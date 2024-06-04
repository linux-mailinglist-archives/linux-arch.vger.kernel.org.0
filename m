Return-Path: <linux-arch+bounces-4665-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC6A8FA9A7
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 07:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 980B628E2DE
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 05:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD55A1422B0;
	Tue,  4 Jun 2024 05:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYYwQnoN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AAB1419B1;
	Tue,  4 Jun 2024 05:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717477847; cv=none; b=uxX2k1GjZmD1i37HzEJU1qFC14Zc4wYTYrGkJQRbmsnvofAglfnsN9t9U1gPOgsgmmmVEpwABtyPxknSZSzcD4d1F36IBvRGfeDe5F5hLvaH8nqnLfyLKy/B4ta/rUcYiIw+n2wnXbpUQeVTjw7mZ1haTsrSSF8RZL8EPKFJaco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717477847; c=relaxed/simple;
	bh=vVRI2TfY68wado4CSOgxUZSaUZKTk/D7LMeKecnuSBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G5y1bdCkGoNWGM9E/z3nirrKsZ0gpns4xKj7wU8gvj0w+6FFUDQQbtDCgrwspeaw9VDLFh0ga2U2wBO0IUtLReG+ilPGVhCKPq6GMzfETb2tWar5Bs87HvY63CweuJEWSXnN7YI20/3y76o6WbM7N+5I4BM13hNKxB+A3CCmlpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYYwQnoN; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70245b22365so2957212b3a.1;
        Mon, 03 Jun 2024 22:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717477845; x=1718082645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uI7hPio5EOSCOqhNP+fmg82P5jjcL6y/nOk7OMudZ2w=;
        b=XYYwQnoN+NFssVXY7qDW7r1aRkkg25tQnfiARNrXfqKp6Zsvk5sobOSsPPFYcE8mpM
         v8mCplCymvf4hlJt4C01bt2gLCWIABmUsbKXd24drl2NAB6d6kcbb12xcCn8cTpYVtoR
         zaRRxz9XeT3eINwS9t5gOT2Gw08qOjXD1WmPRKrg+YYQqG624rI4Lp9eLRUukspNMyiL
         9QYmI5js6ys1N4D4an/f5lQUqh0K4FzvUcC7C3nM2cKSZcutTZwsfSTk4uKAU/MMqOnm
         08hvToLUcHWAvF6LSDcr6XSGEyeeG3OCiBYlno+sFpOvt2p06E6BYexboMKNIKd2Ua/b
         YaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717477845; x=1718082645;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uI7hPio5EOSCOqhNP+fmg82P5jjcL6y/nOk7OMudZ2w=;
        b=Mf156JGjEHOWPPbXaryMgVD3HzkIa8iKf33umrJxo+bzmNJsLIdLqgTKW5l/8OCJ7W
         LJLwSuSkXHlqmEqCjyTI8L9lrMOE+BKI/q53aw3ptMrOByUGIv/xhAkE2SLnKx3gneNK
         nb0mGAKnZjmAPWhFjDAiXlqdoCM7vEFNUbJxY64Ox7TvFJu7M17bYBiU52JNVhoHVO4m
         l9eYFenOqaCejSmE/Q7bWQFMsFxa6Elu6e/YJVUm1Gt1AoQu5aMU7kmxYMWkHzBzQr4e
         Ecid4sBOTI1E3d/if9MCzxD6Tbup9BxqNws30YXq77B3JF/4Xz0AudPNVobu6ISjI4x8
         Eypg==
X-Forwarded-Encrypted: i=1; AJvYcCXeDUJyACJ7fPm0hDHWH9B7FN80vY2Bdwd2sIOxDwzFqVtkI7hZdFQW+BeoDtQNJ3OF/f+X5fIGR0UUYeAONT9FM409sRmFh+ZD4vKozPOaN8X1L1G3/u27gyGkbEMRhKiNSTeRpjc75JS1G3eFHYfWRXKIVgzXF9s6WfECnJXp9IWYOhgNZ/ZtV6NMHFAQ1IiZywKFFtNr0o4rwKAecWLF95mKbR6Sm0ZwHmoMCnc1yn0G8PwbuTU6eH2MBiE=
X-Gm-Message-State: AOJu0YxK9/EaoG2BQKloxegYdzGlXPzeX6fAqe5osPTsyV4/8fOKRJ8M
	Fj8ulnRvo8VPiEVTJJJjeOrE3nOQRxSEnT10fPOs5Ir1J5T9+qcd
X-Google-Smtp-Source: AGHT+IEmnCRnuRNZeIpORES3MssYPt/+L5A69/3IuhurrqBWUQ1ji+4Umw+ygAq+nk7kFKVPAk9Pog==
X-Received: by 2002:a05:6a20:8415:b0:1af:7646:fc14 with SMTP id adf61e73a8af0-1b26ef54e19mr11855148637.0.1717477845049;
        Mon, 03 Jun 2024 22:10:45 -0700 (PDT)
Received: from localhost.localdomain (c-67-161-114-176.hsd1.wa.comcast.net. [67.161.114.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242c270c7sm6298153b3a.220.2024.06.03.22.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 22:10:44 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	arnd@arndb.de,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: maz@kernel.org,
	den@valinux.co.jp,
	jgowans@amazon.com,
	dawei.li@shingroup.cn
Subject: [RFC 07/12] Drivers: hv: vmbus: Set up irqdomain and irqchip for the VMBus connection
Date: Mon,  3 Jun 2024 22:09:35 -0700
Message-Id: <20240604050940.859909-8-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240604050940.859909-1-mhklinux@outlook.com>
References: <20240604050940.859909-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

In preparation for assigning Linux IRQs to VMBus channels, set up an
irqdomain and irqchip for the VMBus connection. The irqdomain is linear,
with the VMBus relid used as the "hwirq" value. A relid is a unique
index assigned by Hyper-V to each VMBus channel, with values ranging
from 1 to 2047. Because these hwirqs don't map to anything in the
architectural hardware, the domain is not part of the domain hierarchy.

VMBus channel interrupts provide minimal management functionality, so
provide only a minimal set of irqchip functions. The set_affinity function
is a place-holder that is populated in a subsequent patch.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/connection.c        | 24 +++++++++-----
 drivers/hv/hyperv_vmbus.h      |  9 +++++
 drivers/hv/vmbus_drv.c         | 60 +++++++++++++++++++++++++++++++++-
 include/asm-generic/mshyperv.h |  6 ++++
 4 files changed, 90 insertions(+), 9 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index f001ae880e1d..cb01784e5c3b 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -21,21 +21,29 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/set_memory.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
+#include <linux/irqdomain.h>
 #include <asm/mshyperv.h>
 
 #include "hyperv_vmbus.h"
 
 
 struct vmbus_connection vmbus_connection = {
-	.conn_state		= DISCONNECTED,
-	.unload_event		= COMPLETION_INITIALIZER(
-				  vmbus_connection.unload_event),
-	.next_gpadl_handle	= ATOMIC_INIT(0xE1E10),
-
-	.ready_for_suspend_event = COMPLETION_INITIALIZER(
-				  vmbus_connection.ready_for_suspend_event),
+	.conn_state			= DISCONNECTED,
+	.unload_event			= COMPLETION_INITIALIZER(
+						vmbus_connection.unload_event),
+	.next_gpadl_handle		= ATOMIC_INIT(0xE1E10),
+
+	.vmbus_irq_chip.name		= "VMBus",
+	.vmbus_irq_chip.irq_set_affinity = vmbus_irq_set_affinity,
+	.vmbus_irq_chip.irq_mask	= vmbus_irq_mask,
+	.vmbus_irq_chip.irq_unmask	= vmbus_irq_unmask,
+
+	.ready_for_suspend_event	= COMPLETION_INITIALIZER(
+					vmbus_connection.ready_for_suspend_event),
 	.ready_for_resume_event	= COMPLETION_INITIALIZER(
-				  vmbus_connection.ready_for_resume_event),
+					vmbus_connection.ready_for_resume_event),
 };
 EXPORT_SYMBOL_GPL(vmbus_connection);
 
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 76ac5185a01a..95d4d47d34f7 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -18,7 +18,11 @@
 #include <asm/hyperv-tlfs.h>
 #include <linux/atomic.h>
 #include <linux/hyperv.h>
+#include <linux/fwnode.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
+#include <linux/irqdomain.h>
 
 #include "hv_trace.h"
 
@@ -258,6 +262,11 @@ struct vmbus_connection {
 	/* Array of channels */
 	struct vmbus_channel **channels;
 
+	/* IRQ domain data */
+	struct fwnode_handle *vmbus_fwnode;
+	struct irq_domain *vmbus_irq_domain;
+	struct irq_chip	vmbus_irq_chip;
+
 	/*
 	 * An offer message is handled first on the work_queue, and then
 	 * is further handled on handle_primary_chan_wq or
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 291a8358370b..cbccdfad49a2 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -36,6 +36,9 @@
 #include <linux/syscore_ops.h>
 #include <linux/dma-map-ops.h>
 #include <linux/pci.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/hardirq.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/mshyperv.h>
 #include "hyperv_vmbus.h"
@@ -1306,6 +1309,40 @@ static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+int vmbus_irq_set_affinity(struct irq_data *data,
+				  const struct cpumask *dest, bool force)
+{
+	return 0;
+}
+
+/*
+ * VMBus channel interrupts do not need to be masked or unmasked, and the
+ * Hyper-V synic doesn't provide any masking functionality anyway. But in the
+ * absence of these irqchip functions, the IRQ subsystem keeps the IRQ marked
+ * as "masked". To prevent any problems associated with staying the "masked"
+ * state, and so that IRQ status shown in debugfs doesn't indicate "masked",
+ * provide null implementations.
+ */
+void vmbus_irq_unmask(struct irq_data *data)
+{
+}
+
+void vmbus_irq_mask(struct irq_data *data)
+{
+}
+
+static int vmbus_irq_map(struct irq_domain *d, unsigned int irq,
+			 irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(irq,
+			&vmbus_connection.vmbus_irq_chip, handle_simple_irq);
+	return 0;
+}
+
+static const struct irq_domain_ops vmbus_domain_ops = {
+	.map = vmbus_irq_map,
+};
+
 /*
  * vmbus_bus_init -Main vmbus driver initialization routine.
  *
@@ -1340,6 +1377,7 @@ static int vmbus_bus_init(void)
 	if (vmbus_irq == -1) {
 		hv_setup_vmbus_handler(vmbus_isr);
 	} else {
+		irq_set_handler(vmbus_irq, handle_percpu_demux_irq);
 		vmbus_evt = alloc_percpu(long);
 		ret = request_percpu_irq(vmbus_irq, vmbus_percpu_isr,
 				"Hyper-V VMbus", vmbus_evt);
@@ -1355,6 +1393,20 @@ static int vmbus_bus_init(void)
 	if (ret)
 		goto err_alloc;
 
+	/* Create IRQ domain for VMBus devices */
+	vmbus_connection.vmbus_fwnode = irq_domain_alloc_named_fwnode("hv-vmbus");
+	if (!vmbus_connection.vmbus_fwnode) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
+	vmbus_connection.vmbus_irq_domain = irq_domain_create_linear(
+			vmbus_connection.vmbus_fwnode, MAX_CHANNEL_RELIDS,
+			&vmbus_domain_ops, NULL);
+	if (!vmbus_connection.vmbus_irq_domain) {
+		ret = -ENOMEM;
+		goto err_fwnode;
+	}
+
 	/*
 	 * Initialize the per-cpu interrupt state and stimer state.
 	 * Then connect to the host.
@@ -1362,7 +1414,7 @@ static int vmbus_bus_init(void)
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vmbus:online",
 				hv_synic_init, hv_synic_cleanup);
 	if (ret < 0)
-		goto err_alloc;
+		goto err_domain;
 	hyperv_cpuhp_online = ret;
 
 	ret = vmbus_connect();
@@ -1382,6 +1434,10 @@ static int vmbus_bus_init(void)
 
 err_connect:
 	cpuhp_remove_state(hyperv_cpuhp_online);
+err_domain:
+	irq_domain_remove(vmbus_connection.vmbus_irq_domain);
+err_fwnode:
+	irq_domain_free_fwnode(vmbus_connection.vmbus_fwnode);
 err_alloc:
 	hv_synic_free();
 	if (vmbus_irq == -1) {
@@ -2690,6 +2746,8 @@ static void __exit vmbus_exit(void)
 	hv_debug_rm_all_dir();
 
 	vmbus_free_channels();
+	irq_domain_remove(vmbus_connection.vmbus_irq_domain);
+	irq_domain_free_fwnode(vmbus_connection.vmbus_fwnode);
 	kfree(vmbus_connection.channels);
 
 	/*
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 8fe7aaab2599..0488ff8b511f 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -24,6 +24,7 @@
 #include <acpi/acpi_numa.h>
 #include <linux/cpumask.h>
 #include <linux/nmi.h>
+#include <linux/irq.h>
 #include <asm/ptrace.h>
 #include <asm/hyperv-tlfs.h>
 
@@ -187,6 +188,11 @@ void hv_remove_kexec_handler(void);
 void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
 void hv_remove_crash_handler(void);
 
+extern void vmbus_irq_mask(struct irq_data *data);
+extern void vmbus_irq_unmask(struct irq_data *data);
+extern int vmbus_irq_set_affinity(struct irq_data *data,
+				const struct cpumask *dest, bool force);
+
 extern int vmbus_interrupt;
 extern int vmbus_irq;
 
-- 
2.25.1


