Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0E1819F944
	for <lists+linux-arch@lfdr.de>; Mon,  6 Apr 2020 17:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbgDFPxy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Apr 2020 11:53:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42161 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbgDFPxl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Apr 2020 11:53:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id 22so7700062pfa.9;
        Mon, 06 Apr 2020 08:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8eQoSe2M/BULPKm6rT4KkJz9rHpLzA8oR8K4h6ArKs8=;
        b=Fmv6RyJy69p1jnLwXZSETpPwyqLmL3CXQEGqcV7c9Qut2x6fVsSibS1N8SZ7HrSDGd
         9Uxw0MAYpzKT08tSPmcdmBHZCGrcZCwlfWY/YBPpWz59Is4BKO9PbgrWzAqiaAq9MLL2
         fCVsUhtlQJkk09wqYqSl7+YVtQ9bmGgpjqVVP7Us/fwmmyJuqnMBUxEVK6TVM/8U6cZa
         Nse+a3HY5J9btTJzzg8Q0IBAI9rcgLt7BcngHfAStAqfczA+KeWBWS+0VpmjPMFI7hrI
         /4aeVtOp4ILMJJH+tXCrq92dOoPhX6kbyHSGP0v3kDXmljcCmFkRZJwlXlRgmYuFNfP0
         WDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8eQoSe2M/BULPKm6rT4KkJz9rHpLzA8oR8K4h6ArKs8=;
        b=cDrXMvjeXNudjQT37E2K0yu5YNVuBf/rF/IOZb0RWzTgT/HqhvCBpFk72p0nzOe2xH
         xAHzrLga4xnzg7vl6FpNo4nPuFobzGaCCFB2FBEWU/jKv07uevj9mC6lJZ2SjdMRftUY
         z2ZVgDdj8Cdz71JZe9QhhQhKFvTRjU2zUvbQ/rouQr8Vkj/CAJ9PQ00vgkBy92xLtyVa
         iY1wB5WlFCbtubB4IjqQ5a1/zF94Xljku4LZeDUfcCbEzgaMF9sRgQg0s9Bm6wEBXPQz
         Bo018YZ3KaXSLxlWifnRZsxLeORMvD8+NwFofMbB76iTVihxGsHgE5VCCS7RTuZzIYzF
         tzzA==
X-Gm-Message-State: AGi0PuZCfxx0V09Ky6Lq1XvAkh28WXPN7WkkG236/6TepVgDsm9QBt+7
        s7Fosef17RtwfZ1UfqCCsU8=
X-Google-Smtp-Source: APiQypKcbocApIfduaFaeNXg5AUesFEAxP8JcjHgJ/l8LdMfUbt9UNZfVUT3Wb/1fexunRtGokzDeA==
X-Received: by 2002:a62:687:: with SMTP id 129mr103400pfg.209.1586188419798;
        Mon, 06 Apr 2020 08:53:39 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([131.107.160.210])
        by smtp.googlemail.com with ESMTPSA id 79sm11823275pfz.23.2020.04.06.08.53.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 08:53:39 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, vkuznets@redhat.com
Subject: [PATCH V4 5/6] x86/Hyper-V: Report crash register data when sysctl_record_panic_msg is not set
Date:   Mon,  6 Apr 2020 08:53:30 -0700
Message-Id: <20200406155331.2105-6-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
References: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

When sysctl_record_panic_msg is not set, the panic will
not be reported to Hyper-V via hyperv_report_panic_msg().
So the crash should be reported via hyperv_report_panic().

Fixes: 81b18bce48af ("Drivers: HV: Send one page worth of kmsg dump over Hyper-V during panic")
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
Change since v3:
        - Add fix commit in the change log
---
 drivers/hv/vmbus_drv.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 333dad39b1c1..172ceae69abb 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -48,6 +48,18 @@ static int hyperv_cpuhp_online;
 
 static void *hv_panic_page;
 
+/*
+ * Boolean to control whether to report panic messages over Hyper-V.
+ *
+ * It can be set via /proc/sys/kernel/hyperv/record_panic_msg
+ */
+static int sysctl_record_panic_msg = 1;
+
+static int hyperv_report_reg(void)
+{
+	return !sysctl_record_panic_msg || !hv_panic_page;
+}
+
 static int hyperv_panic_event(struct notifier_block *nb, unsigned long val,
 			      void *args)
 {
@@ -61,7 +73,7 @@ static int hyperv_panic_event(struct notifier_block *nb, unsigned long val,
 	 * the notification here.
 	 */
 	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE
-	    && !hv_panic_page) {
+	    && hyperv_report_reg()) {
 		regs = current_pt_regs();
 		hyperv_report_panic(regs, val);
 	}
@@ -79,7 +91,7 @@ static int hyperv_die_event(struct notifier_block *nb, unsigned long val,
 	 * doing hyperv_report_panic_msg() later with kmsg data, don't do
 	 * the notification here.
 	 */
-	if (!hv_panic_page)
+	if (hyperv_report_reg())
 		hyperv_report_panic(regs, val);
 	return NOTIFY_DONE;
 }
@@ -1267,13 +1279,6 @@ static void vmbus_isr(void)
 	add_interrupt_randomness(HYPERVISOR_CALLBACK_VECTOR, 0);
 }
 
-/*
- * Boolean to control whether to report panic messages over Hyper-V.
- *
- * It can be set via /proc/sys/kernel/hyperv/record_panic_msg
- */
-static int sysctl_record_panic_msg = 1;
-
 /*
  * Callback from kmsg_dump. Grab as much as possible from the end of the kmsg
  * buffer and call into Hyper-V to transfer the data.
-- 
2.14.5

