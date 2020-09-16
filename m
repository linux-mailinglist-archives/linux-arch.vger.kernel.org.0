Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDF426C9C9
	for <lists+linux-arch@lfdr.de>; Wed, 16 Sep 2020 21:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgIPTZu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Sep 2020 15:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbgIPTYE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Sep 2020 15:24:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3111DC06174A;
        Wed, 16 Sep 2020 12:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Lu9AW4PaP4+ghxOf92Z5TIuOtrZJHfVdt4GP1kALmko=; b=qie+Isc1xWiVTOH0FpnUHhEdVO
        U/jpqcMvDRllAqn5p1U7GdefAxVM84Yy20b0cEM1bgiBf5hCnk01e9MB0TfKNwOXtWN1U1K+TKZoh
        Bf7eW6kpPKuWJAr92A4pFo4s9J4/zlCT/ZybRGMdVlaWMx2Lk0KLJY3uqYA5myPxU7z9T0QBID7Dv
        QCPTePB01BBKw0BUKhTbux2is2J6jnziOkr8sFb2qrhMyKZ9JnMFHBYx4uJoB16mYi9Z0C/a5HCRA
        DVWm6Js19jJdrChlv68PKTMdyYhgXX++ENCqsExKeuZiA9F/oE7zG8P2cfvR8n7McmH85zDTJUYAn
        sSR0hzAg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kId20-0006tV-87; Wed, 16 Sep 2020 19:23:52 +0000
Date:   Wed, 16 Sep 2020 20:23:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um <linux-um@lists.infradead.org>,
        Brian Cain <bcain@codeaurora.org>,
        linux-hexagon@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [patch 00/13] preempt: Make preempt count unconditional
Message-ID: <20200916192352.GO5449@casper.infradead.org>
References: <20200914204209.256266093@linutronix.de>
 <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
 <871rj4owfn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rj4owfn.fsf@nanos.tec.linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 14, 2020 at 11:55:24PM +0200, Thomas Gleixner wrote:
> But just look at any check which uses preemptible(), especially those
> which check !preemptible():

hmm.

+++ b/include/linux/preempt.h
@@ -180,7 +180,9 @@ do { \
 
 #define preempt_enable_no_resched() sched_preempt_enable_no_resched()
 
+#ifndef MODULE
 #define preemptible()  (preempt_count() == 0 && !irqs_disabled())
+#endif
 
 #ifdef CONFIG_PREEMPTION
 #define preempt_enable() \


$ git grep -w preemptible drivers
(slightly trimmed by hand to remove, eg, comments)
drivers/firmware/arm_sdei.c:    WARN_ON_ONCE(preemptible());
drivers/firmware/arm_sdei.c:    WARN_ON_ONCE(preemptible());
drivers/firmware/arm_sdei.c:    WARN_ON_ONCE(preemptible());
drivers/firmware/arm_sdei.c:    WARN_ON_ONCE(preemptible());
drivers/firmware/arm_sdei.c:    WARN_ON(preemptible());
drivers/firmware/efi/efi-pstore.c:                            preemptible(), record->size, record->psi->buf);
drivers/irqchip/irq-gic-v4.c:   WARN_ON(preemptible());
drivers/irqchip/irq-gic-v4.c:   WARN_ON(preemptible());
drivers/scsi/hisi_sas/hisi_sas_main.c:          if (!preemptible())
drivers/xen/time.c:     BUG_ON(preemptible());

That only looks like two drivers that need more than WARNectomies.

Although maybe rcu_read_load_sched_held() or rcu_read_lock_any_held()
might get called from a module ...
