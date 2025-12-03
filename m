Return-Path: <linux-arch+bounces-15127-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D21EC9DE2D
	for <lists+linux-arch@lfdr.de>; Wed, 03 Dec 2025 07:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5886B3461FF
	for <lists+linux-arch@lfdr.de>; Wed,  3 Dec 2025 06:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340FC29E0FD;
	Wed,  3 Dec 2025 06:04:20 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7782877CB;
	Wed,  3 Dec 2025 06:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764741860; cv=none; b=GmFiqCbO+P62RhfyCd6mLKCiVFSPu6lKMopa6R9mB7TNg7h+nySd2maF5NichpVqAG3GaDUFA86RWie8bujyZoREDig+JY34KVSdNoSBd1GVSqck4+smexP9penn4Nr3skmxAou5SluiWEv9o+RM2xR0K8KhaTGZcB2h1j2FJnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764741860; c=relaxed/simple;
	bh=Cv1m6mFOEbqxqQ7ohqRcJ0BfyrpDB7qBBNdsXm8lCM4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nuyl71GcbNf3pdsM6VAoyvzGRPzcsPHKxYGN/dimlcHkfI8sFwj3VkZ7zZtO19ykBaniIuYKBNyNeM/kxJWVPJovt6bYLWjEb+ayVtv+tIH5kkMQXUhM2O7qKn5YjeD9u4HnNkAvUqSfSiOhaCXK8a2clOeAVTyxlMCTQTE0CIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org; spf=pass smtp.mailfrom=tinylab.org; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinylab.org
X-QQ-mid: esmtpsz19t1764741758t994f776a
X-QQ-Originating-IP: ecJ7hl59DzA1RsOBM2o5nW7l0oYjMDoO2gtQ1U1uKbs=
Received: from [169.235.25.235] ( [169.235.25.235])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Dec 2025 14:02:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9602860117365221652
EX-QQ-RecipientCnt: 13
Message-ID: <921F22AF0D7D10F0+3a743e26-ae83-40e8-b266-ccffe478d2c7@tinylab.org>
Date: Tue, 2 Dec 2025 22:02:31 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yuan Tan <tanyuan@tinylab.org>
Subject: Re: [PATCH v2 0/8] dce, riscv: Unused syscall trimming with
 PUSHSECTION and conditional KEEP()
To: Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-kbuild@vger.kernel.org, linux-riscv@lists.infradead.org
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 i@maskray.me, Zhangjin Wu <falcon@tinylab.org>, ronbogo@outlook.com,
 z1652074432@gmail.com, lx24@stu.ynu.edu.cn
References: <30C972B6393DBAC5+cover.1760463245.git.tanyuan@tinylab.org>
 <33333fdd-2aa2-4ce0-8781-92222829ea12@app.fastmail.com>
 <0BF8B2E83B6154B6+f17f32b4-f6ff-4184-917d-4b27fb916eae@tinylab.org>
 <73010511-a804-4cf4-a5c1-1d08e3f324c5@app.fastmail.com>
Content-Language: en-US
In-Reply-To: <73010511-a804-4cf4-a5c1-1d08e3f324c5@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mn6sU2dhbGGPy3SlOxmaK0LE5Z51PtSefaFsZdr10igLsnLoZ95HCyu4
	3kYfG0vJgPK/ONwJr9N/nsFfj9qj/HisO07YKO8nXRGSkZRFa+83dLwGoRUssC3rLlh9dNy
	rf50P9OviAxHJ4/ZhX+rXutNF42Wkm6kuFvPUwzPyWSD6ch45QEgL48BjtTb1TzOZ3GOFwN
	x/8ks0KlKaPJPFcwUZqk+Dw/s9j88yFfyUDCsT4YG8x4MZGDehtt6HrEyE6G0vBVH7Uk+mV
	ubttnFKf0VURGnjyTeQeBFf4H11FZkUr9nxBGsjHU7CxxUeJieUl+dNYdUg/OdrMaahSWfk
	KzbrVtj9wO2/MpiwNlY60fo/bRxRCHZ4iXrEnsw6vm+ygvf3r3RXWZc98CyJ8WkMx8uzfs/
	dfYMO1tf2FBh15cZbl40QZMxMwt3hm9GZfmfJzYMWGXWqtuLL9G0KEh7lWdvP0lhoAtuPop
	M38YkHg4QauuibB+CaVMtmGzTeEW9rPwxWHEeIbT1TmJkIcsgW7S4pucyrFreDI4BxMCBK8
	jp5OaeP4GxldON2poRnHEgpwF2tIxKyFG1bs3U+0TTVn372PKL9dtRhBiAmOn5fdAE0L80w
	SBM8lgX42BceNrMN2ovfQInrloEcjhwnyj0qoWOIuYSzTV37mRCpnXc0c3oGntduZin8Mqk
	ZvVv+FI7akoPZ9DRXIqQyyR7YDXHVT+S/iIxGZoHvngBzEgUS4u6yhaPt0SOB3ApXhuhiKi
	o0UlpKBqBIoIoCUPtPe8gxJytnoMsNvEmvWqqGVfRFdGL1HxL2thAHDH8Mr/Y5rVADX76v1
	3pMr5+36aQRL3I7nmCCDmmtxzgRkvdaAexXPBox+oi9w4/Qe7GLVrrXbYX+zplGeYmFiGHo
	EmVCeLFwrXlgjDkhGot5B77MC/3TNGMhWM1DgK1/30ujzGa4rA52WRSH72kfGf2Xp1FUghH
	SqC0Fule4TVHSHq9v2ib1s8xDn6dlcEh+8dIC5kcPrWW5FpgCV3aMAxi/
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0


On 11/7/2025 5:33 AM, Arnd Bergmann wrote:
> On Tue, Nov 4, 2025, at 03:21, Yuan Tan wrote:
>
>>> Sorry for the late reply — this patchset really wore me out, and I only just
>>> recovered.  Thank you very much for your feedback!
> Sorry to hear this has been stressful for you. It's an unfortunate
> aspect of the way we work that sometimes 
>
>> On 10/15/2025 12:47 AM, Arnd Bergmann wrote:
>>> On Wed, Oct 15, 2025, at 08:16, Yuan Tan wrote:
>>> Thanks a lot for your work on this. I think it is indeed valuable to
>>> be able to optimize kernels with a smaller subset of system calls for
>>> known workloads, and have as much dead code elimination as possible.
>>>
>>> However, I continue to think that the added scripting with a known
>>> set of syscall names is fundamentally the wrong approach to get to
>>> this list: This adds complexity to the build process in one of
>>> the areas that is already too complicated, and it duplicates what
>>> we can already do with Kconfig for a subset of the system calls.
>>>
>>> I think the way we should configure the set of syscalls instead is
>>> to add more Kconfig symbols guarded by CONFIG_EXPERT that turn
>>> classes of syscalls on or off. You have obviously done the research
>>> to come up with a list of used/unused entry points for one or more
>>> workloads. Can you share those lists?
>> Regarding your suggestion to use Kconfig to control which system calls are
>> included or excluded, perhaps we could take inspiration from systemd's
>> classification approach. For example, systemd groups syscalls into categories
>> like[1]:
>>
>> @aio @basic-io @chown @clock @cpu-emulation @debug @file-system
>>
>> and so on.
> I think many of the categories already naturally align with the
> structure of the kernel source code, so maintaining them naturally comes
> out of the build system.
>
> More importantly, turning off parts of the kernel on a per-file
> basis tends to work better for eliminating the entire block
> of code because only removing the syscall entry still leaves
> references to functions and global data structures from initcalls
> and exported functions.
>
>> However, if we go down this route, we would need to continuously maintain and
>> update these categories whenever Linux introduces new system calls. I' m not
>> sure whether that would be an ideal long-term approach.
> If we can (at least roughly) align the categories between the kernel and the
> systemd classification, that would at least make it easier to maintain
> the systemd ones.
>
>> For reference, here is the list of syscalls required to run Lighttpd.
>>
>> execve set_tid_address mount write brk mmap munmap getuid getgid getpid
>> clock_gettime getcwd fcntl fstat read dup3 socket setsockopt bind listen
>> rt_sigaction rt_sigprocmask newfstatat prlimit64 epoll_create1 epoll_ctl pipe2
>> epoll_pwait accept4 getsockopt recvfrom shutdown writev getdents64 openat close
>>
>> We've tested it successfully on QEMU + initramfs, and I can share the
>> deployment script if anyone would like to reproduce the setup.
> Thanks for the list! Is this a workload you are interested in actually
> optimizing for deployment, or just something you used as a simple test
> environment?
>
> I see three types of syscalls in your list above:
>
> 1. essential ones that are basically always needed
> 2. socket interfaces (already optional)
> 3. epoll (already optional)
>
> The first two sets are clearly going to have more syscalls in
> them that are usually used in combination with the others:
> If we provide read, write and writev, we should also provide readv,
> and if we provide socket/bind/listen/recvfrom, we also likely want
> accept/connect/sendto and probably recvmsg/sendmsg.
>
> Starting with your set of syscalls and those closely related
> ones, as well as the set of syscalls that already have a
> Kconfig option, we should be able to find the set of syscalls
> that are unconditionally enabled but could be optional.
> If you have the chance, could you compile that list?
> I might also have a list, but probably not in the next week.
>
> The next step after that I think is to measure the impact
> of turning off those remaining ones in a configuration that
> has the existing symbols (e.g. sysvipc, futex, compat_32bit_time,
> ...) disabled already.
>
> Side note: I'm a  bit surprised to see fstat() in the list, since riscv
> should only really support newfstat().


The syscall list comes from a simple test environment rather than a
workload I intend to optimize for deployment.

The list I posted was generated using strace on RISC-V QEMU. I was
looking at the ABI names, not the actual kernel syscall names.  One
question here: for syscall trimming, should we discuss everything in
terms of syscall ABI names or the actual kernel syscall function names?
I would like to confirm your preference before I continue with the
updated list.

For now, I'll continue the discussion in terms of syscall ABI names.

Following your suggestion, I started by taking the syscall list required
for the Lighttpd workload and expanded it into the corresponding
functional groups.

Here is a very preliminary draft of the syscall grouping, based on the
systemd classification.

https://pastebin.com/raw/Yx92bb3m

Then, I wrote a small script that classifies each syscall from lighttpd
into its category and then enumerates all syscalls belonging to those
categories.

It addresses two of the items you asked for

- Identifying the syscall families related to my minimal Lighttpd
  workload

- Enumerating which syscalls appear in those categories and could
  potentially become optional

```
Categories present in lighttpd_syscalls.txt:
  @basic-io: 5 / 16
  @clock: 1 / 8
  @default: 9 / 30
  @file-system: 6 / 47
  @io-event: 3 / 7
  @ipc: 1 / 23
  @mount: 1 / 13
  @network-io: 8 / 18
  @signal: 2 / 14
Total unique categories: 9
Total categories defined: 30

Categories not present in lighttpd_syscalls.txt:
  @aio: 0 / 9
  @chown: 0 / 2
  @debug: 0 / 5
  @keyring: 0 / 3
  @memlock: 0 / 5
  @module: 0 / 3
  @pkey: 0 / 3
  @privileged: 0 / 15
  @process: 0 / 24
  @reboot: 0 / 3
  @resources: 0 / 14
  @sandbox: 0 / 4
  @setuid: 0 / 12
  @swap: 0 / 2
  @sync: 0 / 6
  @system-service: 0 / 24
  @timer: 0 / 11
  arch-specific: 0 / 1
  memory-isolation: 0 / 1
  memory-protection: 0 / 1
  security-lsm: 0 / 3

All syscalls in the appearing categories:
accept, accept4, adjtimex, bind, brk, cachestat, chdir, chroot, clock_adjtime, clock_getres, clock_gettime, clock_nanosleep, clock_settime, close, close_range, connect, copy_file_range, dup, dup3, epoll_create1, epoll_ctl, epoll_pwait, epoll_pwait2, eventfd2, execve, exit, exit_group, faccessat, faccessat2, fallocate, fchdir, fchmod, fchmodat, fchmodat2, fcntl, fgetxattr, flistxattr, fremovexattr, fsconfig, fsetxattr, fsmount, fsopen, fspick, fstat, fstatfs, ftruncate, futex, futex_requeue, futex_wait, futex_waitv, futex_wake, get_robust_list, getcwd, getdents64, getegid, geteuid, getgid, getpeername, getpid, getppid, getrandom, getsockname, getsockopt, gettid, gettimeofday, getuid, getxattr, inotify_add_watch, inotify_init1, inotify_rm_watch, ioctl, kill, lgetxattr, linkat, listen, listmount, listxattr, llistxattr, lremovexattr, lseek, lsetxattr, membarrier, memfd_create, mkdirat, mknodat, mmap, mount, mount_setattr, move_mount, mprotect, mq_getsetattr, mq_notify, mq_open,
mq_timedreceive, mq_timedsend, mq_unlink, mremap, msgctl, msgget, msgrcv, msgsnd, munmap, newfstatat, open_tree, openat, openat2, pidfd_send_signal, pipe2, pivot_root, ppoll, pread64, preadv, preadv2, prlimit64, process_madvise, process_vm_readv, process_vm_writev, pselect6, pwrite64, pwritev, pwritev2, read, readahead, readlinkat, readv, recvfrom, recvmmsg, recvmsg, removexattr, renameat2, restart_syscall, riscv_flush_icache, riscv_hwprobe, rseq, rt_sigaction, rt_sigpending, rt_sigprocmask, rt_sigqueueinfo, rt_sigreturn, rt_sigsuspend, rt_sigtimedwait, rt_tgsigqueueinfo, semctl, semget, semop, semtimedop, sendmmsg, sendmsg, sendto, set_robust_list, set_tid_address, setsockopt, settimeofday, setxattr, shmat, shmctl, shmdt, shmget, shutdown, sigaltstack, signalfd4, socket, socketpair, statfs, statmount, statx, symlinkat, tgkill, tkill, truncate, umask, umount2, unlinkat, utimensat, write, writev
Total syscalls in these categories: 176
```


This produces a list of 176 syscalls across 9 categories that are
relevant to the workload. The output also shows which categories do not
appear in this workload (21 categories with 0 syscalls used).

If the categorization works this way, it's actually quite surprising
that even such a simple workload would pull in as many as 176 syscalls.
I'm not sure yet what the actual trimming impact will look like after
building, but I will test that next.

>> Also, I noticed that there haven't been any comments so far on the later
>> patches introducing the PUSHSECTION macro.  I' m a bit concerned about how
>> people perceive this part.
> I don't have a strong opinion on this part.
>
>      Arnd


