Return-Path: <linux-arch+bounces-10774-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8785A609A4
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 08:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F285D3BFD8C
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 07:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03451DDA18;
	Fri, 14 Mar 2025 07:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KI8gPlQ3"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA31D1DB55C
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936308; cv=none; b=T4bpY4cYFXrbyhkGOEua5Fae9qaLnpV4GCbP0/WS5iZGuChwkywOl8KB9eKbVE3qL5QkkE+lQq4pkP2L+jP2kvTHjUqUgX9wjLhIPPkvcDlfE9tmtmN1FGO5ReaDTs376J74D2TiF5sNDcxAn6RZ8Tt+SIgkTOTPpFdK1MiqYrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936308; c=relaxed/simple;
	bh=OKHu3GGhyADerg2IzyWK22rj3U0zoxD9vfMsMAk9g80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4uW2eaYgAECbP5pRXLcuNE+EtH8lAPTDJw09U1AURh/LRnHkRokJW46Fd4uHteQGYi2pqLW55sOzw4UjA8Zco/5hfz1EEhxnRBbvnC/MQSvNAgCvm44yT7kGh+8hz9gsEuX3u5QBFp+jF/7xwU4oHVfkOU+TEnq5fe+7G270Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KI8gPlQ3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7zuMTpTFPIJgizKsiEcCzfUaR0WNgsZZ61oMOy8ygOw=;
	b=KI8gPlQ39wmRM63+3ykbtpy719JmhVqYo/nuy82Z8k5GyND6uaEXxC4dT9BIXuarjucRBU
	s71xkFofdQh7g1yTuSB82RVo2k9jgkbpbtL16pKY1GXCvNTpOzvvNr9tXTZVqhQh5fupLy
	MKhYxDW6BIkeKj+4DZxNai3b8pf6vmA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687---FORp1DOO2KbwzYPW8yjw-1; Fri,
 14 Mar 2025 03:11:40 -0400
X-MC-Unique: --FORp1DOO2KbwzYPW8yjw-1
X-Mimecast-MFC-AGG-ID: --FORp1DOO2KbwzYPW8yjw_1741936299
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7009B195609E;
	Fri, 14 Mar 2025 07:11:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E5C31801758;
	Fri, 14 Mar 2025 07:11:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Michal Simek <monstr@monstr.eu>
Subject: [PATCH 17/41] microblaze: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
Date: Fri, 14 Mar 2025 08:09:48 +0100
Message-ID: <20250314071013.1575167-18-thuth@redhat.com>
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

Cc: Michal Simek <monstr@monstr.eu>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/microblaze/include/uapi/asm/ptrace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/microblaze/include/uapi/asm/ptrace.h b/arch/microblaze/include/uapi/asm/ptrace.h
index 46dd94cb78021..8039957a1a9cd 100644
--- a/arch/microblaze/include/uapi/asm/ptrace.h
+++ b/arch/microblaze/include/uapi/asm/ptrace.h
@@ -10,7 +10,7 @@
 #ifndef _UAPI_ASM_MICROBLAZE_PTRACE_H
 #define _UAPI_ASM_MICROBLAZE_PTRACE_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 typedef unsigned long microblaze_reg_t;
 
@@ -68,6 +68,6 @@ struct pt_regs {
 
 #endif /* __KERNEL */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _UAPI_ASM_MICROBLAZE_PTRACE_H */
-- 
2.48.1


