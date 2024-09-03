Return-Path: <linux-arch+bounces-6950-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1B896A1D0
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 17:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0FB1C24030
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 15:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63989186E3D;
	Tue,  3 Sep 2024 15:14:57 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3B918453F;
	Tue,  3 Sep 2024 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376497; cv=none; b=cFpVFbI2FmkATcJTxSfniwFI0Lzc5rvQEAnn+tfA4EUZgsfYaaGrWx9eHi4Hc5zEPKExHVyOi9l+qog7sNqn660njjbIXa3yoB6q7+vDcAxlXboOkaulA4Df8231yM9uvsdzzKi8lAZ0pXSEoWTjQfyqtzPuIq33D5my08yqX0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376497; c=relaxed/simple;
	bh=hISohSaroQVPWad+7oMz3hmA7ruIT1tsYMKvbsgf3so=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TlEGOtSEj9fdkUBF6+X0rm+Ldi/VDzSdb5b/9Uk1r64HOpK2aaGEcSNhA4dMpK/UfLPP05bm9wP8+d/LmGEZT+OqIJdpIyQtaldtthsUowq+QQpekdClwdtlR3r8tmFOG5vEXIko2KStXTwSz63eiXuLVHpaBBUyUOWDQBPzVNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1F08FEC;
	Tue,  3 Sep 2024 08:15:20 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A8253F66E;
	Tue,  3 Sep 2024 08:14:51 -0700 (PDT)
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
Subject: [PATCH 0/9] vdso: Use only headers from the vdso/ namespace
Date: Tue,  3 Sep 2024 16:14:28 +0100
Message-Id: <20240903151437.1002990-1-vincenzo.frascino@arm.com>
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

Vincenzo Frascino (9):
  x86: vdso: Introduce asm/vdso/mman.h
  vdso: Introduce vdso/mman.h
  x86: vdso: Introduce asm/vdso/page.h
  vdso: Introduce vdso/page.h
  vdso: Split linux/minmax.h
  vdso: Split linux/array_size.h
  x86: vdso: Modify asm/vdso/getrandom.h to include datapage
  vdso: Modify vdso/getrandom.h to include the asm header
  vdso: Modify getrandom to include the correct namespace

 arch/x86/include/asm/vdso/getrandom.h |  2 ++
 arch/x86/include/asm/vdso/mman.h      | 15 +++++++++++
 arch/x86/include/asm/vdso/page.h      | 15 +++++++++++
 include/linux/array_size.h            |  8 +-----
 include/linux/minmax.h                | 28 +-------------------
 include/vdso/array_size.h             | 13 +++++++++
 include/vdso/getrandom.h              |  1 +
 include/vdso/minmax.h                 | 38 +++++++++++++++++++++++++++
 include/vdso/mman.h                   |  7 +++++
 include/vdso/page.h                   |  7 +++++
 lib/vdso/getrandom.c                  | 22 ++++++----------
 11 files changed, 108 insertions(+), 48 deletions(-)
 create mode 100644 arch/x86/include/asm/vdso/mman.h
 create mode 100644 arch/x86/include/asm/vdso/page.h
 create mode 100644 include/vdso/array_size.h
 create mode 100644 include/vdso/minmax.h
 create mode 100644 include/vdso/mman.h
 create mode 100644 include/vdso/page.h

-- 
2.34.1


