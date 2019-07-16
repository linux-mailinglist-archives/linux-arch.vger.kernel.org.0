Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E78396AAE2
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2019 16:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387748AbfGPOuN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jul 2019 10:50:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43130 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387637AbfGPOuN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Jul 2019 10:50:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9FDEDC05FBC0;
        Tue, 16 Jul 2019 14:50:12 +0000 (UTC)
Received: from llong.remote.csb (ovpn-122-180.rdu2.redhat.com [10.10.122.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4022D60C4C;
        Tue, 16 Jul 2019 14:50:10 +0000 (UTC)
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
 <77bba626-f3e6-45a8-aae8-43b945d0fab9@redhat.com>
 <aa73b86d-902a-bb6f-d372-8645c8299a6d@redhat.com>
 <C1C55A40-FDB1-43B5-B551-F9B8BE776DF8@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <2a7a3ea8-7a94-52d4-b8ef-581de28e0063@redhat.com>
Date:   Tue, 16 Jul 2019 10:50:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <C1C55A40-FDB1-43B5-B551-F9B8BE776DF8@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 16 Jul 2019 14:50:13 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/16/19 10:29 AM, Alex Kogan wrote:
>
>> On Jul 15, 2019, at 7:22 PM, Waiman Long <longman@redhat.com
>> <mailto:longman@redhat.com>> wrote:
>>
>> On 7/15/19 5:30 PM, Waiman Long wrote:
>>>> -#ifndef _GEN_PV_LOCK_SLOWPATH
>>>> +#if !defined(_GEN_PV_LOCK_SLOWPATH) && !defined(_GEN_CNA_LOCK_SLOWPATH)
>>>>  
>>>>  #include <linux/smp.h>
>>>>  #include <linux/bug.h>
>>>> @@ -77,18 +77,14 @@
>>>>  #define MAX_NODES	4
>>>>  
>>>>  /*
>>>> - * On 64-bit architectures, the mcs_spinlock structure will be 16 bytes in
>>>> - * size and four of them will fit nicely in one 64-byte cacheline. For
>>>> - * pvqspinlock, however, we need more space for extra data. To accommodate
>>>> - * that, we insert two more long words to pad it up to 32 bytes. IOW, only
>>>> - * two of them can fit in a cacheline in this case. That is OK as it is rare
>>>> - * to have more than 2 levels of slowpath nesting in actual use. We don't
>>>> - * want to penalize pvqspinlocks to optimize for a rare case in native
>>>> - * qspinlocks.
>>>> + * On 64-bit architectures, the mcs_spinlock structure will be 20 bytes in
>>>> + * size. For pvqspinlock or the NUMA-aware variant, however, we need more
>>>> + * space for extra data. To accommodate that, we insert two more long words
>>>> + * to pad it up to 36 bytes.
>>>>   */
>>> The 20 bytes figure is wrong. It is actually 24 bytes for 64-bit as the
>>> mcs_spinlock structure is 8-byte aligned. For better cacheline
>>> alignment, I will like to keep mcs_spinlock to 16 bytes as before.
>>> Instead, you can use encode_tail() to store the CNA node pointer in
>>> "locked". For instance, use (encode_tail() << 1) in locked to
>>> distinguish it from the regular locked=1 value.
>>
>> Actually, the encoded tail value is already shift left either 16 bits
>> or 9 bits. So there is no need to shift it. You can assigned it directly:
>>
>> mcs->locked = cna->encoded_tail;
>>
>> You do need to change the type of locked to "unsigned int", though,
>> for proper comparison with "1".
>>
> Got it, thanks.
>
I forgot to mention that I would like to see a boot command line option
to force off and maybe on as well the numa qspinlock code. This can help
in testing as you don't need to build 2 separate kernels, one with
NUMA_AWARE_SPINLOCKS on and one with it off. For small 2-socket systems,
numa qspinlock may not help much. So an option to turn it off can be
useful. Xen also have an option to turns off PV qspinlock.

-Longman

