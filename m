Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3971532EDFB
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 16:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhCEPJu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 10:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhCEPJq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Mar 2021 10:09:46 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDF7C061574;
        Fri,  5 Mar 2021 07:09:46 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id m6so2383155pfk.1;
        Fri, 05 Mar 2021 07:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GuLO/+4m3J3HNZ6Nqmidrx/MzLvW8cjxmYnlEV0BLSs=;
        b=bGLEzA9wG5flnyheuqIHYHjgopFpkciFW7I9BLIJEpEj5jUttovqa3OVTRArTF2JlV
         B5TxtCMh3eDxI3QNDotufjRHCgQBFaxzbZL97RhfNYkVbopRKmfIwWTI5tnUWhbwjeej
         7JR7GSo7lCKKMl20WVu7LnRRKmq5Gxfqb67i6x1JCUDO7HJbG0hvKn4p3GLDJ47q8lJh
         plEuncX5p7GJx7tPik/s1NV+4PQtTz9Rnc/cvqxjNnpACiuEbPhsPkNnf0VdIKEREYx4
         ZZER9nSN5ruDkzung8fmyvZqP7Pw/ELUolXlIVLlE5YlaWRE7qizRmzVj5jcYt2yYXEU
         s5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GuLO/+4m3J3HNZ6Nqmidrx/MzLvW8cjxmYnlEV0BLSs=;
        b=qJ5v1Bi/ZY15GUszvjpO29iNY20S6Epim4eGbPlyzUWQ0mLRNIu7cQ0OK2Gq4ix00n
         FZnEHgq+/uNQLBZtb8YAVCbpGa7JhDYJ1XY1k9MQMKaDHgf+hhcuG657aQytlg0hxhyN
         b8x3Cz1+wF/O+HVv+zZMecOVbQpU0h0uZdIRBvUA5bn06wbi1UWDvN+TUXmlgID5VIFh
         cj4d+rQLQciYktjgvX7Pw4Wrzv5yKvPTPPMonTOaBHP4OGx8FpnM/zssyynsS0GwvQum
         yicvQwhVX3UBWfZs1N6F2WNto2qE8huEKxlzNAQy0tW5VfvMwYCTA4YCrFQbsm7J9CFZ
         M4zg==
X-Gm-Message-State: AOAM532Asv/aGN9t36ImXG3wy5KFEUxeOcYLRi+98NCTpSVkJ+ZiKZ5q
        8HpRjtAK37XWutIy1tpAAIc/T/jemGIC8DrscKc=
X-Google-Smtp-Source: ABdhPJySuiVQahfMZKNqzRL9pGTI02zcrDNpr1zvr+iLwhqslvWh769rqoPHBLjJOe9LpOWTi5Y8qTC7TP4RxZffevQ=
X-Received: by 2002:a05:6a00:854:b029:1b7:6233:c5f with SMTP id
 q20-20020a056a000854b02901b762330c5fmr9424227pfk.73.1614956985483; Fri, 05
 Mar 2021 07:09:45 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-11-marcan@marcan.st>
 <CACRpkdYeeUb6WUe_RBxBEjNnTJ9o55Z-8Ma7CLokFOdCtF0M+Q@mail.gmail.com>
In-Reply-To: <CACRpkdYeeUb6WUe_RBxBEjNnTJ9o55Z-8Ma7CLokFOdCtF0M+Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Mar 2021 17:09:29 +0200
Message-ID: <CAHp75VfEshraJMUfmCNvMgm5yVRNLk-yDkbJ+6m6NuLV4tme7g@mail.gmail.com>
Subject: Re: [RFT PATCH v3 10/27] docs: driver-api: device-io: Document
 ioremap() variants & access funcs
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Hector Martin <marcan@marcan.st>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
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
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 5, 2021 at 12:25 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Mar 4, 2021 at 10:40 PM Hector Martin <marcan@marcan.st> wrote:
>
> > This documents the newly introduced ioremap_np() along with all the
> > other common ioremap() variants, and some higher-level abstractions
> > available.
> >
> > Signed-off-by: Hector Martin <marcan@marcan.st>
>
> I like this, I just want one change:
>
> Put the common ioremap() on top in all paragraphs, so the norm
> comes before the exceptions.
>
> I.e. it is weird to mention ioremap_np() before mentioning ioremap().

+1 here. That is what I have stumbled upon reading carefully.

-- 
With Best Regards,
Andy Shevchenko
