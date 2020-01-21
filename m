Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31749143E08
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2020 14:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgAUNbE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jan 2020 08:31:04 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43374 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgAUNbE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jan 2020 08:31:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sQsNUT1I6E8QItPKtSDNxr8kzUBb8jOWCVawdbMbuhs=; b=wumgBDv6cNBhEJASXpiGDNAAA
        fIjFViuZ/mfovC47v2shUCqKUf1OHOHGHCqlPOvQ1A7JID+0E02moRI0efYbudsqlBXR/o+B+mGN5
        mxIMenqLi4lcXgHyX6fCzBEzOsMdRXvfiIht1UCcGvWIe/7idW3F02/5yuTujrnLupRkFDzhwre64
        0e3Tb0KiaEV35OILtmALggkTSogvX2c4NUq6SAxjY4o624HXSoftOhLihn9/jnyMmejE86xuOmlNz
        d4dQ2iYkRLOzMPuMT9CR6NFW2DiezhfzlklTPofyQ86qCl400zrucJA1Mux8uWyHG3//ShnZLO7TL
        y5ils314w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ittbO-0006Ql-0z; Tue, 21 Jan 2020 13:29:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B9A1F3043C9;
        Tue, 21 Jan 2020 14:28:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D89C520983FD9; Tue, 21 Jan 2020 14:29:49 +0100 (CET)
Date:   Tue, 21 Jan 2020 14:29:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
Message-ID: <20200121132949.GL14914@hirez.programming.kicks-ass.net>
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20191230194042.67789-5-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230194042.67789-5-alex.kogan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 30, 2019 at 02:40:41PM -0500, Alex Kogan wrote:

> +/*
> + * Controls the threshold for the number of intra-node lock hand-offs before
> + * the NUMA-aware variant of spinlock is forced to be passed to a thread on
> + * another NUMA node. By default, the chosen value provides reasonable
> + * long-term fairness without sacrificing performance compared to a lock
> + * that does not have any fairness guarantees. The default setting can
> + * be changed with the "numa_spinlock_threshold" boot option.
> + */
> +int intra_node_handoff_threshold __ro_after_init = 1 << 16;

There is a distinct lack of quantitative data to back up that
'reasonable' claim there.

Where is the table of inter-node latencies observed for the various
values tested, and on what criteria is this number deemed reasonable?

To me, 64k lock hold times seems like a giant number, entirely outside
of reasonable.

> +
>  static void __init cna_init_nodes_per_cpu(unsigned int cpu)
>  {
>  	struct mcs_spinlock *base = per_cpu_ptr(&qnodes[0].mcs, cpu);
> @@ -97,6 +109,11 @@ static int __init cna_init_nodes(void)
>  }
>  early_initcall(cna_init_nodes);
>  
> +static __always_inline void cna_init_node(struct mcs_spinlock *node)
> +{
> +	((struct cna_node *)node)->intra_count = 0;
> +}
> +
>  /* this function is called only when the primary queue is empty */
>  static inline bool cna_try_change_tail(struct qspinlock *lock, u32 val,
>  				       struct mcs_spinlock *node)
> @@ -233,7 +250,9 @@ __always_inline u32 cna_pre_scan(struct qspinlock *lock,
>  {
>  	struct cna_node *cn = (struct cna_node *)node;
>  
> -	cn->pre_scan_result = cna_scan_main_queue(node, node);
> +	cn->pre_scan_result =
> +		cn->intra_count == intra_node_handoff_threshold ?
> +			FLUSH_SECONDARY_QUEUE : cna_scan_main_queue(node, node);

Because:

	if (cn->intra_count < intra_node_handoff_threshold)
		cn->pre_scan_result = cna_scan_main_queue(node, node);
	else
		cn->pre_scan_result = FLUSH_SECONDARY_QUEUE;

was too readable?

