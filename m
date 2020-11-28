Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407D02C72A4
	for <lists+linux-arch@lfdr.de>; Sat, 28 Nov 2020 23:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389933AbgK1VuN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Nov 2020 16:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729747AbgK1S3k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 28 Nov 2020 13:29:40 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B34C0258EE;
        Sat, 28 Nov 2020 08:01:51 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id e8so7097822pfh.2;
        Sat, 28 Nov 2020 08:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2O6qcQHJ1HIADKlavbzosnF3a3wMtszkYQ/PuPl66qI=;
        b=CgE6KOyTfg3utDcRpZdx3wNg5OyhBXbYyc7PH8oa6j60BTtpQLlHDpvZodUSgtskAv
         kqzv+kzRC8gJVu60u38BrPXBYCz+1pEo0KvxCwXjcwsZBMYy4UyOWOY3pEIZ4CakN9AD
         IlOOeUveQZn2f5Ib6HdtyeE6Xd8O/3Ajz61BxBQaI2kgQLf9g57ysabjeDv/7CTlsJSV
         6GIrzobXL4pzBVG6qscprgZn16B+G8oGEPy3hSkuzq1R6I3T2JlwKWSi3WfN7MY57x/P
         zPH8/jK+/t1BSRextQVoRrJHkVB9PMJuGQ9K8ajrDnT+LwE9dGk9paNd5x5WY4BqSCif
         XnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2O6qcQHJ1HIADKlavbzosnF3a3wMtszkYQ/PuPl66qI=;
        b=sdnVo1Y4H/oHWneo5uGHyD9ra7RcE7/+VdI98aGK3dZWNbw3Bs46Ta7iBy1Ku0I84s
         w97ejLL2WE0iIaY4pTmXA3aY6BeJp3xs7WanNEpMaS45qfabQLCLcatYe98NAct3fm1m
         opuxTHND7DaKJAXJAExjvwCOGyjMkpIXKfJRT4dooWBEl6Mn0miQkmPExxYqN4CHk2WB
         +3HwKrY0ZhSvr6JlThziiG1CxDkgqgNWfhsByKEauQOWgv2CMDahdOz2ulkrsx7IBbtx
         u3MSTXUDzDDIHMQtPDIWV9tVEORlq4gC0hFHsv4vDP1egcJqClba+fyiO9p6BfCj/1zQ
         GLjQ==
X-Gm-Message-State: AOAM531NEUKXjc/wpmaX3r8IKsB4MCELi32eX7rhufAxiVzOTxSRvIZZ
        2aITcwaBGyjCwp8Rop0U9UaO6gVxi7k=
X-Google-Smtp-Source: ABdhPJwuiEos39Kd+yWnNTMmDC8yimmI7zJPon0FpMljcy6a+V40CGpf8EDqJAwgKioFXcJ84fR1pw==
X-Received: by 2002:a17:90a:f695:: with SMTP id cl21mr16872124pjb.137.1606579310741;
        Sat, 28 Nov 2020 08:01:50 -0800 (PST)
Received: from bobo.ibm.com (193-116-103-132.tpgi.com.au. [193.116.103.132])
        by smtp.gmail.com with ESMTPSA id d4sm9762607pjz.28.2020.11.28.08.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 08:01:50 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>
Subject: [PATCH 0/8] shoot lazy tlbs
Date:   Sun, 29 Nov 2020 02:01:33 +1000
Message-Id: <20201128160141.1003903-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a rebase now on top of Arnd's asm-generic tree, which has
reduced most of the fluff from this patch series.

The x86 refactoring is still in the way a bit, I hope to get some
movement on that rather than rebase the main patches off it, because
I think it's a good cleanup. I think it could go in a generic
mm/scheduler series if we get arch acks because it's really just
refactoring wrappers.

The main result is reduced contention on lazy tlb mm refcount that
helps very big systems.

Thanks,
Nick

Nicholas Piggin (8):
  lazy tlb: introduce exit_lazy_tlb
  x86: use exit_lazy_tlb rather than
    membarrier_mm_sync_core_before_usermode
  x86: remove ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
  lazy tlb: introduce lazy mm refcount helper functions
  lazy tlb: allow lazy tlb mm switching to be configurable
  lazy tlb: shoot lazies, a non-refcounting lazy tlb option
  powerpc: use lazy mm refcount helper functions
  powerpc/64s: enable MMU_LAZY_TLB_SHOOTDOWN

 .../membarrier-sync-core/arch-support.txt     |  6 +-
 arch/Kconfig                                  | 24 +++++
 arch/arm/mach-rpc/ecard.c                     |  3 +-
 arch/powerpc/Kconfig                          |  1 +
 arch/powerpc/kernel/smp.c                     |  2 +-
 arch/powerpc/mm/book3s64/radix_tlb.c          |  5 +-
 arch/x86/Kconfig                              |  1 -
 arch/x86/include/asm/mmu_context.h            | 27 ++++++
 arch/x86/kernel/alternative.c                 |  2 +-
 arch/x86/kernel/cpu/mce/core.c                |  2 +-
 drivers/misc/sgi-gru/grufault.c               |  2 +-
 drivers/misc/sgi-gru/gruhandles.c             |  2 +-
 drivers/misc/sgi-gru/grukservices.c           |  2 +-
 fs/exec.c                                     |  6 +-
 include/asm-generic/mmu_context.h             | 21 ++++
 include/linux/sched/mm.h                      | 34 ++++---
 include/linux/sync_core.h                     | 21 ----
 init/Kconfig                                  |  3 -
 kernel/cpu.c                                  |  6 +-
 kernel/exit.c                                 |  2 +-
 kernel/fork.c                                 | 53 ++++++++++
 kernel/kthread.c                              | 12 ++-
 kernel/sched/core.c                           | 97 +++++++++++++------
 kernel/sched/sched.h                          |  4 +-
 24 files changed, 247 insertions(+), 91 deletions(-)
 delete mode 100644 include/linux/sync_core.h

-- 
2.23.0

