Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59A33168850
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 21:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgBUUZi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 15:25:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40262 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgBUUZi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 15:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2Hcbu7VsxhWQs9BO+Aja19os7FBfjIizSEAD/jxIKN0=; b=XymCjwuobjJepMla2WyDSnMt82
        wHklJoYIVwXJDYArgHkEAeiwB4P66pWfl36CylzFP2URQWLAV4B/ZdP4OAyWOpmXyOgQGsuPS6rmZ
        K6G7OPKgX9plbs8TCyW12z+dDj+avbXAQVwfJyKsFpqZxPmkTTnIHyJT8C4OgCWKmueBA9s6+Dfqr
        SC5giFO0TnAgTN7bA6cxnefE5kYnIbYOLEw5JMAnnMtYsa+nPr4L3tpt7RnuSEaOPlLj3g+7z5+Id
        71lWOqBNaPM23qR3Ot1KJpr7ggBkoRZmbxgCm5lmu7bktPd/pb9s4ZqjttRh4wlrIPuNdGUnI02oz
        qKa7tWUA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5ErK-0003Ys-C8; Fri, 21 Feb 2020 20:25:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9DEBC300478;
        Fri, 21 Feb 2020 21:23:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6B1F7209DB0F7; Fri, 21 Feb 2020 21:25:11 +0100 (CET)
Date:   Fri, 21 Feb 2020 21:25:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v4 01/27] lockdep: Teach lockdep about "USED" <- "IN-NMI"
 inversions
Message-ID: <20200221202511.GB14897@hirez.programming.kicks-ass.net>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.090538203@infradead.org>
 <20200221100855.2f9bec3a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221100855.2f9bec3a@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 21, 2020 at 10:08:55AM -0500, Steven Rostedt wrote:
> On Fri, 21 Feb 2020 14:34:17 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -379,13 +379,13 @@ void lockdep_init_task(struct task_struc
> >  
> >  void lockdep_off(void)
> >  {
> > -	current->lockdep_recursion++;
> > +	current->lockdep_recursion += BIT(16);
> >  }
> >  EXPORT_SYMBOL(lockdep_off);
> >  
> >  void lockdep_on(void)
> >  {
> > -	current->lockdep_recursion--;
> > +	current->lockdep_recursion -= BIT(16);
> >  }
> >  EXPORT_SYMBOL(lockdep_on);
> >  
> 
> > +
> > +static bool lockdep_nmi(void)
> > +{
> > +	if (current->lockdep_recursion & 0xFFFF)
> 
> Nitpick, but the association with bit 16 and this mask really should be
> defined as a macro somewhere and not have hard coded numbers.

Right, I suppose I can do something like:

#define LOCKDEP_RECURSION_BITS	16
#define LOCKDEP_OFF (1U << LOCKDEP_RECURSION_BITS)
#define LOCKDEP_RECURSION_MASK (LOCKDEP_OFF - 1)


