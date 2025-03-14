Return-Path: <linux-arch+bounces-10796-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1834CA609E4
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 08:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 566543B9F0B
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 07:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21E41B414F;
	Fri, 14 Mar 2025 07:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8s5f2Vd"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9161FC0EB
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 07:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936398; cv=none; b=TLySMzTLGtCcKcy9OFLjjtGn/J3R7HhsJhLVqESRhVuYN04S9FlTIUGNtMPMZLQBtmoEEKt19rNh6RDXJxs6W6oy67ClO/1QSQvW8IcnIiJkaBqYwRLmyXjIVD1/jkY+RjdHJQKtcdqPOFH+oBhvx5vf/LsqzK7o4KfTpyjmEvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936398; c=relaxed/simple;
	bh=rHGLoWqdm42/4FCycHrRwxhBYygkSD7glUovtmftaOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsIkqhEHshUN1a5SWCx91sG1nCFc8BZ62C31ZHxlnge1+j5vsfYqjEOIGN04fVRpUzfmlFOoQ2OVjAM8A3ppmG9J0ENzNnYCpskCTxisc1s8pgwvJoHkDBZWYn2FkUkPeQXSuNrmBN567Fk6AtxYn+WVzErPHKZMc1Lxp+bZKUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X8s5f2Vd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lBnLVSz82WXl21LiYvBhpw7Gip8rvB2xWayGSZ4A9UY=;
	b=X8s5f2VdajaOOnsE9atTqNIuToA2asoUpEmPsugh56fgBaZih+1ybvt4uWmVdEs5YRmBTW
	RUVI7MLLw2xiBPRIqpozvQ0czOJfq0YWeqZjU4pPNIeGQ9euU8kVvW1ZUsNegWWVlYrrm4
	riXKAbYR1R9GrJZnIqFkYyTnFsYTGbU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-jhYmG-gjP0WYsfrQyq-EDQ-1; Fri,
 14 Mar 2025 03:13:14 -0400
X-MC-Unique: jhYmG-gjP0WYsfrQyq-EDQ-1
X-Mimecast-MFC-AGG-ID: jhYmG-gjP0WYsfrQyq-EDQ_1741936393
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D36A1956046;
	Fri, 14 Mar 2025 07:13:13 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 022161801758;
	Fri, 14 Mar 2025 07:13:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 38/41] xtensa: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
Date: Fri, 14 Mar 2025 08:10:09 +0100
Message-ID: <20250314071013.1575167-39-thuth@redhat.com>
In-Reply-To: <20250314071013.1575167-1-thuth@redhat.com>
References: <20250314071013.1575167-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

__ASSEMBLY__ is only defined by the Makefile of the kernel, so
this is not really useful for uapi headers (unless the userspace
Makefile defines it, too). Let's switch to __ASSEMBLER__ which
gets set automatically by the compiler when compiling assembly
code.

This is a completely mechanical patch (done with a simple "sed -i"
statement).

Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/xtensa/include/uapi/asm/ptrace.h | 2 +-
 arch/xtensa/include/uapi/asm/signal.h | 6 +++---
 arch/xtensa/include/uapi/asm/types.h  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/xtensa/include/uapi/asm/ptrace.h b/arch/xtensa/include/uapi/asm/ptrace.h
index 9115e86ebc75f..6e89ea3014380 100644
--- a/arch/xtensa/include/uapi/asm/ptrace.h
+++ b/arch/xtensa/include/uapi/asm/ptrace.h
@@ -42,7 +42,7 @@
 #define PTRACE_GETFDPIC_EXEC	0
 #define PTRACE_GETFDPIC_INTERP	1
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct user_pt_regs {
 	__u32 pc;
diff --git a/arch/xtensa/include/uapi/asm/signal.h b/arch/xtensa/include/uapi/asm/signal.h
index b8c824dd4b746..8060f19144008 100644
--- a/arch/xtensa/include/uapi/asm/signal.h
+++ b/arch/xtensa/include/uapi/asm/signal.h
@@ -19,7 +19,7 @@
 #define _NSIG_BPW	32
 #define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 
@@ -77,7 +77,7 @@ typedef struct {
 #define MINSIGSTKSZ	2048
 #define SIGSTKSZ	8192
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm-generic/signal-defs.h>
 
@@ -106,5 +106,5 @@ typedef struct sigaltstack {
 	__kernel_size_t ss_size;
 } stack_t;
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 #endif /* _UAPI_XTENSA_SIGNAL_H */
diff --git a/arch/xtensa/include/uapi/asm/types.h b/arch/xtensa/include/uapi/asm/types.h
index 12db8ac38750f..2e9217a06ebf9 100644
--- a/arch/xtensa/include/uapi/asm/types.h
+++ b/arch/xtensa/include/uapi/asm/types.h
@@ -14,7 +14,7 @@
 
 #include <asm-generic/int-ll64.h>
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 # define __XTENSA_UL(x)		(x)
 # define __XTENSA_UL_CONST(x)	x
 #else
@@ -23,7 +23,7 @@
 # define __XTENSA_UL_CONST(x)	___XTENSA_UL_CONST(x)
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #endif
 
-- 
2.48.1


