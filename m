Return-Path: <linux-arch+bounces-7172-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3358A972DC5
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 11:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A06AAB22A2E
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 09:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31D2188CD2;
	Tue, 10 Sep 2024 09:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAIFUnbk"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EAD188CB3;
	Tue, 10 Sep 2024 09:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960945; cv=none; b=rMpLiTimLmC27XYZC/7yZQfh3MvAU6lWQ7eRzMncxhBQ5T5vQjuZTi29Qwpa6bxXstm09azv8FKgj+SVdVlq1NTdFRoERglQbXFBGI6qQ8UXeoTUH/E9fNflLTYWsh/6pnrcYDRkYhRdCTASQpaeAn7FxZsiUqTEUl8wQ3N/IUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960945; c=relaxed/simple;
	bh=TBCYlvMv+CXUZRevJVyM0lQA/IZ4ZH4AmMprMHtYvlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CE/zUfMdhbvyJbO4z1aam/++cpBpVnOSixAaDyxdwcxsi6peIR3IzHQBNgK54UK0pYRvnqDghDSdx4kIJl6kbUIxhIvAUmFOR0B8KQ9c/GwMJBTaaXbWt2AvIrM86zgcKEAIbunU7icrt6OjtyflsnasGi3+9jNT0JWYhg7Xiv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAIFUnbk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25545C4CECF;
	Tue, 10 Sep 2024 09:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725960945;
	bh=TBCYlvMv+CXUZRevJVyM0lQA/IZ4ZH4AmMprMHtYvlw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AAIFUnbkEFTcQpSLieFiYjCtb2IxBMyXzOXGIdn9U2FRcJ8A+jQnl9/HvcZopeLrR
	 DYMRztJ3Gagf/QFSeAEGf1H6ytJhBqy8Cc+w8ioxpjas2VLD6v6a6StyiUQN6+ymaU
	 gACQTT5dM2T+6ejfsvw8ock+PQ4FueCsXFekx8kvxEN5ckO6VNrkYK4v4jT9PwQuYu
	 zAlwi4uBBYFi21BYgVSAkWFJQdhfgWpcvsL0/yYcfD0lGpru8VgYIplUM6mAFnB/Nu
	 CJPV2gtm35Uf3GxiJ2bNnSURUzKjpxH42jrbsmwLKTbjXx5qM4RPMebcz7djbUvYEu
	 FmjohxuyEBxjg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53653ff0251so6283157e87.0;
        Tue, 10 Sep 2024 02:35:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUpFodMlvYbrkbjCsJEwE7uImN746D4JfWAC3Hvempel1nPXnHEoJMuL+ae/O9190InGuQvImZ6pKlbvg==@vger.kernel.org, AJvYcCVuQP/FjPkOXPUi7bL2PEO0AYfKcTayy8+ZIKJa/2DpFgNlBeop4k+Bqg0F/RR2wAm+/9t5nJDq0OYW22aKskY=@vger.kernel.org, AJvYcCVwOrrvSXV2WgJ1qmrJtpAaXMNxKkejKMAVI2V8+4U9tJE/0Z+HiTLozLcs2+1RpA2sdN85NUROaRJx7w==@vger.kernel.org, AJvYcCVx+j71HJyeo5+E11gVBsCTG5h4JQWYopvl0IoxjkZWZcbnyYDp8EI6lIeBiOSpPSNXLvKX0g+0/nIGGqr8@vger.kernel.org, AJvYcCXtVeZWB1XCUuOLjoY5Egvmyf2JBL6n1AQCUGNF/jrpuVum0fVGVO1Z68OrH04TvMgVRn207iLAIIum@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6unjGZm4smkjzkkkWFr0bSRpx84Oa2aVcqTbXlhluxSc5I7NQ
	T4GtzaBimwUrcGuTzeWdA+I+CoiKjt+mFENldjOijLEdPmXjCIAL3brzEqabMjvs0ytMdCvi22r
	seWFLPv3DVO8aq9RZPEP9t40vThY=
X-Google-Smtp-Source: AGHT+IENtsmQg68T2Ng35CvFqHD8v1uFN5MIvWFG7psrbL/gymy/jagJsarSBmqhnENe7SHnrN02zL4FzfCwY+63Hyw=
X-Received: by 2002:a05:6512:2514:b0:536:5827:8778 with SMTP id
 2adb3069b0e04-536588130d9mr9715058e87.53.1725960943742; Tue, 10 Sep 2024
 02:35:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904234803.698424-1-masahiroy@kernel.org> <20240904234803.698424-5-masahiroy@kernel.org>
 <20240905141723.GC1517132-robh@kernel.org>
In-Reply-To: <20240905141723.GC1517132-robh@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 10 Sep 2024 18:35:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQnMn5fUbREnDx4XKVy9ssxVEaaZQsMtCb2a2KPZP=y=g@mail.gmail.com>
Message-ID: <CAK7LNAQnMn5fUbREnDx4XKVy9ssxVEaaZQsMtCb2a2KPZP=y=g@mail.gmail.com>
Subject: Re: [PATCH 04/15] kbuild: add generic support for built-in boot DTBs
To: Rob Herring <robh@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Michal Simek <monstr@monstr.eu>, devicetree@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 11:17=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Thu, Sep 05, 2024 at 08:47:40AM +0900, Masahiro Yamada wrote:
> > Some architectures embed boot DTBs in vmlinux. A potential issue for
> > these architectures is a race condition during parallel builds because
> > Kbuild descends into arch/*/boot/dts/ twice.
> >
> > One build thread is initiated by the 'dtbs' target, which is a
> > prerequisite of the 'all' target in the top-level Makefile:
> >
> >   ifdef CONFIG_OF_EARLY_FLATTREE
> >   all: dtbs
> >   endif
> >
> > For architectures that support the embedded boot dtb, arch/*/boot/dts/
> > is visited also during the ordinary directory traversal in order to
> > build obj-y objects that wrap DTBs.
> >
> > Since these build threads are unaware of each other, they can run
> > simultaneously during parallel builds.
> >
> > This commit introduces a generic build rule to scripts/Makefile.vmlinux
> > to support embedded boot DTBs in a race-free way. Architectures that
> > want to use this rule need to select CONFIG_GENERIC_BUILTIN_DTB.
> >
> > After the migration, Makefiles under arch/*/boot/dts/ will be visited
> > only once to build only *.dtb files.
> >
> > This change also aims to unify the CONFIG options used for embedded DTB=
s
> > support. Currently, different architectures use different CONFIG option=
s
> > for the same purposes.
> >
> > The CONFIG options are unified as follows:
> >
> >  - CONFIG_GENERIC_BUILTIN_DTB
> >
> >    This enables the generic rule for embedded boot DTBs. This will be
> >    renamed to CONFIG_BUILTIN_DTB after all architectures migrate to the
> >    generic rule.
> >
> >  - CONFIG_BUILTIN_DTB_NAME
> >
> >    This specifies the path to the embedded DTB.
> >    (relative to arch/*/boot/dts/)
> >
> >  - CONFIG_BUILTIN_DTB_ALL
> >
> >    If this is enabled, all DTB files compiled under arch/*/boot/dts/ ar=
e
> >    embedded into vmlinux. Only used by MIPS.
>
> I started to do this a long time ago, but then decided we didn't want to
> encourage this feature. IMO it should only be for legacy bootloaders or
> development/debug. And really, appended DTB is more flexible for the
> legacy bootloader case.
>
> In hindsight, a common config would have been easier to limit new
> arches...
>
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  Makefile                 |  7 ++++++-
> >  drivers/of/Kconfig       |  6 ++++++
> >  scripts/Makefile.vmlinux | 44 ++++++++++++++++++++++++++++++++++++++++
> >  scripts/link-vmlinux.sh  |  4 ++++
> >  4 files changed, 60 insertions(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 145112bf281a..1c765c12ab9e 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1417,6 +1417,10 @@ ifdef CONFIG_OF_EARLY_FLATTREE
> >  all: dtbs
> >  endif
> >
> > +ifdef CONFIG_GENERIC_BUILTIN_DTB
> > +vmlinux: dtbs
> > +endif
> > +
> >  endif
> >
> >  PHONY +=3D scripts_dtc
> > @@ -1483,7 +1487,8 @@ endif # CONFIG_MODULES
> >  CLEAN_FILES +=3D vmlinux.symvers modules-only.symvers \
> >              modules.builtin modules.builtin.modinfo modules.nsdeps \
> >              compile_commands.json rust/test \
> > -            rust-project.json .vmlinux.objs .vmlinux.export.c
> > +            rust-project.json .vmlinux.objs .vmlinux.export.c \
> > +               .builtin-dtbs-list .builtin-dtb.S
> >
> >  # Directories & files removed with 'make mrproper'
> >  MRPROPER_FILES +=3D include/config include/generated          \
> > diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> > index dd726c7056bf..5142e7d7fef8 100644
> > --- a/drivers/of/Kconfig
> > +++ b/drivers/of/Kconfig
> > @@ -2,6 +2,12 @@
> >  config DTC
> >       bool
> >
> > +config GENERIC_BUILTIN_DTB
> > +     bool
>
> So that we don't add new architectures to this, I would like something
> like:
>
> # Do not add new architectures to this list
> depends on MIPS || RISCV || MICROBLAZE ...


This will not work after 14/15 is applied.


For example, if arch/arm/Kconfig has


config BUILTIN_DTB
      bool "enable BUILTIN_DTB"


No warning is displayed.




--=20
Best Regards
Masahiro Yamada

