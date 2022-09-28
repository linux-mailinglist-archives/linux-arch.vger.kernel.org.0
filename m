Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FD55EE81D
	for <lists+linux-arch@lfdr.de>; Wed, 28 Sep 2022 23:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbiI1VQL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Sep 2022 17:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbiI1VPv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2022 17:15:51 -0400
Received: from condef-01.nifty.com (condef-01.nifty.com [202.248.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A46476D9;
        Wed, 28 Sep 2022 14:10:33 -0700 (PDT)
Received: from conssluserg-02.nifty.com ([10.126.8.81])by condef-01.nifty.com with ESMTP id 28SL6gC7000770;
        Thu, 29 Sep 2022 06:06:42 +0900
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 28SL5q68001910;
        Thu, 29 Sep 2022 06:05:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 28SL5q68001910
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664399153;
        bh=9up+bTK5BWQ+kwLY4kLOa7NGKSwEXLj5uD5cGziJ5To=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l3lK4KpEimBu9kNN3NdsTgWZYUiRP6a7evwtiMaAed7gzcGZk1vlv4lwASNgN08ez
         q+A+DR7SHnqJFBdBj+AJXKhaOB4FHXIOeY82ygyJgElxazdlSVFkQCoqf7XKcgRUPi
         qUw2gO/lULtJCu7Lj6Ad1PLo1npHKWo42VSVM9f6538MOkFkcn4qn0YqZRrnlJibBb
         SxoadZyn7VuaEp53OpYL2UK0Gm0z9g8lPr9Cnj/PMx8Gla8T2HHJJ3KkGBCc2GVZCj
         csKUWv60JDvWXNkeoDYXgUbCaErF0yCzzB1JuAaE7kIP0+/QXo8K53n0Uekyp1AxAe
         +j48axC9FlBlQ==
X-Nifty-SrcIP: [209.85.167.181]
Received: by mail-oi1-f181.google.com with SMTP id s125so16797537oie.4;
        Wed, 28 Sep 2022 14:05:53 -0700 (PDT)
X-Gm-Message-State: ACrzQf3Pd69jcEclYFnIXBLan3MmFcH7fIGEkDOZPpEx5ZiUNwuOcOIx
        E+YfozMARUrgFy6Ttw35d5CW13gcRUTXKQ9P4BA=
X-Google-Smtp-Source: AMsMyM6Vv0mXNByGI64xVVwo+ve0W4Oeq9motr7ErKJeVs+xPXBnbO2weKAtdYXWjczfclkJ8MDFyuRIPMKH14k/VZY=
X-Received: by 2002:a54:400c:0:b0:34f:9913:262 with SMTP id
 x12-20020a54400c000000b0034f99130262mr5193714oie.287.1664399152276; Wed, 28
 Sep 2022 14:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220924181915.3251186-1-masahiroy@kernel.org>
 <20220924181915.3251186-6-masahiroy@kernel.org> <YzSnlIChHmKdKFt8@bergen.fjasle.eu>
In-Reply-To: <YzSnlIChHmKdKFt8@bergen.fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 29 Sep 2022 06:05:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQm9CQe26=rgid36KX3JTfwP0zOhZBXCjssj_hOvFePDw@mail.gmail.com>
Message-ID: <CAK7LNAQm9CQe26=rgid36KX3JTfwP0zOhZBXCjssj_hOvFePDw@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] kbuild: unify two modpost invocations
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 4:59 AM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> On Sun, 25 Sep 2022 03:19:13 +0900 Masahiro Yamada wrote:
> > Currently, modpost is executed twice; first for vmlinux, second
> > for modules.
> >
> > This commit merges them.
> >
> > Current build flow
> > ==================
> >
> >   1) build obj-y and obj-m objects
> >     2) link vmlinux.o
> >       3) modpost for vmlinux
> >         4) link vmlinux
> >           5) modpost for modules
> >             6) link modules (*.ko)
> >
> > The build steps 1) through 6) are serialized, that is, modules are
> > built after vmlinux. You do not get benefits of parallel builds when
> > scripts/link-vmlinux.sh is being run.
> >
> > New build flow
> > ==============
> >
> >   1) build obj-y and obj-m objects
> >     2) link vmlinux.o
> >       3) modpost for vmlinux and modules
> >         4a) link vmlinux
> >         4b) link modules (*.ko)
> >
> > In the new build flow, modpost is invoked just once.
> >
> > vmlinux and modules are built in parallel. One exception is
> > CONFIG_DEBUG_INFO_BTF_MODULES=y, where modules depend on vmlinux.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> > (no changes since v1)
> >
> >  Makefile                  | 30 ++++++++++---
> >  scripts/Makefile.modfinal |  2 +-
> >  scripts/Makefile.modpost  | 93 ++++++++++++---------------------------
> >  scripts/link-vmlinux.sh   |  3 --
> >  4 files changed, 53 insertions(+), 75 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index b5dfb54b1993..cf9d7b1d8c14 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1152,7 +1152,7 @@ cmd_link-vmlinux =                                                 \
> >       $(CONFIG_SHELL) $< "$(LD)" "$(KBUILD_LDFLAGS)" "$(LDFLAGS_vmlinux)";    \
> >       $(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
> >
> > -vmlinux: scripts/link-vmlinux.sh vmlinux.o $(KBUILD_LDS) FORCE
> > +vmlinux: scripts/link-vmlinux.sh vmlinux.o $(KBUILD_LDS) modpost FORCE
> >       +$(call if_changed_dep,link-vmlinux)
> >
> >  targets := vmlinux
> > @@ -1428,7 +1428,13 @@ endif
> >  # Build modules
> >  #
> >
> > -modules: $(if $(KBUILD_BUILTIN),vmlinux) modules_prepare
> > +# *.ko are usually independent of vmlinux, but CONFIG_DEBUG_INFOBTF_MODULES
> > +# is an exception.
> > +ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> > +modules: vmlinux
> > +endif
> > +
> > +modules: modules_prepare
> >
> >  # Target to prepare building external modules
> >  modules_prepare: prepare
> > @@ -1741,8 +1747,12 @@ ifdef CONFIG_MODULES
> >  $(MODORDER): $(build-dir)
> >       @:
> >
> > -modules: modules_check
> > -     $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
> > +# KBUILD_MODPOST_NOFINAL can be set to skip the final link of modules.
> > +# This is solely useful to speed up test compiles.
> > +modules: modpost
> > +ifneq ($(KBUILD_MODPOST_NOFINAL),1)
> > +     $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modfinal
> > +endif
> >
> >  PHONY += modules_check
> >  modules_check: $(MODORDER)
> > @@ -1773,6 +1783,11 @@ KBUILD_MODULES :=
> >
> >  endif # CONFIG_MODULES
> >
> > +PHONY += modpost
> > +modpost: $(if $(single-build),, $(if $(KBUILD_BUILTIN), vmlinux.o)) \
> > +      $(if $(KBUILD_MODULES), modules_check)
> > +     $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
> > +
> >  # Single targets
> >  # ---------------------------------------------------------------------------
> >  # To build individual files in subdirectories, you can do like this:
> > @@ -1792,16 +1807,19 @@ single-ko := $(sort $(filter %.ko, $(MAKECMDGOALS)))
> >  single-no-ko := $(filter-out $(single-ko), $(MAKECMDGOALS)) \
> >               $(foreach x, o mod, $(patsubst %.ko, %.$x, $(single-ko)))
> >
> > -$(single-ko): single_modpost
> > +$(single-ko): single_modules
> >       @:
> >  $(single-no-ko): $(build-dir)
> >       @:
> >
> >  # Remove MODORDER when done because it is not the real one.
> >  PHONY += single_modpost
>
> PHONY += single_modules


Thank you for your close review!
I will fix it locally.




>
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
>

-- 
Best Regards
Masahiro Yamada
