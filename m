Return-Path: <linux-arch+bounces-7093-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC9996E76A
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 03:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B348284AA1
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 01:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8E31D554;
	Fri,  6 Sep 2024 01:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="as6MXblP"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0647D1BDE6;
	Fri,  6 Sep 2024 01:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725587836; cv=none; b=puIb3ksZNQ0D/cB24JlYvEUp/t0G/VAvwkAqul/VBX2n2mBGX/nz1Mh2CGHhp2QxfNH153lCknJDWhObfvqMiSGhIwlmHf7/Zxjw1V2P8rzxHpaVZ4bEDAnkab/IqoQLaY67q2VFV9m6qVDxEzu4Jd+Y90k4MUqEYDbO0dLff/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725587836; c=relaxed/simple;
	bh=8GSouxZA15dzrjJlHlKZLXCIMbilzZC4xgwf3qtb3bE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=koMJfnEJqqiSl6JVy8d+kvF6i6dpan23RH3pJi5tZ5BBlo60fgZr8eJqb05LfzVIGyWf7TN0DUV/Cs37hBYYllZS99k/R663L01coQ2//ZMEJGTunUSXcdmFvffC83Cn9JpCkJKcOp5lHAjf+WMZju8yp+R6kKUt5UJVjdOGvbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=as6MXblP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8298CC4CEC5;
	Fri,  6 Sep 2024 01:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725587835;
	bh=8GSouxZA15dzrjJlHlKZLXCIMbilzZC4xgwf3qtb3bE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=as6MXblP0yNOMTRazIuivP5C+O+n+8YswubSIkUSW8DgCoMr8L1pcRGcUP3568lm+
	 a3X/gifiDx/o2kwjtcC+MhtkCsM0aXpYUIcAbfU+EednoSPbuFKmTXEHyS+EF61B3W
	 tFhjXrguURs2eDdL9daoche4qvwDCxGED9GOC9ULUCdffXbzFNtx7COa0r6joJ561I
	 wQNIIdqQ6Had7RDDPjofRp5qIqwthJe7jK/Nw1gFQAwem9ph9kFC4XkzhhcqM2iUdU
	 tXAWMtoCmaJEd0QcEQJAz5o10sbBqVBoi9ILhg6+NpZrWQLM2L4k7Bt9bDLyImvDo9
	 GrRZmZmGVJmJg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53436e04447so1264061e87.1;
        Thu, 05 Sep 2024 18:57:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWSr35u8+BxUQlRqR4VKJ5dyGmiSzqqhzbY0ggS4BupzQOjZHWPXgcumEqIbDqrGVFK4oR8rrUXR3lSg==@vger.kernel.org, AJvYcCUjwfyBcISTinXoip/y5RP9iQSGFoOgU1b5VUmU0QII1WhbBBd2lT0nhNC97R4B+tYLL8vKh5VC/w3O@vger.kernel.org, AJvYcCVQgXPdepP0OYOgBX90YFL/9qcYXlTr/7/zIwFHtg4Qna9jzgVQnoyNIxrdYW8aPmJoNbYSTXJfYPg1udMNERs=@vger.kernel.org, AJvYcCXSt6gyg4DCSwFjF3SGsDNX9vgStDibEKwVtgIE5Hei+SW0D2iiLkkpN42L3boP/ah+Qggu0cPts1hSFw==@vger.kernel.org, AJvYcCXlVb6JTIcFexEQvXJjhfkWNfe5A8jOcBtBZlukCZrGvn3flhTZbH5z39+h/Umk7zV5u+iM9NoupPFIR11+@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwr53nDmwpI0f2eZfiUwnGo5jzSvDToMCYXp09e/wxhXbqp9nv
	+DTehJ/xEMc8HGlaYX6us5H5LHcc0tFwYY+SB0dzlm95mv6GisRRGZ1bYBOMTiOKPNfCZLu79/a
	UlteuWSHSKCLpLxQBt6lYchxSDws=
X-Google-Smtp-Source: AGHT+IEyHAyF5odK5wNGdrU91US5ikWBw7iV5drivufpH4J1DDqUMcH1u85P5o28YcdYFP088Ih/883620s0jcsYKJA=
X-Received: by 2002:a05:6512:2806:b0:52f:1b08:d2d8 with SMTP id
 2adb3069b0e04-53657dbb114mr374742e87.7.1725587834140; Thu, 05 Sep 2024
 18:57:14 -0700 (PDT)
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
Date: Fri, 6 Sep 2024 10:56:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNASRtTDkVC7rBz6EEsu64LykMVRqyDODUCycGD1deLC9pw@mail.gmail.com>
Message-ID: <CAK7LNASRtTDkVC7rBz6EEsu64LykMVRqyDODUCycGD1deLC9pw@mail.gmail.com>
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


I learned CONFIG_ARM_APPENDED_DTB today.



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
>
> Yes, it's kind of odd since the arch selects the option...
>
> For sure, we don't want this option on arm64. For that, I can rely on
> Will and Catalin rejecting a select, but on some new arch I can't.
>
> > +
> > +config BUILTIN_DTB_ALL
> > +     bool
>
> Can this be limited to MIPS?


I am fine with hard-coded "depends on"
if this feature is discouraged.




> > +
> >  menuconfig OF
> >       bool "Device Tree and Open Firmware support"
> >       help
> > diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
> > index 5ceecbed31eb..4626b472da49 100644
> > --- a/scripts/Makefile.vmlinux
> > +++ b/scripts/Makefile.vmlinux
> > @@ -17,6 +17,50 @@ quiet_cmd_cc_o_c =3D CC      $@
> >  %.o: %.c FORCE
> >       $(call if_changed_dep,cc_o_c)
> >
> > +quiet_cmd_as_o_S =3D AS      $@
> > +      cmd_as_o_S =3D $(CC) $(a_flags) -c -o $@ $<
> > +
> > +%.o: %.S FORCE
> > +     $(call if_changed_dep,as_o_S)
> > +
> > +# Built-in dtb
> > +# --------------------------------------------------------------------=
-------
> > +
> > +quiet_cmd_wrap_dtbs =3D WRAP    $@
> > +      cmd_wrap_dtbs =3D {                                             =
         \
> > +     echo '\#include <asm-generic/vmlinux.lds.h>';                   \
> > +     echo '.section .dtb.init.rodata,"a"';                           \
> > +     while read dtb; do                                              \
> > +             symbase=3D__dtb_$$(basename -s .dtb "$${dtb}" | tr - _); =
 \
> > +             echo '.balign STRUCT_ALIGNMENT';                        \
>
> Is this always guaranteed to be at least 8 bytes? That's the required
> alignment for dtbs and assumed by libfdt.


I think so.


include/asm-generic/vmlinux.lds.h defines it as 32.


We can loosen the alignment to 8, but for safety,
I just copied this from scripts/Makefile.lib
because 32-byte alignment is what we do now.








--=20
Best Regards
Masahiro Yamada

