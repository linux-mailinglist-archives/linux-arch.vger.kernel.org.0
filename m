Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 783A0148FEF
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2020 22:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgAXVMl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jan 2020 16:12:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41607 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725767AbgAXVMl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jan 2020 16:12:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579900360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r88FQ3jP4tbWAociS00rg3LER5v2m7ImuFP1hdddwiI=;
        b=PIg2gflQcuvfi4kx1aRZwF4LlegAknhYbI6a++gt3+Mh11psbes0kRk05UOnZ3x3Ns+ent
        HnNj8JAjD4hi0bmPjuqoK5phhS1mXJEUmcZWetQdRNGyP22twwY1dwSA3qd1Uc8xOgeyOf
        IQ9ctWyh1OOf8yPDD5Y9z4zkc3kIkpQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-ZycLx2YZN7We8FdE4kvvzg-1; Fri, 24 Jan 2020 16:12:35 -0500
X-MC-Unique: ZycLx2YZN7We8FdE4kvvzg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B89218017CC;
        Fri, 24 Jan 2020 21:12:32 +0000 (UTC)
Received: from llong.remote.csb (ovpn-124-92.rdu2.redhat.com [10.10.124.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6C20859AA;
        Fri, 24 Jan 2020 21:12:29 +0000 (UTC)
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux@armlinux.org.uk,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, hpa@zytor.com, x86@kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        dave.dice@oracle.com
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20191230194042.67789-5-alex.kogan@oracle.com>
 <20200121132949.GL14914@hirez.programming.kicks-ass.net>
 <cfdf635d-be2e-9d4b-c4ca-6bcbddc6868f@redhat.com>
 <3862F8A1-FF9B-40AD-A88E-2C0BA7AF6F58@oracle.com>
 <20200124075235.GX14914@hirez.programming.kicks-ass.net>
 <2c6741c5-d89d-4b2c-cebe-a7c7f6eed884@redhat.com>
 <48ce49e5-98a7-23cd-09f4-8290a65abbb5@redhat.com>
 <8D3AFB47-B595-418C-9568-08780DDC58FF@oracle.com>
 <714892cd-d96f-4d41-ae8b-d7b7642a6e3c@redhat.com>
 <1669BFDE-A1A5-4ED8-B586-035460BBF68A@oracle.com>
 <45660873-731a-a810-8c57-1a5a19d266b4@redhat.com>
 <693E6287-E37C-4C5D-BE33-B3D813BE505D@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <edc53126-bfe4-5102-d2eb-2332bf3a68e5@redhat.com>
Date:   Fri, 24 Jan 2020 16:12:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <693E6287-E37C-4C5D-BE33-B3D813BE505D@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/24/20 3:09 PM, Alex Kogan wrote:
>>> We also probably do not want those =E2=80=9Cprioritized=E2=80=9D thre=
ads to disrupt
>>> normal
>>> CNA operation. E.g., if the main queue looks like T1_1, P2_1, T1_2,
>>> =E2=80=A6, where
>>> T1_x is a thread running on node 1 and P2_1 is a prioritized thread
>>> running
>>> on node 2, we want to pass the lock from T1_1 to P2_1 and then to T1_=
2
>>> (rather than have P2_1 to scan for another thread on node 2).
>>>
>>> There is a way to achieve that =E2=80=94 when we pass the lock to P2_=
1,
>>> we can set its numa node field to 1. This means that we need to
>>> reset the numa
>>> node field in cna_init_node(), but AFAICT this is relatively cheap.
>>> The rest
>>> of the CNA logic should not change.
>>
>> I won't recommend doing that. If the lock cacheline has been moved
>> from node 1 to 2, I will say it is better to stick with node 2 rather
>> than switching back to node 1. That will mean that the secondary
>> queue may contain lock waiters from the same nodes, but they will
>> eventually be flushed back to the primary queue.
>>
> That=E2=80=99s right, assuming we do not reset intra_node count when
> transferring the
> lock to a prioritized thread from another node. Otherwise, we may starv=
e
> waiters in the secondary queue.=C2=A0
>
> Still, that can make the lock even less fair to non-prioritized
> threads. When
> you flush the secondary queue, the preference may remain with the same
> node. This will not happen in the current form of CNA, as we never get=C2=
=A0
> threads from the preferred node in the secondary queue.

That is true.

However, it is no different from the current scheme that a waiter from
another node may have to wait for 64k other waiters to go first before
it has a chance to get it. Now that waiter can be from the same node as
well.

>
> Besides, I think that will decrease the benefit of CNA, especially if s=
uch
> prioritized threads are frequent, switching the preference from one nod=
e
> to another. But this is something I can evaluate, unless
> there is some fundamental objection to the idea of tweaking the numa
> node of prioritized threads.

Usually the locks used in interrupt context are not that contended to
the point that CNA can kick in. Of course, there are exceptions in some
circumstances and we do not want to introduce additional latency to
their lock waiting time.

Cheers,
Longman

