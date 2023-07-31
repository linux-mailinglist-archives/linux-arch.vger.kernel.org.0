Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA7B76A467
	for <lists+linux-arch@lfdr.de>; Tue,  1 Aug 2023 01:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjGaXAf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 19:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGaXAe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 19:00:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06D9E4E;
        Mon, 31 Jul 2023 16:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WmgsCmRaYT46DSqAZwIGXz8iJ/q3+wtkP/ja7WU2DH4=; b=cYoZtpiIOhwjGglz3U4aJxHc4v
        XjRzzEaEFufiRhCuhwRmeXO4pEPVHBfLQ3mW+Z4J9Ad2Ham/FW+At/kSqI0QtJ+ISuSe8VFqPNSB2
        OJGeurnIPLSsfgjdwUuLk8Be2z9GcOpO/AWZu6PSRXr+8kwUugbS7Xzpm7x2mJJGdB2JZmvvTdlgY
        Xo17DosCdkRgbU1WwoK7neR0MHJC/oCkCG/K897caVv3T9Vn/ZArfbtmd9H+RDNN6vZrhm+OaYI9w
        kJQMe8iHWtioB+Wc8Q+Tl5C1CzEkRbayyF3ayVQ0Pz3CQFlvgGdc5Il0IE2KqzQLt0Rt1CUTT/KKP
        N2ha2UyQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQbru-00DA0u-30;
        Mon, 31 Jul 2023 23:00:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 56511300134;
        Tue,  1 Aug 2023 01:00:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E44BC213D004E; Tue,  1 Aug 2023 00:59:59 +0200 (CEST)
Date:   Tue, 1 Aug 2023 00:59:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org, mingo@redhat.com,
        dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
        Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH v1 02/14] futex: Extend the FUTEX2 flags
Message-ID: <20230731225959.GE51835@hirez.programming.kicks-ass.net>
References: <20230721102237.268073801@infradead.org>
 <20230721105743.819362688@infradead.org>
 <87edkonjrk.ffs@tglx>
 <87mszcm0zw.ffs@tglx>
 <20230731192012.GA11704@hirez.programming.kicks-ass.net>
 <87a5vbn5r0.ffs@tglx>
 <20230731213341.GB51835@hirez.programming.kicks-ass.net>
 <87y1ivln1v.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1ivln1v.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 01, 2023 at 12:43:24AM +0200, Thomas Gleixner wrote:
> > Also, sys_futex_{wake,wait}() have this thing as a syscall argument,
> > surely you don't want to put this union there as well?
> 
> Why not? The anon union does not break the ABI unless I'm missing
> something. Existing user space can still use 'flags' and people who care
> about readability can use the bitfield, no?
> 
> Its inside struct futex_waitv and not an explicit syscall argument, right?

Nope, see patches 5 and 6, they introduce:

sys_futex_wake(void __user *uaddr, unsigned long mask, int nr, unsigned int flags);
sys_futex_wait(void __user *uaddr, unsigned long val,
               unsigned long mask, unsigned int flags,
	       struct __kernel_timespec __user *timeout, clockid_t clockid);

Using a union, would turn that into:

sys_futex_wake(void __user *uaddr, unsigned long mask, int nr, union futex_flags flags);
sys_futex_wait(void __user *uaddr, unsigned long val,
               unsigned long mask, union futex_flags flags,
	       struct __kernel_timespec __user *timeout, clockid_t clockid);

Which then gets people to write garbage like:

	futex_wake(add, 0xFFFF, 1, (union futex_flags){ .flags = FUTEX2_SIZE_U16 | FUTEX2_PRIVATE));
or
	futex_wake(add, 0xFFFF, 1, (union futex_flags){ .size = FUTEX2_SIZE_U16, private = true, ));

You really want that ?
