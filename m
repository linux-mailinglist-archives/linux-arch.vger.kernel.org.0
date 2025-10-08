Return-Path: <linux-arch+bounces-13963-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B60BC6DF8
	for <lists+linux-arch@lfdr.de>; Thu, 09 Oct 2025 01:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC24A4E3C23
	for <lists+linux-arch@lfdr.de>; Wed,  8 Oct 2025 23:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44092C234F;
	Wed,  8 Oct 2025 23:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cRe72l7g"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADAE34BA39;
	Wed,  8 Oct 2025 23:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759966464; cv=none; b=XSF7v0y8LxWKJ256MPLKkpfDX4XpJK4fB/7c0yyIX2+/Iv5Xlp3CWW0AycZKCTteBMjpkL+5hSqKWuQ6LXGDDQaDmnDOMPwJ8HHaZJSV5McdRXv2IBqUkRskuOoUmOPSwFI6xZjL+KKJ7EzxWJ6lTKNzJbSOlGSt4RjluEsU7XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759966464; c=relaxed/simple;
	bh=0Vx+nNQu4j0ojqAZ+fafluGsj7lN9l4cbrGyJk3gzOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fkbet8NI0n5WlXuV7dCGGsGElFK9K4jpVH6kh/pok4ZbdXIqziajt4q79jPO7CeAxKwhnPV2PIXvO2dvtk4L/pXDdM6MPXTdntpO97drPD+nfBDsdsjfJob/fXjMPQIrzisplSybRLeqGKP/bVf4hln48I8O5UoViQg3ZcuiLOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cRe72l7g; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 615552038B7D;
	Wed,  8 Oct 2025 16:34:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 615552038B7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759966461;
	bh=Whc9zN3cPa9r6enAabfB8wf9Lgg1G77WOzQzaiKxe6w=;
	h=From:To:Cc:Subject:Date:From;
	b=cRe72l7gwt3/WKMO0ACNlIY9uZPcH5xiJBjhYaB3eLCX3C01wW0Weg+MU+ai8F/nZ
	 X2DXwG3ehhDRjQKB5RL6Qqz/ALUx2c4Tk79wkk3zqyQ+g25QMorNy2jrkB5A9Cx230
	 BNxJV/aUtU5U/w7WQxIfQAczPbOPuF0NSxcM/HKk=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bp@alien8.de,
	bagasdotme@gmail.com,
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
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v7 00/17] Confidential VMBus
Date: Wed,  8 Oct 2025 16:34:02 -0700
Message-ID: <20251008233419.20372-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello all,

Enclosed is the 7th version of the patch series with all patches approved,
and the delta against the 6th version is few non-functional changes
suggested by Michael. Bagas also provided some feedback on how to use
a simpler cross-reference mechanism in the Documentation based on
some additional processing happening during "make htmldocs", and unfortunately
that wouldn't work for "make pdfdocs" so I kept the original approach
which is the standard :doc: role of Sphinx. I'll dig in into that anomaly
separately.

Since v5, the fallback mechanism for establishing the VMBus connection
is no longer used as the availability of the Confidential VMBus is
now indicated by a bit in the Virtualization Stack (VS) CPUID leaf.
The v6 patch series breaks that out into a separate patch seizing
the opportunity to refactor the code that uses the same leaf.
That is obviously an x86_64 specific technique. On ARM64, the
Confidential VMBus is expected to be required once support for ARM CCA is
implemented.

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
(currently support for AMD SEV-SNP and Intel TDX is implemented) and the guest
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

[V7]
    - Removed the sentence about the fallible functions for setting/getting
      registers of the paravisor SynIC. That was no longer valid in v6.
    - Fixed grammar and whitespace in the patch for Documentation.
      **Thank you, Michael!**

    - Fixed the warning produced when building for i386 w/o Hyper-V.
      **Thank you, kernel robot!**
      **Thank you, Michael!**

[V6] https://lore.kernel.org/linux-hyperv/20251003222710.6257-1-romank@linux.microsoft.com/
    - Rebased onto the latest hyperv-next tree.

    - Gave another thought to the fallible routines for getting and setting
      SynIC registers via paravisor introduced in the patch series, and after
      Michael's feedback decided to make them infallible as now we have the
      CPUID bit to indicate the availability of the Confidential VMBus. That
      simplifies the code and makes it clearer and more robust - a reflection
      of the improvements in the design throught the patch series iterations.
    - Removed the sentence discussing the fallback mechanism in the Documentation
      as it is no longer relevant.
      **Thank you, Michael!**

    - Avoided using the macro'es for (un)masking the proxy bit thanks to
      `union hv_synic_sint`.
      **Thank you, Wei!**

[V5] https://lore.kernel.org/linux-hyperv/20250828010557.123869-1-romank@linux.microsoft.com/
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

Roman Kisel (17):
  Documentation: hyperv: Confidential VMBus
  Drivers: hv: VMBus protocol version 6.0
  arch/x86: mshyperv: Discover Confidential VMBus availability
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

 Documentation/virt/hyperv/coco.rst | 139 ++++++++++-
 arch/x86/kernel/cpu/mshyperv.c     |  77 ++++--
 drivers/hv/channel.c               |  73 ++++--
 drivers/hv/channel_mgmt.c          |  27 ++-
 drivers/hv/connection.c            |   6 +-
 drivers/hv/hv.c                    | 372 +++++++++++++++++++----------
 drivers/hv/hv_common.c             |  16 ++
 drivers/hv/hyperv_vmbus.h          |  75 +++++-
 drivers/hv/mshv_root.h             |   2 +-
 drivers/hv/mshv_synic.c            |   6 +-
 drivers/hv/ring_buffer.c           |   5 +-
 drivers/hv/vmbus_drv.c             | 186 ++++++++++-----
 include/asm-generic/mshyperv.h     |  45 +---
 include/hyperv/hvgdk_mini.h        |   1 +
 include/linux/hyperv.h             |  69 ++++--
 15 files changed, 793 insertions(+), 306 deletions(-)


base-commit: b595edcb24727e7f93e7962c3f6f971cc16dd29e
-- 
2.43.0


