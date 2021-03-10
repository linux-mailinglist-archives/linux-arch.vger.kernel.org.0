Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76213333BA6
	for <lists+linux-arch@lfdr.de>; Wed, 10 Mar 2021 12:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhCJLnf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 10 Mar 2021 06:43:35 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:43659 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbhCJLnQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Mar 2021 06:43:16 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MSLlu-1l8zwg1biq-00Sioh; Wed, 10 Mar 2021 12:43:14 +0100
Received: by mail-oi1-f176.google.com with SMTP id d20so18734653oiw.10;
        Wed, 10 Mar 2021 03:43:13 -0800 (PST)
X-Gm-Message-State: AOAM531/7yZSvEeZkdCJa5NSq6fmieEqZ2RXVdtDQxJXhoLASuwSYSuv
        L1D+aTPOqxnQ5AciLBcxDsIpR6C2d074lcunWHY=
X-Google-Smtp-Source: ABdhPJxlHt0uYmch4USUhyI1PmZYpWv5SFHgA7xLm+M/LTOw8bqf4Cpyeoo3gC1uj5lb01XEoAYopnrDQGHXZzFybs8=
X-Received: by 2002:a05:6808:3d9:: with SMTP id o25mr2139659oie.4.1615376592865;
 Wed, 10 Mar 2021 03:43:12 -0800 (PST)
MIME-Version: 1.0
References: <20210225080453.1314-1-alex@ghiti.fr> <20210225080453.1314-3-alex@ghiti.fr>
 <5279e97c-3841-717c-2a16-c249a61573f9@redhat.com> <7d9036d9-488b-47cc-4673-1b10c11baad0@ghiti.fr>
In-Reply-To: <7d9036d9-488b-47cc-4673-1b10c11baad0@ghiti.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 10 Mar 2021 12:42:56 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3mVDwJG6k7PZEKkteszujP06cJf8Zqhq43F0rNsU=h4g@mail.gmail.com>
Message-ID: <CAK8P3a3mVDwJG6k7PZEKkteszujP06cJf8Zqhq43F0rNsU=h4g@mail.gmail.com>
Subject: Re: [PATCH 2/3] Documentation: riscv: Add documentation that
 describes the VM layout
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:bgeb1O6xJm5Eu32jvoeA9HZygSXfrnl6bZIKYPa2hQtRZXi2xN3
 8jiZ6cQFF3TuLw3vAMCIncE4hHz5L0+F/ma7mjn8OgcOJ8SBGuKV6xnwhYd1YRWxK+SHaUq
 GvuqHahb7NpC9WtQtfE1XV0CSRe53Ql/RVv7U9gTuy5hbREGU8NRODTnUE2vGdZycIwcAsV
 EaYbF3tvDquFns9QufCqQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DD+2KlrKtKs=:I8RnZHOqF3ZzqNfAQyYRZs
 eozE/kGvXgg3SwkhQPZo3yDi3UHAQl3YjU37wSfrg4wc7JTnCWLLsmKCWGwlXDC5eQKl0ctTr
 WMm9wS3qpjAIlvgxPoaUWMTaAfLd8FSVZfY3/AejgeJ7rVsB13zpmHXMgjOwm4A4VxyB6LHNW
 xl90+WmC/CvbjKbqeJQAQwlToPYiNWdMXybUY+U6PnuzTnaPwpXFjKRvEYCgdIRIwiC/n1J91
 XJiWP003mpMbm91mxfXNU3jnlIkmD4gh6lVuaOrChdXc1c2l6opjLx5wlSGj0dMmN0Bo/2Cke
 MPwWkJsDaxzdNXWEMpQ+gsFQvUF4r1icCF/kM9DgIT6rcTX8/95bdvKgbcmNehg1VLmaYBqFO
 AGLekYDVrJW0OsGZFCfKhMGoNrc1PVb2gmsRclRHfvlMqeppED9iDOt23F1b8TwTzAtMF7PXq
 /gJQpHeSCg6gQKLiEv6hxZdZAizwq8j9Kll9/il2Zf8D8+n/EvFhVszDaJ14sxwkqu8ePQw2E
 JkaEp3+OQnftw+WMKhTBNi8mqYP0KdgW02F+6mZuYrl3BxchjCoI0UEmir7kE/Mwg==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 25, 2021 at 12:56 PM Alex Ghiti <alex@ghiti.fr> wrote:
>
> Le 2/25/21 à 5:34 AM, David Hildenbrand a écrit :
> >                   |            |                  |         |> +
> > ffffffc000000000 | -256    GB | ffffffc7ffffffff |   32 GB | kasan
> >> +   ffffffcefee00000 | -196    GB | ffffffcefeffffff |    2 MB | fixmap
> >> +   ffffffceff000000 | -196    GB | ffffffceffffffff |   16 MB | PCI io
> >> +   ffffffcf00000000 | -196    GB | ffffffcfffffffff |    4 GB | vmemmap
> >> +   ffffffd000000000 | -192    GB | ffffffdfffffffff |   64 GB |
> >> vmalloc/ioremap space
> >> +   ffffffe000000000 | -128    GB | ffffffff7fffffff |  126 GB |
> >> direct mapping of all physical memory
> >
> > ^ So you could never ever have more than 126 GB, correct?
> >
> > I assume that's nothing new.
> >
>
> Before this patch, the limit was 128GB, so in my sense, there is nothing
> new. If ever we want to increase that limit, we'll just have to lower
> PAGE_OFFSET, there is still some unused virtual addresses after kasan
> for example.

Linus Walleij is looking into changing the arm32 code to have the kernel
direct map inside of the vmalloc area, which would be another place
that you could use here. It would be nice to not have too many different
ways of doing this, but I'm not sure how hard it would be to rework your
code, or if there are any downsides of doing this.

        Arnd
