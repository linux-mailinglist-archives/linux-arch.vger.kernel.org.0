Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99C31AAEC8
	for <lists+linux-arch@lfdr.de>; Wed, 15 Apr 2020 18:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410481AbgDOQwu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Apr 2020 12:52:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410478AbgDOQwt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Apr 2020 12:52:49 -0400
Received: from localhost.localdomain (unknown [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29EED20737;
        Wed, 15 Apr 2020 16:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586969568;
        bh=MBTHGFuyd6RkQ3mM9tXpCw5qvy6Khusn8uo3qKblggE=;
        h=From:To:Cc:Subject:Date:From;
        b=sZnKIEafLDe3NdRw0M16kTS1yp9wM/RpCYwALwJm6Wb4JytGDxVyhNcexnnI7Mqk9
         CBUg1bVfYaFjIzM3hHOOTQUG5VVoiRHDBsBEF9m+kbX/KWPQff0/mDp8nEQvRC7d5L
         UJ7vJo8xAT4lr8vpQvb0ELDatkf8ZJOLS9QPOSoY=
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
Subject: [PATCH v3 00/12] Rework READ_ONCE() to improve codegen
Date:   Wed, 15 Apr 2020 17:52:06 +0100
Message-Id: <20200415165218.20251-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi everyone,

This is version three of the patches I previously posted for improving
the code generation of READ_ONCE() and moving the minimum GCC version
to 4.8:

RFC: https://lore.kernel.org/lkml/20200110165636.28035-1-will@kernel.org
v2:  https://lore.kernel.org/lkml/20200123153341.19947-1-will@kernel.org

Although v2 was queued up by Peter in -tip, it was found to break the
build for m68k and sparc32. We fixed m68k during the merge window and
I've since posted patches to fix sparc32 here:

  https://lore.kernel.org/lkml/20200414214011.2699-1-will@kernel.org

This series is a refresh on top of 5.7-rc1, the main changes being:

  * Fix another issue where 'const' is assigned to non-const via
    WRITE_ONCE(), this time in the tls code

  * Fix READ_ONCE_NOCHECK() abuse in arm64 checksum code

  * Added Reviewed-bys and Acks from v2

Hopefully this can be considered for 5.8, along with the sparc32 changes.

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

Will Deacon (12):
  compiler/gcc: Emit build-time warning for GCC prior to version 4.8
  netfilter: Avoid assigning 'const' pointer to non-const pointer
  net: tls: Avoid assigning 'const' pointer to non-const pointer
  fault_inject: Don't rely on "return value" from WRITE_ONCE()
  arm64: csum: Disable KASAN for do_csum()
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
 arch/arm64/lib/csum.c             |  20 +-
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
 net/tls/tls_main.c                |   2 +-
 scripts/Kconfig.include           |   6 +
 scripts/gcc-plugins/Kconfig       |   2 +-
 19 files changed, 126 insertions(+), 719 deletions(-)
 delete mode 100644 kernel/gcov/gcc_3_4.c

-- 
2.26.0.110.g2183baf09c-goog

