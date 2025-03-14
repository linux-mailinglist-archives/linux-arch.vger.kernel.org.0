Return-Path: <linux-arch+bounces-10805-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41808A60B76
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 09:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D971748DF
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 08:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB66A1A9B2C;
	Fri, 14 Mar 2025 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IopvT0Fg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A657C1A3AB8
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 08:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940910; cv=none; b=IQTy6GKS3hqf2SO27OjL26aBv1QnVj2SVMd0G5aIK4XX+TXkOGfGzAOIztG184gnOh/VlA/21izzBCLXu3J/gb101sle/4DcGuFvR3JgLdSsKYetJbwyxWJsnnn2XeEN6K8jbE3hdElFBqcT6hiKrJJ1E8wCO8S2SgSDCCQuqf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940910; c=relaxed/simple;
	bh=7uofjIIGoCDldE/Obw0jtasiP0UD1fVzTxdYVV5y7p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IiZrxfpILfHxHnqJzsSR9/r7K1Zl9+rDtVuyYk2EcaOT7DLzjiKLMI95g8r8FJSriyfb1iQ+jPdHWOsUywDlJBFlRj+Bd23H/9IExA1xFQrg8rGLmxKiUOWMVi530wI3q6z3MQ3I2eXBVHnI++KWqQAvDLIHMtlmEqQRMPP9gJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=IopvT0Fg; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-854a68f5a9cso133786239f.0
        for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 01:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741940908; x=1742545708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfQM28N9JPXsaVfg+1fZcj0o7z6iPxTVilM1OHygPAA=;
        b=IopvT0FgvxMwyhKnd8H0/5HP6O94kEZsMEBcmvACN4Fizcgcgt8gbikQrlsNOuShDz
         6tkOTFikiWaWqh07BiL0F42bjJS3oEiABEI4fGS+GVYXPxHbrsuuH8bwO2msMdLMPXV6
         rUkWAev2HUufRrsccxgGpBKsXHEE6YNf+GXeJYNcW01jwdCUy7Duk8+XUAlkPMsGnp9O
         hFwjpVoPc02hf6kgukz9ADZeIQFVHTmFo474vKUZ8lw0Mc/I07oxWrbq5NgCBJYhI58C
         VSQM4hhrIqGwIP74+Qzca6NYYq8JrtBlZEisLPNnK+LpFn/OZb5mP+Y+RXCoB0W0xu1C
         lgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741940908; x=1742545708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfQM28N9JPXsaVfg+1fZcj0o7z6iPxTVilM1OHygPAA=;
        b=uWN00L2FB5k/4qZqX3mKix9NcqmJLaHcVuOMvxQYmUvhj07Y+08Ao2Ocgf05cInYLe
         zeqv7/brson3xnMuxrmKRwFmMrHeb9MlDRJrNKwUAGRoUm4Zw5PRVcfHugKk8NgrRxao
         mjidpHfHJF3UXkBntm51nvxV+wIyHIk+d+R8neZrSxEA6BQap20e6yW8IV8OjC/B6eKt
         /AIp76p642yPw74e2eXMMfWenWfJB0cf2Zatf93+7I399SAiOJYhdZIq0+lQjYhDgM8n
         8hWxxXEWHNQ4zkxSOVICuWVCLebmTJVQ5pbGzpJyMIdvHX6eeyxgJfWWqaesNzPYdLja
         SORg==
X-Forwarded-Encrypted: i=1; AJvYcCXw3gqgP1mje+0ONxxxAQfRS0N++WX0uH7yEQwg6X5IMK/4baQKbyckf/sqQw3R+GSO3jMZpF9+M+0P@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1NQsV/dX447dvWdzLf/3A97M28YQIUxFXeKkGSQATYAJsSkL9
	dqWIFF3BSu46BILNjAxCixZodUAHVKHMZTvYcLbSrUnd0vywerk1MiV8vTW0z8xLHUriRTIOIZz
	9zmofGJD3KqnG0CQG+H3knojX9S+LDFn1++nFXg==
X-Gm-Gg: ASbGncs0aZGdGmIi/1pDI47ENPi+E0afzdiQ37F9RYJrfdzB2NtqMa76+D6era8upLG
	iq+nLF72Y7Hhec9mh8rTLArm3oAcBeRn8uLPfYerqO1iI8+wQsHaWP+5n+mxco/nBhpi8eWPhLr
	2wNx7CEvvSSAuPp2p01XKIjF6cfozTz/vIfH/lOw==
X-Google-Smtp-Source: AGHT+IEus2eidY5ho/u8kwK0lJdtjoMJ6hhBelcGc2gZ6mBgkM87bHEv8OtdPq4kzNbtkzqAYGzl75buC/L6OC0Zx7w=
X-Received: by 2002:a05:6e02:338b:b0:3d4:3fed:81f7 with SMTP id
 e9e14a558f8ab-3d483a76c70mr14609815ab.19.1741940907731; Fri, 14 Mar 2025
 01:28:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com> <20250310-v5_user_cfi_series-v11-5-86b36cbfb910@rivosinc.com>
In-Reply-To: <20250310-v5_user_cfi_series-v11-5-86b36cbfb910@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 14 Mar 2025 16:28:16 +0800
X-Gm-Features: AQ5f1JpDAK-Wh3zbs_fniZz3O3lKSiSx95v5vbF1bDBIyMbqDELLA2snuSUHWWE
Message-ID: <CANXhq0pdUPu4eDSJDGpjz804hY3ZsjLCOvyTuKDYajqzT0Xw+w@mail.gmail.com>
Subject: Re: [PATCH v11 05/27] riscv: usercfi state for task and save/restore
 of CSR_SSP on trap entry/exit
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
	richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
	kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
	evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 11:42=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> =
wrote:
>
> Carves out space in arch specific thread struct for cfi status and shadow
> stack in usermode on riscv.
>
> This patch does following
> - defines a new structure cfi_status with status bit for cfi feature
> - defines shadow stack pointer, base and size in cfi_status structure
> - defines offsets to new member fields in thread in asm-offsets.c
> - Saves and restore shadow stack pointer on trap entry (U --> S) and exit
>   (S --> U)
>
> Shadow stack save/restore is gated on feature availiblity and implemented
> using alternative. CSR can be context switched in `switch_to` as well but
> soon as kernel shadow stack support gets rolled in, shadow stack pointer
> will need to be switched at trap entry/exit point (much like `sp`). It ca=
n
> be argued that kernel using shadow stack deployment scenario may not be a=
s
> prevalant as user mode using this feature. But even if there is some
> minimal deployment of kernel shadow stack, that means that it needs to be
> supported. And thus save/restore of shadow stack pointer in entry.S inste=
ad
> of in `switch_to.h`.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/include/asm/processor.h   |  1 +
>  arch/riscv/include/asm/thread_info.h |  3 +++
>  arch/riscv/include/asm/usercfi.h     | 24 ++++++++++++++++++++++++
>  arch/riscv/kernel/asm-offsets.c      |  4 ++++
>  arch/riscv/kernel/entry.S            | 26 ++++++++++++++++++++++++++
>  5 files changed, 58 insertions(+)
>
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/=
processor.h
> index e3aba3336e63..d851bb5c6da0 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -14,6 +14,7 @@
>
>  #include <asm/ptrace.h>
>  #include <asm/hwcap.h>
> +#include <asm/usercfi.h>
>
>  #define arch_get_mmap_end(addr, len, flags)                    \
>  ({                                                             \
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/as=
m/thread_info.h
> index f5916a70879a..a0cfe00c2ca6 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -62,6 +62,9 @@ struct thread_info {
>         long                    user_sp;        /* User stack pointer */
>         int                     cpu;
>         unsigned long           syscall_work;   /* SYSCALL_WORK_ flags */
> +#ifdef CONFIG_RISCV_USER_CFI
> +       struct cfi_status       user_cfi_state;
> +#endif
>  #ifdef CONFIG_SHADOW_CALL_STACK
>         void                    *scs_base;
>         void                    *scs_sp;
> diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/us=
ercfi.h
> new file mode 100644
> index 000000000000..5f2027c51917
> --- /dev/null
> +++ b/arch/riscv/include/asm/usercfi.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + * Copyright (C) 2024 Rivos, Inc.
> + * Deepak Gupta <debug@rivosinc.com>
> + */
> +#ifndef _ASM_RISCV_USERCFI_H
> +#define _ASM_RISCV_USERCFI_H
> +
> +#ifndef __ASSEMBLY__
> +#include <linux/types.h>
> +
> +#ifdef CONFIG_RISCV_USER_CFI
> +struct cfi_status {
> +       unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
> +       unsigned long rsvd : ((sizeof(unsigned long) * 8) - 1);
> +       unsigned long user_shdw_stk; /* Current user shadow stack pointer=
 */
> +       unsigned long shdw_stk_base; /* Base address of shadow stack */
> +       unsigned long shdw_stk_size; /* size of shadow stack */
> +};
> +
> +#endif /* CONFIG_RISCV_USER_CFI */
> +
> +#endif /* __ASSEMBLY__ */
> +
> +#endif /* _ASM_RISCV_USERCFI_H */
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offs=
ets.c
> index e89455a6a0e5..0c188aaf3925 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -50,6 +50,10 @@ void asm_offsets(void)
>  #endif
>
>         OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
> +#ifdef CONFIG_RISCV_USER_CFI
> +       OFFSET(TASK_TI_CFI_STATUS, task_struct, thread_info.user_cfi_stat=
e);
> +       OFFSET(TASK_TI_USER_SSP, task_struct, thread_info.user_cfi_state.=
user_shdw_stk);
> +#endif
>         OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
>         OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
>         OFFSET(TASK_THREAD_F2,  task_struct, thread.fstate.f[2]);
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 33a5a9f2a0d4..68c99124ea55 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -147,6 +147,20 @@ SYM_CODE_START(handle_exception)
>
>         REG_L s0, TASK_TI_USER_SP(tp)
>         csrrc s1, CSR_STATUS, t0
> +       /*
> +        * If previous mode was U, capture shadow stack pointer and save =
it away
> +        * Zero CSR_SSP at the same time for sanitization.
> +        */
> +       ALTERNATIVE("nop; nop; nop; nop",
> +                               __stringify(                    \
> +                               andi s2, s1, SR_SPP;    \
> +                               bnez s2, skip_ssp_save; \
> +                               csrrw s2, CSR_SSP, x0;  \
> +                               REG_S s2, TASK_TI_USER_SSP(tp); \
> +                               skip_ssp_save:),
> +                               0,
> +                               RISCV_ISA_EXT_ZICFISS,
> +                               CONFIG_RISCV_USER_CFI)
>         csrr s2, CSR_EPC
>         csrr s3, CSR_TVAL
>         csrr s4, CSR_CAUSE
> @@ -236,6 +250,18 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
>          * structures again.
>          */
>         csrw CSR_SCRATCH, tp
> +
> +       /*
> +        * Going back to U mode, restore shadow stack pointer
> +        */
> +       ALTERNATIVE("nop; nop",
> +                               __stringify(                             =
       \
> +                               REG_L s3, TASK_TI_USER_SSP(tp); \
> +                               csrw CSR_SSP, s3),
> +                               0,
> +                               RISCV_ISA_EXT_ZICFISS,
> +                               CONFIG_RISCV_USER_CFI)
> +
>  1:
>  #ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
>         move a0, sp
>

LGTM.

Reviewed-by: Zong Li <zong.li@sifive.com>

> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

