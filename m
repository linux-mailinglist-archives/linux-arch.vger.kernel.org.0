Return-Path: <linux-arch+bounces-9072-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE8A9C786E
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 17:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403EC1F259F7
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 16:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD7D15C145;
	Wed, 13 Nov 2024 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jCyVMMJR"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5E3137C35
	for <linux-arch@vger.kernel.org>; Wed, 13 Nov 2024 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731514433; cv=none; b=gpiahvQNnK04FoDM+xLu5ZwsNYGyBH+5Z4ivjUEdEErCR+mMEx/onp1gWoQu/L5sJX2sGZN0oPj4pTKmtVEcISVko4uqrbIQHaghEUnY66uMf07MLa3TgqlIAMNEBj/c4JjqKxLICx4ATbQ5sX1b4JIxnnVXG4vRQIE1ImRuX1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731514433; c=relaxed/simple;
	bh=7HWQ/VqZgyhSHZd91HoF8yCdwP+of9WeF4Yh1KQV7BE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rs5eCZyGJjSVY92oCAyGRD9jGvJ/Y6i3W3tEZjSLGEYiNeLGKduWX/KFFqUW2BAUu44wKRutRbvWV7n4B8IiLhvHavt8jQfzC6bXMEOfRNv/LqgVFSEf9Z6Stii/fVP+/myDIy8oplSIihoQiLztdUfvvZvf5dLlK22bt1fQdQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=jCyVMMJR; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ee8eaa1694so942713eaf.0
        for <linux-arch@vger.kernel.org>; Wed, 13 Nov 2024 08:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1731514429; x=1732119229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4CnOM9V0G25evq0IkfWx5gKqtwex3+JBvT1EkxAWJE=;
        b=jCyVMMJRZOft92rmgjFsP3jK3JLbWqZcaGXyMz40qYrjgttc8yEJhY7jqrB/gqK/+y
         D+SOZId9qjrrJnGW6X/8heTjD372K9LsGgC4UEfHPQxjal+LF2O538+U6Hv0vntjjMl3
         80hXhVeRNixVT6HGJ1HWhZVBwNbQFtgcFFRtKo12KNHP0baM+vriLZDpTpaPCIU/Ftld
         G0uD/fq4As/pD77wGfseFLWCBZGm7lAhe3sen+uAvRSVbGMOXUJMG5Am/9W1TFZ0cv+I
         dOmfpvAumQU6rqEv6oKwookaF4hT5Mde01ublxW8YgpR+5DjCfj7CSff+k+Vh1fLL0Qu
         0R+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731514429; x=1732119229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4CnOM9V0G25evq0IkfWx5gKqtwex3+JBvT1EkxAWJE=;
        b=dE8ZHM0OrmRl1rYEqwMrGbTJ6Ha3q4/caDXnCN/uOdj5pbfLaAvE2Bi4EZcPfdGqbi
         v6m/LCObQV0oJH15+OQbhh7CP6rb6OJF1sdhn4gL5zEGg7uLf7A/XGEMWQdcAg5NRk4X
         TBM+7w3dPl0Dha+R1cblgqxXM6y5yhwXYhdNWC+iNmaE1yQUiHf5sYknz8LTGaerzHLy
         2ebz5NxgLDLlIoRkdCysb2KzDtpzuUS858Yej3J8EUxAkfjeUACMVOHZpuLTvusnawXW
         SIiHgexDm9eipiTAye5V8l9LxSz3G5Lb8y2qaiAmpwZhUuA2ysH66sv7ku6XrZ9TVQ/u
         CDbg==
X-Forwarded-Encrypted: i=1; AJvYcCWBbHQBIcYfowLh1+vgDfSI1k5diF9wPERed1ivseKeiMml9xhDxYhPjTTuCDAMFw7rFpbvcFyqWUXf@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoa69MDV6J9bJcTBHNuVvQ9O8lKzr697gLydYqOKEGhCHnwXOG
	JotShedVMyONKzm0isodGNyl7H1JPQQE/G/WqIzHcu1N/uW8PnJJdgeM4Wfi0d9GlaB5liE125H
	iVVYNNekWBEuXqcyC03x4HbE1nqKSA9OXOo+L6A==
X-Google-Smtp-Source: AGHT+IGDFpRJff+OKPz21HLMWXvGQyDkqQzC8F4K0hofednOGXa7SW/5Crlgs/h6Bl5IR8Aw+zrRHhGFgVmxSg02ZdY=
X-Received: by 2002:a05:6820:1805:b0:5eb:c72e:e29c with SMTP id
 006d021491bc7-5ee86a500a2mr5293321eaf.8.1731514429462; Wed, 13 Nov 2024
 08:13:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com> <20241111-v5_user_cfi_series-v8-24-dce14aa30207@rivosinc.com>
In-Reply-To: <20241111-v5_user_cfi_series-v8-24-dce14aa30207@rivosinc.com>
From: Nick Hu <nick.hu@sifive.com>
Date: Thu, 14 Nov 2024 00:13:38 +0800
Message-ID: <CAKddAkCCVjNHUinPWtOiK8Ki_ZkdoUCawfv1-+0B69J_1aJv5Q@mail.gmail.com>
Subject: Re: [PATCH v8 24/29] riscv: enable kernel access to shadow stack
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
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
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

Hi Deepak

On Tue, Nov 12, 2024 at 5:08=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
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
> index 766bd33f10cb..a22ab8a41672 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -517,4 +517,8 @@ void asm_offsets(void)
>         DEFINE(FREGS_A6,            offsetof(struct ftrace_regs, a6));
>         DEFINE(FREGS_A7,            offsetof(struct ftrace_regs, a7));
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
> --
> 2.45.0
>
Should we clear the SBI_FWFT_SET_FLAG_LOCK before the cpu hotplug
otherwise the menvcfg.sse won't be set by the fwft set sbi call when
the hotplug cpu back to kernel?

Regards,
Nick
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

