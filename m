Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6F62F817A
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jan 2021 18:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbhAOREi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jan 2021 12:04:38 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11023 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbhAOREi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jan 2021 12:04:38 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DHSDB4JtVzj8G9;
        Sat, 16 Jan 2021 01:02:50 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Sat, 16 Jan 2021 01:03:47 +0800
From:   John Garry <john.garry@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <arnd@arndb.de>,
        <akpm@linux-foundation.org>, <xuwei5@hisilicon.com>,
        <lorenzo.pieralisi@arm.com>, <helgaas@kernel.org>,
        <jiaxun.yang@flygoat.com>, <song.bao.hua@hisilicon.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mips@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@openeuler.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC 0/4] Fix arm64 crash for accessing unmapped IO port regions (reboot)
Date:   Sat, 16 Jan 2021 00:58:45 +0800
Message-ID: <1610729929-188490-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a reboot of my original series to address the problem of drivers
for legacy ISA devices accessing unmapped IO port regions on arm64 systems
and causing the system to crash.

There was another recent report of such an issue [0], and some old ones
[1] and [2] for reference.

The background is that many systems do not include PCI host controllers,
or they do and controller probe may have failed. For these cases, no IO
ports are mapped. However, loading drivers for legacy ISA devices can
crash the system as there is nothing to stop them accessing those IO
ports (which have not been io remap'ed).

My original solution tried to keep the kernel alive in these situations by
rejecting logical PIO access to PCI IO regions until PCI IO port regions
have been mapped.

This series goes one step further, by just reserving the complete legacy
IO port range in 0x0--0xffff for arm64. The motivation for doing this is
to make the request_region() calls for those drivers fail, like this:

root@ubuntu:/home/john# insmod mk712.ko
 [ 3415.575800] mk712: unable to get IO region
insmod: ERROR: could not insert module mk712.ko: No such device

Otherwise, in theory, those drivers could initiate rogue accesses to
mapped IO port regions for other devices and cause corruptions or
side-effects. Indeed, those drivers should not be allowed to access
IO ports at all in such a system.

As a secondary defence, for broken drivers who do not call
request_region(), IO port accesses in range 0--0xffff will be ignored,
again preserving the system.

I am sending as an RFC as I am not sure of any problem with reserving
first 0x10000 of IO space like this. There is reserve= commandline
argument, which does allow this already.

For reference, here's how /proc/ioports looks on my arm64 system with
this change:

root@ubuntu:/home/john# more /proc/ioports
00010000-0001ffff : PCI Bus 0002:f8
  00010000-00010fff : PCI Bus 0002:f9
    00010000-00010007 : 0002:f9:00.0
      00010000-00010007 : serial
    00010008-0001000f : 0002:f9:00.1
      00010008-0001000f : serial
    00010010-00010017 : 0002:f9:00.2
    00010018-0001001f : 0002:f9:00.2
00020000-0002ffff : PCI Bus 0004:88
00030000-0003ffff : PCI Bus 0005:78
00040000-0004ffff : PCI Bus 0006:c0
00050000-0005ffff : PCI Bus 0007:90
00060000-0006ffff : PCI Bus 000a:10
00070000-0007ffff : PCI Bus 000c:20
00080000-0008ffff : PCI Bus 000d:30

[0] https://lore.kernel.org/linux-input/20210112055129.7840-1-song.bao.hua@hisilicon.com/T/#mf86445470160c44ac110e9d200b09245169dc5b6
[1] https://lore.kernel.org/linux-pci/56F209A9.4040304@huawei.com
[2] https://lore.kernel.org/linux-arm-kernel/e6995b4a-184a-d8d4-f4d4-9ce75d8f47c0@huawei.com/

Difference since v4:
https://lore.kernel.org/linux-pci/1560262374-67875-1-git-send-email-john.garry@huawei.com/
- Reserve legacy ISA region

John Garry (4):
  arm64: io: Introduce IO_SPACE_BASE
  asm-generic/io.h: Add IO_SPACE_BASE
  kernel/resource: Make ioport_resource.start configurable
  logic_pio: Warn on and discard accesses to addresses below
    IO_SPACE_BASE

 arch/arm64/include/asm/io.h |  1 +
 include/asm-generic/io.h    |  4 ++++
 include/linux/logic_pio.h   |  5 +++++
 kernel/resource.c           |  2 +-
 lib/logic_pio.c             | 20 ++++++++++++++------
 5 files changed, 25 insertions(+), 7 deletions(-)

-- 
2.26.2

