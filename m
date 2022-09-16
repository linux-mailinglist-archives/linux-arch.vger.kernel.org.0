Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402D25BA9B2
	for <lists+linux-arch@lfdr.de>; Fri, 16 Sep 2022 11:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiIPJyA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Sep 2022 05:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiIPJyA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Sep 2022 05:54:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808613B957;
        Fri, 16 Sep 2022 02:53:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D8D0B824EC;
        Fri, 16 Sep 2022 09:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E51C433D7;
        Fri, 16 Sep 2022 09:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663322035;
        bh=qFPNvyHhB2r/skNQfxfx2JMHndYiHi2MRfUe73aWbiM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RsDD13ai0f1QCnA23L2VDi0Ie696D09vogDcR9mSab0sry4gymw6zHE8J8PQTYSss
         v2yjh1Mwx/1M4Xrx5rT+tLzYWpU/8443c0/JB0qRoWRY5Yp8HqXPIzERt3hBaVEGMd
         u1J9+PScBuBNCVgDP1WRJYUou2DabT8uZpSoYCGQs9SvV9KSmvZhqbPFOMEfd/EMUy
         zRMaPduT9DEx0aDTapi4gMxDJVzFGinj6QRTs6XtgDSDtq3XqQepOl/9yz7KhpzQbZ
         jGQ5txBwPozVbeH8gM8aQ4S52kxDzTZjRSaUZBGUsgkDVKh7mbAdJzXgIWKoh1S5sK
         6egsc52A3o8Mw==
Received: by mail-ua1-f49.google.com with SMTP id a14so7671876uat.13;
        Fri, 16 Sep 2022 02:53:55 -0700 (PDT)
X-Gm-Message-State: ACrzQf3UCTMtXNNVr/UzcRAf+1QDSHVy/dr5nl5MLzdhSYSQluc12Y6i
        ZWg1MyspHxoqGxjvhxt4OsDd1n4k5wvZwAb/SAI=
X-Google-Smtp-Source: AMsMyM5nRkPsAtjryOFzobmnOnzjWzAZpksURPSIuN4BEDidMOSDOxDtOT4oL2oqXqlPu0bnMQFb0VsMeEs33iHi/5c=
X-Received: by 2002:a05:6130:c13:b0:39f:58bb:d51c with SMTP id
 cg19-20020a0561300c1300b0039f58bbd51cmr1613949uab.104.1663322034565; Fri, 16
 Sep 2022 02:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220818040413.2865849-1-chenhuacai@loongson.cn>
In-Reply-To: <20220818040413.2865849-1-chenhuacai@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 16 Sep 2022 17:53:30 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7fiyq7tKJw3CsYDBWjJu89oBJqgNZLxgd+UQE=+X6Czw@mail.gmail.com>
Message-ID: <CAAhV-H7fiyq7tKJw3CsYDBWjJu89oBJqgNZLxgd+UQE=+X6Czw@mail.gmail.com>
Subject: Re: [PATCH] Input: i8042 - Add PNP checking hook for Loongson
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        loongarch@lists.linux.dev, linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Ping?

On Thu, Aug 18, 2022 at 12:04 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> Add PNP checking related functions for Loongson, so that i8042 driver
> can work well under the ACPI firmware with PNP typed keyboard and mouse
> configured in DSDT.
>
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/input/serio/i8042-loongsonio.h | 330 +++++++++++++++++++++++++
>  drivers/input/serio/i8042.h            |   2 +
>  2 files changed, 332 insertions(+)
>  create mode 100644 drivers/input/serio/i8042-loongsonio.h
>
> diff --git a/drivers/input/serio/i8042-loongsonio.h b/drivers/input/serio/i8042-loongsonio.h
> new file mode 100644
> index 000000000000..2ea83b14f13d
> --- /dev/null
> +++ b/drivers/input/serio/i8042-loongsonio.h
> @@ -0,0 +1,330 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * i8042-loongsonio.h
> + *
> + * Copyright (C) 2020 Loongson Technology Corporation Limited
> + * Author: Jianmin Lv <lvjianmin@loongson.cn>
> + *         Huacai Chen <chenhuacai@loongson.cn>
> + */
> +
> +#ifndef _I8042_LOONGSONIO_H
> +#define _I8042_LOONGSONIO_H
> +
> +/*
> + * Names.
> + */
> +
> +#define I8042_KBD_PHYS_DESC "isa0060/serio0"
> +#define I8042_AUX_PHYS_DESC "isa0060/serio1"
> +#define I8042_MUX_PHYS_DESC "isa0060/serio%d"
> +
> +/*
> + * IRQs.
> + */
> +#define I8042_MAP_IRQ(x)       (x)
> +
> +#define I8042_KBD_IRQ  i8042_kbd_irq
> +#define I8042_AUX_IRQ  i8042_aux_irq
> +
> +static int i8042_kbd_irq;
> +static int i8042_aux_irq;
> +
> +/*
> + * Register numbers.
> + */
> +
> +#define I8042_COMMAND_REG      i8042_command_reg
> +#define I8042_STATUS_REG       i8042_command_reg
> +#define I8042_DATA_REG         i8042_data_reg
> +
> +static int i8042_command_reg = 0x64;
> +static int i8042_data_reg = 0x60;
> +
> +
> +static inline int i8042_read_data(void)
> +{
> +       return inb(I8042_DATA_REG);
> +}
> +
> +static inline int i8042_read_status(void)
> +{
> +       return inb(I8042_STATUS_REG);
> +}
> +
> +static inline void i8042_write_data(int val)
> +{
> +       outb(val, I8042_DATA_REG);
> +}
> +
> +static inline void i8042_write_command(int val)
> +{
> +       outb(val, I8042_COMMAND_REG);
> +}
> +
> +#ifdef CONFIG_PNP
> +#include <linux/pnp.h>
> +
> +static bool i8042_pnp_kbd_registered;
> +static unsigned int i8042_pnp_kbd_devices;
> +static bool i8042_pnp_aux_registered;
> +static unsigned int i8042_pnp_aux_devices;
> +
> +static int i8042_pnp_command_reg;
> +static int i8042_pnp_data_reg;
> +static int i8042_pnp_kbd_irq;
> +static int i8042_pnp_aux_irq;
> +
> +static char i8042_pnp_kbd_name[32];
> +static char i8042_pnp_aux_name[32];
> +
> +static void i8042_pnp_id_to_string(struct pnp_id *id, char *dst, int dst_size)
> +{
> +       strlcpy(dst, "PNP:", dst_size);
> +
> +       while (id) {
> +               strlcat(dst, " ", dst_size);
> +               strlcat(dst, id->id, dst_size);
> +               id = id->next;
> +       }
> +}
> +
> +static int i8042_pnp_kbd_probe(struct pnp_dev *dev,
> +               const struct pnp_device_id *did)
> +{
> +       if (pnp_port_valid(dev, 0) && pnp_port_len(dev, 0) == 1)
> +               i8042_pnp_data_reg = pnp_port_start(dev, 0);
> +
> +       if (pnp_port_valid(dev, 1) && pnp_port_len(dev, 1) == 1)
> +               i8042_pnp_command_reg = pnp_port_start(dev, 1);
> +
> +       if (pnp_irq_valid(dev, 0))
> +               i8042_pnp_kbd_irq = pnp_irq(dev, 0);
> +
> +       strlcpy(i8042_pnp_kbd_name, did->id, sizeof(i8042_pnp_kbd_name));
> +       if (strlen(pnp_dev_name(dev))) {
> +               strlcat(i8042_pnp_kbd_name, ":", sizeof(i8042_pnp_kbd_name));
> +               strlcat(i8042_pnp_kbd_name, pnp_dev_name(dev),
> +                               sizeof(i8042_pnp_kbd_name));
> +       }
> +       i8042_pnp_id_to_string(dev->id, i8042_kbd_firmware_id,
> +                              sizeof(i8042_kbd_firmware_id));
> +
> +       /* Keyboard ports are always supposed to be wakeup-enabled */
> +       device_set_wakeup_enable(&dev->dev, true);
> +
> +       i8042_pnp_kbd_devices++;
> +       return 0;
> +}
> +
> +static int i8042_pnp_aux_probe(struct pnp_dev *dev,
> +               const struct pnp_device_id *did)
> +{
> +       if (pnp_port_valid(dev, 0) && pnp_port_len(dev, 0) == 1)
> +               i8042_pnp_data_reg = pnp_port_start(dev, 0);
> +
> +       if (pnp_port_valid(dev, 1) && pnp_port_len(dev, 1) == 1)
> +               i8042_pnp_command_reg = pnp_port_start(dev, 1);
> +
> +       if (pnp_irq_valid(dev, 0))
> +               i8042_pnp_aux_irq = pnp_irq(dev, 0);
> +
> +       strlcpy(i8042_pnp_aux_name, did->id, sizeof(i8042_pnp_aux_name));
> +       if (strlen(pnp_dev_name(dev))) {
> +               strlcat(i8042_pnp_aux_name, ":", sizeof(i8042_pnp_aux_name));
> +               strlcat(i8042_pnp_aux_name, pnp_dev_name(dev),
> +                               sizeof(i8042_pnp_aux_name));
> +       }
> +       i8042_pnp_id_to_string(dev->id, i8042_aux_firmware_id,
> +                              sizeof(i8042_aux_firmware_id));
> +
> +       i8042_pnp_aux_devices++;
> +       return 0;
> +}
> +
> +static const struct pnp_device_id pnp_kbd_devids[] = {
> +       { .id = "PNP0300", .driver_data = 0 },
> +       { .id = "PNP0301", .driver_data = 0 },
> +       { .id = "PNP0302", .driver_data = 0 },
> +       { .id = "PNP0303", .driver_data = 0 },
> +       { .id = "PNP0304", .driver_data = 0 },
> +       { .id = "PNP0305", .driver_data = 0 },
> +       { .id = "PNP0306", .driver_data = 0 },
> +       { .id = "PNP0309", .driver_data = 0 },
> +       { .id = "PNP030a", .driver_data = 0 },
> +       { .id = "PNP030b", .driver_data = 0 },
> +       { .id = "PNP0320", .driver_data = 0 },
> +       { .id = "PNP0343", .driver_data = 0 },
> +       { .id = "PNP0344", .driver_data = 0 },
> +       { .id = "PNP0345", .driver_data = 0 },
> +       { .id = "CPQA0D7", .driver_data = 0 },
> +       { .id = "", },
> +};
> +MODULE_DEVICE_TABLE(pnp, pnp_kbd_devids);
> +
> +static struct pnp_driver i8042_pnp_kbd_driver = {
> +       .name           = "i8042 kbd",
> +       .id_table       = pnp_kbd_devids,
> +       .probe          = i8042_pnp_kbd_probe,
> +       .driver         = {
> +               .probe_type = PROBE_FORCE_SYNCHRONOUS,
> +               .suppress_bind_attrs = true,
> +       },
> +};
> +
> +static const struct pnp_device_id pnp_aux_devids[] = {
> +       { .id = "AUI0200", .driver_data = 0 },
> +       { .id = "FJC6000", .driver_data = 0 },
> +       { .id = "FJC6001", .driver_data = 0 },
> +       { .id = "PNP0f03", .driver_data = 0 },
> +       { .id = "PNP0f0b", .driver_data = 0 },
> +       { .id = "PNP0f0e", .driver_data = 0 },
> +       { .id = "PNP0f12", .driver_data = 0 },
> +       { .id = "PNP0f13", .driver_data = 0 },
> +       { .id = "PNP0f19", .driver_data = 0 },
> +       { .id = "PNP0f1c", .driver_data = 0 },
> +       { .id = "SYN0801", .driver_data = 0 },
> +       { .id = "", },
> +};
> +MODULE_DEVICE_TABLE(pnp, pnp_aux_devids);
> +
> +static struct pnp_driver i8042_pnp_aux_driver = {
> +       .name           = "i8042 aux",
> +       .id_table       = pnp_aux_devids,
> +       .probe          = i8042_pnp_aux_probe,
> +       .driver         = {
> +               .probe_type = PROBE_FORCE_SYNCHRONOUS,
> +               .suppress_bind_attrs = true,
> +       },
> +};
> +
> +static void i8042_pnp_exit(void)
> +{
> +       if (i8042_pnp_kbd_registered) {
> +               i8042_pnp_kbd_registered = false;
> +               pnp_unregister_driver(&i8042_pnp_kbd_driver);
> +       }
> +
> +       if (i8042_pnp_aux_registered) {
> +               i8042_pnp_aux_registered = false;
> +               pnp_unregister_driver(&i8042_pnp_aux_driver);
> +       }
> +}
> +#ifdef CONFIG_ACPI
> +#include <linux/acpi.h>
> +#endif
> +static int __init i8042_pnp_init(void)
> +{
> +       char kbd_irq_str[4] = { 0 }, aux_irq_str[4] = { 0 };
> +       bool pnp_data_busted = false;
> +       int err;
> +
> +       if (i8042_nopnp) {
> +               pr_info("PNP detection disabled\n");
> +               return 0;
> +       }
> +
> +       err = pnp_register_driver(&i8042_pnp_kbd_driver);
> +       if (!err)
> +               i8042_pnp_kbd_registered = true;
> +
> +       err = pnp_register_driver(&i8042_pnp_aux_driver);
> +       if (!err)
> +               i8042_pnp_aux_registered = true;
> +
> +       if (!i8042_pnp_kbd_devices && !i8042_pnp_aux_devices) {
> +               i8042_pnp_exit();
> +               pr_info("PNP: No PS/2 controller found.\n");
> +#ifdef CONFIG_ACPI
> +               if (acpi_disabled == 0)
> +                       return -ENODEV;
> +#endif
> +               pr_info("Probing ports directly.\n");
> +               return 0;
> +       }
> +
> +       if (i8042_pnp_kbd_devices)
> +               snprintf(kbd_irq_str, sizeof(kbd_irq_str),
> +                       "%d", i8042_pnp_kbd_irq);
> +       if (i8042_pnp_aux_devices)
> +               snprintf(aux_irq_str, sizeof(aux_irq_str),
> +                       "%d", i8042_pnp_aux_irq);
> +
> +       pr_info("PNP: PS/2 Controller [%s%s%s] at %#x,%#x irq %s%s%s\n",
> +               i8042_pnp_kbd_name,
> +               (i8042_pnp_kbd_devices && i8042_pnp_aux_devices) ? "," : "",
> +               i8042_pnp_aux_name,
> +               i8042_pnp_data_reg, i8042_pnp_command_reg,
> +               kbd_irq_str,
> +               (i8042_pnp_kbd_devices && i8042_pnp_aux_devices) ? "," : "",
> +               aux_irq_str);
> +
> +       if (((i8042_pnp_data_reg & ~0xf) == (i8042_data_reg & ~0xf) &&
> +             i8042_pnp_data_reg != i8042_data_reg) ||
> +           !i8042_pnp_data_reg) {
> +               pr_warn("PNP: PS/2 controller has invalid data port %#x; using default %#x\n",
> +                       i8042_pnp_data_reg, i8042_data_reg);
> +               i8042_pnp_data_reg = i8042_data_reg;
> +               pnp_data_busted = true;
> +       }
> +
> +       if (((i8042_pnp_command_reg & ~0xf) == (i8042_command_reg & ~0xf) &&
> +             i8042_pnp_command_reg != i8042_command_reg) ||
> +           !i8042_pnp_command_reg) {
> +               pr_warn("PNP: PS/2 controller has invalid command port %#x; using default %#x\n",
> +                       i8042_pnp_command_reg, i8042_command_reg);
> +               i8042_pnp_command_reg = i8042_command_reg;
> +               pnp_data_busted = true;
> +       }
> +
> +       if (!i8042_nokbd && !i8042_pnp_kbd_irq) {
> +               pr_warn("PNP: PS/2 controller doesn't have KBD irq; using default %d\n",
> +                       i8042_kbd_irq);
> +               i8042_pnp_kbd_irq = i8042_kbd_irq;
> +               pnp_data_busted = true;
> +       }
> +
> +       if (!i8042_noaux && !i8042_pnp_aux_irq) {
> +               if (!pnp_data_busted && i8042_pnp_kbd_irq) {
> +                       pr_warn("PNP: PS/2 appears to have AUX port disabled, "
> +                               "if this is incorrect please boot with i8042.nopnp\n");
> +                       i8042_noaux = true;
> +               } else {
> +                       pr_warn("PNP: PS/2 controller doesn't have AUX irq; using default %d\n",
> +                               i8042_aux_irq);
> +                       i8042_pnp_aux_irq = i8042_aux_irq;
> +               }
> +       }
> +
> +       i8042_data_reg = i8042_pnp_data_reg;
> +       i8042_command_reg = i8042_pnp_command_reg;
> +       i8042_kbd_irq = i8042_pnp_kbd_irq;
> +       i8042_aux_irq = i8042_pnp_aux_irq;
> +
> +       return 0;
> +}
> +
> +#else  /* !CONFIG_PNP */
> +static inline int i8042_pnp_init(void) { return 0; }
> +static inline void i8042_pnp_exit(void) { }
> +#endif /* CONFIG_PNP */
> +
> +static int __init i8042_platform_init(void)
> +{
> +       int retval;
> +
> +       i8042_kbd_irq = I8042_MAP_IRQ(1);
> +       i8042_aux_irq = I8042_MAP_IRQ(12);
> +
> +       retval = i8042_pnp_init();
> +       if (retval)
> +               return retval;
> +
> +       return retval;
> +}
> +
> +static inline void i8042_platform_exit(void)
> +{
> +       i8042_pnp_exit();
> +}
> +
> +#endif /* _I8042_LOONGSONIO_H */
> diff --git a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.h
> index 55381783dc82..166bd69841cf 100644
> --- a/drivers/input/serio/i8042.h
> +++ b/drivers/input/serio/i8042.h
> @@ -19,6 +19,8 @@
>  #include "i8042-snirm.h"
>  #elif defined(CONFIG_SPARC)
>  #include "i8042-sparcio.h"
> +#elif defined(CONFIG_MACH_LOONGSON64)
> +#include "i8042-loongsonio.h"
>  #elif defined(CONFIG_X86) || defined(CONFIG_IA64)
>  #include "i8042-x86ia64io.h"
>  #else
> --
> 2.31.1
>
>
