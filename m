Return-Path: <linux-arch+bounces-7110-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A0396F34A
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 13:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2792289DFD
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 11:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765451CBE83;
	Fri,  6 Sep 2024 11:41:17 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C350F15852B;
	Fri,  6 Sep 2024 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725622877; cv=none; b=lmP6wTLwHL8IcghyoDJ9VoUAvLLpWJ+0y0c2pryKhxo9B3a2zL7lzGxz/HvcXh6MdxvLyPhgtHO1DfjDa/WCT/do0xp/Ad5omEhIz3J4+/PrUAbKrPDL/0PFyCf8Dxry79sCVp09TDU2lBt1dubfBqvqwzJ1sMWcfbvCshWNaFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725622877; c=relaxed/simple;
	bh=DsvcgjE4oyPw6dEsqQoTNxMR3441YI+YMB9QY1RDRBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGZDSTSwuUC0LPGyT4DpdL7bjipkxvxnX1L2qn3CDTuI5GRlL/Z8g+DjH0sZ+yIBe7R3YhATM/FOUm3b5RS1b+0sU15x/TbgVPM11QnbOtCVN4sQy1IQS47yBapMEp7UR5UOUTN0XnhW2yhknSU1zZsBzSPZgha65T/7WjvIUh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2283EFEC;
	Fri,  6 Sep 2024 04:41:42 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9383D3F73B;
	Fri,  6 Sep 2024 04:41:12 -0700 (PDT)
Message-ID: <1d86a38b-dd57-48ac-875b-4d9d2f645d47@arm.com>
Date: Fri, 6 Sep 2024 12:41:11 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] vdso: Split linux/minmax.h
To: Arnd Bergmann <arnd@arndb.de>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-mm@kvack.org
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
 Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20240903151437.1002990-1-vincenzo.frascino@arm.com>
 <20240903151437.1002990-6-vincenzo.frascino@arm.com>
 <b78eab34-61f5-4c9e-b080-d2524cd30eb8@csgroup.eu>
 <780d969f-8057-41aa-901f-08a5fbebcba9@app.fastmail.com>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <780d969f-8057-41aa-901f-08a5fbebcba9@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 04/09/2024 18:23, Arnd Bergmann wrote:
> On Wed, Sep 4, 2024, at 17:17, Christophe Leroy wrote:
>> Le 03/09/2024 à 17:14, Vincenzo Frascino a écrit :
>>> The VDSO implementation includes headers from outside of the
>>> vdso/ namespace.
>>>
>>> Split linux/minmax.h to make sure that the generic library
>>> uses only the allowed namespace.
>>
>> It is probably easier to just don't use min_t() in VDSO. Can be open 
>> coded without impeeding readability.
> 
> Right, or possibly the even simpler MIN()/MAX() if the arguments
> have no side-effects.
> 

Agreed, generally I do not like open-coding since it tends to introduce
duplication, but these cases are simple especially if we can use MIN()/MAX().

>        Arnd

-- 
Regards,
Vincenzo

