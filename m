Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA5E331883
	for <lists+linux-arch@lfdr.de>; Mon,  8 Mar 2021 21:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCHU1q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Mar 2021 15:27:46 -0500
Received: from mail-il1-f176.google.com ([209.85.166.176]:39655 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhCHU1e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Mar 2021 15:27:34 -0500
Received: by mail-il1-f176.google.com with SMTP id d5so10077523iln.6;
        Mon, 08 Mar 2021 12:27:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/GM8CBHRElPJRP7PZysMpqCFpogNoxjGu0HwECydzbU=;
        b=Sg6RpGnmpjV55SFUymvTXwOugZYITDywQCrRqi3GgudFvNx94dsmviSsCO+WKwvS0O
         6aSOSCq/u8/w0eGKcHLA4RiotdpONyYHy4zi47Ib/W9G3SOZuQvyr9Vj4lA5KBSS7zM7
         BA1d4jUmXRuk2Z7wfreWUa3B2gqujIiu3vxSgAa6+rvOj/SLPoi8ujN6IL699SrNbroy
         IhYkf7/dBFlEtigMCF8gNHBIXMga5K+i8+QnYRZBsPah7goU4Xl6ASKXOltWExp33jVs
         qxQlbqRVXc7oip84na54wIhCcdFbX06nTaoXNQc2RA/RmNfWW5n33xHEFErIvWmVx9SZ
         DbhA==
X-Gm-Message-State: AOAM5307ZQKyzTbHRU4j5fFOuoO/peryx2bqMC722KgAVC7Ms/4HTcMQ
        X/DiAOq2JZuMJZ4Jik3YXg==
X-Google-Smtp-Source: ABdhPJyikPugSPe3ApaD9ZSRIxAAqiFeV57n2qsdvnfy5DlaAgPiUQtG668fCuDraC3YI7+B01Weiw==
X-Received: by 2002:a92:b08:: with SMTP id b8mr21998138ilf.13.1615235253505;
        Mon, 08 Mar 2021 12:27:33 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id y20sm6430010ioy.10.2021.03.08.12.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 12:27:32 -0800 (PST)
Received: (nullmailer pid 2905848 invoked by uid 1000);
        Mon, 08 Mar 2021 20:27:29 -0000
Date:   Mon, 8 Mar 2021 13:27:29 -0700
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-serial@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-samsung-soc@vger.kernel.org, linux-doc@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Graf <graf@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stan Skowronek <stan@corellium.com>,
        Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>
Subject: Re: [RFT PATCH v3 03/27] dt-bindings: arm: apple: Add bindings for
 Apple ARM platforms
Message-ID: <20210308202729.GA2905797@robh.at.kernel.org>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-4-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304213902.83903-4-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 05 Mar 2021 06:38:38 +0900, Hector Martin wrote:
> This introduces bindings for all three 2020 Apple M1 devices:
> 
> * apple,j274 - Mac mini (M1, 2020)
> * apple,j293 - MacBook Pro (13-inch, M1, 2020)
> * apple,j313 - MacBook Air (M1, 2020)
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../devicetree/bindings/arm/apple.yaml        | 64 +++++++++++++++++++
>  MAINTAINERS                                   | 10 +++
>  2 files changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/apple.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
