Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2624032DC75
	for <lists+linux-arch@lfdr.de>; Thu,  4 Mar 2021 22:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240636AbhCDVoF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Mar 2021 16:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240922AbhCDVnm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Mar 2021 16:43:42 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F23EC061762;
        Thu,  4 Mar 2021 13:43:01 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5B5B84270F;
        Thu,  4 Mar 2021 21:42:11 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT PATCH v3 24/27] tty: serial: samsung_tty: Add support for Apple UARTs
Date:   Fri,  5 Mar 2021 06:38:59 +0900
Message-Id: <20210304213902.83903-25-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210304213902.83903-1-marcan@marcan.st>
References: <20210304213902.83903-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Apple SoCs are a distant descendant of Samsung designs and use yet
another variant of their UART style, with different interrupt handling.

In particular, this variant has the following differences with existing
ones:

* It includes a built-in interrupt controller with different registers,
  using only a single platform IRQ

* Internal interrupt sources are treated as edge-triggered, even though
  the IRQ output is level-triggered. This chiefly affects the TX IRQ
  path: the driver can no longer rely on the TX buffer empty IRQ
  immediately firing after TX is enabled, but instead must prime the
  FIFO with data directly.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/tty/serial/Kconfig       |   2 +-
 drivers/tty/serial/samsung_tty.c | 238 +++++++++++++++++++++++++++++--
 include/linux/serial_s3c.h       |  16 +++
 3 files changed, 247 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 0c4cd4a348f4..3ba31ea20d8a 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -236,7 +236,7 @@ config SERIAL_CLPS711X_CONSOLE
 
 config SERIAL_SAMSUNG
 	tristate "Samsung SoC serial support"
-	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
+	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || ARCH_APPLE || COMPILE_TEST
 	select SERIAL_CORE
 	help
 	  Support for the on-chip UARTs on the Samsung S3C24XX series CPUs,
diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 26cb05992e9f..5ef37c4538ce 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -59,6 +59,7 @@
 enum s3c24xx_port_type {
 	TYPE_S3C24XX,
 	TYPE_S3C6400,
+	TYPE_APPLE_S5L,
 };
 
 struct s3c24xx_uart_info {
@@ -151,6 +152,8 @@ struct s3c24xx_uart_port {
 #endif
 };
 
+static void s3c24xx_serial_tx_chars(struct s3c24xx_uart_port *ourport);
+
 /* conversion functions */
 
 #define s3c24xx_dev_to_port(__dev) dev_get_drvdata(__dev)
@@ -290,6 +293,9 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
 	case TYPE_S3C6400:
 		s3c24xx_set_bit(port, S3C64XX_UINTM_TXD, S3C64XX_UINTM);
 		break;
+	case TYPE_APPLE_S5L:
+		s3c24xx_clear_bit(port, APPLE_S5L_UCON_TXTHRESH_ENA, S3C2410_UCON);
+		break;
 	default:
 		disable_irq_nosync(ourport->tx_irq);
 		break;
@@ -358,6 +364,9 @@ static void enable_tx_dma(struct s3c24xx_uart_port *ourport)
 	case TYPE_S3C6400:
 		s3c24xx_set_bit(port, S3C64XX_UINTM_TXD, S3C64XX_UINTM);
 		break;
+	case TYPE_APPLE_S5L:
+		WARN_ON(1); // No DMA
+		break;
 	default:
 		disable_irq_nosync(ourport->tx_irq);
 		break;
@@ -396,12 +405,23 @@ static void enable_tx_pio(struct s3c24xx_uart_port *ourport)
 		s3c24xx_clear_bit(port, S3C64XX_UINTM_TXD,
 				  S3C64XX_UINTM);
 		break;
+	case TYPE_APPLE_S5L:
+		ucon |= APPLE_S5L_UCON_TXTHRESH_ENA_MSK;
+		wr_regl(port, S3C2410_UCON, ucon);
+		break;
 	default:
 		enable_irq(ourport->tx_irq);
 		break;
 	}
 
 	ourport->tx_mode = S3C24XX_TX_PIO;
+
+	/*
+	 * The Apple version only has edge triggered TX IRQs, so we need
+	 * to kick off the process by sending some characters here.
+	 */
+	if (ourport->info->type == TYPE_APPLE_S5L)
+		s3c24xx_serial_tx_chars(ourport);
 }
 
 static void s3c24xx_serial_start_tx_pio(struct s3c24xx_uart_port *ourport)
@@ -527,6 +547,10 @@ static void s3c24xx_serial_stop_rx(struct uart_port *port)
 			s3c24xx_set_bit(port, S3C64XX_UINTM_RXD,
 					S3C64XX_UINTM);
 			break;
+		case TYPE_APPLE_S5L:
+			s3c24xx_clear_bit(port, APPLE_S5L_UCON_RXTHRESH_ENA, S3C2410_UCON);
+			s3c24xx_clear_bit(port, APPLE_S5L_UCON_RXTO_ENA, S3C2410_UCON);
+			break;
 		default:
 			disable_irq_nosync(ourport->rx_irq);
 			break;
@@ -664,14 +688,18 @@ static void enable_rx_pio(struct s3c24xx_uart_port *ourport)
 
 	/* set Rx mode to DMA mode */
 	ucon = rd_regl(port, S3C2410_UCON);
-	ucon &= ~(S3C64XX_UCON_TIMEOUT_MASK |
-			S3C64XX_UCON_EMPTYINT_EN |
-			S3C64XX_UCON_DMASUS_EN |
-			S3C64XX_UCON_TIMEOUT_EN |
-			S3C64XX_UCON_RXMODE_MASK);
-	ucon |= 0xf << S3C64XX_UCON_TIMEOUT_SHIFT |
-			S3C64XX_UCON_TIMEOUT_EN |
-			S3C64XX_UCON_RXMODE_CPU;
+	ucon &= ~S3C64XX_UCON_RXMODE_MASK;
+	ucon |= S3C64XX_UCON_RXMODE_CPU;
+
+	/* Apple types use these bits for IRQ masks */
+	if (ourport->info->type != TYPE_APPLE_S5L) {
+		ucon &= ~(S3C64XX_UCON_TIMEOUT_MASK |
+				S3C64XX_UCON_EMPTYINT_EN |
+				S3C64XX_UCON_DMASUS_EN |
+				S3C64XX_UCON_TIMEOUT_EN);
+		ucon |= 0xf << S3C64XX_UCON_TIMEOUT_SHIFT |
+				S3C64XX_UCON_TIMEOUT_EN;
+	}
 	wr_regl(port, S3C2410_UCON, ucon);
 
 	ourport->rx_mode = S3C24XX_RX_PIO;
@@ -935,6 +963,27 @@ static irqreturn_t s3c64xx_serial_handle_irq(int irq, void *id)
 	return ret;
 }
 
+/* interrupt handler for Apple SoC's.*/
+static irqreturn_t apple_serial_handle_irq(int irq, void *id)
+{
+	struct s3c24xx_uart_port *ourport = id;
+	struct uart_port *port = &ourport->port;
+	unsigned int pend = rd_regl(port, S3C2410_UTRSTAT);
+	irqreturn_t ret = IRQ_NONE;
+
+	if (pend & (APPLE_S5L_UTRSTAT_RXTHRESH | APPLE_S5L_UTRSTAT_RXTO)) {
+		wr_regl(port, S3C2410_UTRSTAT,
+			APPLE_S5L_UTRSTAT_RXTHRESH | APPLE_S5L_UTRSTAT_RXTO);
+		ret = s3c24xx_serial_rx_irq(irq, id);
+	}
+	if (pend & APPLE_S5L_UTRSTAT_TXTHRESH) {
+		wr_regl(port, S3C2410_UTRSTAT, APPLE_S5L_UTRSTAT_TXTHRESH);
+		ret = s3c24xx_serial_tx_irq(irq, id);
+	}
+
+	return ret;
+}
+
 static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
 {
 	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
@@ -1154,6 +1203,32 @@ static void s3c64xx_serial_shutdown(struct uart_port *port)
 	ourport->tx_in_progress = 0;
 }
 
+static void apple_s5l_serial_shutdown(struct uart_port *port)
+{
+	struct s3c24xx_uart_port *ourport = to_ourport(port);
+
+	unsigned int ucon;
+
+	ucon = rd_regl(port, S3C2410_UCON);
+	ucon &= ~(APPLE_S5L_UCON_TXTHRESH_ENA_MSK |
+		  APPLE_S5L_UCON_RXTHRESH_ENA_MSK |
+		  APPLE_S5L_UCON_RXTO_ENA_MSK);
+	wr_regl(port, S3C2410_UCON, ucon);
+
+	wr_regl(port, S3C2410_UTRSTAT, APPLE_S5L_UTRSTAT_ALL_FLAGS);
+
+	free_irq(port->irq, ourport);
+
+	ourport->tx_enabled = 0;
+	ourport->tx_mode = 0;
+	ourport->rx_enabled = 0;
+
+	if (ourport->dma)
+		s3c24xx_serial_release_dma(ourport);
+
+	ourport->tx_in_progress = 0;
+}
+
 static int s3c24xx_serial_startup(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
@@ -1241,6 +1316,45 @@ static int s3c64xx_serial_startup(struct uart_port *port)
 	return ret;
 }
 
+static int apple_s5l_serial_startup(struct uart_port *port)
+{
+	struct s3c24xx_uart_port *ourport = to_ourport(port);
+	unsigned long flags;
+	unsigned int ufcon;
+	int ret;
+
+	wr_regl(port, S3C2410_UTRSTAT, APPLE_S5L_UTRSTAT_ALL_FLAGS);
+
+	ret = request_irq(port->irq, apple_serial_handle_irq, 0,
+			  s3c24xx_serial_portname(port), ourport);
+	if (ret) {
+		dev_err(port->dev, "cannot get irq %d\n", port->irq);
+		return ret;
+	}
+
+	/* For compatibility with s3c24xx Soc's */
+	ourport->rx_enabled = 1;
+	ourport->tx_enabled = 0;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	ufcon = rd_regl(port, S3C2410_UFCON);
+	ufcon |= S3C2410_UFCON_RESETRX | S5PV210_UFCON_RXTRIG8;
+	if (!uart_console(port))
+		ufcon |= S3C2410_UFCON_RESETTX;
+	wr_regl(port, S3C2410_UFCON, ufcon);
+
+	enable_rx_pio(ourport);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	/* Enable Rx Interrupt */
+	s3c24xx_set_bit(port, APPLE_S5L_UCON_RXTHRESH_ENA, S3C2410_UCON);
+	s3c24xx_set_bit(port, APPLE_S5L_UCON_RXTO_ENA, S3C2410_UCON);
+
+	return ret;
+}
+
 /* power power management control */
 
 static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
@@ -1568,6 +1682,8 @@ static const char *s3c24xx_serial_type(struct uart_port *port)
 		return "S3C24XX";
 	case TYPE_S3C6400:
 		return "S3C6400/10";
+	case TYPE_APPLE_S5L:
+		return "APPLE S5L";
 	default:
 		return NULL;
 	}
@@ -1659,6 +1775,27 @@ static const struct uart_ops s3c64xx_serial_ops = {
 #endif
 };
 
+static const struct uart_ops apple_s5l_serial_ops = {
+	.pm		= s3c24xx_serial_pm,
+	.tx_empty	= s3c24xx_serial_tx_empty,
+	.get_mctrl	= s3c24xx_serial_get_mctrl,
+	.set_mctrl	= s3c24xx_serial_set_mctrl,
+	.stop_tx	= s3c24xx_serial_stop_tx,
+	.start_tx	= s3c24xx_serial_start_tx,
+	.stop_rx	= s3c24xx_serial_stop_rx,
+	.break_ctl	= s3c24xx_serial_break_ctl,
+	.startup	= apple_s5l_serial_startup,
+	.shutdown	= apple_s5l_serial_shutdown,
+	.set_termios	= s3c24xx_serial_set_termios,
+	.type		= s3c24xx_serial_type,
+	.config_port	= s3c24xx_serial_config_port,
+	.verify_port	= s3c24xx_serial_verify_port,
+#if defined(CONFIG_SERIAL_SAMSUNG_CONSOLE) && defined(CONFIG_CONSOLE_POLL)
+	.poll_get_char = s3c24xx_serial_get_poll_char,
+	.poll_put_char = s3c24xx_serial_put_poll_char,
+#endif
+};
+
 static struct uart_driver s3c24xx_uart_drv = {
 	.owner		= THIS_MODULE,
 	.driver_name	= "s3c2410_serial",
@@ -1975,6 +2112,18 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 		wr_regl(port, S3C64XX_UINTP, 0xf);
 		wr_regl(port, S3C64XX_UINTSP, 0xf);
 		break;
+	case TYPE_APPLE_S5L: {
+		unsigned int ucon;
+
+		ucon = rd_regl(port, S3C2410_UCON);
+		ucon &= ~(APPLE_S5L_UCON_TXTHRESH_ENA_MSK |
+			APPLE_S5L_UCON_RXTHRESH_ENA_MSK |
+			APPLE_S5L_UCON_RXTO_ENA_MSK);
+		wr_regl(port, S3C2410_UCON, ucon);
+
+		wr_regl(port, S3C2410_UTRSTAT, APPLE_S5L_UTRSTAT_ALL_FLAGS);
+		break;
+	}
 	default:
 		break;
 	}
@@ -2054,6 +2203,9 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 	case TYPE_S3C6400:
 		ourport->port.ops = &s3c64xx_serial_ops;
 		break;
+	case TYPE_APPLE_S5L:
+		ourport->port.ops = &apple_s5l_serial_ops;
+		break;
 	}
 
 	if (np) {
@@ -2196,6 +2348,43 @@ static int s3c24xx_serial_resume_noirq(struct device *dev)
 			clk_disable_unprepare(ourport->clk);
 			break;
 		}
+		case TYPE_APPLE_S5L: {
+			unsigned int ucon;
+			int ret;
+
+			ret = clk_prepare_enable(ourport->clk);
+			if (ret) {
+				dev_err(dev, "clk_enable clk failed: %d\n", ret);
+				return ret;
+			}
+			if (!IS_ERR(ourport->baudclk)) {
+				ret = clk_prepare_enable(ourport->baudclk);
+				if (ret) {
+					dev_err(dev, "clk_enable baudclk failed: %d\n", ret);
+					clk_disable_unprepare(ourport->clk);
+					return ret;
+				}
+			}
+
+			ucon = rd_regl(port, S3C2410_UCON);
+
+			ucon &= ~(APPLE_S5L_UCON_TXTHRESH_ENA_MSK |
+				  APPLE_S5L_UCON_RXTHRESH_ENA_MSK |
+				  APPLE_S5L_UCON_RXTO_ENA_MSK);
+
+			if (ourport->tx_enabled)
+				ucon |= APPLE_S5L_UCON_TXTHRESH_ENA_MSK;
+			if (ourport->rx_enabled)
+				ucon |= APPLE_S5L_UCON_RXTHRESH_ENA_MSK |
+					APPLE_S5L_UCON_RXTO_ENA_MSK;
+
+			wr_regl(port, S3C2410_UCON, ucon);
+
+			if (!IS_ERR(ourport->baudclk))
+				clk_disable_unprepare(ourport->baudclk);
+			clk_disable_unprepare(ourport->clk);
+			break;
+		}
 		default:
 			break;
 		}
@@ -2605,6 +2794,34 @@ static struct s3c24xx_serial_drv_data exynos5433_serial_drv_data = {
 #define EXYNOS5433_SERIAL_DRV_DATA (kernel_ulong_t)NULL
 #endif
 
+#ifdef CONFIG_ARCH_APPLE
+static struct s3c24xx_serial_drv_data s5l_serial_drv_data = {
+	.info = &(struct s3c24xx_uart_info) {
+		.name		= "Apple S5L UART",
+		.type		= TYPE_APPLE_S5L,
+		.port_type	= PORT_8250,
+		.fifosize	= 16,
+		.rx_fifomask	= S3C2410_UFSTAT_RXMASK,
+		.rx_fifoshift	= S3C2410_UFSTAT_RXSHIFT,
+		.rx_fifofull	= S3C2410_UFSTAT_RXFULL,
+		.tx_fifofull	= S3C2410_UFSTAT_TXFULL,
+		.tx_fifomask	= S3C2410_UFSTAT_TXMASK,
+		.tx_fifoshift	= S3C2410_UFSTAT_TXSHIFT,
+		.def_clk_sel	= S3C2410_UCON_CLKSEL0,
+		.num_clks	= 1,
+		.clksel_mask	= 0,
+		.clksel_shift	= 0,
+	},
+	.def_cfg = &(struct s3c2410_uartcfg) {
+		.ucon		= APPLE_S5L_UCON_DEFAULT,
+		.ufcon		= S3C2410_UFCON_DEFAULT,
+	},
+};
+#define S5L_SERIAL_DRV_DATA ((kernel_ulong_t)&s5l_serial_drv_data)
+#else
+#define S5L_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
+#endif
+
 static const struct platform_device_id s3c24xx_serial_driver_ids[] = {
 	{
 		.name		= "s3c2410-uart",
@@ -2627,6 +2844,9 @@ static const struct platform_device_id s3c24xx_serial_driver_ids[] = {
 	}, {
 		.name		= "exynos5433-uart",
 		.driver_data	= EXYNOS5433_SERIAL_DRV_DATA,
+	}, {
+		.name		= "s5l-uart",
+		.driver_data	= S5L_SERIAL_DRV_DATA,
 	},
 	{ },
 };
@@ -2648,6 +2868,8 @@ static const struct of_device_id s3c24xx_uart_dt_match[] = {
 		.data = (void *)EXYNOS4210_SERIAL_DRV_DATA },
 	{ .compatible = "samsung,exynos5433-uart",
 		.data = (void *)EXYNOS5433_SERIAL_DRV_DATA },
+	{ .compatible = "apple,s5l-uart",
+		.data = (void *)S5L_SERIAL_DRV_DATA },
 	{},
 };
 MODULE_DEVICE_TABLE(of, s3c24xx_uart_dt_match);
diff --git a/include/linux/serial_s3c.h b/include/linux/serial_s3c.h
index ca2c5393dc6b..f6c3323fc4c5 100644
--- a/include/linux/serial_s3c.h
+++ b/include/linux/serial_s3c.h
@@ -246,6 +246,22 @@
 				 S5PV210_UFCON_TXTRIG4 |	\
 				 S5PV210_UFCON_RXTRIG4)
 
+#define APPLE_S5L_UCON_RXTO_ENA		9
+#define APPLE_S5L_UCON_RXTHRESH_ENA	12
+#define APPLE_S5L_UCON_TXTHRESH_ENA	13
+#define APPLE_S5L_UCON_RXTO_ENA_MSK	(1 << APPLE_S5L_UCON_RXTO_ENA)
+#define APPLE_S5L_UCON_RXTHRESH_ENA_MSK	(1 << APPLE_S5L_UCON_RXTHRESH_ENA)
+#define APPLE_S5L_UCON_TXTHRESH_ENA_MSK	(1 << APPLE_S5L_UCON_TXTHRESH_ENA)
+
+#define APPLE_S5L_UCON_DEFAULT		(S3C2410_UCON_TXIRQMODE | \
+					 S3C2410_UCON_RXIRQMODE | \
+					 S3C2410_UCON_RXFIFO_TOI)
+
+#define APPLE_S5L_UTRSTAT_RXTHRESH	(1<<4)
+#define APPLE_S5L_UTRSTAT_TXTHRESH	(1<<5)
+#define APPLE_S5L_UTRSTAT_RXTO		(1<<9)
+#define APPLE_S5L_UTRSTAT_ALL_FLAGS	(0x3f0)
+
 #ifndef __ASSEMBLY__
 
 #include <linux/serial_core.h>
-- 
2.30.0

