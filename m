Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639874DE596
	for <lists+linux-arch@lfdr.de>; Sat, 19 Mar 2022 04:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241950AbiCSD4g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Mar 2022 23:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiCSD4g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Mar 2022 23:56:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6F7201AD;
        Fri, 18 Mar 2022 20:55:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87152B825D5;
        Sat, 19 Mar 2022 03:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB0EC340EC;
        Sat, 19 Mar 2022 03:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647662113;
        bh=YTk93zwuaGZlbGJYQpGVX2DQwDayvasBfkPYcHh8gIk=;
        h=From:To:Cc:Subject:Date:From;
        b=nKlhwcjbrbTFviWdQBTu3WNloG1jgLcDtDoTMwafpkUo0Wb84lOTYscr2NuACdEA7
         TZkKNzeVChhvA35+Ku/YlGkd8r7mIqpVTmtozurPhoWQQrGiFRInRRxoBSAXoIabeh
         Ix14wd0/aTu0OlnjrcGwqx+RRsvx1NlR8T0kx/Hv+GOoyW9S/KhCMcPbLJDmdNxFtc
         /s50rZmR5fC1vJ1YHqyIg0J1dGzOIBNthyLLoxyjJ99FbY93Y7CtdFfn2U3PFiovGB
         fKnsz5EUUnJGzuiKpsLj3VtAVyxzJZlj/a1DfpfrVdXrSuxpZ+xERjuUT+eJDpNuFv
         8f/K8jPnqs0+Q==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        boqun.feng@gmail.com, longman@redhat.com, peterz@infradead.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        openrisc@lists.librecores.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 0/5] Generic Ticket Spinlocks
Date:   Sat, 19 Mar 2022 11:54:52 +0800
Message-Id: <20220319035457.2214979-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Palmer:
Peter sent an RFC out about a year ago
<https://lore.kernel.org/lkml/YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net/>,
but after a spirited discussion it looks like we lost track of things.
IIRC there was broad consensus on this being the way to go, but there
was a lot of discussion so I wasn't sure.  Given that it's been a year,
I figured it'd be best to just send this out again formatted a bit more
explicitly as a patch.

This has had almost no testing (just a build test on RISC-V defconfig),
but I wanted to send it out largely as-is because I didn't have a SOB
from Peter on the code.  I had sent around something sort of similar in
spirit, but this looks completely re-written.  Just to play it safe I
wanted to send out almost exactly as it was posted.  I'd probably rename
this tspinlock and tspinlock_types, as the mis-match kind of makes my
eyes go funny, but I don't really care that much.  I'll also go through
the other ports and see if there's any more candidates, I seem to
remember there having been more than just OpenRISC but it's been a
while.

I'm in no big rush for this and given the complex HW dependencies I
think it's best to target it for 5.19, that'd give us a full merge
window for folks to test/benchmark it on their systems to make sure it's
OK.  RISC-V has a forward progress guarantee so we should be safe, but
these can always trip things up.

Guo:
Update V2 with Arnd's suggestion [1].

[1] https://lore.kernel.org/linux-arch/CAK8P3a0NMPVGVw7===uEOtNnu1hr1GqimMbZT+Kea1CUxRvPmw@mail.gmail.com/raw

Changes in V2:
 - Follow Arnd suggestion to make the patch series more generic.
 - Add csky in the series.
 - Combine RISC-V's two patches into one.
 - Modify openrisc's patch to suit the new generic version.

Guo Ren (1):
  csky: Move to generic ticket-spinlock

Palmer Dabbelt (1):
  RISC-V: Move to ticket-spinlocks & RW locks

Peter Zijlstra (3):
  asm-generic: ticket-lock: New generic ticket-based spinlock
  asm-generic: qspinlock: Indicate the use of mixed-size atomics
  openrisc: Move to ticket-spinlock

 arch/csky/include/asm/Kbuild               |   3 +-
 arch/csky/include/asm/spinlock.h           |  89 --------------
 arch/csky/include/asm/spinlock_types.h     |  27 -----
 arch/openrisc/Kconfig                      |   1 -
 arch/openrisc/include/asm/Kbuild           |   7 +-
 arch/openrisc/include/asm/spinlock.h       |  27 -----
 arch/openrisc/include/asm/spinlock_types.h |   7 --
 arch/riscv/Kconfig                         |   1 +
 arch/riscv/include/asm/Kbuild              |   2 +
 arch/riscv/include/asm/spinlock.h          | 135 ---------------------
 arch/riscv/include/asm/spinlock_types.h    |  25 ----
 include/asm-generic/qspinlock.h            |  30 +++++
 include/asm-generic/spinlock.h             |  11 +-
 include/asm-generic/spinlock_types.h       |  15 +++
 include/asm-generic/ticket-lock-types.h    |  11 ++
 include/asm-generic/ticket-lock.h          |  86 +++++++++++++
 16 files changed, 157 insertions(+), 320 deletions(-)
 delete mode 100644 arch/csky/include/asm/spinlock.h
 delete mode 100644 arch/csky/include/asm/spinlock_types.h
 delete mode 100644 arch/openrisc/include/asm/spinlock.h
 delete mode 100644 arch/openrisc/include/asm/spinlock_types.h
 delete mode 100644 arch/riscv/include/asm/spinlock.h
 delete mode 100644 arch/riscv/include/asm/spinlock_types.h
 create mode 100644 include/asm-generic/spinlock_types.h
 create mode 100644 include/asm-generic/ticket-lock-types.h
 create mode 100644 include/asm-generic/ticket-lock.h

-- 
2.25.1

