Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0D375D1CD
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jul 2023 20:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjGUSxF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jul 2023 14:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjGUSxE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jul 2023 14:53:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0F530CA;
        Fri, 21 Jul 2023 11:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r7HKb0fHKAzqTvjH4XFG87Ln9mhascjsc5GVXDtG5p0=; b=iMKuGzkflbdlrFkVAjStdw2Je5
        9kHIxeM+r1V0Yn0ulE3UYkPmNrg8KIegNMAfErN0GSTjejkOqn+8nH4FD11aIYTl4FsXdNv803aBo
        gzjhnriyNiotaaCyuAcmqn65Mh42ZcG78tdz2OFKdRUIsuAJ6TOBzlA0DRgVYG+nowv9V0MgAe4fB
        hkVVUF6MRXdgth7Yhuw32q3XQLEinsbxbHFcOdAdnJk9C5uGCNotMVqvCNInv5DhpsBJPepJDdVAX
        OHwNbfbW6kapWN1CQ8d1CwVlb7Uk/bjgcPC1Z5YgwSkhLRZwZyfOalWNMj0TWGVIevIdN8Q97t9Yz
        Eag+OfGg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qMvF8-001NGA-OP; Fri, 21 Jul 2023 18:52:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 42BF4300346;
        Fri, 21 Jul 2023 20:52:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0EA6C315B37C6; Fri, 21 Jul 2023 20:52:46 +0200 (CEST)
Date:   Fri, 21 Jul 2023 20:52:46 +0200
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
Subject: Re: [PATCH v1 02/14] futex: Extend the FUTEX2 flags
Message-ID: <20230721185246.GR4253@hirez.programming.kicks-ass.net>
References: <20230721102237.268073801@infradead.org>
 <20230721105743.819362688@infradead.org>
 <6a49b585-05d0-4b79-b5ab-d710f5d6d598@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a49b585-05d0-4b79-b5ab-d710f5d6d598@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 21, 2023 at 05:47:31PM +0200, Arnd Bergmann wrote:
> On Fri, Jul 21, 2023, at 12:22, Peter Zijlstra wrote:
> >   * futex_parse_waitv - Parse a waitv array from userspace
> > @@ -207,7 +207,12 @@ static int futex_parse_waitv(struct fute
> >  		if ((aux.flags & ~FUTEX2_MASK) || aux.__reserved)
> >  			return -EINVAL;
> > 
> > -		if (!(aux.flags & FUTEX2_32))
> > +		if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall()) {
> > +			if ((aux.flags & FUTEX2_64) == FUTEX2_64)
> > +				return -EINVAL;
> > +		}
> > +
> > +		if ((aux.flags & FUTEX2_64) != FUTEX2_32)
> >  			return -EINVAL;
> 
> This looks slightly confusing, how about defining another
> FUTEX2_SIZEMASK (or similar) macro to clarify that
> "aux.flags & FUTEX2_64" is a mask operation that can
> match the FUTEX2_{8,16,32,64} values?

Yeah, I had that in an earlier version, but then reconsidered as I
didn't want to clutter the uabi with that. But perhaps I over-throught
this.
