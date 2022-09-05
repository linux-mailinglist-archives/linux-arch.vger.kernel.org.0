Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF36B5AD9A4
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 21:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiIETbE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 15:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiIETbD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 15:31:03 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F59326D7
        for <linux-arch@vger.kernel.org>; Mon,  5 Sep 2022 12:30:59 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id cu2so18956394ejb.0
        for <linux-arch@vger.kernel.org>; Mon, 05 Sep 2022 12:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fOjvm1AMsZ4nR0oKVwuUuwq6yRIdBGx8cQ5CH0pdOQ8=;
        b=mEBD5Ir8YMB4+1XemGmtRKWBA4PgrHa65B5dZBHw+q9qZY/fFLZAzWJtnnjt3ZabJ1
         k030tzzoAkffYwspwGcjthTDzsdHLi1/EfD5ZrIKQ81gBWJ+iFLi0rB47a8BoHQ1u+Mc
         ONLy2GkBHoKxccBbjIM3ToQDSmBmmUQCVAkJSWv4nkokAx3LqfcZUkbkUWgZc7Unaeoa
         poaOdJs1SSKb8ToZvDtPGjWuP8kkxkwRsMcwiWGeOPNcTEVrtAFYZn6SemA6NMADQmZJ
         +g5EZ+4ms2uJrfpHxIDKT7OlQqfQPnrzMLafL9vYFw9mXzLhNWt3cXdzgwgZ5MvcFakY
         AzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fOjvm1AMsZ4nR0oKVwuUuwq6yRIdBGx8cQ5CH0pdOQ8=;
        b=bViERVCW3Smmm7MhXNgwJscxGB+rHTYxSw/Z5yTRR/im1LjthFHt76X8yrTYTQv9ba
         XZo05arEe5KpAQRbdwRor335kOuwpBiZO71Oq7BIOGk/mPqoH4tPUxj9gyzG76bdmNUD
         OlKuFtqn8cIgX/CmD8P/BDHwXCk5vIrUxRIu0umUa3lcXxTK3UOfNIasOD+ruuNFLGo6
         i/Ts5Mx3Ne5pc1V9ab4EufPB8t4sOwHT+2Bc75Kjc+oXG18m+EA37dDd6ZHLosKpASFq
         zV8uYhTAaaMcSA6cIiXHqqGjXuc7HBLku4McZcKMLa7IkywSH2KIHXu68iteHMtsEwio
         /NKQ==
X-Gm-Message-State: ACgBeo2lIUSTny7HoztDCKIwk+dTM/h6lcissg7Z9FVDv4UC5qr0iGXX
        zFZ0AXKwcgSG1gryCo7Atul33ESPmR/xggj/Qwv5lw==
X-Google-Smtp-Source: AA6agR4Hc8cmwlWYtsQVcBEtvqR9R/KjlMAyZkpasBU28NpCQnSRS0A9I4kDiDihauw8ABGqaibWdQYAFxDk2F4buDw=
X-Received: by 2002:a17:906:cc5a:b0:741:5240:d91a with SMTP id
 mm26-20020a170906cc5a00b007415240d91amr30519881ejb.500.1662406258147; Mon, 05
 Sep 2022 12:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220818092059.103884-1-linus.walleij@linaro.org> <CAK8P3a1x52F8Ya3ShQ+v6x_jANfUsEq0E55u+pOBNaYniRO7cA@mail.gmail.com>
In-Reply-To: <CAK8P3a1x52F8Ya3ShQ+v6x_jANfUsEq0E55u+pOBNaYniRO7cA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Sep 2022 21:30:47 +0200
Message-ID: <CACRpkdZemHScp9WW-7LaGtcXuvT2qzs_7nXS60icSWtPkEwMHg@mail.gmail.com>
Subject: Re: [PATCH] alpha: Use generic <asm-generic/io.h>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Mark Brown <broonie@kernel.org>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

On Thu, Aug 18, 2022 at 12:28 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Aug 18, 2022 at 11:20 AM Linus Walleij <linus.walleij@linaro.org> wrote:

> > I'd like this applied to the alpha tree if there is such a
> > thing otherwise maybe Arnd can apply it to the arch generic
> > tree?
>
> Sure, I can do that.

Could you apply this to the arch tree? I see no signs of life from
the alpha maintainers.

> > +/*
> > + * These defines are necessary to use the generic io.h for filling in
> > + * the missing parts of the API contract. This is because the platform
> > + * uses (inline) functions rather than defines and the generic helper
> > + * fills in the undefined.
> > + */
> > +#define virt_to_phys virt_to_phys
> > +#define phys_to_virt phys_to_virt
> > +#define memset_io memset_io
> > +#define memcpy_fromio memcpy_fromio
>
> We tend to have these next to the function definition rather than
> in a single place. Again, I'm not too worried here, just if you end
> up reworking the patch in some form, or doing the same for the
> other architectures that would be the way to do it.

I looked into this, for parisc it was pretty straight forward. alpha has
a bunch of competing static inlines and externs and what not, I don't
see it helping to inline this, IMO it's actually better like this: "those
were defined somewhere in the birdnest of ifdefs above".

If it is a big issue I can start to pry into it.

Yours,
Linus Walleij
