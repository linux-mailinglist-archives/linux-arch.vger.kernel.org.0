Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9268F4E562E
	for <lists+linux-arch@lfdr.de>; Wed, 23 Mar 2022 17:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbiCWQUO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Mar 2022 12:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238855AbiCWQUM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Mar 2022 12:20:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8784C59A65;
        Wed, 23 Mar 2022 09:18:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2390C6184B;
        Wed, 23 Mar 2022 16:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A62C340E8;
        Wed, 23 Mar 2022 16:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648052320;
        bh=xmssCclpuXkvokPOIc8kA2TpF6hDPr1nfNP2UJCwIVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kQDEhbn2dsQ+pF3/zFmCMhiRAPwUL9hr3vakvVKREmueBHXYPPkGc1Yjk77g1+upO
         lsDQg0C3crQmPNkuUwYh3N5/NCPu7xCYzLRLkINXEPhXo6X4YJjVbQqoAXsUk9wZ3M
         Nph/NkDtXZQ3cUm86JAvalrgq86oea+2tvOlDFHw7B8O56nOXfcl0t6rQ0d6AY4qwA
         IadGNCw72DxDcmz7wQcxJVg1G9vsRI9GsUIHs91zDchMl/QMSewj0sA6+BEoIVeyXh
         T7p/CRUlVXHmloiINmMA/7xJ6LVM8pjEqYnS63qXXzPUgIkiBU7MrJsgohHJmDkTAQ
         /q/OmoZUIiA7g==
Date:   Wed, 23 Mar 2022 16:18:31 +0000
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
Message-ID: <YjtIVymPEZ4t16tP@sirena.org.uk>
References: <20220217162848.303601-1-Jason@zx2c4.com>
 <20220322155820.GA1745955@roeck-us.net>
 <YjoUU+8zrzB02pW7@sirena.org.uk>
 <0d20fb04-81b8-eeee-49ab-5b0a9e78c9f8@roeck-us.net>
 <YjsOHmvDgAxwLFMg@sirena.org.uk>
 <ebafdf77-5d96-556b-0197-a172b656bb01@roeck-us.net>
 <CAK8P3a1hzmXTTMsGcCA2ekEHnff+M7GrYSQDN4bVfVk6Ui=Apw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rbHr+yLemIUaUxTK"
Content-Disposition: inline
In-Reply-To: <CAK8P3a1hzmXTTMsGcCA2ekEHnff+M7GrYSQDN4bVfVk6Ui=Apw@mail.gmail.com>
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


--rbHr+yLemIUaUxTK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 23, 2022 at 04:53:13PM +0100, Arnd Bergmann wrote:
> On Wed, Mar 23, 2022 at 3:23 PM Guenter Roeck <linux@roeck-us.net> wrote:

> > I don't think it is entirely academic. versatile-pb fails for me;
> > if it doesn't fail at KernelCI, I'd like to understand why - not to
> > fix it in my test environment, but to make sure that I _don't_ fix it.
> > After all, it _is_ a regression. Even if that regression is triggered
> > by bad (for a given definition of "bad") userspace code, it is still
> > a regression.

> Maybe kernelci has a virtio-rng device assigned to the machine
> and you don't? That would clearly avoid the issue here.

No, nothing I can see in the boot log:

https://storage.kernelci.org/next/master/next-20220323/arm/versatile_defcon=
fig/gcc-10/lab-baylibre/baseline-qemu_arm-versatilepb.html

and I'd be surprised if virtio devices made it through with a specific
platform emulation.  However it looks like for that test the init
scripts didn't do anything with the random seed (possibly due to running
=66rom ramdisk?) so we'd not have hit the condition.

--rbHr+yLemIUaUxTK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmI7SFYACgkQJNaLcl1U
h9DyDgf/U3gmBBfzqO9p6NhtOGB/g28xQ3p6y1kJ4Sg2NhFwA6wgeFfZE8b8k9Ps
4Fra0rZ5ps4ygGLxhk0sD0yHMtRlFP95ybscWVOP/hEDxqDOzqTwAZ5zbYAgyIxS
a1hKm0AbnEmEpXyK7AhxHXsl3stNSqzCY9OFhJgMFekKkv7L3CAdrBUQCxZhfnKr
obsPPejMdrEI5IX1ge4QCq9HFI0ohwRDaINOHWXGAX1p4+s6OwFjxvmzZZA87DPs
OCApFRP6IbCHGqiIykL0UsxWZ6qDRdjLqnCaAK6N5+ZnrP13/C4O3M+dCxV8Vfx6
Y/3OlG3UrMouJEWe/iwV0bq4UdP6wA==
=FAu8
-----END PGP SIGNATURE-----

--rbHr+yLemIUaUxTK--
