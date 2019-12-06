Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACCA111551B
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2019 17:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfLFQYh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Dec 2019 11:24:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:41970 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726258AbfLFQYh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Dec 2019 11:24:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9D64CB190;
        Fri,  6 Dec 2019 16:24:35 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Thomas Renninger <trenn@suse.de>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org,
        fschnitzlein@suse.de
Subject: [PATCH v5 0/3] sysfs: add sysfs based cpuinfo
Date:   Fri,  6 Dec 2019 17:24:18 +0100
Message-Id: <20191206162421.15050-1-trenn@suse.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I picked up Felix Schnizlein's work from 2017.

It was already reviewed by Greg-KH at this time and even
pushed into linux-next tree, when it came out that the mails
never reached lkml, even the list was added to CC.

ARM people then correctly complained that this needs more review
by ARCH people. It got reverted, Felix had no time anymore and this
nice patcheset was hanging around nowhere...


Changes (by trenn) since v4:
- Do not separate bug and flag list via comma, but by space
- Adjust renamed cpu_data(c).x86_mask to cpu_data(c).x86_stepping
  due to commit b399151cb48db30ad1e0
- Introduce
  config CPUINFO_SYSFS
  and use config HAVE_CPUINFO_SYSFS as a pre-set helper only
- Set CPUINFO_SYSFS
  def_bool y

=============================================

Tested on x86_64 and aarch64 (see below).

Tested on x86_64 (virtual machine):

------------------------------------------------------------

/sys/devices/system/cpu/cpu1/info/:[0]# ls
bogomips  bugs  cpu_family  flags  model  model_name  stepping  vendor_id

for file in *;do echo $file; cat $file;echo;done
bogomips
5187.72

bugs
cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapgs 
itlb_multihit

cpu_family
6

flags
fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 
clflush mmx fxsr sse sse2 ss syscall nx pdpe1gb rdtscp lm constant_tsc 
rep_good nopl xtopology cpuid tsc_known_freq pni pclmulqdq ssse3 fma cx16 pcid 
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
hypervisor lahf_lm abm cpuid_fault invpcid_single pti ssbd ibrs ibpb fsgsbase 
tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt arat umip

model
60

model_name
Intel Core Processor (Haswell, no TSX, IBRS)

stepping
1

vendor_id
GenuineIntel

=============================================

Tested on aarch64:

/sys/devices/system/cpu/cpu1/info/:[0]# ls
architecture  bogomips  flags  implementer  part  revision  variant

------------------------------------------------------------

for file in *;do echo $file; cat $file;echo;done
architecture
8

bogomips
40.00

flags
fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid asimdrdm

implementer
0x51

part
0xc00

revision
1

variant
0x0


Felix Schnizlein (3):
  cpuinfo: add sysfs based arch independent cpuinfo framework
  x86 cpuinfo: implement sysfs nodes for x86
  arm64 cpuinfo: implement sysfs nodes for arm64

 Documentation/ABI/testing/sysfs-devices-system-cpu | 52 ++++++++++++
 arch/Kconfig                                       | 11 +++
 arch/arm64/Kconfig                                 |  1 +
 arch/arm64/kernel/cpuinfo.c                        | 55 ++++++++++++
 arch/x86/Kconfig                                   |  1 +
 arch/x86/kernel/Makefile                           |  2 +
 arch/x86/kernel/cpuinfo.c                          | 99 ++++++++++++++++++++++
 drivers/base/Makefile                              |  1 +
 drivers/base/cpuinfo.c                             | 48 +++++++++++
 include/linux/cpuhotplug.h                         |  1 +
 include/linux/cpuinfo.h                            | 43 ++++++++++
 11 files changed, 314 insertions(+)
 create mode 100644 arch/x86/kernel/cpuinfo.c
 create mode 100644 drivers/base/cpuinfo.c
 create mode 100644 include/linux/cpuinfo.h

-- 
2.16.4

