Return-Path: <linux-arch+bounces-12606-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CFAAFF293
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jul 2025 22:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 725C63AAA7B
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jul 2025 20:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C38F24336D;
	Wed,  9 Jul 2025 20:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="MNAPTSqG"
X-Original-To: linux-arch@vger.kernel.org
Received: from slateblue.cherry.relay.mailchannels.net (slateblue.cherry.relay.mailchannels.net [23.83.223.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D01242907;
	Wed,  9 Jul 2025 20:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091341; cv=pass; b=hAClNd64iJZRsV1VV/SKO3otbj6ba/bbUPb/aa20PiDfrSszGcS0Ue9hwZSvC6JdD/La55xZshcavk4NT9DhM4VKPZf1TWmBjNRZdVzjbNd7LaFU0DB36n1LOrbWffHqTBjHk0sWcZPf8Od0OmJ8Xa0mucAc3VL940sbEr3JaOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091341; c=relaxed/simple;
	bh=T7+gk4yndEAXxrNbTlbrYpYmnRnH6YglAKEGyZm6Jvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7bQPbaqIH8EwyjeRF026BgVIU5qX7Fx9V/IpbyfABngwp8SjP7M53puBaiW67SzUZ9xKqn3+jVpCS1x1Ib5E6J6NMwWSBENx+rZWTILE4uNBTEUsZfKcLYD9w2jmArtkzW39feTQrjESaDZstpsOOMg1B3SPVc+pnxoQ3g+fhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=MNAPTSqG; arc=pass smtp.client-ip=23.83.223.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E1BD5902FB6;
	Wed,  9 Jul 2025 19:53:16 +0000 (UTC)
Received: from pdx1-sub0-mail-a220.dreamhost.com (trex-green-6.trex.outbound.svc.cluster.local [100.111.53.65])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 2D743903243;
	Wed,  9 Jul 2025 19:53:15 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1752090795; a=rsa-sha256;
	cv=none;
	b=0ZOBVuLcMnJG4nUtPqunO2ilkmQD8f6QmXJRaRw4oHqljM3hvIMnSWB8YJiBgbXEmRnmm3
	9FHFvmYSzrylACfjluli6jZnuKHo7pt5uiVWWHJbPo4D9ZxeHPAqgEE05/Ga0JaiFenTi4
	S6frqWHQ723eDPoVyDM8M5YEVH3BwbTkvfBvmN1b0H1lrK3MjT9dwe0BKJKBiwBlHbD07P
	5lLaw34A29zdXuAYuhWcOuYuARMUWy51gVMuvwEMzC0+t3LEngCV1k/yXLCSEEY4g9V7I4
	W9De6I8grFZFnq48XKZzatgU78yE9cDujSr6io8cpiT7hFvX1YLcaWi12yMeJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1752090795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=T7+gk4yndEAXxrNbTlbrYpYmnRnH6YglAKEGyZm6Jvk=;
	b=kNo7zS5ttuqZZC68w8PCWFd/otpMIgUDnCgvNzHQHfGXsf697u5vAXiGGa/agEViQDhEmy
	/YWFofPSzqpvoMBV5etpeoD6qEuj7YKycLhDlhlOAr3NZiF3H1T0/gCI/qbEU04bnqRG+3
	RlGfu1zAK6d88GXjqwXdKr1XSMcz129JUt8VcD8QtYGi57rP4UDG5P3JPGQi3O60IJ5Nva
	zbPu3Dokog5yZLr+9ZuiabYQGs78Qb6b9arUXC4lmMyJyKuDf+4vZaX2SYJ47TUaeYlWZH
	rOn+YV3RMsJLS+xb21ggOaf4K/HzVuqDjCH9Cs70lfcNBj1f6LR3JvFUOUeFBw==
ARC-Authentication-Results: i=1;
	rspamd-5c976dc8b-dj4rr;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Eyes-Callous: 2336bfa936ee4816_1752090795798_3380218129
X-MC-Loop-Signature: 1752090795797:4037420958
X-MC-Ingress-Time: 1752090795797
Received: from pdx1-sub0-mail-a220.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.111.53.65 (trex/7.1.3);
	Wed, 09 Jul 2025 19:53:15 +0000
Received: from offworld (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a220.dreamhost.com (Postfix) with ESMTPSA id 4bcpYj4DQfz7F;
	Wed,  9 Jul 2025 12:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1752090795;
	bh=T7+gk4yndEAXxrNbTlbrYpYmnRnH6YglAKEGyZm6Jvk=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=MNAPTSqGqIUV9YlJMB4z55PsBA59V9i/q1iBdovNWtX3x01yj3XRlx+GvEjTbvzfk
	 5GLEebuebBRx/675NKzuPV28KiJosUny0+rcXQeU57XGYYZdwoPbbE+HJfmB/+W1No
	 /TFPyyAtIVjnTCt4A/hJh9MSRHeHNQtRKYZydYXcrOouHE/kuIpOoAPSWEXNJaSA5T
	 kPLrEBn2l7Zbg8xkzmPMBkbUzkdY5+uxyHN/UzgRHAlpDGacLNTd/TsAbSkSaTOkaM
	 OtQmt/8ATb2ksJmH4qNJk4ffjrJy0J5a+X2XAyPkfLFZmRVRy65ftxxj1HszhLJdn5
	 W8oZdfHmKn8sA==
Date: Wed, 9 Jul 2025 12:53:10 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
	linux-cxl@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org,
	Will Deacon <will@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Yicong Yang <yangyicong@huawei.com>, linuxarm@huawei.com,
	Yushan Wang <wangyushan12@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
	Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [PATCH v2 0/8] Cache coherency management subsystem
Message-ID: <20250709195310.7ofioxl5vpqs6rib@offworld>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
	linux-cxl@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org,
	Will Deacon <will@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Yicong Yang <yangyicong@huawei.com>, linuxarm@huawei.com,
	Yushan Wang <wangyushan12@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
	Adam Manzanares <a.manzanares@samsung.com>
References: <20250624154805.66985-1-Jonathan.Cameron@huawei.com>
 <20250625085204.GC1613200@noisy.programming.kicks-ass.net>
 <FB7122A4-BF5E-4C05-805A-2EE3240286A1@zytor.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <FB7122A4-BF5E-4C05-805A-2EE3240286A1@zytor.com>
User-Agent: NeoMutt/20220429

On Wed, 25 Jun 2025, H. Peter Anvin wrote:

>On June 25, 2025 1:52:04 AM PDT, Peter Zijlstra <peterz@infradead.org> wrote:
>>On Tue, Jun 24, 2025 at 04:47:56PM +0100, Jonathan Cameron wrote:
>>
>>> On x86 there is the much loved WBINVD instruction that causes a write back
>>> and invalidate of all caches in the system. It is expensive but it is
>>
>>Expensive is not the only problem. It actively interferes with things
>>like Cache-Allocation-Technology (RDT-CAT for the intel folks). Doing
>>WBINVD utterly destroys the cache subsystem for everybody on the
>>machine.
>>
>>> necessary in a few corner cases.
>>
>>Don't we have things like CLFLUSH/CLFLUSHOPT/CLWB exactly so that we can
>>avoid doing dumb things like WBINVD ?!?
>>
>>> These are cases where the contents of
>>> Physical Memory may change without any writes from the host. Whilst there
>>> are a few reasons this might happen, the one I care about here is when
>>> we are adding or removing mappings on CXL. So typically going from
>>> there being actual memory at a host Physical Address to nothing there
>>> (reads as zero, writes dropped) or visa-versa.
>>
>>> The
>>> thing that makes it very hard to handle with CPU flushes is that the
>>> instructions are normally VA based and not guaranteed to reach beyond
>>> the Point of Coherence or similar. You might be able to (ab)use
>>> various flush operations intended to ensure persistence memory but
>>> in general they don't work either.
>>
>>Urgh so this. Dan, Dave, are we getting new instructions to deal with
>>this? I'm really not keen on having WBINVD in active use.
>>
>
>WBINVD is the nuclear weapon to use when you have lost all notion of where the problematic data can be, and amounts to a full reset of the cache system.
>
>WBINVD can block interrupts for many *milliseconds*, system wide, and so is really only useful for once-per-boot type events, like MTRR initialization.

Correct, and cpu_cache_invalidate_memregion() was introduced exactly
with these constraints in mind, and the current x86 is the worse case
scenario. As Jonathan pointed out, ranged optimizations only improve
what is already there.

Thanks,
Davidlohr

