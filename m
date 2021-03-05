Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4560932EFE7
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 17:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhCEQUu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 11:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhCEQU1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Mar 2021 11:20:27 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF97C061574;
        Fri,  5 Mar 2021 08:20:26 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id e6so1714765pgk.5;
        Fri, 05 Mar 2021 08:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=boCa64fG4W3WCm+9ChyeoaRgwehVFUby8zC/hTUMZzg=;
        b=rsT6Tlua+ii43EVOburqG9qBUuJHjuPkPNCv0Ptl6LW18HtoODhBB1hk5pPRB2zh6l
         +rtRTJVVj+PhOJj3M4fprqkafaXE2Zzp9wGW2W7LQXMidfMnn+7gzWk4G4nKh/e7hHBb
         ImPc6LGoVP0rXhawxuvLVGmb7YSt5r+8Arwfye9RDD8mPtW7M9eXHoq5izrvWdn+IvHB
         8xGa8fjbfJ/EtbBVZ6n2vD5KXQ/h5uG1rYLJlecAZVD/dAKH1KGNhYf1WkOYiJoqA/oY
         EaCsl5ukGD/oO6Zt4rMZXindIRABsS03aLkXO/rwmi2pJd6ijjFBB8u83VMsSO/Mo4Mt
         AO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=boCa64fG4W3WCm+9ChyeoaRgwehVFUby8zC/hTUMZzg=;
        b=e6ksMEA408qL/5dBT9pie3pDtyIyRuQv6Y4udbIKd0qUdYsw1GcsIjZK75Sj4n8zrd
         Ko/cap+ki1Ko/nxuRUcJ3AnDwXKSCm92bnpHXSiAudcgo90L2+r70C3LbRYf1sSXZSvt
         WmsorV/0VXI6PYjajeBpA61SeeGv89lIxuNrmpmBH9zIkhyg5fq7ibR9tfIOdRQuocdV
         wg2eWS3+IkO6VmPlw8yQAOLnhgZPxuTx9daihlQfnLhfP9P0i2m0iJNF+kgbHA+qAU4B
         LZG3NVn5582LWRN/HIbcd9jh82Q+LLK/CXrDyo8Ftwl45a4s5slvOw9Ya7IvII/TZagp
         uZyQ==
X-Gm-Message-State: AOAM531NJ7TpD01ZEjbZcNW2ufHJ6uI8ZHdGcdwIPj9EiTKIK5BxIAiC
        sI7zIByskdq75dpZsYqH+lVVq0ra6DRIadfT/q8=
X-Google-Smtp-Source: ABdhPJzpHuRfbzgse9xN4Nrv93TTVGJQnTIeImSnTO4+//St56aPX2qy3MqZ0uLWkV9xTeaHtiU1CTzttx7xYN3fKrY=
X-Received: by 2002:a05:6a00:854:b029:1b7:6233:c5f with SMTP id
 q20-20020a056a000854b02901b762330c5fmr9709475pfk.73.1614961226373; Fri, 05
 Mar 2021 08:20:26 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-22-marcan@marcan.st>
 <CAHp75Vc+t9_FNHZ0xYNaJ1+Ny+FFeZKA79abxV2NAsZvpBh3Bg@mail.gmail.com> <535ff48e-160e-4ba4-23ac-54e478a2f3ee@marcan.st>
In-Reply-To: <535ff48e-160e-4ba4-23ac-54e478a2f3ee@marcan.st>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Mar 2021 18:20:10 +0200
Message-ID: <CAHp75Vd_kwdjbus3iq_39+p_xRk3rum2ek3nLLFbBDzMwggnKA@mail.gmail.com>
Subject: Re: [RFT PATCH v3 21/27] tty: serial: samsung_tty: IRQ rework
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 5, 2021 at 6:16 PM Hector Martin <marcan@marcan.st> wrote:
>
> On 06/03/2021 00.17, Andy Shevchenko wrote:
> > Add a separate change that removes flags from the spin lock in the IRQ handler.
>
> This commit should have no functional changes;

Exactly my point why I'm suggesting to have _separate_ change!

> I am just splitting an
> existing function into two, where one takes the lock and the other does
> the work. Do you mean using a different locking function? I'm not
> entirely sure what you're suggesting.

Yes, as a prerequisite

spin_lock_irqsave -> spin_lock().

-- 
With Best Regards,
Andy Shevchenko
