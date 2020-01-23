Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76B56146CA3
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 16:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgAWPZV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 10:25:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53756 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729238AbgAWPZV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 10:25:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579793120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2iN/148ydxo6cOEibr7t4o6TqZN00D1PLyEg2aOUAsE=;
        b=N/ImqNQKIivh8OIOEw4MhvodqBsbZzkrCPqydS8TUySwbD7Ee8ehByo58FJg2Fn+tTxyiA
        TSAhk5Khj6yVK8Guv/ZGV0qTxHgrcVDPhno3vRdG0uLLVCVRj4BQr8p8uza17CuUaJZaQ0
        uCdUiW6ssgmFDl1EcdHL4TmcRe08r9w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-3aZizUTBO7aYE8g_rivKQQ-1; Thu, 23 Jan 2020 10:25:16 -0500
X-MC-Unique: 3aZizUTBO7aYE8g_rivKQQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44FDC1005513;
        Thu, 23 Jan 2020 15:25:13 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F3EE610D8;
        Thu, 23 Jan 2020 15:25:08 +0000 (UTC)
Subject: Re: [PATCH v9 0/5] Add NUMA-awareness to qspinlock
To:     Will Deacon <will@kernel.org>
Cc:     Lihao Liang <lihaoliang@google.com>,
        Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com, dave.dice@oracle.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <CAC4j=Y8rCeTX9oKKbh+dCdTP8Ud4hW1ybu+iE7t_nxMSYBOR5w@mail.gmail.com>
 <4e15fa1d-9540-3274-502a-4195a0d46f63@redhat.com>
 <20200123113547.GD18991@willie-the-truck>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <54ba237b-e1db-c14c-7cff-b0be41731ba5@redhat.com>
Date:   Thu, 23 Jan 2020 10:25:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200123113547.GD18991@willie-the-truck>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/23/20 6:35 AM, Will Deacon wrote:
> Hi folks,
>
> (I think Lihao is travelling at the moment, so he may be delayed in his
> replies)
>
> On Wed, Jan 22, 2020 at 12:24:58PM -0500, Waiman Long wrote:
>> On 1/22/20 6:45 AM, Lihao Liang wrote:
>>> On Wed, Jan 22, 2020 at 10:28 AM Alex Kogan <alex.kogan@oracle.com> wrote:
>>>> Summary
>>>> -------
>>>>
>>>> Lock throughput can be increased by handing a lock to a waiter on the
>>>> same NUMA node as the lock holder, provided care is taken to avoid
>>>> starvation of waiters on other NUMA nodes. This patch introduces CNA
>>>> (compact NUMA-aware lock) as the slow path for qspinlock. It is
>>>> enabled through a configuration option (NUMA_AWARE_SPINLOCKS).
>>>>
>>> Thanks for your patches. The experimental results look promising!
>>>
>>> I understand that the new CNA qspinlock uses randomization to achieve
>>> long-term fairness, and provides the numa_spinlock_threshold parameter
>>> for users to tune. As Linux runs extremely diverse workloads, it is not
>>> clear how randomization affects its fairness, and how users with
>>> different requirements are supposed to tune this parameter.
>>>
>>> To this end, Will and I consider it beneficial to be able to answer the
>>> following question:
>>>
>>> With different values of numa_spinlock_threshold and
>>> SHUFFLE_REDUCTION_PROB_ARG, how long do threads running on different
>>> sockets have to wait to acquire the lock? This is particularly relevant
>>> in high contention situations when new threads keep arriving on the same
>>> socket as the lock holder.
>>>
>>> In this email, I try to provide some formal analysis to address this
>>> question. Let's assume the probability for the lock to stay on the
>>> same socket is *at least* p, which corresponds to the probability for
>>> the function probably(unsigned int num_bits) in the patch to return *false*,
>>> where SHUFFLE_REDUCTION_PROB_ARG is passed as the value of num_bits to the
>>> function.
>> That is not strictly true from my understanding of the code. The
>> probably() function does not come into play if a secondary queue is
>> present. Also calling cna_scan_main_queue() doesn't guarantee that a
>> waiter in the same node can be found. So the simple mathematical
>> analysis isn't that applicable in this case. One will have to do an
>> actual simulation to find out what the actual behavior will be.
> It's certainly true that the analysis is based on the worst-case scenario,
> but I think it's still worth considering. For example, the secondary queue
> does not exist initially so it seems a bit odd that we only instantiate it
> with < 1% probability.
>
> That said, my real concern with any of this is that it makes formal
> modelling and analysis of the qspinlock considerably more challenging. I
> would /really/ like to see an update to the TLA+ model we have of the
> current implementation [1] and preferably also the userspace version I
> hacked together [2] so that we can continue to test and validate changes
> to the code outside of the usual kernel stress-testing.

I do agree that the current CNA code is hard to model. The CNA lock
behaves like a regular qspinlock in many cases. If the lock becomes
fairly contended with waiters from different nodes, it will
opportunistically switch to CNA mode where preference is given to
waiters in the same node.

Cheers,
Longman

