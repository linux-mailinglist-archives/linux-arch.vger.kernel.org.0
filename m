Return-Path: <linux-arch+bounces-1288-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14668262B3
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jan 2024 03:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5779EB21C9A
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jan 2024 02:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178FB6FCA;
	Sun,  7 Jan 2024 02:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/2dWfbs"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCBC10A09;
	Sun,  7 Jan 2024 02:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96776C43391;
	Sun,  7 Jan 2024 02:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704595156;
	bh=jJbJktSdzhdzV2bS3gu5EK0DeDy7WfVB0EYasXcaPjw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G/2dWfbsLN9WwONooqF8NP5eFXFFOXQ5R6pDJXrL/Xza8jKUMjyzLISO/JNRMvYNn
	 ebjH0gTMb0U4Prs0XDY60enG/LtvrGLzWjVf7Zzw8H2mYYP9S0qsp8K7Ce6UKsNFDs
	 luwaMAnTvjVJM9HUnldij5bMjLFAarf4NscxczzeoYtSCV5eoStKqOMNDLTmu19xze
	 aMrbfKIfNiIj8X1DZgs468Zb9C+7WcgK9ZNAOjucthSo1/0cLBg7F7C6N6JPLcTfxU
	 QUG04tPdXEPjgcJtJhrAkM9utpizPYOwvU0ipsvKaL5YnYtdbnpOYvyKg5CDhYcl0N
	 TIVY824fazJig==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e7ddd999bso811323e87.1;
        Sat, 06 Jan 2024 18:39:16 -0800 (PST)
X-Gm-Message-State: AOJu0Yy96k41kceJPCsSIyZPM+RKCzXsHH71vve1M9AgREVKm5BusafQ
	Me2Uwvsaza0FtiYLDaTXVcKeptmSTrkC25Zp/qc=
X-Google-Smtp-Source: AGHT+IE666iz2mwVRCBnzGP5r7CatHWfsTic6W1ztccc+lpU8OH145j+/Z8tY3bo1scDBlBwbi74pfIJZJaXjjloGT8=
X-Received: by 2002:a05:6512:3a82:b0:50e:8ead:3889 with SMTP id
 q2-20020a0565123a8200b0050e8ead3889mr731610lfu.75.1704595154779; Sat, 06 Jan
 2024 18:39:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228014220.3562640-1-samuel.holland@sifive.com>
 <20231228014220.3562640-8-samuel.holland@sifive.com> <CAAhV-H5TJPqRcgS6jywWDSNsCvd-PsVacgxgoiF-fJ00ZnS4uA@mail.gmail.com>
 <84389bc3-f2e7-49c5-a820-de60ee00f8a7@sifive.com>
In-Reply-To: <84389bc3-f2e7-49c5-a820-de60ee00f8a7@sifive.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 7 Jan 2024 10:39:07 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4JxP-j5A7KuNSBncZkHF9i3O1njCtMjVkd3=RNbE5Q7w@mail.gmail.com>
Message-ID: <CAAhV-H4JxP-j5A7KuNSBncZkHF9i3O1njCtMjVkd3=RNbE5Q7w@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] LoongArch: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	x86@kernel.org, linux-riscv@lists.infradead.org, 
	Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, linux-arch@vger.kernel.org, 
	WANG Xuerui <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 11:58=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Huacai,
>
> On 2024-01-04 3:55 AM, Huacai Chen wrote:
> > Hi, Samuel,
> >
> > On Thu, Dec 28, 2023 at 9:42=E2=80=AFAM Samuel Holland
> > <samuel.holland@sifive.com> wrote:
> >>
> >> LoongArch already provides kernel_fpu_begin() and kernel_fpu_end() in
> >> asm/fpu.h, so it only needs to add kernel_fpu_available() and export
> >> the CFLAGS adjustments.
> >>
> >> Acked-by: WANG Xuerui <git@xen0n.name>
> >> Reviewed-by: Christoph Hellwig <hch@lst.de>
> >> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> >> ---
> >>
> >> (no changes since v1)
> >>
> >>  arch/loongarch/Kconfig           | 1 +
> >>  arch/loongarch/Makefile          | 5 ++++-
> >>  arch/loongarch/include/asm/fpu.h | 1 +
> >>  3 files changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> >> index ee123820a476..65d4475565b8 100644
> >> --- a/arch/loongarch/Kconfig
> >> +++ b/arch/loongarch/Kconfig
> >> @@ -15,6 +15,7 @@ config LOONGARCH
> >>         select ARCH_HAS_CPU_FINALIZE_INIT
> >>         select ARCH_HAS_FORTIFY_SOURCE
> >>         select ARCH_HAS_KCOV
> >> +       select ARCH_HAS_KERNEL_FPU_SUPPORT if CPU_HAS_FPU
> >>         select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
> >>         select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
> >>         select ARCH_HAS_PTE_SPECIAL
> >> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> >> index 4ba8d67ddb09..1afe28feaba5 100644
> >> --- a/arch/loongarch/Makefile
> >> +++ b/arch/loongarch/Makefile
> >> @@ -25,6 +25,9 @@ endif
> >>  32bit-emul             =3D elf32loongarch
> >>  64bit-emul             =3D elf64loongarch
> >>
> >> +CC_FLAGS_FPU           :=3D -mfpu=3D64
> >> +CC_FLAGS_NO_FPU                :=3D -msoft-float
> > We will add LoongArch32 support later, maybe it should be -mfpu=3D32 in
> > that case, and do other archs have the case that only support FP32?
>
> Do you mean that LoongArch32 does not support double-precision FP in hard=
ware?
> At least both of the consumers in this series use double-precision, so my=
 first
> thought is that LoongArch32 could not select ARCH_HAS_KERNEL_FPU_SUPPORT.
Then is it possible to introduce CC_FLAGS_SP_FPU and CC_FLAGS_DP_FPU?
I think there may be some place where SP FP is enough.

Huacai

>
> Regards,
> Samuel
>

