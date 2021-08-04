Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBB93E0885
	for <lists+linux-arch@lfdr.de>; Wed,  4 Aug 2021 21:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239388AbhHDTQT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Aug 2021 15:16:19 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:40366 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239207AbhHDTQS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Aug 2021 15:16:18 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 57A89C0CD6;
        Wed,  4 Aug 2021 19:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1628104565; bh=QNBcV08QVOLccNUG2RaWflwIhkYnYjRy+AJtEG7BCbM=;
        h=From:To:Cc:Subject:Date:From;
        b=j+zH2QZqMB8dlQi0ifUZfqfjzQb3+v7Ci6eYugBIrUptM30jGgkoH+f+5DWjc/XEw
         IbU4qIzBI2fG0Pt265Ih/kmMylP7PXIN0N1zQyQi3lsTRQJpC2v4xEfI94DbGzrbCv
         ZIRw28CDf8Rnlcx38GpDpJpTMXStH44CeQWqsAbgPzWrC1aEl4oN+OynLOUIMri5bI
         5Ov3ztKGWJf2YgzqVbUp2ZJZhQe4MrgZJtJdugc2ndbAuWmSRFpOMH2vXX8OGnTPAx
         J4683Ztg4lFNBUieT8tMLv3QyBs0ONSok5enMQyz/VKby7b6vRWmcvH09Nan7Nhruk
         8rrLMs4iX2E8w==
Received: from vineetg-Latitude-7400.internal.synopsys.com (snps-fugpbdpduq.internal.synopsys.com [10.202.17.37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 112D3A0090;
        Wed,  4 Aug 2021 19:16:02 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Vladimir Isaev <Vladimir.Isaev@synopsys.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 00/11] ARC atomics update
Date:   Wed,  4 Aug 2021 12:15:43 -0700
Message-Id: <20210804191554.1252776-1-vgupta@synopsys.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

This series contains long due update to ARC atomics, discussed back
in 2018 [1] and [2]. I had them for arc64 port and decided to post them
here for some review and inclusion, after Mark's rework.

The main changes are use of relaxed atomics and generic bitops. Latter
does cause some cogen bloat on ARC due to signed args but that can be
reviewd seperately consider cross-arch impact.

The changes survive glibc testsuite with no regressions whatsoever.

Please review and provide any feedback.

Thx,
-Vineet

[1] https://lore.kernel.org/r/20180830144344.GW24142@hirez.programming.kicks-ass.net
[2] https://lore.kernel.org/r/20180830135749.GA13005@arm.com


Vineet Gupta (10):
  ARC: atomics: disintegrate header
  ARC: atomic: !LLSC: remove hack in atomic_set() for for UP
  ARC: atomic: !LLSC: use int data type consistently
  ARC: atomic64: LLSC: elide unused atomic_{and,or,xor,andnot}_return
  ARC: atomics: implement relaxed variants
  ARC: bitops: fls/ffs to take int (vs long) per asm-generic defines
  ARC: xchg: !LLSC: remove UP micro-optimization/hack
  ARC: cmpxchg/xchg: rewrite as macros to make type safe
  ARC: cmpxchg/xchg: implement relaxed variants (LLSC config only)
  ARC: atomic_cmpxchg/atomic_xchg: implement relaxed variants

Will Deacon (1):
  ARC: switch to generic bitops

 arch/arc/include/asm/atomic-llsc.h     |  97 ++++++
 arch/arc/include/asm/atomic-spinlock.h | 102 ++++++
 arch/arc/include/asm/atomic.h          | 444 ++-----------------------
 arch/arc/include/asm/atomic64-arcv2.h  | 250 ++++++++++++++
 arch/arc/include/asm/bitops.h          | 188 +----------
 arch/arc/include/asm/cmpxchg.h         | 233 ++++++-------
 arch/arc/include/asm/smp.h             |  14 -
 arch/arc/kernel/smp.c                  |   2 -
 8 files changed, 588 insertions(+), 742 deletions(-)
 create mode 100644 arch/arc/include/asm/atomic-llsc.h
 create mode 100644 arch/arc/include/asm/atomic-spinlock.h
 create mode 100644 arch/arc/include/asm/atomic64-arcv2.h

-- 
2.25.1

