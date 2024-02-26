Return-Path: <linux-arch+bounces-2745-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D58867F0F
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 18:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A8E1C29B0C
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 17:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B34E12FB35;
	Mon, 26 Feb 2024 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen0n.name header.i=@xen0n.name header.b="JjDaLd4L"
X-Original-To: linux-arch@vger.kernel.org
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F63112FB28;
	Mon, 26 Feb 2024 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.28.160.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708969138; cv=none; b=DV8pyY5Qib8P3hyt2uCRWz+z31uUEWChf8tu827u2IRMvd8hXGNFbUHbVE+EPtm+TF/030MiHYyIXhqFwjqPE2xytGBKhhGCsqZW2UAhppXytNiFLIgGEeKd7QTELZa0/Ua6l4Lk8DYGCvaOs1Rus3//HRxNn0A3Qb2CppijsaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708969138; c=relaxed/simple;
	bh=BqoV+f7qOQ3QlYoj2afq3XTuO91YwrBHlrZ8jcSxY2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cBjZI0qLEUMlJoeKqPfg6ZBRDtjdjZpZoLG2xHJARGwawOQq+Bj6c5dhARvihZ4zplnXafScSMXhJ7RL+7OYkjnCxiEKtn5iQy6hUVwuVEs6N9JwuOkZMGobNu4iT6IF07IxulWvBPp1uqDIIhg6M7r6JnEFh2u8TAz+swwdy4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen0n.name; spf=pass smtp.mailfrom=xen0n.name; dkim=pass (1024-bit key) header.d=xen0n.name header.i=@xen0n.name header.b=JjDaLd4L; arc=none smtp.client-ip=115.28.160.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen0n.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen0n.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
	t=1708969132; bh=BqoV+f7qOQ3QlYoj2afq3XTuO91YwrBHlrZ8jcSxY2I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JjDaLd4LlwBUp3pN/hiU0KRjDLosm4DjD0dVWSd5jUYxRrAzt27XKJmyodUq0ITtn
	 GW0h3MrmYXN8RGZC/qFtnGIfoMqcTvNUsUQGPPCqOFbxyZ7RliHpjDg+rlI4tc0HQM
	 BaC1NJMw8QVygdA5lK3G3qEmDSHO7MD0mY7wgnEE=
Received: from [IPV6:240e:388:8d00:6500:68e:73ae:46e1:716] (unknown [IPv6:240e:388:8d00:6500:68e:73ae:46e1:716])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 7D6CE60121;
	Tue, 27 Feb 2024 01:38:52 +0800 (CST)
Message-ID: <3f48b008-4d14-4711-b076-0c8ceccd03f5@xen0n.name>
Date: Tue, 27 Feb 2024 01:38:52 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Chromium sandbox on LoongArch and statx -- seccomp deep argument
 inspection again?
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Xi Ruoyao <xry111@xry111.site>,
 Icenowy Zheng <uwu@icenowy.me>, Huacai Chen <chenhuacai@kernel.org>,
 linux-api@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 Xuefeng Li <lixuefeng@loongson.cn>, Jianmin Lv <lvjianmin@loongson.cn>,
 Xiaotian Wu <wuxiaotian@loongson.cn>, WANG Rui <wangrui@loongson.cn>,
 Miao Wang <shankerwangmiao@gmail.com>,
 "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <599df4a3-47a4-49be-9c81-8e21ea1f988a@xen0n.name>
 <CAAhV-H4oW70y-2ZSp=b-Ed3A7Jrxfg6xvO8YpjED6To=PF0NwA@mail.gmail.com>
 <f063e65df92228cac6e57b0c21de6b750cf47e42.camel@icenowy.me>
 <24c47463f9b469bdc03e415d953d1ca926d83680.camel@xry111.site>
 <61c5b883762ba4f7fc5a89f539dcd6c8b13d8622.camel@icenowy.me>
 <3c396b7c-adec-4762-9584-5824f310bf7b@app.fastmail.com>
 <6f7a8e320f3c2bd5e9b704bb8d1f311714cd8644.camel@xry111.site>
 <b9fb0de1-bfb9-47a6-9730-325e7641c182@app.fastmail.com>
 <20240226-graustufen-hinsehen-6c578a744806@brauner>
 <7641391a-b109-49b3-84c8-7e72053210d8@xen0n.name>
 <20240226-altmodisch-gedeutet-91c5ba2f6071@brauner>
From: WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20240226-altmodisch-gedeutet-91c5ba2f6071@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/26/24 23:35, Christian Brauner wrote:
> On Mon, Feb 26, 2024 at 10:00:05PM +0800, WANG Xuerui wrote:
>> On 2/26/24 21:32, Christian Brauner wrote:
>>> On Mon, Feb 26, 2024 at 10:20:23AM +0100, Arnd Bergmann wrote:
>>>> On Mon, Feb 26, 2024, at 08:09, Xi Ruoyao wrote:
>>>>> On Mon, 2024-02-26 at 07:56 +0100, Arnd Bergmann wrote:
>>>>>> On Mon, Feb 26, 2024, at 07:03, Icenowy Zheng wrote:
>>>>>>> 在 2024-02-25星期日的 15:32 +0800，Xi Ruoyao写道：
>>>>>>>> On Sun, 2024-02-25 at 14:51 +0800, Icenowy Zheng wrote:
>>>>>>>>> My idea is this problem needs syscalls to be designed with deep
>>>>>>>>> argument inspection in mind; syscalls before this should be
>>>>>>>>> considered
>>>>>>>>> as historical error and get fixed by resotring old syscalls.
>>>>>>>> I'd not consider fstat an error as using statx for fstat has a
>>>>>>>> performance impact (severe for some workflows), and Linus has
>>>>>>>> concluded
>>>>>>> Sorry for clearance, I mean statx is an error in ABI design, not fstat.
>>>>> I'm wondering why we decided to use AT_EMPTY_PATH/"" instead of
>>>>> "AT_NULL_PATH"/nullptr in the first place?
>>>> Not sure, but it's hard to change now since the libc
>>>> implementation won't easily know whether using the NULL
>>>> path is safe on a given kernel. It could check the kernel
>>>> version number, but that adds another bit of complexity in
>>>> the fast path and doesn't work on old kernels with the
>>>> feature backported.
>>>>
>>>>> But it's not irrational to pass a path to syscall, as long as we still
>>>>> have the concept of file system (maybe in 2371 or some year we'll use a
>>>>> 128-bit UUID instead of path).
>>>>>
>>>>>> The problem I see with the 'use use fstat' approach is that this
>>>>>> does not work on 32-bit architectures, unless we define a new
>>>>>> fstatat64_time64() syscall, which is one of the things that statx()
>>>>> "fstat64_time64".  Using statx for fstatat should be just fine.
>>>> Right. It does feel wrong to have only an fstat() variant but not
>>>> fstatat() if we go there.
>>>>
>>>>> Or maybe we can just introduce a new AT_something to make statx
>>>>> completely ignore pathname but behave like AT_EMPTY_PATH + "".
>>>> I think this is better than going back to fstat64_time64(), but
>>>> it's still not great because
>>>>
>>>> - all the reserved flags on statx() are by definition incompatible
>>>>     with existing kernels that return -EINVAL for any flag they do
>>>>     not recognize.
>>>>
>>>> - you still need to convince libc developers to actually use
>>>>     the flag despite the backwards compatibility problem, either
>>>>     with a fallback to the current behavior or a version check.
>>>>
>>>> Using the NULL path as a fallback would solve the problem with
>>>> seccomp, but it would not make the normal case any faster.
>>>>
>>>>>> was trying to avoid.
>>>>> Oops.  I thought "newstat" should be using 64-bit time but it seems the
>>>>> "new" is not what I'd expected...  The "new" actually means "newer than
>>>>> Linux 0.9"! :(
>>>>>
>>>>> Let's not use "new" in future syscall names...
>>>> Right, we definitely can't ever succeed. On some architectures
>>>> we even had "oldstat" and "stat" before "newstat" and "stat64",
>>>> and on some architectures we mix them up. E.g. x86_64 has fstat()
>>>> and fstatat64() with the same structure but doesn't define
>>>> __NR_newfstat. On mips64, there is a 'newstat' but it has 32-bit
>>>> timestamps unlike all other 64-bit architectures.
>>>>
>>>> statx() was intended to solve these problems once and for all,
>>>> and it appears that we have failed again.
>>> New apis don't invalidate old apis necessarily. That's just not going to
>>> work in an age where you have containerized workloads.
>>>
>>> statx() is just the beginning of this. A container may have aritrary
>>> seccomp profiles that return ENOSYS or even EPERM for whatever reason
>>> for any new api that exists. So not implementing fstat() might already
>>> break container workloads.
>>>
>>> Another example: You can't just skip on implementing mount() and only
>>> implement the new mount api for example. Because tools that look for api
>>> simplicity and don't need complex setup will _always_ continue to use
>>> mount() and have a right to do so.
>>>
>>> And fwiw, mount() isn't fully inspectable by seccomp since forever. The
>>> list goes on and on.
>>>
>>> But let's look at the original mail. Why are they denying statx() and
>>> what's that claim about it not being able to be rewritten to something
>>> safe? Looking at:
>>>
>>> intptr_t SIGSYSFstatatHandler(const struct arch_seccomp_data& args,
>>>                                 void* fs_denied_errno) {
>>>     if (args.nr == __NR_fstatat_default) {
>>>       if (*reinterpret_cast<const char*>(args.args[1]) == '\0' &&
>>>           args.args[3] == static_cast<uint64_t>(AT_EMPTY_PATH)) {
>>>         return syscall(__NR_fstat_default, static_cast<int>(args.args[0]),
>>>                        reinterpret_cast<default_stat_struct*>(args.args[2]));
>>>       }
>>>       return -reinterpret_cast<intptr_t>(fs_denied_errno);
>>>     }
>>>
>>> What this does it to rewrite fstatat() to fstat() if it was made with
>>> AT_EMPTY_PATH and the path argument was "". That is easily doable for
>>> statx() because it has the exact same AT_EMPTY_PATH semantics that
>>> fstatat() has.
>>>
>>> Plus, they can even filter on mask and rewrite that to something that
>>> they think is safe. For example, STATX_BASIC_STATS which is equivalent
>>> to what any fstat() call returns. So it's pretty difficult to understand
>>> what their actual gripe with statx() is.
>>>
>>> It can't be that statx() passes a struct because fstatat() and fstat()
>>> do that too. So what exactly is that problem there?
>>  From our investigation:
>>
>> For (new)fstatat calls that the sandboxed process may make, this SIGSYS
>> handler either:
>>
>> * turns allowed calls (those looking at fd's) into fstat's that only have
>> one argument (the fd) each, or
>> * denies the call,
> Yes, but look at the filtering that they do:
>
> if (args.nr == __NR_fstatat_default) {
> 	if (*reinterpret_cast<const char*>(args.args[1]) == '\0' &&
> 	    args.args[3] == static_cast<uint64_t>(AT_EMPTY_PATH)) {
>
> So if you have a statx() call instead of an fstatat() call this is
> trivially:
>
> if (args.nr == __NR_statx) {
> 	if (*reinterpret_cast<const char*>(args.args[1]) == '\0' &&
> 	    args.args[2] == static_cast<uint64_t>(AT_EMPTY_PATH)) {
>
> maybe if they care about it also simply check
> args.args[3] == STATX_BASIC_STATS.
>
> And then just as with fstatat() rewrite it to fstat().

But fstat() and fstatat() share the same return value type i.e. struct 
stat, different from struct statx. And they are different enough that 
their existing seccomp policy can distinguish. In the statx-only case 
though, the seccomp policy cannot distinguish "statx actually called 
with empty path" from "statx called with AT_EMPTY_PATH but non-empty 
path" because in both cases the path would be a non-NULL pointer opaque 
to the policy cBPF program.

>> so the sandbox only ever sees fstat calls and no (new)fstatat's, and the
>> guarantee that only open fds can ever been stat'ed trivially holds.
>>
>> With statx, however, there's no way of guaranteeing "only look at fd"
>> semantics without peeking into the path argument, because a non-empty path
>> makes AT_EMPTY_PATH ineffective, and the flags are not validated prior to
>> use making it near-impossible to introduce new semantics in a
>> backwards-compatible manner.
> I don't understand. That's exactly the same thing as for fstatat(). My
> point is that you can turn statx() into fstat() just like you can turn
> fstatat() into fstat(). So if you add fstat()/fstat64() what's left to
> do?
Yes, once fstat is restored it's a matter of transforming every allowed 
statx into fstat, then translating struct stat back into struct statx. 
What we're seeking is a possible way forward without re-introducing that 
though, because we still have some time and don't have to rush.
>>> What this tells me without knowing the exact reason is that they thought
>>> "Oh, if we just return ENOSYS then the workload or glibc will just
>>> always be able to fallback to fstat() or fstatat()". Which ultimately is
>>> the exact same thing that containers often assume.
>>>
>>> So really, just skipping on various system calls isn't going to work.
>>> You can't just implement new system calls and forget about the rest
>>> unless you know exactly what workloads your architecure will run on.
>>>
>>> Please implement fstat() or fstatat() and stop inventing hacks for
>>> statx() to make weird sandboxing rules work, please.
>> We have already provided fstat(at) on LoongArch for a while by
>> unconditionally doing statx and translating the returned structure -- see
>> the [glibc] and [golang] [golang-2] implementations for example -- without
> But you're doing that translation in userspace. I was talking about
> adding the fstat()/fstat64() system calls.
Hmm, yeah. I meant to provide some more context but I later realized 
that the sandbox is in charge of rewriting the syscalls from inside the 
sandbox, so the userland may not matter in the big picture after all.

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/


