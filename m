Return-Path: <linux-arch+bounces-2725-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D70B86769A
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 14:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310741C24E2A
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 13:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541F81292F3;
	Mon, 26 Feb 2024 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZ0XgdJs"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DAB12881A;
	Mon, 26 Feb 2024 13:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954329; cv=none; b=WvJUFn//9wl8Clwbbyl89oXYMudpcM8i07DT08ZPLJdRfz74C2vAo6MXNozMiJs2wBVy9AhIFAmRM33wUEGHv+Oy2LIhjg2acXHGpsRGCV9mOtvBxG96MG4GVof6GAZIRteNlmRpNv+PID3v6g4d2tY85nWh936Fh2tfeEHfSoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954329; c=relaxed/simple;
	bh=6PF+2AKQuOPIsoZ9sOdkKoMFsp3t9Bw3zLgGFEbwy2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYtvVTzg6UOyJ1ylRfs6gqrF2BWbyyWLj+8Xx9UqwhYgdHV/YbylOEPttXIHOYMoQzkWx67peQt4/o3fVo+mGES8RlJ99gy5n84PYPPQ3h9eBhNYk1REHe/MINzoCJfZwRYYsxMw8dmcrQHaHT3iIeAguaA/lMt1muThdk982Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZ0XgdJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E74C433C7;
	Mon, 26 Feb 2024 13:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708954328;
	bh=6PF+2AKQuOPIsoZ9sOdkKoMFsp3t9Bw3zLgGFEbwy2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZ0XgdJsJ0Z/oqzm/LB6ro/uE6elSsq/3jb/TpviTvjd5mzm0nA8GYBSL6cj76pJW
	 Y4HSiaFtKyEc1Wo3+IwfI5CwQhmbdpuUEv+nzixKFqs0L+BrVV/Y9QVDzbTt+SGNgQ
	 eLoK/aP19YHao0E1ZxfaBYAcxOs4ZOgfJco6gORhJ1RRVa26QHVRmqYXx5QfPzm4Uz
	 aRtnvE5oWT+ZPBsZ3yDEfB2YrYZ6HsL4FMqK0jF85I5Zstd0IIFwQ7PiGsHK22wJx0
	 5cjCM/W6M7DmhoyDsRLHZs2xeeoBeaHVMJKgQUCPViTedZ4m1byYL/CpovZSNiuTfm
	 agWL2T/7CLyDA==
Date: Mon, 26 Feb 2024 14:32:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Xi Ruoyao <xry111@xry111.site>, Icenowy Zheng <uwu@icenowy.me>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, linux-api@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, Xuefeng Li <lixuefeng@loongson.cn>, 
	Jianmin Lv <lvjianmin@loongson.cn>, Xiaotian Wu <wuxiaotian@loongson.cn>, 
	WANG Rui <wangrui@loongson.cn>, Miao Wang <shankerwangmiao@gmail.com>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, Linux-Arch <linux-arch@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Chromium sandbox on LoongArch and statx -- seccomp deep argument
 inspection again?
Message-ID: <20240226-graustufen-hinsehen-6c578a744806@brauner>
References: <599df4a3-47a4-49be-9c81-8e21ea1f988a@xen0n.name>
 <CAAhV-H4oW70y-2ZSp=b-Ed3A7Jrxfg6xvO8YpjED6To=PF0NwA@mail.gmail.com>
 <f063e65df92228cac6e57b0c21de6b750cf47e42.camel@icenowy.me>
 <24c47463f9b469bdc03e415d953d1ca926d83680.camel@xry111.site>
 <61c5b883762ba4f7fc5a89f539dcd6c8b13d8622.camel@icenowy.me>
 <3c396b7c-adec-4762-9584-5824f310bf7b@app.fastmail.com>
 <6f7a8e320f3c2bd5e9b704bb8d1f311714cd8644.camel@xry111.site>
 <b9fb0de1-bfb9-47a6-9730-325e7641c182@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9fb0de1-bfb9-47a6-9730-325e7641c182@app.fastmail.com>

On Mon, Feb 26, 2024 at 10:20:23AM +0100, Arnd Bergmann wrote:
> On Mon, Feb 26, 2024, at 08:09, Xi Ruoyao wrote:
> > On Mon, 2024-02-26 at 07:56 +0100, Arnd Bergmann wrote:
> >> On Mon, Feb 26, 2024, at 07:03, Icenowy Zheng wrote:
> >> > 在 2024-02-25星期日的 15:32 +0800，Xi Ruoyao写道：
> >> > > On Sun, 2024-02-25 at 14:51 +0800, Icenowy Zheng wrote:
> >> > > > My idea is this problem needs syscalls to be designed with deep
> >> > > > argument inspection in mind; syscalls before this should be
> >> > > > considered
> >> > > > as historical error and get fixed by resotring old syscalls.
> >> > > 
> >> > > I'd not consider fstat an error as using statx for fstat has a
> >> > > performance impact (severe for some workflows), and Linus has
> >> > > concluded
> >> > 
> >> > Sorry for clearance, I mean statx is an error in ABI design, not fstat.
> >
> > I'm wondering why we decided to use AT_EMPTY_PATH/"" instead of
> > "AT_NULL_PATH"/nullptr in the first place?
> 
> Not sure, but it's hard to change now since the libc
> implementation won't easily know whether using the NULL
> path is safe on a given kernel. It could check the kernel
> version number, but that adds another bit of complexity in
> the fast path and doesn't work on old kernels with the
> feature backported.
> 
> > But it's not irrational to pass a path to syscall, as long as we still
> > have the concept of file system (maybe in 2371 or some year we'll use a
> > 128-bit UUID instead of path).
> >
> >> The problem I see with the 'use use fstat' approach is that this
> >> does not work on 32-bit architectures, unless we define a new
> >> fstatat64_time64() syscall, which is one of the things that statx()
> >
> > "fstat64_time64".  Using statx for fstatat should be just fine.
> 
> Right. It does feel wrong to have only an fstat() variant but not
> fstatat() if we go there.
> 
> > Or maybe we can just introduce a new AT_something to make statx
> > completely ignore pathname but behave like AT_EMPTY_PATH + "".
> 
> I think this is better than going back to fstat64_time64(), but
> it's still not great because
> 
> - all the reserved flags on statx() are by definition incompatible
>   with existing kernels that return -EINVAL for any flag they do
>   not recognize.
> 
> - you still need to convince libc developers to actually use
>   the flag despite the backwards compatibility problem, either
>   with a fallback to the current behavior or a version check.
> 
> Using the NULL path as a fallback would solve the problem with
> seccomp, but it would not make the normal case any faster.
> 
> >> was trying to avoid.
> >
> > Oops.  I thought "newstat" should be using 64-bit time but it seems the
> > "new" is not what I'd expected...  The "new" actually means "newer than
> > Linux 0.9"! :(
> >
> > Let's not use "new" in future syscall names...
> 
> Right, we definitely can't ever succeed. On some architectures
> we even had "oldstat" and "stat" before "newstat" and "stat64",
> and on some architectures we mix them up. E.g. x86_64 has fstat()
> and fstatat64() with the same structure but doesn't define
> __NR_newfstat. On mips64, there is a 'newstat' but it has 32-bit
> timestamps unlike all other 64-bit architectures.
> 
> statx() was intended to solve these problems once and for all,
> and it appears that we have failed again.

New apis don't invalidate old apis necessarily. That's just not going to
work in an age where you have containerized workloads.

statx() is just the beginning of this. A container may have aritrary
seccomp profiles that return ENOSYS or even EPERM for whatever reason
for any new api that exists. So not implementing fstat() might already
break container workloads.

Another example: You can't just skip on implementing mount() and only
implement the new mount api for example. Because tools that look for api
simplicity and don't need complex setup will _always_ continue to use
mount() and have a right to do so.

And fwiw, mount() isn't fully inspectable by seccomp since forever. The
list goes on and on.

But let's look at the original mail. Why are they denying statx() and
what's that claim about it not being able to be rewritten to something
safe? Looking at:

intptr_t SIGSYSFstatatHandler(const struct arch_seccomp_data& args,
                              void* fs_denied_errno) {
  if (args.nr == __NR_fstatat_default) {
    if (*reinterpret_cast<const char*>(args.args[1]) == '\0' &&
        args.args[3] == static_cast<uint64_t>(AT_EMPTY_PATH)) {
      return syscall(__NR_fstat_default, static_cast<int>(args.args[0]),
                     reinterpret_cast<default_stat_struct*>(args.args[2]));
    }
    return -reinterpret_cast<intptr_t>(fs_denied_errno);
  }

What this does it to rewrite fstatat() to fstat() if it was made with
AT_EMPTY_PATH and the path argument was "". That is easily doable for
statx() because it has the exact same AT_EMPTY_PATH semantics that
fstatat() has.

Plus, they can even filter on mask and rewrite that to something that
they think is safe. For example, STATX_BASIC_STATS which is equivalent
to what any fstat() call returns. So it's pretty difficult to understand
what their actual gripe with statx() is.

It can't be that statx() passes a struct because fstatat() and fstat()
do that too. So what exactly is that problem there?

What this tells me without knowing the exact reason is that they thought
"Oh, if we just return ENOSYS then the workload or glibc will just
always be able to fallback to fstat() or fstatat()". Which ultimately is
the exact same thing that containers often assume.

So really, just skipping on various system calls isn't going to work.
You can't just implement new system calls and forget about the rest
unless you know exactly what workloads your architecure will run on.

Please implement fstat() or fstatat() and stop inventing hacks for
statx() to make weird sandboxing rules work, please.

