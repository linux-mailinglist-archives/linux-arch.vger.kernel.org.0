Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4A9426200
	for <lists+linux-arch@lfdr.de>; Fri,  8 Oct 2021 03:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhJHB2k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Oct 2021 21:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhJHB2k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Oct 2021 21:28:40 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB31C061714
        for <linux-arch@vger.kernel.org>; Thu,  7 Oct 2021 18:26:45 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id kk10so6341744pjb.1
        for <linux-arch@vger.kernel.org>; Thu, 07 Oct 2021 18:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=pJpdSjWQ9J57N/lwk0QG5s7Kp9DIqFcdVWHLvvYpJjI=;
        b=s+MMrKGNGrHx6bfFOUqPVOd5XD+gv5OM/LYiNgY6bbTSNhbQnxrQxAtjMVMo4yOXLk
         xcm1nQK4WnIakev01IJ3xAi3TfIiJhXioq85IKrwOraUw/MRHLJAwvPLS+tJsnwtPoii
         2lzDV8nfm69rq+LDi7d6jbmo+qWmqZ6efgIm7b23ZDi7BnOQJIJdJHURPLUtNd++IefB
         jk5Ix9vRfUWwQr6kEJuJuFlqHiQvrQQE+jjCjZS96nPCR/lLSTIzEzdRZ+/UYyLkrQ5P
         0pi81mRSl+pbqNRn/5xupNOcKOUEktMaNvJGzFGDb7oo7BnWam5kDsiwkoSguzvtSmoq
         zbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=pJpdSjWQ9J57N/lwk0QG5s7Kp9DIqFcdVWHLvvYpJjI=;
        b=cOd2CxM9/hM1VbzVsOWMw6Is7eIKnx5/gYKv+hF+WBogFyUMj1/ue/HGYzIB1H4WOL
         Dl6q0dHi/wvf6EiinZTF3tsf9lWJHbFapAN9EqaOhvlbPf1E+jAb9GFyDRVE9O4Ib0BW
         KymQz9InH9/Hwfyn2qiBaVhsjnY9I7HCVPDab8my/jqsDYVXAhPDqC9wN4S7VHBBirns
         zJ1IldgL78pjKgwQyq1VJJpJBh2eKxmWbyfOQLdH+UELWhSxypPgtBq2932h/KYnxky/
         bw1bB8pz1aO17GSLdb+CdKjPJqvgyFSSN1CbL984se+Rtl31twG+w5GvXw16PrZsMj2N
         MRUw==
X-Gm-Message-State: AOAM531DCYeJNBApFplozMgW1x6YQ2dvzmMBa8QxNQ4tVXHLInMQOV6G
        p6pHZa7YSCUpCiHPDw2S8RJG3Q==
X-Google-Smtp-Source: ABdhPJzZ9dgVXzRUrfgOj4y/IRYM+8rBocqvbuvdJzKL3LpgbfM2wLjbp9eqPdRWxci8d3kehbgMWA==
X-Received: by 2002:a17:90a:62ca:: with SMTP id k10mr8475031pjs.38.1633656405198;
        Thu, 07 Oct 2021 18:26:45 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id x9sm9478349pjp.50.2021.10.07.18.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 18:26:44 -0700 (PDT)
Date:   Thu, 07 Oct 2021 18:26:44 -0700 (PDT)
X-Google-Original-Date: Thu, 07 Oct 2021 18:26:33 PDT (-0700)
Subject:     Re: [PATCH v4 0/3] riscv: optimized mem* functions
In-Reply-To: <20210919192104.98592-1-mcroce@linux.microsoft.com>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Atish Patra <Atish.Patra@wdc.com>,
        kernel@esmil.dk, akira.tsukamoto@gmail.com, drew@beagleboard.org,
        bmeng.cn@gmail.com, David.Laight@aculab.com, guoren@kernel.org,
        Christoph Hellwig <hch@lst.de>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     mcroce@linux.microsoft.com
Message-ID: <mhng-1ef62a9c-06e5-43cf-a4ec-8c18111e79d3@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 19 Sep 2021 12:21:01 PDT (-0700), mcroce@linux.microsoft.com wrote:
> From: Matteo Croce <mcroce@microsoft.com>
>
> Replace the assembly mem{cpy,move,set} with C equivalent.
>
> Try to access RAM with the largest bit width possible, but without
> doing unaligned accesses.
>
> A further improvement could be to use multiple read and writes as the
> assembly version was trying to do.
>
> Tested on a BeagleV Starlight with a SiFive U74 core, where the
> improvement is noticeable.
>
> v3 -> v4:
> - incorporate changes from proposed generic version:
>   https://lore.kernel.org/lkml/20210617152754.17960-1-mcroce@linux.microsoft.com/
>
> v2 -> v3:
> - alias mem* to __mem* and not viceversa
> - use __alias instead of a tail call
>
> v1 -> v2:
> - reduce the threshold from 64 to 16 bytes
> - fix KASAN build
> - optimize memset
>
> Matteo Croce (3):
>   riscv: optimized memcpy
>   riscv: optimized memmove
>   riscv: optimized memset
>
>  arch/riscv/include/asm/string.h |  18 ++--
>  arch/riscv/kernel/Makefile      |   1 -
>  arch/riscv/kernel/riscv_ksyms.c |  17 ----
>  arch/riscv/lib/Makefile         |   4 +-
>  arch/riscv/lib/memcpy.S         | 108 ----------------------
>  arch/riscv/lib/memmove.S        |  64 -------------
>  arch/riscv/lib/memset.S         | 113 -----------------------
>  arch/riscv/lib/string.c         | 154 ++++++++++++++++++++++++++++++++
>  8 files changed, 164 insertions(+), 315 deletions(-)
>  delete mode 100644 arch/riscv/kernel/riscv_ksyms.c
>  delete mode 100644 arch/riscv/lib/memcpy.S
>  delete mode 100644 arch/riscv/lib/memmove.S
>  delete mode 100644 arch/riscv/lib/memset.S
>  create mode 100644 arch/riscv/lib/string.c

Thanks.  These generally look good, but they're failing to build for me.  
I'm getting errors along the lines of

    arch/riscv/lib/string.c:89:7: error: inlining failed in call to ‘always_inline’ ‘memcpy’: function body can be overwritten at link time
       89 | void *memcpy(void *dest, const void *src, size_t count) __weak __alias(__memcpy);      |       ^~~~~~
    arch/riscv/lib/string.c:99:10: note: called from here
       99 |   return memcpy(dest, src, count);
          |          ^~~~~~~~~~~~~~~~~~~~~~~~

I'm still a bit behind on email so I'm going to keep going through 
patches, but if there's no v5 by the time I get back here then I'll take 
a look.
