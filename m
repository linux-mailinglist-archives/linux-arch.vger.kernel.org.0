Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B97769F94
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 19:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjGaRjK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 13:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjGaRjJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 13:39:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7D0C7;
        Mon, 31 Jul 2023 10:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FWxe5J1hE38eMUz7xvskScrwN5CGj61RpGiQj1KfL8k=; b=N/PvmfIJka0LmTfamlvuygudrb
        JsbinBTLLKNiq37bm5mPPAVv09JhACMF/0Xkb7VJbrwYVu2oOHZydYjUI0rzG51C7GloDM58pGP/B
        O8NPzkWqqzqXbvkiENP+6mMw9GWCP9lDcxrYAFFg/59l8TWowq+Yg3BkjPBLmqd4TpOJkMUKx7vOq
        5MwhUEpkM23PYPrSMEL6LXc1d9KYsimAjG90HseJwi5J+UGUNqABkgUocYhXWXtTfZ9X8UkfhJubJ
        RjyPZo/De79puk4DXLKnGKryAlMAHfcK30fNBlCKVn/aIYrErIJTcA0NngTqsHMNyNtFvVaiHWrkQ
        ZzwQOeXQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qQWrA-002vaJ-91; Mon, 31 Jul 2023 17:38:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 51E00300134;
        Mon, 31 Jul 2023 19:38:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 366B5203C0B01; Mon, 31 Jul 2023 19:38:56 +0200 (CEST)
Date:   Mon, 31 Jul 2023 19:38:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org, mingo@redhat.com,
        dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
        Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH v1 09/14] futex: Add sys_futex_requeue()
Message-ID: <20230731173856.GQ29590@hirez.programming.kicks-ass.net>
References: <20230721102237.268073801@infradead.org>
 <20230721105744.298661259@infradead.org>
 <87sf94m222.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sf94m222.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 31, 2023 at 07:19:17PM +0200, Thomas Gleixner wrote:
> On Fri, Jul 21 2023 at 12:22, Peter Zijlstra wrote:
> > +/*
> > + * sys_futex_requeue - Requeue a waiter from one futex to another
> > + * @waiters:	array describing the source and destination futex
> > + * @flags:	unused
> > + * @nr_wake:	number of futexes to wake
> > + * @nr_requeue:	number of futexes to requeue
> > + *
> > + * Identical to the traditional FUTEX_CMP_REQUEUE op, except it is part of the
> > + * futex2 family of calls.
> > + */
> > +
> > +SYSCALL_DEFINE4(futex_requeue,
> > +		struct futex_waitv __user *, waiters,
> > +		unsigned int, flags,
> > +		int, nr_wake,
> > +		int, nr_requeue)
> > +{
> > +	struct futex_vector futexes[2];
> > +	u32 cmpval;
> 
> So this is explictely u32. I'm completely confused vs. the 64 bit futex
> size variant enablement earlier in the series by now.

As per the previous email; these patches only enable the syscall part of
64bit futexes, they do not convert the core, and per futex_flags_valid()
(patches 4 and 13), explicitly disallow having FUTEX2_64 set.


-       /* Only 32bit futexes are implemented -- for now */
-       if ((flags & FLAGS_SIZE_MASK) != FLAGS_SIZE_32)
+       /* 64bit futexes aren't implemented -- yet */
+       if ((flags & FLAGS_SIZE_MASK) == FLAGS_SIZE_64)
		return false;


