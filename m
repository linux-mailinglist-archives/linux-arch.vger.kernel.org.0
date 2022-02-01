Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9F54A5577
	for <lists+linux-arch@lfdr.de>; Tue,  1 Feb 2022 04:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbiBADHQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jan 2022 22:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbiBADHQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jan 2022 22:07:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED23C061714;
        Mon, 31 Jan 2022 19:07:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24D20B82C45;
        Tue,  1 Feb 2022 03:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBFDC340E8;
        Tue,  1 Feb 2022 03:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643684832;
        bh=RWGziZvAcSIC9lUYmms3EZhw2d4HrnjQmDEh+l0erd0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nRKJAEGl2qxCqQhvDxA4ZerW+APO5/FLlhafvP9scG8v2Y5CkLbLJBqcSsExHqVrB
         OX3evy0z35wsv6qKv8mZoLVMa9qhZ1JkGvn3/V5K+Ya8eJn5j5/QKrGZBzURxRUn2Q
         YrwUm3dBk4pdrkxsVuT2Zw0kpPdbNeI3lRto/qWn/AwYDThqnNgPdgQO6+xgbPlVK8
         J2wExTTQsRWHgs9YwMash9dOsKTFXvNWShyPq2ydx536GMBm456Ot1Yqeod+Qn7cgU
         rA83rDdC4gyCEOxoxw81Zd0o6CbjHFppo0ZVE6yH7x2guN6pA/Sn5hTf9qKA32tLYG
         QHimT44JTmTSg==
Received: by mail-vs1-f50.google.com with SMTP id f6so14433718vsa.5;
        Mon, 31 Jan 2022 19:07:12 -0800 (PST)
X-Gm-Message-State: AOAM532gwB1Jql5Z5nUXVSwaGfyJiykepuRxBOwu++rwnYXsNEfDQrgF
        SoPpGuN/FU5mRoN3d1pb+W6q4O809HQunrnMr0o=
X-Google-Smtp-Source: ABdhPJzr8oODyGThDZRWf00Gu124HUnNsdtS2vrpuLxr9Y8ThaVajON5m3RaTZJVL7lWmE7wHYjPKw8pKHhLgKGL2D4=
X-Received: by 2002:a67:e947:: with SMTP id p7mr9249674vso.59.1643684831581;
 Mon, 31 Jan 2022 19:07:11 -0800 (PST)
MIME-Version: 1.0
References: <20220131064933.3780271-1-hch@lst.de> <20220131064933.3780271-5-hch@lst.de>
 <CAJF2gTRj3DN4YJCM2VXqpyJNY7G-PCG4APcLkMk0CKzg-+SsdA@mail.gmail.com>
In-Reply-To: <CAJF2gTRj3DN4YJCM2VXqpyJNY7G-PCG4APcLkMk0CKzg-+SsdA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 1 Feb 2022 11:07:00 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSvV5PKVkyHZ1jixQYAPDZHwwfG+2=PH_VAQD6Y0XdQVg@mail.gmail.com>
Message-ID: <CAJF2gTSvV5PKVkyHZ1jixQYAPDZHwwfG+2=PH_VAQD6Y0XdQVg@mail.gmail.com>
Subject: Re: [PATCH 4/5] uapi: always define F_GETLK64/F_SETLK64/F_SETLKW64 in fcntl.h
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 1, 2022 at 11:02 AM Guo Ren <guoren@kernel.org> wrote:
>
> On Mon, Jan 31, 2022 at 2:49 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > The F_GETLK64/F_SETLK64/F_SETLKW64 fcntl opcodes are only implemented
> > for the 32-bit syscall APIs, but are also needed for compat handling
> > on 64-bit kernels.
> >
> > Consolidate them in unistd.h instead of definining the internal compat
> > definitions in compat.h, which is rather errror prone (e.g. parisc
> > gets the values wrong currently).
> >
> > Note that before this change they were never visible to userspace due
> > to the fact that CONFIG_64BIT is only set for kernel builds.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  arch/arm64/include/asm/compat.h        | 4 ----
> >  arch/mips/include/asm/compat.h         | 4 ----
> >  arch/mips/include/uapi/asm/fcntl.h     | 4 ++--
> >  arch/powerpc/include/asm/compat.h      | 4 ----
> >  arch/s390/include/asm/compat.h         | 4 ----
> >  arch/sparc/include/asm/compat.h        | 4 ----
> >  arch/x86/include/asm/compat.h          | 4 ----
> >  include/uapi/asm-generic/fcntl.h       | 4 ++--
> >  tools/include/uapi/asm-generic/fcntl.h | 2 --
> >  9 files changed, 4 insertions(+), 30 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
> > index eaa6ca062d89b..2763287654081 100644
> > --- a/arch/arm64/include/asm/compat.h
> > +++ b/arch/arm64/include/asm/compat.h
> > @@ -73,10 +73,6 @@ struct compat_flock {
> >         compat_pid_t    l_pid;
> >  };
> >
> > -#define F_GETLK64      12      /*  using 'struct flock64' */
> > -#define F_SETLK64      13
> > -#define F_SETLKW64     14
> > -
> >  struct compat_flock64 {
> >         short           l_type;
> >         short           l_whence;
> > diff --git a/arch/mips/include/asm/compat.h b/arch/mips/include/asm/compat.h
> > index bbb3bc5a42fd8..6a350c1f70d7e 100644
> > --- a/arch/mips/include/asm/compat.h
> > +++ b/arch/mips/include/asm/compat.h
> > @@ -65,10 +65,6 @@ struct compat_flock {
> >         s32             pad[4];
> >  };
> >
> > -#define F_GETLK64      33
> > -#define F_SETLK64      34
> > -#define F_SETLKW64     35
> Oops we can't remove above, right?
No problem, I missing, it's okay.

All come from arch/mips/include/uapi/asm/fcntl.h

>
> > -
> >  struct compat_flock64 {
> >         short           l_type;
> >         short           l_whence;
> > diff --git a/arch/mips/include/uapi/asm/fcntl.h b/arch/mips/include/uapi/asm/fcntl.h
> > index 9e44ac810db94..0369a38e3d4f2 100644
> > --- a/arch/mips/include/uapi/asm/fcntl.h
> > +++ b/arch/mips/include/uapi/asm/fcntl.h
> > @@ -44,11 +44,11 @@
> >  #define F_SETOWN       24      /*  for sockets. */
> >  #define F_GETOWN       23      /*  for sockets. */
> >
> > -#ifndef __mips64
> > +#if __BITS_PER_LONG == 32 || defined(__KERNEL__)
> >  #define F_GETLK64      33      /*  using 'struct flock64' */
> >  #define F_SETLK64      34
> >  #define F_SETLKW64     35
> > -#endif
> > +#endif /* __BITS_PER_LONG == 32 || defined(__KERNEL__) */
> >
> >  #if _MIPS_SIM != _MIPS_SIM_ABI64
> >  #define __ARCH_FLOCK_EXTRA_SYSID       long l_sysid;
> > diff --git a/arch/powerpc/include/asm/compat.h b/arch/powerpc/include/asm/compat.h
> > index 7afc96fb6524b..83d8f70779cbc 100644
> > --- a/arch/powerpc/include/asm/compat.h
> > +++ b/arch/powerpc/include/asm/compat.h
> > @@ -52,10 +52,6 @@ struct compat_flock {
> >         compat_pid_t    l_pid;
> >  };
> >
> > -#define F_GETLK64      12      /*  using 'struct flock64' */
> > -#define F_SETLK64      13
> > -#define F_SETLKW64     14
> > -
> >  struct compat_flock64 {
> >         short           l_type;
> >         short           l_whence;
> > diff --git a/arch/s390/include/asm/compat.h b/arch/s390/include/asm/compat.h
> > index cdc7ae72529d8..0f14b3188b1bb 100644
> > --- a/arch/s390/include/asm/compat.h
> > +++ b/arch/s390/include/asm/compat.h
> > @@ -110,10 +110,6 @@ struct compat_flock {
> >         compat_pid_t    l_pid;
> >  };
> >
> > -#define F_GETLK64       12
> > -#define F_SETLK64       13
> > -#define F_SETLKW64      14
> > -
> >  struct compat_flock64 {
> >         short           l_type;
> >         short           l_whence;
> > diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
> > index bd949fcf9d63b..108078751bb5a 100644
> > --- a/arch/sparc/include/asm/compat.h
> > +++ b/arch/sparc/include/asm/compat.h
> > @@ -84,10 +84,6 @@ struct compat_flock {
> >         short           __unused;
> >  };
> >
> > -#define F_GETLK64      12
> > -#define F_SETLK64      13
> > -#define F_SETLKW64     14
> > -
> >  struct compat_flock64 {
> >         short           l_type;
> >         short           l_whence;
> > diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
> > index 7516e4199b3c6..8d19a212f4f26 100644
> > --- a/arch/x86/include/asm/compat.h
> > +++ b/arch/x86/include/asm/compat.h
> > @@ -58,10 +58,6 @@ struct compat_flock {
> >         compat_pid_t    l_pid;
> >  };
> >
> > -#define F_GETLK64      12      /*  using 'struct flock64' */
> > -#define F_SETLK64      13
> > -#define F_SETLKW64     14
> > -
> >  /*
> >   * IA32 uses 4 byte alignment for 64 bit quantities,
> >   * so we need to pack this structure.
> > diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
> > index 98f4ff165b776..8c05d3d89ff18 100644
> > --- a/include/uapi/asm-generic/fcntl.h
> > +++ b/include/uapi/asm-generic/fcntl.h
> > @@ -116,13 +116,13 @@
> >  #define F_GETSIG       11      /* for sockets. */
> >  #endif
> >
> > -#ifndef CONFIG_64BIT
> > +#if __BITS_PER_LONG == 32 || defined(__KERNEL__)
> >  #ifndef F_GETLK64
> >  #define F_GETLK64      12      /*  using 'struct flock64' */
> >  #define F_SETLK64      13
> >  #define F_SETLKW64     14
> >  #endif
> > -#endif
> > +#endif /* __BITS_PER_LONG == 32 || defined(__KERNEL__) */
> >
> >  #ifndef F_SETOWN_EX
> >  #define F_SETOWN_EX    15
> > diff --git a/tools/include/uapi/asm-generic/fcntl.h b/tools/include/uapi/asm-generic/fcntl.h
> > index bf961a71802e0..6e16722026f39 100644
> > --- a/tools/include/uapi/asm-generic/fcntl.h
> > +++ b/tools/include/uapi/asm-generic/fcntl.h
> > @@ -115,13 +115,11 @@
> >  #define F_GETSIG       11      /* for sockets. */
> >  #endif
> >
> > -#ifndef CONFIG_64BIT
> >  #ifndef F_GETLK64
> >  #define F_GETLK64      12      /*  using 'struct flock64' */
> >  #define F_SETLK64      13
> >  #define F_SETLKW64     14
> >  #endif
> > -#endif
> >
> >  #ifndef F_SETOWN_EX
> >  #define F_SETOWN_EX    15
> > --
> > 2.30.2
> >
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
