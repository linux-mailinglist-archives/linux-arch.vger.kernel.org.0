Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6387D51F962
	for <lists+linux-arch@lfdr.de>; Mon,  9 May 2022 12:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiEIKMb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 May 2022 06:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbiEIKM3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 May 2022 06:12:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368CF233A6A;
        Mon,  9 May 2022 03:08:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A54AAB80D3C;
        Mon,  9 May 2022 10:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308F7C385A8;
        Mon,  9 May 2022 10:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652090465;
        bh=Xj+BxxtzqKq6ClC+lgtNkIEjRLg+0U/DyE+0EsHanR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rVhyEI4DCCNX9EpA2cYe+oghmzpR+KJ7NQEvWTwkt57PG8e+pkVTuXwkv68g1h8ty
         X0d530Fm1dTEXvRXxQo84SlftXYiVkh6cviQ9dYCER0QlBP6uf83H4OEoiPXZFyh/y
         831mCcvaiHL8kyxFd9ZkztQaBJQV1AKE8sqHtYI12swbA6JHnt/fURNh7iDnXA/025
         Zbnoj/7G6qtsBV6hdnhu3VLlfjJtadyE0ZW6ckVDMUKZvdDf2Omi4GgcMKYXtlg+W0
         2Nny282doe/wTCMPH/Zs+Uc79huxL3X5FjzwT7h6qM4vt1n0cH0b3/qcH2hhclM/Ao
         JOLdtch+eOtmQ==
Date:   Mon, 9 May 2022 12:00:58 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH V9 13/24] LoongArch: Add system call support
Message-ID: <20220509100058.vmrgn5fkk3ayt63v@wittgenstein>
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
 <20220430090518.3127980-14-chenhuacai@loongson.cn>
 <CAK8P3a0A9dW4mwJ6JHDiJxizL7vWfr4r4c5KhbjtAY0sWbZJVA@mail.gmail.com>
 <CAAhV-H4te_+AS69viO4eBz=abBUm5oQ6AfoY1Cb+nOCZyyeMdA@mail.gmail.com>
 <CAK8P3a0DqQcApv8aa2dgBS5At=tEkN7cnaskoUeXDi2-Bu9Rnw@mail.gmail.com>
 <20220507121104.7soocpgoqkvwv3gc@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220507121104.7soocpgoqkvwv3gc@wittgenstein>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 07, 2022 at 02:11:04PM +0200, Christian Brauner wrote:
> On Sat, Apr 30, 2022 at 12:34:52PM +0200, Arnd Bergmann wrote:
> > On Sat, Apr 30, 2022 at 12:05 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> > > On Sat, Apr 30, 2022 at 5:45 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Sat, Apr 30, 2022 at 11:05 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > > >
> > > > > This patch adds system call support and related uaccess.h for LoongArch.
> > > > >
> > > > > Q: Why keep __ARCH_WANT_NEW_STAT definition while there is statx:
> > > > > A: Until the latest glibc release (2.34), statx is only used for 32-bit
> > > > >    platforms, or 64-bit platforms with 32-bit timestamp. I.e., Most 64-
> > > > >    bit platforms still use newstat now.
> > > > >
> > > > > Q: Why keep _ARCH_WANT_SYS_CLONE definition while there is clone3:
> > > > > A: The latest glibc release (2.34) has some basic support for clone3 but
> > > > >    it isn't complete. E.g., pthread_create() and spawni() have converted
> > > > >    to use clone3 but fork() will still use clone. Moreover, some seccomp
> > > > >    related applications can still not work perfectly with clone3. E.g.,
> > > > >    Chromium sandbox cannot work at all and there is no solution for it,
> > > > >    which is more terrible than the fork() story [1].
> > > > >
> > > > > [1] https://chromium-review.googlesource.com/c/chromium/src/+/2936184
> > > >
> > > > I still think these have to be removed. There is no mainline glibc or musl
> > > > port yet, and neither of them should actually be required. Please remove
> > > > them here, and modify your libc patches accordingly when you send those
> > > > upstream.
> > >
> > > If this is just a problem that can be resolved by upgrading
> > > glibc/musl, I will remove them. But the Chromium problem (or sandbox
> > > problem in general) seems to have no solution now.
> > 
> > I added Christian Brauner to Cc now, maybe he has come across the
> > sandbox problem before and has an idea for a solution.
> 
> (I just got back from LSFMM so I'll reply in more detail next week. I'm
> still pretty jet-lagged.)

Right, I forgot about the EPERM/ENOSYS sandbox thread.

Kees and I gave a talk about this problem at LPC 2019 (see [2]). The
proposed solutions back then was to add basic deep argument inspection
for first-level pointers to seccomp.

There are problems with this approach such as not useable on
second-level pointers (although we concluded that's ok) and if the input
args are very large copying stuff from within seccomp becomes rather
costly and in general the various approaches seemed handwavy at the
time.

If seccomp were to be made to support some basic form of eBPF such that
it can still be safely called by unprivileged users then this would
likely be easier to do (famous last words) but given that the stance has
traditionally bee to not port seccomp it remains a tricky patch.

Some time after that I talked to Mathieu Desnoyers about this issue who
used another angle of attack. The idea seems less complicated to me.
Instead of argument inspection we introduce basic syscall argument
checksumming for seccomp. It would only be done when seccomp is
interested in syscall input args and checksumming would be per syscall
argument. It would be validated within the syscall when it actually
reads the arguments; again, only if seccomp is used. If the checksums
mismatch an error is returned or the calling process terminated.

There's one case that deserves mentioning: since we introduced the
seccomp notifier we do allow advanced syscall interception and we do use
it extensively in various projects.

Roughly, it works by allowing a userspace process (the "supervisor") to
listen on a seccomp fd. The seccomp fd is an fd referring to the filter
of a target task (the "supervisee"). When the supervisee performs a
syscall listed in the seccomp notify filter the supervisor will receive
a notification on the seccomp fd for the filter.

I mention this because it is possible for the supervisor to e.g.
intercept an bpf() system call and then modify/create/attach a bpf
program for the supervisee and then update fields in the supervisee's
bpf struct that was passed to the bpf() syscall by it. So the supervisor
might rewrite syscall args and continue the syscall (In general, it's
not recommeneded because of TOCTOU. But still doable in certain
scenarios where we can guarantee that this is safe even if syscall args
are rewritten to something else by a MIT attack.).

Arguably, the checksumming approach could even be made to work with this
if the seccomp fd learns a new ioctl() or similar to safely update the
checksum.

I can try and move a poc for this up the todo list.

Without an approach like this certain sandboxes will fallback to
ENOSYSing system calls they can't filter. This is a generic problem
though with clone3() being one promiment example.

[2]: https://www.youtube.com/watch?v=PnOSPsRzVYM&list=PLVsQ_xZBEyN2Ol7y8axxhbTsG47Va3Se2
