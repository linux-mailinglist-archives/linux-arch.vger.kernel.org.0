Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3B119F93F
	for <lists+linux-arch@lfdr.de>; Mon,  6 Apr 2020 17:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgDFPxn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Apr 2020 11:53:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40330 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729120AbgDFPxm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Apr 2020 11:53:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id h11so6071394plk.7;
        Mon, 06 Apr 2020 08:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XrqzwjI0j/nMPAOrM34wtWItxFTYrHCtPj6nWTiU39U=;
        b=K4d+VMtQX1FGgK6IRSZUkqDLpw4X7hN4+EwKFJ2zQ2vJsuEUiRlLI35bTgxtfPggIK
         Mpn/NXJI4NU7nqEOhGPfI4PjiXBvu686SyIfekEZ/9K64RivXS/i14m47LR28rAjLy5E
         U5+ciRL+R1gaU6sDEamDzLLRIVJB1J9bGA8a+hnoInuzPQOoB5wJPbAYMSRN+Ngf4Geg
         z8z18AyZ4jlylFcgNb7kggTgts1fmhTyM0dZNZimd0jNd3GHObXyBtWZMChBRUzxUl7i
         nWEWwJujtGW6s5NA8+ubaGttj1l2tG/SWQJ3svhwjdznjkma2kBxK/bjtVOfMdCyhEQj
         uGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XrqzwjI0j/nMPAOrM34wtWItxFTYrHCtPj6nWTiU39U=;
        b=dfweJXhHSRaHNC1bHjX7jBuyW45zfIsCnOEgTqa4r7lvh7bdWKv6joAnJxof3lbcPk
         NPnzNL9jP1ImUDlk0HJDS965BTk10eVamX8qZmuCyVowg2EREKjDXZ8STKMKe7VnWNKL
         lHvMtV+XdaJ/cC0VheJ7RfxPsaSCiTXbxB+DK9EyEz2MaWIH4Ecy9i6AiPE3QSzyyMWw
         lXPrCPN/xstw2Q9Dzrk6HOf2OEIIVAOpmu/UlcfEU2kE57cmh10C/IqELYzMoS7S1do0
         NkXVLd9O+LXPk5uqjNAKvLhPoSR39d+FZJQ4ggZTQn50KsWiQImjvKWA1iTRGcw672ze
         /GXQ==
X-Gm-Message-State: AGi0PuYJdUTlRAYgrzlZh83Luw7FihdgxYYnchzV01wdeptFPGCI5Oee
        kZlSer+4jMUVNrxEWtd+VWY=
X-Google-Smtp-Source: APiQypKxfSP0gOXTwB28CTPsaKYc32lPalwB8tcRZHWYSRxl7nNfLLCooTqlfWpYo4oOZtOoZQ5oIQ==
X-Received: by 2002:a17:90a:354e:: with SMTP id q72mr52988pjb.174.1586188420785;
        Mon, 06 Apr 2020 08:53:40 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([131.107.160.210])
        by smtp.googlemail.com with ESMTPSA id 79sm11823275pfz.23.2020.04.06.08.53.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 08:53:40 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, vkuznets@redhat.com
Subject: [PATCH V4 6/6] x86/Hyper-V: Report crash data in die() when panic_on_oops is set
Date:   Mon,  6 Apr 2020 08:53:31 -0700
Message-Id: <20200406155331.2105-7-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
References: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

When oops happens with panic_on_oops unset, the oops
thread is killed by die() and system continues to run.
In such case, guest should not report crash register
data to host since system still runs. Check panic_on_oops
and return directly in hyperv_report_panic() when the function
is called in the die() and panic_on_oops is unset. Fix it.

Fixes: 7ed4325a44ea ("Drivers: hv: vmbus: Make panic reporting to be more useful")
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
Change since v3:
	- Fix compile error.
        - Add fix commit in the change log
---
 arch/x86/hyperv/hv_init.c      | 6 +++++-
 drivers/hv/vmbus_drv.c         | 5 +++--
 include/asm-generic/mshyperv.h | 2 +-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index b0da5320bcff..31e1d70f7e03 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -20,6 +20,7 @@
 #include <linux/mm.h>
 #include <linux/hyperv.h>
 #include <linux/slab.h>
+#include <linux/kernel.h>
 #include <linux/cpuhotplug.h>
 #include <linux/syscore_ops.h>
 #include <clocksource/hyperv_timer.h>
@@ -419,11 +420,14 @@ void hyperv_cleanup(void)
 }
 EXPORT_SYMBOL_GPL(hyperv_cleanup);
 
-void hyperv_report_panic(struct pt_regs *regs, long err)
+void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die)
 {
 	static bool panic_reported;
 	u64 guest_id;
 
+	if (in_die && !panic_on_oops)
+		return;
+
 	/*
 	 * We prefer to report panic on 'die' chain as we have proper
 	 * registers to report, but if we miss it (e.g. on BUG()) we need
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 172ceae69abb..a68bce4d0ddb 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -31,6 +31,7 @@
 #include <linux/kdebug.h>
 #include <linux/efi.h>
 #include <linux/random.h>
+#include <linux/kernel.h>
 #include <linux/syscore_ops.h>
 #include <clocksource/hyperv_timer.h>
 #include "hyperv_vmbus.h"
@@ -75,7 +76,7 @@ static int hyperv_panic_event(struct notifier_block *nb, unsigned long val,
 	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE
 	    && hyperv_report_reg()) {
 		regs = current_pt_regs();
-		hyperv_report_panic(regs, val);
+		hyperv_report_panic(regs, val, false);
 	}
 	return NOTIFY_DONE;
 }
@@ -92,7 +93,7 @@ static int hyperv_die_event(struct notifier_block *nb, unsigned long val,
 	 * the notification here.
 	 */
 	if (hyperv_report_reg())
-		hyperv_report_panic(regs, val);
+		hyperv_report_panic(regs, val, true);
 	return NOTIFY_DONE;
 }
 
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index b3f1082cc435..1c4fd950f091 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -163,7 +163,7 @@ static inline int cpumask_to_vpset(struct hv_vpset *vpset,
 	return nr_bank;
 }
 
-void hyperv_report_panic(struct pt_regs *regs, long err);
+void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die);
 void hyperv_report_panic_msg(phys_addr_t pa, size_t size);
 bool hv_is_hyperv_initialized(void);
 bool hv_is_hibernation_supported(void);
-- 
2.14.5

