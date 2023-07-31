Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E462176A27C
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 23:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjGaVOP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 17:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjGaVOO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 17:14:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8CF10E3;
        Mon, 31 Jul 2023 14:14:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690838051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zmlfoRcUVyyK6VDWwuqIXZu4oD0M/UoDbT+qIU6ZUP8=;
        b=GNkr4yO9Wh8utq3Zt2tM8NULxbMTdkTTfxsbR2e7JLp8ip1wDgEg99qZ6Q+4xpHY5ny9Ma
        s6aSDxn89YCUHl3ChYtUZuJfgtQMf5XsnydZ9VxOJqmZubHu9Ftk/t5q/b0BsYeL3/J708
        v6DWbT7qwiaEeswVAw3hUjuG8Nu2wZOZHkEeZcfxAV9RZsGivU+YfOCzlFE10X+O1hmwPd
        /2q8QWfz6eFy5qdiTk+OadjzLVW/reZOUBq/disMAW4+Tu642/kOahCDrGkJDO06vVihL3
        OA3hjqU3HUz81tK2ZWcLLCckYPC2oMlZoH80PE+8u8hc4Ny8HwjDw6XZd5NWqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690838051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zmlfoRcUVyyK6VDWwuqIXZu4oD0M/UoDbT+qIU6ZUP8=;
        b=wB5Xf+Iq3rcAu4YpX7kKXKT+wmsUYdpedrVysKtZQz/odp4Xuif6wYETOyAZgFE/eynJ7H
        qIMRzrxdAOliZkCw==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org, mingo@redhat.com,
        dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
        Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH v1 02/14] futex: Extend the FUTEX2 flags
In-Reply-To: <20230731192012.GA11704@hirez.programming.kicks-ass.net>
References: <20230721102237.268073801@infradead.org>
 <20230721105743.819362688@infradead.org> <87edkonjrk.ffs@tglx>
 <87mszcm0zw.ffs@tglx>
 <20230731192012.GA11704@hirez.programming.kicks-ass.net>
Date:   Mon, 31 Jul 2023 23:14:11 +0200
Message-ID: <87a5vbn5r0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 31 2023 at 21:20, Peter Zijlstra wrote:
> -#define FUTEX2_MASK (FUTEX2_64 | FUTEX2_PRIVATE)
> +#define FUTEX2_MASK (FUTEX2_SIZE_MASK | FUTEX2_PRIVATE)

Along with some comment which documents that the size "flags" constitute
a number field and not flags in the sense of binary flags.

And please name these size constants so it really becomes obvious:

#define FUTEX2_SIZE_U32		2

>  /**
>   * futex_parse_waitv - Parse a waitv array from userspace
> @@ -208,11 +208,11 @@ static int futex_parse_waitv(struct fute
>  			return -EINVAL;
>  
>  		if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall()) {
> -			if ((aux.flags & FUTEX2_64) == FUTEX2_64)
> +			if ((aux.flags & FUTEX2_SIZE_MASK) == FUTEX2_64)
>  				return -EINVAL;
>  		}

That should be part of the actual 64bit futex enablement, no?
  
> -		if ((aux.flags & FUTEX2_64) != FUTEX2_32)
> +		if ((aux.flags & FUTEX2_SIZE_MASK) != FUTEX2_32)
>  			return -EINVAL;

In hindsight I think it was as mistake just to have this __u32 flags
field in the new interface. Soemthing like the incomplete below might be
retrofittable, no?

--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -74,7 +74,12 @@
 struct futex_waitv {
 	__u64 val;
 	__u64 uaddr;
-	__u32 flags;
+	union {
+		__u32	flags;
+		__u32	size	: 2,
+				: 5,
+			private	: 1;
+	};
 	__u32 __reserved;
 };
 
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -204,10 +204,10 @@ static int futex_parse_waitv(struct fute
 		if (copy_from_user(&aux, &uwaitv[i], sizeof(aux)))
 			return -EFAULT;
 
-		if ((aux.flags & ~FUTEX2_MASK) || aux.__reserved)
+		if ((aux.flags & ~FUTEX2_VALID_FLAGBITS) || aux.__reserved)
 			return -EINVAL;
 
-		if (!(aux.flags & FUTEX2_32))
+		if (aux.size != FUTEX2_SIZE_U32)
 			return -EINVAL;
 
 		futexv[i].w.flags = aux.flags;


If this muck already confused me right now, then I don't want to
experience the confusion factor 6 month down the road :)

Thanks,

        tglx
