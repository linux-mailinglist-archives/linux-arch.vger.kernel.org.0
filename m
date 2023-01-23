Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1506775A9
	for <lists+linux-arch@lfdr.de>; Mon, 23 Jan 2023 08:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjAWHgB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Jan 2023 02:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjAWHgB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Jan 2023 02:36:01 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D531318AB7
        for <linux-arch@vger.kernel.org>; Sun, 22 Jan 2023 23:35:59 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id e3so9859198wru.13
        for <linux-arch@vger.kernel.org>; Sun, 22 Jan 2023 23:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wgOELi+0GLLFDRqtM9K/SOPPwlEPk5gkUlBy27WnbHg=;
        b=B93OkJviOA6e8TpHPeqQjlji4hoLV71Kb4swdlcDUj2ruZmkuPLm+wtIcOaMSikxGX
         zGf75x2K1pBgYlohzbaY80LlAsl0apssgjasj69sed7Rcqkz+f35/psiVWCp/ES777M0
         F/ZYCM25CgrWbYi83KDrTCg3KaYpKfVpg7B4CBm+eLPuKj8ufmjPB+NCVDY6vPSVqnLH
         EqaTHJM879e2ZQFQ6cxN0IY8hwwuxguNcZd5sN/P8Uu7XGSZdlaxOA5+ywT76M9yWBXy
         ArCVGU8yTsV597fRPIGL9OSSflkdbWlCSLRPwY4D7FJHb7oPiyXWI4q7zO9ZCGH5Ev6X
         MxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wgOELi+0GLLFDRqtM9K/SOPPwlEPk5gkUlBy27WnbHg=;
        b=35a/yYWhQ8Agas1SzKY2W/Sh8zy0P/q/7Vq06h+kn8afRR0VM+pJk4YWhsMSPKmd8j
         VKFF0126ceLV7eM2JPaVK6RP2zed6JEe1bttKRDcfVprDuTH24rAIUf+oiIE+30j8J2h
         E79frgMhLCADqbQVnToIK/wA0nonGJ0ZW45czoNod9g08vN+a8wzpr5DcjqnrrFvyUAJ
         Z5RApPC1qAImbpFYXBg4uWfW9tfUkCSe2jF15lR3lwBdtBC1FNxUGfDh8ZaHS2n0q8cI
         6z7O+E11W5uZKNunJFPawKQI/7dbVyL3fU4LEqRPMGuHMRQPHjNoCEjX2Mxdn099/InM
         PzrQ==
X-Gm-Message-State: AFqh2krrjff/GSswnc2F/2z3UBooJjzPvHnstkL0MyFF9d/0NZZRmvJr
        5mDG7bS3r5yw6zu1vvr9Xm8=
X-Google-Smtp-Source: AMrXdXuqSx4yAhQaR73tNlp4h3VYBOLpcs4hjb1mTAIQerCXFQaQnHcLGQeXEz6WGulurruLqj7JGg==
X-Received: by 2002:a05:6000:1708:b0:2bd:daf1:9e4c with SMTP id n8-20020a056000170800b002bddaf19e4cmr22685079wrc.43.1674459358027;
        Sun, 22 Jan 2023 23:35:58 -0800 (PST)
Received: from [192.168.86.94] ([77.137.66.37])
        by smtp.gmail.com with ESMTPSA id e17-20020adfe7d1000000b0024cb961b6aesm4138922wrn.104.2023.01.22.23.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 23:35:57 -0800 (PST)
Message-ID: <ee3844c0-b342-edc6-77cf-4cdc78e30a18@gmail.com>
Date:   Mon, 23 Jan 2023 09:35:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.0
Subject: Re: [PATCH v6 2/5] lazy tlb: allow lazy tlb mm refcounting to be
 configurable
Content-Language: en-US
To:     Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linuxppc-dev@lists.ozlabs.org
References: <20230118080011.2258375-1-npiggin@gmail.com>
 <20230118080011.2258375-3-npiggin@gmail.com>
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20230118080011.2258375-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 1/18/23 10:00 AM, Nicholas Piggin wrote:
> Add CONFIG_MMU_TLB_REFCOUNT which enables refcounting of the lazy tlb mm
> when it is context switched. This can be disabled by architectures that
> don't require this refcounting if they clean up lazy tlb mms when the
> last refcount is dropped. Currently this is always enabled, which is
> what existing code does, so the patch is effectively a no-op.
> 
> Rename rq->prev_mm to rq->prev_lazy_mm, because that's what it is.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   Documentation/mm/active_mm.rst |  6 ++++++
>   arch/Kconfig                   | 17 +++++++++++++++++
>   include/linux/sched/mm.h       | 18 +++++++++++++++---
>   kernel/sched/core.c            | 22 ++++++++++++++++++----
>   kernel/sched/sched.h           |  4 +++-
>   5 files changed, 59 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/mm/active_mm.rst b/Documentation/mm/active_mm.rst
> index 6f8269c284ed..2b0d08332400 100644
> --- a/Documentation/mm/active_mm.rst
> +++ b/Documentation/mm/active_mm.rst
> @@ -4,6 +4,12 @@
>   Active MM
>   =========
>   
> +Note, the mm_count refcount may no longer include the "lazy" users
> +(running tasks with ->active_mm == mm && ->mm == NULL) on kernels
> +with CONFIG_MMU_LAZY_TLB_REFCOUNT=n. Taking and releasing these lazy
> +references must be done with mmgrab_lazy_tlb() and mmdrop_lazy_tlb()
> +helpers which abstracts this config option.
> +
>   ::
>   
>    List:       linux-kernel
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 12e3ddabac9d..b07d36f08fea 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -465,6 +465,23 @@ config ARCH_WANT_IRQS_OFF_ACTIVATE_MM
>   	  irqs disabled over activate_mm. Architectures that do IPI based TLB
>   	  shootdowns should enable this.
>   
> +# Use normal mm refcounting for MMU_LAZY_TLB kernel thread references.
> +# MMU_LAZY_TLB_REFCOUNT=n can improve the scalability of context switching
> +# to/from kernel threads when the same mm is running on a lot of CPUs (a large
> +# multi-threaded application), by reducing contention on the mm refcount.
> +#
> +# This can be disabled if the architecture ensures no CPUs are using an mm as a
> +# "lazy tlb" beyond its final refcount (i.e., by the time __mmdrop frees the mm
> +# or its kernel page tables). This could be arranged by arch_exit_mmap(), or
> +# final exit(2) TLB flush, for example.
> +#
> +# To implement this, an arch *must*:
> +# Ensure the _lazy_tlb variants of mmgrab/mmdrop are used when dropping the
> +# lazy reference of a kthread's ->active_mm (non-arch code has been converted
> +# already).
> +config MMU_LAZY_TLB_REFCOUNT
> +	def_bool y
> +
>   config ARCH_HAVE_NMI_SAFE_CMPXCHG
>   	bool
>   
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 5376caf6fcf3..68bbe8d90c2e 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -82,17 +82,29 @@ static inline void mmdrop_sched(struct mm_struct *mm)
>   /* Helpers for lazy TLB mm refcounting */
>   static inline void mmgrab_lazy_tlb(struct mm_struct *mm)
>   {
> -	mmgrab(mm);
> +	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_REFCOUNT))
> +		mmgrab(mm);
>   }
>   
>   static inline void mmdrop_lazy_tlb(struct mm_struct *mm)
>   {
> -	mmdrop(mm);
> +	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_REFCOUNT)) {
> +		mmdrop(mm);
> +	} else {
> +		/*
> +		 * mmdrop_lazy_tlb must provide a full memory barrier, see the
> +		 * membarrier comment finish_task_switch which relies on this.
> +		 */
> +		smp_mb();
> +	}
>   }

Considering the fact that mmdrop_lazy_tlb() replaced mmdrop() in various 
locations in which smp_mb() was not required, this comment might be 
confusing. IOW, for the cases in most cases where mmdrop_lazy_tlb() 
replaced mmdrop(), this comment was irrelevant, and therefore it now 
becomes confusing.

I am not sure the include the smp_mb() here instead of "open-coding" it 
helps.

>   
>   static inline void mmdrop_lazy_tlb_sched(struct mm_struct *mm)
>   {
> -	mmdrop_sched(mm);
> +	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_REFCOUNT))
> +		mmdrop_sched(mm);
> +	else
> +		smp_mb(); // see above
>   }

Wrong style of comment.
