[CmdletBinding()]
param(
    
)
# Line break for readability in AppVeyor console
Write-Host -Object ''
Import-Module posh-git -Force

if ($env:APPVEYOR_REPO_BRANCH -ne 'master') 
{
    Write-Warning -Message "Skipping version increment and publish for branch $env:APPVEYOR_REPO_BRANCH"
}
elseif ($env:APPVEYOR_PULL_REQUEST_NUMBER -gt 0)
{
    Write-Warning -Message "Skipping version increment and publish for pull request #$env:APPVEYOR_PULL_REQUEST_NUMBER"
}
else
{
    Try 
    {
        git checkout master
        git add --all
        git commit -m "PSGallery Version Update to $newVersion"
        git push origin master
        Write-Verbose "Repo has been pushed to github"
    }
    Catch 
    {
        Write-Warning "Github push failed"
        throw $_
    }

}