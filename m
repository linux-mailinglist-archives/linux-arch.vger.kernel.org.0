Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF4E54FA5A
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jun 2022 17:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiFQPfH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jun 2022 11:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiFQPfH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jun 2022 11:35:07 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF4A3BFBC
        for <linux-arch@vger.kernel.org>; Fri, 17 Jun 2022 08:35:05 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id h7so3209438ila.10
        for <linux-arch@vger.kernel.org>; Fri, 17 Jun 2022 08:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wweLd0IY4VacU+kMRqEasPr5a8L5WeGA9PHNlWsTsRY=;
        b=I52z8HSXU1qWTP3FLBS+cUWrNLj0HOjylKSiCI/y/K6r7fit0kUOX14r3sDKiLVA/M
         ZIljKYuiNSmbV833LPAZtohB05OsX+YECRCtnQPbQezWrIfxX+nCUcQ+cWAGM49MAUKQ
         g84jprT4CwTpzWoxy9zwgGwGmlcOiJa8yrJ3MHfV3lIhuw6mtY1UDmgmxPZd5iBWgmrH
         Rl33WWfKKTvbs+4sOBYrs0iKQytua+ztm/rgZ2er1slZulLTcuQgpnrexgiK+EEFCpqW
         0PAI/N/40olsKN6gp0fCvK4BayCZDNv7JOZujfl/eo0f/0NM1ffjHARJZiwrBYQ4XQzM
         Djkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wweLd0IY4VacU+kMRqEasPr5a8L5WeGA9PHNlWsTsRY=;
        b=WLvz79KQ6GbO0T8yOD9WMKXa+SjVzJ2NLssk83RPrjjL1h/gOpv8FxOKb++bfQ7ejk
         V0ZgB3Dgt7EjrQUfFul3C5M8zSVrdg46hZOU+fNxTWQum+ptd8qVFjPW87FT44j+2W9Q
         LGOf7c/B3uj3hvHbnoVhuadhKF8r9iX3cS8AZK3AZQ6MInwU12kMF7aRJhjjLGeVe3Jw
         6gTl7golAK6dAqMz8OmiuCsaxbdw4XK0rc6LzUANFj85oHgzISXx16AA5WlCbfcw1yRq
         LTxcva1uZuk/l+WyUEjcPb51+1Wy1oNqGScVakepg/sOGCygb23QjaWJQE1Du2FwmzWz
         OYWg==
X-Gm-Message-State: AJIora+HsLHHbXRLugZJ0cDemOs6lUQu2picWhOejVEPBYnvDN8cVhag
        mDxJ0tMqLmfO4WN3zGwyeUFAwuzaRvTb0I/qXlwEZw==
X-Google-Smtp-Source: AGRyM1vf5unkTlFCkksxiNjqIpLyvQfi6AYK8OMCPqEmsdlhRoWRSq7q83veuPI1DjDWnqmUkPgrgfndwrsce4uJTuc=
X-Received: by 2002:a05:6e02:1bc8:b0:2d4:342:9c68 with SMTP id
 x8-20020a056e021bc800b002d403429c68mr6070190ilv.254.1655480104445; Fri, 17
 Jun 2022 08:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220617145828.582117-1-chenhuacai@loongson.cn>
In-Reply-To: <20220617145828.582117-1-chenhuacai@loongson.cn>
From:   hev <r@hev.cc>
Date:   Fri, 17 Jun 2022 23:34:53 +0800
Message-ID: <CAHirt9hRs_iTvAZ=UxBBK448j7p+pYxKsMVise=Jj2qCtNky2Q@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add vDSO syscall __vdso_getcpu()
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello,

On Fri, Jun 17, 2022 at 10:57 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> We test 20 million times of getcpu(), the real syscall version take 25
> seconds, while the vsyscall version take only 2.4 seconds.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/include/asm/vdso.h      |  4 +++
>  arch/loongarch/include/asm/vdso/vdso.h | 10 +++++-
>  arch/loongarch/kernel/vdso.c           | 23 +++++++++-----
>  arch/loongarch/vdso/Makefile           |  3 +-
>  arch/loongarch/vdso/vdso.lds.S         |  1 +
>  arch/loongarch/vdso/vgetcpu.c          | 43 ++++++++++++++++++++++++++
>  6 files changed, 74 insertions(+), 10 deletions(-)
>  create mode 100644 arch/loongarch/vdso/vgetcpu.c
>
> diff --git a/arch/loongarch/include/asm/vdso.h b/arch/loongarch/include/asm/vdso.h
> index 8f8a0f9a4953..e76d5e37480d 100644
> --- a/arch/loongarch/include/asm/vdso.h
> +++ b/arch/loongarch/include/asm/vdso.h
> @@ -12,6 +12,10 @@
>
>  #include <asm/barrier.h>
>
> +typedef struct vdso_pcpu_data {
> +       u32 node;
> +} ____cacheline_aligned_in_smp vdso_pcpu_data;
> +
>  /*
>   * struct loongarch_vdso_info - Details of a VDSO image.
>   * @vdso: Pointer to VDSO image (page-aligned).
> diff --git a/arch/loongarch/include/asm/vdso/vdso.h b/arch/loongarch/include/asm/vdso/vdso.h
> index 5a01643a65b3..94055f7c54b7 100644
> --- a/arch/loongarch/include/asm/vdso/vdso.h
> +++ b/arch/loongarch/include/asm/vdso/vdso.h
> @@ -8,6 +8,13 @@
>
>  #include <asm/asm.h>
>  #include <asm/page.h>
> +#include <asm/vdso.h>
> +
> +#if PAGE_SIZE < SZ_16K
> +#define VDSO_DATA_SIZE SZ_16K

Whether we add members to the vdso data structure or extend
SMP_CACHE_BYTES/NR_CPUS, the static VDSO_DATA_SIZE may not match, and
there is no assertion checking to help us catch bugs early. So I
suggest defining VDSO_DATA_SIZE as ALIGN_UP(sizeof (struct vdso_data),
PAGE_SIZE).

hev

> +#else
> +#define VDSO_DATA_SIZE PAGE_SIZE
> +#endif
>
>  static inline unsigned long get_vdso_base(void)
>  {
> @@ -24,7 +31,8 @@ static inline unsigned long get_vdso_base(void)
>
>  static inline const struct vdso_data *get_vdso_data(void)
>  {
> -       return (const struct vdso_data *)(get_vdso_base() - PAGE_SIZE);
> +       return (const struct vdso_data *)(get_vdso_base()
> +                       - VDSO_DATA_SIZE + SMP_CACHE_BYTES * NR_CPUS);
>  }
>
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
> index e20c8ca87473..6ce322a1bf8b 100644
> --- a/arch/loongarch/kernel/vdso.c
> +++ b/arch/loongarch/kernel/vdso.c
> @@ -26,11 +26,15 @@ extern char vdso_start[], vdso_end[];
>
>  /* Kernel-provided data used by the VDSO. */
>  static union loongarch_vdso_data {
> -       u8 page[PAGE_SIZE];
> -       struct vdso_data data[CS_BASES];
> +       u8 page[VDSO_DATA_SIZE];
> +       struct {
> +               vdso_pcpu_data pdata[NR_CPUS];
> +               struct vdso_data data[CS_BASES];
> +       };
>  } loongarch_vdso_data __page_aligned_data;
> -struct vdso_data *vdso_data = loongarch_vdso_data.data;
> +
>  static struct page *vdso_pages[] = { NULL };
> +struct vdso_data *vdso_data = loongarch_vdso_data.data;
>
>  static int vdso_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma)
>  {
> @@ -55,11 +59,14 @@ struct loongarch_vdso_info vdso_info = {
>
>  static int __init init_vdso(void)
>  {
> -       unsigned long i, pfn;
> +       unsigned long i, cpu, pfn;
>
>         BUG_ON(!PAGE_ALIGNED(vdso_info.vdso));
>         BUG_ON(!PAGE_ALIGNED(vdso_info.size));
>
> +       for_each_possible_cpu(cpu)
> +               loongarch_vdso_data.pdata[cpu].node = cpu_to_node(cpu);
> +
>         pfn = __phys_to_pfn(__pa_symbol(vdso_info.vdso));
>         for (i = 0; i < vdso_info.size / PAGE_SIZE; i++)
>                 vdso_info.code_mapping.pages[i] = pfn_to_page(pfn + i);
> @@ -93,9 +100,9 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>
>         /*
>          * Determine total area size. This includes the VDSO data itself
> -        * and the data page.
> +        * and the data pages.
>          */
> -       vvar_size = PAGE_SIZE;
> +       vvar_size = VDSO_DATA_SIZE;
>         size = vvar_size + info->size;
>
>         data_addr = get_unmapped_area(NULL, vdso_base(), size, 0, 0);
> @@ -115,8 +122,8 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>
>         /* Map VDSO data page. */
>         ret = remap_pfn_range(vma, data_addr,
> -                             virt_to_phys(vdso_data) >> PAGE_SHIFT,
> -                             PAGE_SIZE, PAGE_READONLY);
> +                             virt_to_phys(&loongarch_vdso_data) >> PAGE_SHIFT,
> +                             vvar_size, PAGE_READONLY);
>         if (ret)
>                 goto out;
>
> diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
> index 6b6e16732c60..d89e2ac75f7b 100644
> --- a/arch/loongarch/vdso/Makefile
> +++ b/arch/loongarch/vdso/Makefile
> @@ -6,7 +6,7 @@
>  ARCH_REL_TYPE_ABS := R_LARCH_32|R_LARCH_64|R_LARCH_MARK_LA|R_LARCH_JUMP_SLOT
>  include $(srctree)/lib/vdso/Makefile
>
> -obj-vdso-y := elf.o vgettimeofday.o sigreturn.o
> +obj-vdso-y := elf.o vgetcpu.o vgettimeofday.o sigreturn.o
>
>  # Common compiler flags between ABIs.
>  ccflags-vdso := \
> @@ -21,6 +21,7 @@ ccflags-vdso += $(filter --target=%,$(KBUILD_CFLAGS))
>  endif
>
>  cflags-vdso := $(ccflags-vdso) \
> +       -isystem $(shell $(CC) -print-file-name=include) \
>         $(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
>         -O2 -g -fno-strict-aliasing -fno-common -fno-builtin -G0 \
>         -fno-stack-protector -fno-jump-tables -DDISABLE_BRANCH_PROFILING \
> diff --git a/arch/loongarch/vdso/vdso.lds.S b/arch/loongarch/vdso/vdso.lds.S
> index 955f02de4a2d..56ad855896de 100644
> --- a/arch/loongarch/vdso/vdso.lds.S
> +++ b/arch/loongarch/vdso/vdso.lds.S
> @@ -58,6 +58,7 @@ VERSION
>  {
>         LINUX_5.10 {
>         global:
> +               __vdso_getcpu;
>                 __vdso_clock_getres;
>                 __vdso_clock_gettime;
>                 __vdso_gettimeofday;
> diff --git a/arch/loongarch/vdso/vgetcpu.c b/arch/loongarch/vdso/vgetcpu.c
> new file mode 100644
> index 000000000000..23fe2362f4e0
> --- /dev/null
> +++ b/arch/loongarch/vdso/vgetcpu.c
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Fast user context implementation of getcpu()
> + */
> +
> +#include <asm/vdso.h>
> +#include <linux/getcpu.h>
> +
> +static __always_inline int read_cpu_id(void)
> +{
> +       int cpu_id;
> +
> +       __asm__ __volatile__(
> +       "       rdtime.d $zero, %0\n"
> +       : "=r" (cpu_id)
> +       :
> +       : "memory");
> +
> +       return cpu_id;
> +}
> +
> +static __always_inline const vdso_pcpu_data *get_pcpu_data(void)
> +{
> +       return (vdso_pcpu_data *)(get_vdso_base() - VDSO_DATA_SIZE);
> +}
> +
> +int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused)
> +{
> +       int cpu_id;
> +       const vdso_pcpu_data *data;
> +
> +       cpu_id = read_cpu_id();
> +
> +       if (cpu)
> +               *cpu = cpu_id;
> +
> +       if (node) {
> +               data = get_pcpu_data();
> +               *node = data[cpu_id].node;
> +       }
> +
> +       return 0;
> +}
> --
> 2.27.0
>
>
