Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25712503FA
	for <lists+linux-arch@lfdr.de>; Mon, 24 Aug 2020 18:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgHXQy5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 12:54:57 -0400
Received: from mail-dm6nam12on2120.outbound.protection.outlook.com ([40.107.243.120]:2560
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728818AbgHXQrq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 12:47:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIX1ihnvRtWVRY/Tv2+IOoh8aIo99Gr5Z0rS58DmPa+lliAgGmd7zYnXtklD0FIjgoVB28lTuVOYeM1hlkEP3i4qf6lNIcufFYn3C7P/Gno+RxKszpKs3X08lwklP6ie38nobe0lW4e0ezgLr116jCZ7eKN6FThwp0wMUzAejVlGiaLyrJUAqE6GLOrgtMiNFr8Y5k3iJID2qHjEtoL1UGEf9P1vxqhs4re67FbDCxRK5FJeQAOBN+fyJTl5QpQwLh9Z5buRivEABayTbFKl910AIIs5YQNUHjtu3nGegsXo4kEi7WjDEZVIDpky2lZ4BXmg73cZnJpiwxx8V9o9MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGXEsijak9lCyB+9sR6rnOyznDhuYRXlGxLZ27dmKoM=;
 b=AXNeY7wVYfNHpKJDOIaqgirpOVsPO3adQ28i/z6Zy0UmcNO8xHiN4YH0hDdnKErkrL9xNvJhwOdvX1pplheaX7mzJV7QtqRaTpLYB7CQpXKXsY9YJyRKDJrm2sVgCw1109S603gj4qF0PQFBncUoEoB0d3CMZU6UvIaic0ZJVa9wQUgKMFqtXhdHhPzU9l9bOAFlNmy9KnWUiZFTxxkQ/vdPdEmMZ8hFqE6JsA2ZYcP5bpg9W3AZz4CjjqhBhfWXDJLUqqB+tuc5FNKvghUioLWT3SGwaK//Yo7pF9jY05N86dKMlsptV/JJhYYx/quSy1+fr5zvKCnoRW7Xa3Icrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGXEsijak9lCyB+9sR6rnOyznDhuYRXlGxLZ27dmKoM=;
 b=S4vNuxA32f8FuIPFUlQGMl9bTnozIQmOE+0CnP+2DgQv2ubxRreOhDYhHrRXxW2DCoZpeeICH2Kt31ELzO0yNLoa2ZR9K90NSdgH79QzixrSVRdsb2WidQYUabgnF6AzCxtFXEPXRteUWrLYokzd6PSxLjQwuMB2k4uUgbHFCnI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from BN8PR21MB1281.namprd21.prod.outlook.com (2603:10b6:408:a2::19)
 by BN6PR21MB0753.namprd21.prod.outlook.com (2603:10b6:404:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.4; Mon, 24 Aug
 2020 16:47:41 +0000
Received: from BN8PR21MB1281.namprd21.prod.outlook.com
 ([fe80::e0c9:2634:6fb1:5615]) by BN8PR21MB1281.namprd21.prod.outlook.com
 ([fe80::e0c9:2634:6fb1:5615%3]) with mapi id 15.20.3326.012; Mon, 24 Aug 2020
 16:47:41 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, ardb@kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, mark.rutland@arm.com, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arch@vger.kernel.org,
        wei.liu@kernel.org, vkuznets@redhat.com, kys@microsoft.com
Cc:     mikelley@microsoft.com, sunilmut@microsoft.com,
        boqun.feng@gmail.com
Subject: [PATCH v7 00/10] Enable Linux guests on Hyper-V on ARM64
Date:   Mon, 24 Aug 2020 09:46:13 -0700
Message-Id: <1598287583-71762-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: CO2PR04CA0145.namprd04.prod.outlook.com (2603:10b6:104::23)
 To BN8PR21MB1281.namprd21.prod.outlook.com (2603:10b6:408:a2::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by CO2PR04CA0145.namprd04.prod.outlook.com (2603:10b6:104::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Mon, 24 Aug 2020 16:47:39 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [131.107.159.16]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e5182806-76a8-4861-9dab-08d8484d6a6c
X-MS-TrafficTypeDiagnostic: BN6PR21MB0753:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR21MB075373D2109EA71697328B9FD7560@BN6PR21MB0753.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U4pmubZeDor1ltJMbzx6B69wdIaPm85SoYd1DT+8bawv8dk0l4Hu7VG8Ky2xSHIDmgZLc5Dj2smFWy6RvbnMLTT5SICzYgOxgO5ktRPXz/6BP4C6GyKqNtLPevWILE7SXgovtVEdGn9YTF2vc1JW0s/S/Hl8D4Y9uJhYOTXohfpqUVsZxfvj0/wfQ6swxWW4BsRMWq/U71aj1PS4Z2XBGd/vE/8qbEc6NqGll5KUiNb/0mgHsZbohVhOqDcx/VNMRdcZUP/fqrZS7zGvesf5RjnnnRcrFNv5uIJg8AHEGBB2pJjhXDX/xgIOHa3NNIkD3iyF6AVJHEuGZVI2I832Z/NbzJLfA493scpVHMSSO+a3nPLArg5Cx8uoGVH83fZn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1281.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(8676002)(86362001)(2616005)(956004)(2906002)(6486002)(8936002)(52116002)(10290500003)(5660300002)(66946007)(16576012)(66556008)(4326008)(6636002)(316002)(36756003)(186003)(82950400001)(478600001)(26005)(6666004)(66476007)(82960400001)(83380400001)(7416002)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: eyTX/6dcITeKHkVevAsZoGVk39WWSI75qJeGj/S66st+QVd4l+xl99zrcs6bwMrI1qXcZSzlfVL8K7uJtfnufE5f3quEfsHlhqqjLWMDsWVD+skQPBLBqVVKH+8Qh9kCk+lpoSVfuag9NPKBwi8GYmEh9COZMvvICIxZp8aSCxUnDpcxNSDUZk5Hc1pQ7z3+ilXPdO0esYWVoQwTHVpAFqbQgrqo/JoAwfKdrSpVbPL9gPY0/kGGCL0KSLT0mkSJ0r7eeyFSjYyhkcEIZkl9e9+vhnF4RTjO//+UhfqHr7A0xDsYNGwoD7D8+0lOS5oMN50iIfL4KuPq96gootaLxU72L/Be3N2adByM3GHJLCdvf0OC7SMzJ1Zeb6lp52Z8SJtMEtBa2DtmA1qt3n1qLYuBoDR36+spiTLpb/vEuBVogOILcA7EBj8e/BeYoeEnHKlb9mJ6CRjyb4Lufan0euTbOKukF6AzmoJe8xbHT3h2LtlNANJrFBSvEYQkEO5/+ZOEpOvwPjWsd5q02yR65JAIBEFbK6Vp04QrtROBt2I5Zo2Wg5MMlL7GZsHxUrqTTko+ZanHVNd/LFQ5aWxwwJkO77eUFanrMOLWwWNGcZsaKTscYpetN+g9HsNnpi3DMdEKpZMqmszVo+VcoPPkiA==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5182806-76a8-4861-9dab-08d8484d6a6c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR21MB1281.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 16:47:40.9419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2sXxFIHvzWPzVoHDrzvyzDrdqOYyvZLhKSE8qnLvNltaC6A8X2NWvaUeIx1ga5wX/QSpTSTx1ShJOC/25N7PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0753
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This series enables Linux guests running on Hyper-V on ARM64
hardware. New ARM64-specific code in arch/arm64/hyperv initializes
Hyper-V, including its interrupts and hypercall mechanism.
Existing architecture independent drivers for Hyper-V's VMbus and
synthetic devices just work when built for ARM64. Hyper-V code is
built and included in the image and modules only if CONFIG_HYPERV
is enabled.

The ten patches are organized as follows:
1) Add #define for vendor specific owner definition to linux/arm-smccc.h

2) Add include files that define the Hyper-V interface as
   described in the Hyper-V Top Level Functional Spec (TLFS), plus
   additional definitions specific to Linux running on Hyper-V.

3) thru 7) Add core Hyper-V support on ARM64, including hypercalls,
   interrupt handlers, kexec & panic handlers, and core hypervisor
   initialization.

8) Update the existing VMbus driver to generalize interrupt
   management across x86/x64 and ARM64.

9) Export screen_info so it may be used by the Hyper-V frame buffer
   driver built as a module. It is already exported for x86,
   powerpc, and alpha architectures.

10) Make CONFIG_HYPERV selectable on ARM64 in addition to x86/x64.

Some areas of Linux guests on Hyper-V on ARM64 are a work-
in-progress:

* Hyper-V on ARM64 currently runs with a 4 Kbyte page size, but
  allows guests with 16K/64K page size. However, the Linux drivers
  for Hyper-V synthetic devices assume the guest page size is 4K.
  This patch set lays the groundwork for larger guest page sizes,
  but additional patches are coming to update these drivers.

* The Hyper-V vPCI driver at drivers/pci/host/pci-hyperv.c has
  x86/x64-specific code and is not being built for ARM64. Fixing
  this driver to enable vPCI devices on ARM64 will be done later.

In a few cases, terminology from the x86/x64 world has been carried
over into the ARM64 code ("MSR", "TSC").  Hyper-V still uses the
x86/x64 terminology and has not replaced it with something more
generic, so the code uses the Hyper-V terminology.  This will be
fixed when Hyper-V updates the usage in the TLFS.

This patch set is based on the linux-next-20200817 tree (5.9-rc1).

Changes in v7:
* Separately upstreamed split of hyperv-tlfs.h into arch dependent
  and independent sections. In this patch set, update the ARM64
  hyperv-tlfs.h to include architecture independent definitions.
  This approach eliminates a lot of lines of otherwise duplicated
  code on the ARM64 side.
* Break ARM64 mshyperv.h into smaller pieces. Have an initial
  baseline, and add code along with patches for a particular
  functional area. [Marc Zyngier]
* In mshyperv.h, use static inline functions instead of #defines
  where possible. [Arnd Bergmann]
* Use VMbus INTID obtained from ACPI DSDT instead of hardcoding.
  The STIMER INTID is still hardcoded because it is needed
  before Linux has initialized the ACPI subsystem, so it can't
  be obtained from the DSDT.  Wedging it into the GTDT seems
  dubious, so was not done. [Marc Zyngier]
* Update Hyper-V page size allocation functions to use
  alloc_page() if PAGE_SIZE == HV_HYP_PAGE_SIZE [Arnd
  Bergmann]
* Various other minor changes based on feedback and to rebase
  to latest linux-next [Marc Zyngier and Arnd Bergmann]

Changes in v6:
* Use SMCCC hypercall interface instead of direct invocation
  of HVC instruction and the Hyper-V hypercall interface
  [Marc Zyngier]
* Reimplemented functions to alloc/free Hyper-V size pages
  using kmalloc/kfree since kmalloc now guarantees alignment of
  power of 2 size allocations [Marc Zyngier]
* Export screen_info in arm64 architecture so it can be used
  by the Hyper-V buffer driver built as a module
* Renamed source file arch/arm64/hyperv/hv_init.c to hv_core.c
  to better reflect its content
* Fixed the bit position of certain feature flags presented by
  Hyper-V to the guest.  The bit positions on ARM64 don't match
  the position on x86 like originally thought.
* Minor fixups to rebase to 5.6-rc5 linux-next

Changes in v5:
* Minor fixups to rebase to 5.4-rc1 linux-next

Changes in v4:
* Moved clock-related code into an architecture independent
  Hyper-V clocksource driver that is already upstream. Clock
  related code is removed from this patch set except for the
  ARM64 specific interrupt handler. [Marc Zyngier]
* Separately upstreamed the split of mshyperv.h into arch independent
  and arch dependent portions. The arch independent portion has been
  removed from this patch set.
* Divided patch #2 of the series into multiple smaller patches
  [Marc Zyngier]
* Changed a dozen or so smaller things based on feedback
  [Marc Zyngier, Will Deacon]
* Added functions to alloc/free Hyper-V size pages for use by
  drivers for Hyper-V synthetic devices when updated to not assume
  guest page size and Hyper-v page size are the same

Changes in v3:
* Added initialization of hv_vp_index array like was recently
  added on x86 branch [KY Srinivasan]
* Changed Hyper-V ARM64 register symbols to be all uppercase 
  instead of mixed case [KY Srinivasan]
* Separated mshyperv.h into two files, one architecture
  independent and one architecture dependent. After this code
  is upstream, will make changes to the x86 code to use the
  architecture independent file and remove duplication. And
  once we have a multi-architecture Hyper-V TLFS, will do a
  separate patch to split hyperv-tlfs.h in the same way.
  [KY Srinivasan]
* Minor tweaks to rebase to latest linux-next code

Changes in v2:
* Removed patch to implement slow_virt_to_phys() on ARM64.
  Use of slow_virt_to_phys() in arch independent Hyper-V
  drivers has been eliminated by commit 6ba34171bcbd
  ("Drivers: hv: vmbus: Remove use of slow_virt_to_phys()")
* Minor tweaks to rebase to latest linux-next code

---

Michael Kelley (10):
  arm/arm64: smccc-1.1: Add vendor specific owner definition
  arm64: hyperv: Add core Hyper-V include files
  arm64: hyperv: Add hypercall and register access functions
  arm64: hyperv: Add memory alloc/free functions for Hyper-V size pages
  arm64: hyperv: Add interrupt handlers for VMbus and stimer
  arm64: hyperv: Add kexec and panic handlers
  arm64: hyperv: Initialize hypervisor on boot
  Drivers: hv: vmbus: Add hooks for per-CPU IRQ
  arm64: efi: Export screen_info
  Drivers: hv: Enable Hyper-V code to be built on ARM64

 MAINTAINERS                          |   3 +
 arch/arm64/Kbuild                    |   1 +
 arch/arm64/hyperv/Makefile           |   2 +
 arch/arm64/hyperv/hv_core.c          | 437 +++++++++++++++++++++++++++++++++++
 arch/arm64/hyperv/mshyperv.c         | 159 +++++++++++++
 arch/arm64/include/asm/hyperv-tlfs.h |  94 ++++++++
 arch/arm64/include/asm/mshyperv.h    | 165 +++++++++++++
 arch/arm64/kernel/efi.c              |   1 +
 arch/x86/include/asm/mshyperv.h      |   4 +
 drivers/hv/Kconfig                   |   3 +-
 drivers/hv/hv.c                      |   3 +
 include/asm-generic/mshyperv.h       |   5 +
 include/linux/arm-smccc.h            |   1 +
 13 files changed, 877 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/hyperv/Makefile
 create mode 100644 arch/arm64/hyperv/hv_core.c
 create mode 100644 arch/arm64/hyperv/mshyperv.c
 create mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
 create mode 100644 arch/arm64/include/asm/mshyperv.h

-- 
1.8.3.1

