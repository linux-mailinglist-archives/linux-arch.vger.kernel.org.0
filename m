Return-Path: <linux-arch+bounces-10793-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F55A609D2
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 08:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B23217F77B
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 07:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CE71FBCA2;
	Fri, 14 Mar 2025 07:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPsCjNMf"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322B11FAC37
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 07:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936386; cv=none; b=TUkT8+WAmS2Sr503YSXmxG5PaqnzoudeiRQu5WVbCYIfMmDnxWYXRddlyLqIQhFq8dRA/LsJNjktTQiRbYfWmHG5+hpINoKLHpdijlV8rN9BirTrAZZcHFkl26d2NwFLFgl6D6GLCxuRAoLOvdIKl+hnlvBFTH2cZ6NQxvbHcEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936386; c=relaxed/simple;
	bh=hR0Qu2XVH3GET5RJ8j99I8+PZIjMwhX3oYEnnSmP1DI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVFl/D3lmgnt6lZ5mzOxd0zaVYtdPUirOSWXcaNy+FOXF6QmDeIu4q9qRBpbCRKbgjUVR5jdTsZSJPIYm9pjA0fWCJGzfZXfe5C2z+C2dHs5M3TD+iafSHqvKU9ZHV2xM5XHts5B9CHx4x4PhB72cenV+yKOzU1oalxahYgMBfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fPsCjNMf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XgJ3xmVB8Q+Qlov1OOwzrPoA5VYL2CgjG+ZWo4y/fRM=;
	b=fPsCjNMfF2J0+9vVJ863KbduA9HiNYE8z5kyyE5955CFBo1tiuR8Q0bezS7ZxVXsWKRjZj
	jShRCE6vzFg+1WLDfzFD7v4ozHqv7ZSg+rGyzpN7gMDIHXkkJnNX0AnjG0x0fW/LOI489L
	E3phcMzQCtV2CCIQnOuI9CgNhfR8eiM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-PKxp5eKfMNKY2P031irecA-1; Fri,
 14 Mar 2025 03:12:59 -0400
X-MC-Unique: PKxp5eKfMNKY2P031irecA-1
X-Mimecast-MFC-AGG-ID: PKxp5eKfMNKY2P031irecA_1741936378
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94D53195608B;
	Fri, 14 Mar 2025 07:12:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A6F9A18001DE;
	Fri, 14 Mar 2025 07:12:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH 35/41] um: Replace __ASSEMBLY__ with __ASSEMBLER__ in the usermode headers
Date: Fri, 14 Mar 2025 08:10:06 +0100
Message-ID: <20250314071013.1575167-36-thuth@redhat.com>
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

While the GCC and Clang compilers already define __ASSEMBLER__
automatically when compiling assembly code, __ASSEMBLY__ is a
macro that only gets defined by the Makefiles in the kernel.
This can be very confusing when switching between userspace
and kernelspace coding, so let's standardize on the __ASSEMBLER__
macro that is provided by the compilers now.

This is a completely mechanical patch (done with a simple "sed -i"
statement).

Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/um/include/asm/cpufeature.h     | 4 ++--
 arch/um/include/asm/current.h        | 4 ++--
 arch/um/include/asm/page.h           | 4 ++--
 arch/um/include/asm/ptrace-generic.h | 2 +-
 arch/um/include/asm/thread_info.h    | 2 +-
 arch/um/include/shared/as-layout.h   | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/um/include/asm/cpufeature.h b/arch/um/include/asm/cpufeature.h
index 1eb8b834fbec3..4354f6984271c 100644
--- a/arch/um/include/asm/cpufeature.h
+++ b/arch/um/include/asm/cpufeature.h
@@ -4,7 +4,7 @@
 
 #include <asm/processor.h>
 
-#if defined(__KERNEL__) && !defined(__ASSEMBLY__)
+#if defined(__KERNEL__) && !defined(__ASSEMBLER__)
 
 #include <asm/asm.h>
 #include <linux/bitops.h>
@@ -137,5 +137,5 @@ static __always_inline bool _static_cpu_has(u16 bit)
 #define CPU_FEATURE_TYPEVAL		boot_cpu_data.x86_vendor, boot_cpu_data.x86, \
 					boot_cpu_data.x86_model
 
-#endif /* defined(__KERNEL__) && !defined(__ASSEMBLY__) */
+#endif /* defined(__KERNEL__) && !defined(__ASSEMBLER__) */
 #endif /* _ASM_UM_CPUFEATURE_H */
diff --git a/arch/um/include/asm/current.h b/arch/um/include/asm/current.h
index de64e032d66c1..8accc6d6f5026 100644
--- a/arch/um/include/asm/current.h
+++ b/arch/um/include/asm/current.h
@@ -5,7 +5,7 @@
 #include <linux/compiler.h>
 #include <linux/threads.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct task_struct;
 extern struct task_struct *cpu_tasks[NR_CPUS];
@@ -18,6 +18,6 @@ static __always_inline struct task_struct *get_current(void)
 
 #define current get_current()
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __ASM_CURRENT_H */
diff --git a/arch/um/include/asm/page.h b/arch/um/include/asm/page.h
index 3d516f3ca9c74..6f54254aaf443 100644
--- a/arch/um/include/asm/page.h
+++ b/arch/um/include/asm/page.h
@@ -11,7 +11,7 @@
 
 #include <vdso/page.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct page;
 
@@ -94,7 +94,7 @@ extern unsigned long uml_physmem;
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #ifdef CONFIG_X86_32
 #define __HAVE_ARCH_GATE_AREA 1
diff --git a/arch/um/include/asm/ptrace-generic.h b/arch/um/include/asm/ptrace-generic.h
index 4696f24d14920..86d74f9d33cf2 100644
--- a/arch/um/include/asm/ptrace-generic.h
+++ b/arch/um/include/asm/ptrace-generic.h
@@ -6,7 +6,7 @@
 #ifndef __UM_PTRACE_GENERIC_H
 #define __UM_PTRACE_GENERIC_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <sysdep/ptrace.h>
 
diff --git a/arch/um/include/asm/thread_info.h b/arch/um/include/asm/thread_info.h
index f9ad06fcc991a..398e86fe3d051 100644
--- a/arch/um/include/asm/thread_info.h
+++ b/arch/um/include/asm/thread_info.h
@@ -9,7 +9,7 @@
 #define THREAD_SIZE_ORDER CONFIG_KERNEL_STACK_ORDER
 #define THREAD_SIZE ((1 << CONFIG_KERNEL_STACK_ORDER) * PAGE_SIZE)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/types.h>
 #include <asm/page.h>
diff --git a/arch/um/include/shared/as-layout.h b/arch/um/include/shared/as-layout.h
index ea65f151bf484..07721d7210b1f 100644
--- a/arch/um/include/shared/as-layout.h
+++ b/arch/um/include/shared/as-layout.h
@@ -26,7 +26,7 @@
 #define STUB_DATA_PAGES 2 /* must be a power of two */
 #define STUB_END (STUB_DATA + STUB_DATA_PAGES * UM_KERN_PAGE_SIZE)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <sysdep/ptrace.h>
 
-- 
2.48.1


