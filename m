Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8204A5F35D1
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 20:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJCSra (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 14:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiJCSr3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 14:47:29 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E2D4317E
        for <linux-arch@vger.kernel.org>; Mon,  3 Oct 2022 11:47:27 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y8so15827928edc.10
        for <linux-arch@vger.kernel.org>; Mon, 03 Oct 2022 11:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=M385r7adQFP2eJtYDCJbx5h+dCbHhqD1X387se0QADM=;
        b=CwuXfWTQtGBI+ETWvrJJg/XCJL1CuB9zIHoM7dxASoTS9jlc+jKMFINn+BEXIBID5D
         wS3GpKZ1rlLmy4u8btcISk1/TjgjmjZ+ezSc7v6WoJcEapfwLw8IzdAhR1U6q/vr9WZc
         I9w4nvXpkuxXxuLLZhgVdjyTL8iU+cgsw0jNHuSShk2jIoBLF7aoZwofUnsbOrnqDjFq
         oF8cpKazfVDBmpusVajY10W4Q7t7aFBDSHi85//zExevfkIFngCGsajVxTX3206GP/ac
         V2fRkUxcsmdMbjiAIbSygG+Ia/0VvUDuhSBYqtikAjHXHdwiY7i5kePM1BsGCduRQH7V
         A0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=M385r7adQFP2eJtYDCJbx5h+dCbHhqD1X387se0QADM=;
        b=FAI0pMUJi9KcGo8M1sVWgq7HFnfUYd97yula5RNROXkspN0CsexoJmvItL4Fz0T6zm
         FK4fhNHpGmO6f3/fNFp+3TpcCS17Vw+kOsBd06n9FOdJArLdBAv+0gg6aN1XMqPs1eQ1
         KrUJscVcG+J7SuGUyTDG1pzV6nYHVwuJpCnXQo2KBVZdBOeaPrsQrGy59cBvy3xRg/TK
         EC6LRFNyWA1hNPMNtpv9Y9IKK3ADL79cG3GgThzIatY7MwYeyt/GX+3bJMVmJ6XqxccO
         +1ZgnCxcrAqX42AwQcsU1hL+v930VV2SBfC2DigfMVJbgeotFh6515QcBZtwWLA4ExlU
         aryA==
X-Gm-Message-State: ACrzQf3L3V9fK1+A11YGO9hIh3QjJNFJYhBAggQ3Hw1JL+oWZXRXWNPo
        0u1cynaPbObrmz9UFZ3PZX8WuklwqbM/089WSqeJUA==
X-Google-Smtp-Source: AMsMyM5SZrnZEq2okaiVJbe1WXEshFPS3yyh2MmrFHx0ymSl0yjjkPKoaSxnK1XXqqx3Z4DrkZh4dp2oc2bttaHLBzE=
X-Received: by 2002:a05:6402:190f:b0:452:d6ba:a150 with SMTP id
 e15-20020a056402190f00b00452d6baa150mr19698528edz.126.1664822842838; Mon, 03
 Oct 2022 11:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221003121316.2540339-1-linus.walleij@linaro.org> <49e40308-969f-4b22-a8b5-d7f07e50b8ef@app.fastmail.com>
In-Reply-To: <49e40308-969f-4b22-a8b5-d7f07e50b8ef@app.fastmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 3 Oct 2022 20:47:11 +0200
Message-ID: <CACRpkdYHcTPNLj_GBjKh2Xex1rKQDZTLwppHAEjhhouPqdivtw@mail.gmail.com>
Subject: Re: [PATCH] alpha: Fix ioread64/iowrite64 helpers
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Linux-Arch <linux-arch@vger.kernel.org>
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

On Mon, Oct 3, 2022 at 3:05 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Oct 3, 2022, at 2:13 PM, Linus Walleij wrote:
> > When doing allmod builds it turns out some modules are using
> > ioread64() and iowrite64() that the alpha does not implement,
> > as it is using <asm-generic/iomap.h> without selecting
> > GENERIC_IOMAP.
> >
> > Fix this by implementing the ioread64()/iowrite64() stubs
> > as well, using readq() and writeq() respectively.
> >
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Fixes: 7e772dad9913 ("alpha: Use generic <asm-generic/io.h>")
> > Link: https://lore.kernel.org/linux-arch/20221002224521.GA968453@roeck-us.net/
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Richard Henderson <richard.henderson@linaro.org>
> > Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> > Cc: Matt Turner <mattst88@gmail.com>
> > Cc: linux-arch@vger.kernel.org
> > Cc: linux-alpha@vger.kernel.org
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > Arnd if this looks OK then please apply it on linux-arch
> > for fixes.
> > --
>
> It looks like we just crossed patches. I also sent a fix a minute
> ago, but I think mine is better here because it also works on
> I/O ports.

Hey! :D
Take your patch instead.

Yours,
Linus Walleij
