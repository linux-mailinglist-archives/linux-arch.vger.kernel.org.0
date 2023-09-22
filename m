Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27A07AB024
	for <lists+linux-arch@lfdr.de>; Fri, 22 Sep 2023 13:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjIVLEO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Sep 2023 07:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjIVLEN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Sep 2023 07:04:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BB7AC;
        Fri, 22 Sep 2023 04:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UeywqmhCNAjqs52nmB6hEaX6k+k7gNhbsRsLtBV8z90=; b=hCJ516bu07G2X0l5xL9adb9g6E
        IxQiOaVwZTkY0yDCJ9DvQXtyUchbVKae6U/uB9YY+ZbbNYrXjBkpSeI+XwhZ/efTrDqsUzvKsnyVU
        t3fRNF7HAjQbz+zAshIhfQM1S12/lAg9pmgeA5VLaBYQBfq8oCM8PE7d4j3ycr8WuZ/H3iX72HJQq
        QX7mlIPGj3UgO0WT0CSdy+g/UciSaSVYErDSvRME7Nds6CGDKZDQCflKPQiQoW7MCH7AXxa+y3kfk
        qDl3Q+krwQHTceGJcJbgNV9veRsfFK8Hz3ecySXMEZtJuo9TbDHRtnzyORGwdWrAqYUDJSuNGsTyQ
        6Tjy9ZBA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qjdwc-00GEJm-0p;
        Fri, 22 Sep 2023 11:03:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5A95B30042E; Fri, 22 Sep 2023 13:03:35 +0200 (CEST)
Date:   Fri, 22 Sep 2023 13:03:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     tglx@linutronix.de, axboe@kernel.dk, linux-kernel@vger.kernel.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 10/15] futex: Add sys_futex_requeue()
Message-ID: <20230922110335.GC7080@noisy.programming.kicks-ass.net>
References: <20230921104505.717750284@noisy.programming.kicks-ass.net>
 <20230921105248.511860556@noisy.programming.kicks-ass.net>
 <ZQ1fx29+b8PmLVk6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQ1fx29+b8PmLVk6@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 22, 2023 at 11:35:03AM +0200, Ingo Molnar wrote:
> 
> * peterz@infradead.org <peterz@infradead.org> wrote:
> 
> > --- linux-2.6.orig/kernel/futex/syscalls.c
> > +++ linux-2.6/kernel/futex/syscalls.c
> > @@ -396,6 +396,44 @@ SYSCALL_DEFINE6(futex_wait,
> >  	return ret;
> >  }
> >  
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
> > +	int ret;
> > +
> > +	if (flags)
> > +		return -EINVAL;
> 
> Small detail, but isn't -ENOSYS the canonical error code for functionality 
> not yet implemented - which the unused 'flags' ABI is arguably?
> 
> -EINVAL is for recognized but incorrect parameters, such as:

IIUC 'unknown flag' falls into the -EINVAL return category. Here we
happen to have no known flags, but that should not matter.
