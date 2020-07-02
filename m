Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4D72125A4
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 16:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgGBOI7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 10:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729363AbgGBOI6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 10:08:58 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E990C08C5C1
        for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2020 07:08:58 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id u8so12198159pje.4
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2020 07:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QwdAwomAk2ltg1grbV+9NQkaDdoDFru+sqVSXHRR9r4=;
        b=BjV9ggak1qS7sx7q9gGxO75x9GkcaqisDOfzuFdC77jOO0bdV1ekcIV8P5Ix1Dl+DU
         0f9ZfY3AUy6GGYDUANh0rdiGQmKpyWKrXfJJlJmrq+HwUcmv4z3CbCxkClngJupcWYG7
         Aoe9b6spsx6Y2YsTCAJDqQAMnqbFgwraa+IozcweWKM662A/RDJXbdamfEwYT3wpXE/B
         SzaAExupi+jxiFOKE4Id2mTB+OI/RJK2STlh9VGUhlO+xx41bn26UnwM0IZ8ZTJlzPbz
         Yt+CvRHqp2g6EvH5ffeKVHmjQwNQrTCVp5iYBMN15Ef5YVyarlexn3TaXS212o5oHkCY
         6yRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QwdAwomAk2ltg1grbV+9NQkaDdoDFru+sqVSXHRR9r4=;
        b=hrtbUaRA+VhmBKB8ZRs7RFf4mXPtgZ0V2clvobTJEXfY6DSmils814jvTFI5FFJ39M
         DTleJ86KzTyiYHCykqR4yjHu8QKCQkvhqIJtGrETsSt44lPcbOEJJbmN6XzEZVcNgsmk
         2wIOsLzvpr56XWEYlyN83RtvU/hsBO+rLTPz/z8jLN30qo9kP/JAxu9NI7FMPfz1LXjN
         kTYnkwAm+0yESorC5bvsFspr8Ghc5cqlm7CdNLEpFQ4wcMwB7EVcachEXP1AYB07VnUQ
         B2uXvGJGBPvGqIfAahgLSvJF98aIgXKlsOjonEZMkt3R6cRqhfj2wy2e5cURvQvh5eM4
         SScg==
X-Gm-Message-State: AOAM533S5/ktHlqqmH+auG04P/EVzPvDd+1ZVL9WbfZkPu6VnjO76yP/
        GD8lkm2PDO8SSkYOODgjTcg=
X-Google-Smtp-Source: ABdhPJzeYk5OStImCc6jXwI7wK2f4JubzcH2A4ddZYtKMmjeNqvf4JHDCZgKZ8gbIuX3X5pfsqmeBg==
X-Received: by 2002:a17:902:a412:: with SMTP id p18mr26270151plq.341.1593698938073;
        Thu, 02 Jul 2020 07:08:58 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id o128sm9313973pfg.127.2020.07.02.07.08.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jul 2020 07:08:57 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id B14FC202D31D23; Thu,  2 Jul 2020 23:08:55 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v5 09/21] um: nommu: host interface
Date:   Thu,  2 Jul 2020 23:07:03 +0900
Message-Id: <c1c6be020d29b66678948e7a2c8abe2db90cb32f.1593697069.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1593697069.git.thehajime@gmail.com>
References: <cover.1593697069.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch introduces the host operations that define the interface
between the LKL and the host. These operations must be provided either
by a host library or by the application itself.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/include/asm/host_ops.h            |  9 ++++++++
 arch/um/nommu/include/uapi/asm/host_ops.h | 25 +++++++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 arch/um/include/asm/host_ops.h
 create mode 100644 arch/um/nommu/include/uapi/asm/host_ops.h

diff --git a/arch/um/include/asm/host_ops.h b/arch/um/include/asm/host_ops.h
new file mode 100644
index 000000000000..f52423cc4ced
--- /dev/null
+++ b/arch/um/include/asm/host_ops.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LKL_HOST_OPS_H
+#define _ASM_LKL_HOST_OPS_H
+
+#include <uapi/asm/host_ops.h>
+
+extern struct lkl_host_operations *lkl_ops;
+
+#endif
diff --git a/arch/um/nommu/include/uapi/asm/host_ops.h b/arch/um/nommu/include/uapi/asm/host_ops.h
new file mode 100644
index 000000000000..d3dad11b459e
--- /dev/null
+++ b/arch/um/nommu/include/uapi/asm/host_ops.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __UM_NOMMU_UAPI_HOST_OPS_H
+#define __UM_NOMMU_UAPI_HOST_OPS_H
+
+/* Defined in {posix,nt}-host.c */
+struct lkl_mutex;
+struct lkl_sem;
+typedef unsigned long lkl_thread_t;
+struct lkl_jmp_buf {
+	unsigned long buf[128];
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

