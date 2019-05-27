Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D06C2B532
	for <lists+linux-arch@lfdr.de>; Mon, 27 May 2019 14:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfE0M2w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 May 2019 08:28:52 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38194 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfE0M2w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 May 2019 08:28:52 -0400
Received: by mail-qk1-f194.google.com with SMTP id p26so15030824qkj.5;
        Mon, 27 May 2019 05:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rWDn1EpP4eQShj/YiW/gOE7EWLo5vc51PVu6vXx1TPc=;
        b=dTdZumPTQDMy8kRLgl5y65WYKSGTfxmb7nK9QG+YSivB9pokJwTSAG3gpY8gGaypbR
         g6XI/ibbHYOQlJIANMKxoeXJ9lZ3TzwDyB1BevpZ5OBJ5OqdKfZ7NkkRE2Ma1HwWcfho
         qYL+egpp8p1JJNl08uyh2CUlxkxCbtkO30RKFVw7BGPY4BlrcIbTSV4hPqE9Gk3zlGgQ
         OZg4phP73gkOfupRhN7G6e75BdOAK8UfTi4ZGyThc0NoeurbnbrBppmNC3uXWyxQ6nMY
         27ru1EouWZq7VI6HnQDCnVz7gavfwabqpqcnSWgmyRObRDNxhHzybWpMKEd7jS9MHAuB
         Ucog==
X-Gm-Message-State: APjAAAX0A4fU3YEbQRJ0CsmUjiwDvDgh4w4WfTgEUkxUWcnwvAyDXpCL
        sHdWXxWp95mH7KSLuWLP5vGWmVqrDwnXvmr3Phs=
X-Google-Smtp-Source: APXvYqzmhkKKNeuD0vGRNhhIhorDuDat7mVtalrNQBW+JjQtUosQodaoEkFjKAEBvNqlGn38dggu+nHZuNACipDUHhQ=
X-Received: by 2002:a0c:b78a:: with SMTP id l10mr70934055qve.62.1558960130995;
 Mon, 27 May 2019 05:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190526102612.6970-1-christian@brauner.io> <20190526102612.6970-2-christian@brauner.io>
 <CAK8P3a1Ltsna_rtKxhMU7X0t=UOXDA75tKpph6s=OZ4itJe7VQ@mail.gmail.com> <20190527104528.cao7wamuj4vduh3u@brauner.io>
In-Reply-To: <20190527104528.cao7wamuj4vduh3u@brauner.io>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 May 2019 14:28:33 +0200
Message-ID: <CAK8P3a3q=5Ca0xoMp+kyCvOqNDRzDTgu28f+U8J-buMVcZcVaw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arch: wire-up clone6() syscall on x86
To:     Christian Brauner <christian@brauner.io>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 27, 2019 at 12:45 PM Christian Brauner <christian@brauner.io> wrote:
> On Mon, May 27, 2019 at 12:02:37PM +0200, Arnd Bergmann wrote:
> > On Sun, May 26, 2019 at 12:27 PM Christian Brauner <christian@brauner.io> wrote:
> > >
> > > Wire up the clone6() call on x86.
> > >
> > > This patch only wires up clone6() on x86. Some of the arches look like they
> > > need special assembly massaging and it is probably smarter if the
> > > appropriate arch maintainers would do the actual wiring.
> >
> > Why do some architectures need special cases here? I'd prefer to have
> > new system calls always get defined in a way that avoids this, and
> > have a common entry point for everyone.
> >
> > Looking at the m68k sys_clone comment in
> > arch/m68k/kernel/process.c, it seems that this was done as an
> > optimization to deal with an inferior ABI. Similar code is present
> > in h8300, ia64, nios2, and sparc. If all of them just do this to
> > shave off a few cycles from the system call entry, I really
> > couldn't care less.
>
> I'm happy to wire all arches up at the same time in the next revision. I
> just wasn't sure why some of them were assemblying the living hell out
> of clone; especially ia64. I really didn't want to bother touching all
> of this just for an initial RFC.

Don't worry about doing all architectures for the RFC, I mainly want this
to be done consistently by the time it gets into linux-next.

One thing to figure out though is whether we need the stack_size argument
that a couple of architectures pass. It's usually hardwired to zero,
but not all the time, and I don't know the history of this.

       Arnd
