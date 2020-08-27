Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854D32548AC
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 17:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgH0PKi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 11:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbgH0Lsw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 07:48:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43CAC061264;
        Thu, 27 Aug 2020 04:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0rvdlxgGKGxpXdTBCFym7wSDlaY+0hGRyK+gC8FCBBM=; b=F+2m0kJPClquWJZ1PZvmOPfqhf
        4udkwPM4I37XmN0BolP2AY8z8vMB5a37F7b9fetUpQwl8C/3n6XgcwVzi/QuUWJfZROZ/2OWlgCSt
        eWoaIZDZ9BBIhbh0duJJmVgEqqPdoWkhEyCsuWFRqa53oByvoZXmZvYeW/OcMMor9+LWMFkpORw41
        ThBZO/ITtcAZc5LUIFbUkT0JD8gWG58qWX3DWlW/hWPUtr6XyVUwck2AL4MWymZMtiXefisIf/BMT
        fIEeONTsfMwej6ql6yi8uQJetHmfhuHw9zMT+XjW2MXEZ9+8L+DBNebfSrq4HRyFzyhasYkblBttN
        B7giso9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBGO0-0008HR-Sc; Thu, 27 Aug 2020 11:48:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 640C5301A66;
        Thu, 27 Aug 2020 13:48:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1DBFE2C1263AB; Thu, 27 Aug 2020 13:48:07 +0200 (CEST)
Date:   Thu, 27 Aug 2020 13:48:07 +0200
From:   peterz@infradead.org
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Eddy Wu <Eddy_Wu@trendmicro.com>,
        x86@kernel.org, "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 15/15] kprobes: Free kretprobe_instance with rcu
 callback
Message-ID: <20200827114807.GA2674@hirez.programming.kicks-ass.net>
References: <159852811819.707944.12798182250041968537.stgit@devnote2>
 <159852826969.707944.15092569392287597887.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159852826969.707944.15092569392287597887.stgit@devnote2>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 27, 2020 at 08:37:49PM +0900, Masami Hiramatsu wrote:
> Free kretprobe_instance with rcu callback instead of directly
> freeing the object in the kretprobe handler context.
> 
> This will make kretprobe run safer in NMI context.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  include/linux/kprobes.h |    3 ++-
>  kernel/kprobes.c        |   25 ++++++-------------------
>  2 files changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 46a7afcf5ec0..97557f820d9b 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -160,6 +160,7 @@ struct kretprobe_instance {
>  	struct kretprobe *rp;
>  	kprobe_opcode_t *ret_addr;
>  	struct task_struct *task;
> +	struct rcu_head rcu;
>  	void *fp;
>  	char data[];
>  };

You can stick the rcu_head in a union with hlist.
