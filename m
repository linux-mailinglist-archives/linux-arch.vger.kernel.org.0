Return-Path: <linux-arch+bounces-4725-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A958FDCFA
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2024 04:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CBF31F24655
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2024 02:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C3BDDC1;
	Thu,  6 Jun 2024 02:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Qtho0aUf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B321321340
	for <linux-arch@vger.kernel.org>; Thu,  6 Jun 2024 02:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717642170; cv=none; b=TQh3d4XxXCiLydnmbL73ETPMZYReHzF8Eqr7E+F27OBfuoldjmU4yWZnJsGi+Fb9NUYEecHa5cgiZGxrmWfDHpquFTxKM6b56yPrJaiEKgro4gXwma3X5ycLZzuNStlgOOhwJ+T42vvp/YZGLWF5IgKc4O1gHw1JOQ2Huz2ZmoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717642170; c=relaxed/simple;
	bh=76P5iQwy5Ju8bE3eW6sWhGgCNFsXZIle5i9/6aV1dAg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=b7Lw/39IuPZbPe5CULPeir4ZqYWdodYsURIV/3aH3w/attf0zKjsvMfipjzh9pd5arKVwlPBu/NQinENS1gl7/jSOFpKDg0XddPiE/X47hY05lvXVhBijNMK33ZZnsR2JWwDDdcIHRv90fzd9EETyDftNFGBtWU+sf9W67btwCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (0-bit key) header.d=zytor.com header.i=@zytor.com header.b=Qtho0aUf reason="key not found in DNS"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4562Od0b1657346
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 5 Jun 2024 19:24:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4562Od0b1657346
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024051501; t=1717640679;
	bh=85VOBgEwHja2fr+hbigzrKLsB88FZ40KHT4qKXTTA8U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Qtho0aUf3clt8F6YrMJg2V1HI7X24I3NnP/jf7P75v55jICZIMmJRYCUkt1cxl3fj
	 CZiWVTBa/YUYVD2yYMMpTRgzoPkjiHjjjxSMmD8PeaDMX/mf2tntzVHZsu/UpoxOsf
	 CafgqWjHsZcJVtAhZUjdxhyhBuGp7Ww4l10wBwBiRl62R1efqBV74+yAjV5wJlZnm0
	 NTmfYRkR1dhkclcu/W0vmk0vs6oc3O25gml8gJCRMbUSrXNmFouwH/B+CRHbAAbZxT
	 bkw9EKFjtCtdKNlY+yIy4vUMcTI+f+aBMgKwSaCWkUwaCgCPngS4NPQmy7bvwPNNY+
	 YwIfitIKoGHbQ==
Date: Wed, 05 Jun 2024 19:24:36 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC: the arch/x86 maintainers <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: Horrendous "runtime constant" hack - current patch x86-64 only
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=whFSz=usMPHHGAQBnJRVAFfuH4gFHtgyLe0YET75zYRzA@mail.gmail.com>
References: <CAHk-=whFSz=usMPHHGAQBnJRVAFfuH4gFHtgyLe0YET75zYRzA@mail.gmail.com>
Message-ID: <9FD53E66-CD82-448B-89B6-77092115F0AD@zytor.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 5, 2024 7:14:13 PM PDT, Linus Torvalds <torvalds@linux-foundation=
=2Eorg> wrote:
>Ok, this attached patch is so absolutely disgusting that it is almost
>a work of art=2E
>
>I spent some time last week doing arm64 profiles, and on the loads I
>tested, I saw my old enemy __d_lookup_rcu()=2E The hash table lookup
>ends up being expensive=2E Not a huge surprise=2E
>
>That said, the expense of the hash table lookup is only partially the
>memory accesses of the hashtable itself=2E  A noticeable part of the
>cost is in looking up the address of the hash table=2E
>
>That annoys me=2E It has annoyed me before=2E It's a "runtime constant"=
=2E
>In fact, it's two runtime constants: the address of the hash table,
>and the shift count that turns the dentry name hash into the index
>into the hash table (approximates a mask)=2E
>
>It's disgusting having the profile point to the "load constant from memor=
y"=2E
>
>Peter Anvin at some point had some rather complex patch to do
>"constant alternatives"=2E I couldn't find it, but I didn't search very
>hard because I remembered it being pretty significant in size, and I
>went "how hard can it be"=2E
>
>Now, I did the profiling on arm64, but then when it came to rewriting
>instructions I went back to x86-64 just because while I'm trying to
>get better at reading arm64 asm, I don't want to deal with the pain of
>huge constants (and a very slow boot for testing)=2E
>
>I'm posting this disgusting patch here because I need to take a break
>from this insanity, and maybe somebody else is interested=2E
>
>And yes, this needs to be behind some "CONFIG_RUNTIME_CONSTANTS"
>config variable, with fallback to the same old code=2E
>
>And yes, that static_shift_right_32() thing is odd=2E It takes and
>returns an 'unsigned long', but then operates on the low 32 bits of
>it, and clears the upper 32 bits (on 64-bit architectures)=2E That's
>purely because this is what x86-64 code generation wants to turn that
>whole op into just a single instruction=2E
>
>The static_const_init() sizes are also hardcoded, "knowing" what the layo=
ut is=2E
>
>So this is all just a truly disgusting tech demo, but it generates
>very pretty code in d_lookup_rcu()=2E
>
>Tested in the sense that it works for me in one particular
>configuration using clang=2E The code from gcc looks fine to me too, but
>that's from just quick "let's check"=2E
>
>Actually extending this to arm64 (and possibly other architectures)
>would need some more cleanups and abstracting this all more=2E I didn't
>look if other core kernel code might want to use this, I was literally
>just concentrating on making __d_lookup_rcu() look pretty (and you
>need to get rid of debug build options for it to do that)
>
>               Linus

Yeah I never finished it, because, well, getting some of the corner cases =
done turned out to need temporary registers during initialization (before a=
lternatives), which ended up leading to literally the ugliest assembly code=
 I have ever written (and you know some of the crap I have done=2E)

This was to be able to do things like shift counts on x86=2E

