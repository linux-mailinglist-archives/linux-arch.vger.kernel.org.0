Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4E0748DC6
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jul 2023 21:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjGET3p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jul 2023 15:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbjGET3l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jul 2023 15:29:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4610F171A;
        Wed,  5 Jul 2023 12:29:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D55F0616DA;
        Wed,  5 Jul 2023 19:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C56C433C7;
        Wed,  5 Jul 2023 19:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688585377;
        bh=58E9A5hdZBNfXmya5PCeY7HXsUfb3Ff8zPeemokngEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V6wbGg/+57CYKEHYV+uixfWNCh/9v+4zU9M8fxtJrep+XywpzBRieTW8SdVm9jWsX
         8jnjQD9t6n3OZ6QZ9WB+iDJtUxpwv4c4vTBDNFuur048merbY3/wMo+JC/gdG//GRH
         r99TXiptTgZrvYpA/9uhlHueIHq3uh2J3uw1f2qLVev5pb4hgVIef5bwl/E1njRHS2
         iJUh76lOuAH4VvAXROqmZWUY9lHdifDf21yCH3pEKbRMUA6D6smgR4NpOJuGnIgqnv
         7TmA4xrsUSHXI6oRcIUVw0x1Ed4fpu1ZjvuoEI2k2jUowmOlwyxOoTwvTs9I2i3JmU
         pJEZZt2lDYEVA==
Date:   Wed, 5 Jul 2023 20:29:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
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
Message-ID: <ccce9d4a-90fe-465a-88ae-ea1416770c77@sirena.org.uk>
References: <eda8b2c4b2471529954aadbe04592da1ddae906d.camel@intel.com>
 <2a30ac58-d970-45c3-87d2-55396c0a83f9@sirena.org.uk>
 <0a9ade13b989ea881fd43fabbe5de1d248cf4218.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="itt77taXQv6vqcOz"
Content-Disposition: inline
In-Reply-To: <0a9ade13b989ea881fd43fabbe5de1d248cf4218.camel@intel.com>
X-Cookie: Don't feed the bats tonight.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--itt77taXQv6vqcOz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 05, 2023 at 07:17:25PM +0000, Edgecombe, Rick P wrote:

> Ah, interesting, thanks for the extra info. So which features is glibc
> planning to use? (probably more of a question for Szabolcs). Are push
> and pop controllable separately?

Push and pop are one control, you get both or neither.

I'll defer to Szabolcs on glibc plans.

--itt77taXQv6vqcOz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSlxJQACgkQJNaLcl1U
h9Dl3gf4pyfBTQGKNG7L2/ecpPEphYcpapfkYdEFAnsVKJ2aZlrgdUGX+h5iB+eV
OIUnTjkuQDFCJ47C3ORYsCtSAbkRe13XbVaYXbOWjB6eJjzgs9LncuKK4aunziJj
mLuY0uRzDE7JbGH94ds/eFOuFHaFPTsd+ZnDEE7ajHueHolhNxgLJZqN8TJhuQ6u
8cNXaAu3CGKgwoLKXh/VaYQQ2LOAivBeFXzDoXKCZGSBpAeAIrkWQj2EoxcAu7BN
pVXE5n3Wq2pwAwPWF0fFaIxHM6FKYcDsPM7u5Sbf0vqDC5MxLxr8kNfzO+7gK9g+
TuGmuQ73sTVmtQZrEqVpN69B27mf
=80j0
-----END PGP SIGNATURE-----

--itt77taXQv6vqcOz--
