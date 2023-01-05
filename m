Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF6665E81D
	for <lists+linux-arch@lfdr.de>; Thu,  5 Jan 2023 10:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjAEJon (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Jan 2023 04:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjAEJom (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Jan 2023 04:44:42 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A63A479F5;
        Thu,  5 Jan 2023 01:44:41 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bt23so37673118lfb.5;
        Thu, 05 Jan 2023 01:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMfPMqVihaiTJlT1Abj1PYS+2gSL2oaYpar/GBI9FMc=;
        b=nBnJF5CP3mfII46U2YiJsG+dbQOu1GeS3wO8pLQuug4Eu7IzE+o4YwWGH3gZsDbY9N
         GlqXGNoKI3shcLNwShp01YS8wcqA/WvHHaf8Gd5zeGhA0/Pzym31fyH7tG4LH0Ys8vhR
         Q+ViAzHnImWSeZee76o7q9xZRR6c6qdDmlxsiVBKO1SnasNEj24YNALLCTpR5RUm1n7I
         +YD9639wlLlTRJKUJDBSM7VA9hhRFnV+ytvp3DKla3jlP5eb/kZ2JaKks0qG1Th/7w/6
         0KwrC61GDy/CJ07gVBtpnLYuELsRbuQtPJ/InI9+zEHuCodD2fJ8ZAqoY7Dw9/HfI1Va
         qIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMfPMqVihaiTJlT1Abj1PYS+2gSL2oaYpar/GBI9FMc=;
        b=vLlN1xbtHvhijXKZyt7Ga+ayj1wsPjWg1vTEYupWJDQPg7Ofc4/vJy5/uI7H9Glt1O
         piVLT7SpEasYaXLDKcWyG0F650KwlCZTJjKBWdG8EI4eXNQDdP6dMQ+aZ7Fk9MCI+4qd
         dEodg1Jp8fYA87o/RUhLzjN4WTAi4kKPrdiywAG+6j/eFmgc0O/ffiorp2xsM4LICGP0
         sKPi3iUVLnzB8aXAJJq0i0wFtzq5VQpeIq9jYV1v3OD8QvkEDsUAQ9kAfRloOdfH+wOX
         3f3cWN7vk2RW82n2yGAGQNziIKS8WvYHRBFysnd9kG4KtFVe/3rM3gxgZGYELhiLmrQ4
         dZlA==
X-Gm-Message-State: AFqh2krJuRAT0yQRIytJLriZLDwZCO8w5eu6bEd236IF/4kUaCWq0U8C
        4JRHU7QdtU5YNwoFoA08v24=
X-Google-Smtp-Source: AMrXdXvfoW6rNC1yIfxetONNLyRdkEsgAM5TYbPLdpGhhnZ6p9YMvu0A+9bMpQADT7R4Jc7NiJBPQQ==
X-Received: by 2002:a19:f609:0:b0:4b5:7672:57ef with SMTP id x9-20020a19f609000000b004b5767257efmr3125936lfe.2.1672911879248;
        Thu, 05 Jan 2023 01:44:39 -0800 (PST)
Received: from localhost (88-115-161-74.elisa-laajakaista.fi. [88.115.161.74])
        by smtp.gmail.com with ESMTPSA id i8-20020a196d08000000b004b523766c23sm5466608lfc.202.2023.01.05.01.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 01:44:39 -0800 (PST)
Date:   Thu, 5 Jan 2023 11:44:35 +0200
From:   Zhi Wang <zhi.wang.linux@gmail.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, haiyangz@microsoft.com, hpa@zytor.com,
        jane.chu@oracle.com, kirill.shutemov@linux.intel.com,
        kys@microsoft.com, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        x86@kernel.org, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org, zhi.a.wang@intel.com
Subject: Re: [PATCH v2 2/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Message-ID: <20230105114435.000078e4@gmail.com>
In-Reply-To: <20221207003325.21503-3-decui@microsoft.com>
References: <20221207003325.21503-1-decui@microsoft.com>
        <20221207003325.21503-3-decui@microsoft.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue,  6 Dec 2022 16:33:21 -0800
Dexuan Cui <decui@microsoft.com> wrote:

> When a TDX guest runs on Hyper-V, the hv_netvsc driver's
> netvsc_init_buf() allocates buffers using vzalloc(), and needs to share
> the buffers with the host OS by calling set_memory_decrypted(), which is
> not working for vmalloc() yet. Add the support by handling the pages one
> by one.
> 

It seems calling set_memory_decrypted() in netvsc_init_buf() is missing in
this patch series. I guess there should be another one extra patch to cover
that.

> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> 
> ---
> 
> Changes in v2:
>   Changed tdx_enc_status_changed() in place.
>   
> Hi, Dave, I checked the huge vmalloc mapping code, but still don't know
> how to get the underlying huge page info (if huge page is in use) and
> try to use PG_LEVEL_2M/1G in try_accept_page() for vmalloc: I checked
> is_vm_area_hugepages() and  __vfree() -> __vunmap(), and I think the
> underlying page allocation info is internal to the mm code, and there
> is no mm API to for me get the info in tdx_enc_status_changed().
> 
> Hi, Kirill, the load_unaligned_zeropad() issue is not addressed in
> this patch. The issue looks like a generic issue that also happens to
> AMD SNP vTOM mode and C-bit mode. Will need to figure out how to
> address the issue. If we decide to adjust direct mapping to have the
> shared bit set, it lools like we need to do the below for each
> 'start_va' vmalloc page:
>   pa = slow_virt_to_phys(start_va);
>   set_memory_decrypted(phys_to_virt(pa), 1); -- this line calls
> tdx_enc_status_changed() the second time for the page, which is bad.
> It looks like we need to find a way to reuse the cpa_flush() related
> code in __set_memory_enc_pgtable() and make sure we call
> tdx_enc_status_changed() only once for a vmalloc page?
> 
>   
>  arch/x86/coco/tdx/tdx.c | 69 ++++++++++++++++++++++++++---------------
>  1 file changed, 44 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index cdeda698d308..795ac56f06b8 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -5,6 +5,7 @@
>  #define pr_fmt(fmt)     "tdx: " fmt
>  
>  #include <linux/cpufeature.h>
> +#include <linux/mm.h>
>  #include <asm/coco.h>
>  #include <asm/tdx.h>
>  #include <asm/vmx.h>
> @@ -693,6 +694,34 @@ static bool try_accept_one(phys_addr_t *start,
> unsigned long len, return true;
>  }
>  
> +static bool try_accept_page(phys_addr_t start, phys_addr_t end)
> +{
> +	/*
> +	 * For shared->private conversion, accept the page using
> +	 * TDX_ACCEPT_PAGE TDX module call.
> +	 */
> +	while (start < end) {
> +		unsigned long len = end - start;
> +
> +		/*
> +		 * Try larger accepts first. It gives chance to VMM to
> keep
> +		 * 1G/2M SEPT entries where possible and speeds up
> process by
> +		 * cutting number of hypercalls (if successful).
> +		 */
> +
> +		if (try_accept_one(&start, len, PG_LEVEL_1G))
> +			continue;
> +
> +		if (try_accept_one(&start, len, PG_LEVEL_2M))
> +			continue;
> +
> +		if (!try_accept_one(&start, len, PG_LEVEL_4K))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  /*
>   * Notify the VMM about page mapping conversion. More info about ABI
>   * can be found in TDX Guest-Host-Communication Interface (GHCI),
> @@ -749,37 +778,27 @@ static bool tdx_map_gpa(phys_addr_t start,
> phys_addr_t end, bool enc) */
>  static bool tdx_enc_status_changed(unsigned long vaddr, int numpages,
> bool enc) {
> -	phys_addr_t start = __pa(vaddr);
> -	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
> +	bool is_vmalloc = is_vmalloc_addr((void *)vaddr);
> +	unsigned long len = numpages * PAGE_SIZE;
> +	void *start_va = (void *)vaddr, *end_va = start_va + len;
> +	phys_addr_t start_pa, end_pa;
>  
> -	if (!tdx_map_gpa(start, end, enc))
> +	if (offset_in_page(start_va) != 0)
>  		return false;
>  
> -	/* private->shared conversion  requires only MapGPA call */
> -	if (!enc)
> -		return true;
> -
> -	/*
> -	 * For shared->private conversion, accept the page using
> -	 * TDX_ACCEPT_PAGE TDX module call.
> -	 */
> -	while (start < end) {
> -		unsigned long len = end - start;
> -
> -		/*
> -		 * Try larger accepts first. It gives chance to VMM to
> keep
> -		 * 1G/2M SEPT entries where possible and speeds up
> process by
> -		 * cutting number of hypercalls (if successful).
> -		 */
> -
> -		if (try_accept_one(&start, len, PG_LEVEL_1G))
> -			continue;
> +	while (start_va < end_va) {
> +		start_pa = is_vmalloc ? slow_virt_to_phys(start_va) :
> +					__pa(start_va);
> +		end_pa = start_pa + (is_vmalloc ? PAGE_SIZE : len);
>  
> -		if (try_accept_one(&start, len, PG_LEVEL_2M))
> -			continue;
> +		if (!tdx_map_gpa(start_pa, end_pa, enc))
> +			return false;
>  
> -		if (!try_accept_one(&start, len, PG_LEVEL_4K))
> +		/* private->shared conversion requires only MapGPA call
> */
> +		if (enc && !try_accept_page(start_pa, end_pa))
>  			return false;
> +
> +		start_va += is_vmalloc ? PAGE_SIZE : len;
>  	}
>  
>  	return true;

