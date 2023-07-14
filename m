Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B115B753E01
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jul 2023 16:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbjGNOsL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jul 2023 10:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjGNOsK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Jul 2023 10:48:10 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D541D2690;
        Fri, 14 Jul 2023 07:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=njTLHLFMh16HuHE6NvqX3Yjrmk8yNTzTQKCOyHUveJs=; b=WZYk4jxaFlnChcvddb0bl2o/as
        xkSs+mNy8/ZsEWQhsbL0TVjICEaLcZIVyHbJOqK4v9MskwnDo/Mzay+QctqXTWBD1JqUmBM1TYEas
        B8kItNsA2ZcQ+/ThLZqrtLu4b1Kw37BQo50qAh2QDK0KMODZ6xWrRJ/nYSMuNqhvA0oKdXDm5k7wv
        F7VAGnV9cuJub90tZH8EXoE7I/MZ+Ei7W+djkMs4XEhT6bsd0/hSrcYTlfXNDVH5pKaSFFwVNEzrs
        QhCfu3gEXGnjOCfmXegxdbtMbLPEp/4SLHPuXl3PTfsnckUSMJKfd2lPDA0+LNFf7wmVY808dcM8p
        CmySDnkA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qKK5G-006J0O-1m;
        Fri, 14 Jul 2023 14:47:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 542A53001E7;
        Fri, 14 Jul 2023 16:47:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3AEB8213728A5; Fri, 14 Jul 2023 16:47:49 +0200 (CEST)
Date:   Fri, 14 Jul 2023 16:47:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        Linux-Arch <linux-arch@vger.kernel.org>, malteskarupke@web.de
Subject: Re: [RFC][PATCH 04/10] futex: Add sys_futex_wake()
Message-ID: <20230714144749.GA3261758@hirez.programming.kicks-ass.net>
References: <20230714133859.305719029@infradead.org>
 <20230714141218.879715585@infradead.org>
 <c5a09710-a7a1-43df-ac25-42e8f3983f9c@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5a09710-a7a1-43df-ac25-42e8f3983f9c@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 14, 2023 at 04:26:45PM +0200, Arnd Bergmann wrote:
> On Fri, Jul 14, 2023, at 15:39, Peter Zijlstra wrote:
> >
> > +++ b/include/linux/syscalls.h
> > @@ -563,6 +563,9 @@ asmlinkage long sys_set_robust_list(stru
> >  asmlinkage long sys_futex_waitv(struct futex_waitv *waiters,
> >  				unsigned int nr_futexes, unsigned int flags,
> >  				struct __kernel_timespec __user *timeout, clockid_t clockid);
> > +
> > +asmlinkage long sys_futex_wake(void __user *uaddr, int nr, unsigned 
> > int flags, u64 mask);
> > +
> 
> You can't really use 'u64' arguments in portable syscalls, it causes
> a couple of problems, both with defining the user space wrappers,
> and with compat mode.
> 
> Variants that would work include:
> 
> - using 'unsigned long' instead of 'u64'
> - passing 'mask' by reference, as in splice()
> - passing the mask in two u32-bit arguments like in llseek()
> 
> Not sure if any of the above work for you.

Durr, I was hoping they'd use register pairs, but yeah I can see how
that would be very hard to do in generic code.

Hurmph.. using 2 u32s is unfortunate on 64bit, while unsigned long
would limit 64bit futexes to 64bit machines (perhaps not too bad).

Using unsigned long would help with the futex_wait() thing as well.

I'll ponder things a bit.

Obviously I only did build x86_64 ;-)
