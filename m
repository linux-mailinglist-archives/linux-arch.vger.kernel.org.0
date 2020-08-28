Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86627255B50
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 15:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbgH1NjI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 09:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbgH1NjB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2020 09:39:01 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C18FC061232;
        Fri, 28 Aug 2020 06:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LOexncqInd9UhATcu9VDk+sYlfrOpuGRHHk9ZHPPG40=; b=vpjhziZVX2mDZ0xUL0b3jpksFR
        o++pJAu7Utjlj/ITds01XQp3jeXjmGgW5q7Ufe2TCqKr9ksQbY8JZLdfpAv8WTeJtGUMS7uGLgnJ+
        L2sCHjbzFYYAx02JkKcyUn1ysEgVvouyI+EyEOTFgyFbpZYKJce3GxgvsNYf1iWxYBkhvQ37wh6rT
        1yUG0aZg06B6ClVsluxih9/HkOAP7XDh/76TTv+bYOXdIOF2GvDFv+PEndl21CZqz0EhCp+Yb6VyT
        6lx4i+0j2dU9HXC9Xa4HbYtkiB9CciZ9FVafDMxz4OljL5aZEtO3UcsN6Y8N1sJ+82xprKCgovL8V
        u4hRcEJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBeab-0008K0-Gp; Fri, 28 Aug 2020 13:38:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 23F393003E5;
        Fri, 28 Aug 2020 15:38:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D3B6F2C5F933F; Fri, 28 Aug 2020 15:38:43 +0200 (CEST)
Date:   Fri, 28 Aug 2020 15:38:43 +0200
From:   peterz@infradead.org
To:     "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
        "anil.s.keshavamurthy@intel.com" <anil.s.keshavamurthy@intel.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "cameron@moodycamel.com" <cameron@moodycamel.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>
Subject: Re: [RFC][PATCH 3/7] kprobes: Remove kretprobe hash
Message-ID: <20200828133843.GC1362448@hirez.programming.kicks-ass.net>
References: <20200827161237.889877377@infradead.org>
 <20200827161754.359432340@infradead.org>
 <7df0a1af432040d9908517661c32dc34@trendmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7df0a1af432040d9908517661c32dc34@trendmicro.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 28, 2020 at 01:11:15PM +0000, Eddy_Wu@trendmicro.com wrote:
> > -----Original Message-----
> > From: Peter Zijlstra <peterz@infradead.org>
> > Sent: Friday, August 28, 2020 12:13 AM
> > To: linux-kernel@vger.kernel.org; mhiramat@kernel.org
> > Cc: Eddy Wu (RD-TW) <Eddy_Wu@trendmicro.com>; x86@kernel.org; davem@davemloft.net; rostedt@goodmis.org;
> > naveen.n.rao@linux.ibm.com; anil.s.keshavamurthy@intel.com; linux-arch@vger.kernel.org; cameron@moodycamel.com;
> > oleg@redhat.com; will@kernel.org; paulmck@kernel.org; peterz@infradead.org
> > Subject: [RFC][PATCH 3/7] kprobes: Remove kretprobe hash
> >
> > @@ -1935,71 +1932,45 @@ unsigned long __kretprobe_trampoline_han
> >                                         unsigned long trampoline_address,
> >                                         void *frame_pointer)
> >  {
> > // ... removed
> > // NULL here
> > +       first = node = current->kretprobe_instances.first;
> > +       while (node) {
> > +               ri = container_of(node, struct kretprobe_instance, llist);
> >
> > -               orig_ret_address = (unsigned long)ri->ret_addr;
> > -               if (skipped)
> > -                       pr_warn("%ps must be blacklisted because of incorrect kretprobe order\n",
> > -                               ri->rp->kp.addr);
> > +               BUG_ON(ri->fp != frame_pointer);
> >
> > -               if (orig_ret_address != trampoline_address)
> > +               orig_ret_address = (unsigned long)ri->ret_addr;
> > +               if (orig_ret_address != trampoline_address) {
> >                         /*
> >                          * This is the real return address. Any other
> >                          * instances associated with this task are for
> >                          * other calls deeper on the call stack
> >                          */
> >                         break;
> > +               }
> > +
> > +               node = node->next;
> >         }
> >
> 
> Hi, I found a NULL pointer dereference here, where
> current->kretprobe_instances.first == NULL in these two scenario:

Hurmph, that would mean hitting the trampoline and not having a
kretprobe_instance, weird. Let me try and reproduce.
