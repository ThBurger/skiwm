class Utility {
  static String rewardedCredits(int rank) {
    if (rank > 300) {
      return '';
    } else if (rank > 200 && rank <= 300) {
      return '5';
    } else if (rank > 150 && rank <= 200) {
      return '10';
    } else if (rank > 80 && rank <= 150) {
      return '20';
    } else if (rank > 30 && rank <= 80) {
      return '50';
    } else if (rank > 10 && rank <= 30) {
      return '75';
    } else if (rank > 3 && rank <= 10) {
      return '100';
    } else if (rank == 3) {
      return '125';
    } else if (rank == 2) {
      return '150';
    } else if (rank == 1) {
      return '200';
    }
    return '';
  }
}
