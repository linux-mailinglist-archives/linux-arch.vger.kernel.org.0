Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3542EC0A1
	for <lists+linux-arch@lfdr.de>; Wed,  6 Jan 2021 16:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbhAFPqg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Jan 2021 10:46:36 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:34983 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbhAFPqe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jan 2021 10:46:34 -0500
Received: by mail-wr1-f46.google.com with SMTP id r3so2853521wrt.2;
        Wed, 06 Jan 2021 07:46:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FPAbZDn/cFbENDB7SIYEjMVopPnPxK58UQtiBPxbqrE=;
        b=Du9KbQMJf8DCcH5ZOTm+Z/PnPVypeSq98LnV3cFxx1/+073bzg9nfDSE8A8n8QMrTL
         LUE4kBIV8pc5XO+o5de9n0hAHV+uHOeLhSvDLxstqI5cotRCZVdnjYniRA9/c8in7vn1
         XH/7/1FJrJc7uGh9Kx10+ZHOAZ85xfQX35gPk2sIpB3nAxtRIyksBfAcgxizW+bN39if
         iCYTXZdTX4mfp81GwR2sWCyXk3Z7zPGPnmebfltwqtV5e62hbmDrS5RKJtbN+wFT3/XP
         zRYIrD+OU6HpRu87uq+bOSR21jrbWM8rbF1PK8WerciF9XXe7WdbXagKLP1T+QSBxzFD
         CyXw==
X-Gm-Message-State: AOAM5326FrF/tr25IQVgrSzj60FCvKn02jZ6PPsQKgTuoDGVXX0QGMw6
        LcHP5YmROV3ACT/t1hqyHInJ9UcnHmo=
X-Google-Smtp-Source: ABdhPJxXnwUBwofD7GC19sdC/8ajX6hx5BVSjxImIQJz0+eWJcMpCPckZGhhA1Bfw0NPlwexauObQw==
X-Received: by 2002:adf:a1d5:: with SMTP id v21mr4887659wrv.24.1609947952605;
        Wed, 06 Jan 2021 07:45:52 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id k10sm3413995wrq.38.2021.01.06.07.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 07:45:52 -0800 (PST)
Date:   Wed, 6 Jan 2021 15:45:50 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3 01/17] asm-generic/hyperv: change
 HV_CPU_POWER_MANAGEMENT to HV_CPU_MANAGEMENT
Message-ID: <20210106154550.mbk5yyyp3cvgprvr@liuwe-devbox-debian-v2>
References: <20201124170744.112180-1-wei.liu@kernel.org>
 <20201124170744.112180-2-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124170744.112180-2-wei.liu@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 24, 2020 at 05:07:28PM +0000, Wei Liu wrote:
> This makes the name match Hyper-V TLFS.
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

This patch is trivially correct.

I will apply it to hyperv-next to reduce length of this series.

Wei.

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
> -- 
> 2.20.1
> 
