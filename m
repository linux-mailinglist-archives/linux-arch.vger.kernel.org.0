Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA88F5955B4
	for <lists+linux-arch@lfdr.de>; Tue, 16 Aug 2022 10:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiHPI5n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Aug 2022 04:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiHPI5G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Aug 2022 04:57:06 -0400
X-Greylist: delayed 452 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 Aug 2022 00:07:07 PDT
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17C43ED54;
        Tue, 16 Aug 2022 00:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1660633174;
        bh=+uMSy/SoA1MfT4WakY3FJamPrADELYGH3M17SmvsLGY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bW/0KQpn5a1aV23rLhFOWkshDLyLnLPQ7BJ0r7Lwo4atIzRYOFevz1RYo4hv5tUti
         U6atovDlQTOcUx1h4FX+jk6l+7ApiON6KEKoCUO+QKTrAYj9Xxvxb+aZ/0t/q81paU
         PeQVgv/juObay5D1zoyqphpQTf4AmlIc+1sa4SnI=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id F0150667FD;
        Tue, 16 Aug 2022 02:59:31 -0400 (EDT)
Message-ID: <df43f3fc133099d446b422003393814f78ac49c4.camel@xry111.site>
Subject: Re: [PATCH 1/2] LoongArch: Add CPU HWMon platform driver
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-acpi@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Tue, 16 Aug 2022 14:59:30 +0800
In-Reply-To: <20220815124803.3332991-1-chenhuacai@loongson.cn>
References: <20220815124803.3332991-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.45.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

It shows my CPU temperature is floating between 48 and 50 Celsius.=20
Higher than I expected but I guess it's because we've not implemented
CPUFreq yet.

Tested-by: Xi Ruoyao <xry111@xry111.site>

On Mon, 2022-08-15 at 20:48 +0800, Huacai Chen wrote:
> This add CPU HWMon (temperature sensor) platform driver for Loongson-
> 3.
>=20
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> =C2=A0drivers/platform/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> =C2=A0drivers/platform/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/platform/loongarch/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
26 ++++
> =C2=A0drivers/platform/loongarch/Makefile=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
 1 +
> =C2=A0drivers/platform/loongarch/cpu_hwmon.c | 195
> +++++++++++++++++++++++++
> =C2=A05 files changed, 226 insertions(+)
> =C2=A0create mode 100644 drivers/platform/loongarch/Kconfig
> =C2=A0create mode 100644 drivers/platform/loongarch/Makefile
> =C2=A0create mode 100644 drivers/platform/loongarch/cpu_hwmon.c
>=20
> diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
> index b437847b6237..9c68e2def2cb 100644
> --- a/drivers/platform/Kconfig
> +++ b/drivers/platform/Kconfig
> @@ -2,6 +2,9 @@
> =C2=A0if MIPS
> =C2=A0source "drivers/platform/mips/Kconfig"
> =C2=A0endif
> +if LOONGARCH
> +source "drivers/platform/loongarch/Kconfig"
> +endif
> =C2=A0
> =C2=A0source "drivers/platform/goldfish/Kconfig"
> =C2=A0
> diff --git a/drivers/platform/Makefile b/drivers/platform/Makefile
> index 4de08ef4ec9d..41640172975a 100644
> --- a/drivers/platform/Makefile
> +++ b/drivers/platform/Makefile
> @@ -4,6 +4,7 @@
> =C2=A0#
> =C2=A0
> =C2=A0obj-$(CONFIG_X86)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+=3D x86/
> +obj-$(CONFIG_LOONGARCH)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+=3D loongarch/
> =C2=A0obj-$(CONFIG_MELLANOX_PLATFORM)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0+=3D mellanox/
> =C2=A0obj-$(CONFIG_MIPS)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+=3D mips/
> =C2=A0obj-$(CONFIG_OLPC_EC)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0+=3D olpc/
> diff --git a/drivers/platform/loongarch/Kconfig
> b/drivers/platform/loongarch/Kconfig
> new file mode 100644
> index 000000000000..a1542843b0ad
> --- /dev/null
> +++ b/drivers/platform/loongarch/Kconfig
> @@ -0,0 +1,26 @@
> +#
> +# LoongArch Platform Specific Drivers
> +#
> +
> +menuconfig LOONGARCH_PLATFORM_DEVICES
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool "LoongArch Platform Speci=
fic Device Drivers"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default LOONGARCH
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Say Y here to get to se=
e options for device drivers of
> various
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LoongArch platforms, in=
cluding vendor-specific
> laptop/desktop
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extension and hardware =
monitor drivers. This option itself
> does
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 not add any kernel code=
.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If you say N, all optio=
ns in this submenu will be skipped
> and disabled.
> +
> +if LOONGARCH_PLATFORM_DEVICES
> +
> +config CPU_HWMON
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool "Loongson CPU HWMon Drive=
r"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on MACH_LOONGSON64
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select HWMON
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default y
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Loongson-3A/3B/3C CPU H=
WMon (temperature sensor) driver.
> +
> +endif # LOONGARCH_PLATFORM_DEVICES
> diff --git a/drivers/platform/loongarch/Makefile
> b/drivers/platform/loongarch/Makefile
> new file mode 100644
> index 000000000000..8dfd03924c37
> --- /dev/null
> +++ b/drivers/platform/loongarch/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_CPU_HWMON) +=3D cpu_hwmon.o
> diff --git a/drivers/platform/loongarch/cpu_hwmon.c
> b/drivers/platform/loongarch/cpu_hwmon.c
> new file mode 100644
> index 000000000000..3673c850f66c
> --- /dev/null
> +++ b/drivers/platform/loongarch/cpu_hwmon.c
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Loongson Technology Corporation Limited
> + */
> +#include <linux/module.h>
> +#include <linux/reboot.h>
> +#include <linux/jiffies.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +
> +#include <asm/loongson.h>
> +
> +int loongson3_cpu_temp(int cpu)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 reg;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reg =3D iocsr_read32(LOONGARCH=
_IOCSR_CPUTEMP) & 0xff;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return (int)((s8)reg) * 1000;
> +}
> +EXPORT_SYMBOL(loongson3_cpu_temp);
> +
> +static int nr_packages;
> +static struct device *cpu_hwmon_dev;
> +
> +static ssize_t cpu_temp_label(struct device *dev,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct de=
vice_attribute *attr, char *buf)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int id =3D (to_sensor_dev_attr=
(attr))->index - 1;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return sprintf(buf, "CPU %d Te=
mperature\n", id);
> +}
> +
> +static ssize_t get_cpu_temp(struct device *dev,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct de=
vice_attribute *attr, char *buf)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int id =3D (to_sensor_dev_attr=
(attr))->index - 1;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int value =3D loongson3_cpu_te=
mp(id);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return sprintf(buf, "%d\n", va=
lue);
> +}
> +
> +static SENSOR_DEVICE_ATTR(temp1_input, 0444, get_cpu_temp, NULL, 1);
> +static SENSOR_DEVICE_ATTR(temp1_label, 0444, cpu_temp_label, NULL,
> 1);
> +static SENSOR_DEVICE_ATTR(temp2_input, 0444, get_cpu_temp, NULL, 2);
> +static SENSOR_DEVICE_ATTR(temp2_label, 0444, cpu_temp_label, NULL,
> 2);
> +static SENSOR_DEVICE_ATTR(temp3_input, 0444, get_cpu_temp, NULL, 3);
> +static SENSOR_DEVICE_ATTR(temp3_label, 0444, cpu_temp_label, NULL,
> 3);
> +static SENSOR_DEVICE_ATTR(temp4_input, 0444, get_cpu_temp, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp4_label, 0444, cpu_temp_label, NULL,
> 4);
> +static SENSOR_DEVICE_ATTR(temp5_input, 0444, get_cpu_temp, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp5_label, 0444, cpu_temp_label, NULL,
> 4);
> +static SENSOR_DEVICE_ATTR(temp6_input, 0444, get_cpu_temp, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp6_label, 0444, cpu_temp_label, NULL,
> 4);
> +static SENSOR_DEVICE_ATTR(temp7_input, 0444, get_cpu_temp, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp7_label, 0444, cpu_temp_label, NULL,
> 4);
> +static SENSOR_DEVICE_ATTR(temp8_input, 0444, get_cpu_temp, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp8_label, 0444, cpu_temp_label, NULL,
> 4);
> +static SENSOR_DEVICE_ATTR(temp9_input, 0444, get_cpu_temp, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp9_label, 0444, cpu_temp_label, NULL,
> 4);
> +static SENSOR_DEVICE_ATTR(temp10_input, 0444, get_cpu_temp, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp10_label, 0444, cpu_temp_label, NULL,
> 4);
> +static SENSOR_DEVICE_ATTR(temp11_input, 0444, get_cpu_temp, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp11_label, 0444, cpu_temp_label, NULL,
> 4);
> +static SENSOR_DEVICE_ATTR(temp12_input, 0444, get_cpu_temp, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp12_label, 0444, cpu_temp_label, NULL,
> 4);
> +static SENSOR_DEVICE_ATTR(temp13_input, 0444, get_cpu_temp, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp13_label, 0444, cpu_temp_label, NULL,
> 4);
> +static SENSOR_DEVICE_ATTR(temp14_input, 0444, get_cpu_temp, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp14_label, 0444, cpu_temp_label, NULL,
> 4);
> +static SENSOR_DEVICE_ATTR(temp15_input, 0444, get_cpu_temp, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp15_label, 0444, cpu_temp_label, NULL,
> 4);
> +static SENSOR_DEVICE_ATTR(temp16_input, 0444, get_cpu_temp, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp16_label, 0444, cpu_temp_label, NULL,
> 4);
> +
> +static struct attribute *cpu_hwmon_attributes[] =3D {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp1_input.d=
ev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp1_label.d=
ev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp2_input.d=
ev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp2_label.d=
ev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp3_input.d=
ev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp3_label.d=
ev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp4_input.d=
ev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp4_label.d=
ev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp5_input.d=
ev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp5_label.d=
ev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp6_input.d=
ev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp6_label.d=
ev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp7_input.d=
ev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp7_label.d=
ev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp8_input.d=
ev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp8_label.d=
ev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp9_input.d=
ev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp9_label.d=
ev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp10_input.=
dev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp10_label.=
dev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp11_input.=
dev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp11_label.=
dev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp12_input.=
dev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp12_label.=
dev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp13_input.=
dev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp13_label.=
dev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp14_input.=
dev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp14_label.=
dev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp15_input.=
dev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp15_label.=
dev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp16_input.=
dev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sensor_dev_attr_temp16_label.=
dev_attr.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0NULL
> +};
> +static umode_t cpu_hwmon_is_visible(struct kobject *kobj,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct attribute =
*attr, int i)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int id =3D i / 2;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (id < nr_packages)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return attr->mode;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> +}
> +
> +static struct attribute_group cpu_hwmon_group =3D {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.attrs =3D cpu_hwmon_attribute=
s,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.is_visible =3D cpu_hwmon_is_v=
isible,
> +};
> +
> +static const struct attribute_group *cpu_hwmon_groups[] =3D {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&cpu_hwmon_group,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0NULL
> +};
> +
> +static int cpu_initial_threshold =3D 72000;
> +static int cpu_thermal_threshold =3D 96000;
> +module_param(cpu_thermal_threshold, int, 0644);
> +MODULE_PARM_DESC(cpu_thermal_threshold, "cpu thermal threshold (96000
> (default))");
> +
> +static struct delayed_work thermal_work;
> +
> +static void do_thermal_timer(struct work_struct *work)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int i, value, temp_max =3D 0;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (i=3D0; i<nr_packages; i++=
) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0value =3D loongson3_cpu_temp(i);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0if (value > temp_max)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0temp_max =
=3D value;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (temp_max <=3D cpu_thermal_=
threshold)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0schedule_delayed_work(&thermal_work,
> msecs_to_jiffies(5000));
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0orderly_poweroff(true);
> +}
> +
> +static int __init loongson_hwmon_init(void)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int i, value, temp_max =3D 0;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_info("Loongson Hwmon Enter.=
..\n");
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0nr_packages =3D loongson_sysco=
nf.nr_cpus /
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0loongson_sysconf.cores_per_package;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpu_hwmon_dev =3D hwmon_device=
_register_with_groups(NULL,
> "cpu_hwmon",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL,
> cpu_hwmon_groups);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(cpu_hwmon_dev)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0pr_err("hwmon_device_register fail!\n");
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return PTR_ERR(cpu_hwmon_dev);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < nr_packages;=
 i++) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0value =3D loongson3_cpu_temp(i);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0if (value > temp_max)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0temp_max =
=3D value;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_info("Initial CPU temperatu=
re is %d (highest).\n",
> temp_max);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (temp_max > cpu_initial_thr=
eshold)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0cpu_thermal_threshold +=3D temp_max -
> cpu_initial_threshold;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0INIT_DEFERRABLE_WORK(&thermal_=
work, do_thermal_timer);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0schedule_delayed_work(&thermal=
_work, msecs_to_jiffies(20000));
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> +}
> +
> +static void __exit loongson_hwmon_exit(void)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cancel_delayed_work_sync(&ther=
mal_work);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hwmon_device_unregister(cpu_hw=
mon_dev);
> +}
> +
> +module_init(loongson_hwmon_init);
> +module_exit(loongson_hwmon_exit);
> +
> +MODULE_AUTHOR("Huacai Chen <chenhuacai@loongson.cn>");
> +MODULE_DESCRIPTION("Loongson CPU Hwmon driver");
> +MODULE_LICENSE("GPL");

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
