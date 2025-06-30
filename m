Return-Path: <linux-arch+bounces-12510-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD94AEDC52
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 14:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA39D179832
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 12:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8DC289838;
	Mon, 30 Jun 2025 12:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="iugN6wBE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UZ7ycnM8"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C78B23A987;
	Mon, 30 Jun 2025 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751285303; cv=none; b=SMPOHJMBVBRXxxZJEh8z/Z4xSRRPoT+hFVHm6AuteL5y54qTHwdi8lJzqad2WeV7qZ0wu7WVE35vMRZM4qLWkH34M4eqv5ihJrz2aJT+dqjf6BDP48rFOKYdDcgmhhOOCKdV+SAvYRyu2lhWO9HruFzylrEzFJyh2/Lx8u6xNbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751285303; c=relaxed/simple;
	bh=ZZFsv75i5DyeRoNwPNk5Y+xJh0q+P/KZtwKC9QqMkEQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=klw1EuNL9acXNJrbYWewQBL8FudKVqHfN9ZtyMolvM7BRz/2SHrQjBi2FfUQs/EInxMvSS3OV/I1CbYvwY9VistuCYa1PHqKqoDoP5eVQmV1RaqKsNHJQmSrGgVLiCVz1JIv3RU17CYwC2lweAIz81XoAejLGC+sdo0usyfIGNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=iugN6wBE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UZ7ycnM8; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 56229EC0462;
	Mon, 30 Jun 2025 08:08:20 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 30 Jun 2025 08:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1751285300;
	 x=1751371700; bh=yA4pB/ln0DpXJQFu0EMsyGjmOJrxSRSOcs2tGhcBfiI=; b=
	iugN6wBEfLrLIsOpfsE7dIFwzFoetLZ209ragPJTslG+Q8vsgw/xOTHcLdBLUlVm
	ndU9Wtf+GF6m3CMFF37GgzgIG942Gaf2Xi+9HU9EZO7e/Y/X04WIgxXAyYtWUyW9
	CJabDAHvS+KWDX/0RTRkg6gRajY/hCXRXMN0qd86u6sfHC6aC+JJsqEKCMMKETaB
	z1JOd6ZVCpHw0iPa/+1GuXmdHaeLgbfhnFcgiCGH3HYf5v1PPVcTes0OHNeOzKpO
	La1rGSh1cdHllR37z6nVWttzsdgD/Ajjv+oyq+Srhr3YdO61xneUvQRwRVIiTRMu
	s4BypaMeasqIFoUYIRSUjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751285300; x=
	1751371700; bh=yA4pB/ln0DpXJQFu0EMsyGjmOJrxSRSOcs2tGhcBfiI=; b=U
	Z7ycnM8RZuVvBBBuljXJq4LhjzZNjY9IqIT/89BBugRodoIRVxx1RKh5sluqSdSB
	GdHNPgaC2t+G9qK0MRLysdyNlDjlXppPkZQDYI/VL5+RrVQewUlrQ/uQQHJVffzl
	3ofwRX+GM2Zkp+twAzf3WGlUwdrySyJEW98VvCDBtZ6qEotvBu/WnhqzZOIc+4Op
	1qxtItUmV70Rr6HfSTKeGLHYMdlO5MsBTqzhcwOtQK2zSiT5A/pdb3E8qoTMFm0n
	zvhAZ01OIaAyVqm/MBzszwbnA+ouGGJRIj6KIe/IczQyMmAh/9vKZiBXewq+FoYo
	P4QCiy9nAcRWR9JHI545g==
X-ME-Sender: <xms:M35iaHThVK9hc5fV8Y7q4vYLytwXKGSjl3hS9t410f19wTGDJfVMYg>
    <xme:M35iaIxSmKAGGZbHFyp1NdybIzTnZC7Hzp7SxUafnSuYaaSA4HBrjvOoWag6Qo5L3
    biXGflrRai8DVqpDV4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhkphesihhnthgvlhdrtghomhdprhgtphhtthhopegsrhgruhhnvg
    hrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguihhnghhuhigvnheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhlvhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtg
    hpthhtohepohgvqdhksghuihhlugdqrghllheslhhishhtshdrlhhinhhugidruggvvhdp
    rhgtphhtthhopehglhgruhgsihhtiiesphhhhihsihhkrdhfuhdqsggvrhhlihhnrdguvg
    dprhgtphhtthhopehstghhuhhsthgvrhdrshhimhhonhdosghinhhuthhilhhssehsihgv
    mhgvnhhsqdgvnhgvrhhghidrtghomhdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhhvgigrghgohhn
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:M35iaM1FdbOFfKqqI_dgsxajeKECIOaEiMxsytq1m7tl05CtpZbBzA>
    <xmx:M35iaHBShCmBmYhlrecMCoYFT1AoslmOOwbeiAaF-ahwJoUx_jR4-A>
    <xmx:M35iaAh-6-oA2baOhW6ZKJeU4CQUAD4fris2SoALFvoyJB9Lk0Hidw>
    <xmx:M35iaLp1xjlq-k66C1nuz67F1rx7M95KmzDCIwh11pdVTnAL7LH0Sg>
    <xmx:NH5iaPS4a9l9hu-H1VKC-r4u_z3OfbQaLQsaiOQ91aNmfwJQ6JV17pQq>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A869570006A; Mon, 30 Jun 2025 08:08:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T9274589f850a4c5d
Date: Mon, 30 Jun 2025 14:07:58 +0200
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
Message-Id: <ccf937cb-a139-4a07-aa47-4006b880b025@app.fastmail.com>
In-Reply-To: 
 <5375b5bb7221cf878d1f93e60e72807f66e26154.camel@physik.fu-berlin.de>
References: <202506282120.6vRwodm3-lkp@intel.com>
 <2ef5bc91-f56d-4c76-b12e-2797999cba72@app.fastmail.com>
 <57101e901013a8e6ff44e10c93d1689490c714bf.camel@physik.fu-berlin.de>
 <46c6b0f6-6155-4366-9cbf-9fbbfb95ce30@app.fastmail.com>
 <5375b5bb7221cf878d1f93e60e72807f66e26154.camel@physik.fu-berlin.de>
Subject: Re: kernel/fork.c:3088:2: warning: clone3() entry point is missing, please fix
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Jun 30, 2025, at 12:45, John Paul Adrian Glaubitz wrote:
> On Mon, 2025-06-30 at 12:02 +0200, Arnd Bergmann wrote:
>> Some architectures have custom calling conventions for the
>> fork/vfork/clone/clone3 syscalls, e.g. to handle copying all the
>> registers correctly when the normal syscall entry doesn't do that,
>> or to handle the changing stack correctly.
>> 
>> I see that both sparc and hexagon have a custom clone() syscall,
>> so they likely need a custom clone3() as well, while sh and
>> nios2 probably don't.
>> 
>> All four would need a custom assembler implementation in userspace
>> for each libc, in order to test the userspace calling the clone3()
>> function. For testing the kernel entry point itself, see Christian's
>> original test case[1].
>
> Thanks for the explanation. So, I guess as long as a proposed implementation
> of clone3() on sh would pass Arnd's test program, it should be good for merging?

Yes, Christian's test program should be enough for merging into
the kernel, though I would recommend also coming up with the matching
glibc patch, in order to ensure it can actually be regression tested
automatically, and to use the new features provided by glibc clone3().

Right now glibc assumes that clone3() is available on linux-5.3 or
higher and uses it to implement the normal clone() in that case,
except where the implementation is missing.

I see that at alpha, csky, parisc and microblaze have a kernel
implementation in modern Linux versions, but are missing the
glibc wrapper for it, as the kernel side was done later without
the glibc version. sparc and sh are the only ones with a glibc
port that are missing both the kernel and userspace side,
while hexagon and nios2 are not currently part of mainline glibc.

     Arnd

