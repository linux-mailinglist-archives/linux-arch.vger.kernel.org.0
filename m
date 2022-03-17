Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8084DC983
	for <lists+linux-arch@lfdr.de>; Thu, 17 Mar 2022 16:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbiCQPFE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Mar 2022 11:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbiCQPFD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Mar 2022 11:05:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B81AF1AF7
        for <linux-arch@vger.kernel.org>; Thu, 17 Mar 2022 08:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647529426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aa1jAvfCIcTnLm2lUoV2mmz4eiiaEOLiyUm5zpRdIXk=;
        b=OA6aotsSJ+ExrNOr9YF3BpuAP7Jz89tcEiuAT130v0jSEhAzptpNnw0Efqer5NAuybOswu
        UzH45R9UhPOwQu2SCY8Cqf8t1K6oFZt3pr7CzNO3kXXlVMctEpLbkuO1MHJXsQWKGcLLQc
        N6zc7eSZc0vsy0eNV9oOKRzLxk5bkL0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-1uKE53VaO8eu6i448SukJw-1; Thu, 17 Mar 2022 11:03:43 -0400
X-MC-Unique: 1uKE53VaO8eu6i448SukJw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0AF02805A30;
        Thu, 17 Mar 2022 15:03:42 +0000 (UTC)
Received: from [10.22.33.180] (unknown [10.22.33.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98BEC401E6F;
        Thu, 17 Mar 2022 15:03:40 +0000 (UTC)
Message-ID: <364c72a9-64ca-592a-510b-d48a963121aa@redhat.com>
Date:   Thu, 17 Mar 2022 11:03:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/5] asm-generic: ticket-lock: New generic ticket-based
 spinlock
Content-Language: en-US
To:     Boqun Feng <boqun.feng@gmail.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, peterz@infradead.org,
        jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        shorne@gmail.com, mingo@redhat.com, Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, jszhang@kernel.org,
        wangkefeng.wang@huawei.com, openrisc@lists.librecores.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20220316232600.20419-1-palmer@rivosinc.com>
 <20220316232600.20419-3-palmer@rivosinc.com>
 <YjM+P32I4fENIqGV@boqun-archlinux>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YjM+P32I4fENIqGV@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/17/22 09:57, Boqun Feng wrote:
> On Wed, Mar 16, 2022 at 04:25:57PM -0700, Palmer Dabbelt wrote:
>> From: Peter Zijlstra <peterz@infradead.org>
>>
>> This is a simple, fair spinlock.  Specifically it doesn't have all the
>> subtle memory model dependencies that qspinlock has, which makes it more
>> suitable for simple systems as it is more likely to be correct.
>>
>> [Palmer: commit text]
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>>
>> --
>>
>> I have specifically not included Peter's SOB on this, as he sent his
>> original patch
>> <https://lore.kernel.org/lkml/YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net/>
>> without one.
>> ---
>>   include/asm-generic/ticket-lock-types.h | 11 ++++
>>   include/asm-generic/ticket-lock.h       | 86 +++++++++++++++++++++++++
>>   2 files changed, 97 insertions(+)
>>   create mode 100644 include/asm-generic/ticket-lock-types.h
>>   create mode 100644 include/asm-generic/ticket-lock.h
>>
>> diff --git a/include/asm-generic/ticket-lock-types.h b/include/asm-generic/ticket-lock-types.h
>> new file mode 100644
>> index 000000000000..829759aedda8
>> --- /dev/null
>> +++ b/include/asm-generic/ticket-lock-types.h
>> @@ -0,0 +1,11 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef __ASM_GENERIC_TICKET_LOCK_TYPES_H
>> +#define __ASM_GENERIC_TICKET_LOCK_TYPES_H
>> +
>> +#include <linux/types.h>
>> +typedef atomic_t arch_spinlock_t;
>> +
>> +#define __ARCH_SPIN_LOCK_UNLOCKED	ATOMIC_INIT(0)
>> +
>> +#endif /* __ASM_GENERIC_TICKET_LOCK_TYPES_H */
>> diff --git a/include/asm-generic/ticket-lock.h b/include/asm-generic/ticket-lock.h
>> new file mode 100644
>> index 000000000000..3f0d53e21a37
>> --- /dev/null
>> +++ b/include/asm-generic/ticket-lock.h
>> @@ -0,0 +1,86 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +/*
>> + * 'Generic' ticket-lock implementation.
>> + *
>> + * It relies on atomic_fetch_add() having well defined forward progress
>> + * guarantees under contention. If your architecture cannot provide this, stick
>> + * to a test-and-set lock.
>> + *
>> + * It also relies on atomic_fetch_add() being safe vs smp_store_release() on a
>> + * sub-word of the value. This is generally true for anything LL/SC although
>> + * you'd be hard pressed to find anything useful in architecture specifications
>> + * about this. If your architecture cannot do this you might be better off with
>> + * a test-and-set.
>> + *
>> + * It further assumes atomic_*_release() + atomic_*_acquire() is RCpc and hence
>> + * uses atomic_fetch_add() which is SC to create an RCsc lock.
>> + *
> Probably it's better to use "fully-ordered" instead of "SC", because our
> atomic documents never use "SC" or "Sequential Consisteny" to describe
> the semantics, further I'm not sure our "fully-ordered" is equivalent to
> SC, better not cause misunderstanding in the future here.

The terms RCpc, RCsc comes from academia. I believe we can keep this but 
add more comment to elaborate what they are and what do they mean for 
the average kernel engineer.

Cheers,
Longman

