Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221DE21350D
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jul 2020 09:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgGCHf3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jul 2020 03:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgGCHf3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jul 2020 03:35:29 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F973C08C5C1;
        Fri,  3 Jul 2020 00:35:29 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id l6so10456250pjq.1;
        Fri, 03 Jul 2020 00:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vbRBeJ+XIbof8SsSnUrtwZgJ/aiu8Z+x8SsI7+GEKqo=;
        b=Sx/HrLI1gUrhnhruDmTnduBJm6i1u2AFd+QouTv/vb5YltoyihE6ABJowb0MWAz6Pf
         +uXGTwzRxR7b4k3wQmaA6naeh+y4u9Y2BAoN9vb0ulKlIyhXQw/raf4qDDowv+9P3vx6
         YEPSk+sNOeSOK0Umr8u1rPFcNnN5aW+kfalo8IP036e6NWdMYadk5NZDPS8fvt9SB2tQ
         sSHyx3urEWcOP26k/GNZ3LLNVlsem7fH+NdDgB53nCrQVtn+Jf6XtQEbLD4BdcW+QJ5v
         JucXQVQ44J3p+gLsA04oOXln9Ypjb4MyUkxCDnJOZein/EaL7mal3GVQ2TRMyoqf03c/
         2E4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vbRBeJ+XIbof8SsSnUrtwZgJ/aiu8Z+x8SsI7+GEKqo=;
        b=Q0830cjYwVR6THe5bTLC3oqxXtXYXiz+hYMVYj9RT+KUxSTjthyQz/XnxI/ebtfytB
         SSY0SqzZysJNtfJsAVgjD7wUmOY8fnPMp7UIlmWrJw8Xivd7CpowM+HjRrdlkaiy97in
         QM6vfkyqE3ARcnd/SyhzpusgMk7cr1sZCyh/Ck2YKYpAJIALgePaNEqswmSwCfOwq9V4
         wg2kZOT3fOAUbWan18X8QBJNxIwIH6FEiEkxsVOy/6hlcl9naKxzF4Uz7CJan7JMxnQU
         PDuzLnWqnOVKs+GAhvqJHTfX04fTLpDC3K1/94YGm8Tear55IY2zg7cwLHQO6gHTibw1
         0QcA==
X-Gm-Message-State: AOAM532OyqNG7thfLvANgDDRRQ5kOl+szRkkokvrhTakJOheF+EGY7yD
        NOyv3NUobJ3GePW08hobM4A=
X-Google-Smtp-Source: ABdhPJxGGr/T+DMbaejYqpR0giBM8nZ8ynq17VDv7uveaGsjhL5t6fMWI9MQnFOkBe6Nr0BI89jHMg==
X-Received: by 2002:a17:90a:db48:: with SMTP id u8mr5957942pjx.169.1593761728886;
        Fri, 03 Jul 2020 00:35:28 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id y7sm10218499pgk.93.2020.07.03.00.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 00:35:28 -0700 (PDT)
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
Subject: [PATCH v2 0/6] powerpc: queued spinlocks and rwlocks
Date:   Fri,  3 Jul 2020 17:35:10 +1000
Message-Id: <20200703073516.1354108-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

v2 is updated to account for feedback from Will, Peter, and
Waiman (thank you), and trims off a couple of RFC and unrelated
patches.

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
 arch/powerpc/include/asm/qspinlock.h          |  80 +++++
 arch/powerpc/include/asm/qspinlock_paravirt.h |   5 +
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
 16 files changed, 564 insertions(+), 322 deletions(-)
 create mode 100644 arch/powerpc/include/asm/paravirt.h
 create mode 100644 arch/powerpc/include/asm/qspinlock.h
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
 create mode 100644 arch/powerpc/include/asm/simple_spinlock.h
 create mode 100644 arch/powerpc/include/asm/simple_spinlock_types.h

-- 
2.23.0

