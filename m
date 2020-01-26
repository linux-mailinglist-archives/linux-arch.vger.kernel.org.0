Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74FF4149DC2
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2020 00:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgAZXcY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 Jan 2020 18:32:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:39250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgAZXcY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 26 Jan 2020 18:32:24 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C8172070A;
        Sun, 26 Jan 2020 23:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580081543;
        bh=HLB3DylvqhRZUjuNAimZ9xQIJr3vfYsph79EU+v44AM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XBDbUIra8EdZU3tEIdgh9kjZX2vMcKornjr8VLP0zn2D7JJwzbSoEHbjVKZ9vIEt3
         EEG8uBU/MRC7vnKBSO7cYcbAgFOyH/yPa18UDbEAPWa2KVsP2Ms1QPk3OgBNFV7oVO
         dBJOQaAjjYYAiVP6gNKQgxHEZ1RoKtJk09snvne8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 09B95352279E; Sun, 26 Jan 2020 15:32:23 -0800 (PST)
Date:   Sun, 26 Jan 2020 15:32:23 -0800
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
Message-ID: <20200126233222.GA4840@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <20200124222434.GA7196@paulmck-ThinkPad-P72>
 <6AAE7FC6-F5DE-4067-8BC4-77F27948CD09@oracle.com>
 <20200125005713.GZ2935@paulmck-ThinkPad-P72>
 <02defadb-217d-7803-88a1-ec72a37eda28@redhat.com>
 <adb4fb09-f374-4d64-096b-ba9ad8b35fd5@redhat.com>
 <20200125045844.GC2935@paulmck-ThinkPad-P72>
 <967f99ee-b781-43f4-d8ba-af83786c429c@redhat.com>
 <20200126153535.GL2935@paulmck-ThinkPad-P72>
 <20200126224245.GA22901@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126224245.GA22901@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 26, 2020 at 02:42:45PM -0800, Paul E. McKenney wrote:
> On Sun, Jan 26, 2020 at 07:35:35AM -0800, Paul E. McKenney wrote:
> > On Sat, Jan 25, 2020 at 02:41:39PM -0500, Waiman Long wrote:
> > > On 1/24/20 11:58 PM, Paul E. McKenney wrote:
> > > > On Fri, Jan 24, 2020 at 09:17:05PM -0500, Waiman Long wrote:
> > > >> On 1/24/20 8:59 PM, Waiman Long wrote:
> > > >>>> You called it!  I will play with QEMU's -numa argument to see if I can get
> > > >>>> CNA to run for me.  Please accept my apologies for the false alarm.
> > > >>>>
> > > >>>> 							Thanx, Paul
> > > >>>>
> > > >>> CNA is not currently supported in a VM guest simply because the numa
> > > >>> information is not reliable. You will have to run it on baremetal to
> > > >>> test it. Sorry for that.
> > > >> Correction. There is a command line option to force CNA lock to be used
> > > >> in a VM. Use the "numa_spinlock=on" boot command line parameter.
> > > > As I understand it, I need to use a series of -numa arguments to qemu
> > > > combined with the numa_spinlock=on (or =1) on the kernel command line.
> > > > If the kernel thinks that there is only one NUMA node, it appears to
> > > > avoid doing CNA.
> > > >
> > > > Correct?
> > > >
> > > > 							Thanx, Paul
> > > >
> > > In auto-detection mode (the default), CNA will only be turned on when
> > > paravirt qspinlock is not enabled first and there are at least 2 numa
> > > nodes. The "numa_spinlock=on" option will force it on even when both of
> > > the above conditions are false.
> > 
> > Hmmm...
> > 
> > Here is my kernel command line taken from the console log:
> > 
> > console=ttyS0 locktorture.onoff_interval=0 numa_spinlock=on locktorture.stat_interval=15 locktorture.shutdown_secs=1800 locktorture.verbose=1
> > 
> > Yet the string "Enabling CNA spinlock" does not appear.
> > 
> > Ah, idiot here needs to enable CONFIG_NUMA_AWARE_SPINLOCKS in his build.
> > Trying again with "--kconfig "CONFIG_NUMA_AWARE_SPINLOCKS=y"...
> 
> And after fixing that, plus adding the other three Kconfig options required
> to enable this, I really do see "Enabling CNA spinlock" in the console log.
> Yay!
> 
> At the end of the 30-minute locktorture exclusive-lock run, I see this:
> 
> Writes:  Total: 572176565  Max/Min: 54167704/10878216 ???  Fail: 0
> 
> This is about a five-to-one ratio.  Is this expected behavior, given a
> single NUMA node on a single-socket system with 12 hardware threads?
> 
> I will try reader-writer lock next.
> 
> Again, should I be using qemu's -numa command-line option to create nodes?
> If so, what would be a sane configuration given 12 CPUs and 512MB of
> memory for the VM?  If not, what is a good way to exercise CNA's NUMA
> capabilities within a guest OS?

And the reader-writer lock run also shows "Enabling CNA spinlock".  Same
hardware and same 30-minute duration.

Writes:  Total: 25556912  Max/Min: 3225161/1664621   Fail: 0
Reads :  Total: 11530762  Max/Min: 1155679/794179   Fail: 0

These are both within a factor of two (1.9 and 1.5), hence no "???".

							Thanx, Paul
