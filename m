Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F1F67CAEE
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 13:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237115AbjAZM3u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 07:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235934AbjAZM3t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 07:29:49 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2731F4DCFC
        for <linux-arch@vger.kernel.org>; Thu, 26 Jan 2023 04:29:36 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id t16so1766806ybk.2
        for <linux-arch@vger.kernel.org>; Thu, 26 Jan 2023 04:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vnNmJePGJCbbDvROAft9ZF6gM7UoLWWa+rvqMySAcK4=;
        b=JXeZAZxiBPxXxy94PEdiDOse+N42yw5hsyKv4EBERO3mpUdLAwxHkR/WKve8vcAIea
         MzAJK4s9sMUMF9MIHgurYeYpVBFAe2RMx1qW33nPoLRkKXKpW6QXVZYxCy8YKAQKo5hQ
         HAEXrG6gnR6oOKnXwEnpaQkJtUCS0DJ3/bBftrFptQ1CjlmJiM6UdoXztMX7mDqOPm5A
         fL6mHxSa9SNUUP+R1VQ+quU8ROtyL942Qc7GrKREW0Yqd5LfLat9Dx6eQS6fTF4qzQy/
         G25cGP6wkB0rhrUw9U49exAu4m6yml6pb/7PIZjuhUCzAUy1mAqGQBkSMEj3AZojOvoA
         lEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vnNmJePGJCbbDvROAft9ZF6gM7UoLWWa+rvqMySAcK4=;
        b=KjXoWxK2OaDjYDPPnHW2UTC5as+nACG67c21N8waWsP71X9uvxPDUbQJcxMZxquoUo
         IkzDlK05mn4BfqROmXpMuBsk/cnXek+x1eRJJGkVB/Ic03yuwK7rfWEt0aY//DvQFqI2
         dq1BEKeiM2z0WUJ4fjBMk2zxooEJdtaYAYflcDTPTcCx6F9Ag2zh2XA2AOCSLL14FUZk
         kVLm0v71i2gqrMBzBNXtLkDusk4nePoLRXOr9sWfKCc1ctl1FFloaUBvpN46lajlysVy
         5tHCGwQTq6j6Bri8qAUBZ0SxnLTPzaWDSo5epKwn7jVY3xXPYk17Ao5JT/onF0qlQDeT
         JFWg==
X-Gm-Message-State: AO0yUKVOo3cRbGmkfGXyG9jnaXgqXv5w75QkRk8qULPLjZ8Ndl++xjnr
        nQRLtS4blVRdBkoEMeMytDy+xDoEF3+1h7pbKY1iyA==
X-Google-Smtp-Source: AK7set/R1E3VulrFeCGTfBUtG8LxoXpuG58zhcJcdYW89tvuRbDaG2arAuK+pVQHU2FmAebKaJrwFgd0AEKp7UOlw4c=
X-Received: by 2002:a25:d1d1:0:b0:80b:4d84:b25 with SMTP id
 i200-20020a25d1d1000000b0080b4d840b25mr992515ybg.584.1674736175266; Thu, 26
 Jan 2023 04:29:35 -0800 (PST)
MIME-Version: 1.0
References: <20230125201020.10948-1-andriy.shevchenko@linux.intel.com>
 <20230125201020.10948-6-andriy.shevchenko@linux.intel.com>
 <CACRpkdZ1g9BEb28-YzAU8V5geiYzT9drjT3EMxok70ex3fOCKA@mail.gmail.com> <Y9JvCQSi3DB/6un3@smile.fi.intel.com>
In-Reply-To: <Y9JvCQSi3DB/6un3@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Jan 2023 13:29:23 +0100
Message-ID: <CACRpkdbMhuW50L6SX1ct4OYOJtcFHD2G1BhqG6_3EMc8gfexQA@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] gpio: Clean up headers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 26, 2023 at 1:16 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> > Just to add to the confusion I was also pursuing a series of cleanups directed
> > at just removing <linux/gpio/driver.h> from <linux/gpio.h>:
> > https://lore.kernel.org/linux-gpio/CACRpkdb6yMqTkrJOg+K46RZ1478-gbxh6=tw4bzWmd--5nj_Bw@mail.gmail.com/
> >
> > Right now I don't know what to do :D
>
> I saw your series and find them very good!
> Can we have them applied?

I see that they will cause conflicts (patching files deleted in the
big board removal)
so I don't want to push them for the moment. I will send them out again though.

Yours,
Linus Walleij
