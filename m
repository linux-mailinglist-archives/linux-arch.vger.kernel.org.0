Return-Path: <linux-arch+bounces-15869-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DD7D3AF31
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 16:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 974B83037522
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 15:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD2B38A9B3;
	Mon, 19 Jan 2026 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="VwZi4id+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9CC358D16;
	Mon, 19 Jan 2026 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768836867; cv=none; b=jOLUKAqn2j2xQVkF2whaFJzvmF/cHE4eTV1K3z3F6r+bZjpeKwpar9LgoxL1IaUPPu3y2gh0aFUYELIJ/uxwofponPoqcdQchSc42vocA+ZVghceKxwTu0T0EEzKYCKx+kmP8FtgV5ZUGDN5762z+spV8YNRRV4Kbv/12HsbVWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768836867; c=relaxed/simple;
	bh=NcKInReWm5YQxR5FryyX76yerQYcqrt3nalDSXS7vBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRJwhoSX3lTaJ/2ovVtppuNfsitMknigqMQtwQ0bQMQ/JdhTXNaZME7QZ01SY0I1fq4Z6MFFTLnrV784g9bVoa4qXVbpwmcSB4teW5tHYBFk5wFYdlK33nkJS0PaWNhzJLlLp2coGFg4LrkfvDuAsuYsskq2Mm36AD3jLKm15EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=VwZi4id+; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9483:13a:c452:d5de:4aa7] ([IPv6:2601:646:8081:9483:13a:c452:d5de:4aa7])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 60JFXJwl2977448
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 19 Jan 2026 07:33:46 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 60JFXJwl2977448
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025122301; t=1768836827;
	bh=6Jcq5LWRqtEvNJV1i0+wD6XGL3eXImUE64L1x29/M2U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VwZi4id+fnAbs5zreO9+d/I5WlNsEfKdh+0/RnPRwMXBng52tcxyLeTf38eRFaQt8
	 JDYkx6GywQc0Lb/b8iA2gfJDB0lczV+AESHoJcuD6yyx/CbAe+W+V/UsRm0fR0pg6m
	 W0T31rKyJuiDU7iFIvQjMlwBMd3HXNK7vbS7NehIfpiDG3l8xFavNlrLdRqFsFC3qK
	 CyBMNkbOUuU6MTc39nVdhCkyXQfrgCKboVhDUXMJ5zRvYYx35xXww7kRPjYp1+kcO6
	 kHycRWQqsBvLXygO2I2A3XOR0nGFrjUgOKguNBMdwN0LLhL7d8Zj7FhJuTaYi8xEB2
	 OgHtq0Flg2iCw==
Message-ID: <8deae27e-1e9f-4bc0-8d60-0173cf92942f@zytor.com>
Date: Mon, 19 Jan 2026 07:33:30 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] x86/vdso: Use 32-bit CHECKFLAGS for compat vDSO
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        Thomas Gleixner <tglx@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, Sun Jian <sun.jian.kdev@gmail.com>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
 <20260116-vdso-compat-checkflags-v1-2-4a83b4fbb0d3@linutronix.de>
 <87bjir3nfy.ffs@tglx>
 <20260119081917-f47ff5da-4465-4b3e-8c94-42b96c932583@linutronix.de>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260119081917-f47ff5da-4465-4b3e-8c94-42b96c932583@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026-01-18 23:20, Thomas Weißschuh wrote:
> On Sat, Jan 17, 2026 at 11:05:05PM +0100, Thomas Gleixner wrote:
>> On Fri, Jan 16 2026 at 08:40, Thomas Weißschuh wrote:
>>> Manually override the CHECKFLAGS for the compat vDSO with the correct
>>> 32-bit configuration.
>>
>> Fun. I just fixed the same thing half an hour ago:
>>
>>    https://lore.kernel.org/lkml/20260117215542.342638347@kernel.org/
> 
> Assuming you are going to apply your patches bevore, can I respin my
> remaining patches on top of tip/x86/entry?
> 

Please do.

	-hpa


