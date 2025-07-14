Return-Path: <linux-arch+bounces-12756-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F32CB04A24
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 00:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D93CE4A1466
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 22:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DE5277035;
	Mon, 14 Jul 2025 22:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QYl2kgST"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA481B87E9;
	Mon, 14 Jul 2025 22:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531349; cv=none; b=txnCbT9lHNaznNogue5k1RkqK2Re0K35W4tjXm7z0BSehxnJD/trRG5zFVdGxaHtoGhHoT3Or2VdnBkQXGUB9kzkqVWAbwXv9riQOOR8rjg3wyl+Iw2o8KWXCjn0N/sKqXQqmvXtg2wXXDMDY3pmP5z5FCe/4B0Fin839ot7DQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531349; c=relaxed/simple;
	bh=OyGH4spMrhcywIaQjsDzr0V2fG7hh6BSdDn/2ukWmsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MayNQHNCCTpInvDow+1gqXoUUkvuffGo6qp9eN1VOmPwcgLNzyzhX/B5jIzyvCgN3TXJVIXsYCfG93KYFfqx12qEj2qxOLYAGi5JlZgpMRf0yZebUAQpOufr92WNdUl/B/GzPiz2eHjC0h+aTtemejNpWMerTLaOJdNouNukiko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QYl2kgST; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3A8E22016578;
	Mon, 14 Jul 2025 15:15:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3A8E22016578
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752531347;
	bh=tF4KjrMlXUSFdjACqUuSOArtP8vWogRQxSVvgwAGV6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QYl2kgSTQwafee9SG6N50zHSHIWK7KyWQexAVJDjT/Ug8JspfrHPxvxIxvor3WYmb
	 7Y46PM4nVYwQ1D8/d0IOedp8hnIALmqli0rnZSyOsJxrjaPfxe/eoHQHKvLIoVU4+V
	 ZRz4FXuvu67wfKh/HrohS7LO4ln71dM9ov2ZTOsg=
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
	mhklinux@outlook.com,
	mingo@redhat.com,
	rdunlap@infradead.org,
	tglx@linutronix.de,
	Tianyu.Lan@microsoft.com,
	wei.liu@kernel.org,
	linux-arch@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v4 01/16] Documentation: hyperv: Confidential VMBus
Date: Mon, 14 Jul 2025 15:15:30 -0700
Message-ID: <20250714221545.5615-2-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714221545.5615-1-romank@linux.microsoft.com>
References: <20250714221545.5615-1-romank@linux.microsoft.com>
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
 Documentation/virt/hyperv/coco.rst | 140 ++++++++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/hyperv/coco.rst b/Documentation/virt/hyperv/coco.rst
index c15d6fe34b4e..e8515acfe306 100644
--- a/Documentation/virt/hyperv/coco.rst
+++ b/Documentation/virt/hyperv/coco.rst
@@ -178,7 +178,7 @@ These Hyper-V and VMBus memory pages are marked as decrypted:
 
 * VMBus monitor pages
 
-* Synthetic interrupt controller (synic) related pages (unless supplied by
+* Synthetic interrupt controller (SynIC) related pages (unless supplied by
   the paravisor)
 
 * Per-cpu hypercall input and output pages (unless running with a paravisor)
@@ -232,6 +232,144 @@ with arguments explicitly describing the access. See
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
+The data won't ever leave the VM when a device is attached to VTL2, and the
+device supports encrypted memory. Therefore, neither the host partition nor the
+hypervisor can access the data being processed at all. The guest needs to
+establish a VMBus connection only with the paravisor for the channels that
+process sensitive data, and the paravisor abstracts the details of
+communicating with the specific devices away providing the guest with the
+well-established VSP (Virtual Service Provider) interface that has had support
+in the Hyper-V drivers for a decade.
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
+Confidential VMBus is supported by the current paravisor. It does so by
+first trying to establish a Confidential VMBus connection with the paravisor
+usingstandard mechanisms where the memory remains encrypted. If this succeeds,
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


