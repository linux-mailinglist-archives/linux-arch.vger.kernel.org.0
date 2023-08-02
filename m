Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BFC76DBDB
	for <lists+linux-arch@lfdr.de>; Thu,  3 Aug 2023 01:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjHBXzt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 19:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjHBXzs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 19:55:48 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6B030D2;
        Wed,  2 Aug 2023 16:55:47 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-686c06b806cso256328b3a.2;
        Wed, 02 Aug 2023 16:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691020547; x=1691625347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04WSNLnGL1RlIxiFfe2FPIMTqJKLrjY2eoaxW6L3Pac=;
        b=IA2VkofCziDyV9f1/+RtJSmCmAHG85SwA114cN0Uo5mmwu+F1iIW008HrBrflSfq8s
         vepz5K+JW5+ob/nvFqPVhH8wzff7KTZdaiowohLsKxAPMBvH5cNGL8dVq4C7pR/hMzvz
         L2irTRy4y+pAza6N0fVdyxs+2Kz3dExcapMLvRl01yBc4wflu+MdH5A6rXaRJfikZtWN
         A5iVNRUI2vqTcH0iBFQ4NFKc+it/4vnxjXeZc9LxJCPpH+uiU8K8RDtGANYDBE8+nvUn
         lcAOifze9c27bBYfalEoCEKAL9zSQRFyotEBjhVcGHtx7F5MaO38YKRtCtE1E93KBYsF
         GpbA==
X-Gm-Message-State: ABy/qLbS0tU/yW/ZyRfjONqqQq++SXr3Cwwj8800G5Y3Jq8uW/2O3V88
        fQexq6Ft6D3gJjPXOfiJzoo=
X-Google-Smtp-Source: APBJJlFWTcGYXexaDucziuAfMKB+btsaoAOoADwW8N+C12urcSjOVDKrGLFWnyOJotiJtqjlQBKG/w==
X-Received: by 2002:a05:6a20:7289:b0:13e:da98:966a with SMTP id o9-20020a056a20728900b0013eda98966amr4491297pzk.5.1691020547251;
        Wed, 02 Aug 2023 16:55:47 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b001adf6b21c77sm12954728plx.107.2023.08.02.16.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 16:55:46 -0700 (PDT)
Date:   Wed, 2 Aug 2023 23:55:40 +0000
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
        hpa@zytor.com, will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH 05/15] hyperv: Move hv_connection_id to hyperv-tlfs
Message-ID: <ZMrs/BgDzxlLL0VX@liuwe-devbox-debian-v2>
References: <1690487690-2428-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1690487690-2428-6-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690487690-2428-6-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 27, 2023 at 12:54:40PM -0700, Nuno Das Neves wrote:
> This structure should be in hyperv-tlfs.h anyway, since it is part of
> the TLFS document.

Missing blank line here.

> The definition conflicts with one added in hvgdk.h as part of the mshv
> driver so must be moved to hyperv-tlfs.h.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  include/asm-generic/hyperv-tlfs.h | 9 +++++++++
>  include/linux/hyperv.h            | 9 ---------
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index 373f26efa18a..8fc5e5a9d7cb 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -845,4 +845,13 @@ struct hv_mmio_write_input {
>  	u8 data[HV_HYPERCALL_MMIO_MAX_DATA_LENGTH];
>  } __packed;
>  
> +/* Define connection identifier type. */
> +union hv_connection_id {
> +	u32 asu32;
> +	struct {
> +		u32 id:24;
> +		u32 reserved:8;
> +	} u;
> +};
> +

Missing __packed here, but since this is already aligned it probably
doesn't matter much.

>  #endif
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index bfbc37ce223b..f90de5abcd50 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -748,15 +748,6 @@ struct vmbus_close_msg {
>  	struct vmbus_channel_close_channel msg;
>  };
>  
> -/* Define connection identifier type. */
> -union hv_connection_id {
> -	u32 asu32;
> -	struct {
> -		u32 id:24;
> -		u32 reserved:8;
> -	} u;
> -};
> -
>  enum vmbus_device_type {
>  	HV_IDE = 0,
>  	HV_SCSI,
> -- 
> 2.25.1
> 
