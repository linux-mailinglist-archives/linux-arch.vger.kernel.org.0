Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EE9355977
	for <lists+linux-arch@lfdr.de>; Tue,  6 Apr 2021 18:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346567AbhDFQoY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Apr 2021 12:44:24 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:43648 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346639AbhDFQoX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Apr 2021 12:44:23 -0400
Received: by mail-ot1-f47.google.com with SMTP id s16-20020a0568301490b02901b83efc84a0so6323179otq.10;
        Tue, 06 Apr 2021 09:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J7LDEpkiDm0rpoZGOM9wHiAh8YlcxbABWbtB5AZtmNQ=;
        b=iQ9Rn5crP80Nw9zAd+fq7Av3AOFaOwCJWIVZq9Zu+CV0xeCnsHXYbQtPl8ogBHUo+T
         MzV0rM+Rh65yzXXJxGMgpSO4OIaU3FhaJEUvw5U3+oQGatpbkszwX0IB1tJ7VCduDdVc
         V7ZQJpw6bJPAszidSyqnrWI/09RF3N0JXeryAu5//9E8/vbSJsjtmBl7E94YO6INlFNs
         pO8xV08MUIstzdTDJKRAUpgEFXOKNKnBnEAyQwfMqDDMgOBMewIRv4q+MCiy1akaNYvD
         oCFJx1tDuv6y8j51rgeOHlSvy4jasQTQ8DwKdYUoYZOb5CeVTxwvA5emCDmtqv83zMwL
         22Wg==
X-Gm-Message-State: AOAM5307cLRNbAbAj7hfexok6fwgd7DMs3pfdng7T8cFajzZdCrou7VG
        taisOQQVELGvpyxHHrSLIQ==
X-Google-Smtp-Source: ABdhPJyzH3K+JW6PxOMQBF7pXPPswHPc4y4NUqvPYmuOnBQCmnCYxptwHsxdLe7sADX/O6h3SkpM1w==
X-Received: by 2002:a05:6830:17d2:: with SMTP id p18mr27319477ota.161.1617727453272;
        Tue, 06 Apr 2021 09:44:13 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g61sm4724597otb.65.2021.04.06.09.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 09:44:12 -0700 (PDT)
Received: (nullmailer pid 1937608 invoked by uid 1000);
        Tue, 06 Apr 2021 16:44:11 -0000
Date:   Tue, 6 Apr 2021 11:44:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Alexander Graf <graf@amazon.com>, Olof Johansson <olof@lixom.net>,
        Stan Skowronek <stan@corellium.com>,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@kernel.org>, Will Deacon <will@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        linux-doc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v4 05/18] dt-bindings: timer: arm,arch_timer: Add
 interrupt-names support
Message-ID: <20210406164411.GA1937531@robh.at.kernel.org>
References: <20210402090542.131194-1-marcan@marcan.st>
 <20210402090542.131194-6-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402090542.131194-6-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 02 Apr 2021 18:05:29 +0900, Hector Martin wrote:
> Not all platforms provide the same set of timers/interrupts, and Linux
> only needs one (plus kvm/guest ones); some platforms are working around
> this by using dummy fake interrupts. Implementing interrupt-names allows
> the devicetree to specify an arbitrary set of available interrupts, so
> the timer code can pick the right one.
> 
> This also adds the hyp-virt timer/interrupt, which was previously not
> expressed in the fixed 4-interrupt form.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Marc Zyngier <maz@kernel.org>
> Reviewed-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../bindings/timer/arm,arch_timer.yaml        | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
