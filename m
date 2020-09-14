Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC9C2683C2
	for <lists+linux-arch@lfdr.de>; Mon, 14 Sep 2020 06:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgINEwi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Sep 2020 00:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgINEwg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Sep 2020 00:52:36 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF83EC06174A;
        Sun, 13 Sep 2020 21:52:36 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z19so11540741pfn.8;
        Sun, 13 Sep 2020 21:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Q2Ibfk+nQZOW1cqQJ9txIYMhLv+gj4Sy6xqSd9DmWA=;
        b=ejUmrq8Iadf/nWh/k76D9SUjpOWREHXHs/sYszqAIcXvWn01J7LU9SavyNRh5tf3We
         lVdoabqUUuvksTLGvX+nfyOWpdUmbRFmMexlOsIelNCjlPaujuQQhoklVQMjIPZ2LN4U
         lmOAFYsu0p+t6RtwKv1lQhr5H2D9f3RXh/oZkyYldfDPLBwQ3N9LYwG76Y0w6emjqbaR
         THE69ZZ8qCk8byO69uE5yMU8a9cFyS6mbn5LAa5BGhVTRy0r/GDvtIr0lxOhOul8+7dI
         LwlWZgqot0gPmX0nHiFVt7KvA+rW4IJBUkcEAGNxRIrWg734wU3s8k22KSwfcP6FP16q
         5PUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Q2Ibfk+nQZOW1cqQJ9txIYMhLv+gj4Sy6xqSd9DmWA=;
        b=ZqFvrTJNu6uKc8AHei1dxBB5N4UHqrq8xpygM4wgKj5pK+1UMK5BHroO7u406G42ES
         clS/N1UuP2trAAM4Uk1kR4z3uy20unWn57ckJB/1SBMthd8uavCNt9pJBCcbrGm+VJb1
         cUM94oWDv7UmND0u8aJq+KlKekVWlmQreOeK1eNlQGt1uSq7nyjk9NTSGyvGnR2pkEPt
         aLWZ1TJhZ0TMhXYisiLVWrO9gVCHQlCkbFUGQejgNQ3Uu7LH05oxrYLQYx/kxq0S6hm6
         Yu3ocQwbVLjMQlP8zrafg2KqJTaWhl0BsNC18BjFR2567h5/h38qSIn5j47XV30/1tF7
         qTyA==
X-Gm-Message-State: AOAM533H5M3BUUWWoyLNpz8MstcLPlbh8uZKPrWSFys5zVrhcpn28usx
        GeSgWiwWCWiu3kUPRRH0xhM=
X-Google-Smtp-Source: ABdhPJzFrz8mmf96fURpM3KuwwEgUYQJyVtYlAsIcvS5cLVagsaDZEbOGwmLwgd4u8HXatYEzUDalg==
X-Received: by 2002:a63:524a:: with SMTP id s10mr3316432pgl.40.1600059156171;
        Sun, 13 Sep 2020 21:52:36 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id a13sm6945312pgq.41.2020.09.13.21.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 21:52:35 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     "linux-mm @ kvack . org" <linux-mm@kvack.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH v2 0/4] more mm switching vs TLB shootdown and lazy tlb fixes
Date:   Mon, 14 Sep 2020 14:52:15 +1000
Message-Id: <20200914045219.3736466-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an attempt to fix a few different related issues around
switching mm, TLB flushing, and lazy tlb mm handling.

This will require all architectures to eventually move to disabling
irqs over activate_mm, but it's possible we could add another arch
call after irqs are re-enabled for those few which can't do their
entire activation with irqs disabled.

Testing so far indicates this has fixed a mm refcounting bug that
powerpc was running into (via distro report and backport). I haven't
had any real feedback on this series outside powerpc (and it doesn't
really affect other archs), so I propose patches 1,2,4 go via the
powerpc tree.

There is no dependency between them and patch 3, I put it there only
because it follows the history of the code (powerpc code was written
using the sparc64 logic), but I guess they have to go via different arch
trees. Dave, I'll leave patch 3 with you.

Thanks,
Nick

Since v1:
- Updates from Michael Ellerman's review comments.

Nicholas Piggin (4):
  mm: fix exec activate_mm vs TLB shootdown and lazy tlb switching race
  powerpc: select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
  sparc64: remove mm_cpumask clearing to fix kthread_use_mm race
  powerpc/64s/radix: Fix mm_cpumask trimming race vs kthread_use_mm

 arch/Kconfig                           |  7 +++
 arch/powerpc/Kconfig                   |  1 +
 arch/powerpc/include/asm/mmu_context.h |  2 +-
 arch/powerpc/include/asm/tlb.h         | 13 ------
 arch/powerpc/mm/book3s64/radix_tlb.c   | 23 ++++++---
 arch/sparc/kernel/smp_64.c             | 65 ++++++--------------------
 fs/exec.c                              | 17 ++++++-
 7 files changed, 54 insertions(+), 74 deletions(-)

-- 
2.23.0

