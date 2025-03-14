Return-Path: <linux-arch+bounces-10761-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C990BA60976
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 08:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC8419C2EC8
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 07:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF70018DF73;
	Fri, 14 Mar 2025 07:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="guY7TGjo"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F6F16F271
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 07:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936259; cv=none; b=A3+O2u/KowVQKVuQh/IwRUroHPiyqbcb7YwViQ42DGvozNwS2wAzNi1z29u1mePTQGhuE5pjrkNMPBNVgq4tUrjwtvKw7SHTf7RKa4ol1LYekpSHUyPfT4/OCVyZhY42V789WF83pCy0c6He29Nd7PpIYxZwvz+ntZyWPMXUeZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936259; c=relaxed/simple;
	bh=nh8Y/2X/KVLRY755ZBLqq4CBUtbI/ai14s3of9+XGTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kuegu3tOVXdkncLnZGEgr4VW7ZtXKqA4zQYgmFyTk7y4Ai1uNjffFCRUVzrMh7/3o3H0KsfG4BHfj0SQMrzsaUGoomy2b9tNQat2IfwayaXoFhpKfAnmxd61GDLZD0HacD5z0snKUyrZut1qs9p0XJqy5xTQbcYFHE9R4t6zv0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=guY7TGjo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9DH5r5nUiV9oMJ9t9HWO/gI/Ze20kxPCau4i0GakJus=;
	b=guY7TGjoGnoSwSD/E5qEbH77lLiM1G6/Cp6vvuSshkYzy9lx3vaccDL9D6vX79X9CqOv+L
	v+YzlcjIvEi4YOYlDJPlAX8kgnyOHQADm1uqc6EG+/o9SdU5NRbYDLJZ3Ud71DhHyTjpC+
	GQOnRv4HmlAlpGcibrI2uO+OAgt4EII=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-ih_sP1kiOGC6BEcYPTApIg-1; Fri,
 14 Mar 2025 03:10:53 -0400
X-MC-Unique: ih_sP1kiOGC6BEcYPTApIg-1
X-Mimecast-MFC-AGG-ID: ih_sP1kiOGC6BEcYPTApIg_1741936252
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87AE919560B4;
	Fri, 14 Mar 2025 07:10:52 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B783B18001D4;
	Fri, 14 Mar 2025 07:10:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Vineet Gupta <vgupta@kernel.org>,
	linux-snps-arc@lists.infradead.org
Subject: [PATCH 04/41] arc: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
Date: Fri, 14 Mar 2025 08:09:35 +0100
Message-ID: <20250314071013.1575167-5-thuth@redhat.com>
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

Cc: Vineet Gupta <vgupta@kernel.org>
Cc: linux-snps-arc@lists.infradead.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/arc/include/uapi/asm/ptrace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arc/include/uapi/asm/ptrace.h b/arch/arc/include/uapi/asm/ptrace.h
index 2a6eff57f6dd8..3ae832db278cd 100644
--- a/arch/arc/include/uapi/asm/ptrace.h
+++ b/arch/arc/include/uapi/asm/ptrace.h
@@ -14,7 +14,7 @@
 
 #define PTRACE_GET_THREAD_AREA	25
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * Userspace ABI: Register state needed by
  *  -ptrace (gdbserver)
@@ -53,6 +53,6 @@ struct user_regs_arcv2 {
 	unsigned long r30, r58, r59;
 };
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* _UAPI__ASM_ARC_PTRACE_H */
-- 
2.48.1


