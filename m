Return-Path: <linux-arch+bounces-7562-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1629E98C651
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 21:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30A02822D5
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 19:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A99E1CCB45;
	Tue,  1 Oct 2024 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rjKI26XN"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160FE19D894;
	Tue,  1 Oct 2024 19:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727812384; cv=none; b=GZ7gV/YrdN5H0WoUACAmdz42puZLQLafd+2zYhBFDULFxDL6kRbiCzbqPU3oU7B60jr1dq1a0aiXCgtAztX3ZijkL0EtA50hgks7M85/Dl+N9KPUN8Vgr9Ha0WaawvRwAH6va8WshKmAcUuCvScu22yQPmL1tb8ATo/6XB+wAMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727812384; c=relaxed/simple;
	bh=m1fCNDHHE5yacpCqSDEonHrjUjBQyDnJZdVlgbWMXaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNV4OUv4tWrkUqySSBVWGcz3uTIjzlbH6KvlCcTNBbzp8YDsYubAuF5s5QnS+FhJNAhchGjOAHk+rw11v+BZ25YtUNQocQYGi7pWL6ZzkxmKRvyWwnJHOrwVATbzBoM+KkmZHZ3iebNC7pp1aTGXsmrGXPbWXc2ZVXqM3Gd8M18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rjKI26XN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5EVxBGPp7KGspKutgQuR6iCITjad0JGZJJIjxk3aigs=; b=rjKI26XNH4mwnLSIiAR6/5K4Yf
	3XsMqr1A1taSsSeYitGtdIwkYfU33jONiNJU75qEftLrjZnGpIxpCbIhrpVFpq9YvY5flkjmtcETH
	O5s79phbB0tjHU6++gTizy1x3xzW9EgVhEZ0iWgz6LMIS6UVri9V+6koDcqDvLNDcwmAsXS1Mg+Bv
	KKaszQQ2XyCc31AkUoktaUS16tmGmByVaI3/kS13Mp3sIdA6oLAiHLNnS0vPSPo8S3DgzbCJ9kFWH
	iAO+eZE7oxS8XwEWu0XECv53BXfGqRlclTpKykqVbu18KY3tL+X7QOi7Jwet9QJhIFWQk5Ud+pWB0
	NXSsG5VQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1svivc-0000000HLw5-2va1;
	Tue, 01 Oct 2024 19:53:00 +0000
Date: Tue, 1 Oct 2024 20:53:00 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-parisc@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 2/3] arc: get rid of private asm/unaligned.h
Message-ID: <20241001195300.GB4135693@ZenIV>
References: <20241001195107.GA4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001195107.GA4017910@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Declarations local to arch/*/kernel/*.c are better off *not* in a public
header - arch/arc/kernel/unaligned.h is just fine for those
bits.

Unlike the parisc case, here we have an extra twist - asm/mmu.h
has an implicit dependency on struct pt_regs, and in some users
that used to be satisfied by include of asm/ptrace.h from
asm/unaligned.h (note that asm/mmu.h itself did _not_ pull asm/unaligned.h
- it relied upon the users having pulled asm/unaligned.h before asm/mmu.h
got there).

Seeing that asm/mmu.h only wants struct pt_regs * arguments in
an extern, just pre-declare it there - less brittle that way.

With that done _all_ asm/unaligned.h instances are reduced to include
of asm-generic/unaligned.h and can be removed - unaligned.h is in
mandatory-y in include/asm-generic/Kbuild.

What's more, we can move asm-generic/unaligned.h to linux/unaligned.h
and switch includes of <asm/unaligned.h> to <linux/unaligned.h>; that's
better off as an auto-generated commit, though, to be done by Linus
at -rc1 time next cycle.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/arc/include/asm/mmu.h       |  1 +
 arch/arc/include/asm/unaligned.h | 27 ---------------------------
 arch/arc/kernel/traps.c          |  1 +
 arch/arc/kernel/unaligned.c      |  1 +
 arch/arc/kernel/unaligned.h      | 16 ++++++++++++++++
 5 files changed, 19 insertions(+), 27 deletions(-)
 delete mode 100644 arch/arc/include/asm/unaligned.h
 create mode 100644 arch/arc/kernel/unaligned.h

diff --git a/arch/arc/include/asm/mmu.h b/arch/arc/include/asm/mmu.h
index 9febf5bc3de6..4ae2db59d494 100644
--- a/arch/arc/include/asm/mmu.h
+++ b/arch/arc/include/asm/mmu.h
@@ -14,6 +14,7 @@ typedef struct {
 	unsigned long asid[NR_CPUS];	/* 8 bit MMU PID + Generation cycle */
 } mm_context_t;
 
+struct pt_regs;
 extern void do_tlb_overlap_fault(unsigned long, unsigned long, struct pt_regs *);
 
 #endif
diff --git a/arch/arc/include/asm/unaligned.h b/arch/arc/include/asm/unaligned.h
deleted file mode 100644
index cf5a02382e0e..000000000000
--- a/arch/arc/include/asm/unaligned.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
- */
-
-#ifndef _ASM_ARC_UNALIGNED_H
-#define _ASM_ARC_UNALIGNED_H
-
-/* ARC700 can't handle unaligned Data accesses. */
-
-#include <asm-generic/unaligned.h>
-#include <asm/ptrace.h>
-
-#ifdef CONFIG_ARC_EMUL_UNALIGNED
-int misaligned_fixup(unsigned long address, struct pt_regs *regs,
-		     struct callee_regs *cregs);
-#else
-static inline int
-misaligned_fixup(unsigned long address, struct pt_regs *regs,
-		 struct callee_regs *cregs)
-{
-	/* Not fixed */
-	return 1;
-}
-#endif
-
-#endif /* _ASM_ARC_UNALIGNED_H */
diff --git a/arch/arc/kernel/traps.c b/arch/arc/kernel/traps.c
index a19751e824fb..41af02081549 100644
--- a/arch/arc/kernel/traps.c
+++ b/arch/arc/kernel/traps.c
@@ -20,6 +20,7 @@
 #include <asm/setup.h>
 #include <asm/unaligned.h>
 #include <asm/kprobes.h>
+#include "unaligned.h"
 
 void die(const char *str, struct pt_regs *regs, unsigned long address)
 {
diff --git a/arch/arc/kernel/unaligned.c b/arch/arc/kernel/unaligned.c
index 99a9b92ed98d..d2f5ceaaed1b 100644
--- a/arch/arc/kernel/unaligned.c
+++ b/arch/arc/kernel/unaligned.c
@@ -12,6 +12,7 @@
 #include <linux/ptrace.h>
 #include <linux/uaccess.h>
 #include <asm/disasm.h>
+#include "unaligned.h"
 
 #ifdef CONFIG_CPU_BIG_ENDIAN
 #define BE		1
diff --git a/arch/arc/kernel/unaligned.h b/arch/arc/kernel/unaligned.h
new file mode 100644
index 000000000000..5244453bb85f
--- /dev/null
+++ b/arch/arc/kernel/unaligned.h
@@ -0,0 +1,16 @@
+struct pt_regs;
+struct callee_regs;
+
+#ifdef CONFIG_ARC_EMUL_UNALIGNED
+int misaligned_fixup(unsigned long address, struct pt_regs *regs,
+		     struct callee_regs *cregs);
+#else
+static inline int
+misaligned_fixup(unsigned long address, struct pt_regs *regs,
+		 struct callee_regs *cregs)
+{
+	/* Not fixed */
+	return 1;
+}
+#endif
+
-- 
2.39.5


