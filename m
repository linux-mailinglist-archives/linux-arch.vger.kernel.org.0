Return-Path: <linux-arch+bounces-13270-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D13B34FBC
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 01:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBBA43AF72F
	for <lists+linux-arch@lfdr.de>; Mon, 25 Aug 2025 23:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075241E51FA;
	Mon, 25 Aug 2025 23:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SnN8HPR1"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBDF1E32DB
	for <linux-arch@vger.kernel.org>; Mon, 25 Aug 2025 23:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756164887; cv=none; b=Wp1fvqvNvyZIs/sjoyptXb9KUprG6ZI6OYYGOMbdRfpRNnnR54HytLjrONGTbfWxuKQnYczT8emuafvkAq2P0O9l5DmM0ObmC4S+nDYzOGSd7RcX1Q/VYVwkvHSbvhdb3A0tHi0FrqmHBL2pVuv5dNx1jFXLue/asOFAPaTI/zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756164887; c=relaxed/simple;
	bh=kTJ1dngBPGZL1gqffFZSR9/Ri+4h6ObJ7IhyqTWKMEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3HWhdr22SSEg3AbmkvEw0bVe5oMHtpFI5LGrr7NXg7zxAS8LPQeUNhbQZeOZPVP0CKpS8nOjOOxjMf0LP3f5kDKmooMwn8V4JKNEMCciz8nA2CJS2S6xDv8qPiDxSZuXgINqPEK+aulu32Qy+YVjIW19umdIL8Zt155UEZeQpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SnN8HPR1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8B38F211829D;
	Mon, 25 Aug 2025 16:34:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8B38F211829D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756164885;
	bh=bKHUg3kN3BMPB61jq1Ou+P2RhztFLbNE1srABqKlvzE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SnN8HPR1cy4cmflSYELKP4ObrSYZ4BRrtVGOaNcSf3i4paFe6Bfh+eKWpYx6HT01/
	 gFNNUZ+1JXl32py2eA8FHyRV0fJv3LUkxGn047tKL8SS1dCA4ZOf2D2GDZKW6ogPIP
	 Kq+mzrRLmMQxkRBByGX0rtYNAH6d9/0oV0EtjX2s=
Message-ID: <0e808267-7955-4a37-8726-2a4e3040dd11@linux.microsoft.com>
Date: Mon, 25 Aug 2025 16:34:45 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v4 15/16] Drivers: hv: Support establishing
 the confidential VMBus connection
To: dan.j.williams@intel.com
Cc: Tianyu.Lan@microsoft.com, alok.a.tiwari@oracle.com, apais@microsoft.com,
 arnd@arndb.de, benhill@microsoft.com, bp@alien8.de, bperkins@microsoft.com,
 corbet@lwn.net, dave.hansen@linux.intel.com, decui@microsoft.com,
 haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
 linux-arch@vger.kernel.org, linux-coco@lists.linux.dev
References: <68a4ddff258de_2709100ba@dwillia2-xfh.jf.intel.com.notmuch>
 <20250825222126.356372-1-romank@linux.microsoft.com>
 <68aceb1ad6569_75e310067@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <68aceb1ad6569_75e310067@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/25/2025 4:00 PM, dan.j.williams@intel.com wrote:
> Roman Kisel wrote:
> [..]
>> This doesn't replace TDISP, I'll do a better job of supplementing the code changes
>> with documentation and comments! Any suggestions are greatly appreciated.
> 
> No, I am not asking for documentation and comments and I am asking how
> any of the security claims are validated by this partially enabled L2
> guest?
> 

As the guest is partially enabled, it relies on the trusted paravaisor
which is fully enabled wrt running in a hardware isolated VM. The
paravisor image is measured, there is attestation flow, and the hardware
validates the paravisor image.

[...]

>> The patch set is a building block for building a confidential I/O path for the non-fully
>> enlightened Linux guests. It would be great to have the Linux storage and network stack not
>> to share pages with the host (and not bounce-buffer) if the storage and network are
>> paravirtualized && use the Confidential VMBus. In the first version of the patchset I had
>> patches for that, yet that was considered too naive to be merged in the main line kernel so
>> I dropped them. But even without that, this patch series protects the control plane and the
>> data plane from the host with the exception of the pages the guest might use for bounce-buffering
>> although it could've avoided that in this case.
> 
> The question is what protects against the paravisor lying about its
> identity? If the L2 guest is partially aware that a paravisor is
> providing confidentiality then it needs some interaction with a relying
> party to say "yes, this paravisor is indeed what it claims to be". Is
> that some indicator passed over an established / trusted channel that I
> overlooked?
> 

Trying to understand the question, thinking out loud. The paravisor is
running within the same GPA space as the guest, the host/hv cannot
access the CPU context and the memory assigned to the paravisor and the
guest until they share the pages, the paravisor is measured and goes
through attestation. From that, the customer has the control over the
chain of trust. They can rebuild the paravisor if they wish to do so.

>> I mentioned that the paravisor will be handling the TDISP device for such guests.
>> As folks might know, we use the OpenHCL paravisor which is a Linux kernel with the VTL
>> mode patches we've been upstreaming (links to the repos are in the cover letter), and
>> the OpenVMM running in the user land. The question would be if TDISP isn't available
>> in the Linux kernel, how one would get it working in the OpenHCL paravisor that itself
>> runs Linux? The SEV guest device in the paravisor kernel is being extended to handle
>> TIO. Once TDISP support is available in the mainline kernel, the paravisor will switch
>> to using the mainline implementation.
> 
> Either the L2 is unenlightened and has all its mapping attempts trapped
> and redirected to be encrypted, or the L2 is partially enlightened and
> at a minimum validates the identity of the paravisor.

-- 
Thank you,
Roman


