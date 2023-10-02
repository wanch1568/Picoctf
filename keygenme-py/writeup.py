import hashlib

key_part_static1_trial = "picoCTF{1n_7h3_|<3y_of_"
key_part_dynamic1_trial = ""
key_part_static2_trial = "}"

dynamic1_trial_key=b"MORTON"
key_hash=hashlib.sha256(dynamic1_trial_key).hexdigest()
key_index=[4,5,3,6,2,7,1,8]
for key_char in key_index:
    key_part_dynamic1_trial+=key_hash[key_char]
print(key_part_static1_trial+key_part_dynamic1_trial+key_part_static2_trial)
    