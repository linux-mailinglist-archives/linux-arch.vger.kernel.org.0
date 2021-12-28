Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239344809D8
	for <lists+linux-arch@lfdr.de>; Tue, 28 Dec 2021 15:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbhL1OKW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Dec 2021 09:10:22 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:39547 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbhL1OKW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Dec 2021 09:10:22 -0500
Received: by mail-wm1-f49.google.com with SMTP id g7-20020a7bc4c7000000b00345c4bb365aso10093482wmk.4;
        Tue, 28 Dec 2021 06:10:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0ZGswmS9Kg1o16OGnsntYKDywaqdNk9zaWYcZyPMq+c=;
        b=t7cP9UVqkQtpQliMAxMAtQTFiN1XH+vn/B/bH2P8lLMLdXYqZuPLpN02S/Q+KfZEcx
         2KXsYsfplhrQ8uJjZ09CY/7PwVI+BqOq3mJPnF0DfS1tyNjSUPqhHsIZRiNoc4xw2SUn
         KQMszCGPRd/AVpIObFyjFDRKNKuNvEIOlMz6eTf+noriggA2FqldJvKvCWVPA1E03wP2
         6V56L6NE6y8pyg0PlveeTDpeHZa3NKl39ClNU1uoW+GtHHXSqrj9UopaDi8vTv3dFCb4
         nY5tt77IGA9IDlryT909l9vYt/nPs5XN1W2r0/BU/zhEXKyscYGZ5eDZywwPea2NTegS
         Z2Ew==
X-Gm-Message-State: AOAM530esz679/YRACGkHJXFXQzQValADN/L6ynvEnXz8p9ogkwul9Tm
        ha8cJn31GKmmjCZ7oUBIFWs=
X-Google-Smtp-Source: ABdhPJy4WKHIuabZrfZzrjIBPrX/x0zSG1rgyUuHXKEcBUuKB7FeqCBh7D2LGwTEWQV+kc+1GGpmrQ==
X-Received: by 2002:a05:600c:4896:: with SMTP id j22mr17632144wmp.165.1640700619959;
        Tue, 28 Dec 2021 06:10:19 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id i8sm22317066wry.108.2021.12.28.06.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 06:10:19 -0800 (PST)
Date:   Tue, 28 Dec 2021 14:10:17 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, arnd@arndb.de, tianyu.lan@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/2] Drivers: hv: Fix definition of hypercall input &
 output arg variables
Message-ID: <20211228141017.deahhdqc3i6w4kyy@liuwe-devbox-debian-v2>
References: <1640662315-22260-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1640662315-22260-1-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 27, 2021 at 07:31:54PM -0800, Michael Kelley wrote:
> The percpu variables hyperv_pcpu_input_arg and hyperv_pcpu_output_arg
> have been incorrectly defined since their inception.  The __percpu
> qualifier should be associated with the void * (i.e., a pointer), not
> with the target of the pointer. This distinction makes no difference
> to gcc and the generated code, but sparse correctly complains.  Fix
> the definitions in the interest of general correctness in addition
> to making sparse happy.
> 
> No functional change.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Good catch. I failed to interpret sparse's complaints.

Both patches queued to hyperv-next. Thanks.

> ---
>  drivers/hv/hv_common.c         | 4 ++--
>  include/asm-generic/mshyperv.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 7be173a..7477e5a 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -44,10 +44,10 @@
>  u32 hv_max_vp_index;
>  EXPORT_SYMBOL_GPL(hv_max_vp_index);
>  
> -void  __percpu **hyperv_pcpu_input_arg;
> +void * __percpu *hyperv_pcpu_input_arg;
>  EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
>  
> -void  __percpu **hyperv_pcpu_output_arg;
> +void * __percpu *hyperv_pcpu_output_arg;
>  EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
>  
>  /*
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index 3e2248ac..95b7888 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -49,8 +49,8 @@ struct ms_hyperv_info {
>  };
>  extern struct ms_hyperv_info ms_hyperv;
>  
> -extern void  __percpu  **hyperv_pcpu_input_arg;
> -extern void  __percpu  **hyperv_pcpu_output_arg;
> +extern void * __percpu *hyperv_pcpu_input_arg;
> +extern void * __percpu *hyperv_pcpu_output_arg;
>  
>  extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
>  extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
> -- 
> 1.8.3.1
> 
