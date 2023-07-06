Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2135474A415
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jul 2023 21:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjGFTDi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jul 2023 15:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjGFTDh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jul 2023 15:03:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DF31FC6;
        Thu,  6 Jul 2023 12:03:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A35861195;
        Thu,  6 Jul 2023 19:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544ECC433C8;
        Thu,  6 Jul 2023 19:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688670214;
        bh=zcBaqYahXAhcJ/QGg28GedoZoIVRedEm6esUTbPIAu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l49iNd/Eq8MI5J5iGM4+8yyNRvSI7FDdHtcqmzr+ZqirbMTsIw7q3Q5ls0sGRQ1yg
         z12VRI0ksavt/91yuHf0jyduqbFage5sdzXAiUCfc8JooCD+FT8ZrR2fw8/+jIig98
         xd8nda7Xkyt7AKcS/hSVbzvjQxrKe8VVfP1cKqTmILol4DBbfnnJ7UFvCYEZ7E5laC
         qlPdgNIB8qOVEOwzDR9a83fNXrlEFe4WNgZhRGiYa2tbLy+64yYabP1ekBXbKoOa15
         tdj8edsHQRhdln8WejySsXzZQZSp+iGneoUFwGeXn98WHx1IhiyBrFyDzHYtL9S/M3
         z6TIB6xsj2z4w==
Date:   Thu, 6 Jul 2023 20:03:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Message-ID: <352b0dfa-9da1-4996-8086-b45950f023ff@sirena.org.uk>
References: <eda8b2c4b2471529954aadbe04592da1ddae906d.camel@intel.com>
 <2a30ac58-d970-45c3-87d2-55396c0a83f9@sirena.org.uk>
 <0a9ade13b989ea881fd43fabbe5de1d248cf4218.camel@intel.com>
 <ccce9d4a-90fe-465a-88ae-ea1416770c77@sirena.org.uk>
 <ZKa+QFKHSyqMlriG@arm.com>
 <e9a377ce-7ce4-47b0-b30e-56a5aae18544@sirena.org.uk>
 <a7f312b1e712b87f4932d6295e6f6d28f41afd8f.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sGlMqBUxl5KKZAGa"
Content-Disposition: inline
In-Reply-To: <a7f312b1e712b87f4932d6295e6f6d28f41afd8f.camel@intel.com>
X-Cookie: Don't read everything you believe.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--sGlMqBUxl5KKZAGa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2023 at 04:59:45PM +0000, Edgecombe, Rick P wrote:
> On Thu, 2023-07-06 at 15:24 +0100, Mark Brown wrote:
> > szabolcs.nagy@arm.com=A0wrote:
> > > The 07/05/2023 20:29, Mark Brown wrote:

> > > gcspopm is always available (esentially *ssp++, this is used
> > > for longjmp).

> > Ah, sorry - I misremembered there.=A0 You're right, it's only push that
> > we
> > have control over.

FWIW the confusion there was some of the hypervisor features which do
tie some of the push and pop instructions together.

> Ah, ok! So if you are not planning to enable the push mode then the
> features are pretty well aligned, except:
>  - On x86 it is possible to switch stacks without leaving a token=A0
>    behind.
>  - The GCSPOPM/INCSSP looping may require longer loops on ARM=A0
>    because it only pops one at at time.

> If you are not going to use GCSPUSHM by default, then I think we
> *should* be able to have some unified set of rules for developers for
> glibc behaviors at least.

Yes, the only case where I am aware of conciously diverging in any
substantial way is that we do not free the GCS when GCS is disabled by
userspace, we just disable the updates and checks, and reenabling after
disabling is not supported.  We have demand for disabling at runtime so
we want to keep the stack around for things like a running unwinder but
we don't see a practical use for reenabling so didn't worry about
figuring out what would make sense for userspace.  glibc isn't going to
be using that though.

--sGlMqBUxl5KKZAGa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSnD/kACgkQJNaLcl1U
h9BAuQf/ZlxwHanBD/TEBQkEI5Myy6kEtI1p6LWXwsCmree4AOmHNPxc7m9HqdSD
d+N1YrfV4XPVTnR5xnknnbKZ1QGdOvKAhv0UbDFFRJn/TY3d8miPOMqgpAF35K6C
Urpa0SPngTHYCZ32LKoHyy1G9zG4nH5FgXcN0bmOzU8+orrnvzjXAUbroEbgUxQR
Af3rlLZN1E1qKzBIU7LC3+InmYpYeWOU3K7B/XP6c/OQMJrJr4k4gWN+DW7bQMsF
SkmwVwADaxUidhKpXFWwvQ4bsBo3x1Es7j7wjU8uFOwX+gxAwTqgWkZBjg8D79Om
pXGXRkbF+a5wHjTTpEGJRnqCBBqQxw==
=cL31
-----END PGP SIGNATURE-----

--sGlMqBUxl5KKZAGa--
