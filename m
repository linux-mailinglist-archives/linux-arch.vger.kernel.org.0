Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62DB81394E5
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jan 2020 16:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgAMPgR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jan 2020 10:36:17 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:37266 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgAMPgR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jan 2020 10:36:17 -0500
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 00DFaChC004910;
        Tue, 14 Jan 2020 00:36:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 00DFaChC004910
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578929773;
        bh=WvM/gJrWjdVgUnU+HkAKdEIOMw3oFE5evrhjYDUHO8Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AjXElao0UYggxb1dkHr7ah6ygIJcmjkZePTnf6OsVB3Lgu5XNgfXf2FY9+giU267w
         kY73r1h5UIzJ8M02jk5Xe+ukHDIA7ZdcpwkbHGY3SlBEm6IKHctwhK++HLkDZJy8bW
         X6XudRapkHOsXyiOLFjdalyK+kjBktvH/fjcwjEoWrqEpvZQtpvnqBG95EQw9ZcyfS
         vJ39FrMmstmZLRow9aXXVv3Yf62v1qqhCKqxuMpUXklb93bABavyVym2qhbzSg1wgA
         XZqnC10iPqgmNrBjYEnJKWSpJSQSO2qCYo70crJmNlIUHHVy+9u5Wq9TmdRZMEG2SB
         d6p0YsC9RTXmQ==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id a12so3502781uan.0;
        Mon, 13 Jan 2020 07:36:12 -0800 (PST)
X-Gm-Message-State: APjAAAVnuYDfPDfKgmaQ/oUR9h0ehVjm0+jb5e4wfC/xd2sZMKgwdD4f
        InF9vO2gqFtMa5119IHA8RvQgEfUN1ME/qcSQeU=
X-Google-Smtp-Source: APXvYqwYBiIIg3r8QgGcoIZIOVEtg69qxQQCglH/6roVxQ/uPHUuHQeSZFiMEV6rUasevilDljUUnofe9cNzeIXKF4k=
X-Received: by 2002:ab0:14ea:: with SMTP id f39mr7599928uae.40.1578929771582;
 Mon, 13 Jan 2020 07:36:11 -0800 (PST)
MIME-Version: 1.0
References: <20200110165636.28035-1-will@kernel.org> <20200110165636.28035-2-will@kernel.org>
 <CAK8P3a3ueJ_rQc-1JTg=3N0JSuY9BduJ6FrrPFG1K2FWVzJdfA@mail.gmail.com>
 <8fe4f81699517758b44afbe0e1a53bc080f64a62.camel@perches.com> <CAK8P3a1t9757M5CRKNX_X+T9VuLX+5=z5_845rLJGTG50RogXA@mail.gmail.com>
In-Reply-To: <CAK8P3a1t9757M5CRKNX_X+T9VuLX+5=z5_845rLJGTG50RogXA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 14 Jan 2020 00:35:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNARugZUWNF_1e70ZCyK5t_e4MFXnnw1PkmaRWQioQSPkEA@mail.gmail.com>
Message-ID: <CAK7LNARugZUWNF_1e70ZCyK5t_e4MFXnnw1PkmaRWQioQSPkEA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/8] compiler/gcc: Emit build-time warning for GCC
 prior to version 4.8
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Joe Perches <joe@perches.com>, Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 13, 2020 at 11:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Jan 10, 2020 at 6:54 PM Joe Perches <joe@perches.com> wrote:
> >
> > On Fri, 2020-01-10 at 18:35 +0100, Arnd Bergmann wrote:
> > > On Fri, Jan 10, 2020 at 5:56 PM Will Deacon <will@kernel.org> wrote:
> > > > Prior to version 4.8, GCC may miscompile READ_ONCE() by erroneously
> > > > discarding the 'volatile' qualifier:
> > > >
> > > > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
> > > >
> > > > We've been working around this using some nasty hacks which make
> > > > READ_ONCE() both horribly complicated and also prevent us from enforcing
> > > > that it is only used on scalar types. Since GCC 4.8 is pretty old for
> > > > kernel builds now, emit a warning if we detect it during the build.
> > >
> > > No objection to recommending gcc-4.8, but I think this should either
> > > just warn once during the kernel build instead of for every file, or
> > > it should become a hard requirement.
> >
> > It might as well be a hard requirement as
> > gcc 4.8.0 is already nearly 7 years old.
> >
> > gcc 4.6.0 released 2011-03-25
> > gcc 4.8.0 released 2013-03-22
> >
> > Perhaps there are exceedingly few to zero new
> > instances using gcc compiler versions < 4.8
>
> The last time we had this discussion, the result was that gcc-4.8 is
> probably ok as a minimum version, but moving to 5.1+ (from 2015)
> was not an obvious choice:
>
> https://www.spinics.net/lists/linux-kbuild/msg23648.html
>
> If nobody complains about the move to 4.8, we can try moving to
> gcc-5.1 and GNU99/GNU11 next year  ;-)
>
>        Arnd


I agree.

"Your compiler is old and may miscompile the kernel due to
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145 - please upgrade it."
sounds like an error rather than a warning.



-- 
Best Regards
Masahiro Yamada
