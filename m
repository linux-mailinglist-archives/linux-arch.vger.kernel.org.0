Return-Path: <linux-arch+bounces-14999-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B10FDC785D0
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 11:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 893E8350A08
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 10:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B6934B69F;
	Fri, 21 Nov 2025 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JjWY37Er"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D637234BA24
	for <linux-arch@vger.kernel.org>; Fri, 21 Nov 2025 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719277; cv=none; b=GGCfqTRfh4tG8KLyXk8HR+5BdZeN9qAmbo/MlyA81jm/Ya1JeYwdke59S+CcHva8FpMUhRiC5VqQYPJ2mnEHBNZETvepwJSL0ZiN8CVGqt7ejHxm+AU8CD+y4CX9ccuqwxSo/cVeXnt/ZoDtmmshru1xBGj0mDpyvJ27m03mLN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719277; c=relaxed/simple;
	bh=tTBrStqZDoU4dQkJ53jPDPLNkhKZ68tF63B1Vr2sOng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZoiGkHXQRJVe2XAF7aVb10yD4k3EZWVQeJOeZIbhMTVbUxinRWvSyXuFezYlAMI1kxvmbKoNZC1EDDjqjiU5RIsqrXtud82Xau9miAMjoyI/AG0zTAYByY1vYbW7dXKf9GyP/kXSqEv7qMPhbEB+NIw6IKyxHu055ifpUUGkzr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JjWY37Er; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763719273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nc9aRQB9cflUGnoGvuuPbilyJvXJTYtWgN2fto6TDTw=;
	b=JjWY37ErfHQwbXzFOf9q4BfFg9+2SwMFRVUG5C0g0Bo/W1u6n8TW0D3eLljy2nbRoqaZW4
	ombQQucn/UGSeJfVpOGWREYJPWBxtpUnIrL13at+qxXHO3f36eM0M72PLx8AXfyJNI8luK
	368JQVMrnzj9SrcEOIvEGMVZPE+h5qo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-1ukCfpEfMKCdA65478e4fw-1; Fri,
 21 Nov 2025 05:01:06 -0500
X-MC-Unique: 1ukCfpEfMKCdA65478e4fw-1
X-Mimecast-MFC-AGG-ID: 1ukCfpEfMKCdA65478e4fw_1763719265
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE1A3195605B;
	Fri, 21 Nov 2025 10:01:04 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.78])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E3CD1955F6E;
	Fri, 21 Nov 2025 10:01:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kbuild@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v4 2/9] arm: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
Date: Fri, 21 Nov 2025 11:00:37 +0100
Message-ID: <20251121100044.282684-3-thuth@redhat.com>
In-Reply-To: <20251121100044.282684-1-thuth@redhat.com>
References: <20251121100044.282684-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Thomas Huth <thuth@redhat.com>

__ASSEMBLY__ is only defined by the Makefile of the kernel, so
this is not really useful for uapi headers (unless the userspace
Makefile defines it, too). Let's switch to __ASSEMBLER__ which
gets set automatically by the compiler when compiling assembly
code.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/arm/include/uapi/asm/ptrace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/uapi/asm/ptrace.h b/arch/arm/include/uapi/asm/ptrace.h
index 8896c23ccba78..fb829c96dc2ae 100644
--- a/arch/arm/include/uapi/asm/ptrace.h
+++ b/arch/arm/include/uapi/asm/ptrace.h
@@ -119,7 +119,7 @@
 #define PT_DATA_ADDR		0x10004
 #define PT_TEXT_END_ADDR	0x10008
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * This struct defines the way the registers are stored on the
@@ -158,6 +158,6 @@ struct pt_regs {
 #define ARM_VFPREGS_SIZE ( 32 * 8 /*fpregs*/ + 4 /*fpscr*/ )
 
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _UAPI__ASM_ARM_PTRACE_H */
-- 
2.51.1


