Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8689B6A664
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2019 12:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732318AbfGPKVX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jul 2019 06:21:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56740 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731401AbfGPKVX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 06:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+jPmiLFoLFkErQnsFP18srbHMWPmmDSQUv0S0HNnLWo=; b=1FCCrHiw6wHWzTKNNLJJ628q3
        sfZxcu4lXp8UOSjklMM84EEttE7cH/rxMVbAXKhQFu/3gZ+10G+GnD+QOGbggR+a4ntTcNNLYXw6j
        HQwYBI7Ip3s3jo0xYu5aAhxsO3PdiOkRFEk7AC6tY7L756h2yeZid6XR7FOoEIDs4wrGIKWBypx6+
        29+ITIL/Aw/WCMapng0MkEzqtfJq2WfLPttOSGcTayXz12kmjfnqKQ1/O4cinbNjMouqSZ1YNkODG
        xCHWvcC8YQP8U9hwBoJRuKV0DN2nezJlsVl3CsaH//S3ws6GsMrkZoCA9+TfD1jPwDtslYWwL3NIq
        t5kPYIzrg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hnKZX-0005uN-La; Tue, 16 Jul 2019 10:20:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 58FB52021C301; Tue, 16 Jul 2019 12:20:34 +0200 (CEST)
Date:   Tue, 16 Jul 2019 12:20:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
Subject: Re: [PATCH v3 2/5] locking/qspinlock: Refactor the qspinlock slow
 path
Message-ID: <20190716102034.GN3419@hirez.programming.kicks-ass.net>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-3-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715192536.104548-3-alex.kogan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 15, 2019 at 03:25:33PM -0400, Alex Kogan wrote:

> +/*
> + * set_locked_empty_mcs - Try to set the spinlock value to _Q_LOCKED_VAL,
> + * and by doing that unlock the MCS lock when its waiting queue is empty
> + * @lock: Pointer to queued spinlock structure
> + * @val: Current value of the lock
> + * @node: Pointer to the MCS node of the lock holder
> + *
> + * *,*,* -> 0,0,1
> + */
> +static __always_inline bool __set_locked_empty_mcs(struct qspinlock *lock,
> +						   u32 val,
> +						   struct mcs_spinlock *node)
> +{
> +	return atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL);
> +}

That name is nonsense. It should be something like:

static __always_inline bool __try_clear_tail(...)


> +/*
> + * pass_mcs_lock - pass the MCS lock to the next waiter
> + * @node: Pointer to the MCS node of the lock holder
> + * @next: Pointer to the MCS node of the first waiter in the MCS queue
> + */
> +static __always_inline void __pass_mcs_lock(struct mcs_spinlock *node,
> +					    struct mcs_spinlock *next)
> +{
> +	arch_mcs_spin_unlock_contended(&next->locked, 1);
> +}

I'm not entirely happy with that name either; but it's not horrible like
the other one. Why not mcs_spin_unlock_contended() ?
