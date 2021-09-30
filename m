Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8CC41D765
	for <lists+linux-arch@lfdr.de>; Thu, 30 Sep 2021 12:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349835AbhI3KOz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Sep 2021 06:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349804AbhI3KOy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Sep 2021 06:14:54 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541D4C06176C
        for <linux-arch@vger.kernel.org>; Thu, 30 Sep 2021 03:13:11 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id s17so19809071edd.8
        for <linux-arch@vger.kernel.org>; Thu, 30 Sep 2021 03:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=di22f+1qtT1rJlDsDU5gv52bfkIzi99/0/f5YELZTOw=;
        b=ppyHc1xu2ZjQ/kTBT2c/n07AkMuYUtXvdy0s7QXVTxECAFMjweuXUCK7xVE+xwaX0C
         6o8ZrsH3/9Aynnbf9fMbiY9C8vrkZKxMS2dYyF99LaMNbMDmo+1MshkoCVBu64oPE6ga
         zFJAQfJwiWTcCZsmLrqej5kKbY2vHfu7puIu4/K01CNJFBuzzGgBrIqsTKFJtWl1D8WY
         Zs33o3bUzbg+B6tae1aWxdGoSxVf8Jp54BcOj5rIAhOIm93rKhQ0OmZemre71DGprt/y
         YIumJdsINVkRuayzKbrt7Bx5i0AKwik6J4Ki1n3eaMHv8bBS9zWjaa6znfhzuZJX3poI
         GbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=di22f+1qtT1rJlDsDU5gv52bfkIzi99/0/f5YELZTOw=;
        b=un4ubl3Rqkqp2R0rp79T1xKP3BvMqJ9eRc71oUXniRdOVsuA/XMEDwnbOion+wfUfY
         CfsSIgpOxs2MM597xpPDOCuvRztMGekBEMC5Z3DJxss5b6BROPePw+Q7HJhTjFvDcYKb
         AhfpjQnrOm7svfDTtb5dsmYUbfDevLD5hlJno4pdf+c9Zw8ZRANf2gUrEQz55+Bqda47
         Yvbh6ZsYOMCSRZ1YkSIWGRTR5wlmsBtl71Qgz6wtJ7JsTAsUabFb8HUA8f9Exdhv4ZlJ
         53qrWdVHFEcBKezjWy3woO7POyQrQF1sybLxCXcBptOlrvXlHeU/UexjEvK/Z/L9g2WN
         TtCA==
X-Gm-Message-State: AOAM5317Ynge+SYWqk09ez5q7ZZCUPUvIw81bGDLay//ZdZzIyBDnujy
        LkjKFQqZcKaki/jl51QQMlrkCQ==
X-Google-Smtp-Source: ABdhPJzUmXdUqIGI8syP1K7qbkNoLgpokgx7oGftLZ5Q5kO7Xtw6c5x1cXA4qfoDB4xaMGW2mjnWyg==
X-Received: by 2002:a17:906:4d99:: with SMTP id s25mr5632392eju.175.1632996789937;
        Thu, 30 Sep 2021 03:13:09 -0700 (PDT)
Received: from ?IPv6:2a02:768:2307:40d6::45a? ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id j14sm1265961edl.21.2021.09.30.03.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 03:13:09 -0700 (PDT)
Subject: Re: [PATCH v4 10/11] microblaze: Use is_kernel_text() helper
To:     Kefeng Wang <wangkefeng.wang@huawei.com>, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, rostedt@goodmis.org,
        mingo@redhat.com, davem@davemloft.net, ast@kernel.org,
        ryabinin.a.a@gmail.com, akpm@linux-foundation.org
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        bpf@vger.kernel.org, linux-alpha@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20210930071143.63410-1-wangkefeng.wang@huawei.com>
 <20210930071143.63410-11-wangkefeng.wang@huawei.com>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <2a23c06c-62e5-d4f8-4c7c-4e5c055a9e69@monstr.eu>
Date:   Thu, 30 Sep 2021 12:13:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210930071143.63410-11-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 9/30/21 9:11 AM, Kefeng Wang wrote:
> Use is_kernel_text() helper to simplify code.
> 
> Cc: Michal Simek <monstr@monstr.eu>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/microblaze/mm/pgtable.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/microblaze/mm/pgtable.c b/arch/microblaze/mm/pgtable.c
> index c1833b159d3b..9f73265aad4e 100644
> --- a/arch/microblaze/mm/pgtable.c
> +++ b/arch/microblaze/mm/pgtable.c
> @@ -34,6 +34,7 @@
>  #include <linux/mm_types.h>
>  #include <linux/pgtable.h>
>  #include <linux/memblock.h>
> +#include <linux/kallsyms.h>
>  
>  #include <asm/pgalloc.h>
>  #include <linux/io.h>
> @@ -171,7 +172,7 @@ void __init mapin_ram(void)
>  	for (s = 0; s < lowmem_size; s += PAGE_SIZE) {
>  		f = _PAGE_PRESENT | _PAGE_ACCESSED |
>  				_PAGE_SHARED | _PAGE_HWEXEC;
> -		if ((char *) v < _stext || (char *) v >= _etext)
> +		if (!is_kernel_text(v))
>  			f |= _PAGE_WRENABLE;
>  		else
>  			/* On the MicroBlaze, no user access
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

