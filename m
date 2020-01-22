Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1EE144E96
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2020 10:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgAVJXA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jan 2020 04:23:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37346 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAVJXA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jan 2020 04:23:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7TJ8torUFmtaFtBo15mPSZ4ZwelNEa23cOw5BRX3Vpw=; b=kw+tIUTbU7943YpDBQeDQWrVC
        tFIhT7H7jmPCo2OYXmI5H1wk/MJm/xaKQXE/R4TQHFksvKPYXfgRzdv+l1qdl5cOnR0/mktS1WXpQ
        kf2LG9e+BKFtIofJmGDI4YlmhFI3a/fhkDpgNeTJMmRki39754GxF79A3fuidw8OMicohRQQhDPkT
        f1jtlpOA1Kt781bhn2iEW4nwnTjG1gxmzRkl/8enXcIj0YWhETQ8mGc6UexvWCkki2OiTcIwFjZmO
        GyybztJNOk/LOfvlSBYzZX4tP+Ycq2e33gsFVGeAPACgT2/ILfg8/gAl9MLFTaGf3PV4Fw+Rhnxrj
        QTCerUBPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iuCDj-0004nF-Hg; Wed, 22 Jan 2020 09:22:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 78B463011F9;
        Wed, 22 Jan 2020 10:20:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 043BB20983E34; Wed, 22 Jan 2020 10:22:38 +0100 (CET)
Date:   Wed, 22 Jan 2020 10:22:38 +0100
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
Message-ID: <20200122092238.GV14879@hirez.programming.kicks-ass.net>
References: <20191125210709.10293-1-alex.kogan@oracle.com>
 <20191125210709.10293-4-alex.kogan@oracle.com>
 <20200121202919.GM11457@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121202919.GM11457@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 21, 2020 at 09:29:19PM +0100, Peter Zijlstra wrote:
> @@ -92,8 +92,8 @@ static int __init cna_init_nodes(void)
>  }
>  early_initcall(cna_init_nodes);
>  
> -static inline bool cna_try_change_tail(struct qspinlock *lock, u32 val,
> -				       struct mcs_spinlock *node)
> +static inline bool cna_try_clear_tail(struct qspinlock *lock, u32 val,
> +				      struct mcs_spinlock *node)
>  {
>  	struct mcs_spinlock *head_2nd, *tail_2nd;
>  	u32 new;

Also, that whole function is placed wrong; it should be between
cna_wait_head_or_lock() and cna_pass_lock(), then it's in the order they
appear in the slow path, ie. the order they actually run.
