Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DDC7B3960
	for <lists+linux-arch@lfdr.de>; Fri, 29 Sep 2023 20:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbjI2SCK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Sep 2023 14:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbjI2SCF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Sep 2023 14:02:05 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 704BF1BB;
        Fri, 29 Sep 2023 11:01:57 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 42A3020B74C0;
        Fri, 29 Sep 2023 11:01:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 42A3020B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1696010516;
        bh=KWWgT6NBlRzrvKSS4wBxf3e5eXGI9LeLYDKcIID6Smo=;
        h=From:To:Cc:Subject:Date:From;
        b=V7vxnxOff+Wus8xWCTpEx8oy+767yhDRKctdP5oMc8kWGqdceloYS3fw/zDzqBrjW
         lbUH2DC2IqF3Lky3Q2LTr8OZ50SiOJRpuCTodTfMpLKDdDhgeRYKI0PRcNTEAS4hJI
         do/JQljATfzZDQg+onoQ3XrZWvlmM6jNGkpySGS8=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Cc:     patches@lists.linux.dev, mikelley@microsoft.com, kys@microsoft.com,
        wei.liu@kernel.org, gregkh@linuxfoundation.org,
        haiyangz@microsoft.com, decui@microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
Subject: [PATCH v4 00/15] Introduce /dev/mshv drivers
Date:   Fri, 29 Sep 2023 11:01:26 -0700
Message-Id: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-15.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URI_TRY_3LD,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This series introduces support for creating and running guest machines
while running on the Microsoft Hypervisor. [0]
This is done via an IOCTL interface accessed through /dev/mshv, similar to
/dev/kvm. Another series introducing this support was previously posted.
[1]

These interfaces support VMMs running in:
1. The root patition - provided in the mshv_root module, and
2. VTL 2 - provided in the mshv_vtl module [2]

Patches breakdown
-----------------
The first 7 patches are refactoring and adding some helper functions.
They provide some benefit on their own and could be applied independently
as cleanup patches.

Patches 8-12 just set things up for the driver code to come. These are very
small. They come first so that the remaining patches are more self-contained.

The final 3 patches are the meat of the series:
- Patch 13 contains new header files used by the driver.
  These are designed to mirror the ABI headers exported by Hyper-V. This is
  done to avoid polluting hyperv-tlfs.h and help track changes to the ABIs
  that are still unstable. (See FAQ below).
- Patch 14 conditionally includes these new header files into mshyperv.h
  and linux/hyperv.h, in order to be able to use these files in the new
  drivers while remaining independent from hyperv-tlfs.h.
- Patch 15 contains the new driver code located in drivers/hv. This is a
  large amount of code and new files, but it is mostly self-contained and
  all within drivers/hv - apart from the IOCTL interface itself in uapi.

Patch 15 is rather big and has bounced back from some mailing lists. If you
did not get a copy in your inbox, you can view it here instead:
https://github.com/NunoDasNeves/linux/commit/3974fa9e586daf4be2580ca94d49c20a1f3f9b98

FAQ on include/uapi/hyperv/*.h
------------------------------
Q:
Why not just add these definitions to hyperv-tlfs.h?
A:
The intention of hyperv-tlfs.h is to contain stable definitions documented
in the public TLFS document. These new definitions don't fit that criteria,
so they should be separate.

Q:
The new headers redefine many things that are already in hyperv-tlfs.h - why?
A:
Some definitions are extended compared to what is documented in the TLFS.
In order to avoid adding undocumented or unstable definitions to hyperv-tlfs.h,
the new headers must compile independently.
Therefore, the new headers must redefine many things in hyperv-tlfs.h in order
to compile.

Q:
Why are these files named hvgdk.h, hvgdk_mini.h, hvhdk.h and hvhdk_mini.h?
A:
The precise meaning of the names reflects conventions used internally at
Microsoft.
Naming them this way makes it easy to find where particular Hyper-V
definitions come from, and check their correctness.
It also facilitates the future work of automatically generating these files.

Q:
Why are they in uapi?
A:
In short, to keep things simple. There are many definitions needed in both
the kernel and the VMM in userspace. Separating them doesn't serve much
purpose, and makes it more laborious to import definitions from Hyper-V
code.

--------------------------
[0] "Hyper-V" is more well-known, but it really refers to the whole stack
    including the hypervisor and other components that run in Windows
    kernel and userspace.
[1] Previous /dev/mshv patch series and discussion:
    https://lore.kernel.org/linux-hyperv/1632853875-20261-1-git-send-email-nunodasneves@linux.microsoft.com/
[2] Virtual Secure Mode (VSM) and Virtual Trust Levels (VTL):
    https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/vsm
--------------------------

Changes since v3:
    * Correct HyperV -> Hyper-V in patch 1 commit message
    * Replace BUG()s in mshv_vtl_init() with return -ENODEV
    * Remove some debug prints that leak kernel addresses
    * Remove __func__ in most error printing where the error string is easily
      greppable, and in all uses of pr_debug()/dev_dbg()
    * Pass mshv_dev->this_device to mshv_vtl and mshv_root, store it in vtl
      and partition structs
    * Add a set of macros vp_*() and partition_*() which call the equivalent
      dev_*(), passing the device from the partition struct
        * The new macros also print the partition and vp ids to aid debugging
          and reduce repeated code
    * Use dev_*() (mostly via the new macros) instead of pr_*() *almost*
      everywhere - in interrupt context we can't always get the device struct
    * Remove pr_*() logging from hv_call.c and mshv_root_hv_call.c
Changes since v2:
    * Fix some commit message wrapping
    * Fix many checkpatch.pl --strict style issues
    * Replace uapi ints with __s32
    * Replace uapi enums with __u32
    * Replace uapi pointers with __u64
    * Add explicit padding to uapi structures
    * Initialize status in get/set registers hypercall helpers
    * Add missing return on error in get_vp_signaled_count
    * Remove select TRANSPARENT_HUGEPAGES for mshv_vtl
    * Use __func__ prefix consistently in printks
    * Use single generic cpuid() to get all 4 registers instead of 4 calls
    * Change hv_proximity_domain_info from union to struct for clarity
Changes since v1:
    * Clean up formatting, capitalization in commit messages
    * Add detail to commit message for patch 15
    * Remove errant lines in Makefile and Kconfig in patch 15
    * Move a reference to CONFIG_MSHV_VTL from patch 9 to 15

Nuno Das Neves (15):
  hyperv-tlfs: Change shared HV_REGISTER_* defines to HV_MSR_*
  mshyperv: Introduce hv_get_hypervisor_version function
  mshyperv: Introduce numa_node_to_proximity_domain_info
  asm-generic/mshyperv: Introduce hv_recommend_using_aeoi()
  hyperv: Move hv_connection_id to hyperv-tlfs
  hyperv-tlfs: Introduce hv_status_to_string and hv_status_to_errno
  Drivers: hv: Move hv_call_deposit_pages and hv_call_create_vp to
    common code
  Drivers: hv: Introduce per-cpu event ring tail
  Drivers: hv: Introduce hv_output_arg_exists in hv_common.c
  x86: hyperv: Add mshv_handler irq handler and setup function
  Drivers: hv: export vmbus_isr, hv_context and hv_post_message
  Documentation: Reserve ioctl number for mshv driver
  uapi: hyperv: Add mshv driver headers defining hypervisor ABIs
  asm-generic: hyperv: Use new Hyper-V headers conditionally.
  Drivers: hv: Add modules to expose /dev/mshv to VMMs running on
    Hyper-V

 .../userspace-api/ioctl/ioctl-number.rst      |    2 +
 arch/arm64/hyperv/mshyperv.c                  |   23 +-
 arch/arm64/include/asm/hyperv-tlfs.h          |   25 +
 arch/arm64/include/asm/mshyperv.h             |    2 +-
 arch/x86/hyperv/hv_init.c                     |    2 +-
 arch/x86/hyperv/hv_proc.c                     |  166 +-
 arch/x86/include/asm/hyperv-tlfs.h            |  137 +-
 arch/x86/include/asm/mshyperv.h               |   12 +-
 arch/x86/kernel/cpu/mshyperv.c                |   67 +-
 drivers/acpi/numa/srat.c                      |    1 +
 drivers/clocksource/hyperv_timer.c            |   24 +-
 drivers/hv/Kconfig                            |   49 +
 drivers/hv/Makefile                           |   20 +
 drivers/hv/hv.c                               |   50 +-
 drivers/hv/hv_call.c                          |  103 +
 drivers/hv/hv_common.c                        |  223 +-
 drivers/hv/hyperv_vmbus.h                     |    2 +-
 drivers/hv/mshv.h                             |  125 ++
 drivers/hv/mshv_eventfd.c                     |  761 +++++++
 drivers/hv/mshv_eventfd.h                     |   80 +
 drivers/hv/mshv_main.c                        |  196 ++
 drivers/hv/mshv_msi.c                         |  129 ++
 drivers/hv/mshv_portid_table.c                |   84 +
 drivers/hv/mshv_root.h                        |  232 ++
 drivers/hv/mshv_root_hv_call.c                |  911 ++++++++
 drivers/hv/mshv_root_main.c                   | 1911 +++++++++++++++++
 drivers/hv/mshv_synic.c                       |  688 ++++++
 drivers/hv/mshv_vtl.h                         |   52 +
 drivers/hv/mshv_vtl_main.c                    | 1522 +++++++++++++
 drivers/hv/vmbus_drv.c                        |    3 +-
 drivers/hv/xfer_to_guest.c                    |   28 +
 include/asm-generic/hyperv-defs.h             |   26 +
 include/asm-generic/hyperv-tlfs.h             |   93 +-
 include/asm-generic/mshyperv.h                |   73 +-
 include/linux/hyperv.h                        |   11 +-
 include/uapi/hyperv/hvgdk.h                   |   41 +
 include/uapi/hyperv/hvgdk_mini.h              | 1076 ++++++++++
 include/uapi/hyperv/hvhdk.h                   | 1342 ++++++++++++
 include/uapi/hyperv/hvhdk_mini.h              |  160 ++
 include/uapi/linux/mshv.h                     |  306 +++
 40 files changed, 10394 insertions(+), 364 deletions(-)
 create mode 100644 drivers/hv/hv_call.c
 create mode 100644 drivers/hv/mshv.h
 create mode 100644 drivers/hv/mshv_eventfd.c
 create mode 100644 drivers/hv/mshv_eventfd.h
 create mode 100644 drivers/hv/mshv_main.c
 create mode 100644 drivers/hv/mshv_msi.c
 create mode 100644 drivers/hv/mshv_portid_table.c
 create mode 100644 drivers/hv/mshv_root.h
 create mode 100644 drivers/hv/mshv_root_hv_call.c
 create mode 100644 drivers/hv/mshv_root_main.c
 create mode 100644 drivers/hv/mshv_synic.c
 create mode 100644 drivers/hv/mshv_vtl.h
 create mode 100644 drivers/hv/mshv_vtl_main.c
 create mode 100644 drivers/hv/xfer_to_guest.c
 create mode 100644 include/asm-generic/hyperv-defs.h
 create mode 100644 include/uapi/hyperv/hvgdk.h
 create mode 100644 include/uapi/hyperv/hvgdk_mini.h
 create mode 100644 include/uapi/hyperv/hvhdk.h
 create mode 100644 include/uapi/hyperv/hvhdk_mini.h
 create mode 100644 include/uapi/linux/mshv.h

-- 
2.25.1

