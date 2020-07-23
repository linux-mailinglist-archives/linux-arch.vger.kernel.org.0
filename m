Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E670D22B155
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jul 2020 16:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgGWO3O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 10:29:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49106 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728966AbgGWO3O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 10:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595514553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sjWrHb3Ks2HmLwSk4IBKGBOeRlTKPDTsa4ryyXU2kGA=;
        b=Ocm70ZpVsgfWjk9pSkBJR+ibXhmn/Pzy8BV24wvWVthvEOLUMX/9ti6WPEvRhmsRnk8lqG
        jQ2nKAQZef0VxZi7y9iXOr0T4pvfmDclJJ+GccQP78RyUWKu+SBQsf/jTNhKILXdAlzqH9
        L1SG9Vj72N5XeM+nRwqwbmzZwxzT97Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-WWW-soEHN2WBpuXa82lQDw-1; Thu, 23 Jul 2020 10:29:08 -0400
X-MC-Unique: WWW-soEHN2WBpuXa82lQDw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F11818C63C6;
        Thu, 23 Jul 2020 14:29:06 +0000 (UTC)
Received: from llong.remote.csb (ovpn-119-128.rdu2.redhat.com [10.10.119.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FEA15FC3B;
        Thu, 23 Jul 2020 14:29:05 +0000 (UTC)
Subject: Re: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
To:     Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Anton Blanchard <anton@ozlabs.org>,
        Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <24f75d2c-60cd-2766-4aab-1a3b1c80646e@redhat.com>
 <1594101082.hfq9x5yact.astroid@bobo.none>
 <20200708084106.GE597537@hirez.programming.kicks-ass.net>
 <1595327263.lk78cqolxm.astroid@bobo.none>
 <eaabf501-80fe-dd15-c03c-f75ce4f75877@redhat.com>
 <1595510571.u39qfc8d1o.astroid@bobo.none>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <af825bce-ecf3-66e4-ad63-a844dbd2e775@redhat.com>
Date:   Thu, 23 Jul 2020 10:29:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1595510571.u39qfc8d1o.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/23/20 9:30 AM, Nicholas Piggin wrote:
>> I would prefer to extract out the pending bit handling code out into a
>> separate helper function which can be overridden by the arch code
>> instead of breaking the slowpath into 2 pieces.
> You mean have the arch provide a queued_spin_lock_slowpath_pending
> function that the slow path calls?
>
> I would actually prefer the pending handling can be made inline in
> the queued_spin_lock function, especially with out-of-line locks it
> makes sense to put it there.
>
> We could ifdef out queued_spin_lock_slowpath_queue if it's not used,
> then __queued_spin_lock_slowpath_queue would be inlined into the
> caller so there would be no split?

The pending code is an optimization for lightly contended locks. That is 
why I think it is appropriate to extract it into a helper function and 
mark it as such.

You can certainly put the code in the arch's spin_lock code, you just 
has to override the generic pending code by a null function.

Cheers,
Longman

