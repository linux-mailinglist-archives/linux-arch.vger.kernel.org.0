Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D625165D3C
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2020 13:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgBTMHH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Feb 2020 07:07:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48830 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgBTMHH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Feb 2020 07:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cv6/HWnnJ/eE0Z4xVRlKKP4A5MEBltFbBUkFytPysi8=; b=K1EYLRC3q/EYX2S2d+zwehZ0Iq
        ABHi0MrkYaOfupgauOcZS16ZhR5ca56wbk5CnCVMynlEeiptT1l2+GxiZq0rla6R2tCTCC2tdYaEb
        xhZ5lI5PF36LdPYoqN/g7JQXj7r3j4pVqYWD/KKD9zUXXof1MqIsZB3jyj9oFpSgTA+l4K3r1Z31k
        DGqe6BkMVuCe4CSMsVcr4tKr/x9pPUKLTAFSozvBo1bjvgRJCqg+ispwJS9xJDvnlbTLYTdmFdVn7
        tdmVuvxSqYRjxcGX3YeH5T4uzjTKWijnslRvq4NT28Vsa5HrKvwryBRCQGAbFRH6peeFp6pFm8e0h
        89Fo+9gg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4kbD-0002o7-7q; Thu, 20 Feb 2020 12:06:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1124130008D;
        Thu, 20 Feb 2020 13:04:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B5E6C2B4D9BDA; Thu, 20 Feb 2020 13:06:31 +0100 (CET)
Date:   Thu, 20 Feb 2020 13:06:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andy Lutomirski <luto@kernel.org>, tony.luck@intel.com,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH v3 22/22] x86/int3: Ensure that poke_int3_handler() is
 not sanitized
Message-ID: <20200220120631.GX18400@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150745.651901321@infradead.org>
 <CACT4Y+Y+nPcnbb8nXGQA1=9p8BQYrnzab_4SvuPwbAJkTGgKOQ@mail.gmail.com>
 <20200219163025.GH18400@hirez.programming.kicks-ass.net>
 <20200219172014.GI14946@hirez.programming.kicks-ass.net>
 <CACT4Y+ZfxqMuiL_UF+rCku628hirJwp3t3vW5WGM8DWG6OaCeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZfxqMuiL_UF+rCku628hirJwp3t3vW5WGM8DWG6OaCeg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 20, 2020 at 11:37:32AM +0100, Dmitry Vyukov wrote:
> On Wed, Feb 19, 2020 at 6:20 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Feb 19, 2020 at 05:30:25PM +0100, Peter Zijlstra wrote:
> >
> > > By inlining everything in poke_int3_handler() (except bsearch :/) we can
> > > mark the whole function off limits to everything and call it a day. That
> > > simplicity has been the guiding principle so far.
> > >
> > > Alternatively we can provide an __always_inline variant of bsearch().
> >
> > This reduces the __no_sanitize usage to just the exception entry
> > (do_int3) and the critical function: poke_int3_handler().
> >
> > Is this more acceptible?
> 
> Let's say it's more acceptable.
> 
> Acked-by: Dmitry Vyukov <dvyukov@google.com>

Thanks, I'll go make it happen.

> I guess there is no ideal solution here.
> 
> Just a straw man proposal: expected number of elements is large enough
> to make bsearch profitable, right? I see 1 is a common case, but the
> other case has multiple entries.

Latency was the consideration; the linear search would dramatically
increase the runtime of the exception.

The current limit is 256 entries and we're hitting that quite often.

(we can trivially increase, but nobody has been able to show significant
benefits for that -- as of yet)
