Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94A72552D1
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 03:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgH1B5Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 21:57:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbgH1B5U (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Aug 2020 21:57:20 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40E602080C;
        Fri, 28 Aug 2020 01:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598579840;
        bh=ytVYmdvTxAHSvpNi2RcVC8TEBHrhZKe/ZTew0OdUFkg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n1Ug5cjFKvK7LDWSaWQXnOwQtS4KmW086f5qCkSAxdNbnQDxNtBCQeh3u0gd4Amc+
         CUwWt7TRQR8rg+BpnvA9u0wFBEUn/MsJKg/KeUyjQLJxyRNxNCbhce6vL/LoWFUHO3
         2hIJRZeNqAsqoo93U3qbnLy96JyVfjPvNiqnhdSY=
Date:   Fri, 28 Aug 2020 10:57:14 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Eddy Wu <Eddy_Wu@trendmicro.com>, x86@kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        linux-arch@vger.kernel.org, guoren@kernel.org
Subject: Re: [PATCH v3 01/16] kprobes: Add generic kretprobe trampoline
 handler
Message-Id: <20200828105714.b499777a12e5cd5d11855f8b@kernel.org>
In-Reply-To: <159854632381.736475.17150452390088286224.stgit@devnote2>
References: <159854631442.736475.5062989489155389472.stgit@devnote2>
        <159854632381.736475.17150452390088286224.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 28 Aug 2020 01:38:44 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> +unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
> +					unsigned long trampoline_address,
> +					void *frame_pointer)
> +{
> +	struct kretprobe_instance *ri = NULL;
> +	struct hlist_head *head, empty_rp;
> +	struct hlist_node *tmp;
> +	unsigned long flags, orig_ret_address = 0;
> +	kprobe_opcode_t *correct_ret_addr = NULL;
> +	bool skipped = false;
> +
> +	INIT_HLIST_HEAD(&empty_rp);
> +	kretprobe_hash_lock(current, &head, &flags);
> +
> +	/*
> +	 * It is possible to have multiple instances associated with a given
> +	 * task either because multiple functions in the call path have
> +	 * return probes installed on them, and/or more than one
> +	 * return probe was registered for a target function.
> +	 *
> +	 * We can handle this because:
> +	 *     - instances are always pushed into the head of the list
> +	 *     - when multiple return probes are registered for the same
> +	 *	 function, the (chronologically) first instance's ret_addr
> +	 *	 will be the real return address, and all the rest will
> +	 *	 point to kretprobe_trampoline.
> +	 */
> +	hlist_for_each_entry(ri, head, hlist) {
> +		if (ri->task != current)
> +			/* another task is sharing our hash bucket */
> +			continue;
> +		/*
> +		 * Return probes must be pushed on this hash list correct
> +		 * order (same as return order) so that it can be popped
> +		 * correctly. However, if we find it is pushed it incorrect
> +		 * order, this means we find a function which should not be
> +		 * probed, because the wrong order entry is pushed on the
> +		 * path of processing other kretprobe itself.
> +		 */
> +		if (ri->fp != frame_pointer) {
> +			if (!skipped)
> +				pr_warn("kretprobe is stacked incorrectly. Trying to fixup.\n");
> +			skipped = true;
> +			continue;
> +		}
> +
> +		orig_ret_address = (unsigned long)ri->ret_addr;
> +		if (skipped)
> +			pr_warn("%ps must be blacklisted because of incorrect kretprobe order\n",
> +				ri->rp->kp.addr);
> +
> +		if (orig_ret_address != trampoline_address)
> +			/*
> +			 * This is the real return address. Any other
> +			 * instances associated with this task are for
> +			 * other calls deeper on the call stack
> +			 */
> +			break;
> +	}
> +
> +	kretprobe_assert(ri, orig_ret_address, trampoline_address);
> +
> +	correct_ret_addr = ri->ret_addr;

Oops, here is an insane code... why we have orig_ret_address *and* correct_ret_addr?
I'll clean this up.

Thanks,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
