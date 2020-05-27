Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E676E1E4668
	for <lists+linux-arch@lfdr.de>; Wed, 27 May 2020 16:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388871AbgE0Ovl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 May 2020 10:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388621AbgE0Ovk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 May 2020 10:51:40 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A546C05BD1E;
        Wed, 27 May 2020 07:51:40 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id fs4so1625397pjb.5;
        Wed, 27 May 2020 07:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IYroLjMhHIVfp0Ps4FH2gR7ebtraWAtzjxwzzSb03/M=;
        b=nvBQbKqu5uFlfoz4A5iT/BRqwAA8UHqKPLuPI5X+8dMcGD3yQs1GfpF8rFYMs8sIEZ
         /zOmKsWnxre5wX15QnuVgq96cv7CKeVXGn/necTUqms/syMmCXlw7jNqUXJRh3xJvncE
         3wpsv9RvAg4NSJrKGNi5T6iLJUJTfPyUaT1cU7raqBROg2rJXVHEIklC1euPIQHLgXiv
         y4/sXdDpBDT9Wa+X32movpmy4qW5oM16GwBojVvG9+KyZcyVyuPRXymA1ATn7OSYgRtG
         aLIp2/mLNbZhX1BicXG/LKRfBVktz2IK2vMLTis1ijqd3KRD44FYpN2GkH0VSkpOeFY8
         d6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IYroLjMhHIVfp0Ps4FH2gR7ebtraWAtzjxwzzSb03/M=;
        b=jQCSjgl7Se9HroJXBIS61ojC+QKPHeqkF3Zp0agioAuOH0jK6RlNyOsWYDok1dIrt8
         7rJnsTmoqMRA1fjf0fuMXWfIqlA529SlH+QsT5LO3HqguEjyZTqSRJfc8aWPD8wky/6g
         4uTFMkWyR+cVi1//8MzcOzkwyiFnFAJw7xrcybk7pveG9tJD8ybW4c/gsovagb0E96+4
         L6BVpTUTAgAI2mTGjemxR5WM2VWn92+PXVmQtvaDLPFOIvoIWm74ysClbjDxxzENpHL1
         zb0MJmCp3wGGbO4NiqsV4dMq70Uac9RxrjL++9Ir1pY3CLAtBpe5rcealtDnllrbcdfn
         ZzLg==
X-Gm-Message-State: AOAM532oZfOL7o0zKyx4oODXb60efZdx00SKhc/ZKS+dkfV8Oz+Jdj2K
        oOsbll2J1aSvh3RdaLm2UzjZfagy
X-Google-Smtp-Source: ABdhPJzl1QaOIN8BcHat2UxwfnIUWt1l2rFunjdMaTopWGdypIXtikiuE4zr+Kn1y2hdOLqd5yS8bg==
X-Received: by 2002:a17:902:6b4b:: with SMTP id g11mr2846536plt.9.1590591100154;
        Wed, 27 May 2020 07:51:40 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f11sm2321239pfa.32.2020.05.27.07.51.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 May 2020 07:51:39 -0700 (PDT)
Date:   Wed, 27 May 2020 07:51:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Henderson <rth@twiddle.net>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpumask: guard cpumask_of_node() macro argument
Message-ID: <20200527145138.GB209591@roeck-us.net>
References: <20200527134623.930247-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527134623.930247-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 27, 2020 at 03:46:08PM +0200, Arnd Bergmann wrote:
> drivers/hwmon/amd_energy.c:195:15: error: invalid operands to binary expression ('void' and 'int')
>                                         (channel - data->nr_cpus));
>                                         ~~~~~~~~~^~~~~~~~~~~~~~~~~
> include/asm-generic/topology.h:51:42: note: expanded from macro 'cpumask_of_node'
>     #define cpumask_of_node(node)       ((void)node, cpu_online_mask)
>                                                ^~~~
> include/linux/cpumask.h:618:72: note: expanded from macro 'cpumask_first_and'
>  #define cpumask_first_and(src1p, src2p) cpumask_next_and(-1, (src1p), (src2p))
>                                                                        ^~~~~
> 
> Fixes: f0b848ce6fe9 ("cpumask: Introduce cpumask_of_{node,pcibus} to replace {node,pcibus}_to_cpumask")
> Fixes: 8abee9566b7e ("hwmon: Add amd_energy driver to report energy counters")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Didn't I Cc: you on the same patch I sent out earlier ? Never mind, though.

Acked-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>  include/asm-generic/topology.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/topology.h b/include/asm-generic/topology.h
> index 238873739550..5aa8705df87e 100644
> --- a/include/asm-generic/topology.h
> +++ b/include/asm-generic/topology.h
> @@ -48,7 +48,7 @@
>    #ifdef CONFIG_NEED_MULTIPLE_NODES
>      #define cpumask_of_node(node)	((node) == 0 ? cpu_online_mask : cpu_none_mask)
>    #else
> -    #define cpumask_of_node(node)	((void)node, cpu_online_mask)
> +    #define cpumask_of_node(node)	((void)(node), cpu_online_mask)
>    #endif
>  #endif
>  #ifndef pcibus_to_node
> -- 
> 2.26.2
> 
