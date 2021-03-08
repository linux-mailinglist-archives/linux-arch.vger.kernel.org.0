Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6BC6331935
	for <lists+linux-arch@lfdr.de>; Mon,  8 Mar 2021 22:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhCHVRK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Mar 2021 16:17:10 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:38880 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhCHVQ5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Mar 2021 16:16:57 -0500
Received: by mail-io1-f53.google.com with SMTP id k2so11572605ioh.5;
        Mon, 08 Mar 2021 13:16:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wENDCdWaSuNo/9lFklZ0lZUQIRPa8gqGgWLSaGo2ihY=;
        b=g6+AaLvntMqexDPFcKpwGaDMZIPvSEm+x3DaYXZx0NDZGp61E/a15Hlv4vFz3k9jQH
         aDrBGhzZeRNHv29BaNDnBz1lNYZXbr9kvQnGz32KnZI57aWEis7hxOXrbKnpSgfTChVU
         07rLnmjtqwnCuOBez+C1uGOj7AuCt4wkGU0pAPLztFkiXVRGKlMqoJQFw7ACocl/O+D4
         nZ6TbdMa0/fCiCoHcN9X8ygWrgegKcytcS8mb13sEprvNUEt2h7sWoKKvJh2qA4VEtWL
         /GtHu77cBawea0UoF1RD4T+3NjFvW0fVM4Bt/4ov/hOK2oNkdLcWlTZNbDglZCh0JXVK
         pMyA==
X-Gm-Message-State: AOAM531VyuIa9W8vV58pgkFHAV34srtkYGlH87Gxfty5VwppI9Hq9UXe
        lWcthTRI2d4Q+0gmcKibkg==
X-Google-Smtp-Source: ABdhPJxM6BeOQdAzQkQ3yg2K05EvksZzTVIx2JLACJFRTq+Zv0djbKLPxzbB8aPacgz5KAoO9UbdNA==
X-Received: by 2002:a6b:e312:: with SMTP id u18mr20265529ioc.58.1615238216808;
        Mon, 08 Mar 2021 13:16:56 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id t9sm6728380iln.61.2021.03.08.13.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 13:16:56 -0800 (PST)
Received: (nullmailer pid 2970565 invoked by uid 1000);
        Mon, 08 Mar 2021 21:16:53 -0000
Date:   Mon, 8 Mar 2021 14:16:53 -0700
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        devicetree@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Graf <graf@amazon.com>, linux-doc@vger.kernel.org,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@kernel.org>, linux-serial@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Stan Skowronek <stan@corellium.com>
Subject: Re: [RFT PATCH v3 15/27] dt-bindings: interrupt-controller: Add DT
 bindings for apple-aic
Message-ID: <20210308211653.GA2970507@robh.at.kernel.org>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-16-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304213902.83903-16-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 05 Mar 2021 06:38:50 +0900, Hector Martin wrote:
> AIC is the Apple Interrupt Controller found on Apple ARM SoCs, such as
> the M1.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../interrupt-controller/apple,aic.yaml       | 88 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  .../interrupt-controller/apple-aic.h          | 15 ++++
>  3 files changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
>  create mode 100644 include/dt-bindings/interrupt-controller/apple-aic.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
