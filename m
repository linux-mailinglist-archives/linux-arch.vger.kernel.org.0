Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C90E71526DD
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2020 08:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgBEHa6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 02:30:58 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33199 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgBEHa5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 02:30:57 -0500
Received: by mail-pj1-f66.google.com with SMTP id m7so1630660pjs.0
        for <linux-arch@vger.kernel.org>; Tue, 04 Feb 2020 23:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RKef0Si42OEfpiKCb0RBwsAXF8ojY8UauQkTHAz5Bio=;
        b=LALwKKy6UL+Jt0hh9SF5+HNFnYuk4Xv2z0Z78ixsNPP+e59mnuDkMIX8hihAC4xo/I
         2TR5PbIY8iMTNwk5NgbjEYoF+q4QxUIMfaW9GDR3vYqVBz8KE7jAGemr17mAosd6qK8l
         vtS/lfo0HS4fYnXeI/VJ/Cow/7Y7avbIlEKhUWtrC7enrqf3He1/SC7/s3u0ZXtp48nw
         8r365Z6iLKWIsaaY020CAGCM71RSeWmGyflxmGtbz+SuVsdy8F8aYZj78Ip5yS0j4nQa
         Nmhvu63A5uFUn97T/l1u6i9+IR910v0owdrvh/ONSCo4aI5ipjswo49k6hMmnBsihA2A
         wJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RKef0Si42OEfpiKCb0RBwsAXF8ojY8UauQkTHAz5Bio=;
        b=TG0VGITQT61YSMCQuSHZC4IaVJWoS376KOB11eCbPOYXBv9543Z1S9XQCNjDspj/iT
         aUfPwvtCgzw/cxvPiUtQBqEGaorW+5gEXkUEfYe1MJIO4B1YDapYm8+ur/p30W8Kyqtp
         PWbQYLLFEWRGgR3V3EqNGJlz1A08lBji1lNKCl2Abo3ADUFYHeX+DkNICFvbybLa0Ybh
         gVdyAaj8+/WIY7sCPNtzCnN5TaiYRrhrJ0JUAQM/biFL7swCHCV/vQY6mt+kOy++e2ia
         DmtE2eAHBdZ+KFb6CNwxCjFhA/PFZUo3V8uazwHPSKxM/gXGtZq93WweRNwxc72ZNgFl
         I+QA==
X-Gm-Message-State: APjAAAVNed99HGo6AESQamNsV1nke2VMgcJFMUQZI4QVrWWz/EpStQp7
        q0nMtW2M9bTuBauIWOeatbU=
X-Google-Smtp-Source: APXvYqxE/1i2z6cwJSSiGzWT2QskQHaXtbcZSSKuQXisp9/VfuYaDb3OQNuVmg/j8xZAV1ZJk1U5uA==
X-Received: by 2002:a17:902:bd86:: with SMTP id q6mr29865763pls.143.1580887857106;
        Tue, 04 Feb 2020 23:30:57 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id w18sm23111665pfq.167.2020.02.04.23.30.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Feb 2020 23:30:55 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 5F7FD202572FCB; Wed,  5 Feb 2020 16:30:53 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Michael Zimmermann <sigmaepsilon92@gmail.com>,
        Patrick Collins <pscollins@google.com>,
        Pierre-Hugues Husson <phh@phh.me>,
        Yuan Liu <liuyuan@google.com>,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v3 04/26] um lkl: host interface
Date:   Wed,  5 Feb 2020 16:30:13 +0900
Message-Id: <f1460ace30d533fbb79ad3d5ec43075daa047e16.1580882335.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1580882335.git.thehajime@gmail.com>
References: <cover.1580882335.git.thehajime@gmail.com>
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

Cc: Michael Zimmermann <sigmaepsilon92@gmail.com>
Cc: Patrick Collins <pscollins@google.com>
Cc: Pierre-Hugues Husson <phh@phh.me>
Cc: Yuan Liu <liuyuan@google.com>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
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
2.21.0 (Apple Git-122.2)

