Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D0E2194A7
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jul 2020 01:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgGHXxL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Jul 2020 19:53:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25017 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725982AbgGHXxL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jul 2020 19:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594252389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sMGK9tA8COwKvD1fQVNRk+JUOzHjOS5PJXHcnsRB2BQ=;
        b=ObbfKktOMtOjnmqW7U4HXKEu/ydNYJmW0rdj6D9ca+jmdJDwj1YfyW1XC1sZwGy8ezRi7Y
        MAV0ZHru+/BQPRgs3UJIHnYyppUPbS4cuuHnfLNzxXvUYU3dh7PWfEE4FgchP+OrwPfZsC
        SrH8OH+nKY5KxUUFU640AagIxHzzB1k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-PttZH5YuNPOhfnms_liwDg-1; Wed, 08 Jul 2020 19:53:08 -0400
X-MC-Unique: PttZH5YuNPOhfnms_liwDg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30B6F1082;
        Wed,  8 Jul 2020 23:53:06 +0000 (UTC)
Received: from llong.remote.csb (ovpn-116-205.rdu2.redhat.com [10.10.116.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA6637F8A4;
        Wed,  8 Jul 2020 23:53:04 +0000 (UTC)
Subject: Re: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        Anton Blanchard <anton@ozlabs.org>,
        Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <24f75d2c-60cd-2766-4aab-1a3b1c80646e@redhat.com>
 <1594101082.hfq9x5yact.astroid@bobo.none>
 <de3ead58-7f81-8ebd-754d-244f6be24af4@redhat.com>
 <20200708083210.GD597537@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <72f7df33-ab58-2e58-7981-cf02b6638c5b@redhat.com>
Date:   Wed, 8 Jul 2020 19:53:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200708083210.GD597537@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/8/20 4:32 AM, Peter Zijlstra wrote:
> On Tue, Jul 07, 2020 at 11:33:45PM -0400, Waiman Long wrote:
>>  From 5d7941a498935fb225b2c7a3108cbf590114c3db Mon Sep 17 00:00:00 2001
>> From: Waiman Long <longman@redhat.com>
>> Date: Tue, 7 Jul 2020 22:29:16 -0400
>> Subject: [PATCH 2/9] locking/pvqspinlock: Introduce
>>   CONFIG_PARAVIRT_QSPINLOCKS_LITE
>>
>> Add a new PARAVIRT_QSPINLOCKS_LITE config option that allows
>> architectures to use the PV qspinlock code without the need to use or
>> implement a pv_kick() function, thus eliminating the atomic unlock
>> overhead. The non-atomic queued_spin_unlock() can be used instead.
>> The pv_wait() function will still be needed, but it can be a dummy
>> function.
>>
>> With that option set, the hybrid PV queued/unfair locking code should
>> still be able to make it performant enough in a paravirtualized
> How is this supposed to work? If there is no kick, you have no control
> over who wakes up and fairness goes out the window entirely.
>
> You don't even begin to explain...
>
I don't have a full understanding of how the PPC hypervisor work myself. 
Apparently, a cpu kick may not be needed.

This is just a test patch to see if it yields better result. It is 
subjected to further modifcation.

Cheers,
Longman

