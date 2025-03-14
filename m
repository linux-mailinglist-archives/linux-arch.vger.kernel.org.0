Return-Path: <linux-arch+bounces-10776-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3787A609AB
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 08:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC2C3B3C5B
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 07:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D3D17BEC5;
	Fri, 14 Mar 2025 07:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NPGK4T5W"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F5D1946B8
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 07:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936315; cv=none; b=pdBUfHGIC6Mdb+WWR92NDtC+MmbsAdfW1k28tfM6CZWOJHMc2Z8vD2crNUhmovG1wDS5EQg/hCaMxCb9d6+gLiKu5SXtNDrrOhfUZcTh3JlwnQgTcNvH2J8Zfavr7QRC/QNU+ez7DEw87nvnNWrTYQhC7DQGdAF6WaX9C3TZtxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936315; c=relaxed/simple;
	bh=PoiuYi+UdxZabu4PqUnzQiwnxr1s1h7qshT5USHYTW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBiQlCSTZW4aJxxWx3c2sWlQQZ5h7ucdi7x0ZHG39D5PTh4/Jz8usYAxWaH9N9pRODs2ubwLAXkBhRpEOv82Sn6pNwGTOWxvJ4csqn6EUtvvHfO0Dgf1lsvkNL8uBSumpR861MasThnRDM3Jc9sgLnn7PYR2lZWWDov6bNf96iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NPGK4T5W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w/icU0rYwhHsmyhqcav7daSw50Oq8EusYXXaJtzC4eA=;
	b=NPGK4T5WX6v9sdZSZQI9axvGaF8daon8fRFby0NJJS4uGhtWBjeGX5ew7ex9lYZVMugpRh
	8xt2SSy2wms2ty05Mh6U+RuXxUSlBRghPKB7gJGtcAQ1WZ3raQISaOXUp8L0zZPtlo3Nkw
	M2SSJUBBxrDB8GljZ5C3Y6IL+OdqbD8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-x6CbKFiCP9qx__h2jOT-7w-1; Fri,
 14 Mar 2025 03:11:51 -0400
X-MC-Unique: x6CbKFiCP9qx__h2jOT-7w-1
X-Mimecast-MFC-AGG-ID: x6CbKFiCP9qx__h2jOT-7w_1741936310
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D58A5180AB1C;
	Fri, 14 Mar 2025 07:11:50 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CCC7C18001DE;
	Fri, 14 Mar 2025 07:11:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 20/41] nios2: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
Date: Fri, 14 Mar 2025 08:09:51 +0100
Message-ID: <20250314071013.1575167-21-thuth@redhat.com>
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

Cc: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/nios2/include/uapi/asm/ptrace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/nios2/include/uapi/asm/ptrace.h b/arch/nios2/include/uapi/asm/ptrace.h
index 2b91dbe5bcfee..1298db9f0fc98 100644
--- a/arch/nios2/include/uapi/asm/ptrace.h
+++ b/arch/nios2/include/uapi/asm/ptrace.h
@@ -13,7 +13,7 @@
 #ifndef _UAPI_ASM_NIOS2_PTRACE_H
 #define _UAPI_ASM_NIOS2_PTRACE_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 
@@ -80,5 +80,5 @@ struct user_pt_regs {
 	__u32		regs[49];
 };
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _UAPI_ASM_NIOS2_PTRACE_H */
-- 
2.48.1


