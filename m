Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 117B6146CEC
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 16:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgAWPdw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 10:33:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:51436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgAWPdw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jan 2020 10:33:52 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD09E20684;
        Thu, 23 Jan 2020 15:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579793631;
        bh=o6EdoWvDjV0sQGp9eCNVL9r+skCvy+Ya6kW6vxPyTyE=;
        h=From:To:Cc:Subject:Date:From;
        b=eVJ0ruE/2Tz0FXXq4dYDrnMPg44Hx3JW5424ZttDI5YrS5iGeA4hZ4cd6LnRSSeFP
         Yxdq/fqHUA+9YoiUGznrIEuwAAIZBrABumYTxs0BHqHzWsoYY1Re+BraooqllFjP7G
         RDmgA3eswTIP8bEhFG7WROAQeI4ZpOsq1kbjjkEk=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
Date:   Thu, 23 Jan 2020 15:33:31 +0000
Message-Id: <20200123153341.19947-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi folks,

This is version two of the patches I previously posted as an RFC here:

https://lore.kernel.org/lkml/20200110165636.28035-1-will@kernel.org

Changes since then include:

  * Adopted a less vomit-inducing series of macros for __unqual_scalar_typeof

  * Cast to 'const' in READ_ONCE() to prevent assignment to the resulting
    expression

  * Only warn once at build-time if GCC prior to 4.8 is detected...

  * ... and then raise the minimum GCC version to 4.8, with an error for
    older versions of the compiler

  * Remove some dead gcov code so that the resulting diffstat can distract
    from those less vomit-inducing macros I mentioned earlier on

Failing the build for older compilers is always a contentious topic, so
I've done that as a separate couple of patches on the end in case we end
up dropping or reverting them.

Cheers,

Will

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>

--->8

Will Deacon (10):
  compiler/gcc: Emit build-time warning for GCC prior to version 4.8
  netfilter: Avoid assigning 'const' pointer to non-const pointer
  fault_inject: Don't rely on "return value" from WRITE_ONCE()
  READ_ONCE: Simplify implementations of {READ,WRITE}_ONCE()
  READ_ONCE: Enforce atomicity for {READ,WRITE}_ONCE() memory accesses
  READ_ONCE: Drop pointer qualifiers when reading from scalar types
  locking/barriers: Use '__unqual_scalar_typeof' for load-acquire macros
  arm64: barrier: Use '__unqual_scalar_typeof' for acquire/release
    macros
  compiler/gcc: Raise minimum GCC version for kernel builds to 4.8
  gcov: Remove old GCC 3.4 support

 Documentation/process/changes.rst |   2 +-
 arch/arm/crypto/Kconfig           |  12 +-
 arch/arm64/include/asm/barrier.h  |  16 +-
 crypto/Kconfig                    |   1 -
 drivers/xen/time.c                |   2 +-
 include/asm-generic/barrier.h     |  16 +-
 include/linux/compiler-gcc.h      |   5 +-
 include/linux/compiler.h          | 129 +++----
 include/linux/compiler_types.h    |  21 ++
 init/Kconfig                      |   5 +-
 kernel/gcov/Kconfig               |  24 --
 kernel/gcov/Makefile              |   3 +-
 kernel/gcov/gcc_3_4.c             | 573 ------------------------------
 lib/fault-inject.c                |   4 +-
 net/netfilter/core.c              |   2 +-
 net/xdp/xsk_queue.h               |   2 +-
 scripts/Kconfig.include           |   3 +
 scripts/gcc-plugins/Kconfig       |   4 +-
 18 files changed, 111 insertions(+), 713 deletions(-)
 delete mode 100644 kernel/gcov/gcc_3_4.c

-- 
2.25.0.341.g760bfbb309-goog

