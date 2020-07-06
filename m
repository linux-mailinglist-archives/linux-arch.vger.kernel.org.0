Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA102151B0
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jul 2020 06:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgGFEfy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jul 2020 00:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgGFEfy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jul 2020 00:35:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CB2C061794;
        Sun,  5 Jul 2020 21:35:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k6so39344719wrn.3;
        Sun, 05 Jul 2020 21:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZKbw/z5L6V9QIy1x3CDqGbQPwSP3RR4H4VZhRPfsp8M=;
        b=Hkf1JzYh8wjUYolV0yaByArSjR1r/H4U8J4WcN5XtRtVGH5W1a+waY2FcTp6vNrLBv
         jUMpiNqYBpmtBNy0cshISgyAcM8ayGC//EhS4EYX7SaFkqXmDS7tGBDLg5gGMwx+RI0v
         rFOVnaVf/ZahbQA9k3IR3fBN0Nr5dbv8ZnaxhEiQ8cS4v1n7xBWwPFfjtuUabcwR3wgn
         Pn010T/J+8URF0VzurWA/Zg0X0kLeBB6VLgpir94tXXLt4ibfN8TCZXm0Uqe8IgWEk7r
         i10AkbH3ZRjLbsnoD+AFWUwuWz0ZGk7mbp96o/clHt9q62DneKcDYbkA09H3OaLiOHAV
         /a/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZKbw/z5L6V9QIy1x3CDqGbQPwSP3RR4H4VZhRPfsp8M=;
        b=HEldRPJ9r/E1p99rvXlu7gofH5pLoEi1IDsCsLlfH09au6wCtleWN0Et9/q9yLaFKR
         ReepX5og+5iLoFqO2S4vclLmU9aGdy8txk4D1Hyf7LthwI97KEpNj/b3iM14NB61T1KG
         P0qQWPwQGu9I9d+q2cV8gMW1yYi25EBynz7kMovOM1uBANnK5m+mC/camk7ZjwE1kvsl
         V1jbR0vgB+kthLosFSp9JsAOyYxtHcB5PxQ+WJkCk49ZJsBOgh65iW7MUAusoaihhjh+
         QesHjF1TqEvxOEo1slyFb0QoQtdwmj22yISJ7eABULYbv1w/MxkQCO+17JK/O4O6wKcf
         0B8g==
X-Gm-Message-State: AOAM531wqKzVhNPMSEKJ/Gy6gl9AZf8wiXEkZ4NB3w3HrzpZ4Frr07oN
        jS+9ROEwJZERz6Ifp6q3Rezgi35l
X-Google-Smtp-Source: ABdhPJzihhpFIjNtA4jYZFpWqPBLQzM2ItdHfjFiE1pNPdxZGN7QPxVTkIDKR3KTQMdZob9+J5kqVg==
X-Received: by 2002:adf:f34e:: with SMTP id e14mr46431344wrp.299.1594010152557;
        Sun, 05 Jul 2020 21:35:52 -0700 (PDT)
Received: from bobo.ibm.com (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id r10sm22202309wrm.17.2020.07.05.21.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 21:35:51 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
Date:   Mon,  6 Jul 2020 14:35:34 +1000
Message-Id: <20200706043540.1563616-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

v3 is updated to use __pv_queued_spin_unlock, noticed by Waiman (thank you).

Thanks,
Nick

Nicholas Piggin (6):
  powerpc/powernv: must include hvcall.h to get PAPR defines
  powerpc/pseries: move some PAPR paravirt functions to their own file
  powerpc: move spinlock implementation to simple_spinlock
  powerpc/64s: implement queued spinlocks and rwlocks
  powerpc/pseries: implement paravirt qspinlocks for SPLPAR
  powerpc/qspinlock: optimised atomic_try_cmpxchg_lock that adds the
    lock hint

 arch/powerpc/Kconfig                          |  13 +
 arch/powerpc/include/asm/Kbuild               |   2 +
 arch/powerpc/include/asm/atomic.h             |  28 ++
 arch/powerpc/include/asm/paravirt.h           |  89 +++++
 arch/powerpc/include/asm/qspinlock.h          |  91 ++++++
 arch/powerpc/include/asm/qspinlock_paravirt.h |   7 +
 arch/powerpc/include/asm/simple_spinlock.h    | 292 +++++++++++++++++
 .../include/asm/simple_spinlock_types.h       |  21 ++
 arch/powerpc/include/asm/spinlock.h           | 308 +-----------------
 arch/powerpc/include/asm/spinlock_types.h     |  17 +-
 arch/powerpc/lib/Makefile                     |   3 +
 arch/powerpc/lib/locks.c                      |  12 +-
 arch/powerpc/platforms/powernv/pci-ioda-tce.c |   1 +
 arch/powerpc/platforms/pseries/Kconfig        |   5 +
 arch/powerpc/platforms/pseries/setup.c        |   6 +-
 include/asm-generic/qspinlock.h               |   4 +
 16 files changed, 577 insertions(+), 322 deletions(-)
 create mode 100644 arch/powerpc/include/asm/paravirt.h
 create mode 100644 arch/powerpc/include/asm/qspinlock.h
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
 create mode 100644 arch/powerpc/include/asm/simple_spinlock.h
 create mode 100644 arch/powerpc/include/asm/simple_spinlock_types.h

-- 
2.23.0

