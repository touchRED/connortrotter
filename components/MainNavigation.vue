<template>
    <div class="main-navigation">
        <nuxt-link to="/">
            <h1>connor trotter</h1>
        </nuxt-link>
    </div>
</template>

<style lang="scss">
.main-navigation {
    display: flex;
    padding: 70px 60px;
    position: fixed;
    top: 0px;
    left: 0px;
    width: 100%;
    pointer-events: none;
    z-index: 10;
    /* opacity: 0; */

    @media (max-width: 768px) {
        padding: 35px 30px;
        align-items: flex-start;
    }

    a {
        z-index: 0;
        display: flex;
        text-decoration: none;
        pointer-events: all;
        transform-origin: left;
        background: black;
        /* opacity: 0; */

        h1 {
            color: black;
            font-size: 16px;
            padding: 9px 15px;
            margin: 0;
            position: relative;
            font-weight: 100;
            letter-spacing: 1px;
            font-family: monospace;
            border: 1px solid black;
            background: white;
            transform: translate(5px, -7px);
            /* opacity: 0; */
        }
    }
}
</style>
