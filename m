Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8595215A72C
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 11:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgBLK4x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 05:56:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:59450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbgBLK4w (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Feb 2020 05:56:52 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD1D620675;
        Wed, 12 Feb 2020 10:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581505012;
        bh=4pZYCUBDsbqAJS8ZCZ6TjAOwz6/YRSffWxenSOtB50U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QRgU7x7TZli8ZVmDnLJzwtnNVmdWfAHB0Q/qll4v64rUTI4fE8Dojv/BMAco567EH
         jgUYQ8+QHsY1GFzOLk7bhC8SELeIyM765FUHJr+guMH4xXt2YZUleDsnsYhJNVl5e2
         2sLuwCG2V2jkGnmXd4wcDg3I1kLckzO67mW9qQQU=
Date:   Wed, 12 Feb 2020 10:56:46 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, james.morse@arm.com, catalin.marinas@arm.com,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH 0/8] tracing vs rcu vs nmi
Message-ID: <20200212105646.GA4017@willie-the-truck>
References: <20200212093210.468391728@infradead.org>
 <20200212100106.GA14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212100106.GA14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 12, 2020 at 11:01:06AM +0100, Peter Zijlstra wrote:
> On Wed, Feb 12, 2020 at 10:32:10AM +0100, Peter Zijlstra wrote:
> > Hi all,
> > 
> > These here patches are the result of Mathieu and Steve trying to get commit
> > 865e63b04e9b2 ("tracing: Add back in rcu_irq_enter/exit_irqson() for rcuidle
> > tracepoints") reverted again.
> > 
> > One of the things discovered is that tracing MUST NOT happen before nmi_enter()
> > or after nmi_exit(). I've only fixed x86, but quickly gone through other
> > architectures and there is definitely more stuff to be fixed (simply grep for
> > nmi_enter in your arch).
> 
> For ARM64:
> 
>  - apei_claim_sea()
>  - __sdei_handler()
>  - do_serror()
>  - debug_exception_enter() / do_debug_exception()
> 
> all look dodgy.

Hmm, so looks like we need to spinkle some 'notrace' annotations around
these. Are there are scenarios where you would want NOKPROBE_SYMBOL() but
*not* 'notrace'? We've already got the former for the debug exception
handlers and we probably (?) want it for the SDEI stuff too...

Will
