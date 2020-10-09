Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6C72883CF
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 09:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732267AbgJIHk6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 03:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732265AbgJIHk6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2020 03:40:58 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC4DC0613D2
        for <linux-arch@vger.kernel.org>; Fri,  9 Oct 2020 00:40:58 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g3so7257820qtq.10
        for <linux-arch@vger.kernel.org>; Fri, 09 Oct 2020 00:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dXkndgh/6kXZXBGdT1OVgg8/9FjPePJcSH0bS6uQ+Cw=;
        b=U5f4dxAhbv/BhGce3MLaVC+hlDOsxP62TK0g42WkPt9OpHCtKCBPiTZJszaZshLYfW
         XyhxwGpCNdXz8wvqmpqYkVC21dXW3SFs6sPfDWIuSBPHIfMCrQI81yoRW+KxyBzQYHu5
         D6TrguWU3k2FJQaGbp4Gmm29iDnE+pKI2fp214pZqBKMs51FZEGNaAdL+EBHjJ51SBhL
         pbb5vD7gB5YZNlZL2uZbvg66nweEfe27xLRffCKWz5AZZh1DECTytqrbzLbAx82IeJi5
         /Ykp598C+cP3uPsQZFGUdM1nenMU5BGgP2XunGhZIuwIsNMOC35q+gsnEodEt+wj0UMQ
         dkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dXkndgh/6kXZXBGdT1OVgg8/9FjPePJcSH0bS6uQ+Cw=;
        b=MgOi2avVA2MA+Egb9Yy1NJiGxvjTuJHFPz0inWLri4k21FZIOKpRkmRCDAtQQG9S/e
         PDKMxOCNkIEOzNqAn6N6MwYbKl0fkE98byKLCI7ZT9DjuPYZMAoyukswA/TXBYOuRYte
         vIAOBKfCUP+3t68LqM4FfTaXNzuyIikKP5wwiJZPZCzFvvMbJPll3OI6N8iNYPgkvfTD
         aG18w61ANw7Bm5C9jfc4p2pVDYWhWj08COcBePsra3JqnzlU3dpCylzH/x2Cjekagprw
         KESYuaoXS0LF4meRam4n82D8Qki+i/HRt17FUfSo4Uu8UAQLShkpIi9YG5y5nwrS5Qo8
         ssYQ==
X-Gm-Message-State: AOAM532ezLZ7L+QpzH+74/ozz8xzG6mXjb7i0O8RS58CDXRz8g1YFoTF
        LX/ZVZE276QUmUm6twY1m5QMrLX97PdB+myLr60=
X-Google-Smtp-Source: ABdhPJz1L3hggHaFXJ93CuoxVpf4HUuPN7qGDBH7fu5E/xTGcJfjrhS/hUEYPnY3SFJWNQU3wPLFivoNpsmlJTInVHk=
X-Received: by 2002:aed:35cb:: with SMTP id d11mr12357542qte.324.1602229257626;
 Fri, 09 Oct 2020 00:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601960644.git.thehajime@gmail.com> <714783a8d1d6aace7d0e315fc12ffc60b5867ada.1601960644.git.thehajime@gmail.com>
 <52dec5e578550efa0b8abbbabcf45d7ef7845c52.camel@sipsolutions.net>
In-Reply-To: <52dec5e578550efa0b8abbbabcf45d7ef7845c52.camel@sipsolutions.net>
From:   Hajime TAZAKI <thehajime@gmail.com>
Date:   Fri, 9 Oct 2020 16:40:46 +0900
Message-ID: <CADZqhTNqkb92=CJjvOX3esRFr72vFUHBwU2mLryPRvgDoepM6Q@mail.gmail.com>
Subject: Re: [RFC v7 16/21] um: nommu: plug in the build system
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-um@lists.infradead.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Octavian Purdila <tavi.purdila@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Akira Moroo <retrage01@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

(I removed UMMODE_LIB vs !MMU part, but leave replies to the others)

On Thu, 08 Oct 2020 04:20:00 +0900,
Johannes Berg wrote:

> >   make defconfig ARCH=um UMMODE=library
> >   make ARCH=um UMMODE=library
>
> Why not make it a real Kconfig symbol? I find the ARCH=um tricky enough
> to remember all the time, so much I usually write a "GNUmakefile" with
>
> export ARCH=um
> include Makefile
>
> :-)
>
> > +config UMMODE_LIB
> > + bool "UML mode: library mode"
> > + default y if "$(UMMODE)" = "library"
>
> So wait, you _can_ switch that through Kconfig then, because you made it
> a visible option (string after "bool"). But it won't work, because then
> you later in the build system etc. still check UMMODE instead of
> CONFIG_UMMODE_LIB. Seems like something that ought to be fixed one way
> or the other - at the very least hide this symbol if setting it manually
> is invalid.

I now see what I went wrong..
thanks, will fix this with your suggestion not to use the command line argument.

> > + help
> > + This mode switches a mode to build a library of UML (Linux
> > + Kernel Library/LKL).  This switch is exclusive to "kernel mode"
> > + of UML, which is traditional mode of UML.
>
> Not sure if that historically made more sense, but you don't have any
> UMMODE_KERNEL option or something like that, so the help text seems
> confusing?

thanks, we will clarify this text.

> > +ifeq ($(UMMODE),library)
> > +  SUBARCH := um/nommu
> > +endif
>
> >  INSTALL_PATH=$(objtree)/tools/um
> > +ifeq ($(UMMODE),library)
>
> Here a few places using UMMODE which must come from the command line.

will fix this too.

> >  linux.o: vmlinux
> >  @echo '  LINK $@'
> > - $(Q)$(OBJCOPY) -R .eh_frame $< $@
> > + $(Q)$(OBJCOPY) -R .eh_frame -L sem_init -L sem_post -L sem_wait -L sem_destroy $< $@
>
> Care to explain?

If we will link a userspace binary with liblinux.a (LKL) and
libpthread, the the symbols sem_init, etc will conflict with the one
in the kernel (ipc/sem.c).  objcopy command with -L localizes the
symbol specified to avoid this conflict.

We will add the description as a comment.

> > + select UACCESS_MEMCPY
> > + select ARCH_THREAD_STACK_ALLOCATOR
> > + select ARCH_HAS_SYSCALL_WRAPPER
>
> You never use this except for the selects, maybe can go elsewhere?

This is used at the patch 12/21, so add Kconfig earlier and move this
to 12/21 would be better.  We'll work on.

> > +config 64BIT
> > + bool
> > + default y
> > +
> > +config GENERIC_CSUM
> > + def_bool y
> > +
> > +config GENERIC_ATOMIC64
> > + bool
> > + default y if !64BIT
> > +
> > +config SECCOMP
> > + bool
> > + default n
> > +
> > +config GENERIC_HWEIGHT
> > + def_bool y
> > +
> > +config GENERIC_CALIBRATE_DELAY
> > + bool
> > + default n
> > +
> > +config STACKTRACE_SUPPORT
> > + bool
> > + default n
>
> You ... were just changing these elsewhere, so one of that isn't needed?

you're right too. will fix it.

-- Hajime
