Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A3F76DBCD
	for <lists+linux-arch@lfdr.de>; Thu,  3 Aug 2023 01:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjHBXrv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 19:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjHBXru (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 19:47:50 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEF4F2;
        Wed,  2 Aug 2023 16:47:47 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-68730bafa6bso1025996b3a.1;
        Wed, 02 Aug 2023 16:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691020066; x=1691624866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iND6DoCGv2c/em+mZgV+i0Ux/oJxu8oM5xAqj7hv5MQ=;
        b=Wl7g+i4UCqmbP2pbXDNt3dz/ocSMKa+SpnT1SRIM6e3ztSQL6i6s1f2npQ+oqMiqBH
         u/1CLUAOGxnCHoGAVzhA7g9tvmD7Llig8U0MgHhUgN0E3/YBx80irEk2u7A/aRuH1B4Z
         tOviSI0loBjPXZH9/NJcV/aM0YZ29q2wpa1rd5WFBnsFmdR3BkefsVDNxjhCNSxla/+F
         VuwTMZrXsk6lGyAmnUWK5zlTn4uniSWJSx1uOHHxhvs5nBMpGN/JwxxnJTaKeLQvQ4vN
         b6jvw7ziR0q84TxXb1HErQrRHlcavskME5iVFw47oLL5RSGsyXpiqe5NJf3ZKN9ubdZ6
         wSfg==
X-Gm-Message-State: ABy/qLb8nplTFrPZEzUx/TkKquM3Lui5vj+3ggKqx4cnjsGd7a7Ru8Wx
        UrULHgWWAIQlV8iBbOT8YAo=
X-Google-Smtp-Source: APBJJlHbxVznnDHfw3ul7bW2kcVCoiWDy1NoNUodbRC6Z0E1ILsRsrjtOqq0YX6H8sipUKpi3cZBbg==
X-Received: by 2002:a05:6a20:729b:b0:125:4d74:cd6a with SMTP id o27-20020a056a20729b00b001254d74cd6amr22020038pzk.3.1691020066504;
        Wed, 02 Aug 2023 16:47:46 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id n4-20020a637204000000b0054fe7736ac1sm12152307pgc.76.2023.08.02.16.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 16:47:45 -0700 (PDT)
Date:   Wed, 2 Aug 2023 23:47:39 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, mikelley@microsoft.com,
        kys@microsoft.com, wei.liu@kernel.org, haiyangz@microsoft.com,
        decui@microsoft.com, ssengar@linux.microsoft.com,
        mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
        jinankjain@linux.microsoft.com, apais@linux.microsoft.com,
        Tianyu.Lan@microsoft.com, vkuznets@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, will@kernel.org, catalin.marinas@arm.com,
        rafael@kernel.org, lenb@kernel.org
Subject: Re: [PATCH 03/15] mshyperv: Introduce
 numa_node_to_proximity_domain_info
Message-ID: <ZMrrG0urnR6BdZcW@liuwe-devbox-debian-v2>
References: <1690487690-2428-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1690487690-2428-4-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690487690-2428-4-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 27, 2023 at 12:54:38PM -0700, Nuno Das Neves wrote:
> Factor out logic for converting numa node to proximity domain info into
> a helper function, and export it.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Reviewed-by: Wei Liu <wei.liu@kernel.org>

> ---
>  arch/x86/hyperv/hv_proc.c      |  8 ++------
>  drivers/acpi/numa/srat.c       |  1 +
>  include/asm-generic/mshyperv.h | 18 ++++++++++++++++++
>  3 files changed, 21 insertions(+), 6 deletions(-)
> 
[...]
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 1f4fc5f8a819..0cf9f0574495 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -48,6 +48,7 @@ int node_to_pxm(int node)
>  		return PXM_INVAL;
>  	return node_to_pxm_map[node];
>  }
> +EXPORT_SYMBOL(node_to_pxm);

Rafael and Len, I would like to get an ACK from you on this one line
change. I see a lot of other functions in that file are already
exported, so I hope this is okay, too.

It's user is the function below numa_node_to_proximity_domain_info.

Thanks,
Wei.

>  
>  static void __acpi_map_pxm_to_node(int pxm, int node)
>  {
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index 233c976344e5..447e7ebe67ee 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -21,6 +21,7 @@
>  #include <linux/types.h>
>  #include <linux/atomic.h>
>  #include <linux/bitops.h>
> +#include <acpi/acpi_numa.h>
>  #include <linux/cpumask.h>
>  #include <linux/nmi.h>
>  #include <asm/ptrace.h>
> @@ -28,6 +29,23 @@
>  
>  #define VTPM_BASE_ADDRESS 0xfed40000
>  
> +static inline union hv_proximity_domain_info
> +numa_node_to_proximity_domain_info(int node)
> +{
> +	union hv_proximity_domain_info proximity_domain_info;
> +
> +	if (node != NUMA_NO_NODE) {
> +		proximity_domain_info.domain_id = node_to_pxm(node);
> +		proximity_domain_info.flags.reserved = 0;
> +		proximity_domain_info.flags.proximity_info_valid = 1;
> +		proximity_domain_info.flags.proximity_preferred = 1;
> +	} else {
> +		proximity_domain_info.as_uint64 = 0;
> +	}
> +
> +	return proximity_domain_info;
> +}
> +
>  struct ms_hyperv_info {
>  	u32 features;
>  	u32 priv_high;
> -- 
> 2.25.1
> 
