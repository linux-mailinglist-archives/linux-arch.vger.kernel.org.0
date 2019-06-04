Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E941634088
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2019 09:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfFDHlT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jun 2019 03:41:19 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:45419 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfFDHlS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jun 2019 03:41:18 -0400
Received: by mail-lj1-f176.google.com with SMTP id m23so412355lje.12;
        Tue, 04 Jun 2019 00:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZAHr1x2OGrSpVVmyEF6SL+BemidY5crrkYYK4WkhFYw=;
        b=oCBie5I3iCCTadEzaA41MpPoyxl7PNo/ljtORXFf1+LnK6gzh2MOkiPLlFFCIkYhmS
         N/h7PccGPfVr9b00EB3cAHIMmF5SPIGlU0yXPo9Rc/pNO4IEhUptbe7IVfzcZakU9pBb
         r4i9bpi8jSbwSOy21fWlgwksa4N77d7TUD4yx3rSN26V5nVlVzr33pm3np4+HWIemKWB
         7/heXvEa3kgljnCyP6K7R1qWNNVImH7yxy+jMbP7An2HvduKRihgRGf4DnWd4c6SKeWP
         bLdnQWMyjWVciwJPibU3z/qPM6UNRtA9BPicxOsZ8C6FyvfToYop2rxrOztQ6ctnRzRB
         zYVg==
X-Gm-Message-State: APjAAAXlnIXcP0gWQB5Zoz1PpkoKzYFmOZgsQMvoOgQApaCGnheKKXOH
        xO9oCIWm7uCi9JeusoglHhb/c8Q4pkavjklKsvI=
X-Google-Smtp-Source: APXvYqzLztAMA/8xqZvEThx/dBoNLHWeEXrEpWdQwYRs3xI2FxEn7V2swIn8FrGUNYkkKJxgDcCVDKMKQoQ+1GalhoQ=
X-Received: by 2002:a2e:2b8d:: with SMTP id r13mr3443413ljr.145.1559634076658;
 Tue, 04 Jun 2019 00:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
 <20190531082112.GH2623@hirez.programming.kicks-ass.net> <C2D7FE5348E1B147BCA15975FBA2307501A2522B5B@us01wembx1.internal.synopsys.com>
 <20190603201324.GN28207@linux.ibm.com>
In-Reply-To: <20190603201324.GN28207@linux.ibm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jun 2019 09:41:04 +0200
Message-ID: <CAMuHMdW-8Jt80mSyHTYmj6354-3f1=Vp_8dY-Nite1ERpUCFew@mail.gmail.com>
Subject: Re: single copy atomicity for double load/stores on 32-bit systems
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <Will.Deacon@arm.com>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Paul,

On Mon, Jun 3, 2019 at 10:14 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> On Mon, Jun 03, 2019 at 06:08:35PM +0000, Vineet Gupta wrote:
> > On 5/31/19 1:21 AM, Peter Zijlstra wrote:
> > >> I'm not sure how to interpret "natural alignment" for the case of double
> > >> load/stores on 32-bit systems where the hardware and ABI allow for 4 byte
> > >> alignment (ARCv2 LDD/STD, ARM LDRD/STRD ....)
> > > Natural alignment: !((uintptr_t)ptr % sizeof(*ptr))
> > >
> > > For any u64 type, that would give 8 byte alignment. the problem
> > > otherwise being that your data spans two lines/pages etc..
> >
> > Sure, but as Paul said, if the software doesn't expect them to be atomic by
> > default, they could span 2 hardware lines to keep the implementation simpler/sane.
>
> I could imagine 8-byte types being only four-byte aligned on 32-bit systems,
> but it would be quite a surprise on 64-bit systems.

Or two-byte aligned?

M68k started with a 16-bit data bus, and alignment rules were retained
when gaining a wider data bus.

BTW, do any platforms have issues with atomicity of 4-byte types on
16-bit data buses? I believe some embedded ARM or PowerPC do have
such buses.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
