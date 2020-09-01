Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E8A259D4C
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 19:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgIARil (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 13:38:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25999 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728297AbgIARik (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 13:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598981918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7AZRZCQ50VQO4CE1EbIlyq9iRI2To5Z5oSxTCQ9Kvv0=;
        b=DdHVFVP0vYcwBzSEjuf7IQaFPkQCacKHaTmnDTi9bWEuusCcyp50hAnD5f+ARQ5C8i/qWR
        ZDq31AU4qQ4wdBMKzmhFB6GVo9qbL4uIlSK89EA/4VsPuWtIg5cM0T2RgQhNRh/XEWpj3T
        w56KTo8yag+4L3kyAttUucahRX1RfHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-kN1KjVNCOh-KAjeBdqpYvA-1; Tue, 01 Sep 2020 13:38:34 -0400
X-MC-Unique: kN1KjVNCOh-KAjeBdqpYvA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1B7D873112;
        Tue,  1 Sep 2020 17:38:31 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-74.rdu2.redhat.com [10.10.118.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE5175D9CD;
        Tue,  1 Sep 2020 17:38:29 +0000 (UTC)
Subject: Re: [PATCH v10 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
References: <20200403205930.1707-1-alex.kogan@oracle.com>
 <20200403205930.1707-4-alex.kogan@oracle.com>
 <a4bf9541-1996-3ba2-dfe5-e734c652ac86@redhat.com>
 <08E77224-563F-49C7-9E7F-BD98E4FD121D@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <84fdb30e-387d-7bc1-e1f9-fa57cd9a32c9@redhat.com>
Date:   Tue, 1 Sep 2020 13:38:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <08E77224-563F-49C7-9E7F-BD98E4FD121D@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/31/20 5:39 PM, Alex Kogan wrote:
>> On Jul 28, 2020, at 4:00 PM, Waiman Long <longman@redhat.com> wrote:
>>
>> On 4/3/20 4:59 PM, Alex Kogan wrote:
>>> In CNA, spinning threads are organized in two queues, a primary queue for
>>> threads running on the same node as the current lock holder, and a
>>> secondary queue for threads running on other nodes. After acquiring the
>>> MCS lock and before acquiring the spinlock, the lock holder scans the
>>> primary queue looking for a thread running on the same node (pre-scan). If
>>> found (call it thread T), all threads in the primary queue between the
>>> current lock holder and T are moved to the end of the secondary queue.
>>> If such T is not found, we make another scan of the primary queue when
>>> unlocking the MCS lock (post-scan), starting at the position where
>>> pre-scan stopped. If both scans fail to find such T, the MCS lock is
>>> passed to the first thread in the secondary queue. If the secondary queue
>>> is empty, the lock is passed to the next thread in the primary queue.
>>> For more details, see https://urldefense.com/v3/__https://arxiv.org/abs/1810.05600__;!!GqivPVa7Brio!OaieLQ3MMZThgxr-Of8i9dbN5CwG8mXSIBJ_sUofhAXcs43IWL2x-stO-XKLEebn$ .
>>>
>>> Note that this variant of CNA may introduce starvation by continuously
>>> passing the lock to threads running on the same node. This issue
>>> will be addressed later in the series.
>>>
>>> Enabling CNA is controlled via a new configuration option
>>> (NUMA_AWARE_SPINLOCKS). By default, the CNA variant is patched in at the
>>> boot time only if we run on a multi-node machine in native environment and
>>> the new config is enabled. (For the time being, the patching requires
>>> CONFIG_PARAVIRT_SPINLOCKS to be enabled as well. However, this should be
>>> resolved once static_call() is available.) This default behavior can be
>>> overridden with the new kernel boot command-line option
>>> "numa_spinlock=on/off" (default is "auto").
>>>
>>> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
>>> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
>>> Reviewed-by: Waiman Long <longman@redhat.com>
>>> ---
>> There is also a concern that the worst case latency for a lock transfer can be close to O(n) which can be quite large for large SMP systems. I have a patch on top that modifies the current behavior to limit the number of node scans after the lock is freed.
> I understand the concern. While your patch addresses it, I am afraid it makes
> the code somewhat more complex, and duplicates some of the slow path
> functionality (e.g., the spin loop until the lock value changes to a certain
> value).
>
> Let me suggest a different idea for gradually restructuring the main queue
> that has some similarity to the way you suggested to handle prioritized waiters.
> Basically, instead of scanning the entire chain of main queue waiters,
> we can check only the next waiter and, if present and it runs on a different
> node, move it to the secondary queue. In addition, to maintain the preference
> for a certain numa node ID, we set the numa node of the next-next waiter,
> if present, to that of the current lock holder. This is the part similar to the
> way you suggested to handle prioritized waiters.
>
> This way, the worst case complexity of cna_order_queue() decreases from O(n)
> down to O(1), as we always “scan" only one waiter. And as before, we change
> the preference (and flush the secondary queue) after X handovers (or after
> Y ms, as in your in other patch).
>
> I attach the patch that applies on top of your patch for prioritized nodes
> (0006), but does not include your patch 0007 (time based threshold),
> which I will integrate into the series in the next revision.
>
> Please, let me know what you think.
>
That is an interesting idea. I don't have any fundamental objection to 
that. I just wonder how it will impact the kind of performance test that 
you ran before. It would be nice to see the performance impact with that 
change.

Cheers,
Longman

