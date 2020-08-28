Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C03255B53
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 15:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbgH1NjG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 09:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729520AbgH1Nim (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2020 09:38:42 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBEBC061232;
        Fri, 28 Aug 2020 06:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2pUKJOhhhKQQlO5FlUO+EgalWHY2MMJEwWG/1/OfNIE=; b=2hdL8Uo1Vigmo65KBOUfJYeiJS
        3R17ve06sdEE2iOLEfjBFSG6GA/Jica2M7ndhUU6ux3aeJYBYYa3ijVXiJ+mFiO8nEHYzMhBJdldz
        LAUfPaiAdez8ChT+/zM4O9YuwesCTgssJ0iJjm/usXeatoUdK3podvWL1Zk41za36X2aR7UKikzPq
        kw2ECDMI/5xVtQymqf+nUGZaCwnhuLL0WH0WaPfF2p+dl+JNErEpNTrxT7UhpwOWNssEJEyE9CrYN
        tYmSDPwRT/KuGpONePUi9sLienAZJpMim+5c+n5GGlAJWMrVPmMN7+JVKDLCEJDqWBb6yg91IMtqG
        1SImWamg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBeZF-0008Dp-8b; Fri, 28 Aug 2020 13:37:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 75A2430015A;
        Fri, 28 Aug 2020 15:37:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3CDAD2C5F935C; Fri, 28 Aug 2020 15:37:18 +0200 (CEST)
Date:   Fri, 28 Aug 2020 15:37:18 +0200
From:   peterz@infradead.org
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH v4 04/23] arm64: kprobes: Use generic kretprobe
 trampoline handler
Message-ID: <20200828133718.GB1362448@hirez.programming.kicks-ass.net>
References: <159861759775.992023.12553306821235086809.stgit@devnote2>
 <159861764221.992023.10214437014901668680.stgit@devnote2>
 <20200828133131.GA71981@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828133131.GA71981@C02TD0UTHF1T.local>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 28, 2020 at 02:31:31PM +0100, Mark Rutland wrote:
> Hi,
> 
> On Fri, Aug 28, 2020 at 09:27:22PM +0900, Masami Hiramatsu wrote:
> > Use the generic kretprobe trampoline handler, and use the
> > kernel_stack_pointer(regs) for framepointer verification.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  arch/arm64/kernel/probes/kprobes.c |   78 +-----------------------------------
> >  1 file changed, 3 insertions(+), 75 deletions(-)
> 
> > +	return (void *)kretprobe_trampoline_handler(regs, &kretprobe_trampoline,
> > +					(void *)kernel_stack_pointer(regs));
> >  }
> >  
> >  void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
> >  				      struct pt_regs *regs)
> >  {
> >  	ri->ret_addr = (kprobe_opcode_t *)regs->regs[30];
> > +	ri->fp = (void *)kernel_stack_pointer(regs);
> 
> This is probably a nomenclature problem, but what exactly is
> kretprobe_instance::fp used for?
> 
> I ask because arm64's frame pointer lives in x29 (and is not necessarily
> the same as the stack pointer at function boundaries), so the naming
> is potentially misleading and possibly worth a comment or rename.

IIUC ri->rp is used for matching up the frame between the moment we
install the return trampoline on the stack and actually hitting that
trampoline.
