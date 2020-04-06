Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 882B319F948
	for <lists+linux-arch@lfdr.de>; Mon,  6 Apr 2020 17:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgDFPxi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Apr 2020 11:53:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34604 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbgDFPxi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Apr 2020 11:53:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id l14so121202pgb.1;
        Mon, 06 Apr 2020 08:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+9KjE0gcagaW6BknUsMHTQZDdHRFKr6puOdlVuQED7Y=;
        b=m3/NFZitU17lODZBp2pchvapYrneFUQ0huYm9dHIs7f2U9CHd9wESHPBOPwjjZu7qQ
         Zgl3gQyPTIAfIJjN8lywUUKh3nqOpyaTQyPjA7dK8u8Fbih4W6XxxpOsYK16toHI8NO5
         6jmET8qrlop/wm1zjEKemjbwo/DtHd3iTeTbMP/kCYmd0XwpXz9Fk1pLgvMm5q+oEzVj
         7395xyyVR5A1LZQ8T4FPNYuKUfw0U30WZMe6b2bpYxy52O7dKtYFVyL5t1A6hSHiBkFx
         8rED9K8B8GhoWkksxb7Ush9pJfBu245gjJm5mLmJZHZxe9o4xG+wlvihseHTgy7bzlwV
         JiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+9KjE0gcagaW6BknUsMHTQZDdHRFKr6puOdlVuQED7Y=;
        b=Ag5+RC+JTE2fhD2T1RkOK3/BDKYo+EyJT3gItlVHAQXwQCOsp+fAlCS8EP800A3MMp
         VGWzifZg1mVlx/KOBmcWO76GV2+Bm63oT3c1fX3EMx63nIVAYQ4QvzPeKsFnw0pgIzqb
         ZezWHVUiPalHi7lAiBJJfi7eUhEcpUHIeUSFu2HLViTY/byX7Ry2+nn3DyXJHOHdDNI0
         +zjAaxcaFHB3dfikwgVPH8smW+POOe8mdLRUq9gh5Z81wOZxKvtirfCjAAf9wii9PLig
         06QZtXiUU7c1v8FbGz9sYu5BpcLpaCOP6v0iWjFj8KiAPvD8/0vRl1sC5wVJL+TZ/zIv
         57ew==
X-Gm-Message-State: AGi0PuYud7fkK2sXkpM4ZZvNaw5OuzqASo+2/ubdyhs+GieWwnrK1APj
        LfMw7lvaWlWM04AVT6KDS4M=
X-Google-Smtp-Source: APiQypIVSdiqfXCR9ZUhGagiar8jl8iy5SIFWVSyhMtZwpDn+z5l5p7ZtK8al+Ee92teHthmrWJ82w==
X-Received: by 2002:a62:ce48:: with SMTP id y69mr135671pfg.178.1586188415916;
        Mon, 06 Apr 2020 08:53:35 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([131.107.160.210])
        by smtp.googlemail.com with ESMTPSA id 79sm11823275pfz.23.2020.04.06.08.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 08:53:35 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, vkuznets@redhat.com
Subject: [PATCH V4 1/6] x86/Hyper-V: Unload vmbus channel in hv panic callback
Date:   Mon,  6 Apr 2020 08:53:26 -0700
Message-Id: <20200406155331.2105-2-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
References: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

When kdump is not configured, a Hyper-V VM might still respond to
network traffic after a kernel panic when kernel parameter panic=0.
The panic CPU goes into an infinite loop with interrupts enabled,
and the VMbus driver interrupt handler still works because the
VMbus connection is unloaded only in the kdump path.  The network
responses make the other end of the connection think the VM is
still functional even though it has panic'ed, which could affect any
failover actions that should be taken.

Fix this by unloading the VMbus connection during the panic process.
vmbus_initiate_unload() could then be called twice (e.g., by
hyperv_panic_event() and hv_crash_handler(), so reset the connection
state in vmbus_initiate_unload() to ensure the unload is done only
once.

Fixes: 81b18bce48af ("Drivers: HV: Send one page worth of kmsg dump over Hyper-V during panic")
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
Change since v1:
	- Update change log
	- Use xchg() to change vmbus connection status
Change since v2:
	- Update comment of registering panic callback.
Change since v3:
        - Add fix commit in the change log.
---
 drivers/hv/channel_mgmt.c |  3 +++
 drivers/hv/vmbus_drv.c    | 21 +++++++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 0370364169c4..501c43c5851d 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -839,6 +839,9 @@ void vmbus_initiate_unload(bool crash)
 {
 	struct vmbus_channel_message_header hdr;
 
+	if (xchg(&vmbus_connection.conn_state, DISCONNECTED) == DISCONNECTED)
+		return;
+
 	/* Pre-Win2012R2 hosts don't support reconnect */
 	if (vmbus_proto_version < VERSION_WIN8_1)
 		return;
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 029378c27421..6478240d11ab 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -53,9 +53,12 @@ static int hyperv_panic_event(struct notifier_block *nb, unsigned long val,
 {
 	struct pt_regs *regs;
 
-	regs = current_pt_regs();
+	vmbus_initiate_unload(true);
 
-	hyperv_report_panic(regs, val);
+	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
+		regs = current_pt_regs();
+		hyperv_report_panic(regs, val);
+	}
 	return NOTIFY_DONE;
 }
 
@@ -1391,10 +1394,16 @@ static int vmbus_bus_init(void)
 		}
 
 		register_die_notifier(&hyperv_die_block);
-		atomic_notifier_chain_register(&panic_notifier_list,
-					       &hyperv_panic_block);
 	}
 
+	/*
+	 * Always register the panic notifier because we need to unload
+	 * the VMbus channel connection to prevent any VMbus
+	 * activity after the VM panics.
+	 */
+	atomic_notifier_chain_register(&panic_notifier_list,
+			       &hyperv_panic_block);
+
 	vmbus_request_offers();
 
 	return 0;
@@ -2204,8 +2213,6 @@ static int vmbus_bus_suspend(struct device *dev)
 
 	vmbus_initiate_unload(false);
 
-	vmbus_connection.conn_state = DISCONNECTED;
-
 	/* Reset the event for the next resume. */
 	reinit_completion(&vmbus_connection.ready_for_resume_event);
 
@@ -2289,7 +2296,6 @@ static void hv_kexec_handler(void)
 {
 	hv_stimer_global_cleanup();
 	vmbus_initiate_unload(false);
-	vmbus_connection.conn_state = DISCONNECTED;
 	/* Make sure conn_state is set as hv_synic_cleanup checks for it */
 	mb();
 	cpuhp_remove_state(hyperv_cpuhp_online);
@@ -2306,7 +2312,6 @@ static void hv_crash_handler(struct pt_regs *regs)
 	 * doing the cleanup for current CPU only. This should be sufficient
 	 * for kdump.
 	 */
-	vmbus_connection.conn_state = DISCONNECTED;
 	cpu = smp_processor_id();
 	hv_stimer_cleanup(cpu);
 	hv_synic_disable_regs(cpu);
-- 
2.14.5

