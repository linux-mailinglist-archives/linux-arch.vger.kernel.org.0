Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CDD276A59
	for <lists+linux-arch@lfdr.de>; Thu, 24 Sep 2020 09:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgIXHPE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Sep 2020 03:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgIXHPE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Sep 2020 03:15:04 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E28C0613CE
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2020 00:15:04 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id bw23so1195703pjb.2
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2020 00:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QwdAwomAk2ltg1grbV+9NQkaDdoDFru+sqVSXHRR9r4=;
        b=BH0a5uo5jp049dqpjp2ECh38Gi0b4GWVN5mpv8oiL7iDE5F8xxUTMP+Kh9mbaC0VAf
         kBSJpAHtEemOQDoQlYnYYJYGY8Mu00iynsbyEOeKioDsuYeMZIsGm5FiZBbJ48Mdnfbr
         Tni8MJDilbEReq/W9dd96KVMIhcnmXEbpTPUSsuR9KdCF4mypx1DTRYOatXv7fbng1MT
         9HZg98c2ky+ONVmut762iJrb+bd9NNE0ksZF9dw0LmVhRE6LjhSvyMBkD+W949R39NOV
         j7UTwFr+zE28GNkzCrlit6aW6dSiNfB5vb3JuuLmDYFsQIF/RX1xSa5TjLJqaVo2UgMo
         1M9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QwdAwomAk2ltg1grbV+9NQkaDdoDFru+sqVSXHRR9r4=;
        b=S/YCuR6l1jaEZjY75xMcy0n9BHAIcwqe+Q3XOuFK/pA4iGiSvCvyuwPeCtp44WQhBv
         4Qg+rkq5+nwe3mPAoycQyUA9S27JVhYX37pU6jiY+LsI4DIODdaEtboowymB5g1fw2IL
         Rux/v+voUSuhEMK3xFh7Vr+/D5sMSVox3tw2v7PVOtZTQ1zNHuNiPk77Ekx2oUTth5Ds
         aWV7knGPDGG7RkqpIwiG+c5KHQvLKgHIegxOR1dgZwjb0cdd+18e3cSupvSzFt7f0bud
         Mj7rXFuNDb100eI3KeOIxSMg6tiV1+UT/8bmF4w9BvXsz0Q2SorQHI94NfBTKY3JctCv
         XWhA==
X-Gm-Message-State: AOAM532KFwzXmfE7zOFEbFwcvyff4yirhHJfPzNqENU4T3sVADdaAu7a
        yPXsQA+gZtUHS2sHw2mnilA=
X-Google-Smtp-Source: ABdhPJxqYiC/7wivghrhZuAtVVI0RhkfS67HzvSRJ9NVggJKLS5sbQF8uk+t/hJn1ibvXRCjfpdreQ==
X-Received: by 2002:a17:902:7286:b029:d1:e598:400f with SMTP id d6-20020a1709027286b02900d1e598400fmr3264071pll.73.1600931703572;
        Thu, 24 Sep 2020 00:15:03 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id f207sm1897142pfa.54.2020.09.24.00.15.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Sep 2020 00:15:02 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id C3F0B2037C208E; Thu, 24 Sep 2020 16:15:00 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v6 09/21] um: nommu: host interface
Date:   Thu, 24 Sep 2020 16:12:49 +0900
Message-Id: <8ee5307216dda4f695e84eb1dcc2dab166e08ee7.1600922528.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1600922528.git.thehajime@gmail.com>
References: <cover.1600922528.git.thehajime@gmail.com>
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

