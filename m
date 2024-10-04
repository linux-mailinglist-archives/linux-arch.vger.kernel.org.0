Return-Path: <linux-arch+bounces-7707-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 811EF99111F
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 23:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46BD6283CF8
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 21:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C417B1ADFF4;
	Fri,  4 Oct 2024 21:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="RHbE3DVW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B0D15A856;
	Fri,  4 Oct 2024 21:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728076028; cv=none; b=HX3tiEHE3g3E+iv4vFbwD56WbToiow0pXr+fdqncIB/p7KXy1hQvfmdDiQlCqG954E/lLntHKbJVlcXcB5ZZRnQFZJbgFSQP26DIgofB5qNdaE8t7PhqFXo15rPrtJHZ/A/RSGfGM/vCDH6qymExHz1Rg6oI0nTlvXhcpSBjIvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728076028; c=relaxed/simple;
	bh=35IOoHe/X7gnxDSJ+PKxFRsGFeTWY6fFlRdddCjRNEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tdtkxW6MbI+05i9d38gtjKiz5qeF6Gk04sACgPAQYTGrvyyozgy4S/lYhS6fr8KGi4SRfZ9/4Yg1t2iOdrD9item5bYAWKorJ775LgCjdUhOYnhxRfACoQ+ntz9I+KmnOdkS7fd6tBE5Q2LDEBf+1UzaC0XxeEdr7ZSPhkIsIr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=RHbE3DVW; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.3.244] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 494L65GU1102942
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 4 Oct 2024 14:06:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 494L65GU1102942
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024091601; t=1728075968;
	bh=XsIxGCLuwc7oDprSmGh/r3HcUoLTGC5y0f+hwyxMfwo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RHbE3DVWEQje/BMw0MYaccvz1CZHwlX6EAgZGBVxHM2N6A8Bs+1jWvQpqHAmpUzya
	 B92rCcmXrNdl6GfJQOI48PxiDK98iUmhievUBaOuzvKW3PAg7k45+MO2DgOhre9Bqd
	 MrXnCq+SHnBPZaEqYPEh1ZZWpqzvtfcpjsowsK7ZSQpJE3n6P52zeuoQxt6YTsZKnI
	 eOmpzoP5V4jl/5Ek7xSXJuKz/8Ygm8jcSxEYWiVLw5Mr50hkZ5MwtV2JsKhIo4+1yl
	 R0hI44pjMEjCP35l4UByBpjxQS3xPtcQR5w0P8PyQOSjLhz1QZW4Zg4KVQGx8RJEXl
	 n08E+BHxsQUWw==
Message-ID: <5c7490bb-aa74-427b-849e-c28c343b7409@zytor.com>
Date: Fri, 4 Oct 2024 14:06:05 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 25/28] x86: Use PIE codegen for the core kernel
To: Ard Biesheuvel <ardb@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Uros Bizjak <ubizjak@gmail.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky
 <boris.ostrovsky@oracle.com>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
        Keith Packard <keithp@keithp.com>,
        Justin Stitt <justinstitt@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sparse@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-perf-users@vger.kernel.org,
        rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-55-ardb+git@google.com>
 <99446363-152f-43a8-8b74-26f0d883a364@zytor.com>
 <CAMj1kXG7ZELM8D7Ft3H+dD5BHqENjY9eQ9kzsq2FzTgP5+2W3A@mail.gmail.com>
 <CAHk-=wj0HG2M1JgoN-zdCwFSW=N7j5iMB0RR90aftTS3oqwKTg@mail.gmail.com>
 <CAMj1kXEU5RU0i11zqD0433_LMMyNQH2gCoSkU7GeXmaRXGF1Yw@mail.gmail.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <CAMj1kXEU5RU0i11zqD0433_LMMyNQH2gCoSkU7GeXmaRXGF1Yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/24 04:13, Ard Biesheuvel wrote:
> 
>> That said, doing changes like changing "mov $sym" to "lea sym(%rip)" I
>> feel are a complete no-brainer and should be done regardless of any
>> other code generation issues.
> 
> Yes, this is the primary reason I ended up looking into this in the
> first place. Earlier this year, we ended up having to introduce
> RIP_REL_REF() to emit those RIP-relative references explicitly, in
> order to prevent the C code that is called via the early 1:1 mapping
> from exploding. The amount of C code called in that manner has been
> growing steadily over time with the introduction of 5-level paging and
> SEV-SNP and TDX support, which need to play all kinds of tricks before
> the normal kernel mappings are created.
> 

movq $sym to leaq sym(%rip) which you said ought to be smaller (and in 
reality appears to be the same size, 7 bytes) seems like a no-brainer 
and can be treated as a code quality issue -- in other words, file bug 
reports against gcc and clang.

> Compiling with -fpie and linking with --pie -z text produces an
> executable that is guaranteed to have only RIP-relative references in
> the .text segment, removing the need for RIP_REL_REF entirely (it
> already does nothing when __pic__ is #define'd).

But -fpie has a considerable cost; specifically when we have indexed 
references, as in that case the base pointer needs to be manifest in a 
register, *and* it takes up a register slot in the EA, which may end 
converting one instruction into three.

Now, the "kernel" memory model is defined in the ABI document, but there 
is nothing that prevents us from making updates to it if we need to; 
e.g. the statement that movq $sym can be used is undesirable, of course.

	-hpa


