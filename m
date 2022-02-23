Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552B04C070D
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 02:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbiBWBnb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Feb 2022 20:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236661AbiBWBn3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Feb 2022 20:43:29 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B23506E3
        for <linux-arch@vger.kernel.org>; Tue, 22 Feb 2022 17:42:54 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id g1so13873571pfv.1
        for <linux-arch@vger.kernel.org>; Tue, 22 Feb 2022 17:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=TWhgF9FeTi8dOQVI2k/1V0qT/3+zoCpboq+qKZ5bMI8=;
        b=lhFeOPH1tXM6mZ6KGKijnCg9cWqzTSt7ZQdh4S9KiIyb9cMveL28/g42MvvbnDVtt4
         SAZ6MhDy1zYOhxh9qzkByiw6t1xZr3DP7hmRlQw7Us5N0V6vfmWmdADfTJobhfbjYDuC
         4/RN7QFYswrzNG4mgmSZ+3ZFsnvJOTxoZ5e5LOhU6Sg8olj20480dX0azWETbCeaygdf
         wJnp5lSB5MZXA1aRKe3ZE49Bz0GXYhmqNQ5jU2i9jadxR7aM75wmDig0R7cDDC5606dk
         BGFF5Bpcu+rpjQX9S9NLcVXB4b4AwRsRuPO4Wr22oKHlFg3WcluvYcTwn0T5YOp89o2/
         evFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=TWhgF9FeTi8dOQVI2k/1V0qT/3+zoCpboq+qKZ5bMI8=;
        b=ThkqM5nZNS+TDGYVKwESFGbc4T48EOSmAvVKeK3R4kq7XiljVEN1m3/L/5eLNbOhvV
         Q4K/JZr1eaSFTA88furBdy5PYB9ITyz3GRW9gzD2nWx19yX/HpCMt4G3lPhFx7B5Rz22
         F2efnS6fA+JwMfbNTA0Vtx+1JvRY3AhGYa7cKRTgnLbG+wW4PZZpbZTV6deYfowb47Ha
         e5f+KmyibrlSVqHIQRYnbMKistdB8RLQnfYWcQbCPdl9NPwWRM8bLIuzwzw6P4Ko54Tp
         /nF2ybbvdflYL5hHnwli47I+5dbfs5GQ0NvGBE8QGdr4FHVqHh3pSRHTWltoVg5uk8KZ
         jbdw==
X-Gm-Message-State: AOAM531pbz9BfAZQJWeuF4MKJfBJv2BUbDrZpp737aR2BaX+qCc+cUOA
        3NJYaWNhaKsd4nwpr3ttzP+yPg==
X-Google-Smtp-Source: ABdhPJxNA5reRs8r3v6c0shrIzFkO76IQZ2c1KGY/GgGhDuLP8n1xhwjgWddNUq0H+VpTDObNB+pSA==
X-Received: by 2002:a05:6a00:1744:b0:4c4:4bd:dc17 with SMTP id j4-20020a056a00174400b004c404bddc17mr27275420pfc.57.1645580573932;
        Tue, 22 Feb 2022 17:42:53 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id v9sm17437449pfu.134.2022.02.22.17.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 17:42:53 -0800 (PST)
Date:   Tue, 22 Feb 2022 17:42:53 -0800 (PST)
X-Google-Original-Date: Tue, 22 Feb 2022 17:04:06 PST (-0800)
Subject:     Re: [PATCH V5 17/21] riscv: compat: vdso: Add setup additional pages implementation
In-Reply-To: <20220201150545.1512822-18-guoren@kernel.org>
CC:     guoren@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        anup@brainfault.org, Greg KH <gregkh@linuxfoundation.org>,
        liush@allwinnertech.com, wefu@redhat.com, drew@beagleboard.org,
        wangjunqiang@iscas.ac.cn, Christoph Hellwig <hch@lst.de>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     guoren@kernel.org
Message-ID: <mhng-fda909a7-d09a-4835-94a9-90a0746f6a95@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 01 Feb 2022 07:05:41 PST (-0800), guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Reconstruct __setup_additional_pages() by appending vdso info
> pointer argument to meet compat_vdso_info requirement. And change
> vm_special_mapping *dm, *cm initialization into static.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> ---
>  arch/riscv/include/asm/elf.h |   5 ++
>  arch/riscv/include/asm/mmu.h |   1 +
>  arch/riscv/kernel/vdso.c     | 104 +++++++++++++++++++++++++----------
>  3 files changed, 81 insertions(+), 29 deletions(-)
>
> diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
> index 3a4293dc7229..d87d3bcc758d 100644
> --- a/arch/riscv/include/asm/elf.h
> +++ b/arch/riscv/include/asm/elf.h
> @@ -134,5 +134,10 @@ do {    if ((ex).e_ident[EI_CLASS] == ELFCLASS32)		\
>  typedef compat_ulong_t			compat_elf_greg_t;
>  typedef compat_elf_greg_t		compat_elf_gregset_t[ELF_NGREG];
>
> +extern int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
> +					      int uses_interp);
> +#define compat_arch_setup_additional_pages \
> +				compat_arch_setup_additional_pages
> +
>  #endif /* CONFIG_COMPAT */
>  #endif /* _ASM_RISCV_ELF_H */
> diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
> index 0099dc116168..cedcf8ea3c76 100644
> --- a/arch/riscv/include/asm/mmu.h
> +++ b/arch/riscv/include/asm/mmu.h
> @@ -16,6 +16,7 @@ typedef struct {
>  	atomic_long_t id;
>  #endif
>  	void *vdso;
> +	void *vdso_info;
>  #ifdef CONFIG_SMP
>  	/* A local icache flush is needed before user execution can resume. */
>  	cpumask_t icache_stale_mask;
> diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
> index a9436a65161a..deca69524799 100644
> --- a/arch/riscv/kernel/vdso.c
> +++ b/arch/riscv/kernel/vdso.c
> @@ -23,6 +23,9 @@ struct vdso_data {
>  #endif
>
>  extern char vdso_start[], vdso_end[];
> +#ifdef CONFIG_COMPAT
> +extern char compat_vdso_start[], compat_vdso_end[];
> +#endif
>
>  enum vvar_pages {
>  	VVAR_DATA_PAGE_OFFSET,
> @@ -30,6 +33,11 @@ enum vvar_pages {
>  	VVAR_NR_PAGES,
>  };
>
> +enum rv_vdso_map {
> +	RV_VDSO_MAP_VVAR,
> +	RV_VDSO_MAP_VDSO,
> +};
> +
>  #define VVAR_SIZE  (VVAR_NR_PAGES << PAGE_SHIFT)
>
>  /*
> @@ -52,12 +60,6 @@ struct __vdso_info {
>  	struct vm_special_mapping *cm;
>  };
>
> -static struct __vdso_info vdso_info __ro_after_init = {
> -	.name = "vdso",
> -	.vdso_code_start = vdso_start,
> -	.vdso_code_end = vdso_end,
> -};
> -
>  static int vdso_mremap(const struct vm_special_mapping *sm,
>  		       struct vm_area_struct *new_vma)
>  {
> @@ -66,35 +68,35 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
>  	return 0;
>  }
>
> -static int __init __vdso_init(void)
> +static int __init __vdso_init(struct __vdso_info *vdso_info)
>  {
>  	unsigned int i;
>  	struct page **vdso_pagelist;
>  	unsigned long pfn;
>
> -	if (memcmp(vdso_info.vdso_code_start, "\177ELF", 4)) {
> +	if (memcmp(vdso_info->vdso_code_start, "\177ELF", 4)) {
>  		pr_err("vDSO is not a valid ELF object!\n");
>  		return -EINVAL;
>  	}
>
> -	vdso_info.vdso_pages = (
> -		vdso_info.vdso_code_end -
> -		vdso_info.vdso_code_start) >>
> +	vdso_info->vdso_pages = (
> +		vdso_info->vdso_code_end -
> +		vdso_info->vdso_code_start) >>
>  		PAGE_SHIFT;
>
> -	vdso_pagelist = kcalloc(vdso_info.vdso_pages,
> +	vdso_pagelist = kcalloc(vdso_info->vdso_pages,
>  				sizeof(struct page *),
>  				GFP_KERNEL);
>  	if (vdso_pagelist == NULL)
>  		return -ENOMEM;
>
>  	/* Grab the vDSO code pages. */
> -	pfn = sym_to_pfn(vdso_info.vdso_code_start);
> +	pfn = sym_to_pfn(vdso_info->vdso_code_start);
>
> -	for (i = 0; i < vdso_info.vdso_pages; i++)
> +	for (i = 0; i < vdso_info->vdso_pages; i++)
>  		vdso_pagelist[i] = pfn_to_page(pfn + i);
>
> -	vdso_info.cm->pages = vdso_pagelist;
> +	vdso_info->cm->pages = vdso_pagelist;
>
>  	return 0;
>  }
> @@ -116,13 +118,14 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
>  {
>  	struct mm_struct *mm = task->mm;
>  	struct vm_area_struct *vma;
> +	struct __vdso_info *vdso_info = mm->context.vdso_info;

IIUC this is the only use for context.vdso_info?  If that's the case, 
can we just switch between VDSO targets based on __is_compat_task(task)?  
That'd save an mm_struct pointer, which is always nice.  It'd probably 
be worth cleaning up the arm64 port too, which zaps both mappings.

>
>  	mmap_read_lock(mm);
>
>  	for (vma = mm->mmap; vma; vma = vma->vm_next) {
>  		unsigned long size = vma->vm_end - vma->vm_start;
>
> -		if (vma_is_special_mapping(vma, vdso_info.dm))
> +		if (vma_is_special_mapping(vma, vdso_info->dm))
>  			zap_page_range(vma, vma->vm_start, size);
>  	}
>
> @@ -187,11 +190,6 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
>  	return vmf_insert_pfn(vma, vmf->address, pfn);
>  }
>
> -enum rv_vdso_map {
> -	RV_VDSO_MAP_VVAR,
> -	RV_VDSO_MAP_VDSO,
> -};
> -
>  static struct vm_special_mapping rv_vdso_maps[] __ro_after_init = {
>  	[RV_VDSO_MAP_VVAR] = {
>  		.name   = "[vvar]",
> @@ -203,25 +201,53 @@ static struct vm_special_mapping rv_vdso_maps[] __ro_after_init = {
>  	},
>  };
>
> +static struct __vdso_info vdso_info __ro_after_init = {
> +	.name = "vdso",
> +	.vdso_code_start = vdso_start,
> +	.vdso_code_end = vdso_end,
> +	.dm = &rv_vdso_maps[RV_VDSO_MAP_VVAR],
> +	.cm = &rv_vdso_maps[RV_VDSO_MAP_VDSO],
> +};
> +
> +#ifdef CONFIG_COMPAT
> +static struct __vdso_info compat_vdso_info __ro_after_init = {
> +	.name = "compat_vdso",
> +	.vdso_code_start = compat_vdso_start,
> +	.vdso_code_end = compat_vdso_end,
> +	.dm = &rv_vdso_maps[RV_VDSO_MAP_VVAR],
> +	.cm = &rv_vdso_maps[RV_VDSO_MAP_VDSO],
> +};
> +#endif
> +
>  static int __init vdso_init(void)
>  {
> -	vdso_info.dm = &rv_vdso_maps[RV_VDSO_MAP_VVAR];
> -	vdso_info.cm = &rv_vdso_maps[RV_VDSO_MAP_VDSO];
> +	int ret;
> +
> +	ret = __vdso_init(&vdso_info);
> +	if (ret)
> +		goto out;
>
> -	return __vdso_init();
> +#ifdef CONFIG_COMPAT
> +	ret = __vdso_init(&compat_vdso_info);
> +	if (ret)
> +		goto out;

It's a bit pedantic (we're just going to crash anyway), but this is 
mising the cleanup for the first __vdso_init().

> +#endif
> +out:
> +	return ret;
>  }
>  arch_initcall(vdso_init);
>
>  static int __setup_additional_pages(struct mm_struct *mm,
>  				    struct linux_binprm *bprm,
> -				    int uses_interp)
> +				    int uses_interp,
> +				    struct __vdso_info *vdso_info)
>  {
>  	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
>  	void *ret;
>
>  	BUILD_BUG_ON(VVAR_NR_PAGES != __VVAR_PAGES);
>
> -	vdso_text_len = vdso_info.vdso_pages << PAGE_SHIFT;
> +	vdso_text_len = vdso_info->vdso_pages << PAGE_SHIFT;
>  	/* Be sure to map the data page */
>  	vdso_mapping_len = vdso_text_len + VVAR_SIZE;
>
> @@ -232,16 +258,18 @@ static int __setup_additional_pages(struct mm_struct *mm,
>  	}
>
>  	ret = _install_special_mapping(mm, vdso_base, VVAR_SIZE,
> -		(VM_READ | VM_MAYREAD | VM_PFNMAP), vdso_info.dm);
> +		(VM_READ | VM_MAYREAD | VM_PFNMAP), vdso_info->dm);
>  	if (IS_ERR(ret))
>  		goto up_fail;
>
>  	vdso_base += VVAR_SIZE;
>  	mm->context.vdso = (void *)vdso_base;
> +	mm->context.vdso_info = (void *)vdso_info;
> +
>  	ret =
>  	   _install_special_mapping(mm, vdso_base, vdso_text_len,
>  		(VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC),
> -		vdso_info.cm);
> +		vdso_info->cm);
>
>  	if (IS_ERR(ret))
>  		goto up_fail;
> @@ -253,6 +281,24 @@ static int __setup_additional_pages(struct mm_struct *mm,
>  	return PTR_ERR(ret);
>  }
>
> +#ifdef CONFIG_COMPAT
> +int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
> +				       int uses_interp)
> +{
> +	struct mm_struct *mm = current->mm;
> +	int ret;
> +
> +	if (mmap_write_lock_killable(mm))
> +		return -EINTR;
> +
> +	ret = __setup_additional_pages(mm, bprm, uses_interp,
> +							&compat_vdso_info);
> +	mmap_write_unlock(mm);
> +
> +	return ret;
> +}
> +#endif
> +
>  int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>  {
>  	struct mm_struct *mm = current->mm;
> @@ -261,7 +307,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>  	if (mmap_write_lock_killable(mm))
>  		return -EINTR;
>
> -	ret = __setup_additional_pages(mm, bprm, uses_interp);
> +	ret = __setup_additional_pages(mm, bprm, uses_interp, &vdso_info);
>  	mmap_write_unlock(mm);
>
>  	return ret;

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>

As I don't think either of these are big enough of a deal to keep from merging
this.
