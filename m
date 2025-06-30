Return-Path: <linux-arch+bounces-12506-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1751CAED940
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 12:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2507189A89A
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 10:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63510251783;
	Mon, 30 Jun 2025 10:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="cd4CeJnW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CJ5o5zH2"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BD91E2858;
	Mon, 30 Jun 2025 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751277783; cv=none; b=mLIZycZ6mWDwBvg7xMMYdTqW5YjwGI4JDfqSOxuwHna9DB6Un2fJUCaJ5Pq3BgwzKXKTKmBPkAnKjCKzByN/SiwvMMV/y+OcrQinQo0Fpd5TES//5RheP50xq12HdOSM+flHX//wKAuEHpAnXYC6a4bI5qgyjUalBPAe7nvPW5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751277783; c=relaxed/simple;
	bh=C19Ng+YvJns31vZggHyOTH4tG4WskcJBUUNS/x4N/rU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dHBwsFxeGjbpyHxl6lmPTr27u57GV9mcaDjp7uE2jwIKkD/kdqZyvduCHiy00bQUgoppaYgckFN4csxLVmkS4lU6J5B1QHGTvQQZR0sklJ2jZwDeD1u2LU+yqbmmQC+ghx1EVjogXmduZh8LcZxFbw8uwgfKt6k3yiNQKdonit4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=cd4CeJnW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CJ5o5zH2; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EC69D7A0228;
	Mon, 30 Jun 2025 06:02:59 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 30 Jun 2025 06:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1751277779;
	 x=1751364179; bh=5/NwZS0sObcR73yPXLZ9doO8bP3vohgc9CV9/MRQ08g=; b=
	cd4CeJnWskomZ2ZPauSEAgYdKBFadxFOHbbcPFRTTalbEC3kxMsiy3mT5fM9+CRT
	6HTnsiCRQaIcJPJy1OSbhXq9QtvSumLK7jj3vYa/w3t0s3GA+rp3KIEwXpHg3+7k
	UpR4KT9xQHHkcqTKN+AC3gMyzikt+HKHsWAvfUoE9rWizGLOFpYa5V7qF3X7WSLb
	VfXRZFCs3gBpPugzallqWwKHikD6cQdMfbV4NkaSw1QrwoL+2/5eX6EuhShVSN3N
	EN1H+Civz9Jl2ofDRCe+nE5mhi3CuqF6O2RX4ZZ/rAnAJCCS/hj4/j2uDSVRLJUS
	DwvqIoXijCGom6+2eNV9GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751277779; x=
	1751364179; bh=5/NwZS0sObcR73yPXLZ9doO8bP3vohgc9CV9/MRQ08g=; b=C
	J5o5zH2jLV15mLK+KiKG4KrIRDNiSdm059Eh19Qh8CF2uD+5hOBOgOMaa/LNNuaH
	UbUlNTbJfTJ3HoUmWSMsCnHCtMbhG+bGCwjjNxpGZx7mb1JaUewK7B2RjEw9J8jo
	mWvFAMSYiDIxs4Czg6cT6JQizvMrAan2GQNh6COzE9kQZ+vS+wZLPg+thccqTqCH
	To8WASijOYZ38+ht6/pyv2GdVV+e7dR+r+LVWqSWwVwCDYgRXD3+joozxxCDMeWP
	DIU40MZdWhEQ2vh53p2H4dNDDOa5p7KH0je3Je609MKgSoJQIu/uUFgDinAX2vEs
	SF+FTT6ahH1ZPQ3/RpLRQ==
X-ME-Sender: <xms:02BiaIRVmGM47HK4-xQ4sK1UVN2FJkKLp2dCdbS_FPrdtWUerI_XhA>
    <xme:02BiaFwdV9ovuDeMnE1gtoYatHzfP-ziRkGlinL2_gocXc4CytSHxlqtwLVFtQwoo
    1H60SjRmu_-VOZ3Edo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeefhfehteffuddvgfeigefhjeetvdekteekjeefkeekleffjeetvedvgefhhfeihfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghp
    thhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlkhhpsehinhhtvg
    hlrdgtohhmpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepughinhhguhihvghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehllhhvmh
    eslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehovgdqkhgsuhhilhguqdgr
    lhhlsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepghhlrghusghithiise
    hphhihshhikhdrfhhuqdgsvghrlhhinhdruggvpdhrtghpthhtohepshgthhhushhtvghr
    rdhsihhmohhnodgsihhnuhhtihhlshesshhivghmvghnshdqvghnvghrghihrdgtohhmpd
    hrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqhhgvgigrghhonhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:02BiaF2AqAuEt3X4uWHFbyqPo5ESQdjWnDsn8JqYvs4BtAo6QiqPBg>
    <xmx:02BiaMChsZpwfEDl04aNZhLioKZG1QBYM-Em-wznYLmp_K4beoBhpA>
    <xmx:02BiaBgjOE6_m_xZ4LpDwxDLLBtr0htDhku4RE5WQcX4y83CI-OTMw>
    <xmx:02BiaIoddWiji4HxGBPX18gZHnJ7QLMJgaPCowYM7yR17UrviqChDw>
    <xmx:02BiaER9MROjnuqlHtynfmqE-nla73GkZHq8805QBlFsNX1msf2EKNdz>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5BDA4700068; Mon, 30 Jun 2025 06:02:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T9274589f850a4c5d
Date: Mon, 30 Jun 2025 12:02:39 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "kernel test robot" <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-sh@vger.kernel.org,
 "Dinh Nguyen" <dinguyen@kernel.org>,
 "Simon Schuster" <schuster.simon+binutils@siemens-energy.com>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "Christian Brauner" <brauner@kernel.org>
Message-Id: <46c6b0f6-6155-4366-9cbf-9fbbfb95ce30@app.fastmail.com>
In-Reply-To: 
 <57101e901013a8e6ff44e10c93d1689490c714bf.camel@physik.fu-berlin.de>
References: <202506282120.6vRwodm3-lkp@intel.com>
 <2ef5bc91-f56d-4c76-b12e-2797999cba72@app.fastmail.com>
 <57101e901013a8e6ff44e10c93d1689490c714bf.camel@physik.fu-berlin.de>
Subject: Re: kernel/fork.c:3088:2: warning: clone3() entry point is missing, please fix
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Jun 30, 2025, at 08:30, John Paul Adrian Glaubitz wrote:
> On Mon, 2025-06-30 at 08:14 +0200, Arnd Bergmann wrote:
>> On Sat, Jun 28, 2025, at 21:59, kernel test robot wrote:
>> 
>> I don't think any of those architecture maintainers are paying
>> attention to the build warnings or the lkp reports, and they are
>> clearly not trying to fix them any more, so maybe it's better to
>> just stop testing them in lkp.
>
> I have seen that warning about clone3() missing but I was not aware that it's
> an urgent issue to address. Do you have any suggestion on how to implement
> that syscall?

Some architectures have custom calling conventions for the
fork/vfork/clone/clone3 syscalls, e.g. to handle copying all the
registers correctly when the normal syscall entry doesn't do that,
or to handle the changing stack correctly.

I see that both sparc and hexagon have a custom clone() syscall,
so they likely need a custom clone3() as well, while sh and
nios2 probably don't.

All four would need a custom assembler implementation in userspace
for each libc, in order to test the userspace calling the clone3()
function. For testing the kernel entry point itself, see Christian's
original test case[1].

     Arnd

[1] https://lore.kernel.org/lkml/20190716130631.tohj4ub54md25dys@brauner.io/

