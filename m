Return-Path: <linux-arch+bounces-7386-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02990984851
	for <lists+linux-arch@lfdr.de>; Tue, 24 Sep 2024 17:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32E381C20D29
	for <lists+linux-arch@lfdr.de>; Tue, 24 Sep 2024 15:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AAA1AB53B;
	Tue, 24 Sep 2024 15:10:39 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3445B1AAE2E;
	Tue, 24 Sep 2024 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727190639; cv=none; b=Pc4Apa/9ewH1DBd3FIRr+TzkN8BHAWRxZxDMZxBTrq+BVCM39v7DFTgg/+6qOr4Tk5VHVaFDNFP+078e7XQHl723BbVs3jPqlm1c1xpSFR/Jn5/x+N2ATm0yIKaSTSaXOEIum8c1TD2/qiFvZyUzatsfGyxmZfHaoC4C40hfl68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727190639; c=relaxed/simple;
	bh=sbwW5D39yiPTKK/V51LaTXSpydxMR+7pGFGdCqhw0Bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2DcX3WX6aK1QWACI0JC8xG+ny8rweQ6n6tFAxshTYc17G8kSomd+VujsAGFdkSfZ0fQQaVvCWfRxeXPNuVscMUHjDuBBnfcF4/MEU5R/xxI8VOLQYjm5Bf/Et8mPw0C4h+HlMFtK0Dt0gLnxDafwxYAURID5S/HeleJPxDWYjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C98EDDA7;
	Tue, 24 Sep 2024 08:11:05 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A088C3F528;
	Tue, 24 Sep 2024 08:10:33 -0700 (PDT)
Message-ID: <9c1d96d4-61ca-4e27-9d67-8c194cd7770d@arm.com>
Date: Tue, 24 Sep 2024 16:10:32 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] x86: vdso: Introduce asm/vdso/mman.h
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
 Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20240923141943.133551-1-vincenzo.frascino@arm.com>
 <20240923141943.133551-2-vincenzo.frascino@arm.com>
 <ZvH0PdVy5jJN3VTt@zx2c4.com>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <ZvH0PdVy5jJN3VTt@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jason,

Thank you for your review.

On 24/09/2024 00:05, Jason A. Donenfeld wrote:
> Hi,
> 
> I have the feeling I said this in the last two revisions, but maybe I
> just thought it or agreed with somebody else who typed it but never
> typed it myself, so now I'm typing it in no uncertain terms.
> 

This is the second revision, I am not sure to which other two revisions you are
referring to. Anyway if I missed your suggestion, I apologize.

> On Mon, Sep 23, 2024 at 03:19:36PM +0100, Vincenzo Frascino wrote:
>> +#define VDSO_MMAP_PROT	PROT_READ | PROT_WRITE
>> +#define VDSO_MMAP_FLAGS	MAP_DROPPABLE | MAP_ANONYMOUS
> 
> No, absolutely not. This is nonsense. Those flags aren't "the vdso
> flags" or something. The variable name makes no sense. Moving the
> definition outside of getrandom.c like the next patch does also makes no
> sense. Do not do this.
> 
> If you need to, for some reason, rename those symbols, then rename them
> each to VDSO_MAP_ANONYMOUS or whatever, and then use those from within
> getrandom.c so it remains as readable and reasonable as it currently is.
> 
> But under no circumstances should you move where this is expressed and
> rename it something generic like "vdso flags", when it is not generic
> but rather very specific to the function where it is currently used.
> IOW, please take a look and try to understand the code that you're
> touching when proposing changes like this.
> 
> 
> Also, though, I don't quite see what this patch accomplishes. If you're
> fine doing #include <notvdso/whatever.h> into here, importing this
> header into vdso code will transitively include notvdso/whatever.h with
> it. So in that case, either we can keep using MAP_ANONYMOUS and whatnot
> in the original sane symbol names, or this approach isn't correct in the
> first place.
> 
> Maybe what you want instead is a simpler vdso/whatever.h header that
> just includes nonvdso/whatever.h, and then you let getrandom.c and other
> things keep using the same symbols as they were using before.
>

In past we had a problem with compiling vDSOs on certain architectures.
Since then:
 - The generic vDSO library can include only the common denominator of the
headers required to build the library on all the architectures that support it.
 - The headers must come from the vdso/ namespace only (with rare documented
exceptions).
 - The generic vDSO library does not mandate how an architecture organizes its
headers or provides the required symbols.

Based on this it is not fine to include directly "notvdso/whatever.h" into
"vdso/whatever.h" because a future change to first might work on one
architecture but might break another one.

To the naming problem: I agree, maybe the naming is not self explanatory and
might need some comments to clarify its purpose.

The reasons why I introduced an extra indirection are the following:
 - Allow the architecture to decide if it wants to include directly mman.h or
not. As it was discussed already [1] a future update might cause problems (Note:
for x86 I honored your original strategy).
 - A future architecture might need different prot/flags.

[1]
https://lore.kernel.org/lkml/cb66b582-ba63-4a5a-9df8-b07288f1f66d@app.fastmail.com/

I am open to suggestions on what's your preference to address the problem. Let
me know your thoughts.
> Jason

-- 
Regards,
Vincenzo

