Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B26D2B0834
	for <lists+linux-arch@lfdr.de>; Thu, 12 Nov 2020 16:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgKLPO3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Nov 2020 10:14:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42458 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728220AbgKLPO3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Nov 2020 10:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605194068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fWIN7/Nq/yeoyKpiKidMDeDSC6wVzNUm+jANJbo9SZs=;
        b=DU8SerBNIEIACZD4gkrnIPiAiM6prlvmF7lPUGZbZCl2utgnViNpIYxxVNDHyakEB1LgQ3
        iau/QYuQb31KcENbs9Ode9CxEc05NoC8J7O8KpuApKCb1ZaVVEfLdhJE68l+Qt9GeV7+ln
        b9XQI+lyj+eos78juxups3xH8FUx/lc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-U-JhpbX3P3mdjvRh0DYO5Q-1; Thu, 12 Nov 2020 10:14:26 -0500
X-MC-Unique: U-JhpbX3P3mdjvRh0DYO5Q-1
Received: by mail-wr1-f69.google.com with SMTP id c8so2067532wrh.16
        for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2020 07:14:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=fWIN7/Nq/yeoyKpiKidMDeDSC6wVzNUm+jANJbo9SZs=;
        b=NFhiSBFuwg2wc9DSRatSEvTamo9N12F+I55Cce+KoOjLfglGN7SoS783rPCnHwJ7Kn
         7ei72E4AJWhhQbsVcWsa6tXxQF0PobWsHPGZ3us585QwTuSyktZzlpc975cppaYxfQMm
         BuF7QFSYOtGt5sEodJAOlYxU8mgvyUv2UozK9U4iZg+n5Y+ae9F634NsGmY6E4kvoEmF
         jZDlcOWd+l5ar+XHI3zBd9uq9acRRQBf2VEKcCYbJ64itaMbdDQzjGQ7yWbD7OrsLafa
         eZwhkFqGV0hF3pPV24BytgSjuKi5WsN5sSvb+ECqMT1ahLVyXuWG5IPgHTRLn86m5T1B
         Fq3Q==
X-Gm-Message-State: AOAM531tIEtmBrofzHRjuSditayWZuVrb2S6aG8RlRkeVfBuEokE0pcb
        /id40+8cznXEZptzlKilrHGNIJ2usgKCJZTlD3hVHxYTh/s8rpDmFSXwowd08i69LNl1ecMpTop
        3AlS591iG9TJtIi7pRjSFuSPXPe57TEh2DLPwaYktxO0ZjP7XnMs487BO4EdwmgW8iCxNtCqd2g
        ==
X-Received: by 2002:adf:c547:: with SMTP id s7mr6978wrf.222.1605194065037;
        Thu, 12 Nov 2020 07:14:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzCi+qMEnYo3Z4at9GKUxuCuJdHsy/Kwa2RjJxcMb5RiR3KRPrzSMM5oNvlfzZNkCS6x5Cx5g==
X-Received: by 2002:adf:c547:: with SMTP id s7mr6912wrf.222.1605194064609;
        Thu, 12 Nov 2020 07:14:24 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f8sm7541222wrt.88.2020.11.12.07.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 07:14:24 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 01/17] asm-generic/hyperv: change
 HV_CPU_POWER_MANAGEMENT to HV_CPU_MANAGEMENT
In-Reply-To: <20201105165814.29233-2-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-2-wei.liu@kernel.org>
Date:   Thu, 12 Nov 2020 16:14:22 +0100
Message-ID: <87mtzmy5dd.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> This makes the name match Hyper-V TLFS.
>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  include/asm-generic/hyperv-tlfs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index e73a11850055..e6903589a82a 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -88,7 +88,7 @@
>  #define HV_CONNECT_PORT				BIT(7)
>  #define HV_ACCESS_STATS				BIT(8)
>  #define HV_DEBUGGING				BIT(11)
> -#define HV_CPU_POWER_MANAGEMENT			BIT(12)
> +#define HV_CPU_MANAGEMENT			BIT(12)
>  
>  
>  /*

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

