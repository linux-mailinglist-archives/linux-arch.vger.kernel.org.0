Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496B1241FC4
	for <lists+linux-arch@lfdr.de>; Tue, 11 Aug 2020 20:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgHKSfC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Aug 2020 14:35:02 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:29845 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726089AbgHKSfB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Aug 2020 14:35:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597170901; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=Im9yRO9mh487palFvyNYpFQ99DNOmpNy24geWo/2G34=; b=L5BgJW+Kjkztp97sPIGnZMBvgVzUnBcBLjv65qwYOjOqESGlBPE6yyJIqS/BGSAqjG7hcWPS
 KpEcp+bSdy4xNZ3MPRt/4Fkc/1Pe/I49ptoHw6fBbzXwmZHB/ylPyzm6abgPPreKfFfkGkip
 h1xrr3eBXXRnB2wxiHzpRCk4YYw=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5MDNlZiIsICJsaW51eC1hcmNoQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n13.prod.us-east-1.postgun.com with SMTP id
 5f32e4d0ba4c2cd3675f90f8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 11 Aug 2020 18:34:56
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2F637C43395; Tue, 11 Aug 2020 18:34:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from BCAIN (104-54-226-75.lightspeed.austtx.sbcglobal.net [104.54.226.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bcain)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5A230C433C6;
        Tue, 11 Aug 2020 18:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A230C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bcain@codeaurora.org
Reply-To: <bcain@codeaurora.org>
From:   "Brian Cain" <bcain@codeaurora.org>
To:     "'Nicholas Piggin'" <npiggin@gmail.com>,
        <linux-arch@vger.kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        "'Arnd Bergmann'" <arnd@arndb.de>, <linux-hexagon@vger.kernel.org>
References: <20200728033405.78469-1-npiggin@gmail.com> <20200728033405.78469-8-npiggin@gmail.com>
In-Reply-To: <20200728033405.78469-8-npiggin@gmail.com>
Subject: RE: [PATCH 07/24] hexagon: use asm-generic/mmu_context.h for no-op implementations
Date:   Tue, 11 Aug 2020 13:34:52 -0500
Message-ID: <037d01d6700e$1af0a580$50d1f080$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIkqsFHYugh5s2ey2Pj0VF04P8MggLS7NLsqIAvKQA=
Content-Language: en-us
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> -----Original Message-----
> From: linux-arch-owner@vger.kernel.org <linux-arch-owner@vger.kernel.org>
> On Behalf Of Nicholas Piggin

Acked-by: Brian Cain <bcain@codeaurora.org>

 
> Cc: Brian Cain <bcain@codeaurora.org>
> Cc: linux-hexagon@vger.kernel.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/hexagon/include/asm/mmu_context.h | 33 ++++----------------------
>  1 file changed, 5 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/hexagon/include/asm/mmu_context.h
> b/arch/hexagon/include/asm/mmu_context.h
> index cdc4adc0300a..81947764c47d 100644
> --- a/arch/hexagon/include/asm/mmu_context.h
> +++ b/arch/hexagon/include/asm/mmu_context.h
> @@ -15,39 +15,13 @@
>  #include <asm/pgalloc.h>
>  #include <asm/mem-layout.h>
> 
> -static inline void destroy_context(struct mm_struct *mm) -{ -}
> -
>  /*
>   * VM port hides all TLB management, so "lazy TLB" isn't very
>   * meaningful.  Even for ports to architectures with visble TLBs,
>   * this is almost invariably a null function.
> + *
> + * mm->context is set up by pgd_alloc, so no init_new_context required.
>   */
> -static inline void enter_lazy_tlb(struct mm_struct *mm,
> -	struct task_struct *tsk)
> -{
> -}
> -
> -/*
> - * Architecture-specific actions, if any, for memory map deactivation.
> - */
> -static inline void deactivate_mm(struct task_struct *tsk,
> -	struct mm_struct *mm)
> -{
> -}
> -
> -/**
> - * init_new_context - initialize context related info for new mm_struct
> instance
> - * @tsk: pointer to a task struct
> - * @mm: pointer to a new mm struct
> - */
> -static inline int init_new_context(struct task_struct *tsk,
> -					struct mm_struct *mm)
> -{
> -	/* mm->context is set up by pgd_alloc */
> -	return 0;
> -}
> 
>  /*
>   *  Switch active mm context
> @@ -74,6 +48,7 @@ static inline void switch_mm(struct mm_struct *prev,
> struct mm_struct *next,
>  /*
>   *  Activate new memory map for task
>   */
> +#define activate_mm activate_mm
>  static inline void activate_mm(struct mm_struct *prev, struct mm_struct
> *next)  {
>  	unsigned long flags;
> @@ -86,4 +61,6 @@ static inline void activate_mm(struct mm_struct *prev,
> struct mm_struct *next)
>  /*  Generic hooks for arch_dup_mmap and arch_exit_mmap  */  #include
> <asm-generic/mm_hooks.h>
> 
> +#include <asm-generic/mmu_context.h>
> +
>  #endif
> --
> 2.23.0


