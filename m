Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C185BC452
	for <lists+linux-arch@lfdr.de>; Mon, 19 Sep 2022 10:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiISI37 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Sep 2022 04:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiISI3t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Sep 2022 04:29:49 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FB065EF;
        Mon, 19 Sep 2022 01:29:47 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id sb3so33080313ejb.9;
        Mon, 19 Sep 2022 01:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=xoymz8faVzT0wsOgDh8GpMXHhgQOtJ4iGMWiJ5WcE5M=;
        b=Lm7BO126imBfW2p86+6dSuKs+lWUTMbm5eMgm9pFu/j9M/kqYbL3JPu1nJiCf2uXr4
         I7IjQVG8rbtLB0O7vzXFYE+FtBv2dj5kEBIvcsHegeo10YjZOcoRy1WxnAtjcEC/iNDW
         LcZ876QNCiVqfZB64ohts2NklO+0MWD4dVJ/IzGNrK5jBfbQMOHyIOKpjO4KZqmvbhZZ
         wUdEFhlwl+rhhZZ3tSlF8mb5iHWsovbVUpVkoOGA/EKZVYlXfCdv2ngNkltl17K4xVE6
         tXMXyO/wJ7y8GipOINg2yZTi0v86atZT9vywEtsJ82Dsk6Aw4RVBVqeYs5+x1cRDgJyy
         0rEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=xoymz8faVzT0wsOgDh8GpMXHhgQOtJ4iGMWiJ5WcE5M=;
        b=4pCH6dZyol4FmHtqoeQaDQckaCfIEYpfi49CKaIR/iRlJhj2Y/uQ5NXXe7OCMYqZ9b
         1qbicvvbQ2wlr6E/fdV4zOQ+J2hniYt5qAE63XjVvtD8koyP4PTUjEEsgNRVlNpySeNV
         xNv8/Vl9GYi1HRfWX7Vyu5W0NuCK/4J+RCx/2g0NY9bz6kV6JxnCbJdN0Yy2zGw7amHt
         szjuNCG+tjxGDMIKMXwT23WOcRReOAYJn95bvrE41PZ6RnAvDCpvx/kj3XidGJDGJBTY
         IRY+aHVX4S0/eSaPrrtzXBB1XFDk62fD5ee5SMV2bmtlTwpwLjAiu7bEAPdsKAt8bz1u
         Hi2g==
X-Gm-Message-State: ACrzQf30Mw+B7khMu7rjtnDOPePYufZnwD+c4mDyoYmJCZ4ygxl7ARba
        SA8rS/gZLXsQiNmi9kOr2jU=
X-Google-Smtp-Source: AMsMyM7YDpMsT8S/fBs/dBZJOSrjXi9Pb8U6bCYB3DP/597jg0tInZfxP8MG7aCnJ70pWKg7ildXhA==
X-Received: by 2002:a17:906:ee86:b0:741:89bc:27a1 with SMTP id wt6-20020a170906ee8600b0074189bc27a1mr12414411ejb.725.1663576185705;
        Mon, 19 Sep 2022 01:29:45 -0700 (PDT)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id s15-20020a1709067b8f00b00775f6081a87sm2271881ejo.121.2022.09.19.01.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 01:29:45 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 19 Sep 2022 10:29:43 +0200
To:     Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, dev@der-flo.net,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/3] usercopy: Add find_vmap_area_try() to avoid deadlocks
Message-ID: <Yygod+YBwzbMPmgA@pc636>
References: <20220916135953.1320601-1-keescook@chromium.org>
 <20220916135953.1320601-4-keescook@chromium.org>
 <YySML2HfqaE/wXBU@casper.infradead.org>
 <202209160805.CA47B2D673@keescook>
 <YyTLTBM4OC6/RnjG@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyTLTBM4OC6/RnjG@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 16, 2022 at 08:15:24PM +0100, Matthew Wilcox wrote:
> On Fri, Sep 16, 2022 at 08:09:16AM -0700, Kees Cook wrote:
> > On Fri, Sep 16, 2022 at 03:46:07PM +0100, Matthew Wilcox wrote:
> > > On Fri, Sep 16, 2022 at 06:59:57AM -0700, Kees Cook wrote:
> > > > The check_object_size() checks under CONFIG_HARDENED_USERCOPY need to be
> > > > more defensive against running from interrupt context. Use a best-effort
> > > > check for VMAP areas when running in interrupt context
> > > 
> > > I had something more like this in mind:
> > 
> > Yeah, I like -EAGAIN. I'd like to keep the interrupt test to choose lock
> > vs trylock, otherwise it's trivial to bypass the hardening test by having
> > all the other CPUs beating on the spinlock.
> 
> I was thinking about this:
> 
> +++ b/mm/vmalloc.c
> @@ -1844,12 +1844,19 @@
>  {
>  	struct vmap_area *va;
> 
> -	if (!spin_lock(&vmap_area_lock))
> -		return ERR_PTR(-EAGAIN);
> +	/*
> +	 * It's safe to walk the rbtree under the RCU lock, but we may
> +	 * incorrectly find no vmap_area if the tree is being modified.
> +	 */
> +	rcu_read_lock();
>  	va = __find_vmap_area(addr, &vmap_area_root);
> -	spin_unlock(&vmap_area_lock);
> +	if (!va && in_interrupt())
> +		va = ERR_PTR(-EAGAIN);
> +	rcu_read_unlock();
> 
> -	return va;
> +	if (va)
> +		return va;
> +	return find_vmap_area(addr);
>  }
> 
>  /*** Per cpu kva allocator ***/
> 
> ... but I don't think that works since vmap_areas aren't freed by RCU,
> and I think they're reused without going through an RCU cycle.
>
Right you are. It should be freed via RCU-core. So wrapping by rcu_* is
useless here.

> 
> So here's attempt #4, which actually compiles, and is, I think, what you
> had in mind.
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 096d48aa3437..2b7c52e76856 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -215,7 +215,7 @@ extern struct vm_struct *__get_vm_area_caller(unsigned long size,
>  void free_vm_area(struct vm_struct *area);
>  extern struct vm_struct *remove_vm_area(const void *addr);
>  extern struct vm_struct *find_vm_area(const void *addr);
> -struct vmap_area *find_vmap_area(unsigned long addr);
> +struct vmap_area *find_vmap_area_try(unsigned long addr);
>  
>  static inline bool is_vm_area_hugepages(const void *addr)
>  {
> diff --git a/mm/usercopy.c b/mm/usercopy.c
> index c1ee15a98633..e0fb605c1b38 100644
> --- a/mm/usercopy.c
> +++ b/mm/usercopy.c
> @@ -173,7 +173,11 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
>  	}
>  
>  	if (is_vmalloc_addr(ptr)) {
> -		struct vmap_area *area = find_vmap_area(addr);
> +		struct vmap_area *area = find_vmap_area_try(addr);
> +
> +		/* We may be in NMI context */
> +		if (area == ERR_PTR(-EAGAIN))
> +			return;
>  
>  		if (!area)
>  			usercopy_abort("vmalloc", "no area", to_user, 0, n);
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index dd6cdb201195..c47b3b5d1c2d 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1829,7 +1829,7 @@ static void free_unmap_vmap_area(struct vmap_area *va)
>  	free_vmap_area_noflush(va);
>  }
>  
> -struct vmap_area *find_vmap_area(unsigned long addr)
> +static struct vmap_area *find_vmap_area(unsigned long addr)
>  {
>  	struct vmap_area *va;
>  
> @@ -1840,6 +1840,26 @@ struct vmap_area *find_vmap_area(unsigned long addr)
>  	return va;
>  }
>  
> +/*
> + * The vmap_area_lock is not interrupt-safe, and we can end up here from
> + * NMI context, so it's not worth even trying to make it IRQ-safe.
> + */
> +struct vmap_area *find_vmap_area_try(unsigned long addr)
> +{
> +	struct vmap_area *va;
> +
> +	if (in_interrupt()) {
> +		if (!spin_trylock(&vmap_area_lock))
> +			return ERR_PTR(-EAGAIN);
> +	} else {
> +		spin_lock(&vmap_area_lock);
> +	}
> +	va = __find_vmap_area(addr, &vmap_area_root);
> +	spin_unlock(&vmap_area_lock);
> +
> +	return va;
> +}
> +
>
If we look at it other way around. There is a user that tries to access
the tree from IRQ context. Can we just extend the find_vmap_area() with?

   - in_interrupt();
   - use trylock if so.

--
Uladzislau Rezki
