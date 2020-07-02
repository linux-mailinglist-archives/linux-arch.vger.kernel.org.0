Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9EA211D55
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 09:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgGBHsz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 03:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgGBHsy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 03:48:54 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875F7C08C5C1;
        Thu,  2 Jul 2020 00:48:54 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g67so12169124pgc.8;
        Thu, 02 Jul 2020 00:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BGkFFlz3CL02oLLT9btRQ7t/uEdtktYrj+rJR3OzJfE=;
        b=VBfP9EfuSC5B01Yl75AWN5yemr1U1nXAUk5J9ZUrRV6z1IlF+wqWTn7hCEuC1eO+pI
         8f86dVB/F+CRd2am9M5cdc/3ApYWU6kEbVD5j3DjFhKedIbYD6rPBQFjGeEFgjvWKhXo
         0e1AZa92QpzFmLh0b6SRUIBVyzGbRd5JemEOktspm7S9V6vAkyWXCfRj4tjCBfWyfnT+
         ibbtdkwflelrAnPwkuhudW8uZVK9d9lclyVgPdyVkQ6uqW230GSyTCzVVXtq2CoRm+Q3
         kcR2wSgzchyBlq61itWFoQtZn4e2Yc2BMOZTuceB0zw5NeG/q5iyNoN40PF6g1sA1DIe
         pXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BGkFFlz3CL02oLLT9btRQ7t/uEdtktYrj+rJR3OzJfE=;
        b=HfxZbaaKftnSeUhFrICjnetejTwADi87rz2eoqJvfs7XHE9wJI1buC7yEwEPfEDTOQ
         Pea4rxMavFP1Ms2Xghf8WZ2hoseWdEHUgnVrFXFDT56ajJY9leDGrL+TcPUVcunia4jc
         ZcVx3lHyiKWJz6vo1RE1sYYQAYwISioyNpigTOIdq/t0jXD84bi2EUFiiwKH5agySgnm
         r498LJcXfPcD3ILyIITRSw1K8Uz0n3DSZ69YQPVL/jc4iXtv2dNLqThSAva3YwpF0TDJ
         rlEwZUMz3tcFz1BmXhW8DQ4+bZk+OsJuBirNekZhb4hilhfLqp4C8NLX80BDnaRhOI7B
         G/uQ==
X-Gm-Message-State: AOAM5329lYuHGm28oEMo85ut5FLRWvcV0TwAYCIZpEuBWFI7/76Tovu0
        TxR2cRsONjjEG/RX/OU3ffI=
X-Google-Smtp-Source: ABdhPJyZZV6c4bnHmvuCFcUHb/+F9EKbXInlk5xywpAnKg6m7EzNfoqKOOHYh+AmFZBFfTL3c0/qMQ==
X-Received: by 2002:a65:4847:: with SMTP id i7mr14123759pgs.385.1593676134139;
        Thu, 02 Jul 2020 00:48:54 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id 17sm6001953pfv.16.2020.07.02.00.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 00:48:53 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 0/8] powerpc: queued spinlocks and rwlocks
Date:   Thu,  2 Jul 2020 17:48:31 +1000
Message-Id: <20200702074839.1057733-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This series adds an option to use queued spinlocks for powerpc, and
makes it the default for the Book3S-64 subarch.

This effort starts with the generic code so it's very simple but
still very performant. There are optimisations that can be made to
slowpaths, but I think it's better to attack those incrementally
if/when we find things, and try to add the improvements to generic
code as much as possible.

Still in the process of getting numbers and testing, but the
implementation turned out to be surprisingly simple and we have a
config option, so I think we could merge it fairly soon.

Thanks,
Nick

Nicholas Piggin (8):
  powerpc/powernv: must include hvcall.h to get PAPR defines
  powerpc/pseries: use smp_rmb() in H_CONFER spin yield
  powerpc/pseries: move some PAPR paravirt functions to their own file
  powerpc: move spinlock implementation to simple_spinlock
  powerpc/64s: implement queued spinlocks and rwlocks
  powerpc/pseries: implement paravirt qspinlocks for SPLPAR
  powerpc/qspinlock: optimised atomic_try_cmpxchg_lock that adds the
    lock hint
  powerpc/64s: remove paravirt from simple spinlocks (RFC only)

 arch/powerpc/Kconfig                          |  13 +
 arch/powerpc/include/asm/Kbuild               |   2 +
 arch/powerpc/include/asm/atomic.h             |  28 ++
 arch/powerpc/include/asm/paravirt.h           |  84 +++++
 arch/powerpc/include/asm/qspinlock.h          |  75 +++++
 arch/powerpc/include/asm/qspinlock_paravirt.h |   5 +
 arch/powerpc/include/asm/simple_spinlock.h    | 235 +++++++++++++
 .../include/asm/simple_spinlock_types.h       |  21 ++
 arch/powerpc/include/asm/spinlock.h           | 308 +-----------------
 arch/powerpc/include/asm/spinlock_types.h     |  17 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c           |   6 -
 arch/powerpc/lib/Makefile                     |   1 -
 arch/powerpc/lib/locks.c                      |  65 ----
 arch/powerpc/platforms/powernv/pci-ioda-tce.c |   1 +
 arch/powerpc/platforms/pseries/Kconfig        |   5 +
 arch/powerpc/platforms/pseries/setup.c        |   6 +-
 include/asm-generic/qspinlock.h               |   4 +
 17 files changed, 488 insertions(+), 388 deletions(-)
 create mode 100644 arch/powerpc/include/asm/paravirt.h
 create mode 100644 arch/powerpc/include/asm/qspinlock.h
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
 create mode 100644 arch/powerpc/include/asm/simple_spinlock.h
 create mode 100644 arch/powerpc/include/asm/simple_spinlock_types.h
 delete mode 100644 arch/powerpc/lib/locks.c

-- 
2.23.0

