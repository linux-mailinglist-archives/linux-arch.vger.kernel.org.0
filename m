Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 951A9165D50
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2020 13:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgBTMLh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Feb 2020 07:11:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50318 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgBTMLh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Feb 2020 07:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YmVRDek+B2T1n7RDukHZxAGkhFyE67wqzGfrUyN9bnk=; b=KIKEWIppTck6euc9S6SYz8bITo
        NIDl3tt9TaBxjyAqF0VWS7eTwEh2ndrAq1HApPeR+ODvT7m1LO4wyWP73KOHBlwbkU1hlZjvf5uOj
        ZBm8KtdNQf4yfKYF/o2bODJM8Q20EF/0gPyZq5w3EA0M8vmecZVBnQX8gprmNb+ZshDZv4x87auou
        qZTdGiMRfZ6zt8AMS0wbCbXBjyEOFcV297YnT5Bpxg7gmyoCDSYZyY6i4xMlDV7gGkEwca/0yFrC3
        oNkbGBq9wCE3l3pp15GF3BKy3HmtLRyR4+MxH6Gh35Dht8WJ2V+PTCdkgiEUOivoQ3UoFmoqmc8XC
        DHbcZo5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4kfl-0004Uf-5e; Thu, 20 Feb 2020 12:11:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 03B6730008D;
        Thu, 20 Feb 2020 13:09:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BCDD92B178B31; Thu, 20 Feb 2020 13:11:13 +0100 (CET)
Date:   Thu, 20 Feb 2020 13:11:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v3 03/22] x86: Replace ist_enter() with nmi_enter()
Message-ID: <20200220121113.GY18400@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.547288232@infradead.org>
 <20200220105439.GA507@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220105439.GA507@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 20, 2020 at 11:54:39AM +0100, Borislav Petkov wrote:
> On Wed, Feb 19, 2020 at 03:47:27PM +0100, Peter Zijlstra wrote:
> > @@ -1220,7 +1220,7 @@ static void mce_kill_me_maybe(struct cal
> >   * MCE broadcast. However some CPUs might be broken beyond repair,
> >   * so be always careful when synchronizing with others.
> >   */
> > -void do_machine_check(struct pt_regs *regs, long error_code)
> > +notrace void do_machine_check(struct pt_regs *regs, long error_code)
> 
> Is there a convention where the notrace marker should come in the
> function signature? I see all possible combinations while grepping...

Same place as inline I think.

> >  {
> >  	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
> >  	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
> > @@ -1254,10 +1254,10 @@ void do_machine_check(struct pt_regs *re
> >  	 */
> >  	int lmce = 1;
> >  
> > -	if (__mc_check_crashing_cpu(cpu))
> > -		return;
> > +	nmi_enter();
> >  
> > -	ist_enter(regs);
> > +	if (__mc_check_crashing_cpu(cpu))
> > +		goto out;
> >  
> >  	this_cpu_inc(mce_exception_count);
> >  
> 
> Should that __mc_check_crashing_cpu() happen before nmi_enter? The
> function is doing only a bunch of checks and clearing MSRs for bystander
> CPUs...

You'll note the lack of notrace on that function, and we must not call
into tracers before nmi_enter().

AFAICT there really is no benefit to trying to lift it before
nmi_enter().
