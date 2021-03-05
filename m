Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A7132E637
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 11:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhCEKXX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 05:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhCEKXD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Mar 2021 05:23:03 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F70C061762
        for <linux-arch@vger.kernel.org>; Fri,  5 Mar 2021 02:23:02 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id q25so2710299lfc.8
        for <linux-arch@vger.kernel.org>; Fri, 05 Mar 2021 02:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LfHQxtXLpgHzWWehAxy54rgqvbReyYhSet51OAulNz0=;
        b=kD6/l/0Vi2BEoQPUIUTVfySLU+oGOH8dhaVp52y9xqPK9vrBGwOXrYPqAdVsioaq7Q
         BSVl0SrF2rmu7/8jAVon7ihnGEcn1/xFoZERo0vcXrkf23f2qRZ3HXS5Mj9uOvek+Cdu
         TzxpO49nda2QldHAqLTx7lZ38Vwou2bm+b276mzMWUNqeyqT/F6ZuHInNRj3pp6VaVJF
         Hb0KdVNazzZiWHllpGCCXqyTs/i7KImP3DmYD9uOvCawQxqaWjw7S8a8D9F7wSpS9oU+
         Mk2IXHel6lwAq2blqHQayb642ZFEC+pJQpyAsFDWWhbf5xNWING9veK8vpg+s+EXiYUA
         oAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LfHQxtXLpgHzWWehAxy54rgqvbReyYhSet51OAulNz0=;
        b=LjHV0vpU/CVWsndZ7dOha3dIAuW4X0ZaSBR2JRY6l34Y7isXH9XFbHVus0SNHtjgPc
         JLFPSvKI5F09Ufi9Mv9OngQmT9DvQzff9P4OHa497n0Z+rXVRe06TWTpf3dzK89M9p25
         o/CPr9FOJA+TZAUwvTHYknxE0fiM3d3axyJFywxNOVFB60M3Bgbla80VI5Fq5LpMpICo
         O+DAoBgDMpxBJLZ6Apnvhtgzk71YYvGdZRRldjleioNW+VJOjMjWx3aQM0Y5I+6kRELg
         uralOk9UfHdnY50VqfCCh9RCMo9iZxh0TiCOWuTH23GeVVE5NLHX5PzLXyvmvT5YfvUh
         e2hQ==
X-Gm-Message-State: AOAM530XocpDObSsSbKG8eYPxj/6EImYNay8IgUfuWRV/apWfs2V0dcO
        9kerzRNAr+aBNw48qD8/Rmrzh6A+S3lVJo/zlsss8w==
X-Google-Smtp-Source: ABdhPJx+i531/mdEEsILHSu2PXPp+jA1Jld7y10Dq0JMoPYIdD19rJgXaEDARwuiGdh9W28fAuFk1UFedpx77+cLayM=
X-Received: by 2002:a05:6512:243:: with SMTP id b3mr1467597lfo.529.1614939780828;
 Fri, 05 Mar 2021 02:23:00 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-10-marcan@marcan.st>
In-Reply-To: <20210304213902.83903-10-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 5 Mar 2021 11:22:49 +0100
Message-ID: <CACRpkdZ7S=9nSZ9EknYVRAdY7-teHWXjZ6CRB6UGOnALV0UgXg@mail.gmail.com>
Subject: Re: [RFT PATCH v3 09/27] docs: driver-api: device-io: Document I/O
 access functions
To:     Hector Martin <marcan@marcan.st>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
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
        Andy Shevchenko <andy.shevchenko@gmail.com>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 4, 2021 at 10:40 PM Hector Martin <marcan@marcan.st> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> This adds more detailed descriptions of the various read/write
> primitives available for use with I/O memory/ports.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Excellent work!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
