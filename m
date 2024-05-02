Return-Path: <linux-arch+bounces-4140-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9ED8B9F8C
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 19:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6AB928C132
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 17:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1450616FF52;
	Thu,  2 May 2024 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ul6mu2Dy"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4CB16FF3D
	for <linux-arch@vger.kernel.org>; Thu,  2 May 2024 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714671101; cv=none; b=NoaSU2SrLnFYN4d9xrMHecvnWTdmSPhAjU9llRVsqBEGTJeqERUKYO4C75OFhwry70aYWs5VsNT6vl5MtBdgqfM+yQ2L57FsROuWtjSKTM1jHAiScjsteDUWRvXi2nBULv4QTPJWOudLWPCiRE8jom/NxGx8SNm7rXj1asVMWH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714671101; c=relaxed/simple;
	bh=7zGK+CxCEqMsn8UIbCCcUkJMqdwExUdxpOZvoZ4zcFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LfZmjLVMKhFHcSkDmgA5uFt4KAcEKVCBNLr3TiwlJ4EvixFVEzApRCN0k0APlrn276SCXI4j7s6Gtq5cYSatkYeitMJCsGPxLg3zVxECskpTGuYmOEPbbWiOXgkJntv6TQRHtf69Sj0hXFT3lYZl1j5cWl4ATaMlLuKk/hSSddI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ul6mu2Dy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714671098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sB91QKrP49e1+jKYA7HCeRe5RMkZyONEHjmLnHX1yds=;
	b=Ul6mu2Dyc3i+SvD2pomsK8p6EnyOA/truVGqIKII9bpzse3nhNOWjE2g3QeHa0OrFuhI88
	DToCUc6etoFZOWq0SA47T8qzlNU0XnMJUmxvHcybQgo7BwOckwXBBUYaaEcFZ3wbNTqENC
	XGFUPf3qTL7cieYcWE3L+rFERkBLREA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-rijvY694PW6aJwZ0J9v_HA-1; Thu, 02 May 2024 13:31:35 -0400
X-MC-Unique: rijvY694PW6aJwZ0J9v_HA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F04EA80017B;
	Thu,  2 May 2024 17:31:34 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9E314203397D;
	Thu,  2 May 2024 17:31:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Michal Simek <monstr@monstr.eu>
Cc: linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: [PATCH] microblaze: Remove empty #ifndef __ASSEMBLY__ statement
Date: Thu,  2 May 2024 19:31:32 +0200
Message-ID: <20240502173132.57098-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Likely an unnecessary remainder of the scripted UAPI cleanup that
happened long ago...

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/microblaze/include/uapi/asm/setup.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/microblaze/include/uapi/asm/setup.h b/arch/microblaze/include/uapi/asm/setup.h
index 6831794e6f2c..16c56807f86a 100644
--- a/arch/microblaze/include/uapi/asm/setup.h
+++ b/arch/microblaze/include/uapi/asm/setup.h
@@ -14,7 +14,4 @@
 
 #define COMMAND_LINE_SIZE	256
 
-# ifndef __ASSEMBLY__
-
-# endif /* __ASSEMBLY__ */
 #endif /* _UAPI_ASM_MICROBLAZE_SETUP_H */
-- 
2.44.0


