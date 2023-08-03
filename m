Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F9C76DCE1
	for <lists+linux-arch@lfdr.de>; Thu,  3 Aug 2023 02:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjHCAtG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 20:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjHCAtF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 20:49:05 -0400
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56DA269E;
        Wed,  2 Aug 2023 17:49:04 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-26837895fc8so210663a91.0;
        Wed, 02 Aug 2023 17:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691023744; x=1691628544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTv5W4Q6yS6G6v7qn6WVl32Gcj1wC0XOowAiH8q+7B8=;
        b=CFVIYiBwZr5MZErTBrWEGvzVYBlF5Qyx5ZQsIGqbRoc2tetc0YCNYOLu1bUu+HXV7j
         sugxe5qEul+NpTXf+b8aYuc+okVd+ety3Gvl2hMq69oRivfeu8CfXqNXAdJWiQ285Sd0
         z5PTj91jTi6/LVBkybuGqcuZOlLMPnoOpWgNikpuPQ1igtIrUgwnY8Xmeh17tbXGwJpf
         x6z6N1+s0aSWZIMJkOgxI7ftkNGt3v/u96uyLClDrjEaqSP2OSJmd7Lm7ntQrA8BCiWd
         rVmgPf1sZPQ+NMYxMcY12hOjK/12ek9czeoSDVA+WuvVFnZuREZmX/bLBAf4jEl2Ops0
         0jFQ==
X-Gm-Message-State: ABy/qLbAQjtQfhM/dtTGIHLNblQ5tLeJniZXmfmZbGAy5NPNAbor0a2n
        ttmSvQznUzHuLXI56LVeKR0=
X-Google-Smtp-Source: APBJJlGlrF2BoFgwZfEV6V2b6NStOmhRISsvraxtM7VPK80JgV3vkWcJ9YhwIsY3KRqEi5lAF4jmQg==
X-Received: by 2002:a17:90a:6fa6:b0:262:e6c6:c2ec with SMTP id e35-20020a17090a6fa600b00262e6c6c2ecmr15085133pjk.33.1691023744201;
        Wed, 02 Aug 2023 17:49:04 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id l4-20020a17090ad10400b00263f33eef41sm1595084pju.37.2023.08.02.17.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 17:49:03 -0700 (PDT)
Date:   Thu, 3 Aug 2023 00:48:57 +0000
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
Subject: Re: [PATCH 14/15] asm-generic: hyperv: Use mshv headers
 conditionally. Add asm-generic/hyperv-defs.h
Message-ID: <ZMr5ebxAqfjHPkVb@liuwe-devbox-debian-v2>
References: <1690487690-2428-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1690487690-2428-15-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690487690-2428-15-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 27, 2023 at 12:54:49PM -0700, Nuno Das Neves wrote:
> In order to keep unstable hyper-v interfaces independent of
> hyperv-tlfs.h, hvhdk.h must replace hyperv-tlfs.h eveywhere it will be
> used in the mshv driver.

Please properly capitalize "Hyper-V" when it is used as a term.

> Add hyperv-defs.h to replace some inclusions of hyperv-tlfs.h.
> It includes hyperv-tlfs.h or hvhdk.h depending on a compile-time constant
> HV_HYPERV_DEFS which will be defined in the mshv driver.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  arch/arm64/include/asm/mshyperv.h |  2 +-
>  arch/x86/include/asm/mshyperv.h   |  3 +--
>  drivers/hv/hyperv_vmbus.h         |  1 -
>  include/asm-generic/hyperv-defs.h | 26 ++++++++++++++++++++++++++
>  include/asm-generic/mshyperv.h    |  2 +-
>  include/linux/hyperv.h            |  2 +-
>  6 files changed, 30 insertions(+), 6 deletions(-)
>  create mode 100644 include/asm-generic/hyperv-defs.h
> 
[...]
> diff --git a/include/asm-generic/hyperv-defs.h b/include/asm-generic/hyperv-defs.h
> new file mode 100644
> index 000000000000..ac6fcba35c8c
> --- /dev/null
> +++ b/include/asm-generic/hyperv-defs.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_GENERIC_HYPERV_DEFS_H
> +#define _ASM_GENERIC_HYPERV_DEFS_H
> +
> +/*
> + * There are cases where Microsoft Hypervisor ABIs are needed which may not be
> + * stable or present in the Hyper-V TLFS document. E.g. the mshv_root driver.
> + *
> + * As these interfaces are unstable and may differ from hyperv-tlfs.h, they
> + * must be kept separate and independent.
> + *
> + * However, code from files that depend on hyperv-tlfs.h (such as mshyperv.h)
> + * is still needed, so work around the issue by conditionally including the
> + * correct definitions.
> + *
> + * Note: Since they are independent of each other, there are many definitions
> + * duplicated in both hyperv-tlfs.h and uapi/hyperv/hv*.h files.
> + */

Is this because we accidentally introduced some host only, unstable
interfaces to hyperv-tlfs.h? Is the long term plan to drop those from
hyperv-tlfs.h and further separate the helper functions?

Thanks,
Wei.

> +#ifdef HV_HYPERV_DEFS
> +#include <uapi/hyperv/hvhdk.h>
> +#else
> +#include <asm/hyperv-tlfs.h>
> +#endif
> +
> +#endif /* _ASM_GENERIC_HYPERV_DEFS_H */
> +
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index 2b20994d809e..e86b6f51fb64 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -25,7 +25,7 @@
>  #include <linux/cpumask.h>
>  #include <linux/nmi.h>
>  #include <asm/ptrace.h>
> -#include <asm/hyperv-tlfs.h>
> +#include <asm-generic/hyperv-defs.h>
>  
>  #define VTPM_BASE_ADDRESS 0xfed40000
>  
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index f90de5abcd50..66ed8b3e5d89 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -24,7 +24,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/interrupt.h>
>  #include <linux/reciprocal_div.h>
> -#include <asm/hyperv-tlfs.h>
> +#include <asm-generic/hyperv-defs.h>
>  
>  #define MAX_PAGE_BUFFER_COUNT				32
>  #define MAX_MULTIPAGE_BUFFER_COUNT			32 /* 128K */
> -- 
> 2.25.1
> 
