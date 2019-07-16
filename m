Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 535AE6AC62
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2019 17:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387773AbfGPP7Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jul 2019 11:59:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34340 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732614AbfGPP7Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 11:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HKURHM7m5zXsi/GOJrSkjBrQT5KBLSbh/yuqng7TVWQ=; b=FZ2B+Fcqy5zrXkeMmMwqudKix
        0MId/49v5zj7hvExkwzR406w9qiPdWWNN8orfzbsU2+IvDK5dUb6AVNQr9RbtfbmLJE1iNFTgA/N3
        lgVh2CR+iocUKXmxSyJm93Fw9p0m8+L5OAuKoXp/gn5R1iDQOWybaJpWKjBFxSES9APhYZ+h09hOO
        d0UoLArUQk6RZQgNkISbxzZZqQYTr/YTiCc5gEo658bZfh8IIs6cdggGTBbfpvsKhjPMD2qCCRtzV
        RG+EM/IvdXAWSKosY1wbLpsfnSdSU+S/nuMhbs6htPFUw8AbyNSYU5xJn/VrzYla7hqJVbpqGfG9Q
        d/pDbtEcw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hnPr4-00015I-B2; Tue, 16 Jul 2019 15:59:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B55F12059DEA3; Tue, 16 Jul 2019 17:59:00 +0200 (CEST)
Date:   Tue, 16 Jul 2019 17:59:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
Subject: Re: [PATCH v3 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
Message-ID: <20190716155900.GS3419@hirez.programming.kicks-ass.net>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-5-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715192536.104548-5-alex.kogan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 15, 2019 at 03:25:35PM -0400, Alex Kogan wrote:

> @@ -36,6 +37,33 @@ struct cna_node {
>  
>  #define CNA_NODE(ptr) ((struct cna_node *)(ptr))
>  
> +/* Per-CPU pseudo-random number seed */
> +static DEFINE_PER_CPU(u32, seed);
> +
> +/*
> + * Controls the probability for intra-node lock hand-off. It can be
> + * tuned and depend, e.g., on the number of CPUs per node. For now,
> + * choose a value that provides reasonable long-term fairness without
> + * sacrificing performance compared to a version that does not have any
> + * fairness guarantees.
> + */
> +#define INTRA_NODE_HANDOFF_PROB_ARG 0x10000
> +
> +/*
> + * Return false with probability 1 / @range.
> + * @range must be a power of 2.
> + */
> +static bool probably(unsigned int range)
> +{
> +	u32 s;
> +
> +	s = this_cpu_read(seed);
> +	s = next_pseudo_random32(s);
> +	this_cpu_write(seed, s);
> +
> +	return s & (range - 1);

This is fragile, better to take a number of bits as argument.

> +}
> +
>  static void cna_init_node(struct mcs_spinlock *node)
>  {
>  	struct cna_node *cn = CNA_NODE(node);
> @@ -140,7 +168,13 @@ static inline void cna_pass_mcs_lock(struct mcs_spinlock *node,
>  	u64 *var = &next->locked;
>  	u64 val = 1;
>  
> -	succ = find_successor(node);
> +	/*
> +	 * Try to pass the lock to a thread running on the same node.
> +	 * For long-term fairness, search for such a thread with high
> +	 * probability rather than always.
> +	 */
> +	if (probably(INTRA_NODE_HANDOFF_PROB_ARG))
> +		succ = find_successor(node);
>  
>  	if (succ) {
>  		var = &succ->mcs.locked;

And this is where that tertiary condition comes from.. I think.

