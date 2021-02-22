Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B8A321C23
	for <lists+linux-arch@lfdr.de>; Mon, 22 Feb 2021 17:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhBVQD0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Feb 2021 11:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbhBVQDV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Feb 2021 11:03:21 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0386C061226;
        Mon, 22 Feb 2021 08:01:48 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id m144so12990742qke.10;
        Mon, 22 Feb 2021 08:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=25yajcnygbYYQGY/GzbdKnoTm6lkCXxAnbhiTFE9e0A=;
        b=i54pwN/HRxHD02bAdKUvwgkWvW2ioxHcbZ03b5FKuOysL2DGBbbTLJ9KzHnKUxsxWZ
         +6t5MqAC/QiaLsUKl2IZiyBQNM8GQoOhpiMS7l8nfLM+OE4dUcEHOU5gL0GTVYDIJRQk
         x1xnDAUYvAjEICfwphEF+3khf5MdRDX3g6Bu/tIU77LFyPdOUNImtKEY5bASOI0zHU9o
         8Jn/THeqEIRPCs8PQNOGlX0QIOcx3oc6suw3NXsq2A34llHqN+GwKq93iLLfGzViiQCi
         LoVmllhsnT18njiXGH59C72TvR1lyqzJNeYxnsf4r/94M9rHAMQEikB/Juzw34S6FgZm
         j3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=25yajcnygbYYQGY/GzbdKnoTm6lkCXxAnbhiTFE9e0A=;
        b=WVI5LJggUlFsxdGuBWh62Rbh3h5yQphrowT4TSuDde1d/7bqM4kK8kZ5DX6dETqMcl
         +mHg7+F6t8/vifljlaB5QI8JiWPQ0lSFWao6vZDhzzOvDs+KFQHBCPkh8oWwMMnP97TF
         lg2q6wqMfip+uZetwnRNTpGJ4VgDCpDKqWNX6jdM3uH6rpt1AwMXF4JXEH8I9Zl134Vl
         hE0fBlthf8UuwwX0NRZxqCxlhcLpHo+4KzJU563vRrHUO9oNacKo0zgV50GQQ7rda2pO
         Hly7UCjzdCp+pPD7wqN4nXZSx+v68p1d6a3JVJL1P8UXOPVy5hhrsBBv1hlH/q4UexgC
         o/XA==
X-Gm-Message-State: AOAM530IZpWOsud6B2CstMghFvFFGe6g4evMoRB5u5X9smvQWLdqI5x3
        a0c+yjaimFPABoNt8nM2+Yg=
X-Google-Smtp-Source: ABdhPJx7vE0DaNGcTC14fkNv0Sd1sTunTUoA8rMwFmf5NWqeV358LsiOecabONA7n9UfGR0UGyMtJQ==
X-Received: by 2002:a05:620a:3d1:: with SMTP id r17mr21732030qkm.256.1614009708000;
        Mon, 22 Feb 2021 08:01:48 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id x3sm1289034qkd.94.2021.02.22.08.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 08:01:47 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id F0E9727C0060;
        Mon, 22 Feb 2021 11:01:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 22 Feb 2021 11:01:46 -0500
X-ME-Sender: <xms:adUzYLMigtGdpe8Mthtz1E0diuJHJSEhEf2ro2XDuLSSU4sie-Z-qg>
    <xme:adUzYAimg8SM1-XF9uMJNdnSc-f_z18cyqUBIjIxJtbT7S2HwrAHF9lF0Ifl6HVhp
    D7SJkgJ94awjryRqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeefgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucfkphepudefuddruddtjedrudegjedruddvieenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:adUzYG3vuMutpwLu3ccd5rDoWOvFcB_03JBUh_1gyxKO4l02h9dwLg>
    <xmx:adUzYCgVl9DRkHip1FSb-HWzEVtsCu8yN9I91nCWdOyu2iK3JkSmAQ>
    <xmx:adUzYOc_zAyUvziYufyTqYrpZlNJSO4stH6qmuhZzMKQm5bgvu3ycw>
    <xmx:atUzYAGI846UUoqmZqNdc1cpef1YKpUPBqo4aGikdyx57pP4Y8LrI8hVpYw>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id D3EFC108005B;
        Mon, 22 Feb 2021 11:01:44 -0500 (EST)
Date:   Tue, 23 Feb 2021 00:01:11 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 09/10] clocksource/drivers/hyper-v: Set clocksource
 rating based on Hyper-V feature
Message-ID: <YDPVRy+QnZzoM+eF@boqun-archlinux>
References: <1611779025-21503-1-git-send-email-mikelley@microsoft.com>
 <1611779025-21503-10-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611779025-21503-10-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 27, 2021 at 12:23:44PM -0800, Michael Kelley wrote:
> On x86/x64, the TSC clocksource is available in a Hyper-V VM only if
> Hyper-V provides the TSC_INVARIANT flag. The rating on the Hyper-V
> Reference TSC page clocksource is currently set so that it will not
> override the TSC clocksource in this case.  Alternatively, if the TSC
> clocksource is not available, then the Hyper-V clocksource is used.
> 
> But on ARM64, the Hyper-V Reference TSC page clocksource should
> override the ARM arch counter, since the Hyper-V clocksource provides
> scaling and offsetting during live migrations that is not provided
> for the ARM arch counter.
> 
> To get the needed behavior for both x86/x64 and ARM64, tweak the
> logic by defaulting the Hyper-V Reference TSC page clocksource
> rating to a large value that will always override.  If the Hyper-V
> TSC_INVARIANT flag is set, then reduce the rating so that it will not
> override the TSC.
> 
> While the logic for getting there is slightly different, the net
> result in the normal cases is no functional change.
> 

One question here, please see below:

> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  drivers/clocksource/hyperv_timer.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index a2bee50..edf2d43 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -302,14 +302,6 @@ void hv_stimer_global_cleanup(void)
>   * the other that uses the TSC reference page feature as defined in the
>   * TLFS.  The MSR version is for compatibility with old versions of
>   * Hyper-V and 32-bit x86.  The TSC reference page version is preferred.
> - *
> - * The Hyper-V clocksource ratings of 250 are chosen to be below the
> - * TSC clocksource rating of 300.  In configurations where Hyper-V offers
> - * an InvariantTSC, the TSC is not marked "unstable", so the TSC clocksource
> - * is available and preferred.  With the higher rating, it will be the
> - * default.  On older hardware and Hyper-V versions, the TSC is marked
> - * "unstable", so no TSC clocksource is created and the selected Hyper-V
> - * clocksource will be the default.
>   */
>  
>  u64 (*hv_read_reference_counter)(void);
> @@ -380,7 +372,7 @@ static int hv_cs_enable(struct clocksource *cs)
>  
>  static struct clocksource hyperv_cs_tsc = {
>  	.name	= "hyperv_clocksource_tsc_page",
> -	.rating	= 250,
> +	.rating	= 500,
>  	.read	= read_hv_clock_tsc_cs,
>  	.mask	= CLOCKSOURCE_MASK(64),
>  	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
> @@ -417,7 +409,7 @@ static u64 notrace read_hv_sched_clock_msr(void)
>  
>  static struct clocksource hyperv_cs_msr = {
>  	.name	= "hyperv_clocksource_msr",
> -	.rating	= 250,
> +	.rating	= 500,

Before this patch, since the ".rating" of hyper_cs_msr is 250 which is
smaller than the TSC clocksource rating, the TSC clocksource is better.
After this patch, in the case where HV_MSR_REFERENCE_TSC_AVAILABLE bit
is 0, we make hyperv_cs_msr better than the TSC clocksource (and we
don't lower the rating of hyperv_cs_msr if TSC_INVARIANT is not
offered), right?  Could you explain why we need the change? Or maybe I'm
missing something?

Regards,
Boqun

>  	.read	= read_hv_clock_msr_cs,
>  	.mask	= CLOCKSOURCE_MASK(64),
>  	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
> @@ -452,6 +444,17 @@ static bool __init hv_init_tsc_clocksource(void)
>  	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
>  		return false;
>  
> +	/*
> +	 * If Hyper-V offers TSC_INVARIANT, then the virtualized TSC correctly
> +	 * handles frequency and offset changes due to live migration,
> +	 * pause/resume, and other VM management operations.  So lower the
> +	 * Hyper-V Reference TSC rating, causing the generic TSC to be used.
> +	 * TSC_INVARIANT is not offered on ARM64, so the Hyper-V Reference
> +	 * TSC will be preferred over the virtualized ARM64 arch counter.
> +	 */
> +	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT)
> +		hyperv_cs_tsc.rating = 250;
> +
>  	hv_read_reference_counter = read_hv_clock_tsc;
>  	phys_addr = virt_to_phys(hv_get_tsc_page());
>  
> -- 
> 1.8.3.1
> 
