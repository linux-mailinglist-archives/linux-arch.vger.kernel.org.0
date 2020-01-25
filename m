Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E56DE14935D
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2020 05:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgAYE6q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jan 2020 23:58:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:56164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgAYE6p (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Jan 2020 23:58:45 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32D382075E;
        Sat, 25 Jan 2020 04:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579928325;
        bh=se8AI+drmz8YaJ/8zhHySxcdJx3cDLiDs/OjJa17Oco=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kWYruwuKFzmpVprbEiv42WnO1l8hPIhsYJNU87fNFTiwlnIhfPi7wZUzk+7FyHg0t
         vre9xtm/9e6IgK94Oz2vMRqqCgXVwRQ4V4L2CGyHGqPTraGzKuAiCjU3yHAP7L0KoH
         hFfWTERFAbBf41FQBHKC55IS0rkQ66hdbmergH+g=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 04EDD352018E; Fri, 24 Jan 2020 20:58:45 -0800 (PST)
Date:   Fri, 24 Jan 2020 20:58:45 -0800
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
Message-ID: <20200125045844.GC2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <20200124222434.GA7196@paulmck-ThinkPad-P72>
 <6AAE7FC6-F5DE-4067-8BC4-77F27948CD09@oracle.com>
 <20200125005713.GZ2935@paulmck-ThinkPad-P72>
 <02defadb-217d-7803-88a1-ec72a37eda28@redhat.com>
 <adb4fb09-f374-4d64-096b-ba9ad8b35fd5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adb4fb09-f374-4d64-096b-ba9ad8b35fd5@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 24, 2020 at 09:17:05PM -0500, Waiman Long wrote:
> On 1/24/20 8:59 PM, Waiman Long wrote:
> >> You called it!  I will play with QEMU's -numa argument to see if I can get
> >> CNA to run for me.  Please accept my apologies for the false alarm.
> >>
> >> 							Thanx, Paul
> >>
> > CNA is not currently supported in a VM guest simply because the numa
> > information is not reliable. You will have to run it on baremetal to
> > test it. Sorry for that.
> 
> Correction. There is a command line option to force CNA lock to be used
> in a VM. Use the "numa_spinlock=on" boot command line parameter.

As I understand it, I need to use a series of -numa arguments to qemu
combined with the numa_spinlock=on (or =1) on the kernel command line.
If the kernel thinks that there is only one NUMA node, it appears to
avoid doing CNA.

Correct?

							Thanx, Paul
