Return-Path: <linux-arch+bounces-13100-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8182FB1F886
	for <lists+linux-arch@lfdr.de>; Sun, 10 Aug 2025 07:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D593B26F5
	for <lists+linux-arch@lfdr.de>; Sun, 10 Aug 2025 05:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA9A20B81D;
	Sun, 10 Aug 2025 05:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JU9k4Q9Q"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF991F417B
	for <linux-arch@vger.kernel.org>; Sun, 10 Aug 2025 05:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754805152; cv=none; b=L4kjG/4MJz68Yf6Sjek9or3Jb3AkJ8WUixBjxzCiDgJ0Vs87zMMnHnSlFEQ5cn7Xog3vtV1fc2xY02uwvKFz3ZkCnRIf9rlVv8bwpwTfZM5Xnq3QKN7a0klutHg4pjy2Fhy9GRSfWylrepNVRfYu9lSRgadN6T4QJjyOVuhxDVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754805152; c=relaxed/simple;
	bh=hm46ej6Vrko2gXSPA8dx5Mt413MKshcRC/EPBjHNg1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CdiEHDUf/lOOEgDTiLyEquhNqMNRyfhlpGtHDxhaYYs1ULlsvmJ78+FXHkh1lrxc2TFlmDSovQVIGTkNxyI3C8aNhblpkR5kdp/yLDirmiKJ13K8HyTEj9jeuaCp+9paD4cQ3/UthVa9CccUWJz/6fX6cOiffyhyUzTRIJm2J0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JU9k4Q9Q; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754805148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=htk5PcwaQftKiGsMJqYeQtYQUBUiLxMymGVv6gN7xZ4=;
	b=JU9k4Q9QkBJ4/UzFZfr2Ik9aorYkFaVf3evLKVKmN68FOgWNJech5SFMXhSwqbXUr6jQTA
	zxW8JLgX211hl7/OgHGKKNcywlSeFYPdrN7w6jacsDzceolVezN2obaCFj14Ib9ROzlj8+
	sDtb7MtV0ZNvPNGH1xxNOXzcvjcZSgI=
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
Subject: [PATCH v2 09/10] asm-generic: percpu: Add assembly guard
Date: Sun, 10 Aug 2025 13:51:35 +0800
Message-Id: <20250810055136.897712-10-tiwei.bie@linux.dev>
In-Reply-To: <20250810055136.897712-1-tiwei.bie@linux.dev>
References: <20250810055136.897712-1-tiwei.bie@linux.dev>
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


