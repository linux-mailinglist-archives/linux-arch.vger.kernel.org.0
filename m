Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8DF51B145
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2019 09:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfEMHj6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 May 2019 03:39:58 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40653 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfEMHj5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 May 2019 03:39:57 -0400
Received: by mail-it1-f194.google.com with SMTP id g71so18760229ita.5
        for <linux-arch@vger.kernel.org>; Mon, 13 May 2019 00:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OCBAgYZcl/Mx9I9kBUc9k0z+VS+2s/+/8BKjMe5L/4M=;
        b=SZjZHRBaI2LN21jyRT5EZkLIQdXHRrkgReZnW+swFod0bdKDie3+g+WGtklY0kC311
         D1KKaZ2x7uQDR0V2qnPwQzvKPDzqAA94Zpm8YHT/sOwgUG6HPRnEqu85XA+O1k0sypE5
         bbop+wUKsZ4yMehyLmsJ9459MhRGj3LYgqRz4uO/ypZ8wYUyM8rWxxtLJhVeYmIoNPzJ
         P0BGjN9KPs18zjGreU5S/Jg8qeugpnE19O6Fjj/RYomOU65m0ow3YaAVxRMZqaRgh++4
         kfjbw31MpcBw/JJVWa6iRCoFOI7x3lquY0Qvqmfqv/Cd/3KZ+WPUFvwRRIVAPicbMYQz
         mSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OCBAgYZcl/Mx9I9kBUc9k0z+VS+2s/+/8BKjMe5L/4M=;
        b=SAHDQdvPnmMuU5CuVU5Za1p6Euq0imKF/9rUa7HFaEl+9xvOQRIViwU+TQ1VAks+hy
         j2KU+Y7DzAxqQQj1UB4wORoxmhMjwHpZK+0VNlgLSfiTvWSw4Oo6Owqt4rDHnGpfL+Z0
         K2m3t42nvVOccpxgvpJZVeA21xinz6GQ7RVxetGS5OVsgzy8iy7GrVtetkZUK7zPeF4c
         wIdFj7P5bC9t7r8e6f5ygKOIxvdtuaFnGY7VM82WbROBUOxr1fwxlQsREKtMPJFNe4Ry
         UqXAwmhWxdT3t3U3gLQgmtNHGaY+X9KJN7NpLIzpE4+3Ajwx90grmvJC1gJ5fjDchSr+
         Wamg==
X-Gm-Message-State: APjAAAWfB0s3DwZ3TIr+k7EOBYKpROgmlxVMGCDIRXdS1fM4W64LwW0N
        f5CAWNVBQnktdEgdgvZiWvI+0Rzb1cS5TOrp0/bXsLJh
X-Google-Smtp-Source: APXvYqx3ThZE+Yj0kNbVwe1j3uegPjtZ90tj9AYcwjCq3pZNd6Fh+sqbqj1PKRwpmit1sNvknwuQU89gTtGOhYZrWFU=
X-Received: by 2002:a05:660c:10f:: with SMTP id w15mr11634340itj.166.1557733196690;
 Mon, 13 May 2019 00:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190412143538.11780-1-hch@lst.de> <CAK8P3a2bg9YkbNpAb9uZkXLFZ3juCmmbF7cRw+Dm9ZiLFno2OQ@mail.gmail.com>
 <fd59e6e22594f740eaf86abad76ee04d@mailhost.ics.forth.gr> <CACT4Y+aKGKm9Wbc1owBr51adkbesHP_Z81pBAoZ5HmJ+uZdsaw@mail.gmail.com>
 <CAK8P3a3xRBZrgv16sSigJhY0vGmb=qF9o=6dC_5DqAJtW3qPGQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3xRBZrgv16sSigJhY0vGmb=qF9o=6dC_5DqAJtW3qPGQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 13 May 2019 09:39:45 +0200
Message-ID: <CACT4Y+ad5z6z0Dweh5hGwYcUUebPEtqsznmX9enPvYB20J16aA@mail.gmail.com>
Subject: Re: [PATCH, RFC] byteorder: sanity check toolchain vs kernel endianess
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, May 11, 2019 at 2:51 AM
To: Dmitry Vyukov
Cc: Nick Kossifidis, Christoph Hellwig, Linus Torvalds, Andrew Morton,
linux-arch, Linux Kernel Mailing List, linuxppc-dev

> On Fri, May 10, 2019 at 6:53 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > I think it's good to have a sanity check in-place for consistency.
> >
> >
> > Hi,
> >
> > This broke our cross-builds from x86. I am using:
> >
> > $ powerpc64le-linux-gnu-gcc --version
> > powerpc64le-linux-gnu-gcc (Debian 7.2.0-7) 7.2.0
> >
> > and it says that it's little-endian somehow:
> >
> > $ powerpc64le-linux-gnu-gcc -dM -E - < /dev/null | grep BYTE_ORDER
> > #define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__
> >
> > Is it broke compiler? Or I always hold it wrong? Is there some
> > additional flag I need to add?
>
> It looks like a bug in the kernel Makefiles to me. powerpc32 is always
> big-endian,
> powerpc64 used to be big-endian but is now usually little-endian. There are
> often three separate toolchains that default to the respective user
> space targets
> (ppc32be, ppc64be, ppc64le), but generally you should be able to build
> any of the
> three kernel configurations with any of those compilers, and have the Makefile
> pass the correct -m32/-m64/-mbig-endian/-mlittle-endian command line options
> depending on the kernel configuration. It seems that this is not happening
> here. I have not checked why, but if this is the problem, it should be
> easy enough
> to figure out.


Thanks! This clears a lot.
This may be a bug in our magic as we try to build kernel files outside
of make with own flags (required to extract parts of kernel
interfaces).
So don't spend time looking for the Makefile bugs yet.
