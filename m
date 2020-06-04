Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1011C1EEA10
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jun 2020 20:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbgFDSEj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Jun 2020 14:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730055AbgFDSEi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Jun 2020 14:04:38 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4FFC08C5C0;
        Thu,  4 Jun 2020 11:04:38 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i12so1459338pju.3;
        Thu, 04 Jun 2020 11:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rD8xuTgnZ6MvQvEnMb+rcASld4ronehkugR1bak9iF4=;
        b=fMbfz5xtWwcFx1lkzWMOzCVDlzqu2GYk/fZ0yKlBIL/eJw7AQlXPM2ornec0YYgVg7
         UYGQJ4ce7zktK+/93Nyb3PS/m2PGda6kaaZjjKvMBFSQC+5ryhUsnt7DThlQNA+R0LYy
         XCOeVDZckgIwHBWGyTdygX0wfKPfra4o7dlq1L9ooD+CeRgcbkE7Twjb7pCQfjzeXoLG
         DzwVK0l56ba8mx/b0odQND6lKJArXIcdxw8cT5vRrUzCKY2EeI60IrU3p/lzvHw2cDjL
         z61/A872SA93qHPX+YEF1qSZkUOOlTvrcJT4nP7tq+k2Mbmg+QKA2emmCuXl+HTOtxOF
         iTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rD8xuTgnZ6MvQvEnMb+rcASld4ronehkugR1bak9iF4=;
        b=ZO4dpcHEnIjkKcUbjU2nmfDxY9HZlgShCvO97sc+kiyRIYwuk1bUXeZuJ5OWEQWXZy
         5ykHqAy1hybGVzhOww11K/GJ2PNy4SZuOqkExf9SNqKYOKHfjM+mCBJaAXBQTvPF6tbw
         iZ/LpeiPQcwy5pjKuZSbHObFAIXszEm2UNuH/u3eW6Oldzpn2Yv6Vvtjgh8MbriEzD/i
         G1/DLNgXw9no3Mq9151YffOMs4l93HW2/3/pU+vI0NOYMQmxRHWWRlYVxfW1upjMFd+w
         JvcQ+vIwfmBDUnDf+Bh6YvUF0yXHIAo7Bw8D1J0HfC8Ci9hjHp9CxA/6Y64hYEpmlP9S
         2M4A==
X-Gm-Message-State: AOAM5304uf/Ia+RFMuykORUSF+A7owShfhmZzaxHyE69tPyQk7j9zc1z
        ODvzC4GkQtYQsx7veRvO3Fw=
X-Google-Smtp-Source: ABdhPJz0+8tBh768mrEJ585mQCjvZcm0WkxiKChW8xM5bO8f66+aggOYu3pZxcjJ7Ue5X/xjt/lBfg==
X-Received: by 2002:a17:90a:b013:: with SMTP id x19mr7609215pjq.229.1591293878091;
        Thu, 04 Jun 2020 11:04:38 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g9sm3932309pfm.151.2020.06.04.11.04.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jun 2020 11:04:37 -0700 (PDT)
Date:   Thu, 4 Jun 2020 11:04:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterz@infradead.org,
        jroedel@suse.de, Andy Lutomirski <luto@kernel.org>,
        Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        manvanth@linux.vnet.ibm.com, linux-next@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        linuxppc-dev@lists.ozlabs.org, hch@lst.de,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: Fix pud_alloc_track()
Message-ID: <20200604180435.GA219656@roeck-us.net>
References: <20200604074446.23944-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604074446.23944-1-joro@8bytes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 04, 2020 at 09:44:46AM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The pud_alloc_track() needs to do different checks based on whether
> __ARCH_HAS_5LEVEL_HACK is defined, like it already does in
> pud_alloc(). Otherwise it causes boot failures on PowerPC.
> 
> Provide the correct implementations for both possible settings of
> __ARCH_HAS_5LEVEL_HACK to fix the boot problems.
> 
> Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> Tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> Tested-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> Fixes: d8626138009b ("mm: add functions to track page directory modifications")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  include/asm-generic/5level-fixup.h |  5 +++++
>  include/linux/mm.h                 | 26 +++++++++++++-------------
>  2 files changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/include/asm-generic/5level-fixup.h b/include/asm-generic/5level-fixup.h
> index 58046ddc08d0..afbab31fbd7e 100644
> --- a/include/asm-generic/5level-fixup.h
> +++ b/include/asm-generic/5level-fixup.h
> @@ -17,6 +17,11 @@
>  	((unlikely(pgd_none(*(p4d))) && __pud_alloc(mm, p4d, address)) ? \
>  		NULL : pud_offset(p4d, address))
>  
> +#define pud_alloc_track(mm, p4d, address, mask)					\
> +	((unlikely(pgd_none(*(p4d))) &&						\
> +	  (__pud_alloc(mm, p4d, address) || ({*(mask)|=PGTBL_P4D_MODIFIED;0;})))?	\
> +	  NULL : pud_offset(p4d, address))
> +
>  #define p4d_alloc(mm, pgd, address)		(pgd)
>  #define p4d_alloc_track(mm, pgd, address, mask)	(pgd)
>  #define p4d_offset(pgd, start)			(pgd)
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 66e0977f970a..ad3b31c5bcc3 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2088,35 +2088,35 @@ static inline pud_t *pud_alloc(struct mm_struct *mm, p4d_t *p4d,
>  		NULL : pud_offset(p4d, address);
>  }
>  
> -static inline p4d_t *p4d_alloc_track(struct mm_struct *mm, pgd_t *pgd,
> +static inline pud_t *pud_alloc_track(struct mm_struct *mm, p4d_t *p4d,
>  				     unsigned long address,
>  				     pgtbl_mod_mask *mod_mask)
> -
>  {
> -	if (unlikely(pgd_none(*pgd))) {
> -		if (__p4d_alloc(mm, pgd, address))
> +	if (unlikely(p4d_none(*p4d))) {
> +		if (__pud_alloc(mm, p4d, address))
>  			return NULL;
> -		*mod_mask |= PGTBL_PGD_MODIFIED;
> +		*mod_mask |= PGTBL_P4D_MODIFIED;
>  	}
>  
> -	return p4d_offset(pgd, address);
> +	return pud_offset(p4d, address);
>  }
>  
> -#endif /* !__ARCH_HAS_5LEVEL_HACK */
> -
> -static inline pud_t *pud_alloc_track(struct mm_struct *mm, p4d_t *p4d,
> +static inline p4d_t *p4d_alloc_track(struct mm_struct *mm, pgd_t *pgd,
>  				     unsigned long address,
>  				     pgtbl_mod_mask *mod_mask)
> +
>  {
> -	if (unlikely(p4d_none(*p4d))) {
> -		if (__pud_alloc(mm, p4d, address))
> +	if (unlikely(pgd_none(*pgd))) {
> +		if (__p4d_alloc(mm, pgd, address))
>  			return NULL;
> -		*mod_mask |= PGTBL_P4D_MODIFIED;
> +		*mod_mask |= PGTBL_PGD_MODIFIED;
>  	}
>  
> -	return pud_offset(p4d, address);
> +	return p4d_offset(pgd, address);
>  }
>  
> +#endif /* !__ARCH_HAS_5LEVEL_HACK */
> +
>  static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
>  {
>  	return (unlikely(pud_none(*pud)) && __pmd_alloc(mm, pud, address))?
> -- 
> 2.26.2
> 
