Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1522A91DA
	for <lists+linux-arch@lfdr.de>; Fri,  6 Nov 2020 09:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbgKFI5i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 03:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgKFI5i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Nov 2020 03:57:38 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B2AC0613CF
        for <linux-arch@vger.kernel.org>; Fri,  6 Nov 2020 00:57:37 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id v144so819569lfa.13
        for <linux-arch@vger.kernel.org>; Fri, 06 Nov 2020 00:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rDbRRGn34zXTBJ75beQCb48hBrXPldiexvEsZ0HXAgw=;
        b=vPAj/NPMq+kZPDTqhNOlXhs13YOHtQWsU/BGtoxbD//dfTm6r07YObI4TBsQA36J8D
         vWGT2aFa2VLD69eizZmhrXhmsOiedzgIYcJPRSjN0ylCXly3pSBuofkVg21AoGTwthvu
         F1igEwb4uHkJf70qaHHLSpBCrsfpHj/xd/7wDUw+bsCj7X+RIXp8TP9zvABnyBn9sGQ/
         g99Zb2pkOEqa7tTsSC1Ep3yaegCxOI89uVZ1wrbA+ZBlKlpIshnOpZvkRArZQWgTZCJi
         T0wt8j3DU2C1DUZQzVdB34f30qubk/SPdguieuUx36aU+tz6Wa7R1ccvXzOls35MGDv4
         x1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rDbRRGn34zXTBJ75beQCb48hBrXPldiexvEsZ0HXAgw=;
        b=mKiA9UQuZodIW5Y5mlmT7epDA2bh+P7p2aDaUWZ9p3gFqlCgUW1hrxBgwYGUOHPWnF
         Au5hAZ7Yq1oU9KWN0yBaDWq5wVXoUnUn8wyqEcWg8D7UvbxFOVR9F6J3wmw1FcLFAscL
         cb1gpm3eGD5D+KYoTJd73qcWncnAKmBZfE5KACRYaj3iV/fwpR+xOorMB50ykywANjWH
         zX3T8REuEzbzPX4fVy4H6GH+XbrAUKZHskSTJnKNO4/mVVFNu7+0YS8H8oIiPesTcRYB
         NJ8EgNc1O3rXs/7bW4EegZGcxndr7LJQmsoKSdTzO3pBWJ6uW/rcC4co9UT+0yWWly/q
         wdWw==
X-Gm-Message-State: AOAM531cGnoWrLASQrGKHNafIXsEAHZ/u8V22GILlttdMxxhjUZjngwO
        iQPFnhZAgpqdcLZHWIyxTVae1RjFe/lS75cgQr8EWQ==
X-Google-Smtp-Source: ABdhPJyiBvhbwjuNJtxtQFv0OEV20PHDsdlVuc7QPzzJby5XvH2n9z2dVzk2KL3kyldL3uqTaJSzoDbAIoAoMmJp8K0=
X-Received: by 2002:ac2:50c1:: with SMTP id h1mr451651lfm.333.1604653056413;
 Fri, 06 Nov 2020 00:57:36 -0800 (PST)
MIME-Version: 1.0
References: <20201030154519.1245983-1-arnd@kernel.org> <20201030154919.1246645-1-arnd@kernel.org>
In-Reply-To: <20201030154919.1246645-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 6 Nov 2020 09:57:25 +0100
Message-ID: <CACRpkdYxJPdy4UY929V5oAXkwx_wxsszxk+iz_C+es5VBVGFbA@mail.gmail.com>
Subject: Re: [PATCH 1/9] mm/maccess: fix unaligned copy_{from,to}_kernel_nofault
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 30, 2020 at 4:49 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> On machines such as ARMv5 that trap unaligned accesses, these
> two functions can be slow when each access needs to be emulated,
> or they might not work at all.
>
> Change them so that each loop is only used when both the src
> and dst pointers are naturally aligned.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
