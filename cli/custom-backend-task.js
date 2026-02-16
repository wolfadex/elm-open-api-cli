export function profile(label) {
    console.profile(label);
}

export function profileEnd(label) {
    console.profileEnd(label);
}

export function isTTY() {
    return !!process.stdout.isTTY;
}
