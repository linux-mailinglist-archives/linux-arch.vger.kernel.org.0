Return-Path: <linux-arch+bounces-10785-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5112EA609C4
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 08:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CDE48806DD
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 07:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DD51624D5;
	Fri, 14 Mar 2025 07:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jmp51rCp"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3F4193074
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936355; cv=none; b=QY/F5yrItGnnsrEKTb3BwBIXTOpya9SBEGZD983NJBY5dffp2e9IFRtBRZ+YbzALNyyqi3NdMw75XotmddjqJkOWx6ojQX3vv0tJg0UYJ1/FrP7KCRP9DP0cPu0HO4mx5XJl8+WDPbnhmi8BpSRezk0bt2Ao69dg3iBG+nqGrd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936355; c=relaxed/simple;
	bh=EoIx8sxqopmGpa5nePf7SVDDBLygP7qyxd5uiDwF9SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGuE0b0fJQttTvZBlbj58SQeYJ0K7Il1sJpg9rZWDXU5BzSILsiKKGRNxqaDIoFVqZwM+UvdLxlJ5eWinKui+0YqX1BBdWNaE/ZqOf7vvsQL32hI/dpoYOYTEQn+oa6VAi4A2ZF9n50w3ZHTmX2RSxETqplxpkKZUha6/S3xjsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jmp51rCp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c1k83YcwFgoq7Y1Cl51ypGRAA8oPhImO51BODSPRGfU=;
	b=Jmp51rCpk3u8vfOAvmCU3M7dGoEZTRsveKtH1hdTNCJq/4FoAJ8uezcUgr8anYq4S2sN3J
	h7MvaUHaQHddLCNDnC+M6TkoecUIA+LCiNJDsYUjC4H7PqbX4ipwA/KsLYj5Cud8SNRRdS
	FQFYgmSd5LTerJXcz4G/I5AFphwUmy8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-X98NAb_QN2WUgg1DR8mzTA-1; Fri,
 14 Mar 2025 03:12:29 -0400
X-MC-Unique: X98NAb_QN2WUgg1DR8mzTA-1
X-Mimecast-MFC-AGG-ID: X98NAb_QN2WUgg1DR8mzTA_1741936347
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2C9C19560AB;
	Fri, 14 Mar 2025 07:12:26 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DCD5B18001DE;
	Fri, 14 Mar 2025 07:12:22 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org
Subject: [PATCH 28/41] riscv: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
Date: Fri, 14 Mar 2025 08:09:59 +0100
Message-ID: <20250314071013.1575167-29-thuth@redhat.com>
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

Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/riscv/include/uapi/asm/kvm.h        | 2 +-
 arch/riscv/include/uapi/asm/ptrace.h     | 4 ++--
 arch/riscv/include/uapi/asm/sigcontext.h | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index f06bc5efcd79a..1b460e8c6263b 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -9,7 +9,7 @@
 #ifndef __LINUX_KVM_RISCV_H
 #define __LINUX_KVM_RISCV_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 #include <asm/bitsperlong.h>
diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
index a38268b19c3d3..beff8df80ac9c 100644
--- a/arch/riscv/include/uapi/asm/ptrace.h
+++ b/arch/riscv/include/uapi/asm/ptrace.h
@@ -6,7 +6,7 @@
 #ifndef _UAPI_ASM_RISCV_PTRACE_H
 #define _UAPI_ASM_RISCV_PTRACE_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 
@@ -127,6 +127,6 @@ struct __riscv_v_regset_state {
  */
 #define RISCV_MAX_VLENB (8192)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _UAPI_ASM_RISCV_PTRACE_H */
diff --git a/arch/riscv/include/uapi/asm/sigcontext.h b/arch/riscv/include/uapi/asm/sigcontext.h
index cd4f175dc8376..748dffc9ae194 100644
--- a/arch/riscv/include/uapi/asm/sigcontext.h
+++ b/arch/riscv/include/uapi/asm/sigcontext.h
@@ -15,7 +15,7 @@
 /* The size of END signal context header. */
 #define END_HDR_SIZE	0x0
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct __sc_riscv_v_state {
 	struct __riscv_v_ext_state v_state;
@@ -35,6 +35,6 @@ struct sigcontext {
 	};
 };
 
-#endif /*!__ASSEMBLY__*/
+#endif /*!__ASSEMBLER__*/
 
 #endif /* _UAPI_ASM_RISCV_SIGCONTEXT_H */
-- 
2.48.1


