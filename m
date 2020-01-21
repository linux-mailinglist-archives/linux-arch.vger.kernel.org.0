Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14AAF1440D2
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2020 16:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgAUPqA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jan 2020 10:46:00 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33749 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729235AbgAUPp7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Jan 2020 10:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579621558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X4V9D6y2Lif4i/Bl6mgnfeFczMOxy2sAL0UfSmHDkVo=;
        b=OzeW8bYuAKEgom0xLx2Di74U+k1L95/BkI3zk37R8HXXAI6idL0uJOvxySUe0auygoTNK7
        YZ5/NGm0t879LGF5tfakM3umgrm1nt9MI95SxHiQUjZEVqIV7uEq2bb5uM396hqHLYiNHJ
        ijqFCKnZFkCYnKyNjNtoD/T6TPmU1IE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-6I1zfnugNnqKXYuU_fxsGg-1; Tue, 21 Jan 2020 10:45:54 -0500
X-MC-Unique: 6I1zfnugNnqKXYuU_fxsGg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 774E68045C0;
        Tue, 21 Jan 2020 15:45:51 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C488860F8;
        Tue, 21 Jan 2020 15:45:49 +0000 (UTC)
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
To:     Peter Zijlstra <peterz@infradead.org>,
        Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20191230194042.67789-5-alex.kogan@oracle.com>
 <20200121132949.GL14914@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <cfdf635d-be2e-9d4b-c4ca-6bcbddc6868f@redhat.com>
Date:   Tue, 21 Jan 2020 10:45:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200121132949.GL14914@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/21/20 8:29 AM, Peter Zijlstra wrote:
> On Mon, Dec 30, 2019 at 02:40:41PM -0500, Alex Kogan wrote:
>
>> +/*
>> + * Controls the threshold for the number of intra-node lock hand-offs before
>> + * the NUMA-aware variant of spinlock is forced to be passed to a thread on
>> + * another NUMA node. By default, the chosen value provides reasonable
>> + * long-term fairness without sacrificing performance compared to a lock
>> + * that does not have any fairness guarantees. The default setting can
>> + * be changed with the "numa_spinlock_threshold" boot option.
>> + */
>> +int intra_node_handoff_threshold __ro_after_init = 1 << 16;
> There is a distinct lack of quantitative data to back up that
> 'reasonable' claim there.
>
> Where is the table of inter-node latencies observed for the various
> values tested, and on what criteria is this number deemed reasonable?
>
> To me, 64k lock hold times seems like a giant number, entirely outside
> of reasonable.

I actually had similar question before, but having the capability of
changing the default with boot time parameter alleviate some of my
concern. I will certainly like to see actual data on how different
values will affect the performance of the code.

Cheers,
Longman

