Return-Path: <linux-arch+bounces-12517-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90769AEE291
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 17:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C90189C61D
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 15:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB1C28F930;
	Mon, 30 Jun 2025 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="MnqXWOgg"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB7E28A1D4;
	Mon, 30 Jun 2025 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297571; cv=none; b=frCN7F50NT7Lv89lVHXybBDPqzHM5PfRkCJtQ1FX3LB4YYjS/1vIyOGY3qZUUChGhcO0nn9NnO0RiVE5JP+9erP4mTfjM0JNYU2xIOSjUpmgKyCgAM1YaKwqZDD2TPsxnegO0rkGxUeKRqQODfMAMsQueNT5mxqQNMN1nKNVt54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297571; c=relaxed/simple;
	bh=T5lSKSr/aPOKJcx+aLJlz6q2pyOBR4NaNMddccYdZtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aUueSX0p8zAmrriGdCr46hY2Ucc/op8oaxFDSr3BakMRYCyasymAitSRisWrX+F+dy4h19rMEG0ez8sDJgYuDHT5loP8LMSqBvDAlxKuDjz8ussPNHdFO5Wt215UBNKlQ/dyWazqZDNQvVlyV445WZGGCxjzWwbxI7riKYp2RUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=MnqXWOgg reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4bW91K5Vlnz1DDh0;
	Mon, 30 Jun 2025 17:24:05 +0200 (CEST)
Received: from [10.10.15.6] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4bW91K1FcDz1DNGp;
	Mon, 30 Jun 2025 17:24:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1751297045;
	bh=TCuz8wYG0OMRJ5WGli0CVDLwlocoMhb5D/fgiqVnow0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MnqXWOgg+jJ+lZh0c5wrl4nReL6iOScU6lufaG3dZAGHiHfytBMOHPZqvRHbD2Ch+
	 m3U5qEx3lGc07rftyLldqu3P2rEUhxMgpqRgnKbqNB6rbm8ZPGl7Z5GRnNFl54NULj
	 cYGVNSDVLDwWcXicbCo0wu4QY5q7gNpubXjqI4du0EyF4EA2MUgnuuZsd5YJi0CMQO
	 OI+x59rBYIg79jAvqHYkOBQrXlm9kSd8nSZSQW7LLcrL0TtyRDXliUDBjbg3ybYuXg
	 MFrtWV18MT54DALHfihwuneTrj6shn+LnBXam7JCPVDFdqwVyx38JJRsKW+4/r+53h
	 OSYvaYC3MnG0A==
Message-ID: <dfd0a228-940d-4c30-b07e-9f3910e3aeaf@gaisler.com>
Date: Mon, 30 Jun 2025 17:24:04 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel/fork.c:3088:2: warning: clone3() entry point is missing,
 please fix
To: Arnd Bergmann <arnd@arndb.de>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 kernel test robot <lkp@intel.com>, Philip Li <philip.li@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-sh@vger.kernel.org,
 Dinh Nguyen <dinguyen@kernel.org>,
 Simon Schuster <schuster.simon+binutils@siemens-energy.com>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>
References: <202506282120.6vRwodm3-lkp@intel.com>
 <2ef5bc91-f56d-4c76-b12e-2797999cba72@app.fastmail.com>
 <57101e901013a8e6ff44e10c93d1689490c714bf.camel@physik.fu-berlin.de>
 <46c6b0f6-6155-4366-9cbf-9fbbfb95ce30@app.fastmail.com>
 <5375b5bb7221cf878d1f93e60e72807f66e26154.camel@physik.fu-berlin.de>
 <ccf937cb-a139-4a07-aa47-4006b880b025@app.fastmail.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <ccf937cb-a139-4a07-aa47-4006b880b025@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-06-30 14:07, Arnd Bergmann wrote:
> On Mon, Jun 30, 2025, at 12:45, John Paul Adrian Glaubitz wrote:
>> On Mon, 2025-06-30 at 12:02 +0200, Arnd Bergmann wrote:
>>> Some architectures have custom calling conventions for the
>>> fork/vfork/clone/clone3 syscalls, e.g. to handle copying all the
>>> registers correctly when the normal syscall entry doesn't do that,
>>> or to handle the changing stack correctly.
>>>
>>> I see that both sparc and hexagon have a custom clone() syscall,
>>> so they likely need a custom clone3() as well, while sh and
>>> nios2 probably don't.
>>>
>>> All four would need a custom assembler implementation in userspace
>>> for each libc, in order to test the userspace calling the clone3()
>>> function. For testing the kernel entry point itself, see Christian's
>>> original test case[1].
>>
>> Thanks for the explanation. So, I guess as long as a proposed implementation
>> of clone3() on sh would pass Arnd's test program, it should be good for merging?
> 
> Yes, Christian's test program should be enough for merging into
> the kernel, though I would recommend also coming up with the matching
> glibc patch, in order to ensure it can actually be regression tested
> automatically, and to use the new features provided by glibc clone3().
> 
> Right now glibc assumes that clone3() is available on linux-5.3 or
> higher and uses it to implement the normal clone() in that case,
> except where the implementation is missing.
> 
> I see that at alpha, csky, parisc and microblaze have a kernel
> implementation in modern Linux versions, but are missing the
> glibc wrapper for it, as the kernel side was done later without
> the glibc version. sparc and sh are the only ones with a glibc
> port that are missing both the kernel and userspace side,
> while hexagon and nios2 are not currently part of mainline glibc.

Thanks for all the input Arnd! All this will be very good to have at
hand when looking into implementing and testing it!

I was not aware that clone3 was used under the hood in glibc. Given that
clone3 is not exposed by glibc to the outside I did not realize that
glibc would actually use it, so it never got high enough up in the
priority even though I have been well aware of it being missing.

Stopping the testing of these architectures in lkp because of the
missing clone3 would be unfortunate and a bit excessive in my view. That
testing is and has been very useful!

Cheers,
Andreas

