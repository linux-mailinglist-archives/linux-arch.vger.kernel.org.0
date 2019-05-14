Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A21C41CFB2
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2019 21:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfENTNV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 May 2019 15:13:21 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:43484 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfENTNU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 May 2019 15:13:20 -0400
Received: by mail-ua1-f67.google.com with SMTP id u4so52483uau.10;
        Tue, 14 May 2019 12:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ey484zS6VT0M2Pei8ezvWLc9zrbpgGtkTWzKMtIHIxc=;
        b=bTyAxoi26MlY32ZVEWBpc7IGzT3MRipSSpeh1dW8sAyxHhYv+tEULUybeSBsS4y/rM
         K17+FAipOKt/JQ1OXodXFnyllxPBO7RtMH4zGIo6XCCVl/j1fkvWbGy9qZ3GAwVv5cQf
         Zc5XtBM2cpl+Gy3kVLjg4dfZQTfnN239oUNoibgiiYA7wqk+7sftZASUEGORTP4139T0
         HIKVszzo+dnB88opp4BHRfXK/z2WUyiixur1sXN6dx9U/etbpf7my5/Sy6zTuydB9rhv
         ImSZW2Nuc4sp8lVGGgUxK3mBDA90p/715SAUo3ipUOy5Mi5fugNtzMqTSRA+l4Uw78pT
         MTKQ==
X-Gm-Message-State: APjAAAUCwomsx5kb6zpFxhA/4NXhWcELobCNCUfBlcPmrvBx4aviesbC
        9/ls5TKnsrTWAVqlX90ZEjCFw1Fb7Ehwz3Tmaak=
X-Google-Smtp-Source: APXvYqwpNaVM9wRlHtOulRVzPKuMGHFU99WPEXTmHwABAVMr5sC13R5BhmyWg1OsGphA/1Wa/vebr7FJneAt0jS5OTs=
X-Received: by 2002:ab0:d89:: with SMTP id i9mr17498845uak.96.1557861198950;
 Tue, 14 May 2019 12:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190510081635.GA4533@jagdpanzerIV> <20190510084213.22149-1-pmladek@suse.com>
 <20190510122401.21a598f6@gandalf.local.home> <daf4dfd1-7f4f-8b92-6866-437c3a2be28b@c-s.fr>
 <096d6c9c17b3484484d9d9d3f3aa3a7c@AcuMS.aculab.com> <20190513091320.GK9224@smile.fi.intel.com>
 <20190513124220.wty2qbnz4wo52h3x@pathway.suse.cz> <20190514020730.GA651@jagdpanzerIV>
 <45348cf615fe40d383c1a25688d4a88f@AcuMS.aculab.com> <CAMuHMdXaMObq9h2Sb49PW1-HUysPeaWXB7wJmKFz=xLmSoUDZg@mail.gmail.com>
 <20190514143751.48e81e05@oasis.local.home>
In-Reply-To: <20190514143751.48e81e05@oasis.local.home>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 May 2019 21:13:06 +0200
Message-ID: <CAMuHMdUhy3uB+G23uXh__F2Y_Jsam5uS1Q5jJC95kWAOEM8WRA@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing addresses
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        christophe leroy <christophe.leroy@c-s.fr>,
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

Hi Steve,

On Tue, May 14, 2019 at 8:37 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 14 May 2019 11:02:17 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, May 14, 2019 at 10:29 AM David Laight <David.Laight@aculab.com> wrote:
> > > > And I like Steven's "(fault)" idea.
> > > > How about this:
> > > >
> > > >       if ptr < PAGE_SIZE              -> "(null)"
> > > >       if IS_ERR_VALUE(ptr)            -> "(fault)"
> > > >
> > > >       -ss
> > >
> > > Or:
> > >         if (ptr < PAGE_SIZE)
> > >                 return ptr ? "(null+)" : "(null)";
>
> Hmm, that is useful.
>
> > >         if IS_ERR_VALUE(ptr)
> > >                 return "(errno)"
>
> I still prefer "(fault)" as is pretty much all I would expect from a
> pointer dereference, even if it is just bad parsing of, say, a parsing
> an MAC address. "fault" is generic enough. "errno" will be confusing,
> because that's normally a variable not a output.
>
> >
> > Do we care about the value? "(-E%u)"?
>
> That too could be confusing. What would (-E22) be considered by a user
> doing an sprintf() on some string. I know that would confuse me, or I
> would think that it was what the %pX displayed, and wonder why it
> displayed it that way. Whereas "(fault)" is quite obvious for any %p
> use case.

I would immediately understand there's a missing IS_ERR() check in a
function that can return  -EINVAL, without having to add a new printk()
to find out what kind of bogus value has been received, and without
having to reboot, and trying to reproduce...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
