Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DA45BB198
	for <lists+linux-arch@lfdr.de>; Fri, 16 Sep 2022 19:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiIPR3Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Sep 2022 13:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIPR3P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Sep 2022 13:29:15 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC05EB5A72;
        Fri, 16 Sep 2022 10:29:14 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id k10so36634000lfm.4;
        Fri, 16 Sep 2022 10:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=c99THgg/Qu0Uq0g1n2HvJ4GdbvThpErIDXzsQyV5Y5M=;
        b=eN2BMBgsZzIHstlT6w6/JlqB6fmfOVwchpgbw5yUUQ1CVP9LpL7cwDinWmTalaZh1K
         B8eGSg8d56nehxCAwsIvboZ+spzR5QjQQoc0Tob9ul1uSUQKIA3x5erYAdxwgdbYI1Xb
         Y1OOhV66eIT7XWPjDXjkqhEIpqHro8TQ0Bhpj/lVv1BZ0852s2vlDJBEjPehSU9MrGfE
         07Yu65TPUquxzWtLydmFCxnYulixscsCAK73Z7RMfcOIR6jWb4KWCw3SzipQP4NN9SYY
         Dx8wEzM9p8S/u2ZWqdc+fmGTjt5CjJaxcvRmPNMgG7KWaNSPcaBuGHvAkR/rYPpPFyJ9
         aTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=c99THgg/Qu0Uq0g1n2HvJ4GdbvThpErIDXzsQyV5Y5M=;
        b=eWXWS/ibbMhr+ka7dovCjUNyBT7LnbGGJvhD2C2ghieZ/BOE/LYfDw78BWzfcmKHP0
         hDDj8ZwGW88Vh/97gd2yI7znFuwIfgNHC9SY/Qfy1a9X/nGHUGCvxZgB/wMJWAaN3D88
         QJMDJtsoJwzoIwo2Q0nd5HIMXPPtmaS0hZT5D4Zwsx6F9RBZO+0ckxdJe9D7Nv47J0N8
         KEnpLd0gJ21kPMEA2mOvAe7FfFT+WftGu7zLU027nR0mRuge49erssO5X0JiMlPwsd6d
         Ogv9if1Zufgs1rqFiODyBNiaCzy8zqjqIJmbOjEamdE87g8C8+NWyko53ycDCqvKc2zS
         YeMQ==
X-Gm-Message-State: ACrzQf0ntCQFqRrMAhHgIWVqa6xcf8IBV6jl8LzJKrk5vcKWztTqJpTU
        WucPGVglY8RAt3CZVdiQXzg=
X-Google-Smtp-Source: AMsMyM7G12shYaSwRYpiyRnjwgOShehtfYm9M38UQS6WG2ub/wqwZyBZ/jAB4NB382PL6nr4GKMEKA==
X-Received: by 2002:a19:e044:0:b0:497:14fd:326f with SMTP id g4-20020a19e044000000b0049714fd326fmr1941972lfj.332.1663349353017;
        Fri, 16 Sep 2022 10:29:13 -0700 (PDT)
Received: from pc636 (host-90-235-8-56.mobileonline.telia.com. [90.235.8.56])
        by smtp.gmail.com with ESMTPSA id q14-20020a056512210e00b00492cfecf1c0sm3592686lfr.245.2022.09.16.10.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 10:29:12 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 16 Sep 2022 19:29:09 +0200
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, dev@der-flo.net,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/3] usercopy: Add find_vmap_area_try() to avoid deadlocks
Message-ID: <YySyZZh6Cu/Zf/F5@pc636>
References: <20220916135953.1320601-1-keescook@chromium.org>
 <20220916135953.1320601-4-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916135953.1320601-4-keescook@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 16, 2022 at 06:59:57AM -0700, Kees Cook wrote:
> The check_object_size() checks under CONFIG_HARDENED_USERCOPY need to be
> more defensive against running from interrupt context. Use a best-effort
> check for VMAP areas when running in interrupt context
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Link: https://lore.kernel.org/linux-mm/YyQ2CSdIJdvQPSPO@casper.infradead.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: dev@der-flo.net
> Cc: linux-mm@kvack.org
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/vmalloc.h |  1 +
>  mm/usercopy.c           | 11 ++++++++++-
>  mm/vmalloc.c            | 11 +++++++++++
>  3 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 096d48aa3437..c8a00f181a11 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -216,6 +216,7 @@ void free_vm_area(struct vm_struct *area);
>  extern struct vm_struct *remove_vm_area(const void *addr);
>  extern struct vm_struct *find_vm_area(const void *addr);
>  struct vmap_area *find_vmap_area(unsigned long addr);
> +struct vmap_area *find_vmap_area_try(unsigned long addr);
>  
>  static inline bool is_vm_area_hugepages(const void *addr)
>  {
> diff --git a/mm/usercopy.c b/mm/usercopy.c
> index c1ee15a98633..4a371099ac64 100644
> --- a/mm/usercopy.c
> +++ b/mm/usercopy.c
> @@ -173,7 +173,16 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
>  	}
>  
>  	if (is_vmalloc_addr(ptr)) {
> -		struct vmap_area *area = find_vmap_area(addr);
> +		struct vmap_area *area;
> +
> +		if (unlikely(in_interrupt())) {
> +			area = find_vmap_area_try(addr);
> +			/* Give up under interrupt to avoid deadlocks. */
> +			if (!area)
> +				return;
> +		} else {
> +			area = find_vmap_area(addr);
> +		}
>  
>  		if (!area)
>  			usercopy_abort("vmalloc", "no area", to_user, 0, n);
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index dd6cdb201195..f14f1902c2f6 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1840,6 +1840,17 @@ struct vmap_area *find_vmap_area(unsigned long addr)
>  	return va;
>  }
>  
> +struct vmap_area *find_vmap_area_try(unsigned long addr)
>
I think it makes sense to add a comment of having such function and for
which context it is supposed to be used. Maybe rename it to something
with "atomic" prefix.

Thanks.

--
Uladzislau Rezki
