Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1897747AB53
	for <lists+linux-arch@lfdr.de>; Mon, 20 Dec 2021 15:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbhLTOfv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Dec 2021 09:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbhLTOfu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Dec 2021 09:35:50 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED32C06173E
        for <linux-arch@vger.kernel.org>; Mon, 20 Dec 2021 06:35:50 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id kk22so9529979qvb.0
        for <linux-arch@vger.kernel.org>; Mon, 20 Dec 2021 06:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KIUzswcAUaRAOTc8qof1lu1zKeUeUmXtr9MrXGORaeI=;
        b=DiEjH6My8Ez1IQhVc6pvDrx8DdYBf5P9Q+clTviqtdAcGoyrz8O3Mm0QM1wUFrNkY0
         erUGHvnkQdBzOobPRhQhMUs2tWFe8BqPjTGLGO7iDNYJjnvifWvJK0CZAwohnr/jSIgz
         QpKt+Ew79In897TuLR2zRLivKaLe3tEQEONG8JVkG6PU0InE460sA5jq4dymMlHT8XSX
         zg2DC/LWEyYpH62+sfMqlCvUH8ljGrMJB9GT5NpPjnlC3IZ7ST16PWtT0L8tFOZmLFjb
         TIGp0qdZPmp5QBN5QRqIC1GTcIzUBcUI8b5RNxMVY+8vGRJeuba9qlq6VNmEPxlzglI1
         v4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KIUzswcAUaRAOTc8qof1lu1zKeUeUmXtr9MrXGORaeI=;
        b=DqKAE0Kv8niPVdiKMg2M2Ny8eU6az1Or5QjuX1fVPexX24bAhpsG/fq6PK59W+UFX9
         oM11JODVfMpkbHEvxyTA9dyaKF5/qhj565uOqXrPqvx+4CMVKQCmbZGehMg7PIkN4nI/
         qCvN/XQl5tsLwqRkQjbpgQM1MRv00y8ard80Oj8pXgFzTMY8jUd2K/XeBORO4xBgDW+p
         tL1MXceDjh0b6Ya3ldenO9wlNm6hVko2w8F+0LlMQAJ9WnpBP2YDWYYvwPpAHBYuKGDw
         lmqGRQHJE27OgWULY1mIo0oxgHl1Nrwk04JnZpHU410CEYRX4RFA4O1x/hQTvwdQrOr1
         9jGw==
X-Gm-Message-State: AOAM532VBtnNJjTQtdaWp/d+6HEEKJZPY1YaLV2V8iUhWmcmZyS67g4p
        fJi5lD8mwDLqf3FetiquKtlvVRe2rVQUfZC8MQP9Xg==
X-Google-Smtp-Source: ABdhPJzaFRZE2AdeTnoG9pfGf1WQwZj1GmAFj8sa8rSd0l4vITphwUpgRq+6SCv0VHaU8fAW9eiqASykEX99MrCy/vM=
X-Received: by 2002:a0c:8031:: with SMTP id 46mr13207207qva.126.1640010949396;
 Mon, 20 Dec 2021 06:35:49 -0800 (PST)
MIME-Version: 1.0
References: <20211214162050.660953-1-glider@google.com> <20211214162050.660953-40-glider@google.com>
 <87bl1ec32a.ffs@tglx>
In-Reply-To: <87bl1ec32a.ffs@tglx>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 20 Dec 2021 15:35:13 +0100
Message-ID: <CAG_fn=VTow8S-H8SQbDNmB8gj+QpBm3RFKeiYhH=CRo0yd_CKg@mail.gmail.com>
Subject: Re: [PATCH 39/43] x86: kmsan: handle register passing from
 uninstrumented code
To:     Thomas Gleixner <tglx@linutronix.de>
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
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 17, 2021 at 10:51 PM Thomas Gleixner <tglx@linutronix.de> wrote=
:
>
> Alexander,
>
> On Tue, Dec 14 2021 at 17:20, Alexander Potapenko wrote:
> > When calling KMSAN-instrumented functions from non-instrumented
> > functions, function parameters may not be initialized properly, leading
> > to false positive reports. In particular, this happens all the time whe=
n
> > calling interrupt handlers from `noinstr` IDT entries.
> >
> > Fortunately, x86 code has instrumentation_begin() and
>
> It's not only x86 code:
> >  kernel/entry/common.c           | 3 +++

Shall this bit go into a separate patch?

> > @@ -76,6 +77,7 @@ __visible noinstr void do_syscall_64(struct pt_regs *=
regs, int nr)
> >       nr =3D syscall_enter_from_user_mode(regs, nr);
> >
> >       instrumentation_begin();
> > +     kmsan_instrumentation_begin(regs);
>
> Can we please make this something like:
>
>        instrumentation_begin_at_entry(regs);

Fine, will do.
Do you think it would make sense to hide it inside
instrumentation_begin(), or is it ok to have both macros follow each
other?

> or some other sensible name which hides that kmsan gunk and avoids to
> touch all of this again when KFOOSAN comes around?
>
> Thanks,
>
>         tglx
>
>
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
