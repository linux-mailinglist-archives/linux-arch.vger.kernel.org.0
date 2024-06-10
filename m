Return-Path: <linux-arch+bounces-4814-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310F4902A37
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 22:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF1ED286553
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 20:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE41152188;
	Mon, 10 Jun 2024 20:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="oW6YdVQZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DCE15217E;
	Mon, 10 Jun 2024 20:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052538; cv=none; b=U3/hrJA7DIZC9cMEE7g8m1Xa0vGs8yfAe6BcaXEg/HPKikS4gVWPwyR1hXPtHlzaxNQZclkYRj/UMKwofF47Y5smVVxXRcDU07fDMAEXLEVE+koewfV5vBd50ATjjqHp2PvtfRnBABhNnLLBeTbaDsIFMWgd8xbot1yiBCJfZGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052538; c=relaxed/simple;
	bh=ZLKP+8SlFBbrksEeWgQE5JXZVIKp4sUqZEnPm1wWp08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmQmGWsbsFaV0WwYhbBAvHQMrK4eKeGFueAFv+n0znOjbrvD0cihqYEcZBv1WGR4TKFn4TaEiINUrlU9vqY8nR5/3JZ7Ern4v8gK6M98ai0VqlFfrOGV+P2PXWrKxX7RHuyixIzmQKnH4eietw0jSkYy6GVlAkVPk4Egsz5a1sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=oW6YdVQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8B8C2BBFC;
	Mon, 10 Jun 2024 20:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718052537;
	bh=ZLKP+8SlFBbrksEeWgQE5JXZVIKp4sUqZEnPm1wWp08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oW6YdVQZvb7pT3RZFzWwOH0DwmEzdPSEz6ug0yrQT5f7eFcIFPll+TIRF/JYMqYAN
	 IPuGjDiAiCBVYcvtkSVVlzyLqnVfjT59DCr4d/zHaCDWs3pNa9EDzgXhxWifioijEi
	 SB0wd1qaiCK27TsS/Cb+VMdqMj9GjYqEaSE5JufY=
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Peter Anvin <hpa@zytor.com>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-arch <linux-arch@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 7/7] arm64: access_ok() optimization
Date: Mon, 10 Jun 2024 13:48:21 -0700
Message-ID: <20240610204821.230388-8-torvalds@linux-foundation.org>
X-Mailer: git-send-email 2.45.1.209.gc6f12300df
In-Reply-To: <20240610204821.230388-1-torvalds@linux-foundation.org>
References: <20240610204821.230388-1-torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TBI setup on arm64 is very strange: HW is set up to always do TBI,
but the kernel enforcement for system calls is purely a software
contract, and user space is supposed to mask off the top bits before the
system call.

Except all the actual brk/mmap/etc() system calls then mask it in kernel
space anyway, and accept any TBI address.

This basically unifies things and makes access_ok() also ignore it.

This is an ABI change, but the current situation is very odd, and this
change avoids the current mess and makes the kernel more permissive, and
as such is unlikely to break anything.

The way forward - for some possible future situation when people want to
use more bits - is probably to introduce a new "I actually want the full
64-bit address space" prctl.  But we should make sure that the software
and hardware rules actually match at that point.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/arm64/include/asm/uaccess.h | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 4ab3938290ab..a435eff4ee93 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -30,23 +30,20 @@ static inline int __access_ok(const void __user *ptr, unsigned long size);
 
 /*
  * Test whether a block of memory is a valid user space address.
- * Returns 1 if the range is valid, 0 otherwise.
  *
- * This is equivalent to the following test:
- * (u65)addr + (u65)size <= (u65)TASK_SIZE_MAX
+ * We only care that the address cannot reach the kernel mapping, and
+ * that an invalid address will fault.
  */
-static inline int access_ok(const void __user *addr, unsigned long size)
+static inline int access_ok(const void __user *p, unsigned long size)
 {
-	/*
-	 * Asynchronous I/O running in a kernel thread does not have the
-	 * TIF_TAGGED_ADDR flag of the process owning the mm, so always untag
-	 * the user address before checking.
-	 */
-	if (IS_ENABLED(CONFIG_ARM64_TAGGED_ADDR_ABI) &&
-	    (current->flags & PF_KTHREAD || test_thread_flag(TIF_TAGGED_ADDR)))
-		addr = untagged_addr(addr);
+	unsigned long addr = (unsigned long)p;
 
-	return likely(__access_ok(addr, size));
+	/* Only bit 55 of the address matters */
+	addr |= addr+size;
+	addr = (addr >> 55) & 1;
+	size >>= 55;
+
+	return !(addr | size);
 }
 #define access_ok access_ok
 
-- 
2.45.1.209.gc6f12300df


