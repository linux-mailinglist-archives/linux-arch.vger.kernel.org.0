Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5912E14A6F2
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2020 16:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgA0PJE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jan 2020 10:09:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:49314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729152AbgA0PJE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Jan 2020 10:09:04 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6895520702;
        Mon, 27 Jan 2020 15:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580137743;
        bh=LneyVWiMa0REJZFBSVOC8VBfEgVQakydJNAdr2Lnekk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pNrhYElv6xTheDCjXktEOImu6bsIU9tRvoXN96pANqkFzcFkQMZ1I+dYuoCmC0JRu
         6d/2P9PLeT9AJ9Y9WwM1oNxUHft49dzNLbkS6Va+Ig/mWrrGsVR6gdRS44EXVJZh3t
         3xg1uhtQVrzLCDg5L2GFvbqE+VxoruZq+8YbkGQo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B631A352279E; Mon, 27 Jan 2020 07:09:02 -0800 (PST)
Date:   Mon, 27 Jan 2020 07:09:02 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com, dave.dice@oracle.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com
Subject: Re: [PATCH v9 0/5] Add NUMA-awareness to qspinlock
Message-ID: <20200127150902.GN2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200124222434.GA7196@paulmck-ThinkPad-P72>
 <6AAE7FC6-F5DE-4067-8BC4-77F27948CD09@oracle.com>
 <20200125005713.GZ2935@paulmck-ThinkPad-P72>
 <02defadb-217d-7803-88a1-ec72a37eda28@redhat.com>
 <adb4fb09-f374-4d64-096b-ba9ad8b35fd5@redhat.com>
 <20200125045844.GC2935@paulmck-ThinkPad-P72>
 <967f99ee-b781-43f4-d8ba-af83786c429c@redhat.com>
 <20200126153535.GL2935@paulmck-ThinkPad-P72>
 <20200126224245.GA22901@paulmck-ThinkPad-P72>
 <2e552fad-79c0-ec06-3b8c-d13f1b67f57d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e552fad-79c0-ec06-3b8c-d13f1b67f57d@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 27, 2020 at 09:11:43AM -0500, Waiman Long wrote:
> On 1/26/20 5:42 PM, Paul E. McKenney wrote:
> > On Sun, Jan 26, 2020 at 07:35:35AM -0800, Paul E. McKenney wrote:
> >> On Sat, Jan 25, 2020 at 02:41:39PM -0500, Waiman Long wrote:
> >>> On 1/24/20 11:58 PM, Paul E. McKenney wrote:
> >>>> On Fri, Jan 24, 2020 at 09:17:05PM -0500, Waiman Long wrote:
> >>>>> On 1/24/20 8:59 PM, Waiman Long wrote:
> >>>>>>> You called it!  I will play with QEMU's -numa argument to see if I can get
> >>>>>>> CNA to run for me.  Please accept my apologies for the false alarm.
> >>>>>>>
> >>>>>>> 							Thanx, Paul
> >>>>>>>
> >>>>>> CNA is not currently supported in a VM guest simply because the numa
> >>>>>> information is not reliable. You will have to run it on baremetal to
> >>>>>> test it. Sorry for that.
> >>>>> Correction. There is a command line option to force CNA lock to be used
> >>>>> in a VM. Use the "numa_spinlock=on" boot command line parameter.
> >>>> As I understand it, I need to use a series of -numa arguments to qemu
> >>>> combined with the numa_spinlock=on (or =1) on the kernel command line.
> >>>> If the kernel thinks that there is only one NUMA node, it appears to
> >>>> avoid doing CNA.
> >>>>
> >>>> Correct?
> >>>>
> >>>> 							Thanx, Paul
> >>>>
> >>> In auto-detection mode (the default), CNA will only be turned on when
> >>> paravirt qspinlock is not enabled first and there are at least 2 numa
> >>> nodes. The "numa_spinlock=on" option will force it on even when both of
> >>> the above conditions are false.
> >> Hmmm...
> >>
> >> Here is my kernel command line taken from the console log:
> >>
> >> console=ttyS0 locktorture.onoff_interval=0 numa_spinlock=on locktorture.stat_interval=15 locktorture.shutdown_secs=1800 locktorture.verbose=1
> >>
> >> Yet the string "Enabling CNA spinlock" does not appear.
> >>
> >> Ah, idiot here needs to enable CONFIG_NUMA_AWARE_SPINLOCKS in his build.
> >> Trying again with "--kconfig "CONFIG_NUMA_AWARE_SPINLOCKS=y"...
> > And after fixing that, plus adding the other three Kconfig options required
> > to enable this, I really do see "Enabling CNA spinlock" in the console log.
> > Yay!
> >
> > At the end of the 30-minute locktorture exclusive-lock run, I see this:
> >
> > Writes:  Total: 572176565  Max/Min: 54167704/10878216 ???  Fail: 0
> >
> > This is about a five-to-one ratio.  Is this expected behavior, given a
> > single NUMA node on a single-socket system with 12 hardware threads?
> Do you mean within the VM, lscpu showed that the system has one node and
> 12 threads per node? If that is the case, it should behave like regular
> qspinlock and be fair.

I mean that I saw this in dmesg, which I believe to be telling me the
same thing as lscpu saying that there is one node, but you tell me!

[    0.007106] No NUMA configuration found
[    0.007107] Faking a node at [mem 0x0000000000000000-0x000000001ffdefff]
[    0.007111] NODE_DATA(0) allocated [mem 0x1ffdb000-0x1ffdefff]
[    0.007126] Zone ranges:
[    0.007127]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.007128]   DMA32    [mem 0x0000000001000000-0x000000001ffdefff]
[    0.007128]   Normal   empty
[    0.007129] Movable zone start for each node
[    0.007129] Early memory node ranges
[    0.007130]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.007132]   node   0: [mem 0x0000000000100000-0x000000001ffdefff]
[    0.007227] Zeroed struct page in unavailable ranges: 98 pages
[    0.007227] Initmem setup node 0 [mem 0x0000000000001000-0x000000001ffdefff]
[    0.007228] On node 0 totalpages: 130941
[    0.007231]   DMA zone: 64 pages used for memmap
[    0.007231]   DMA zone: 21 pages reserved
[    0.007232]   DMA zone: 3998 pages, LIFO batch:0
[    0.007266]   DMA32 zone: 1984 pages used for memmap
[    0.007267]   DMA32 zone: 126943 pages, LIFO batch:31

> > I will try reader-writer lock next.
> >
> > Again, should I be using qemu's -numa command-line option to create nodes?
> > If so, what would be a sane configuration given 12 CPUs and 512MB of
> > memory for the VM?  If not, what is a good way to exercise CNA's NUMA
> > capabilities within a guest OS?
> 
> You can certainly play around with CNA in a VM. However, it is generally
> not recommended to use CNA in a VM unless the VM cpu topology matches
> the host with 1-to-1 vcpu pinning and there is no vcpu overcommit. In
> this case, one may see some performance improvement using CNA by using
> the "numa_spinlock=on" option to explicitly turn it on.

Sorry, but I will not be booting this on bare metal on the systems that
I currently have access to.  No more than I run rcutorture on bare metal
on them, especially not with newly modified variants of RCU.  ;-)

> Because of the shuffling of queue entries, CNA is inherently less fair
> than the regular qspinlock. However, a ratio of 5 seems excessive to me.
> vcpu preemption may be a factor in contributing to this large variation.
> My testing on bare metal only showed a throughput variation within
> 10-20% at most.

OK.  Any guidance on qemu's -numa, or should I just experiment with it?
The latter will take me some time, as I must focus on other things
this week.

Alternatively, would it make sense for you to give it a spin in a VM?
After all, it is entirely possible that I still have some configuration
or another messed up.

							Thanx, Paul
