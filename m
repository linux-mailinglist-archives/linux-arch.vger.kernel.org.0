Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8679248A245
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jan 2022 23:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241262AbiAJWEQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jan 2022 17:04:16 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:42581 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiAJWEP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jan 2022 17:04:15 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MXXdn-1mrPQv1A5f-00Z2sF; Mon, 10 Jan 2022 23:04:14 +0100
Received: by mail-wm1-f42.google.com with SMTP id n19-20020a7bc5d3000000b003466ef16375so308944wmk.1;
        Mon, 10 Jan 2022 14:04:14 -0800 (PST)
X-Gm-Message-State: AOAM5308Px2BSL92C/badE9AqS39ltRNxQ17XquJPIjyLlWuoibzJuuV
        c4Ni4navSaTvhc2ajGRjBcWIT1DIPRDtsMcCJHk=
X-Google-Smtp-Source: ABdhPJyciqcg2uvXeIfuwE7UNZzHXNuNt1HQPy9AJQg0ko57Ij4iRi/iwrgrOSmmVXTt1zVT/mtee43J2O0Y7jwucVI=
X-Received: by 2002:a7b:ce96:: with SMTP id q22mr3334217wmj.82.1641852253858;
 Mon, 10 Jan 2022 14:04:13 -0800 (PST)
MIME-Version: 1.0
References: <Ydm7ReZWQPrbIugn@gmail.com>
In-Reply-To: <Ydm7ReZWQPrbIugn@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 10 Jan 2022 23:03:57 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1emGYHPcjTfLqd-yyU8_9w88=2g_B_vfhbKeDtDHMM-w@mail.gmail.com>
Message-ID: <CAK8P3a1emGYHPcjTfLqd-yyU8_9w88=2g_B_vfhbKeDtDHMM-w@mail.gmail.com>
Subject: Re: [ANNOUNCE] "Fast Kernel Headers" Tree -v2
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:u9nyXwUNAqT1urpk/aR3aX4MZpsrEVsSfnNR162ErlLN5OMdeFp
 Mo9UH4FJ3mm9UjuET6GuRcEDavhf2cEP4hHEUHbWT+xiVy4JinEbDoA4nIZFahhPoNV5FS9
 tftdo0fDxRbXzcBOKLyMCWxosJ+EEB7kckDdnk/uhRRbYoA9Bc1zpUKp+wYw3EemxDUuprX
 1yZix46Nfl1WmffSFc2Qg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:djMmaCRJkno=:KHysov6eQzTRBkXpYHNGEE
 isp9TGYS7fK0s5XW2+y20cM28Z7Gc6999vkXssNN5nouE1d1WlVwvyst9sBozGaQGIEmEbRMa
 Oebg/pVQPbOyvTYWWi1S2PfY3zrCbn0tOSTp5cDSfW8rA3Ti2C+/QmKtwNgnbqoxfWgTE+KvY
 i0/l321GHMaEzb8b+YCP8uXlr5qcpDZhbpIjs2IPfeT/MszxUbx8g5cV6IrYQrJKQoqWCcjrr
 tThg6vYycM19E74MfKR8v80vfkr9BTcgDp8VNDGVJ2fGpJT96eJJyE4vMaRJfgMnTjriq+eLW
 fr0CApSrL6cA+aBGSL2lsvVwt0A+6Su9YRg+uDpLrcnAUbeFldZCyyaI3b51chvlDVZnghg5D
 Y8kLHCkn137SmHK8zb++5qFrwpmU4HHAK6D/7FJ5He97PjC+ZyQtVBcoN/xvCiuWG48LCKCIN
 3QO1NsJ1NzW5FHJ8uVW6MH7kfaNCdyXl2CKZkjQ8KruRX6Y472oMWkVqvvrHaHUdmS2UY51+O
 JPWh+jGqbbWwB/KbuVcXNqBRACSuS7plf9Z9p0K7waMi8ErMz57MTAgrxOClK2cHNf/9iT+8m
 c7Tn8Upmat3/XkKX5Dx9J5D14f7GJPQKiVQniQ3gOdUBhnyttHe9Am/sxKVftIyPHJx00u1dx
 gQbMPrQo/doaldsFR1H0QpzBT34huIcxQRhmTc3M3SgFnBB7rV0ePDeUxtD05Jb3lwaU=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 8, 2022 at 5:26 PM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> I'm pleased to announce -v2 of the "Fast Kernel Headers" tree, which is a
> comprehensive rework of the Linux kernel's header hierarchy & header
> dependencies, with the dual goals of:
>
>  - speeding up the kernel build (both absolute and incremental build times)
>
>  - decoupling subsystem type & API definitions from each other
>
> The fast-headers tree consists of over 25 sub-trees internally, spanning
> over 2,300 commits, which can be found at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
>
>    # HEAD: 391ce485ced0 headers/deps: Introduce the CONFIG_FAST_HEADERS=y config option

I've started reading through it at last. I can't say that I'm
reviewing every patch, but
at least (almost all) the things I've looked at so far all seem really
nice to me, mostly
this is the same that I was planning to do as well, some things I
would have done
differently but I'm not complaining as you did the work, and some things seem
unnecessary but might not be.

I've started building randconfig kernels for arm64 and x86, and fixing
up things that come up,
a few things I have noticed out so far:

* 2e98ec93d465 ("headers/prep: Rename constants: SOCK_DESTROY =>
SOCK_DIAG_SOCK_DESTROY")

  This one looks wrong, as you are changing a uapi header, possibly
breaking applications
  at compile time. I think the other one should be renamed instead.

* 04293522a8cb ("headers/deps: ipc/shm: Move the 'struct shmid_ds'
definition to ipc/shm.c")
  and related patches

  Similarly, the IPC structures are uapi headers that I would not
change here for the same reasons.
  Even if nothing uses those any more with modern libc
implementations, the structures belong into
  uapi, unless we can prove that the old-style sysvipc interface is
completely unused and we
  remove the implementation from the kernel as well (I don't think we
want that, but I have not
  looked in depth at when it was last used by a libc)

* changing any include/uapi headers to use "#include <uapi/linux/*.h>"
is broken because
  that makes the headers unusable from userspace, including any of
tools/*/. I think we
  can work around this in the headers_install.sh postprocessing step
though, where we already
  do unifdef etc.

* For all the header additions to .c files, I assume you are using a
set of script, so these could
  probably be changed without much trouble. I would suggest applying
them in sequence so
   the headers remain sorted alphabetically in the end. It would
probably make sense to
   squash those all together to avoid patching certain files many
times over, for the sake
   of keeping a slightly saner git history.

* The per-task stuff sounded a bit scary from your descriptions but
looking at the actual
   implementation I now get it, this looks like a really nice way of doing it.

* I think it would be good to keep the include/linux/syscalls_api.h declarations
   in the same header as the SYSCALL_DEFINE*() macros, to ensure that the
   prototypes remain synchronized. Splitting them out will likely also
cause sparse
   warnings for missing prototypes (or maybe it should but doesn't at
the moment).

* include/linux/time64_types.h is not a good name, as these are now
the default types
   after we removed the time32 versions. I'd either rename it to
linux/time_types.h
   or split it up between linux/types.h and linux/ktime_types.h

* arm64 needs  a couple of minor fixups, see
https://pastebin.com/eSKhz4CL for what
  I have so far, feel free to integrate any things that directly make sense.

         Arnd
