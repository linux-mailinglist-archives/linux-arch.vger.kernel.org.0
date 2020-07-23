Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBE022B5B8
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jul 2020 20:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgGWSco (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 14:32:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21826 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726349AbgGWSco (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 14:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595529162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sKozQ0KnMZ6/jFMcku3oZ38jLyvLbmaFhh4u3SNBWFc=;
        b=gZHQd8X1mQag8LfClpQ5wYmJ3wkB5LmbOpA4wcdC/tj+Qw2O9Wkpj1sAuUIXXuyGoAQIiF
        DPbyU9a2H6J3zoaMwpgSWbtGH4HUI6XruGUHEv02q2lObPiVSE4KGyLjY7SUdJYqcaults
        qBKc59ai/lUDhBtgyOEeaBIz2juw6+M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-a7YRzGORP6i5sZOBhCiJ6Q-1; Thu, 23 Jul 2020 14:32:40 -0400
X-MC-Unique: a7YRzGORP6i5sZOBhCiJ6Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8A501005510;
        Thu, 23 Jul 2020 18:32:38 +0000 (UTC)
Received: from llong.remote.csb (ovpn-119-128.rdu2.redhat.com [10.10.119.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 209FA19D7E;
        Thu, 23 Jul 2020 18:32:37 +0000 (UTC)
Subject: Re: [PATCH v3 5/6] powerpc/pseries: implement paravirt qspinlocks for
 SPLPAR
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
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
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <845de183-56f5-2958-3159-faa131d46401@redhat.com>
Date:   Thu, 23 Jul 2020 14:32:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200723140011.GR5523@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/23/20 10:00 AM, Peter Zijlstra wrote:
> On Thu, Jul 09, 2020 at 12:06:13PM -0400, Waiman Long wrote:
>> We don't really need to do a pv_spinlocks_init() if pv_kick() isn't
>> supported.
> Waiman, if you cannot explain how not having kick is a sane thing, what
> are you saying here?
>
The current PPC paravirt spinlock code doesn't do any cpu kick. It does 
an equivalence of pv_wait by yielding the cpu to the lock holder only. 
The pv_spinlocks_init() is for setting up the hash table for doing 
pv_kick. If we don't need to do pv_kick, we don't need the hash table.

I am not saying that pv_kick is not needed for the PPC environment. I 
was just trying to adapt the pvqspinlock code to such an environment 
first. Further investigation on how to implement some kind of pv_kick 
will be something that we may want to do as a follow on.

BTW, do you have any comment on my v2 lock holder cpu info qspinlock 
patch? I will have to update the patch to fix the reported 0-day test 
problem, but I want to collect other feedback before sending out v3.

Cheers,
Longman

