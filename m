Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DCD73DFB0
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jun 2023 14:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjFZMrj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jun 2023 08:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjFZMrN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2023 08:47:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA0E1FF3;
        Mon, 26 Jun 2023 05:46:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DCD060E00;
        Mon, 26 Jun 2023 12:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F70C433C0;
        Mon, 26 Jun 2023 12:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687783544;
        bh=ad7qXuxyTVm3Hup4TPrwUJSUzMHj6o5DDbnqUq5bBhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nr+VZhRu1S8TdcgB1G3LwUYdS5Mevc1gEG6wluGez0PuFw8p/4IWpVNl6aqJ1TIxN
         F1/LkWsR08SV4KNW5tSrRuJZt7z34scYrn27JUm9WtSj8gMjLja7ZndbPeUkbFvBgK
         1GE5ZE40gU4zjajLs9XFuMXc9QVj7iXibAFLI08/a+NWNxkLulw1CB6n+0vhgCsx9h
         13jHCc35DHf0VHZ186ZcCP1u1zY318iTOjEr6LgU4EA6z0nrS3N6DIUqli3Ero4CYr
         GguqwF7vUjUX8TmvlOgjhvtzHM0QK68M/Hs52b9FyPFG97Eq+mPCwcXXf5e09fH3gP
         k7KSDnuO7JCHA==
Date:   Mon, 26 Jun 2023 13:45:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "rppt@kernel.org" <rppt@kernel.org>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "willy@infradead.org" <willy@infradead.org>,
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
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 16/42] mm: Add guard pages around a shadow stack.
Message-ID: <ad6df14b-1fbd-4136-abcd-314425c28306@sirena.org.uk>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-17-rick.p.edgecombe@intel.com>
 <ZJSRD1xZauOW3jFO@casper.infradead.org>
 <ba77d21492e2631072f51328413d227f31dd78ae.camel@intel.com>
 <20230623074000.GG52412@kernel.org>
 <ZJWNWeqQ8ON9NNfs@finisterre.sirena.org.uk>
 <10673dd87c27ea9def60ff841ebd261d31b46568.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FlQ2BtIHgZ0V+5nj"
Content-Disposition: inline
In-Reply-To: <10673dd87c27ea9def60ff841ebd261d31b46568.camel@intel.com>
X-Cookie: Nihilism should commence with oneself.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--FlQ2BtIHgZ0V+5nj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 25, 2023 at 04:44:32PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2023-06-23 at 13:17 +0100, Mark Brown wrote:

> > This isn't an x86 specific concept, arm64 has a very similar
> > extension
> > called Guarded Control Stack (which I should be publishing changes
> > for
> > in the not too distant future) and riscv also has something.=A0 For
> > arm64
> > I'm using the generic mm changes wholesale, we have a similar need
> > for
> > guard pages around the GCS and while the mechanics of accessing are
> > different the requirement ends up being the same.=A0 Perhaps we could
> > just
> > rewrite the comment to say that guard pages prevent over/underflow of
> > the stack by userspace and that a single page is sufficient for all
> > current architectures, with the details of the working for x86 put in
> > some x86 specific place?

> Something sort of similar came up in regards to the riscv series, about
> adding something like an is_shadow_stack_vma() helper. The plan was to
> not make too many assumptions about the final details of the other
> shadow stack features and leave that for refactoring. I think some kind
> of generic comment like you suggest makes sense, but I don't want to
> try to assert any arch specifics for features that are not upstream. It
> should be very easy to tweak the comment when the time comes.

> The points about x86 details not belonging in non-arch headers and
> having some arch generic explanation in the file are well taken though.

I think a statement to the effect that "this works for currently
supported architectures" is fine, if something comes along with
additional requirements then the comment can be adjusted as part of
merging the new thing.

--FlQ2BtIHgZ0V+5nj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSZiGsACgkQJNaLcl1U
h9B3DAf+LWSA4bx8fTIOePWjXu2L6LeG9YG2PswlY0EfvmEvZtaSKmIszPhtMDUb
06vPe7GHKtgxB2gXQ0wUveNXqXUQRVDsuHmg7hAMEXzTGl+Ael3P1MSzNFV94LIQ
Z3BXNKJk0egBAthRbZmyGcpj1sfp082RpsdI1a6dViRJwjd+ODTNI089CvNemY6b
MJvmuMEJdjaRlrTGdfIBTdCKDNCqQQxqhMXBOcY5Hr7d9JLNa5JaWwfgyO0PbipH
L20yRdqFhM5cEJ70RuHtQuyAJB/cDQlQZKUGJhTXwys+xbYjkZ9Dad1CvN4N1+SS
E1ZXpzd5bzwITEKsBrkm9meQGQuK9A==
=kRl4
-----END PGP SIGNATURE-----

--FlQ2BtIHgZ0V+5nj--
