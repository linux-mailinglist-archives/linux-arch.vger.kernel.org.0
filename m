Return-Path: <linux-arch+bounces-12187-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7DFACD0BC
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 02:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811CF188911B
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 00:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FABBE67;
	Wed,  4 Jun 2025 00:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LY7DtV0k"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F3A79F5;
	Wed,  4 Jun 2025 00:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748997826; cv=none; b=cqBJNUCGua5I4B5PnT/e3NsF8WDkzkJlZIsUAiUGBwjnszGtdfS48jUsf5voJ8IhtaMLubGs9lM0wQTS7Km67GsHGHDPDnCif6WRvDitsVVSBMfvOC1DZuBajNQQYO5ARph8cH08C6zocrSpOx882cEI0ZdHwgL7GrXQkVrOHw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748997826; c=relaxed/simple;
	bh=5XlTn7oXcjao3VqHkxnk9Xb/cg6Dq4G3kzQhnyid41k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dEQF57h03JjBHHukFPpFDKsvbfrhFxrfL1dE1dqfW2Q4z4pESj2eUu5atOU8US7W33U8DH1nXH/qjtCbRgiBetC1d3H3lI5PydS+rsE2AkACt3cVIMBvo8LEo62u+2UYTDNGn0DgLdsp608rd2z2E4RKM9KBbh1ZKV50nHQdoDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LY7DtV0k; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 754982115DB5;
	Tue,  3 Jun 2025 17:43:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 754982115DB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748997824;
	bh=W2kFVrUcVkC6qHNqYEoSix4ZwhxOLqNhoLnHoPiRR+c=;
	h=From:To:Cc:Subject:Date:From;
	b=LY7DtV0kmuWobLbPPHtkrVUrZjWvxjkEkbfpHYS2b/JHnat2cngNZPjSI61BA7Z6U
	 bviDzkZGY6OUYK1/nNrnAtzrFyCboCxnufUCh2obzVhFcSxmMsQ8AS07+Ag9D1h3Kh
	 JWjQ4B7FT8okormu0vJFf0E801MYGP4kbBFarjIk=
From: Roman Kisel <romank@linux.microsoft.com>
To: alok.a.tiwari@oracle.com,
	arnd@arndb.de,
	bp@alien8.de,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	mingo@redhat.com,
	mhklinux@outlook.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v3 00/15] Confidential VMBus
Date: Tue,  3 Jun 2025 17:43:26 -0700
Message-ID: <20250604004341.7194-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The guests running on Hyper-V can be confidential where the memory and the
register content are encrypted, provided that the hardware supports that
(currently support AMD SEV-SNP and Intel TDX is implemented) and the guest
is capable of using these features. The confidential guests cannot be
introspected by the host nor the hypervisor without the guest sharing the
memory contents upon doing which the memory is decrypted.

In the confidential guests, neither the host nor the hypervisor need to be
trusted, and the guests processing sensitive data can take advantage of that.

Not trusting the host and the hypervisor (removing them from the Trusted
Computing Base aka TCB) ncessitates that the method of communication
between the host and the guest be changed. Below there is the breakdown of
the options used in the both cases (in the diagrams below the server is
marked as S, the client is marked as C):

1. Without the paravisoor the devices are connected to the host, and the
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

An implementation of the VMBus relay that offers the Confidential VMBus channels
is available in the OpenVMM project as a part of the OpenHCL paravisor. Please
refer to https://openvmm.dev/ and https://github.com/microsoft/openvmm for more
information about the OpenHCL paravisor.

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

[V3]
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

Roman Kisel (15):
  Documentation: hyperv: Confidential VMBus
  drivers: hv: VMBus protocol version 6.0
  arch: hyperv: Get/set SynIC synth.registers via paravisor
  arch/x86: mshyperv: Trap on access for some synthetic MSRs
  Drivers: hv: Rename fields for SynIC message and event pages
  Drivers: hv: Allocate the paravisor SynIC pages when required
  Drivers: hv: Post messages via the confidential VMBus if available
  Drivers: hv: remove stale comment
  Drivers: hv: Use memunmap() to check if the address is in IO map
  Drivers: hv: Rename the SynIC enable and disable routines
  Drivers: hv: Functions for setting up and tearing down the paravisor
    SynIC
  Drivers: hv: Allocate encrypted buffers when requested
  Drivers: hv: Support confidential VMBus channels
  Drivers: hv: Support establishing the confidential VMBus connection
  Drivers: hv: Set the default VMBus version to 6.0

 Documentation/virt/hyperv/coco.rst | 125 ++++++++-
 arch/x86/kernel/cpu/mshyperv.c     |  67 ++++-
 drivers/hv/channel.c               |  43 ++--
 drivers/hv/channel_mgmt.c          |  27 +-
 drivers/hv/connection.c            |   6 +-
 drivers/hv/hv.c                    | 399 ++++++++++++++++++++---------
 drivers/hv/hv_common.c             |  13 +
 drivers/hv/hyperv_vmbus.h          |  28 +-
 drivers/hv/mshv_root.h             |   2 +-
 drivers/hv/mshv_synic.c            |   6 +-
 drivers/hv/ring_buffer.c           |   5 +-
 drivers/hv/vmbus_drv.c             | 187 +++++++++-----
 include/asm-generic/mshyperv.h     |   3 +
 include/linux/hyperv.h             |  69 +++--
 14 files changed, 740 insertions(+), 240 deletions(-)


base-commit: 96959283a58d91ae20d025546f00e16f0a555208
-- 
2.43.0


