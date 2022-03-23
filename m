Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E278F4E56DD
	for <lists+linux-arch@lfdr.de>; Wed, 23 Mar 2022 17:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245533AbiCWQti (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Mar 2022 12:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245532AbiCWQtc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Mar 2022 12:49:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CB93AC;
        Wed, 23 Mar 2022 09:48:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6921B81FB1;
        Wed, 23 Mar 2022 16:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4CFC340EE;
        Wed, 23 Mar 2022 16:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648054077;
        bh=GXavJvlaiTb+T7WbLpkUjW9/g2S2PtTfhMx/DZ2gdnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iYLqcQY9fwH8klPGFWwIoTHUfdDXPptnOuiTYbBc9P2iQNEy5ogUKMUNnfahgrBzR
         gZnc1BHLGxeh9uTkFpMzf79YD2oxsga2QlJZcHb3TCuzr/Et6xNXciF0UXqjeUvmiF
         iKhBz4HzJGsGhsK3nKVnHZfHBek/8v/4rZkZ9FXDejX1XWKtqy863A7GO3ANf4PG4C
         SUuYH03MkI2ODKlmKqA5Dj1frfYKD54pl4llZKJs8PSuPx2gqvv0VwxoRFhcSNi3KJ
         yDyFyBe/IHh35tz3nQzCLWH317az/oz0mHGw7SGtlQNQLCe2tXfFTF3tN1rnaCBASP
         /e3eRd7xwp5Pw==
Date:   Wed, 23 Mar 2022 16:47:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "David S . Miller" <davem@davemloft.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Borislav Petkov <bp@alien8.de>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joshua Kinard <kumba@gentoo.org>,
        David Laight <David.Laight@aculab.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v1] random: block in /dev/urandom
Message-ID: <YjtPNI2ZQFgVML6L@sirena.org.uk>
References: <20220217162848.303601-1-Jason@zx2c4.com>
 <20220322155820.GA1745955@roeck-us.net>
 <YjoUU+8zrzB02pW7@sirena.org.uk>
 <0d20fb04-81b8-eeee-49ab-5b0a9e78c9f8@roeck-us.net>
 <YjsOHmvDgAxwLFMg@sirena.org.uk>
 <ebafdf77-5d96-556b-0197-a172b656bb01@roeck-us.net>
 <CAK8P3a1hzmXTTMsGcCA2ekEHnff+M7GrYSQDN4bVfVk6Ui=Apw@mail.gmail.com>
 <YjtIVymPEZ4t16tP@sirena.org.uk>
 <CAK8P3a0Fzryo8Wi2exbQz=qXKGOGU6yxP0FGowa-fJkr0aGJFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sQdCBG94vBDiG872"
Content-Disposition: inline
In-Reply-To: <CAK8P3a0Fzryo8Wi2exbQz=qXKGOGU6yxP0FGowa-fJkr0aGJFg@mail.gmail.com>
X-Cookie: Nice guys get sick.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--sQdCBG94vBDiG872
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 23, 2022 at 05:41:01PM +0100, Arnd Bergmann wrote:
> On Wed, Mar 23, 2022 at 5:18 PM Mark Brown <broonie@kernel.org> wrote:

> > and I'd be surprised if virtio devices made it through with a specific
> > platform emulation.

> In general they do: virtio devices appear as regular PCI devices
> and get probed from there, as long as the drivers are available.

> It looks like the PCI driver does not get initialized here though,
> presumably because it's not enabled in versatile_defconfig.
> It used to also not be enabled in multi_v5_defconfig, but I have
> merged a patch from Anders that enables it in 5.18 for the
> multi_v5_defconfig.

Ah, I thought Versatile was like the other older Arm reference platforms
and didn't have PCI.

--sQdCBG94vBDiG872
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmI7TzQACgkQJNaLcl1U
h9BjvAf/duSXw3LO6eKiw2GKSb5qNFkM7yPR4P7dmSrFcL3EotKV9wPef1AAKRWF
p3DuYX1BoatfsHDiaTIzTDxaX9ao5E15uASqAy1Yd+V1LRa5HUobpSbDVonf+Kfw
CG0Sh3gfmkRU8EAvDmFQZPBZ2hQAGENSpMHb1OBcTf3aras8a6bU9t9qHqpjlw2L
gHrYYjlDm5V6iseTYAiNevPXyAh8XSHYJLfxjKquQTJ/nbe+2pcfYYsdz6Aqv+TF
r6wGJR8dz+CXFNJHXyTRUpUyClPpFTqb8zEp4aTLMUgtf0ZyrIKpomR2Z5+kQkSd
qraSPCepNqe5SiAsn8BY88A719I1Og==
=d+d/
-----END PGP SIGNATURE-----

--sQdCBG94vBDiG872--
