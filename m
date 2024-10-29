Return-Path: <linux-arch+bounces-8681-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD2D9B3F01
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2024 01:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A127B2197A
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2024 00:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44D34A33;
	Tue, 29 Oct 2024 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gLesxE+1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF952904;
	Tue, 29 Oct 2024 00:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730161206; cv=none; b=c+M47BL19pKEcxCQg1a3QL2Y3XZXD0PU3BHXU3kvaVPdvBGbGcs9PgEIYnn+S7a5MmmUGF4muY0ug/U6gemkFm4+N5BYWQnqHbO15VGV7J5StGt5CIniUiTTEuNLT1vvSAkA3ePBJn2mtsyTzkQYBitq2LyIqq8Je07PxcIeyqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730161206; c=relaxed/simple;
	bh=FOUiNvi8O3GqXFPiU21I448Bt9bmNIXrroPvtjYN/Xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQUfetMYSqOrolVt1urwFwsLj0Iewb2RyFvSQgeNka7YAa8i60xVVFnGex/JyhxR0woEr6g6wTVXnpc2ClcwExP5L5Z2BjjIIM7tPDmRWyB4u6CvuKkF/KpCxbACD+EO7tUBiNHeJtTGnmQyegjEInal4jJJYf81ZlBAQl/JIZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=gLesxE+1; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.3.244] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 49T0I9Jq034002
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 28 Oct 2024 17:18:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 49T0I9Jq034002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1730161095;
	bh=lw19VMVgvpimByaEBMvY/Dq85RZi0Sbm7gXvjx0Vg/M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gLesxE+1tY7r5RxYlvoDemz/lwnCb6m7LWPZaAybe/08vd4npJw8ZzVaGbGq4Ola+
	 UY78bVymAky07wU0B/tZweoyTY6bGNWuAFWaecf3Cc4GH7F+tg95/zQ86ZIoL8Tu2b
	 kcsQ8F3YRJahe7p7s6zPL3QpKNDb8nOoO8tqg7vCFswE7KjaugvgUW+c1WPDT5LA6/
	 AWQvtblVz5L14MTBe2U5RGZQKZRXO1TBplPFTlcr7OiN8d7i2Q6Lt3ime/klzEkmNI
	 ulEBTXWImaZ++7WNbYcQwW69wthI9mt0RzihG9g3k42UO0VoHPe9szIT4vWrH5a13K
	 muN3WPAz/4NIg==
Message-ID: <0605fa9c-0e48-48ec-b04d-c2ef1c48fdd9@zytor.com>
Date: Mon, 28 Oct 2024 17:18:09 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/7] objtool: Fix unreachable instruction warnings for
 weak functions
To: Kees Cook <kees@kernel.org>, Rong Xu <xur@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>,
        Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>,
        Brian Gerst <brgerst@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Li <davidxl@google.com>, Han Shen <shenhan@google.com>,
        Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>, Juergen Gross <jgross@suse.com>,
        Justin Stitt <justinstitt@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Mike Rapoport (IBM)"
 <rppt@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner
 <tglx@linutronix.de>,
        Wei Yang <richard.weiyang@gmail.com>, workflows@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Maksim Panchenko <max4bolt@gmail.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Yonghong Song <yonghong.song@linux.dev>, Yabin Cui <yabinc@google.com>,
        Krzysztof Pszeniczny <kpszeniczny@google.com>,
        Sriraman Tallam <tmsriram@google.com>,
        Stephane Eranian
 <eranian@google.com>, x86@kernel.org,
        linux-arch@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20241026051410.2819338-1-xur@google.com>
 <20241026051410.2819338-3-xur@google.com> <202410281716.0C8F383@keescook>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <202410281716.0C8F383@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/24 17:16, Kees Cook wrote:
> On Fri, Oct 25, 2024 at 10:14:04PM -0700, Rong Xu wrote:
>> In the presence of both weak and strong function definitions, the
>> linker drops the weak symbol in favor of a strong symbol, but
>> leaves the code in place. Code in ignore_unreachable_insn() has
>> some heuristics to suppress the warning, but it does not work when
>> -ffunction-sections is enabled.
>>
>> Suppose function foo has both strong and weak definitions.
>> Case 1: The strong definition has an annotated section name,
>> like .init.text. Only the weak definition will be placed into
>> .text.foo. But since the section has no symbols, there will be no
>> "hole" in the section.
>>
>> Case 2: Both sections are without an annotated section name.
>> Both will be placed into .text.foo section, but there will be only one
>> symbol (the strong one). If the weak code is before the strong code,
>> there is no "hole" as it fails to find the right-most symbol before
>> the offset.
>>
>> The fix is to use the first node to compute the hole if hole.sym
>> is empty. If there is no symbol in the section, the first node
>> will be NULL, in which case, -1 is returned to skip the whole
>> section.
>>
>> Co-developed-by: Han Shen <shenhan@google.com>
>> Signed-off-by: Han Shen <shenhan@google.com>
> 
> This seems logically correct to me, but I'd love to see review from Josh
> and/or Peter Z on this change too.
> 
> Reviewed-by: Kees Cook <kees@kernel.org>
> 

Does this happen even with -Wl,--gc-sections?

	-hpa


