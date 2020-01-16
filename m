Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8BC013D8E9
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jan 2020 12:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgAPLZY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jan 2020 06:25:24 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35004 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgAPLZY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jan 2020 06:25:24 -0500
Received: from ip5f5bd663.dynamic.kabel-deutschland.de ([95.91.214.99] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1is3H5-0001S8-FE; Thu, 16 Jan 2020 11:25:19 +0000
Date:   Thu, 16 Jan 2020 12:25:18 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Subject: Re: clone3 on ARC (was Re: [PATCH v3 2/2] arch: wire-up clone3()
 syscall)
Message-ID: <20200116112517.53luv7qolevtqjpu@wittgenstein>
References: <20190604160944.4058-1-christian@brauner.io>
 <20190604160944.4058-2-christian@brauner.io>
 <CAK8P3a0OfBpx6y4m5uWX-DUg16NoFby5ik-3xCcD+yMrw0tbEw@mail.gmail.com>
 <20190604212930.jaaztvkent32b7d3@brauner.io>
 <a58c8425-83a3-b64c-339a-7e94a72f4bee@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a58c8425-83a3-b64c-339a-7e94a72f4bee@synopsys.com>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 15, 2020 at 10:41:20PM +0000, Vineet Gupta wrote:
> On 6/4/19 2:29 PM, Christian Brauner wrote:
> > On Tue, Jun 04, 2019 at 08:40:01PM +0200, Arnd Bergmann wrote:
> >> On Tue, Jun 4, 2019 at 6:09 PM Christian Brauner <christian@brauner.io> wrote:
> >>>
> >>> Wire up the clone3() call on all arches that don't require hand-rolled
> >>> assembly.
> >>>
> >>> Some of the arches look like they need special assembly massaging and it is
> >>> probably smarter if the appropriate arch maintainers would do the actual
> >>> wiring. Arches that are wired-up are:
> >>> - x86{_32,64}
> >>> - arm{64}
> >>> - xtensa
> >>
> >> The ones you did look good to me. I would hope that we can do all other
> >> architectures the same way, even if they have special assembly wrappers
> >> for the old clone(). The most interesting cases appear to be ia64, alpha,
> >> m68k and sparc, so it would be good if their maintainers could take a
> >> look.
> > 
> > Yes, agreed. They can sort this out even after this lands.
> > 
> >>
> >> What do you use for testing? Would it be possible to override the
> >> internal clone() function in glibc with an LD_PRELOAD library
> >> to quickly test one of the other architectures for regressions?
> > 
> > I have a test program that is rather horrendously ugly and I compiled
> > kernels for x86 and the arms and tested in qemu. The program basically
> > looks like [1].
> 
> I just got around to fixing this for ARC (patch to follow after we sort out the
> testing) and was trying to use the test case below for a qucik and dirty smoke
> test (so existing toolchain lacking with headers lacking NR_clone3 or struct
> clone_args etc). I did hack those up, but then spotted below
> 
> uapi/linux/sched.h
> 
> |    struct clone_args {
> |	__aligned_u64 flags;
> |	__aligned_u64 pidfd;
> |	__aligned_u64 child_tid;
> |	__aligned_u64 parent_tid;
> ..
> ..
> 
> Are all clone3 arg fields supposed to be 64-bit wide, even things like @child_tid,
> @tls .... which are traditionally ARCH word wide ?

This is just the kernel ABI we expose to userspace with the intention to
make it easy for us to handle 32 and 64 bit. A libc like glibc is
expected to expose a properly typed struct to userspace. The kernel
struct kernel_clone_args has "correct" typing.

Christian
