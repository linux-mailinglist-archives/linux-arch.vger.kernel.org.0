Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065AF48D596
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jan 2022 11:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbiAMKRM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jan 2022 05:17:12 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:38917 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiAMKRL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Jan 2022 05:17:11 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MnaY1-1mg0OW3Wc9-00jdNT; Thu, 13 Jan 2022 11:17:09 +0100
Received: by mail-wr1-f48.google.com with SMTP id x4so9145856wru.7;
        Thu, 13 Jan 2022 02:17:09 -0800 (PST)
X-Gm-Message-State: AOAM530g5AZtkemmm+gsxwZhoQUhVhp0RCDzbdQb1p4rhpa1DTc5cb9j
        Vo6OG6bUuIx0s3sSMgav8ECakA/Vp1LVOL69RGg=
X-Google-Smtp-Source: ABdhPJx3fbPaX/EtcCPY2WtRP8M4sTFAgLOPYVZcoPzlr4KJ3TscIN6PSqBl2Z7f7ES8SN4tlkrlMUHqLuIOlCbmWqU=
X-Received: by 2002:a5d:548b:: with SMTP id h11mr3297689wrv.12.1642069029342;
 Thu, 13 Jan 2022 02:17:09 -0800 (PST)
MIME-Version: 1.0
References: <Ydm7ReZWQPrbIugn@gmail.com> <CAK8P3a1emGYHPcjTfLqd-yyU8_9w88=2g_B_vfhbKeDtDHMM-w@mail.gmail.com>
 <Yd/pYSKZKDgPieVR@gmail.com>
In-Reply-To: <Yd/pYSKZKDgPieVR@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 13 Jan 2022 11:16:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0Gz3h4SDbgyx-73ER2Q2yPqn5vOxDErGtQ64Q=Vz0N8w@mail.gmail.com>
Message-ID: <CAK8P3a0Gz3h4SDbgyx-73ER2Q2yPqn5vOxDErGtQ64Q=Vz0N8w@mail.gmail.com>
Subject: Re: [ANNOUNCE] "Fast Kernel Headers" Tree -v2
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
X-Provags-ID: V03:K1:XEyYrNouFbGtdZcyX5bTItpNiysX3vd0XPhm5cJ2fH+0Bcbh+4q
 QGH6m1rJWxWXzShTnPjcvSoxotvCR7q6ICalfhS5DGuz2ug8O+kzxMedm80u0+eV/xdMk+u
 ythDZvY3sBmO1RJnYSmmkGc6rPhN5pGsK49Jwecr9FFZbLrLR6/WdxeQf0RDrZsyZzYcj57
 qEWnRWPpfG1+C2iuZodxg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ybuLZ69Oivw=:cxMvUOqutL4pYh8cMjK2dI
 rftH9E46+Ov984Hlv+ZWMRU7xRS844VSVMa7L4298M7yBOeieoXvQSYvA2NWBXgZ2zH5ZvP70
 eqpXqlx6+6U36JsOgz54m4U+Gp6fehVzHiNbVaUMt3ssGIrdF3Dl/er7qButVtHrOgKxOSaAP
 t7XFgioWU7lE/kBf9m7xlpB4kqMaVX+QnmF1PxweKd8lYSQlVtlWWbEDbvLGwmQ6vgQYHzkbe
 tkECpwy0lV8bJrDXBHgEhxm3xpLyEVMp89tKanFIUvmY+wLPyB1y9A8hz0drRVlN94QIvP+NX
 1VFBNcZMpwh+4dhqCj45WKrYWe7EB7aPUmqg8JOvB4+RomP7eslHLI/7GN5Uj4U+MGxEq+I5p
 9SNvQZBS+JX03WB9uc4BZR1RbqosNwWcS5IX7Eii/f2ol5rNanGPDNvzqNZUXfyS4RbJVhst0
 RLKqBw3NoGDQtoJzl/88+yu7PoTqZ2+19yQZ/ky0d2QM5k5amwmMiWJZabQy1K3es9y6vYBgQ
 HxS+hiJquCGYYynJFcjUbd6MAuewXar9dZ+w/52jIHkFVBZUc62xWeIEKZn6xiSWAl2pVKMsS
 deTxnW+MfLCPtNAM/XiFKIx301uFFVdLHON5Q11Rrv37x2+BXKXrwLTlaoGe42r8i+PeYVVYZ
 Qrxke8eMZ3cBWc5c/P6M0xQqgQ+5ljRzmAQQ9PHolnU9vKfzEfk3/GaRv+R+b2axxfKORnInD
 y8PcetmCgm8fgDAgngWhGSDeZQYY4IHFqk5r+DX58Sjj0v4uesAHOmfvKGe/V4a8/+JaP9pmg
 CAgiGIyCqU0QuZdE+ktWrpMBTlBtefvurYytYyCO5QKco9ITaA=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

.hOn Thu, Jan 13, 2022 at 9:57 AM Ingo Molnar <mingo@kernel.org> wrote:
> * Arnd Bergmann <arnd@arndb.de> wrote:
> > On Sat, Jan 8, 2022 at 5:26 PM Ingo Molnar <mingo@kernel.org> wrote:
> > well, some things I would have done differently but I'm not complaining
> > as you did the work, and some things seem unnecessary but might not be.
> >
> > I've started building randconfig kernels for arm64 and x86, and fixing
> > up things that come up,
> > a few things I have noticed out so far:
> >
> > * 2e98ec93d465 ("headers/prep: Rename constants: SOCK_DESTROY =>
> > SOCK_DIAG_SOCK_DESTROY")
> >
> >   This one looks wrong, as you are changing a uapi header, possibly
> >   breaking applications at compile time. I think the other one should be
> >   renamed instead.
>
> This is hard: SOCK_DESTROY is one of the main constants for sockets, is
> well named, fits into an existing in-kernel nomenclature and both me and
> networking folks would hate to rename it ...
>
> So I'd keep this one and wait for any reported breakage. I don't think we
> *guarantee* the specific naming of symbols - we guarantee an ABI, and make
> a best-effort for the rest. The constant is netdiag specific and doesn't
> seem to be included by any major user-space header in /usr/include.

Ok.

https://codesearch.debian.net/search?q=%5CWSOCK_DESTROY%5CW&literal=0
finds only iproute2 and strace referencing this name, and they both provide
their own definitions, but it would be good to split out the rename from the
series and discuss it separate with the relevant maintainers.

> > * 04293522a8cb ("headers/deps: ipc/shm: Move the 'struct shmid_ds'
> > definition to ipc/shm.c")
> >   and related patches
> >
> >   Similarly, the IPC structures are uapi headers that I would not
> > change here for the same reasons.
> >   Even if nothing uses those any more with modern libc
> > implementations, the structures belong into
> >   uapi, unless we can prove that the old-style sysvipc interface is
> > completely unused and we
> >   remove the implementation from the kernel as well (I don't think we
> > want that, but I have not
> >   looked in depth at when it was last used by a libc)
>
> Ok, we can certainly undo this one - but how does it work in practice, as
> the structure is already defined by libc:
>
> /usr/include/x86_64-linux-gnu/bits/types/struct_shmid_ds.h:struct shmid_ds
>
> /* Data structure describing a shared memory segment.  */
> struct shmid_ds
>   {
>     struct ipc_perm shm_perm;           /* operation permission struct */
>     size_t shm_segsz;                   /* size of segment in bytes */
> #if __TIMESIZE == 32
>     __time_t shm_atime;                 /* time of last shmat() */
>     unsigned long int __shm_atime_high;
>     __time_t shm_dtime;                 /* time of last shmdt() */
>     unsigned long int __shm_dtime_high;
>     __time_t shm_ctime;                 /* time of last change by shmctl() */
>     unsigned long int __shm_ctime_high;
> #else
>     __time_t shm_atime;                 /* time of last shmat() */
>     __time_t shm_dtime;                 /* time of last shmdt() */
>     __time_t shm_ctime;                 /* time of last change by shmctl() */
> #endif
>     __pid_t shm_cpid;                   /* pid of creator */
>     __pid_t shm_lpid;                   /* pid of last shmop */
>     shmatt_t shm_nattch;                /* number of current attaches */
>     __syscall_ulong_t __glibc_reserved5;
>     __syscall_ulong_t __glibc_reserved6;
>   };
>
>
> Wouldn't this definition conflict with any header use of linux/shm.h?

This is the glibc version of the modern structure that corresponds to
the kernel's shmid64_ds. Any user of the old interface would necessarily
be something other than glibc, and presumably something that works
with the syscall interface directly. The main examples I can think of would
be stuff like strace, qemu-user, or gdb for the purpose of interpreting
another tasks syscalls. There is a good chance that any such tool
already has its own definition, but I have not done specific research here.

Another possibility would be any runtime environment (non-glibc C or
some other language) that wraps the syscall interface to applications.
Again, these /should/ not use the old sysvipc stuff, but that doesn't
mean that they don't just blindly wrap every single interface provided
by the kernel.

I checked the uclibc-ng and found that it moved over from the legacy
interface to the modern interface in 2005, but it has always had its
own definition of the structures since ipc support was added in 2000.

> > * changing any include/uapi headers to use "#include <uapi/linux/*.h>"
> > is broken because
> >   that makes the headers unusable from userspace, including any of
> > tools/*/. I think we
> >   can work around this in the headers_install.sh postprocessing step
> > though, where we already
> >   do unifdef etc.
>
> Yeah, so the problem here is on the kernel side, the following innocent
> looking include in a UAPI header:
>
>    #include <linux/foo.h>
>
> Will turn into a very large header - and unintentionally so - if there
> happens to be an include/foo.h header.
>
> I.e. normally there's only the UAPI header, which is then included, but in
> some significant cases that's not so.
>
> IMO it seems so much cleaner to express the intent to only include the UAPI
> header - so solving this at header-install time would be preferable.

Right, let's do that then. Not sure when I'll get around to this, but
it shouldn't
be hard to do, so feel free to do this first if you come across it again.
For the moment, I have my local workaround, but I agree that the
postprocessing would be better to do in your tree.

> > * For all the header additions to .c files, I assume you are using a set
> > of script, so these could
> >   probably be changed without much trouble. I would suggest applying
> > them in sequence so
> >    the headers remain sorted alphabetically in the end. It would
> > probably make sense to
> >    squash those all together to avoid patching certain files many
> > times over, for the sake
> >    of keeping a slightly saner git history.
>
> Are you suggesting to change the current reverse-alphabetical order of
> headers:
>
> --- a/drivers/auxdisplay/ht16k33.c
> +++ b/drivers/auxdisplay/ht16k33.c
> @@ -8,6 +8,15 @@
>   * Copyright (C) 2021 Glider bv
>   */
>
> +#include <linux/workqueue_api.h>
> +#include <linux/wait_api.h>
> +#include <linux/sched.h>
> +#include <linux/pgtable_api.h>
> +#include <linux/of_api.h>
> +#include <linux/mm_api.h>
> +#include <linux/jiffies.h>
> +#include <linux/gfp_api.h>
> +#include <linux/device_api_lock.h>
>
> ... to alphabetical?
>
> Can certainly do that - but this will flip around the commit order: it's
> much easier to add at the head of the include files section.

Yes, I think doing the alphabetical sorting is better, as that seems to be
the most common version. In my earlier approach I came up with a
pseudo-alphabetical sorting that would add the new #include statements
before the first existing #include that comes later in the alphabet. This
is slightly more fragile than just adding to the front (especially
when #include statements are inside of an #ifdef), but it's closer to
what a lot of maintainers prefer.

> > * I think it would be good to keep the include/linux/syscalls_api.h declarations
> >    in the same header as the SYSCALL_DEFINE*() macros, to ensure that the
> >    prototypes remain synchronized. Splitting them out will likely also
> > cause sparse
> >    warnings for missing prototypes (or maybe it should but doesn't at
> > the moment).
>
> Yeah, I suppose we could undo the split:
>
>   # -fast-headers-v2:
>
>                                                                _______________________
>                                                               | stripped lines of code
>                                                               |              _____________________________
>                                                               |             | headers included recursively
>                                                               |             |                _______________________________
>                                                               |             |               | usage in a distro kernel build
>  ____________                                                 |             |               |         _________________________________________
> | header name                                                 |             |               |        | million lines of comment-stripped C code
> |                                                             |             |               |        |
>   #include <linux/syscalls_types.h>                           | LOC:  2,397 | headers:  128 |    353 | MLOC:    0.8 |
>   #include <linux/syscalls_api.h>                             | LOC: 12,842 | headers:  361 |    167 | MLOC:    2.1 |
>
> The full header used to be a lot bigger:
>
>   # v5.16-rc8
>
>   #include <linux/syscalls.h>                                 | LOC: 40,217 | headers:  604 |    321 | MLOC:   12.9 | ###

I would actually hope to need almost no indirect includes for
linux/syscall_api.h,
aside from linux/types.h for a couple of typedefs and linux/linkage.h
for asmlinkage.
Most of the remaining #includes appear to be there only for structure
definitions
that can be converted into additional forward declarations.

> > * arm64 needs  a couple of minor fixups, see
> > https://pastebin.com/eSKhz4CL for what
> >   I have so far, feel free to integrate any things that directly make sense.
>
> Thanks! Mind sending the dependency removals in a series, so I can keep
> attribution?

Ok, I'll have a look at rebasing and will split it up further. I have
a couple more
fixes now, so I can build all randconfig kernels without warnings on arm64 and
x86_64 now.

> These bits are usually in separate commits, unless they fix
> some bug in an existing commit:
>
>  arch/arm64/include/asm/mmu.h                     |    1 -
>  arch/arm64/include/asm/pgtable-hwdef.h           |    1 -
>  arch/arm64/include/asm/pgtable-prot.h            |    1 -
>
> This bit looks suboptimal - but as you mentioned it fixes tooling build
> errors:
>
> --- a/include/uapi/linux/netdevice.h
> +++ b/include/uapi/linux/netdevice.h
> @@ -26,11 +26,17 @@
>  #ifndef _UAPI_LINUX_NETDEVICE_H
>  #define _UAPI_LINUX_NETDEVICE_H
>
> +#ifdef __KERNEL__
>  #include <uapi/linux/if.h>
>  #include <uapi/linux/if_ether.h>
>  #include <uapi/linux/if_packet.h>
>  #include <uapi/linux/if_link.h>
> -
> +#else
> +#include <linux/if.h>
> +#include <linux/if_ether.h>
> +#include <linux/if_packet.h>
> +#include <linux/if_link.h>
> +#endif

Right, this was not meant to be added to your series, it was just the
quickest way
to get randconfig kernels to build when they enable tools/*/

> This KASAN bit:
>
> --- a/include/linux/mm_api_kasan.h
> +++ b/include/linux/mm_api_kasan.h
> @@ -18,7 +18,7 @@ static inline u8 page_kasan_tag(const struct page *page)
>  {
>         u8 tag = 0xff;
>
> -       if (kasan_enabled()) {
> +       if (IS_ENABLED(CONFIG_KASAN)) {
>                 tag = (page->flags >> KASAN_TAG_PGSHIFT) & KASAN_TAG_MASK;
>                 tag ^= 0xff;
>         }
>
> Is this a fix for some build failure? Upstream it's using kasan_enabled():

Yes, I got a circular include chain between mm_api_kasan.h, mm_types.h
and linux/kasan.h in certain configurations. I'm guessing this happens
specifically
for kasan-enabled kernels, but it could be others as well. The problem here
is that include/linux/mm_api_kasan.h needs the 'struct page' definition.

        Arnd
