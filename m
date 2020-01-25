Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD6B714926F
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2020 01:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387542AbgAYA5P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jan 2020 19:57:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:44822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387475AbgAYA5O (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Jan 2020 19:57:14 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D40442071E;
        Sat, 25 Jan 2020 00:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579913833;
        bh=7jt0GTJ/WTvnJW0J0lj3B8HCo6k1PQjNhvzflXBV4Tk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=p2zHxPE5tfiNPi2OhmhFXsfhjkb6uZL1MmWFtLvtH2bHlq5/tAqcHCSP2TZe7SDkn
         3iI69TItHEfO9zhVah9QIqJaHhMn6rGJOIRtvf1kNaBL232FKwpOvMViCH4EG9f1R4
         /Cbm/Lyzh+kK/9ABYtItJ/s72k1nCeBSgG6Of1Bs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A729D352018E; Fri, 24 Jan 2020 16:57:13 -0800 (PST)
Date:   Fri, 24 Jan 2020 16:57:13 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com, dave.dice@oracle.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com
Subject: Re: [PATCH v9 0/5] Add NUMA-awareness to qspinlock
Message-ID: <20200125005713.GZ2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <20200124222434.GA7196@paulmck-ThinkPad-P72>
 <6AAE7FC6-F5DE-4067-8BC4-77F27948CD09@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6AAE7FC6-F5DE-4067-8BC4-77F27948CD09@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 24, 2020 at 06:39:02PM -0500, Alex Kogan wrote:
> Hi, Paul.
> 
> Thanks for running those experiments!
> 
> > On Jan 24, 2020, at 5:24 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > On Tue, Jan 14, 2020 at 10:59:15PM -0500, Alex Kogan wrote:
> >> Minor changes from v8 based on feedback from Longman:
> >> -----------------------------------------------------
> >> 
> >> - Add __init to cna_configure_spin_lock_slowpath().
> >> 
> >> - Fix the comment for cna_scan_main_queue().
> >> 
> >> - Change the type of intra_node_handoff_threshold to unsigned int.
> >> 
> >> 
> >> Summary
> >> -------
> >> 
> >> Lock throughput can be increased by handing a lock to a waiter on the
> >> same NUMA node as the lock holder, provided care is taken to avoid
> >> starvation of waiters on other NUMA nodes. This patch introduces CNA
> >> (compact NUMA-aware lock) as the slow path for qspinlock. It is
> >> enabled through a configuration option (NUMA_AWARE_SPINLOCKS).
> >> 
> >> CNA is a NUMA-aware version of the MCS lock. Spinning threads are
> >> organized in two queues, a main queue for threads running on the same
> >> node as the current lock holder, and a secondary queue for threads
> >> running on other nodes. Threads store the ID of the node on which
> >> they are running in their queue nodes. After acquiring the MCS lock and
> >> before acquiring the spinlock, the lock holder scans the main queue
> >> looking for a thread running on the same node (pre-scan). If found (call
> >> it thread T), all threads in the main queue between the current lock
> >> holder and T are moved to the end of the secondary queue.  If such T
> >> is not found, we make another scan of the main queue after acquiring 
> >> the spinlock when unlocking the MCS lock (post-scan), starting at the
> >> node where pre-scan stopped. If both scans fail to find such T, the
> >> MCS lock is passed to the first thread in the secondary queue. If the
> >> secondary queue is empty, the MCS lock is passed to the next thread in the
> >> main queue. To avoid starvation of threads in the secondary queue, those
> >> threads are moved back to the head of the main queue after a certain
> >> number of intra-node lock hand-offs.
> >> 
> >> More details are available at https://urldefense.proofpoint.com/v2/url?u=https-3A__arxiv.org_abs_1810.05600&d=DwIBAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=Hvhk3F4omdCk-GE1PTOm3Kn0A7ApWOZ2aZLTuVxFK4k&m=1KUGGZYTHnQ25fgRFppdNvpJfI0rOO_Usdu18RDu_14&s=F12nhHutwnPNt_TQ2ELER0DhtsHlEI9EiW1nDPhm5-Y&e= <https://urldefense.proofpoint.com/v2/url?u=https-3A__arxiv.org_abs_1810.05600&d=DwIBAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=Hvhk3F4omdCk-GE1PTOm3Kn0A7ApWOZ2aZLTuVxFK4k&m=1KUGGZYTHnQ25fgRFppdNvpJfI0rOO_Usdu18RDu_14&s=F12nhHutwnPNt_TQ2ELER0DhtsHlEI9EiW1nDPhm5-Y&e=> .
> >> 
> >> The series applies on top of v5.5.0-rc6, commit b3a987b026.
> >> Performance numbers are available in previous revisions
> >> of the series.
> >> 
> >> Further comments are welcome and appreciated.
> > 
> > I ran this on a large system with a version of locktorture that was
> > modified to print out the maximum and minimum per-CPU lock-acquisition
> > counts, and with CPU hotplug disabled.  I also modified the LOCK01 and
> > LOCK04 scenarios to use 220 hardware threads.
> > 
> > Here is what the test ended up with at the end of a one-hour run:
> > 
> > LOCK01 (exclusive):
> > Writes:  Total: 1241107333  Max/Min: 9206962/60902 ???  Fail: 0
> > 
> > LOCK04 (rwlock):
> > Writes:  Total: 232991963  Max/Min: 2631574/74582 ???  Fail: 0
> > Reads :  Total: 216935386  Max/Min: 2735939/28665 ???  Fail: 0
> > 
> > The "???" strings are printed because the ratio of maximum to minimum exceeds
> > a factor of two.
> Is this what you expect / have seen with the existing qspinlock?
> 
> > 
> > I also ran 30-minute runs on my laptop, which has 12 hardware threads:
> > 
> > LOCK01 (exclusive):
> > Writes:  Total: 3992072782  Max/Min: 259368782/97231961 ???  Fail: 0
> > 
> > LOCK04 (rwlock):
> > Writes:  Total: 131063892  Max/Min: 13136206/5876157 ???  Fail: 0
> > Reads :  Total: 144876801  Max/Min: 19999535/4873442 ???  Fail: 0
> I assume the system above is multi-socket, but your laptop is probably not?
> 
> If that’s the case, CNA should not be enabled on your laptop (grep
> kernel logs for "Enabling CNA spinlock” to be sure).
> 
> > 
> > These also exceed the factor-of-two cutoff, but not as dramatically.
> > The readers for the reader-writer lock fared worst, with a 4-to-1 ratio.
> > 
> > These tests did run within guest OSes.
> So I really wonder if CNA was enabled here, or whether this is what you get
> with paravirt qspinlock.
> 
> >  Is that configuration out of
> > scope for this locking algorithm?  In addition (as might well also have
> > been the case for the locktorture runs in your paper), these tests run
> > a pair of stress-test tasks for each hardware thread.
> > 
> > Is this expected behavior?
> The results do appear skewed a bit too much, but it would be helpful to know
> what qspinlock we are looking at, and how they compare to the existing qspinlock,
> in case it is indeed CNA.

You called it!  I will play with QEMU's -numa argument to see if I can get
CNA to run for me.  Please accept my apologies for the false alarm.

							Thanx, Paul
