Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9DD255C2D
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 16:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgH1OTi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 10:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgH1OTe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2020 10:19:34 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D46CC061264;
        Fri, 28 Aug 2020 07:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CgkzEyu0nU72gWHm4QE/GrxCk7mtJkJ1KRfoVj7KTxU=; b=qXErMp4MVkKtX8+yfaAqaWid7U
        hp1ZkOY9TbMDQoNfoh50zxxhiXqksCVZymihPqoo3xdi9ufHVlPx1z2eeG0jJI79WkyvuhVAUvEVl
        avjbStouRLh5Y+vQbOaTVKFm6dfezPizfn379Z5MINu4MDKHgURH5/1aPv/1ZvMBKRRimcRgWQ8sB
        46rsc2KEFDoZ5J/NPy3w7ADlimjd+OF7gGJBTq0H1D621rD329L4O0NSG3o5fougcXt4nGQUIEBxw
        F0m9k0e2LZdoUfcpu3tjtKGl2Na8KH/i5VsK6vCMLiEFAtbvoY1jVXWVloXeUHvZfbUAU20l7VPqu
        f2UJG26Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBfDr-0006yS-Qg; Fri, 28 Aug 2020 14:19:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 21F7C300238;
        Fri, 28 Aug 2020 16:19:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C80752C5FDBE8; Fri, 28 Aug 2020 16:19:17 +0200 (CEST)
Date:   Fri, 28 Aug 2020 16:19:17 +0200
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
Message-ID: <20200828141917.GE1362448@hirez.programming.kicks-ass.net>
References: <20200827161237.889877377@infradead.org>
 <20200827161754.359432340@infradead.org>
 <7df0a1af432040d9908517661c32dc34@trendmicro.com>
 <20200828225113.9541a5f67a3bcb17c4ce930c@kernel.org>
 <23d43cfb12c54a1fbc766ea313ecb5a6@trendmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23d43cfb12c54a1fbc766ea313ecb5a6@trendmicro.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 28, 2020 at 02:11:18PM +0000, Eddy_Wu@trendmicro.com wrote:
> > From: Masami Hiramatsu <mhiramat@kernel.org>
> >
> > OK, schedule function will be the key. I guess the senario is..
> >
> > 1) kretporbe replace the return address with kretprobe_trampoline on task1's kernel stack
> > 2) the task1 forks task2 before returning to the kretprobe_trampoline
> > 3) while copying the process with the kernel stack, task2->kretprobe_instances.first = NULL
> 
> I think new process created by fork/clone uses a brand new kernel
> stack? I thought only user stack are copied.  Otherwise any process
> launch should crash in the same way

I was under the same impression, we create a brand new stack-frame for
the new task, this 'fake' frame we can schedule into.

It either points to ret_from_fork() for new user tasks, or
kthread_frame_init() for kernel threads.
