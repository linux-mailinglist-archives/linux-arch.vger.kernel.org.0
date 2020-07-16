Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E021A222BF1
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 21:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgGPTa7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 15:30:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29128 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729609AbgGPTa7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 15:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594927858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=NhQ2ROHSxC2oK8u3E25aErfE2eiG8dl+nWxZQxJ4JJw=;
        b=FtOhGhpIyGRuvrP84S7IrBICXb1+QAThMmitCboJX/F/aC4hjhfSgNJK88REXeNBaVL8yN
        OE+JS9ZpthBKv8iug6MbtLY6vyI9C3ciDsKCdy+Dmeka6Ipg51eFme35v5kjd3Pt2TtV4d
        WOsVyFEVunZ5eaRH5MjgxcXOe46Xay0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-ESBw1fneMi2Pcp_zkTEpzw-1; Thu, 16 Jul 2020 15:30:54 -0400
X-MC-Unique: ESBw1fneMi2Pcp_zkTEpzw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AE21800400;
        Thu, 16 Jul 2020 19:30:51 +0000 (UTC)
Received: from llong.com (ovpn-119-61.rdu2.redhat.com [10.10.119.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C009874F70;
        Thu, 16 Jul 2020 19:30:46 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/5] x86, locking/qspinlock: Allow lock to store lock holder cpu number
Date:   Thu, 16 Jul 2020 15:29:22 -0400
Message-Id: <20200716192927.12944-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patchset modifies the x86 qspinlock and qrwlock code to allow it to
store the lock holder cpu number (lock writer cpu number for qrwlock)
in the lock itself if feasible.  This lock holder cpu information is 
useful for debugging and crash dump analysis. It may also be useful to
architectures like PowerPC that needs the lock holder cpu number for
better paravirtual spinlock performance.

This capability is enabled on a per-architecture basis by defining
the macros __cpu_number_sadd1 (for qrwlock) and __cpu_number_sadd2
(for qspinlock). These macros define the architecture's way to get
to a percpu saturated +1 and +2 cpu number that can be used in the
lock byte of qspinlock and qrwlock.

This patchset enables it for the x86 architecture only. Additional
patches can be submitted later on to enable other architectures,
if desired.

I have run some locking microbenchmark with and without this patch. I
saw about 1% peformance degradation at low lock contention level, but
about 1% performance gain at high lock contention level. That slight
performance may be caused by a slight difference in the generated code
and may not be entirely due to the access of the percpu variable. Anyway,
that performance difference should be negligible for most real workloads.

Waiman Long (5):
  x86/smp: Add saturated +1/+2 1-byte cpu numbers
  locking/pvqspinlock: Make pvqsinlock code easier to read
  locking/qspinlock: Pass lock value as function argument
  locking/qspinlock: Make qspinhlock store lock holder cpu number
  locking/qrwlock: Make qrwlock store writer cpu number

 arch/x86/include/asm/qspinlock_paravirt.h | 42 +++++++++++------------
 arch/x86/include/asm/spinlock.h           |  5 +++
 arch/x86/kernel/setup_percpu.c            | 11 ++++++
 include/asm-generic/qrwlock.h             | 12 ++++++-
 include/asm-generic/qspinlock.h           | 10 ++++++
 include/asm-generic/qspinlock_types.h     |  2 +-
 kernel/locking/qrwlock.c                  | 11 +++---
 kernel/locking/qspinlock.c                | 31 ++++++++---------
 kernel/locking/qspinlock_paravirt.h       | 35 ++++++++++---------
 9 files changed, 97 insertions(+), 62 deletions(-)

-- 
2.18.1

