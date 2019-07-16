Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDA316A6EC
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2019 13:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387439AbfGPLEr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jul 2019 07:04:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35026 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387421AbfGPLEr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 07:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V8XZvZAcUamsSZTab85Z64TRseHDkhL2kB2eADz4tBU=; b=kq39LOq6ikOI7FkK15EnJPIm2
        GSYX7Nv6fUk6tyKjvX4zU26KYfvGHcwEDzdOS1KDha/TpjZy2UlhePyOmlSWnYhVU2El08XXvu8IH
        9UTdM7DRYxtCU9EJLplTsaLAEC5QuqvzC2a1vYb4DpIJp6MpA2FVp2gC6P4Ky2GI492Th5FShcpJ0
        vjdFbhoHVqM3Step7g08MgFwZFn9Ref1SYepQ2TdEFdmM1UF9Q/1Eq405Mox0ssaDaUOAf8lP0oqT
        fhBb5uLElUZ8gHTz833nqU8iHgg6PT9WvfJYGvD++u/Zhwe6XVi39WQeBF8epYRDVfv5+ZuknLnMp
        IzFBLXrHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hnLG1-0004dN-Ta; Tue, 16 Jul 2019 11:04:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9DEA0201D171F; Tue, 16 Jul 2019 13:04:27 +0200 (CEST)
Date:   Tue, 16 Jul 2019 13:04:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, dave.dice@oracle.com,
        rahul.x.yadav@oracle.com
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20190716110427.GP3419@hirez.programming.kicks-ass.net>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
 <77bba626-f3e6-45a8-aae8-43b945d0fab9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77bba626-f3e6-45a8-aae8-43b945d0fab9@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 15, 2019 at 05:30:01PM -0400, Waiman Long wrote:
> On 7/15/19 3:25 PM, Alex Kogan wrote:
> >  /*
> > - * On 64-bit architectures, the mcs_spinlock structure will be 16 bytes in
> > - * size and four of them will fit nicely in one 64-byte cacheline. For
> > - * pvqspinlock, however, we need more space for extra data. To accommodate
> > - * that, we insert two more long words to pad it up to 32 bytes. IOW, only
> > - * two of them can fit in a cacheline in this case. That is OK as it is rare
> > - * to have more than 2 levels of slowpath nesting in actual use. We don't
> > - * want to penalize pvqspinlocks to optimize for a rare case in native
> > - * qspinlocks.
> > + * On 64-bit architectures, the mcs_spinlock structure will be 20 bytes in
> > + * size. For pvqspinlock or the NUMA-aware variant, however, we need more
> > + * space for extra data. To accommodate that, we insert two more long words
> > + * to pad it up to 36 bytes.
> >   */

> The 20 bytes figure is wrong. It is actually 24 bytes for 64-bit as the
> mcs_spinlock structure is 8-byte aligned. For better cacheline
> alignment, I will like to keep mcs_spinlock to 16 bytes as before.
> Instead, you can use encode_tail() to store the CNA node pointer in
> "locked". For instance, use (encode_tail() << 1) in locked to
> distinguish it from the regular locked=1 value.

Yes, please don't bloat this. I already don't like what Waiman did for
the paravirt case, but this is horrible.
