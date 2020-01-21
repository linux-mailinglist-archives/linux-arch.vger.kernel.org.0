Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0D0143E9C
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2020 14:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgAUNuv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jan 2020 08:50:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50982 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbgAUNuv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jan 2020 08:50:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RjUsqeJUUzUJuJcmpsSdcYGm0XwgRf/1551aZ5zeO3s=; b=RjMIrq2wAUkcmRdiBmTy7NcGK
        5QtEMlFa32lozP7Jb5nLiZb/2904F3amrncL046uY2/QkmsePy6eurlt328MwWZKdQ2MTm6aSsOld
        0PM2OZ1zHHsw1Bdaww8cj3JNqZ0OfTTISC6bQHl87U8NmJkpTdagE0u8DUyctShmE+P0zfp5tBtvm
        q0ZZqPYaPpTS1y03H5Ph0uOipV2nAOynqXDrnR2CTalgWzkMjXtJMZPSMKQwl0Afxol6nc33q/jhF
        SLxM/Eu3xVqnqxqC/ADaWa4BL5Va1Wybr+spaCET+wNzsBv12luA4HBkhkIeUrWPGmEEZXLdO+qtW
        WYzq6t+TQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ittvR-0003vU-1M; Tue, 21 Jan 2020 13:50:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C7F8C305D3F;
        Tue, 21 Jan 2020 14:48:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E9BBA20983FC0; Tue, 21 Jan 2020 14:50:34 +0100 (CET)
Date:   Tue, 21 Jan 2020 14:50:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, bristot@redhat.com
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
Message-ID: <20200121135034.GA14946@hirez.programming.kicks-ass.net>
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20191230194042.67789-5-alex.kogan@oracle.com>
 <20200121132949.GL14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121132949.GL14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 21, 2020 at 02:29:49PM +0100, Peter Zijlstra wrote:
> On Mon, Dec 30, 2019 at 02:40:41PM -0500, Alex Kogan wrote:
> 
> > +/*
> > + * Controls the threshold for the number of intra-node lock hand-offs before
> > + * the NUMA-aware variant of spinlock is forced to be passed to a thread on
> > + * another NUMA node. By default, the chosen value provides reasonable
> > + * long-term fairness without sacrificing performance compared to a lock
> > + * that does not have any fairness guarantees. The default setting can
> > + * be changed with the "numa_spinlock_threshold" boot option.
> > + */
> > +int intra_node_handoff_threshold __ro_after_init = 1 << 16;
> 
> There is a distinct lack of quantitative data to back up that
> 'reasonable' claim there.
> 
> Where is the table of inter-node latencies observed for the various
> values tested, and on what criteria is this number deemed reasonable?
> 
> To me, 64k lock hold times seems like a giant number, entirely outside
> of reasonable.

Daniel, IIRC you just did a paper on constructing worst case latencies
from measuring pieces. Do you have data on average lock hold times?
