Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5BB9044C
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2019 17:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfHPPAa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Aug 2019 11:00:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55730 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfHPPA1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Aug 2019 11:00:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id f72so4291105wmf.5
        for <linux-arch@vger.kernel.org>; Fri, 16 Aug 2019 08:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eEktMynsAcH66TtPZndp2mGx6pMeqCeqO+5iafrtukI=;
        b=RfKZ6skhAB1ZgZ6x27FSohEQSQS9goYWUB+/+tsJACDJHruX0U88Pk9tF/TIV5pjdb
         UWESEOqzC46IYRLHA9LYVj7YzgO4W9sf4SGYxol6GxrVMK6I4u9QOIlvmgS0JTPPWbqm
         WEU1Oa2z/dl+K9xwnGuKoit7j3davtBi+q5RTzpOne5jKcCXRdOoKQvnrSbHKuYT1Cnc
         audeblUb7qROlVl8rH4+7IH5h5mg2jmWHM8cUcTP3kuLeS4XPwv+wPGZ3KaohtCVfpzY
         EpirUD1e9NDADqOMmiGa9eP1JV44IZaJ+qF7SU1mpx7XJLSANPchhDLqUBktCOtH4Naf
         KtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=eEktMynsAcH66TtPZndp2mGx6pMeqCeqO+5iafrtukI=;
        b=sUgH/8qtElNgLx+ID1BBgtk0bY81sZZ1OfQ2txUr+AuAnELoLv9Lq5erXft0K9GdcH
         7Lp1dftbsd9hkvLLU0BOgbHaIQlbcDBc3EIXIv/sSMAJmRJHuQXVBCXUgePIbK8mnWzL
         Prz1gQ5HJffjCrGdZq4rWGKxlayUJLiryNAqy/y3zp9rTD3Krank7vAZKv0/BfJkp7dK
         o+2KElrpq8lwnpxF9c8hk4lJ/luD8Bm813UmAVUUbFJjDG7PIDOmG2Z/nWNvBIqjf8ap
         2K7PWUc51HJk5CT4ExkWU9chI0uQJo5rNss1gmpttsT4v4O1rWKdKpL0uiIfVEAgZoxd
         Wz/w==
X-Gm-Message-State: APjAAAVxSWizKdpvnvkxSgmkgfNgIo6uQcVsGzKd4pq0kAJh454lUiIh
        BrI0G2EaH6CNnDoaIbjkzo7YJ2AaR/U=
X-Google-Smtp-Source: APXvYqw9JAzsdIazEnafgTHIxtSU/hEPo+MT5eK5Fu0cwHUxHNxWMumIdjl1WXANg+kI5NVRNzqbQA==
X-Received: by 2002:a1c:238e:: with SMTP id j136mr7792008wmj.144.1565967624558;
        Fri, 16 Aug 2019 08:00:24 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:d4e8:1742:2f00:abef? ([2a01:e34:ed2f:f020:d4e8:1742:2f00:abef])
        by smtp.googlemail.com with ESMTPSA id r16sm12475740wrc.81.2019.08.16.08.00.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 08:00:23 -0700 (PDT)
Subject: Re: [PATCH V2 1/2] clocksource/Hyper-v: Allocate Hyper-V tsc page
 statically
To:     lantianyu1986@gmail.com, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, arnd@arndb.de, michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20190814123216.32245-1-Tianyu.Lan@microsoft.com>
 <20190814123216.32245-2-Tianyu.Lan@microsoft.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <78625f69-550d-212c-d3a0-89356ba98d2a@linaro.org>
Date:   Fri, 16 Aug 2019 17:00:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814123216.32245-2-Tianyu.Lan@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 14/08/2019 14:32, lantianyu1986@gmail.com wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> Prepare to add Hyper-V sched clock callback and move Hyper-V
> Reference TSC initialization much earlier in the boot process.  Earlier
> initialization is needed so that it happens while the timestamp value
> is still 0 and no discontinuity in the timestamp will occur when
> pv_ops.time.sched_clock calculates its offset.  The earlier
> initialization requires that the Hyper-V TSC page be allocated
> statically instead of with vmalloc(), so fixup the references
> to the TSC page and the method of getting its physical address.
> 
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>     Change since v1:
>            - Update commit log
>            - Remove and operation of tsc page's va with PAGE_MASK
> 
>  arch/x86/entry/vdso/vma.c          |  2 +-
>  drivers/clocksource/hyperv_timer.c | 12 ++++--------
>  2 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> index 349a61d8bf34..f5937742b290 100644
> --- a/arch/x86/entry/vdso/vma.c
> +++ b/arch/x86/entry/vdso/vma.c
> @@ -122,7 +122,7 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
>  
>  		if (tsc_pg && vclock_was_used(VCLOCK_HVCLOCK))
>  			return vmf_insert_pfn(vma, vmf->address,
> -					vmalloc_to_pfn(tsc_pg));
> +					virt_to_phys(tsc_pg) >> PAGE_SHIFT);
>  	}
>  
>  	return VM_FAULT_SIGBUS;
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index ba2c79e6a0ee..432aa331df04 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -214,17 +214,17 @@ EXPORT_SYMBOL_GPL(hyperv_cs);
>  
>  #ifdef CONFIG_HYPERV_TSCPAGE
>  
> -static struct ms_hyperv_tsc_page *tsc_pg;
> +static struct ms_hyperv_tsc_page tsc_pg __aligned(PAGE_SIZE);
>  
>  struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
>  {
> -	return tsc_pg;
> +	return &tsc_pg;
>  }
>  EXPORT_SYMBOL_GPL(hv_get_tsc_page);
>  
>  static u64 notrace read_hv_sched_clock_tsc(void)
>  {
> -	u64 current_tick = hv_read_tsc_page(tsc_pg);
> +	u64 current_tick = hv_read_tsc_page(&tsc_pg);
>  
>  	if (current_tick == U64_MAX)
>  		hv_get_time_ref_count(current_tick);
> @@ -280,12 +280,8 @@ static bool __init hv_init_tsc_clocksource(void)
>  	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
>  		return false;
>  
> -	tsc_pg = vmalloc(PAGE_SIZE);
> -	if (!tsc_pg)
> -		return false;
> -
>  	hyperv_cs = &hyperv_cs_tsc;
> -	phys_addr = page_to_phys(vmalloc_to_page(tsc_pg));
> +	phys_addr = virt_to_phys(&tsc_pg);
>  
>  	/*
>  	 * The Hyper-V TLFS specifies to preserve the value of reserved
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

