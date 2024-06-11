Return-Path: <linux-arch+bounces-4838-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E369045A4
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 22:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5838BB214CA
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 20:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660043839C;
	Tue, 11 Jun 2024 20:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="O4UuX8Jx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F8612E61;
	Tue, 11 Jun 2024 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718136979; cv=none; b=O84KcacIsUWi7Hb3HUeWUgoU8WpoMFj2Yu1KBqZKe0OzI3mcljMZ3NohJ5fgczkiXtGcCvUAfyUPZw5C/buD2FR5F5hRC+FLPvoOh+KWLO/iKcfd/g4sxUfuwh17QmId8BALwTVTUzds9ROVir3Dar7OOVa80PA3vQmMvhXUfp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718136979; c=relaxed/simple;
	bh=HAK2OHutCS/Lj87z2/N+VGndKX2mskGP86pdblWyp2w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=eVQdZjdKYWwDw1kYllGc9YHhavqydKMXq79PFqqBcj+TOAvxxLlx9vShDrio+g2w2hPOyMC05LCZBIcOYYx9Ttmmm+gcuLxPYOigpsBxRN576CDMJIvonZfK5eD9RUFXMAUzTED+d4uxGkOE0QWwTgvgIOnt1fEgJ5dqK7ht+/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=O4UuX8Jx; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([99.8.153.148])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45BKFlxc3470245
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 11 Jun 2024 13:15:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45BKFlxc3470245
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024051501; t=1718136948;
	bh=WhP585hb/L47fJhChNfJiVXpMXU0QH1KtWBu/UgVVp4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=O4UuX8JxWZ947o1nr0MB5zU/V06HeNWKwliayCcDZnsAHeOrt4o2lUoSETF6zXMJS
	 4Vk3TDyfCmEuxcaIBmO8HV2zutSuK1IC06IQGhMhPMoXOfv9CeQiFNFzlnoQ2kMyuX
	 ZaFnylG5wmSmOEZ/XkYdAqpBFXiQIhiT7XYs+h+8W88/KXyOVTz9OzMSjXz7M7bneA
	 fTPuP5G9l5DhfrQBXIFZToLzbt6VFaQurfP2keJN6BGHm2kxFzbuLPhFlHgXz+KVNm
	 YlvUobF5pCM+xy1q/jT7FfyO8+2APpYo+fJ9dSLjzUph5utoiEx6n5gchN6vzeP6O2
	 8bWk8Q9JcO62g==
Date: Tue, 11 Jun 2024 13:15:43 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] x86: add 'runtime constant' infrastructure
User-Agent: K-9 Mail for Android
In-Reply-To: <8eb5960f-17f9-4d94-9b52-dea8b475e9dc@zytor.com>
References: <20240608193504.429644-2-torvalds@linux-foundation.org> <20240610104352.GT8774@noisy.programming.kicks-ass.net> <f967d835-d26e-47af-af35-c3c79746f7d9@rasmusvillemoes.dk> <8eb5960f-17f9-4d94-9b52-dea8b475e9dc@zytor.com>
Message-ID: <BFD0AF77-C95E-4B8B-B475-DCBD808CA5C0@zytor.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 11, 2024 12:43:02 PM PDT, "H=2E Peter Anvin" <hpa@zytor=2Ecom> wrot=
e:
>On 6/10/24 06:38, Rasmus Villemoes wrote:
>> On 10/06/2024 12=2E43, Peter Zijlstra wrote:
>>> On Sat, Jun 08, 2024 at 12:35:05PM -0700, Linus Torvalds wrote:
>>=20
>>>> Comments?
>>>=20
>>> It obviously has the constraint of never running the code before the
>>> corresponding runtime_const_init() has been done, otherwise things wil=
l
>>> go sideways in a hurry, but this also makes the whole thing a *lot*
>>> simpler=2E
>>>=20
>>> The only thing I'm not sure about is it having a section per symbol,
>>> given how jump_label and static_call took off, this might not be
>>> scalable=2E
>>>=20
>>> Yes, the approach is super simple and straight forward, but imagine
>>> there being like a 100 symbols soon :/
>>>=20
>>> The below hackery -- it very much needs cleanup and is only compiled o=
n
>>> x86_64 and does not support modules, boots for me=2E
>>=20
>> As can be seen in my other reply, yes, I'm also worried about the
>> scalability and would like to see this applied to more stuff=2E
>>=20
>> But if we do this, surely that's what scripts/sorttable is for, right?
>>=20
>> Alternatively, if we just keep emitting to per-symbol
>> __runtime_const_##sym sections but collect them in one __runtime_const,
>> just using __runtime_const { *(SORT_BY_NAME(__runtime_const_*)) } in th=
e
>> linker script should already be enough to allow that binary search to
>> work (with whatever : AT(ADDR() =2E=2E=2E ) magic is also required), wi=
th no
>> post-processing at build or runtime required=2E
>>=20
>
>As far as one section per symbol, this is *exactly* what the linker table=
 infrastructure was intended to make clean and scalable=2E
>
>I think rejecting it was a big mistake=2E It is really a very useful gene=
ral piece of infrastructure, and IMNSHO the whole notion of "oh, we won't e=
ver need that many such tables" is just plain wrong (as evidenced here=2E)
>
>Either way, the problem isn't that hard; you end up doing something like:
>
>struct runtime_const {
>	unsigned int size;
>	reladdr_t entries[0];
>};
>
>#define DECLARE_RUNTIME_CONST(sym,type) \
>extern struct runtime_const sym;\
>asm("=2Epushsection \"runtime_const_" #sym "=2EStart\",\"a\"\n\t"
>    "=2Eglobl " #sym "\n"
>    #sym ": =2Eint 2f - 1f\n\t"
>    "1:\n"
>    "=2Epopsection\n\t"
>    "=2Epushsection \"runtime_const_" #sym "=2E_end\",\"a\"\n\t"
>    "2:\n"
>    "=2Epopsection\n\t");
>
>=2E=2E=2E and add a common suffix, say, "=2Eentry", for the entry section=
 names=2E Then SORT_BY_NAME() will handle the rest=2E
>
>	-hpa
>

Ok, the section naming is obviously bogus, but=2E=2E=2E

I just had an idea how to clearly make this type-safe as a benefit=2E I'm =
at a school event right now but I'll hack up a demo as soon as I get home=
=2E

