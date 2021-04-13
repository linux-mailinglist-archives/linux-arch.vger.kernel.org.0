Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4ED35DE34
	for <lists+linux-arch@lfdr.de>; Tue, 13 Apr 2021 14:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238034AbhDMMD4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Apr 2021 08:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237609AbhDMMD4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Apr 2021 08:03:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB204C061574;
        Tue, 13 Apr 2021 05:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6KpzU18eXMDe/3Xb84g1a2GDcLOlQ4ZLthSWTM3Q8Z8=; b=NJuH3upRDSQU/v0LS0b2VKedoz
        yn+GkzfBO4OPiS+JHLQRK9sAn8ds9v4liCyEFxTwMeWz45LhUxhzT0t6/cQgEftZyYpn7iJU3gL7p
        NRrhLKO+cy3TbkfQH1oOCc+5XFbCY5ip53geF7AQVennuk3LeYirPrks3QEmcd9gzoi85F3BzWThi
        iL+lOcVQmbJhsr97FMFAR5lv2z8RkWVWq63BcNHFA4/hExtlBH4q9uET+cxieV9SqvYdXDf7RGfys
        D+ifUrOiJZQINBlSn6attQvXTXCGkUiLwVVj64GbRLi5VAS8VDM61nzR5XGkk/ROGAiBMm2lvohjg
        pYuGNRxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWHl5-009A7T-Ma; Tue, 13 Apr 2021 12:03:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3763F300033;
        Tue, 13 Apr 2021 14:03:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1B0D82C2DBD59; Tue, 13 Apr 2021 14:03:07 +0200 (CEST)
Date:   Tue, 13 Apr 2021 14:03:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
Subject: Re: [PATCH v14 4/6] locking/qspinlock: Introduce starvation
 avoidance into CNA
Message-ID: <YHWIezK9pbmbWxsu@hirez.programming.kicks-ass.net>
References: <20210401153156.1165900-1-alex.kogan@oracle.com>
 <20210401153156.1165900-5-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401153156.1165900-5-alex.kogan@oracle.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 01, 2021 at 11:31:54AM -0400, Alex Kogan wrote:

> @@ -49,13 +55,33 @@ struct cna_node {
>  	u16			real_numa_node;
>  	u32			encoded_tail;	/* self */
>  	u32			partial_order;	/* enum val */
> +	s32			start_time;
>  };

> +/*
> + * Controls the threshold time in ms (default = 10) for intra-node lock
> + * hand-offs before the NUMA-aware variant of spinlock is forced to be
> + * passed to a thread on another NUMA node. The default setting can be
> + * changed with the "numa_spinlock_threshold" boot option.
> + */
> +#define MSECS_TO_JIFFIES(m)	\
> +	(((m) + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ))
> +static int intra_node_handoff_threshold __ro_after_init = MSECS_TO_JIFFIES(10);
> +
> +static inline bool intra_node_threshold_reached(struct cna_node *cn)
> +{
> +	s32 current_time = (s32)jiffies;
> +	s32 threshold = cn->start_time + intra_node_handoff_threshold;
> +
> +	return current_time - threshold > 0;
> +}

None of this makes any sense:

 - why do you track time elapsed as a signed entity?
 - why are you using jiffies; that's terrible granularity.

As Andi already said, 10ms is silly large. You've just inflated the
lock-acquire time for every contended lock to stupid land just because
NUMA.

And this also brings me to the whole premise of this series; *why* are
we optimizing this? What locks are so contended that this actually helps
and shouldn't you be spending your time breaking those locks? That would
improve throughput more than this ever can.

>  static void __init cna_init_nodes_per_cpu(unsigned int cpu)
>  {
>  	struct mcs_spinlock *base = per_cpu_ptr(&qnodes[0].mcs, cpu);

> @@ -250,11 +284,17 @@ static void cna_order_queue(struct mcs_spinlock *node)
>  static __always_inline u32 cna_wait_head_or_lock(struct qspinlock *lock,
>  						 struct mcs_spinlock *node)
>  {
> -	/*
> -	 * Try and put the time otherwise spent spin waiting on
> -	 * _Q_LOCKED_PENDING_MASK to use by sorting our lists.
> -	 */
> -	cna_order_queue(node);
> +	struct cna_node *cn = (struct cna_node *)node;
> +
> +	if (!cn->start_time || !intra_node_threshold_reached(cn)) {
> +		/*
> +		 * Try and put the time otherwise spent spin waiting on
> +		 * _Q_LOCKED_PENDING_MASK to use by sorting our lists.
> +		 */
> +		cna_order_queue(node);
> +	} else {
> +		cn->partial_order = FLUSH_SECONDARY_QUEUE;

This is even worse naming..

> +	}
>  
>  	return 0; /* we lied; we didn't wait, go do so now */
>  }
