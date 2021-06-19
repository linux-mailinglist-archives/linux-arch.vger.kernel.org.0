Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35FA53ADA8B
	for <lists+linux-arch@lfdr.de>; Sat, 19 Jun 2021 17:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbhFSPSi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Jun 2021 11:18:38 -0400
Received: from gate.crashing.org ([63.228.1.57]:59443 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234128AbhFSPSh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 19 Jun 2021 11:18:37 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 15JF26n5018966;
        Sat, 19 Jun 2021 10:02:07 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 15JF2288018951;
        Sat, 19 Jun 2021 10:02:02 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sat, 19 Jun 2021 10:02:02 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        maged michael <maged.michael@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Watson <davejwatson@fb.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Hunter <ahh@google.com>, David Sehr <sehr@google.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arch <linux-arch@vger.kernel.org>, x86 <x86@kernel.org>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Greg Hackmann <ghackmann@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Paul <paulmck@linux.vnet.ibm.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Avi Kivity <avi@scylladb.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-api <linux-api@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH for 4.16 v7 02/11] powerpc: membarrier: Skip memory barrier in switch_mm()
Message-ID: <20210619150202.GZ5077@gate.crashing.org>
References: <20180129202020.8515-1-mathieu.desnoyers@efficios.com> <20180129202020.8515-3-mathieu.desnoyers@efficios.com> <8b200dd5-f37b-b208-82fb-2775df7bcd49@csgroup.eu> <2077369633.12794.1624037192994.JavaMail.zimbra@efficios.com> <4d2026cc-28e1-7781-fc95-e6160bd8db86@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d2026cc-28e1-7781-fc95-e6160bd8db86@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 19, 2021 at 11:35:34AM +0200, Christophe Leroy wrote:
> 
> 
> Le 18/06/2021 à 19:26, Mathieu Desnoyers a écrit :
> >----- On Jun 18, 2021, at 1:13 PM, Christophe Leroy 
> >christophe.leroy@csgroup.eu wrote:
> >[...]
> >>
> >>I don't understand all that complexity to just replace a simple
> >>'smp_mb__after_unlock_lock()'.
> >>
> >>#define smp_mb__after_unlock_lock()	smp_mb()
> >>#define smp_mb()	barrier()
> >># define barrier() __asm__ __volatile__("": : :"memory")
> >>
> >>
> >>Am I missing some subtility ?
> >
> >On powerpc CONFIG_SMP, smp_mb() is actually defined as:
> >
> >#define smp_mb()        __smp_mb()
> >#define __smp_mb()      mb()
> >#define mb()   __asm__ __volatile__ ("sync" : : : "memory")
> >
> >So the original motivation here was to skip a "sync" instruction whenever
> >switching between threads which are part of the same process. But based on
> >recent discussions, I suspect my implementation may be inaccurately doing
> >so though.
> >
> 
> I see.
> 
> Then, if you think a 'sync' is a concern, shouldn't we try and remove the 
> forest of 'sync' in the I/O accessors ?
> 
> I can't really understand why we need all those 'sync' and 'isync' and 
> 'twi' around the accesses whereas I/O memory is usually mapped as 'Guarded' 
> so memory access ordering is already garantied.
> 
> I'm sure we'll save a lot with that.

The point of the twi in the I/O accessors was to make things easier to
debug if the accesses fail: for the twi insn to complete the load will
have to have completed as well.  On a correctly working system you never
should need this (until something fails ;-) )

Without the twi you might need to enforce ordering in some cases still.
The twi is a very heavy hammer, but some of that that gives us is no
doubt actually needed.


Segher
