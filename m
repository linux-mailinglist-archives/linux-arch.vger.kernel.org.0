Return-Path: <linux-arch+bounces-7561-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F4A98C64F
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 21:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E395BB211F0
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 19:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878D31CBEB8;
	Tue,  1 Oct 2024 19:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RJ4Ya5VS"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A391CDA09;
	Tue,  1 Oct 2024 19:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727812322; cv=none; b=XHHaqev98zPmY4uKXB1ewvZYpLTTKFCUYvBUGfmeQk/FZhGOmkU3h+7wpAWC1OItd385aFW0D6prvAmNPSHEQEm0w31w9/giq+HE0RtR0ThDbJ5l/vl2XgUWFeyLYG+BBLRqFXKnnlEVBblBJwtgUDIUkaCDvysnc77+4QJeb6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727812322; c=relaxed/simple;
	bh=TIHjBTyVKePvkd7vZH1lHOHBvlKGISrLpJ5DUm++GS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWKNQdh0jOZEG/QU3yAMJQgX+tOx3HDPvE12cg9oYHOVz2qiMdjqTPLqbFoTo0YZQXKv7TuQp9pzo5MeI0OkaSNbr3J/jtEjSgwLJwAd2sp77CRpAOBK3t5dBZVuTpqy9MDKP+1v8p4d++rxkv9hUtli0gwERtiwBRG1qReD0bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RJ4Ya5VS; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xa+Bc4wVHUCS0MYJrH7PUOO8ca5otHSXeMvqCaG7vM4=; b=RJ4Ya5VSUbwwVGt4ysRf3GwF0H
	PAoJxqkFKxB2czgdULb4WWTjI7XBUshmtsithiaYtxK3C8Mbjp8P2Cw6c3dNOVqNctMDHDyWdTQtH
	g5fUYtD9aPk7NxIb9BF1CZfiEQoA6mUurUImL82jhc0Rb5b8yU72Zjvc/hsxT0GY1BdY5qDURuvQy
	8NeYejteB8BlUL3rc9tme/hsxGXfbsoAMzkSPuREZQJDdPXoNJoN6SkQi3zR07cmlkteGJyCIxj0/
	K6cWcbCGd4XEpfx3CITKrrgerDwDtU8ukv0/l0g62lkd25g+Pj3DpISafvWxjl5AlzHT4OFHSOuyC
	JEhasm4A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sviuc-0000000HLtz-2ksp;
	Tue, 01 Oct 2024 19:51:58 +0000
Date: Tue, 1 Oct 2024 20:51:58 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-parisc@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 1/3] parisc: get rid of private asm/unaligned.h
Message-ID: <20241001195158.GA4135693@ZenIV>
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
header - arch/parisc/kernel/unaligned.h is just fine for those
bits.

With that done parisc asm/unaligned.h is reduced to include
of asm-generic/unaligned.h and can be removed - unaligned.h is in
mandatory-y in include/asm-generic/Kbuild.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/parisc/include/asm/unaligned.h | 11 -----------
 arch/parisc/kernel/traps.c          |  2 ++
 arch/parisc/kernel/unaligned.c      |  1 +
 arch/parisc/kernel/unaligned.h      |  3 +++
 4 files changed, 6 insertions(+), 11 deletions(-)
 delete mode 100644 arch/parisc/include/asm/unaligned.h
 create mode 100644 arch/parisc/kernel/unaligned.h

diff --git a/arch/parisc/include/asm/unaligned.h b/arch/parisc/include/asm/unaligned.h
deleted file mode 100644
index c0621295100d..000000000000
--- a/arch/parisc/include/asm/unaligned.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_PARISC_UNALIGNED_H
-#define _ASM_PARISC_UNALIGNED_H
-
-#include <asm-generic/unaligned.h>
-
-struct pt_regs;
-void handle_unaligned(struct pt_regs *regs);
-int check_unaligned(struct pt_regs *regs);
-
-#endif /* _ASM_PARISC_UNALIGNED_H */
diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
index 294b0e026c9a..a111d7362d56 100644
--- a/arch/parisc/kernel/traps.c
+++ b/arch/parisc/kernel/traps.c
@@ -47,6 +47,8 @@
 #include <linux/kgdb.h>
 #include <linux/kprobes.h>
 
+#include "unaligned.h"
+
 #if defined(CONFIG_LIGHTWEIGHT_SPINLOCK_CHECK)
 #include <asm/spinlock.h>
 #endif
diff --git a/arch/parisc/kernel/unaligned.c b/arch/parisc/kernel/unaligned.c
index 3e79e40e361d..99897107d800 100644
--- a/arch/parisc/kernel/unaligned.c
+++ b/arch/parisc/kernel/unaligned.c
@@ -15,6 +15,7 @@
 #include <asm/unaligned.h>
 #include <asm/hardirq.h>
 #include <asm/traps.h>
+#include "unaligned.h"
 
 /* #define DEBUG_UNALIGNED 1 */
 
diff --git a/arch/parisc/kernel/unaligned.h b/arch/parisc/kernel/unaligned.h
new file mode 100644
index 000000000000..c1aa4b12e284
--- /dev/null
+++ b/arch/parisc/kernel/unaligned.h
@@ -0,0 +1,3 @@
+struct pt_regs;
+void handle_unaligned(struct pt_regs *regs);
+int check_unaligned(struct pt_regs *regs);
-- 
2.39.5


