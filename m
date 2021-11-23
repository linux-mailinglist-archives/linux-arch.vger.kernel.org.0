Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5149445A525
	for <lists+linux-arch@lfdr.de>; Tue, 23 Nov 2021 15:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbhKWOWI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Nov 2021 09:22:08 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:48879 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhKWOWG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Nov 2021 09:22:06 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M2wCi-1mmDme1RqG-003NAJ; Tue, 23 Nov 2021 15:18:56 +0100
Received: by mail-wm1-f41.google.com with SMTP id i12so18887463wmq.4;
        Tue, 23 Nov 2021 06:18:56 -0800 (PST)
X-Gm-Message-State: AOAM533DbjJmQm6ZctWC9Z6vivsKKJQSC1ixiSVsOZnqMFzcTFxkxc9J
        JHHJ/EEQ4wR46bz4vsB8Yq2xf8NtnO5VqTTg06Q=
X-Google-Smtp-Source: ABdhPJy/iu+HUeUW5MAS4aoS4UPs9O0+2rPHcGIO3sxNnrXnPW2hntwc4AmghGSopXx9bjgxeEGyK0ovTBLVT2Rzyac=
X-Received: by 2002:a1c:770e:: with SMTP id t14mr3353750wmi.173.1637677135896;
 Tue, 23 Nov 2021 06:18:55 -0800 (PST)
MIME-Version: 1.0
References: <YZvIlz7J6vOEY+Xu@yuki> <CAK8P3a0x5Bw7=0ng-s+KsUywqJYa0tk9cSWmZhx+cZRBOR87ZA@mail.gmail.com>
 <YZyw56flmdQnBIuh@yuki>
In-Reply-To: <YZyw56flmdQnBIuh@yuki>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 23 Nov 2021 15:18:39 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2RU8XJp_hS0JkO9mPJctAHHKBobV97gced6pMXcwzWow@mail.gmail.com>
Message-ID: <CAK8P3a2RU8XJp_hS0JkO9mPJctAHHKBobV97gced6pMXcwzWow@mail.gmail.com>
Subject: Re: [PATCH] uapi: Make __{u,s}64 match {u,}int64_t in userspace
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>,
        GNU C Library <libc-alpha@sourceware.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:bW/f+VphpYkHIEZZBN8KslsMylIIeO6hr9nhozV0Rpy1x/6iRJ/
 D5V2hQDN5Iw4Qx5QaI8XAYNRGbOKDpmz4c7XoGqT962Ml9pgIjsqy4KR1/34Qy0Z9KGsSy0
 Kfh97NTo/tptA2fCxjHK/ipOBEIuYXQaY9bBfIWOHpB44OJOwMopw8bbUeDUVXQj+1+AGIv
 b4tuX9DdRXcE+FjxYvsBw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:b1UT8YbWGQo=:zuceAjNY5IVb8nU1C/i4Db
 /kAN4NcdmfV9Tdj5fcnhuwJp5+csQM4jFibACODlF7MHkKptbWPa0o7VkrkHl2Id0IhocCURT
 sEr1tBNvJlVzMoj8kcZCyTfzQXYmag535wcln5X0eNC66qcOh3oFWonpNsp873P6nFXKgtMPP
 n178UljVLBdSbcUKlfJ6YULIvv5wkqQaH9iVu7Pp1ekyNytARJvt0tMOx/hZvGlvIlWkiC1l0
 LOE4QefVE+CDzmGiXfDk6mXeDPruL0En4EkS3tjqBIo0X8b1GuC6JBjF9qJtvOXHEn9lFMQH3
 dEGWRQVkJyHMWLjj5+nQdTrN5pen+Hxf7Tg2ZlOqx9H7j7iIj1b39y8DZ8rv2upryR0rX8fPH
 +bkVe6R8NqnwjQw//DDAZmYHr7voPAY0F06tKhxIcZFwAXOnLWlkYK5di/3gBrsalkcDcJGb7
 fqWIqIyovq/+qBm5Yoge6SAFkNcim2E6eC4QmlM7JGENctpeqOjopK1oSL1ozs/pV/2UYhnD+
 xpWAx27d9ri/NQrzJcMZfncbKYdt8lgAE4ik0pkZlH38CxIACjefea4I4AfsmrrQ6omeu8c7v
 07d+qthZDKs4+Qh1MdobtSqCPNZ6J61sAACKBcs6pktbha4XXFaLbN/H1EycuA2Ow076Xg90h
 kOuDgFCgXI9Wp+9CMSXGBM+ijvvGhcHQ1pJKAD/CrqrIGdLrumyxdK1jGYIHE1PXIVWCDIv7e
 x7How1t8ioRzMsIGwxtb22l+A6Dw+a5sQ18hsD0FyZXoewYWTy7N7MdAc84Aa6xiOP9Nyl6/E
 kmVUxvOniABpqgcw6j5tT8YdzTXDzushHbWCCJ6A2cElaHZRZs=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 23, 2021 at 10:14 AM Cyril Hrubis <chrubis@suse.cz> wrote:
> > I don't think this is correct on all 64-bit architectures, as far as I
> > remember the
> > definition can use either 'long' or 'long long' depending on the user space
> > toolchain.
>
> As far as I can tell the userspace bits/types.h does exactly the same
> check in order to define uint64_t and int64_t, i.e.:
>
> #if __WORDSIZE == 64
> typedef signed long int __int64_t;
> typedef unsigned long int __uint64_t;
> #else
> __extension__ typedef signed long long int __int64_t;
> __extension__ typedef unsigned long long int __uint64_t;
> #endif
>
> The macro __WORDSIZE is defined per architecture, and it looks like the
> defintions in glibc sources in bits/wordsize.h match the uapi
> asm/bitsperlong.h. But I may have missed something, the code in glibc is
> not exactly easy to read.

It's possible that the only difference between the two files was the
'__u32'/'__s32' definition, which could be either 'int' or 'long'. We used
to try matching the user space types for these, but not use 'int'
everywhere in the kernel.

> > Out of the ten supported 64-bit architectures, there are four that already
> > use asm-generic/int-l64.h conditionally, and six that don't, and I
> > think at least
> > some of those are intentional.
> >
> > I think it would be safer to do this one architecture at a time to make
> > sure this doesn't regress on those that require the int-ll64.h version.
>
> I'm still trying to understand what exactly can go wrong here. As long
> as __BITS_PER_LONG is correctly defined the __u64 and __s64 will be
> correctly sized as well. The only visible change is that one 'long' is
> dropped from the type when it's not needed.

Correct, I'm not worried about getting incorrectly-sized types here,
but using the wrong type can cause compile-time warnings when
they are mismatched against format strings or assigning pointers
to the wrong types. With the kernel types, one would always use
%d for __u32 and %lld for __u64, while with the user space types,
one has to resort to using macros.

       Arnd
