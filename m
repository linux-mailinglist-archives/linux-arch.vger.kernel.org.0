Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95FBC1A5EB
	for <lists+linux-arch@lfdr.de>; Sat, 11 May 2019 02:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfEKAvb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 May 2019 20:51:31 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38098 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfEKAvb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 May 2019 20:51:31 -0400
Received: by mail-qt1-f193.google.com with SMTP id d13so1598567qth.5;
        Fri, 10 May 2019 17:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2yJyMuj40ehLn1VJjGCyDbn5ZrzNMv6yLbIutJnLbw0=;
        b=oslF2ILCtz6Ra76n5Gdli4mg1t5uTVK7flOHFONAcO6QR/C1HZJyMnQhDnsDBICH5n
         /DPlgM+yrTiIRHefxIdZVJTdVzACEdIyOxVdtF3lypZIf8IFfqtX42lm/iYW4z9h0WoB
         V2viRR6n4BfhTZB0nMuA4VTM2HO4Jpy271uaygsjvCVS4YOKjRqg05ZDWFwldAokokyc
         pXW0IWQoH59hDEwPp1wVpQySlIPbOaQV8NrBJ8XvudPBj6yKz6q0duBu7l7sz65WCaF3
         9B9T68OZTB8RmxyXanUii4lk9QlxtPHQCgFXcYzr1c9lCTFiuUL+aDPvTqMzvmaxPxID
         72yw==
X-Gm-Message-State: APjAAAXdPTq2g06a2VWs1UaWFq4r95Yq8XqEcaH4Aa2pTlqZ2TKoxzw1
        pSjpbBiCpO3qvSah9KDzPvsOTdFFlYdmAYBw/Ho=
X-Google-Smtp-Source: APXvYqxFKEloXfs+RHuMKqqDTkbQ2DMYSkXhWhHARTrTqb4xCGfWCNfnszBb+Rc+y0gwljMkH4orfi2JM8qYr2q0Dhk=
X-Received: by 2002:a0c:87f4:: with SMTP id 49mr11681367qvk.149.1557535885304;
 Fri, 10 May 2019 17:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190412143538.11780-1-hch@lst.de> <CAK8P3a2bg9YkbNpAb9uZkXLFZ3juCmmbF7cRw+Dm9ZiLFno2OQ@mail.gmail.com>
 <fd59e6e22594f740eaf86abad76ee04d@mailhost.ics.forth.gr> <CACT4Y+aKGKm9Wbc1owBr51adkbesHP_Z81pBAoZ5HmJ+uZdsaw@mail.gmail.com>
In-Reply-To: <CACT4Y+aKGKm9Wbc1owBr51adkbesHP_Z81pBAoZ5HmJ+uZdsaw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 10 May 2019 20:51:12 -0400
Message-ID: <CAK8P3a3xRBZrgv16sSigJhY0vGmb=qF9o=6dC_5DqAJtW3qPGQ@mail.gmail.com>
Subject: Re: [PATCH, RFC] byteorder: sanity check toolchain vs kernel endianess
To:     Dmitry Vyukov <dvyukov@google.com>
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

On Fri, May 10, 2019 at 6:53 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > I think it's good to have a sanity check in-place for consistency.
>
>
> Hi,
>
> This broke our cross-builds from x86. I am using:
>
> $ powerpc64le-linux-gnu-gcc --version
> powerpc64le-linux-gnu-gcc (Debian 7.2.0-7) 7.2.0
>
> and it says that it's little-endian somehow:
>
> $ powerpc64le-linux-gnu-gcc -dM -E - < /dev/null | grep BYTE_ORDER
> #define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__
>
> Is it broke compiler? Or I always hold it wrong? Is there some
> additional flag I need to add?

It looks like a bug in the kernel Makefiles to me. powerpc32 is always
big-endian,
powerpc64 used to be big-endian but is now usually little-endian. There are
often three separate toolchains that default to the respective user
space targets
(ppc32be, ppc64be, ppc64le), but generally you should be able to build
any of the
three kernel configurations with any of those compilers, and have the Makefile
pass the correct -m32/-m64/-mbig-endian/-mlittle-endian command line options
depending on the kernel configuration. It seems that this is not happening
here. I have not checked why, but if this is the problem, it should be
easy enough
to figure out.

       Arnd
