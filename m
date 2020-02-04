Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE97151F9A
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2020 18:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgBDRjm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Feb 2020 12:39:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31571 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727382AbgBDRjl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Feb 2020 12:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580837980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rOt4Q7Y7NbeoLNOkgoGRXQ71dvuW8UbbyvbNZ5N5pIs=;
        b=ZTT4euUxQFSfDdi3c8c41iSYOcu+7LTkiq73G4oEfGYSeAWmftOVJe207XU6xaUcH/TZX0
        61sM6VuAQ0c6x+luBqa9xZeO+Spb3YviSKctmqNF1XtVVs/7/Vd1XNOGGCVp5J/lcTsMD9
        K5oA8wnCUzXMJkpL7Hsqso+4XTd4KUw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-RFdFYVoNOtmfFcl0m6Qxsg-1; Tue, 04 Feb 2020 12:39:36 -0500
X-MC-Unique: RFdFYVoNOtmfFcl0m6Qxsg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE0AADB25;
        Tue,  4 Feb 2020 17:39:33 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 17A5660BF4;
        Tue,  4 Feb 2020 17:39:30 +0000 (UTC)
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
To:     Peter Zijlstra <peterz@infradead.org>,
        Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, Ingo Molnar <mingo@redhat.com>,
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
References: <8D3AFB47-B595-418C-9568-08780DDC58FF@oracle.com>
 <714892cd-d96f-4d41-ae8b-d7b7642a6e3c@redhat.com>
 <1669BFDE-A1A5-4ED8-B586-035460BBF68A@oracle.com>
 <20200125111931.GW11457@worktop.programming.kicks-ass.net>
 <F32558D8-4ACB-483A-AB4C-F565003A02E7@oracle.com>
 <20200203134540.GA14879@hirez.programming.kicks-ass.net>
 <6d11b22b-2fb5-7dea-f88b-b32f1576a5e0@redhat.com>
 <20200203152807.GK14914@hirez.programming.kicks-ass.net>
 <15fa978d-bd41-3ecb-83d5-896187e11244@redhat.com>
 <83762715-F68C-42DF-9B41-C4C48DF6762F@oracle.com>
 <20200204172758.GF14879@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <e26b3afa-80d6-71bf-39c8-0fa4b875cbb2@redhat.com>
Date:   Tue, 4 Feb 2020 12:39:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200204172758.GF14879@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/4/20 12:27 PM, Peter Zijlstra wrote:
> On Tue, Feb 04, 2020 at 11:54:02AM -0500, Alex Kogan wrote:
>>> On Feb 3, 2020, at 10:47 AM, Waiman Long <longman@redhat.com> wrote:
>>>
>>> On 2/3/20 10:28 AM, Peter Zijlstra wrote:
>>>> On Mon, Feb 03, 2020 at 09:59:12AM -0500, Waiman Long wrote:
>>>>> On 2/3/20 8:45 AM, Peter Zijlstra wrote:
>>>>>> Presumably you have a workload where CNA is actually a win? That i=
s,
>>>>>> what inspired you to go down this road? Which actual kernel lock i=
s so
>>>>>> contended on NUMA machines that we need to do this?
>> There are quite a few actually. files_struct.file_lock, file_lock_cont=
ext.flc_lock
>> and lockref.lock are some concrete examples that get very hot in will-=
it-scale
>> benchmarks.=20
> Right, that's all a variant of banging on the same resources across
> nodes. I'm not sure there's anything fundamental we can fix there.
>
>> And then there are spinlocks in __futex_data.queues,=20
>> which get hot when applications have contended (pthread) locks =E2=80=94=
=20
>> LevelDB is an example.
> A numa aware rework of futexes has been on the todo list for years :/
Now, we are going to get that for free with this patchset:-)
>
>> Our initial motivation was based on an observation that kernel qspinlo=
ck is not=20
>> NUMA-aware. So what, you may ask. Much like people realized in the pas=
t that
>> global spinning is bad for performance, and they switched from ticket =
lock to
>> locks with local spinning (e.g., MCS), I think everyone would agree th=
ese days that
>> bouncing a lock (and cache lines in general) across numa nodes is simi=
larly bad.
>> And as CNA demonstrates, we are easily leaving 2-3x speedups on the ta=
ble by
>> doing just that with the current qspinlock.
> Actual benchmarks with performance numbers are required. It helps
> motivate the patches as well as gives reviewers clues on how to
> reproduce / inspect the claims made.
>
I think the cover-letter does have some benchmark results listed.=C2=A0 A=
re
you saying that some benchmark results should be put into individual
patches themselves?

Cheers,
Longman

