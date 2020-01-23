Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F299B146CD1
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 16:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgAWP3y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 10:29:54 -0500
Received: from merlin.infradead.org ([205.233.59.134]:34794 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgAWP3y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 10:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B/n7W4E7uJv5pAkHx8ZqbqbrQSUi/FNUw9Ppcu+la6k=; b=j1j6sCnf43FehruEfnqskrYLt
        Nn8vL0JG757sO7HS9jy/OW4qN7Xix2ztFpJGjhG0QLLNLKrSVprKwN1Sm3w4t2G1KuTivtLxuDNow
        srmx8d4BRDA1cZVtL6pPeoES1PflMknut7Qo5+xQo4tgayMAJo90FilPtFtGDWghaDrVt4qeBqnX/
        jkQYNsbBaH8pe2tklc/irJIS4pachSjxnlh9EF7llzHd7lOWKQaqSi5iO5UGtwVpOK2z8O/H++xNM
        IUmNO6YlaNgdwixRiYPWm027TpZwMb8tRhf1G4ApegWcUN+G3gVCW7J+VmdIQ/F6/Es0/QM44NRFi
        gDzwJ0FxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iueQ6-0007ex-8F; Thu, 23 Jan 2020 15:29:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2261E300693;
        Thu, 23 Jan 2020 16:27:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 42C712B63FCAF; Thu, 23 Jan 2020 16:29:18 +0100 (CET)
Date:   Thu, 23 Jan 2020 16:29:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, dave.dice@oracle.com
Subject: Re: [PATCH v9 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20200123152918.GD14879@hirez.programming.kicks-ass.net>
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <20200115035920.54451-4-alex.kogan@oracle.com>
 <d751a8ef-aae8-ca70-6a28-79dd8bee2324@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d751a8ef-aae8-ca70-6a28-79dd8bee2324@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 23, 2020 at 09:15:55AM -0500, Waiman Long wrote:
> On 1/14/20 10:59 PM, Alex Kogan wrote:
> > +static int __init cna_init_nodes(void)
> > +{
> > +	unsigned int cpu;
> > +
> > +	/*
> > +	 * this will break on 32bit architectures, so we restrict
> > +	 * the use of CNA to 64bit only (see arch/x86/Kconfig)
> > +	 */
> > +	BUILD_BUG_ON(sizeof(struct cna_node) > sizeof(struct qnode));
> > +	/* we store an ecoded tail word in the node's @locked field */
> > +	BUILD_BUG_ON(sizeof(u32) > sizeof(unsigned int));
> > +
> > +	for_each_possible_cpu(cpu)
> > +		cna_init_nodes_per_cpu(cpu);
> > +
> > +	return 0;
> > +}
> > +early_initcall(cna_init_nodes);
> > +
> 
> I just realized that you shouldn't call cna_init_nodes as an
> early_initcall. Instead,
> 
> > +/*
> > + * Switch to the NUMA-friendly slow path for spinlocks when we have
> > + * multiple NUMA nodes in native environment, unless the user has
> > + * overridden this default behavior by setting the numa_spinlock flag.
> > + */
> > +void __init cna_configure_spin_lock_slowpath(void)
> > +{
> > +	if ((numa_spinlock_flag == 1) ||
> > +	    (numa_spinlock_flag == 0 && nr_node_ids > 1 &&
> > +		    pv_ops.lock.queued_spin_lock_slowpath ==
> > +			native_queued_spin_lock_slowpath)) {
> > +		pv_ops.lock.queued_spin_lock_slowpath =
> > +		    __cna_queued_spin_lock_slowpath;
> > +
> > +		pr_info("Enabling CNA spinlock\n");
> > +	}
> > +}
> 
> call it when it is sure that CNA spinlock is going to be used. At this
> point, the system is still in UP mode and the slowpath will not be called.

Indeed, let me go fix that!
