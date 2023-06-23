Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EBB73B6F6
	for <lists+linux-arch@lfdr.de>; Fri, 23 Jun 2023 14:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjFWMRg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Jun 2023 08:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFWMRf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Jun 2023 08:17:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70931BE4;
        Fri, 23 Jun 2023 05:17:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 767EF61A39;
        Fri, 23 Jun 2023 12:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAB1C433C0;
        Fri, 23 Jun 2023 12:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687522653;
        bh=+7+qY2pMjJYzB9xElhuCVbaU19w3qgAqAoglFmxdPOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hDEa6UrV+PRl4gVbTIs/hZdUDvZIr/H1xBTlK856m60e8pDuMAFgtOA4E3Z+w3z2D
         L5qHQY1QuSFJyDb835gTkZn9vNoLgcUDeS567rvnfVqqQmxnm/U87TD/gujZr5Sawj
         W10+cvRXWfs9IHCtOP66qOmtqejcXkPuYGHArVW+bdHP9aRvqAkXM0pDMmVl6Df3If
         +SXba9qDA+VmFbFbl1P5my5mcIug+uUU/y6LYNbRZ+HRwXY55CCmpQk5FAd/mQA6V6
         RfNnSnFbUxxfGDa4ALqAaV256v8TnBRhKXif0TKoHSuCMYPNVzOMh8o7h99c36o31G
         Jt4nQ1NE2izFA==
Date:   Fri, 23 Jun 2023 13:17:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 16/42] mm: Add guard pages around a shadow stack.
Message-ID: <ZJWNWeqQ8ON9NNfs@finisterre.sirena.org.uk>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-17-rick.p.edgecombe@intel.com>
 <ZJSRD1xZauOW3jFO@casper.infradead.org>
 <ba77d21492e2631072f51328413d227f31dd78ae.camel@intel.com>
 <20230623074000.GG52412@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6xcRS/HNRY4aTkhh"
Content-Disposition: inline
In-Reply-To: <20230623074000.GG52412@kernel.org>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--6xcRS/HNRY4aTkhh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2023 at 10:40:00AM +0300, Mike Rapoport wrote:
> On Thu, Jun 22, 2023 at 06:27:40PM +0000, Edgecombe, Rick P wrote:

> > Yes, I couldn't find another place for it. This was the reasoning:
> > https://lore.kernel.org/lkml/07deaffc10b1b68721bbbce370e145d8fec2a494.c=
amel@intel.com/

> > Did you have any particular place in mind?

> Since it's near CONFIG_X86_USER_SHADOW_STACK the comment in mm.h could be=
=20

> /*
>  * VMA is used for shadow stack and implies guard pages.
>  * See arch/x86/kernel/shstk.c for details
>  */

> and the long reasoning comment can be moved near alloc_shstk in
> arch/x86/kernel/shstk.h

This isn't an x86 specific concept, arm64 has a very similar extension
called Guarded Control Stack (which I should be publishing changes for
in the not too distant future) and riscv also has something.  For arm64
I'm using the generic mm changes wholesale, we have a similar need for
guard pages around the GCS and while the mechanics of accessing are
different the requirement ends up being the same.  Perhaps we could just
rewrite the comment to say that guard pages prevent over/underflow of
the stack by userspace and that a single page is sufficient for all
current architectures, with the details of the working for x86 put in
some x86 specific place?

--6xcRS/HNRY4aTkhh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSVjVUACgkQJNaLcl1U
h9BV1ggAgSOn8u1kb6HeUhHTldAbqy+XWNhMN9/fILZ0CP9sw4vUhTHZa0SfygRu
BJ/QiMVJ00xJd26NTnXoK5gLBGmz3qDSpX6JxHhytRM2zLh1KS8tZkEYS9kehwrl
Iiqgg53zg31Ir/5LJ7PsBQ6SAd4rfE5aZKG8NAR653jLr2SRMEd3BUx8ZJj6/Re/
MpKQfBwU9ltLLEOS6xI0+f0YibTkxPcKp9+zMXWi5+xDCCxdhPxpcFok7ZcBpaOj
2ay7LhRYRsKziXpV3Y4RorbiXt7zgehqryMShTvoTswU2LbkxdP95Ob3nHVTRW+s
P+ACzWi6uNUFXQ1Ko44YzoQboSpPPA==
=ssEI
-----END PGP SIGNATURE-----

--6xcRS/HNRY4aTkhh--
