Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893505AB45F
	for <lists+linux-arch@lfdr.de>; Fri,  2 Sep 2022 16:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbiIBO4I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Sep 2022 10:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236621AbiIBOz2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Sep 2022 10:55:28 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E2EE53;
        Fri,  2 Sep 2022 07:20:12 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MJyHc5bSLz9sls;
        Fri,  2 Sep 2022 14:42:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id h2PzkgbLgGpu; Fri,  2 Sep 2022 14:42:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MJyHS1F6Kz9shq;
        Fri,  2 Sep 2022 14:42:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1694F8B764;
        Fri,  2 Sep 2022 14:42:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id EG_IQt1Mx-88; Fri,  2 Sep 2022 14:42:43 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.39])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C72FD8B78B;
        Fri,  2 Sep 2022 14:42:42 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 282CgRcw2141487
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 2 Sep 2022 14:42:27 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 282CgQee2141486;
        Fri, 2 Sep 2022 14:42:26 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Keerthy <j-keerthy@ti.com>, Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Davide Ciminaghi <ciminaghi@gnudd.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, x86@kernel.org,
        Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
Subject: [PATCH v2 1/9] gpio: Remove sta2x11 GPIO driver
Date:   Fri,  2 Sep 2022 14:42:01 +0200
Message-Id: <987511e2d7db3be398cdc7c10f67b61d4d864e5a.1662116601.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1662116601.git.christophe.leroy@csgroup.eu>
References: <cover.1662116601.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1662122526; l=13561; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=iwen9fsMolV+K4U+UH/VORwgRFbgrFmT8ZUSCypQPSc=; b=IWb8j69Dj10bazUuXNusgNQtdN7wi4IryUUntaqlAL/UTR6tvt8Qd2JjIwsBpWWx2qXY+CaN2CWw HHkqSjiHDXJFcZyw5FB10AVtsDR2LU/FDx9BdU9dCx9pz5cJlGqo
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Davide Ciminaghi <ciminaghi@gnudd.com>

The Connext chip has 4 gpio cells looking very similar to those of the
Nomadik, whose gpio/pinctrl driver (already featuring devicetree support)
will be used instead of the sta2x11 specific one.

Signed-off-by: Davide Ciminaghi <ciminaghi@gnudd.com>
Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: New
---
 drivers/gpio/Kconfig        |   8 -
 drivers/gpio/Makefile       |   1 -
 drivers/gpio/gpio-sta2x11.c | 411 ------------------------------------
 3 files changed, 420 deletions(-)
 delete mode 100644 drivers/gpio/gpio-sta2x11.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 0642f579196f..f7f620076b05 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -596,14 +596,6 @@ config GPIO_SPRD
 	help
 	  Say yes here to support Spreadtrum GPIO device.
 
-config GPIO_STA2X11
-	bool "STA2x11/ConneXt GPIO support"
-	depends on MFD_STA2X11
-	select GENERIC_IRQ_CHIP
-	help
-	  Say yes here to support the STA2x11/ConneXt GPIO device.
-	  The GPIO module has 128 GPIO pins with alternate functions.
-
 config GPIO_STP_XWAY
 	bool "XWAY STP GPIOs"
 	depends on SOC_XWAY || COMPILE_TEST
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index a0985d30f51b..3ffd46ae6e02 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -140,7 +140,6 @@ obj-$(CONFIG_GPIO_SL28CPLD)		+= gpio-sl28cpld.o
 obj-$(CONFIG_GPIO_SODAVILLE)		+= gpio-sodaville.o
 obj-$(CONFIG_GPIO_SPEAR_SPICS)		+= gpio-spear-spics.o
 obj-$(CONFIG_GPIO_SPRD)			+= gpio-sprd.o
-obj-$(CONFIG_GPIO_STA2X11)		+= gpio-sta2x11.o
 obj-$(CONFIG_GPIO_STMPE)		+= gpio-stmpe.o
 obj-$(CONFIG_GPIO_STP_XWAY)		+= gpio-stp-xway.o
 obj-$(CONFIG_GPIO_SYSCON)		+= gpio-syscon.o
diff --git a/drivers/gpio/gpio-sta2x11.c b/drivers/gpio/gpio-sta2x11.c
deleted file mode 100644
index e07cca0f8d35..000000000000
--- a/drivers/gpio/gpio-sta2x11.c
+++ /dev/null
@@ -1,411 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * STMicroelectronics ConneXt (STA2X11) GPIO driver
- *
- * Copyright 2012 ST Microelectronics (Alessandro Rubini)
- * Based on gpio-ml-ioh.c, Copyright 2010 OKI Semiconductors Ltd.
- * Also based on previous sta2x11 work, Copyright 2011 Wind River Systems, Inc.
- */
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/gpio/driver.h>
-#include <linux/bitops.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/pci.h>
-#include <linux/platform_device.h>
-#include <linux/mfd/sta2x11-mfd.h>
-
-struct gsta_regs {
-	u32 dat;		/* 0x00 */
-	u32 dats;
-	u32 datc;
-	u32 pdis;
-	u32 dir;		/* 0x10 */
-	u32 dirs;
-	u32 dirc;
-	u32 unused_1c;
-	u32 afsela;		/* 0x20 */
-	u32 unused_24[7];
-	u32 rimsc;		/* 0x40 */
-	u32 fimsc;
-	u32 is;
-	u32 ic;
-};
-
-struct gsta_gpio {
-	spinlock_t			lock;
-	struct device			*dev;
-	void __iomem			*reg_base;
-	struct gsta_regs __iomem	*regs[GSTA_NR_BLOCKS];
-	struct gpio_chip		gpio;
-	int				irq_base;
-	/* FIXME: save the whole config here (AF, ...) */
-	unsigned			irq_type[GSTA_NR_GPIO];
-};
-
-/*
- * gpio methods
- */
-
-static void gsta_gpio_set(struct gpio_chip *gpio, unsigned nr, int val)
-{
-	struct gsta_gpio *chip = gpiochip_get_data(gpio);
-	struct gsta_regs __iomem *regs = chip->regs[nr / GSTA_GPIO_PER_BLOCK];
-	u32 bit = BIT(nr % GSTA_GPIO_PER_BLOCK);
-
-	if (val)
-		writel(bit, &regs->dats);
-	else
-		writel(bit, &regs->datc);
-}
-
-static int gsta_gpio_get(struct gpio_chip *gpio, unsigned nr)
-{
-	struct gsta_gpio *chip = gpiochip_get_data(gpio);
-	struct gsta_regs __iomem *regs = chip->regs[nr / GSTA_GPIO_PER_BLOCK];
-	u32 bit = BIT(nr % GSTA_GPIO_PER_BLOCK);
-
-	return !!(readl(&regs->dat) & bit);
-}
-
-static int gsta_gpio_direction_output(struct gpio_chip *gpio, unsigned nr,
-				      int val)
-{
-	struct gsta_gpio *chip = gpiochip_get_data(gpio);
-	struct gsta_regs __iomem *regs = chip->regs[nr / GSTA_GPIO_PER_BLOCK];
-	u32 bit = BIT(nr % GSTA_GPIO_PER_BLOCK);
-
-	writel(bit, &regs->dirs);
-	/* Data register after direction, otherwise pullup/down is selected */
-	if (val)
-		writel(bit, &regs->dats);
-	else
-		writel(bit, &regs->datc);
-	return 0;
-}
-
-static int gsta_gpio_direction_input(struct gpio_chip *gpio, unsigned nr)
-{
-	struct gsta_gpio *chip = gpiochip_get_data(gpio);
-	struct gsta_regs __iomem *regs = chip->regs[nr / GSTA_GPIO_PER_BLOCK];
-	u32 bit = BIT(nr % GSTA_GPIO_PER_BLOCK);
-
-	writel(bit, &regs->dirc);
-	return 0;
-}
-
-static int gsta_gpio_to_irq(struct gpio_chip *gpio, unsigned offset)
-{
-	struct gsta_gpio *chip = gpiochip_get_data(gpio);
-	return chip->irq_base + offset;
-}
-
-static void gsta_gpio_setup(struct gsta_gpio *chip) /* called from probe */
-{
-	struct gpio_chip *gpio = &chip->gpio;
-
-	/*
-	 * ARCH_NR_GPIOS is currently 256 and dynamic allocation starts
-	 * from the end. However, for compatibility, we need the first
-	 * ConneXt device to start from gpio 0: it's the main chipset
-	 * on most boards so documents and drivers assume gpio0..gpio127
-	 */
-	static int gpio_base;
-
-	gpio->label = dev_name(chip->dev);
-	gpio->owner = THIS_MODULE;
-	gpio->direction_input = gsta_gpio_direction_input;
-	gpio->get = gsta_gpio_get;
-	gpio->direction_output = gsta_gpio_direction_output;
-	gpio->set = gsta_gpio_set;
-	gpio->dbg_show = NULL;
-	gpio->base = gpio_base;
-	gpio->ngpio = GSTA_NR_GPIO;
-	gpio->can_sleep = false;
-	gpio->to_irq = gsta_gpio_to_irq;
-
-	/*
-	 * After the first device, turn to dynamic gpio numbers.
-	 * For example, with ARCH_NR_GPIOS = 256 we can fit two cards
-	 */
-	if (!gpio_base)
-		gpio_base = -1;
-}
-
-/*
- * Special method: alternate functions and pullup/pulldown. This is only
- * invoked on startup to configure gpio's according to platform data.
- * FIXME : this functionality shall be managed (and exported to other drivers)
- * via the pin control subsystem.
- */
-static void gsta_set_config(struct gsta_gpio *chip, int nr, unsigned cfg)
-{
-	struct gsta_regs __iomem *regs = chip->regs[nr / GSTA_GPIO_PER_BLOCK];
-	unsigned long flags;
-	u32 bit = BIT(nr % GSTA_GPIO_PER_BLOCK);
-	u32 val;
-	int err = 0;
-
-	pr_info("%s: %p %i %i\n", __func__, chip, nr, cfg);
-
-	if (cfg == PINMUX_TYPE_NONE)
-		return;
-
-	/* Alternate function or not? */
-	spin_lock_irqsave(&chip->lock, flags);
-	val = readl(&regs->afsela);
-	if (cfg == PINMUX_TYPE_FUNCTION)
-		val |= bit;
-	else
-		val &= ~bit;
-	writel(val | bit, &regs->afsela);
-	if (cfg == PINMUX_TYPE_FUNCTION) {
-		spin_unlock_irqrestore(&chip->lock, flags);
-		return;
-	}
-
-	/* not alternate function: set details */
-	switch (cfg) {
-	case PINMUX_TYPE_OUTPUT_LOW:
-		writel(bit, &regs->dirs);
-		writel(bit, &regs->datc);
-		break;
-	case PINMUX_TYPE_OUTPUT_HIGH:
-		writel(bit, &regs->dirs);
-		writel(bit, &regs->dats);
-		break;
-	case PINMUX_TYPE_INPUT:
-		writel(bit, &regs->dirc);
-		val = readl(&regs->pdis) | bit;
-		writel(val, &regs->pdis);
-		break;
-	case PINMUX_TYPE_INPUT_PULLUP:
-		writel(bit, &regs->dirc);
-		val = readl(&regs->pdis) & ~bit;
-		writel(val, &regs->pdis);
-		writel(bit, &regs->dats);
-		break;
-	case PINMUX_TYPE_INPUT_PULLDOWN:
-		writel(bit, &regs->dirc);
-		val = readl(&regs->pdis) & ~bit;
-		writel(val, &regs->pdis);
-		writel(bit, &regs->datc);
-		break;
-	default:
-		err = 1;
-	}
-	spin_unlock_irqrestore(&chip->lock, flags);
-	if (err)
-		pr_err("%s: chip %p, pin %i, cfg %i is invalid\n",
-		       __func__, chip, nr, cfg);
-}
-
-/*
- * Irq methods
- */
-
-static void gsta_irq_disable(struct irq_data *data)
-{
-	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
-	struct gsta_gpio *chip = gc->private;
-	int nr = data->irq - chip->irq_base;
-	struct gsta_regs __iomem *regs = chip->regs[nr / GSTA_GPIO_PER_BLOCK];
-	u32 bit = BIT(nr % GSTA_GPIO_PER_BLOCK);
-	u32 val;
-	unsigned long flags;
-
-	spin_lock_irqsave(&chip->lock, flags);
-	if (chip->irq_type[nr] & IRQ_TYPE_EDGE_RISING) {
-		val = readl(&regs->rimsc) & ~bit;
-		writel(val, &regs->rimsc);
-	}
-	if (chip->irq_type[nr] & IRQ_TYPE_EDGE_FALLING) {
-		val = readl(&regs->fimsc) & ~bit;
-		writel(val, &regs->fimsc);
-	}
-	spin_unlock_irqrestore(&chip->lock, flags);
-	return;
-}
-
-static void gsta_irq_enable(struct irq_data *data)
-{
-	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
-	struct gsta_gpio *chip = gc->private;
-	int nr = data->irq - chip->irq_base;
-	struct gsta_regs __iomem *regs = chip->regs[nr / GSTA_GPIO_PER_BLOCK];
-	u32 bit = BIT(nr % GSTA_GPIO_PER_BLOCK);
-	u32 val;
-	int type;
-	unsigned long flags;
-
-	type = chip->irq_type[nr];
-
-	spin_lock_irqsave(&chip->lock, flags);
-	val = readl(&regs->rimsc);
-	if (type & IRQ_TYPE_EDGE_RISING)
-		writel(val | bit, &regs->rimsc);
-	else
-		writel(val & ~bit, &regs->rimsc);
-	val = readl(&regs->rimsc);
-	if (type & IRQ_TYPE_EDGE_FALLING)
-		writel(val | bit, &regs->fimsc);
-	else
-		writel(val & ~bit, &regs->fimsc);
-	spin_unlock_irqrestore(&chip->lock, flags);
-	return;
-}
-
-static int gsta_irq_type(struct irq_data *d, unsigned int type)
-{
-	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
-	struct gsta_gpio *chip = gc->private;
-	int nr = d->irq - chip->irq_base;
-
-	/* We only support edge interrupts */
-	if (!(type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING))) {
-		pr_debug("%s: unsupported type 0x%x\n", __func__, type);
-		return -EINVAL;
-	}
-
-	chip->irq_type[nr] = type; /* used for enable/disable */
-
-	gsta_irq_enable(d);
-	return 0;
-}
-
-static irqreturn_t gsta_gpio_handler(int irq, void *dev_id)
-{
-	struct gsta_gpio *chip = dev_id;
-	struct gsta_regs __iomem *regs;
-	u32 is;
-	int i, nr, base;
-	irqreturn_t ret = IRQ_NONE;
-
-	for (i = 0; i < GSTA_NR_BLOCKS; i++) {
-		regs = chip->regs[i];
-		base = chip->irq_base + i * GSTA_GPIO_PER_BLOCK;
-		while ((is = readl(&regs->is))) {
-			nr = __ffs(is);
-			irq = base + nr;
-			generic_handle_irq(irq);
-			writel(1 << nr, &regs->ic);
-			ret = IRQ_HANDLED;
-		}
-	}
-	return ret;
-}
-
-static int gsta_alloc_irq_chip(struct gsta_gpio *chip)
-{
-	struct irq_chip_generic *gc;
-	struct irq_chip_type *ct;
-	int rv;
-
-	gc = devm_irq_alloc_generic_chip(chip->dev, KBUILD_MODNAME, 1,
-					 chip->irq_base,
-					 chip->reg_base, handle_simple_irq);
-	if (!gc)
-		return -ENOMEM;
-
-	gc->private = chip;
-	ct = gc->chip_types;
-
-	ct->chip.irq_set_type = gsta_irq_type;
-	ct->chip.irq_disable = gsta_irq_disable;
-	ct->chip.irq_enable = gsta_irq_enable;
-
-	/* FIXME: this makes at most 32 interrupts. Request 0 by now */
-	rv = devm_irq_setup_generic_chip(chip->dev, gc,
-					 0 /* IRQ_MSK(GSTA_GPIO_PER_BLOCK) */,
-					 0, IRQ_NOREQUEST | IRQ_NOPROBE, 0);
-	if (rv)
-		return rv;
-
-	/* Set up all 128 interrupts: code from setup_generic_chip */
-	{
-		struct irq_chip_type *ct = gc->chip_types;
-		int i, j;
-		for (j = 0; j < GSTA_NR_GPIO; j++) {
-			i = chip->irq_base + j;
-			irq_set_chip_and_handler(i, &ct->chip, ct->handler);
-			irq_set_chip_data(i, gc);
-			irq_clear_status_flags(i, IRQ_NOREQUEST | IRQ_NOPROBE);
-		}
-		gc->irq_cnt = i - gc->irq_base;
-	}
-
-	return 0;
-}
-
-/* The platform device used here is instantiated by the MFD device */
-static int gsta_probe(struct platform_device *dev)
-{
-	int i, err;
-	struct pci_dev *pdev;
-	struct sta2x11_gpio_pdata *gpio_pdata;
-	struct gsta_gpio *chip;
-
-	pdev = *(struct pci_dev **)dev_get_platdata(&dev->dev);
-	gpio_pdata = dev_get_platdata(&pdev->dev);
-
-	if (gpio_pdata == NULL)
-		dev_err(&dev->dev, "no gpio config\n");
-	pr_debug("gpio config: %p\n", gpio_pdata);
-
-	chip = devm_kzalloc(&dev->dev, sizeof(*chip), GFP_KERNEL);
-	if (!chip)
-		return -ENOMEM;
-	chip->dev = &dev->dev;
-	chip->reg_base = devm_platform_ioremap_resource(dev, 0);
-	if (IS_ERR(chip->reg_base))
-		return PTR_ERR(chip->reg_base);
-
-	for (i = 0; i < GSTA_NR_BLOCKS; i++) {
-		chip->regs[i] = chip->reg_base + i * 4096;
-		/* disable all irqs */
-		writel(0, &chip->regs[i]->rimsc);
-		writel(0, &chip->regs[i]->fimsc);
-		writel(~0, &chip->regs[i]->ic);
-	}
-	spin_lock_init(&chip->lock);
-	gsta_gpio_setup(chip);
-	if (gpio_pdata)
-		for (i = 0; i < GSTA_NR_GPIO; i++)
-			gsta_set_config(chip, i, gpio_pdata->pinconfig[i]);
-
-	/* 384 was used in previous code: be compatible for other drivers */
-	err = devm_irq_alloc_descs(&dev->dev, -1, 384,
-				   GSTA_NR_GPIO, NUMA_NO_NODE);
-	if (err < 0) {
-		dev_warn(&dev->dev, "sta2x11 gpio: Can't get irq base (%i)\n",
-			 -err);
-		return err;
-	}
-	chip->irq_base = err;
-
-	err = gsta_alloc_irq_chip(chip);
-	if (err)
-		return err;
-
-	err = devm_request_irq(&dev->dev, pdev->irq, gsta_gpio_handler,
-			       IRQF_SHARED, KBUILD_MODNAME, chip);
-	if (err < 0) {
-		dev_err(&dev->dev, "sta2x11 gpio: Can't request irq (%i)\n",
-			-err);
-		return err;
-	}
-
-	return devm_gpiochip_add_data(&dev->dev, &chip->gpio, chip);
-}
-
-static struct platform_driver sta2x11_gpio_platform_driver = {
-	.driver = {
-		.name	= "sta2x11-gpio",
-		.suppress_bind_attrs = true,
-	},
-	.probe = gsta_probe,
-};
-builtin_platform_driver(sta2x11_gpio_platform_driver);
-- 
2.37.1

