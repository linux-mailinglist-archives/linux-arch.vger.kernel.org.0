Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C64275D857
	for <lists+linux-arch@lfdr.de>; Sat, 22 Jul 2023 02:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjGVAii (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jul 2023 20:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjGVAiZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jul 2023 20:38:25 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202CB3C03
        for <linux-arch@vger.kernel.org>; Fri, 21 Jul 2023 17:38:01 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-40371070eb7so72711cf.1
        for <linux-arch@vger.kernel.org>; Fri, 21 Jul 2023 17:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689986262; x=1690591062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gj3Xl7dsvl9L6KFIj63HJhmaeXyRYFaIHbakrb1Ec4I=;
        b=MAdJRMJYGacsbrazrEuC0rQIeU8QNFQUnJUCPgK7a1vzUNIj82x/4RiX3EPgCAVJv+
         vjDvb5O/dVdRr8MjaYyeLQg7RNJx5mp+B0hz5ymmByPWoPUwC282oofovzofBXW4lOgo
         uDPcDd3ofQhJYWARPXrTAICAs+ZZ75L7XDKUp34xegAxO54nxkG3DD/j1+HS5w3acRR0
         2hKfahZSEDpdXscDRJARFhBCX6IVCFk+ORU7D45GfxMEWXwEwOyTHIDBkfpEdDUfweXI
         ZKFKuO/VLBeM83b2EJkOtpn3jk8ZfPHtjtO2qHeaVp1h/KkAmh89HkmVdmMDwtBOJ0ON
         zzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689986262; x=1690591062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gj3Xl7dsvl9L6KFIj63HJhmaeXyRYFaIHbakrb1Ec4I=;
        b=lSx611d7lhMRtZ9NStslNt7G2jVY3lGUMd5pyqrQgN+ouPvhDb4t43ut1ctWMoXFRq
         OnxfL0kwU9DnB8Vy9Ouq8QTsPGi/skkg26xWDBriR+mWVYl41d0o94oCV63awb7PE48t
         2gJifwEUYS8M65iQLoUbBaIwUGCJmHJ8vJCSpO+WaGEoi/odFjzTWQ9gZkCDm23QIfGr
         V0xeb2/d4Sh6yh2pUkdEr0mWHrOs9BUCTZICfSDGoktbdmXOoAV0koCbOSXKFWdNCLFw
         FReDDhDocqcRghFMGxq6z9yHz0vYRqPYnhrILDEG+fyFH4GmW+F5EmCDa1VcecL0tQCB
         KvVw==
X-Gm-Message-State: ABy/qLY5HQvBPKO1X/8XfO2NujGwqlnh9iDzVsZ4vhs7cyA2Ej9vQZeZ
        b+tLvlBgSr5I4vc38N5SF0u6WwNnNzr+FlsO3OFtzg==
X-Google-Smtp-Source: APBJJlG6UeFhKQqQQEY9+tUoce4sdevzyvGzeohxg9thFoKM20vYXi0/+fsLHV/dolkPCJEyE+UJo35jN4HgsafYSAQ=
X-Received: by 2002:ac8:5d49:0:b0:3f4:f0fd:fe7e with SMTP id
 g9-20020ac85d49000000b003f4f0fdfe7emr56472qtx.3.1689986262548; Fri, 21 Jul
 2023 17:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230625-radish-comic-b0861fb96023@spud> <mhng-c2d55859-cf3b-48ac-bf38-9aa1344fc93c@palmer-ri-x1c9a>
In-Reply-To: <mhng-c2d55859-cf3b-48ac-bf38-9aa1344fc93c@palmer-ri-x1c9a>
From:   Fangrui Song <maskray@google.com>
Date:   Fri, 21 Jul 2023 17:37:31 -0700
Message-ID: <CAFP8O3+41QFVyNTVJ2iZYkB0tqnvdLTAoGShgGy-qPP1PHjBEw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Conor Dooley <conor@kernel.org>, jszhang@kernel.org,
        ndesaulniers@google.com, bjorn@kernel.org, llvm@lists.linux.dev,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 25, 2023 at 1:06=E2=80=AFPM Palmer Dabbelt <palmer@dabbelt.com>=
 wrote:
>
> On Sun, 25 Jun 2023 05:43:13 PDT (-0700), Conor Dooley wrote:
> > On Sun, Jun 25, 2023 at 08:24:56PM +0800, Jisheng Zhang wrote:
> >> On Fri, Jun 23, 2023 at 10:17:54AM -0700, Nick Desaulniers wrote:
> >> > On Thu, Jun 22, 2023 at 11:18:03PM +0000, Nathan Chancellor wrote:
> >> > > If you wanted to restrict it to just LD_IS_BFD in arch/riscv/Kconf=
ig,
> >> > > that would be fine with me too.
> >> > >
> >> > >   select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if LD_IS_BFD
> >> >
> >> > Hi Jisheng, would you mind sending a v3 with the attached patch appl=
ied
> >> > on top / at the end of your series?
> >>
> >> Hi Nick, Nathan, Palmer,
> >>
> >> I saw the series has been applied to riscv-next, so I'm not sure which
> >> solution would it be, Palmer to apply Nick's patch to riscv-next or
> >> I to send out v3, any suggestion is appreciated.
> >
> > I don't see what you are seeing w/ riscv/for-next. HEAD is currently at
> > 4681dacadeef ("riscv: replace deprecated scall with ecall") and there
> > are no patches from your series in the branch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/log/?h=
=3Dfor-next
>
> It's been in and out of staging a few times as we tracked down the
> performance regression, but it shouldn't have ever made it to linux-next
> for real.
>
> I'm fine just picking up the patch to disable DCE, I've got a few other
> (hopefully small) things to work through first though.

Note: for GCC, -fpatchable-function-entry=3D (used by
arch/riscv/Kconfig) require GCC 13 for correct garbage collection
semantics.
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D110729

> > Cheers,
> > Conor.
> >
> >> > > Nick said he would work on a report for the LLVM side, so as long =
as
> >> > > this issue is handled in some way to avoid regressing LLD builds u=
ntil
> >> > > it is resolved, I don't think there is anything else for the kerne=
l to
> >> > > do. We like to have breadcrumbs via issue links, not sure if the r=
eport
> >> > > will be internal to Google or on LLVM's issue tracker though;
> >> > > regardless, we will have to touch this block to add a version chec=
k
> >> > > later, at which point we can add a link to the fix in LLD.
> >> >
> >> > https://github.com/ClangBuiltLinux/linux/issues/1881
> >>
> >> > From 3e5e010958ee41b9fb408cfade8fb017c2fe7169 Mon Sep 17 00:00:00 20=
01
> >> > From: Nick Desaulniers <ndesaulniers@google.com>
> >> > Date: Fri, 23 Jun 2023 10:06:17 -0700
> >> > Subject: [PATCH] riscv: disable HAVE_LD_DEAD_CODE_DATA_ELIMINATION f=
or LLD
> >> >
> >> > Linking allyesconfig with ld.lld-17 with CONFIG_DEAD_CODE_ELIMINATIO=
N=3Dy
> >> > takes hours.  Assuming this is a performance regression that can be
> >> > fixed, tentatively disable this for now so that allyesconfig builds
> >> > don't start timing out.  If and when there's a fix to ld.lld, this c=
an
> >> > be converted to a version check instead so that users of older but s=
till
> >> > supported versions of ld.lld don't hurt themselves by enabling
> >> > CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=3Dy.
> >> >
> >> > Link: https://github.com/ClangBuiltLinux/linux/issues/1881
> >> > Reported-by: Palmer Dabbelt <palmer@dabbelt.com>
> >> > Suggested-by: Nathan Chancellor <nathan@kernel.org>
> >> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >> > ---
> >> > Hi Jisheng, would you mind sending a v3 with this patch on top/at th=
e
> >> > end of your patch series?
> >> >
> >> >  arch/riscv/Kconfig | 3 ++-
> >> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >> > index 8effe5bb7788..0573991e9b78 100644
> >> > --- a/arch/riscv/Kconfig
> >> > +++ b/arch/riscv/Kconfig
> >> > @@ -116,7 +116,8 @@ config RISCV
> >> >    select HAVE_KPROBES if !XIP_KERNEL
> >> >    select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
> >> >    select HAVE_KRETPROBES if !XIP_KERNEL
> >> > -  select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> >> > +  # https://github.com/ClangBuiltLinux/linux/issues/1881
> >> > +  select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !LD_IS_LLD
> >> >    select HAVE_MOVE_PMD
> >> >    select HAVE_MOVE_PUD
> >> >    select HAVE_PCI
> >> > --
> >> > 2.41.0.162.gfafddb0af9-goog
> >> >
> >>
>


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
