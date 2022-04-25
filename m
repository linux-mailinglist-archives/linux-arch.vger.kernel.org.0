Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B250950DFB5
	for <lists+linux-arch@lfdr.de>; Mon, 25 Apr 2022 14:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbiDYMNC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Apr 2022 08:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbiDYMMu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Apr 2022 08:12:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00075B3C2;
        Mon, 25 Apr 2022 05:09:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CFC1B8160E;
        Mon, 25 Apr 2022 12:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC5AC385A7;
        Mon, 25 Apr 2022 12:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650888584;
        bh=1cGqa9zyT58RE2mP9Te3PxJ0mlr36OZJHKDXdnMZfr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lF9f5yW897I0R3eQH311XOACxuKiPKWTs8ZKJ4KDbI/UkGn3qWUHChSAaAE/4Og3U
         yBZ2nTQ1Ykj224QMHk5YVtaftIlMrNgme88N4KotkNcY9mW7Vmrx3n4WbU8yh6PoES
         nF1PyLMFvhqA3xI2Jm6GnK4UPiPFawD6ggvWmRwZkfd0/w2P7FSP0gZrC13cFx1CJX
         50uCeKszDyL5YGy+dlzB7+V4d7DjEELMB9Vq1jCpO7MFTl05NRXat79UdxwfDw2R1F
         2uGHTHMY8nn1VDwRSdu7Kxb9F87cv7Jpoborq4dXI91GWbJaDn1sLC5+YYlrpqrT1l
         aeyR5bEwsmmRw==
Date:   Mon, 25 Apr 2022 13:09:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>,
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
Message-ID: <YmaPfvWq5eRixiJK@sirena.org.uk>
References: <20220217162848.303601-1-Jason@zx2c4.com>
 <20220322155820.GA1745955@roeck-us.net>
 <YjoUU+8zrzB02pW7@sirena.org.uk>
 <0d20fb04-81b8-eeee-49ab-5b0a9e78c9f8@roeck-us.net>
 <YjsOHmvDgAxwLFMg@sirena.org.uk>
 <ebafdf77-5d96-556b-0197-a172b656bb01@roeck-us.net>
 <CAK8P3a1hzmXTTMsGcCA2ekEHnff+M7GrYSQDN4bVfVk6Ui=Apw@mail.gmail.com>
 <CAHmME9pMFMk6Uu1p4z9SzdAwg2q52FnH3fcsGXCK0OZod=YwLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="onvU6J0IiWNDQHVw"
Content-Disposition: inline
In-Reply-To: <CAHmME9pMFMk6Uu1p4z9SzdAwg2q52FnH3fcsGXCK0OZod=YwLw@mail.gmail.com>
X-Cookie: An apple a day makes 365 apples a year.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--onvU6J0IiWNDQHVw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 23, 2022 at 02:52:51AM +0200, Jason A. Donenfeld wrote:
> On Wed, Mar 23, 2022 at 4:53 PM Arnd Bergmann <arnd@arndb.de> wrote:

> > Maybe kernelci has a virtio-rng device assigned to the machine
> > and you don't? That would clearly avoid the issue here.

> Indeed it's probably something like that. Or maybe they're networked
> with something that has a steady stream of interrupts. I say this
> because I was able to reproduce Guenter's findings using the
> versatilepb machine with the versatile_defconfig config and the
> versatile-pb.dtb file. Indeed this board doesn't have a cycle counter.
> However, I did have success using the fallback timer and the other
> patches in the jd/for-guenter branch, so at least for versatile's
> nuances, I think (hope?) there's a reasonable success story here.

There's no virtio-rng device being instantiated, unless qemu is doing
that by default (I can't see anything in the logs that suggests it did).
There is networking though.  A sample command for invoking qemu for
versatilepb is:

qemu-system-arm -cpu arm926 -machine versatilepb -nographic -net nic,model=smc91c111,macaddr=52:54:00:12:34:58 -net user -m 256 -monitor none -dtb /var/lib/lava/dispatcher/tmp/85180/deployimages-hitd6sn_/dtb/versatile-pb.dtb -kernel /var/lib/lava/dispatcher/tmp/85180/deployimages-hitd6sn_/kernel/zImage -append "console=ttyAMA0,115200 root=/dev/ram0 debug verbose console_msg_format=syslog earlycon" -initrd /var/lib/lava/dispatcher/tmp/85180/deployimages-hitd6sn_/ramdisk/rootfs.cpio.gz -drive format=qcow2,file=/var/lib/lava/dispatcher/tmp/85180/apply-overlay-guest-l9_f_lxl/lava-guest.qcow2,media=disk,if=scsi,id=lavatest

--onvU6J0IiWNDQHVw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJmj34ACgkQJNaLcl1U
h9CeWwf/Yaj9E+Pc63nMbfJFj83Dzh5N/lIq7zixSu3FpWYBuYqbtE8Dmnnch2Rg
WWWZuPFHNUsUnTfVjCf6UUhoVa0gVphiNVhGZ3AR18HCxB6jpmue2o0rjuGvhpw0
G8gmLrP1qTXptqiG3bG2SNmAzazeqxsl+KRseLjhSRKzDzQbDFByTNePc6pmKDJW
gAqV2YZfGNSNOz2nvzqwTXVK4vL7/QPB2sVEVlkb9uSuOWbNSMrcCtNsfeWzY4hQ
h45dDgk/+DigcTOCpBNOq4+bMGHy+wXKzMsT37S3t4YFd0gimba4r/CbVsYWmo/6
z9ktO6xoFAC+q42db0+s6en2SzVLLg==
=/kLK
-----END PGP SIGNATURE-----

--onvU6J0IiWNDQHVw--
