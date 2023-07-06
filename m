Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE414749EE9
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jul 2023 16:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjGFOYm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jul 2023 10:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjGFOYl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jul 2023 10:24:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15431BC3;
        Thu,  6 Jul 2023 07:24:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E2EE6198A;
        Thu,  6 Jul 2023 14:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27906C433C7;
        Thu,  6 Jul 2023 14:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688653478;
        bh=O45ertu3AbL/0W9DK51Iqjup0+XJ/VyrW0PT/x/Zq0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SJSsx9hZKApwEzVdCFFpYNQt8mmt7MVaEkwDf5QwcsihmISLxyqwlVGpKsAr2O2uA
         wHqxfGhSXsoEpE/dmiE/XolVvmsgBa5QIlkyf2y9FSJQF0ZleU6L2PkPSAST/cHvKw
         q5z5g7BeLuabIkuOKJGc+Wb9q5/BosoQrhXmGOukiRytsB1b52ZgjtohiDVAjPcwBM
         PH1dsFOXBdLt0OAlkoYLZhs7FdOta5Wzn40KmvsZ21p3zYFhUjJgJZKOo04JW3ydb6
         jh4RkkxrzG85J9QYC4Ax/z4ruy26AMnsA0GYiE8qSXdHdZS+ukv0RKj8FTYfj6WcLl
         j/t11Gg1Tn/EA==
Date:   Thu, 6 Jul 2023 15:24:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "david@redhat.com" <david@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Message-ID: <e9a377ce-7ce4-47b0-b30e-56a5aae18544@sirena.org.uk>
References: <eda8b2c4b2471529954aadbe04592da1ddae906d.camel@intel.com>
 <2a30ac58-d970-45c3-87d2-55396c0a83f9@sirena.org.uk>
 <0a9ade13b989ea881fd43fabbe5de1d248cf4218.camel@intel.com>
 <ccce9d4a-90fe-465a-88ae-ea1416770c77@sirena.org.uk>
 <ZKa+QFKHSyqMlriG@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="woDWu/1up2+/uYLd"
Content-Disposition: inline
In-Reply-To: <ZKa+QFKHSyqMlriG@arm.com>
X-Cookie: Don't read everything you believe.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--woDWu/1up2+/uYLd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 06, 2023 at 02:14:40PM +0100, szabolcs.nagy@arm.com wrote:
> The 07/05/2023 20:29, Mark Brown wrote:

> > Push and pop are one control, you get both or neither.

> gcspopm is always available (esentially *ssp++, this is used
> for longjmp).

Ah, sorry - I misremembered there.  You're right, it's only push that we
have control over.

--woDWu/1up2+/uYLd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSmzpkACgkQJNaLcl1U
h9DnEQf7BcnGI2A9Hm92frxRo982dBeJJWDACtl7P//CR1MjaAoA5AAveA5J4QpS
ochiNCQREYpdyJ4Kw0JmnYZ/BV00ndbzr57J6jiDCauoZePl25nAdlB+8cp7954v
kcm4f8q960IqMWc6grZxlLjJkWOG7Il/WXkepOvR83pgiGmsSQXJwXRWvjs6vX38
nNlmgH28DtjqVKpVZwkLtrS3qiwHqpcoYnHGs65bzxB8JB2Xn+il3m5iCI8L4rz6
vSy2uJhTjam/bz8DTGFH31BOArTTV8zgc/t31UgWWFbCGoQ4zTSeUMAGmd8AHU7Y
Z4DTcFiSEdIv/AjoWv2bJntWnEN8OQ==
=eJ7T
-----END PGP SIGNATURE-----

--woDWu/1up2+/uYLd--
