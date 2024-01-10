Return-Path: <linux-arch+bounces-1327-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42793829CD2
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jan 2024 15:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFE44282A8C
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jan 2024 14:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDB04B5DD;
	Wed, 10 Jan 2024 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="fRTmRw2B"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A9D4BA8B
	for <linux-arch@vger.kernel.org>; Wed, 10 Jan 2024 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7bb0af58134so196510339f.3
        for <linux-arch@vger.kernel.org>; Wed, 10 Jan 2024 06:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1704898299; x=1705503099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UlRr87AfARWxTIrPYo3v1voc73TzaNkp96EPHRmj2xU=;
        b=fRTmRw2Bt8UXdAznfySY7lFa9+F/xQH/4rfMflS72/RXhfqFE18/JorLqBFpYHWJWu
         aadrKwKMs/YFbwuX4fVOhvCucNAt7c5NRVHg2/XX2Stgorfc1IlI7tSES8mteQMGmipr
         XdQJltJtf3z0W2Ks0xKn+Hc8g+xIeVxZNV0hjFTloYSoWUOzI9losM33oepGWKw8ymmx
         xhcdVdlmzx9OE0I6DxlB+Zn6ekO8aHvsRNlIS9P5FHzIfQtGencnpvHbIsPTsYqnqRx7
         N0pVyxkXclrCrZ/mqPxYAd446553dkeALTog6c2Y0ZrvHhuZwJJhT2s4fKFSh5l9VLoh
         wLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704898299; x=1705503099;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlRr87AfARWxTIrPYo3v1voc73TzaNkp96EPHRmj2xU=;
        b=msP/McYkQa7B6LNU4Ps2qTIO+tsiH9n0wJPtHapMkyTTmXMn7sXm2OrIIhjO0Ntnqr
         Lt7K5vul6Ngss3avN85Rg1FcYUaSP6IpYCtsBzKALNnvx87bycjSIFiJ99GqspfsXh1Z
         tr6vk5PqHmiuP1ka/Nl5ywyN0CbRTSjlaihCVc+6MCqOLq1S1OaSFfvYVyfE1tO9m0hc
         6SIE6+VuV1ixO09O6dbSe+TDTwWHR17lfW7PcAz4XlHxqy+jDeNzri4fzBTDZGAbiiKL
         X5U052axvXlvx3vmHaXqxtn00yquZhT47BoH/w9kzZBzi5LcU1EnWGs+LdBFrYU7hK2c
         t4CA==
X-Gm-Message-State: AOJu0Yz4daAzwMzUvBJAXRd5ahw8fVYBp2nrT/JiR9pLp5vWBAephP7B
	kKfhbC2+QJxhVLQ/ysT6EGU1z5Y1Y2LdTg==
X-Google-Smtp-Source: AGHT+IESMcbobMlRjbgJYfocjXsZ0yo/qo6i1dK8eo1VFgWRNLIDb9r8HTjU5OKJKjNYljfVT1tLPg==
X-Received: by 2002:a05:6602:131d:b0:7bc:838:6665 with SMTP id h29-20020a056602131d00b007bc08386665mr986219iov.28.1704898299159;
        Wed, 10 Jan 2024 06:51:39 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id k12-20020a02c64c000000b0046e304dc641sm1319869jan.95.2024.01.10.06.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 06:51:38 -0800 (PST)
Date: Wed, 10 Jan 2024 06:51:38 -0800 (PST)
X-Google-Original-Date: Wed, 10 Jan 2024 06:51:33 PST (-0800)
Subject:     Re: [PATCH v2 10/14] riscv: Add support for kernel-mode FPU
In-Reply-To: <20231228014220.3562640-11-samuel.holland@sifive.com>
CC: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
  x86@kernel.org, linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
  loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
  linux-arch@vger.kernel.org, samuel.holland@sifive.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: samuel.holland@sifive.com
Message-ID: <mhng-3e4b97f6-8310-487e-9f9a-1d19d6e42a1e@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 27 Dec 2023 17:42:00 PST (-0800), samuel.holland@sifive.com wrote:
> This is motivated by the amdgpu DRM driver, which needs floating-point
> code to support recent hardware. That code is not performance-critical,
> so only provide a minimal non-preemptible implementation for now.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> Changes in v2:
>  - Remove RISC-V architecture-specific preprocessor check
>
>  arch/riscv/Kconfig                  |  1 +
>  arch/riscv/Makefile                 |  3 +++
>  arch/riscv/include/asm/fpu.h        | 16 ++++++++++++++++
>  arch/riscv/kernel/Makefile          |  1 +
>  arch/riscv/kernel/kernel_mode_fpu.c | 28 ++++++++++++++++++++++++++++
>  5 files changed, 49 insertions(+)
>  create mode 100644 arch/riscv/include/asm/fpu.h
>  create mode 100644 arch/riscv/kernel/kernel_mode_fpu.c
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 24c1799e2ec4..4d4d1d64ce34 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -27,6 +27,7 @@ config RISCV
>  	select ARCH_HAS_GCOV_PROFILE_ALL
>  	select ARCH_HAS_GIGANTIC_PAGE
>  	select ARCH_HAS_KCOV
> +	select ARCH_HAS_KERNEL_FPU_SUPPORT if FPU
>  	select ARCH_HAS_MMIOWB
>  	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>  	select ARCH_HAS_PMEM_API
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index a74be78678eb..2e719c369210 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -81,6 +81,9 @@ KBUILD_CFLAGS += -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64i
>
>  KBUILD_AFLAGS += -march=$(riscv-march-y)
>
> +# For C code built with floating-point support, exclude V but keep F and D.
> +CC_FLAGS_FPU  := -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)([^v_]*)v?/\1\2/')
> +
>  KBUILD_CFLAGS += -mno-save-restore
>  KBUILD_CFLAGS += -DCONFIG_PAGE_OFFSET=$(CONFIG_PAGE_OFFSET)
>
> diff --git a/arch/riscv/include/asm/fpu.h b/arch/riscv/include/asm/fpu.h
> new file mode 100644
> index 000000000000..91c04c244e12
> --- /dev/null
> +++ b/arch/riscv/include/asm/fpu.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2023 SiFive
> + */
> +
> +#ifndef _ASM_RISCV_FPU_H
> +#define _ASM_RISCV_FPU_H
> +
> +#include <asm/switch_to.h>
> +
> +#define kernel_fpu_available()	has_fpu()
> +
> +void kernel_fpu_begin(void);
> +void kernel_fpu_end(void);
> +
> +#endif /* ! _ASM_RISCV_FPU_H */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index fee22a3d1b53..662c483e338d 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -62,6 +62,7 @@ obj-$(CONFIG_MMU) += vdso.o vdso/
>
>  obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
>  obj-$(CONFIG_FPU)		+= fpu.o
> +obj-$(CONFIG_FPU)		+= kernel_mode_fpu.o
>  obj-$(CONFIG_RISCV_ISA_V)	+= vector.o
>  obj-$(CONFIG_SMP)		+= smpboot.o
>  obj-$(CONFIG_SMP)		+= smp.o
> diff --git a/arch/riscv/kernel/kernel_mode_fpu.c b/arch/riscv/kernel/kernel_mode_fpu.c
> new file mode 100644
> index 000000000000..0ac8348876c4
> --- /dev/null
> +++ b/arch/riscv/kernel/kernel_mode_fpu.c
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 SiFive
> + */
> +
> +#include <linux/export.h>
> +#include <linux/preempt.h>
> +
> +#include <asm/csr.h>
> +#include <asm/fpu.h>
> +#include <asm/processor.h>
> +#include <asm/switch_to.h>
> +
> +void kernel_fpu_begin(void)
> +{
> +	preempt_disable();
> +	fstate_save(current, task_pt_regs(current));
> +	csr_set(CSR_SSTATUS, SR_FS);
> +}
> +EXPORT_SYMBOL_GPL(kernel_fpu_begin);
> +
> +void kernel_fpu_end(void)
> +{
> +	csr_clear(CSR_SSTATUS, SR_FS);
> +	fstate_restore(current, task_pt_regs(current));
> +	preempt_enable();
> +}
> +EXPORT_SYMBOL_GPL(kernel_fpu_end);

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

assuming you want to keep these together -- it touches a lot of stuff, 
so LMK if you want me to pick something up.

Thanks!

