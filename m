Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8B011174CB
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2019 19:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfLISp7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Dec 2019 13:45:59 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46627 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfLISp7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Dec 2019 13:45:59 -0500
Received: by mail-pl1-f195.google.com with SMTP id k20so6144226pll.13;
        Mon, 09 Dec 2019 10:45:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1gFoYCa7AlAmnk1s1t8ozpJosgfJNX2bcZlbOW2olns=;
        b=B7GHAHceaIHu0mkV4fG2IOZLANfvqJeH++PRmyZuN9BF0BdGyY9fbzP8CAf19RphpA
         enTEVOtfxGKGaJ+W5mBSmeo1OQ2WpXi3pqPIgVHeC/qvyn1pkfVL48bClnDcwwtoZblD
         Qo+NyY+yDxqU5gMYrqOW/9krYswZBD1hviP5lTbjj/ZBsDNxcPzI4VW7TI78m1aWtbKS
         jyswImA3q4CJ5aOdxvx/5TJJawZH2JPwjLHhmwF7rCAGzms5aYQeFhyWdXJHjRIBxrDQ
         gv22Dpyx1JploOH/iFy2Zhd/hCgqKw8cuS4odsuNvbZKbdyUdM/0WR+UMi6NxdOzBJo7
         km+Q==
X-Gm-Message-State: APjAAAXyLaTUqnjOVm7uW1uh/PQeOlivLx65RC7SvKryOqRLFAIM+0hE
        rmcM3SMQw98iGOfyxU1ZzJoYwpyRLIAYFw==
X-Google-Smtp-Source: APXvYqyl5p3COqmJGCQ+A4j4ybM0jJFj2GPBs8ZwFrQSwoz6aE/5l4nbS9i0rrQm6wjycJ92+k3zpw==
X-Received: by 2002:a17:902:aa85:: with SMTP id d5mr31870248plr.16.1575917158044;
        Mon, 09 Dec 2019 10:45:58 -0800 (PST)
Received: from localhost ([2601:646:8a00:9810:5af3:56d9:f882:39d4])
        by smtp.gmail.com with ESMTPSA id t63sm200318pfb.70.2019.12.09.10.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 10:45:57 -0800 (PST)
Date:   Mon, 9 Dec 2019 10:46:54 -0800
From:   Paul Burton <paulburton@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        James Hogan <jhogan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MIPS: define ioremap_nocache to ioremap
Message-ID: <20191209184654.w2d7mguzfc5cyage@lantea.localdomain>
References: <20191209135823.28465-1-hch@lst.de>
 <20191209135823.28465-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191209135823.28465-2-hch@lst.de>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Christoph,

On Mon, Dec 09, 2019 at 02:58:21PM +0100, Christoph Hellwig wrote:
> They are both defined the same way, but this makes it easier to validate
> the scripted ioremap_nocache removal following soon.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Paul Burton <paulburton@kernel.org>

Thanks,
    Paul

> ---
>  arch/mips/include/asm/io.h | 25 ++-----------------------
>  1 file changed, 2 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> index 3f6ce74335b4..d9caa811a2fa 100644
> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -227,29 +227,8 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset,
>   */
>  #define ioremap(offset, size)						\
>  	__ioremap_mode((offset), (size), _CACHE_UNCACHED)
> -
> -/*
> - * ioremap_nocache     -   map bus memory into CPU space
> - * @offset:    bus address of the memory
> - * @size:      size of the resource to map
> - *
> - * ioremap_nocache performs a platform specific sequence of operations to
> - * make bus memory CPU accessible via the readb/readw/readl/writeb/
> - * writew/writel functions and the other mmio helpers. The returned
> - * address is not guaranteed to be usable directly as a virtual
> - * address.
> - *
> - * This version of ioremap ensures that the memory is marked uncachable
> - * on the CPU as well as honouring existing caching rules from things like
> - * the PCI bus. Note that there are other caches and buffers on many
> - * busses. In particular driver authors should read up on PCI writes
> - *
> - * It's useful if some control registers are in such an area and
> - * write combining or read caching is not desirable:
> - */
> -#define ioremap_nocache(offset, size)					\
> -	__ioremap_mode((offset), (size), _CACHE_UNCACHED)
> -#define ioremap_uc ioremap_nocache
> +#define ioremap_nocache		ioremap
> +#define ioremap_uc		ioremap
>  
>  /*
>   * ioremap_cache -	map bus memory into CPU space
> -- 
> 2.20.1
> 
