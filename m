Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5966F4C3AFB
	for <lists+linux-arch@lfdr.de>; Fri, 25 Feb 2022 02:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbiBYBc3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Feb 2022 20:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbiBYBcV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Feb 2022 20:32:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1EA4A923;
        Thu, 24 Feb 2022 17:31:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F09D660F01;
        Fri, 25 Feb 2022 01:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22C5C340F0;
        Fri, 25 Feb 2022 01:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645752709;
        bh=3AAPf7WkSDBU47MasXkUqlVc+MASq7jzM/CbTcX6ooM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ScwlZhwtdWXtWq7plCxg8/+Li9LCokWs9aZi1UQlDC4f/GB4PFGju2PlGN6lxf4YI
         O+Ui8gRPpUYSrxfFp4jchgbYurTXPBpu3zA1Wqy1v/vqzAl9qQeAqOfbuhbl4fidMn
         adMhIwzHGoRR7ozritc4CpwIF5n2N9vvYZXeOc+Gna2PaC28t/++nlIdWpU1afUw4B
         XFFvqRx33AeRFOvnCBBrNEzHOBTE3j6fRyUfyG/yWOZ5xuE1GKM4M+ol6CA0NC7xCo
         1I3zMoAUjtYSP7rdRF7E+OG1Df3YI89/GkNBLpzWPJ6uonF8FR4VkN+FLzViysg1B/
         Cp1jGHPdOgmxA==
Message-ID: <50ac6dc2-7c71-2a8b-aa00-78926351b252@kernel.org>
Date:   Thu, 24 Feb 2022 19:31:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 25/30] nios2/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org
References: <1644805853-21338-1-git-send-email-anshuman.khandual@arm.com>
 <1644805853-21338-26-git-send-email-anshuman.khandual@arm.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <1644805853-21338-26-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Anshuman,

On 2/13/22 20:30, Anshuman Khandual wrote:
> This defines and exports a platform specific custom vm_get_page_prot() via
> subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
> macros can be dropped which are no longer needed.
> 
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Acked-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>   arch/nios2/Kconfig               |  1 +
>   arch/nios2/include/asm/pgtable.h | 16 ------------
>   arch/nios2/mm/init.c             | 45 ++++++++++++++++++++++++++++++++
>   3 files changed, 46 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
> index 33fd06f5fa41..85a58a357a3b 100644
> --- a/arch/nios2/Kconfig
> +++ b/arch/nios2/Kconfig
> @@ -6,6 +6,7 @@ config NIOS2
>   	select ARCH_HAS_SYNC_DMA_FOR_CPU
>   	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>   	select ARCH_HAS_DMA_SET_UNCACHED
> +	select ARCH_HAS_VM_GET_PAGE_PROT
>   	select ARCH_NO_SWAP
>   	select COMMON_CLK
>   	select TIMER_OF
> diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
> index 4a995fa628ee..2678dad58a63 100644
> --- a/arch/nios2/include/asm/pgtable.h
> +++ b/arch/nios2/include/asm/pgtable.h
> @@ -40,24 +40,8 @@ struct mm_struct;
>    */
>   
>   /* Remove W bit on private pages for COW support */
> -#define __P000	MKP(0, 0, 0)
> -#define __P001	MKP(0, 0, 1)
> -#define __P010	MKP(0, 0, 0)	/* COW */
> -#define __P011	MKP(0, 0, 1)	/* COW */
> -#define __P100	MKP(1, 0, 0)
> -#define __P101	MKP(1, 0, 1)
> -#define __P110	MKP(1, 0, 0)	/* COW */
> -#define __P111	MKP(1, 0, 1)	/* COW */
>   
>   /* Shared pages can have exact HW mapping */
> -#define __S000	MKP(0, 0, 0)
> -#define __S001	MKP(0, 0, 1)
> -#define __S010	MKP(0, 1, 0)
> -#define __S011	MKP(0, 1, 1)
> -#define __S100	MKP(1, 0, 0)
> -#define __S101	MKP(1, 0, 1)
> -#define __S110	MKP(1, 1, 0)
> -#define __S111	MKP(1, 1, 1)
>   
>   /* Used all over the kernel */
>   #define PAGE_KERNEL __pgprot(_PAGE_PRESENT | _PAGE_CACHED | _PAGE_READ | \
> diff --git a/arch/nios2/mm/init.c b/arch/nios2/mm/init.c
> index 613fcaa5988a..311b2146a248 100644
> --- a/arch/nios2/mm/init.c
> +++ b/arch/nios2/mm/init.c
> @@ -124,3 +124,48 @@ const char *arch_vma_name(struct vm_area_struct *vma)
>   {
>   	return (vma->vm_start == KUSER_BASE) ? "[kuser]" : NULL;
>   }
> +
> +pgprot_t vm_get_page_prot(unsigned long vm_flags)
> +{
> +	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
> +	case VM_NONE:
> +		return MKP(0, 0, 0);
> +	case VM_READ:
> +		return MKP(0, 0, 1);
> +	/* COW */
> +	case VM_WRITE:
> +		return MKP(0, 0, 0);
> +	/* COW */
> +	case VM_WRITE | VM_READ:
> +		return MKP(0, 0, 1);
> +	case VM_EXEC:
> +		return MKP(1, 0, 0);
> +	case VM_EXEC | VM_READ:
> +		return MKP(1, 0, 1);
> +	/* COW */
> +	case VM_EXEC | VM_WRITE:
> +		return MKP(1, 0, 0);
> +	/* COW */
> +	case VM_EXEC | VM_WRITE | VM_READ:
> +		return MKP(1, 0, 1);
> +	case VM_SHARED:
> +		return MKP(0, 0, 0);
> +	case VM_SHARED | VM_READ:
> +		return MKP(0, 0, 1);
> +	case VM_SHARED | VM_WRITE:
> +		return MKP(0, 1, 0);
> +	case VM_SHARED | VM_WRITE | VM_READ:
> +		return MKP(0, 1, 1);
> +	case VM_SHARED | VM_EXEC:
> +		return MKP(1, 0, 0);
> +	case VM_SHARED | VM_EXEC | VM_READ:
> +		return MKP(1, 0, 1);
> +	case VM_SHARED | VM_EXEC | VM_WRITE:
> +		return MKP(1, 1, 0);
> +	case VM_SHARED | VM_EXEC | VM_WRITE | VM_READ:
> +		return MKP(1, 1, 1);
> +	default:
> +		BUILD_BUG();
> +	}
> +}
> +EXPORT_SYMBOL(vm_get_page_prot);

I'm getting this compile error after applying this patch when build NIOS2:


mm/mmap.c:105:2: error: ‘__P000’ undeclared here (not in a function)

   105 |  __P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,

       |  ^~~~~~

mm/mmap.c:105:10: error: ‘__P001’ undeclared here (not in a function)

   105 |  __P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,

       |          ^~~~~~

mm/mmap.c:105:18: error: ‘__P010’ undeclared here (not in a function)

   105 |  __P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,

       |                  ^~~~~~

   AR      fs/devpts/built-in.a

mm/mmap.c:105:26: error: ‘__P011’ undeclared here (not in a function)

   105 |  __P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,

       |                          ^~~~~~

mm/mmap.c:105:34: error: ‘__P100’ undeclared here (not in a function)

   105 |  __P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,

       |                                  ^~~~~~

mm/mmap.c:105:42: error: ‘__P101’ undeclared here (not in a function)

   105 |  __P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,

       |                                          ^~~~~~

mm/mmap.c:105:50: error: ‘__P110’ undeclared here (not in a function)

   105 |  __P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,

       |                                                  ^~~~~~

mm/mmap.c:105:58: error: ‘__P111’ undeclared here (not in a function)

   105 |  __P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,

       |                                                          ^~~~~~

mm/mmap.c:106:2: error: ‘__S000’ undeclared here (not in a function)

   106 |  __S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111

       |  ^~~~~~

mm/mmap.c:106:10: error: ‘__S001’ undeclared here (not in a function)

   106 |  __S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111



Dinh
