Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C8A227201
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 00:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgGTWKt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jul 2020 18:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgGTWKt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jul 2020 18:10:49 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7521CC061794;
        Mon, 20 Jul 2020 15:10:49 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id o22so637871pjw.2;
        Mon, 20 Jul 2020 15:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h0GEicoGZvUY4aSOetLAK7yh5EuOCMqYG/Hqy0bSab8=;
        b=rEffvtAR5yY0laEVInca+LKZUHy7fvvHGPywogRX7YS2qAduLQJ0l+6YVHo0eZh2+J
         xB8kMhyRt6fstkCPtgGeoMwCFEvHRsfx9PtG0/ZgvhduN38XzekAFIKa0oniNUvqnFru
         +qG/DOKHpgFgAntgCwTdaZjaY8Nx6dk606FiOtWk0hdKFfhFV7O0o8Oz9pGv6Pqon2Cd
         99wrcDypHEybAOdNoNA3FhZWnbYQb6ggkFFfmQOQQIelNIIphQ4A3IqRDCeq6hGWy0zq
         uZAkEZqTPYeAMyDKrPTkKBPrXc6XqXor0opjNfNwor9pdTsYMleGK8hfzVkj0nbGL6bQ
         qopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=h0GEicoGZvUY4aSOetLAK7yh5EuOCMqYG/Hqy0bSab8=;
        b=jUwKlnXGTiMLSqx26r668fPEsCnZHc6YDDg3Rtb0DZ8tK5ozBAMSGqELE5dBrb6L25
         TEGSaF+Fl/ScC3gwsIedvZD/sKuN6WZIAMxwMZ9Y/nE+xVqcohavjSvty2eZva07scQP
         8GAzrJAEDKsVgRsoY5raVb+wJcZGwrWYK6h8/zVVnyAI0pehLTP0UFPclqT+yXVNFOUE
         s2G4ChxtI4E/w6LImxPq2OCTRAqnNfhNX9+uPxzmMr4ZuUvdQDtsrUWZxmJvmq/Ot10f
         RnOkglIL/UIRsXPVL9P34U8KCHt/VshT4YH/JRZFoTSwJX4c6euuL0cBRuxXZFJLEkHR
         Asvw==
X-Gm-Message-State: AOAM5337nv7IWU/Lvz0IZpKFZ9t9n7DLu0ufRuqZhBzErbP17xxSrA/d
        Phk7gcoMhi0NvHi49Krd4DE=
X-Google-Smtp-Source: ABdhPJyAtwghREh+cNVe4GBVZ28Uhys24HSMBEM0bwHPLTtJGq3WqPh0KHblwq+XQJwxzII+Zp5Afg==
X-Received: by 2002:a17:90a:d684:: with SMTP id x4mr1458894pju.62.1595283049018;
        Mon, 20 Jul 2020 15:10:49 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e28sm17823273pfm.177.2020.07.20.15.10.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Jul 2020 15:10:47 -0700 (PDT)
Date:   Mon, 20 Jul 2020 15:10:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] syscalls: use uaccess_kernel in addr_limit_user_check
Message-ID: <20200720221046.GA86726@roeck-us.net>
References: <20200714105505.935079-1-hch@lst.de>
 <20200714105505.935079-2-hch@lst.de>
 <20200718013849.GA157764@roeck-us.net>
 <20200718094846.GA8593@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718094846.GA8593@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 18, 2020 at 11:48:46AM +0200, Christoph Hellwig wrote:
> On Fri, Jul 17, 2020 at 06:38:50PM -0700, Guenter Roeck wrote:
> > Hi,
> > 
> > On Tue, Jul 14, 2020 at 12:55:00PM +0200, Christoph Hellwig wrote:
> > > Use the uaccess_kernel helper instead of duplicating it.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > This patch causes a severe hiccup with my mps2-an385 boot test.
> 

I had another look into the code. Right after this patch, I see

#define uaccess_kernel() segment_eq(get_fs(), KERNEL_DS)

Yet, this patch is:

-       if (CHECK_DATA_CORRUPTION(!segment_eq(get_fs(), USER_DS),
+       if (CHECK_DATA_CORRUPTION(uaccess_kernel(),

So there is a negation in the condition. Indeed, the following change
on top of next-20200720 fixes the problem for mps2-an385.

-       if (CHECK_DATA_CORRUPTION(uaccess_kernel(),
+       if (CHECK_DATA_CORRUPTION(!uaccess_kernel(),

How does this work anywhere ?

Thanks,
Guenter

> I guess that is a nommu config?
> 
> Can you try this patch?
> 
> diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
> index b19c9bec1f7a63..cc7daf374a6eb6 100644
> --- a/arch/arm/include/asm/uaccess.h
> +++ b/arch/arm/include/asm/uaccess.h
> @@ -263,7 +263,7 @@ extern int __put_user_8(void *, unsigned long long);
>   */
>  #define USER_DS			KERNEL_DS
>  
> -#define uaccess_kernel()	(true)
> +#define uaccess_kernel()	(false)
>  #define __addr_ok(addr)		((void)(addr), 1)
>  #define __range_ok(addr, size)	((void)(addr), 0)
>  #define get_fs()		(KERNEL_DS)
