Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12EF71B2AD6
	for <lists+linux-arch@lfdr.de>; Tue, 21 Apr 2020 17:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgDUPPp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Apr 2020 11:15:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgDUPPo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Apr 2020 11:15:44 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E21C2068F;
        Tue, 21 Apr 2020 15:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587482144;
        bh=+aKgLByQ6UXETds4VE4kQnDmFrOnvCT2cUPD0WVnbAo=;
        h=From:To:Cc:Subject:Date:From;
        b=ddXe43JOrjtoi1DTBU1xzqgc4LsnhmTLdzMIrIwySjZ3rf38YOLUCKRWL3IM+Qj+7
         VVkklbclK8M3q51/hScO1lReoMYyFyja15EUbnfk0JQuIygF0Aozn4NUO/IE4lx/N+
         meBX291yBiSTObAqCVdeOBlMvCDa5JT2u60cY4Sw=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
Subject: [PATCH v4 00/11] Rework READ_ONCE() to improve codegen
Date:   Tue, 21 Apr 2020 16:15:26 +0100
Message-Id: <20200421151537.19241-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

It's me again. This is version four of the READ_ONCE() codegen improvement
patches that I previously posted here:

RFC: https://lore.kernel.org/lkml/20200110165636.28035-1-will@kernel.org
v2:  https://lore.kernel.org/lkml/20200123153341.19947-1-will@kernel.org
v3:  https://lore.kernel.org/lkml/20200415165218.20251-1-will@kernel.org/

Changes since v3 include:

  * Drop the patch warning for GCC versions prior to 4.8
  * Move the patch raising the minimum GCC version earlier in the series
  * Reintroduce the old READ_ONCE_NOCHECK behaviour so that it can continue
    to be used by stack unwinders

As before, this will break the build for sparc32 without the changes here:

  https://lore.kernel.org/lkml/20200414214011.2699-1-will@kernel.org

and boy are they proving to be popular (I'm interpreting the silence as
monumental joy).

Ta,

Will

Cc: Mark Rutland <mark.rutland@arm.com>
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

Will Deacon (11):
  compiler/gcc: Raise minimum GCC version for kernel builds to 4.8
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
  gcov: Remove old GCC 3.4 support

 Documentation/process/changes.rst |   2 +-
 arch/arm/crypto/Kconfig           |  12 +-
 arch/arm64/include/asm/barrier.h  |  16 +-
 arch/arm64/lib/csum.c             |  20 +-
 crypto/Kconfig                    |   1 -
 drivers/xen/time.c                |   2 +-
 include/asm-generic/barrier.h     |  16 +-
 include/linux/compiler-gcc.h      |   5 +-
 include/linux/compiler.h          | 145 ++++----
 include/linux/compiler_types.h    |  21 ++
 init/Kconfig                      |   1 -
 kernel/gcov/Kconfig               |  24 --
 kernel/gcov/Makefile              |   3 +-
 kernel/gcov/gcc_3_4.c             | 573 ------------------------------
 lib/fault-inject.c                |   4 +-
 net/netfilter/core.c              |   2 +-
 net/tls/tls_main.c                |   2 +-
 scripts/gcc-plugins/Kconfig       |   2 +-
 18 files changed, 132 insertions(+), 719 deletions(-)
 delete mode 100644 kernel/gcov/gcc_3_4.c

-- 
2.26.1.301.g55bc3eb7cb9-goog

