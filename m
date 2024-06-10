Return-Path: <linux-arch+bounces-4816-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 762F2902C83
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 01:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1301F21F59
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 23:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9131C6F2FD;
	Mon, 10 Jun 2024 23:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="f8aCIaXn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFAD3C0C;
	Mon, 10 Jun 2024 23:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718062537; cv=none; b=Mr5TyoqVyRt5mwJqxTVrgVpH9PqsBvroJgDF/pbyjP9BbLoxLQ+RAAGyysX+yzBhFRSDqT5kKsYWMbSPxhwnb7ha82rrgJtb+SylS08Ss7S0WCD6T3ZFXTFYQo6p4ovL0gNAWviI4EhgHOuIu6cCELPrrTyGt4dXdJP03q+ASvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718062537; c=relaxed/simple;
	bh=wSWL/70ZBsPTYeRbz7dH6zGPqpxIt4663shY+CMkz7I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=i3FO0fA61Esmjd39fkYkCcyj7ofAvtDrN+Po+AahGqBR9ZDh+5n3xMalWeuDh7Ue8d1oqQ5zAwJYlCgJgbMelYgaNlqfv9VqQ569zl0yBkomIFd+pTR8CTSobFt71BPGIgrnDFSOjvPODECSbpBFkqnAdCJNpIO7K2LxuyBSoFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=f8aCIaXn; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45AKdkPF1303131
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 10 Jun 2024 13:39:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45AKdkPF1303131
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024051501; t=1718051988;
	bh=jcCI8SDBfOzo+prfPYX0FGiNeJM3cOjzgscH9q+Yza8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=f8aCIaXn7i5aYCWXgNqkBWwZ6gB5uqiPqD5lyOHUkAsjHY9w/OKIIlJ9rbJQiJhoc
	 tj9YJpLVgztdmZpzbHO+oucSp6qkci/vvRdEaVZDE1b6Ico7xkYC8T4JGV2GscIqib
	 n/XViD0dYfTykiUswTNRyZS51ONXDXIwq5z8uVW4CR9QMzKLxvtEP3sgp4Y7HPcZvE
	 l4xA7FE5AZOmExO6ywbm6vAKaaoXvW3mFxOoOzSoX36MaKH9ikjLH6LilwXG6lJX/q
	 dP15+HBmqlM9tXp7qrneYz6ZZOOcyfFMWUzr4RjgiOphDTITBDGaOPzyNL/dgDa38N
	 5TM0kkEib8tQg==
Date: Mon, 10 Jun 2024 13:39:40 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] x86: add 'runtime constant' infrastructure
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wgb98nSCvJ-gL42mt+jt6Eyp-0QSMJLovmAoJOkQ_G3gQ@mail.gmail.com>
References: <20240608193504.429644-2-torvalds@linux-foundation.org> <20240610104352.GT8774@noisy.programming.kicks-ass.net> <20240610120201.GAZmbrOYmcA21kD8NB@fat_crate.local> <CAHk-=wgb98nSCvJ-gL42mt+jt6Eyp-0QSMJLovmAoJOkQ_G3gQ@mail.gmail.com>
Message-ID: <71FE7A14-62F6-45D3-9BC4-BE09E06F7863@zytor.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 10, 2024 11:20:21 AM PDT, Linus Torvalds <torvalds@linux-foundation=
=2Eorg> wrote:
>On Mon, 10 Jun 2024 at 05:02, Borislav Petkov <bp@alien8=2Ede> wrote:
>>
>> I think we should accept patches using this only when there really is
>> a good, perf reason for doing so=2E Not "I wanna use this fance shite i=
n
>> my new driver just because=2E=2E=2E"=2E
>
>Absolutely=2E
>
>So for example, if the code could possibly be a module, it's never
>going to be able to use runtime constants=2E
>
>If the code doesn't show up as "noticeable percentage of kernel time
>on real loads", it will not be a valid use for runtime constants=2E
>
>The reason I did __d_lookup_rcu() is that I have optimized that
>function to hell and back before, and it *still* showed up at 14% of
>kernel time on my "empty kernel build" benchmark=2E And the constant
>load was a noticeable - but not dominant - part of that=2E
>
>And yes, it shows up that high because it's all D$ misses, and the
>machine I tested on has more CPU cores than cache, so it's all kinds
>of broken=2E But the point ends up being that __d_lookup_rcu() is just
>very very hot on loads that just do a lot of 'stat()' calls (and such
>loads exist and aren't just microbenchmarks)=2E
>
>I have other functions I see in the 5%+ range of kernel overhead on
>real machines, but they tend to be things like clear_page(), which is
>another kind of issue entirely=2E
>
>And yes, the benchmarks I run are odd ("why would anybody care about
>an empty kernel build?") but somewhat real to me (since I do builds
>between every pull even when they just change a couple of files)=2E
>
>And yes, to actually even see anything else than the CPU security
>issues on x86, you need to build without debug support, and without
>retpolines etc=2E So my profiles are "fake" in that sense, because they
>are the best case profiles without a lot of the horror that people
>enable=2E
>
>Others will have other real benchmarks, which is why I do think we'd
>end up with more uses of this=2E But I would expect a handful, not
>"hundreds"=2E
>
>I could imagine some runtime constant in the core networking socket
>code, for example=2E Or in some scheduler thing=2E Or kernel entry code=
=2E
>
>But not ever in a driver or a filesystem, for example=2E Once you've
>gotten that far off the core code path, the "load a variable" overhead
>just isn't relevant any more=2E
>
>                Linus

So I would also strongly suggest that we make the code fault if it is exec=
uted unpatched if there is no fallback=2E

My original motivation for making the code as complex as I did was to hand=
le both the init and noninit cases, and to handle things other than mov (fo=
r the mov case, it is quite trivial to allow for either a memory reference =
or an immediate, of course, but I was trying to optimize all kinds of opera=
tions, of which shifts were by far the worst=2E Almost certainly a mistake =
on my part=2E)

For that case it also works just fine in modules, since alternatives does =
the patching there already=2E

The way I did it was to introduce a new alternative patching type (a conce=
pt that didn't exist yet, and again I made the mistake of not simply doing =
that part separately first) using the address of the variable in question (=
in the ro_after_init segment) as the alternatives source buffer=2E=20

Much has changed since I hacked on this, a lot of which makes this whole c=
oncept *much* easier to implement=2E We could even make it completely trans=
parent at the programmer level by using objtool or a linker plugin to detec=
t loads from a certain segment and tag them for alternatives patching (whic=
h would, however, require adding padding to some kinds of instructions, not=
ably arbitrary 64-bit immediates=2E)

The one case that gets really nasty for automatic conversation is the case=
 of an arbitrary 64-bit value used in a computation,  like:

    __patchable long b;
    long a;
    /* =2E=2E=2E */
    a +=3D b;

The compiler can generate:=20

     addq b(%rip),%rax

=2E=2E=2E which would require a temporary register to convert to an immedi=
ate=2E On the other hand:=20

    __patchable int b;
    long a;
    /* =2E=2E=2E */
    a +=3D b;

=2E=2E=2E would generate =2E=2E=2E

    movslq b(%rip),%rbx
    addq %rbx,%rax
   =20
=2E=2E=2E which can be compacted down to a single instruction:=20

    addq $bimm,%rax

=2E=2E=2E so *really* optimizing this could be rather tricky without some =
kind of compiler support (native or via plug-in) even=2E The most likely op=
tion would be to generate object code as if immediate instructions are used=
, but with relocations that indicate "value of" rather than "address of" th=
e variable being referenced=2E Postprocessing either at the assembly level =
or object code level (i=2Ee=2E objtool) can then substitute the prepatch se=
quence and alternatives metadata=2E

(If it is a custom plug-in then postprocessing is presumably not necessary=
, of course=2E)

