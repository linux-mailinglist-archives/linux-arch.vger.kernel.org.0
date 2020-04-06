Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CADF19F938
	for <lists+linux-arch@lfdr.de>; Mon,  6 Apr 2020 17:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgDFPxl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Apr 2020 11:53:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37361 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbgDFPxk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Apr 2020 11:53:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id r4so112948pgg.4;
        Mon, 06 Apr 2020 08:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i4k1s9lIro7kHeb4LhDT7pDDMzLkhHK+1p6OmaLFjeI=;
        b=UI1iM/BoYfMBNOmSYVXqoYKOkbIP2MvWZoPFYpe0WCmIbolLEND6psMu/6hkWRDlVi
         rBXqlahoHjuAEtKRXZshf+81+sUuLKeICbOrwh8Fn43kv/BGrhEg1Ax4HB3VLZ6MsEyZ
         GG8RFuWxFh/t38CkZOpHwKfm4YTdAc877nQIlvcnFNpBNDPdBvr53Uh9KaeK4kaATAg8
         YrIlLU3d3Ga1k7XZXxaSdQ/vQ5iJiEHlJAsHlldAKsjFGub33MfmJJZfWQOKPPGhCv0V
         sijyhPtU/s4fMQVIbeUGLIsTcZn3xxSLuGSZRzeHf3vEFP7L0RCGnuU/k1IM1H9gE83/
         gZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i4k1s9lIro7kHeb4LhDT7pDDMzLkhHK+1p6OmaLFjeI=;
        b=f04FGE9aaTc8WiwlsQhxH50156JUgzb3EYCSjxJSRA94S/FDh+FLHywl9pj7+bcvOB
         H0POk3O2QRhqrFpcv2QZd4dhmaYguZtpkyZw0Fou6qrZb1v7hXgKBefY+ZtAjZJ4CTea
         6g/metsppgGesw5k/j7IcjKUuf8SShNUiyxI/IJIDSLO74Oe9SwBu4u5EgqT169LM/jr
         tmBy+ne9krRB/Jyh4r6oGdfxP+mNjMtK0bq0XvGcD9PMq5i4zHHAJBHitCxcaVLTn/jC
         5eJJ200Q6+oHuqphAP1CsW1aRNE7yoLzsZDRuIayDZGjx1kdO4uoKaY6dWKeQGYH9aqq
         erCA==
X-Gm-Message-State: AGi0PubQKhRWcpnUgnghxWGJHBXyI7w6BFPCfGAL6KfbkzbjIQ9GNnSn
        cC9Z5Wd55uFLE1GKVRhKNzc=
X-Google-Smtp-Source: APiQypJfggfsp35tmmMBchANZ6iCpxWGiTy1Wcp7wbXvmszlsdTRlbLS64VECKOZv3wBJxJUuNGWgA==
X-Received: by 2002:a63:f50c:: with SMTP id w12mr21473698pgh.253.1586188417826;
        Mon, 06 Apr 2020 08:53:37 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([131.107.160.210])
        by smtp.googlemail.com with ESMTPSA id 79sm11823275pfz.23.2020.04.06.08.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 08:53:37 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, vkuznets@redhat.com
Subject: [PATCH V4 3/6] x86/Hyper-V: Trigger crash enlightenment only once during 0;136;0c0;136;0c system crash.
Date:   Mon,  6 Apr 2020 08:53:28 -0700
Message-Id: <20200406155331.2105-4-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
References: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

When a guest VM panics, Hyper-V should be notified only once via the
crash synthetic MSRs.  Current Linux code might write these crash MSRs
twice during a system panic:
1) hyperv_panic/die_event() calling hyperv_report_panic()
2) hv_kmsg_dump() calling hyperv_report_panic_msg()

Fix this by not calling hyperv_report_panic() if a kmsg dump has been
successfully registered.  The notification will happen later via
hyperv_report_panic_msg().

Fixes: 7ed4325a44ea ("Drivers: hv: vmbus: Make panic reporting to be more useful")
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
Change since v1:
	- Update commit log

Change since v2:
        - Update comment
Change since v3:
        - Add fix commit in the change log.	
---
 drivers/hv/vmbus_drv.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 00a511f15926..333dad39b1c1 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -55,7 +55,13 @@ static int hyperv_panic_event(struct notifier_block *nb, unsigned long val,
 
 	vmbus_initiate_unload(true);
 
-	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
+	/*
+	 * Hyper-V should be notified only once about a panic.  If we will be
+	 * doing hyperv_report_panic_msg() later with kmsg data, don't do
+	 * the notification here.
+	 */
+	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE
+	    && !hv_panic_page) {
 		regs = current_pt_regs();
 		hyperv_report_panic(regs, val);
 	}
@@ -68,7 +74,13 @@ static int hyperv_die_event(struct notifier_block *nb, unsigned long val,
 	struct die_args *die = (struct die_args *)args;
 	struct pt_regs *regs = die->regs;
 
-	hyperv_report_panic(regs, val);
+	/*
+	 * Hyper-V should be notified only once about a panic.  If we will be
+	 * doing hyperv_report_panic_msg() later with kmsg data, don't do
+	 * the notification here.
+	 */
+	if (!hv_panic_page)
+		hyperv_report_panic(regs, val);
 	return NOTIFY_DONE;
 }
 
-- 
2.14.5

