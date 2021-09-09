Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9CB140451A
	for <lists+linux-arch@lfdr.de>; Thu,  9 Sep 2021 07:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350824AbhIIFjs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Sep 2021 01:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23831 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350792AbhIIFjr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Sep 2021 01:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631165918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BfCn6Kdj9U6+wyRq6rGqDZVU0uEjDmVJjKfyDttwqj4=;
        b=VmTMOcDnTb7EW0iAI6E5i+0DLaA5qrr/M1gBc+zIpHxt19SCB6PsWUBolj/vVy5GQfMPfr
        dhdU0pcSZx34o7N8Tr9yElBssgcZjtpKF9rDZYQsnH1wEzf5vMutz0c2WKmPNeyzpWuq5m
        UbTuQ38rihJJjP6bOtjoEYOxrucOvwg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-tXLY1QEyPOaYZFxroNsMfA-1; Thu, 09 Sep 2021 01:38:36 -0400
X-MC-Unique: tXLY1QEyPOaYZFxroNsMfA-1
Received: by mail-wm1-f69.google.com with SMTP id m22-20020a7bca56000000b002e7508f3faeso324887wml.2
        for <linux-arch@vger.kernel.org>; Wed, 08 Sep 2021 22:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=BfCn6Kdj9U6+wyRq6rGqDZVU0uEjDmVJjKfyDttwqj4=;
        b=8D851qr3dOHgjJc9cU1UWCxH/1Blp8ItV8PO5Gi5QeRP9QWgmb25P5B39cymFCSir9
         3gmfbBQ8h39506Zrxa8Adb8UpJFqangFQmbeisb5NwUQd+l2IRcfcNQWrhwZn/Pm7IOh
         0EQKnfWJHwwch+C8SkYce5v/KDRChDbeLbbJ/IEEk7QbAN5hJLgSWpqfPitAv0D6XmFx
         F9+XOCL+phqU1gdaNAdGOSNc61jBnoQKucTz0Zste3YoYnRtXh+m3ZFUo82jYBaIpoHB
         dwpT+NybkDXFs0AfEIYX28UzvCNofuWoGDlK1NCWyRpMa4jHjgsGy3vhTukTsfqwp27c
         cVmA==
X-Gm-Message-State: AOAM531c88rwdCJWHfqI/S3s+uG5+mEPDOb5ZV5LO/V7NobUMfeyaYFw
        hF0rpBH+U34ijpIEDw4mJ/aSdKfdopKkJr7DToNPkhpWBWxrglDK4L1hxvKGGayE1a6bSl3H3K+
        NMxvfvhzwwkw9eh940CVh5A==
X-Received: by 2002:a05:600c:4ece:: with SMTP id g14mr949953wmq.6.1631165915839;
        Wed, 08 Sep 2021 22:38:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiQhiOIlpAuX8rpt3T7XtP8J6o3lWikUicYoSmXpx5dZWBi4uCbKfDGS7P3ZII3II9uJU7Ig==
X-Received: by 2002:a05:600c:4ece:: with SMTP id g14mr949943wmq.6.1631165915665;
        Wed, 08 Sep 2021 22:38:35 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id t14sm650634wrw.59.2021.09.08.22.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 22:38:35 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Wei Liu <wei.liu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] asm-generic/hyperv: provide cpumask_to_vpset_noself
In-Reply-To: <20210908194243.238523-2-wei.liu@kernel.org>
References: <20210908194243.238523-1-wei.liu@kernel.org>
 <20210908194243.238523-2-wei.liu@kernel.org>
Date:   Thu, 09 Sep 2021 07:38:28 +0200
Message-ID: <871r5y48bv.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> This is a new variant which removes `self' cpu from the vpset. It will
> be used in Hyper-V enlightened IPI code.
>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> Provide a new variant instead of adding a new parameter because it makes
> it easier to backport -- we don't need to fix the users of
> cpumask_to_vpset.
> ---
>  include/asm-generic/mshyperv.h | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index 9a000ba2bb75..d89690ee95aa 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -184,10 +184,12 @@ static inline int hv_cpu_number_to_vp_number(int cpu_number)
>  	return hv_vp_index[cpu_number];
>  }
>  
> -static inline int cpumask_to_vpset(struct hv_vpset *vpset,
> -				    const struct cpumask *cpus)
> +static inline int cpumask_to_vpset_ex(struct hv_vpset *vpset,

I'd suggest to avoid '_ex' suffix as we use it for 'extended hypercalls'
(e.g. __send_ipi_mask_ex). Assuming nobody needs to call
cpumask_to_vpset_ex() directly, should we just go with
__cpumask_to_vpset() instead?

> +				    const struct cpumask *cpus,
> +				    bool exclude_self)
>  {
>  	int cpu, vcpu, vcpu_bank, vcpu_offset, nr_bank = 1;
> +	int this_cpu = smp_processor_id();
>  
>  	/* valid_bank_mask can represent up to 64 banks */
>  	if (hv_max_vp_index / 64 >= 64)
> @@ -205,6 +207,8 @@ static inline int cpumask_to_vpset(struct hv_vpset *vpset,
>  	 * Some banks may end up being empty but this is acceptable.
>  	 */
>  	for_each_cpu(cpu, cpus) {
> +		if (exclude_self && cpu == this_cpu)
> +			continue;
>  		vcpu = hv_cpu_number_to_vp_number(cpu);
>  		if (vcpu == VP_INVAL)
>  			return -1;
> @@ -219,6 +223,18 @@ static inline int cpumask_to_vpset(struct hv_vpset *vpset,
>  	return nr_bank;
>  }
>  
> +static inline int cpumask_to_vpset(struct hv_vpset *vpset,
> +				    const struct cpumask *cpus)
> +{
> +	return cpumask_to_vpset_ex(vpset, cpus, false);
> +}
> +
> +static inline int cpumask_to_vpset_noself(struct hv_vpset *vpset,
> +				    const struct cpumask *cpus)
> +{
> +	return cpumask_to_vpset_ex(vpset, cpus, true);


We need to make sure this is called with preemption disabled. We
could've just swapped smp_processor_id() for get_cpu() in
cpumask_to_vpset_ex() but this is hardly a solution: we can get
preempted right after put_cpu() so it's really the caller of this
function which needs to be protected.

TL;DR: I suggest we add 'WARN_ON_ONCE(preemptible());' or something like
this here to catch wrong usage.

> +}
> +
>  void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die);
>  bool hv_is_hyperv_initialized(void);
>  bool hv_is_hibernation_supported(void);

-- 
Vitaly

