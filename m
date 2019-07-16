Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B18A6A669
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2019 12:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfGPKXd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jul 2019 06:23:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56786 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbfGPKXd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 06:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=geQnomQajzgBsSVYw/PnnftxW7/f0nnaIsebEDQXuNY=; b=FlbJkTtZ1IvTsDccm1VJQt3rW
        Sz3zJvkV3o6EPdjxAtfFv31Hzjdlj+DaBzBwzryDBFV1Zn/+QedDxmC4oXNnqDdfbYI1aG/sWFOE2
        rimoVRhsG8M6UQUyM0Pi4KQutoGRIjXOge4jf4t9PrYkUxn9KLoOxVdBhQo4bXfJwDf5nD05TmpPE
        V9QaY97exZg9urrNVaNC8vJuoYi3RPlhIRrvftlxB5yRDkqFtdRY0RjKec0lDRsgijTdTgVm4CRVf
        WZKxzyPlRgtYOYfVL1J+3JC42sdy+wIIVZK6y3a6OkgSESsjhzDDpbQAGGjJuMJozuJ0/CiEasfxQ
        H9cZc/zXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hnKc7-0005wF-Lm; Tue, 16 Jul 2019 10:23:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 36F982021C301; Tue, 16 Jul 2019 12:23:14 +0200 (CEST)
Date:   Tue, 16 Jul 2019 12:23:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
Subject: Re: [PATCH v3 1/5] locking/qspinlock: Make
 arch_mcs_spin_unlock_contended more generic
Message-ID: <20190716102314.GO3419@hirez.programming.kicks-ass.net>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-2-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715192536.104548-2-alex.kogan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 15, 2019 at 03:25:32PM -0400, Alex Kogan wrote:

> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index e14b32c69639..961781624638 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -558,7 +558,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  	if (!next)
>  		next = smp_cond_load_relaxed(&node->next, (VAL));
>  
> -	arch_mcs_spin_unlock_contended(&next->locked);
> +	arch_mcs_spin_unlock_contended(&next->locked, 1);
>  	pv_kick_node(lock, next);

My problem with this patch is that the above reads really daft. Should
we rename the whole function? arch_mcs_pass_lock() perhaps?
