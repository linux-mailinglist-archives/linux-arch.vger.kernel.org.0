Return-Path: <linux-arch+bounces-6380-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0509589CD
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 16:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D241C1C219D9
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 14:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464A5198E96;
	Tue, 20 Aug 2024 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Hq4z+czG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FE1191F96
	for <linux-arch@vger.kernel.org>; Tue, 20 Aug 2024 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164592; cv=none; b=HlvCvg+uRpYP01Ent6/pHTXhUi/XVGp3H2sxQGepJF0Qppiw/fFClicJBP35dQSS7ZYwOnldItYZz2dj/pU7/WKnVahA0dATWpuO04kuzRFzPDmOFDzqCIjwmsPcIMkTqPY0uEdM8Qd0vF3R3ZTAAVo87za3nkEFn+S3zPt8h+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164592; c=relaxed/simple;
	bh=H1rh3I4WvcAdn4G9qoUbVodAgW/yR/vXM1pq7YJTIOo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfNmc4csOfi/o0TXwLce6B1KzonnHjpqZoFCf5ZxBfm5eXTrJ4SxCiklDANQaJh61EqW2hNayxAnv9ykrAjmi4WG5h6I94KYgrS1HhrA+q1pCHnx7S1nY/jWyBllSC/2BHZeDgJOYtb88QATthHAy7QXdobAHJA0CFVSrwJHRJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Hq4z+czG; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a843bef98so624117466b.2
        for <linux-arch@vger.kernel.org>; Tue, 20 Aug 2024 07:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724164584; x=1724769384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7q3PhSwxzFmMAK0cgmdkeN/v66au8FFB5dI6gUE4kzQ=;
        b=Hq4z+czGI6y9wExGlBmeJX1+8/yb3MXNU256CrZ8UCJgUVqJEln8Dzj79n+fmh1bZH
         lYwtr6Dul+/fGR8DZUAzq7k/WwWOzxRF6gXRB25ThoDw5lqI/YY4lcK4lYZV+WAj/IEe
         P8IGD+KgpwTF5YwLLz5Zd6Thg9CQQ0SuCqzjHIhYNLPy48//VWZVHzDQM/5so+iRveJp
         KyYajszqfCZ4AZtJyPmftwcZTU0pdwOkFrjlQ4M6uA4djWsTfXKJILIgTHanufHw7V92
         5ljJhBLhtkDiCuZg/fLtjMl8kCXpAMPIGLlk1rUE7IJ2H7dPhrSz14hLP3kcYP6J+gG5
         zUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724164584; x=1724769384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7q3PhSwxzFmMAK0cgmdkeN/v66au8FFB5dI6gUE4kzQ=;
        b=fmNAcCzsDdxtI4EoATSUXufuk3Qlrc5kvBv8fSJeNfvOs97KA8IP+A6RJ/VC9XzrMa
         1j0LqVi1rXK8UxGAeqZQmL+SWsmdbeNeuPDcx5xbBXjivdEQARioAwb4Nd71JzS4F7S/
         rU/C8QHg83GwQjXGHzy315907WVkZtnR17yr6WA7SXU+Ar2/Y8uNcR3QpcCPWEMyO3XN
         sUnAJecXIGmKkVKo/pbQjiu8ubMFKYEjZk+l6dp1uz3G07RAh++kx8+fPKTTYlvmDWJV
         kH69ji7Wz8CnkQ0PdPXfXvH3+EpxH6XFnMO1pLfpts4CAN+ooRXUnPpiLhXFloV+pO8h
         RkIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj4jUmHeDdExo5dnOrcdoiec5Zrwtx5cALqlZgkaaOoB1dlXfGwSFlh+Ywtn+FG2YpZXlUybFppHpPr6L9ZKwNJtQSG9yilbFzJA==
X-Gm-Message-State: AOJu0YwC03bdl4FM4nRI/tYcsCQoeEbxPiN6HqFY90oYQqcvfOiD3NGY
	2cNilrjDaShF7rNmMFKIcN4f898VZdoyFvPm53ro0SGz0DKBCwmkguMIusA9A0k=
X-Google-Smtp-Source: AGHT+IFWbqMR+9HU0Eeaq+Tp1S9VLHNjRGVyxf/xu9OlgwwfJtOGg4jD6sjdd8BlXUW1zClxwF03pA==
X-Received: by 2002:a17:907:e290:b0:a7d:e98c:5bd1 with SMTP id a640c23a62f3a-a839292fdddmr1047281166b.26.1724164583321;
        Tue, 20 Aug 2024 07:36:23 -0700 (PDT)
Received: from localhost ([87.13.33.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396d380sm767996266b.216.2024.08.20.07.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 07:36:22 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 10/11] net: macb: Add support for RP1's MACB variant
Date: Tue, 20 Aug 2024 16:36:12 +0200
Message-ID: <775000dfb3a35bc691010072942253cb022750e1.1724159867.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724159867.git.andrea.porta@suse.com>
References: <cover.1724159867.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RaspberryPi RP1 contains Cadence's MACB core. Implement the
changes to be able to operate the customization in the RP1.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/net/ethernet/cadence/macb.h      |  25 ++++
 drivers/net/ethernet/cadence/macb_main.c | 152 ++++++++++++++++++++++-
 2 files changed, 175 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index ea71612f6b36..1d298f0cf685 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -85,6 +85,8 @@
 #define GEM_PBUFRXCUT		0x0044 /* RX Partial Store and Forward */
 #define GEM_JML			0x0048 /* Jumbo Max Length */
 #define GEM_HS_MAC_CONFIG	0x0050 /* GEM high speed config */
+#define GEM_AMP			0x0054 /* AXI Max Pipeline */
+#define GEM_INTMOD		0x005c /* Interrupt moderation */
 #define GEM_HRB			0x0080 /* Hash Bottom */
 #define GEM_HRT			0x0084 /* Hash Top */
 #define GEM_SA1B		0x0088 /* Specific1 Bottom */
@@ -347,6 +349,21 @@
 #define GEM_ADDR64_OFFSET	30 /* Address bus width - 64b or 32b */
 #define GEM_ADDR64_SIZE		1
 
+/* Bitfields in AMP */
+#define GEM_AR2R_MAX_PIPE_OFFSET	0  /* Maximum number of outstanding AXI read requests */
+#define GEM_AR2R_MAX_PIPE_SIZE		8
+#define GEM_AW2W_MAX_PIPE_OFFSET	8  /* Maximum number of outstanding AXI write requests */
+#define GEM_AW2W_MAX_PIPE_SIZE		8
+#define GEM_AW2B_FILL_OFFSET		16 /* Select wether the max AW2W transactions operates between: */
+#define GEM_AW2B_FILL_AW2W		0  /*   0: the AW to W AXI channel */
+#define GEM_AW2B_FILL_AW2B		1  /*   1: AW to B channel */
+#define GEM_AW2B_FILL_SIZE              1
+
+/* Bitfields in INTMOD */
+#define GEM_RX_MODERATION_OFFSET	0  /* RX interrupt moderation */
+#define GEM_RX_MODERATION_SIZE		8
+#define GEM_TX_MODERATION_OFFSET	16 /* TX interrupt moderation */
+#define GEM_TX_MODERATION_SIZE		8
 
 /* Bitfields in PBUFRXCUT */
 #define GEM_ENCUTTHRU_OFFSET	31 /* Enable RX partial store and forward */
@@ -812,6 +829,7 @@
 	})
 
 #define MACB_READ_NSR(bp)	macb_readl(bp, NSR)
+#define MACB_READ_TSR(bp)	macb_readl(bp, TSR)
 
 /* struct macb_dma_desc - Hardware DMA descriptor
  * @addr: DMA address of data buffer
@@ -1228,6 +1246,7 @@ struct macb_queue {
 	dma_addr_t		tx_ring_dma;
 	struct work_struct	tx_error_task;
 	bool			txubr_pending;
+	bool			tx_pending;
 	struct napi_struct	napi_tx;
 
 	dma_addr_t		rx_ring_dma;
@@ -1293,9 +1312,15 @@ struct macb {
 
 	u32			caps;
 	unsigned int		dma_burst_length;
+	u8			aw2w_max_pipe;
+	u8			ar2r_max_pipe;
+	bool			use_aw2b_fill;
 
 	phy_interface_t		phy_interface;
 
+	struct gpio_desc	*phy_reset_gpio;
+	int			phy_reset_ms;
+
 	/* AT91RM9200 transmit queue (1 on wire + 1 queued) */
 	struct macb_tx_skb	rm9200_txq[2];
 	unsigned int		max_tx_length;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 11665be3a22c..5eb5be6c96fc 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -41,6 +41,9 @@
 #include <linux/inetdevice.h>
 #include "macb.h"
 
+static unsigned int txdelay = 35;
+module_param(txdelay, uint, 0644);
+
 /* This structure is only used for MACB on SiFive FU540 devices */
 struct sifive_fu540_macb_mgmt {
 	void __iomem *reg;
@@ -334,7 +337,7 @@ static int macb_mdio_wait_for_idle(struct macb *bp)
 	u32 val;
 
 	return readx_poll_timeout(MACB_READ_NSR, bp, val, val & MACB_BIT(IDLE),
-				  1, MACB_MDIO_TIMEOUT);
+				  100, MACB_MDIO_TIMEOUT);
 }
 
 static int macb_mdio_read_c22(struct mii_bus *bus, int mii_id, int regnum)
@@ -493,6 +496,19 @@ static int macb_mdio_write_c45(struct mii_bus *bus, int mii_id,
 	return status;
 }
 
+static int macb_mdio_reset(struct mii_bus *bus)
+{
+	struct macb *bp = bus->priv;
+
+	if (bp->phy_reset_gpio) {
+		gpiod_set_value_cansleep(bp->phy_reset_gpio, 1);
+		msleep(bp->phy_reset_ms);
+		gpiod_set_value_cansleep(bp->phy_reset_gpio, 0);
+	}
+
+	return 0;
+}
+
 static void macb_init_buffers(struct macb *bp)
 {
 	struct macb_queue *queue;
@@ -969,6 +985,7 @@ static int macb_mii_init(struct macb *bp)
 	bp->mii_bus->write = &macb_mdio_write_c22;
 	bp->mii_bus->read_c45 = &macb_mdio_read_c45;
 	bp->mii_bus->write_c45 = &macb_mdio_write_c45;
+	bp->mii_bus->reset = &macb_mdio_reset;
 	snprintf(bp->mii_bus->id, MII_BUS_ID_SIZE, "%s-%x",
 		 bp->pdev->name, bp->pdev->id);
 	bp->mii_bus->priv = bp;
@@ -1640,6 +1657,11 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 
 		macb_init_rx_ring(queue);
 		queue_writel(queue, RBQP, queue->rx_ring_dma);
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+		if (bp->hw_dma_cap & HW_DMA_CAP_64B)
+			macb_writel(bp, RBQPH,
+				    upper_32_bits(queue->rx_ring_dma));
+#endif
 
 		macb_writel(bp, NCR, ctrl | MACB_BIT(RE));
 
@@ -1940,8 +1962,9 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 				queue_writel(queue, ISR, MACB_BIT(TCOMP) |
 							 MACB_BIT(TXUBR));
 
-			if (status & MACB_BIT(TXUBR)) {
+			if (status & MACB_BIT(TXUBR) || queue->tx_pending) {
 				queue->txubr_pending = true;
+				queue->tx_pending = 0;
 				wmb(); // ensure softirq can see update
 			}
 
@@ -2394,6 +2417,11 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	skb_tx_timestamp(skb);
 
 	spin_lock_irq(&bp->lock);
+
+	/* TSTART write might get dropped, so make the IRQ retrigger a buffer read */
+	if (macb_readl(bp, TSR) & MACB_BIT(TGO))
+		queue->tx_pending = 1;
+
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
 	spin_unlock_irq(&bp->lock);
 
@@ -2800,6 +2828,37 @@ static void macb_configure_dma(struct macb *bp)
 	}
 }
 
+static void gem_init_axi(struct macb *bp)
+{
+	u32 amp;
+
+	/* AXI pipeline setup - don't touch values unless specified in device
+	 * tree. Some hardware could have reset values > 1.
+	 */
+	amp = gem_readl(bp, AMP);
+
+	if (bp->use_aw2b_fill)
+		amp = GEM_BFINS(AW2B_FILL, bp->use_aw2b_fill, amp);
+	if (bp->aw2w_max_pipe)
+		amp = GEM_BFINS(AW2W_MAX_PIPE, bp->aw2w_max_pipe, amp);
+	if (bp->ar2r_max_pipe)
+		amp = GEM_BFINS(AR2R_MAX_PIPE, bp->ar2r_max_pipe, amp);
+
+	gem_writel(bp, AMP, amp);
+}
+
+static void gem_init_intmod(struct macb *bp)
+{
+	unsigned int throttle;
+	u32 intmod = 0;
+
+	/* Use sensible interrupt moderation thresholds (50us rx and tx) */
+	throttle = (1000 * 50) / 800;
+	intmod = GEM_BFINS(TX_MODERATION, throttle, intmod);
+	intmod = GEM_BFINS(RX_MODERATION, throttle, intmod);
+	gem_writel(bp, INTMOD, intmod);
+}
+
 static void macb_init_hw(struct macb *bp)
 {
 	u32 config;
@@ -2828,6 +2887,11 @@ static void macb_init_hw(struct macb *bp)
 	if (bp->caps & MACB_CAPS_JUMBO)
 		bp->rx_frm_len_mask = MACB_RX_JFRMLEN_MASK;
 
+	if (macb_is_gem(bp)) {
+		gem_init_axi(bp);
+		gem_init_intmod(bp);
+	}
+
 	macb_configure_dma(bp);
 
 	/* Enable RX partial store and forward and set watermark */
@@ -3189,6 +3253,52 @@ static void gem_get_ethtool_strings(struct net_device *dev, u32 sset, u8 *p)
 	}
 }
 
+static int gem_set_coalesce(struct net_device *dev,
+			    struct ethtool_coalesce *ec,
+			    struct kernel_ethtool_coalesce *kernel_coal,
+			    struct netlink_ext_ack *extack)
+{
+	struct macb *bp = netdev_priv(dev);
+	unsigned int tx_throttle;
+	unsigned int rx_throttle;
+	u32 intmod = 0;
+
+	/* GEM has simple IRQ throttling support. RX and TX interrupts
+	 * are separately moderated on 800ns quantums, with no support
+	 * for frame coalescing.
+	 */
+
+	/* Max is 255 * 0.8us = 204us. Zero implies no moderation. */
+	if (ec->rx_coalesce_usecs > 204 || ec->tx_coalesce_usecs > 204)
+		return -EINVAL;
+
+	tx_throttle = (1000 * ec->tx_coalesce_usecs) / 800;
+	rx_throttle = (1000 * ec->rx_coalesce_usecs) / 800;
+
+	intmod = GEM_BFINS(TX_MODERATION, tx_throttle, intmod);
+	intmod = GEM_BFINS(RX_MODERATION, rx_throttle, intmod);
+
+	gem_writel(bp, INTMOD, intmod);
+
+	return 0;
+}
+
+static int gem_get_coalesce(struct net_device *dev,
+			    struct ethtool_coalesce *ec,
+			    struct kernel_ethtool_coalesce *kernel_coal,
+			    struct netlink_ext_ack *extack)
+{
+	struct macb *bp = netdev_priv(dev);
+	u32 intmod;
+
+	intmod = gem_readl(bp, INTMOD);
+
+	ec->tx_coalesce_usecs = (GEM_BFEXT(TX_MODERATION, intmod) * 800) / 1000;
+	ec->rx_coalesce_usecs = (GEM_BFEXT(RX_MODERATION, intmod) * 800) / 1000;
+
+	return 0;
+}
+
 static struct net_device_stats *macb_get_stats(struct net_device *dev)
 {
 	struct macb *bp = netdev_priv(dev);
@@ -3772,6 +3882,8 @@ static const struct ethtool_ops macb_ethtool_ops = {
 };
 
 static const struct ethtool_ops gem_ethtool_ops = {
+	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS |
+				     ETHTOOL_COALESCE_TX_USECS,
 	.get_regs_len		= macb_get_regs_len,
 	.get_regs		= macb_get_regs,
 	.get_wol		= macb_get_wol,
@@ -3781,6 +3893,8 @@ static const struct ethtool_ops gem_ethtool_ops = {
 	.get_ethtool_stats	= gem_get_ethtool_stats,
 	.get_strings		= gem_get_ethtool_strings,
 	.get_sset_count		= gem_get_sset_count,
+	.get_coalesce		= gem_get_coalesce,
+	.set_coalesce		= gem_set_coalesce,
 	.get_link_ksettings     = macb_get_link_ksettings,
 	.set_link_ksettings     = macb_set_link_ksettings,
 	.get_ringparam		= macb_get_ringparam,
@@ -5100,6 +5214,11 @@ static int macb_probe(struct platform_device *pdev)
 			}
 		}
 	}
+
+	device_property_read_u8(&pdev->dev, "cdns,aw2w-max-pipe", &bp->aw2w_max_pipe);
+	device_property_read_u8(&pdev->dev, "cdns,ar2r-max-pipe", &bp->ar2r_max_pipe);
+	bp->use_aw2b_fill = device_property_read_bool(&pdev->dev, "cdns,use-aw2b-fill");
+
 	spin_lock_init(&bp->lock);
 
 	/* setup capabilities */
@@ -5155,6 +5274,21 @@ static int macb_probe(struct platform_device *pdev)
 	else
 		bp->phy_interface = interface;
 
+	/* optional PHY reset-related properties */
+	bp->phy_reset_gpio = devm_gpiod_get_optional(&pdev->dev, "phy-reset",
+						     GPIOD_OUT_LOW);
+	if (IS_ERR(bp->phy_reset_gpio)) {
+		dev_err(&pdev->dev, "Failed to obtain phy-reset gpio\n");
+		err = PTR_ERR(bp->phy_reset_gpio);
+		goto err_out_free_netdev;
+	}
+
+	bp->phy_reset_ms = 10;
+	of_property_read_u32(np, "phy-reset-duration", &bp->phy_reset_ms);
+	/* A sane reset duration should not be longer than 1s */
+	if (bp->phy_reset_ms > 1000)
+		bp->phy_reset_ms = 1000;
+
 	/* IP specific init */
 	err = init(pdev);
 	if (err)
@@ -5229,6 +5363,19 @@ static void macb_remove(struct platform_device *pdev)
 	}
 }
 
+static void macb_shutdown(struct platform_device *pdev)
+{
+	struct net_device *dev;
+
+	dev = platform_get_drvdata(pdev);
+
+	rtnl_lock();
+	netif_device_detach(dev);
+	if (netif_running(dev))
+		dev_close(dev);
+	rtnl_unlock();
+}
+
 static int __maybe_unused macb_suspend(struct device *dev)
 {
 	struct net_device *netdev = dev_get_drvdata(dev);
@@ -5482,6 +5629,7 @@ static const struct dev_pm_ops macb_pm_ops = {
 static struct platform_driver macb_driver = {
 	.probe		= macb_probe,
 	.remove_new	= macb_remove,
+	.shutdown	= macb_shutdown,
 	.driver		= {
 		.name		= "macb",
 		.of_match_table	= of_match_ptr(macb_dt_ids),
-- 
2.35.3


