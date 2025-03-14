Return-Path: <linux-arch+bounces-10763-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF26DA60981
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 08:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573C317EE36
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 07:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89553199943;
	Fri, 14 Mar 2025 07:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3a/Lp+M"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0EA1624D3
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 07:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936266; cv=none; b=GnZluGMB52zQvj5OvcG/f+GKwdiVNekgrKOSFx5qK03XvvhmfcxlyZC8G/McMZDeR4VkV8yAAIGDZqU5bgiqO+uWNVewVBUXmHDYfpaP/0x6HorL8As4NdBiUvuLfazHTMpG1ekqsFfMkINSK8DW0rRdwrQLMq0OMbvW+98VxTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936266; c=relaxed/simple;
	bh=Zmd6A6WMj5t+dSCiJ0RGB68SZaaFNLWGAg2ub3gXqnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlhWflY6kXk+ROrGghqO2mNXsfjsPQ1cg15XCNOLcuqqPRUvBnfIFl882rJZ6oF0nqzCk+nUDFnPOf72m3uiiEtDAYMqzLO0Pft4/Z+bGOPe9zUkbnx81Tp7e9l2XxjmFY09CJ8YelkeZw6oNY/oRjxLmZCWw5fIlWddZS7XimM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3a/Lp+M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SQEqd5abz3pdVrykTBT7fmxrmzSEJu3WYOoaxdZJFI=;
	b=d3a/Lp+MpJYX3OxR8KKwow2OeNACjRn643C1UijDx3sTIMA5kcmqG5Fg0NWkvnpNLK/kS+
	Pnf85x9vyhNy0RD3Fw+JWZiSckPCSmX78lYccjh05Hwhapaq80gHTpijn6HeANx/m0iEQu
	Nyl6vDhdQJ//cf+bE2DI27p+6+ieAOE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-CgBym4mLOuys33ARhyp7Xg-1; Fri,
 14 Mar 2025 03:11:02 -0400
X-MC-Unique: CgBym4mLOuys33ARhyp7Xg-1
X-Mimecast-MFC-AGG-ID: CgBym4mLOuys33ARhyp7Xg_1741936260
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33BBE18007E1;
	Fri, 14 Mar 2025 07:11:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 25FC818001D4;
	Fri, 14 Mar 2025 07:10:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH 06/41] arm: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
Date: Fri, 14 Mar 2025 08:09:37 +0100
Message-ID: <20250314071013.1575167-7-thuth@redhat.com>
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
2.48.1


