Return-Path: <linux-arch+bounces-1277-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235EC823F19
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jan 2024 10:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B435C286B1A
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jan 2024 09:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D305520B26;
	Thu,  4 Jan 2024 09:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHFkUtqf"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B610A20B23;
	Thu,  4 Jan 2024 09:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50045C433CA;
	Thu,  4 Jan 2024 09:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704362139;
	bh=NUKoeng2TtOuvmS1QuUleD7BGl+JqWw7EjY22X+zMeE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OHFkUtqftfj+SZv9SeaQruKnYEQ+cq+CUVLhdhS4ctC5mJde61oZpomnZp+ecLocl
	 edGdjmqnCNVqcSE+r/1BHCS9HtiWkfJlVSxkDAqPGjrXpj3m1RESX+i8Du30XCZhoc
	 Phx4BiVKMLfV6iWckC4A+sp0BbGfUzv2NrDh9iOsqfiDWgJJBXqcmWjicme7o2UqjD
	 OMdDO97BJHjpoD64eKNTbxVRZi2a6R+/ZwjD90Vah4KdwTLgLKFVkFiJMEVPIBQPIC
	 QoCG2KHOziSdqLfOlz01MyVVY2UGekeYO2k3gZN/0V0FQCNOuMwCjTEqTwRZOK3QMU
	 ZsLwm/ZTJ1jcQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-556c60c3f9aso432293a12.3;
        Thu, 04 Jan 2024 01:55:39 -0800 (PST)
X-Gm-Message-State: AOJu0YwnzEtFlm+7zeyQm3rr1xJIcSg6vl2DSTPACqRQXRZouJ25s4lr
	1l+9iGjjp2oAicDIe16TyX1okSWmGu7Gp6vEHV0=
X-Google-Smtp-Source: AGHT+IEKmcnwqgygVH9sZZQyzsnOvSR/gqjMEXN+FYG4pXKZGSTboqY34lxGfMFTo2QI4qDTuxyc5MRzDYiHeKc4cMU=
X-Received: by 2002:a17:906:a94:b0:a28:9633:d599 with SMTP id
 y20-20020a1709060a9400b00a289633d599mr160134ejf.18.1704362137704; Thu, 04 Jan
 2024 01:55:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228014220.3562640-1-samuel.holland@sifive.com> <20231228014220.3562640-8-samuel.holland@sifive.com>
In-Reply-To: <20231228014220.3562640-8-samuel.holland@sifive.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 4 Jan 2024 17:55:32 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5TJPqRcgS6jywWDSNsCvd-PsVacgxgoiF-fJ00ZnS4uA@mail.gmail.com>
Message-ID: <CAAhV-H5TJPqRcgS6jywWDSNsCvd-PsVacgxgoiF-fJ00ZnS4uA@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] LoongArch: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	x86@kernel.org, linux-riscv@lists.infradead.org, 
	Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, linux-arch@vger.kernel.org, 
	WANG Xuerui <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Samuel,

On Thu, Dec 28, 2023 at 9:42=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> LoongArch already provides kernel_fpu_begin() and kernel_fpu_end() in
> asm/fpu.h, so it only needs to add kernel_fpu_available() and export
> the CFLAGS adjustments.
>
> Acked-by: WANG Xuerui <git@xen0n.name>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> (no changes since v1)
>
>  arch/loongarch/Kconfig           | 1 +
>  arch/loongarch/Makefile          | 5 ++++-
>  arch/loongarch/include/asm/fpu.h | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index ee123820a476..65d4475565b8 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -15,6 +15,7 @@ config LOONGARCH
>         select ARCH_HAS_CPU_FINALIZE_INIT
>         select ARCH_HAS_FORTIFY_SOURCE
>         select ARCH_HAS_KCOV
> +       select ARCH_HAS_KERNEL_FPU_SUPPORT if CPU_HAS_FPU
>         select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
>         select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>         select ARCH_HAS_PTE_SPECIAL
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index 4ba8d67ddb09..1afe28feaba5 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -25,6 +25,9 @@ endif
>  32bit-emul             =3D elf32loongarch
>  64bit-emul             =3D elf64loongarch
>
> +CC_FLAGS_FPU           :=3D -mfpu=3D64
> +CC_FLAGS_NO_FPU                :=3D -msoft-float
We will add LoongArch32 support later, maybe it should be -mfpu=3D32 in
that case, and do other archs have the case that only support FP32?

Huacai

> +
>  ifdef CONFIG_DYNAMIC_FTRACE
>  KBUILD_CPPFLAGS +=3D -DCC_USING_PATCHABLE_FUNCTION_ENTRY
>  CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D2
> @@ -46,7 +49,7 @@ ld-emul                       =3D $(64bit-emul)
>  cflags-y               +=3D -mabi=3Dlp64s
>  endif
>
> -cflags-y                       +=3D -pipe -msoft-float
> +cflags-y                       +=3D -pipe $(CC_FLAGS_NO_FPU)
>  LDFLAGS_vmlinux                        +=3D -static -n -nostdlib
>
>  # When the assembler supports explicit relocation hint, we must use it.
> diff --git a/arch/loongarch/include/asm/fpu.h b/arch/loongarch/include/as=
m/fpu.h
> index c2d8962fda00..3177674228f8 100644
> --- a/arch/loongarch/include/asm/fpu.h
> +++ b/arch/loongarch/include/asm/fpu.h
> @@ -21,6 +21,7 @@
>
>  struct sigcontext;
>
> +#define kernel_fpu_available() cpu_has_fpu
>  extern void kernel_fpu_begin(void);
>  extern void kernel_fpu_end(void);
>
> --
> 2.42.0
>
>

