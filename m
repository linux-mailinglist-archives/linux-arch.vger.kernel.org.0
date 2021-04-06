Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134FE354F2C
	for <lists+linux-arch@lfdr.de>; Tue,  6 Apr 2021 10:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244654AbhDFI5K (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Apr 2021 04:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244643AbhDFI5J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Apr 2021 04:57:09 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D451C06174A;
        Tue,  6 Apr 2021 01:57:02 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id s11so9945308pfm.1;
        Tue, 06 Apr 2021 01:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uZUmKkwLM2oSaojuTn4DZClVwuluaLe6PZbLvPR8s3c=;
        b=WpscpUN2s8UcwB80GPNIwVjusSFrsDNimXL3met/I3dY8jN7f/vDKn6GC3ZCHm0gvJ
         X0eSOYRoV3NrPws6+e881tyauDFR2DHTYRV6VDqRR6VreNS5QLy+z6a529MqZm6XO64F
         lmZaxZTY8DzlbI/lOZk7FXot9YJCSbwMtxI73bs8JqKe+1fcadudbIefJQn+3yvE5QwO
         v51LL2yCRBNsZZY7W/VBJY2QK9Zy7gCpGu0LKVY+ttIhCbpKZSiKfm34rIQ6oN64mUjr
         ODCo1c/gMcffa6EZt3MRR1y4wMbMqMCvg55HnV7a22su7k7OVEgCuiZOOpr1Dun6mzcW
         ahtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uZUmKkwLM2oSaojuTn4DZClVwuluaLe6PZbLvPR8s3c=;
        b=J5/o6RTxKalU+T50low4s8hC5FxP4Era2plCV+dnynbLVJS3lvTlP+aVjsR1ZnZix2
         hrR/dZurFBvEEZNaOhlkKX6NEyTg4s2vAzgcP4E0qbqwtzeJWbajU+LqqlXOHSJbILFH
         REtT+ZeMQxtVBG1W0uKjQrpLr9Lvwi/zBdWEEgj1ONHMOlk8lBArqRP6XYv3CsXxLjGn
         xF3i2sDgDiB1MaGabEd6WD3q1pxVAftxHZ211BRDn8n5hjj1t/735IFcLcAP6P35h6uO
         F5Pj99g0BoHPCYeVr4MFIJpBuI/OjQNJ+AJq9bv/dwMgVH3la3t5reoKgjzjLCDpKGNo
         HTfg==
X-Gm-Message-State: AOAM531otqjcSLlC8AH8YtypS5tFc1F6WoUCE4GULHLP89XRJTGdaJQa
        kh1p1b3QTinPjcKuTKmze7Q=
X-Google-Smtp-Source: ABdhPJyoX4fauwUz8/uRPC+PLrlDTqY/BbNhdRIQpb2w7mh6/qLvfq7K0aPB9a6PVbfbagmli9jcUQ==
X-Received: by 2002:a63:e903:: with SMTP id i3mr21319346pgh.374.1617699421963;
        Tue, 06 Apr 2021 01:57:01 -0700 (PDT)
Received: from localhost (g139.124-45-193.ppp.wakwak.ne.jp. [124.45.193.139])
        by smtp.gmail.com with ESMTPSA id y15sm20720606pgi.31.2021.04.06.01.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 01:57:01 -0700 (PDT)
Date:   Tue, 6 Apr 2021 17:56:59 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: Re: [PATCH v6 6/9] openrisc: qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Message-ID: <20210406085659.GF3288043@lianli.shorne-pla.net>
References: <1617201040-83905-1-git-send-email-guoren@kernel.org>
 <1617201040-83905-7-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617201040-83905-7-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 31, 2021 at 02:30:37PM +0000, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> We don't have native hw xchg16 instruction, so let qspinlock
> generic code to deal with it.
> 
> Using the full-word atomic xchg instructions implement xchg16 has
> the semantic risk for atomic operations.
> 
> This patch cancels the dependency of on qspinlock generic code on
> architecture's xchg16.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: openrisc@lists.librecores.org

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  arch/openrisc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index 591acc5990dc..b299e409429f 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -33,6 +33,7 @@ config OPENRISC
>  	select OR1K_PIC
>  	select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
>  	select ARCH_USE_QUEUED_SPINLOCKS
> +	select ARCH_USE_QUEUED_SPINLOCKS_XCHG32
>  	select ARCH_USE_QUEUED_RWLOCKS
>  	select OMPIC if SMP
>  	select ARCH_WANT_FRAME_POINTERS
> -- 
> 2.17.1
> 
