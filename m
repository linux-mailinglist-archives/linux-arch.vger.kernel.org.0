Return-Path: <linux-arch+bounces-13900-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4495BB8446
	for <lists+linux-arch@lfdr.de>; Sat, 04 Oct 2025 00:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99FD74A6DB5
	for <lists+linux-arch@lfdr.de>; Fri,  3 Oct 2025 22:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DAA26FDB2;
	Fri,  3 Oct 2025 22:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XD4lKQnU"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A97825A324;
	Fri,  3 Oct 2025 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759530441; cv=none; b=CMMUoJmqBfPoPRGT9VdOPVJKu07P+TPhjPGsp0mofstMiks+bk3TwBzao7hLHhijX+sbmXTuBYy4bR8rkpuyPsfd2zu06vrC2pvV9+oLMJwc8f1vSl6/hmDE7bDNFJOQhSOqSWyDteJ4RFpkaWHrQ7I5miNZvuuXaXZzeNluw2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759530441; c=relaxed/simple;
	bh=JqRoXpsQqKkek3y71NifZaZzOohyCa/jXDkK608IiLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jXvC9xxXrfeM86B44qwAWgOxPKlWaX+hruX/WmD5GlkNPfohVHVjePdYHAR/DpbzXme7gfEo5tccGhHOv/Rod1ib39BPxJwkB6r6D0RcgVW06D0yE2gNkEmsIvQyS5SMBf7n7201glFTB/+38hvbEcm9yfYm0rzI7e0FpxyswXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XD4lKQnU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id D881A211C268;
	Fri,  3 Oct 2025 15:27:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D881A211C268
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759530432;
	bh=/DM3/xW2aA5FWHDXvCoE8vQO1z0EDyi8DHYN44bBRwY=;
	h=From:To:Cc:Subject:Date:From;
	b=XD4lKQnULhWDPdIsb8Hk9R05l67ut7PZyhRvqgAdUJosR2COlTT+9qTzDPZTKIZ7N
	 bE6sBmacvQm2XOO8wtun00t0B+HAMJ6LIcUPXRD6E4lhNG0oWUvvpYm920EaUp9UxY
	 3CPwlrXy2qK9stZZqm6vo82gIj+moCkrohCWrFy8=
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
Subject: [PATCH hyperv-next v6 00/17] Confidential VMBus
Date: Fri,  3 Oct 2025 15:26:53 -0700
Message-ID: <20251003222710.6257-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings everyone,

We've got to the 6th version of the patch series, and the full changelog
is at the end of the cover letter. I addressed feedback from
Michael and Wei on the previous version of the patch series.

Since v5, the fallback mechanism for establishing the VMBus connection
is no longer used as the availability of the Confidential VMBus is
now indicated by a bit in the Virtualization Stack (VS) CPUID leaf.
The v6 patch series breaks that out into a separate patch seizing
the opportunity to refactor the code that uses the same leaf.

That is obviously an x86_64 specific technique. On ARM64, the
Confidential VMBus is expected to be required once support for ARM CCA is
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

[V6]
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


