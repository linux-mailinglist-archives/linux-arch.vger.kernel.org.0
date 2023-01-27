Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE1D67E859
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jan 2023 15:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjA0Oev (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Jan 2023 09:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbjA0Oeu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Jan 2023 09:34:50 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DCF10AAB;
        Fri, 27 Jan 2023 06:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jLg0NgtndXwOK1xM/a9LLndkpSy2IRQYcolcesnToSM=; b=ZFKG54wRPyqDX3DCGqtaENHPh4
        nNgrk8iAQL2ZlkGDS+qKr73pk4309yNZ0YT4/jNw5F5Ef+QyX2n1mXToZfq0cnb/ACOequ4aHD6og
        YzdkXqxrK2Lu8TJ/fWPHvWhg6cpMdVR4400Z5ShH/oGkgPDWfNtI0DKot/BcroDaSbQrggL+xSfGW
        lSmYdpdSnUGpWV3BSn76jxS6h3h6t6yScwNZXrZhJoCfwFQY5qtmkjaatY+xeXq1HNMbvKYmbrk4s
        RtyPwkntEbvBAjvrkI16gTWyNKfQPvpiBAfjVXPCzwLjGVKL/1LP7tHN+LN3nVBQF+s8VFnyyKRVL
        UEtWHs5Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pLPnn-002sdj-2O;
        Fri, 27 Jan 2023 14:34:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 26F8D300137;
        Fri, 27 Jan 2023 15:34:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0FBBF20A79E8B; Fri, 27 Jan 2023 15:34:34 +0100 (CET)
Date:   Fri, 27 Jan 2023 15:34:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jules Maselbas <jmaselbas@kalray.eu>
Cc:     Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/atomic: atomic: Use arch_atomic_{read,set} in
 generic atomic ops
Message-ID: <Y9Pg+aNM9f48SY5Z@hirez.programming.kicks-ass.net>
References: <20230126173354.13250-1-jmaselbas@kalray.eu>
 <Y9Oy9ZAj/DQ7O+6e@hirez.programming.kicks-ass.net>
 <20230127134946.GJ5952@tellis.lin.mbt.kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127134946.GJ5952@tellis.lin.mbt.kalray.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 27, 2023 at 02:49:46PM +0100, Jules Maselbas wrote:
> Hi Peter,
> 
> On Fri, Jan 27, 2023 at 12:18:13PM +0100, Peter Zijlstra wrote:
> > On Thu, Jan 26, 2023 at 06:33:54PM +0100, Jules Maselbas wrote:
> > 
> > > @@ -58,9 +61,11 @@ static inline int generic_atomic_fetch_##op(int i, atomic_t *v)		\
> > >  static inline void generic_atomic_##op(int i, atomic_t *v)		\
> > >  {									\
> > >  	unsigned long flags;						\
> > > +	int c;								\
> > >  									\
> > >  	raw_local_irq_save(flags);					\
> > > -	v->counter = v->counter c_op i;					\
> > > +	c = arch_atomic_read(v);					\
> > > +	arch_atomic_set(v, c c_op i);					\
> > >  	raw_local_irq_restore(flags);					\
> > >  }
> > 
> > This and the others like it are a bit sad, it explicitly dis-allows the
> > compiler from using memops and forces a load-store.
> Good point, I don't know much about atomic memops but this is indeed a
> bit sad to prevent such instructions to be used.

Depends on the platform, x86,s390 etc. have then, RISC like things
typically don't.

> > The alternative is writing it like:
> > 
> > 	*(volatile int *)&v->counter c_op i;
> I wonder if it could be possible to write something like:
> 
>         *(volatile int *)&v->counter += i;

Should work, but give it a try, see what it does :-)

> I also noticed that GCC has some builtin/extension to do such things,
> __atomic_OP_fetch and __atomic_fetch_OP, but I do not know if this
> can be used in the kernel.

On a per-architecture basis only, the C/C++ memory model does not match
the Linux Kernel memory model so using the compiler to generate the
atomic ops is somewhat tricky and needs architecture audits.
