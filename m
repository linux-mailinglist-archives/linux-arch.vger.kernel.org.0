Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F82D4C04F0
	for <lists+linux-arch@lfdr.de>; Tue, 22 Feb 2022 23:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbiBVW4e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Feb 2022 17:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbiBVW4d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Feb 2022 17:56:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DB266AFB;
        Tue, 22 Feb 2022 14:56:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59ECC60BC9;
        Tue, 22 Feb 2022 22:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46CEC340E8;
        Tue, 22 Feb 2022 22:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645570565;
        bh=NRmy3RSn/nbdEABt2HaHzeybpTLaSk8inhbxfo1jZpU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QgxpLl+iLkSrHvtdsG0z8VhK+E0iSmS4f5eb7XHZQD2Y0X+cX0ziliYGN8pxIi7cw
         j5HrxPp8oglQjLa5e9D+cAQcMrYvBwgmI2V1zyF3tDf5MnyCzxwTI/zTT2Onn8N+2f
         li0+mdDFYFNVj27BABhQDzhqHp705Hw7eKxGurt/xCdHJ7xKi31vZlba6kfh0ehyTW
         349nqG5vmahkB3Nk7DALQN1kd9pDu8ewczCwljpLnLSkIQmRwVIkC0+fTIIaVbemVa
         B1hGoDNPfcIgo6GNfffEh1ez6DJJ6EYucDw+lhe+FgGN/nJYjdF3K1b7KYitySEwsz
         HYPmrYzMLXz9g==
Message-ID: <158868e5-257a-1986-4b85-b47b368a5ec7@kernel.org>
Date:   Tue, 22 Feb 2022 16:56:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2 25/30] nios2/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-arch@vger.kernel.org
References: <1645425519-9034-1-git-send-email-anshuman.khandual@arm.com>
 <1645425519-9034-26-git-send-email-anshuman.khandual@arm.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <1645425519-9034-26-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2/21/22 00:38, Anshuman Khandual wrote:
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

Applied!

Thanks,
Dinh
