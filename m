Return-Path: <linux-arch+bounces-7655-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E247998F297
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 17:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D84281897
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 15:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A9C1A265E;
	Thu,  3 Oct 2024 15:29:23 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BE21A0708;
	Thu,  3 Oct 2024 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727969363; cv=none; b=Q1UVfek78LmnjWtujrHCD7Kzd2KNaNIPKt8snVx7OuhB7H2JdTYrwL/YLVadP6fOZiyYiQ7mP5fX69hLgmgTeRgqxo/lyw0x1qqQOSrxGDYdLJRtSdgiijmaDssNsArFjLrdg1T66Cr06RMXycSdvIuZE3hbQi45092mBE3E40s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727969363; c=relaxed/simple;
	bh=pII1JQEUEe3l4XrTYQ16aKUPeSkG/WGB8VqvHkfyi34=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fg9GoPNQeEY/0Oz+HI4vAk6QfmpseuQbewz7QY9mR8nkX7tUa89hyC5VPqmCXTM0SPmL+BAhwkefKMhtT0rI0vuFSizZaj4obPlqd0lzzV7cyO4hoA7kQhLnlkXGSgNructrlPisLMMNp/tj3xtT9i2IINyLVcfwJ+G0hOt6x0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC383339;
	Thu,  3 Oct 2024 08:29:49 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 803283F640;
	Thu,  3 Oct 2024 08:29:17 -0700 (PDT)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v3 0/2] vdso: Use only headers from the vdso/ namespace
Date: Thu,  3 Oct 2024 16:29:08 +0100
Message-Id: <20241003152910.3287259-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The recent implementation of getrandom in the generic vdso library,
includes headers from outside of the vdso/ namespace.

The purpose of this patch series is to refactor the code to make sure
that the library uses only the allowed namespace.

The series has been rebased on [1] to simplify the testing. 

[1] git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git master

Changes:
--------
v3:
  - Discard vdso/mman.h changes in favor of [2].
  - Refactor vdso/page.h.
  - Add a fix to drm/intel_gt.
v2:
  - Added common PAGE_SIZE and PAGE_MASK definitions.
  - Added opencoded macros where not defined.
  - Dropped VDSO_PAGE_* redefinitions.

[2] https://lore.kernel.org/lkml/20240925210615.2572360-1-arnd@kernel.org

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Vincenzo Frascino (2):
  drm: Fix fault format
  vdso: Introduce vdso/page.h

 arch/alpha/include/asm/page.h      |  6 +-----
 arch/arc/include/uapi/asm/page.h   |  7 +++----
 arch/arm/include/asm/page.h        |  5 +----
 arch/arm64/include/asm/page-def.h  |  5 +----
 arch/csky/include/asm/page.h       |  8 ++------
 arch/hexagon/include/asm/page.h    |  4 +---
 arch/loongarch/include/asm/page.h  |  7 +------
 arch/m68k/include/asm/page.h       |  6 ++----
 arch/microblaze/include/asm/page.h |  5 +----
 arch/mips/include/asm/page.h       |  7 +------
 arch/nios2/include/asm/page.h      |  7 +------
 arch/openrisc/include/asm/page.h   | 11 +----------
 arch/parisc/include/asm/page.h     |  4 +---
 arch/powerpc/include/asm/page.h    | 10 +---------
 arch/riscv/include/asm/page.h      |  4 +---
 arch/s390/include/asm/page.h       |  4 +---
 arch/sh/include/asm/page.h         |  6 ++----
 arch/sparc/include/asm/page_32.h   |  4 +---
 arch/sparc/include/asm/page_64.h   |  4 +---
 arch/um/include/asm/page.h         |  5 +----
 arch/x86/include/asm/page_types.h  |  5 +----
 arch/xtensa/include/asm/page.h     |  8 +-------
 drivers/gpu/drm/i915/gt/intel_gt.c |  2 +-
 include/vdso/page.h                | 23 +++++++++++++++++++++++
 24 files changed, 51 insertions(+), 106 deletions(-)
 create mode 100644 include/vdso/page.h

-- 
2.34.1


