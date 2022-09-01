Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988475A961C
	for <lists+linux-arch@lfdr.de>; Thu,  1 Sep 2022 13:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbiIAL5H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Sep 2022 07:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiIAL5G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Sep 2022 07:57:06 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20768956B4
        for <linux-arch@vger.kernel.org>; Thu,  1 Sep 2022 04:57:04 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id y3so34182602ejc.1
        for <linux-arch@vger.kernel.org>; Thu, 01 Sep 2022 04:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qON8ghVdHvW8iEwJ3G0VkdEgH/I5ucZT6RhYDlXmnDk=;
        b=vnOQ4xJiSPUTLNVVw/GUqRHX2vkz8mz1iiKBmWIturj/6IYvXS8/xqOFxBiFUHW4D1
         N6Jlrk/HcE1BPP62TqjN4FI1dVP1sKdwTwibR4HUyXpvxfpR856gcmNkvUXFjlAbEKB8
         5wfSxuI8tAVyiEu+9eQv4UBXkYJvzQ9NCT0WPm5Hie0qX2ttlBvSDcuWZxQ0B2yBR1CW
         44QB4shhadnvDS23YroeNeGvs/+9fQ9jtZUia9fgPdciBizhR92Unw7M9MdhYHRyb13h
         0BM1nIuhQYcO7YydrG4XCoSzVdcHy2BGKJvrmRy68fsQGBZtnW7dDxo4BRgffJMggRbR
         S9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qON8ghVdHvW8iEwJ3G0VkdEgH/I5ucZT6RhYDlXmnDk=;
        b=ftpwx7p0Dsgm9Ed4wz4HYD2vNBdwN4MFUFXIKN2WJmnBsG+KP13lMrh5P2d4fIEz+Q
         h5XLJB2QsJeRhoNYURwDtCHeAt8NEigIW3i1hvwtrBM+nJg6D5bWhfhJNNlZj7QgY4jU
         oREsrqeIThLpAw3vAVnEu8Op9oKyFgO4Jv28XQh+xgTv2v2Vv7mlXorpKrf7ryER0tJ4
         N1gIujFf63QL8DKH5rDPf6wW7fBweOwx54RbnfvQA7j0ByG/4HuPyJFQ66a27WUtSRzT
         JiGIlUsVufhTPPGEyJTT7OEl2NZ3fZNooawd0Sxs3KV9WnYIlmhiDRbq0SP8bpCfQNdI
         z/cA==
X-Gm-Message-State: ACgBeo2v6K3N8WQFfM+JWnyYmKZ7oS40mClvwuDa4ITmLBHoESffrbVI
        FcY5Pm39ljEFKNmkcgf6JQExithnP8g1aN0u2ileuQ==
X-Google-Smtp-Source: AA6agR6d7Woawz6HoNHWWzfQEAlkANmnOOKCA8P31cQAmr5Ud1hwNmPDHHQVvrgDvwRaG4viQiinS+xFbTuFmBS5cCQ=
X-Received: by 2002:a17:907:1c89:b0:741:4453:75be with SMTP id
 nb9-20020a1709071c8900b00741445375bemr17577998ejc.208.1662033422650; Thu, 01
 Sep 2022 04:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220831214447.273178-1-linus.walleij@linaro.org> <5b1f418e-3705-4093-9a13-3fe7793ed520@www.fastmail.com>
In-Reply-To: <5b1f418e-3705-4093-9a13-3fe7793ed520@www.fastmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 1 Sep 2022 13:56:50 +0200
Message-ID: <CACRpkdapZCrhQjFfGM_mU2+kUTBO6tpDUAY5k7sDRZUNWAKnVg@mail.gmail.com>
Subject: Re: [PATCH] parisc: Use the generic IO helpers
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
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

On Thu, Sep 1, 2022 at 9:35 AM Arnd Bergmann <arnd@arndb.de> wrote:

> >  #include <asm-generic/iomap.h>
> > +/* These get provided from <asm-generic/iomap.h> */
> > +#define ioport_map ioport_map
> > +#define ioport_unmap ioport_unmap
> > +#define ioread8 ioread8
> > +#define ioread16 ioread16
> > +#define ioread32 ioread32
> > +#define ioread16be ioread16be
> > +#define ioread32be ioread32be
> > +#define iowrite8 iowrite8
> > +#define iowrite16 iowrite16
> > +#define iowrite32 iowrite32
> > +#define iowrite16be iowrite16be
> > +#define iowrite32be iowrite32be
> > +#define ioread8_rep ioread8_rep
> > +#define ioread16_rep ioread16_rep
> > +#define ioread32_rep ioread32_rep
> > +#define iowrite8_rep iowrite8_rep
> > +#define iowrite16_rep iowrite16_rep
> > +#define iowrite32_rep iowrite32_rep
>
> You should not need these overrides here, since the
> definitions in asm-generic/io.h are only relevant
> for the !CONFIG_GENERIC_IOMAP case, i.e. architectures
> that can access port I/O through MMIO rather than
> special helper functions or instructions.

parisc does not select GENERIC_IOMAP.

Are you saying that it should?

That seems like an invasive change to me...

Fixed the rest and resending.

Yours,
Linus Walleij
