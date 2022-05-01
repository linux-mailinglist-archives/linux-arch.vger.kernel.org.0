Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019B8516872
	for <lists+linux-arch@lfdr.de>; Sun,  1 May 2022 23:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376454AbiEAV7L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 May 2022 17:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355443AbiEAV7K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 1 May 2022 17:59:10 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163CA2DD7F
        for <linux-arch@vger.kernel.org>; Sun,  1 May 2022 14:55:43 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id e12so23289357ybc.11
        for <linux-arch@vger.kernel.org>; Sun, 01 May 2022 14:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7rmKOmP5MkmzB6kYwqydPOY8Y/8AVOpHSwETVjiHA9I=;
        b=WAyuZryKlUvTJ6kmm5uy/jwqa15kiwrjusdIJ5eDuY3LzFArwiFBHppsGeFl93dGUA
         aRFZM3OGRe9/1ZsfBAGsNrxtq9VIqDWOo4wYESFLFR0W3DPEm0C8ARYo3KzTKrBTkijw
         r9Ri8TPuCaeRW63/lCZyBKuHyXD3oxSXHsAVra2RElgjum4GrMmy4OjAN3XpyQWy8TaO
         yhLZRuBdNh8ocwUvZOb/5JKSEUzIjBzxE7DFL06GDxVfT8sWPk2RvudjrEDKInmr1+w3
         5mOCiOp/5riekUqXbLCnRgTzfgjOdBAs7UcD7j5V28WNlgR84z+jAMc7M2oX2RI1uoY9
         cX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7rmKOmP5MkmzB6kYwqydPOY8Y/8AVOpHSwETVjiHA9I=;
        b=rFvzRoo/W8pTOJ9jtPCug8kBd6DR5lUPFfv0ILwLCZ6WTTs+flvbLu0QhyND6mUiTL
         85ii5H/w8KEAa6bJkjVNoEw4O1Jt+wM5uOfTTvz5C/fCOTc+l5qFTgyVpPKW6VsGhuNJ
         iyX0CoPqTfXmjkMDdUmXSdID2fJ6LxKy/oI/dGW8mzFcbTjKKYXCXpw67OYdGonDu9cC
         oiCP6tNIVwagCVJo2qcxjvtXMESwQuhiGsr9IGKTMw1zSXEMFKvlsj1GIPeC/LYZa4el
         kxrcJtMLo5YXQaiNe9E/rqnEzFg1ro2C1aSYMmIQZvJeN46ROZDX8AP7RK08xaxKQAbU
         rFNw==
X-Gm-Message-State: AOAM533f1oLwGsGuktKqKTBlq1Ka7ek5f4OnwRRYhow0RvBMA7/CiNyg
        k2gr6KW/SyD2ic5532yJOuKmZYvOSSYRIpljB+SULw==
X-Google-Smtp-Source: ABdhPJxqR+wj7vzqumSDiGlciHIivrD/WScHz6GVJNOR1rgSzhxVA4VDvKDovYr4a2IaCgbibVBmgNfiIylUorU7RJY=
X-Received: by 2002:a25:e684:0:b0:645:d429:78e9 with SMTP id
 d126-20020a25e684000000b00645d42978e9mr8676157ybh.369.1651442142362; Sun, 01
 May 2022 14:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
 <20220429135108.2781579-19-schnelle@linux.ibm.com> <Ymv3DnS1vPMY8QIg@fedora>
 <f006229ae056d4cdcf57fc5722a695ad4c257182.camel@linux.ibm.com> <YmwGLrh4U+pVJo0m@fedora>
In-Reply-To: <YmwGLrh4U+pVJo0m@fedora>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 1 May 2022 23:55:31 +0200
Message-ID: <CACRpkdaha37y-ZNSqYSbf=TvsJNcvbH1Y=N0JkVCewB-Lvf81Q@mail.gmail.com>
Subject: Re: [RFC v2 10/39] gpio: add HAS_IOPORT dependencies
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
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

On Fri, Apr 29, 2022 at 5:37 PM William Breathitt Gray
<william.gray@linaro.org> wrote:
> On Fri, Apr 29, 2022 at 04:46:00PM +0200, Niklas Schnelle wrote:

> > Good question. As far as I can see most (all?) of these have "select
> > ISA_BUS_API" which is "def_bool ISA". Now "config ISA" seems to
> > currently be repeated in architectures and doesn't have an explicit
> > HAS_IOPORT dependency (it maybe should have one). But it does only make
> > sense on architectures with HAS_IOPORT set.
>
> There is such a thing as ISA DMA, but you'll still need to initialize
> the device via the IO Port bus first, so perhaps setting HAS_IOPORT for
> "config ISA" is the right thing to do: all ISA devices are expected to
> communicate in some way via ioport.

Adding that dependency seems like the right solution to me.

Yours,
Linus Walleij
