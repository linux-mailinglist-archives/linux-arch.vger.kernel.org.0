Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADA75BB317
	for <lists+linux-arch@lfdr.de>; Fri, 16 Sep 2022 21:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiIPT52 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Sep 2022 15:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiIPT50 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Sep 2022 15:57:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EC4B6D68;
        Fri, 16 Sep 2022 12:57:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E48562CA2;
        Fri, 16 Sep 2022 19:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4599FC433D6;
        Fri, 16 Sep 2022 19:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663358244;
        bh=toDD/DKP6ej2h13IFCfqAwO2xnElND7IEzQWcWOhAqI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fhlmuao9gEG+AEm6I2K7+XKwGMFg0YwspJcIDXhJE3SqUlTamt3OveKskBKFPKz7e
         7vt/kU0mHM9Nzc0uzQSp9mKiWSIbf+Mbfsy6aLoW1h0glwmkKUk8EaeFBHea3rxm0I
         QJQ64gI3IHdtu9eZ+E6nOBptuTupvwO0jn6Rffoc=
Date:   Fri, 16 Sep 2022 12:57:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Yu Zhao <yuzhao@google.com>, dev@der-flo.net,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 0/3] x86/dumpstack: Inline copy_from_user_nmi()
Message-Id: <20220916125723.b4c189d09bcd8fd211a73c32@linux-foundation.org>
In-Reply-To: <20220916135953.1320601-1-keescook@chromium.org>
References: <20220916135953.1320601-1-keescook@chromium.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 16 Sep 2022 06:59:51 -0700 Kees Cook <keescook@chromium.org> wrote:

> Hi,
> 
> This fixes a find_vmap_area() deadlock. The main fix is patch 2, repeated here:
> 
>     The check_object_size() helper under CONFIG_HARDENED_USERCOPY is
>     designed to skip any checks where the length is known at compile time as
>     a reasonable heuristic to avoid "likely known-good" cases. However, it can
>     only do this when the copy_*_user() helpers are, themselves, inline too.
> 
>     Using find_vmap_area() requires taking a spinlock. The check_object_size()
>     helper can call find_vmap_area() when the destination is in vmap memory.
>     If show_regs() is called in interrupt context, it will attempt a call to
>     copy_from_user_nmi(), which may call check_object_size() and then
>     find_vmap_area(). If something in normal context happens to be in the
>     middle of calling find_vmap_area() (with the spinlock held), the interrupt
>     handler will hang forever.
> 
>     The copy_from_user_nmi() call is actually being called with a fixed-size
>     length, so check_object_size() should never have been called in the
>     first place. In order for check_object_size() to see that the length is
>     a fixed size, inline copy_from_user_nmi(), as already done with all the
>     other uaccess helpers.
> 

Why is this so complicated.

There's virtually zero value in running all those debug checks from within
copy_from_user_nmi().

--- a/arch/x86/lib/usercopy.c~a
+++ a/arch/x86/lib/usercopy.c
@@ -44,7 +44,7 @@ copy_from_user_nmi(void *to, const void
 	 * called from other contexts.
 	 */
 	pagefault_disable();
-	ret = __copy_from_user_inatomic(to, from, n);
+	ret = raw_copy_from_user(to, from, n);
 	pagefault_enable();
 
 	return ret;
_

