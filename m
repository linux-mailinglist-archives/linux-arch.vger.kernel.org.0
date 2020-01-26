Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BED65149B6F
	for <lists+linux-arch@lfdr.de>; Sun, 26 Jan 2020 16:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgAZPfh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 Jan 2020 10:35:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:57562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbgAZPfg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 26 Jan 2020 10:35:36 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EAA12071A;
        Sun, 26 Jan 2020 15:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580052936;
        bh=wNZuYpHo/oqB810XSYgXonQ7QrqECablZ/abB2+Rxq4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eBkcLRR/OVOxK9jF4dAE0VVVJJGuBwoL10Xxa8stXLh38IkJ21JBqYg4pSeBn/9OX
         Kyf360tAyg43NBsr4G3IyY4D1KKiLXCcEc6kEPqhho9c6c9w9xOMb7y1xEH2f+v4v2
         FEuL2in2eYunSEnck9fUMP3oOGi950PTouWTQZx0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 070B7352277B; Sun, 26 Jan 2020 07:35:36 -0800 (PST)
Date:   Sun, 26 Jan 2020 07:35:36 -0800
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
Message-ID: <20200126153535.GL2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <20200124222434.GA7196@paulmck-ThinkPad-P72>
 <6AAE7FC6-F5DE-4067-8BC4-77F27948CD09@oracle.com>
 <20200125005713.GZ2935@paulmck-ThinkPad-P72>
 <02defadb-217d-7803-88a1-ec72a37eda28@redhat.com>
 <adb4fb09-f374-4d64-096b-ba9ad8b35fd5@redhat.com>
 <20200125045844.GC2935@paulmck-ThinkPad-P72>
 <967f99ee-b781-43f4-d8ba-af83786c429c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <967f99ee-b781-43f4-d8ba-af83786c429c@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 25, 2020 at 02:41:39PM -0500, Waiman Long wrote:
> On 1/24/20 11:58 PM, Paul E. McKenney wrote:
> > On Fri, Jan 24, 2020 at 09:17:05PM -0500, Waiman Long wrote:
> >> On 1/24/20 8:59 PM, Waiman Long wrote:
> >>>> You called it!  I will play with QEMU's -numa argument to see if I can get
> >>>> CNA to run for me.  Please accept my apologies for the false alarm.
> >>>>
> >>>> 							Thanx, Paul
> >>>>
> >>> CNA is not currently supported in a VM guest simply because the numa
> >>> information is not reliable. You will have to run it on baremetal to
> >>> test it. Sorry for that.
> >> Correction. There is a command line option to force CNA lock to be used
> >> in a VM. Use the "numa_spinlock=on" boot command line parameter.
> > As I understand it, I need to use a series of -numa arguments to qemu
> > combined with the numa_spinlock=on (or =1) on the kernel command line.
> > If the kernel thinks that there is only one NUMA node, it appears to
> > avoid doing CNA.
> >
> > Correct?
> >
> > 							Thanx, Paul
> >
> In auto-detection mode (the default), CNA will only be turned on when
> paravirt qspinlock is not enabled first and there are at least 2 numa
> nodes. The "numa_spinlock=on" option will force it on even when both of
> the above conditions are false.

Hmmm...

Here is my kernel command line taken from the console log:

console=ttyS0 locktorture.onoff_interval=0 numa_spinlock=on locktorture.stat_interval=15 locktorture.shutdown_secs=1800 locktorture.verbose=1

Yet the string "Enabling CNA spinlock" does not appear.

Ah, idiot here needs to enable CONFIG_NUMA_AWARE_SPINLOCKS in his build.
Trying again with "--kconfig "CONFIG_NUMA_AWARE_SPINLOCKS=y"...

							Thanx, Paul
