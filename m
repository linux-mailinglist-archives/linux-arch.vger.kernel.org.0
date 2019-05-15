Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8E81E8EF
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2019 09:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfEOHXT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 May 2019 03:23:19 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36417 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfEOHXS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 May 2019 03:23:18 -0400
Received: by mail-ua1-f68.google.com with SMTP id 94so87935uam.3;
        Wed, 15 May 2019 00:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D6y3Txro2Y80xJMXPF/WXXyGFbfglpcuRYylKAaykOs=;
        b=G4d5TbL2zXDn5f9I+chOsiGhFl10gM57db35uOamciP3gknJPcKVAPQ91SGx5xumQ9
         tvb51SUNSptNd5quVQ29U/dlzr49oSMN2kg61B+NDMqNh118Anjl577d7R4f9IV2G5Rm
         WWalbCsPJzu6IixyqHD8SxelZOfrxdanwBT9E1K8rJrZfzMPQXiw+QlDQLFFV5HzWztC
         FinsSG8D1crlV7wGLP63W3JJgBtGI+uAIwWbrYHxSxGKqbBfMRfkIW5OpXpXeEDoekkb
         YUbKyC3AYzdUDWVwXRtGr2bimNvLIrpD0Y9/bb6Asejx5QcuZ0cDYynoosigb4ODS4nT
         DJHA==
X-Gm-Message-State: APjAAAWZsGZ6LjNx1HBrEMY9eAuDJxvGx3efvWJrJaCXgkWAskar6KMB
        fK+OLxwNDPKg36z491yliv+KRlWAlzinHoI0xyhl+w==
X-Google-Smtp-Source: APXvYqwXjd7ZJQ8Ru9EPguJi1io4zPagRBwnSJVZX+f303p0r2QyE6ajAOtJrnYR8sRf8L5ySdKBcnfwbQtAINpBUKc=
X-Received: by 2002:ab0:6419:: with SMTP id x25mr19591138uao.86.1557904997683;
 Wed, 15 May 2019 00:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190510081635.GA4533@jagdpanzerIV> <20190510084213.22149-1-pmladek@suse.com>
 <20190510122401.21a598f6@gandalf.local.home> <daf4dfd1-7f4f-8b92-6866-437c3a2be28b@c-s.fr>
 <096d6c9c17b3484484d9d9d3f3aa3a7c@AcuMS.aculab.com> <20190513091320.GK9224@smile.fi.intel.com>
 <20190513124220.wty2qbnz4wo52h3x@pathway.suse.cz> <20190514020730.GA651@jagdpanzerIV>
 <45348cf615fe40d383c1a25688d4a88f@AcuMS.aculab.com> <CAMuHMdXaMObq9h2Sb49PW1-HUysPeaWXB7wJmKFz=xLmSoUDZg@mail.gmail.com>
 <20190514143751.48e81e05@oasis.local.home> <CAMuHMdUhy3uB+G23uXh__F2Y_Jsam5uS1Q5jJC95kWAOEM8WRA@mail.gmail.com>
 <20190514153503.6b7faaa7@oasis.local.home>
In-Reply-To: <20190514153503.6b7faaa7@oasis.local.home>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 May 2019 09:23:05 +0200
Message-ID: <CAMuHMdUFEwxwQUWg0HNUiz75hP6S7TVGSx7fWXnsQ_3qsVfotQ@mail.gmail.com>
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

On Tue, May 14, 2019 at 9:35 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 14 May 2019 21:13:06 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > Do we care about the value? "(-E%u)"?
> > >
> > > That too could be confusing. What would (-E22) be considered by a user
> > > doing an sprintf() on some string. I know that would confuse me, or I
> > > would think that it was what the %pX displayed, and wonder why it
> > > displayed it that way. Whereas "(fault)" is quite obvious for any %p
> > > use case.
> >
> > I would immediately understand there's a missing IS_ERR() check in a
> > function that can return  -EINVAL, without having to add a new printk()
> > to find out what kind of bogus value has been received, and without
> > having to reboot, and trying to reproduce...
>
> I have to ask. Has there actually been a case that you used a %pX and
> it faulted, and you had to go back to find what the value of the
> failure was?

If it faulted, the bad pointer value is obvious from the backtrace.
If the code avoids the fault by verifying the pointer and returning
"(efault)" instead, the bad pointer value is lost.

Or am I missing something?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
