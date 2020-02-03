Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F122D150A27
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2020 16:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgBCPr3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Feb 2020 10:47:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33872 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728034AbgBCPr3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Feb 2020 10:47:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580744848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hXZe6FEUmH9hjk4hufHYUU+BgVLORNyZ1sbApPlRBeU=;
        b=bl/tRYssUdg7HivggzHPDcQhHyrqcqrFaSUFeXoTVyswe03h/bmlft9uYdD1absZYmW0Ro
        5tvP8ySKZXoyvsS10lKIrl7q8iJT4Zx8srWkg9CO5tlKGiIC69TtZ6mMmWvvVVwxwzInaR
        nij/eJKmZSATtk3lnnZz6BqvXUEJiVU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-aeDC1h7MNYCqXuy0WDdweg-1; Mon, 03 Feb 2020 10:47:24 -0500
X-MC-Unique: aeDC1h7MNYCqXuy0WDdweg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5959D800D4E;
        Mon,  3 Feb 2020 15:47:21 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 095D55C1B5;
        Mon,  3 Feb 2020 15:47:15 +0000 (UTC)
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
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
References: <20200124075235.GX14914@hirez.programming.kicks-ass.net>
 <2c6741c5-d89d-4b2c-cebe-a7c7f6eed884@redhat.com>
 <48ce49e5-98a7-23cd-09f4-8290a65abbb5@redhat.com>
 <8D3AFB47-B595-418C-9568-08780DDC58FF@oracle.com>
 <714892cd-d96f-4d41-ae8b-d7b7642a6e3c@redhat.com>
 <1669BFDE-A1A5-4ED8-B586-035460BBF68A@oracle.com>
 <20200125111931.GW11457@worktop.programming.kicks-ass.net>
 <F32558D8-4ACB-483A-AB4C-F565003A02E7@oracle.com>
 <20200203134540.GA14879@hirez.programming.kicks-ass.net>
 <6d11b22b-2fb5-7dea-f88b-b32f1576a5e0@redhat.com>
 <20200203152807.GK14914@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <15fa978d-bd41-3ecb-83d5-896187e11244@redhat.com>
Date:   Mon, 3 Feb 2020 10:47:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200203152807.GK14914@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/3/20 10:28 AM, Peter Zijlstra wrote:
> On Mon, Feb 03, 2020 at 09:59:12AM -0500, Waiman Long wrote:
>> On 2/3/20 8:45 AM, Peter Zijlstra wrote:
>>> Presumably you have a workload where CNA is actually a win? That is,
>>> what inspired you to go down this road? Which actual kernel lock is so
>>> contended on NUMA machines that we need to do this?
>> Today, a 2-socket Rome server can have 128 cores and 256 threads. If we
>> scale up more, we could easily have more than 1000 threads in a system.
>> With that many logical cpus available, it is easy to envision some heavy
>> spinlock contention can happen fairly regularly. This patch can
>> alleviate the congestion and improve performance under that
>> circumstance. Of course, the specific locks that are contended will
>> depend on the workloads.
> Not the point. If there isn't an issue today, we don't have anything to
> fix.
>
> Furthermore, we've always adressed specific issues by looking at the
> locking granularity, first.

You are right in that. Unlike ticket spinlock where performance can drop
precipitately over a cliff when there is heavy contention, qspinlock
won't have this kind of performance drop. My suspicion is that slowdowns
caused by heavy spinlock contention in actual workloads are likely to be
more transient in nature and harder to pinpoint. These days, I seldom
get bug report that is related to heavy spinlock contention.

>
> So again, what specific lock inspired all these patches?
>
Maybe Alex has some data to share.

Cheers,
Longman

