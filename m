Return-Path: <linux-arch+bounces-4141-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 237AE8B9FA3
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 19:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3AB1F22956
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 17:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C6516FF49;
	Thu,  2 May 2024 17:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XyAvVbSH"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC0D16FF39
	for <linux-arch@vger.kernel.org>; Thu,  2 May 2024 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714671505; cv=none; b=C/J4NWKVZaFhjyCf3pD2Z5dFvMj2rZns6JZLtiZuXUjCTkPRYJ6ojP1rRB6UzHIw/1Mrlpfj1ReT6c9w872+T5DolNo4e+o3Yuti6bhlVF/vuw1B9EQXWze9D17/dGaZE7Et/AO+rWPbhVevDKNMrA07UUW3TW9o7br09f9mnfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714671505; c=relaxed/simple;
	bh=GvwRPHoxtk/jezrpSCZ86ku2akWlX5bSrTJGDd347OE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jfd86NXIQEBEp7ss6jrFKqExiycJExBn4wViaPD3aIqvC8R7Eizb1SbbguRl9l9yAUEKJi77euYnytA060wqP6rsIombfFdhprkLERmBgpKAcoQSwq9JXFXsshdUfgkZCHcnrfhArvhjehzX0kX/yDi2X0baQ3MPPBrSlpwZpBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XyAvVbSH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714671502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3JxNBtIIqVU4bz0zF1ZmAy1QkpyEGqwoMSlvusLpYz4=;
	b=XyAvVbSHsJUB5GzE7rVbLoPn7veYo1Xb3rR+7JT1gz6cKYFCbEz4BrLr2GqLta8e8/hM5J
	eYY4/4C8SB+6PXme5plnyT+kkZkSAOfjQVIiFR7dVnYkVU8qIiW7PmZSSpRIY89JnkxE26
	8l/KD+g9Ufo9SMrCl4wsQl3o/FCRwP0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-jV_WCGHFOX6v_SgVPx2G9Q-1; Thu, 02 May 2024 13:38:21 -0400
X-MC-Unique: jV_WCGHFOX6v_SgVPx2G9Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F31D78032FA;
	Thu,  2 May 2024 17:38:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B012DEC682;
	Thu,  2 May 2024 17:38:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Brian Cain <bcain@quicinc.com>
Cc: linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-hexagon@vger.kernel.org
Subject: [PATCH] hexagon: Move kernel prototypes out of uapi/asm/setup.h header
Date: Thu,  2 May 2024 19:38:18 +0200
Message-ID: <20240502173818.58152-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

The kernel function prototypes are of no use for userspace and
shouldn't get exposed in an uapi header, so let's move them into
an internal header instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/hexagon/include/asm/setup.h      | 20 ++++++++++++++++++++
 arch/hexagon/include/uapi/asm/setup.h | 14 ++------------
 2 files changed, 22 insertions(+), 12 deletions(-)
 create mode 100644 arch/hexagon/include/asm/setup.h

diff --git a/arch/hexagon/include/asm/setup.h b/arch/hexagon/include/asm/setup.h
new file mode 100644
index 000000000000..9f2749cd4052
--- /dev/null
+++ b/arch/hexagon/include/asm/setup.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ */
+
+#ifndef _ASM_HEXAGON_SETUP_H
+#define _ASM_HEXAGON_SETUP_H
+
+#include <linux/init.h>
+#include <uapi/asm/setup.h>
+
+extern char external_cmdline_buffer;
+
+void __init setup_arch_memory(void);
+
+#endif
diff --git a/arch/hexagon/include/uapi/asm/setup.h b/arch/hexagon/include/uapi/asm/setup.h
index 8ce9428b1583..598f74f671f6 100644
--- a/arch/hexagon/include/uapi/asm/setup.h
+++ b/arch/hexagon/include/uapi/asm/setup.h
@@ -17,19 +17,9 @@
  * 02110-1301, USA.
  */
 
-#ifndef _ASM_SETUP_H
-#define _ASM_SETUP_H
-
-#ifdef __KERNEL__
-#include <linux/init.h>
-#else
-#define __init
-#endif
+#ifndef _UAPI_ASM_HEXAGON_SETUP_H
+#define _UAPI_ASM_HEXAGON_SETUP_H
 
 #include <asm-generic/setup.h>
 
-extern char external_cmdline_buffer;
-
-void __init setup_arch_memory(void);
-
 #endif
-- 
2.44.0


