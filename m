Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAEE2530EA
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 16:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgHZOJW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 10:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgHZOJW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:09:22 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B855EC061574;
        Wed, 26 Aug 2020 07:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sCuKJXsoVUftjxMjMCgzhnNkoywvdvw00UKnFJnBbtc=; b=kEgGCFJwHUE6qZhuZ6jKfBYJQU
        FWr6K2fZ+qYnlQNIUH7HqQCgOiS7uYA9obXr2PTZjbrlJ3r+bHGgYXN8MvzVbNC4N47DsCxdHP+/S
        9oHnGmaadcsWK8HDf5rFKrl8VZ6pDOFLzui8h9mua07287m74DVdfyFP7AgwJf6EK2O3Z6tFPTZar
        VZwpucKk6XExR/XbaOKvSPwluDAYQWpfqF0HvmA3juhbwd86ARtXcbgg1QuqvABFB3zry8R+o5usH
        yxVU/CVapqJ88CjtPgg/M3Ocnvya6DcMjazVi6UlJbvfrxiFiMZ5X7xlCxgctoyBURfMkqTCrkhUo
        nX95P5FQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAw6h-0003Az-CQ; Wed, 26 Aug 2020 14:08:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6AFD930015A;
        Wed, 26 Aug 2020 16:08:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1AACD203A64CA; Wed, 26 Aug 2020 16:08:52 +0200 (CEST)
Date:   Wed, 26 Aug 2020 16:08:52 +0200
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
Message-ID: <20200826140852.GG1362448@hirez.programming.kicks-ass.net>
References: <159844957216.510284.17683703701627367133.stgit@devnote2>
 <159844960343.510284.15315372011917043979.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159844960343.510284.15315372011917043979.stgit@devnote2>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 26, 2020 at 10:46:43PM +0900, Masami Hiramatsu wrote:
>  static __used __kprobes void *trampoline_handler(struct pt_regs *regs)
>  {
> +	return (void *)kretprobe_trampoline_handler(regs,
> +				(unsigned long)&kretprobe_trampoline,
> +				regs->ARM_fp);
>  }

Does it make sense to have the generic code have a weak
trampoline_handler() implemented like the above? It looks like a number
of architectures have this trivial variant and it seems pointless to
duplicate this.
