Return-Path: <linux-arch+bounces-14349-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC39C0B86A
	for <lists+linux-arch@lfdr.de>; Mon, 27 Oct 2025 01:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179AC18A1B56
	for <lists+linux-arch@lfdr.de>; Mon, 27 Oct 2025 00:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519B2225390;
	Mon, 27 Oct 2025 00:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T4PKl5X+"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A251F3B87
	for <linux-arch@vger.kernel.org>; Mon, 27 Oct 2025 00:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761524337; cv=none; b=bYEu2oQ5tvtndcuVZ8UAX7SOWfmcIz1CMgr/bb8r10axGtNtJUMaLvoq03ESpjjqi/cRmg3bwyDJ20+waNBNg0uTanQh11C0fv0eNKCZfxlOwNxhEZi0srhl2iQrS8FsUsSM0IEVGrVfX8zYvgcnSdXclNb5meL38rzof+htOpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761524337; c=relaxed/simple;
	bh=9DoCjxBOtuHLpHgIlbx76kr9AICQ+StOVxBkqP6vrGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SxHmh9I5weXSoplhJgpTdXHbnBenL3D02DWTiVqkuTq42t9xljsKRe9FlAYWmWvr71SUvRav4dhWWE11HLkmTNPhynvNl34R6cEyc70tcyxz2n30tEQ6qdAhfzCQjTDhAqj4VlSi6PpQJuMjYUJDmCxSvaPz/uPzvAty0Nxy0gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T4PKl5X+; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761524332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qv8GrhWWLvpi+yXjcVXvopwH0zWKk+Fo+xAzYv1qf0M=;
	b=T4PKl5X+6V424JgZsHbjgohHFQmgP76ww0hRCuAU8l0OHdP80gOU4h5zkGhwT54VMt6IiR
	g/0xY78vvtuBWUgD/WDWefBPq53HQnlB1K8Xq7XZZgmL5nsY2iJjmGFPmkGGV8PZPjd2t3
	CQmBS+q7pZDeiog2t+/nDV+DmIglumA=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	benjamin@sipsolutions.net,
	arnd@arndb.de,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev,
	linux-arch@vger.kernel.org
Subject: [PATCH v4 7/8] asm-generic: percpu: Add assembly guard
Date: Mon, 27 Oct 2025 08:18:14 +0800
Message-Id: <20251027001815.1666872-8-tiwei.bie@linux.dev>
In-Reply-To: <20251027001815.1666872-1-tiwei.bie@linux.dev>
References: <20251027001815.1666872-1-tiwei.bie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tiwei Bie <tiwei.btw@antgroup.com>

Currently, asm/percpu.h is directly or indirectly included by
some assembly files on x86. Some of them (e.g., checksum_32.S)
are also used on um. But x86 and um provide different versions
of asm/percpu.h -- um uses asm-generic/percpu.h directly.

When SMP is enabled, asm-generic/percpu.h will introduce C code
that cannot be assembled. Since asm-generic/percpu.h currently
is not designed for use in assembly, and these assembly files
do not actually need asm/percpu.h on um, let's add the assembly
guard in asm-generic/percpu.h to fix this issue.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/percpu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index 02aeca21479a..6628670bcb90 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_GENERIC_PERCPU_H_
 #define _ASM_GENERIC_PERCPU_H_
 
+#ifndef __ASSEMBLER__
+
 #include <linux/compiler.h>
 #include <linux/threads.h>
 #include <linux/percpu-defs.h>
@@ -557,4 +559,5 @@ do {									\
 	this_cpu_generic_cmpxchg(pcp, oval, nval)
 #endif
 
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_GENERIC_PERCPU_H_ */
-- 
2.34.1


