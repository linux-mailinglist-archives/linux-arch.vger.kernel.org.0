Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F306748D9C
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jul 2023 21:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbjGETRc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jul 2023 15:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbjGETRS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jul 2023 15:17:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C57A7EFA;
        Wed,  5 Jul 2023 12:12:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D0AC616EE;
        Wed,  5 Jul 2023 19:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF8FC433C7;
        Wed,  5 Jul 2023 19:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688584249;
        bh=fa13Rrp/ewRaXb15ROYQwSY3HRGY9tgXoBGOXCxz7qQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rArXyDhGF1qeLuF+8vWJDIK/3L3LjaPvhWozvBC873N6pi4MbeTwNwAiwB2VIO8h6
         H1wZgqBv55CuKdgGKzBaOx1+aTzXj97ktJjjoYNYrnHUNlWeipg0mYZlwowYai1JCY
         pHd1zhhWKMbNZpkU1QRyUO0UFs24TGHkrcWXFOQO/3qDPNx1lcaErhu3E7ZSaV6zWQ
         fl80eJEGPWLHhYv4neHzkW7KlYXcejS+pjyFpgeI1wlvZED9d8Zoz1SrIqGuPbWjuF
         sCKJQYBvh+dsTB8CcTxnWyMgQobRcdSdt6ZzTMoOqxT247MLe8MwfcFtQzucR/H749
         HI7K1Xf1aqnBA==
Date:   Wed, 5 Jul 2023 20:10:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Message-ID: <2a30ac58-d970-45c3-87d2-55396c0a83f9@sirena.org.uk>
References: <eda8b2c4b2471529954aadbe04592da1ddae906d.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Dmr76OeBT4pTBUQM"
Content-Disposition: inline
In-Reply-To: <eda8b2c4b2471529954aadbe04592da1ddae906d.camel@intel.com>
X-Cookie: Don't feed the bats tonight.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--Dmr76OeBT4pTBUQM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 05, 2023 at 06:45:38PM +0000, Edgecombe, Rick P wrote:

> Looking at the docs Mark linked (thanks!), ARM has generic GCS PUSH and
> POP shadow stack instructions? Can ARM just push a restore token at
> setjmp time, like I was trying to figure out earlier with a push token
> arch_prctl? It would be good to understand how ARM is going to
> implement this with these differences in what is allowed by the HW.

> If there are differences in how locked down/functional the hardware
> implementations are, and if we want to have some unified set of rules
> for apps, there will need to some give and take. The x86 approach was
> mostly to not support all behaviors and ask apps to either change or
> not enable shadow stacks. We don't want one architecture to have to do
> a bunch of strange things, but we also don't want one to lose some key
> end user value.

GCS is all or nothing, either the hardware supports GCS or it doesn't.
There are finer grained hypervisor traps (see HFGxTR_EL2 in the system
registers) but they aren't intended to be used to disable partial
functionality and there's a strong chance we'd just disable the feature
in the face of such usage.  The kernel does have the option to control
which functionality is exposed to userspace, in particular we have
separate controls for use of the GCS, the push/pop instructions and the
store instructions (similarly to the control x86 has for WRSS).
Similarly to the handling of WRSS in your series my patches allow
userspace to choose which of these features are enabled.

--Dmr76OeBT4pTBUQM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSlwC0ACgkQJNaLcl1U
h9DuvAf+JgrHCBe/TIeWaTXbh1FnwnOIdz2doyUlgUqzu5K5fGjE+AF6nytAvxsw
HIFAEaZItokV1L7RHKWjunwM1sjA7UmdGfhH1i5KYZF8XpmfgZTK3ZiaHJO8EKsL
WAN1sgXlNOkCfoE0vggDqr9ksQ5WGjJS3TDgoXnTQna75/J3ggrKWQPdBRZ52/YK
Swo9HHZ/aUSvO8Xo6iSEetZIyxUjcDvPVGBNrMauABpExP1ww/LA7NeJIUF8O32/
ZYRWOy09jbfMJA80DH+bfaHVJw/g9ZI65/tBFI364wcp4LXSiymoz6f3yQUyBJV4
97UBNALINVmtmDPEpmSVX6DM3PbVWA==
=HVOg
-----END PGP SIGNATURE-----

--Dmr76OeBT4pTBUQM--
