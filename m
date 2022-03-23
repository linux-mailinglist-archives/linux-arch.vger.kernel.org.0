Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629B54E51E1
	for <lists+linux-arch@lfdr.de>; Wed, 23 Mar 2022 13:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiCWMLr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Mar 2022 08:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbiCWMLr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Mar 2022 08:11:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE74739162;
        Wed, 23 Mar 2022 05:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FFC7614DD;
        Wed, 23 Mar 2022 12:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338B1C340E8;
        Wed, 23 Mar 2022 12:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648037416;
        bh=vbcI4mero0N/bJWLX90aYg9H0pV4+j0AozrkgOJahHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JEITn10iUJpImQkt/uXRjniHYZUsd6BAzcy643WWTVYjsTo6LxFwUOnlQRwy8OBWs
         w+4D6eknX4FOtFXmSAea1GdGlwv0HFpq0K1HD3cALlwlnsouh+AQX8r/I0wsJUGDxp
         8BIw8b8ZDdFDNkobUgmmMF3gItUrnC9A2s0QrNjQKU2xQ8hD+mT9YeZ/822MKbVIln
         cCPNK2h+QBEWIOYkWi/kUDqmg9dWlU6ayXMjSlhvOuiqzrp6L1J0sK1ZBwiBEV5Emi
         f97DvFO2X4mz0npZGdc9uAPrqNl/o/+geIXj5acz32k1eHUYV1tvby8dwPUkZicHfI
         XSuP6rifB8qRg==
Date:   Wed, 23 Mar 2022 12:10:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-arch@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
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
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v1] random: block in /dev/urandom
Message-ID: <YjsOHmvDgAxwLFMg@sirena.org.uk>
References: <20220217162848.303601-1-Jason@zx2c4.com>
 <20220322155820.GA1745955@roeck-us.net>
 <YjoUU+8zrzB02pW7@sirena.org.uk>
 <0d20fb04-81b8-eeee-49ab-5b0a9e78c9f8@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tJxr+BfuLW0D7ewQ"
Content-Disposition: inline
In-Reply-To: <0d20fb04-81b8-eeee-49ab-5b0a9e78c9f8@roeck-us.net>
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


--tJxr+BfuLW0D7ewQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 22, 2022 at 02:54:20PM -0700, Guenter Roeck wrote:
> On 3/22/22 11:24, Mark Brown wrote:

> > Just as a datapoint for debugging at least qemu/arm is getting coverage
> > in CI systems (KernelCI is covering a bunch of different emulated
> > machines and LKFT has at least one configuration as well, clang's tests
> > have some wider architecture coverage as well I think) and they don't
> > seem to be seeing any problems - there's some other variable in there.

> I use buildroot 2021.02.3. I have not changed the buildroot code, and it
> still seems to be the same in 2022.02. I don't see the problem with all
> boot tests, only with the architectures mentioned above, and not with all
> qemu machines on the affected platforms. For arm, mostly older machines
> are affected (versatile, realview, pxa configurations, collie, integratorcp,
> sx1, mps2-an385, vexpress-a9, cubieboard). I didn't check, but maybe
> kernelci doesn't test those machines ?

Kind of academic given that Jason seems to have a handle on what the
issues are but for KernelCI it's variations on mach-virt, plus
versatile-pb.  There's a physical cubietruck as well, and BeagleBone
Blacks among others.  My best guess would be systems with low RAM are
somehow more prone to issues.

--tJxr+BfuLW0D7ewQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmI7Dh0ACgkQJNaLcl1U
h9BcKgf9GIwAeN+f0WgtlSoiS81pYIPqyjQ+X1zRuvJIR7xCVZq+sYQ27js719v2
oES8pLcPkyjZHNziBmIDbpiNeKJWWbYlxxXdyyW5sTe+GzEUzh/+MVxLeGUDF1Qx
rpZYsiZ/NybofrWfkOwDmm/R5tTn2JgJFZaRHtMeUn67ElJPNu107LsgeDVujePG
Pywun/VDDjcC5scInU3cbhzRoo2ipY8/nwAxPcM6fddMqgaymdFrC5wU8+ihxGsc
55rSw4QnKKPRpX8CGjc4wSmYXax1OsLc5Lsh9FQHf9EqVs46ZsJHwd6FntTpIht2
fiOwR2pk7XiyL1tJEsCZyQfE4vAmBw==
=b+8U
-----END PGP SIGNATURE-----

--tJxr+BfuLW0D7ewQ--
