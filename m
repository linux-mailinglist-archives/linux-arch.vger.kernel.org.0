Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5998231DA1
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jul 2020 13:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgG2Lp6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Jul 2020 07:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG2Lp6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jul 2020 07:45:58 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2203CC061794;
        Wed, 29 Jul 2020 04:45:58 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e8so14104540pgc.5;
        Wed, 29 Jul 2020 04:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rnSHWpSGzohq9BhD/C5rl6PYPh18BOuLPWnyUBOdMSk=;
        b=J+A4zrhh/K095SpdzjX1CgPX766Epnk6LbUcVSeK3q5d0KW6pywZilp6N76R34FIlg
         VqLOX/UjD3jVuyeRpAPygMZp/nq5EulAg2VVaJ7aroMRYqeuIwBI6egsPGPVrBHUDJkD
         /aE2w6XsNBtY884+iLTCYWY81p2t4BQb+si4l+o7hOWx2mNZOLSnIa694qtY6oDKiA04
         04tkBtLi+CZK1xV7bS1dB4+sHL+KaS4cLVI/H2CroCmCFQSHErwzCwxRyAFXP+MSKXV5
         +m7F5PbmbIFc7q8wkYErNJJLFTNvDvJ+mgKbvTTkypkEEXIfPf95yfMvkw7dCsu4aZ4H
         vBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rnSHWpSGzohq9BhD/C5rl6PYPh18BOuLPWnyUBOdMSk=;
        b=g5m+aL3v9F3BadkergCOJPzXX6Vz2pGIKcnDHYeuQu9UDmpGsoYKiEVfQ1IrR2BbIx
         3iNzJjY6g2wPZrBg3YVOJQZOcWHgXXJTdX0W9SX26cykVyB4/vRTPx+/5FfLFxmcPE5s
         bzq+4i1QDyc7px4RkH7kO3MADtsqp3N9eHXKHAsgm4+T8PldkdKjIkEvwznAD9qXM2rZ
         QeByVR+4OLh9J2Z7samlQG/rs0zrYdNzQtY8T38Ta019TlP1O/8YL9oCTHdyJkS0Rvon
         EaiQlqmolhXMVxXHkSrHJjszvh1FHiCFvXmdDCCwff2XukCN9pXQenZ3ZvkZj7oNsMvR
         /2LA==
X-Gm-Message-State: AOAM531Ak9s5OVkq+VeAp3ikcOOr63mtP1/fgCVxKDW75PT5+9KuiY1i
        YZSXLWU3SiWLbExorWeHvho=
X-Google-Smtp-Source: ABdhPJyjQVFbxP+CyHoZIHRWD+Yqf5j/tnegtYmAsoD0wYfkwzMe5cQTFyjC3B/OV628Iaka0B/EeQ==
X-Received: by 2002:a63:6486:: with SMTP id y128mr27631994pgb.82.1596023157675;
        Wed, 29 Jul 2020 04:45:57 -0700 (PDT)
Received: from localhost (g155.222-224-148.ppp.wakwak.ne.jp. [222.224.148.155])
        by smtp.gmail.com with ESMTPSA id i14sm2050136pjz.25.2020.07.29.04.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 04:45:56 -0700 (PDT)
Date:   Wed, 29 Jul 2020 20:45:54 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH 14/24] openrisc: use asm-generic/mmu_context.h for no-op
 implementations
Message-ID: <20200729114554.GG80756@lianli.shorne-pla.net>
References: <20200728033405.78469-1-npiggin@gmail.com>
 <20200728033405.78469-15-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728033405.78469-15-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 28, 2020 at 01:33:55PM +1000, Nicholas Piggin wrote:
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: openrisc@lists.librecores.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/openrisc/include/asm/mmu_context.h | 8 +++-----
>  arch/openrisc/mm/tlb.c                  | 2 ++
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/openrisc/include/asm/mmu_context.h b/arch/openrisc/include/asm/mmu_context.h
> index ced577542e29..a6702384c77d 100644
> --- a/arch/openrisc/include/asm/mmu_context.h
> +++ b/arch/openrisc/include/asm/mmu_context.h
> @@ -17,13 +17,13 @@
>  
>  #include <asm-generic/mm_hooks.h>
>  
> +#define init_new_context init_new_context
>  extern int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
> +#define destroy_context destroy_context
>  extern void destroy_context(struct mm_struct *mm);
>  extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  		      struct task_struct *tsk);
>  
> -#define deactivate_mm(tsk, mm)	do { } while (0)
> -
>  #define activate_mm(prev, next) switch_mm((prev), (next), NULL)
>  
>  /* current active pgd - this is similar to other processors pgd
> @@ -32,8 +32,6 @@ extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  
>  extern volatile pgd_t *current_pgd[]; /* defined in arch/openrisc/mm/fault.c */
>  
> -static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
> -{
> -}
> +#include <asm-generic/mmu_context.h>

This looks ok.

>  #endif
> diff --git a/arch/openrisc/mm/tlb.c b/arch/openrisc/mm/tlb.c
> index 4b680aed8f5f..821aab4cf3be 100644
> --- a/arch/openrisc/mm/tlb.c
> +++ b/arch/openrisc/mm/tlb.c
> @@ -159,6 +159,7 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>   * instance.
>   */
>  
> +#define init_new_context init_new_context
>  int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>  {
>  	mm->context = NO_CONTEXT;
> @@ -170,6 +171,7 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>   * drops it.
>   */
>  
> +#define destroy_context destroy_context
>  void destroy_context(struct mm_struct *mm)
>  {
>  	flush_tlb_mm(mm);

I don't think we need the #define's in the .c file.  Do we?

-Stafford

> -- 
> 2.23.0
> 
