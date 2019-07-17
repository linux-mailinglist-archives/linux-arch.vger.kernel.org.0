Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6EF6C0B5
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2019 19:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbfGQR6q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Jul 2019 13:58:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfGQR6q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Jul 2019 13:58:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 43EDD307D933;
        Wed, 17 Jul 2019 17:58:45 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 576405B689;
        Wed, 17 Jul 2019 17:58:41 +0000 (UTC)
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, dave.dice@oracle.com,
        rahul.x.yadav@oracle.com
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
 <77bba626-f3e6-45a8-aae8-43b945d0fab9@redhat.com>
 <aa73b86d-902a-bb6f-d372-8645c8299a6d@redhat.com>
 <C1C55A40-FDB1-43B5-B551-F9B8BE776DF8@oracle.com>
 <2a7a3ea8-7a94-52d4-b8ef-581de28e0063@redhat.com>
 <10197432-47E5-49D7-AD68-8A412782012B@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <76d70284-dd6b-009c-710c-cc97bac8146f@redhat.com>
Date:   Wed, 17 Jul 2019 13:58:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <10197432-47E5-49D7-AD68-8A412782012B@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 17 Jul 2019 17:58:45 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/17/19 1:44 PM, Alex Kogan wrote:
>> On Jul 16, 2019, at 10:50 AM, Waiman Long <longman@redhat.com> wrote:
>>
>> On 7/16/19 10:29 AM, Alex Kogan wrote:
>>>> On Jul 15, 2019, at 7:22 PM, Waiman Long <longman@redhat.com
>>>> <mailto:longman@redhat.com>> wrote:
>>>>
>>>> On 7/15/19 5:30 PM, Waiman Long wrote:
>>>>>> -#ifndef _GEN_PV_LOCK_SLOWPATH
>>>>>> +#if !defined(_GEN_PV_LOCK_SLOWPATH) && !defined(_GEN_CNA_LOCK_SLOWPATH)
>>>>>>
>>>>>> #include <linux/smp.h>
>>>>>> #include <linux/bug.h>
>>>>>> @@ -77,18 +77,14 @@
>>>>>> #define MAX_NODES	4
>>>>>>
>>>>>> /*
>>>>>> - * On 64-bit architectures, the mcs_spinlock structure will be 16 bytes in
>>>>>> - * size and four of them will fit nicely in one 64-byte cacheline. For
>>>>>> - * pvqspinlock, however, we need more space for extra data. To accommodate
>>>>>> - * that, we insert two more long words to pad it up to 32 bytes. IOW, only
>>>>>> - * two of them can fit in a cacheline in this case. That is OK as it is rare
>>>>>> - * to have more than 2 levels of slowpath nesting in actual use. We don't
>>>>>> - * want to penalize pvqspinlocks to optimize for a rare case in native
>>>>>> - * qspinlocks.
>>>>>> + * On 64-bit architectures, the mcs_spinlock structure will be 20 bytes in
>>>>>> + * size. For pvqspinlock or the NUMA-aware variant, however, we need more
>>>>>> + * space for extra data. To accommodate that, we insert two more long words
>>>>>> + * to pad it up to 36 bytes.
>>>>>> */
>>>>> The 20 bytes figure is wrong. It is actually 24 bytes for 64-bit as the
>>>>> mcs_spinlock structure is 8-byte aligned. For better cacheline
>>>>> alignment, I will like to keep mcs_spinlock to 16 bytes as before.
>>>>> Instead, you can use encode_tail() to store the CNA node pointer in
>>>>> "locked". For instance, use (encode_tail() << 1) in locked to
>>>>> distinguish it from the regular locked=1 value.
>>>> Actually, the encoded tail value is already shift left either 16 bits
>>>> or 9 bits. So there is no need to shift it. You can assigned it directly:
>>>>
>>>> mcs->locked = cna->encoded_tail;
>>>>
>>>> You do need to change the type of locked to "unsigned int", though,
>>>> for proper comparison with "1".
>>>>
>>> Got it, thanks.
>>>
>> I forgot to mention that I would like to see a boot command line option
>> to force off and maybe on as well the numa qspinlock code. This can help
>> in testing as you don't need to build 2 separate kernels, one with
>> NUMA_AWARE_SPINLOCKS on and one with it off.
> IIUC it should be easy to add a boot option to force off the NUMA-aware spinlock 
> even if it is enabled though config, but the other way around would require 
> compiling in the NUMA-aware spinlock stuff even if the config option is disabled.
> Is that ok?

That is not what I am looking for. If the config option is disabled, the
boot command line option is disabled also. For the on case, one possible
usage scenario is with a VM guest where all the vcpus are pinned to a
physical CPUs with no over-commit and correct numa information. In that
case, one may want to use numa-qspinlock instead of pv-qspinlock.

> Also, what should the option name be?
> "numa_spinlock=on/off” if we want both ways, or “no_numa_spinlock" if we want just the “force off” option?

I think "numa_spinlock=on/off" will be good. The default is "auto" where
it will be turned on when there is more than one numa nodes in the system.

>> For small 2-socket systems,
>> numa qspinlock may not help much.
> It actually helps quite a bit (e.g., speedup of up to 42-57% for will-it-scale on a dual-socket x86 system).
> We have numbers and plots in our paper on arxiv.

I am talking about older 2-socket systems where each socket may have
just a few cpus. Also some Intel CPU can be configured to have 2 numa
nodes per socket. For AMD EPYC, it can be configured to have 4 numa
nodes per socket.

Cheers,
Longman


