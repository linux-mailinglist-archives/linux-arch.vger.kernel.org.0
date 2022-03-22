Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD1F4E45ED
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 19:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240339AbiCVS1B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 14:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240474AbiCVS0t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 14:26:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6082291AE6;
        Tue, 22 Mar 2022 11:24:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBCCE615C1;
        Tue, 22 Mar 2022 18:24:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A312DC340EC;
        Tue, 22 Mar 2022 18:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647973468;
        bh=FvpGfCbFl7jiIv+5qDBixSNKRQDQ0tuqYtKpgJTJImM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tQuDXUlhqs9CKsHkSjY/ScbmM/fz5A8eD7iftU4YRevtwvus6YLjyHciExv9uEdvK
         ODgx6yqbrUVHYitdapwSw4VSk3x+3dDFFmpv5S3UydMRalWps10DNbqG6qzDgFeSri
         tCuYrOWRikPlVAOw3zibpylqKvA34k+giMV9sDN+3SZ18VosQbFmMMNYqyS7RzYk7W
         San13jBR7ieHdupZcUbtNZo0+rG5hNfra34zL1x9muYlzHDpqu0rkEVeg2jxCsbBLR
         vi2JhVOE/Fgj8jBj4RQeaxhNngtN4bUtwQOvWzlVEwWN09QoJcBGUj208CehiBpojp
         K3AoZ6dmCtHdw==
Date:   Tue, 22 Mar 2022 18:24:19 +0000
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
Message-ID: <YjoUU+8zrzB02pW7@sirena.org.uk>
References: <20220217162848.303601-1-Jason@zx2c4.com>
 <20220322155820.GA1745955@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9GphWWnfqSfQwrGD"
Content-Disposition: inline
In-Reply-To: <20220322155820.GA1745955@roeck-us.net>
X-Cookie: I exist, therefore I am paid.
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--9GphWWnfqSfQwrGD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 22, 2022 at 08:58:20AM -0700, Guenter Roeck wrote:

> This patch (or a later version of it) made it into mainline and causes a
> large number of qemu boot test failures for various architectures (arm,
> m68k, microblaze, sparc32, xtensa are the ones I observed). Common
> denominator is that boot hangs at "Saving random seed:". A sample bisect
> log is attached. Reverting this patch fixes the problem.

Just as a datapoint for debugging at least qemu/arm is getting coverage
in CI systems (KernelCI is covering a bunch of different emulated
machines and LKFT has at least one configuration as well, clang's tests
have some wider architecture coverage as well I think) and they don't
seem to be seeing any problems - there's some other variable in there.

For example current basic boot tests for KernelCI are at:

   https://linux.kernelci.org/test/job/mainline/branch/master/kernel/v5.17-=
1442-gb47d5a4f6b8d/plan/baseline/

for mainline and -next has:

   https://linux.kernelci.org/test/job/next/branch/master/kernel/next-20220=
322/plan/baseline/

These are with a buildroot based rootfs that has a "Saving random seed: "=
=20
step in the boot process FWIW.

--9GphWWnfqSfQwrGD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmI6FFIACgkQJNaLcl1U
h9BikAf9GyEwspA1FgiJqGxDrpcFJatNlthPVfssfjxi3+PM/Sr3aGVYuI1cucrY
rOXZc5iGh0WzI6+6SJa4LHN9Az3zbhAbXim3xfsdRA6H43LLTo2Nnm5X7WXiimIs
+DoFKihIN+SIeYLbYORzZpmCnZ23wcVviG2W3WdzUCKj7LzOQYcPKzAoBfqvXM0H
DdzlPyQMQMo1RwxuMv7gokqg/ZXNKt3bTJ8ptBTYY+uOwYKAifVdzsJc8GF+FfE7
1vZPgBdPNegM/QLA2E5p5OlfmymsdJfN0+M6pjVINH9CyIKvAPpoFkXacv8EV/2i
QuDiWltRqivsK2Px9ISnKQzA9wB5tw==
=nsEK
-----END PGP SIGNATURE-----

--9GphWWnfqSfQwrGD--
