Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB7F14A5C8
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2020 15:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgA0OLz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jan 2020 09:11:55 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30728 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726029AbgA0OLz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Jan 2020 09:11:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580134313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kh2pcEVP2+3UdtdW1VSYX4yZOf7ucW5oyPwHUzLPaSA=;
        b=F1Vk4cl5xGcb9Ie99jZKUBNMZNO2fXXJewCO57C2tE3zvH8pXPkzWOBA+4JyUmBCnE7Dzf
        DgPopo+tndTeo298Y/+oYwCeQg4PU2hxfnbjnd6Jj+R5s7sY4scEuD+qSFLuwWf/YvA2ya
        nMU6TqYt2GRBv0ypSiaaJAkP/nEZ5bI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-Ae2NuINDN5iB58AHVSPbbA-1; Mon, 27 Jan 2020 09:11:49 -0500
X-MC-Unique: Ae2NuINDN5iB58AHVSPbbA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFBF21005510;
        Mon, 27 Jan 2020 14:11:46 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E227C1001B2D;
        Mon, 27 Jan 2020 14:11:43 +0000 (UTC)
Subject: Re: [PATCH v9 0/5] Add NUMA-awareness to qspinlock
To:     paulmck@kernel.org
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
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <2e552fad-79c0-ec06-3b8c-d13f1b67f57d@redhat.com>
Date:   Mon, 27 Jan 2020 09:11:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200126224245.GA22901@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/26/20 5:42 PM, Paul E. McKenney wrote:
> On Sun, Jan 26, 2020 at 07:35:35AM -0800, Paul E. McKenney wrote:
>> On Sat, Jan 25, 2020 at 02:41:39PM -0500, Waiman Long wrote:
>>> On 1/24/20 11:58 PM, Paul E. McKenney wrote:
>>>> On Fri, Jan 24, 2020 at 09:17:05PM -0500, Waiman Long wrote:
>>>>> On 1/24/20 8:59 PM, Waiman Long wrote:
>>>>>>> You called it!  I will play with QEMU's -numa argument to see if I can get
>>>>>>> CNA to run for me.  Please accept my apologies for the false alarm.
>>>>>>>
>>>>>>> 							Thanx, Paul
>>>>>>>
>>>>>> CNA is not currently supported in a VM guest simply because the numa
>>>>>> information is not reliable. You will have to run it on baremetal to
>>>>>> test it. Sorry for that.
>>>>> Correction. There is a command line option to force CNA lock to be used
>>>>> in a VM. Use the "numa_spinlock=on" boot command line parameter.
>>>> As I understand it, I need to use a series of -numa arguments to qemu
>>>> combined with the numa_spinlock=on (or =1) on the kernel command line.
>>>> If the kernel thinks that there is only one NUMA node, it appears to
>>>> avoid doing CNA.
>>>>
>>>> Correct?
>>>>
>>>> 							Thanx, Paul
>>>>
>>> In auto-detection mode (the default), CNA will only be turned on when
>>> paravirt qspinlock is not enabled first and there are at least 2 numa
>>> nodes. The "numa_spinlock=on" option will force it on even when both of
>>> the above conditions are false.
>> Hmmm...
>>
>> Here is my kernel command line taken from the console log:
>>
>> console=ttyS0 locktorture.onoff_interval=0 numa_spinlock=on locktorture.stat_interval=15 locktorture.shutdown_secs=1800 locktorture.verbose=1
>>
>> Yet the string "Enabling CNA spinlock" does not appear.
>>
>> Ah, idiot here needs to enable CONFIG_NUMA_AWARE_SPINLOCKS in his build.
>> Trying again with "--kconfig "CONFIG_NUMA_AWARE_SPINLOCKS=y"...
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
Do you mean within the VM, lscpu showed that the system has one node and
12 threads per node? If that is the case, it should behave like regular
qspinlock and be fair.
>
> I will try reader-writer lock next.
>
> Again, should I be using qemu's -numa command-line option to create nodes?
> If so, what would be a sane configuration given 12 CPUs and 512MB of
> memory for the VM?  If not, what is a good way to exercise CNA's NUMA
> capabilities within a guest OS?

You can certainly play around with CNA in a VM. However, it is generally
not recommended to use CNA in a VM unless the VM cpu topology matches
the host with 1-to-1 vcpu pinning and there is no vcpu overcommit. In
this case, one may see some performance improvement using CNA by using
the "numa_spinlock=on" option to explicitly turn it on.

Because of the shuffling of queue entries, CNA is inherently less fair
than the regular qspinlock. However, a ratio of 5 seems excessive to me.
vcpu preemption may be a factor in contributing to this large variation.
My testing on bare metal only showed a throughput variation within
10-20% at most.

Cheers,
Longman

