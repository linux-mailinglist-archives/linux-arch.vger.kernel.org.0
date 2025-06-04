Return-Path: <linux-arch+bounces-12188-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 922E6ACD0C0
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 02:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7A5188A90F
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 00:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174D11804A;
	Wed,  4 Jun 2025 00:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ERvUQIfx"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9B8846C;
	Wed,  4 Jun 2025 00:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748997827; cv=none; b=AiR8xMEA5yY8irEph3QnfQdmBmebgOdkZrdLQurCfjweeDIZvX2sKXc9xyMGyBXoge3SzUhYKNESiZLmR3xLW/eWNTS9sfF2ysNGcjbfeU+xYQC2a16bQ8c3tBIJ9693JPDCuD6hnPlZgFGQrKaK5dm2dOAlVmBE3Xl+uNElTHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748997827; c=relaxed/simple;
	bh=dhZK/mbD/B/W3rp8HtrbqjPVQLXYz17gmLzX9jVAw0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVKMjxieZ6mDdjAfOYZxmzKZRJRXtQ760Eh2OcH0xFDCLhGgbLV/cahHxpgthWivlUCGAL03L1BfYbeEpoibH2/fk5DPITUIojVBeS/HqqzMEEDn7JFMTqQcT6F3voSutAlKpGLoidlDXEc370mqR98xxCth6Y5JU8m/omAEyPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ERvUQIfx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id B24F32115DDF;
	Tue,  3 Jun 2025 17:43:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B24F32115DDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748997824;
	bh=L0zwZxej62ckeG9kTheAzPG/t1KXKM3djWbh+qBjdxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ERvUQIfx+DNJMbA2TMQQNHq9H31u5J7ONl+QVFCfpJByurULEdhdYmBX9YODgO7S/
	 5o05HVgqa1yY6FPTd+A9VYS76IV7ygbINnNJLS8AjrvUW6rieYQwnaRJi1v1GD3fGe
	 ZxoQ1QB2jOvY6sN6gVyoE6dNxSVmwvm43WGbae3o=
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
Subject: [PATCH hyperv-next v3 01/15] Documentation: hyperv: Confidential VMBus
Date: Tue,  3 Jun 2025 17:43:27 -0700
Message-ID: <20250604004341.7194-2-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604004341.7194-1-romank@linux.microsoft.com>
References: <20250604004341.7194-1-romank@linux.microsoft.com>
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
---
 Documentation/virt/hyperv/coco.rst | 125 ++++++++++++++++++++++++++++-
 1 file changed, 124 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/hyperv/coco.rst b/Documentation/virt/hyperv/coco.rst
index c15d6fe34b4e..b4904b64219d 100644
--- a/Documentation/virt/hyperv/coco.rst
+++ b/Documentation/virt/hyperv/coco.rst
@@ -178,7 +178,7 @@ These Hyper-V and VMBus memory pages are marked as decrypted:
 
 * VMBus monitor pages
 
-* Synthetic interrupt controller (synic) related pages (unless supplied by
+* Synthetic interrupt controller (SynIC) related pages (unless supplied by
   the paravisor)
 
 * Per-cpu hypercall input and output pages (unless running with a paravisor)
@@ -258,3 +258,126 @@ normal page fault is generated instead of #VC or #VE, and the page-fault-
 based handlers for load_unaligned_zeropad() fixup the reference. When the
 encrypted/decrypted transition is complete, the pages are marked as "present"
 again. See hv_vtom_clear_present() and hv_vtom_set_host_visibility().
+
+Confidential VMBus
+------------------
+
+The confidential VMBus enables the confidential guest not to interact with the
+untrusted host partition and the untrusted hypervisor. Instead, the guest relies
+on the trusted paravisor to communicate with the devices processing sensitive
+data. The hardware (SNP or TDX) encrypts the guest memory and the register state
+while measuring the paravisor image using the platform security processor to
+ensure trusted and confidential computing.
+
+Confidential VMBus provides a secure communication channel between the guest and
+the paravisor, ensuring that sensitive data is protected from  hypervisor-level
+access through memory encryption and register state isolation.
+
+The unencrypted data never leaves the VM so neither the host partition nor the
+hypervisor can access it at all. In addition to that, the guest only needs to
+establish a VMBus connection with the paravisor for the channels that process
+sensitive data, and the paravisor abstracts the details of communicating with
+the specific devices away.
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
+with the Hyper-V host as necessary. In some cases (e.g. time synchonization,
+key-value pairs exchange) the unencrypted data doesn't need to be communicated
+with the host at all, and a conventional VMBus connection suffices.
+
+Here is the data flow for a conventional VMBus connection and the Confidential
+VMBus connection (C stands for the client or VSC, S for the server or VSP):
+
++---- GUEST ----+       +----- DEVICE ----+        +----- HOST -----+
+|               |       |                 |        |                |
+|               |       |                 |        |                |
+|               |       |                 ==========                |
+|               |       |                 |        |                |
+|               |       |                 |        |                |
+|               |       |                 |        |                |
++----- C -------+       +-----------------+        +------- S ------+
+       ||                                                   ||
+       ||                                                   ||
++------||------------------ VMBus --------------------------||------+
+|                     Interrupts, MMIO                              |
++-------------------------------------------------------------------+
+
++---- GUEST --------------- VTL0 ------+               +-- DEVICE --+
+|                                      |               |            |
+| +- PARAVISOR --------- VTL2 -----+   |               |            |
+| |     +-- VMBus Relay ------+    ====+================            |
+| |     |   Interrupts, MMIO  |    |   |               |            |
+| |     +-------- S ----------+    |   |               +------------+
+| |               ||               |   |
+| +---------+     ||               |   |
+| |  Linux  |     ||    OpenHCL    |   |
+| |  kernel |     ||               |   |
+| +---- C --+-----||---------------+   |
+|       ||        ||                   |
++-------++------- C -------------------+               +------------+
+        ||                                             |    HOST    |
+        ||                                             +---- S -----+
++-------||----------------- VMBus ---------------------------||-----+
+|                     Interrupts, MMIO                              |
++-------------------------------------------------------------------+
+
+An implementation of the VMBus relay that offers the Confidential VMBus channels
+is available in the OpenVMM project as a part of the OpenHCL paravisor. Please
+refer to https://openvmm.dev/ and https://github.com/microsoft/openvmm for more
+information about the OpenHCL paravisor.
+
+A guest that is running with a paravisor must determine at runtime if
+Confidential VMBus is supported by the current paravisor. It does so by first
+trying to establish a Confidential VMBus connection with the paravisor using
+standard mechanisms where the memory remains encrypted. If this succeeds,
+then the guest can proceed to use Confidential VMBus. If it fails, then the
+guest must fallback to establishing a non-Confidential VMBus connection with
+the Hyper-V host.
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
+ring buffer only or both encrypted ring buffer and external data. If a channel
+is offered by the paravisor with confidential VMBus, the ring buffer can always
+be encrypted since it's strictly for communication between the VTL2 paravisor
+and the VTL0 guest. However, other memory regions are often used for e.g. DMA,
+so they need to be accessible by the underlying hardware, and must be unencrypted
+(unless the device supports encrypted memory). Currently, there are no any VSPs
+in OpenHCL that support encrypted external memory, but we will use it in the
+future.
+
+Because some devices on a Confidential VMBus may require decrypted ring buffers
+and DMA transfers, the guest must interact with two SynICs -- the one provided
+by the paravisor and the one provided by the Hyper-V host when Confidential
+VMBus is not offered. Interrupts are always signaled by the paravisor SynIC, but
+the guest must check for messages and for channel interrupts on both SynICs.
+
+In the case of a confidential VM, regular SynIC access by the guest is
+intercepted by the paravisor (this includes various MSRs such as the SIMP and
+SIEFP, as well as hypercalls like HvPostMessage and HvSignalEvent). If the guest
+actually wants to communicate with the hypervisor, it has to use special mechanisms
+(GHCB page on SNP, or tdcall on TDX). Messages will always be one or the other:
+with confidential VMBus, all messages use the paravisor SynIC, otherwise they all
+use the hypervisor SynIC. For interrupt signaling, though, some channels may be
+running on the host (non-confidential, using the VMBus relay) and use the hypervisor
+SynIC, and some on the paravisor and use its SynIC. The RelIDs are coordinated by
+the OpenHCL VMBus server and are guaranteed to be unique regardless of whether
+the channel originated on the host or the paravisor.
-- 
2.43.0


