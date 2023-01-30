Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AE9681872
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jan 2023 19:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbjA3SPi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Jan 2023 13:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbjA3SPg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Jan 2023 13:15:36 -0500
Received: from fx405.security-mail.net (smtpout140.security-mail.net [85.31.212.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1096F2BEC5
        for <linux-arch@vger.kernel.org>; Mon, 30 Jan 2023 10:15:19 -0800 (PST)
Received: from localhost (fx405.security-mail.net [127.0.0.1])
        by fx405.security-mail.net (Postfix) with ESMTP id D5775335E13
        for <linux-arch@vger.kernel.org>; Mon, 30 Jan 2023 19:15:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1675102517;
        bh=woT0XghOpc8/Ph/a4ARIHPi/U8sPdIzTDWFEsM/l7bU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=MMWfghrp2pQ3aR8uh8DYck7RCE+EZJ9sSm/PCX109tX46cUzimKH8Ezka9lqWANgJ
         nN2QbpOeR8xAubmPYQrPbcar9dVQXMfUgwi0wbELyi++uQ+TIO9s2Kcb0zAYbXkJbt
         aFGkPuEOLX9pFaKcNta3FJVd545FUsMNhkLFG1vs=
Received: from fx405 (fx405.security-mail.net [127.0.0.1]) by
 fx405.security-mail.net (Postfix) with ESMTP id 58603335D89; Mon, 30 Jan
 2023 19:15:17 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx405.security-mail.net (Postfix) with ESMTPS id 0C350335D41; Mon, 30 Jan
 2023 19:15:16 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id CE4D427E0495; Mon, 30 Jan 2023
 19:15:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id A81A927E049B; Mon, 30 Jan 2023 19:15:15 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 tfsa0M71DeLS; Mon, 30 Jan 2023 19:15:15 +0100 (CET)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 7298027E0495; Mon, 30 Jan 2023
 19:15:15 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <91c0.63d80934.9114.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu A81A927E049B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1675102515;
 bh=TVW2Si/hpSOjuGYUu0CdutuWCroWI8LPHqIKqnMnoFk=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=SbZSbibIdNcBFFMgKHuQ2E99Em5DNZ53DmrhrGpObZ7logdlVjcB8vtn0VHIE93af
 BeYqchg4ehGUWbaAlCrKwNWpt0ZGXBNA+Il0SgQl9N2xb/4SX1G1kKPiLHcW3bzjbx
 hHIOIDPeuK4LOuWxhxX+pP2dCkfS5meMqF2asLyE=
Date:   Mon, 30 Jan 2023 19:15:14 +0100
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
        Paul =?utf-8?b?SGVpZGVrcsO8Z2Vy?= <paul.heidekrueger@in.tum.de>,
        Marco Elver <elver@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?b?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Yann Sionneau <ysionneau@kalray.eu>
Subject: Re: [PATCH] locking/atomic: atomic: Use arch_atomic_{read,set} in
 generic atomic ops
Message-ID: <20230130181514.GK5952@tellis.lin.mbt.kalray.eu>
References: <20230126173354.13250-1-jmaselbas@kalray.eu>
 <Y9Oy9ZAj/DQ7O+6e@hirez.programming.kicks-ass.net>
 <20230127134946.GJ5952@tellis.lin.mbt.kalray.eu>
 <Y9Pg+aNM9f48SY5Z@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y9Pg+aNM9f48SY5Z@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Peter,

On Fri, Jan 27, 2023 at 03:34:33PM +0100, Peter Zijlstra wrote:
> On Fri, Jan 27, 2023 at 02:49:46PM +0100, Jules Maselbas wrote:
> > Hi Peter,
> > 
> > On Fri, Jan 27, 2023 at 12:18:13PM +0100, Peter Zijlstra wrote:
> > > On Thu, Jan 26, 2023 at 06:33:54PM +0100, Jules Maselbas wrote:
> > > 
> > > > @@ -58,9 +61,11 @@ static inline int generic_atomic_fetch_##op(int i, atomic_t *v)		\
> > > >  static inline void generic_atomic_##op(int i, atomic_t *v)		\
> > > >  {									\
> > > >  	unsigned long flags;						\
> > > > +	int c;								\
> > > >  									\
> > > >  	raw_local_irq_save(flags);					\
> > > > -	v->counter = v->counter c_op i;					\
> > > > +	c = arch_atomic_read(v);					\
> > > > +	arch_atomic_set(v, c c_op i);					\
> > > >  	raw_local_irq_restore(flags);					\
> > > >  }
> > > 
> > > This and the others like it are a bit sad, it explicitly dis-allows the
> > > compiler from using memops and forces a load-store.
> > Good point, I don't know much about atomic memops but this is indeed a
> > bit sad to prevent such instructions to be used.
> 
> Depends on the platform, x86,s390 etc. have then, RISC like things
> typically don't.
> 
> > > The alternative is writing it like:
> > > 
> > > 	*(volatile int *)&v->counter c_op i;
> > I wonder if it could be possible to write something like:
> > 
> >         *(volatile int *)&v->counter += i;
> 
> Should work, but give it a try, see what it does :-)
> 

I've made a quick test on godbolt[1] and I don't see a major difference
between the old version and the new version I propose. I am not very
familiar with both x86 and s390 architecture and I might have missed an
option for gcc to automagically generate "memops" instructions.

[1] https://godbolt.org/z/nrvvMs9b6

From my understanding s390 has instructions to read a value from memory
and add a value, but still needs to be written by another instruction.

x86 is not using the generic atomic code, but has its own implementation
of atomic memory operations using lock {add,...} instructions.

The goal of the proposed patch is to make the generic code more correct:
| I don't think that's true; without READ_ONCE() the compiler could (but
| is very unlikely to) read multiple times, and that could cause problems.
explained by Mark Rutland here:
https://lore.kernel.org/lkml/Y71LoCIl+IFdy9D8@FVFF77S0Q05N/

I still have some open questions:

 - Maybe in SMP the generic_atomic_* functions should use READ_ONCE
instead of arch_atomic_read, since only the "once" part is what is
needed, and the atomicity is done by the cmpxchg.

 - I have the feeling that in non-SMP we do not need the atomicity at all.


Thanks
-- Jules

> > I also noticed that GCC has some builtin/extension to do such things,
> > __atomic_OP_fetch and __atomic_fetch_OP, but I do not know if this
> > can be used in the kernel.
> 
> On a per-architecture basis only, the C/C++ memory model does not match
> the Linux Kernel memory model so using the compiler to generate the
> atomic ops is somewhat tricky and needs architecture audits.
> 
> 
> 
> 




