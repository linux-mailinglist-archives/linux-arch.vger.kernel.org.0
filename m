Return-Path: <linux-arch+bounces-11966-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CF7AB91C5
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 23:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C989E16E264
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 21:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071B32222D1;
	Thu, 15 May 2025 21:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="U/hPhtCl"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D537218AAA;
	Thu, 15 May 2025 21:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747344288; cv=none; b=nvn5G1wwE4p/OlSVzgMiUCg9O6iJU6FOAk28ixqY/rxC60PGFaVf6Sb7RFamqE56OhlXBh2l9QNFGu97LKfSivjoh/rfFIhGjUVE9XCXRqsPKL3jKyFo2YHUcocX4SCkAnCtZlbMI+9otzNjqQPl77NMIBq/diBHyaTtG94Cegc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747344288; c=relaxed/simple;
	bh=2J39odpyH3jFo9b+/CKsfvFR/J9H7G5srto0L8N6xC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJYDYSFm/GM8wNFeoqeccPUZumuGUiOOUr4LNGBuLvw6lgbWgShjK00Fd4y5HLBvuSJ1sjFRoUetdD9pINJsMlLGXcRmGHmKSiHGgnp1jMuZj8CgP5xW2AbgKXLZk32pE4JIg/1SiOAPYYb0phF5C91v15NzUn7Cw0AqoEmVWBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=U/hPhtCl; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9485:60b7:882d:1594:8b0f] ([IPv6:2601:646:8081:9485:60b7:882d:1594:8b0f])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 54FLOYlq3715764
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 15 May 2025 14:24:35 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 54FLOYlq3715764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1747344276;
	bh=RUDeJD8D5oL6/c5joaB6sbMrOkBLB2ux6jBoSsZNp+E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U/hPhtClFOfd7pzRvhOV2RjpPAdpYYq7DS10kWP8xyVkFjc5pije3IIReBdojkhb8
	 x5De84X6e1itXMxMW257ku67hfSzTnUsfZ2/SZSo9hpEQwlU2JUou5D0e/SR4GCX20
	 5VHy4ldyMEQ5U5rYMWYOhHtdenPU3YjuWlV1Uy3hl5cWJB4iMmTybHd+okgW1qbc1G
	 fiK2VjoDF33bmBe5p6d8+diw7fFxPwSEvfcTynpQvWWmTsNychB2QUWxdxFP40+2fY
	 tTQjQDSJdror2WmV/d/mLXJbjMNKLRafr2RVEb9RbKa4dwfkNmseNiP/7W0qazC/mf
	 ieHbYRoV5FtCw==
Message-ID: <e4d114e3-984a-482d-a162-03f896cd2053@zytor.com>
Date: Thu, 15 May 2025 14:24:29 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Metalanguage for the Linux UAPI
To: enh <enh@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org
References: <feb98a0f-8d17-495c-b556-b4fe19446d5d@zytor.com>
 <CAJgzZoqUV6gSfgCWbfe6oSH5k9qt30gpJ0epa+w78WQUgTCqNQ@mail.gmail.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <CAJgzZoqUV6gSfgCWbfe6oSH5k9qt30gpJ0epa+w78WQUgTCqNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/15/25 13:26, enh wrote:
> On Thu, May 15, 2025 at 4:05 PM H. Peter Anvin <hpa@zytor.com> wrote:
>>
>> OK, so this is something I have been thinking about for quite a while.
>> It would be a quite large project, so I would like to hear people's
>> opinions on it before even starting.
>>
>> We have finally succeeded in divorcing the Linux UAPI from the general
>> kernel headers, but even so, there are a lot of things in the UAPI that
>> means it is not possible for an arbitrary libc to use it directly; for
>> example "struct termios" is not the glibc "struct termios", but
>> redefining it breaks the ioctl numbering unless the ioctl headers are
>> changed as well, and so on. However, other libcs want to use the struct
>> termios as defined in the kernel, or, more likely, struct termios2.
> 
> bionic is a ("the only"?) libc that tries to not duplicate _anything_
> and always defer to the uapi headers. we have quite an extensive list
> of hacks we need to apply to rewrite the uapi headers into something
> directly usable (and a lot of awful python to apply those hacks):
> 
> https://cs.android.com/android/platform/superproject/main/+/main:bionic/libc/kernel/tools/defaults.py
> 

Not "the only".

> a lot are just name collisions ("you say 'class', my c++ compiler says
> wtf?!"), but there are a few "posix and linux disagree"s too. (other
> libcs that weren't linux-only from day one might have more conflicts,
> such as a comically large sigset_t, say :-) )
> 
> but i think most if not all of that could be fixed upstream, given the will?
> 
> (though some c programmers do still get upset if told they shouldn't
> use c++ keywords as identifiers, i note that the uapi headers _were_
> recently fixed to avoid a c extension that's invalid c++. thanks,
> anyone involved in that who's reading this!)
> 
>> Furthermore, I was looking further into how C++ templates could be used
>> to make user pointers inherently safe and probably more efficient, but
>> ran into the problem that you really want to be able to convert a
>> user-tagged structure to a structure with "safe-user-tagged" members
>> (after access_ok), which turned out not to be trivially supportable even
>> after the latest C++ modernizations (without which I don't consider C++
>> viable at all; I would not consider versions of C++ before C++17 worthy
>> of even looking at; C++20 preferred.)
> 
> (/me assumes you're just trolling linus with this.)

I'm not; I posted a long article about why I think it might be an 
alternative worth pursuing. I know, of course, Linus' long time hatred 
of C++, but as I said: I think *very recent* versions of C++ have a lot 
to offer, mainly in the form of metaprogramming (which we currently do 
using some amazingly ugly macros.)

https://lore.kernel.org/lkml/3465e0c6-f5b2-4c42-95eb-29361481f805@zytor.com

>> And it is not just generation of in-kernel versus out-of-kernel headers
>> that is an issue (which we have managed to deal with pretty well.) There
>> generally isn't enough information in C headers alone to do well at
>> creating bindings for other languages, *especially* given how many
>> constants are defined in terms of macros.
> 
> (yeah, while i think the _c_ [and c++] problems could be solved much
> more easily, solving the swift/rust/golang duplication of all that
> stuff is a whole other thing. i'd try to sign up one of those
> languages' library's maintainers before investing too much in having
> another representation of the uapi though...)

Yes, that's one of the reasons for posting this.

>> The use of C also makes it hard to mangle the headers for user space.
>> For example, glibc has to add __extension__ before anonymous struct or
>> union members in order to be able to compile in strict C90 mode.
> 
> (again, that one seems easily fixable upstream.)

Agreed... until it breaks again. And how much

>> I have been considering if it would make sense to create more of a
>> metalanguage for the Linux UAPI. This would be run through a more
>> advanced preprocessor than cpp written in C and yacc/bison. (It could
>> also be done via a gcc plugin or a DWARF parser, but I do not like tying
>> this to compiler internals, and DWARF parsing is probably more complex
>> and less versatile.)
>>
>> It could thus provide things like "true" constants (constexpr for C++11
>> or C23, or enums), bitfield macro explosions and so on, depending on
>> what the backend user would like: namespacing, distributed enumerations,
>> and assembly offset constants, and even possibly syscall stubs.
> 
> (given a clean slate that wouldn't be terrible, but you get a lot of
> #if nonsense. though the `#define foo foo` trick lets you have the
> best of both worlds [at some cost to compile time].)

Again, that would be a choice for the data consumer (backend), which is 
one of the main advantages here.

	-hpa


