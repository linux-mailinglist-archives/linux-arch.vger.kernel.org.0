Return-Path: <linux-arch+bounces-7771-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB95A993282
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 18:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5771F2394B
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 16:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C181B1DA0FC;
	Mon,  7 Oct 2024 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=zytor.com header.i=@zytor.com header.b="CauyQUEM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD151D61BC;
	Mon,  7 Oct 2024 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728317231; cv=none; b=MTjBy/avhDf2KgyRCPibirFsLQLR9pnsk5URcerCbTpWmqbojrL0jd/MPcC0AyMKJM9h4YKe9mU6lynHR6dRRPfQKrHdbnzEQHbzviFdnUdMck7nuVT7Xc9X+ygT1Q01mrUE0fVzcJwZ7rSZLFscepLjZqoQTXQxwJ3kCqCKElk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728317231; c=relaxed/simple;
	bh=ysJYmcRATJGUvDZgVC4VTIwgMLRPerxOknqusaNkkTY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=GrfxkVAC2sfYA2HndPCHN6DZQHaGSNlbPrpd/aZYNtBOQ6lh5/gf8rAbRjIphBVCkECDKB6UTlYo02V0gtdpyMIfLYP4nUz6+d9f41ThEmmch83YD2vWidE+l5LS8lRdw2W1YIlsK5C3BkZIonbVHjv0Y+aTV9uI8EvFEPJjXDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=CauyQUEM reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 497G61qj2299520
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 7 Oct 2024 09:06:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 497G61qj2299520
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024091601; t=1728317164;
	bh=w1FDEB5FUp3CmMwDMFgTGIeu8TBeXqkrNzaDijMpyeo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=CauyQUEMYV55csmkcaj6NUUXCCScDRk2rFIz5IhZ+cc16O4JroobS3oVXbzPDYvN6
	 iDDEzUlVC8Iyo0+wb/1tlm2OgbIaeEXuHTmKxDRicREtj4y90VxQ9e9y6FmfG/faBs
	 khRmjjlqn2ag989XTQ3XCtR68OhI/xCRyvF6Em39Yl+UFAhyzwdQE8gviWFvjxsrH4
	 jbv6KU8rj+h4tqTv5ojrPi16s5pRjMA42Mxvoij8DC9zAxG3aX6ipgXx8gFLXS+yxw
	 1r8oEu+o70zi/wIp6Ve6gVidRjGP7VZJoxjXpc/exUTJHcoR/fvdzRH7/RyivZNMfJ
	 CHwWN1NZXFLAQ==
Date: Mon, 07 Oct 2024 09:05:58 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org
CC: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v3 2/2] vdso: Introduce vdso/page.h
User-Agent: K-9 Mail for Android
In-Reply-To: <6d79c86d-601b-46b9-a06e-6ab78b6d3e8a@arm.com>
References: <20241003152910.3287259-1-vincenzo.frascino@arm.com> <20241003152910.3287259-3-vincenzo.frascino@arm.com> <423e571b-3ef6-4e80-ba81-bf42589a4ba8@app.fastmail.com> <850cdc2a-a336-4dab-bc7a-d9bcae3fb3cf@arm.com> <140c4244-1bb2-404c-8372-1e68963eeea5@app.fastmail.com> <6d79c86d-601b-46b9-a06e-6ab78b6d3e8a@arm.com>
Message-ID: <9C51DD25-3BEE-4E95-8E2C-F94C1B75F95B@zytor.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 7, 2024 4:20:23 AM PDT, Vincenzo Frascino <vincenzo=2Efrascino@a=
rm=2Ecom> wrote:
>
>
>On 07/10/2024 12:06, Arnd Bergmann wrote:
>> On Mon, Oct 7, 2024, at 11:01, Vincenzo Frascino wrote:
>>> On 04/10/2024 14:13, Arnd Bergmann wrote:
>>=20
>>>
>>> It seemed harmless from the tests I did=2E But adding an '&&
>>> defined(CONFIG_32BIT)' makes it logically correct=2E I will add a comm=
ent as well
>>> in the next version=2E
>>=20
>> To clarify: this has to be "!defined(CONFIG_64BIT)", as most
>> 32-bit architectures don't define the CONFIG_32BIT symbol
>> (but all 64-bit ones define CONFIG_64BIT)=2E
>>=20
>
>You are right, it seemed that every 32-bit architectures with a
>64-bit phys_addr_t had CONFIG_32BIT but this is not the case=2E
>
>>     Arnd
>

Maybe we should have CONFIG_32BIT as a global?

