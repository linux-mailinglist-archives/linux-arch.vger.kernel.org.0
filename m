Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF81F597CB4
	for <lists+linux-arch@lfdr.de>; Thu, 18 Aug 2022 06:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbiHREEZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Aug 2022 00:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiHREEZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Aug 2022 00:04:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7500A2208;
        Wed, 17 Aug 2022 21:04:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64A1D61561;
        Thu, 18 Aug 2022 04:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E93C433D7;
        Thu, 18 Aug 2022 04:04:18 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: [PATCH] Input: i8042 - Add PNP checking hook for Loongson
Date:   Thu, 18 Aug 2022 12:04:13 +0800
Message-Id: <20220818040413.2865849-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add PNP checking related functions for Loongson, so that i8042 driver
can work well under the ACPI firmware with PNP typed keyboard and mouse
configured in DSDT.

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/input/serio/i8042-loongsonio.h | 330 +++++++++++++++++++++++++
 drivers/input/serio/i8042.h            |   2 +
 2 files changed, 332 insertions(+)
 create mode 100644 drivers/input/serio/i8042-loongsonio.h

diff --git a/drivers/input/serio/i8042-loongsonio.h b/drivers/input/serio/i8042-loongsonio.h
new file mode 100644
index 000000000000..2ea83b14f13d
--- /dev/null
+++ b/drivers/input/serio/i8042-loongsonio.h
@@ -0,0 +1,330 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * i8042-loongsonio.h
+ *
+ * Copyright (C) 2020 Loongson Technology Corporation Limited
+ * Author: Jianmin Lv <lvjianmin@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ */
+
+#ifndef _I8042_LOONGSONIO_H
+#define _I8042_LOONGSONIO_H
+
+/*
+ * Names.
+ */
+
+#define I8042_KBD_PHYS_DESC "isa0060/serio0"
+#define I8042_AUX_PHYS_DESC "isa0060/serio1"
+#define I8042_MUX_PHYS_DESC "isa0060/serio%d"
+
+/*
+ * IRQs.
+ */
+#define I8042_MAP_IRQ(x)	(x)
+
+#define I8042_KBD_IRQ	i8042_kbd_irq
+#define I8042_AUX_IRQ	i8042_aux_irq
+
+static int i8042_kbd_irq;
+static int i8042_aux_irq;
+
+/*
+ * Register numbers.
+ */
+
+#define I8042_COMMAND_REG	i8042_command_reg
+#define I8042_STATUS_REG	i8042_command_reg
+#define I8042_DATA_REG		i8042_data_reg
+
+static int i8042_command_reg = 0x64;
+static int i8042_data_reg = 0x60;
+
+
+static inline int i8042_read_data(void)
+{
+	return inb(I8042_DATA_REG);
+}
+
+static inline int i8042_read_status(void)
+{
+	return inb(I8042_STATUS_REG);
+}
+
+static inline void i8042_write_data(int val)
+{
+	outb(val, I8042_DATA_REG);
+}
+
+static inline void i8042_write_command(int val)
+{
+	outb(val, I8042_COMMAND_REG);
+}
+
+#ifdef CONFIG_PNP
+#include <linux/pnp.h>
+
+static bool i8042_pnp_kbd_registered;
+static unsigned int i8042_pnp_kbd_devices;
+static bool i8042_pnp_aux_registered;
+static unsigned int i8042_pnp_aux_devices;
+
+static int i8042_pnp_command_reg;
+static int i8042_pnp_data_reg;
+static int i8042_pnp_kbd_irq;
+static int i8042_pnp_aux_irq;
+
+static char i8042_pnp_kbd_name[32];
+static char i8042_pnp_aux_name[32];
+
+static void i8042_pnp_id_to_string(struct pnp_id *id, char *dst, int dst_size)
+{
+	strlcpy(dst, "PNP:", dst_size);
+
+	while (id) {
+		strlcat(dst, " ", dst_size);
+		strlcat(dst, id->id, dst_size);
+		id = id->next;
+	}
+}
+
+static int i8042_pnp_kbd_probe(struct pnp_dev *dev,
+		const struct pnp_device_id *did)
+{
+	if (pnp_port_valid(dev, 0) && pnp_port_len(dev, 0) == 1)
+		i8042_pnp_data_reg = pnp_port_start(dev, 0);
+
+	if (pnp_port_valid(dev, 1) && pnp_port_len(dev, 1) == 1)
+		i8042_pnp_command_reg = pnp_port_start(dev, 1);
+
+	if (pnp_irq_valid(dev, 0))
+		i8042_pnp_kbd_irq = pnp_irq(dev, 0);
+
+	strlcpy(i8042_pnp_kbd_name, did->id, sizeof(i8042_pnp_kbd_name));
+	if (strlen(pnp_dev_name(dev))) {
+		strlcat(i8042_pnp_kbd_name, ":", sizeof(i8042_pnp_kbd_name));
+		strlcat(i8042_pnp_kbd_name, pnp_dev_name(dev),
+				sizeof(i8042_pnp_kbd_name));
+	}
+	i8042_pnp_id_to_string(dev->id, i8042_kbd_firmware_id,
+			       sizeof(i8042_kbd_firmware_id));
+
+	/* Keyboard ports are always supposed to be wakeup-enabled */
+	device_set_wakeup_enable(&dev->dev, true);
+
+	i8042_pnp_kbd_devices++;
+	return 0;
+}
+
+static int i8042_pnp_aux_probe(struct pnp_dev *dev,
+		const struct pnp_device_id *did)
+{
+	if (pnp_port_valid(dev, 0) && pnp_port_len(dev, 0) == 1)
+		i8042_pnp_data_reg = pnp_port_start(dev, 0);
+
+	if (pnp_port_valid(dev, 1) && pnp_port_len(dev, 1) == 1)
+		i8042_pnp_command_reg = pnp_port_start(dev, 1);
+
+	if (pnp_irq_valid(dev, 0))
+		i8042_pnp_aux_irq = pnp_irq(dev, 0);
+
+	strlcpy(i8042_pnp_aux_name, did->id, sizeof(i8042_pnp_aux_name));
+	if (strlen(pnp_dev_name(dev))) {
+		strlcat(i8042_pnp_aux_name, ":", sizeof(i8042_pnp_aux_name));
+		strlcat(i8042_pnp_aux_name, pnp_dev_name(dev),
+				sizeof(i8042_pnp_aux_name));
+	}
+	i8042_pnp_id_to_string(dev->id, i8042_aux_firmware_id,
+			       sizeof(i8042_aux_firmware_id));
+
+	i8042_pnp_aux_devices++;
+	return 0;
+}
+
+static const struct pnp_device_id pnp_kbd_devids[] = {
+	{ .id = "PNP0300", .driver_data = 0 },
+	{ .id = "PNP0301", .driver_data = 0 },
+	{ .id = "PNP0302", .driver_data = 0 },
+	{ .id = "PNP0303", .driver_data = 0 },
+	{ .id = "PNP0304", .driver_data = 0 },
+	{ .id = "PNP0305", .driver_data = 0 },
+	{ .id = "PNP0306", .driver_data = 0 },
+	{ .id = "PNP0309", .driver_data = 0 },
+	{ .id = "PNP030a", .driver_data = 0 },
+	{ .id = "PNP030b", .driver_data = 0 },
+	{ .id = "PNP0320", .driver_data = 0 },
+	{ .id = "PNP0343", .driver_data = 0 },
+	{ .id = "PNP0344", .driver_data = 0 },
+	{ .id = "PNP0345", .driver_data = 0 },
+	{ .id = "CPQA0D7", .driver_data = 0 },
+	{ .id = "", },
+};
+MODULE_DEVICE_TABLE(pnp, pnp_kbd_devids);
+
+static struct pnp_driver i8042_pnp_kbd_driver = {
+	.name           = "i8042 kbd",
+	.id_table       = pnp_kbd_devids,
+	.probe          = i8042_pnp_kbd_probe,
+	.driver         = {
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
+		.suppress_bind_attrs = true,
+	},
+};
+
+static const struct pnp_device_id pnp_aux_devids[] = {
+	{ .id = "AUI0200", .driver_data = 0 },
+	{ .id = "FJC6000", .driver_data = 0 },
+	{ .id = "FJC6001", .driver_data = 0 },
+	{ .id = "PNP0f03", .driver_data = 0 },
+	{ .id = "PNP0f0b", .driver_data = 0 },
+	{ .id = "PNP0f0e", .driver_data = 0 },
+	{ .id = "PNP0f12", .driver_data = 0 },
+	{ .id = "PNP0f13", .driver_data = 0 },
+	{ .id = "PNP0f19", .driver_data = 0 },
+	{ .id = "PNP0f1c", .driver_data = 0 },
+	{ .id = "SYN0801", .driver_data = 0 },
+	{ .id = "", },
+};
+MODULE_DEVICE_TABLE(pnp, pnp_aux_devids);
+
+static struct pnp_driver i8042_pnp_aux_driver = {
+	.name           = "i8042 aux",
+	.id_table       = pnp_aux_devids,
+	.probe          = i8042_pnp_aux_probe,
+	.driver         = {
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
+		.suppress_bind_attrs = true,
+	},
+};
+
+static void i8042_pnp_exit(void)
+{
+	if (i8042_pnp_kbd_registered) {
+		i8042_pnp_kbd_registered = false;
+		pnp_unregister_driver(&i8042_pnp_kbd_driver);
+	}
+
+	if (i8042_pnp_aux_registered) {
+		i8042_pnp_aux_registered = false;
+		pnp_unregister_driver(&i8042_pnp_aux_driver);
+	}
+}
+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+#endif
+static int __init i8042_pnp_init(void)
+{
+	char kbd_irq_str[4] = { 0 }, aux_irq_str[4] = { 0 };
+	bool pnp_data_busted = false;
+	int err;
+
+	if (i8042_nopnp) {
+		pr_info("PNP detection disabled\n");
+		return 0;
+	}
+
+	err = pnp_register_driver(&i8042_pnp_kbd_driver);
+	if (!err)
+		i8042_pnp_kbd_registered = true;
+
+	err = pnp_register_driver(&i8042_pnp_aux_driver);
+	if (!err)
+		i8042_pnp_aux_registered = true;
+
+	if (!i8042_pnp_kbd_devices && !i8042_pnp_aux_devices) {
+		i8042_pnp_exit();
+		pr_info("PNP: No PS/2 controller found.\n");
+#ifdef CONFIG_ACPI
+		if (acpi_disabled == 0)
+			return -ENODEV;
+#endif
+		pr_info("Probing ports directly.\n");
+		return 0;
+	}
+
+	if (i8042_pnp_kbd_devices)
+		snprintf(kbd_irq_str, sizeof(kbd_irq_str),
+			"%d", i8042_pnp_kbd_irq);
+	if (i8042_pnp_aux_devices)
+		snprintf(aux_irq_str, sizeof(aux_irq_str),
+			"%d", i8042_pnp_aux_irq);
+
+	pr_info("PNP: PS/2 Controller [%s%s%s] at %#x,%#x irq %s%s%s\n",
+		i8042_pnp_kbd_name,
+		(i8042_pnp_kbd_devices && i8042_pnp_aux_devices) ? "," : "",
+		i8042_pnp_aux_name,
+		i8042_pnp_data_reg, i8042_pnp_command_reg,
+		kbd_irq_str,
+		(i8042_pnp_kbd_devices && i8042_pnp_aux_devices) ? "," : "",
+		aux_irq_str);
+
+	if (((i8042_pnp_data_reg & ~0xf) == (i8042_data_reg & ~0xf) &&
+	      i8042_pnp_data_reg != i8042_data_reg) ||
+	    !i8042_pnp_data_reg) {
+		pr_warn("PNP: PS/2 controller has invalid data port %#x; using default %#x\n",
+			i8042_pnp_data_reg, i8042_data_reg);
+		i8042_pnp_data_reg = i8042_data_reg;
+		pnp_data_busted = true;
+	}
+
+	if (((i8042_pnp_command_reg & ~0xf) == (i8042_command_reg & ~0xf) &&
+	      i8042_pnp_command_reg != i8042_command_reg) ||
+	    !i8042_pnp_command_reg) {
+		pr_warn("PNP: PS/2 controller has invalid command port %#x; using default %#x\n",
+			i8042_pnp_command_reg, i8042_command_reg);
+		i8042_pnp_command_reg = i8042_command_reg;
+		pnp_data_busted = true;
+	}
+
+	if (!i8042_nokbd && !i8042_pnp_kbd_irq) {
+		pr_warn("PNP: PS/2 controller doesn't have KBD irq; using default %d\n",
+			i8042_kbd_irq);
+		i8042_pnp_kbd_irq = i8042_kbd_irq;
+		pnp_data_busted = true;
+	}
+
+	if (!i8042_noaux && !i8042_pnp_aux_irq) {
+		if (!pnp_data_busted && i8042_pnp_kbd_irq) {
+			pr_warn("PNP: PS/2 appears to have AUX port disabled, "
+				"if this is incorrect please boot with i8042.nopnp\n");
+			i8042_noaux = true;
+		} else {
+			pr_warn("PNP: PS/2 controller doesn't have AUX irq; using default %d\n",
+				i8042_aux_irq);
+			i8042_pnp_aux_irq = i8042_aux_irq;
+		}
+	}
+
+	i8042_data_reg = i8042_pnp_data_reg;
+	i8042_command_reg = i8042_pnp_command_reg;
+	i8042_kbd_irq = i8042_pnp_kbd_irq;
+	i8042_aux_irq = i8042_pnp_aux_irq;
+
+	return 0;
+}
+
+#else  /* !CONFIG_PNP */
+static inline int i8042_pnp_init(void) { return 0; }
+static inline void i8042_pnp_exit(void) { }
+#endif /* CONFIG_PNP */
+
+static int __init i8042_platform_init(void)
+{
+	int retval;
+
+	i8042_kbd_irq = I8042_MAP_IRQ(1);
+	i8042_aux_irq = I8042_MAP_IRQ(12);
+
+	retval = i8042_pnp_init();
+	if (retval)
+		return retval;
+
+	return retval;
+}
+
+static inline void i8042_platform_exit(void)
+{
+	i8042_pnp_exit();
+}
+
+#endif /* _I8042_LOONGSONIO_H */
diff --git a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.h
index 55381783dc82..166bd69841cf 100644
--- a/drivers/input/serio/i8042.h
+++ b/drivers/input/serio/i8042.h
@@ -19,6 +19,8 @@
 #include "i8042-snirm.h"
 #elif defined(CONFIG_SPARC)
 #include "i8042-sparcio.h"
+#elif defined(CONFIG_MACH_LOONGSON64)
+#include "i8042-loongsonio.h"
 #elif defined(CONFIG_X86) || defined(CONFIG_IA64)
 #include "i8042-x86ia64io.h"
 #else
-- 
2.31.1

