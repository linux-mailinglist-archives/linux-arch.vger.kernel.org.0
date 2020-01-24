Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2573148A2F
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2020 15:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgAXOnJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jan 2020 09:43:09 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36275 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729527AbgAXOnI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Jan 2020 09:43:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579876988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9l6POn3eu1T5wYGvqIrxXu86ud4cnXxoH7SZuURfrZw=;
        b=BM65m3LyBYV97o3I8XEp4Zpt4hoEb/Fx0RssAf8yQFDdcWiFPVL6N7411M9X1Nqn4HQwAV
        s3qrbEIJW3X90F0KPbLaPupjYmCCOh2PLq1bvVyqKVoT2E6EaH5ztn8HVniQ7z6FBR1rlD
        EiL9oHE+Sl49gLC9vU88YwfwhAybtsE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-NZHuf-WlOACiaqvI3HcN3A-1; Fri, 24 Jan 2020 09:43:03 -0500
X-MC-Unique: NZHuf-WlOACiaqvI3HcN3A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DAB4800D5B;
        Fri, 24 Jan 2020 14:42:48 +0000 (UTC)
Received: from llong.remote.csb (ovpn-124-92.rdu2.redhat.com [10.10.124.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 445F919C69;
        Fri, 24 Jan 2020 14:42:42 +0000 (UTC)
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
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20191230194042.67789-5-alex.kogan@oracle.com>
 <20200121132949.GL14914@hirez.programming.kicks-ass.net>
 <cfdf635d-be2e-9d4b-c4ca-6bcbddc6868f@redhat.com>
 <3862F8A1-FF9B-40AD-A88E-2C0BA7AF6F58@oracle.com>
 <20200124075235.GX14914@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <2c6741c5-d89d-4b2c-cebe-a7c7f6eed884@redhat.com>
Date:   Fri, 24 Jan 2020 09:42:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200124075235.GX14914@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/24/20 2:52 AM, Peter Zijlstra wrote:
> On Thu, Jan 23, 2020 at 04:33:54PM -0500, Alex Kogan wrote:
>> Let me put this question to you. What do you think the number should be?
> I think it would be very good to keep the inter-node latency below 1ms.
It is hard to guarantee that given that lock hold times can vary quite a
lot depending on the workload. What we can control is just how many
later lock waiters can jump ahead before a given waiter.
> But to realize that we need data on the lock hold times. Specifically
> for the heavily contended locks that make CNA worth it in the first
> place.
>
> I don't see that data, so I don't see how we can argue about this let
> alone call something reasonable.
>
In essence, CNA lock is for improving throughput on NUMA machines at the
expense of increasing worst case latency. If low latency is important,
it should be disabled. If CONFIG_PREEMPT_RT is on,
CONFIG_NUMA_AWARE_SPINLOCKS should be off.

Cheers,
Longman

