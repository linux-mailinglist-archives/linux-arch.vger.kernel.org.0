Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EEB225C4B
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jul 2020 12:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgGTKBI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jul 2020 06:01:08 -0400
Received: from verein.lst.de ([213.95.11.211]:46243 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbgGTKBI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Jul 2020 06:01:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9D7A068BFE; Mon, 20 Jul 2020 12:01:04 +0200 (CEST)
Date:   Mon, 20 Jul 2020 12:01:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/6] syscalls: use uaccess_kernel in
 addr_limit_user_check
Message-ID: <20200720100104.GA20196@lst.de>
References: <20200714105505.935079-1-hch@lst.de> <20200714105505.935079-2-hch@lst.de> <20200718013849.GA157764@roeck-us.net> <20200718094846.GA8593@lst.de> <fe1d4a6d-e32d-6994-a08b-40134000e988@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe1d4a6d-e32d-6994-a08b-40134000e988@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

To try to reproduce your report I built a mps2_defconfig kernel
and then run the qemu command line manually extraced from your
script below, using a mainline qemu built for arm-softmmu, but it
crashes with the following message even for the baseline kernel.

qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)

R00=00000000 R01=00000000 R02=00000000 R03=00000000
R04=00000000 R05=00000000 R06=00000000 R07=00000000
R08=00000000 R09=00000000 R10=00000000 R11=00000000
R12=00000000 R13=ffffffe0 R14=fffffff9 R15=00000000
XPSR=40000003 -Z-- A handler
FPSCR: 00000000

Does anyone have an idea what this means?


---
/opt/qemu/bin/qemu-system-arm \
	-M mps2-an385 \
	-cpu cortex-m3 \
	-dtb arch/arm/boot/dts/mps2-an385.dtb \
	-kernel vmlinux \
	-no-reboot \
        -snapshot -m 16 \
        -initrd ~/images/rootfs-arm-m3.cpio \
        -append 'panic=-1' \
	-bios ~/images/mps2-boot.axf \
	-nographic -monitor null -serial stdio
