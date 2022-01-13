Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8231648D481
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jan 2022 10:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbiAMI6O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jan 2022 03:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbiAMI5e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Jan 2022 03:57:34 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1B1C0611FF;
        Thu, 13 Jan 2022 00:57:11 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id m4so20359717edb.10;
        Thu, 13 Jan 2022 00:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C9pTSew8IvqTOHh5d+VI9Kbh5oAaqV9jV+b1RhfYG/A=;
        b=cf7UUKkXIHJAeHcBfjVDg0wmg5YMnquQU1q7exQ8o0nbyzxtwR08La/4GH8MmkeOZA
         Dgp+ZptQ5pSDBa5zQKHQ4KtFXDIyw3qio4eYZ3J88rSAciT/JlkmIfM7AdWsJ7vgWPjD
         LBwvxQoAoy5yOjslkKMjWiNg/tgpg3A9MI1mlAsMFPz5pQnrpjo3JoEC9BJv5L+pBMll
         /NRIaf+hInn8ZAnmn90/xEXRaEkocUw0ECkMbqdtJ6hVFeH+dPpghd8h5IJDbG1LIuas
         GPr/Yy4cEYK8msTQxW7Kc7xT4DrI6vmT4sbJfaarIHBoilIZ19+1SyT4ShOWM8K9asqx
         iY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=C9pTSew8IvqTOHh5d+VI9Kbh5oAaqV9jV+b1RhfYG/A=;
        b=XqVzOKCk2M1JiBeozBLyijP0L+6QofdXLMbetKt7gkJXIQ8z69BiWSaL8vW9RPW0cw
         SsbTbUbj4FiPmjhboFVZZ9pQMIyTkfXioCPIJTDgyx21/2YoSZ86LipVoa8pHi1WuQiZ
         kM13bned1+YvQYPmfJqTJ7h1RTHN6InlcFObJ8wgomOJPtZ5dO64ZD+F5fWtr8xnHs6G
         fbmEkckAxB7J0bCUcc8w/IW9v7wYjZXRX1gsCvHh04Wd0KlfM8S0NohiteoLk8VNfmIF
         Ne4vDKB245pO6ZKc8/l1rN4H8bYyxF9lUZfAKQ392gOFkRSuQ9p4BNNhzzss5KCSqsPZ
         BsMQ==
X-Gm-Message-State: AOAM53146eiMiapsVhEpxJceQ7hH1mcVO2VlR6KHNVT2qNVluiM60Q63
        fI1UjcTu39Y6B35Ec4Jks/jXjVt6bAw=
X-Google-Smtp-Source: ABdhPJxhzkIGZghbcoKFqEK6eMFLnNZmt3YymMUv1xq6yuUOXWszbChBHB4wW7k/lUsHDiE+lgIfRw==
X-Received: by 2002:a05:6402:4406:: with SMTP id y6mr3227210eda.374.1642064230155;
        Thu, 13 Jan 2022 00:57:10 -0800 (PST)
Received: from gmail.com (563BAB82.dsl.pool.telekom.hu. [86.59.171.130])
        by smtp.gmail.com with ESMTPSA id f18sm886823edf.95.2022.01.13.00.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 00:57:09 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 13 Jan 2022 09:57:05 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
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
Subject: Re: [ANNOUNCE] "Fast Kernel Headers" Tree -v2
Message-ID: <Yd/pYSKZKDgPieVR@gmail.com>
References: <Ydm7ReZWQPrbIugn@gmail.com>
 <CAK8P3a1emGYHPcjTfLqd-yyU8_9w88=2g_B_vfhbKeDtDHMM-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1emGYHPcjTfLqd-yyU8_9w88=2g_B_vfhbKeDtDHMM-w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Arnd Bergmann <arnd@arndb.de> wrote:

> On Sat, Jan 8, 2022 at 5:26 PM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > I'm pleased to announce -v2 of the "Fast Kernel Headers" tree, which is a
> > comprehensive rework of the Linux kernel's header hierarchy & header
> > dependencies, with the dual goals of:
> >
> >  - speeding up the kernel build (both absolute and incremental build times)
> >
> >  - decoupling subsystem type & API definitions from each other
> >
> > The fast-headers tree consists of over 25 sub-trees internally, spanning
> > over 2,300 commits, which can be found at:
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
> >
> >    # HEAD: 391ce485ced0 headers/deps: Introduce the CONFIG_FAST_HEADERS=y config option
> 
> I've started reading through it at last. I can't say that I'm reviewing 
> every patch, [...]

Yeah, not expected at all with 2,300+ commits - but even cursory review or 
review of specific areas is appreciated.

> but at least (almost all) the things I've looked at so far all seem 
> really nice to me, mostly this is the same that I was planning to do as 

Thanks!

> well, some things I would have done differently but I'm not complaining 
> as you did the work, and some things seem unnecessary but might not be.
> 
> I've started building randconfig kernels for arm64 and x86, and fixing
> up things that come up,
> a few things I have noticed out so far:
> 
> * 2e98ec93d465 ("headers/prep: Rename constants: SOCK_DESTROY =>
> SOCK_DIAG_SOCK_DESTROY")
> 
>   This one looks wrong, as you are changing a uapi header, possibly 
>   breaking applications at compile time. I think the other one should be 
>   renamed instead.

This is hard: SOCK_DESTROY is one of the main constants for sockets, is 
well named, fits into an existing in-kernel nomenclature and both me and 
networking folks would hate to rename it ...

So I'd keep this one and wait for any reported breakage. I don't think we 
*guarantee* the specific naming of symbols - we guarantee an ABI, and make 
a best-effort for the rest. The constant is netdiag specific and doesn't 
seem to be included by any major user-space header in /usr/include.

> * 04293522a8cb ("headers/deps: ipc/shm: Move the 'struct shmid_ds'
> definition to ipc/shm.c")
>   and related patches
> 
>   Similarly, the IPC structures are uapi headers that I would not
> change here for the same reasons.
>   Even if nothing uses those any more with modern libc
> implementations, the structures belong into
>   uapi, unless we can prove that the old-style sysvipc interface is
> completely unused and we
>   remove the implementation from the kernel as well (I don't think we
> want that, but I have not
>   looked in depth at when it was last used by a libc)

Ok, we can certainly undo this one - but how does it work in practice, as 
the structure is already defined by libc:

/usr/include/x86_64-linux-gnu/bits/types/struct_shmid_ds.h:struct shmid_ds

/* Data structure describing a shared memory segment.  */
struct shmid_ds
  {
    struct ipc_perm shm_perm;           /* operation permission struct */
    size_t shm_segsz;                   /* size of segment in bytes */
#if __TIMESIZE == 32
    __time_t shm_atime;                 /* time of last shmat() */
    unsigned long int __shm_atime_high;
    __time_t shm_dtime;                 /* time of last shmdt() */
    unsigned long int __shm_dtime_high;
    __time_t shm_ctime;                 /* time of last change by shmctl() */
    unsigned long int __shm_ctime_high;
#else
    __time_t shm_atime;                 /* time of last shmat() */
    __time_t shm_dtime;                 /* time of last shmdt() */
    __time_t shm_ctime;                 /* time of last change by shmctl() */
#endif
    __pid_t shm_cpid;                   /* pid of creator */
    __pid_t shm_lpid;                   /* pid of last shmop */
    shmatt_t shm_nattch;                /* number of current attaches */
    __syscall_ulong_t __glibc_reserved5;
    __syscall_ulong_t __glibc_reserved6;
  };


Wouldn't this definition conflict with any header use of linux/shm.h?

> * changing any include/uapi headers to use "#include <uapi/linux/*.h>"
> is broken because
>   that makes the headers unusable from userspace, including any of
> tools/*/. I think we
>   can work around this in the headers_install.sh postprocessing step
> though, where we already
>   do unifdef etc.

Yeah, so the problem here is on the kernel side, the following innocent 
looking include in a UAPI header:

   #include <linux/foo.h>

Will turn into a very large header - and unintentionally so - if there 
happens to be an include/foo.h header.

I.e. normally there's only the UAPI header, which is then included, but in 
some significant cases that's not so.

IMO it seems so much cleaner to express the intent to only include the UAPI 
header - so solving this at header-install time would be preferable.

> * For all the header additions to .c files, I assume you are using a set 
> of script, so these could
>   probably be changed without much trouble. I would suggest applying
> them in sequence so
>    the headers remain sorted alphabetically in the end. It would
> probably make sense to
>    squash those all together to avoid patching certain files many
> times over, for the sake
>    of keeping a slightly saner git history.

Are you suggesting to change the current reverse-alphabetical order of 
headers:

--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -8,6 +8,15 @@
  * Copyright (C) 2021 Glider bv
  */
 
+#include <linux/workqueue_api.h>
+#include <linux/wait_api.h>
+#include <linux/sched.h>
+#include <linux/pgtable_api.h>
+#include <linux/of_api.h>
+#include <linux/mm_api.h>
+#include <linux/jiffies.h>
+#include <linux/gfp_api.h>
+#include <linux/device_api_lock.h>

... to alphabetical?

Can certainly do that - but this will flip around the commit order: it's 
much easier to add at the head of the include files section.

> * The per-task stuff sounded a bit scary from your descriptions but
> looking at the actual
>    implementation I now get it, this looks like a really nice way of doing it.

Thank you!

> * I think it would be good to keep the include/linux/syscalls_api.h declarations
>    in the same header as the SYSCALL_DEFINE*() macros, to ensure that the
>    prototypes remain synchronized. Splitting them out will likely also
> cause sparse
>    warnings for missing prototypes (or maybe it should but doesn't at
> the moment).

Yeah, I suppose we could undo the split:

  # -fast-headers-v2:

                                                               _______________________
                                                              | stripped lines of code
                                                              |              _____________________________
                                                              |             | headers included recursively
                                                              |             |                _______________________________
                                                              |             |               | usage in a distro kernel build
 ____________                                                 |             |               |         _________________________________________
| header name                                                 |             |               |        | million lines of comment-stripped C code
|                                                             |             |               |        |
  #include <linux/syscalls_types.h>                           | LOC:  2,397 | headers:  128 |    353 | MLOC:    0.8 | 
  #include <linux/syscalls_api.h>                             | LOC: 12,842 | headers:  361 |    167 | MLOC:    2.1 | 

The full header used to be a lot bigger:

  # v5.16-rc8

  #include <linux/syscalls.h>                                 | LOC: 40,217 | headers:  604 |    321 | MLOC:   12.9 | ###


> * include/linux/time64_types.h is not a good name, as these are now
> the default types
>    after we removed the time32 versions. I'd either rename it to
> linux/time_types.h
>    or split it up between linux/types.h and linux/ktime_types.h

I was doing this in the context of v5.16.

> * arm64 needs  a couple of minor fixups, see
> https://pastebin.com/eSKhz4CL for what
>   I have so far, feel free to integrate any things that directly make sense.

Thanks! Mind sending the dependency removals in a series, so I can keep 
attribution? These bits are usually in separate commits, unless they fix 
some bug in an existing commit:

 arch/arm64/include/asm/mmu.h                     |    1 -
 arch/arm64/include/asm/pgtable-hwdef.h           |    1 -
 arch/arm64/include/asm/pgtable-prot.h            |    1 -

This bit looks suboptimal - but as you mentioned it fixes tooling build 
errors:

--- a/include/uapi/linux/netdevice.h
+++ b/include/uapi/linux/netdevice.h
@@ -26,11 +26,17 @@
 #ifndef _UAPI_LINUX_NETDEVICE_H
 #define _UAPI_LINUX_NETDEVICE_H
 
+#ifdef __KERNEL__
 #include <uapi/linux/if.h>
 #include <uapi/linux/if_ether.h>
 #include <uapi/linux/if_packet.h>
 #include <uapi/linux/if_link.h>
-
+#else
+#include <linux/if.h>
+#include <linux/if_ether.h>
+#include <linux/if_packet.h>
+#include <linux/if_link.h>
+#endif

I'll apply & backmerge the per_task() fixlets for the bugs you found:

-       per_task(&init_task, kcsan_ctx).scoped_addresses.next = LIST_POISON1;
+       per_task(&init_task, kcsan_ctx).scoped_accesses.next = LIST_POISON1;

-       return ptr == &current->flags;
+       return ptr == &task_flags(current);

This KASAN bit:

--- a/include/linux/mm_api_kasan.h
+++ b/include/linux/mm_api_kasan.h
@@ -18,7 +18,7 @@ static inline u8 page_kasan_tag(const struct page *page)
 {
        u8 tag = 0xff;
 
-       if (kasan_enabled()) {
+       if (IS_ENABLED(CONFIG_KASAN)) {
                tag = (page->flags >> KASAN_TAG_PGSHIFT) & KASAN_TAG_MASK;
                tag ^= 0xff;
        }

Is this a fix for some build failure? Upstream it's using kasan_enabled():

static inline u8 page_kasan_tag(const struct page *page)
{
        u8 tag = 0xff;

        if (kasan_enabled()) {
                tag = (page->flags >> KASAN_TAG_PGSHIFT) & KASAN_TAG_MASK;
                tag ^= 0xff;
        }

        return tag;
}

	Ingo
