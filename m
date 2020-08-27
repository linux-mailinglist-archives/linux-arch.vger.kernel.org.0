Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF452254C82
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 20:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgH0SBI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 14:01:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgH0SBG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Aug 2020 14:01:06 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5677620707;
        Thu, 27 Aug 2020 18:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598551265;
        bh=Bn0qulrmGo8+JQLEGDP+lfcoVCxev5sxmZ5f0aMh91E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bv5KwTQrNOQsC28a1+5pESc4J4vEuC/qxLUTPtaLYWoTnRxleN4e7QgV+ZwRzliAs
         kk7jRqkpW6c1qsrDoKgvcRk12aMZhHDobDmwfRuVvVJCCa9lU+1MMgpYMTYsk7kRAa
         qBg31/RgmB9isZHCArBsPWeIHfNVVCnoM/ksnvgc=
Date:   Fri, 28 Aug 2020 03:00:59 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org
Subject: Re: [RFC][PATCH 3/7] kprobes: Remove kretprobe hash
Message-Id: <20200828030059.d6618caf5b0214c424b941df@kernel.org>
In-Reply-To: <20200827161754.359432340@infradead.org>
References: <20200827161237.889877377@infradead.org>
        <20200827161754.359432340@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 27 Aug 2020 18:12:40 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> +static void invalidate_rp_inst(struct task_struct *t, struct kretprobe *rp)
> +{
> +	struct invl_rp_ipi iri = {
> +		.task = t,
> +		.rp = rp,
> +		.done = false
> +	};
> +
> +	for (;;) {
> +		if (try_invoke_on_locked_down_task(t, __invalidate_rp_inst, rp))
> +			return;
> +
> +		smp_call_function_single(task_cpu(t), __invalidate_rp_ipi, &iri, 1);
> +		if (iri.done)
> +			return;
> +	}

Hmm, what about making a status place holder and point it from
each instance to tell it is valid or not?

struct kretprobe_holder {
	atomic_t refcnt;
	struct kretprobe *rp;
};

struct kretprobe {
...
	struct kretprobe_holder	*rph;	// allocate at register
...
};

struct kretprobe_instance {
...
	struct kretprobe_holder	*rph; // free if refcnt == 0
...
};

cleanup_rp_inst(struct kretprobe *rp)
{
	rp->rph->rp = NULL;
}

kretprobe_trampoline_handler()
{
...
	rp = READ_ONCE(ri->rph-rp);
	if (likely(rp)) {
		// call rp->handler
	} else
		rcu_call(ri, free_rp_inst_rcu);
...
}

free_rp_inst_rcu()
{
	if (!atomic_dec_return(ri->rph->refcnt))
		kfree(ri->rph);
	kfree(ri);
}

This increase kretprobe_instance a bit, but make things simpler.
(and still keep lockless, atomic op is in the rcu callback).

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
