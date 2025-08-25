Return-Path: <linux-arch+bounces-13268-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8192FB34F21
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 00:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995381A84E6D
	for <lists+linux-arch@lfdr.de>; Mon, 25 Aug 2025 22:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F642BD59C;
	Mon, 25 Aug 2025 22:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="b8uj2Vlf"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DCC29D26C;
	Mon, 25 Aug 2025 22:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756161681; cv=none; b=TA7BwnX32IPTi1NnYqeJgOH75tFCaoDdhhkMnP/GmZMBaRI9dw21mFILYriJSUG8IvjbK1GJ9d4lEYd8uFV/3fTl+XRF+sSBgmnrTIxbalGRxeUkcnapmF92boVkqXUhgBEIcFvdFApVgI0IKFmLUg8T51ybdYWpXHqoJ/2OWEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756161681; c=relaxed/simple;
	bh=vENPD8qIYT0SxnJvVGHSlqT6IgLPf2Q+JP29FkUujyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kR4n02ydmjKgejVdJzJnLWcA0RwRKOLLgdIDdb545c/hEFl+vgb4iFEcs8nKzY3yY5A3m9C7ro3//DjeQigh9zdcsVWvFZfVRWqqMpiY71L/uJM+ZVxgZsw/eeBGxpwSBI80l8gKTc1+cAlMAzQzOb+xioNDfmiKk4yzBYJk7rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=b8uj2Vlf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4F71E211829B;
	Mon, 25 Aug 2025 15:41:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4F71E211829B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756161679;
	bh=4V+Di2CdNqpVDQpM4RzbnLiWDx2BluMDafouDHKyG8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b8uj2VlfaJc8cUSf3cp8QIWiLVMDA0I6acFWKSRutFKxvRSVRxNEI5i6h7LTLr2lm
	 9d/01sTCBI4LyyY41CphZFLzHuiozoulcz66giqgRJO5Nv5lU0IBMFRl8Rm9NcuyXS
	 OAbQ8HTLq/d+Kf+fhIlklCqG0J5qp0jrMGEt+acI=
From: Roman Kisel <romank@linux.microsoft.com>
To: dan.j.williams@intel.com
Cc: Tianyu.Lan@microsoft.com,
	alok.a.tiwari@oracle.com,
	apais@microsoft.com,
	arnd@arndb.de,
	benhill@microsoft.com,
	bp@alien8.de,
	bperkins@microsoft.com,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	linux-arch@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mhklinux@outlook.com,
	mingo@redhat.com,
	rdunlap@infradead.org,
	romank@linux.microsoft.com,
	sunilmut@microsoft.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH hyperv-next v4 15/16] Drivers: hv: Support establishing the confidential VMBus connection
Date: Mon, 25 Aug 2025 15:41:17 -0700
Message-ID: <20250825224117.360875-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <68a4ddff258de_2709100ba@dwillia2-xfh.jf.intel.com.notmuch>
References: <68a4ddff258de_2709100ba@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[...]
>> +	 *
>> +	 * All scenarios here are:
>> +	 *	1. No paravisor,
>> +	 *  2. Paravisor without VMBus relay, no hardware isolation,
>> +	 *  3. Paravisor without VMBus relay, with hardware isolation,
>> +	 *  4. Paravisor with VMBus relay, no hardware isolation,
>> +	 *  5. Paravisor with VMBus relay, with hardware isolation.
>> +	 *
>>
> I read this blurb looking for answers to my question below, no luck, and
> left further wondering what is the comment trying to convey to future
> maintenance?

The intention was to enumerate scenarios in which the driver executes
this code to document what to expect of the conditional statement

| if (ms_hyperv.paravisor_present && (hv_isolation_type_tdx() || hv_isolation_type_snp()))

[...]

> In comparison to PCIe TDISP where there is an explicit validation step
> of cryptographic evidence that the platform is what it claims to be, I
> am missing the same for this.
>

This doesn't replace TDISP, I'll do a better job of supplementing the code changes
with documentation and comments! Any suggestions are greatly appreciated.

A fully-enlightened Linux guest could just use TDISP once support for that is available
in the Linux kernel. Before it is, the non-fully enlightened Linux guests (they can only deal
with accepting memory and sharing memory with the host) could rely on the paravisor to talk
to such devices. The TDISP device will be connected to the paravisor, and the paravisor will
provide the paravirtualized storage and network over the VMBus channels to the Linux guest.

The patch set is a building block for building a confidential I/O path for the non-fully
enlightened Linux guests. It would be great to have the Linux storage and network stack not
to share pages with the host (and not bounce-buffer) if the storage and network are
paravirtualized && use the Confidential VMBus. In the first version of the patchset I had
patches for that, yet that was considered too naive to be merged in the main line kernel so
I dropped them. But even without that, this patch series protects the control plane and the
data plane from the host with the exception of the pages the guest might use for bounce-buffering
although it could've avoided that in this case.

I mentioned that the paravisor will be handling the TDISP device for such guests.
As folks might know, we use the OpenHCL paravisor which is a Linux kernel with the VTL
mode patches we've been upstreaming (links to the repos are in the cover letter), and
the OpenVMM running in the user land. The question would be if TDISP isn't available
in the Linux kernel, how one would get it working in the OpenHCL paravisor that itself
runs Linux? The SEV guest device in the paravisor kernel is being extended to handle
TIO. Once TDISP support is available in the mainline kernel, the paravisor will switch
to using the mainline implementation.

> I would expect something like a paravisor signed golden measurement with
> a certificate that can be built-in to the kernel to validate that "yes,
> in addition to the platform claims that can be emulated, this bus
> enumeration is signed by an authority this kernel image trusts."
>
> My motivation for commenting here is for alignment purposes with the
> PCIe TDISP enabling and wider concerns about accepting other devices for
> private operation. Specifically, I want to align on a shared
> representation in the device-core (struct device) to communicate that a
> device is either on a bus that has been accepted for private operation
> (confidential-vmbus today, potentially signed-ACPI-devices tomorrow), or
> is a device that has been individually accepted for private operation
> (PCIe TDISP). In both cases there needs to be either a golden
> measurement mechanism built-in, or a userspace acceptance dependency in
> the flow.
>
> Otherwise what mitigates a guest conveying secrets to a device that is
> merely emulating a trusted bus/device?

