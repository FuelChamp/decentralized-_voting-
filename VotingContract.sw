contract Voting {

    storage {
        voters: (map address bool); // Map of addresses to their voting eligibility
        candidates: (map string u64); // Map of candidate names to their vote count
    }

    init {
        voters = Big_map.empty;
        candidates = Big_map.empty;
    }

    // Function to register as a voter
    entry register_voter() {
        assert(!voters.contains(Tezos.sender), Unit, "Address is already registered as a voter");
        voters = voters.update(Tezos.sender, true);
    }

    // Function to add a candidate
    entry add_candidate(name: string) {
        assert(!candidates.contains(name), Unit, "Candidate already exists");
        candidates = candidates.update(name, 0);
    }

    // Function to cast a vote
    entry vote(candidate: string) {
        assert(voters.contains(Tezos.sender), Unit, "Address is not registered as a voter");
        assert(candidates.contains(candidate), Unit, "Candidate does not exist");
        let current_votes = candidates.get(candidate, 0);
        candidates = candidates.update(candidate, current_votes + 1);
    }

    // Function to get the total votes for a candidate
    entry get_candidate_votes(candidate: string) {
        candidates.get(candidate, 0);
    }
}

