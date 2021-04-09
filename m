Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AEE35A156
	for <lists+linux-arch@lfdr.de>; Fri,  9 Apr 2021 16:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhDIOmi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Apr 2021 10:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbhDIOmh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Apr 2021 10:42:37 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A181C061760
        for <linux-arch@vger.kernel.org>; Fri,  9 Apr 2021 07:42:24 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id u4so6751690ljo.6
        for <linux-arch@vger.kernel.org>; Fri, 09 Apr 2021 07:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mgWegSwhOpcGml0uML3IWUn1X3Z+AH0MFZdCHi/93PY=;
        b=o7eFJ30qOzBa3dgRnh/WcCN0kX49sPw9maR/6OuBKUPp5AJKAFmoQDa74vCSyYhlXn
         hXJeJrBR3C5NdSpTtex/aViY9q5M/fbQ4/Z9GR18hYJendIm2ZSEhhp48Syfl2xDKuD7
         d6uhhhrmy+ADPRbj2wNKbzG2BqQoEEVnbG5DY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mgWegSwhOpcGml0uML3IWUn1X3Z+AH0MFZdCHi/93PY=;
        b=leKIF4CjfmzMWKN9WvYvNgq6NdgSU1azbBJteylCmfDs5yi6MSq3vIZeTc6tqSUxzG
         K30MDRXJwKdG87xAeSER0xxJsAm+8H1WgD6QOmeWAluUmg1VyP8xR7eRhLaOAs9If2T0
         DJUo4rMVCLGbq9xDBaJwD9563ZFKoqnv6qXaRSYyUb7Wn7/x4LSY/u4dzVwsnxqXQzJL
         MnOqE5bz0sOcbOCLlUrTNtgCi8NdEo2FPtEgsD5xS5yrccDq1U9KmfAcRf154o3QrIr3
         UYjjYgZD42I8qx/9CfkRrKn/x8HZEOcEP+6Rlc5CfJisw0yPxYZovMcKmdGg3C793m5x
         gtfw==
X-Gm-Message-State: AOAM533LlvcdZfJjr4TtmVuUOjmq+dccy3uQgJ+kh21KXpro00thlpS2
        HeXWng9uWt0ovmImLeEa8psf6V09B0cWacdGUpErJQ==
X-Google-Smtp-Source: ABdhPJyLql3K0BO+oWb/9QvOTKYKMmjccNLMOLeXWEEXD3jfxsO8N+MD+HIzwc0FZJ18L7cYPrFgQ7ScHDtmwE+wAss=
X-Received: by 2002:a2e:9dd8:: with SMTP id x24mr9267330ljj.173.1617979343021;
 Fri, 09 Apr 2021 07:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210409065115.11054-1-alex@ghiti.fr> <3500f3cb-b660-5bbc-ae8d-0c9770e4a573@ghiti.fr>
 <be575094-badf-bac7-1629-36808ca530cc@redhat.com> <c4e78916-7e4c-76db-47f6-4dda3f09c871@ghiti.fr>
 <YHBEsDuEvPAnL8Vb@linux.ibm.com> <e7e87306-bb04-2d4f-7e7f-aabd40dccb3b@redhat.com>
 <YHBdzPsHantT9r8t@linux.ibm.com>
In-Reply-To: <YHBdzPsHantT9r8t@linux.ibm.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Fri, 9 Apr 2021 16:42:12 +0200
Message-ID: <CAM4kBBKyHSYz+NNDpT=fWseWccsQ4HZ3teBc01jYT2g8j7Ze2A@mail.gmail.com>
Subject: Re: [PATCH v7] RISC-V: enable XIP
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>, Alex Ghiti <alex@ghiti.fr>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 9, 2021 at 3:59 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Fri, Apr 09, 2021 at 02:46:17PM +0200, David Hildenbrand wrote:
> > > > > Also, will that memory properly be exposed in the resource tree as
> > > > > System RAM (e.g., /proc/iomem) ? Otherwise some things (/proc/kcore)
> > > > > won't work as expected - the kernel won't be included in a dump.
> > > Do we really need a XIP kernel to included in kdump?
> > > And does not it sound weird to expose flash as System RAM in /proc/iomem? ;-)
> >
> > See my other mail, maybe we actually want something different.
> >
> > >
> > > > I have just checked and it does not appear in /proc/iomem.
> > > >
> > > > Ok your conclusion would be to have struct page, I'm going to implement this
> > > > version then using memblock as you described.
> > >
> > > I'm not sure this is required. With XIP kernel text never gets into RAM, so
> > > it does not seem to require struct page.
> > >
> > > XIP by definition has some limitations relatively to "normal" operation,
> > > so lack of kdump could be one of them.
> >
> > I agree.
> >
> > >
> > > I might be wrong, but IMHO, artificially creating a memory map for part of
> > > flash would cause more problems in the long run.
> >
> > Can you elaborate?
>
> Nothing particular, just a gut feeling. Usually, when you force something
> it comes out the wrong way later.

It's possible still that MTD_XIP is implemented allowing to write to
the flash used for XIP. While flash is being written, memory map
doesn't make sense at all. I can't come up with a real life example
when it can actually lead to problems but it is indeed weird when
System RAM suddenly becomes unreadable. I really don't think exposing
it in /proc/iomem is a good idea.

> > > BTW, how does XIP account the kernel text on other architectures that
> > > implement it?
> >
> > Interesting point, I thought XIP would be something new on RISC-V (well, at
> > least to me :) ). If that concept exists already, we better mimic what
> > existing implementations do.
>
> I had quick glance at ARM, it seems that kernel text does not have memory
> map and does not show up in System RAM.

Exactly, and I believe ARM64 won't do that too when it gets its own
XIP support (which is underway).

Best regards,
   Vitaly
