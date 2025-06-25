Return-Path: <linux-arch+bounces-12451-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0398AAE7C4A
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jun 2025 11:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954073B3B52
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jun 2025 09:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA81129CB3E;
	Wed, 25 Jun 2025 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="W+B0I6fa"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5AB2877CB;
	Wed, 25 Jun 2025 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750842839; cv=none; b=CBZm3XcitiKXr/uc797kOYkOmGOtVbEHa6lCSxzNc4HkCJMo2ythPQOMQnISh1j4WbsRAiNAvC1x1+Dd5JX3jC+zq6H3I7s/5s5MF/bTy0lU41xk34LuZ4n5bAr3SlYIIm1GGPDWFenTk1z/lFt7uKkGD3K++qhCSG6sYFhox8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750842839; c=relaxed/simple;
	bh=Q0/RM2kQyckW7LSQ3VeyfPEi1mattHTjXA79SYKL5MQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=R2TqWzsKYFBSHFrCFyCXMtntBgASa83bSsUd9J6NfGqvrQHMV21uSCcyKVVMaBi8ZrHGKHmUnFWcYvay7LgbZlFHvWsHI0fCr+Jz6l9NEZh4bzDuIDSsR4i5UQ0WLWNKHfRr/KpgXDUmYAL4jBGx7lBWTNFaVqzaxfHgAMt2sVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=W+B0I6fa; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 55P9CeH61706513
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 25 Jun 2025 02:12:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 55P9CeH61706513
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1750842761;
	bh=Q0/RM2kQyckW7LSQ3VeyfPEi1mattHTjXA79SYKL5MQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=W+B0I6fat7CBMT8xxv1mOc55VFltc/zjXsP3OwTMiTTZtyf3Fsi+bvE02lJgVO1F2
	 IuAz3EgL52KsFKV+kBlMfDlHRSSqrMPwCg18mlwvplgdehXFaGUTw6a++Ax4KL2kKw
	 FIQeeDSEq/A0BTqA1La3+DGCze68qT1gBK+gs79Vc2z5CkyhDqmHK7WUQlL7UsHmOp
	 d4ytIvUBcHN0QkrMS5NBIkyc85ZqDXjDMGXTKEDF86V1yqYddYtivujm+OYCDZjVGc
	 u0Wjl5yVuoFGi7OgzLoMZ20RQT2WTKH3AXcxbMIqftnevMQ06REiTtc4pqGPTXnfDk
	 hVKVhJdC3xoFg==
Date: Wed, 25 Jun 2025 02:12:39 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Peter Zijlstra <peterz@infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
        linux-cxl@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, gregkh@linuxfoundation.org,
        Will Deacon <will@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Yicong Yang <yangyicong@huawei.com>, linuxarm@huawei.com,
        Yushan Wang <wangyushan12@huawei.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 0/8] Cache coherency management subsystem
User-Agent: K-9 Mail for Android
In-Reply-To: <20250625085204.GC1613200@noisy.programming.kicks-ass.net>
References: <20250624154805.66985-1-Jonathan.Cameron@huawei.com> <20250625085204.GC1613200@noisy.programming.kicks-ass.net>
Message-ID: <FB7122A4-BF5E-4C05-805A-2EE3240286A1@zytor.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 25, 2025 1:52:04 AM PDT, Peter Zijlstra <peterz@infradead=2Eorg> wr=
ote:
>On Tue, Jun 24, 2025 at 04:47:56PM +0100, Jonathan Cameron wrote:
>
>> On x86 there is the much loved WBINVD instruction that causes a write b=
ack
>> and invalidate of all caches in the system=2E It is expensive but it is
>
>Expensive is not the only problem=2E It actively interferes with things
>like Cache-Allocation-Technology (RDT-CAT for the intel folks)=2E Doing
>WBINVD utterly destroys the cache subsystem for everybody on the
>machine=2E
>
>> necessary in a few corner cases=2E=20
>
>Don't we have things like CLFLUSH/CLFLUSHOPT/CLWB exactly so that we can
>avoid doing dumb things like WBINVD ?!?
>
>> These are cases where the contents of
>> Physical Memory may change without any writes from the host=2E Whilst t=
here
>> are a few reasons this might happen, the one I care about here is when
>> we are adding or removing mappings on CXL=2E So typically going from
>> there being actual memory at a host Physical Address to nothing there
>> (reads as zero, writes dropped) or visa-versa=2E=20
>
>> The
>> thing that makes it very hard to handle with CPU flushes is that the
>> instructions are normally VA based and not guaranteed to reach beyond
>> the Point of Coherence or similar=2E You might be able to (ab)use
>> various flush operations intended to ensure persistence memory but
>> in general they don't work either=2E
>
>Urgh so this=2E Dan, Dave, are we getting new instructions to deal with
>this? I'm really not keen on having WBINVD in active use=2E
>

WBINVD is the nuclear weapon to use when you have lost all notion of where=
 the problematic data can be, and amounts to a full reset of the cache syst=
em=2E=20

WBINVD can block interrupts for many *milliseconds*, system wide, and so i=
s really only useful for once-per-boot type events, like MTRR initializatio=
n=2E

