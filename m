Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943B71ED836
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jun 2020 23:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgFCV6h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Jun 2020 17:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgFCV6h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jun 2020 17:58:37 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7872C08C5C0;
        Wed,  3 Jun 2020 14:58:36 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y17so1289894plb.8;
        Wed, 03 Jun 2020 14:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qmgJt4PdsESH6tmBmwTOPwDVV1Ll9TPCWH5ByqNZkOs=;
        b=TCQcSsFl3qKkBj4YlGE4aC9Pbuf+moem+PaECr4bQzj/BobeofHt3xbI+d27DkcVNB
         40WjJqIcxTwfiGAI9XP/DuJEG1GLB9tb8FgXRaxkTjPfAG8ZYxTipspSxVw7uRHCbB0C
         WQ/m7tv6LToRIKoj7UVhUQwcGQkGMv/pbR2EdPjUP9LAjLo/va+qGx0NMiXMWWqjhS25
         eIXf9j1WnsLm7jhtI0fK0o+cilB+vRAdZaYxlJcjP6+6eN5oB8ZXRBNgkZxmC7f1Mdko
         JmI7ZYp4r6Ep6p4hI+sc8ThlePsd69HLNiq+tB8WIlzgq+0BlXRNKn+GLW3STgQf6VOQ
         i1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qmgJt4PdsESH6tmBmwTOPwDVV1Ll9TPCWH5ByqNZkOs=;
        b=GPECeNRyJTSy/Mg4h/n0vp7X1BoSAdg+OUT8nJmWWGG77mb00bqGVZn0CaxsE1RG6W
         0ZhQu0tkgW7TMw6R55RUKjwFScqxWXi+g1jkqdsUsccj44iPL37ko/cQnicgR8cVuxbX
         4xaPfyY1QjdeIVBONKL9MRF+cpuYGPwT0DwB96UQO6cKFxxDAAln7vHUr6GA2F9dEX+8
         gXf/5oW1G4+TLrAut3CNvHG6UTalVc1TmG5cM2CNvU2Odpxv842YxJGlLpAkQnFqhYlg
         HpkJIEEIBM3rO49XPaivKewtOCCJaEirC4rPSjsXIjJHfr/dYcChVuzK2+CLuAjI6Qor
         U6kg==
X-Gm-Message-State: AOAM533uxPuOTVPKDbEKHM9STMrtOhWALDBHZuqNRTqZkhoExIs3H/aK
        i4yZfjjo0aBFCMhpoFoAdrm3T9DUQCQmTHXBLio=
X-Google-Smtp-Source: ABdhPJxvOd/rxSkS3SDcGd9w+wE0DvS/xc0PNdUmaiTFNHEUuyjWv6xxiiqEmH/nJYu8Butm7Ja+zj20B5fpXzOLCLI=
X-Received: by 2002:a17:90a:220f:: with SMTP id c15mr2313884pje.129.1591221516321;
 Wed, 03 Jun 2020 14:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <CACG_h5qGEsyRBHj+O5nmwsHpi3rkVQd1hVMDnnauAmqqTa_pbg@mail.gmail.com>
 <CAHp75VdPcNOuV_JO4y3vSDmy7we3kiZL2kZQgFQYmwqb6x7NEQ@mail.gmail.com>
 <CACG_h5pDHCp_b=UJ7QZCEDqmJgUdPSaNLR+0sR1Bgc4eCbqEKw@mail.gmail.com>
 <CAHp75VfBe-LMiAi=E4Cy8OasmE8NdSqevp+dsZtTEOLwF-TgmA@mail.gmail.com>
 <CACG_h5p1UpLRoA+ubE4NTFQEvg-oT6TFmsLXXTAtBvzN9z3iPg@mail.gmail.com>
 <CAHp75Vdxa1_ANBLEOB6g25x3O0V5h3yjZve8qpz-xkisD3KTLg@mail.gmail.com>
 <20200531223716.GA20752@rikard> <20200601083330.GB1634618@smile.fi.intel.com>
 <20200602190136.GA913@rikard> <CAHp75VdUf8=y+y4Q3OtWc7owxg0uX8LhZY4Nrgnezuv+aSyzUg@mail.gmail.com>
 <20200603215314.GA916134@rikard>
In-Reply-To: <20200603215314.GA916134@rikard>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 4 Jun 2020 00:58:19 +0300
Message-ID: <CAHp75VeQ+3rRAs+5Tmn=Tj_jkdKff=crwX9S3bPGLO6iVQ8Kqg@mail.gmail.com>
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

On Thu, Jun 4, 2020 at 12:53 AM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
> On Wed, Jun 03, 2020 at 11:49:37AM +0300, Andy Shevchenko wrote:
> > On Tue, Jun 2, 2020 at 10:01 PM Rikard Falkeborn
> > <rikard.falkeborn@gmail.com> wrote:

...

> I'd be very surprised if compilers warned for explicit casts but  I'll
> send a proper patch soon to let the build robot try it.

I noticed that you should have received kbuild bot report about a
driver where it appears.

You patch broke all cases where (l) = 0 and (h) is type of unsigned
(not a const from compiler point of view).


-- 
With Best Regards,
Andy Shevchenko
