Return-Path: <linux-arch+bounces-13303-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0344AB39083
	for <lists+linux-arch@lfdr.de>; Thu, 28 Aug 2025 03:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ADA9464211
	for <lists+linux-arch@lfdr.de>; Thu, 28 Aug 2025 01:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D6019CC39;
	Thu, 28 Aug 2025 01:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="joLOfUDr"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54AA4A00;
	Thu, 28 Aug 2025 01:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756343161; cv=none; b=Xx6u/uAr1fwYzXBijRQB3XgSkBmXv6IiPRsyXtmWad253AtI5co28C0H1kI5elkggX6JBl40zg14UKLP4qm2lS7BJbEHzKfRKr5yTdrbEEURqVKDhYNokAnbkqHC5gPZyYgM+ADgVAXuAy9gGaufPXLuWG4fqq822E7C7kmmdys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756343161; c=relaxed/simple;
	bh=ho5z0dVXM3/Vtd4N21Mso2UzUUV48x3fiOjkWmpgyrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A01b2G24B7l+pJ5XGpGcsBi1A+ia2xfvNEFfWc7RniEjm+NnMOM18hl2JEKS15qHcKMeZXfrS5Vg4rMCZ2P9OrBAVJwJ0Aw6l8Pdft8FmiDvhO1NW17CDEXJq3Bqp8hI/TjR7Pxxo+pmwSFvBqg6ePAkV+kCZM3QwXtv/RsP/MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=joLOfUDr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.174.60])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7C545201656A;
	Wed, 27 Aug 2025 18:05:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7C545201656A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756343158;
	bh=gdwJzFK/nbHwucF8CUZ+Nb/WB7C3XLC6IFr8J3kWy6E=;
	h=From:To:Cc:Subject:Date:From;
	b=joLOfUDrC1nJSwtnqZmKITywEieTFxJoY1BDOCcacQRZiY28gzvap/VPeTUbIhJi4
	 DAAeTIl8i9tLK22T2T7OT086EvbZMa8tHxa0doEtg4wbeeWamvDZw4hpiJuFV2FiK/
	 bOgKbpk7y9Ky4Nc5+s/yAXcAamu7r8BUxt9uwoQQ=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bp@alien8.de,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	mikelley@microsoft.com,
	mingo@redhat.com,
	tglx@linutronix.de,
	Tianyu.Lan@microsoft.com,
	wei.liu@kernel.org,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com,
	romank@linux.microsoft.com
Subject: [PATCH hyperv-next v5 00/16] Confidential VMBus
Date: Wed, 27 Aug 2025 18:05:41 -0700
Message-ID: <20250828010557.123869-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello all,

This is the 5th version of the patch series, and the full changelog
is at the end of the cover letter. The most notable change is that
now there is a CPUID bit set under the virtualization leaf to indicate
that the Confidential VMBus is available. The fallback approach used
in the first versions received some criticism, and that has been addressed
in this version.

The COUID bit is obviously an x86_64 specific technique. On ARM64, the
Confidential VMBus is expected to be required once support for ARM CC is
implemented. Despite that change, the functions for getting and setting
registers via paravisor remain fallible. That provides a clearer root cause
for failures instead of printing messages about unchecked MSR accesses.
That might seem as not needed with the paravisors run in Azure (OpenHCL
and the TrustedLauch aka HCL paravisor). However, if someone decides to
implement their own or tweak the exisiting one, this will help with debugging.

TLDR; is that these patches are for the Hyper-V guests, and the patches
allow to keep data flowing from physical devices into the guests encrypted
at the CPU level so that neither the root/host partition nor the hypervisor
can access the data being processed (they only "see" the encrypted/garbled
data) unless the guest decides to share it. The changes are backward compatible
with older systems, and their full potential is realized on hardware that
supports memory encryption.

These features also require running a paravisor, such as
OpenHCL (https://github.com/microsoft/openvmm) used in Azure. Another
implementation of the functionality available in this patch set is
available in the Hyper-V UEFI: https://github.com/microsoft/mu_msvm.

A more detailed description of the patches follows.

The guests running on Hyper-V can be confidential where the memory and the
register content are encrypted, provided that the hardware supports that
(currently support AMD SEV-SNP and Intel TDX is implemented) and the guest
is capable of using these features. The confidential guests cannot be
introspected by the host nor the hypervisor without the guest sharing the
memory contents upon doing which the memory is decrypted.

In the confidential guests, neither the host nor the hypervisor need to be
trusted, and the guests processing sensitive data can take advantage of that.

Not trusting the host and the hypervisor (removing them from the Trusted
Computing Base aka TCB) necessitates that the method of communication
between the host and the guest be changed. Here is the data flow for a
conventional and the confidential VMBus connections (`C` stands for the
client or VSC, `S` for the server or VSP, the `DEVICE` is a physical one,
might be with multiple virtual functions):

1. Without the paravisor the devices are connected to the host, and the
host provides the device emulation or translation to the guest:

  +---- GUEST ----+       +----- DEVICE ----+        +----- HOST -----+
  |               |       |                 |        |                |
  |               |       |                 |        |                |
  |               |       |                 ==========                |
  |               |       |                 |        |                |
  |               |       |                 |        |                |
  |               |       |                 |        |                |
  +----- C -------+       +-----------------+        +------- S ------+
         ||                                                   ||
         ||                                                   ||
  +------||------------------ VMBus --------------------------||------+
  |                     Interrupts, MMIO                              |
  +-------------------------------------------------------------------+

2. With the paravisor, the devices are connected to the paravisor, and
the paravisor provides the device emulation or translation to the guest.
The guest doesn't communicate with the host directly, and the guest
communicates with the paravisor via the VMBus. The host is not trusted
in this model, and the paravisor is trusted:

  +---- GUEST --------------- VTL0 ------+               +-- DEVICE --+
  |                                      |               |            |
  | +- PARAVISOR --------- VTL2 -----+   |               |            |
  | |     +-- VMBus Relay ------+    ====+================            |
  | |     |   Interrupts, MMIO  |    |   |               |            |
  | |     +-------- S ----------+    |   |               +------------+
  | |               ||               |   |
  | +---------+     ||               |   |
  | |  Linux  |     ||    OpenHCL    |   |
  | |  kernel |     ||               |   |
  | +---- C --+-----||---------------+   |
  |       ||        ||                   |
  +-------++------- C -------------------+               +------------+
          ||                                             |    HOST    |
          ||                                             +---- S -----+
  +-------||----------------- VMBus ---------------------------||-----+
  |                     Interrupts, MMIO                              |
  +-------------------------------------------------------------------+

Note that in the second case the guest doesn't need to share the memory
with the host as it communicates only with the paravisor within their
partition boundary. That is precisely the raison d'etre and the value
proposition of this patch series: equip the confidential guest to use
private (encrypted) memory and rely on the paravisor when this is
available to be more secure.

An implementation of the VMBus relay that offers the Confidential VMBus
channels is available in the OpenVMM project as a part of the OpenHCL
paravisor. Please refer to

  * https://openvmm.dev/, and
  * https://github.com/microsoft/openvmm

for more information about the OpenHCL paravisor. A VMBus client
that can work with the Confidential VMBus is available in the
open-source Hyper-V UEFI: https://github.com/microsoft/mu_msvm.

I'd like to thank the following people for their help with this
patch series:

* Dexuan for help with validation and the fruitful discussions,
* Easwar for reviewing the refactoring of the page allocating and
  freeing in `hv.c`,
* John and Sven for the design,
* Mike for helping to avoid pitfalls when dealing with the GFP flags,
* Sven for blazing the trail and implementing the design in few
  codebases.

I made sure to validate the patch series on

    {TrustedLaunch(x86_64), OpenHCL} x
    {SNP(x86_64), TDX(x86_64), No hardware isolation, No paravisor} x
    {VMBus 5.0, VMBus 6.0} x
    {arm64, x86_64}.

[V5]
    - Rebased onto the latest hyperv-next tree.

    - Fixed build issues with the configs provided by the kernel robot.
      **Thank you, kernel robot!**

    - Fixed the potential NULL deref in a failure path.
      **Thank you, Michael!**

    - Removed the added blurb from the vmbus_drv.c with taxonomy of Hyper-V VMs
      that was providing reasons for the trade-offs in the fallback code. That
      code is no longer needed.

[V4] https://lore.kernel.org/linux-hyperv/20250714221545.5615-1-romank@linux.microsoft.com/
    - Rebased the patch series on top of the latest hyperv-next branch,
      applying changes as needed.

    - Fixed typos and clarifications all around the patch series.
    - Added clarifications in the patch 7 for `ms_hyperv.paravisor_present && !vmbus_is_confidential()`
      and using hypercalls vs SNP or TDX specific protocols.
      **Thank you, Alok!**

    - Trim the Documentation changes to 80 columns.
      **Thank you, Randy!**

    - Make sure adhere to the RST format, actually built the PDF docs
      and made sure the layout was correct.
    **Thank you, Jon!**

    - Better section order in Documentation.
    - Fixed the commit descriptions where suggested.
    - Moved EOI/EOM signaling for the confidential VMBus to the specialized function.
    - Removed the unused `cpu` parameters.
    - Clarified comments in the `hv_per_cpu_context` struct
    - Explicitly test for NULL and only call `iounmap()` if non-NULL instead of
      using `munmap()`.
    - Don't deallocate SynIC pages in the CPU online and offline paths.
    - Made sure the post page needs to be allocated for the future.
    - Added comments to describe trade-offs.
    **Thank you, Michael!**

[V3] https://lore.kernel.org/linux-hyperv/20250604004341.7194-1-romank@linux.microsoft.com/
    - The patch series is rebased on top of the latest hyperv-next branch.
    - Reworked the "wiring" diagram in the cover letter, added links to the
      OpenVMM project and the OpenHCL paravisor.

    - More precise wording in the comments and clearer code.
    **Thank you, Alok!**

    - Reworked the documentation patch.
    - Split the patchset into much more granular patches.
    - Various fixes and improvements throughout the patch series.
    **Thank you, Michael!**

[V2] https://lore.kernel.org/linux-hyperv/20250511230758.160674-1-romank@linux.microsoft.com/
    - The patch series is rebased on top of the latest hyperv-next branch.
  
    - Better wording in the commit messages and the Documentation.
    **Thank you, Alok and Wei!**

    - Removed the patches 5 and 6 concerning turning bounce buffering off from
      the previous version of the patch series as they were found to be
      architecturally unsound. The value proposition of the patch series is not
      diminished by this removal: these patches were an optimization and only for
      the storage (for the simplicity sake) but not for the network. These changes
      might be proposed in the future again after revolving the issues.
    ** Thanks you, Christoph, Dexuan, Dan, Michael, James, Robin! **

[V1] https://lore.kernel.org/linux-hyperv/20250409000835.285105-1-romank@linux.microsoft.com/

Roman Kisel (16):
  Documentation: hyperv: Confidential VMBus
  drivers: hv: VMBus protocol version 6.0
  arch: hyperv: Get/set SynIC synth.registers via paravisor
  arch/x86: mshyperv: Trap on access for some synthetic MSRs
  Drivers: hv: Rename fields for SynIC message and event pages
  Drivers: hv: Allocate the paravisor SynIC pages when required
  Drivers: hv: Post messages through the confidential VMBus if available
  Drivers: hv: remove stale comment
  Drivers: hv: Check message and event pages for non-NULL before
    iounmap()
  Drivers: hv: Rename the SynIC enable and disable routines
  Drivers: hv: Functions for setting up and tearing down the paravisor
    SynIC
  Drivers: hv: Allocate encrypted buffers when requested
  Drivers: hv: Free msginfo when the buffer fails to decrypt
  Drivers: hv: Support confidential VMBus channels
  Drivers: hv: Set the default VMBus version to 6.0
  Drivers: hv: Support establishing the confidential VMBus connection

 Documentation/virt/hyperv/coco.rst | 143 +++++++++-
 arch/x86/include/asm/mshyperv.h    |   2 +
 arch/x86/kernel/cpu/mshyperv.c     |  86 +++++-
 drivers/hv/channel.c               |  73 +++--
 drivers/hv/channel_mgmt.c          |  27 +-
 drivers/hv/connection.c            |   6 +-
 drivers/hv/hv.c                    | 426 ++++++++++++++++++++---------
 drivers/hv/hv_common.c             |  24 ++
 drivers/hv/hyperv_vmbus.h          |  70 ++++-
 drivers/hv/mshv_root.h             |   2 +-
 drivers/hv/mshv_synic.c            |   6 +-
 drivers/hv/ring_buffer.c           |   5 +-
 drivers/hv/vmbus_drv.c             | 186 ++++++++-----
 include/asm-generic/mshyperv.h     |  39 +--
 include/hyperv/hvgdk_mini.h        |   1 +
 include/linux/hyperv.h             |  69 +++--
 16 files changed, 878 insertions(+), 287 deletions(-)


base-commit: 03ac62a578566730ab3c320f289f7320798ee2e1
-- 
2.43.0


