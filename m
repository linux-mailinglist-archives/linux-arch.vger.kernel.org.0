Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1CEE3E0B
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2019 23:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfJXVVN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Oct 2019 17:21:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:32874 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbfJXVVN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Oct 2019 17:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZtBs1/l6mBDyZtFIn5CV1kjtXQutizfGl/4BYEKqk5s=; b=cr/AzgsUHzuuLdrtAYldm3B0z
        ZUT3crSYPW7skGAja72go1Gn3JmrRIDYXYdAUYoSdD/Fqwht/8/D4FplLIjNFbb341N9xhlYauKBj
        26VLTellYCz1U3ReG+1izW9JrXvkY7GtBtMhPfIao8PAe/C+n6ln+abjjL0JTC+no/chVBJHI2GKJ
        EdYED71cXcjq6cyQuENIqBbIDxGS6qx2anCLbGdOdqHPcpR0Aislg6PTUeVnhoCLa8KsBvukT5Cml
        sKXcryyI5fnDIBdHtpcUkzJ+OvZWWtTTqnuoCzObmdqXNiqlfKWwbiQJEcchp/6jEkNsKyyCOygUe
        z+AGtug8w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNkXb-0004gG-3p; Thu, 24 Oct 2019 21:21:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CE337300EBF;
        Thu, 24 Oct 2019 23:20:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 719D02100B87C; Thu, 24 Oct 2019 23:21:05 +0200 (CEST)
Date:   Thu, 24 Oct 2019 23:21:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [patch V2 07/17] x86/entry/64: Remove redundant interrupt disable
Message-ID: <20191024212105.GY4114@hirez.programming.kicks-ass.net>
References: <20191023122705.198339581@linutronix.de>
 <20191023123118.296135499@linutronix.de>
 <20191023220618.qsmog2k5oaagj27v@treble>
 <alpine.DEB.2.21.1910240146200.1852@nanos.tec.linutronix.de>
 <CALCETrX+N_cR-HAmQyHxqUo0LPCk4GmqbzizXk-gq9qp00-RdA@mail.gmail.com>
 <alpine.DEB.2.21.1910242032080.1783@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910242032080.1783@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 24, 2019 at 10:52:59PM +0200, Thomas Gleixner wrote:
> is just undefined behaviour and I personally consider it to be a plain bug.

I concur.

> Just for the record: This results in running a resulting or even completely
> unrelated signal handler with interrupts disabled as well.
> 
> Whatever we decide it is, leaving it completely inconsistent is not a
> solution at all. The options are:
> 
>   1)  Always do conditional tracing depending on the user_regs->eflags.IF
>       state.
> 
>   2)  #1 + warn once when syscalls and exceptions (except NMI/MCE) happen
>       and user_regs->eflags.IF is cleared.
> 
>   3a) #2 + enforce signal handling to run with interrupts enabled.
> 
>   3b) #2 + set regs->eflags.IF. So the state is always correct from the
>       kernel POV. Of course that changes existing behaviour, but its
>       changing undefined and inconsistent behaviour.
>   
>   4) Let iopl(level) return -EPERM if level == 3.
> 
>      Yeah, I know it's not possible due to regressions (DPKD uses iopl(3)),
>      but TBH that'd be the sanest option of all.
> 
>      Of course the infinite wisdom of hardware designers tied IN, INS, OUT,
>      OUTS and CLI/STI together on IOPL so we cannot even distangle them in
>      any way.
> 
>      The only way out would be to actually use a full 8K sized I/O bitmap,
>      but that's a massive pain as it has to be copied on every context
>      switch. 
> 
> Really pretty options to chose from ...

If 4 is out (and I'm afraid it might be), then I'm on record for liking
3b.
