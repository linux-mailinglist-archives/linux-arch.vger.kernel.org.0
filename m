Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 726D6149531
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2020 12:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgAYLU6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 25 Jan 2020 06:20:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52478 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgAYLU6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Jan 2020 06:20:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LQclcc/iHz+UluZUUVN5bYPkULWxZm0NAtmv8jLa33E=; b=UOyLhHITbrqmU2/KnPPEmd42/
        2LlBjJTe2clynX01qlgxdIY0tm6AtJHMWdcXKGohJRUOyr747Iio0zP7Pr92dUSGNwJyXyg89kxmT
        YZS0pts0CkUg2PzsMbmJNLK9XEPjyaMMNVGZGQ8ZZ2+CnqeqUvD18yqkqSEG0hNGTQkdOc5yU63pb
        pNKyir/P9IUZZzl7tfR/u69bxmpAYZR4YBHKZYvKwoD/mkA94Nm1goYRBMZG0D6+vw0ZcPY3DfBPc
        PJepegAWFbwhrA/JJuBMfBc/opFgbcmk0wUNgD+orUvKn5Pn44FSMCEWf4D3lCmB4/2j0JKdMRkju
        R2evE6eKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ivJUY-0005d4-0o; Sat, 25 Jan 2020 11:20:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1F4A2980BB0; Sat, 25 Jan 2020 12:20:39 +0100 (CET)
Date:   Sat, 25 Jan 2020 12:20:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, hpa@zytor.com, x86@kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        dave.dice@oracle.com
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
Message-ID: <20200125112039.GX11457@worktop.programming.kicks-ass.net>
References: <cfdf635d-be2e-9d4b-c4ca-6bcbddc6868f@redhat.com>
 <3862F8A1-FF9B-40AD-A88E-2C0BA7AF6F58@oracle.com>
 <20200124075235.GX14914@hirez.programming.kicks-ass.net>
 <2c6741c5-d89d-4b2c-cebe-a7c7f6eed884@redhat.com>
 <48ce49e5-98a7-23cd-09f4-8290a65abbb5@redhat.com>
 <8D3AFB47-B595-418C-9568-08780DDC58FF@oracle.com>
 <714892cd-d96f-4d41-ae8b-d7b7642a6e3c@redhat.com>
 <1669BFDE-A1A5-4ED8-B586-035460BBF68A@oracle.com>
 <45660873-731a-a810-8c57-1a5a19d266b4@redhat.com>
 <b26837a9-d0cd-4413-95ec-1deaca184324@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b26837a9-d0cd-4413-95ec-1deaca184324@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 24, 2020 at 01:51:34PM -0500, Waiman Long wrote:

< 71 lines of garbage >

> > You can use the in_task() macro in include/linux/preempt.h. This is
> > just a percpu preempt_count read and test. If in_task() is false, it
> > is in a {soft|hard}irq or nmi context. If it is true, you can check
> > the rt_task() macro to see if it is an RT task. That will access to
> > the current task structure. So it may cost a little bit more if you
> > want to handle the RT task the same way.
> >
> We may not need to do that for softIRQ context. If that is the case, you
> can use in_irq() which checks for hardirq and nmi only. Peter, what is
> your thought on that?

Can you lot please start trimming emails when you reply?
