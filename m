Return-Path: <linux-arch+bounces-7091-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A737696E6D4
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 02:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329F41F24626
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 00:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0544AD2FF;
	Fri,  6 Sep 2024 00:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOwVxMUD"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD53711CA0;
	Fri,  6 Sep 2024 00:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725582472; cv=none; b=H1Zlz56OMFhosKJRflU+IAjMOHLGWRAKlLjKpgJN4pJMQcyDm5jDDkmgB5LoTd38CUEdS2B+TQ3qgPsgfcTfobwyO9UnhZ0izL5ppBUqiBX75uUQOr28lcuqPPCjBHcyzGpsfQjARWOtqDOpxhKz5tqf47s6fG3ZVZ4EWjyacY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725582472; c=relaxed/simple;
	bh=K6wrMA4NMaFGP3Sp4vPuMOOJ9z42CsYsjU+yH0k9ZpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fPcebXaHVrWzJLv+seXy56sYciXc3bZ/sNxDsjIubeXhAnOMwLx5ckZ11R8uSAS20t4Q0rfzgXI/IFJaeASu4psk1fi5vGM6q0X5w3IT80cNpBWP466nrP76GlZyDFh/aCEA2JmAdIh7F+PfNHlJK/OZwhoNMJPdoXCqDLFlC0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOwVxMUD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0E1C4CEC3;
	Fri,  6 Sep 2024 00:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725582472;
	bh=K6wrMA4NMaFGP3Sp4vPuMOOJ9z42CsYsjU+yH0k9ZpI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rOwVxMUDAoXw5SklKVcoMdydUgoE4tk0T3VLu7rhVnOSII9MTQcVpt3Mq6X4bZb7v
	 kPPu+HWw2WxGF6UXBpC1fYcQJutF4XD3aOFuan5GSAy529cwBq5zVYnkR+4D5IKnOO
	 e9MkFI1cRjZ6hUGQyqoPDKY0lZYN6sc8x/WafGh1wdi1HeK6e7LjylwpwqyIXvG0kQ
	 6RVVoymO+D6WddBCPvgSzjuK609lqstj+BXismhUT9t4LjLH+N83RdD+7DM0sJckxD
	 S5+vrNVSBlDc23DA3kJYxXe44ac1DgPer1vZCDMOehUT7w7r4NZGHb405u28pWxdTX
	 6jYGs3ZXqn7kA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f3fea6a0a9so13492721fa.0;
        Thu, 05 Sep 2024 17:27:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUt8xl16IemRnq1Qbx5vm1/bL5WufGwQ7aEvbpCgx2SKbzWUlk1XHql9WnExx4oKQp/92naiPZrkLtl4w==@vger.kernel.org, AJvYcCVe7prjHu/DOJkKOQCqkHKAoBHIpxc98UA4f0PWlRAxkQZIdIIDdj5RIPXIp5udvvCLDNs169OhR/0fljbpZEw=@vger.kernel.org, AJvYcCVh4w85pFU+o5Ci/0/W93YzYCgygdzOp6Kjm0wdQicFJlMOwXahNLBOQSWk+aAYRnEd3OUHlADz1uK+@vger.kernel.org, AJvYcCWfDMwFf2ZAeJ48Hc7jmOD01/WYJ2Hxo8kmsuJynC7q3Bf3CYa/SYvZTf79cD4o7D9fkQZPJJLGi7t/8syc@vger.kernel.org, AJvYcCWwYARhhnWq17GGFnjgpDwccmPq/GlNlDS6J3pAk9jkiCrB8NFNkTl8YYEMq70WcGIxIcjRlmAGwN7g6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAzh53mDklLi6ijIq+3Tegk/ctDAyjsxseroSBMy9Q7e5vev8s
	V1jI+l+iig2D5O9svf5Zf+OLGICxn9yQf5kZPJD0Hkec81shcGt+k4JofAYPKNxHiMGxc8bPVZ1
	EC3Pw2V75sYJ7pszKd+QiLNTxe+I=
X-Google-Smtp-Source: AGHT+IECEJXsJFKh8FBdQC2eV1kk62AdTyv6v0z/HVmN55+fHGg4x6UhGG8hEo+Rv28CTDwPO53RFRQNS5OnAybvF2s=
X-Received: by 2002:a05:651c:545:b0:2f5:66a:627 with SMTP id
 38308e7fff4ca-2f657a9793emr24818091fa.0.1725582471070; Thu, 05 Sep 2024
 17:27:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904234803.698424-1-masahiroy@kernel.org> <20240904234803.698424-15-masahiroy@kernel.org>
 <20240905143850.GD1517132-robh@kernel.org>
In-Reply-To: <20240905143850.GD1517132-robh@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 6 Sep 2024 09:27:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNASbhsgMyo--WrvLaUyaJQdAFrpS48L_E=T1MVgvZhB4Bw@mail.gmail.com>
Message-ID: <CAK7LNASbhsgMyo--WrvLaUyaJQdAFrpS48L_E=T1MVgvZhB4Bw@mail.gmail.com>
Subject: Re: [PATCH 14/15] kbuild: rename CONFIG_GENERIC_BUILTIN_DTB to CONFIG_BUILTIN_DTB
To: Rob Herring <robh@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Michal Simek <monstr@monstr.eu>, devicetree@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 11:38=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Thu, Sep 05, 2024 at 08:47:50AM +0900, Masahiro Yamada wrote:
> > Now that all architectures have migrated to the generic built-in
> > DTB support, the GENERIC_ prefix is no longer necessary.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  Makefile                             | 2 +-
> >  arch/arc/Kconfig                     | 2 +-
> >  arch/loongarch/Kconfig               | 1 -
> >  arch/microblaze/Kconfig              | 2 +-
> >  arch/mips/Kconfig                    | 1 -
> >  arch/nios2/platform/Kconfig.platform | 1 -
> >  arch/openrisc/Kconfig                | 2 +-
> >  arch/riscv/Kconfig                   | 1 -
> >  arch/sh/Kconfig                      | 1 -
> >  arch/xtensa/Kconfig                  | 2 +-
> >  drivers/of/Kconfig                   | 2 +-
> >  scripts/Makefile.vmlinux             | 2 +-
> >  scripts/link-vmlinux.sh              | 2 +-
> >  13 files changed, 8 insertions(+), 13 deletions(-)
>
> > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > index e1d3e5fb6fd2..70f169210b52 100644
> > --- a/arch/loongarch/Kconfig
> > +++ b/arch/loongarch/Kconfig
> > @@ -388,7 +388,6 @@ endchoice
> >  config BUILTIN_DTB
> >       bool "Enable built-in dtb in kernel"
> >       depends on OF
> > -     select GENERIC_BUILTIN_DTB
> >       help
> >         Some existing systems do not provide a canonical device tree to
> >         the kernel at boot time. Let's provide a device tree table in t=
he
>
> > diff --git a/arch/nios2/platform/Kconfig.platform b/arch/nios2/platform=
/Kconfig.platform
> > index c75cadd92388..5f0cf551b5ca 100644
> > --- a/arch/nios2/platform/Kconfig.platform
> > +++ b/arch/nios2/platform/Kconfig.platform
> > @@ -38,7 +38,6 @@ config NIOS2_DTB_PHYS_ADDR
> >  config BUILTIN_DTB
> >       bool "Compile and link device tree into kernel image"
> >       depends on !COMPILE_TEST
> > -     select GENERIC_BUILTIN_DTB
>
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -1110,7 +1110,6 @@ config RISCV_ISA_FALLBACK
> >  config BUILTIN_DTB
> >       bool "Built-in device tree"
> >       depends on OF && NONPORTABLE
>
> Humm, maybe this NONPORTABLE option could be common and used to
> accomplish what I want here...



I do not know how this can prevent new architectures from enabling
BUILTIN_DTB.

New architectures can select BUILTIN_DTB together with NONPORTABLE.



> > -     select GENERIC_BUILTIN_DTB
>
> > diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> > index 3b772378773f..b09019cd87d4 100644
> > --- a/arch/sh/Kconfig
> > +++ b/arch/sh/Kconfig
> > @@ -648,7 +648,6 @@ config BUILTIN_DTB
> >       bool "Use builtin DTB"
> >       default n
> >       depends on SH_DEVICE_TREE
> > -     select GENERIC_BUILTIN_DTB
>
> > diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> > index 5142e7d7fef8..53a227ca3a3c 100644
> > --- a/drivers/of/Kconfig
> > +++ b/drivers/of/Kconfig
> > @@ -2,7 +2,7 @@
> >  config DTC
> >       bool
> >
> > -config GENERIC_BUILTIN_DTB
> > +config BUILTIN_DTB
> >       bool
>
> I'm confused. We can't have the same config option twice, can we?


We can.


Documentation/kbuild/kconfig-language.rst says:

  A config option can be defined multiple times with the same
  name, but every definition can have only a single input prompt and the
  type must not conflict.



--=20
Best Regards
Masahiro Yamada

