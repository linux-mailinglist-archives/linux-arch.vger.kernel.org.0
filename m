Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D18522B65F
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jul 2020 21:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgGWTEX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 15:04:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42587 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726455AbgGWTEW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 15:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595531061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=To+9baHo0nhSErT6A7uWNDfbadEXVch0SXRcbjuvNmc=;
        b=FGbMWF+w1L/wLtX9OFZZDWO7EEIcqlM9TUL7RzLbzD6eNJ+CHcg1mTb6fCCancpn+mc7o6
        8/5LWvEkzXaxVvotS63rRbEuLSrtlU4mbDZSChzd6F8g63/s0ZXCDfOFZjicNjl7FJ7GdG
        8n55mRxodvcSpChqk5l7Ckrhh5A25C0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-KMn91B7pP3-wvEpB_u563g-1; Thu, 23 Jul 2020 15:04:16 -0400
X-MC-Unique: KMn91B7pP3-wvEpB_u563g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 289D4106B243;
        Thu, 23 Jul 2020 19:04:15 +0000 (UTC)
Received: from llong.remote.csb (ovpn-119-128.rdu2.redhat.com [10.10.119.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C45565BAD5;
        Thu, 23 Jul 2020 19:04:13 +0000 (UTC)
Subject: Re: [PATCH v3 5/6] powerpc/pseries: implement paravirt qspinlocks for
 SPLPAR
To:     peterz@infradead.org
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
 <845de183-56f5-2958-3159-faa131d46401@redhat.com>
 <20200723184759.GS119549@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <6d6279ad-7432-63c1-14c3-18c4cff30bf8@redhat.com>
Date:   Thu, 23 Jul 2020 15:04:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200723184759.GS119549@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/23/20 2:47 PM, peterz@infradead.org wrote:
> On Thu, Jul 23, 2020 at 02:32:36PM -0400, Waiman Long wrote:
>> BTW, do you have any comment on my v2 lock holder cpu info qspinlock patch?
>> I will have to update the patch to fix the reported 0-day test problem, but
>> I want to collect other feedback before sending out v3.
> I want to say I hate it all, it adds instructions to a path we spend an
> aweful lot of time optimizing without really getting anything back for
> it.

It does add some extra instruction that may slow it down slightly, but I 
don't agree that it gives nothing back. The cpu lock holder information 
can be useful in analyzing crash dumps and in some debugging situation. 
I think it can be useful in RHEL for this readon. How about an x86 
config option to allow distros to decide if they want to have it 
enabled? I will make sure that it will have no performance degradation 
if the option is not enabled.

Cheers,
Longman


