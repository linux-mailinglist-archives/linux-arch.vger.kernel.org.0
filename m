Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0A5215EE9
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jul 2020 20:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbgGFSkC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jul 2020 14:40:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34501 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729743AbgGFSkB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jul 2020 14:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594060799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fGfzwKmfId0nPt6AjeRSKqUxZBg1dc0lbe/SE6/v6yI=;
        b=I+vFqR7cN56J14zf1G6x9NDqGEfPHnVCsqcq8EKjRZVAGEk/Oyc96yD1bnsF7LLb6orb1p
        9EnSi2fk9exFJC9FbwD/efODeU6B7XnmMe5tyrZTShJDEIxrYdsJUtVnOhjMQwag/dECWB
        QP52LShddjeKIUKf8cj5iSvKMXbFCjI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-ZRiGS6MdOQm63DvY3owoAw-1; Mon, 06 Jul 2020 14:39:57 -0400
X-MC-Unique: ZRiGS6MdOQm63DvY3owoAw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 597AF8014D4;
        Mon,  6 Jul 2020 18:39:55 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-98.rdu2.redhat.com [10.10.117.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 150B52C2BC;
        Mon,  6 Jul 2020 18:39:54 +0000 (UTC)
Subject: Re: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
To:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20200706043540.1563616-1-npiggin@gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <24f75d2c-60cd-2766-4aab-1a3b1c80646e@redhat.com>
Date:   Mon, 6 Jul 2020 14:39:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200706043540.1563616-1-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/6/20 12:35 AM, Nicholas Piggin wrote:
> v3 is updated to use __pv_queued_spin_unlock, noticed by Waiman (thank you).
>
> Thanks,
> Nick
>
> Nicholas Piggin (6):
>    powerpc/powernv: must include hvcall.h to get PAPR defines
>    powerpc/pseries: move some PAPR paravirt functions to their own file
>    powerpc: move spinlock implementation to simple_spinlock
>    powerpc/64s: implement queued spinlocks and rwlocks
>    powerpc/pseries: implement paravirt qspinlocks for SPLPAR
>    powerpc/qspinlock: optimised atomic_try_cmpxchg_lock that adds the
>      lock hint
>
>   arch/powerpc/Kconfig                          |  13 +
>   arch/powerpc/include/asm/Kbuild               |   2 +
>   arch/powerpc/include/asm/atomic.h             |  28 ++
>   arch/powerpc/include/asm/paravirt.h           |  89 +++++
>   arch/powerpc/include/asm/qspinlock.h          |  91 ++++++
>   arch/powerpc/include/asm/qspinlock_paravirt.h |   7 +
>   arch/powerpc/include/asm/simple_spinlock.h    | 292 +++++++++++++++++
>   .../include/asm/simple_spinlock_types.h       |  21 ++
>   arch/powerpc/include/asm/spinlock.h           | 308 +-----------------
>   arch/powerpc/include/asm/spinlock_types.h     |  17 +-
>   arch/powerpc/lib/Makefile                     |   3 +
>   arch/powerpc/lib/locks.c                      |  12 +-
>   arch/powerpc/platforms/powernv/pci-ioda-tce.c |   1 +
>   arch/powerpc/platforms/pseries/Kconfig        |   5 +
>   arch/powerpc/platforms/pseries/setup.c        |   6 +-
>   include/asm-generic/qspinlock.h               |   4 +
>   16 files changed, 577 insertions(+), 322 deletions(-)
>   create mode 100644 arch/powerpc/include/asm/paravirt.h
>   create mode 100644 arch/powerpc/include/asm/qspinlock.h
>   create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
>   create mode 100644 arch/powerpc/include/asm/simple_spinlock.h
>   create mode 100644 arch/powerpc/include/asm/simple_spinlock_types.h
>
This patch looks OK to me.

I had run some microbenchmark on powerpc system with or w/o the patch.

On a 2-socket 160-thread SMT4 POWER9 system (not virtualized):

5.8.0-rc4
=========

Running locktest with spinlock [runtime = 10s, load = 1]
Threads = 160, Min/Mean/Max = 77,665/90,153/106,895
Threads = 160, Total Rate = 1,441,759 op/s; Percpu Rate = 9,011 op/s

Running locktest with rwlock [runtime = 10s, r% = 50%, load = 1]
Threads = 160, Min/Mean/Max = 47,879/53,807/63,689
Threads = 160, Total Rate = 860,192 op/s; Percpu Rate = 5,376 op/s

Running locktest with spinlock [runtime = 10s, load = 1]
Threads = 80, Min/Mean/Max = 242,907/319,514/463,161
Threads = 80, Total Rate = 2,555 kop/s; Percpu Rate = 32 kop/s

Running locktest with rwlock [runtime = 10s, r% = 50%, load = 1]
Threads = 80, Min/Mean/Max = 146,161/187,474/259,270
Threads = 80, Total Rate = 1,498 kop/s; Percpu Rate = 19 kop/s

Running locktest with spinlock [runtime = 10s, load = 1]
Threads = 40, Min/Mean/Max = 646,639/1,000,817/1,455,205
Threads = 40, Total Rate = 4,001 kop/s; Percpu Rate = 100 kop/s

Running locktest with rwlock [runtime = 10s, r% = 50%, load = 1]
Threads = 40, Min/Mean/Max = 402,165/597,132/814,555
Threads = 40, Total Rate = 2,388 kop/s; Percpu Rate = 60 kop/s

5.8.0-rc4-qlock+
================

Running locktest with spinlock [runtime = 10s, load = 1]
Threads = 160, Min/Mean/Max = 123,835/124,580/124,587
Threads = 160, Total Rate = 1,992 kop/s; Percpu Rate = 12 kop/s

Running locktest with rwlock [runtime = 10s, r% = 50%, load = 1]
Threads = 160, Min/Mean/Max = 254,210/264,714/276,784
Threads = 160, Total Rate = 4,231 kop/s; Percpu Rate = 26 kop/s

Running locktest with spinlock [runtime = 10s, load = 1]
Threads = 80, Min/Mean/Max = 599,715/603,397/603,450
Threads = 80, Total Rate = 4,825 kop/s; Percpu Rate = 60 kop/s

Running locktest with rwlock [runtime = 10s, r% = 50%, load = 1]
Threads = 80, Min/Mean/Max = 492,687/525,224/567,456
Threads = 80, Total Rate = 4,199 kop/s; Percpu Rate = 52 kop/s

Running locktest with spinlock [runtime = 10s, load = 1]
Threads = 40, Min/Mean/Max = 1,325,623/1,325,628/1,325,636
Threads = 40, Total Rate = 5,299 kop/s; Percpu Rate = 132 kop/s

Running locktest with rwlock [runtime = 10s, r% = 50%, load = 1]
Threads = 40, Min/Mean/Max = 1,249,731/1,292,977/1,342,815
Threads = 40, Total Rate = 5,168 kop/s; Percpu Rate = 129 kop/s

On systems on large number of cpus, qspinlock lock is faster and more fair.

With some tuning, we may be able to squeeze out more performance.

Cheers,
Longman

