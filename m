Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF855B428C
	for <lists+linux-arch@lfdr.de>; Sat, 10 Sep 2022 00:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiIIWiM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Sep 2022 18:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiIIWiL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Sep 2022 18:38:11 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E85F653B
        for <linux-arch@vger.kernel.org>; Fri,  9 Sep 2022 15:38:10 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y3so7359153ejc.1
        for <linux-arch@vger.kernel.org>; Fri, 09 Sep 2022 15:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6EP33BV0TfYyrJ4fchWrKDHolm4FaPueLJRrBAEVrQA=;
        b=mF8soULIR5HkFy2HYmmOB5pV37C0M47XE/NO9cqyQ9GpeXvRfebtkka60MfwBdyCn3
         OmF3RehNNncQgpXWYcls9NQqI6DM7vPeSFpKrvyyEiIvh+9nEECyItbg7A9EOkmp9SDa
         AxbS6xUrBYBej2XRQEJRMKAZxGXQ4BM0TU+oGoUaVoG2/CEBH7ZQGECAahZA+g8Gw/OS
         Qm87MLMqzHUkrqBzUVYKAkGtZMQD74Q2lLZUpXHElFgQ5tLK+ymE68fB7uZkIW6MpvUq
         mN63UelOQ2S5cTlcGW4v0Hxy4iFypW/V5gQGqwRa9CYcmUbX/MOY0zNbc8//lWhFMYJl
         ADuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6EP33BV0TfYyrJ4fchWrKDHolm4FaPueLJRrBAEVrQA=;
        b=gdALgUQSPDIkUyyhH8Rid1OuOMYk3hPXGrAjjx6m5PjQ6YvTtZxsNgfl1GuoCaYGZv
         LSLHMQD5wv/5WznUDk3FINs5HDnaDUxXxBzBDyAIOh8JBvd03oKCQGlx8ZRQeRPer44/
         jjaobhUn5llaGru78jmjrqLYT3Lqo7yb71f2Eje3GKj127MR8Bojn5sXzUAZiw3Zi9wo
         5VU8TN60IwgTGw059Ax3LsWYiuI0ZElLyT3EgV2AhBTERZqHLQfK2kdhHZnyLptFR2fU
         tkY8FVZNv8qiOyV8K0Td6TgJxYmNyc0Uj8i7xXG7NsvusA3RLiWNh1leEMfM319paVl0
         MIJw==
X-Gm-Message-State: ACgBeo0O9Gbj618S3nDLuzGKgg88NsBpDUW7Deaz61b4w0/1OSBN935Z
        PTeuZUEupJk7DwHLopI1i0r2WZ3DW4z12BCgTK0bkA==
X-Google-Smtp-Source: AA6agR6P4BoSeY4HaOaQdooaMJA8lOFm8HE7hrotOZ2+nY/um0tPfO0ujoUkJImQAz4m6NPSaqOKqZf9/fJAHrYsdGg=
X-Received: by 2002:a17:907:7242:b0:741:770b:dfc6 with SMTP id
 ds2-20020a170907724200b00741770bdfc6mr11427201ejc.203.1662763089099; Fri, 09
 Sep 2022 15:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220903224526.553897-1-linus.walleij@linaro.org> <eded16ee-b9c9-4830-a75c-685056e56b56@www.fastmail.com>
In-Reply-To: <eded16ee-b9c9-4830-a75c-685056e56b56@www.fastmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 10 Sep 2022 00:37:57 +0200
Message-ID: <CACRpkdaV0CQGeLgqCCw6gEY4yBHEe0uS3eE5hkf-OJOBxQynYQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 v4] parisc: Remove 64bit access on 32bit machines
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        John David Anglin <dave.anglin@bell.net>
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

On Sun, Sep 4, 2022 at 10:11 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Sun, Sep 4, 2022, at 12:45 AM, Linus Walleij wrote:
> > The parisc was using some readq/writeq accessors without special
> > considerations as to what will happen on 32bit CPUs if you do
> > this. Maybe we have been lucky that it "just worked" on 32bit
> > due to the compiler behaviour, or the code paths were never
> > executed.
> >
> > Fix the two offending code sites like this:
> >
> > arch/parisc/lib/iomap.c:
> >
> > - Put ifdefs around the 64bit accessors and make sure
> >   that ioread64, ioread64be, iowrite64 and iowrite64be
> >   are not available on 32bit builds.
> >
> > - Also fold in a bug fix where 64bit access was by
> >   mistake using 32bit writel() accessors rather
> >   than 64bit writeq().
> >
> > drivers/parisc/sba_iommu.c:
> >
> > - Access any 64bit registers using _lo_hi-semantics by way
> >   of the readq and writeq operations provided by
> >   <linux/io-64-nonatomic-lo-hi.h>
> >
> > Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
> > Cc: Helge Deller <deller@gmx.de>
> > Cc: linux-parisc@vger.kernel.org
> > Cc: linux-arch@vger.kernel.org
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: John David Anglin <dave.anglin@bell.net>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd,

it seems quiet around parisc, maybe you could apply these two to
the arch tree as well?

Yours,
Linus Walleij
