Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB5E6C319F
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 13:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjCUMZd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 08:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjCUMZc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 08:25:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F6A52D42;
        Tue, 21 Mar 2023 05:25:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34B13AD7;
        Tue, 21 Mar 2023 05:26:08 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CDC5D3F71E;
        Tue, 21 Mar 2023 05:25:21 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>
Cc:     agordeev@linux.ibm.com, aou@eecs.berkeley.edu, bp@alien8.de,
        dave.hansen@linux.intel.com, davem@davemloft.net,
        gor@linux.ibm.com, hca@linux.ibm.com, linux-arch@vger.kernel.org,
        linux@armlinux.org.uk, mark.rutland@arm.com, mingo@redhat.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robin.murphy@arm.com,
        tglx@linutronix.de
Subject: [PATCH v2 0/4] usercopy: generic tests + arm64 fixes
Date:   Tue, 21 Mar 2023 12:25:10 +0000
Message-Id: <20230321122514.1743889-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This series adds tests for the usercopy functions, which have found a
few issues on most architectures I've tested on. The last two patches
are fixes for arm64 (which pass all the tests, and are at least as good
performance-wise as the existing implementation).

Arch maintainers: if you are Cc'd on patches 1 or 2, I believe that your
architecture has an issue (which should be called out explicitly in the
commit message). I've only been able to test on some architectures, so
other architectures may be affected.

Al, Linus: could you double-check that I have the requirements right?
I'm going by Al's prior message at:

  https://lore.kernel.org/all/YNSyZaZtPTmTa5P8@zeniv-ca.linux.org.uk/

Which mentions the commentary in include/linux/uaccess.h:

 * If raw_copy_{to,from}_user(to, from, size) returns N, size - N bytes starting
 * at to must become equal to the bytes fetched from the corresponding area
 * starting at from.  All data past to + size - N must be left unmodified.
 *
 * If copying succeeds, the return value must be 0.  If some data cannot be
 * fetched, it is permitted to copy less than had been fetched; the only
 * hard requirement is that not storing anything at all (i.e. returning size)
 * should happen only when nothing could be copied.  In other words, you don't
 * have to squeeze as much as possible - it is allowed, but not necessary.

I've made two additional assumptions:

1) That a usercopy in a non-atomic context shouldn't have a partial
   failure if it's possible for it to succeed completely. i.e. callers
   don't need to call it in a loop if they only care about it entirely
   succeeding or failing.

   Code all over the place seems to rely upon that (e.g. signal code
   using copy_to_user() to place signal frames), so I assume this must
   be the case or we have bigger issues.

2) That clear_user() has the same requirements, given it has the same
   rough shape as raw_copy_{to,from}_user(), and I believe it's used in
   the same way in the iov_iter code (but I could be mistaken).

Since v1 [1]:
* Trivial rebase to v6.3-rc3
* Simplify the test harness
* Improve comments
* Improve commit messages
* Expand Cc list

[1] https://lore.kernel.org/lkml/20230314115030.347976-1-mark.rutland@arm.com/

Thanks,
Mark.

Mark Rutland (4):
  lib: test copy_{to,from}_user()
  lib: test clear_user()
  arm64: fix __raw_copy_to_user semantics
  arm64: fix clear_user() semantics

 arch/arm64/lib/clear_user.S   | 195 ++++++++++---
 arch/arm64/lib/copy_to_user.S | 203 +++++++++++---
 lib/Kconfig.debug             |   9 +
 lib/Makefile                  |   1 +
 lib/usercopy_kunit.c          | 506 ++++++++++++++++++++++++++++++++++
 5 files changed, 834 insertions(+), 80 deletions(-)
 create mode 100644 lib/usercopy_kunit.c

-- 
2.30.2

