Return-Path: <linux-arch+bounces-12611-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9046DAFF88C
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 07:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3E55A4184
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 05:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF87728002B;
	Thu, 10 Jul 2025 05:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="UZtpJDyY"
X-Original-To: linux-arch@vger.kernel.org
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C294B2905;
	Thu, 10 Jul 2025 05:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752125833; cv=none; b=ayiemI6cxr+uiC4gRb2EeiHs9XWd6boHVRyMIb0FA5xKbaWtb360Cmz8Z9LXn3diPSVdTbvPnMyMMa2aQpzJg/tqxbLVBXhnw6LI5SeKHnsBatzBf9DnnBMek+coA+skMhFwSpLsmsc+CvQogjE6US+Ax9rsZ4v30h7CeALwNS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752125833; c=relaxed/simple;
	bh=CQh1DInxbfOA81mONPPipgpqdwiFZ+9PeQ0qSReXUEY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=A9dfeCtbHNAc0owlJCykr/enNNCUewGbL/CqzEuhi76DLyc3I9tf2PeROIotnM+Ed8Zb4tIX0K5qBqLFXNNXhoxYXRGqzzSH3v0i34LQ7/kBT1N6tQGJ4oFGanKHW76XAqnLupGFs0um77w2qy6b+OIcuXpQgDKnvZwJO+flK3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=UZtpJDyY; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56A5VD0w409123
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 9 Jul 2025 22:31:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56A5VD0w409123
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1752125475;
	bh=CQh1DInxbfOA81mONPPipgpqdwiFZ+9PeQ0qSReXUEY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=UZtpJDyY0O7zpLI46+afIFDPGTxicGDP5fvGUB8m4RMhn9cHwI0R+GHNT0AKpxNfx
	 t6Pw1pdlDE+7fB6TOn/GWTKlrd0SXt6e6wUteOoCiDCqyhEkAh9A1GbdtI78ilGRSq
	 d+cD61d6QF539bDzPSi4LXpUhpF3mJyZOq+NMUXTlPpvdEy6oYdjcX56K5wyPmDIG7
	 0EoDScUMuLImo9dLMrbgJhQPPugqNm64uHQRAL6lw/17BNapD7Otf6phO1a5PZDcxn
	 6NItttWq5qkxG0SToUdZnGvrCIAUhgHWZdX89R8kylXPNXMBH3XlLDcdQe+toELCEb
	 vwu2G4cUcFKLA==
Date: Wed, 09 Jul 2025 22:31:11 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: dan.j.williams@intel.com, Peter Zijlstra <peterz@infradead.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
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
In-Reply-To: <686f4e20c57cd_1d3d100b7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250624154805.66985-1-Jonathan.Cameron@huawei.com> <20250625085204.GC1613200@noisy.programming.kicks-ass.net> <FB7122A4-BF5E-4C05-805A-2EE3240286A1@zytor.com> <20250625093152.GZ1613376@noisy.programming.kicks-ass.net> <686f4e20c57cd_1d3d100b7@dwillia2-xfh.jf.intel.com.notmuch>
Message-ID: <3EAB3F81-D98C-4E4A-8E44-DB067547B318@zytor.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 9, 2025 10:22:40 PM PDT, dan=2Ej=2Ewilliams@intel=2Ecom wrote:
>Peter Zijlstra wrote:
>> On Wed, Jun 25, 2025 at 02:12:39AM -0700, H=2E Peter Anvin wrote:
>> > On June 25, 2025 1:52:04 AM PDT, Peter Zijlstra <peterz@infradead=2Eo=
rg> wrote:
>> > >On Tue, Jun 24, 2025 at 04:47:56PM +0100, Jonathan Cameron wrote:
>> > >
>> > >> On x86 there is the much loved WBINVD instruction that causes a wr=
ite back
>> > >> and invalidate of all caches in the system=2E It is expensive but =
it is
>> > >
>> > >Expensive is not the only problem=2E It actively interferes with thi=
ngs
>> > >like Cache-Allocation-Technology (RDT-CAT for the intel folks)=2E Do=
ing
>> > >WBINVD utterly destroys the cache subsystem for everybody on the
>> > >machine=2E
>> > >
>> > >> necessary in a few corner cases=2E=20
>> > >
>> > >Don't we have things like CLFLUSH/CLFLUSHOPT/CLWB exactly so that we=
 can
>> > >avoid doing dumb things like WBINVD ?!?
>> > >
>> > >> These are cases where the contents of
>> > >> Physical Memory may change without any writes from the host=2E Whi=
lst there
>> > >> are a few reasons this might happen, the one I care about here is =
when
>> > >> we are adding or removing mappings on CXL=2E So typically going fr=
om
>> > >> there being actual memory at a host Physical Address to nothing th=
ere
>> > >> (reads as zero, writes dropped) or visa-versa=2E=20
>> > >
>> > >> The
>> > >> thing that makes it very hard to handle with CPU flushes is that t=
he
>> > >> instructions are normally VA based and not guaranteed to reach bey=
ond
>> > >> the Point of Coherence or similar=2E You might be able to (ab)use
>> > >> various flush operations intended to ensure persistence memory but
>> > >> in general they don't work either=2E
>> > >
>> > >Urgh so this=2E Dan, Dave, are we getting new instructions to deal w=
ith
>> > >this? I'm really not keen on having WBINVD in active use=2E
>> > >
>> >=20
>> > WBINVD is the nuclear weapon to use when you have lost all notion of
>> > where the problematic data can be, and amounts to a full reset of the
>> > cache system=2E=20
>> >=20
>> > WBINVD can block interrupts for many *milliseconds*, system wide, and
>> > so is really only useful for once-per-boot type events, like MTRR
>> > initialization=2E
>>=20
>> Right this=2E=2E=2E But that CXL thing sounds like that's semi 'regular=
' to
>> the point that providing some infrastructure around it makes sense=2E T=
his
>> should not be=2E
>
>"Regular?", no=2E Something is wrong if you are doing this regularly=2E I=
n
>current CXL systems the expectation is to suffer a WBINVD event once per
>server provisioning event=2E
>
>Now, there is a nascent capability called "Dynamic Capacity Devices"
>(DCD) where the CXL configuration is able to change at runtime with
>multiple hosts sharing a pool of memory=2E Each time the physical memory
>capacity changes, cache management is needed=2E
>
>For DCD, I think the negative effects of WBINVD are a *useful* stick to
>move device vendors to stop relying on software to solve this problem=2E
>They can implement an existing CXL protocol where the device tells CPUs
>and other CXL=2Ecache agents to invalidate the physical address ranges
>that the device owns=2E
>
>In other words, if WBINVD makes DCD inviable that is a useful outcome
>because it motivates unburdening Linux long term with this problem=2E
>
>In the near term though, current CXL platforms that do not support
>device-initiated-invalidate still need coarse cache management for that
>original infrequent provisioning events=2E Folks that want to go further
>and attempt frequent DCD events with WBINVD get to keep all the pieces=2E

Since this is presumably rare, it might be better to loop and clflush, eve=
n though it will take longer, rather than stopping the world=2E

