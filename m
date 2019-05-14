Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB431C58E
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2019 11:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbfENJCc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 May 2019 05:02:32 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33731 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfENJCc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 May 2019 05:02:32 -0400
Received: by mail-vs1-f65.google.com with SMTP id y6so9842770vsb.0;
        Tue, 14 May 2019 02:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2QqOosWQeAwRJoNs9Z6x1enYh3cBYDajQeKrzZRmqkc=;
        b=EBDOKAq49/KDVi0tJPh5n4UU6tXAV6jKZ+fM2FBHezMCMw4tNi7ZjPbmf1xyK4ai4u
         nONRFQcfVp6ZtxlXlnLIKnE0VgIY+EJ+xycYoVMwH3k65Qoj9C+uWKFB6fvHPPzhmo86
         korZpN5bvkdxwJj2h1/o6FXyrMnq18q4vO0aDWdFVpgeBZ4qqgV/fgYRSSD54Xj6yIaD
         Uz2kaxO4tipBDOTUH4EoDyhi/KtViZ1UStpLk/3JwYhTMgmseOvqLTsopN7/lq1BxYXM
         xeyS1vOorh37KWUo5RufwnH6k90qs34JxPsqy0eiWuurjiby43p0QNnnDJYUeHhcWclg
         4ZAw==
X-Gm-Message-State: APjAAAWldPZTH1qR+POgRnAdmForh7sSy+BSR9l0tRTGf/P2WYxKPe/X
        Nvk1f/e6o4Q04ba/IGFGVlLeru6Anp+R2orjFPY=
X-Google-Smtp-Source: APXvYqwi3qbyq7zdQc/EvX2OvsAWMtr+MgLv2h/XMFQWPJGUCYbXVG6LRayJYD+Q+PmXioY96F5KIcICjqmtTGPRtEc=
X-Received: by 2002:a67:7c93:: with SMTP id x141mr8531743vsc.96.1557824550758;
 Tue, 14 May 2019 02:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190510081635.GA4533@jagdpanzerIV> <20190510084213.22149-1-pmladek@suse.com>
 <20190510122401.21a598f6@gandalf.local.home> <daf4dfd1-7f4f-8b92-6866-437c3a2be28b@c-s.fr>
 <096d6c9c17b3484484d9d9d3f3aa3a7c@AcuMS.aculab.com> <20190513091320.GK9224@smile.fi.intel.com>
 <20190513124220.wty2qbnz4wo52h3x@pathway.suse.cz> <20190514020730.GA651@jagdpanzerIV>
 <45348cf615fe40d383c1a25688d4a88f@AcuMS.aculab.com>
In-Reply-To: <45348cf615fe40d383c1a25688d4a88f@AcuMS.aculab.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 May 2019 11:02:17 +0200
Message-ID: <CAMuHMdXaMObq9h2Sb49PW1-HUysPeaWXB7wJmKFz=xLmSoUDZg@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing addresses
To:     David Laight <David.Laight@aculab.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        christophe leroy <christophe.leroy@c-s.fr>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Russell Currey <ruscur@russell.cc>,
        Stephen Rothwell <sfr@ozlabs.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 14, 2019 at 10:29 AM David Laight <David.Laight@aculab.com> wrote:
> > And I like Steven's "(fault)" idea.
> > How about this:
> >
> >       if ptr < PAGE_SIZE              -> "(null)"
> >       if IS_ERR_VALUE(ptr)            -> "(fault)"
> >
> >       -ss
>
> Or:
>         if (ptr < PAGE_SIZE)
>                 return ptr ? "(null+)" : "(null)";
>         if IS_ERR_VALUE(ptr)
>                 return "(errno)"

Do we care about the value? "(-E%u)"?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
