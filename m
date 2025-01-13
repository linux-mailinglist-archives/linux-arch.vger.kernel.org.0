Return-Path: <linux-arch+bounces-9734-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1284A0C499
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jan 2025 23:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9310B1882D28
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jan 2025 22:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB6C1F943C;
	Mon, 13 Jan 2025 22:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=o2.pl header.i=@o2.pl header.b="HbE9dRPk"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1811F8EFB
	for <linux-arch@vger.kernel.org>; Mon, 13 Jan 2025 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.222.135.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736807008; cv=none; b=IFFM5IBI8CI03A6fsW7mL+hXhkX1XTDZnvg/Q1xheXUoSjaNSSV6KTNvCG4vZKJ9pJ1/tuvEZ9XB21MOXgPhK3ktkXAF4X4RlQ1eQ7VvVUggSAxrIz1XRFLSOLNhy8ppcHoBecQ5rn761RFmhQNVa3EY2/LF+f4Ihe5KKCFceBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736807008; c=relaxed/simple;
	bh=hryTG4iC6jy+KTUIyVTeZ6i2VoJFQf6juDnitnrA5G8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=t/xrVbIJJG8FRIK7/FflOwE/ib+Pd8Dl65qZEb7sKBlhbF0RLKyFSYwIXFx8tLKQ8z6IkGb3M4G6+g6uAcX5ugk0RS++bMUERqi06uXldNpVBQ0mULyZAReXwPHOtHOMeM6U0kG8aoWUAWsk8rT2cWsBDROAPhA8tYJ6IhxvWWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=o2.pl; spf=pass smtp.mailfrom=o2.pl; dkim=pass (2048-bit key) header.d=o2.pl header.i=@o2.pl header.b=HbE9dRPk; arc=none smtp.client-ip=193.222.135.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=o2.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=o2.pl
Received: (wp-smtpd smtp.tlen.pl 37735 invoked from network); 13 Jan 2025 23:16:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=20241105;
          t=1736806598; bh=euJpLW1zkbk+VbgLUiGx7r4CAGyIyXiDnKb4R+fjfYw=;
          h=From:Subject:To:Cc;
          b=HbE9dRPkzw7zBmE3q6NkS3m0mwwSYDW8/7inMVWTXJfmQvubYld9o8yhoo46uyI3C
           HRmu7LVJucOcNzLcb24Jyd/8rAo112zNduV56cYSuLZ4IqolF23jVIdkBbrhsMqsa4
           PcCFznUMpSFdhg97RYyvpfy+tu/w/wyFGvpdhoJ9Eep1HVavWn/O5mQeJRCRMD/B8Y
           f0+yv7uNn9BM0jN4lkub3T/6jMYvIuOgV3gb0jqtBnMa81BPT+zVcPxQCl4d1qW01b
           FI7w6gFnlR09n44R7lR5yzKqkeo4Jd59jrobQm0uNIYilTBTnOu5EhTO8E1Pdjp0Rf
           JeYFq0srWFOmA==
Received: from apn-78-30-75-199.dynamic.gprs.plus.pl (HELO [192.168.1.22]) (mat.jonczyk@o2.pl@[78.30.75.199])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux-mips@vger.kernel.org>; 13 Jan 2025 23:16:38 +0100
Message-ID: <90b5b76d-25b6-4cdc-91ed-07ac930dc519@o2.pl>
Date: Mon, 13 Jan 2025 23:16:37 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Subject: [REGRESSION] mipsel: no RTC CMOS on the Malta platform in QEMU
To: linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Language: en-GB, pl
Cc: Baoquan He <bhe@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Arnd Bergmann <arnd@arndb.de>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 regressions@lists.linux.dev
Autocrypt: addr=mat.jonczyk@o2.pl; keydata=
 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
 TANkZ3QqXNX2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-WP-MailID: c9664bb3b9bbec77d370e7263eeb3f67
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [wXPk]                               

Hello,

On Linux 6.13-rc6 for mipsel in QEMU on the Malta platform, the RTC CMOS
driver does not load and /sys/class/rtc is empty. I have tested this with
"make malta_defconfig", which compiles this driver into the kernel 
(CONFIG_RTC_DRV_CMOS=y).

I have bisected this down to:

commit 4bfb53e7d317c01f296b2feb2fae7c421c1d52dc
Author: Jiaxun Yang<jiaxun.yang@flygoat.com>
Date:   Thu Sep 21 19:04:22 2023 +0800

     mips: add <asm-generic/io.h> including
     With the adding, some default ioremap_xx methods defined in
     asm-generic/io.h can be used. E.g the default ioremap_uc() returning
     NULL.
     We also massaged various headers to avoid nested includes.

I have tried to debug this.

The fallout is apparently limited to the CMOS RTC driver, other
drivers that access IO ports seem to function correctly (e.g. the
PATA driver). Also, the read_persistent_clock64 function in
arch/mips/mti-malta/malta-time.c, which accesses the same hardware
works correctly.

The CMOS RTC driver is likely special because this device is defined
in a devicetree (arch/mips/boot/dts/mti/malta.dts) and there it is
the only defined device on the ISA bus.

That driver fails to load because the call to

platform_get_resource(pdev, IORESOURCE_IO, 0);

in cmos_platform_probe in drivers/rtc/rtc-cmos.c returns NULL.

The mediator seems to be that this bad commit causes 
arch/mips/include/asm/io.h
to #include <asm-generic/io.h> at the end. As a side effect, this causes
the PCI_IOBASE macro to be defined:

#ifndef PCI_IOBASE
#define PCI_IOBASE ((void __iomem *)0)
#endif

That PCI_IOBASE value above is AFAIK incorrect for MIPS (it should be
defined to mips_io_port_base as far as I can tell), but this does not 
matter much here.

When that macro is defined, pci_address_to_pio() in pci.c calls the
logic_pio_trans_cpuaddr() function, which fails. Removing that ifdef
in this function "fixes" the issue and allows that driver to load and work
apparently correctly:

----------8<------------------
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 661f98c6c63a..368cd9ca6801 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4213,14 +4213,10 @@ EXPORT_SYMBOL_GPL(pci_pio_to_address);
unsigned long __weak pci_address_to_pio(phys_addr_t address)
{
-#ifdef PCI_IOBASE
- return logic_pio_trans_cpuaddr(address);
-#else
if (address > IO_SPACE_LIMIT)
return (unsigned long)-1;
return (unsigned long) address;
-#endif
}
/**
----------8<------------------

Additionally, the following message appears in dmesg on affected kernels:

LOGIC PIO: addr 0x00000070 not registered in io_range_list

(0x0070 is the IO port address of the CMOS RTC).

When I added dump_stack() in logic_pio_trans_cpuaddr(), which prints 
this warning,
I got the following:

----------8<------------------
Call Trace:
[<801185c8>] show_stack+0x38/0x118
[<8010be24>] dump_stack_lvl+0x7c/0xbc
[<80841060>] logic_pio_trans_cpuaddr+0x88/0x98
[<80604bec>] __of_address_to_resource+0x208/0x228
[<805ff45c>] of_device_alloc+0x7c/0x1ac
[<805ff778>] of_platform_device_create_pdata+0x60/0xf8
[<805ff9cc>] of_platform_bus_create+0x1b0/0x238
[<805ffa14>] of_platform_bus_create+0x1f8/0x238
[<805ffbd8>] of_platform_populate+0x80/0xf8
[<80a60008>] of_platform_default_populate_init+0xcc/0xe4
[<8011010c>] do_one_initcall+0x50/0x2b4
[<80a3d0f0>] kernel_init_freeable+0x1f8/0x2a0
[<8086975c>] kernel_init+0x24/0x118
[<801124f8>] ret_from_kernel_thread+0x14/0x1c
----------8<------------------

It appears that some call to logic_pio_register_range() from 
lib/logic_pio.c is missing.
Perhaps the reserve_pio_range() function in arch/mips/loongson64/init.c 
could
be reused, but that's too deep water for me.

Steps to reproduce:

----------8<------------------

wget 
https://ftp.debian.org/debian/dists/Debian12.9/main/installer-mipsel/current/images/malta/netboot/initrd.gz

CROSS_COMPILE=mipsel-linux-gnu- ARCH=mips make malta_defconfig

CROSS_COMPILE=mipsel-linux-gnu- ARCH=mips make -j4

qemu-system-mipsel -machine malta -cpu 24Kf -m 1g -nographic -kernel 
vmlinuz \
        -initrd initrd.gz \
        -append "console=ttyS0 debug ignore_loglevel"

----------8<------------------


Greetings,

Mateusz



