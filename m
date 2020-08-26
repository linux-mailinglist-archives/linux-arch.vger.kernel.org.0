Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3CF2530F2
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 16:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgHZOKt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 10:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgHZOKr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:10:47 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B738C061574;
        Wed, 26 Aug 2020 07:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AzWxCen/DOsEQXqFBCdcE4/JIaFFVV3Ee1zoRKCLtqs=; b=k7BgzdKV/oHF1hDGvvyJ8uNhTH
        GHG4mC5roIqFInvdGRyHoGY6HyWEWhv1G57MB9E9x0nBuLS7itGaRnU12bvOdJKahxedudmNXnyAf
        KxbZHEQe+i3Ot4e42e19YkA/ySjpPS+gyqzrn1UTam6hpYWjG8zgfa8TaY759RdzLqZlqdKF4Pa1Q
        9bt8uYMrwUhgNtFKdq8FglA2ly+QRqiZZS/qltGWXL8bGdV4vs1uuucuF7DZYTC7YkrnWMqfCFV8n
        ODGgGFgF1nhS/ZH0seRMbj5a4TPOlojm4XsPHxBPKCi7GSELUNI3mk/skSLLYPB0bW49cDS1HJOPW
        MbJC5Q5A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAw8C-0003IW-SO; Wed, 26 Aug 2020 14:10:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 97C3B30015A;
        Wed, 26 Aug 2020 16:10:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 876D8203A64CA; Wed, 26 Aug 2020 16:10:25 +0200 (CEST)
Date:   Wed, 26 Aug 2020 16:10:25 +0200
From:   peterz@infradead.org
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Eddy Wu <Eddy_Wu@trendmicro.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 03/14] arm: kprobes: Use generic kretprobe trampoline
 handler
Message-ID: <20200826141025.GU35926@hirez.programming.kicks-ass.net>
References: <159844957216.510284.17683703701627367133.stgit@devnote2>
 <159844960343.510284.15315372011917043979.stgit@devnote2>
 <20200826140852.GG1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826140852.GG1362448@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 26, 2020 at 04:08:52PM +0200, peterz@infradead.org wrote:
> On Wed, Aug 26, 2020 at 10:46:43PM +0900, Masami Hiramatsu wrote:
> >  static __used __kprobes void *trampoline_handler(struct pt_regs *regs)
> >  {
> > +	return (void *)kretprobe_trampoline_handler(regs,
> > +				(unsigned long)&kretprobe_trampoline,
> > +				regs->ARM_fp);
> >  }
> 
> Does it make sense to have the generic code have a weak
> trampoline_handler() implemented like the above? It looks like a number
> of architectures have this trivial variant and it seems pointless to
> duplicate this.

Argh, I replied to the wrong variant, I mean the one that uses
kernel_stack_pointer(regs).

Then the architecture only needs to implement kernel_stack_pointer() if
there is nothing else to do.
