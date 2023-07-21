Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F049375C52C
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jul 2023 13:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjGULAC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jul 2023 07:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjGUK7c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jul 2023 06:59:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0C02719;
        Fri, 21 Jul 2023 03:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=lcLLsfwzzryhPpNrplrfD7AaAzzB68vL86jiPn1J03c=; b=cqAvjtTnCh22vJ3NZdY19uUDsT
        dakjp3WQqIb36goKS8vtFbnrBGEX+A8D46mL4l+0REZrWulK7bUMhE1x9fQ3FwrnUntSuk+Xu2UxQ
        qkcNpB///bEL+HrWTuIasMjrcwrVCG2BGgegmSRiW9RyJ/2poSkGzxkGyb25iXtZzEYutcLHzkfXo
        7KFx1RgOIbRY8tl4f2BQ4Ytfp7JGSSj02vTTCJpYycrfdT7uTZCLerKV9YgNlTZRFWMS7h3GmNArb
        rcSFx2w6Gs+GCznImEvRaZdu48G4/VUb25W6NimdzeLOEcDhS190Buw03eBFpTjs0+b1vc9Dofzaa
        weE6UOCw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qMnqJ-0012OT-JX; Fri, 21 Jul 2023 10:58:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3024F3007AF;
        Fri, 21 Jul 2023 12:58:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E256F314E02ED; Fri, 21 Jul 2023 12:58:37 +0200 (CEST)
Message-ID: <20230721102237.268073801@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 21 Jul 2023 12:22:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [PATCH v1 00/14] futex: More futex2 bits
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

New version of the futex2 patches. These are actually tested and appear to work
as expected.

I'm hoping to get at least the first 3 patches merged such that Jens can base
the io_uring futex patches on them.


Changes since v0:
 - switched over to 'unsigned long' for values (Arnd)
 - unshare vmalloc_huge() (Willy)
 - added wait/requeue syscalls
 - fixed NUMA to support sparse nodemask
 - added FUTEX2_n vs FUTEX2_NUMA check to ensure
   the node_id fits in the futex
 - added selftests
 - fixed a ton of silly bugs

---
 arch/alpha/kernel/syscalls/syscall.tbl             |   3 +
 arch/arm/tools/syscall.tbl                         |   3 +
 arch/arm64/include/asm/unistd32.h                  |   6 +
 arch/ia64/kernel/syscalls/syscall.tbl              |   3 +
 arch/m68k/kernel/syscalls/syscall.tbl              |   3 +
 arch/microblaze/kernel/syscalls/syscall.tbl        |   3 +
 arch/mips/kernel/syscalls/syscall_n32.tbl          |   3 +
 arch/mips/kernel/syscalls/syscall_n64.tbl          |   3 +
 arch/mips/kernel/syscalls/syscall_o32.tbl          |   3 +
 arch/parisc/kernel/syscalls/syscall.tbl            |   3 +
 arch/powerpc/kernel/syscalls/syscall.tbl           |   3 +
 arch/s390/kernel/syscalls/syscall.tbl              |   3 +
 arch/sh/kernel/syscalls/syscall.tbl                |   3 +
 arch/sparc/kernel/syscalls/syscall.tbl             |   3 +
 arch/x86/entry/syscalls/syscall_32.tbl             |   3 +
 arch/x86/entry/syscalls/syscall_64.tbl             |   3 +
 arch/xtensa/kernel/syscalls/syscall.tbl            |   3 +
 include/linux/futex.h                              |  14 +-
 include/linux/syscalls.h                           |  10 +
 include/linux/vmalloc.h                            |   1 +
 include/uapi/asm-generic/unistd.h                  |   9 +-
 include/uapi/linux/futex.h                         |  17 +-
 kernel/futex/core.c                                | 144 +++++++++++---
 kernel/futex/futex.h                               |  96 ++++++++-
 kernel/futex/pi.c                                  |  12 +-
 kernel/futex/requeue.c                             |  18 +-
 kernel/futex/syscalls.c                            | 221 ++++++++++++++++-----
 kernel/futex/waitwake.c                            |  80 ++++----
 kernel/sys_ni.c                                    |   3 +
 mm/vmalloc.c                                       |   7 +
 .../selftests/futex/functional/futex_requeue.c     | 100 +++++++++-
 .../selftests/futex/functional/futex_wait.c        |  56 +++++-
 .../futex/functional/futex_wait_timeout.c          |  14 +-
 .../futex/functional/futex_wait_wouldblock.c       |  28 ++-
 .../selftests/futex/functional/futex_waitv.c       |  15 +-
 tools/testing/selftests/futex/functional/run.sh    |   6 +
 tools/testing/selftests/futex/include/futex2test.h |  39 ++++
 37 files changed, 777 insertions(+), 167 deletions(-)

