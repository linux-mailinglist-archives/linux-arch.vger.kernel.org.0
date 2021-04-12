Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869ED35BB38
	for <lists+linux-arch@lfdr.de>; Mon, 12 Apr 2021 09:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237084AbhDLHtv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Apr 2021 03:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237083AbhDLHtv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Apr 2021 03:49:51 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CD9C061574
        for <linux-arch@vger.kernel.org>; Mon, 12 Apr 2021 00:49:33 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id e14so7103266lfn.11
        for <linux-arch@vger.kernel.org>; Mon, 12 Apr 2021 00:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qFK3ymFR+8IkY/EyN1emVbVTfc7jJvlULyoMvBmBots=;
        b=Soa1RlqoeN2pveBDhZJ7t62minjfgT/bCsZg0/EBGI558bQ/bao3frHXP0Rz7qclWJ
         XlL0cuJODa1mwy5dDSETOj5ECqGIfCVjJ14QfQ6C5VOOVsvvjSbiWgX64VQqQHkhUMIC
         eOC6tA7GhvnTU36knNTYZi4yN5tdqRic44hco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qFK3ymFR+8IkY/EyN1emVbVTfc7jJvlULyoMvBmBots=;
        b=qMtQAwrNJEBVbf5N4etoNy19DJvomDkL68Uj/QDlWrofkWMTTVeIc68VamUEe97jVb
         i6m4Dliz8fO3w/hgoN9BxO3pgfi32ElAdi08fTpXBMwGqdinTpbis1DSZCoAtcfz7iTr
         EZccZ4LEt0EwW6h8pdprQKHK7kBx+LyopgyWPiRIN23cAsrD8XAHld3mayLveE0OhIqY
         XQyTxb8JgLf2D1/jERW2pEBdNTDoPgXhnpMouqD54ccaFV6/888wzOmET/PebXFJMlgL
         qQda79GFwmTZ//wi3y1+InHjiAKoUliMyLbzkaCMWvD3sWj8t6fUMaPLhMGjXaqMw9gD
         34HQ==
X-Gm-Message-State: AOAM533v9zw3jDbWByH6V0ctnw2//OInZjLYE1oTkVc4TBjZ3AyyVqUw
        urPhYdLxlyLz/DB4lBi4QuumXkBgaWuNHSBMN9mt0A==
X-Google-Smtp-Source: ABdhPJwBRSVhNhw4No6L7/vBHycAOzfNc3erh48gevSjcRU17HxBGnY6Rhiut8kw7o9Ldf5DIb/dwWKFzUtR20neYAw=
X-Received: by 2002:ac2:59c2:: with SMTP id x2mr4535970lfn.407.1618213771658;
 Mon, 12 Apr 2021 00:49:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210409065115.11054-1-alex@ghiti.fr> <3500f3cb-b660-5bbc-ae8d-0c9770e4a573@ghiti.fr>
 <be575094-badf-bac7-1629-36808ca530cc@redhat.com> <c4e78916-7e4c-76db-47f6-4dda3f09c871@ghiti.fr>
 <YHBEsDuEvPAnL8Vb@linux.ibm.com> <e7e87306-bb04-2d4f-7e7f-aabd40dccb3b@redhat.com>
 <YHBdzPsHantT9r8t@linux.ibm.com> <CAM4kBBKyHSYz+NNDpT=fWseWccsQ4HZ3teBc01jYT2g8j7Ze2A@mail.gmail.com>
 <ec1117a5-63fa-f800-1193-b5737eee6150@ghiti.fr>
In-Reply-To: <ec1117a5-63fa-f800-1193-b5737eee6150@ghiti.fr>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Mon, 12 Apr 2021 09:49:20 +0200
Message-ID: <CAM4kBBKijvZrpZPw4JLwdx+w+NEz4ceEwDSYh5xPgrqZx5Xkjw@mail.gmail.com>
Subject: Re: [PATCH v7] RISC-V: enable XIP
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 12, 2021 at 7:12 AM Alex Ghiti <alex@ghiti.fr> wrote:
>
> Le 4/9/21 =C3=A0 10:42 AM, Vitaly Wool a =C3=A9crit :
> > On Fri, Apr 9, 2021 at 3:59 PM Mike Rapoport <rppt@linux.ibm.com> wrote=
:
> >>
> >> On Fri, Apr 09, 2021 at 02:46:17PM +0200, David Hildenbrand wrote:
> >>>>>> Also, will that memory properly be exposed in the resource tree as
> >>>>>> System RAM (e.g., /proc/iomem) ? Otherwise some things (/proc/kcor=
e)
> >>>>>> won't work as expected - the kernel won't be included in a dump.
> >>>> Do we really need a XIP kernel to included in kdump?
> >>>> And does not it sound weird to expose flash as System RAM in /proc/i=
omem? ;-)
> >>>
> >>> See my other mail, maybe we actually want something different.
> >>>
> >>>>
> >>>>> I have just checked and it does not appear in /proc/iomem.
> >>>>>
> >>>>> Ok your conclusion would be to have struct page, I'm going to imple=
ment this
> >>>>> version then using memblock as you described.
> >>>>
> >>>> I'm not sure this is required. With XIP kernel text never gets into =
RAM, so
> >>>> it does not seem to require struct page.
> >>>>
> >>>> XIP by definition has some limitations relatively to "normal" operat=
ion,
> >>>> so lack of kdump could be one of them.
> >>>
> >>> I agree.
> >>>
> >>>>
> >>>> I might be wrong, but IMHO, artificially creating a memory map for p=
art of
> >>>> flash would cause more problems in the long run.
> >>>
> >>> Can you elaborate?
> >>
> >> Nothing particular, just a gut feeling. Usually, when you force someth=
ing
> >> it comes out the wrong way later.
> >
> > It's possible still that MTD_XIP is implemented allowing to write to
> > the flash used for XIP. While flash is being written, memory map
> > doesn't make sense at all. I can't come up with a real life example
> > when it can actually lead to problems but it is indeed weird when
> > System RAM suddenly becomes unreadable. I really don't think exposing
> > it in /proc/iomem is a good idea.
> >
> >>>> BTW, how does XIP account the kernel text on other architectures tha=
t
> >>>> implement it?
> >>>
> >>> Interesting point, I thought XIP would be something new on RISC-V (we=
ll, at
> >>> least to me :) ). If that concept exists already, we better mimic wha=
t
> >>> existing implementations do.
> >>
> >> I had quick glance at ARM, it seems that kernel text does not have mem=
ory
> >> map and does not show up in System RAM.
> >
> > Exactly, and I believe ARM64 won't do that too when it gets its own
> > XIP support (which is underway).
> >
>
>
> memmap does not seem necessary and ARM/ARM64 do not use it.
>
> But if someone tries to get a struct page from a physical address that
> lies in flash, as mentioned by David, that could lead to silent
> corruptions if something exists at the address where the struct page
> should be. And it is hard to know which features in the kernel depends
> on that.
>
> Regarding SPARSEMEM, the vmemmap lies in its own region so that's
> unlikely to happen, so we will catch those invalid accesses (and that's
> what I observed on riscv).
>
> But for FLATMEM, memmap is in the linear mapping, then that could very
> likely happen silently.
>
> Could a simple solution be to force SPARSEMEM for those XIP kernels ?
> Then wrong things could happen, but we would see those and avoid
> spending hours to debug :)
>
> I will at least send a v8 to remove the pfn_valid modifications for
> FLATMEM that now returns true to pfn in flash.

That sounds good to me. I am not very keen on spending 200K on struct
pages for flash (we can think of this as of an option but I would
definitely like to have the option to compile it out in the end), so
let's remove pfn_valid and fix things that will eventually break, if
some.

Best regards,
   Vitaly
