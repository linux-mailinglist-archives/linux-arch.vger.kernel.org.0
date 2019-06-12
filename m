Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6849742A40
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2019 17:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439913AbfFLPF0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jun 2019 11:05:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437202AbfFLPF0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Jun 2019 11:05:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 49BFFC1EB1F5;
        Wed, 12 Jun 2019 15:05:22 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E70E377B;
        Wed, 12 Jun 2019 15:05:17 +0000 (UTC)
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
To:     Alex Kogan <alex.kogan@oracle.com>,
        "liwei (GF)" <liwei391@huawei.com>
Cc:     linux@armlinux.org.uk, Peter Zijlstra <peterz@infradead.org>,
        mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, dave.dice@oracle.com,
        Rahul Yadav <rahul.x.yadav@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <cc3eee8c-5212-7af5-c932-897ab8f3f8bf@huawei.com>
 <54241445-458C-4AE2-840B-6DFCCD410399@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <a52a5e25-2b71-b6d9-3fa1-fb43bae1cbc1@redhat.com>
Date:   Wed, 12 Jun 2019 11:05:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <54241445-458C-4AE2-840B-6DFCCD410399@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 12 Jun 2019 15:05:26 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/12/19 12:38 AM, Alex Kogan wrote:
> Hi, Wei.
>
>> On Jun 11, 2019, at 12:22 AM, liwei (GF) <liwei391@huawei.com> wrote:
>>
>> Hi Alex,
>>
>> On 2019/3/29 23:20, Alex Kogan wrote:
>>> In CNA, spinning threads are organized in two queues, a main queue for
>>> threads running on the same node as the current lock holder, and a
>>> secondary queue for threads running on other nodes. At the unlock time,
>>> the lock holder scans the main queue looking for a thread running on
>>> the same node. If found (call it thread T), all threads in the main queue
>>> between the current lock holder and T are moved to the end of the
>>> secondary queue, and the lock is passed to T. If such T is not found, the
>>> lock is passed to the first node in the secondary queue. Finally, if the
>>> secondary queue is empty, the lock is passed to the next thread in the
>>> main queue. For more details, see https://urldefense.proofpoint.com/v2/url?u=https-3A__arxiv.org_abs_1810.05600&d=DwICbg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=Hvhk3F4omdCk-GE1PTOm3Kn0A7ApWOZ2aZLTuVxFK4k&m=U7mfTbYj1r2Te2BBUUNbVrRPuTa_ujlpR4GZfUsrGTM&s=Dw4O1EniF-nde4fp6RA9ISlSMOjWuqeR9OS1G0iauj0&e=.
>>>
>>> Note that this variant of CNA may introduce starvation by continuously
>>> passing the lock to threads running on the same node. This issue
>>> will be addressed later in the series.
>>>
>>> Enabling CNA is controlled via a new configuration option
>>> (NUMA_AWARE_SPINLOCKS), which is enabled by default if NUMA is enabled.
>>>
>>> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
>>> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>> arch/x86/Kconfig                      |  14 +++
>>> include/asm-generic/qspinlock_types.h |  13 +++
>>> kernel/locking/mcs_spinlock.h         |  10 ++
>>> kernel/locking/qspinlock.c            |  29 +++++-
>>> kernel/locking/qspinlock_cna.h        | 173 ++++++++++++++++++++++++++++++++++
>>> 5 files changed, 236 insertions(+), 3 deletions(-)
>>> create mode 100644 kernel/locking/qspinlock_cna.h
>>>
>> (SNIP)
>>> +
>>> +static __always_inline int get_node_index(struct mcs_spinlock *node)
>>> +{
>>> +	return decode_count(node->node_and_count++);
>> When nesting level is > 4, it won't return a index >= 4 here and the numa node number
>> is changed by mistake. It will go into a wrong way instead of the following branch.
>>
>>
>> 	/*
>> 	 * 4 nodes are allocated based on the assumption that there will
>> 	 * not be nested NMIs taking spinlocks. That may not be true in
>> 	 * some architectures even though the chance of needing more than
>> 	 * 4 nodes will still be extremely unlikely. When that happens,
>> 	 * we fall back to spinning on the lock directly without using
>> 	 * any MCS node. This is not the most elegant solution, but is
>> 	 * simple enough.
>> 	 */
>> 	if (unlikely(idx >= MAX_NODES)) {
>> 		while (!queued_spin_trylock(lock))
>> 			cpu_relax();
>> 		goto release;
>> 	}
> Good point.
> This patch does not handle count overflows gracefully.
> It can be easily fixed by allocating more bits for the count — we don’t really need 30 bits for #NUMA nodes.

Actually, the default setting uses 2 bits for 4-level nesting and 14
bits for cpu numbers. That means it can support up to 16k-1 cpus. It is
a limit that is likely to be exceeded in the foreseeable future.
qspinlock also supports an additional mode with 21 bits used for cpu
numbers. That can support up to 2M-1 cpus. However, this mode will be a
little bit slower. That is why we don't want to use more than 2 bits for
nesting as I have never see more than 2 level of nesting used in my
testing. So it is highly unlikely we will ever hit more than 4 levels. I
am not saying that it is impossible, though.

Cheers,
Longman

