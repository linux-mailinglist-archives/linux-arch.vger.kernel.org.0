Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A93CEDF1D5
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2019 17:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbfJUPng (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Oct 2019 11:43:36 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40618 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbfJUPng (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Oct 2019 11:43:36 -0400
Received: by mail-oi1-f194.google.com with SMTP id k9so11423808oib.7
        for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2019 08:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cnXjVYkeWXq+gubvSOjcYVnZzqsBIZ+DNJdYhPS5/D8=;
        b=kSbOVSxROO2ODHZOo0AzN65grokopehSUbmYsECSJU6VZS+Nr1cw7LV6r4iAcc7N6Q
         wzllLP+X0DveM8FqCCuVinvCaP3XnL9YCqdDKRLIgt+rSBWXCJrhGRJSCwEj6KftUioO
         0G2RZFY6J41AyIPK9sMmrPMRorNfiZZJTp5ufyuGPVmC6KiDrg62GQx+BfeYcb0Dnk00
         e/caau408WrMpaj5r51qcXRJcyfgpkFW4QXzy07SHQAOJOIGjTVSNPCX9FqYnJLFZw+a
         lxjcEwL/AFpSmr/jX73HRWC155IV+n6XsiPCIITIqBSlVnEH5R1A+3H+uOSRpVi6DTHo
         g2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cnXjVYkeWXq+gubvSOjcYVnZzqsBIZ+DNJdYhPS5/D8=;
        b=rnuUJYpfSWBIDmtuxyQMUJPxHY5O3AGxEdlUvgqy0idAxJeFBDcExxIF5bUff2kv30
         mKldEgo77fKqovkClUW67LbyTCPPu8nSkEeqNIwptpqIg02BREZafRIYaPm/j/KOZChP
         l+wlomEEsiNqtIY2Yf6zrZmpe31VnleFtMftQfTsvpGMkJbBumuzncOLDXCYZMWgJvaa
         1rAUMeM+nvlUH8Jay7T01Ycxh5kbx2U47rSYz96aByST/qYt8k/1dU9FHmC8W9Pu2T6D
         MsNEz21Esp5Rm3u3e3lavanA7OaCHWfvkUxdpcyYj7gq/OcZL/LFiImlwrFWD2tWRJt9
         Oo2Q==
X-Gm-Message-State: APjAAAX6j2ZIN7JkohW0K3FBkMf9ItjK3yPf30vZxBawkJRAcviYWfPX
        nSAKl2rv16H9kTN+Bc35VglWiDUpIvMi4oatMdUh+Q==
X-Google-Smtp-Source: APXvYqxc1yCRq3k+cvMu1sAucXV2pLfdg+Ismk5+9IUGxVHljKC2H3cX5Rq52uV7mrAoht13w5nwv0u1z0tu95TtZcU=
X-Received: by 2002:aca:f492:: with SMTP id s140mr20094795oih.83.1571672614698;
 Mon, 21 Oct 2019 08:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191017141305.146193-1-elver@google.com> <20191017141305.146193-3-elver@google.com>
 <CACT4Y+b9VYz0wji085hvg3ZMMv6FR_WGc_NcEZETSOvME6hYOQ@mail.gmail.com>
In-Reply-To: <CACT4Y+b9VYz0wji085hvg3ZMMv6FR_WGc_NcEZETSOvME6hYOQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 21 Oct 2019 17:43:22 +0200
Message-ID: <CANpmjNPyxjjkRigstizGLh4rQKhY8JVUzD-6sJLYf62KB77F5w@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] objtool, kcsan: Add KCSAN runtime functions to whitelist
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexander Potapenko <glider@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>,
        Daniel Lustig <dlustig@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-efi@vger.kernel.org,
        "open list:KERNEL BUILD + fi..." <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 21 Oct 2019 at 17:15, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Oct 17, 2019 at 4:13 PM Marco Elver <elver@google.com> wrote:
> >
> > This patch adds KCSAN runtime functions to the objtool whitelist.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  tools/objtool/check.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > index 044c9a3cb247..d1acc867b43c 100644
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -466,6 +466,23 @@ static const char *uaccess_safe_builtin[] = {
> >         "__asan_report_store4_noabort",
> >         "__asan_report_store8_noabort",
> >         "__asan_report_store16_noabort",
> > +       /* KCSAN */
> > +       "__kcsan_check_watchpoint",
> > +       "__kcsan_setup_watchpoint",
> > +       /* KCSAN/TSAN out-of-line */
>
> There is no TSAN in-line instrumentation.

Done @ v3.

> > +       "__tsan_func_entry",
> > +       "__tsan_func_exit",
> > +       "__tsan_read_range",
>
> There is also __tsan_write_range(), right? Isn't it safer to add it right away?

Added all missing functions for v3.

Many thanks for the comments!


> > +       "__tsan_read1",
> > +       "__tsan_read2",
> > +       "__tsan_read4",
> > +       "__tsan_read8",
> > +       "__tsan_read16",
> > +       "__tsan_write1",
> > +       "__tsan_write2",
> > +       "__tsan_write4",
> > +       "__tsan_write8",
> > +       "__tsan_write16",
> >         /* KCOV */
> >         "write_comp_data",
> >         "__sanitizer_cov_trace_pc",
> > --
> > 2.23.0.866.gb869b98d4c-goog
> >
