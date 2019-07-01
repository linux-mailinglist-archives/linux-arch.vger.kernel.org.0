Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A361F5BFBD
	for <lists+linux-arch@lfdr.de>; Mon,  1 Jul 2019 17:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfGAP0T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Jul 2019 11:26:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728801AbfGAP0S (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Jul 2019 11:26:18 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0C4A20659;
        Mon,  1 Jul 2019 15:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561994778;
        bh=Ih4bcw/JsMbYGyd0FqAHH4IJcHQtUXAcuIwTbsHMBi8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Rap9HDjTN3kiMZW3uWkg9RRp1r1eusDUvq7f7Zh/AXDRWpF+q454b5kYP87HWiVc8
         RPGzjidqVFOCb+ddi0SFqphR8bDA714hPs+ldZQ3uO3qX1P0cVHc9fc1yKD+aeTmmx
         JfHSSRVNQXil2SE0+FbX8NflimVhmoBF8H1OP6zk=
Received: by mail-wr1-f54.google.com with SMTP id n4so14294882wrw.13;
        Mon, 01 Jul 2019 08:26:17 -0700 (PDT)
X-Gm-Message-State: APjAAAXPc2YfecpitiO58+peG3U/6wT0CHeO4eTLjlSg2tA1x6mKFVQJ
        n1V7ek+UlHPJApRv/rnOsoz1HTJ1Fw0UJGBQdVo=
X-Google-Smtp-Source: APXvYqxRGwhspokcFFFd0KmyPEF9ycQbXeC/CojSvkLBlXQBabadTY0izBxWydQ61ZC4++TSBGTX/OIMRWTQ46rWuKw=
X-Received: by 2002:adf:9425:: with SMTP id 34mr12426100wrq.38.1561994776618;
 Mon, 01 Jul 2019 08:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <1561786601-19512-1-git-send-email-guoren@kernel.org> <CAK8P3a0F5-wtJHbLvEwUXE8EnALMpQb5KeX4FK3S90Ce81oN-Q@mail.gmail.com>
In-Reply-To: <CAK8P3a0F5-wtJHbLvEwUXE8EnALMpQb5KeX4FK3S90Ce81oN-Q@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 1 Jul 2019 23:26:05 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR7ooY=gxKW2zWK9MnuJ9YDm_1r6QTdJ=A=WqRDTuecRQ@mail.gmail.com>
Message-ID: <CAJF2gTR7ooY=gxKW2zWK9MnuJ9YDm_1r6QTdJ=A=WqRDTuecRQ@mail.gmail.com>
Subject: Re: [PATCH] csky: Improve abiv1 mem ops performance with glibc codes
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

On Mon, Jul 1, 2019 at 10:52 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Jun 29, 2019 at 7:36 AM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <ren_guo@c-sky.com>
> >
> > These codes are copied from glibc/string directory, they are the generic
> > implementation for string operations. We may further optimize them with
> > assembly code in the future.
> >
> > In fact these code isn't tested enough for kernel, but we've tested them
> > on glibc and it seems good. We just trust them :)
>
> Are these files from the architecture independent portion of glibc or
> are they csky specific? If they are architecture independent, we might
> want to see if they make sense for other architectures as well, and
> add them to lib/ rather than arch/csky/lib/
They are just copied from glibc-2.28/string/*.c and they are generic.
OK, I'll try to add them to lib/.

>
> Should the SPDX identifier list the original LGPL-2.1 license instead
> of GPL-2.0?
Yes, I removed full Licenses' description:
   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version

I'll change it to:
// SPDX-License-Identifier: LGPL-2.1

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
