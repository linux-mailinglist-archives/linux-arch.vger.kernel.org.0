Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0192A84FA
	for <lists+linux-arch@lfdr.de>; Thu,  5 Nov 2020 18:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731694AbgKEReC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Nov 2020 12:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731672AbgKEReC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Nov 2020 12:34:02 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D70EC0613CF
        for <linux-arch@vger.kernel.org>; Thu,  5 Nov 2020 09:34:02 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id f12so426357pjp.4
        for <linux-arch@vger.kernel.org>; Thu, 05 Nov 2020 09:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=BNUKSCGWkc6CIawczqK2wZtYLRe3Vlhmmh+CKSA+3+c=;
        b=lzbVQmsnHGQrz4/Uh0fYZi54IjSFhyftDYTHwIkpshJXq9uFE86Pa9KWtVjBqWJ7yd
         onq3vAXQjTajSdGzQNX20E/F+aTUTqCib4eZOiqNtlC/7QkS53dFygSpG/W3sUaNJt5c
         qziTHhbP7erX23zyVe1C/vgsPyjRg7S59nO505Ef8FRnRDFDEHb7eJus9H8y7UOL0GcD
         kz5bw5d7wVOPW8Ro0wVtFiDoGvk6pa/TQguCGQJNwdYqoy8N7CCh6wwBSGCc2nivqMeC
         LVMIsZUmFNl9BJeJW24JmrCWWop64Jw79jkqnvLrQ4fzrQemdE2L/D6hiptAVeXhATd9
         9EXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=BNUKSCGWkc6CIawczqK2wZtYLRe3Vlhmmh+CKSA+3+c=;
        b=PiycsohpaTGJp2PjF9D9cf194Mbe5MiZP/bsUJEa2ee7bdoAmJa7bl4WCjH0JRoWlR
         DSZXC3Ra2y1uVIPqCH9gXsJCSR6iWkO1p4/Dh57lahhACOBtmKr2xOUmcy5K+z52SMPD
         GRTnUHPaF27Saz7X4QqM8uujzpQULABdvMDN1KlMyaDuWIyMMq0PnM1BM/7TKz1ndfW7
         Mx5s3quohBRl5cbukWX9tFH2indyNGzvQF2FPuLcyojCaQvyY/NcTVKvGlax7cUpiNIT
         wi+39TclJtkxlDAoanv5PHPd3lFN/YDuMqLuUsT4nshlliZF/zUjx15IvepwlsJRt08H
         zDiA==
X-Gm-Message-State: AOAM530D9kgjgFBQMDTTlgQOrRVKtgfiJpWixEKSjPYtld1nNzP0YL2X
        gxabIL10yLL3sowu5e9NAXuRBA==
X-Google-Smtp-Source: ABdhPJylFsENw71w4yVASLj+rnk7or2cMT1g74UPVnCfF46/UVvMxhFTOGNn7sZscCvrZhuorInUWg==
X-Received: by 2002:a17:902:23:b029:d6:2387:55e1 with SMTP id 32-20020a1709020023b02900d6238755e1mr3120958pla.8.1604597641453;
        Thu, 05 Nov 2020 09:34:01 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id c11sm2964888pgl.20.2020.11.05.09.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 09:34:00 -0800 (PST)
Date:   Thu, 05 Nov 2020 09:34:00 -0800 (PST)
X-Google-Original-Date: Wed, 04 Nov 2020 14:01:41 PST (-0800)
Subject:     Re: [PATCH v4 3/5] riscv: Separate memory init from paging init
In-Reply-To: <20201006001752.248564-4-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        greentime.hu@sifive.com, aou@eecs.berkeley.edu,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        anup@brainfault.org, Arnd Bergmann <arnd@arndb.de>,
        catalin.marinas@arm.com, david@redhat.com,
        Greg KH <gregkh@linuxfoundation.org>, justin.he@arm.com,
        Jonathan.Cameron@huawei.com, wangkefeng.wang@huawei.com,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        rppt@kernel.org, nsaenzjulienne@suse.de,
        Paul Walmsley <paul.walmsley@sifive.com>, rafael@kernel.org,
        steven.price@arm.com, will@kernel.org, zong.li@sifive.com,
        linux-arm-kernel@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-f811a008-fd0c-4e85-b48d-4f2c476c1c65@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 05 Oct 2020 17:17:50 PDT (-0700), Atish Patra wrote:
> Currently, we perform some memory init functions in paging init. But,
> that will be an issue for NUMA support where DT needs to be flattened
> before numa initialization and memblock_present can only be called
> after numa initialization.
>
> Move memory initialization related functions to a separate function.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  arch/riscv/include/asm/pgtable.h | 1 +
>  arch/riscv/kernel/setup.c        | 1 +
>  arch/riscv/mm/init.c             | 6 +++++-
>  3 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index eaea1f717010..515b42f98d34 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -466,6 +466,7 @@ static inline void __kernel_map_pages(struct page *page, int numpages, int enabl
>  extern void *dtb_early_va;
>  void setup_bootmem(void);
>  void paging_init(void);
> +void misc_mem_init(void);
>
>  #define FIRST_USER_ADDRESS  0
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 2c6dd329312b..07fa6d13367e 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -78,6 +78,7 @@ void __init setup_arch(char **cmdline_p)
>  #else
>  	unflatten_device_tree();
>  #endif
> +	misc_mem_init();
>
>  #ifdef CONFIG_SWIOTLB
>  	swiotlb_init(1);
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index ed6e83871112..114c3966aadb 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -565,8 +565,12 @@ static void __init resource_init(void)
>  void __init paging_init(void)
>  {
>  	setup_vm_final();
> -	sparse_init();
>  	setup_zero_page();
> +}
> +
> +void __init misc_mem_init(void)
> +{
> +	sparse_init();
>  	zone_sizes_init();
>  	resource_init();
>  }

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
