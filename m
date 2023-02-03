Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B79C6890A0
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 08:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjBCHTA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 02:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjBCHS7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 02:18:59 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC2D921A6
        for <linux-arch@vger.kernel.org>; Thu,  2 Feb 2023 23:18:55 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id mi9so4184353pjb.4
        for <linux-arch@vger.kernel.org>; Thu, 02 Feb 2023 23:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FLYNxN+89Z9I2MvycqY9goYhkfwarRJMT/94Xq9kdE4=;
        b=fknWjk6dL5edxfKxDS5Rs5o8++Qprn0+hg/MmDkKE/a3jok8QnDK4GXiRe2ULmBeBb
         r3AuZ/P9LO8LzKC9NfLKoesrb9aZHs64mLBnC24H1Czlpx7VypPdpfU0qNMI+lIwPDma
         8leU9efusRQrRNFqgL0/9ES/Oktaei06ROJx9nOPXjjV8ygBOXdXf68QcQBQFGNZQoxx
         zL5/x4XAHO6NyoNRy7qX8L/1OtMC5tu/lQ3zY7P0RnL8Sa0/pIWrHTFCLfhYx+gp3SQC
         r4sCVpiPX5GoJ6flZz5XYEM23RAQ6PCuB/FhPZS8G0B/9Lv4MihQxroiH169o+4gRXxU
         Y1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLYNxN+89Z9I2MvycqY9goYhkfwarRJMT/94Xq9kdE4=;
        b=ixyjoN0WKzQIY5BXnCKWrlh/vjxGN4Ka3jT8VA4H4tHpMx6ZCQ+RTO56osDjTxg2sF
         i5HRaIJ0LGqs3RBPTCKVgdWeAkp1LSkzpaCGcpJW3PL/W5Ln253970AWwX6tIZEQlOdH
         lrfWJfxREKMoG5sxEocHv0FnugRRJVyKjsp+vTwu5e4/6Hn81k8OAOke8qQ4fqAsCWhp
         BxfrxSEkvU/SNu0lxMp9XCGL9DfJ8PJ489YZohY3sxIbMPqsxgnoM+ozWYo2DUZSWAZV
         r5e20AxWNUZm9kNOjURY/U8lL6H4W/CcD1ltD1o2R9savSv0+BhQVmPr7Vx7hvuqcinR
         reLA==
X-Gm-Message-State: AO0yUKUTxlKzSjsO67Em/iIw/Qpk6qrTMLLTkULjs2dxiYFo2bOyf3r7
        eryEccqlbrwASECsrRmOxLY=
X-Google-Smtp-Source: AK7set8UmQdNB4VaSy6Fxb5wxUcSBgBrZDhP2Lw7G1Jnu8w+a6SsBl4amQbJ+dEOBbUxVNaibU8ezg==
X-Received: by 2002:a05:6a20:548c:b0:be:a082:670f with SMTP id i12-20020a056a20548c00b000bea082670fmr4974581pzk.28.1675408734548;
        Thu, 02 Feb 2023 23:18:54 -0800 (PST)
Received: from bobo.ibm.com (193-116-117-77.tpgi.com.au. [193.116.117.77])
        by smtp.gmail.com with ESMTPSA id f20-20020a637554000000b004df4ba1ebfesm877558pgn.66.2023.02.02.23.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 23:18:54 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Rik van Riel <riel@redhat.com>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v7 0/5] shoot lazy tlbs (lazy tlb refcount scalability improvement)
Date:   Fri,  3 Feb 2023 17:18:32 +1000
Message-Id: <20230203071837.1136453-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

(Sorry about the double send)

Hi Andrew,

This series improves scalability of context switching between user and
kernel threads on large systems with a threaded process spread across a
lot of CPUs.

Please consider these patches for mm. Discussion of v6 here:

https://lore.kernel.org/linux-mm/20230118080011.2258375-1-npiggin@gmail.com/

No objections so far, Linus think they look okay in principle but has
not reviewed in detail.

With the exception of patch 1, there should be no functional change
on non-powerpc archs with this series.

Changes since v6:
- Dropped the final patch to optimise powerpc more, as mentioned this
  will be taken through the powerpc tree after the base series is
  upstream.
- Split the first patch into patch 1 and 2 in this series so the
  functional change is isolated to minimal patch.
- Removed ifdefs and churn from sched/core.c that were not required
  because ifdefs in .h refcount functions do the same job.
- Split DEBUG_VM option out to its own sub-option because it IPIs all
  CPUs on on every process exit which is pretty heavy.
- Changed comment style as noted by Nadav.
- Added description about how to test it, requested by Linus.
- Added link and credit to Rik's earlier work in the same vein.
- Did a pass over comments and changelogs to improve readability.

Nicholas Piggin (5):
  kthread: simplify kthread_use_mm refcounting
  lazy tlb: introduce lazy tlb mm refcount helper functions
  lazy tlb: allow lazy tlb mm refcounting to be configurable
  lazy tlb: shoot lazies, non-refcounting lazy tlb mm reference handling
    scheme
  powerpc/64s: enable MMU_LAZY_TLB_SHOOTDOWN

 Documentation/mm/active_mm.rst       |  6 +++
 arch/Kconfig                         | 32 ++++++++++++++
 arch/arm/mach-rpc/ecard.c            |  2 +-
 arch/powerpc/Kconfig                 |  1 +
 arch/powerpc/kernel/smp.c            |  2 +-
 arch/powerpc/mm/book3s64/radix_tlb.c |  4 +-
 fs/exec.c                            |  2 +-
 include/linux/sched/mm.h             | 28 ++++++++++++
 kernel/cpu.c                         |  2 +-
 kernel/exit.c                        |  2 +-
 kernel/fork.c                        | 65 ++++++++++++++++++++++++++++
 kernel/kthread.c                     | 22 ++++++----
 kernel/sched/core.c                  | 15 ++++---
 lib/Kconfig.debug                    | 10 +++++
 14 files changed, 170 insertions(+), 23 deletions(-)

-- 
2.37.2

