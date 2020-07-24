Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35C122C602
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 15:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgGXNOh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jul 2020 09:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgGXNOg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 09:14:36 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA1FC0619D3;
        Fri, 24 Jul 2020 06:14:36 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id t11so5062726pfq.11;
        Fri, 24 Jul 2020 06:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pNbiY4rCOWfn291u6DvF/2Ahe4KMxxHPAD/LG/AtX8A=;
        b=pXLqcyKcwadFpxMawcde5uKWsmYRkcG8MkmB7OazkUR1B9BxLPOTtomS0atxp0wsl0
         3K/nBNDtdLM3XMKp/+Q2KWPhTzNaLsUfCbkpvUQYl6EOzkHNK4vD7ZfKDhoLzWCd2/se
         fgoI8WC64Tprw9SX7RVYFGJVh3Fr+l1v+e5gbAofaNSm7BpQNZBwaJXh4KnnE/c7ATBL
         JP1X36gJgrQMWq1w5fNtffUVAvZelPJ7TC9Q/xuCVhzxxomWZcH5/i0edBgmsWZ5thXx
         Ig3Akrdt8zubCyDuzbipimtLx+lMYUOnS0mpNIrbb3vf4jg7KTVvtMzq2Quh777Evv+Z
         RCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pNbiY4rCOWfn291u6DvF/2Ahe4KMxxHPAD/LG/AtX8A=;
        b=fOhw1y0pJZVgXHfJ82/XVH4Qx+EbPI0sqKmKcQPkY56N98j/dBwBOMBhJIoqKSHFr6
         h/DFi6v7n+uk1D5iUk45GNveIhyREa7COJsAXG9vVNyU6XpAQ8HAvTX5mzX2/BBp3crW
         kNb5TF3d0+RFK8Etug1IgSt5AQj9VsbGWQ2/lw02xO0vs0dQyEwoLn+5wJwy6psNegrl
         y7MrWyLr9gDGkbH2XzJGHNBm3WJZpWhMjGLE2uwkDehLGuu1nHXruKF1J+z2c6mrLei5
         r0KopvgUJSuqAeTdGn7YkX2DAyF3g/iVhm1nGQMAKbrGHHgv8ppwRNiNZaRRExIxhxSH
         mm/w==
X-Gm-Message-State: AOAM530iJk9lXCOY+R+kyb07YU0Ezu7hsveHDc/gPZoqM06XutRfVliM
        VcWJFVWtL8u2AHkpNsZwYh8=
X-Google-Smtp-Source: ABdhPJxTM0xNsmofbW6cID6lTwKMAYAg9GWepJp2u9OgGyKYII7bL4WnhIOmRKega9Bzh5DogPa2Zg==
X-Received: by 2002:a05:6a00:1586:: with SMTP id u6mr8714565pfk.147.1595596476262;
        Fri, 24 Jul 2020 06:14:36 -0700 (PDT)
Received: from bobo.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id az16sm5871998pjb.7.2020.07.24.06.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 06:14:35 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v4 0/6] powerpc: queued spinlocks and rwlocks
Date:   Fri, 24 Jul 2020 23:14:17 +1000
Message-Id: <20200724131423.1362108-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Updated with everybody's feedback (thanks all), and more performance
results.

What I've found is I might have been measuring the worst load point for
the paravirt case, and by looking at a range of loads it's clear that
queued spinlocks are overall better even on PV, doubly so when you look
at the generally much improved worst case latencies.

I have defaulted it to N even though I'm less concerned about the PV
numbers now, just because I think it needs more stress testing. But
it's very nicely selectable so should be low risk to include.

All in all this is a very cool technology and great results especially
on the big systems but even on smaller ones there are nice gains. Thanks
Waiman and everyone who developed it.

Thanks,
Nick

Nicholas Piggin (6):
  powerpc/pseries: move some PAPR paravirt functions to their own file
  powerpc: move spinlock implementation to simple_spinlock
  powerpc/64s: implement queued spinlocks and rwlocks
  powerpc/pseries: implement paravirt qspinlocks for SPLPAR
  powerpc/qspinlock: optimised atomic_try_cmpxchg_lock that adds the
    lock hint
  powerpc: implement smp_cond_load_relaxed

 arch/powerpc/Kconfig                          |  15 +
 arch/powerpc/include/asm/Kbuild               |   1 +
 arch/powerpc/include/asm/atomic.h             |  28 ++
 arch/powerpc/include/asm/barrier.h            |  14 +
 arch/powerpc/include/asm/paravirt.h           |  87 +++++
 arch/powerpc/include/asm/qspinlock.h          |  91 ++++++
 arch/powerpc/include/asm/qspinlock_paravirt.h |   7 +
 arch/powerpc/include/asm/simple_spinlock.h    | 288 ++++++++++++++++
 .../include/asm/simple_spinlock_types.h       |  21 ++
 arch/powerpc/include/asm/spinlock.h           | 308 +-----------------
 arch/powerpc/include/asm/spinlock_types.h     |  17 +-
 arch/powerpc/lib/Makefile                     |   3 +
 arch/powerpc/lib/locks.c                      |  12 +-
 arch/powerpc/platforms/pseries/Kconfig        |   9 +-
 arch/powerpc/platforms/pseries/setup.c        |   4 +-
 include/asm-generic/qspinlock.h               |   4 +
 16 files changed, 588 insertions(+), 321 deletions(-)
 create mode 100644 arch/powerpc/include/asm/paravirt.h
 create mode 100644 arch/powerpc/include/asm/qspinlock.h
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
 create mode 100644 arch/powerpc/include/asm/simple_spinlock.h
 create mode 100644 arch/powerpc/include/asm/simple_spinlock_types.h

-- 
2.23.0

