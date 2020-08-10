Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32518241111
	for <lists+linux-arch@lfdr.de>; Mon, 10 Aug 2020 21:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgHJTjZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Aug 2020 15:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgHJTjY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Aug 2020 15:39:24 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5DCC061756
        for <linux-arch@vger.kernel.org>; Mon, 10 Aug 2020 12:39:24 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k23so10165642iom.10
        for <linux-arch@vger.kernel.org>; Mon, 10 Aug 2020 12:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KG7HkPdgfYza0KKOehXlJf0mICZpLgyaJzR9GuUofuc=;
        b=fUXOloVbCXuF+NPnW17bzh2jLA3H8qu/dOC7TPKOL2QUos/sBzQ5CRoxtQJFb8g3G2
         AYIyYbs0ZfZ6aDIaEoKZNgRRcvbTvgMlsOjLIYpmuy/J3SQhbHXV5dM/VhBeVH8XellB
         6N4elr0PMDoF7N56qBjJa5HD3724dVmbT1YCW1KovZJp2EVcKcAZIlSRmBQ0dOMRG8NV
         gxciGLPqMXMCMBAt0FPiDJwhSVy/LDGoZp0gSnby2PTGC0UM1mVSjd/0MuGwflaH95zs
         j03sj8mSaBzXWRfQq5lyPgMhXF45BsJug4i9aO4ErNTiuPZEXVroBiDBsJAczCMY7u9e
         vg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KG7HkPdgfYza0KKOehXlJf0mICZpLgyaJzR9GuUofuc=;
        b=CJ3rcvH8bJQUvow6aRASF/8w+zKvnX4gkbhwlEWzHtMzW+jXYraLsLkK7YCU13kkko
         GNQAXIk8Xp04CNNgROwxVjzLCQrj7vftbHjbF28rEJ06Rla3M0BNoXWOMHS9dFDTcCNK
         xYnoPEu2V0vytojACYXmgFPpjRsG+kgUBPPa4EIH/5UTcLk/7X0APddbcn9QC+DJqFS2
         GTMKD54Od8ZHKPSyufFt+KBD4kaTBKEXqMzUC0g+SX+14LzRr0Mg2h/GDn3q7h8t1hAI
         8x+sDiUK8oyvQ8WhgnZong1iIHQo3bLucTo56M0wYdog51j9db9akf8LSi8LAeCJF+AJ
         Hdzg==
X-Gm-Message-State: AOAM531zT7kZZkGklsQqB1FfSrjwdGdxfm0vtwoNguYDyTudiJ1MuAy6
        FyDtpMlDE5Ra2eX7TTawHFiQUhC9gUZMmuJV2QwONQ==
X-Google-Smtp-Source: ABdhPJyNCjBD+ApAm5EKXSFXpNtiLnuZQXUEji/Nk9r66AH8XDVZRUMie+STAQO5PpX/pDgrcUhz8sHf1IdT/5swGmI=
X-Received: by 2002:a6b:5c17:: with SMTP id z23mr18928874ioh.67.1597088363879;
 Mon, 10 Aug 2020 12:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2PK_bC5=3wcWm43=y5xk-Dq5-fGPExJMnOrNfGfB1m1A@mail.gmail.com>
 <20200805172629.GA1040@bug> <CAMuHMdV20tZSu5gGsjf8h334+0xr1f=N9NvOoxHQGq42GYsj4g@mail.gmail.com>
 <20200805193001.nebwdutcek53pnit@duo.ucw.cz>
In-Reply-To: <20200805193001.nebwdutcek53pnit@duo.ucw.cz>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 10 Aug 2020 12:39:12 -0700
Message-ID: <CAOesGMjaJ=jcdBp7b-DfetUKKF+cC6NcJdHavBXyP49b9Bztwg@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [TECH TOPIC] Planning code obsolescence
To:     Pavel Machek <pavel@denx.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 5, 2020 at 12:30 PM Pavel Machek <pavel@denx.de> wrote:
>
> On Wed 2020-08-05 20:50:43, Geert Uytterhoeven wrote:
> > Hi Pavel,
> >
> > On Wed, Aug 5, 2020 at 7:26 PM Pavel Machek <pavel@ucw.cz> wrote:
> > > > I have submitted the below as a topic for the linux/arch/* MC that Mike
> > > > and I run, but I suppose it also makes sense to discuss it on the
> > > > ksummit-discuss mailing list (cross-posted to linux-arch and lkml) as well
> > > > even if we don't discuss it at the main ksummit track.
> > >
> > > > * Latest kernel in which it was known to have worked
> > >
> > > For some old hardware, I started collecting kernel version, .config and dmesg from
> > > successful boots. github.com/pavelmachek, click on "missy".
> >
> > You mean your complete hardware collection doesn't boot v5.8? ;-)
>
> I need to do some pushing, and yes, maybe some more testing.
>
> But I was wondering if someone sees this as useful and wants to
> contribute more devices? :-).

There's in my opinion a big difference between "the last user of this
device sent it to Pavel and now it will be supported forever in spite
of no users" and "there's a whole group of people using mainline on
these old devices and Pavel makes sure it keeps booting for them".


-Olof
