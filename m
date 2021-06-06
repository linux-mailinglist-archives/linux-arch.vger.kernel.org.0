Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8224839CE54
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 11:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhFFJHs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 05:07:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230363AbhFFJHj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 05:07:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A9566142B;
        Sun,  6 Jun 2021 09:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622970350;
        bh=WX/JRXcuhHSfjJz7TivKW4lR5Xtw4IgCjErrHaNxYec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VOMBgAahnOOaEXN3b1VJ2SVHlLt+84mseSL2HkCZmC5Z0lFMbD5IqfBasiaAfE7ME
         aQnlhEMgNY5PlSQUsbPuJBfDEr9JYObYhA8o78XGEvP/ORr4F2wEbrd9tQ5AI6qbgs
         YLd4dWmEOstq2L9VgQDHNJaxpneuQNnj7Q+8/W4nj+p/5cWBhUNSqqi43y3+EdmUwU
         pOh8PjNozcwdBZAf1S69ueDQ299jF6yhkblKr40W4CRJeujQjggRxiws3mwNdwQKq7
         rrR8CC8zDXjyRT6UiAfpYAX0gAAGvSyFxWavYt+NbrOCyIDDkfXxMwxLil4MVX3rFo
         bHyA+TbYhyoVw==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        drew@beagleboard.org, liush@allwinnertech.com,
        lazyparser@gmail.com, wefu@redhat.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Maxime Ripard <mripard@kernel.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        LABBE Corentin <clabbe.montjoie@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH v2 11/11] riscv: soc: Allwinner D1 GMAC driver only for temp use
Date:   Sun,  6 Jun 2021 09:04:09 +0000
Message-Id: <1622970249-50770-15-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622970249-50770-1-git-send-email-guoren@kernel.org>
References: <1622970249-50770-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: liush <liush@allwinnertech.com>

This is a temporary driver, only guaranteed to work on allwinner
D1. In order to ensure the developer's demand for network usage.

It only could work at 1Gps mode.

The correct gmac driver should follow (I guess)
drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c

If anyone is familiar with it and can help porting, I would be
very grateful.

Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
Tested-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Corentin Labbe <clabbe@baylibre.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Icenowy Zheng <icenowy@aosc.io>
Cc: LABBE Corentin <clabbe.montjoie@gmail.com>
Cc: Michael Walle <michael@walle.cc>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime@cerno.tech>
Cc: Wei Fu <wefu@redhat.com>
Cc: Wei Wu <lazyparser@gmail.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 .../boot/dts/allwinner/allwinner-d1-nezha-kit.dts  |    2 +-
 arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi    |   16 +
 drivers/net/ethernet/Kconfig                       |    1 +
 drivers/net/ethernet/Makefile                      |    1 +
 drivers/net/ethernet/allwinnertmp/Kconfig          |   17 +
 drivers/net/ethernet/allwinnertmp/Makefile         |    7 +
 drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c |  690 ++++++
 drivers/net/ethernet/allwinnertmp/sunxi-gmac.c     | 2240 ++++++++++++++++++++
 drivers/net/ethernet/allwinnertmp/sunxi-gmac.h     |  258 +++
 drivers/net/phy/realtek.c                          |    2 +-
 10 files changed, 3232 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/allwinnertmp/Kconfig
 create mode 100644 drivers/net/ethernet/allwinnertmp/Makefile
 create mode 100644 drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c
 create mode 100644 drivers/net/ethernet/allwinnertmp/sunxi-gmac.c
 create mode 100644 drivers/net/ethernet/allwinnertmp/sunxi-gmac.h

diff --git a/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts b/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
index cd9f7c9..31b681d 100644
--- a/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
+++ b/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
@@ -11,7 +11,7 @@
 	compatible = "allwinner,d1-nezha-kit";
 
 	chosen {
-		bootargs = "console=ttyS0,115200";
+		bootargs = "console=ttyS0,115200 rootwait init=/sbin/init root=/dev/nfs rw nfsroot=192.168.101.200:/tmp/rootfs_nfs,v3,tcp,nolock ip=192.168.101.23";
 		stdout-path = &serial0;
 	};
 
diff --git a/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi b/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
index 11cd938..d317e19 100644
--- a/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
+++ b/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
@@ -80,5 +80,21 @@
 			clocks = <&dummy_apb>;
 			status = "disabled";
 		};
+
+		eth@4500000 {
+			compatible = "allwinner,sunxi-gmac";
+			reg = <0x00 0x4500000 0x00 0x10000 0x00 0x3000030 0x00 0x04>;
+			interrupts-extended = <&plic 0x3e 0x04>;
+			interrupt-names = "gmacirq";
+			device_type = "gmac0";
+			phy-mode = "rgmii";
+			use_ephy25m = <0x01>;
+			tx-delay = <0x03>;
+			rx-delay = <0x03>;
+			gmac-power0;
+			gmac-power1;
+			gmac-power2;
+			status = "okay";
+		};
 	};
 };
diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index 1cdff1d..1f8e37c 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -18,6 +18,7 @@ config MDIO
 config SUNGEM_PHY
 	tristate
 
+source "drivers/net/ethernet/allwinnertmp/Kconfig"
 source "drivers/net/ethernet/3com/Kconfig"
 source "drivers/net/ethernet/actions/Kconfig"
 source "drivers/net/ethernet/adaptec/Kconfig"
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index cb3f908..3dacc0c 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -3,6 +3,7 @@
 # Makefile for the Linux network Ethernet device drivers.
 #
 
+obj-y += allwinnertmp/
 obj-$(CONFIG_NET_VENDOR_3COM) += 3com/
 obj-$(CONFIG_NET_VENDOR_8390) += 8390/
 obj-$(CONFIG_NET_VENDOR_ACTIONS) += actions/
diff --git a/drivers/net/ethernet/allwinnertmp/Kconfig b/drivers/net/ethernet/allwinnertmp/Kconfig
new file mode 100644
index 00000000..4b7b378
--- /dev/null
+++ b/drivers/net/ethernet/allwinnertmp/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Allwinner device configuration
+#
+
+config SUNXI_GMAC
+	tristate "Allwinner GMAC support"
+	default y
+	depends on OF
+	select CRC32
+	select MII
+	select PHYLIB
+	help
+	  Support for Allwinner Gigabit ethernet driver.
+
+	  To compile this driver as a module, choose M here.  The module
+	  will be called sunxi-gmac.
diff --git a/drivers/net/ethernet/allwinnertmp/Makefile b/drivers/net/ethernet/allwinnertmp/Makefile
new file mode 100644
index 00000000..1375dea
--- /dev/null
+++ b/drivers/net/ethernet/allwinnertmp/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the Allwinner device drivers.
+#
+
+obj-$(CONFIG_SUNXI_GMAC) += sunxi_gmac.o
+sunxi_gmac-objs := sunxi-gmac.o sunxi-gmac-ops.o
diff --git a/drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c b/drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c
new file mode 100644
index 00000000..26ffd7f
--- /dev/null
+++ b/drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c
@@ -0,0 +1,690 @@
+/*
+ * linux/drivers/net/ethernet/allwinner/sunxi_gmac_ops.c
+ *
+ * Copyright © 2016-2018, fuzhaoke
+ *		Author: fuzhaoke <fuzhaoke@allwinnertech.com>
+ *
+ * This file is provided under a dual BSD/GPL license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ */
+#include <linux/kernel.h>
+#include <linux/ctype.h>
+#include <linux/printk.h>
+#include <linux/io.h>
+#include "sunxi-gmac.h"
+
+/******************************************************************************
+ *	sun8iw6 operations
+ *****************************************************************************/
+#define GETH_BASIC_CTL0		0x00
+#define GETH_BASIC_CTL1		0x04
+#define GETH_INT_STA		0x08
+#define GETH_INT_EN		0x0C
+#define GETH_TX_CTL0		0x10
+#define GETH_TX_CTL1		0x14
+#define GETH_TX_FLOW_CTL	0x1C
+#define GETH_TX_DESC_LIST	0x20
+#define GETH_RX_CTL0		0x24
+#define GETH_RX_CTL1		0x28
+#define GETH_RX_DESC_LIST	0x34
+#define GETH_RX_FRM_FLT		0x38
+#define GETH_RX_HASH0		0x40
+#define GETH_RX_HASH1		0x44
+#define GETH_MDIO_ADDR		0x48
+#define GETH_MDIO_DATA		0x4C
+#define GETH_ADDR_HI(reg)	(0x50 + ((reg) << 3))
+#define GETH_ADDR_LO(reg)	(0x54 + ((reg) << 3))
+#define GETH_TX_DMA_STA		0xB0
+#define GETH_TX_CUR_DESC	0xB4
+#define GETH_TX_CUR_BUF		0xB8
+#define GETH_RX_DMA_STA		0xC0
+#define GETH_RX_CUR_DESC	0xC4
+#define GETH_RX_CUR_BUF		0xC8
+#define GETH_RGMII_STA		0xD0
+
+#define RGMII_IRQ		0x00000001
+
+#define	CTL0_LM			0x02
+#define CTL0_DM			0x01
+#define CTL0_SPEED		0x04
+
+#define BURST_LEN		0x3F000000
+#define RX_TX_PRI		0x02
+#define SOFT_RST		0x01
+
+#define TX_FLUSH		0x01
+#define TX_MD			0x02
+#define TX_NEXT_FRM		0x04
+#define TX_TH			0x0700
+
+#define RX_FLUSH		0x01
+#define RX_MD			0x02
+#define RX_RUNT_FRM		0x04
+#define RX_ERR_FRM		0x08
+#define RX_TH			0x0030
+
+#define TX_INT			0x00001
+#define TX_STOP_INT		0x00002
+#define TX_UA_INT		0x00004
+#define TX_TOUT_INT		0x00008
+#define TX_UNF_INT		0x00010
+#define TX_EARLY_INT		0x00020
+#define RX_INT			0x00100
+#define RX_UA_INT		0x00200
+#define RX_STOP_INT		0x00400
+#define RX_TOUT_INT		0x00800
+#define RX_OVF_INT		0x01000
+#define RX_EARLY_INT		0x02000
+#define LINK_STA_INT		0x10000
+
+#define DISCARD_FRAME	-1
+#define GOOD_FRAME	0
+#define CSUM_NONE	2
+#define LLC_SNAP	4
+
+#define SF_DMA_MODE		1
+
+/* Flow Control defines */
+#define FLOW_OFF	0
+#define FLOW_RX		1
+#define FLOW_TX		2
+#define FLOW_AUTO	(FLOW_TX | FLOW_RX)
+
+#define HASH_TABLE_SIZE 64
+#define PAUSE_TIME 0x200
+#define GMAC_MAX_UNICAST_ADDRESSES	8
+
+/* PHY address */
+#define PHY_ADDR		0x01
+#define PHY_DM			0x0010
+#define PHY_AUTO_NEG		0x0020
+#define PHY_POWERDOWN		0x0080
+#define PHY_NEG_EN		0x1000
+
+#define MII_BUSY		0x00000001
+#define MII_WRITE		0x00000002
+#define MII_PHY_MASK		0x0000FFC0
+#define MII_CR_MASK		0x0000001C
+#define MII_CLK			0x00000008
+/* bits 4 3 2 | AHB1 Clock	| MDC Clock
+ * -------------------------------------------------------
+ *      0 0 0 | 60 ~ 100 MHz	| div-42
+ *      0 0 1 | 100 ~ 150 MHz	| div-62
+ *      0 1 0 | 20 ~ 35 MHz	| div-16
+ *      0 1 1 | 35 ~ 60 MHz	| div-26
+ *      1 0 0 | 150 ~ 250 MHz	| div-102
+ *      1 0 1 | 250 ~ 300 MHz	| div-124
+ *      1 1 x | Reserved	|
+ */
+
+enum csum_insertion {
+	cic_dis		= 0, /* Checksum Insertion Control */
+	cic_ip		= 1, /* Only IP header */
+	cic_no_pse	= 2, /* IP header but not pseudoheader */
+	cic_full	= 3, /* IP header and pseudoheader */
+};
+
+struct gethdev {
+	void *iobase;
+	unsigned int ver;
+	unsigned int mdc_div;
+};
+
+static struct gethdev hwdev;
+
+/***************************************************************************
+ * External interface
+ **************************************************************************/
+/* Set a ring desc buffer */
+void desc_init_chain(struct dma_desc *desc, unsigned long addr, unsigned int size)
+{
+	/* In chained mode the desc3 points to the next element in the ring.
+	 * The latest element has to point to the head.
+	 */
+	int i;
+	struct dma_desc *p = desc;
+	unsigned long dma_phy = addr;
+
+	for (i = 0; i < (size - 1); i++) {
+		dma_phy += sizeof(struct dma_desc);
+		p->desc3 = (unsigned int)dma_phy;
+		/* Chain mode */
+		p->desc1.all |= (1 << 24);
+		p++;
+	}
+	p->desc1.all |= (1 << 24);
+	p->desc3 = (unsigned int)addr;
+}
+
+int sunxi_mdio_read(void *iobase, int phyaddr, int phyreg)
+{
+	unsigned int value = 0;
+
+	/* Mask the MDC_DIV_RATIO */
+	value |= ((hwdev.mdc_div & 0x07) << 20);
+	value |= (((phyaddr << 12) & (0x0001F000)) |
+			((phyreg << 4) & (0x000007F0)) |
+			MII_BUSY);
+
+	while (((readl(iobase + GETH_MDIO_ADDR)) & MII_BUSY) == 1)
+		;
+
+	writel(value, iobase + GETH_MDIO_ADDR);
+	while (((readl(iobase + GETH_MDIO_ADDR)) & MII_BUSY) == 1)
+		;
+
+	return (int)readl(iobase + GETH_MDIO_DATA);
+}
+
+int sunxi_mdio_write(void *iobase, int phyaddr, int phyreg, unsigned short data)
+{
+	unsigned int value;
+
+	value = ((0x07 << 20) & readl(iobase + GETH_MDIO_ADDR)) |
+		 (hwdev.mdc_div << 20);
+	value |= (((phyaddr << 12) & (0x0001F000)) |
+		  ((phyreg << 4) & (0x000007F0))) |
+		  MII_WRITE | MII_BUSY;
+
+	/* Wait until any existing MII operation is complete */
+	while (((readl(iobase + GETH_MDIO_ADDR)) & MII_BUSY) == 1)
+		;
+
+	/* Set the MII address register to write */
+	writel(data, iobase + GETH_MDIO_DATA);
+	writel(value, iobase + GETH_MDIO_ADDR);
+
+	/* Wait until any existing MII operation is complete */
+	while (((readl(iobase + GETH_MDIO_ADDR)) & MII_BUSY) == 1)
+		;
+
+	return 0;
+}
+
+int sunxi_mdio_reset(void *iobase)
+{
+	writel((4 << 2), iobase + GETH_MDIO_ADDR);
+	return 0;
+}
+
+void sunxi_set_link_mode(void *iobase, int duplex, int speed)
+{
+	unsigned int ctrl = readl(iobase + GETH_BASIC_CTL0);
+
+	if (!duplex)
+		ctrl &= ~CTL0_DM;
+	else
+		ctrl |= CTL0_DM;
+
+	switch (speed) {
+	case 1000:
+		ctrl &= ~0x0C;
+		break;
+	case 100:
+	case 10:
+	default:
+		ctrl |= 0x08;
+		if (speed == 100)
+			ctrl |= 0x04;
+		else
+			ctrl &= ~0x04;
+		break;
+	}
+
+	writel(ctrl, iobase + GETH_BASIC_CTL0);
+}
+
+void sunxi_mac_loopback(void *iobase, int enable)
+{
+	int reg;
+
+	reg = readl(iobase + GETH_BASIC_CTL0);
+	if (enable)
+		reg |= 0x02;
+	else
+		reg &= ~0x02;
+	writel(reg, iobase + GETH_BASIC_CTL0);
+}
+
+void sunxi_flow_ctrl(void *iobase, int duplex, int fc, int pause)
+{
+	unsigned int flow = 0;
+
+	if (fc & FLOW_RX) {
+		flow = readl(iobase + GETH_RX_CTL0);
+		flow |= 0x10000;
+		writel(flow, iobase + GETH_RX_CTL0);
+	}
+
+	if (fc & FLOW_TX) {
+		flow = readl(iobase + GETH_TX_FLOW_CTL);
+		flow |= 0x00001;
+		writel(flow, iobase + GETH_TX_FLOW_CTL);
+	}
+
+	if (duplex) {
+		flow = readl(iobase + GETH_TX_FLOW_CTL);
+		flow |= (pause << 4);
+		writel(flow, iobase + GETH_TX_FLOW_CTL);
+	}
+}
+
+int sunxi_int_status(void *iobase, struct geth_extra_stats *x)
+{
+	int ret = 0;
+	/* read the status register (CSR5) */
+	unsigned int intr_status;
+
+	intr_status = readl(iobase + GETH_RGMII_STA);
+	if (intr_status & RGMII_IRQ)
+		readl(iobase + GETH_RGMII_STA);
+
+	intr_status = readl(iobase + GETH_INT_STA);
+
+	/* ABNORMAL interrupts */
+	if (intr_status & TX_UNF_INT) {
+		ret = tx_hard_error_bump_tc;
+		x->tx_undeflow_irq++;
+	}
+	if (intr_status & TX_TOUT_INT) {
+		x->tx_jabber_irq++;
+	}
+	if (intr_status & RX_OVF_INT) {
+		x->rx_overflow_irq++;
+	}
+	if (intr_status & RX_UA_INT) {
+		x->rx_buf_unav_irq++;
+	}
+	if (intr_status & RX_STOP_INT) {
+		x->rx_process_stopped_irq++;
+	}
+	if (intr_status & RX_TOUT_INT) {
+		x->rx_watchdog_irq++;
+	}
+	if (intr_status & TX_EARLY_INT) {
+		x->tx_early_irq++;
+	}
+	if (intr_status & TX_STOP_INT) {
+		x->tx_process_stopped_irq++;
+		ret = tx_hard_error;
+	}
+
+	/* TX/RX NORMAL interrupts */
+	if (intr_status & (TX_INT | RX_INT | RX_EARLY_INT | TX_UA_INT)) {
+		x->normal_irq_n++;
+		if (intr_status & (TX_INT | RX_INT))
+			ret = handle_tx_rx;
+	}
+	/* Clear the interrupt by writing a logic 1 to the CSR5[15-0] */
+	writel(intr_status & 0x3FFF, iobase + GETH_INT_STA);
+
+	return ret;
+}
+
+void sunxi_start_rx(void *iobase, unsigned long rxbase)
+{
+	unsigned int value;
+
+	/* Write the base address of Rx descriptor lists into registers */
+	writel(rxbase, iobase + GETH_RX_DESC_LIST);
+
+	value = readl(iobase + GETH_RX_CTL1);
+	value |= 0x40000000;
+	writel(value, iobase + GETH_RX_CTL1);
+}
+
+void sunxi_stop_rx(void *iobase)
+{
+	unsigned int value;
+
+	value = readl(iobase + GETH_RX_CTL1);
+	value &= ~0x40000000;
+	writel(value, iobase + GETH_RX_CTL1);
+}
+
+void sunxi_start_tx(void *iobase, unsigned long txbase)
+{
+	unsigned int value;
+
+	/* Write the base address of Tx descriptor lists into registers */
+	writel(txbase, iobase + GETH_TX_DESC_LIST);
+
+	value = readl(iobase + GETH_TX_CTL1);
+	value |= 0x40000000;
+	writel(value, iobase + GETH_TX_CTL1);
+}
+
+void sunxi_stop_tx(void *iobase)
+{
+	unsigned int value = readl(iobase + GETH_TX_CTL1);
+
+	value &= ~0x40000000;
+	writel(value, iobase + GETH_TX_CTL1);
+}
+
+static int sunxi_dma_init(void *iobase)
+{
+	unsigned int value;
+
+	/* Burst should be 8 */
+	value = (8 << 24);
+
+#ifdef CONFIG_GMAC_DA
+	value |= RX_TX_PRI;	/* Rx has priority over tx */
+#endif
+	writel(value, iobase + GETH_BASIC_CTL1);
+
+	/* Mask interrupts by writing to CSR7 */
+	writel(RX_INT | TX_UNF_INT, iobase + GETH_INT_EN);
+
+	return 0;
+}
+
+int sunxi_mac_init(void *iobase, int txmode, int rxmode)
+{
+	unsigned int value;
+
+	sunxi_dma_init(iobase);
+
+	/* Initialize the core component */
+	value = readl(iobase + GETH_TX_CTL0);
+	value |= (1 << 30);	/* Jabber Disable */
+	writel(value, iobase + GETH_TX_CTL0);
+
+	value = readl(iobase + GETH_RX_CTL0);
+	value |= (1 << 27);	/* Enable CRC & IPv4 Header Checksum */
+	value |= (1 << 28);	/* Automatic Pad/CRC Stripping */
+	value |= (1 << 29);	/* Jumbo Frame Enable */
+	writel(value, iobase + GETH_RX_CTL0);
+
+	writel((hwdev.mdc_div << 20), iobase + GETH_MDIO_ADDR); /* MDC_DIV_RATIO */
+
+	/* Set the Rx&Tx mode */
+	value = readl(iobase + GETH_TX_CTL1);
+	if (txmode == SF_DMA_MODE) {
+		/* Transmit COE type 2 cannot be done in cut-through mode. */
+		value |= TX_MD;
+		/* Operating on second frame increase the performance
+		 * especially when transmit store-and-forward is used.
+		 */
+		value |= TX_NEXT_FRM;
+	} else {
+		value &= ~TX_MD;
+		value &= ~TX_TH;
+		/* Set the transmit threshold */
+		if (txmode <= 64)
+			value |= 0x00000000;
+		else if (txmode <= 128)
+			value |= 0x00000100;
+		else if (txmode <= 192)
+			value |= 0x00000200;
+		else
+			value |= 0x00000300;
+	}
+	writel(value, iobase + GETH_TX_CTL1);
+
+	value = readl(iobase + GETH_RX_CTL1);
+	if (rxmode == SF_DMA_MODE) {
+		value |= RX_MD;
+	} else {
+		value &= ~RX_MD;
+		value &= ~RX_TH;
+		if (rxmode <= 32)
+			value |= 0x10;
+		else if (rxmode <= 64)
+			value |= 0x00;
+		else if (rxmode <= 96)
+			value |= 0x20;
+		else
+			value |= 0x30;
+	}
+
+	/* Forward frames with error and undersized good frame. */
+	value |= (RX_ERR_FRM | RX_RUNT_FRM);
+
+	writel(value, iobase + GETH_RX_CTL1);
+
+	return 0;
+}
+
+void sunxi_hash_filter(void *iobase, unsigned long low, unsigned long high)
+{
+	writel(high, iobase + GETH_RX_HASH0);
+	writel(low, iobase + GETH_RX_HASH1);
+}
+
+void sunxi_set_filter(void *iobase, unsigned long flags)
+{
+	int tmp_flags = 0;
+
+	tmp_flags |= ((flags >> 31) |
+			((flags >> 9) & 0x00000002) |
+			((flags << 1) & 0x00000010) |
+			((flags >> 3) & 0x00000060) |
+			((flags << 7) & 0x00000300) |
+			((flags << 6) & 0x00003000) |
+			((flags << 12) & 0x00030000) |
+			(flags << 31));
+
+	writel(tmp_flags, iobase + GETH_RX_FRM_FLT);
+}
+
+void sunxi_set_umac(void *iobase, unsigned char *addr, int index)
+{
+	unsigned long data;
+
+	data = (addr[5] << 8) | addr[4];
+	writel(data, iobase + GETH_ADDR_HI(index));
+	data = (addr[3] << 24) | (addr[2] << 16) | (addr[1] << 8) | addr[0];
+	writel(data, iobase + GETH_ADDR_LO(index));
+}
+
+void sunxi_mac_enable(void *iobase)
+{
+	unsigned long value;
+
+	value = readl(iobase + GETH_TX_CTL0);
+	value |= (1 << 31);
+	writel(value, iobase + GETH_TX_CTL0);
+
+	value = readl(iobase + GETH_RX_CTL0);
+	value |= (1 << 31);
+	writel(value, iobase + GETH_RX_CTL0);
+}
+
+void sunxi_mac_disable(void *iobase)
+{
+	unsigned long value;
+
+	value = readl(iobase + GETH_TX_CTL0);
+	value &= ~(1 << 31);
+	writel(value, iobase + GETH_TX_CTL0);
+
+	value = readl(iobase + GETH_RX_CTL0);
+	value &= ~(1 << 31);
+	writel(value, iobase + GETH_RX_CTL0);
+}
+
+void sunxi_tx_poll(void *iobase)
+{
+	unsigned int value;
+
+	value = readl(iobase + GETH_TX_CTL1);
+	writel(value | 0x80000000, iobase + GETH_TX_CTL1);
+}
+
+void sunxi_rx_poll(void *iobase)
+{
+	unsigned int value;
+
+	value = readl(iobase + GETH_RX_CTL1);
+	writel(value | 0x80000000, iobase + GETH_RX_CTL1);
+}
+
+void sunxi_int_enable(void *iobase)
+{
+	writel(RX_INT | TX_UNF_INT, iobase + GETH_INT_EN);
+}
+
+void sunxi_int_disable(void *iobase)
+{
+	writel(0, iobase + GETH_INT_EN);
+}
+
+void desc_buf_set(struct dma_desc *desc, unsigned long paddr, int size)
+{
+	desc->desc1.all &= (~((1 << 11) - 1));
+	desc->desc1.all |= (size & ((1 << 11) - 1));
+	desc->desc2 = paddr;
+}
+
+void desc_set_own(struct dma_desc *desc)
+{
+	desc->desc0.all |= 0x80000000;
+}
+
+void desc_tx_close(struct dma_desc *first, struct dma_desc *end, int csum_insert)
+{
+	struct dma_desc *desc = first;
+
+	first->desc1.tx.first_sg = 1;
+	end->desc1.tx.last_seg = 1;
+	end->desc1.tx.interrupt = 1;
+
+	if (csum_insert)
+		do {
+			desc->desc1.tx.cic = 3;
+			desc++;
+		} while (desc <= end);
+}
+
+void desc_init(struct dma_desc *desc)
+{
+	desc->desc1.all = 0;
+	desc->desc2  = 0;
+
+	desc->desc1.all |= (1 << 24);
+}
+
+int desc_get_tx_status(struct dma_desc *desc, struct geth_extra_stats *x)
+{
+	int ret = 0;
+
+	if (desc->desc0.tx.under_err) {
+		x->tx_underflow++;
+		ret = -1;
+	}
+	if (desc->desc0.tx.no_carr) {
+		x->tx_carrier++;
+		ret = -1;
+	}
+	if (desc->desc0.tx.loss_carr) {
+		x->tx_losscarrier++;
+		ret = -1;
+	}
+
+#if 0
+	if ((desc->desc0.tx.ex_deferral) ||
+			(desc->desc0.tx.ex_coll) ||
+			(desc->desc0.tx.late_coll))
+		stats->collisions += desc->desc0.tx.coll_cnt;
+#endif
+
+	if (desc->desc0.tx.deferred)
+		x->tx_deferred++;
+
+	return ret;
+}
+
+int desc_buf_get_len(struct dma_desc *desc)
+{
+	return (desc->desc1.all & ((1 << 11) - 1));
+}
+
+int desc_buf_get_addr(struct dma_desc *desc)
+{
+	return desc->desc2;
+}
+
+int desc_rx_frame_len(struct dma_desc *desc)
+{
+	return desc->desc0.rx.frm_len;
+}
+
+int desc_get_rx_status(struct dma_desc *desc, struct geth_extra_stats *x)
+{
+	int ret = good_frame;
+
+	if (desc->desc0.rx.last_desc == 0) {
+		return discard_frame;
+	}
+
+	if (desc->desc0.rx.err_sum) {
+		if (desc->desc0.rx.desc_err)
+			x->rx_desc++;
+
+		if (desc->desc0.rx.sou_filter)
+			x->sa_filter_fail++;
+
+		if (desc->desc0.rx.over_err)
+			x->overflow_error++;
+
+		if (desc->desc0.rx.ipch_err)
+			x->ipc_csum_error++;
+
+		if (desc->desc0.rx.late_coll)
+			x->rx_collision++;
+
+		if (desc->desc0.rx.crc_err)
+			x->rx_crc++;
+
+		ret = discard_frame;
+	}
+
+	if (desc->desc0.rx.len_err) {
+		ret = discard_frame;
+	}
+	if (desc->desc0.rx.mii_err) {
+		ret = discard_frame;
+	}
+
+	return ret;
+}
+
+int desc_get_own(struct dma_desc *desc)
+{
+	return desc->desc0.all & 0x80000000;
+}
+
+int desc_get_tx_ls(struct dma_desc *desc)
+{
+	return desc->desc1.tx.last_seg;
+}
+
+int sunxi_geth_register(void *iobase, int version, unsigned int div)
+{
+	hwdev.ver = version;
+	hwdev.iobase = iobase;
+	hwdev.mdc_div = div;
+
+	return 0;
+}
+
+int sunxi_mac_reset(void *iobase, void (*delay)(int), int n)
+{
+	unsigned int value;
+
+	/* DMA SW reset */
+	value = readl(iobase + GETH_BASIC_CTL1);
+	value |= SOFT_RST;
+	writel(value, iobase + GETH_BASIC_CTL1);
+
+	delay(n);
+
+	return !!(readl(iobase + GETH_BASIC_CTL1) & SOFT_RST);
+}
diff --git a/drivers/net/ethernet/allwinnertmp/sunxi-gmac.c b/drivers/net/ethernet/allwinnertmp/sunxi-gmac.c
new file mode 100644
index 00000000..0c67877
--- /dev/null
+++ b/drivers/net/ethernet/allwinnertmp/sunxi-gmac.c
@@ -0,0 +1,2240 @@
+/*
+ * linux/drivers/net/ethernet/allwinner/sunxi_gmac.c
+ *
+ * Copyright © 2016-2018, fuzhaoke
+ *		Author: fuzhaoke <fuzhaoke@allwinnertech.com>
+ *
+ * This file is provided under a dual BSD/GPL license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ */
+//#include <linux/clk.h>
+//#include <linux/clk-provider.h>
+#include <linux/mii.h>
+#include <linux/gpio.h>
+#include <linux/crc32.h>
+#include <linux/skbuff.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+//#include <linux/pinctrl/consumer.h>
+//#include <linux/pinctrl/pinctrl.h>
+#include <linux/crypto.h>
+#include <crypto/algapi.h>
+#include <crypto/hash.h>
+#include <linux/err.h>
+#include <linux/scatterlist.h>
+//#include <linux/regulator/consumer.h>
+#include <linux/of_net.h>
+//#include <linux/of_gpio.h>
+#include <linux/io.h>
+//#include <linux/sunxi-sid.h>
+//#include <linux/sunxi-gpio.h>
+//#include <linux/reset.h>
+#include "sunxi-gmac.h"
+
+#define SUNXI_GMAC_VERSION "1.0.0"
+
+#define DMA_DESC_RX	256
+#define DMA_DESC_TX	256
+#define BUDGET		(dma_desc_rx / 4)
+#define TX_THRESH	(dma_desc_tx / 4)
+
+#define HASH_TABLE_SIZE	64
+#define MAX_BUF_SZ	(SZ_2K - 1)
+
+#define POWER_CHAN_NUM	3
+
+#undef PKT_DEBUG
+#undef DESC_PRINT
+
+#define circ_cnt(head, tail, size) (((head) > (tail)) ? \
+					((head) - (tail)) : \
+					((head) - (tail)) & ((size) - 1))
+
+#define circ_space(head, tail, size) circ_cnt((tail), ((head) + 1), (size))
+
+#define circ_inc(n, s) (((n) + 1) % (s))
+
+#define GETH_MAC_ADDRESS "00:00:00:00:00:00"
+static char *mac_str = GETH_MAC_ADDRESS;
+module_param(mac_str, charp, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(mac_str, "MAC Address String.(xx:xx:xx:xx:xx:xx)");
+
+static int rxmode = 1;
+module_param(rxmode, int, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(rxmode, "DMA threshold control value");
+
+static int txmode = 1;
+module_param(txmode, int, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(txmode, "DMA threshold control value");
+
+static int pause = 0x400;
+module_param(pause, int, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(pause, "Flow Control Pause Time");
+
+#define TX_TIMEO	5000
+static int watchdog = TX_TIMEO;
+module_param(watchdog, int, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(watchdog, "Transmit timeout in milliseconds");
+
+static int dma_desc_rx = DMA_DESC_RX;
+module_param(dma_desc_rx, int, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(watchdog, "The number of receive's descriptors");
+
+static int dma_desc_tx = DMA_DESC_TX;
+module_param(dma_desc_tx, int, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(watchdog, "The number of transmit's descriptors");
+
+/* - 0: Flow Off
+ * - 1: Rx Flow
+ * - 2: Tx Flow
+ * - 3: Rx & Tx Flow
+ */
+static int flow_ctrl;
+module_param(flow_ctrl, int, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(flow_ctrl, "Flow control [0: off, 1: rx, 2: tx, 3: both]");
+
+struct geth_priv {
+	struct dma_desc *dma_tx;
+	struct sk_buff **tx_sk;
+	unsigned int tx_clean;
+	unsigned int tx_dirty;
+	dma_addr_t dma_tx_phy;
+
+	unsigned long buf_sz;
+
+	struct dma_desc *dma_rx;
+	struct sk_buff **rx_sk;
+	unsigned int rx_clean;
+	unsigned int rx_dirty;
+	dma_addr_t dma_rx_phy;
+
+	struct net_device *ndev;
+	struct device *dev;
+	struct napi_struct napi;
+
+	struct geth_extra_stats xstats;
+
+	struct mii_bus *mii;
+	int link;
+	int speed;
+	int duplex;
+#define INT_PHY 0
+#define EXT_PHY 1
+	int phy_ext;
+	phy_interface_t phy_interface;
+
+	void __iomem *base;
+	void __iomem *base_phy;
+/*
+	struct clk *geth_clk;
+	struct clk *ephy_clk;
+	struct reset_control *reset;
+	struct pinctrl *pinctrl;
+*/
+	struct regulator *gmac_power[POWER_CHAN_NUM];
+	bool is_suspend;
+	int phyrst;
+	u8  rst_active_low;
+	/* definition spinlock */
+	spinlock_t lock;
+	spinlock_t tx_lock;
+
+	/* whether using ephy_clk */
+	int use_ephy_clk;
+	int phy_addr;
+
+	/* adjust transmit clock delay, value: 0~7 */
+	/* adjust receive clock delay, value: 0~31 */
+	unsigned int tx_delay;
+	unsigned int rx_delay;
+
+	/* resume work */
+	struct work_struct eth_work;
+};
+
+static u64 geth_dma_mask = DMA_BIT_MASK(32);
+
+void sunxi_udelay(int n)
+{
+	udelay(n);
+}
+
+static int geth_stop(struct net_device *ndev);
+static int geth_open(struct net_device *ndev);
+static void geth_tx_complete(struct geth_priv *priv);
+static void geth_rx_refill(struct net_device *ndev);
+
+#ifdef CONFIG_GETH_ATTRS
+static ssize_t adjust_bgs_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	int value = 0;
+	u32 efuse_value;
+	struct net_device *ndev = to_net_dev(dev);
+	struct geth_priv *priv = netdev_priv(ndev);
+
+	if (priv->phy_ext == INT_PHY) {
+		value = readl(priv->base_phy) >> 28;
+		if (sunxi_efuse_read(EFUSE_OEM_NAME, &efuse_value) != 0)
+			pr_err("get PHY efuse fail!\n");
+		else
+#if IS_ENABLED(CONFIG_ARCH_SUN50IW2)
+			value = value - ((efuse_value >> 24) & 0x0F);
+#else
+			pr_warn("miss config come from efuse!\n");
+#endif
+	}
+
+	return sprintf(buf, "bgs: %d\n", value);
+}
+
+static ssize_t adjust_bgs_write(struct device *dev, struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	unsigned int out = 0;
+	struct net_device *ndev = to_net_dev(dev);
+	struct geth_priv *priv = netdev_priv(ndev);
+	u32 clk_value = readl(priv->base_phy);
+	u32 efuse_value;
+
+	out = simple_strtoul(buf, NULL, 10);
+
+	if (priv->phy_ext == INT_PHY) {
+		clk_value &= ~(0xF << 28);
+		if (sunxi_efuse_read(EFUSE_OEM_NAME, &efuse_value) != 0)
+			pr_err("get PHY efuse fail!\n");
+		else
+#if IS_ENABLED(CONFIG_ARCH_SUN50IW2)
+			clk_value |= (((efuse_value >> 24) & 0x0F) + out) << 28;
+#else
+			pr_warn("miss config come from efuse!\n");
+#endif
+	}
+
+	writel(clk_value, priv->base_phy);
+
+	return count;
+}
+
+static struct device_attribute adjust_reg[] = {
+	__ATTR(adjust_bgs, 0664, adjust_bgs_show, adjust_bgs_write),
+};
+
+static int geth_create_attrs(struct net_device *ndev)
+{
+	int j, ret;
+
+	for (j = 0; j < ARRAY_SIZE(adjust_reg); j++) {
+		ret = device_create_file(&ndev->dev, &adjust_reg[j]);
+		if (ret)
+			goto sysfs_failed;
+	}
+	goto succeed;
+
+sysfs_failed:
+	while (j--)
+		device_remove_file(&ndev->dev, &adjust_reg[j]);
+succeed:
+	return ret;
+}
+#endif
+
+#ifdef DEBUG
+static void desc_print(struct dma_desc *desc, int size)
+{
+#ifdef DESC_PRINT
+	int i;
+
+	for (i = 0; i < size; i++) {
+		u32 *x = (u32 *)(desc + i);
+
+		pr_info("\t%d [0x%08lx]: %08x %08x %08x %08x\n",
+			i, (unsigned long)(&desc[i]),
+			x[0], x[1], x[2], x[3]);
+	}
+	pr_info("\n");
+#endif
+}
+#endif
+
+static ssize_t extra_tx_stats_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct geth_priv *priv = netdev_priv(ndev);
+
+	if (!dev) {
+		pr_err("Argment is invalid\n");
+		return 0;
+	}
+
+	if (!ndev) {
+		pr_err("Net device is null\n");
+		return 0;
+	}
+
+	return sprintf(buf, "tx_underflow: %lu\ntx_carrier: %lu\n"
+			"tx_losscarrier: %lu\nvlan_tag: %lu\n"
+			"tx_deferred: %lu\ntx_vlan: %lu\n"
+			"tx_jabber: %lu\ntx_frame_flushed: %lu\n"
+			"tx_payload_error: %lu\ntx_ip_header_error: %lu\n\n",
+			priv->xstats.tx_underflow, priv->xstats.tx_carrier,
+			priv->xstats.tx_losscarrier, priv->xstats.vlan_tag,
+			priv->xstats.tx_deferred, priv->xstats.tx_vlan,
+			priv->xstats.tx_jabber, priv->xstats.tx_frame_flushed,
+			priv->xstats.tx_payload_error, priv->xstats.tx_ip_header_error);
+}
+static DEVICE_ATTR(extra_tx_stats, 0444, extra_tx_stats_show, NULL);
+
+static ssize_t extra_rx_stats_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct geth_priv *priv = netdev_priv(ndev);
+
+	if (!dev) {
+		pr_err("Argment is invalid\n");
+		return 0;
+	}
+
+	if (!ndev) {
+		pr_err("Net device is null\n");
+		return 0;
+	}
+
+	return sprintf(buf, "rx_desc: %lu\nsa_filter_fail: %lu\n"
+			"overflow_error: %lu\nipc_csum_error: %lu\n"
+			"rx_collision: %lu\nrx_crc: %lu\n"
+			"dribbling_bit: %lu\nrx_length: %lu\n"
+			"rx_mii: %lu\nrx_multicast: %lu\n"
+			"rx_gmac_overflow: %lu\nrx_watchdog: %lu\n"
+			"da_rx_filter_fail: %lu\nsa_rx_filter_fail: %lu\n"
+			"rx_missed_cntr: %lu\nrx_overflow_cntr: %lu\n"
+			"rx_vlan: %lu\n\n",
+			priv->xstats.rx_desc, priv->xstats.sa_filter_fail,
+			priv->xstats.overflow_error, priv->xstats.ipc_csum_error,
+			priv->xstats.rx_collision, priv->xstats.rx_crc,
+			priv->xstats.dribbling_bit, priv->xstats.rx_length,
+			priv->xstats.rx_mii, priv->xstats.rx_multicast,
+			priv->xstats.rx_gmac_overflow, priv->xstats.rx_length,
+			priv->xstats.da_rx_filter_fail, priv->xstats.sa_rx_filter_fail,
+			priv->xstats.rx_missed_cntr, priv->xstats.rx_overflow_cntr,
+			priv->xstats.rx_vlan);
+}
+static DEVICE_ATTR(extra_rx_stats, 0444, extra_rx_stats_show, NULL);
+
+static ssize_t gphy_test_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+
+	if (!dev) {
+		pr_err("Argment is invalid\n");
+		return 0;
+	}
+
+	if (!ndev) {
+		pr_err("Net device is null\n");
+		return 0;
+	}
+
+	return sprintf(buf, "Usage:\necho [0/1/2/3/4] > gphy_test\n"
+			"0 - Normal Mode\n"
+			"1 - Transmit Jitter Test\n"
+			"2 - Transmit Jitter Test(MASTER mode)\n"
+			"3 - Transmit Jitter Test(SLAVE mode)\n"
+			"4 - Transmit Distortion Test\n\n");
+}
+
+static ssize_t gphy_test_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct geth_priv *priv = netdev_priv(ndev);
+	u16 value = 0;
+	int ret = 0;
+	u16 data = 0;
+
+	if (!dev) {
+		pr_err("Argument is invalid\n");
+		return count;
+	}
+
+	if (!ndev) {
+		pr_err("Net device is null\n");
+		return count;
+	}
+
+	data = sunxi_mdio_read(priv->base, priv->phy_addr, MII_CTRL1000);
+
+	ret = kstrtou16(buf, 0, &value);
+	if (ret)
+		return ret;
+
+	if (value >= 0 && value <= 4) {
+		data &= ~(0x7 << 13);
+		data |= value << 13;
+		sunxi_mdio_write(priv->base, priv->phy_addr, MII_CTRL1000, data);
+		pr_info("Set MII_CTRL1000(0x09) Reg: 0x%x\n", data);
+	} else {
+		pr_info("unknown value (%d)\n", value);
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR(gphy_test, 0664, gphy_test_show, gphy_test_store);
+
+static ssize_t mii_reg_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct net_device *ndev = NULL;
+	struct geth_priv *priv = NULL;
+
+	if (dev == NULL) {
+		pr_err("Argment is invalid\n");
+		return 0;
+	}
+
+	ndev = dev_get_drvdata(dev);
+	if (ndev == NULL) {
+		pr_err("Net device is null\n");
+		return 0;
+	}
+
+	priv = netdev_priv(ndev);
+	if (priv == NULL) {
+		pr_err("geth_priv is null\n");
+		return 0;
+	}
+
+	if (!netif_running(ndev)) {
+		pr_warn("eth is down!\n");
+		return 0;
+	}
+
+	return sprintf(buf,
+		"Current MII Registers:\n"
+		"BMCR[0x%02x] = 0x%04x,\t\tBMSR[0x%02x] = 0x%04x,\t\tPHYSID1[0x%02x] = 0x%04x\n"
+		"PHYSID2[0x%02x] = 0x%04x,\t\tADVERTISE[0x%02x] = 0x%04x,\tLPA[0x%02x] = 0x%04x\n"
+		"EXPANSION[0x%02x] = 0x%04x,\tCTRL1000[0x%02x] = 0x%04x,\tSTAT1000[0x%02x] = 0x%04x\n",
+		MII_BMCR, sunxi_mdio_read(priv->base, priv->phy_addr, MII_BMCR),
+		MII_BMSR, sunxi_mdio_read(priv->base, priv->phy_addr, MII_BMSR),
+		MII_PHYSID1, sunxi_mdio_read(priv->base, priv->phy_addr, MII_PHYSID1),
+		MII_PHYSID2, sunxi_mdio_read(priv->base, priv->phy_addr, MII_PHYSID2),
+		MII_ADVERTISE, sunxi_mdio_read(priv->base, priv->phy_addr, MII_ADVERTISE),
+		MII_LPA, sunxi_mdio_read(priv->base, priv->phy_addr, MII_LPA),
+		MII_EXPANSION, sunxi_mdio_read(priv->base, priv->phy_addr, MII_EXPANSION),
+		MII_CTRL1000, sunxi_mdio_read(priv->base, priv->phy_addr, MII_CTRL1000),
+		MII_STAT1000, sunxi_mdio_read(priv->base, priv->phy_addr, MII_STAT1000));
+}
+static DEVICE_ATTR(mii_reg, 0444, mii_reg_show, NULL);
+
+static ssize_t loopback_test_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "Usage:\necho [0/1/2] > loopback_test\n"
+			"0 - Normal Mode\n"
+			"1 - Mac loopback test mode\n"
+			"2 - Phy loopback test mode\n");
+}
+
+static ssize_t loopback_test_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct net_device *ndev = NULL;
+	struct geth_priv *priv = NULL;
+	u16 value = 0;
+	int ret = 0;
+	u16 data = 0;
+
+	if (dev == NULL) {
+		pr_err("Argment is invalid\n");
+		return count;
+	}
+
+	ndev = dev_get_drvdata(dev);
+	if (ndev == NULL) {
+		pr_err("Net device is null\n");
+		return count;
+	}
+
+	priv = netdev_priv(ndev);
+	if (priv == NULL) {
+		pr_err("geth_priv is null\n");
+		return count;
+	}
+
+	if (!netif_running(ndev)) {
+		pr_warn("eth is down!\n");
+		return count;
+	}
+
+	ret = kstrtou16(buf, 0, &value);
+	if (ret)
+		return ret;
+
+	if (value == 0) { /* normal mode */
+		/* clear mac loopback */
+		sunxi_mac_loopback(priv->base, 0);
+
+		/* clear phy loopback */
+		data = sunxi_mdio_read(priv->base, priv->phy_addr, MII_BMCR);
+		sunxi_mdio_write(priv->base, priv->phy_addr, MII_BMCR, data & ~BMCR_LOOPBACK);
+	} else if (value == 1) { /* mac loopback test mode */
+		data = sunxi_mdio_read(priv->base, priv->phy_addr, MII_BMCR);
+		sunxi_mdio_write(priv->base, priv->phy_addr, MII_BMCR, data & ~BMCR_LOOPBACK);
+
+		sunxi_mac_loopback(priv->base, 1);
+	} else if (value == 2) { /* phy loopback test mode */
+		sunxi_mac_loopback(priv->base, 0);
+
+		data = sunxi_mdio_read(priv->base, priv->phy_addr, MII_BMCR);
+		sunxi_mdio_write(priv->base, priv->phy_addr, MII_BMCR, data | BMCR_LOOPBACK);
+	} else {
+		pr_err("Undefined value (%d)\n", value);
+	}
+
+	return count;
+}
+static DEVICE_ATTR(loopback_test, 0664, loopback_test_show, loopback_test_store);
+
+static int geth_power_on(struct geth_priv *priv)
+{
+	int value;
+
+	value = readl(priv->base_phy);
+	if (priv->phy_ext == INT_PHY) {
+		value |= (1 << 15);
+		value &= ~(1 << 16);
+		value |= (3 << 17);
+	} else {
+		value &= ~(1 << 15);
+/*
+		for (i = 0; i < POWER_CHAN_NUM; i++) {
+			if (IS_ERR_OR_NULL(priv->gmac_power[i]))
+				continue;
+			if (regulator_enable(priv->gmac_power[i]) != 0) {
+				pr_err("gmac-power%d enable error\n", i);
+				return -EINVAL;
+			}
+		}
+*/
+	}
+
+	writel(value, priv->base_phy);
+
+	return 0;
+}
+
+static void geth_power_off(struct geth_priv *priv)
+{
+	int value;
+
+	if (priv->phy_ext == INT_PHY) {
+		value = readl(priv->base_phy);
+		value |= (1 << 16);
+		writel(value, priv->base_phy);
+	} else {
+/*
+		for (i = 0; i < POWER_CHAN_NUM; i++) {
+			if (IS_ERR_OR_NULL(priv->gmac_power[i]))
+				continue;
+			regulator_disable(priv->gmac_power[i]);
+		}
+*/
+	}
+}
+
+/* PHY interface operations */
+static int geth_mdio_read(struct mii_bus *bus, int phyaddr, int phyreg)
+{
+	struct net_device *ndev = bus->priv;
+	struct geth_priv *priv = netdev_priv(ndev);
+
+	return (int)sunxi_mdio_read(priv->base,  phyaddr, phyreg);
+}
+
+static int geth_mdio_write(struct mii_bus *bus, int phyaddr,
+			   int phyreg, u16 data)
+{
+	struct net_device *ndev = bus->priv;
+	struct geth_priv *priv = netdev_priv(ndev);
+
+	sunxi_mdio_write(priv->base, phyaddr, phyreg, data);
+
+	return 0;
+}
+
+static int geth_mdio_reset(struct mii_bus *bus)
+{
+	struct net_device *ndev = bus->priv;
+	struct geth_priv *priv = netdev_priv(ndev);
+
+	return sunxi_mdio_reset(priv->base);
+}
+
+static void geth_adjust_link(struct net_device *ndev)
+{
+	struct geth_priv *priv = netdev_priv(ndev);
+	struct phy_device *phydev = ndev->phydev;
+	unsigned long flags;
+	int new_state = 0;
+
+	if (!phydev)
+		return;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	if (phydev->link) {
+		/* Now we make sure that we can be in full duplex mode.
+		 * If not, we operate in half-duplex mode.
+		 */
+		if (phydev->duplex != priv->duplex) {
+			new_state = 1;
+			priv->duplex = phydev->duplex;
+		}
+		/* Flow Control operation */
+		if (phydev->pause)
+			sunxi_flow_ctrl(priv->base, phydev->duplex,
+					flow_ctrl, pause);
+
+		if (phydev->speed != priv->speed) {
+			new_state = 1;
+			priv->speed = phydev->speed;
+		}
+
+		if (priv->link == 0) {
+			new_state = 1;
+			priv->link = phydev->link;
+		}
+
+		if (new_state)
+			sunxi_set_link_mode(priv->base, priv->duplex, priv->speed);
+
+#ifdef LOOPBACK_DEBUG
+		phydev->state = PHY_FORCING;
+#endif
+
+	} else if (priv->link != phydev->link) {
+		new_state = 1;
+		priv->link = 0;
+		priv->speed = 0;
+		priv->duplex = -1;
+	}
+
+	if (new_state)
+		phy_print_status(phydev);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static int geth_phy_init(struct net_device *ndev)
+{
+	int value;
+	struct mii_bus *new_bus;
+	struct geth_priv *priv = netdev_priv(ndev);
+	struct phy_device *phydev = ndev->phydev;
+
+	/* Fixup the phy interface type */
+	if (priv->phy_ext == INT_PHY) {
+		priv->phy_interface = PHY_INTERFACE_MODE_MII;
+	} else {
+		/* If config gpio to reset the phy device, we should reset it */
+		/*
+		if (gpio_is_valid(priv->phyrst)) {
+			gpio_direction_output(priv->phyrst,
+					priv->rst_active_low);
+			msleep(50);
+			gpio_direction_output(priv->phyrst,
+					!priv->rst_active_low);
+			msleep(50);
+		}
+		*/
+	}
+
+	if (priv->is_suspend && phydev)
+		goto resume;
+
+	new_bus = mdiobus_alloc();
+	if (!new_bus) {
+		netdev_err(ndev, "Failed to alloc new mdio bus\n");
+		return -ENOMEM;
+	}
+
+	new_bus->name = dev_name(priv->dev);
+	new_bus->read = &geth_mdio_read;
+	new_bus->write = &geth_mdio_write;
+	new_bus->reset = &geth_mdio_reset;
+	snprintf(new_bus->id, MII_BUS_ID_SIZE, "%s-%x", new_bus->name, 0);
+
+	new_bus->parent = priv->dev;
+	new_bus->priv = ndev;
+
+	if (mdiobus_register(new_bus)) {
+		pr_err("%s: Cannot register as MDIO bus\n", new_bus->name);
+		goto reg_fail;
+	}
+
+	priv->mii = new_bus;
+
+	{
+		int addr;
+
+		for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
+			struct phy_device *phydev_tmp = mdiobus_get_phy(new_bus, addr);
+
+			if (phydev_tmp && (phydev_tmp->phy_id != 0x00)) {
+				phydev = phydev_tmp;
+				priv->phy_addr = addr;
+				break;
+			}
+		}
+	}
+
+	if (!phydev) {
+		netdev_err(ndev, "No PHY found!\n");
+		goto err;
+	}
+
+	phydev->irq = PHY_POLL;
+
+	value = phy_connect_direct(ndev, phydev, &geth_adjust_link, priv->phy_interface);
+	if (value) {
+		netdev_err(ndev, "Could not attach to PHY\n");
+		goto err;
+	} else {
+		netdev_info(ndev, "%s: Type(%d) PHY ID %08x at %d IRQ %s (%s)\n",
+			    ndev->name, phydev->interface, phydev->phy_id,
+			    phydev->mdio.addr, "poll", dev_name(&phydev->mdio.dev));
+	}
+
+	//phydev->supported &= PHY_GBIT_FEATURES;
+	phydev->is_gigabit_capable = 1;
+	//phydev->advertising = phydev->supported;
+
+resume:
+	phy_write(phydev, MII_BMCR, BMCR_RESET);
+	while (BMCR_RESET & phy_read(phydev, MII_BMCR))
+		msleep(30);
+
+	value = phy_read(phydev, MII_BMCR);
+	phy_write(phydev, MII_BMCR, (value & ~BMCR_PDOWN));
+
+	if (priv->phy_ext == INT_PHY) {
+		/* EPHY Initial */
+		phy_write(phydev, 0x1f, 0x0100); /* switch to page 1 */
+		phy_write(phydev, 0x12, 0x4824); /* Disable APS */
+		phy_write(phydev, 0x1f, 0x0200); /* switchto page 2 */
+		phy_write(phydev, 0x18, 0x0000); /* PHYAFE TRX optimization */
+		phy_write(phydev, 0x1f, 0x0600); /* switchto page 6 */
+		phy_write(phydev, 0x14, 0x708F); /* PHYAFE TX optimization */
+		phy_write(phydev, 0x19, 0x0000);
+		phy_write(phydev, 0x13, 0xf000); /* PHYAFE RX optimization */
+		phy_write(phydev, 0x15, 0x1530);
+		phy_write(phydev, 0x1f, 0x0800); /* switch to page 8 */
+		phy_write(phydev, 0x18, 0x00bc); /* PHYAFE TRX optimization */
+		phy_write(phydev, 0x1f, 0x0100); /* switchto page 1 */
+		/* reg 0x17 bit3,set 0 to disable iEEE */
+		phy_write(phydev, 0x17, phy_read(phydev, 0x17) & (~(1<<3)));
+		phy_write(phydev, 0x1f, 0x0000); /* switch to page 0 */
+	}
+	if (priv->is_suspend)
+		phy_init_hw(phydev);
+
+	return 0;
+
+err:
+	mdiobus_unregister(new_bus);
+reg_fail:
+	mdiobus_free(new_bus);
+
+	return -EINVAL;
+}
+
+static int geth_phy_release(struct net_device *ndev)
+{
+	struct geth_priv *priv = netdev_priv(ndev);
+	struct phy_device *phydev = ndev->phydev;
+	int value = 0;
+
+	/* Stop and disconnect the PHY */
+	if (phydev)
+		phy_stop(phydev);
+
+	priv->link = PHY_DOWN;
+	priv->speed = 0;
+	priv->duplex = -1;
+
+	if (phydev) {
+		value = phy_read(phydev, MII_BMCR);
+		phy_write(phydev, MII_BMCR, (value | BMCR_PDOWN));
+	}
+
+	if (priv->is_suspend)
+		return 0;
+
+	if (phydev) {
+		phy_disconnect(phydev);
+		ndev->phydev = NULL;
+	}
+
+	if (priv->mii) {
+		mdiobus_unregister(priv->mii);
+		priv->mii->priv = NULL;
+		mdiobus_free(priv->mii);
+		priv->mii = NULL;
+	}
+
+	return 0;
+}
+
+static void geth_rx_refill(struct net_device *ndev)
+{
+	struct geth_priv *priv = netdev_priv(ndev);
+	struct dma_desc *desc;
+	struct sk_buff *sk = NULL;
+	dma_addr_t paddr;
+
+	while (circ_space(priv->rx_clean, priv->rx_dirty, dma_desc_rx) > 0) {
+		int entry = priv->rx_clean;
+
+		/* Find the dirty's desc and clean it */
+		desc = priv->dma_rx + entry;
+
+		if (priv->rx_sk[entry] == NULL) {
+			sk = netdev_alloc_skb_ip_align(ndev, priv->buf_sz);
+
+			if (unlikely(sk == NULL))
+				break;
+
+			priv->rx_sk[entry] = sk;
+			paddr = dma_map_single(priv->dev, sk->data,
+					       priv->buf_sz, DMA_FROM_DEVICE);
+			desc_buf_set(desc, paddr, priv->buf_sz);
+		}
+
+		/* sync memery */
+		wmb();
+		desc_set_own(desc);
+		priv->rx_clean = circ_inc(priv->rx_clean, dma_desc_rx);
+	}
+}
+
+/* geth_dma_desc_init - initialize the RX/TX descriptor list
+ * @ndev: net device structure
+ * Description: initialize the list for dma.
+ */
+static int geth_dma_desc_init(struct net_device *ndev)
+{
+	struct geth_priv *priv = netdev_priv(ndev);
+	unsigned int buf_sz;
+
+	priv->rx_sk = kzalloc(sizeof(struct sk_buff *) * dma_desc_rx,
+				GFP_KERNEL);
+	if (!priv->rx_sk)
+		return -ENOMEM;
+
+	priv->tx_sk = kzalloc(sizeof(struct sk_buff *) * dma_desc_tx,
+				GFP_KERNEL);
+	if (!priv->tx_sk)
+		goto tx_sk_err;
+
+	/* Set the size of buffer depend on the MTU & max buf size */
+	buf_sz = MAX_BUF_SZ;
+
+	priv->dma_tx = dma_alloc_coherent(priv->dev,
+					dma_desc_tx *
+					sizeof(struct dma_desc),
+					&priv->dma_tx_phy,
+					GFP_KERNEL);
+	if (!priv->dma_tx)
+		goto dma_tx_err;
+
+	priv->dma_rx = dma_alloc_coherent(priv->dev,
+					dma_desc_rx *
+					sizeof(struct dma_desc),
+					&priv->dma_rx_phy,
+					GFP_KERNEL);
+	if (!priv->dma_rx)
+		goto dma_rx_err;
+
+	priv->buf_sz = buf_sz;
+
+	return 0;
+
+dma_rx_err:
+	dma_free_coherent(priv->dev, dma_desc_rx * sizeof(struct dma_desc),
+			  priv->dma_tx, priv->dma_tx_phy);
+dma_tx_err:
+	kfree(priv->tx_sk);
+tx_sk_err:
+	kfree(priv->rx_sk);
+
+	return -ENOMEM;
+}
+
+static void geth_free_rx_sk(struct geth_priv *priv)
+{
+	int i;
+
+	for (i = 0; i < dma_desc_rx; i++) {
+		if (priv->rx_sk[i] != NULL) {
+			struct dma_desc *desc = priv->dma_rx + i;
+
+			dma_unmap_single(priv->dev, (u32)desc_buf_get_addr(desc),
+					 desc_buf_get_len(desc),
+					 DMA_FROM_DEVICE);
+			dev_kfree_skb_any(priv->rx_sk[i]);
+			priv->rx_sk[i] = NULL;
+		}
+	}
+}
+
+static void geth_free_tx_sk(struct geth_priv *priv)
+{
+	int i;
+
+	for (i = 0; i < dma_desc_tx; i++) {
+		if (priv->tx_sk[i] != NULL) {
+			struct dma_desc *desc = priv->dma_tx + i;
+
+			if (desc_buf_get_addr(desc))
+				dma_unmap_single(priv->dev, (u32)desc_buf_get_addr(desc),
+						 desc_buf_get_len(desc),
+						 DMA_TO_DEVICE);
+			dev_kfree_skb_any(priv->tx_sk[i]);
+			priv->tx_sk[i] = NULL;
+		}
+	}
+}
+
+static void geth_free_dma_desc(struct geth_priv *priv)
+{
+	/* Free the region of consistent memory previously allocated for the DMA */
+	dma_free_coherent(priv->dev, dma_desc_tx * sizeof(struct dma_desc),
+			  priv->dma_tx, priv->dma_tx_phy);
+	dma_free_coherent(priv->dev, dma_desc_rx * sizeof(struct dma_desc),
+			  priv->dma_rx, priv->dma_rx_phy);
+
+	kfree(priv->rx_sk);
+	kfree(priv->tx_sk);
+}
+
+#if IS_ENABLED(CONFIG_PM)
+/*
+static int geth_select_gpio_state(struct pinctrl *pctrl, char *name)
+{
+	int ret = 0;
+	struct pinctrl_state *pctrl_state = NULL;
+
+	pctrl_state = pinctrl_lookup_state(pctrl, name);
+	if (IS_ERR(pctrl_state)) {
+		pr_err("gmac pinctrl_lookup_state(%s) failed! return %p\n",
+						name, pctrl_state);
+		return -EINVAL;
+	}
+
+	ret = pinctrl_select_state(pctrl, pctrl_state);
+	if (ret < 0)
+		pr_err("gmac pinctrl_select_state(%s) failed! return %d\n",
+						name, ret);
+
+	return ret;
+}
+*/
+static int geth_suspend(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct geth_priv *priv = netdev_priv(ndev);
+
+	cancel_work_sync(&priv->eth_work);
+
+	if (!ndev || !netif_running(ndev))
+		return 0;
+
+	priv->is_suspend = true;
+
+	spin_lock(&priv->lock);
+	netif_device_detach(ndev);
+	spin_unlock(&priv->lock);
+
+	geth_stop(ndev);
+/*
+	if (priv->phy_ext == EXT_PHY)
+
+	geth_select_gpio_state(priv->pinctrl, PINCTRL_STATE_SLEEP);
+*/
+	return 0;
+}
+
+static void geth_resume_work(struct work_struct *work)
+{
+	struct geth_priv *priv = container_of(work, struct geth_priv, eth_work);
+	struct net_device *ndev = priv->ndev;
+	int ret = 0;
+
+	if (!netif_running(ndev))
+		return;
+/*
+	if (priv->phy_ext == EXT_PHY)
+		geth_select_gpio_state(priv->pinctrl, PINCTRL_STATE_DEFAULT);
+*/
+	spin_lock(&priv->lock);
+	netif_device_attach(ndev);
+	spin_unlock(&priv->lock);
+
+#if IS_ENABLED(CONFIG_SUNXI_EPHY)
+	if (!ephy_is_enable()) {
+		pr_info("[geth_resume] ephy is not enable, waiting...\n");
+		msleep(2000);
+		if (!ephy_is_enable()) {
+			netdev_err(ndev, "Wait for ephy resume timeout.\n");
+			return;
+		}
+	}
+#endif
+
+	ret = geth_open(ndev);
+	if (!ret)
+		priv->is_suspend = false;
+}
+
+static void geth_resume(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct geth_priv *priv = netdev_priv(ndev);
+
+	schedule_work(&priv->eth_work);
+}
+
+static int geth_freeze(struct device *dev)
+{
+	return 0;
+}
+
+static int geth_restore(struct device *dev)
+{
+	return 0;
+}
+
+static const struct dev_pm_ops geth_pm_ops = {
+	.complete = geth_resume,
+	.prepare = geth_suspend,
+	.suspend = NULL,
+	.resume = NULL,
+	.freeze = geth_freeze,
+	.restore = geth_restore,
+};
+#else
+static const struct dev_pm_ops geth_pm_ops;
+#endif /* CONFIG_PM */
+
+#define sunxi_get_soc_chipid(x) {}
+static void geth_chip_hwaddr(u8 *addr)
+{
+#define MD5_SIZE	16
+#define CHIP_SIZE	16
+
+	struct crypto_ahash *tfm;
+	struct ahash_request *req;
+	struct scatterlist sg;
+	u8 result[MD5_SIZE];
+	u8 chipid[CHIP_SIZE];
+	int i = 0;
+	int ret = -1;
+
+	memset(chipid, 0, sizeof(chipid));
+	memset(result, 0, sizeof(result));
+
+	sunxi_get_soc_chipid((u8 *)chipid);
+
+	tfm = crypto_alloc_ahash("md5", 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(tfm)) {
+		pr_err("Failed to alloc md5\n");
+		return;
+	}
+
+	req = ahash_request_alloc(tfm, GFP_KERNEL);
+	if (!req)
+		goto out;
+
+	ahash_request_set_callback(req, 0, NULL, NULL);
+
+	ret = crypto_ahash_init(req);
+	if (ret) {
+		pr_err("crypto_ahash_init() failed\n");
+		goto out;
+	}
+
+	sg_init_one(&sg, chipid, sizeof(chipid));
+	ahash_request_set_crypt(req, &sg, result, sizeof(chipid));
+	ret = crypto_ahash_update(req);
+	if (ret) {
+		pr_err("crypto_ahash_update() failed for id\n");
+		goto out;
+	}
+
+	ret = crypto_ahash_final(req);
+	if (ret) {
+		pr_err("crypto_ahash_final() failed for result\n");
+		goto out;
+	}
+
+	ahash_request_free(req);
+
+	/* Choose md5 result's [0][2][4][6][8][10] byte as mac address */
+	for (i = 0; i < ETH_ALEN; i++)
+		addr[i] = result[2 * i];
+	addr[0] &= 0xfe; /* clear multicast bit */
+	addr[0] |= 0x02; /* set local assignment bit (IEEE802) */
+
+out:
+	crypto_free_ahash(tfm);
+}
+
+static void geth_check_addr(struct net_device *ndev, unsigned char *mac)
+{
+	int i;
+	char *p = mac;
+
+	if (!is_valid_ether_addr(ndev->dev_addr)) {
+		for (i = 0; i < ETH_ALEN; i++, p++)
+			ndev->dev_addr[i] = simple_strtoul(p, &p, 16);
+
+		if (!is_valid_ether_addr(ndev->dev_addr))
+			geth_chip_hwaddr(ndev->dev_addr);
+
+		if (!is_valid_ether_addr(ndev->dev_addr)) {
+			random_ether_addr(ndev->dev_addr);
+			pr_warn("%s: Use random mac address\n", ndev->name);
+		}
+	}
+}
+
+static int geth_clk_enable(struct geth_priv *priv)
+{
+	int ret;
+	phy_interface_t phy_interface = 0;
+	u32 clk_value;
+	/*u32 efuse_value;*/
+/*
+	ret = reset_control_deassert(priv->reset);
+	if (ret) {
+		pr_err("deassert gmac rst failed!\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(priv->geth_clk);
+	if (ret) {
+		pr_err("try to enable geth_clk failed!\n");
+		goto assert_reset;
+	}
+
+	if (((priv->phy_ext == INT_PHY) || priv->use_ephy_clk)
+			&& !IS_ERR_OR_NULL(priv->ephy_clk)) {
+		ret = clk_prepare_enable(priv->ephy_clk);
+		if (ret) {
+			pr_err("try to enable ephy_clk failed!\n");
+			goto ephy_clk_disable;
+		}
+	}
+*/
+	phy_interface = priv->phy_interface;
+
+	clk_value = readl(priv->base_phy);
+	if (phy_interface == PHY_INTERFACE_MODE_RGMII)
+		clk_value |= 0x00000004;
+	else
+		clk_value &= (~0x00000004);
+
+	clk_value &= (~0x00002003);
+	if (phy_interface == PHY_INTERFACE_MODE_RGMII
+			|| phy_interface == PHY_INTERFACE_MODE_GMII)
+		clk_value |= 0x00000002;
+	else if (phy_interface == PHY_INTERFACE_MODE_RMII)
+		clk_value |= 0x00002001;
+
+	/*if (priv->phy_ext == INT_PHY) {
+		if (0 != sunxi_efuse_read(EFUSE_OEM_NAME, &efuse_value))
+			pr_err("get PHY efuse fail!\n");
+		else
+#if IS_ENABLED(CONFIG_ARCH_SUN50IW2)
+			clk_value |= (((efuse_value >> 24) & 0x0F) + 3) << 28;
+#else
+			pr_warn("miss config come from efuse!\n");
+#endif
+	}*/
+
+	/* Adjust Tx/Rx clock delay */
+	clk_value &= ~(0x07 << 10);
+	clk_value |= ((priv->tx_delay & 0x07) << 10);
+	clk_value &= ~(0x1F << 5);
+	clk_value |= ((priv->rx_delay & 0x1F) << 5);
+
+	writel(clk_value, priv->base_phy);
+
+    return 0;
+/*
+ephy_clk_disable:
+    clk_disable_unprepare(priv->ephy_clk);
+assert_reset:
+    reset_control_assert(priv->reset);
+*/
+    return ret;
+}
+
+static void geth_clk_disable(struct geth_priv *priv)
+{
+/*
+	if (((priv->phy_ext == INT_PHY) || priv->use_ephy_clk)
+			&& !IS_ERR_OR_NULL(priv->ephy_clk))
+		clk_disable_unprepare(priv->ephy_clk);
+
+	clk_disable_unprepare(priv->geth_clk);
+    reset_control_assert(priv->reset);
+*/
+}
+
+static void geth_tx_err(struct geth_priv *priv)
+{
+	netif_stop_queue(priv->ndev);
+
+	sunxi_stop_tx(priv->base);
+
+	geth_free_tx_sk(priv);
+	memset(priv->dma_tx, 0, dma_desc_tx * sizeof(struct dma_desc));
+	desc_init_chain(priv->dma_tx, (unsigned long)priv->dma_tx_phy, dma_desc_tx);
+	priv->tx_dirty = 0;
+	priv->tx_clean = 0;
+	sunxi_start_tx(priv->base, priv->dma_tx_phy);
+
+	priv->ndev->stats.tx_errors++;
+	netif_wake_queue(priv->ndev);
+}
+
+static inline void geth_schedule(struct geth_priv *priv)
+{
+	if (likely(napi_schedule_prep(&priv->napi))) {
+		sunxi_int_disable(priv->base);
+		__napi_schedule(&priv->napi);
+	}
+}
+
+static irqreturn_t geth_interrupt(int irq, void *dev_id)
+{
+	struct net_device *ndev = (struct net_device *)dev_id;
+	struct geth_priv *priv = netdev_priv(ndev);
+	int status;
+
+	if (unlikely(!ndev)) {
+		pr_err("%s: invalid ndev pointer\n", __func__);
+		return IRQ_NONE;
+	}
+
+	status = sunxi_int_status(priv->base, (void *)(&priv->xstats));
+
+	if (likely(status == handle_tx_rx))
+		geth_schedule(priv);
+	else if (unlikely(status == tx_hard_error_bump_tc))
+		netdev_info(ndev, "Do nothing for bump tc\n");
+	else if (unlikely(status == tx_hard_error))
+		geth_tx_err(priv);
+	else
+		netdev_info(ndev, "Do nothing.....\n");
+
+	return IRQ_HANDLED;
+}
+
+static int geth_open(struct net_device *ndev)
+{
+	struct geth_priv *priv = netdev_priv(ndev);
+	int ret = 0;
+
+	ret = geth_power_on(priv);
+	if (ret) {
+		netdev_err(ndev, "Power on is failed\n");
+		ret = -EINVAL;
+	}
+
+	ret = geth_clk_enable(priv);
+	if (ret) {
+		pr_err("%s: clk enable is failed\n", __func__);
+		ret = -EINVAL;
+	}
+
+	netif_carrier_off(ndev);
+
+	ret = geth_phy_init(ndev);
+	if (ret)
+		goto err;
+
+	ret = sunxi_mac_reset((void *)priv->base, &sunxi_udelay, 10000);
+	if (ret) {
+		netdev_err(ndev, "Initialize hardware error\n");
+		goto desc_err;
+	}
+
+	sunxi_mac_init(priv->base, txmode, rxmode);
+	sunxi_set_umac(priv->base, ndev->dev_addr, 0);
+
+	if (!priv->is_suspend) {
+		ret = geth_dma_desc_init(ndev);
+		if (ret) {
+			ret = -EINVAL;
+			goto desc_err;
+		}
+	}
+
+	memset(priv->dma_tx, 0, dma_desc_tx * sizeof(struct dma_desc));
+	memset(priv->dma_rx, 0, dma_desc_rx * sizeof(struct dma_desc));
+
+	desc_init_chain(priv->dma_rx, (unsigned long)priv->dma_rx_phy, dma_desc_rx);
+	desc_init_chain(priv->dma_tx, (unsigned long)priv->dma_tx_phy, dma_desc_tx);
+
+	priv->rx_clean = 0;
+	priv->rx_dirty = 0;
+	priv->tx_clean = 0;
+	priv->tx_dirty = 0;
+	geth_rx_refill(ndev);
+
+	/* Extra statistics */
+	memset(&priv->xstats, 0, sizeof(struct geth_extra_stats));
+
+	if (ndev->phydev)
+		phy_start(ndev->phydev);
+
+	sunxi_start_rx(priv->base, (unsigned long)((struct dma_desc *)
+		       priv->dma_rx_phy + priv->rx_dirty));
+	sunxi_start_tx(priv->base, (unsigned long)((struct dma_desc *)
+		       priv->dma_tx_phy + priv->tx_clean));
+
+	napi_enable(&priv->napi);
+	netif_start_queue(ndev);
+
+	/* Enable the Rx/Tx */
+	sunxi_mac_enable(priv->base);
+
+	return 0;
+
+desc_err:
+	geth_phy_release(ndev);
+err:
+	geth_clk_disable(priv);
+	if (priv->is_suspend)
+		napi_enable(&priv->napi);
+
+	geth_power_off(priv);
+
+	return ret;
+}
+
+static int geth_stop(struct net_device *ndev)
+{
+	struct geth_priv *priv = netdev_priv(ndev);
+
+	netif_stop_queue(ndev);
+	napi_disable(&priv->napi);
+
+	netif_carrier_off(ndev);
+
+	/* Release PHY resources */
+	geth_phy_release(ndev);
+
+	/* Disable Rx/Tx */
+	sunxi_mac_disable(priv->base);
+
+	geth_clk_disable(priv);
+	geth_power_off(priv);
+
+	netif_tx_lock_bh(ndev);
+	/* Release the DMA TX/RX socket buffers */
+	geth_free_rx_sk(priv);
+	geth_free_tx_sk(priv);
+	netif_tx_unlock_bh(ndev);
+
+	/* Ensure that hareware have been stopped */
+	if (!priv->is_suspend)
+		geth_free_dma_desc(priv);
+
+	return 0;
+}
+
+static void geth_tx_complete(struct geth_priv *priv)
+{
+	unsigned int entry = 0;
+	struct sk_buff *skb = NULL;
+	struct dma_desc *desc = NULL;
+	int tx_stat;
+
+	spin_lock(&priv->tx_lock);
+	while (circ_cnt(priv->tx_dirty, priv->tx_clean, dma_desc_tx) > 0) {
+		entry = priv->tx_clean;
+		desc = priv->dma_tx + entry;
+
+		/* Check if the descriptor is owned by the DMA. */
+		if (desc_get_own(desc))
+			break;
+
+		/* Verify tx error by looking at the last segment */
+		if (desc_get_tx_ls(desc)) {
+			tx_stat = desc_get_tx_status(desc, (void *)(&priv->xstats));
+
+			if (likely(!tx_stat))
+				priv->ndev->stats.tx_packets++;
+			else
+				priv->ndev->stats.tx_errors++;
+		}
+
+		dma_unmap_single(priv->dev, (u32)desc_buf_get_addr(desc),
+				 desc_buf_get_len(desc), DMA_TO_DEVICE);
+
+		skb = priv->tx_sk[entry];
+		priv->tx_sk[entry] = NULL;
+		desc_init(desc);
+
+		/* Find next dirty desc */
+		priv->tx_clean = circ_inc(entry, dma_desc_tx);
+
+		if (unlikely(skb == NULL))
+			continue;
+
+		dev_kfree_skb(skb);
+	}
+
+	if (unlikely(netif_queue_stopped(priv->ndev)) &&
+	    circ_space(priv->tx_dirty, priv->tx_clean, dma_desc_tx) >
+	    TX_THRESH) {
+		netif_wake_queue(priv->ndev);
+	}
+	spin_unlock(&priv->tx_lock);
+}
+
+static netdev_tx_t geth_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct geth_priv  *priv = netdev_priv(ndev);
+	unsigned int entry;
+	struct dma_desc *desc, *first;
+	unsigned int len, tmp_len = 0;
+	int i, csum_insert;
+	int nfrags = skb_shinfo(skb)->nr_frags;
+	dma_addr_t paddr;
+
+	spin_lock(&priv->tx_lock);
+	if (unlikely(circ_space(priv->tx_dirty, priv->tx_clean,
+	    dma_desc_tx) < (nfrags + 1))) {
+		if (!netif_queue_stopped(ndev)) {
+			netdev_err(ndev, "%s: BUG! Tx Ring full when queue awake\n", __func__);
+			netif_stop_queue(ndev);
+		}
+		spin_unlock(&priv->tx_lock);
+
+		return NETDEV_TX_BUSY;
+	}
+
+	csum_insert = (skb->ip_summed == CHECKSUM_PARTIAL);
+	entry = priv->tx_dirty;
+	first = priv->dma_tx + entry;
+	desc = priv->dma_tx + entry;
+
+	len = skb_headlen(skb);
+	priv->tx_sk[entry] = skb;
+
+#ifdef PKT_DEBUG
+	printk("======TX PKT DATA: ============\n");
+	/* dump the packet */
+	print_hex_dump(KERN_DEBUG, "skb->data: ", DUMP_PREFIX_NONE,
+		       16, 1, skb->data, 64, true);
+#endif
+
+	/* Every desc max size is 2K */
+	while (len != 0) {
+		desc = priv->dma_tx + entry;
+		tmp_len = ((len > MAX_BUF_SZ) ?  MAX_BUF_SZ : len);
+
+		paddr = dma_map_single(priv->dev, skb->data, tmp_len, DMA_TO_DEVICE);
+		if (dma_mapping_error(priv->dev, paddr)) {
+			dev_kfree_skb(skb);
+			return -EIO;
+		}
+		desc_buf_set(desc, paddr, tmp_len);
+		/* Don't set the first's own bit, here */
+		if (first != desc) {
+			priv->tx_sk[entry] = NULL;
+			desc_set_own(desc);
+		}
+
+		entry = circ_inc(entry, dma_desc_tx);
+		len -= tmp_len;
+	}
+
+	for (i = 0; i < nfrags; i++) {
+		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+
+		len = skb_frag_size(frag);
+		desc = priv->dma_tx + entry;
+		paddr = skb_frag_dma_map(priv->dev, frag, 0, len, DMA_TO_DEVICE);
+		if (dma_mapping_error(priv->dev, paddr)) {
+			dev_kfree_skb(skb);
+			return -EIO;
+		}
+
+		desc_buf_set(desc, paddr, len);
+		desc_set_own(desc);
+		priv->tx_sk[entry] = NULL;
+		entry = circ_inc(entry, dma_desc_tx);
+	}
+
+	ndev->stats.tx_bytes += skb->len;
+	priv->tx_dirty = entry;
+	desc_tx_close(first, desc, csum_insert);
+
+	desc_set_own(first);
+	spin_unlock(&priv->tx_lock);
+
+	if (circ_space(priv->tx_dirty, priv->tx_clean, dma_desc_tx) <=
+			(MAX_SKB_FRAGS + 1)) {
+		netif_stop_queue(ndev);
+		if (circ_space(priv->tx_dirty, priv->tx_clean, dma_desc_tx) >
+				TX_THRESH)
+			netif_wake_queue(ndev);
+	}
+
+#ifdef DEBUG
+	printk("=======TX Descriptor DMA: 0x%08llx\n", priv->dma_tx_phy);
+	printk("Tx pointor: dirty: %d, clean: %d\n", priv->tx_dirty, priv->tx_clean);
+	desc_print(priv->dma_tx, dma_desc_tx);
+#endif
+	sunxi_tx_poll(priv->base);
+	geth_tx_complete(priv);
+
+	return NETDEV_TX_OK;
+}
+
+static int geth_rx(struct geth_priv *priv, int limit)
+{
+	unsigned int rxcount = 0;
+	unsigned int entry;
+	struct dma_desc *desc;
+	struct sk_buff *skb;
+	int status;
+	int frame_len;
+
+	while (rxcount < limit) {
+		entry = priv->rx_dirty;
+		desc = priv->dma_rx + entry;
+
+		if (desc_get_own(desc))
+			break;
+
+		rxcount++;
+		priv->rx_dirty = circ_inc(priv->rx_dirty, dma_desc_rx);
+
+		/* Get length & status from hardware */
+		frame_len = desc_rx_frame_len(desc);
+		status = desc_get_rx_status(desc, (void *)(&priv->xstats));
+
+		netdev_dbg(priv->ndev, "Rx frame size %d, status: %d\n",
+			   frame_len, status);
+
+		skb = priv->rx_sk[entry];
+		if (unlikely(!skb)) {
+			netdev_err(priv->ndev, "Skb is null\n");
+			priv->ndev->stats.rx_dropped++;
+			break;
+		}
+
+#ifdef PKT_DEBUG
+		printk("======RX PKT DATA: ============\n");
+		/* dump the packet */
+		print_hex_dump(KERN_DEBUG, "skb->data: ", DUMP_PREFIX_NONE,
+				16, 1, skb->data, 64, true);
+#endif
+
+		if (status == discard_frame) {
+			netdev_dbg(priv->ndev, "Get error pkt\n");
+			priv->ndev->stats.rx_errors++;
+			continue;
+		}
+
+		if (unlikely(status != llc_snap))
+			frame_len -= ETH_FCS_LEN;
+
+		priv->rx_sk[entry] = NULL;
+
+		skb_put(skb, frame_len);
+		dma_unmap_single(priv->dev, (u32)desc_buf_get_addr(desc),
+				 desc_buf_get_len(desc), DMA_FROM_DEVICE);
+
+		skb->protocol = eth_type_trans(skb, priv->ndev);
+
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		napi_gro_receive(&priv->napi, skb);
+
+		priv->ndev->stats.rx_packets++;
+		priv->ndev->stats.rx_bytes += frame_len;
+	}
+
+#ifdef DEBUG
+	if (rxcount > 0) {
+		printk("======RX Descriptor DMA: 0x%08llx=\n", priv->dma_rx_phy);
+		printk("RX pointor: dirty: %d, clean: %d\n", priv->rx_dirty, priv->rx_clean);
+		desc_print(priv->dma_rx, dma_desc_rx);
+	}
+#endif
+	geth_rx_refill(priv->ndev);
+
+	return rxcount;
+}
+
+static int geth_poll(struct napi_struct *napi, int budget)
+{
+	struct geth_priv *priv = container_of(napi, struct geth_priv, napi);
+	int work_done = 0;
+
+	geth_tx_complete(priv);
+	work_done = geth_rx(priv, budget);
+
+	if (work_done < budget) {
+		napi_complete(napi);
+		sunxi_int_enable(priv->base);
+	}
+
+	return work_done;
+}
+
+static int geth_change_mtu(struct net_device *ndev, int new_mtu)
+{
+	int max_mtu;
+
+	if (netif_running(ndev)) {
+		pr_err("%s: must be stopped to change its MTU\n", ndev->name);
+		return -EBUSY;
+	}
+
+	max_mtu = SKB_MAX_HEAD(NET_SKB_PAD + NET_IP_ALIGN);
+
+	if ((new_mtu < 46) || (new_mtu > max_mtu)) {
+		pr_err("%s: invalid MTU, max MTU is: %d\n", ndev->name, max_mtu);
+		return -EINVAL;
+	}
+
+	ndev->mtu = new_mtu;
+	netdev_update_features(ndev);
+
+	return 0;
+}
+
+static netdev_features_t geth_fix_features(struct net_device *ndev,
+					   netdev_features_t features)
+{
+	return features;
+}
+
+static void geth_set_rx_mode(struct net_device *ndev)
+{
+	struct geth_priv *priv = netdev_priv(ndev);
+	unsigned int value = 0;
+
+	pr_debug("%s: # mcasts %d, # unicast %d\n",
+		 __func__, netdev_mc_count(ndev), netdev_uc_count(ndev));
+
+	spin_lock(&priv->lock);
+	if (ndev->flags & IFF_PROMISC) {
+		value = GETH_FRAME_FILTER_PR;
+	} else if ((netdev_mc_count(ndev) > HASH_TABLE_SIZE) ||
+		   (ndev->flags & IFF_ALLMULTI)) {
+		value = GETH_FRAME_FILTER_PM;	/* pass all multi */
+		sunxi_hash_filter(priv->base, ~0UL, ~0UL);
+	} else if (!netdev_mc_empty(ndev)) {
+		u32 mc_filter[2];
+		struct netdev_hw_addr *ha;
+
+		/* Hash filter for multicast */
+		value = GETH_FRAME_FILTER_HMC;
+
+		memset(mc_filter, 0, sizeof(mc_filter));
+		netdev_for_each_mc_addr(ha, ndev) {
+			/* The upper 6 bits of the calculated CRC are used to
+			 *  index the contens of the hash table
+			 */
+			int bit_nr = bitrev32(~crc32_le(~0, ha->addr, 6)) >> 26;
+			/* The most significant bit determines the register to
+			 * use (H/L) while the other 5 bits determine the bit
+			 * within the register.
+			 */
+			mc_filter[bit_nr >> 5] |= 1 << (bit_nr & 31);
+		}
+		sunxi_hash_filter(priv->base, mc_filter[0], mc_filter[1]);
+	}
+
+	/* Handle multiple unicast addresses (perfect filtering)*/
+	if (netdev_uc_count(ndev) > 16) {
+		/* Switch to promiscuous mode is more than 8 addrs are required */
+		value |= GETH_FRAME_FILTER_PR;
+	} else {
+		int reg = 1;
+		struct netdev_hw_addr *ha;
+
+		netdev_for_each_uc_addr(ha, ndev) {
+			sunxi_set_umac(priv->base, ha->addr, reg);
+			reg++;
+		}
+	}
+
+#ifdef FRAME_FILTER_DEBUG
+	/* Enable Receive all mode (to debug filtering_fail errors) */
+	value |= GETH_FRAME_FILTER_RA;
+#endif
+	sunxi_set_filter(priv->base, value);
+	spin_unlock(&priv->lock);
+}
+
+static void geth_tx_timeout(struct net_device *ndev, unsigned int txqueue)
+{
+	struct geth_priv *priv = netdev_priv(ndev);
+
+	geth_tx_err(priv);
+}
+
+static int geth_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
+{
+	if (!netif_running(ndev))
+		return -EINVAL;
+
+	if (!ndev->phydev)
+		return -EINVAL;
+
+	return phy_mii_ioctl(ndev->phydev, rq, cmd);
+}
+
+/* Configuration changes (passed on by ifconfig) */
+static int geth_config(struct net_device *ndev, struct ifmap *map)
+{
+	if (ndev->flags & IFF_UP)	/* can't act on a running interface */
+		return -EBUSY;
+
+	/* Don't allow changing the I/O address */
+	if (map->base_addr != ndev->base_addr) {
+		pr_warn("%s: can't change I/O address\n", ndev->name);
+		return -EOPNOTSUPP;
+	}
+
+	/* Don't allow changing the IRQ */
+	if (map->irq != ndev->irq) {
+		pr_warn("%s: can't change IRQ number %d\n", ndev->name, ndev->irq);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int geth_set_mac_address(struct net_device *ndev, void *p)
+{
+	struct geth_priv *priv = netdev_priv(ndev);
+	struct sockaddr *addr = p;
+
+	if (!is_valid_ether_addr(addr->sa_data))
+		return -EADDRNOTAVAIL;
+
+	memcpy(ndev->dev_addr, addr->sa_data, ndev->addr_len);
+	sunxi_set_umac(priv->base, ndev->dev_addr, 0);
+
+	return 0;
+}
+
+int geth_set_features(struct net_device *ndev, netdev_features_t features)
+{
+	struct geth_priv *priv = netdev_priv(ndev);
+
+	if (features & NETIF_F_LOOPBACK && netif_running(ndev))
+		sunxi_mac_loopback(priv->base, 1);
+	else
+		sunxi_mac_loopback(priv->base, 0);
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_NET_POLL_CONTROLLER)
+/* Polling receive - used by NETCONSOLE and other diagnostic tools
+ * to allow network I/O with interrupts disabled.
+ */
+static void geth_poll_controller(struct net_device *dev)
+{
+	disable_irq(dev->irq);
+	geth_interrupt(dev->irq, dev);
+	enable_irq(dev->irq);
+}
+#endif
+
+static const struct net_device_ops geth_netdev_ops = {
+	.ndo_init = NULL,
+	.ndo_open = geth_open,
+	.ndo_start_xmit = geth_xmit,
+	.ndo_stop = geth_stop,
+	.ndo_change_mtu = geth_change_mtu,
+	.ndo_fix_features = geth_fix_features,
+	.ndo_set_rx_mode = geth_set_rx_mode,
+	.ndo_tx_timeout = geth_tx_timeout,
+	.ndo_do_ioctl = geth_ioctl,
+	.ndo_set_config = geth_config,
+#if IS_ENABLED(CONFIG_NET_POLL_CONTROLLER)
+	.ndo_poll_controller = geth_poll_controller,
+#endif
+	.ndo_set_mac_address = geth_set_mac_address,
+	.ndo_set_features = geth_set_features,
+};
+
+static int geth_check_if_running(struct net_device *ndev)
+{
+	if (!netif_running(ndev))
+		return -EBUSY;
+	return 0;
+}
+
+static int geth_get_sset_count(struct net_device *netdev, int sset)
+{
+	int len;
+
+	switch (sset) {
+	case ETH_SS_STATS:
+		len = 0;
+		return len;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+/*static int geth_ethtool_getsettings(struct net_device *ndev,
+				    struct ethtool_cmd *cmd)
+{
+	struct geth_priv *priv = netdev_priv(ndev);
+	struct phy_device *phy = ndev->phydev;
+	int rc;
+
+	if (phy == NULL) {
+		netdev_err(ndev, "%s: %s: PHY is not registered\n",
+		       __func__, ndev->name);
+		return -ENODEV;
+	}
+
+	if (!netif_running(ndev)) {
+		pr_err("%s: interface is disabled: we cannot track "
+		       "link speed / duplex setting\n", ndev->name);
+		return -EBUSY;
+	}
+
+	cmd->transceiver = XCVR_INTERNAL;
+	spin_lock_irq(&priv->lock);
+	//rc = phy_ethtool_gset(phy, cmd);
+	spin_unlock_irq(&priv->lock);
+
+	return rc;
+}
+
+static int geth_ethtool_setsettings(struct net_device *ndev,
+				    struct ethtool_cmd *cmd)
+{
+	struct geth_priv *priv = netdev_priv(ndev);
+	struct phy_device *phy = ndev->phydev;
+	int rc;
+
+	spin_lock(&priv->lock);
+	rc = phy_ethtool_sset(phy, cmd);
+	spin_unlock(&priv->lock);
+
+	return rc;
+}*/
+
+static void geth_ethtool_getdrvinfo(struct net_device *ndev,
+				    struct ethtool_drvinfo *info)
+{
+	strlcpy(info->driver, "sunxi_geth", sizeof(info->driver));
+
+#define DRV_MODULE_VERSION "SUNXI Gbgit driver V1.1"
+
+	strcpy(info->version, DRV_MODULE_VERSION);
+	info->fw_version[0] = '\0';
+}
+
+static const struct ethtool_ops geth_ethtool_ops = {
+	.begin = geth_check_if_running,
+	//.get_settings = geth_ethtool_getsettings,
+	//.set_settings = geth_ethtool_setsettings,
+	.get_link = ethtool_op_get_link,
+	.get_pauseparam = NULL,
+	.set_pauseparam = NULL,
+	.get_ethtool_stats = NULL,
+	.get_strings = NULL,
+	.get_wol = NULL,
+	.set_wol = NULL,
+	.get_sset_count = geth_get_sset_count,
+	.get_drvinfo = geth_ethtool_getdrvinfo,
+};
+
+/* config hardware resource */
+static int geth_hw_init(struct platform_device *pdev)
+{
+	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct geth_priv *priv = netdev_priv(ndev);
+	struct device_node *np = pdev->dev.of_node;
+	int ret = 0;
+	struct resource *res;
+	u32 value;
+//	struct gpio_config cfg;
+//	const char *gmac_power;
+//	char power[20];
+//	int i;
+
+#if 1
+	priv->phy_ext = EXT_PHY;
+#else
+	priv->phy_ext = INT_PHY;
+#endif
+
+	/* config memery resource */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (unlikely(!res)) {
+		pr_err("%s: ERROR: get gmac memory failed", __func__);
+		return -ENODEV;
+	}
+
+	priv->base = devm_ioremap_resource(&pdev->dev, res);
+	if (!priv->base) {
+		pr_err("%s: ERROR: gmac memory mapping failed", __func__);
+		return -ENOMEM;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (unlikely(!res)) {
+		pr_err("%s: ERROR: get phy memory failed", __func__);
+		ret = -ENODEV;
+		goto mem_err;
+	}
+
+	priv->base_phy = devm_ioremap_resource(&pdev->dev, res);
+	if (unlikely(!priv->base_phy)) {
+		pr_err("%s: ERROR: phy memory mapping failed", __func__);
+		ret = -ENOMEM;
+		goto mem_err;
+	}
+
+	/* config IRQ */
+	ndev->irq = platform_get_irq_byname(pdev, "gmacirq");
+	if (ndev->irq == -ENXIO) {
+		pr_err("%s: ERROR: MAC IRQ not found\n", __func__);
+		ret = -ENXIO;
+		goto irq_err;
+	}
+
+	ret = request_irq(ndev->irq, geth_interrupt, IRQF_SHARED, dev_name(&pdev->dev), ndev);
+	if (unlikely(ret < 0)) {
+		pr_err("Could not request irq %d, error: %d\n", ndev->irq, ret);
+		goto irq_err;
+	}
+
+	/* get gmac rst handle */
+/*
+	priv->reset = devm_reset_control_get(&pdev->dev, NULL);
+	if (IS_ERR(priv->reset)) {
+		pr_err("%s: Get gmac reset control failed!\n", __func__);
+		return PTR_ERR(priv->reset);
+	}
+*/
+	/* config clock */
+/*
+	priv->geth_clk = of_clk_get_by_name(np, "gmac");
+	if (unlikely(!priv->geth_clk || IS_ERR(priv->geth_clk))) {
+		pr_err("Get gmac clock failed!\n");
+		ret = -EINVAL;
+		goto clk_err;
+	}
+
+	if (INT_PHY == priv->phy_ext) {
+		priv->ephy_clk = of_clk_get_by_name(np, "ephy");
+		if (unlikely(IS_ERR_OR_NULL(priv->ephy_clk))) {
+			pr_err("Get ephy clock failed!\n");
+			ret = -EINVAL;
+			goto clk_err;
+		}
+	} else {
+		if (!of_property_read_u32(np, "use-ephy25m", &(priv->use_ephy_clk))
+				&& priv->use_ephy_clk) {
+			priv->ephy_clk = of_clk_get_by_name(np, "ephy");
+			if (unlikely(IS_ERR_OR_NULL(priv->ephy_clk))) {
+				pr_err("Get ephy clk failed!\n");
+				ret = -EINVAL;
+				goto clk_err;
+			}
+		}
+	}
+*/
+	/* config power regulator */
+/*
+	if (EXT_PHY == priv->phy_ext) {
+		for (i = 0; i < POWER_CHAN_NUM; i++) {
+			snprintf(power, 15, "gmac-power%d", i);
+			ret = of_property_read_string(np, power, &gmac_power);
+			if (ret) {
+				priv->gmac_power[i] = NULL;
+				pr_info("gmac-power%d: NULL\n", i);
+				continue;
+			}
+			priv->gmac_power[i] = regulator_get(NULL, gmac_power);
+			if (IS_ERR(priv->gmac_power[i])) {
+				pr_err("gmac-power%d get error!\n", i);
+				ret = -EINVAL;
+				goto clk_err;
+			}
+		}
+	}
+*/
+	/* config other parameters */
+	of_get_phy_mode(np, &(priv->phy_interface));
+	if (priv->phy_interface != PHY_INTERFACE_MODE_MII &&
+	    priv->phy_interface != PHY_INTERFACE_MODE_RGMII &&
+	    priv->phy_interface != PHY_INTERFACE_MODE_RMII) {
+		pr_err("Not support phy type!\n");
+		priv->phy_interface = PHY_INTERFACE_MODE_MII;
+	}
+
+	if (!of_property_read_u32(np, "tx-delay", &value))
+		priv->tx_delay = value;
+
+	if (!of_property_read_u32(np, "rx-delay", &value))
+		priv->rx_delay = value;
+
+	/* config pinctrl */
+/*
+	if (EXT_PHY == priv->phy_ext) {
+		priv->phyrst = of_get_named_gpio_flags(np, "phy-rst", 0, (enum of_gpio_flags *)&cfg);
+		priv->rst_active_low = (cfg.data == OF_GPIO_ACTIVE_LOW) ? 1 : 0;
+
+		if (gpio_is_valid(priv->phyrst)) {
+			if (gpio_request(priv->phyrst, "phy-rst") < 0) {
+				pr_err("gmac gpio request fail!\n");
+				ret = -EINVAL;
+				goto pin_err;
+			}
+		}
+
+		priv->pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+		if (IS_ERR_OR_NULL(priv->pinctrl)) {
+			pr_err("gmac pinctrl error!\n");
+			priv->pinctrl = NULL;
+			ret = -EINVAL;
+			goto pin_err;
+		}
+	}
+*/
+	return 0;
+
+//pin_err:
+/*
+	if (EXT_PHY == priv->phy_ext) {
+		for (i = 0; i < POWER_CHAN_NUM; i++) {
+			if (IS_ERR_OR_NULL(priv->gmac_power[i]))
+				continue;
+			regulator_put(priv->gmac_power[i]);
+		}
+	}
+*/
+//clk_err:
+//	free_irq(ndev->irq, ndev);
+irq_err:
+	devm_iounmap(&pdev->dev, priv->base_phy);
+mem_err:
+	devm_iounmap(&pdev->dev, priv->base);
+
+	return ret;
+}
+
+static void geth_hw_release(struct platform_device *pdev)
+{
+	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct geth_priv *priv = netdev_priv(ndev);
+
+	devm_iounmap(&pdev->dev, (priv->base_phy));
+	devm_iounmap(&pdev->dev, priv->base);
+	free_irq(ndev->irq, ndev);
+/*
+	if (priv->geth_clk)
+		clk_put(priv->geth_clk);
+
+	if (EXT_PHY == priv->phy_ext) {
+		for (i = 0; i < POWER_CHAN_NUM; i++) {
+			if (IS_ERR_OR_NULL(priv->gmac_power[i]))
+				continue;
+			regulator_put(priv->gmac_power[i]);
+		}
+
+		if (!IS_ERR_OR_NULL(priv->pinctrl))
+			devm_pinctrl_put(priv->pinctrl);
+
+		if (gpio_is_valid(priv->phyrst))
+			gpio_free(priv->phyrst);
+	}
+
+	if (!IS_ERR_OR_NULL(priv->ephy_clk))
+		clk_put(priv->ephy_clk);
+*/
+}
+
+/**
+ * geth_probe
+ * @pdev: platform device pointer
+ * Description: the driver is initialized through platform_device.
+ */
+static int geth_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct net_device *ndev = NULL;
+	struct geth_priv *priv;
+
+	pr_info("sunxi gmac driver's version: %s\n", SUNXI_GMAC_VERSION);
+
+#if IS_ENABLED(CONFIG_OF)
+	pdev->dev.dma_mask = &geth_dma_mask;
+	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+#endif
+
+	ndev = alloc_etherdev(sizeof(struct geth_priv));
+	if (!ndev) {
+		dev_err(&pdev->dev, "could not allocate device.\n");
+		return -ENOMEM;
+	}
+	SET_NETDEV_DEV(ndev, &pdev->dev);
+
+	priv = netdev_priv(ndev);
+	platform_set_drvdata(pdev, ndev);
+
+	/* Must set private data to pdev, before call it */
+	ret = geth_hw_init(pdev);
+	if (0 != ret) {
+		pr_err("geth_hw_init fail!\n");
+		goto hw_err;
+	}
+
+	/* setup the netdevice, fill the field of netdevice */
+	ether_setup(ndev);
+	ndev->netdev_ops = &geth_netdev_ops;
+	netdev_set_default_ethtool_ops(ndev, &geth_ethtool_ops);
+	ndev->base_addr = (unsigned long)priv->base;
+
+	priv->ndev = ndev;
+	priv->dev = &pdev->dev;
+
+	/* TODO: support the VLAN frames */
+	ndev->hw_features = NETIF_F_SG | NETIF_F_HIGHDMA | NETIF_F_IP_CSUM |
+				NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM;
+
+	ndev->features |= ndev->hw_features;
+	ndev->hw_features |= NETIF_F_LOOPBACK;
+	ndev->priv_flags |= IFF_UNICAST_FLT;
+
+	ndev->watchdog_timeo = msecs_to_jiffies(watchdog);
+
+	netif_napi_add(ndev, &priv->napi, geth_poll,  BUDGET);
+
+	spin_lock_init(&priv->lock);
+	spin_lock_init(&priv->tx_lock);
+
+	/* The last val is mdc clock ratio */
+	sunxi_geth_register((void *)ndev->base_addr, HW_VERSION, 0x03);
+
+	ret = register_netdev(ndev);
+	if (ret) {
+		netif_napi_del(&priv->napi);
+		pr_err("Error: Register %s failed\n", ndev->name);
+		goto reg_err;
+	}
+
+	/* Before open the device, the mac address should be set */
+	geth_check_addr(ndev, mac_str);
+
+#ifdef CONFIG_GETH_ATTRS
+	geth_create_attrs(ndev);
+#endif
+	device_create_file(&pdev->dev, &dev_attr_gphy_test);
+	device_create_file(&pdev->dev, &dev_attr_mii_reg);
+	device_create_file(&pdev->dev, &dev_attr_loopback_test);
+	device_create_file(&pdev->dev, &dev_attr_extra_tx_stats);
+	device_create_file(&pdev->dev, &dev_attr_extra_rx_stats);
+
+	device_enable_async_suspend(&pdev->dev);
+
+#if IS_ENABLED(CONFIG_PM)
+	INIT_WORK(&priv->eth_work, geth_resume_work);
+#endif
+
+	return 0;
+
+reg_err:
+	geth_hw_release(pdev);
+hw_err:
+	platform_set_drvdata(pdev, NULL);
+	free_netdev(ndev);
+
+	return ret;
+}
+
+static int geth_remove(struct platform_device *pdev)
+{
+	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct geth_priv *priv = netdev_priv(ndev);
+
+	device_remove_file(&pdev->dev, &dev_attr_gphy_test);
+	device_remove_file(&pdev->dev, &dev_attr_mii_reg);
+	device_remove_file(&pdev->dev, &dev_attr_loopback_test);
+	device_remove_file(&pdev->dev, &dev_attr_extra_tx_stats);
+	device_remove_file(&pdev->dev, &dev_attr_extra_rx_stats);
+
+	netif_napi_del(&priv->napi);
+	unregister_netdev(ndev);
+	geth_hw_release(pdev);
+	platform_set_drvdata(pdev, NULL);
+	free_netdev(ndev);
+
+	return 0;
+}
+
+static const struct of_device_id geth_of_match[] = {
+	{.compatible = "allwinner,sunxi-gmac",},
+	{},
+};
+MODULE_DEVICE_TABLE(of, geth_of_match);
+
+static struct platform_driver geth_driver = {
+	.probe	= geth_probe,
+	.remove = geth_remove,
+	.driver = {
+		   .name = "sunxi-gmac",
+		   .owner = THIS_MODULE,
+		   .pm = &geth_pm_ops,
+		   .of_match_table = geth_of_match,
+	},
+};
+module_platform_driver(geth_driver);
+
+#ifdef MODULE
+static int __init set_mac_addr(char *str)
+{
+	char *p = str;
+
+	if (str && strlen(str))
+		memcpy(mac_str, p, 18);
+
+	return 0;
+}
+__setup("mac_addr=", set_mac_addr);
+#endif
+
+MODULE_DESCRIPTION("Allwinner Gigabit Ethernet driver");
+MODULE_AUTHOR("fuzhaoke <fuzhaoke@allwinnertech.com>");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/allwinnertmp/sunxi-gmac.h b/drivers/net/ethernet/allwinnertmp/sunxi-gmac.h
new file mode 100644
index 00000000..ea7a6f15
--- /dev/null
+++ b/drivers/net/ethernet/allwinnertmp/sunxi-gmac.h
@@ -0,0 +1,258 @@
+/*
+ * linux/drivers/net/ethernet/allwinner/sunxi_gmac.h
+ *
+ * Copyright © 2016-2018, fuzhaoke
+ *		Author: fuzhaoke <fuzhaoke@allwinnertech.com>
+ *
+ * This file is provided under a dual BSD/GPL license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ */
+#ifndef __SUNXI_GETH_H__
+#define __SUNXI_GETH_H__
+
+#include <linux/etherdevice.h>
+#include <linux/netdevice.h>
+#include <linux/phy.h>
+#include <linux/module.h>
+#include <linux/init.h>
+
+/* GETH_FRAME_FILTER  register value */
+#define GETH_FRAME_FILTER_PR	0x00000001	/* Promiscuous Mode */
+#define GETH_FRAME_FILTER_HUC	0x00000002	/* Hash Unicast */
+#define GETH_FRAME_FILTER_HMC	0x00000004	/* Hash Multicast */
+#define GETH_FRAME_FILTER_DAIF	0x00000008	/* DA Inverse Filtering */
+#define GETH_FRAME_FILTER_PM	0x00000010	/* Pass all multicast */
+#define GETH_FRAME_FILTER_DBF	0x00000020	/* Disable Broadcast frames */
+#define GETH_FRAME_FILTER_SAIF	0x00000100	/* Inverse Filtering */
+#define GETH_FRAME_FILTER_SAF	0x00000200	/* Source Address Filter */
+#define GETH_FRAME_FILTER_HPF	0x00000400	/* Hash or perfect Filter */
+#define GETH_FRAME_FILTER_RA	0x80000000	/* Receive all mode */
+
+/* Default tx descriptor */
+#define TX_SINGLE_DESC0		0x80000000
+#define TX_SINGLE_DESC1		0x63000000
+
+/* Default rx descriptor */
+#define RX_SINGLE_DESC0		0x80000000
+#define RX_SINGLE_DESC1		0x83000000
+
+typedef union {
+	struct {
+		/* TDES0 */
+		unsigned int deferred:1;	/* Deferred bit (only half-duplex) */
+		unsigned int under_err:1;	/* Underflow error */
+		unsigned int ex_deferral:1;	/* Excessive deferral */
+		unsigned int coll_cnt:4;	/* Collision count */
+		unsigned int vlan_tag:1;	/* VLAN Frame */
+		unsigned int ex_coll:1;		/* Excessive collision */
+		unsigned int late_coll:1;	/* Late collision */
+		unsigned int no_carr:1;		/* No carrier */
+		unsigned int loss_carr:1;	/* Loss of collision */
+		unsigned int ipdat_err:1;	/* IP payload error */
+		unsigned int frm_flu:1;		/* Frame flushed */
+		unsigned int jab_timeout:1;	/* Jabber timeout */
+		unsigned int err_sum:1;		/* Error summary */
+		unsigned int iphead_err:1;	/* IP header error */
+		unsigned int ttss:1;		/* Transmit time stamp status */
+		unsigned int reserved0:13;
+		unsigned int own:1;		/* Own bit. CPU:0, DMA:1 */
+	} tx;
+
+	/* bits 5 7 0 | Frame status
+	 * ----------------------------------------------------------
+	 *      0 0 0 | IEEE 802.3 Type frame (length < 1536 octects)
+	 *      1 0 0 | IPv4/6 No CSUM errorS.
+	 *      1 0 1 | IPv4/6 CSUM PAYLOAD error
+	 *      1 1 0 | IPv4/6 CSUM IP HR error
+	 *      1 1 1 | IPv4/6 IP PAYLOAD AND HEADER errorS
+	 *      0 0 1 | IPv4/6 unsupported IP PAYLOAD
+	 *      0 1 1 | COE bypassed.. no IPv4/6 frame
+	 *      0 1 0 | Reserved.
+	 */
+	struct {
+		/* RDES0 */
+		unsigned int chsum_err:1;	/* Payload checksum error */
+		unsigned int crc_err:1;		/* CRC error */
+		unsigned int dribbling:1;	/* Dribble bit error */
+		unsigned int mii_err:1;		/* Received error (bit3) */
+		unsigned int recv_wt:1;		/* Received watchdog timeout */
+		unsigned int frm_type:1;	/* Frame type */
+		unsigned int late_coll:1;	/* Late Collision */
+		unsigned int ipch_err:1;	/* IPv header checksum error (bit7) */
+		unsigned int last_desc:1;	/* Laset descriptor */
+		unsigned int first_desc:1;	/* First descriptor */
+		unsigned int vlan_tag:1;	/* VLAN Tag */
+		unsigned int over_err:1;	/* Overflow error (bit11) */
+		unsigned int len_err:1;		/* Length error */
+		unsigned int sou_filter:1;	/* Source address filter fail */
+		unsigned int desc_err:1;	/* Descriptor error */
+		unsigned int err_sum:1;		/* Error summary (bit15) */
+		unsigned int frm_len:14;	/* Frame length */
+		unsigned int des_filter:1;	/* Destination address filter fail */
+		unsigned int own:1;		/* Own bit. CPU:0, DMA:1 */
+	#define RX_PKT_OK		0x7FFFB77C
+	#define RX_LEN			0x3FFF0000
+	} rx;
+
+	unsigned int all;
+} desc0_u;
+
+typedef union {
+	struct {
+		/* TDES1 */
+		unsigned int buf1_size:11;	/* Transmit buffer1 size */
+		unsigned int buf2_size:11;	/* Transmit buffer2 size */
+		unsigned int ttse:1;		/* Transmit time stamp enable */
+		unsigned int dis_pad:1;		/* Disable pad (bit23) */
+		unsigned int adr_chain:1;	/* Second address chained */
+		unsigned int end_ring:1;	/* Transmit end of ring */
+		unsigned int crc_dis:1;		/* Disable CRC */
+		unsigned int cic:2;		/* Checksum insertion control (bit27:28) */
+		unsigned int first_sg:1;	/* First Segment */
+		unsigned int last_seg:1;	/* Last Segment */
+		unsigned int interrupt:1;	/* Interrupt on completion */
+	} tx;
+
+	struct {
+		/* RDES1 */
+		unsigned int buf1_size:11;	/* Received buffer1 size */
+		unsigned int buf2_size:11;	/* Received buffer2 size */
+		unsigned int reserved1:2;
+		unsigned int adr_chain:1;	/* Second address chained */
+		unsigned int end_ring:1;		/* Received end of ring */
+		unsigned int reserved2:5;
+		unsigned int dis_ic:1;		/* Disable interrupt on completion */
+	} rx;
+
+	unsigned int all;
+} desc1_u;
+
+typedef struct dma_desc {
+	desc0_u desc0;
+	desc1_u desc1;
+	/* The address of buffers */
+	unsigned int	desc2;
+	/* Next desc's address */
+	unsigned int	desc3;
+} __attribute__((packed)) dma_desc_t;
+
+enum rx_frame_status { /* IPC status */
+	good_frame = 0,
+	discard_frame = 1,
+	csum_none = 2,
+	llc_snap = 4,
+};
+
+enum tx_dma_irq_status {
+	tx_hard_error = 1,
+	tx_hard_error_bump_tc = 2,
+	handle_tx_rx = 3,
+};
+
+struct geth_extra_stats {
+	/* Transmit errors */
+	unsigned long tx_underflow;
+	unsigned long tx_carrier;
+	unsigned long tx_losscarrier;
+	unsigned long vlan_tag;
+	unsigned long tx_deferred;
+	unsigned long tx_vlan;
+	unsigned long tx_jabber;
+	unsigned long tx_frame_flushed;
+	unsigned long tx_payload_error;
+	unsigned long tx_ip_header_error;
+
+	/* Receive errors */
+	unsigned long rx_desc;
+	unsigned long sa_filter_fail;
+	unsigned long overflow_error;
+	unsigned long ipc_csum_error;
+	unsigned long rx_collision;
+	unsigned long rx_crc;
+	unsigned long dribbling_bit;
+	unsigned long rx_length;
+	unsigned long rx_mii;
+	unsigned long rx_multicast;
+	unsigned long rx_gmac_overflow;
+	unsigned long rx_watchdog;
+	unsigned long da_rx_filter_fail;
+	unsigned long sa_rx_filter_fail;
+	unsigned long rx_missed_cntr;
+	unsigned long rx_overflow_cntr;
+	unsigned long rx_vlan;
+
+	/* Tx/Rx IRQ errors */
+	unsigned long tx_undeflow_irq;
+	unsigned long tx_process_stopped_irq;
+	unsigned long tx_jabber_irq;
+	unsigned long rx_overflow_irq;
+	unsigned long rx_buf_unav_irq;
+	unsigned long rx_process_stopped_irq;
+	unsigned long rx_watchdog_irq;
+	unsigned long tx_early_irq;
+	unsigned long fatal_bus_error_irq;
+
+	/* Extra info */
+	unsigned long threshold;
+	unsigned long tx_pkt_n;
+	unsigned long rx_pkt_n;
+	unsigned long poll_n;
+	unsigned long sched_timer_n;
+	unsigned long normal_irq_n;
+};
+
+int sunxi_mdio_read(void *,  int, int);
+int sunxi_mdio_write(void *, int, int, unsigned short);
+int sunxi_mdio_reset(void *);
+void sunxi_set_link_mode(void *iobase, int duplex, int speed);
+void sunxi_int_disable(void *);
+int sunxi_int_status(void *, struct geth_extra_stats *x);
+int sunxi_mac_init(void *, int txmode, int rxmode);
+void sunxi_set_umac(void *, unsigned char *, int);
+void sunxi_mac_enable(void *);
+void sunxi_mac_disable(void *);
+void sunxi_tx_poll(void *);
+void sunxi_int_enable(void *);
+void sunxi_start_rx(void *, unsigned long);
+void sunxi_start_tx(void *, unsigned long);
+void sunxi_stop_tx(void *);
+void sunxi_stop_rx(void *);
+void sunxi_hash_filter(void *iobase, unsigned long low, unsigned long high);
+void sunxi_set_filter(void *iobase, unsigned long flags);
+void sunxi_flow_ctrl(void *iobase, int duplex, int fc, int pause);
+void sunxi_mac_loopback(void *iobase, int enable);
+
+void desc_buf_set(struct dma_desc *p, unsigned long paddr, int size);
+void desc_set_own(struct dma_desc *p);
+void desc_init_chain(struct dma_desc *p, unsigned long paddr,  unsigned int size);
+void desc_tx_close(struct dma_desc *first, struct dma_desc *end, int csum_insert);
+void desc_init(struct dma_desc *p);
+int desc_get_tx_status(struct dma_desc *desc, struct geth_extra_stats *x);
+int desc_buf_get_len(struct dma_desc *desc);
+int desc_buf_get_addr(struct dma_desc *desc);
+int desc_get_rx_status(struct dma_desc *desc, struct geth_extra_stats *x);
+int desc_get_own(struct dma_desc *desc);
+int desc_get_tx_ls(struct dma_desc *desc);
+int desc_rx_frame_len(struct dma_desc *desc);
+
+int sunxi_mac_reset(void *iobase, void (*mdelay)(int), int n);
+int sunxi_geth_register(void *iobase, int version, unsigned int div);
+
+#if IS_ENABLED(CONFIG_SUNXI_EPHY)
+extern int ephy_is_enable(void);
+#endif
+
+#if IS_ENABLED(CONFIG_ARCH_SUN8IW3) \
+	|| IS_ENABLED(CONFIG_ARCH_SUN9IW1) \
+	|| IS_ENABLED(CONFIG_ARCH_SUN7I)
+#define HW_VERSION	0
+#else
+#define HW_VERSION	1
+#endif
+
+#endif
diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 821e85a..3c86c2a 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -338,7 +338,7 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 			"2ns TX delay was already %s (by pin-strapping RXD1 or bootloader configuration)\n",
 			val_txdly ? "enabled" : "disabled");
 	}
-
+return 0;
 	ret = phy_modify_paged_changed(phydev, 0xd08, 0x15, RTL8211F_RX_DELAY,
 				       val_rxdly);
 	if (ret < 0) {
-- 
2.7.4

