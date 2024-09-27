Return-Path: <linux-arch+bounces-7472-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A34F988615
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2024 15:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7C0281F8D
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2024 13:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4457718C924;
	Fri, 27 Sep 2024 13:09:12 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCB6189502;
	Fri, 27 Sep 2024 13:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727442552; cv=none; b=rKDmliYj8xJ0vrz+hD4nidN7MvlvmMNpgbMP4Oj40JOUlS6WSMv+7VnNiTXCZmYN3vvIXTMX/2aQoXM79My2mVKD5/wr26syw2vXqP6/nQEyLNFdKQg1y6hQ8sxFmWutL9bD5yo+ZNx0aw0AITG9YgBO1BuuPlZOesvo7Ab/qU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727442552; c=relaxed/simple;
	bh=MY0VguBFD7ubm4DsS0RHYr4xnTyh3+39aOL9ZnKlFzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iB19Sl/+MB2fIqhYVlr7y0U9uIFNr034R2Pblvsk6MXQ8BaI1pzciy6C3x750j50EZe2nD3/nm1coFI0IHk3n/WNht9yqYq1Tz11xM4tlm4KKdVh2ZfRlAoKITZY+FPSCCTP5zqJPn+w5p4I343M77k9fXTDD4RgaroSzMvXAYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D033D14BF;
	Fri, 27 Sep 2024 06:09:37 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9C7F3F587;
	Fri, 27 Sep 2024 06:09:05 -0700 (PDT)
Message-ID: <f9b6ae72-5f72-4569-b083-ab62e5d91382@arm.com>
Date: Fri, 27 Sep 2024 14:09:04 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] x86: vdso: Introduce asm/vdso/mman.h
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
References: <20240923141943.133551-1-vincenzo.frascino@arm.com>
 <20240923141943.133551-2-vincenzo.frascino@arm.com>
 <626baa55-ca84-49ba-9131-c1657e0c0454@csgroup.eu>
 <fe23745e-a965-4b74-863d-9479fdef239f@app.fastmail.com>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <fe23745e-a965-4b74-863d-9479fdef239f@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 25/09/2024 22:23, Arnd Bergmann wrote:
> On Wed, Sep 25, 2024, at 06:51, Christophe Leroy wrote:
>> Le 23/09/2024 à 16:19, Vincenzo Frascino a écrit :
>>> @@ -0,0 +1,15 @@
...

>>
>> I still can't see the point with that change.
>>
>> Today 4 architectures implement getrandom and none of them require that 
>> indirection. Please leave prot and flags as they are in the code.
>>
>> Then this file is totally pointless, VDSO code can include 
>> uapi/linux/mman.h directly.
>>
>> VDSO is userland code, it should be safe to include any UAPI file there.
> 
> I think we are hitting an unfortunate corner case in the build
> system here, based on the way we handle the uapi/ file namespace
> in the kernel:
> 
> include/uapi/linux/mman.h includes three headers: asm/mman.h,
> asm-generic/hugetlb_encode.h and linux/types.h. Two of these
> exist in both include/uapi/ and include/, so while building
> kernel code we end up picking up the non-uapi version which
> on some architectures includes many other headers.
> 
> I agree that moving the contents out of uapi/ into vdso/ namespace
> is not a solution here because that removes the contents from
> the installed user headers, but we still need to do something
> to solve the issue.
>
> The easiest workaround I see for this particular file is to
> move the contents of arch/{arm,arm64,parisc,powerpc,sparc,x86}/\
> include/asm/mman.h into a different file to ensure that the
> only existing file is the uapi/ one. Unfortunately this does
> not help to avoid it regressing again in the future.
> 
> To go a little step further I would also move
> uapi/asm-generic/hugetlb_encode.h to uapi/linux/hugetlb_encode.h
> or merge it into uapi/linux/mman.h. This file has no business
> in asm-generic/* since there is only one copy.
> 
> After looking at this file for way too long, I somehow
> ended up with a (completely unrelated) cleanup series that
> I now posted at
> https://lore.kernel.org/lkml/20240925210615.2572360-1-arnd@kernel.org/T/#t
>

I had a look at your proposal and it seems definitely better then mine. Thanks
Arnd. I am happy to drop my changes and re-post only a small series with
PAGE_SIZE/MASK required rework.

>      Arnd

-- 
Regards,
Vincenzo

