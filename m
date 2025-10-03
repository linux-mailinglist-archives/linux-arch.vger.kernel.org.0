Return-Path: <linux-arch+bounces-13901-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A53C0BB8452
	for <lists+linux-arch@lfdr.de>; Sat, 04 Oct 2025 00:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49A754E2EA9
	for <lists+linux-arch@lfdr.de>; Fri,  3 Oct 2025 22:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C120274B26;
	Fri,  3 Oct 2025 22:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mVBDNRQp"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94503264A8D;
	Fri,  3 Oct 2025 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759530442; cv=none; b=OwKJeyLAvWbgM/yib2O4YGyFE52zqFr+G4+EY6aRRF5uFTLS5J+R5vVSLSlBE34FpPKUAGEoHcT+xttaRvCpkSzuLZmYGnbZyYUOj7SNXjvvi62vHWf+d1jM64xsqZeYcbZeyQ/bO8zMMmCnrsPgjGgdSPlWjKdOuBdm2Oj8r1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759530442; c=relaxed/simple;
	bh=hcFIG3T4MNb2ARwn9CRbYr0i6nyOoCICFoYPJ22UP2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGp4iLbd8gWzDM3NGx1CBysluKtZU7/lEKOG33uNg/1UKLXk2p87XK4+WEN80q4/ZUB928BIYwJhr5uLg7Z0/2Sx1upg31EhoJv4xI8vFTeit9kTpbilK+CrB0RuzxENp3JutAsbPJtT0tCSXlnBDYCwgm5aF48oV+6/xVDrNmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mVBDNRQp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1EE41211C26E;
	Fri,  3 Oct 2025 15:27:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1EE41211C26E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759530433;
	bh=40rcjWUu9hqFGXSOLTbk90II9TuVay0g6H1Pk+zi9PA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mVBDNRQpPriXkaBZ21dU9JslMjWjB7RXLfVgnbO9aMhzFwE7DlBa78mmFZrM9HHed
	 SJLs7EIe+9ef5oB5R/ZmExja3O0xttehCrTIiAQkxobuqTZd8OLi8II0OLoqoWrRpy
	 H3K3GSDl5uwYgOlOHDW4Pfd8bw+/vv+mlOwemQi8=
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
Subject: [PATCH hyperv-next v6 01/17] Documentation: hyperv: Confidential VMBus
Date: Fri,  3 Oct 2025 15:26:54 -0700
Message-ID: <20251003222710.6257-2-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003222710.6257-1-romank@linux.microsoft.com>
References: <20251003222710.6257-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define what the confidential VMBus is and describe what advantages
it offers on the capable hardware.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 Documentation/virt/hyperv/coco.rst | 139 ++++++++++++++++++++++++++++-
 1 file changed, 138 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/hyperv/coco.rst b/Documentation/virt/hyperv/coco.rst
index c15d6fe34b4e..e00d94d9f88f 100644
--- a/Documentation/virt/hyperv/coco.rst
+++ b/Documentation/virt/hyperv/coco.rst
@@ -178,7 +178,7 @@ These Hyper-V and VMBus memory pages are marked as decrypted:
 
 * VMBus monitor pages
 
-* Synthetic interrupt controller (synic) related pages (unless supplied by
+* Synthetic interrupt controller (SynIC) related pages (unless supplied by
   the paravisor)
 
 * Per-cpu hypercall input and output pages (unless running with a paravisor)
@@ -232,6 +232,143 @@ with arguments explicitly describing the access. See
 _hv_pcifront_read_config() and _hv_pcifront_write_config() and the
 "use_calls" flag indicating to use hypercalls.
 
+Confidential VMBus
+------------------
+The confidential VMBus enables the confidential guest not to interact with
+the untrusted host partition and the untrusted hypervisor. Instead, the guest
+relies on the trusted paravisor to communicate with the devices processing
+sensitive data. The hardware (SNP or TDX) encrypts the guest memory and the
+register state while measuring the paravisor image using the platform security
+processor to ensure trusted and confidential computing.
+
+Confidential VMBus provides a secure communication channel between the guest
+and the paravisor, ensuring that sensitive data is protected from hypervisor-
+level access through memory encryption and register state isolation.
+
+Confidential VMBus is an extension of Confidential Computing (CoCo) VMs
+(a.k.a. "Isolated" VMs in Hyper-V terminology). Without Confidential VMBus,
+guest VMBus device drivers (the "VSC"s in VMBus terminology) communicate
+with VMBus servers (the VSPs) running on the Hyper-V host. The
+communication must be through memory that has been decrypted so the
+host can access it. With Confidential VMBus, one or more of the VSPs reside
+in the trusted paravisor layer in the guest VM. Since the paravisor layer also
+operates in encrypted memory, the memory used for communication with
+such VSPs does not need to be decrypted and thereby exposed to the
+Hyper-V host. The paravisor is responsible for communicating securely
+with the Hyper-V host as necessary.
+
+The data is transferred directly between the VM and a vPCI device (a.k.a.
+a PCI pass-thru device, see :doc:`vpci`) that is directly assigned to VTL2
+and that supports encrypted memory. In such a case, neither the host partition
+nor the hypervisor has any access to the data. The guest needs to establish
+a VMBus connection only with the paravisor for the channels that process
+sensitive data, and the paravisor abstracts the details of communicating
+with the specific devices away providing the guest with the well-established
+VSP (Virtual Service Provider) interface that has had support in the Hyper-V
+drivers for a decade.
+
+In the case the device does not support encrypted memory, the paravisor
+provides bounce-buffering, and although the data is not encrypted, the backing
+pages aren't mapped into the host partition through SLAT. While not impossible,
+it becomes much more difficult for the host partition to exfiltrate the data
+than it would be with a conventional VMBus connection where the host partition
+has direct access to the memory used for communication.
+
+Here is the data flow for a conventional VMBus connection (`C` stands for the
+client or VSC, `S` for the server or VSP, the `DEVICE` is a physical one, might
+be with multiple virtual functions)::
+
+  +---- GUEST ----+       +----- DEVICE ----+        +----- HOST -----+
+  |               |       |                 |        |                |
+  |               |       |                 |        |                |
+  |               |       |                 ==========                |
+  |               |       |                 |        |                |
+  |               |       |                 |        |                |
+  |               |       |                 |        |                |
+  +----- C -------+       +-----------------+        +------- S ------+
+         ||                                                   ||
+         ||                                                   ||
+  +------||------------------ VMBus --------------------------||------+
+  |                     Interrupts, MMIO                              |
+  +-------------------------------------------------------------------+
+
+and the Confidential VMBus connection::
+
+  +---- GUEST --------------- VTL0 ------+               +-- DEVICE --+
+  |                                      |               |            |
+  | +- PARAVISOR --------- VTL2 -----+   |               |            |
+  | |     +-- VMBus Relay ------+    ====+================            |
+  | |     |   Interrupts, MMIO  |    |   |               |            |
+  | |     +-------- S ----------+    |   |               +------------+
+  | |               ||               |   |
+  | +---------+     ||               |   |
+  | |  Linux  |     ||    OpenHCL    |   |
+  | |  kernel |     ||               |   |
+  | +---- C --+-----||---------------+   |
+  |       ||        ||                   |
+  +-------++------- C -------------------+               +------------+
+          ||                                             |    HOST    |
+          ||                                             +---- S -----+
+  +-------||----------------- VMBus ---------------------------||-----+
+  |                     Interrupts, MMIO                              |
+  +-------------------------------------------------------------------+
+
+An implementation of the VMBus relay that offers the Confidential VMBus
+channels is available in the OpenVMM project as a part of the OpenHCL
+paravisor. Please refer to
+
+  * https://openvmm.dev/, and
+  * https://github.com/microsoft/openvmm
+
+for more information about the OpenHCL paravisor.
+
+A guest that is running with a paravisor must determine at runtime if
+Confidential VMBus is supported by the current paravisor.The x86_64-specific
+approach relies on the CPUID Virtualization Stack leaf; the ARM64 implementation
+is expected to support the Confidential VMBus unconditionally when running
+the ARM CCA guests.
+
+Confidential VMBus is a characteristic of the VMBus connection as a whole,
+and of each VMBus channel that is created. When a Confidential VMBus
+connection is established, the paravisor provides the guest the message-passing
+path that is used for VMBus device creation and deletion, and it provides a
+per-CPU synthetic interrupt controller (SynIC) just like the SynIC that is
+offered by the Hyper-V host. Each VMBus device that is offered to the guest
+indicates the degree to which it participates in Confidential VMBus. The offer
+indicates if the device uses encrypted ring buffers, and if the device uses
+encrypted memory for DMA that is done outside the ring buffer. These settings
+may be different for different devices using the same Confidential VMBus
+connection.
+
+Although these settings are separate, in practice it'll always be encrypted
+ring buffer only, or both encrypted ring buffer and external data. If a channel
+is offered by the paravisor with confidential VMBus, the ring buffer can always
+be encrypted since it's strictly for communication between the VTL2 paravisor
+and the VTL0 guest. However, other memory regions are often used for e.g. DMA,
+so they need to be accessible by the underlying hardware, and must be
+unencrypted (unless the device supports encrypted memory). Currently, there are
+not any VSPs in OpenHCL that support encrypted external memory, but future
+versions are expected to enable this capability.
+
+Because some devices on a Confidential VMBus may require decrypted ring buffers
+and DMA transfers, the guest must interact with two SynICs -- the one provided
+by the paravisor and the one provided by the Hyper-V host when Confidential
+VMBus is not offered. Interrupts are always signaled by the paravisor SynIC,
+but the guest must check for messages and for channel interrupts on both SynICs.
+
+In the case of a confidential VMBus, regular SynIC access by the guest is
+intercepted by the paravisor (this includes various MSRs such as the SIMP and
+SIEFP, as well as hypercalls like HvPostMessage and HvSignalEvent). If the
+guest actually wants to communicate with the hypervisor, it has to use special
+mechanisms (GHCB page on SNP, or tdcall on TDX). Messages can be of either
+kind: with confidential VMBus, messages use the paravisor SynIC, and if the
+guest chose to communicate directly to the hypervisor, they use the hypervisor
+SynIC. For interrupt signaling, some channels may be running on the host
+(non-confidential, using the VMBus relay) and use the hypervisor SynIC, and
+some on the paravisor and use its SynIC. The RelIDs are coordinated by the
+OpenHCL VMBus server and are guaranteed to be unique regardless of whether
+the channel originated on the host or the paravisor.
+
 load_unaligned_zeropad()
 ------------------------
 When transitioning memory between encrypted and decrypted, the caller of
-- 
2.43.0


