Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E693428E3
	for <lists+linux-arch@lfdr.de>; Fri, 19 Mar 2021 23:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhCSWs7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Mar 2021 18:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhCSWsx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Mar 2021 18:48:53 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F56C061760
        for <linux-arch@vger.kernel.org>; Fri, 19 Mar 2021 15:48:53 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id k14so4340135vsb.6
        for <linux-arch@vger.kernel.org>; Fri, 19 Mar 2021 15:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0Ja0Bm0pbGPbVCQFMQ5kja3rpS5JFuQnqh3OEFTkD4Q=;
        b=PoDC/F7a+9JZAGRETtRCTuh/CByXpenl8koD2/6Hh5xX7JZwYLzkYFLgq5yj4vnUUe
         Wj40+WfDascmSBDQLbtwgrrHUgKOS2DLakB95E0WOZRlG7PoOqcGWoIt00uy7pLQB8C+
         jqKXsgXWkQYjCoc8G54zX5rvXpYIPZ5us1Fk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0Ja0Bm0pbGPbVCQFMQ5kja3rpS5JFuQnqh3OEFTkD4Q=;
        b=rAh8tc46DMveVlxZi3B8I3k13a4votae4YGZnb/UzL7XR8r1bl/fAx5wDanzMWNlSN
         LOxELYrY07e72zrJKJ8adXqeJSyfEWdk5Kv39WhuV/FESiXHH0qmZfsqairtwfnCB35U
         7JUpqIo5cODOdgSjuhj7vDA9VDfqo/vvR7lVTv+3WmQtKhN44iKvdsAuEFKdYjn/z+JL
         NP9AMULWP/e68PYIt8CY/eMEJAWZBqpIeuJMIzLN9aYiDwREKltfQ2trdoTouK1gv4mE
         XLIaA5ZBsS5ftSW9j5fVJJLMU5W7+vTghLlDRsvf6RfD4NqFkwG1l66tkLMKpSFOCcMd
         hERA==
X-Gm-Message-State: AOAM532YqAJzdRvX1UZN6DNiL6Qkida1qCzJXi0OOVeB/ikVs2e/hOYW
        0wC7JipWPlOo+BzkbuRuf02XrLIxaprOinxY93KgZg==
X-Google-Smtp-Source: ABdhPJwrdL2VXaXsq6x7epbNTCHh5OO4DtFmNZjruWS6qG820mnUPtqOUwuccQbJt2TUaJCT/6tgUVX0Of+NZpT68HY=
X-Received: by 2002:a05:6102:3a06:: with SMTP id b6mr4437876vsu.21.1616194132651;
 Fri, 19 Mar 2021 15:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210318235416.794798-1-drinkcat@chromium.org>
 <20210319075410.for-stable-4.19.1.I222f801866f71be9f7d85e5b10665cd4506d78ec@changeid>
 <YFR/fQIePjDQcO5W@kroah.com> <b5d3d0ed-953e-083d-15f6-4a1e3ed95428@oracle.com>
 <YFSRRux3FHJVgWXt@kroah.com>
In-Reply-To: <YFSRRux3FHJVgWXt@kroah.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Sat, 20 Mar 2021 06:48:41 +0800
Message-ID: <CANMq1KDsqsF2AOeY033rUj_Sit57a7O77kZ9Ob=56veGLK_H+Q@mail.gmail.com>
Subject: Re: [for-stable-4.19 PATCH 1/2] vmlinux.lds.h: Create section for
 protection against instrumentation
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        stable <stable@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christopher Li <sparse@chrisli.org>,
        Daniel Axtens <dja@axtens.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Marek <michal.lkml@markovi.net>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Sasha Levin <sashal@kernel.org>, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        linux-sparse@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 19, 2021 at 7:55 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Mar 19, 2021 at 12:20:22PM +0100, Alexandre Chartre wrote:
> >
> > On 3/19/21 11:39 AM, Greg Kroah-Hartman wrote:
> > > On Fri, Mar 19, 2021 at 07:54:15AM +0800, Nicolas Boichat wrote:
> > > > From: Thomas Gleixner <tglx@linutronix.de>
> > > >
> > > > commit 6553896666433e7efec589838b400a2a652b3ffa upstream.
> > > >
> > > > Some code pathes, especially the low level entry code, must be prot=
ected
> > > > against instrumentation for various reasons:
> > > >
> > > >   - Low level entry code can be a fragile beast, especially on x86.
> > > >
> > > >   - With NO_HZ_FULL RCU state needs to be established before using =
it.
> > > >
> > > > Having a dedicated section for such code allows to validate with to=
oling
> > > > that no unsafe functions are invoked.
> > > >
> > > > Add the .noinstr.text section and the noinstr attribute to mark
> > > > functions. noinstr implies notrace. Kprobes will gain a section che=
ck
> > > > later.
> > > >
> > > > Provide also a set of markers: instrumentation_begin()/end()
> > > >
> > > > These are used to mark code inside a noinstr function which calls
> > > > into regular instrumentable text section as safe.
> > > >
> > > > The instrumentation markers are only active when CONFIG_DEBUG_ENTRY=
 is
> > > > enabled as the end marker emits a NOP to prevent the compiler from =
merging
> > > > the annotation points. This means the objtool verification requires=
 a
> > > > kernel compiled with this option.
> > > >
> > > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > > Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> > > > Acked-by: Peter Zijlstra <peterz@infradead.org>
> > > > Link: https://lkml.kernel.org/r/20200505134100.075416272@linutronix=
.de
> > > >
> > > > [Nicolas: context conflicts in:
> > > >   arch/powerpc/kernel/vmlinux.lds.S
> > > >   include/asm-generic/vmlinux.lds.h
> > > >   include/linux/compiler.h
> > > >   include/linux/compiler_types.h]
> > > > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > >
> > > Did you build this on x86?
> > >
> > > I get the following build error:
> > >
> > > ld:./arch/x86/kernel/vmlinux.lds:20: syntax error
> > >
> > > And that line looks like:
> > >
> > >   . =3D ALIGN(8); *(.text.hot .text.hot.*) *(.text .text.fixup) *(.te=
xt.unlikely .text.unlikely.*) *(.text.unknown .text.unknown.*) . =3D ALIGN(=
8); __noinstr_text_start =3D .; *(.__attribute__((noinline)) __attribute__(=
(no_instrument_function)) __attribute((__section__(".noinstr.text"))).text)=
 __noinstr_text_end =3D .; *(.text..refcount) *(.ref.text) *(.meminit.text*=
) *(.memexit.text*)
> > >
> >
> > In the NOINSTR_TEXT macro, noinstr is expanded with the value of the no=
instr
> > macro from linux/compiler_types.h while it shouldn't.
> >
> > The problem is possibly that the noinstr macro is defined for assembly.=
 Make
> > sure that the macro is not defined for assembly e.g.:
> >
> > #ifndef __ASSEMBLY__
> >
> > /* Section for code which can't be instrumented at all */
> > #define noinstr                                                        =
       \
> >       noinline notrace __attribute((__section__(".noinstr.text")))
> >
> > #endif
>
> This implies that the backport is incorrect, so I'll wait for an updated
> version...

Yep, sorry about that. I did test on ARM64 only and these patches
happily went through our Chrome OS CQ (we don't have gcc coverage
though).

Guenter has a fixup here with explanation:
https://crrev.com/c/2776332, I'll look carefully and resubmit.

Thanks,

> thanks,
>
> greg k-h
