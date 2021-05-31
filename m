Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB20395A76
	for <lists+linux-arch@lfdr.de>; Mon, 31 May 2021 14:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhEaMYe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 May 2021 08:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhEaMYd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 May 2021 08:24:33 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5CBC061574
        for <linux-arch@vger.kernel.org>; Mon, 31 May 2021 05:22:53 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id dj8so1015982edb.6
        for <linux-arch@vger.kernel.org>; Mon, 31 May 2021 05:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LNYYJ0npItOg2aTRTp7BxB+oXnJtRa8V64w9pv94XTA=;
        b=BHx2yJ09rgOe6v6dVSNygRU9t2d6Vu6d+uRhC65wPtYXAx5Da+lU/j2IBvKBmohbdt
         lFd2NWJhb4KwAr27ENIyyhL2ctK6MaYZThu7MJ6BPKgfXfHEisqnD/GEB8pO/sAMWPTZ
         0KqxhzCajwS2POmzmRZgCDfRqs4oe/FUt3pQMiX6tlfn8+sBmH0N1lRqtXetInkFu0+m
         /ADt1l/3RZI4qVbU4dsm60EllA5JGoDr3IE5BX7HTWbyE7gJWCnyxwfSLd5BH9qTfeAn
         uolbOwdJyezVYWtpdV+37vpEUoNQahsz0ADnkuOroyE4dMLtV2Uwjx5uM5dJNgUHzho5
         87ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LNYYJ0npItOg2aTRTp7BxB+oXnJtRa8V64w9pv94XTA=;
        b=qGg/5KnxAdIqbyRV7P9nkvAdMesrY8xU/4cKxcvzy1+EOx7zP+fSKJHjKItf5CfA9B
         0cnluvDtuiRGaCH4Lso/+4oouUYfWESwrAs/GVBZCwus5/S7xy7hLIOTHMRQGXDKMUwk
         zy0BTpfioGKmL5tc3vEzslhINpw11BgTuAp/m5b7TCtSJkCEcOZp+ur4Qk8MTLa8ISeT
         pZFrAaBgCkiKz99tVGDc8OnkuZPCnvZKNdIgt1mnvV03jpN+mfhrbP9krlhCuTuj80WF
         KNozs6k4M8ll9sBPHw4pQjgWbEeHwIIdcRK7Q5rPTx4dyrojZfTIDwEThXjEHPffiuHo
         +Q6g==
X-Gm-Message-State: AOAM530zCB7QNnBKOwjTr8Vywqvpr2h59aSt0xarMk5FcQTxun9Xj8E0
        yYN5bp8snUUG06jvl0eHpfcAsQ==
X-Google-Smtp-Source: ABdhPJxMGAvE/AgLesq42O2yn1hoVTHsf6fV2XFs7RBODpYAuyE4hnridU5RIU2SJj1z36K2K6NYIg==
X-Received: by 2002:aa7:d786:: with SMTP id s6mr24668971edq.239.1622463772286;
        Mon, 31 May 2021 05:22:52 -0700 (PDT)
Received: from ?IPv6:2a02:768:2307:40d6::45a? ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id lb23sm4000220ejb.73.2021.05.31.05.22.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 05:22:51 -0700 (PDT)
Subject: Re: [PATCH] microblaze: Remove unused functions
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
References: <1621701994-27650-1-git-send-email-guoren@kernel.org>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <75cc31aa-6fe8-f3d7-94a8-4f43d95f1255@monstr.eu>
Date:   Mon, 31 May 2021 14:22:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1621701994-27650-1-git-send-email-guoren@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 5/22/21 6:46 PM, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> PAGE_UP/DOWN are never used in linux, then the patch remove them
> in asm/page.h.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Michal Simek <monstr@monstr.eu>
> ---
>  arch/microblaze/include/asm/page.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/microblaze/include/asm/page.h b/arch/microblaze/include/asm/page.h
> index bf681f2..ce55097 100644
> --- a/arch/microblaze/include/asm/page.h
> +++ b/arch/microblaze/include/asm/page.h
> @@ -35,9 +35,6 @@
>  
>  #define ARCH_SLAB_MINALIGN	L1_CACHE_BYTES
>  
> -#define PAGE_UP(addr)	(((addr)+((PAGE_SIZE)-1))&(~((PAGE_SIZE)-1)))
> -#define PAGE_DOWN(addr)	((addr)&(~((PAGE_SIZE)-1)))
> -
>  /*
>   * PAGE_OFFSET -- the first address of the first page of memory. With MMU
>   * it is set to the kernel start address (aligned on a page boundary).
> 

Applied.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

