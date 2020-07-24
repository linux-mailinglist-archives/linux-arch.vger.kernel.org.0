Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0EC22CE7F
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 21:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgGXTLJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jul 2020 15:11:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53358 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726666AbgGXTLI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 15:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595617867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/IKeY6oErXCv4WxvHD12K0X54wE8JqQGDnTdTiMdbbI=;
        b=RHVnsO9D2LL8J0m5E/jkUjUIKWBgw/m3Jc2H/4rcNXDt7kkS5hX3+Buv7rewneUbKzgNNL
        rR4cDCplwVwqSLjF+V2K1NvBv+k5OEQLWQLa9b84/cRS8XR9yw/BQ5jL8DF8PHJRsPTDe2
        xS5NwySHsx2VWdcIXe45AYvcSw0rnjg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-KSQWmsA2MWyLHLlGSd4LFQ-1; Fri, 24 Jul 2020 15:11:03 -0400
X-MC-Unique: KSQWmsA2MWyLHLlGSd4LFQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0ADD8015F4;
        Fri, 24 Jul 2020 19:11:01 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-203.rdu2.redhat.com [10.10.117.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 572FD1A835;
        Fri, 24 Jul 2020 19:11:00 +0000 (UTC)
Subject: Re: [PATCH v3 5/6] powerpc/pseries: implement paravirt qspinlocks for
 SPLPAR
To:     Will Deacon <will@kernel.org>, peterz@infradead.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <20200706043540.1563616-6-npiggin@gmail.com>
 <874kqhvu1v.fsf@mpe.ellerman.id.au>
 <8265d782-4e50-a9b2-a908-0cb588ffa09c@redhat.com>
 <20200723140011.GR5523@worktop.programming.kicks-ass.net>
 <845de183-56f5-2958-3159-faa131d46401@redhat.com>
 <20200723184759.GS119549@hirez.programming.kicks-ass.net>
 <20200724081647.GA16642@willie-the-truck>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <8532332b-85dd-661b-cf72-81a8ceb70747@redhat.com>
Date:   Fri, 24 Jul 2020 15:10:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200724081647.GA16642@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/24/20 4:16 AM, Will Deacon wrote:
> On Thu, Jul 23, 2020 at 08:47:59PM +0200, peterz@infradead.org wrote:
>> On Thu, Jul 23, 2020 at 02:32:36PM -0400, Waiman Long wrote:
>>> BTW, do you have any comment on my v2 lock holder cpu info qspinlock patch?
>>> I will have to update the patch to fix the reported 0-day test problem, but
>>> I want to collect other feedback before sending out v3.
>> I want to say I hate it all, it adds instructions to a path we spend an
>> aweful lot of time optimizing without really getting anything back for
>> it.
>>
>> Will, how do you feel about it?
> I can see it potentially being useful for debugging, but I hate the
> limitation to 256 CPUs. Even arm64 is hitting that now.

After thinking more about that, I think we can use all the remaining 
bits in the 16-bit locked_pending. Reserving 1 bit for locked and 1 bit 
for pending, there are 14 bits left. So as long as NR_CPUS < 16k 
(requirement for 16-bit locked_pending), we can put all possible cpu 
numbers into the lock. We can also just use smp_processor_id() without 
additional percpu data.

>
> Also, you're talking ~1% gains here. I think our collective time would
> be better spent off reviewing the CNA series and trying to make it more
> deterministic.

I thought you guys are not interested in CNA. I do want to get CNA 
merged, if possible. Let review the current version again and see if 
there are ways we can further improve it.

Cheers,
Longman

