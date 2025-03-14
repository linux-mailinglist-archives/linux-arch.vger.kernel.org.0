Return-Path: <linux-arch+bounces-10778-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B19BA609AE
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 08:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8CE19C4BEE
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 07:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8AA1EB5D4;
	Fri, 14 Mar 2025 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKddVnfE"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A544F1E5B91
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 07:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936317; cv=none; b=DFEL36hyBfRT/QyFAZRj+POesTt/Wq5elQvAUfAvOP4OI+NE4SzXKBlXqGUmxAw7iGJcPEzOGWC19SI7Hl0k0e43IN+cQp21ShWdzy3SJ+z9EmzZhC00YIlFKThh2nZwm3yE6Rti683dBkYfp1Nzbsdv6oT/RZd9iA2jBKYozR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936317; c=relaxed/simple;
	bh=carqj/K7BRYMlmHgCtRn+i/kZk9+307GqgbsoigQqw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fznXniqH6e9dbjxnLMuFJKTgDP+pqrHo/GYtWsga97od191+86mN6IT1jyNGFsliQZWuD2eSHCATaQFDMW+CQYS6sOhvNq2bonsSZGGMNQl+a3DnjlkWrlcegEkPZF5cas05sHG500TzKsGlJl5iTGRER+dtpf/UZF/wZoGCmu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KKddVnfE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zu7kWQRIHaiQZGQh0A3QzrqgDB6jslhiNlrZVStUqb8=;
	b=KKddVnfEmUeR31qlTiajEb3b3xlpPGpr9mh3KgWtnycHj9eZxR75Rscgj8xbqdNLNH7ONu
	+PzFwJfItH/YvZuLEcME8VtbromYCHEVOW3+GjUHvz1iWS5BBHffmyBNuiSCy6OAiyfmt8
	Ufr1n+Hpi7S72x33AIziIQxdFmsfJdM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-CFh-pJvvNWmIKBlnrEbcPw-1; Fri,
 14 Mar 2025 03:11:35 -0400
X-MC-Unique: CFh-pJvvNWmIKBlnrEbcPw-1
X-Mimecast-MFC-AGG-ID: CFh-pJvvNWmIKBlnrEbcPw_1741936292
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A67B180025E;
	Fri, 14 Mar 2025 07:11:32 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1462C18001DE;
	Fri, 14 Mar 2025 07:11:28 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org
Subject: [PATCH 15/41] m68k: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
Date: Fri, 14 Mar 2025 08:09:46 +0100
Message-ID: <20250314071013.1575167-16-thuth@redhat.com>
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

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/m68k/include/uapi/asm/bootinfo-vme.h | 4 ++--
 arch/m68k/include/uapi/asm/bootinfo.h     | 8 ++++----
 arch/m68k/include/uapi/asm/ptrace.h       | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/m68k/include/uapi/asm/bootinfo-vme.h b/arch/m68k/include/uapi/asm/bootinfo-vme.h
index f36a09ab5e79b..b8139eb393524 100644
--- a/arch/m68k/include/uapi/asm/bootinfo-vme.h
+++ b/arch/m68k/include/uapi/asm/bootinfo-vme.h
@@ -33,7 +33,7 @@
 #define VME_TYPE_BVME6000	0x6000	/* BVM Ltd. BVME6000 */
 
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * Board ID data structure - pointer to this retrieved from Bug by head.S
@@ -56,7 +56,7 @@ typedef struct {
 	__be32	option2;
 } t_bdid, *p_bdid;
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 
     /*
diff --git a/arch/m68k/include/uapi/asm/bootinfo.h b/arch/m68k/include/uapi/asm/bootinfo.h
index 024e87d7095f8..28d2d44c08d06 100644
--- a/arch/m68k/include/uapi/asm/bootinfo.h
+++ b/arch/m68k/include/uapi/asm/bootinfo.h
@@ -16,7 +16,7 @@
 #include <linux/types.h>
 
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
     /*
      *  Bootinfo definitions
@@ -43,7 +43,7 @@ struct mem_info {
 	__be32 size;			/* length of memory chunk (in bytes) */
 };
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 
     /*
@@ -167,7 +167,7 @@ struct mem_info {
 #define BI_VERSION_MAJOR(v)		(((v) >> 16) & 0xffff)
 #define BI_VERSION_MINOR(v)		((v) & 0xffff)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct bootversion {
 	__be16 branch;
@@ -178,7 +178,7 @@ struct bootversion {
 	} machversions[];
 } __packed;
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 
 #endif /* _UAPI_ASM_M68K_BOOTINFO_H */
diff --git a/arch/m68k/include/uapi/asm/ptrace.h b/arch/m68k/include/uapi/asm/ptrace.h
index ebd9fccb3d11f..d70f771399b40 100644
--- a/arch/m68k/include/uapi/asm/ptrace.h
+++ b/arch/m68k/include/uapi/asm/ptrace.h
@@ -22,7 +22,7 @@
 #define PT_SR	   17
 #define PT_PC	   18
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /* this struct defines the way the registers are stored on the
    stack during a system call. */
@@ -81,5 +81,5 @@ struct switch_stack {
 #define PTRACE_GETFDPIC_EXEC	0
 #define PTRACE_GETFDPIC_INTERP	1
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _UAPI_M68K_PTRACE_H */
-- 
2.48.1


