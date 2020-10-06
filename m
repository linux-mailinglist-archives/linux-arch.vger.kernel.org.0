Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA5C28498E
	for <lists+linux-arch@lfdr.de>; Tue,  6 Oct 2020 11:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgJFJpe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Oct 2020 05:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgJFJpe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Oct 2020 05:45:34 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0192C061755
        for <linux-arch@vger.kernel.org>; Tue,  6 Oct 2020 02:45:34 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f19so466309pfj.11
        for <linux-arch@vger.kernel.org>; Tue, 06 Oct 2020 02:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QwdAwomAk2ltg1grbV+9NQkaDdoDFru+sqVSXHRR9r4=;
        b=kgjAWyI6FUwUz01E/9QVA5hIQtvgdFDHlwlWvx5VJ8xw/559ybcznHn4ypwe8gZSZE
         dRSzPHSdcpzmxefchXkcEspNS4Wd3Fe2kEcJV5rGFSZt/Azzq9zcVlndM7vYIRBFHaoz
         vp/l0/HHTtetQNyF+A+4hOL5JvM/tNHUtZZnddzK0wH3WocdxSISVJvm68YFe70rvlQc
         ImYyyzn7Nf/sLQO5hrX70Tx0VurqyRzb/jOVDzR0gSKM4A5aZ25Z+cZE4oWO6tinhA06
         y5almCMeS0vb77ylHc+NtrXY85PVGQqwRoGT4vXITs6Qr1ARlkTpT9PDXMCBmEXgXpoA
         JPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QwdAwomAk2ltg1grbV+9NQkaDdoDFru+sqVSXHRR9r4=;
        b=dCic94VdpieQJ1zYUScnZ4l08+KFLQLqmMLFwFi7FlVfOLP7LlvX9+bqJTu5H0DJ0W
         TbcW/bWyyzsimWkmGomxEPMaSCspDzBOhXWIK8jSMOcPXl9bUmIgQshBmqrDj84c4S6B
         8xdIdMrLkpo9akYnvBw+nc6+dWhkeLnzAiPtJlF7mv086qZl8CWc9fu7Xww3uHzapASY
         ozLLhVdmqTjqCUa1aajIG/JQvJUGO+1YmpOI3pg1TFMEBqExKdmr0WkL150h931yAJo4
         r3SvtRvDeVwcCqUKOhNIul7Nrd1nk2vVmDjwmHYppv9z2KQPehgLfhwzwRUnnN/+pkI2
         Wrow==
X-Gm-Message-State: AOAM5310GcJnUt2GpavpgInlo0Zel2vaBTIL7phPRyc1ah3QP6TKXST4
        QbyqjqZwdbQTWIcRGGqnma8=
X-Google-Smtp-Source: ABdhPJwceWBY4lmDdVvqBTBK6OrWYNJx5gwvpgPLkXNoN+BCKrDdt9O3YSCxdgx04o0Q5aYWgzwf+A==
X-Received: by 2002:a62:7744:0:b029:152:4223:1b4e with SMTP id s65-20020a6277440000b029015242231b4emr3699925pfc.60.1601977533642;
        Tue, 06 Oct 2020 02:45:33 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id c12sm2990346pfj.164.2020.10.06.02.45.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Oct 2020 02:45:33 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id D50A920390F4C1; Tue,  6 Oct 2020 18:45:29 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v7 09/21] um: nommu: host interface
Date:   Tue,  6 Oct 2020 18:44:18 +0900
Message-Id: <9494c2558406a8fd2938fef0c470dd640b7835ed.1601960644.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

