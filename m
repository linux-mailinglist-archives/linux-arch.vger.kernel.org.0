Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A593F1F1424
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jun 2020 10:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgFHIIn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Jun 2020 04:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgFHIIn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jun 2020 04:08:43 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6550C08C5C3;
        Mon,  8 Jun 2020 01:08:42 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r18so2126134pgk.11;
        Mon, 08 Jun 2020 01:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EjQrNI7zMF5Y0xzLknVc46R0yFUGyl7fiVcSOqERa14=;
        b=RZZDUD00YwOtVNwzgGPCI+e7H3TDtuuQGuEK8G7YYt41keF2lpqb1wi+//816DbHjM
         Rdp7YBRxsCNrkgl9OHYTWy2xzCXAK/s71sZI1nFAXkPUb5Y/kUT8D2IAVbucBlwE9CHk
         4wuGm4YHzCKqzKAKBhEBptOwXOTYbLsVirrJQyUmOYBB4vhrcsxIJjJ2nBeEIgiQ+YQt
         uxLk0+8SMAW2UpQ859oLONzv2VsYK1t6GgZl1L9i5rEPtfBi6DehEFhUgZ1vcFg0CMly
         Ii6MZ0P1yNMq+S33WLeAv1UOZC4Vnf2QQUV2a6Qcqer+RLXToqXiS7ZBrVGvBK9gFL7r
         Ujag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EjQrNI7zMF5Y0xzLknVc46R0yFUGyl7fiVcSOqERa14=;
        b=Tvnv0qHgoPCMdhDBSw+rRlCZC1Y2j/BTyTWJuMRDdeLXfcuobRJ0a7xN3ux5UpJbyE
         yt+9fJshGK7bsxakq8PobRULyKoLtwpsBnycrhru9VM7SOWnJNqRJLH1ZwxGF+8AIgPg
         bxqOKsCoLc7m5xz1iObYSs0qXOdzkMDmB4JH3NVQffriJu9MmPqeU5nPatXbXyH3oFhD
         OyKxSZNuKu0jJ+UAYgH/4CGv4ohYmG/S5FO4aq7O0JVJqzWLkyeGuFi47OqKyWPjMz23
         Mr8n1vxb3vh/6FRNmvnUDI5Xt830E8Hsr4w9jAqHavJV5wDZDF08yfCZvFYp/12e3Lep
         Y7Mw==
X-Gm-Message-State: AOAM5308jx16h3mNA0IVuqwXgN1QJHVpejHDnMYQ05XVLaaS/YVuOmz9
        AACyvjaahIk4uj4FhV2FzWVERGj2oTuZ3C47AV913711+Ms=
X-Google-Smtp-Source: ABdhPJwKRWTwRX0pDGMW4ExqWawPbvKubDRxnRbyrCcddZ7gu9m6CQYK9vaCREIITOf/cY90yJ7yKPGRrWsSLwITUAc=
X-Received: by 2002:a63:545a:: with SMTP id e26mr18979915pgm.4.1591603722451;
 Mon, 08 Jun 2020 01:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200604233003.GA102768@rikard> <20200607203411.70913-1-rikard.falkeborn@gmail.com>
 <20200607203411.70913-2-rikard.falkeborn@gmail.com> <CAHp75Vd94PKFSYNQ6h+ju40TwtPvLpi5gt0kCec=SJJOcM3GYQ@mail.gmail.com>
In-Reply-To: <CAHp75Vd94PKFSYNQ6h+ju40TwtPvLpi5gt0kCec=SJJOcM3GYQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Jun 2020 11:08:30 +0300
Message-ID: <CAHp75Vf7ToQFS8dGNJ8FaXa8qpJa-82iHJ2s3VZdzWrBCf5=1A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] bits: Add tests of GENMASK
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 8, 2020 at 11:08 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sun, Jun 7, 2020 at 11:34 PM Rikard Falkeborn
> <rikard.falkeborn@gmail.com> wrote:
> >
> > Add tests of GENMASK and GENMASK_ULL.
> >
> > A few test cases that should fail compilation are provided under ifdef.
> >
>
> Thank you very much!
>
> > * New patch. First time I wrote a KUnittest so may be room for
> >   improvements...
>
> Have you considered to unify them with existing test_bitops.h?

test_bitops.c, of course.

-- 
With Best Regards,
Andy Shevchenko
