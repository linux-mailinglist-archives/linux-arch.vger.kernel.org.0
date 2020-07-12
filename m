Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEC121CBFA
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jul 2020 01:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgGLXFp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Jul 2020 19:05:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31778 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727838AbgGLXFp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sun, 12 Jul 2020 19:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594595144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xBYdTdnXKlelK8bZFQJ36aTsCLk72KGKZGJhxng2yII=;
        b=eg934yJfneSJSpylXhXJSnJ7syeXDbDxihwVc2HeAKBsmgNTJWN/3h124aI+tZasm7js0R
        xVyRWZUVga8Mz7LstZfu6SN8W3Wh16SoVeKzoaqZqHzkFxd5hZGpvGmHQsEGf87rrbsC+s
        gYPXKEiulvgHg4cjnN3RHregNRnB4nc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-84IRPjfAMr2mhUkbUawTzA-1; Sun, 12 Jul 2020 19:05:40 -0400
X-MC-Unique: 84IRPjfAMr2mhUkbUawTzA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4581D10059AB;
        Sun, 12 Jul 2020 23:05:38 +0000 (UTC)
Received: from llong.remote.csb (ovpn-112-77.rdu2.redhat.com [10.10.112.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D7B15C3E7;
        Sun, 12 Jul 2020 23:05:36 +0000 (UTC)
Subject: Re: [PATCH 2/2] locking/pvqspinlock: Optionally store lock holder cpu
 into lock
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
References: <20200711182128.29130-1-longman@redhat.com>
 <20200711182128.29130-3-longman@redhat.com>
 <20200712173452.GB10769@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <bed22603-e347-8bff-f586-072a18987946@redhat.com>
Date:   Sun, 12 Jul 2020 19:05:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200712173452.GB10769@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/12/20 1:34 PM, Peter Zijlstra wrote:
> On Sat, Jul 11, 2020 at 02:21:28PM -0400, Waiman Long wrote:
>> The previous patch enables native qspinlock to store lock holder cpu
>> number into the lock word when the lock is acquired via the slowpath.
>> Since PV qspinlock uses atomic unlock, allowing the fastpath and
>> slowpath to put different values into the lock word will further slow
>> down the performance. This is certainly undesirable.
>>
>> The only way we can do that without too much performance impact is to
>> make fastpath and slowpath put in the same value. Still there is a slight
>> performance overhead in the additional access to a percpu variable in the
>> fastpath as well as the less optimized x86-64 PV qspinlock unlock path.
>>
>> A new config option QUEUED_SPINLOCKS_CPUINFO is now added to enable
>> distros to decide if they want to enable lock holder cpu information in
>> the lock itself for both native and PV qspinlocks across both fastpath
>> and slowpath. If this option is not configureed, only native qspinlocks
>> in the slowpath will put the lock holder cpu information in the lock
>> word.
> And this kills it,.. if it doesn't make unconditional sense, we're not
> going to do this. It's just too ugly.
>
You mean it has to be unconditional, no option config if we want to do 
it. Right?

It can certainly be made unconditional after I figure out how to make 
the optimized PV unlock code work.

Cheers,
Longman

