Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907425BCF75
	for <lists+linux-arch@lfdr.de>; Mon, 19 Sep 2022 16:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiISOq4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Sep 2022 10:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiISOqz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Sep 2022 10:46:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61439EE1A;
        Mon, 19 Sep 2022 07:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ce3z96Js4LblxY5GROf+dxFvOAIV9SCqQWmJq0OtdtQ=; b=vSGtfB9YKERIyQrYTSjZ55U2gE
        TWBwcP7KMMvUwB1p6Sed9omokTt09xfC8Qy6BNR4kIxwnex9L9vdPVO1SWHnn7o0cD0Oj1tPWGuEo
        P6Z1HbOd72vni2tci7W7nl4FF+7BXfsS0iw3Dj39+aR36KeUi+uOGZ/p9W/9jHrUSlkbqdZlBAPtt
        LyqBzXtgU+Wam/XDyijoi3GjytkxszSwGq/RG4pSghV3ugangfI6cHJy/swlUlzE2vGXFpxrPEyUU
        IDmAGT45DdSi6on+e7EMdBfR2GqwrqtD1PVxOElaXUDK5zvehVO4+jI9wsGHQ12EoS852WGnSg/x3
        os5LmJvQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaI2k-004mep-Or; Mon, 19 Sep 2022 14:46:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BDA9F300202;
        Mon, 19 Sep 2022 16:46:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A2DB32BAC7765; Mon, 19 Sep 2022 16:46:39 +0200 (CEST)
Date:   Mon, 19 Sep 2022 16:46:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Yu Zhao <yuzhao@google.com>, dev@der-flo.net,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 0/3] x86/dumpstack: Inline copy_from_user_nmi()
Message-ID: <YyiAz4gs4TvTqrvI@hirez.programming.kicks-ass.net>
References: <20220916135953.1320601-1-keescook@chromium.org>
 <20220916125723.b4c189d09bcd8fd211a73c32@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916125723.b4c189d09bcd8fd211a73c32@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 16, 2022 at 12:57:23PM -0700, Andrew Morton wrote:
> On Fri, 16 Sep 2022 06:59:51 -0700 Kees Cook <keescook@chromium.org> wrote:
> 
> > Hi,
> > 
> > This fixes a find_vmap_area() deadlock. The main fix is patch 2, repeated here:
> > 
> >     The check_object_size() helper under CONFIG_HARDENED_USERCOPY is
> >     designed to skip any checks where the length is known at compile time as
> >     a reasonable heuristic to avoid "likely known-good" cases. However, it can
> >     only do this when the copy_*_user() helpers are, themselves, inline too.
> > 
> >     Using find_vmap_area() requires taking a spinlock. The check_object_size()
> >     helper can call find_vmap_area() when the destination is in vmap memory.
> >     If show_regs() is called in interrupt context, it will attempt a call to
> >     copy_from_user_nmi(), which may call check_object_size() and then
> >     find_vmap_area(). If something in normal context happens to be in the
> >     middle of calling find_vmap_area() (with the spinlock held), the interrupt
> >     handler will hang forever.
> > 
> >     The copy_from_user_nmi() call is actually being called with a fixed-size
> >     length, so check_object_size() should never have been called in the
> >     first place. In order for check_object_size() to see that the length is
> >     a fixed size, inline copy_from_user_nmi(), as already done with all the
> >     other uaccess helpers.
> > 
> 
> Why is this so complicated.
> 
> There's virtually zero value in running all those debug checks from within
> copy_from_user_nmi().
> 
> --- a/arch/x86/lib/usercopy.c~a
> +++ a/arch/x86/lib/usercopy.c
> @@ -44,7 +44,7 @@ copy_from_user_nmi(void *to, const void
>  	 * called from other contexts.
>  	 */
>  	pagefault_disable();
> -	ret = __copy_from_user_inatomic(to, from, n);
> +	ret = raw_copy_from_user(to, from, n);
>  	pagefault_enable();
>  
>  	return ret;

I'm with Andrew here; this looks a *LOT* saner than all the other stuff.
