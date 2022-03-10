Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD164D443E
	for <lists+linux-arch@lfdr.de>; Thu, 10 Mar 2022 11:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241064AbiCJKH2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Mar 2022 05:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240199AbiCJKH1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Mar 2022 05:07:27 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B56D13D927;
        Thu, 10 Mar 2022 02:06:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B9609CE2315;
        Thu, 10 Mar 2022 10:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EC5C340F5;
        Thu, 10 Mar 2022 10:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646906782;
        bh=vhFXTfR/hHQwooRMbLLv+htbY75oKp351jSwOX6ruus=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ud5l1qsbXJFf8gH+uYExyTYvIz8T6lX3+I9F5nGWuFeMgL1BlC5il7yZEy9Pq1jLQ
         nDKmXAUT8gXbXi7oDJgboC3xxlHkuln8v/mLbeLLvO5uzw1gOunhZv4JbH5021WNIq
         g97xqb1Uy9C9vWkGU2U0nDJcwD4VhE57HPj+c0rni/Qbq6cKLTZjLabYQFXW2nTNqo
         8lrRQU9ez/ZlWCmyK17bvCLl3ffRET3rsX96uJX97ksR2RYMBCIxo/8ori2WEd59/O
         OL7rioB5cgwtNpFV23tgpV2bB+46QAVVqSLDqlSOgSatoXmUK8z4m/gLlECpItSWkp
         utWcxHO1iuYVA==
Received: by mail-vs1-f45.google.com with SMTP id u124so5296398vsb.10;
        Thu, 10 Mar 2022 02:06:22 -0800 (PST)
X-Gm-Message-State: AOAM532QD1kKYLDdvA4GHDy2hm7znWX/9hnVc1cpRVvKSPOETZHJeKXp
        nwdsJp7XvVV2j+17Df/4zyK3MTXkXvtjt1L+U1U=
X-Google-Smtp-Source: ABdhPJxmgtCny+YtcJg2sILVIeyOg6uUfrGYFkSlV5X2IRbm6w3wA9qxxW2buYTHGP3tmE/NAGGje/tSIZYaB3Wi5MY=
X-Received: by 2002:a67:fc17:0:b0:320:b039:afc0 with SMTP id
 o23-20020a67fc17000000b00320b039afc0mr2196611vsq.2.1646906781754; Thu, 10 Mar
 2022 02:06:21 -0800 (PST)
MIME-Version: 1.0
References: <20220227162831.674483-1-guoren@kernel.org> <20220227162831.674483-15-guoren@kernel.org>
In-Reply-To: <20220227162831.674483-15-guoren@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 10 Mar 2022 18:06:10 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQLWZbh_yZJMXAsWbjRfkeQMpdsuo5fQcFRYZbKQyGKaA@mail.gmail.com>
Message-ID: <CAJF2gTQLWZbh_yZJMXAsWbjRfkeQMpdsuo5fQcFRYZbKQyGKaA@mail.gmail.com>
Subject: Re: [PATCH V7 14/20] riscv: compat: Add elf.h implementation
To:     Guo Ren <guoren@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Palmer & Arnd

Seems we need a more strict check to distinguish ELFCLASS32/64 RISC in
elf for the elf_check_arch & compat_elf_check_arch. SET_PERSONALITY is
not enough.

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index d87d3bcc758d..2fcd854fb516 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -33,7 +33,8 @@
 /*
  * This is used to ensure we don't load something for the wrong architecture.
  */
-#define elf_check_arch(x) ((x)->e_machine == EM_RISCV)
+#define elf_check_arch(x) (((x)->e_machine == EM_RISCV) && \
+                          ((x)->e_ident[EI_CLASS] == ELF_CLASS))

 /*
  * Use the same code with elf_check_arch, because elf32_hdr &
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 8caa5f48d0a1..f46016e96235 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -88,7 +88,9 @@ static bool compat_mode_supported __read_mostly;

 bool compat_elf_check_arch(Elf32_Ehdr *hdr)
 {
-       return compat_mode_supported && hdr->e_machine == EM_RISCV;
+       return compat_mode_supported &&
+              hdr->e_machine == EM_RISCV &&
+              hdr->e_ident[EI_CLASS] == ELFCLASS32;
 }

 static int __init compat_mode_detect(void)

On Mon, Feb 28, 2022 at 12:30 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Implement necessary type and macro for compat elf. See the code
> comment for detail.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/riscv/include/asm/elf.h | 46 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
> index f53c40026c7a..aee40040917b 100644
> --- a/arch/riscv/include/asm/elf.h
> +++ b/arch/riscv/include/asm/elf.h
> @@ -8,6 +8,8 @@
>  #ifndef _ASM_RISCV_ELF_H
>  #define _ASM_RISCV_ELF_H
>
> +#include <uapi/linux/elf.h>
> +#include <linux/compat.h>
>  #include <uapi/asm/elf.h>
>  #include <asm/auxvec.h>
>  #include <asm/byteorder.h>
> @@ -18,11 +20,13 @@
>   */
>  #define ELF_ARCH       EM_RISCV
>
> +#ifndef ELF_CLASS
>  #ifdef CONFIG_64BIT
>  #define ELF_CLASS      ELFCLASS64
>  #else
>  #define ELF_CLASS      ELFCLASS32
>  #endif
> +#endif
>
>  #define ELF_DATA       ELFDATA2LSB
>
> @@ -31,6 +35,13 @@
>   */
>  #define elf_check_arch(x) ((x)->e_machine == EM_RISCV)
>
> +/*
> + * Use the same code with elf_check_arch, because elf32_hdr &
> + * elf64_hdr e_machine's offset are different. The checker is
> + * a little bit simple compare to other architectures.
> + */
> +#define compat_elf_check_arch(x) ((x)->e_machine == EM_RISCV)
> +
>  #define CORE_DUMP_USE_REGSET
>  #define ELF_EXEC_PAGESIZE      (PAGE_SIZE)
>
> @@ -43,8 +54,14 @@
>  #define ELF_ET_DYN_BASE                ((TASK_SIZE / 3) * 2)
>
>  #ifdef CONFIG_64BIT
> +#ifdef CONFIG_COMPAT
> +#define STACK_RND_MASK         (test_thread_flag(TIF_32BIT) ? \
> +                                0x7ff >> (PAGE_SHIFT - 12) : \
> +                                0x3ffff >> (PAGE_SHIFT - 12))
> +#else
>  #define STACK_RND_MASK         (0x3ffff >> (PAGE_SHIFT - 12))
>  #endif
> +#endif
>  /*
>   * This yields a mask that user programs can use to figure out what
>   * instruction set this CPU supports.  This could be done in user space,
> @@ -60,11 +77,19 @@ extern unsigned long elf_hwcap;
>   */
>  #define ELF_PLATFORM   (NULL)
>
> +#define COMPAT_ELF_PLATFORM    (NULL)
> +
>  #ifdef CONFIG_MMU
>  #define ARCH_DLINFO                                            \
>  do {                                                           \
> +       /*                                                      \
> +        * Note that we add ulong after elf_addr_t because      \
> +        * casting current->mm->context.vdso triggers a cast    \
> +        * warning of cast from pointer to integer for          \
> +        * COMPAT ELFCLASS32.                                   \
> +        */                                                     \
>         NEW_AUX_ENT(AT_SYSINFO_EHDR,                            \
> -               (elf_addr_t)current->mm->context.vdso);         \
> +               (elf_addr_t)(ulong)current->mm->context.vdso);  \
>         NEW_AUX_ENT(AT_L1I_CACHESIZE,                           \
>                 get_cache_size(1, CACHE_TYPE_INST));            \
>         NEW_AUX_ENT(AT_L1I_CACHEGEOMETRY,                       \
> @@ -90,4 +115,23 @@ do {                                                        \
>                 *(struct user_regs_struct *)regs;       \
>  } while (0);
>
> +#ifdef CONFIG_COMPAT
> +
> +#define SET_PERSONALITY(ex)                                    \
> +do {    if ((ex).e_ident[EI_CLASS] == ELFCLASS32)              \
> +               set_thread_flag(TIF_32BIT);                     \
> +       else                                                    \
> +               clear_thread_flag(TIF_32BIT);                   \
> +       if (personality(current->personality) != PER_LINUX32)   \
> +               set_personality(PER_LINUX |                     \
> +                       (current->personality & (~PER_MASK)));  \
> +} while (0)
> +
> +#define COMPAT_ELF_ET_DYN_BASE         ((TASK_SIZE_32 / 3) * 2)
> +
> +/* rv32 registers */
> +typedef compat_ulong_t                 compat_elf_greg_t;
> +typedef compat_elf_greg_t              compat_elf_gregset_t[ELF_NGREG];
> +
> +#endif /* CONFIG_COMPAT */
>  #endif /* _ASM_RISCV_ELF_H */
> --
> 2.25.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
