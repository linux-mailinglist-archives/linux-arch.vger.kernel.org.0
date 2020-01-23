Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0830146403
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 10:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgAWJBM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 04:01:12 -0500
Received: from merlin.infradead.org ([205.233.59.134]:60352 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgAWJBL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 04:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZO2+biof4EL4C/JTzti+vPwupIT1oX/9/8bYDrArCwQ=; b=NOiIWQWR4GnTdEVaJdQR3fftc
        2cjR9yhlWoh9F+xe7DPXmdBijCqW1eXE8n5Fvs/tpQU5tjazIKyXL7ozieETUP8D7R2Dr52zTYZxr
        P/gUBWd02yvOYvrmHlHZAQBDFPQHdNFALsPqjjJj346oGnEuLC8ye6YplJxt91+stCTMCRXavRPnA
        HDLYjxi9LLgx4ck9ovojPNc9iu6QmqJDymrRomPMUDquZklmJPPX0yYRZRvACzenYgm41Rx1LaLgA
        PUF1NFgWuRJPJdX25fpYDxfHwEcyY85OTcn6+gGC1zLeO88BR9EM2Lhck1X3rsq9cPaXXeJRgd1XY
        0j/R7gpyg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iuYLx-0002NM-GD; Thu, 23 Jan 2020 09:00:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 52282304121;
        Thu, 23 Jan 2020 09:58:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3D19D20983FC2; Thu, 23 Jan 2020 10:00:38 +0100 (CET)
Date:   Thu, 23 Jan 2020 10:00:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
Subject: Re: [PATCH v7 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20200123090038.GD14946@hirez.programming.kicks-ass.net>
References: <20191125210709.10293-1-alex.kogan@oracle.com>
 <20191125210709.10293-4-alex.kogan@oracle.com>
 <20200121202919.GM11457@worktop.programming.kicks-ass.net>
 <20200122095127.GC14946@hirez.programming.kicks-ass.net>
 <20200122170456.GY14879@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122170456.GY14879@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 22, 2020 at 06:04:56PM +0100, Peter Zijlstra wrote:
> +/*
> + * cna_splice_head -- splice the entire secondary queue onto the head of the
> + * primary queue.
> + */
> +static cna_splice_head(struct qspinlock *lock, u32 val,
> +		       struct mcs_spinlock *node, struct mcs_spinlock *next)
> +{
> +	struct mcs_spinlock *head_2nd, *tail_2nd;
> +
> +	tail_2nd = decode_tail(node->locked);
> +	head_2nd = tail_2nd->next;
> +
> +	if (lock) {

That should be: if (!next) {

> +		u32 new = ((struct cna_node *)tail_2nd)->encoded_tail | _Q_LOCKED_VAL;
> +		if (!atomic_try_cmpxchg_relaxed(&lock->val, &val, new))
> +			return NULL;
> +
> +		/*
> +		 * The moment we've linked the primary tail we can race with
> +		 * the WRITE_ONCE(prev->next, node) store from new waiters.
> +		 * That store must win.
> +		 */

And that still is a shit comment; I'll go try again.

> +		cmpxchg_relaxed(&tail_2nd->next, head_2nd, next);
> +	} else {
> +		tail_2nd->next = next;
> +	}
> +
> +	return head_2nd;
> +}
