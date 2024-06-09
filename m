Return-Path: <linux-arch+bounces-4763-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20312901605
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 13:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C849C1F213A0
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 11:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9450C208DA;
	Sun,  9 Jun 2024 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CVA/97LG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3B82E832;
	Sun,  9 Jun 2024 11:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717933724; cv=none; b=suk5+LSbWTPbnLkz0ju5IjyCrexYWJXMaZsFRzsu+XVdQv2gyXR86ANdx4zywev5xgv2AcEQpudDPGPXAc/Xvhze45wJS5V9wuhivQimmTKwI01fHr+6AXInrHEyrfpDlimAE42lAzvtJXfAV2Ul4CI4WKoq/xatLuGPUKLecMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717933724; c=relaxed/simple;
	bh=SYZL2TWgbSIkhn/R6U/bSGznHqQlrLwO6krktXsoLcc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=oXMWnQlSGNWSR1Ywe0ANZgccXd5/rOOq00dk7KzoJ7vQJVgJRVDTmAsUS428Xe4yuU/CIbeVZDElaT57H8Gk2S9Bw48EldgbfRnd8r2NFApVZGxwcaG87tRv3/7tfxf5xPbHRMSdI7mtx41PVoh/jtuMZnYBhQR8UD0tjYASbHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=CVA/97LG; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 459BlqVL2567475
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 9 Jun 2024 04:47:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 459BlqVL2567475
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024051501; t=1717933673;
	bh=m+JFpwIO8dtkMONml90NvN4KcZv0aOqbfWbhdqLkHVo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=CVA/97LGg3fPQ1ex6wqWvVogrITI0cV3JuI963UEjAoamJaxw9U3CoHJvXGGaCdHB
	 X4xZZdoO8vIPp3sHKGILctO2nyD2Ze1DjaUctbuHzoiH9WuhGeQJ1w31ss37FgSE3W
	 2RzAON5suqVxGhpF/qf00YD3GfNj05JMoLHPD4G0lZKNBCnTcGLIVDo5oAsXO4LabP
	 Wc4IKxyaaW6XyJB86/bex8zP6DBqy5CpsVH7R2cnsoxa2/ZCYHROvUyOcUoj9NaM+i
	 pzK/nh7WP3yO2D+YviHaP9Nqo+QvCTZXUjFLRA6euX5DMbmgjRdnXzYkXZrJ0H+E1z
	 l7R3ut/+81m8Q==
Date: Sun, 09 Jun 2024 04:47:51 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] x86: add 'runtime constant' infrastructure
User-Agent: K-9 Mail for Android
In-Reply-To: <20240609112240.GBZmWQgNQXguD_8Nc8@fat_crate.local>
References: <20240608193504.429644-2-torvalds@linux-foundation.org> <20240609112240.GBZmWQgNQXguD_8Nc8@fat_crate.local>
Message-ID: <00BA183C-4EE6-46AE-AEC8-94B612222373@zytor.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 9, 2024 4:22:40 AM PDT, Borislav Petkov <bp@alien8=2Ede> wrote:
>On Sat, Jun 08, 2024 at 12:35:05PM -0700, Linus Torvalds wrote:
>> Ingo / Peter / Borislav - I enabled this for 32-bit x86 too, because it
>> was literally trivial (had to remove a "q" from "movq")=2E  I did a
>> test-build and it looks find, but I didn't actually try to boot it=2E=
=20
>
>Will do once you have your final version=2E I still have an Atom, 32-bit
>only laptop lying around here=2E
>
>> +#define runtime_const_ptr(sym) ({				\
>> +	typeof(sym) __ret;					\
>> +	asm("mov %1,%0\n1:\n"					\
>> +		"=2Epushsection runtime_ptr_" #sym ",\"a\"\n\t"	\
>> +		"=2Elong 1b - %c2 - =2E\n\t"			\
>> +		"=2Epopsection"					\
>> +		:"=3Dr" (__ret)					\
>> +		:"i" ((unsigned long)0x0123456789abcdefull),	\
>> +		 "i" (sizeof(long)));				\
>> +	__ret; })
>
>You might wanna use asm symbolic names for the operands so that it is
>more readable:
>
>#define runtime_const_ptr(sym) ({                                        =
       \
>        typeof(sym) __ret;                                               =
       \
>        asm("mov %[constant] ,%[__ret]\n1:\n"                            =
       \
>                "=2Epushsection runtime_ptr_" #sym ",\"a\"\n\t"          =
         \
>                "=2Elong 1b - %c[sizeoflong] - =2E\n\t"                  =
           \
>                "=2Epopsection"                                          =
         \
>                : [__ret] "=3Dr" (__ret)                                 =
         \
>                : [constant] "i" ((unsigned long)0x0123456789abcdefull), =
       \
>                  [sizeoflong] "i" (sizeof(long)));                      =
       \
>        __ret; })
>
>For example=2E
>
>> +// The 'typeof' will create at _least_ a 32-bit type, but
>> +// will happily also take a bigger type and the 'shrl' will
>> +// clear the upper bits
>
>Can we pls use the multiline comments, like you do below in the same
>file=2E
>
>Otherwise, it looks ok to me and it boots in a guest=2E
>
>I'll take the final version for a spin on real hw in a couple of days,
>once the review dust settles=2E
>
>Thx=2E
>

So the biggest difference versus what I had in progress was that I had the=
 idea of basically doing "ro_after_init" behavior by doing memory reference=
s until alternatives are run=2E

I don't know if that was overthinking the problem=2E=2E=2E

