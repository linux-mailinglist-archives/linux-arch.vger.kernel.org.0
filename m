Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108D63318B7
	for <lists+linux-arch@lfdr.de>; Mon,  8 Mar 2021 21:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhCHUjF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Mar 2021 15:39:05 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:45658 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhCHUir (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Mar 2021 15:38:47 -0500
Received: by mail-io1-f53.google.com with SMTP id a7so11406204iok.12;
        Mon, 08 Mar 2021 12:38:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9lLfeCs1Tc8ddEaiXHzDtmEpQP9gGHowCs7DuxfnmRE=;
        b=V49zdQtIBvLb6HwUxPEQD22SVJN5av5W81Q9px9ylJFglJV6RRwil7zSg4hHTkWO0S
         oznzqb2kTi6QWySFgrLqot3EDays8lTCq1gusJOXGm5TjcKi/76IHpML1L/sw+8n05bq
         P1ZQQKtpRy8aIY375TXOx6n5fR0sAqPGbSryKCJIjyF/NeTBjqab54o2SciARXOxeVWT
         2uLJyz8bg9fBqm93dsw0D53y3KtxVx+srr+XxBlOdKHTjdG/Cv10jkBLLLsidibAlwey
         ngw6vRjin6R65JbAfdlyP0HSiXPMHk6gosC+jBRUtRhfJqzibSDrzlrLcOzFJQqa6PuN
         2n6w==
X-Gm-Message-State: AOAM532eOZ+p4EpVEYatuiCq2X/WpB5ejqUzgRn6C1CRMp0JO59P4jta
        9iARogE+ffYNHBHQ6tFzZQ==
X-Google-Smtp-Source: ABdhPJz6/b0HXPf5UbrLJ8rHp/ABrKIy46sXafa7ZkfydealL7GIC6LpxZTvxSGmls2DzSoW84uFgw==
X-Received: by 2002:a02:cc1a:: with SMTP id n26mr25539390jap.21.1615235926457;
        Mon, 08 Mar 2021 12:38:46 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id h128sm6553100ioa.32.2021.03.08.12.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 12:38:45 -0800 (PST)
Received: (nullmailer pid 2920550 invoked by uid 1000);
        Mon, 08 Mar 2021 20:38:41 -0000
Date:   Mon, 8 Mar 2021 13:38:41 -0700
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
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
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH v3 06/27] dt-bindings: timer: arm,arch_timer: Add
 interrupt-names support
Message-ID: <20210308203841.GA2906683@robh.at.kernel.org>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-7-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304213902.83903-7-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 05, 2021 at 06:38:41AM +0900, Hector Martin wrote:
> Not all platforms provide the same set of timers/interrupts, and Linux
> only needs one (plus kvm/guest ones); some platforms are working around
> this by using dummy fake interrupts. Implementing interrupt-names allows
> the devicetree to specify an arbitrary set of available interrupts, so
> the timer code can pick the right one.
> 
> This also adds the hyp-virt timer/interrupt, which was previously not
> expressed in the fixed 4-interrupt form.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../devicetree/bindings/timer/arm,arch_timer.yaml  | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
> index 2c75105c1398..ebe9b0bebe41 100644
> --- a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
> +++ b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
> @@ -34,11 +34,25 @@ properties:
>                - arm,armv8-timer
>  
>    interrupts:
> +    minItems: 1
> +    maxItems: 5
>      items:
>        - description: secure timer irq
>        - description: non-secure timer irq
>        - description: virtual timer irq
>        - description: hypervisor timer irq
> +      - description: hypervisor virtual timer irq
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 5
> +    items:
> +      enum:
> +        - phys-secure
> +        - phys
> +        - virt
> +        - hyp-phys
> +        - hyp-virt

phys-secure and hyp-phys is not very consistent. secure-phys or sec-phys 
instead?

This allows any order which is not ideal (unfortunately json-schema 
doesn't have a way to define order with optional entries in the middle). 
How many possible combinations are there which make sense? If that's a 
reasonable number, I'd rather see them listed out.

Rob
