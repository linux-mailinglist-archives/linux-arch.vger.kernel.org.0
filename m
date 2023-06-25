Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44FA73D110
	for <lists+linux-arch@lfdr.de>; Sun, 25 Jun 2023 14:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjFYMnV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 25 Jun 2023 08:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjFYMnU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Jun 2023 08:43:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3A9F5;
        Sun, 25 Jun 2023 05:43:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9453660BBF;
        Sun, 25 Jun 2023 12:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC56C433C8;
        Sun, 25 Jun 2023 12:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687696998;
        bh=uw+THhCcFwsu2QuqBbqVeEBv0iNk0Ab27RGodyuvtLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ncFKjJEUCyQW3JK+9ueyHlu+2WwftBNfqS7BLGzYCY3LOKe+03s1rVSappC7BnKcY
         xzHvmyRTr9HobXJHODEpqL23UGYvWkh8Xb757DExVQPvGXx2sie1373q0qacF7WA1l
         KPYOuBcgmJDFFl7Csll9L7UZlIDNRjTGK1znm0nXZ/Y7Mxk7K0ex1nfDoQ07VKbTij
         g3ctPgYJ7LsAh2PYjpx2Y/IK1mjycvnv6cBo42+zS6COvu/ax+DvrHjcHk4RgPM7KN
         Dyngujvl96O9Eb9wjblTvRRuPuzCGUfmyaLnURs6hGGDH0Q5s/bovTim73wB0OdpxQ
         Ax8zTzd/jEErQ==
Date:   Sun, 25 Jun 2023 13:43:13 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, bjorn@kernel.org,
        llvm@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 0/4] riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Message-ID: <20230625-radish-comic-b0861fb96023@spud>
References: <20230622215327.GA1135447@dev-arch.thelio-3990X>
 <mhng-6c34765c-126d-4e6c-8904-e002d49a4336@palmer-ri-x1c9a>
 <20230622231803.GA1790165@dev-arch.thelio-3990X>
 <ZJXTwqZIkXLxXaSi@google.com>
 <ZJgyGD8ZSjVmiprB@xhacker>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Cddf6K/j8n8gvZx4"
Content-Disposition: inline
In-Reply-To: <ZJgyGD8ZSjVmiprB@xhacker>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--Cddf6K/j8n8gvZx4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 25, 2023 at 08:24:56PM +0800, Jisheng Zhang wrote:
> On Fri, Jun 23, 2023 at 10:17:54AM -0700, Nick Desaulniers wrote:
> > On Thu, Jun 22, 2023 at 11:18:03PM +0000, Nathan Chancellor wrote:
> > > If you wanted to restrict it to just LD_IS_BFD in arch/riscv/Kconfig,
> > > that would be fine with me too.
> > >=20
> > >   select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if LD_IS_BFD
> >=20
> > Hi Jisheng, would you mind sending a v3 with the attached patch applied
> > on top / at the end of your series?
>=20
> Hi Nick, Nathan, Palmer,
>=20
> I saw the series has been applied to riscv-next, so I'm not sure which
> solution would it be, Palmer to apply Nick's patch to riscv-next or
> I to send out v3, any suggestion is appreciated.

I don't see what you are seeing w/ riscv/for-next. HEAD is currently at
4681dacadeef ("riscv: replace deprecated scall with ecall") and there
are no patches from your series in the branch:
https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/log/?h=3Dfo=
r-next

Cheers,
Conor.

> > > Nick said he would work on a report for the LLVM side, so as long as
> > > this issue is handled in some way to avoid regressing LLD builds until
> > > it is resolved, I don't think there is anything else for the kernel to
> > > do. We like to have breadcrumbs via issue links, not sure if the repo=
rt
> > > will be internal to Google or on LLVM's issue tracker though;
> > > regardless, we will have to touch this block to add a version check
> > > later, at which point we can add a link to the fix in LLD.
> >=20
> > https://github.com/ClangBuiltLinux/linux/issues/1881
>=20
> > From 3e5e010958ee41b9fb408cfade8fb017c2fe7169 Mon Sep 17 00:00:00 2001
> > From: Nick Desaulniers <ndesaulniers@google.com>
> > Date: Fri, 23 Jun 2023 10:06:17 -0700
> > Subject: [PATCH] riscv: disable HAVE_LD_DEAD_CODE_DATA_ELIMINATION for =
LLD
> >=20
> > Linking allyesconfig with ld.lld-17 with CONFIG_DEAD_CODE_ELIMINATION=
=3Dy
> > takes hours.  Assuming this is a performance regression that can be
> > fixed, tentatively disable this for now so that allyesconfig builds
> > don't start timing out.  If and when there's a fix to ld.lld, this can
> > be converted to a version check instead so that users of older but still
> > supported versions of ld.lld don't hurt themselves by enabling
> > CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=3Dy.
> >=20
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1881
> > Reported-by: Palmer Dabbelt <palmer@dabbelt.com>
> > Suggested-by: Nathan Chancellor <nathan@kernel.org>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> > Hi Jisheng, would you mind sending a v3 with this patch on top/at the
> > end of your patch series?
> >=20
> >  arch/riscv/Kconfig | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 8effe5bb7788..0573991e9b78 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -116,7 +116,8 @@ config RISCV
> >  	select HAVE_KPROBES if !XIP_KERNEL
> >  	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
> >  	select HAVE_KRETPROBES if !XIP_KERNEL
> > -	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> > +	# https://github.com/ClangBuiltLinux/linux/issues/1881
> > +	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !LD_IS_LLD
> >  	select HAVE_MOVE_PMD
> >  	select HAVE_MOVE_PUD
> >  	select HAVE_PCI
> > --=20
> > 2.41.0.162.gfafddb0af9-goog
> >=20
>=20

--Cddf6K/j8n8gvZx4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJg2YQAKCRB4tDGHoIJi
0nAEAQD701JCrnWdXplFizS5WQslP2hoBx5xuZNxyoFFL/ExAQD+MaFPDb9nGQgJ
B4z5ajWVB8vRrPS6gu9KMtAmSWLjKgo=
=3gUZ
-----END PGP SIGNATURE-----

--Cddf6K/j8n8gvZx4--
