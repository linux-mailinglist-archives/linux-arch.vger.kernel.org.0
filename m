Return-Path: <linux-arch+bounces-11963-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFEFAB9083
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 22:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A025F7B4CAF
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 20:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E59221F0A;
	Thu, 15 May 2025 20:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="h6IgwPNA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6839F4B1E44;
	Thu, 15 May 2025 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339505; cv=none; b=mtWTSE7R7MAfv3JqMUOIPqzYQzt+olZ2a7fjNhfeNDmaK6QIrM8/alhaEZql9bvYFmuShf9NojSPkiLBCHXRsSQgJivMjqVl9NFea+WPTimdR4bdGL8GTGUss7pUGSuImDQXek+3lCWdWf/Mdkfr6Wo2Ww3w5kfVyNONtOmJUsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339505; c=relaxed/simple;
	bh=SKBHDrkAv6HI41+T61x4+kTjy7+6vSJRsrsYVNkeUOE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=CfmaL1gSFITzRUFIXsny/R1Nnl2E4smkThNRDrQHAyIEXJ733ZwrKV6SlWcxL3inuMl1g3py1AKMajmhyNymF7HxQhUBrTM6KSZT+p8kcCqYNs5VhDMQUuZ2P6B7kAoqxJg/0QrVkYKdibdDkRWCgDQKBqAoRc2vg2A9jjUdHoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=h6IgwPNA; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.3.244] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 54FK4qMB3672567
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 15 May 2025 13:04:54 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 54FK4qMB3672567
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1747339494;
	bh=UgNmHzWW4X0bZb4Guomhh4etUesHhtEoB4gbOyjUxrE=;
	h=Date:To:From:Subject:From;
	b=h6IgwPNAydNf9R+sRGasHln/kezpG1tcgT9MlPDQKwe3jz7XrHKGYb//rDy3J6VvV
	 /A2BA2prwttd5ize9QzxXvP+DfufUXReekF2l1rRoNui1/uKI3zRSPlp0ufx+VexOt
	 l22ZySyKgIYQ6QH1BGDSMUm+8aLvwBX9gUTcSlYUH4Stn1OOJKYfHOde/cjtA6nzP7
	 2CmsXtpdux9F/7tZ3uIXeEbeKGG3RzQ/ybzLlePFidOW45HL/sR3XhF6k1aGo41hUW
	 4uWyNZKmAoucoQnqSodP3xsCASs8+pL9L/4OsUwxteY/dKrM1yNabPZi6wqS3SAQ79
	 VF+erJh/2VsOw==
Message-ID: <feb98a0f-8d17-495c-b556-b4fe19446d5d@zytor.com>
Date: Thu, 15 May 2025 13:04:52 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Metalanguage for the Linux UAPI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

OK, so this is something I have been thinking about for quite a while. 
It would be a quite large project, so I would like to hear people's 
opinions on it before even starting.

We have finally succeeded in divorcing the Linux UAPI from the general 
kernel headers, but even so, there are a lot of things in the UAPI that 
means it is not possible for an arbitrary libc to use it directly; for 
example "struct termios" is not the glibc "struct termios", but 
redefining it breaks the ioctl numbering unless the ioctl headers are 
changed as well, and so on. However, other libcs want to use the struct 
termios as defined in the kernel, or, more likely, struct termios2.

Furthermore, I was looking further into how C++ templates could be used 
to make user pointers inherently safe and probably more efficient, but 
ran into the problem that you really want to be able to convert a 
user-tagged structure to a structure with "safe-user-tagged" members 
(after access_ok), which turned out not to be trivially supportable even 
after the latest C++ modernizations (without which I don't consider C++ 
viable at all; I would not consider versions of C++ before C++17 worthy 
of even looking at; C++20 preferred.)

And it is not just generation of in-kernel versus out-of-kernel headers 
that is an issue (which we have managed to deal with pretty well.) There 
generally isn't enough information in C headers alone to do well at 
creating bindings for other languages, *especially* given how many 
constants are defined in terms of macros.

The use of C also makes it hard to mangle the headers for user space. 
For example, glibc has to add __extension__ before anonymous struct or 
union members in order to be able to compile in strict C90 mode.

I have been considering if it would make sense to create more of a 
metalanguage for the Linux UAPI. This would be run through a more 
advanced preprocessor than cpp written in C and yacc/bison. (It could 
also be done via a gcc plugin or a DWARF parser, but I do not like tying 
this to compiler internals, and DWARF parsing is probably more complex 
and less versatile.)

It could thus provide things like "true" constants (constexpr for C++11 
or C23, or enums), bitfield macro explosions and so on, depending on 
what the backend user would like: namespacing, distributed enumerations, 
and assembly offset constants, and even possibly syscall stubs.

There is of course no reason such a generator couldn't be used for 
kernel-only headers at some point, but I am concentrating on the

Another major motivation is to be able to include one named struct 
anonymously inside another, without having to repeat the definition. 
(This is not supported in standard C or GNU C; MS C supports it as an 
extension, and I have requested that it be added into GNU C which would 
also allow it to be used with __extension__, and perhaps get folded into 
a future C standard since it would now fit the criterion of more than 
one implementation; however, the runway for being able to use that in 
UAPI headers is quite long.)

I obviously want to keep a C-like syntax for this, which is a major 
reason for using a parser like yacc/bison.

I have done such a project in the past, with some good success. That 
being said, the requirements for the Linux UAPI language are obviously 
much more complex. A few things I have considered are wanting to be able 
to namespace constants or, more or less equivalently, create 
enumerations in bits and pieces (consider ioctl constants, for example) 
and have them coalesce into a single definition if appropriate for the 
target language.

Speaking of ioctl constants: one of the current problems is that a fair 
number of ioctl constants do not have the size/type annotations, and 
perhaps worse, it is impossible to tell from just the numeric value 
(since _IOC_NONE expands to 0, an _IO() ioctl ends up having no type 
information at all.) This is something that *definitely* ought to be 
added, even if a certain backend cannot preserve that information

Thoughts?

	-hpa


