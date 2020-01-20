Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 472D7142E3B
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2020 15:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgATO65 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jan 2020 09:58:57 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36087 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgATO65 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jan 2020 09:58:57 -0500
Received: by mail-qk1-f194.google.com with SMTP id a203so30363249qkc.3
        for <linux-arch@vger.kernel.org>; Mon, 20 Jan 2020 06:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eRQ0+UJNHKW1NOT+X9Ptz3p1mfuoK3ob/c2NaAESbjw=;
        b=uKQkn4nh1Hmb1VzqfGj1kZNZpHOrqe0/gjQHY6kKXtdLQ2OKPhf5qpFDHlh2p1nbsB
         PIyX/YsHR12twaWudeSAD22nkWJ1trGRlp0u6J1ywEvCrYSpVxAdP+GCgHpvDDhKjIAa
         TGPNT9ThvBZL3XAszK8rudkiAUCZeKIs0ccefuE1koi0i86ip/IioT0H6sCKytubTsD7
         PdrefwHeqlXpdr0Y868iwnvfK3sXrSKv9WanwMhA2JBenKkE92KveWk1nTE7m7nW8OJE
         /1gjqv4qZHC93/iSDbh6GnISn0B/VoqHQD1KKGYF6LVQbPW9wJ0Csot5eALz9Agw8KqE
         XTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eRQ0+UJNHKW1NOT+X9Ptz3p1mfuoK3ob/c2NaAESbjw=;
        b=TTAP0UJpYL4Du9aivjOrNG2QnerM8uoNQ8CwXz9WDGTMmaqXm6MgN/bsTpeCauIYoY
         HjnwofsIzGNpt6UNkEcGX+By+2n7MlssKJM/fflkRGR2FQwxWia+gM2QE3CXg5NJsmNQ
         iAvT02DhWEmFroYhKxa4juwLSvSyuwMtvywc8r69CQVNl3ODR7wnghBJODEH5ODCoUg1
         kQ9JCz0ujk9XOsF6wausMZfpJb3Px8P31adaO66/coNDwFKMwbd4gJr90EJq7qds27au
         8VxGg6at9PPGCJlyuiJSe25hL6NFE69AUGnXMTxXkO3MbZVOqlsHQvIK+QMawKoiClb5
         cjDg==
X-Gm-Message-State: APjAAAX+QKUKryl6EoCBfu87KT61rlvRgKeMVak5ZcuypunWYvrHQaZ5
        NasO6x/MRKNPGb67v2Ty/rYntzi99dGQWow2jr/WWA==
X-Google-Smtp-Source: APXvYqzRzzU9O3ZxF6WLrarovy3UD8IDGUR8JjGUu5YnvlYVbMHVlZ9dmLHCHobXwQoPv4fnY4LrBPOppw4nTPnvn5w=
X-Received: by 2002:a05:620a:1136:: with SMTP id p22mr52465723qkk.8.1579532336048;
 Mon, 20 Jan 2020 06:58:56 -0800 (PST)
MIME-Version: 1.0
References: <20200120141927.114373-1-elver@google.com> <CACT4Y+bnRoKinPopVqyxj4av6_xa_OUN0wwnidpO3dX3iYq_gg@mail.gmail.com>
In-Reply-To: <CACT4Y+bnRoKinPopVqyxj4av6_xa_OUN0wwnidpO3dX3iYq_gg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 20 Jan 2020 15:58:45 +0100
Message-ID: <CACT4Y+YuTT6kZ-AkgU0c1o09qmQdFWr4_Sds4jaDg-Va6g6jkA@mail.gmail.com>
Subject: Re: [PATCH 1/5] include/linux: Add instrumented.h infrastructure
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Daniel Axtens <dja@axtens.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Borkmann <daniel@iogearbox.net>, cyphar@cyphar.com,
        Kees Cook <keescook@chromium.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 20, 2020 at 3:45 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Jan 20, 2020 at 3:19 PM Marco Elver <elver@google.com> wrote:
> >
> > This adds instrumented.h, which provides generic wrappers for memory
> > access instrumentation that the compiler cannot emit for various
> > sanitizers. Currently this unifies KASAN and KCSAN instrumentation. In
> > future this will also include KMSAN instrumentation.
> >
> > Note that, copy_{to,from}_user require special instrumentation,
> > providing hooks before and after the access, since we may need to know
> > the actual bytes accessed (currently this is relevant for KCSAN, and is
> > also relevant in future for KMSAN).
> >
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  include/linux/instrumented.h | 153 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 153 insertions(+)
> >  create mode 100644 include/linux/instrumented.h
> >
> > diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> > new file mode 100644
> > index 000000000000..9f83c8520223
> > --- /dev/null
> > +++ b/include/linux/instrumented.h
> > @@ -0,0 +1,153 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * This header provides generic wrappers for memory access instrumentation that
> > + * the compiler cannot emit for: KASAN, KCSAN.
> > + */
> > +#ifndef _LINUX_INSTRUMENTED_H
> > +#define _LINUX_INSTRUMENTED_H
> > +
> > +#include <linux/compiler.h>
> > +#include <linux/kasan-checks.h>
> > +#include <linux/kcsan-checks.h>
> > +#include <linux/types.h>
> > +
> > +/**
> > + * instrument_read - instrument regular read access
> > + *
> > + * Instrument a regular read access. The instrumentation should be inserted
> > + * before the actual read happens.
> > + *
> > + * @ptr address of access
> > + * @size size of access
> > + */
>
> Based on offline discussion, that's what we add for KMSAN:
>
> > +static __always_inline void instrument_read(const volatile void *v, size_t size)
> > +{
> > +       kasan_check_read(v, size);
> > +       kcsan_check_read(v, size);
>
> KMSAN: nothing

KMSAN also has instrumentation in
copy_to_user_page/copy_from_user_page. Do we need to do anything for
KASAN/KCSAN for these functions?
