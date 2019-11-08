Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAF4EF4583
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 12:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbfKHLRT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 06:17:19 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:37646 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730151AbfKHLRT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 06:17:19 -0500
Received: by mail-il1-f196.google.com with SMTP id s5so4808493iln.4
        for <linux-arch@vger.kernel.org>; Fri, 08 Nov 2019 03:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1qQIKh0Kx09yt4UlfZE0QQimqZJs0HRuw35Gf2JD9II=;
        b=IVmR8kmezcJBZmhiWRutQsbwJUs8c5A02ZMQsI74eWnXopE6xN9Kmsofu1U8/Dz01Q
         c3n7sOSgQh11xtexkOR1DgTOKczAbkcdnnT62OQJL5/huG5dLZHCrt6sGuvYXEKdWbpF
         /NSQ3lGK9mtKu4KqVyf7ovhlczzCt5k8KfVuCzuqtW7Iwe5dKSjMUDufTBvOLczQCUVZ
         UEaje+bimWhJ3xGYLAAlToAH+PAAeYW7uSt3iwUlcC3LklYy/FTreUej6lujxpaTOcEz
         OKO00wgy41ZJqoYbUBlJ+xg3Ctb+O+iaQu62mo8NM1LnYQbgULw7LA2CWNVY5JUMUC14
         HZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1qQIKh0Kx09yt4UlfZE0QQimqZJs0HRuw35Gf2JD9II=;
        b=G1xT31JbFXLeWi/wlRGHsNGPCbyoCd/ey9A/sHKtzYs6fCheRs+MSi45es5Axh6wgA
         okQDxbfkN+rb9YTm9DNI9bpPMoSxRuYYdUN494LP8/3iheRaHrjjykyWQTCb4bKZuHqR
         9X/1THo8WrGK8gIsHutdNKSIZNNzDZrchqaU7xIsa39VdagwtmI/bbiEKyvqdfw6PvyH
         T944nfMtK6OQ6emtaiPacR3gKxSNA/jc+sosIaRL1bk/OKDWJGGIo2+T1xzkJRG64cnT
         pyZHOEnRoA3oaSrGfzzHaOxh+evAPG9/ahB+dCmTmaficsFAsS2sH8fz6zLLLIbVLwck
         I0FA==
X-Gm-Message-State: APjAAAUpJvMLkucbaMpV7fEg2yXIY2ZLI9zw7RELvAQh1cfZEeGtXiRk
        bQsymmKjcrrI6fnR1t7njrixurBJoIyfAtB8Law=
X-Google-Smtp-Source: APXvYqzwfYLNbik0CIvHznokXJnf6z56trdXVHdesXaKPD73Fgji+qOj96Mb9E45pfStlkOpQAWWF+Dd6gopE0z9Sxo=
X-Received: by 2002:a92:8108:: with SMTP id e8mr11444965ild.209.1573211837950;
 Fri, 08 Nov 2019 03:17:17 -0800 (PST)
MIME-Version: 1.0
References: <cover.1571798507.git.thehajime@gmail.com> <cover.1573179553.git.thehajime@gmail.com>
 <a4d1cb5c-04cd-b6c3-bc96-c5ef08bbcffe@cambridgegreys.com>
In-Reply-To: <a4d1cb5c-04cd-b6c3-bc96-c5ef08bbcffe@cambridgegreys.com>
From:   Octavian Purdila <tavi.purdila@gmail.com>
Date:   Fri, 8 Nov 2019 13:17:06 +0200
Message-ID: <CAMoF9u0EA=D=mpMy2fZ8=Et3rxrjnjDmjGRdcz83nGhS2eOKVQ@mail.gmail.com>
Subject: Re: [RFC v2 00/37] Unifying LKL into UML
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Akira Moroo <retrage01@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 8, 2019 at 11:13 AM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
>
<snip>

Hi Anton,

> I am reading the patch-set and I have a recurring question as I read it.
> It applies to IRQ, mmap IO, timers, devices, etc
>
> The question is: "What is the unerlying req to replace the existing UML
> code for the library".
>
> F.e timers in UML have been moved to an underlying POSIX timers call now
> and that can probably work on any system that offers it. If there is
> some presentation/documentation/etc material which I can read which goes
> through the actual choices it will be very helpful.
>

This (old) paper should help with some of the rationale and design
decision behind LKL:

https://www.researchgate.net/publication/224164682_LKL_The_Linux_kernel_library

> The same question applies the other way around too. I like the hostops
> approach, we can probably adopt some of that in UML proper to make it
> more portable and easier to have alternative implementations for the
> underlying host side operations.
>

The host ops part is not properly explained in the paper as it evolved
over time (they are called native operations there), so I will try to
give a high level overview here.

In order to make it easier to compile LKL applications for different
targets (OSes, architectures, user/kernel) we decided to use a two
step build process: a kernel build and a host target (+apps) build.
This helped us reduce intrusions in the kernel build system while
allowing to support the various requirements a host target has. As
part of the first step a lkl.o object and a set of processed kernel
uabi headers (to avoid conflicts with host Linux kernel headers) are
generated. These are then use to build a library (liblkl.so) for a
specific target. Here is where host ops are compiled in together with
the lkl.o object. This is the reason for the split between arch/lkl
(kernel) and tools/lkl (host target).

I think this build split is the biggest challenge in integrating LKL
with UML and I think once this is resolved it will be much easier to
merge the rest.

I am curios to learn what you think about such a split build for UML
and if there are any low hanging fruits we could start from.

Thanks,
Tavi
