Return-Path: <linux-arch+bounces-11885-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5700AB2C37
	for <lists+linux-arch@lfdr.de>; Mon, 12 May 2025 01:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810763B8DAA
	for <lists+linux-arch@lfdr.de>; Sun, 11 May 2025 23:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8BB263F3D;
	Sun, 11 May 2025 23:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aLRNYtL5"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E4F188A0E;
	Sun, 11 May 2025 23:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747004888; cv=none; b=egDeEqo6nx7BclegwZv30Otto5IfF8+Z6aB2LEpNrBfwmnRfB7lxF4oniVtVFqnDl2NWoZtNUkQ2K4v8ObF7UH+m13RvhuWkMXr3MKPYcoNXT2O+s5UeOhFcy32PInF3f1QmcKIWDkGafIiiLkcuiBMr3QnUEQHoeLWY3sJS13s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747004888; c=relaxed/simple;
	bh=yu30KY9WMPErh9DcvRVTKaLTwBXmEyfrJ1b/8XITBq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NsncHH/ShjhShOjSd4/BT6hfgVcub4pEO4yL6fOfLFz0kh6lp36dcBA+9MPpBi8F/5qymlP9zGmL89DBTjc+M06oBzXhUKY/prTT+BNewFI1Iamw7810lZmFdRk2DP7NWhITIZSWcW42rK7tqacu1MJZmuU21ub6OIsccCBnCvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aLRNYtL5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7450C211D8B8;
	Sun, 11 May 2025 16:08:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7450C211D8B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747004880;
	bh=F2fG0i25TDQiWGtI7DQglXAnLSOL4mMbFNlfNGu1LF0=;
	h=From:To:Cc:Subject:Date:From;
	b=aLRNYtL5kOBG3kGB6vZIhQl85AE/5qTPeARbyiDUbcSGHdhJVf2jmf2pbe6r3fddL
	 td4n6rD5jiHRC9nqxXO71MULvNvKGoZRsEKo/osnBcF119vuO5NeC3PA1dMDIpy+Nj
	 1J41XBLPsuhdCyDHIG1GEKQFjj0Ku6AAt207kXtU=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bp@alien8.de,
	catalin.marinas@arm.com,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	mingo@redhat.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	will@kernel.org,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v2 0/4] Confidential VMBus
Date: Sun, 11 May 2025 16:07:54 -0700
Message-ID: <20250511230758.160674-1-romank@linux.microsoft.com>
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

+---- GUEST ------+                                   +-- DEVICE --+
|                 |                                   |            |
| +- PARAVISOR -+ |                                   |            |
| |             ==+====================================            |
| |   OpenHCL   | |                                   |            |
| |             | C=====================              |            |
+-+---- C - S --+-+                   ||              +------------+
        ||  ||                        ||
        ||  ||      +-- VMBus Relay --||--+           +--- HOST ---+
        ||  ||=======   Interrupts, MMIO  |           |            |
        ||          +---------------------+           +---- S -----+
        ||                                                  ||
+-------||----------------- VMBus --------------------------||------+
|                     Interrupts, MMIO                              |
+-------------------------------------------------------------------+

Note that in the second case the guest doesn't need to share the memory
with the host as it communicates only with the paravisor within their
partition boundary. That is precisely the raison d'etre and the value
proposition of this patch series: equip the confidential guest to use
private (encrypted) memory and rely on the paravisor when this is
available to be more secure.

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

[V2]
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

Roman Kisel (4):
  Documentation: hyperv: Confidential VMBus
  drivers: hyperv: VMBus protocol version 6.0
  arch: hyperv: Get/set SynIC synth.registers via paravisor
  arch: x86, drivers: hyperv: Enable confidential VMBus

 Documentation/virt/hyperv/vmbus.rst |  41 +++
 arch/arm64/hyperv/mshyperv.c        |  19 ++
 arch/arm64/include/asm/mshyperv.h   |   3 +
 arch/x86/include/asm/mshyperv.h     |   3 +
 arch/x86/kernel/cpu/mshyperv.c      |  51 ++-
 drivers/hv/channel.c                |  36 ++-
 drivers/hv/channel_mgmt.c           |  29 +-
 drivers/hv/connection.c             |  10 +-
 drivers/hv/hv.c                     | 485 ++++++++++++++++++++--------
 drivers/hv/hyperv_vmbus.h           |   9 +-
 drivers/hv/ring_buffer.c            |   5 +-
 drivers/hv/vmbus_drv.c              | 152 +++++----
 include/asm-generic/mshyperv.h      |   1 +
 include/linux/hyperv.h              |  71 ++--
 14 files changed, 677 insertions(+), 238 deletions(-)


base-commit: 9b0844d87b1407681b78130429f798beb366f43f
-- 
2.43.0


