Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FCD4BEA7E
	for <lists+linux-arch@lfdr.de>; Mon, 21 Feb 2022 20:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbiBUSOH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Feb 2022 13:14:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbiBUSLk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Feb 2022 13:11:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D57913D70
        for <linux-arch@vger.kernel.org>; Mon, 21 Feb 2022 10:02:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F9FB61471
        for <linux-arch@vger.kernel.org>; Mon, 21 Feb 2022 18:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A164C340F3;
        Mon, 21 Feb 2022 18:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645466522;
        bh=1o//f7ci38Nltr9ZStFH8Ui/1ANWC7noWUcvVsxH4Dk=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=tuZrJAgzdRelGFErIBenRd270wD/oE/BIOhQhynAKVpTiYIHwL7iuzDit6XRDEdek
         ea7byCu0dYO+/q44KRLTH/2H9j6hZJRecdushbu6QUkSXBQCHg8Lp9DlF2+JrWjRfy
         RIN+AibzlmP+MN3475dDcXPpT5oNlR70DsykLmsh408rG0y26qXeEUbvBgkIp7ak4g
         V1ennLcuTNlNt8xL9sSvYn2yhbuUAXb9wBDdaU5w2T08jpHsmAmZUPiLry1JbLSOtS
         47i2yz9Cp9Eam6j95ouBGhKhtYpqB1AKY8sImlJlgsU/iJeFup5E7P9kD9ovnKSZs1
         PiJdKlL2bSUhQ==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id C58BF27C005C;
        Mon, 21 Feb 2022 13:02:00 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute5.internal (MEProxy); Mon, 21 Feb 2022 13:02:00 -0500
X-ME-Sender: <xms:ltMTYrOO-q2eTdc7-lefNVhRw6CMzIIUjeq1Fl3pSsQUg5p0v4T3DQ>
    <xme:ltMTYl-w3T6R0n3Nu6LPsQLBvomkxGIVmuyU0GhbO1DIpztXMJlRsLtQTCEYEh028
    pjjpM0MX0B0CmMumOs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeeigddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpeffffekfeeuueffkedvueeujeduledvteefveevvdeftdfhtdegfeej
    geehveefudenucffohhmrghinhepuhhrrghnughomhdruggvvhdpshgvrhhvvghrrdguvg
    hvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghn
    ugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudekheeifedvqd
    dvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuhigrdhluhht
    ohdruhhs
X-ME-Proxy: <xmx:ltMTYqTKzeHmFBPj0KeeRRyeIPkPiIPH6vrTikCX73-28YSIWW4E9A>
    <xmx:ltMTYvsLwlTbcAc-2gQCU0GdilV3LUcAV3MWMIErkd6OV7tI1F8Liw>
    <xmx:ltMTYjdgCl_PWiXjxovjIlwKP-0RphBlU2K8uA3PaBzbcFmq9vAImg>
    <xmx:mNMTYsvOQibdXI0qUTvczgxlr_u6ezUHEVT1YByEYw8pV2tlEZ9rHX6Q-Nw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 01C9B21E006E; Mon, 21 Feb 2022 13:01:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4778-g14fba9972e-fm-20220217.001-g14fba997
Mime-Version: 1.0
Message-Id: <6e117393-9c2f-441c-9c72-62c209643622@www.fastmail.com>
In-Reply-To: <20220217162848.303601-1-Jason@zx2c4.com>
References: <20220217162848.303601-1-Jason@zx2c4.com>
Date:   Mon, 21 Feb 2022 10:01:37 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Linux Crypto Mailing List" <linux-crypto@vger.kernel.org>,
        linux-arch@vger.kernel.org
Cc:     "Dinh Nguyen" <dinguyen@kernel.org>,
        "Nick Hu" <nickhu@andestech.com>,
        "Max Filippov" <jcmvbkbc@gmail.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        "Michal Simek" <monstr@monstr.eu>,
        "Borislav Petkov" <bp@alien8.de>, "Guo Ren" <guoren@kernel.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Joshua Kinard" <kumba@gentoo.org>,
        "David Laight" <David.Laight@aculab.com>,
        "Dominik Brodowski" <linux@dominikbrodowski.net>,
        "Eric Biggers" <ebiggers@google.com>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Kees Cook" <keescook@chromium.org>,
        "Lennart Poettering" <mzxreary@0pointer.de>,
        "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v1] random: block in /dev/urandom
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 17, 2022, at 8:28 AM, Jason A. Donenfeld wrote:
> This topic has come up countless times, and usually doesn't go anywhere.
> This time I thought I'd bring it up with a slightly narrower focus,
> updated for some developments over the last three years: we finally can
> make /dev/urandom always secure, in light of the fact that our RNG is
> now always seeded.
>
> Ever since Linus' 50ee7529ec45 ("random: try to actively add entropy
> rather than passively wait for it"), the RNG does a haveged-style jitter
> dance around the scheduler, in order to produce entropy (and credit it)
> for the case when we're stuck in wait_for_random_bytes(). How ever you
> feel about the Linus Jitter Dance is beside the point: it's been there
> for three years and usually gets the RNG initialized in a second or so.
>
> As a matter of fact, this is what happens currently when people use
> getrandom(). It's already there and working, and most people have been
> using it for years without realizing.
>
> So, given that the kernel has grown this mechanism for seeding itself
> from nothing, and that this procedure happens pretty fast, maybe there's
> no point any longer in having /dev/urandom give insecure bytes. In the
> past we didn't want the boot process to deadlock, which was
> understandable. But now, in the worst case, a second goes by, and the
> problem is resolved. It seems like maybe we're finally at a point when
> we can get rid of the infamous "urandom read hole".
>

This patch is 100% about a historical mistake.  Way back when (not actually that long ago), there were two usable interfaces to the random number generator: /dev/random and /dev/urandom.  /dev/random was, at least in principle, secure, but it blocked unnecessarily and was, therefore, incredibly slow.  It was totally unsuitable for repeated use by any sort of server.  /dev/urandom didn't block but was insecure if called too early.  *But* urandom was also the correct interface to get best-effort-i-need-them-right-now random bits.  The actual semantics that general crypography users wanted were not available.

Fast forward to today.  /dev/random has the correct semantics for cryptographic purposes.  getrandom() also has the correct semantics for cryptographic purposes and is reliable as such -- it is guaranteed to either not exist or to DTRT.  And best-effort users can use GRND_INSECURE or /dev/urandom.

If we imagine that every user program we care about uses GRND_INSECURE for best-effort and /dev/random or getrandom() without GRND_INSECURE for cryptography, then we're in great shape and this patch is irrelevant.

But we don't get to rely on that.  New kernels are supposed to be compatible with old userspace.  And with *old* userspace, we do not know whether /dev/urandom users want cryptographically secure output or whether they want insecure output.  And there is this window during boot that lasts, supposedly, up to 1 second, there is a massive difference. [0]

So, sorry, this patch is an ABI break.  You're reinterpreting any program that wanted best-effort randomness right after boot as wanting cryptographic randomness, this can delay boot by up to a second [0], and that's more than enough delay to be considered a break.

So I don't like this without a stronger justification and a clearer compatibility story.  I could *maybe* get on board if you had a urandom=insecure boot option to switch back to the old behavior and a very clear message like "random: startup of %s is delayed. Set urandom=insecure for faster boot if you do not need cryptographically secure urandom during boot", but I don't think this patch is okay otherwise.

Or we stick with the status quo and make the warning clearer.  "random: %s us using insecure urandom output.  Fix it to use getrandom() or /dev/rando as appropriate."

[0] I just booted 5.16 in a Skylake -rdrand,-rdseed VM and it took 1.14 seconds to initialize.
