Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3698F51637A
	for <lists+linux-arch@lfdr.de>; Sun,  1 May 2022 11:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239837AbiEAJpT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 May 2022 05:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236939AbiEAJpS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 1 May 2022 05:45:18 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2B8B7D;
        Sun,  1 May 2022 02:41:51 -0700 (PDT)
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 2827D6010C;
        Sun,  1 May 2022 17:41:48 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=xen0n.name; s=mail;
        t=1651398108; bh=ALuI4X6Hbb1jvImxqWfU16/Y6m06lzYZRUXe/NvynhI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mMLtEsKSLo9jvkt8C27Grf5yc0oX/6mFYY9q1YLJ+Q4NpSdW9FHWyRuKSfiuPuWPg
         oLuGLpDvAtjg55N1a3EHNqK57HxTMmbxUcGrC01JqlrSGjEMe2Tj7oC5hpM0ezvxbR
         OSwEKqy1dHkdLWN/CU/v1EREVwyYICUDibJLcUic=
Message-ID: <1cd3fc0d-b17c-30c9-445b-612761b96cd1@xen0n.name>
Date:   Sun, 1 May 2022 17:41:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:101.0) Gecko/20100101
 Thunderbird/101.0a1
Subject: Re: [PATCH V9 03/24] LoongArch: Add elf-related definitions
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
 <20220430090518.3127980-4-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220430090518.3127980-4-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

Commit message title could be "ELF" -- proper capitalization.

On 4/30/22 17:04, Huacai Chen wrote:
> Add elf-related definitions for LoongArch, including: EM_LOONGARCH,
> KEXEC_ARCH_LOONGARCH, AUDIT_ARCH_LOONGARCH32, AUDIT_ARCH_LOONGARCH64
> and NT_LOONGARCH_*.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   include/uapi/linux/audit.h  | 2 ++
>   include/uapi/linux/elf-em.h | 1 +
>   include/uapi/linux/elf.h    | 5 +++++
>   include/uapi/linux/kexec.h  | 1 +
>   scripts/sorttable.c         | 5 +++++
>   5 files changed, 14 insertions(+)
>
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 8eda133ca4c1..7c1dc818b1d5 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -439,6 +439,8 @@ enum {
>   #define AUDIT_ARCH_UNICORE	(EM_UNICORE|__AUDIT_ARCH_LE)
>   #define AUDIT_ARCH_X86_64	(EM_X86_64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
>   #define AUDIT_ARCH_XTENSA	(EM_XTENSA)
> +#define AUDIT_ARCH_LOONGARCH32	(EM_LOONGARCH|__AUDIT_ARCH_LE)
> +#define AUDIT_ARCH_LOONGARCH64	(EM_LOONGARCH|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
>   
>   #define AUDIT_PERM_EXEC		1
>   #define AUDIT_PERM_WRITE	2
> diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h
> index f47e853546fa..ef38c2bc5ab7 100644
> --- a/include/uapi/linux/elf-em.h
> +++ b/include/uapi/linux/elf-em.h
> @@ -51,6 +51,7 @@
>   #define EM_RISCV	243	/* RISC-V */
>   #define EM_BPF		247	/* Linux BPF - in-kernel virtual machine */
>   #define EM_CSKY		252	/* C-SKY */
> +#define EM_LOONGARCH	258	/* LoongArch */
>   #define EM_FRV		0x5441	/* Fujitsu FR-V */
>   
>   /*
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index 7ce993e6786c..1e0ae3f554f6 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -436,6 +436,11 @@ typedef struct elf64_shdr {
>   #define NT_MIPS_DSP	0x800		/* MIPS DSP ASE registers */
>   #define NT_MIPS_FP_MODE	0x801		/* MIPS floating-point mode */
>   #define NT_MIPS_MSA	0x802		/* MIPS SIMD registers */
> +#define NT_LOONGARCH_CPUCFG	0xa00	/* LoongArch CPU config registers */
> +#define NT_LOONGARCH_CSR	0xa01	/* LoongArch control and status registers */
> +#define NT_LOONGARCH_LSX	0xa02	/* LoongArch Loongson SIMD Extension registers */
> +#define NT_LOONGARCH_LASX	0xa03	/* LoongArch Loongson Advanced SIMD Extension registers */
> +#define NT_LOONGARCH_LBT	0xa04	/* LoongArch Loongson Binary Translation registers */
These are named NT_LARCH_* in binutils source, better keep consistent?
>   
>   /* Note types with note name "GNU" */
>   #define NT_GNU_PROPERTY_TYPE_0	5
> diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
> index fb7e2ef60825..981016e05cfa 100644
> --- a/include/uapi/linux/kexec.h
> +++ b/include/uapi/linux/kexec.h
> @@ -43,6 +43,7 @@
>   #define KEXEC_ARCH_MIPS    ( 8 << 16)
>   #define KEXEC_ARCH_AARCH64 (183 << 16)
>   #define KEXEC_ARCH_RISCV   (243 << 16)
> +#define KEXEC_ARCH_LOONGARCH	(258 << 16)
>   
>   /* The artificial cap on the number of segments passed to kexec_load. */
>   #define KEXEC_SEGMENT_MAX 16
> diff --git a/scripts/sorttable.c b/scripts/sorttable.c
> index d00504c5f530..fba40e99f354 100644
> --- a/scripts/sorttable.c
> +++ b/scripts/sorttable.c
> @@ -60,6 +60,10 @@
>   #define EM_RISCV	243
>   #endif
>   
> +#ifndef EM_LOONGARCH
> +#define EM_LOONGARCH	258
> +#endif
> +
>   static uint32_t (*r)(const uint32_t *);
>   static uint16_t (*r2)(const uint16_t *);
>   static uint64_t (*r8)(const uint64_t *);
> @@ -313,6 +317,7 @@ static int do_file(char const *const fname, void *addr)
>   	case EM_ARCOMPACT:
>   	case EM_ARCV2:
>   	case EM_ARM:
> +	case EM_LOONGARCH:
>   	case EM_MICROBLAZE:
>   	case EM_MIPS:
>   	case EM_XTENSA:
