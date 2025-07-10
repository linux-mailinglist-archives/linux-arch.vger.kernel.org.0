Return-Path: <linux-arch+bounces-12643-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110AEB00BBC
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 20:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6349D7ABF1F
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 18:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805F72264D7;
	Thu, 10 Jul 2025 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="frt+T+Za"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518A31547CC;
	Thu, 10 Jul 2025 18:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752173793; cv=none; b=vF6FkXdBm42csnNK8C6jS+MsZSfhAFgo5ZVvWeIuzqSGtv4t6LX29uS18Yv835sD67XrIpICh4pmemDZ71FWcjmMXDT+j9upX0Usz0gwn5W6CZtFLw9l8rQTf09XG2monrZO5osGQO6fQxOuWZ3APH73zoGmKWIXUUvgMowXPlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752173793; c=relaxed/simple;
	bh=VHHMCaeqa3ItN0IdhB57c8hhMJMuVoReCsE7UCNIal4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Fzbu+YhVCf/hl3uy9qfTE9gKUU5PEEmsUJvnL1SSW3BN8rGyAiw6a94pVRUoXZwsv3HiP/8hfZvc5VzDfiutNFNVNxyoAtiiiyYhBj2nGGRuvsZeydhQCHQtIU6jMxW6E0rYtn0yNzp3Lectk1NLLQ1RDLs5JKdpaucqTB4ViRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=frt+T+Za; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56AItXe4768856
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 10 Jul 2025 11:55:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56AItXe4768856
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1752173735;
	bh=VHHMCaeqa3ItN0IdhB57c8hhMJMuVoReCsE7UCNIal4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=frt+T+ZaeHOU5+grV1JCbpKos7M5bBqjph3654o1y7phYKwQfJ56+GDy8KNryK8B9
	 XF2XuNuAABlhHhXW6fYJQLupzUof4nSKjKrhEjsEL35qhyfZVmkeQZVTH89pnSOq+U
	 kBtp64m7He32K7XBQnvn/+b2ktp+IKWKSyCA0ity2XZp1oE453fLiVLHeHJcG4u0q4
	 0G//nuisw6F0H9abazQkXmJZxXo+Sa2Lnk8gPh0vCepk2mHF2Uw2+NhXZh3+A/cCO6
	 uFIYPUSkQ8VouPb6FPWHZ2tDFL2g//rbNfp9FYNLkTeM5fCaiDsWlNrZNlmTJ0g1D0
	 XYwyrqszcEIDg==
Date: Thu, 10 Jul 2025 11:55:33 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: dan.j.williams@intel.com, Peter Zijlstra <peterz@infradead.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
        linux-cxl@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, gregkh@linuxfoundation.org,
        Will Deacon <will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
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
In-Reply-To: <68700a5428a2f_1d3d1008b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250624154805.66985-1-Jonathan.Cameron@huawei.com> <20250625085204.GC1613200@noisy.programming.kicks-ass.net> <FB7122A4-BF5E-4C05-805A-2EE3240286A1@zytor.com> <20250625093152.GZ1613376@noisy.programming.kicks-ass.net> <686f4e20c57cd_1d3d100b7@dwillia2-xfh.jf.intel.com.notmuch> <20250710105622.GA542000@noisy.programming.kicks-ass.net> <68700a5428a2f_1d3d1008b@dwillia2-xfh.jf.intel.com.notmuch>
Message-ID: <575B5DF2-AE1D-43E9-9A4B-09FB78EFFC43@zytor.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 10, 2025 11:45:40 AM PDT, dan=2Ej=2Ewilliams@intel=2Ecom wrote:
>Peter Zijlstra wrote:
>> On Wed, Jul 09, 2025 at 10:22:40PM -0700, dan=2Ej=2Ewilliams@intel=2Eco=
m wrote:
>>=20
>> > "Regular?", no=2E Something is wrong if you are doing this regularly=
=2E In
>> > current CXL systems the expectation is to suffer a WBINVD event once =
per
>> > server provisioning event=2E
>>=20
>> Ok, so how about we strictly track this once, and when it happens more
>> than this once, we error out hard?
>>=20
>> > Now, there is a nascent capability called "Dynamic Capacity Devices"
>> > (DCD) where the CXL configuration is able to change at runtime with
>> > multiple hosts sharing a pool of memory=2E Each time the physical mem=
ory
>> > capacity changes, cache management is needed=2E
>> >=20
>> > For DCD, I think the negative effects of WBINVD are a *useful* stick =
to
>> > move device vendors to stop relying on software to solve this problem=
=2E
>> > They can implement an existing CXL protocol where the device tells CP=
Us
>> > and other CXL=2Ecache agents to invalidate the physical address range=
s
>> > that the device owns=2E
>> >=20
>> > In other words, if WBINVD makes DCD inviable that is a useful outcome
>> > because it motivates unburdening Linux long term with this problem=2E
>>=20
>> Per the above, I suggest we not support this feature *AT*ALL* until an
>> alternative to WBINVD is provided=2E
>>=20
>> > In the near term though, current CXL platforms that do not support
>> > device-initiated-invalidate still need coarse cache management for th=
at
>> > original infrequent provisioning events=2E Folks that want to go furt=
her
>> > and attempt frequent DCD events with WBINVD get to keep all the piece=
s=2E
>>=20
>> I would strongly prefer those pieces to include WARNs and or worse=2E
>
>That is fair=2E It is not productive for the CXL subsystem to sit back an=
d
>hope that people notice the destructive side-effects of wbinvd and hope
>that leads to device changes=2E
>
>This discussion has me reconsidering that yes, it would indeed be better
>to clflushopt loop over potentially terabytes on all CPUs=2E That should
>only be suffered rarely for the provisioning case, and for the DCD case
>the potential add/remove events should be more manageable=2E
>
>drm already has drm_clflush_pages() for bulk cache management, CXL
>should just align on that approach=2E

Let's not be flippant; looping over terabytes could take *hours*=2E But th=
ose are hours during which the system is alive, and only one CPU needs to b=
e looping=2E

The other question is: what happens if memory is unplugged and then a cach=
e line evicted? I'm guessing that existing memory hotplug solutions simply =
drop the writeback, since the OS knows there is no valid memory there, and =
so any cached data is inherently worthless=2E

