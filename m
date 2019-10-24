Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8056FE3A42
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2019 19:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503920AbfJXRkv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Oct 2019 13:40:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38946 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729458AbfJXRku (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Oct 2019 13:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sTRjbq+OPzLWUvcUX+QGFONGylrzn8uKiZz+7VSqigI=; b=PJZB6Tpzh5Aa/T8Oj7iXr+SiH
        KSLUJzsBbcu4Wt4VQZOV0+q7a0ezabFIdj/GsokzzbOMRdXkAt6K64HUq8HjMEU1wzyLmJYtQGw/A
        MTR1caxgCqtx4M2Kyu2JFRZfyrBYKseRn9ZWlgsbj6uOp90nQsuQTAEVQfjQhAdwH5RYJdgwzBbFH
        mZvimTAcQ08s6HinxaD/LnZ1R6Ko/ig1ePM2YFjXRXyWgynIuuHGqrxWKjRcEvpSL0FujLqfbS6W5
        lmSrLuaG+XME4tOyCKf6znNZ8DHEkwM7z39DBmkRxWrz4foFJiK5BoqbdgRTxDvO7R1zuzwjhkr8q
        jM8puMTDQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNh6M-0003eN-T2; Thu, 24 Oct 2019 17:40:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C5F5C306CF9;
        Thu, 24 Oct 2019 19:39:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6109A2B1D8927; Thu, 24 Oct 2019 19:40:44 +0200 (CEST)
Date:   Thu, 24 Oct 2019 19:40:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [patch V2 08/17] x86/entry: Move syscall irq tracing to C code
Message-ID: <20191024174044.GJ4114@hirez.programming.kicks-ass.net>
References: <20191023122705.198339581@linutronix.de>
 <20191023123118.386844979@linutronix.de>
 <CALCETrWLk9LKV4+_mrOKDc3GUvXbCjqA5R6cdpqq02xoRCBOHw@mail.gmail.com>
 <CALCETrV79pw7-nisp4VdEkQ4=fr2nfJFOMCtyKmWZR6PG3=oWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrV79pw7-nisp4VdEkQ4=fr2nfJFOMCtyKmWZR6PG3=oWg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 24, 2019 at 09:24:13AM -0700, Andy Lutomirski wrote:
> On Wed, Oct 23, 2019 at 2:30 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Wed, Oct 23, 2019 at 5:31 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > Interrupt state tracing can be safely done in C code. The few stack
> > > operations in assembly do not need to be covered.
> > >
> > > Remove the now pointless indirection via .Lsyscall_32_done and jump to
> > > swapgs_restore_regs_and_return_to_usermode directly.
> >
> > This doesn't look right.
> 
> Well, I feel a bit silly.  I read this:
> 
> >
> > >  #define SYSCALL_EXIT_WORK_FLAGS                                \
> > > @@ -279,6 +282,9 @@ static void syscall_slow_exit_work(struc
> 
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> and I applied the diff in my head to the wrong function, and I didn't
> notice that it didn't really apply there.  Oddly, gitweb gets this

I had the same when reviewing these patches; I was almost going to ask
tglx about it on IRC when the penny dropped.
