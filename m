Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE251ED83C
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jun 2020 23:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgFCV7h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Jun 2020 17:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgFCV7g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jun 2020 17:59:36 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD191C08C5C0;
        Wed,  3 Jun 2020 14:59:36 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 23so1507066pfw.10;
        Wed, 03 Jun 2020 14:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jnwF1Toq1zg+I3R9H/up2SBuKxY8hOvcaRaCLXmqEXc=;
        b=Yx2NibBUqoCv/OV7CuvgU0yPb0k5dEgIjh2e7TZrKO6n28nrlKQ9ODCFCQlOPbHVxL
         p36WBWpm1IGVdoLE3c32MTZx4ZgEnQDZkL/b/VmfzuPw/jWEhv5yMEwGs6s/9n9i1SHJ
         d7B6B/87MRihs3ip1BE/dGvwMRX4RT8JHc3Vh/Sjh4NfcJ5SDD7BBDApd88td4YvPCwD
         DsK7uh38qMa3h/+UZw2JSsOB1vybwkFEm4pOxeLq8HCSzBAVtIyLw+tghnV/JdJysJmY
         uL9lsvXEFGzBTJSnMvYQLtTzAVDm7QbXNJEPYoFl+ay1XoCKy+YVhNnWr+fU1SLCivOG
         WM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jnwF1Toq1zg+I3R9H/up2SBuKxY8hOvcaRaCLXmqEXc=;
        b=dsKpsB9z7UD14J0koTWiUMXoCPAL7StVZgIvwB8cnD2f/kZTevaxnPgkQqzlDB7T+5
         KRHhhcbRSd0dBzKWIZVbR3+P84Y4FdbMrPCBbRDxxI+dsjdy5eb6luGYwBtQv2ga/Nf2
         icC+wx7s4SQqQhYvotmNMDeH3JibeZNaNzvSpogZqnYWFOeF/X7CZzJAOrdWGqmB2zSi
         KVJxXiu5EGnJYz+3efoR89RgRTnQZqRJJcF5vvZzUAmAxU8n97jsDdURHoA2xo8FuUPq
         8XBcSWzfV4c0QWcbUxH/esvoLzPiD11zZV73gBJ7S4xdCFH4L2uj+Qty7YHlr0jJH4Mf
         ZlTA==
X-Gm-Message-State: AOAM530uTFyMpYlMnM9qehFXeIwM6ZM2Wm7T0SKInHj8X7MPpQp1kC6O
        wC/BQKmmYkP8UIsuwptjPZPIxAK2GO/EAWRMryQ=
X-Google-Smtp-Source: ABdhPJwe/UN28Z8IzKpuwEHFOD1+W9b4Y3sdNM9oTVjMFxDCtr0nl4zSecglffjDiMj06pAkjlfWwQMjsR2P1c6Pxpc=
X-Received: by 2002:a63:545a:: with SMTP id e26mr1395213pgm.4.1591221576413;
 Wed, 03 Jun 2020 14:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <CACG_h5qGEsyRBHj+O5nmwsHpi3rkVQd1hVMDnnauAmqqTa_pbg@mail.gmail.com>
 <CAHp75VdPcNOuV_JO4y3vSDmy7we3kiZL2kZQgFQYmwqb6x7NEQ@mail.gmail.com>
 <CACG_h5pDHCp_b=UJ7QZCEDqmJgUdPSaNLR+0sR1Bgc4eCbqEKw@mail.gmail.com>
 <CAHp75VfBe-LMiAi=E4Cy8OasmE8NdSqevp+dsZtTEOLwF-TgmA@mail.gmail.com>
 <CACG_h5p1UpLRoA+ubE4NTFQEvg-oT6TFmsLXXTAtBvzN9z3iPg@mail.gmail.com>
 <CAHp75Vdxa1_ANBLEOB6g25x3O0V5h3yjZve8qpz-xkisD3KTLg@mail.gmail.com>
 <20200531223716.GA20752@rikard> <20200601083330.GB1634618@smile.fi.intel.com>
 <20200602190136.GA913@rikard> <CAHp75VdUf8=y+y4Q3OtWc7owxg0uX8LhZY4Nrgnezuv+aSyzUg@mail.gmail.com>
 <20200603215314.GA916134@rikard> <CAHp75VeQ+3rRAs+5Tmn=Tj_jkdKff=crwX9S3bPGLO6iVQ8Kqg@mail.gmail.com>
In-Reply-To: <CAHp75VeQ+3rRAs+5Tmn=Tj_jkdKff=crwX9S3bPGLO6iVQ8Kqg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 4 Jun 2020 00:59:19 +0300
Message-ID: <CAHp75VdVqKfGC1+yLOTORLXLRcLxXXUPW2v3iY0uGAS7CDUifQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] bitops: Introduce the the for_each_set_clump macro
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Emil Velikov <emil.l.velikov@gmail.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 4, 2020 at 12:58 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Jun 4, 2020 at 12:53 AM Rikard Falkeborn
> <rikard.falkeborn@gmail.com> wrote:
> > On Wed, Jun 03, 2020 at 11:49:37AM +0300, Andy Shevchenko wrote:
> > > On Tue, Jun 2, 2020 at 10:01 PM Rikard Falkeborn
> > > <rikard.falkeborn@gmail.com> wrote:
>
> ...
>
> > I'd be very surprised if compilers warned for explicit casts but  I'll
> > send a proper patch soon to let the build robot try it.
>
> I noticed that you should have received kbuild bot report about a
> driver where it appears.
>
> You patch broke all cases where (l) = 0 and (h) is type of unsigned
> (not a const from compiler point of view).

I will ask to revert for rc1 if there will be no fix.


-- 
With Best Regards,
Andy Shevchenko
