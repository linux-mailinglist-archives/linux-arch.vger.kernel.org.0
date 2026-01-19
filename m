Return-Path: <linux-arch+bounces-15873-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 627F3D3B92D
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 22:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32EF530864EE
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 21:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAC12F7ABB;
	Mon, 19 Jan 2026 21:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="eTz1pzSv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58962F9C3D;
	Mon, 19 Jan 2026 21:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857191; cv=none; b=MfQXlVtllx57SgP0rwqI5XuWC54QGvHqbq56aRz9JltonEhxdpUcypLCbOfSfkIlCVZ0hEfJpXGA9UkKjtquS+zBm6tvOOxCEnUdL8vTCslsZaq4iUNDnZTxDH3paIGOg1MTB7tz/+RQ5m7r1/34LQVw3WJQyw7NUAED4OpRXgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857191; c=relaxed/simple;
	bh=lO21w8YI62eDPVGN/zRNqGCyxqbEKdCyOC+Ijx/wSMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fS8d68qZCVSsTSHRx/uDnMC6BW113XK5U3yQ93ScukwrInyOpRKaFmsc6adcOOJtVH0rKi4iSNCObR/z7+ieuSLW2j1SRYSJczpWIOtn3l47iufgHGp1qF5UX3RgxerDYdWjCj8DVRFK/RVcfffEUDw6HmiE/zH9YerQb69Ew3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=eTz1pzSv; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9483:13a:c452:d5de:4aa7] ([IPv6:2601:646:8081:9483:13a:c452:d5de:4aa7])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 60JLCIGR3152313
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 19 Jan 2026 13:12:30 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 60JLCIGR3152313
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025122301; t=1768857152;
	bh=SzNZZN5J1ffXvI4mZJ9mNoD2W0pR7DkOp5TvgAGiTfI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eTz1pzSv5xPcKf9MqcDrJkTY8yQfAFdGl2lY435TB2HmDzBUtmX8It7UCjXXiYOJl
	 QzHlRVEfTN0NIuJLNOwmi7pzWQT1HXm6AJgSIFSAF0ydOnVz8Z6JC0XN69ErNff4gf
	 yXXXg5ft1fZG1t6gk7lGUTRyWb7yP6pTVvbLPpHo9q1t6z5rbNm6omuKBEMOiROZ3I
	 9BBtEijPPY/1vepKUXNRXkGoymEXBsiVUYD1L1mtcsPJ9CIglME21nrtdSTZZTfanL
	 iXdnR6ankJ32ZHdbGgYfedbt1h3AQDRiHZyTfHj7QHdrREXNaKU+jw3DsYpJXRvbHJ
	 vRzNCTDyilnZQ==
Message-ID: <f3bd8bfd-d66c-45fe-a634-9ac418806f40@zytor.com>
Date: Mon, 19 Jan 2026 13:12:13 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] asm-generic/bitsperlong.h: Add sanity checks for
 __BITS_PER_LONG
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
 <20260116-vdso-compat-checkflags-v1-4-4a83b4fbb0d3@linutronix.de>
 <1a77fda4-3cf6-4c19-aa36-b5f0e305b313@zytor.com>
 <20260119163559-b20b14d7-56ca-4f17-8800-83f618d778b8@linutronix.de>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260119163559-b20b14d7-56ca-4f17-8800-83f618d778b8@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026-01-19 07:39, Thomas Weißschuh wrote:
>>
>> Do we actually support any compilers which *don't* define __SIZEOF_LONG__?
> 
> When building the kernel not. I used this pattern because it is used
> further up in the file. There it makes sense as it is actually a userspace
> header which needs to support all kinds of compilers.
> But this new check is gated behind __KERNEL__ anyways...
> For the next revision I will move it into the regular kernel-internal
> bitsperlong.h. That will be less confusing and still handle the vDSO build,
> due to the way our header hierarchy works.
> 

The point is that we can simply do:

#define __BITS_PER_LONG (__SIZEOF_LONG__ << 3)

... and it will always be consistent.

	-hpa


