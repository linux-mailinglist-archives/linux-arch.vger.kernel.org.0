Return-Path: <linux-arch+bounces-12124-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA8FAC42C0
	for <lists+linux-arch@lfdr.de>; Mon, 26 May 2025 18:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D7C1887AA2
	for <lists+linux-arch@lfdr.de>; Mon, 26 May 2025 16:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB84212D67;
	Mon, 26 May 2025 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VQcTQFFF"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC98211A0C;
	Mon, 26 May 2025 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748275330; cv=none; b=fG071xaBuDWC8srlBwMZio7+5QQh3NukjRVCLz7vJRJfw8YfPuDX3ZgbP8qFbWoAdzm0XzbybYnOoiOZLTDH1d06HrbBnCeMZuobUxjSfP0yT6kXbUfjD6UVGw7Ssq7SWWQVwp9kFLW9RdwunQRdc/WgCWcTUymru/0RCVPErsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748275330; c=relaxed/simple;
	bh=eV1epbg80l6Ne/TEKOgw8HRG8mB4eIwJFkbx2Y9b4n4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGoCcEjDxugkznaqLO556iOvbLAdFd52J6u2u/2G0teRD6GtEklnOr7KaQoYD0O+S8k7wJRm8RycxzNEcVUIMH37UqD5l2n7EXwAY0Y2PL4GaYI+NtZdNlCpS/NGFuklI369VcfOQsEqjA/9yCy4mzUrQ3Wrc0wxjxV5aT/SSJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VQcTQFFF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id C86E42068336;
	Mon, 26 May 2025 09:02:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C86E42068336
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748275323;
	bh=xbVnkPRVpMtVn5Z4ZBr7rm8h5rSjIm70f4DaBrWVIqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VQcTQFFFHvc4iuNUgmNMyC6xui2eGdu15QhEiNHf2/v1oaOuK59MkaUzqoMHl0NsA
	 l+kQojT+RkIdLTERp5TMFTTcXS02VU1NFRqKvpdrnTHvh02Z/4eGtJu7dT5HZMSNCS
	 fVkdhIj8m1XE5j0GwcxLq7OpaiSuGWePJ51f2cdg=
From: Roman Kisel <romank@linux.microsoft.com>
To: mhklinux@outlook.com
Cc: apais@microsoft.com,
	arnd@arndb.de,
	benhill@microsoft.com,
	bp@alien8.de,
	bperkins@microsoft.com,
	catalin.marinas@arm.com,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	romank@linux.microsoft.com,
	sunilmut@microsoft.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	will@kernel.org,
	x86@kernel.org
Subject: RE: [PATCH hyperv-next v2 1/4] Documentation: hyperv: Confidential VMBus
Date: Mon, 26 May 2025 09:02:01 -0700
Message-ID: <20250526160201.2535-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <SN6PR02MB4157DC69BA25D889CD838D04D49DA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <SN6PR02MB4157DC69BA25D889CD838D04D49DA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> From: Roman Kisel <romank@linux.microsoft.com> Sent: Sunday, May 11, 2025 4:08 PM
>> 
>> Define what the confidential VMBus is and describe what advantages
>> it offers on the capable hardware.
>> 
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> ---
>>  Documentation/virt/hyperv/vmbus.rst | 41 +++++++++++++++++++++++++++++
>>  1 file changed, 41 insertions(+)
>> 
>> diff --git a/Documentation/virt/hyperv/vmbus.rst
>> b/Documentation/virt/hyperv/vmbus.rst
>> index 1dcef6a7fda3..ca2b948e5070 100644
>> --- a/Documentation/virt/hyperv/vmbus.rst
>> +++ b/Documentation/virt/hyperv/vmbus.rst
>> @@ -324,3 +324,44 @@ rescinded, neither Hyper-V nor Linux retains any state about
>>  its previous existence. Such a device might be re-added later,
>>  in which case it is treated as an entirely new device. See
>>  vmbus_onoffer_rescind().
>> +
>> +Confidential VMBus
>> +------------------
>> +
>> +The confidential VMBus provides the control and data planes where
>> +the guest doesn't talk to either the hypervisor or the host. Instead,
>> +it relies on the trusted paravisor. The hardware (SNP or TDX) encrypts
>> +the guest memory and the register state also measuring the paravisor
>> +image via using the platform security processor to ensure trusted and
>> +confidential computing.
>> +
>> +To support confidential communication with the paravisor, a VMBus client
>> +will first attempt to use regular, non-isolated mechanisms for communication.
>> +To do this, it must:
>> +
>> +* Configure the paravisor SIMP with an encrypted page. The paravisor SIMP is
>> +  configured by setting the relevant MSR directly, without using GHCB or tdcall.
>> +
>> +* Enable SINT 2 on both the paravisor and hypervisor, without setting the proxy
>> +  flag on the paravisor SINT. Enable interrupts on the paravisor SynIC.
>> +
>> +* Configure both the paravisor and hypervisor event flags page.
>> +  Both pages will need to be scanned when VMBus receives a channel interrupt.
>> +
>> +* Send messages to the paravisor by calling HvPostMessage directly, without using
>> +  GHCB or tdcall.
>> +
>> +* Set the EOM MSR directly in the paravisor, without using GHCB or tdcall.
>> +
>> +If sending the InitiateContact message using non-isolated HvPostMessage fails,
>> +the client must fall back to using the hypervisor synic, by using the GHCB/tdcall
>> +as appropriate.
>> +
>> +To fall back, the client will have to reconfigure the following:
>> +
>> +* Configure the hypervisor SIMP with a host-visible page.
>> +  Since the hypervisor SIMP is not used when in confidential mode,
>> +  this can be done up front, or only when needed, whichever makes sense for
>> +  the particular implementation.
>> +
>> +* Set the proxy flag on SINT 2 for the paravisor.
>
>I'm assuming there's no public documentation available for how Confidential
>VMBus works. If so, then this documentation needs to take a higher-level
>approach and explain the basic concepts. You've provided some nitty-gritty
>details about how to detect and enable Confidential VMBus, but I think that
>level of detail would be better as comments in the code.
>
>Here's an example of what I envision, with several embedded questions that
>need further explanation. Confidential VMBus is completely new to me, so
>I don't know the answers to the questions. I also think this documentation
>would be better added to the CoCo VM topic instead of the VMBus topic, as
>Confidential VMBus is an extension/enhancement to CoCo VMs that doesn't
>apply to normal VMs.
>
>------------------------------------------
>
>Confidential VMBus is an extension of Confidential Computing (CoCo) VMs
>(a.k.a. "Isolated" VMs in Hyper-V terminology). Without Confidential VMBus,
>guest VMBus device drivers (the "VSC"s in VMBus terminology) communicate
>with VMBus servers (the VSPs) running on the Hyper-V host. The
>communication must be through memory that has been decrypted so the
>host can access it. With Confidential VMBus, one or more of the VSPs reside
>in the trusted paravisor layer in the guest VM. Since the paravisor layer also
>operates in encrypted memory, the memory used for communication with
>such VSPs does not need to be decrypted and thereby exposed to the
>Hyper-V host. The paravisor is responsible for communicating securely
>with the Hyper-V host as necessary.  [Does the paravisor do this in a way
>that is better than what the guest can do? This question seems to be core to
>the value prop for Confidential VMBus. I'm not really clear on the value
>prop.]
>
>A guest that is running with a paravisor must determine at runtime if
>Confidential VMBus is supported by the current paravisor. It does so by first
>trying to establish a Confidential VMBus connection with the paravisor using
>standard mechanisms where the memory remains encrypted. If this succeeds,
>then the guest can proceed to use Confidential VMBus. If it fails, then the
>guest must fallback to establishing a non-Confidential VMBus connection with
>the Hyper-V host.
>
>Confidential VMBus is a characteristic of the VMBus connection as a whole,
>and of each VMBus channel that is created. When a Confidential VMBus
>connection is established, the paravisor provides the guest the message-passing
>path that is used for VMBus device creation and deletion, and it provides a
>per-CPU synthetic interrupt controller (SynIC) just like the SyncIC that is
>offered by the Hyper-V host. Each VMBus device that is offered to the guest
>indicates the degree to which it participates in Confidential VMBus. The offer
>indicates if the device uses encrypted ring buffers, and if the device uses
>encrypted memory for DMA that is done outside the ring buffer. [Are these
>two settings independent? Could there be a device that has one set, and the
>other cleared? I'm having trouble understanding what such a mixed state
>would mean.] These settings may be different for different devices using
>the same Confidential VMBus connection.
>
>Because some devices on a Confidential VMBus may require decrypted ring
>buffers and DMA transfers, the guest must interact with two SynICs -- the
>one provided by the paravisor and the one provided by the Hyper-V host
>when Confidential VMBus is not offered. Interrupts are always signaled by
>the paravisor SynIC, but the guest must check for messages and for channel
>interrupts on both SynICs.  [This requires some further explanation that I
>don't understand. What governs when a message arrives via the paravisor
>SynIC vs. the hypervisor SynIC, and when a VMBus channel indicates an
>interrupt in the paravisor SynIC event page vs. the hypervisor SynIC event
>page? And from looking at the code, it appears that the RelIDs assigned
>to channels are guaranteed to be unique within the guest VM, and not
>per-SynIC, but it would be good to confirm that.]
>
>[There are probably a few other topics to add a well.]

Michael,

Appreciate your help very much! I'll fill the gaps you've pointed out in
this patch and other ones.

--
Thank you,
Roman

