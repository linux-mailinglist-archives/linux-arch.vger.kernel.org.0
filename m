Return-Path: <linux-arch+bounces-10815-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F508A60BB6
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 09:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA4DF19C31E6
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 08:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3315B176AA1;
	Fri, 14 Mar 2025 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UodJk+DL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA6B18A6B2
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741941202; cv=none; b=faksNjHNHpVMN0M80UDTBmXMiCj8n8thQFJJgcMED2ESiS1G2XMUste0eYyHXT7mJmIMEj+mQCDUbkBG4qNZxfE5ja2Av7iAAhPIUl45D2govjnN9sJ5RFxsS0xHDMJLeqgcyeP1PvBdJKN5lqMozd/zblyVGM1Q98/QJ1WBKpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741941202; c=relaxed/simple;
	bh=KdUGoArpkJRkOaCc6KxjKNprdUz8mvS+VZ7WMx+MGU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HtN7ShYijGB2OLq1WEk+APoQOynHQSTNpRNgt5xwatZ2xKm8+egkGvEFRyexNlHZodBKLX0+hpGDfQXc+BIyWYAL4S5WD5ogtAk7WAN1TH4A09O+eCXlKh0RXKr14Vu1avJHvN20qTspHHXMUgSaWY+z9tkZSLUBjBzqz3mfkhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=UodJk+DL; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3cf8e017abcso7503215ab.1
        for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 01:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741941199; x=1742545999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZ6FuxCD5VQCRHQX3CMFDucd83uwpV785bHCUjNT0V8=;
        b=UodJk+DLtsTQqQuayseDqbnBxAKNX2HlCe/tdHIc20betiZF+u7IrfMEi589b4bIpi
         9EBP0bVaBGrjtltiDZmXbngHuHobRfGn10MQ0VoSYrwT1rD2icReJ18KcKv7HOUM1MHX
         js+SQvSGbgNHxizfCxAUgGc9uRCxaf6wRWXUDpIkDm23Z+20pRiqzRDFs/CpI4tchdX5
         HEwECW7X3+MPTwEKEELtke6Vbqc0DGsf/OduhuLq12pxyaIDy+JIdomVepEotcQ0KDVd
         qoNN7jynuBJNLz3SA8VK+xySgPhLECPBgqWb/0eiJv/QooA3zeTC2VvGwaIiyWLhh8Mg
         OLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741941199; x=1742545999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZ6FuxCD5VQCRHQX3CMFDucd83uwpV785bHCUjNT0V8=;
        b=G5ejDm/g/j2XOb+mjnEswSX83P8h8HwYBdeqBSNEbUYkx6dFgU+S39o6xC9aMBdPdM
         +lcNzwyyMljem1TSt0IP05H8beIxeXHoxeHRjtPJf8EcqujEM07b+1S+UGz38H4B+L9G
         +rAoKxjnx+Qj1Z3tWaE16t3lfeHhtVKQRS7A43I+A81E+CLOI57qrj57xHmPSUTVyWMk
         p9kE6eYzEvMFU+RPV818R7nGFNncH+bxqSYCQeZUaEQLvjQ5jfwnE8Qpc4eaYk7kDZtV
         o30UiRk9AFQeFQ+2TJxXgPbfrpxC7PE7m6XJkRYFOBLxSA6tT5wEoDdfWTPrGGTojkPR
         fFnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS9vIYiXfiwg5gptjZ5RlrCdgOIpHKwREl0luoocVlH4AFIF1cO7+/a7Dxn/8ev5vxjdmgEf4XRh4L@vger.kernel.org
X-Gm-Message-State: AOJu0YyOp2tkI3Wdqcr6nHXwQHJZ8u/PVg6mb7CI7QgDodSTzhXYz2Xd
	WNvkRnMUWpNUdEujPq3YjibxwySqCsug2wO8e18i1hG+NhOOQMSQAYZFxxiPdmWA1wBW4ZV52Jb
	aJIby67IhhaAxXm+e3SGY1U+1mmyrBKFhBlF7ZA==
X-Gm-Gg: ASbGnctuRuYWf64bpBS4tyEl7LYEg+xsRFl6E6jUWOtYBhFTypzKR1G98+IocsM4wJ+
	uT1VLypsxbOm/LxeoUJDmkYjAbXkWxMjH5zvynlAH8ZL/7SRZkqdgfpQQphWYVw4ybB6LV/JIMx
	BojnRm4iqM+zXYBwWgRtWb0IZC+RY=
X-Google-Smtp-Source: AGHT+IEpjn4sO807Vp20+x53G/QOr0uFP8XMrOnpLUB7Nd0kqwhiUZDXFX7IBtCy0L3k8Bc72TnDTAm7aisZ3g/OHoQ=
X-Received: by 2002:a05:6e02:3285:b0:3d0:bd5:b863 with SMTP id
 e9e14a558f8ab-3d483a82c1amr15625505ab.20.1741941199592; Fri, 14 Mar 2025
 01:33:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com> <20250310-v5_user_cfi_series-v11-21-86b36cbfb910@rivosinc.com>
In-Reply-To: <20250310-v5_user_cfi_series-v11-21-86b36cbfb910@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 14 Mar 2025 16:33:07 +0800
X-Gm-Features: AQ5f1JogaNhvTzIi-JULlyOhpNHglIVqmb85QzpCgn3yIvu9uGDNtiVJw3WLZ4A
Message-ID: <CANXhq0pynCvJ5bmPErTGiiO3-d0iXX8KyMZUFOH_tO7AYyytkw@mail.gmail.com>
Subject: Re: [PATCH v11 21/27] riscv: enable kernel access to shadow stack
 memory via FWFT sbi call
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

On Mon, Mar 10, 2025 at 11:44=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> =
wrote:
>
> Kernel will have to perform shadow stack operations on user shadow stack.
> Like during signal delivery and sigreturn, shadow stack token must be
> created and validated respectively. Thus shadow stack access for kernel
> must be enabled.
>
> In future when kernel shadow stacks are enabled for linux kernel, it must
> be enabled as early as possible for better coverage and prevent imbalance
> between regular stack and shadow stack. After `relocate_enable_mmu` has
> been done, this is as early as possible it can enabled.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/kernel/asm-offsets.c |  4 ++++
>  arch/riscv/kernel/head.S        | 12 ++++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offs=
ets.c
> index 0c188aaf3925..21f99d5757b6 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -515,4 +515,8 @@ void asm_offsets(void)
>         DEFINE(FREGS_A6,            offsetof(struct __arch_ftrace_regs, a=
6));
>         DEFINE(FREGS_A7,            offsetof(struct __arch_ftrace_regs, a=
7));
>  #endif
> +       DEFINE(SBI_EXT_FWFT, SBI_EXT_FWFT);
> +       DEFINE(SBI_EXT_FWFT_SET, SBI_EXT_FWFT_SET);
> +       DEFINE(SBI_FWFT_SHADOW_STACK, SBI_FWFT_SHADOW_STACK);
> +       DEFINE(SBI_FWFT_SET_FLAG_LOCK, SBI_FWFT_SET_FLAG_LOCK);
>  }
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 356d5397b2a2..6244408ca917 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -164,6 +164,12 @@ secondary_start_sbi:
>         call relocate_enable_mmu
>  #endif
>         call .Lsetup_trap_vector
> +       li a7, SBI_EXT_FWFT
> +       li a6, SBI_EXT_FWFT_SET
> +       li a0, SBI_FWFT_SHADOW_STACK
> +       li a1, 1 /* enable supervisor to access shadow stack access */
> +       li a2, SBI_FWFT_SET_FLAG_LOCK
> +       ecall
>         scs_load_current
>         call smp_callin
>  #endif /* CONFIG_SMP */
> @@ -320,6 +326,12 @@ SYM_CODE_START(_start_kernel)
>         la tp, init_task
>         la sp, init_thread_union + THREAD_SIZE
>         addi sp, sp, -PT_SIZE_ON_STACK
> +       li a7, SBI_EXT_FWFT
> +       li a6, SBI_EXT_FWFT_SET
> +       li a0, SBI_FWFT_SHADOW_STACK
> +       li a1, 1 /* enable supervisor to access shadow stack access */
> +       li a2, SBI_FWFT_SET_FLAG_LOCK
> +       ecall
>         scs_load_current
>
>  #ifdef CONFIG_KASAN
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

