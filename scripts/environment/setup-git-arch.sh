


# Install Git https://git-scm.com/download/linux
#ARCH
pacman -S git


#optional install
#ARCH paru visual-studio-code-bin

git config --global user.name <name>
git config --global user.email <email>


#####
# Connecting to GitHub with SSH (aka Verified)
# https://docs.github.com/en/authentication/connecting-to-github-with-ssh
# Assumes new setup. If you already have keys in place, refer to documentation
#####

# Check for Existing Keys
ls -al ~/.ssh

# TODO: IF NO SSH
echo instructions, to use defaults
ssh-keygen -t ed25519 -C <email> (or label??)
ssh-add <ssh private>

# Add ssh key to github
# https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account
cat <ssh public>
echo instructions



# Generate GPG
# https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key
gpg --full-generate-key
gpg --list-secret-keys --keyid-format=long


gpg --armor --export <id of gpg>

echo Copy your GPG key, beginning with -----BEGIN PGP PUBLIC KEY BLOCK----- and ending with -----END PGP PUBLIC KEY BLOCK-----.



# continue setup Git
# grep this somehow for id var
git config --global user.signingkey <id of gpg>


git config --global commit.gpgsign true
git config --global gpg.format ssh
git config --global user.signingkey <ssh pub>