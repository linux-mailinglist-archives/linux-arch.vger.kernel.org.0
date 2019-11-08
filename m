Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E35EF3F1A
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 06:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfKHFDP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 00:03:15 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39794 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfKHFDO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 00:03:14 -0500
Received: by mail-pf1-f195.google.com with SMTP id x28so3856520pfo.6
        for <linux-arch@vger.kernel.org>; Thu, 07 Nov 2019 21:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YLBv28t/SZ6XhMh/ECVb3wO9hVp5l1KVjRiLPR46eIE=;
        b=btVyx1kPPjh4mSA69tepMmzog+HYofS3S0W0EV3leAnpcyTKI0S4xl7kXusU6YghRr
         +xwx2fKuXpVi7Ug2CfmszzDgIhgpCBnoMkF2IdKMcMshc+z+iAaPHJgaVaDTkPmzwYdU
         eT/zAs3I0F7xFBoGBDkfTtk7/QNSJG/SfZctmvQNrtyxyiq95oufRC3YCliVofnvYJ6C
         nl86KyzUPCcfRXwOPdN/7MOr0LIxgqM0Xz6+EnHCgiPPSRIvq6ZPujW9VYne/kYNIYJ/
         KOwrPSARfjR7ZuvnUD/n/S3zWW4oVglfj0VsIS7RpNyKg+F4xX2pQz7qaNHVDNY/y/0U
         Imzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YLBv28t/SZ6XhMh/ECVb3wO9hVp5l1KVjRiLPR46eIE=;
        b=QYzjk0lK5rTm9LcenvzoaMosSchJzgURUUDLAmKqeiLYRa3IAEOJW6YGgH0HKvy/is
         NhrpiIgxI2mb7I4a+C/TL8oARYy+vGaoUPDy6Y49Dt6yP4JrSKkHgbB7OB8/lsq+9qlO
         WWlPB2l7BAm7uh6FBKl2IR9tNCjW6/7m1AIJp+SaEO2oys6xaVX/8AEk3pr9UqRNHux9
         +/q9ie/jzAsfgKTccwFCbB+eV83BLvkdvTgsh6ZveU30Y+XwyociHkd5265fqUWWkWgA
         z2i+vwD0JQXn4Rvg5Q6J0+3aVk8qCf/QV8EbHZPip/R9bxom3UVNsrTutGnINGq4NxIK
         AACQ==
X-Gm-Message-State: APjAAAWBd5670ue2x613CcvbXG3XsbbC4TP7FTLeVt+DwCG4m9rLFLNc
        MBeZashChwMeWlxVfdI90zw=
X-Google-Smtp-Source: APXvYqzmcEteZxjQ2l6elKj7USALdYkMB15NXFAI6fQtZouXy6fVPYhhRjH0yJ2wZZ0uJgup+KJBDA==
X-Received: by 2002:a63:491e:: with SMTP id w30mr9348687pga.342.1573189393733;
        Thu, 07 Nov 2019 21:03:13 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id d23sm4359162pfo.140.2019.11.07.21.03.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 21:03:12 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 873F4201ACFCA0; Fri,  8 Nov 2019 14:03:11 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>,
        Michael Zimmermann <sigmaepsilon92@gmail.com>,
        Patrick Collins <pscollins@google.com>,
        Pierre-Hugues Husson <phh@phh.me>,
        Yuan Liu <liuyuan@google.com>
Subject: [RFC v2 04/37] lkl: host interface
Date:   Fri,  8 Nov 2019 14:02:19 +0900
Message-Id: <2ed53834403f7c12066ba13d0849038479d36e2a.1573179553.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1573179553.git.thehajime@gmail.com>
References: <cover.1573179553.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Octavian Purdila <tavi.purdila@gmail.com>

This patch introduces the host operations that define the interface
between the LKL and the host. These operations must be provided either
by a host library or by the application itself.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Michael Zimmermann <sigmaepsilon92@gmail.com>
Signed-off-by: Patrick Collins <pscollins@google.com>
Signed-off-by: Pierre-Hugues Husson <phh@phh.me>
Signed-off-by: Yuan Liu <liuyuan@google.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 arch/um/lkl/include/asm/host_ops.h      | 10 ++++++++++
 arch/um/lkl/include/uapi/asm/host_ops.h | 26 +++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 arch/um/lkl/include/asm/host_ops.h
 create mode 100644 arch/um/lkl/include/uapi/asm/host_ops.h

diff --git a/arch/um/lkl/include/asm/host_ops.h b/arch/um/lkl/include/asm/host_ops.h
new file mode 100644
index 000000000000..65850f394b79
--- /dev/null
+++ b/arch/um/lkl/include/asm/host_ops.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LKL_HOST_OPS_H
+#define _ASM_LKL_HOST_OPS_H
+
+#include "irq.h"
+#include <uapi/asm/host_ops.h>
+
+extern struct lkl_host_operations *lkl_ops;
+
+#endif
diff --git a/arch/um/lkl/include/uapi/asm/host_ops.h b/arch/um/lkl/include/uapi/asm/host_ops.h
new file mode 100644
index 000000000000..7cfb0a93e6a6
--- /dev/null
+++ b/arch/um/lkl/include/uapi/asm/host_ops.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _ASM_UAPI_LKL_HOST_OPS_H
+#define _ASM_UAPI_LKL_HOST_OPS_H
+
+/* Defined in {posix,nt}-host.c */
+struct lkl_mutex;
+struct lkl_sem;
+struct lkl_tls_key;
+typedef unsigned long lkl_thread_t;
+struct lkl_jmp_buf {
+	unsigned long buf[32];
+};
+
+/**
+ * lkl_host_operations - host operations used by the Linux kernel
+ *
+ * These operations must be provided by a host library or by the application
+ * itself.
+ *
+ */
+struct lkl_host_operations {
+};
+
+void lkl_bug(const char *fmt, ...);
+
+#endif
-- 
2.20.1 (Apple Git-117)

