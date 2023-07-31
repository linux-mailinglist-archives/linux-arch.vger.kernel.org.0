Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C715C769BF2
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 18:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjGaQLh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 12:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbjGaQLf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 12:11:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B06170A;
        Mon, 31 Jul 2023 09:11:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690819888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VPQ3fAPQWDrjXqLR7sLkRXFSfT5Axv/t++ZFAKa1vPk=;
        b=YCHvdedUGbTtdsUBSqVP5Uw9Mcx1CwPAFnkmNMZtycuurfk4nzE3k/VaYOe9StNEpek6fW
        4tZQI1qZ/8HYR4CHRVz+oSHc297wmYaQtr1Lxsq68JXMsWsZ3rqwa3/FjtNvJo3XGidbJk
        NLZF8ebij6hSGvXSn/YmZn1zszvVymPr+dCKqJIC0pPqQ3p1wSWWtgcY/Jes8i92oRRUYj
        KDEXDgkjQ/3xUJ3r2dNNjLf74LSNkxO8MOvixdltvkf5eHStJ0c4MEIso6BbjcbxA4kiVJ
        cTexDkwgKV+WoiBmfucifc+RwdDhRuvnkLHjAcRDKt1pFA0UxvV88/ucWGg3tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690819888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VPQ3fAPQWDrjXqLR7sLkRXFSfT5Axv/t++ZFAKa1vPk=;
        b=J0tyD6cXAhafaPfAXbWslIuDhV+ckGLy8BKgnEOUONS7UsIzCrAWQb2hlbxnG7rcEPQV+Q
        gDwjvGqWQ5hdNEAw==
To:     Peter Zijlstra <peterz@infradead.org>, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH v1 02/14] futex: Extend the FUTEX2 flags
In-Reply-To: <20230721105743.819362688@infradead.org>
References: <20230721102237.268073801@infradead.org>
 <20230721105743.819362688@infradead.org>
Date:   Mon, 31 Jul 2023 18:11:27 +0200
Message-ID: <87edkonjrk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 21 2023 at 12:22, Peter Zijlstra wrote:
> +#define FUTEX2_8		0x00
> +#define FUTEX2_16		0x01
>  #define FUTEX2_32		0x02
> -			/*	0x04 */
> +#define FUTEX2_64		0x03
> +#define FUTEX2_NUMA		0x04
>  			/*	0x08 */
>  			/*	0x10 */
>  			/*	0x20 */
> --- a/kernel/futex/syscalls.c
> +++ b/kernel/futex/syscalls.c
> @@ -183,7 +183,7 @@ SYSCALL_DEFINE6(futex, u32 __user *, uad
>  	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);
>  }
>  
> -#define FUTEX2_MASK (FUTEX2_32 | FUTEX2_PRIVATE)
> +#define FUTEX2_MASK (FUTEX2_64 | FUTEX2_PRIVATE)
>  
>  /**
>   * futex_parse_waitv - Parse a waitv array from userspace
> @@ -207,7 +207,12 @@ static int futex_parse_waitv(struct fute
>  		if ((aux.flags & ~FUTEX2_MASK) || aux.__reserved)
>  			return -EINVAL;

With the above aux.flags with FUTEX2_32 set will result in -EINVAL. I
don't think that's intentional.

Thanks,

        tglx
