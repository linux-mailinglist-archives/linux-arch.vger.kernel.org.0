Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA682FC937
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 04:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbhATDj3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jan 2021 22:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731743AbhATC3U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jan 2021 21:29:20 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADAFC06179A
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:28:27 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id u11so7385160plg.13
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rQW7spPCAhWgWHPAjxAOsVtKuZNVm+QADzqQsI94rGg=;
        b=rFBnSu+SFHW2MUOgJ9kG+mK4J6/Jl3FqcPqoKvgW14IOFxnW/c7JA5Cv3RqPreCWYe
         5ue9222BBeZoqtjhtdtzDnBH/KsZCvr5cdwfK8OwOJPOFfTVnnkUw5UA1GcOiwL769Xq
         UB24k1Kfl1mR2pVNS8yJzAvERticnqPHOrNIIFHZDJUMDMHQybGWRXoxCsO0+NQWNZ23
         KQsATxFPpUPSa+bepBT8J8azIBwFdFMbFQOvHYtHmWj9HXMjkMobRC3yQpUbUv/csPMC
         ut9tjfkkNYj6k5ofMnQ8fa+z83TSa2ng/nn/yYOtO4auVc0q2DNhYn4/4lAl6MyDlGEL
         +LqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rQW7spPCAhWgWHPAjxAOsVtKuZNVm+QADzqQsI94rGg=;
        b=KJGYHyZeIpJXixtU3hKDT+gLHphAtSu9N8UXaLR0M0L1IA9CzDcpmrmGM1Mco+uamr
         R/FRIJI18/MnWb5KNq1rlzOvEgiPsvDt1t2ka/jM4nSvQGceB6DKAVMeOrAykpeioLfX
         reIWdm32+0t6JELEnC3TVWFpa5OW7YMvFFzAEpj/7Jd8uCw62zvNHJQ/tdr8ViliWktk
         /zjB6apgRMQFBwz6KWaFlNapET2oNCqMmVhDUVpF94xVDzeEEQZg71V84Jnk89JeyQQX
         wIi/F0rKwL/f/BM1BE11E61zZnHZu/C4gB0FYrDMpWaI1lGDoAa/iaMROoIOX/7F93o0
         6GIg==
X-Gm-Message-State: AOAM5337Ohb5DgMAirMRm7VyG08SlTOjqUjxmwUL5tkA9RIJdoNT411s
        BgtrzprO8CzglxUwBkFdjvY=
X-Google-Smtp-Source: ABdhPJwN0wfCReqhj2B6jXCygd0AS3yRO+8uqysiw18iCi2/+44FFeBH7rAh/TytKrObVs6QzrutrA==
X-Received: by 2002:a17:902:eccb:b029:de:8483:505d with SMTP id a11-20020a170902eccbb02900de8483505dmr7647569plh.63.1611109707384;
        Tue, 19 Jan 2021 18:28:27 -0800 (PST)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id f7sm256790pjs.25.2021.01.19.18.28.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jan 2021 18:28:26 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 8EF6B20442D329; Wed, 20 Jan 2021 11:28:24 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     thehajime@gmail.com, tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org
Subject: [RFC v8 07/20] um: lkl: host interface
Date:   Wed, 20 Jan 2021 11:27:12 +0900
Message-Id: <f149135f1943eb81998d54c923c10ebffb0b4518.1611103406.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
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
 arch/um/include/asm/host_ops.h          |  9 +++++++++
 arch/um/lkl/include/uapi/asm/host_ops.h | 23 +++++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 arch/um/include/asm/host_ops.h
 create mode 100644 arch/um/lkl/include/uapi/asm/host_ops.h

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
diff --git a/arch/um/lkl/include/uapi/asm/host_ops.h b/arch/um/lkl/include/uapi/asm/host_ops.h
new file mode 100644
index 000000000000..5d141784541d
--- /dev/null
+++ b/arch/um/lkl/include/uapi/asm/host_ops.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_LIBMODE_UAPI_HOST_OPS_H
+#define __UM_LIBMODE_UAPI_HOST_OPS_H
+
+/**
+ * struct lkl_host_operations - host operations used by the Linux kernel
+ *
+ * These operations must be provided by a host library or by the application
+ * itself.
+ *
+ */
+struct lkl_host_operations {
+};
+
+/**
+ * lkl_bug - call lkl_panic with a message
+ *
+ * @fmt: message format with parameters
+ *
+ */
+void lkl_bug(const char *fmt, ...);
+
+#endif
-- 
2.21.0 (Apple Git-122.2)

