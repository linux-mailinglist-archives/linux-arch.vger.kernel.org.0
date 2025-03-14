Return-Path: <linux-arch+bounces-10766-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7209A60989
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 08:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F99C17F26B
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 07:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7691A2545;
	Fri, 14 Mar 2025 07:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bgWcUCnV"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68D0166F06
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 07:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936274; cv=none; b=fQZHIfxr5FicKFdpzm8PSMDtaW4mjJ+oC9dqf2oGsvRrWktvmYh9+FQMPN1/W9xPHspWVOTfrVbiisSBExFDz6k+ms/qegJpkbhlT3HsgQfEnzZJrdJcUh5kT5mVUTsqXLXE5TWpJkjs2E9kfr/i7Kbo7IpH1zQoQB+g1tP4HxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936274; c=relaxed/simple;
	bh=RdrI0suJjmuquaN+k9PvKIs9EGZFQbPZgofidF5AAP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ghh4sxSQJ0fyyJ57zwWLy0aPuOecH5YxvG4yRmCJ3cWo8m9f/RCWoueaC/xwnsQfom9DWJSA432AJdAHF0/KJRBkcNBpzC3AiYZU7Y1CgzpG+QUv4syCYGbF9UJCENariA3z3wG4KQn6yVdaIb6IXMqACfrFRKAUmGN4tc0AeZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bgWcUCnV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/9u97sgtLQBq5GMZiB9DODjVt9+Rkk4BbAlXOqiWaw=;
	b=bgWcUCnV0SsU2iZPrpKrzYrMfSvu+Dg1WIPfC90UPKtCUtp199a4Fnn490RxQm3zZLUmg5
	nwITnpb/ZAmomEfLu0BjEQP9pTvf6ygf2qfuu3Vt+odr0B/6uPh/q9lPLEIPSQu5/i02al
	aopBYMVuhVE39IVyCOgnL6m/nGwzvXY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-BUi51CSCP3G-78AxUclNew-1; Fri,
 14 Mar 2025 03:11:08 -0400
X-MC-Unique: BUi51CSCP3G-78AxUclNew-1
X-Mimecast-MFC-AGG-ID: BUi51CSCP3G-78AxUclNew_1741936267
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED9E11955DCD;
	Fri, 14 Mar 2025 07:11:06 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4A97D18001D4;
	Fri, 14 Mar 2025 07:11:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 08/41] arm64: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
Date: Fri, 14 Mar 2025 08:09:39 +0100
Message-ID: <20250314071013.1575167-9-thuth@redhat.com>
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

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/arm64/include/uapi/asm/kvm.h        | 2 +-
 arch/arm64/include/uapi/asm/ptrace.h     | 4 ++--
 arch/arm64/include/uapi/asm/sigcontext.h | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 568bf858f3198..f1ee246f7b14e 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -31,7 +31,7 @@
 #define KVM_SPSR_FIQ	4
 #define KVM_NR_SPSR	5
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/psci.h>
 #include <linux/types.h>
 #include <asm/ptrace.h>
diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 0f39ba4f3efd4..6fed93fb2536f 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -80,7 +80,7 @@
 #define PTRACE_PEEKMTETAGS	  33
 #define PTRACE_POKEMTETAGS	  34
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * User structures for general purpose, floating point and debug registers.
@@ -332,6 +332,6 @@ struct user_gcs {
 	__u64 gcspr_el0;
 };
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _UAPI__ASM_PTRACE_H */
diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
index d42f7a92238b9..e29bf3e2d0ccd 100644
--- a/arch/arm64/include/uapi/asm/sigcontext.h
+++ b/arch/arm64/include/uapi/asm/sigcontext.h
@@ -17,7 +17,7 @@
 #ifndef _UAPI__ASM_SIGCONTEXT_H
 #define _UAPI__ASM_SIGCONTEXT_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 
@@ -192,7 +192,7 @@ struct gcs_context {
 	__u64 reserved;
 };
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #include <asm/sve_context.h>
 
-- 
2.48.1


