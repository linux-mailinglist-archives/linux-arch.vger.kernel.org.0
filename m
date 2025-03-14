Return-Path: <linux-arch+bounces-10788-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0842FA609CF
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 08:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95AFE3AE0A9
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 07:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBD41F5619;
	Fri, 14 Mar 2025 07:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hx6C6/G2"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3003D16D9DF
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 07:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936363; cv=none; b=AhdBV2o3+i9Zhvk7pjSB4KUT8hkbrTVde4LGZLQ7L+DmQPn9lJu+vMNEzdK/VEjZSQwc5+vhBCL3NenBW51Dpf9TJBBTDVrbJklTfTP9Q9+UGccxkfOxl40lohhPIaIjo///jhM1sId1zr7u2pKS7/wJJDX4FBhJP/YeVqhpxCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936363; c=relaxed/simple;
	bh=/fT8fwQpqH3ugpFiukm63OIRYhfvUNsyNaybmVW0QPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kf8FOmcqG9lvZNm/SFBBer/fgfbAHj6GFsBMMAIKdSgH+0FZ68kQP+vQTl47KHiZMerfpSfSM8P8J9gKsPwgnj2dpeAkWEi11aYIthbLrYKfldasUtMt4Ms/zbIuh2IipFjM28XRiUqzqC3apmPIzqd/ECKmflrpIpjUGELCXkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hx6C6/G2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zmpRvMjMd9Ucmt9VLoeZf1rqDqtOYydQnsnqQVwt++k=;
	b=hx6C6/G21+beJTul+/xPRj3dkxz9+YqijKd+RladluxrGON3C0trsUqj+urdBHcOsNwdE1
	BjggrCWfYPi6wLGf/tzYyhqbi/SJU8kkGhSiL9bymkPPb4H8yG36lqH62e+bR/s3+UxGqV
	guZvhXNVHpsbD79mFMUG3Jo/kgpbueg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-FtzaGygRNf2Jfs3ekiHGjg-1; Fri,
 14 Mar 2025 03:12:37 -0400
X-MC-Unique: FtzaGygRNf2Jfs3ekiHGjg-1
X-Mimecast-MFC-AGG-ID: FtzaGygRNf2Jfs3ekiHGjg_1741936356
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 37E4E1956048;
	Fri, 14 Mar 2025 07:12:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 22FA51801747;
	Fri, 14 Mar 2025 07:12:31 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: [PATCH 30/41] s390/uapi: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
Date: Fri, 14 Mar 2025 08:10:01 +0100
Message-ID: <20250314071013.1575167-31-thuth@redhat.com>
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

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/s390/include/uapi/asm/ptrace.h | 5 +++--
 arch/s390/include/uapi/asm/schid.h  | 4 ++--
 arch/s390/include/uapi/asm/types.h  | 4 ++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/uapi/asm/ptrace.h b/arch/s390/include/uapi/asm/ptrace.h
index bb0826024bb95..ea202072f1ad5 100644
--- a/arch/s390/include/uapi/asm/ptrace.h
+++ b/arch/s390/include/uapi/asm/ptrace.h
@@ -242,7 +242,8 @@
 #define PTRACE_OLDSETOPTIONS		21
 #define PTRACE_SYSEMU			31
 #define PTRACE_SYSEMU_SINGLESTEP	32
-#ifndef __ASSEMBLY__
+
+#ifndef __ASSEMBLER__
 #include <linux/stddef.h>
 #include <linux/types.h>
 
@@ -450,6 +451,6 @@ struct user_regs_struct {
 	unsigned long ieee_instruction_pointer;	/* obsolete, always 0 */
 };
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _UAPI_S390_PTRACE_H */
diff --git a/arch/s390/include/uapi/asm/schid.h b/arch/s390/include/uapi/asm/schid.h
index a3e1cf1685534..d804d1a5b1b3f 100644
--- a/arch/s390/include/uapi/asm/schid.h
+++ b/arch/s390/include/uapi/asm/schid.h
@@ -4,7 +4,7 @@
 
 #include <linux/types.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct subchannel_id {
 	__u32 cssid : 8;
@@ -15,6 +15,6 @@ struct subchannel_id {
 	__u32 sch_no : 16;
 } __attribute__ ((packed, aligned(4)));
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _UAPIASM_SCHID_H */
diff --git a/arch/s390/include/uapi/asm/types.h b/arch/s390/include/uapi/asm/types.h
index 84457dbb26b4a..4ab468c5032e3 100644
--- a/arch/s390/include/uapi/asm/types.h
+++ b/arch/s390/include/uapi/asm/types.h
@@ -10,7 +10,7 @@
 
 #include <asm-generic/int-ll64.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 typedef unsigned long addr_t;
 typedef __signed__ long saddr_t;
@@ -25,6 +25,6 @@ typedef struct {
 	};
 } __attribute__((packed, aligned(4))) __vector128;
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _UAPI_S390_TYPES_H */
-- 
2.48.1


