Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B32A7149252
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2020 01:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgAYAjA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jan 2020 19:39:00 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29044 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729660AbgAYAjA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Jan 2020 19:39:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579912739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gaVYkO70LUTOzuFS15WZNr0COycz0AX51ZXsTP6Rmt8=;
        b=UVP/wIpmTYf/IrjaLDylBCJMy0lygGuHTTLX6FRXZ+jriTc0nD20h39RRsLvXvaEjOd73z
        KO9vhQi9SeOoypnwsGbRQjuJZKffQS75jp21pXOjlTCZs4QIempeVK9uZxghQ4LWe2qR9W
        8SAlfonbbsuz5TsEHWlk1MAT1Lq770I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-odkxcsjgM5ePY3Oi8a2QAQ-1; Fri, 24 Jan 2020 19:38:55 -0500
X-MC-Unique: odkxcsjgM5ePY3Oi8a2QAQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CF51477;
        Sat, 25 Jan 2020 00:38:53 +0000 (UTC)
Received: from llong.remote.csb (ovpn-124-92.rdu2.redhat.com [10.10.124.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF9998CCF6;
        Sat, 25 Jan 2020 00:38:49 +0000 (UTC)
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
 <edc53126-bfe4-5102-d2eb-2332bf3a68e5@redhat.com>
 <D39064BF-6EF3-4C13-B2D1-34C282A20F5E@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <518185c1-c03a-7e8c-9d09-f67e42c9bc82@redhat.com>
Date:   Fri, 24 Jan 2020 19:38:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <D39064BF-6EF3-4C13-B2D1-34C282A20F5E@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/24/20 4:27 PM, Alex Kogan wrote:
>
>> On Jan 24, 2020, at 4:12 PM, Waiman Long <longman@redhat.com> wrote:
>>
>> On 1/24/20 3:09 PM, Alex Kogan wrote:
>>>>> We also probably do not want those =E2=80=9Cprioritized=E2=80=9D th=
reads to disrupt
>>>>> normal
>>>>> CNA operation. E.g., if the main queue looks like T1_1, P2_1, T1_2,
>>>>> =E2=80=A6, where
>>>>> T1_x is a thread running on node 1 and P2_1 is a prioritized thread
>>>>> running
>>>>> on node 2, we want to pass the lock from T1_1 to P2_1 and then to T=
1_2
>>>>> (rather than have P2_1 to scan for another thread on node 2).
>>>>>
>>>>> There is a way to achieve that =E2=80=94 when we pass the lock to P=
2_1,
>>>>> we can set its numa node field to 1. This means that we need to
>>>>> reset the numa
>>>>> node field in cna_init_node(), but AFAICT this is relatively cheap.
>>>>> The rest
>>>>> of the CNA logic should not change.
>>>> I won't recommend doing that. If the lock cacheline has been moved
>>>> from node 1 to 2, I will say it is better to stick with node 2 rathe=
r
>>>> than switching back to node 1. That will mean that the secondary
>>>> queue may contain lock waiters from the same nodes, but they will
>>>> eventually be flushed back to the primary queue.
>>>>
>>> That=E2=80=99s right, assuming we do not reset intra_node count when
>>> transferring the
>>> lock to a prioritized thread from another node. Otherwise, we may sta=
rve
>>> waiters in the secondary queue.=20
>>>
>>> Still, that can make the lock even less fair to non-prioritized
>>> threads. When
>>> you flush the secondary queue, the preference may remain with the sam=
e
>>> node. This will not happen in the current form of CNA, as we never ge=
t=20
>>> threads from the preferred node in the secondary queue.
>> That is true.
>>
>> However, it is no different from the current scheme that a waiter from
>> another node may have to wait for 64k other waiters to go first before
>> it has a chance to get it. Now that waiter can be from the same node a=
s
>> well.
> The difference is that in the current form of CNA, the preferred node _=
will
> change after 64k lock transitions. In the change you propose, this is n=
o
> longer the case. It may take another ~64k transitions for that to happe=
n.
> More generally, I think this makes the analysis of the lock behavior mo=
re
> convoluted.
>
> I think we should treat those prioritized threads as =E2=80=9Cwild=E2=80=
=9D cards, passing the=20
> lock through them, but keeping the preferred node intact. This will pot=
entially
> cost one extra lock migration, but will make reasoning about the lock
> behavior easier.

It seems like you prefer mathematical purity than practical
consideration. I won't object to that if you insist that is the right
way to go. Just be mindful that you may need to add a preferred node
value to do that. It will also complicate the code, but it is your choice=
.

Cheers,
Longman

