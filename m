Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EA1745D7E
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jul 2023 15:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjGCNdP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jul 2023 09:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjGCNdF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jul 2023 09:33:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B804310D4;
        Mon,  3 Jul 2023 06:32:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D38D60F3C;
        Mon,  3 Jul 2023 13:32:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88351C433C7;
        Mon,  3 Jul 2023 13:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688391151;
        bh=7qlSX9Nell5J7ysbWiOfRWUhTOykTgPNeRvu7kTYWFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z+7keICwZsDZYvzIbUYbAjua4wVC7WpRTZjY+p0UqCOPQWrv55HZV17LbtFu8q55z
         w7+nnoVSS94ACBMalD0MKTnRFPFU8Lo8gOJYLxh/7fFg8lK8+z+7ucOmuceABT2LbP
         OXt0TLl2OgWesEtsAtwwdogHYkJAqX6uxcjqLNOnN4FJ/q4GQ94xo2jHCEL0RlmBjG
         3HH9mfElWZu57e7nhMbgJKjDoRJ7NCGaeytE3WK+/Oau36Zx6m+PH6EyMFWK9dN/+P
         O5o5DDMYh20KrcIyUUvLmMh9lCta8zIFQh0t07Nl5P0Z5JSBTdsqs9+tHNT3DtqWGF
         BFhK3s1ZBvHeQ==
Date:   Mon, 3 Jul 2023 14:32:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Message-ID: <d8ade3c0-f256-48dd-9969-d5e55dadd0e4@sirena.org.uk>
References: <ZJFukYxRbU1MZlQn@arm.com>
 <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
 <ZJLgp29mM3BLb3xa@arm.com>
 <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
 <ZJQR7slVHvjeCQG8@arm.com>
 <CALCETrW+30_a2QQE-yw9djVFPxSxm7-c2FZFwZ50dOEmnmkeDA@mail.gmail.com>
 <ZJR545en+dYx399c@arm.com>
 <1cd67ae45fc379fd82d2745190e4caf74e67499e.camel@intel.com>
 <ZJ2sTu9QRmiWNISy@arm.com>
 <e057de9dd9e9fe48981afb4ded4b337e8a83fabf.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3loSgCLP1vFHrOSe"
Content-Disposition: inline
In-Reply-To: <e057de9dd9e9fe48981afb4ded4b337e8a83fabf.camel@intel.com>
X-Cookie: Please go away.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--3loSgCLP1vFHrOSe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 02, 2023 at 06:03:42PM +0000, Edgecombe, Rick P wrote:
> On Thu, 2023-06-29 at 17:07 +0100, szabolcs.nagy@arm.com wrote:

> > which means x86 linux will likely end up maintaining two incompatible
> > abis and the future one will need user code and build system changes,
> > not just runtime changes. it is not a small incremental change to add
> > alt shadow stack support for example.

> > i don't think the maintenance burden of two shadow stack abis is the
> > right path for arm64 to follow, so the shadow stack semantics will
> > likely become divergent not common across targets.

> Unfortunately we are at a bit of an information asymmetry here because
> the ARM spec and patches are not public. It may be part of the cause of
> the confusion.

While the descriptive text bit of the spec is not yet integrated into
the ARM the architecture XML describing the instructions and system
registers is there, the document is numbered DDI0601:

    https://developer.arm.com/documentation/ddi0601/

The GCS specific instructions and system registers are all named
beginning with GCS, it's aarch64 only.

Hopefully I should have something out next week for the kernel.

--3loSgCLP1vFHrOSe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSizeIACgkQJNaLcl1U
h9D3Wwf/baVnu4r+oxpjrck31M4SQYopy428bSNBHaGoVHcoFSNJEIBylX2Zcrp+
c+z0gkJRAjSvAfpT1mqWkw96gSlqLrDzUS6VClhMu0JZwkfmoNiqXwO2iK1jV5w9
9ZMxbCYtfA6pSN8DHwhVkEJO1+9sI6iUJrWsXXcQBRFEeWwkeKpR8CeYL4F8hpdl
4sOC1f2UeEJ82Rm6WPJ/ZNY/pTaGF3CWRP2WfoewkBwzMw9TevsYXdQAIOooFCOT
5ukjmiLiGw2IuYux8Y0Gb1ZaOiOI/W95yow0cPBDS9YGj7y6ZbZqIa5PVfK1Smwf
1QRf+xHUlAz6eiCCxHK2lZZqEP4vOw==
=6QcV
-----END PGP SIGNATURE-----

--3loSgCLP1vFHrOSe--
