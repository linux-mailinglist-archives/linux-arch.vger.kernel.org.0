Return-Path: <linux-arch+bounces-7365-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB16797ED03
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2024 16:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A252829E9
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2024 14:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873FF19DF48;
	Mon, 23 Sep 2024 14:19:54 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368BE19DF4D;
	Mon, 23 Sep 2024 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727101194; cv=none; b=Gx/6Upmnumbxw+B92I3URr57rFhG/7/j6639VaRCu7gy9m66V2yvbQ3m+sHn8gei0uVDQagRn5A1P6UToyao0JuY6qTJSikp13nSXq3ZxNEBcuJXw0ieHW6gCizcmj+ofn02Luex2vBm2XytYm7mJi6Gdfm6VYlB6Ve4RdwRnm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727101194; c=relaxed/simple;
	bh=HE9XapyKDp/Lx/cb8T6Xc5488xqHzYgWFyFVytf/0EM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CmEhAW/6M0T3BbUUEJSsC7rrGx0zh0IoIHIKHp9mcHEvHjVlYEPA9QcaXDEoSmYrW3krfUAV1FpR5vu8p3CoHfnXm6FKTEtau+PbgG+5sW719Od/fsCu4270cDs71ozZkIGSO2rTmhgNdU0rg3YOiXIO4yBgxdv2UsScwRVUrG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78EA5FEC;
	Mon, 23 Sep 2024 07:20:19 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CD8A3F64C;
	Mon, 23 Sep 2024 07:19:47 -0700 (PDT)
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
Subject: [PATCH v2 0/8] vdso: Use only headers from the vdso/ namespace
Date: Mon, 23 Sep 2024 15:19:35 +0100
Message-Id: <20240923141943.133551-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recent implementation of getrandom in the generic vdso library,
includes headers from outside of the vdso/ namespace.

The purpose of this patch series is to refactor the code to make sure
that the library uses only the allowed namespace.

The series has been rebased on [1] to simplify the testing. 

[1] git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git master

Changes:
--------
v2:
  - Added common PAGE_SIZE and PAGE_MASK definitions.
  - Added opencoded macros where not defined.
  - Dropped VDSO_PAGE_* redefinitions.

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

Vincenzo Frascino (8):
  x86: vdso: Introduce asm/vdso/mman.h
  arm64: vdso: Introduce asm/vdso/mman.h
  vdso: Introduce vdso/mman.h
  vdso: Introduce vdso/page.h
  x86: vdso: Modify asm/vdso/getrandom.h to include datapage
  vdso: Modify vdso/getrandom.h to include the asm header
  vdso: Introduce uapi/vdso/random.h
  vdso: Modify getrandom to include the correct namespace.

 arch/alpha/include/asm/page.h         |  6 +----
 arch/arc/include/uapi/asm/page.h      |  7 +++--
 arch/arm/include/asm/page.h           |  5 +---
 arch/arm64/include/asm/page-def.h     |  5 +---
 arch/arm64/include/asm/vdso/mman.h    | 15 +++++++++++
 arch/csky/include/asm/page.h          |  8 ++----
 arch/hexagon/include/asm/page.h       |  4 +--
 arch/loongarch/include/asm/page.h     |  7 +----
 arch/m68k/include/asm/page.h          |  6 ++---
 arch/microblaze/include/asm/page.h    |  5 +---
 arch/mips/include/asm/page.h          |  7 +----
 arch/nios2/include/asm/page.h         |  7 +----
 arch/openrisc/include/asm/page.h      | 11 +-------
 arch/parisc/include/asm/page.h        |  4 +--
 arch/powerpc/include/asm/page.h       | 10 +------
 arch/riscv/include/asm/page.h         |  4 +--
 arch/s390/include/asm/page.h          |  4 +--
 arch/sh/include/asm/page.h            |  6 ++---
 arch/sparc/include/asm/page_32.h      |  4 +--
 arch/sparc/include/asm/page_64.h      |  4 +--
 arch/um/include/asm/page.h            |  5 +---
 arch/x86/include/asm/page_types.h     |  5 +---
 arch/x86/include/asm/vdso/getrandom.h |  2 ++
 arch/x86/include/asm/vdso/mman.h      | 15 +++++++++++
 arch/xtensa/include/asm/page.h        |  8 +-----
 include/uapi/linux/random.h           | 26 +-----------------
 include/uapi/vdso/random.h            | 38 +++++++++++++++++++++++++++
 include/vdso/datapage.h               |  2 ++
 include/vdso/getrandom.h              |  1 +
 include/vdso/mman.h                   |  7 +++++
 include/vdso/page.h                   | 18 +++++++++++++
 lib/vdso/getrandom.c                  | 22 ++++++++--------
 32 files changed, 137 insertions(+), 141 deletions(-)
 create mode 100644 arch/arm64/include/asm/vdso/mman.h
 create mode 100644 arch/x86/include/asm/vdso/mman.h
 create mode 100644 include/uapi/vdso/random.h
 create mode 100644 include/vdso/mman.h
 create mode 100644 include/vdso/page.h

-- 
2.34.1


