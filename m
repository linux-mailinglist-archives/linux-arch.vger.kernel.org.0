Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A1D475D73
	for <lists+linux-arch@lfdr.de>; Wed, 15 Dec 2021 17:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbhLOQaz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Dec 2021 11:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbhLOQay (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Dec 2021 11:30:54 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EABC061574
        for <linux-arch@vger.kernel.org>; Wed, 15 Dec 2021 08:30:54 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id j17so22380088qtx.2
        for <linux-arch@vger.kernel.org>; Wed, 15 Dec 2021 08:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wa3MSwzDAVEHbCGfosICE8v1Pk9jdslFTtIGuGG4a6I=;
        b=c1PTqBMF2SXFw5lVk084Vcgcek2Ddjlpi2a/hQ6JzoM4R8cD0nIQ8k9FoYV4Lu14fi
         M8tFTAORWv7YALou+JE8nu5AZc14AcvyjMOUQ9yqxRGPnwMzWiqJI85Z/mRF2fadacuC
         KXb0zyqGpCLO+Mqo0kSbjkv3VwDAsletVkn36MxSRx2Jk4xgL3VeZ6U3JTPRlMZ3Hg4S
         oA3Pw45p4nQ7aubQ1wlqtUyljRMPJVfj+SEQ0cq9LyJ4fm3f5BpeC8JKvLzhgfeYxZOj
         x9D770IdLdjIxhZh/wAY1OnYTQbB95wNIfiJWE3UpR/BPIAL979uwnD3S0AUn6x23lTA
         aO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wa3MSwzDAVEHbCGfosICE8v1Pk9jdslFTtIGuGG4a6I=;
        b=Li2jkjfIunsWiBkWr1Sdw/bOcy12Dp6rjciflpuzLUWqt9GDsy1Osrb69MVIe1p+5H
         TRDIlC5toilQUjyu/ZN1dmqnqUutrPhRTQu2oElpyGXq0H57Lqup/lkwg8CRaYq/Yd8t
         7XU/S5TfPTvhLg4PgjpGCguRNGFE8Rm/27YVOUGOBP4hl9rpbjzDbdag0CsdXCafgpOe
         k8UuhLuIeV9B/GYUHJZX8ORT5t14L94TWtxJodlA2RQcIIWAU8WyyOhrz30KFza5m9gL
         on+6nrbWBzqnBKoennv8556yUYM2U7+snRQbmU5M2uMCJS/lJn82WC8FAVcQYLpPMpQa
         zWrA==
X-Gm-Message-State: AOAM531JXbRF8O6vbaV6DzUXB7oM1zURQ8/E9twLGhhhdrbrJoccmFh7
        ddHe/+szn5NMb0xnSiUBLBJtY2n8ijIdD7M7N/D98w==
X-Google-Smtp-Source: ABdhPJznT9ryyPhejtvqmNNv2J7uP1C2hCS3T5NZLL6AV5TLtXI9JAXkKTeGlkeEWt81/Q2IglZMECltJD/vANZdg+c=
X-Received: by 2002:a05:622a:2d5:: with SMTP id a21mr12781053qtx.56.1639585853171;
 Wed, 15 Dec 2021 08:30:53 -0800 (PST)
MIME-Version: 1.0
References: <20211214162050.660953-1-glider@google.com> <20211214162050.660953-34-glider@google.com>
 <Ybn45VpVhjeSqt/S@FVFF77S0Q05N>
In-Reply-To: <Ybn45VpVhjeSqt/S@FVFF77S0Q05N>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 15 Dec 2021 17:30:14 +0100
Message-ID: <CAG_fn=UZSVGLLm-O0o8bW1P=AzwF+wvGbDEq1PVB+HHf8wdU+g@mail.gmail.com>
Subject: Re: [PATCH 33/43] kmsan: disable physical page merging in biovec
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 15, 2021 at 3:17 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Dec 14, 2021 at 05:20:40PM +0100, Alexander Potapenko wrote:
> > KMSAN metadata for consequent physical pages may be inconsequent,
>
> I think you mean 'adjacent'/ rather than 'consequent' here, i.e.
Correct, thank you!

> > +     /*
> > +      * Merging consequent physical pages may not work correctly under KMSAN
> > +      * if their metadata pages aren't consequent. Just disable merging.
> > +      */
>
> Likewise here.
Ack.
