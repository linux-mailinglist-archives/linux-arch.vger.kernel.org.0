Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A268E496
	for <lists+linux-arch@lfdr.de>; Mon, 29 Apr 2019 16:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfD2OWW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Apr 2019 10:22:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41046 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbfD2OWV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Apr 2019 10:22:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id 188so5385935pfd.8
        for <linux-arch@vger.kernel.org>; Mon, 29 Apr 2019 07:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q2RFfAyrf9RFoM43ktNZPcHmGWgFL8fnuov2nkBPWS8=;
        b=nSUn3qnawAssSs6MaxKqsGt7m2rQuwz8iuV7UDRO4XwagTQcUwQLKJChDfpo2Y42Xk
         dLm04wkPLwmDDcGlfi33gt+mgTjEgazJ0pWoNgMCBCgvVwv5SPNGO+R0wOTcgS/YyTDI
         MMCTRBCf6Y5X7Op946XZIErDxOVRLAN1uJUSs6b8aMjiipEdz924r1uFPAVVEONFnBC1
         eRjcEW3uL1UMy4VUvg8gNA4Pg7nsW7DCRDuZC0iLpBAnBGkKHCDzwyf3Uq04LayvwlmL
         Hgpedt4edzE9KmfV/TNfyjqaPwOmLbR2KI1O6u2H+6Cx6SK8d3Pu0MrHeMD38gdpjP27
         JeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q2RFfAyrf9RFoM43ktNZPcHmGWgFL8fnuov2nkBPWS8=;
        b=r8zQ7W5EyEKZPk9X2KSWkXeI29bZCFeuITzNoaOODQtZwHRsVvbpn/EsaAyxwyGOyg
         5H3TXt5IxIddW8Ukh5LsLqyjhxsIMs0IlXSItI6cRSn7vI8OoK6owUU/QesBa1cbaKzt
         0ZjbhIMCz7FL9UwitbUCIT5gYIQsUGDPBU718wk+TR/IMsn8aznb8OUJCljM4mC1ztAX
         ODPdEcfFz+X1hBqY3HB0W/GejzqwG0gvezilrIuqc2NPbcoaSIrrTKKINzUMg5A3/a0/
         m5gMXEWGnbTpfNRGq7QepKKhrKknlRMcjoe8R3M0HiyT3o5jWWe0rJBLADrRDMCBc/Tl
         cJSg==
X-Gm-Message-State: APjAAAX/BgHtSTq63qNk7XLys6u5VfpJMoHqTsprNS0EzTSsB7unia2s
        RSmd4iA9js29ydmpqK9YgmpbK7pDkdM/fN1sE27Vjg==
X-Google-Smtp-Source: APXvYqyjdyjRGlJ4AtmMgCZd/Nm8Zu8D+p70gtT5fOtGOIKXAcrI3uZOPLT4eOOdJOYGY3S3MZtVzM6xnMJJE/TXbvw=
X-Received: by 2002:a62:51c5:: with SMTP id f188mr24041707pfb.239.1556547740003;
 Mon, 29 Apr 2019 07:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553093420.git.andreyknvl@google.com> <44ad2d0c55dbad449edac23ae46d151a04102a1d.1553093421.git.andreyknvl@google.com>
 <20190322114357.GC13384@arrakis.emea.arm.com> <CAAeHK+xE-ywfpVHRhBJVGiqOe0+BYW9awUa10ZP4P6Ggc8nxMg@mail.gmail.com>
 <20190328141934.38960af0@gandalf.local.home> <20190329103039.GA44339@arrakis.emea.arm.com>
 <CAAeHK+xe-zWn8WpCxUxBB2tXL8oiLkshkPi1J3Ly87mACaA4-A@mail.gmail.com> <20190426141742.GB54863@arrakis.emea.arm.com>
In-Reply-To: <20190426141742.GB54863@arrakis.emea.arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 29 Apr 2019 16:22:08 +0200
Message-ID: <CAAeHK+xx_kB_U_ws8eUHOE8SkhGCcERNVcJoaMYbP9TGb+q2tg@mail.gmail.com>
Subject: Re: [PATCH v13 04/20] mm, arm64: untag user pointers passed to memory syscalls
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 26, 2019 at 4:17 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Apr 02, 2019 at 02:47:34PM +0200, Andrey Konovalov wrote:
> > On Fri, Mar 29, 2019 at 11:30 AM Catalin Marinas
> > <catalin.marinas@arm.com> wrote:
> > > On Thu, Mar 28, 2019 at 02:19:34PM -0400, Steven Rostedt wrote:
> > > > On Thu, 28 Mar 2019 19:10:07 +0100
> > > > Andrey Konovalov <andreyknvl@google.com> wrote:
> > > >
> > > > > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > > > > > ---
> > > > > > >  ipc/shm.c      | 2 ++
> > > > > > >  mm/madvise.c   | 2 ++
> > > > > > >  mm/mempolicy.c | 5 +++++
> > > > > > >  mm/migrate.c   | 1 +
> > > > > > >  mm/mincore.c   | 2 ++
> > > > > > >  mm/mlock.c     | 5 +++++
> > > > > > >  mm/mmap.c      | 7 +++++++
> > > > > > >  mm/mprotect.c  | 1 +
> > > > > > >  mm/mremap.c    | 2 ++
> > > > > > >  mm/msync.c     | 2 ++
> > > > > > >  10 files changed, 29 insertions(+)
> > > > > >
> > > > > > I wonder whether it's better to keep these as wrappers in the arm64
> > > > > > code.
> > > > >
> > > > > I don't think I understand what you propose, could you elaborate?
> > > >
> > > > I believe Catalin is saying that instead of placing things like:
> > > >
> > > > @@ -1593,6 +1593,7 @@ SYSCALL_DEFINE3(shmat, int, shmid, char __user *, shmaddr, int, shmflg)
> > > >       unsigned long ret;
> > > >       long err;
> > > >
> > > > +     shmaddr = untagged_addr(shmaddr);
> > > >
> > > > To instead have the shmaddr set to the untagged_addr() before calling
> > > > the system call, and passing the untagged addr to the system call, as
> > > > that goes through the arm64 architecture specific code first.
> > >
> > > Indeed. For example, we already have a SYSCALL_DEFINE6(mmap, ...) in
> > > arch/arm64/kernel/sys.c, just add the untagging there. We could do
> > > something similar for the other syscalls. I don't mind doing this in the
> > > generic code but if it's only needed for arm64, I'd rather keep the
> > > generic changes to a minimum.
> >
> > Do I understand correctly, that I'll need to add ksys_ wrappers for
> > each of the memory syscalls, and then redefine them in
> > arch/arm64/kernel/sys.c with arm64_ prefix, like it is done for the
> > personality syscall right now? This will require generic changes as
> > well.
>
> Yes. My aim is to keep the number of untagged_addr() calls in the
> generic code to a minimum (rather than just keeping the generic code
> changes small).

OK, will do in v14 (despite it still being unclear whether we should
do untagging here or not).

>
> --
> Catalin
