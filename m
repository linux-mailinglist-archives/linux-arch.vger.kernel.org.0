Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B127197EC4
	for <lists+linux-arch@lfdr.de>; Mon, 30 Mar 2020 16:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgC3Oqx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Mar 2020 10:46:53 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45667 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgC3Oqw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Mar 2020 10:46:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id t4so850304plq.12
        for <linux-arch@vger.kernel.org>; Mon, 30 Mar 2020 07:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RKef0Si42OEfpiKCb0RBwsAXF8ojY8UauQkTHAz5Bio=;
        b=sA8XzZhH5GUZt+NtMsglSqJvWTyDg098LTWUZd40WhrgZa8/Nej6Tg5l4XbwTaMZ00
         PGHYQwd6AgFgdonzdYiJMca3LHSeGgQrVhByo+4xWAdAlehp/Edj8IXvyeRipJfD5ifb
         RO1KP5GPY/E7i1ZO10xL56obwpz1AUedc02sRn/TzIIegtzqnXGU85ed4qz0iYMTKhxD
         LJvBgFa8ghE7aPslNuN7CQMniCVtbLYWkVj8MUCiEm4Fgwo74dfGyDknL7SzikZCQl9h
         52u2/QZ8BwXIb/0BsAg4f/L575+Kr/pPsbOkp64ZD84zSBx4IWHCxEJQtOGAw+azAbjp
         L+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RKef0Si42OEfpiKCb0RBwsAXF8ojY8UauQkTHAz5Bio=;
        b=ktNvWODGVpsxvXPPadSGwPFCQtlqad1p+IPdKyWmyIubnuppt1Pd3ZNPzrd6FoJfo2
         oW/c34BeYV3zKKn2fJGw1Q1ZerCgcxM6Y8G/xWsvc0LnuVznsyByZKoaIQDamYSOelLW
         QkiNPrFdHRaeB9cMfdfl3mlnXx/k1G4cZVwvtVl1nfFWc2EJNKcyTIaeQpo26il73+sj
         SN/K4uvqxI/GbdMCMQAtkxQ3WchAKBMMwwOLNhC9ft5pcbaKcxiiMx2iFSSvA8CRfznn
         StMdUPlQ/p7Wwc3q11zxmb2l+znwNgBJCCy+LdVYtfSgq9aSYROlpGaMwGZBYB3z+win
         626A==
X-Gm-Message-State: ANhLgQ2MotkAUMlhdVxZLP3wwCLKRyUwYbxCXmvpGzwNGBB3JmZdx9if
        WoD/KuRzyFffWQO4Xft3+4g=
X-Google-Smtp-Source: ADFU+vv4YV0OjN6LnpWbIA1NvMK/gKAb+8rbdMBw87SqbxIJYjLkoiiG7T6WKuQleqjWaoJCM10z8Q==
X-Received: by 2002:a17:902:d705:: with SMTP id w5mr13143925ply.68.1585579609858;
        Mon, 30 Mar 2020 07:46:49 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id 67sm10289633pfe.168.2020.03.30.07.46.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 07:46:49 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 7A418202804C59; Mon, 30 Mar 2020 23:46:47 +0900 (JST)
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
Subject: [RFC v4 03/25] um lkl: host interface
Date:   Mon, 30 Mar 2020 23:45:35 +0900
Message-Id: <f5d1cc3f16ad744cf4f18b8cc2dead79bf123011.1585579244.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1585579244.git.thehajime@gmail.com>
References: <cover.1585579244.git.thehajime@gmail.com>
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

