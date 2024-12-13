Clear-Host
docker build -t popcorn .

docker run --rm --gpus all -v "C:\Users\abram\popcorn\Popcorn-containerise\data:/data" popcorn -occmodel -senbuilds -S2 -NIR -S1 -treg che --resume "/popcorn/popcorn/POPCORN_RWA_checkpoints/POPCORN_RWA_checkpoints/model3/last_model.pth"
#docker run --rm --gpus all -v "C:\Users\abram\popcorn\Popcorn-containerise\data:/data" popcorn -occmodel -senbuilds -S2 -NIR -S1 -treg che --resume "/popcorn/popcorn/POPCORN_CHE_checkpoints/POPCORN_CHE_checkpoints/model1/last_model.pth"


#python run_eval.py -occmodel -senbuilds -S2 -NIR -S1 -treg che --fourseasons   --resume C:\Users\abram\popcorn\Popcorn-main\POPCORN_CHE_checkpoints\POPCORN_CHE_checkpoints\model1\last_model.pthaca
