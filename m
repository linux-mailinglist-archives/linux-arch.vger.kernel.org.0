Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3DD521621
	for <lists+linux-arch@lfdr.de>; Tue, 10 May 2022 14:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiEJNCR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 May 2022 09:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbiEJNCQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 May 2022 09:02:16 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9752025B07E;
        Tue, 10 May 2022 05:58:18 -0700 (PDT)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 24ACvu4l008246;
        Tue, 10 May 2022 21:57:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 24ACvu4l008246
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652187477;
        bh=mDq58kWqu5y6Ln3TC7JKVH4wytZMH5iO9I4WePnz7Bo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=25sw6WfcaNFpzlfb4msKJ34LislgAAvnKZ+A6sjKvYBd9jNotcIcDp4pDtnS9cS6K
         3O0cXfwv4N/y4gT0OqeD3ZyD1dcCXnHQLf/k5kMNR6OCTuMMZzxWj2CxJdyz9E5UtR
         qIFFiB8R+/giRHrQAIBy/Er/WpaGE+k3Z9Ch2gG/H+skdyAJSXqOs25DtPVarg1sNl
         8Mvb3gweXIfl6ZOwgeCFUjXlFCaORv7IdZddFp7CxTHWcSly6BZF2vtJGtUV+kAZwS
         Y3EG9/02SZdaVK1ZHregEwLrvRiwf1lm5uWy7liINijFykYBvvpmnHsOUTuEb0a4ni
         uz4zxyE12TYHg==
X-Nifty-SrcIP: [209.85.216.47]
Received: by mail-pj1-f47.google.com with SMTP id j10-20020a17090a94ca00b001dd2131159aso1994341pjw.0;
        Tue, 10 May 2022 05:57:57 -0700 (PDT)
X-Gm-Message-State: AOAM531efcP4zFp6/kXF//US+3T+t2/x5+vFaJB43DDanv3S7E8aNGa+
        f3Utp1WLuO17oxY9hYiXhtmODJ/Izry85pbVb/A=
X-Google-Smtp-Source: ABdhPJwVCu7JYNjP+tBUTZDYPZFRxT0HhS9s5h+HxxNYpS2r41IeeCRGW2VFALcZUFeRFcUkknN3i9epiSZ0GRDsIqo=
X-Received: by 2002:a17:90a:e517:b0:1d7:5bbd:f9f0 with SMTP id
 t23-20020a17090ae51700b001d75bbdf9f0mr22749582pjy.77.1652187476536; Tue, 10
 May 2022 05:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220503024716.76666-1-masahiroy@kernel.org> <Yno4m91/H65yX4T1@buildd.core.avm.de>
In-Reply-To: <Yno4m91/H65yX4T1@buildd.core.avm.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 10 May 2022 21:56:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNASDZz4osNX3HgzrK7KVQ0C4uEGOBjbmCfTsBG25jOieXA@mail.gmail.com>
Message-ID: <CAK7LNASDZz4osNX3HgzrK7KVQ0C4uEGOBjbmCfTsBG25jOieXA@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: factor out the common installation code into scripts/install.sh
To:     Nicolas Schier <n.schier@avm.de>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 10, 2022 at 7:04 PM Nicolas Schier <n.schier@avm.de> wrote:
>
> On Tue,  3 May 2022 11:47 +0900 Masahiro Yamada wrote:
> > Many architectures have similar install.sh scripts.
> >
> > The first half is really generic; verifies that the kernel image and
> > System.map exist, then executes ~/bin/${INSTALLKERNEL} or
> > /sbin/${INSTALLKERNEL} if available.
> >
> > The second half is kind of arch-specific. It just copies the kernel image
> > and System.map to the destination, but the code is slightly different.
> >
> > This patch factors out the generic part into scripts/install.sh.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> > Changes in v2:
> >   - Move the installkernel parameters to scripts/install.sh
> >
> >  Makefile                     |  3 ++-
> >  arch/arm/Makefile            |  4 ++--
> >  arch/arm/boot/install.sh     | 21 ------------------
> >  arch/arm64/Makefile          |  6 ++----
> >  arch/arm64/boot/install.sh   | 21 ------------------
> >  arch/ia64/Makefile           |  3 ++-
> >  arch/ia64/install.sh         | 10 ---------
> >  arch/m68k/Makefile           |  3 ++-
> >  arch/m68k/install.sh         | 22 -------------------
> >  arch/nios2/Makefile          |  3 +--
> >  arch/nios2/boot/install.sh   | 22 -------------------
> >  arch/parisc/Makefile         | 11 +++++-----
> >  arch/parisc/install.sh       | 28 ------------------------
> >  arch/powerpc/Makefile        |  3 +--
> >  arch/powerpc/boot/install.sh | 23 --------------------
> >  arch/riscv/Makefile          |  7 +++---
> >  arch/riscv/boot/install.sh   | 21 ------------------
> >  arch/s390/Makefile           |  3 +--
> >  arch/s390/boot/install.sh    |  6 ------
> >  arch/sparc/Makefile          |  3 +--
> >  arch/sparc/boot/install.sh   | 22 -------------------
> >  arch/x86/Makefile            |  3 +--
> >  arch/x86/boot/install.sh     | 22 -------------------
> >  scripts/install.sh           | 41 ++++++++++++++++++++++++++++++++++++
> >  24 files changed, 64 insertions(+), 247 deletions(-)
> >  mode change 100644 => 100755 arch/arm/boot/install.sh
> >  mode change 100644 => 100755 arch/arm64/boot/install.sh
> >  mode change 100644 => 100755 arch/ia64/install.sh
> >  mode change 100644 => 100755 arch/m68k/install.sh
> >  mode change 100644 => 100755 arch/nios2/boot/install.sh
> >  mode change 100644 => 100755 arch/parisc/install.sh
> >  mode change 100644 => 100755 arch/powerpc/boot/install.sh
> >  mode change 100644 => 100755 arch/riscv/boot/install.sh
> >  mode change 100644 => 100755 arch/s390/boot/install.sh
> >  mode change 100644 => 100755 arch/sparc/boot/install.sh
> >  mode change 100644 => 100755 arch/x86/boot/install.sh
> >  create mode 100755 scripts/install.sh
> >
> > diff --git a/Makefile b/Makefile
> > index 9a60f732bb3c..154c32af8805 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1298,7 +1298,8 @@ scripts_unifdef: scripts_basic
> >  # to this Makefile to build and install external modules.
> >  # Cancel sub_make_done so that options such as M=, V=, etc. are parsed.
> >
> > -install: sub_make_done :=
> > +quiet_cmd_install = INSTALL $(INSTALL_PATH)
> > +      cmd_install = unset sub_make_done; $(srctree)/scripts/install.sh
>
> This is the third 'cmd_install' in the tree; might it be better to take
> a more unique name (e.g. cmd_installkernel) to prevent confusion?

If this is confusing, we can rename the ones in
scripts/Makefile.{modinst,headersinst}.

This command name matches the build target ("make install"), so
I believe this name is good.



>
> For me, it would have been more clear, if we'd also move the default
> KBUILD_IMAGE definition here (similar to the corresponding part in
> arch/parisc/Makefile):
>
> zinstall: KBUILD_IMAGE := $(boot)/Image.gz
>
> ($(KBUILD_IMAGE) seems not to be used anywhere else in arch/arm64/
> tree; but I haven't checked in depth.)


KBUILD_IMAGE is _indirectly_ used to specify
the kernel image for package builds.    [1]

This target returns the value IMAGE_BUILD.   [2]


$(KBUILD_IMAGE) is definitely used for arm64.

[1]: https://github.com/torvalds/linux/blob/v5.17/scripts/package/builddeb#L150
[2]: https://github.com/torvalds/linux/blob/v5.17/Makefile#L1943







> > diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
> > index 7583fc39ab2d..aca1710fd658 100644
> > --- a/arch/parisc/Makefile
> > +++ b/arch/parisc/Makefile
> > @@ -184,12 +184,11 @@ vdso_install:
> >       $(Q)$(MAKE) $(build)=arch/parisc/kernel/vdso $@
> >       $(if $(CONFIG_COMPAT_VDSO), \
> >               $(Q)$(MAKE) $(build)=arch/parisc/kernel/vdso32 $@)
> > -install:
> > -     $(CONFIG_SHELL) $(srctree)/arch/parisc/install.sh \
> > -                     $(KERNELRELEASE) vmlinux System.map "$(INSTALL_PATH)"
> > -zinstall:
> > -     $(CONFIG_SHELL) $(srctree)/arch/parisc/install.sh \
> > -                     $(KERNELRELEASE) vmlinuz System.map "$(INSTALL_PATH)"
> > +
> > +install: KBUILD_IMAGE := vmlinux
> > +zinstall: KBUILD_IMAGE := vmlinuz
>
> Does this make the KBUILD_IMAGE definition in line 19 obsolete and
> unused?


As I said above for arm64, KBUILD_IMAGE is used for package builds.

If you delete line 19, it will change the behavior.
(fall back to the global default [3])


[3]: https://github.com/torvalds/linux/blob/v5.17/Makefile#L1059





> > diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> > index eb541e730d3c..45a9caa37b4e 100644
> > --- a/arch/powerpc/Makefile
> > +++ b/arch/powerpc/Makefile
> > @@ -408,8 +408,7 @@ endef
> >
> >  PHONY += install
> >  install:
>
> I can't find a KBUILD_IMAGE definition in arch/powerpc/Makefile.
> Should it be set here as a target-specific varibable, too?


Right, powerpc does not define KBUILD_IMAGE explicitly.
It falls back to [3].






-- 
Best Regards
Masahiro Yamada
