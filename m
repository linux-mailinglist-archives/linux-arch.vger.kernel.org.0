Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16FD331875
	for <lists+linux-arch@lfdr.de>; Mon,  8 Mar 2021 21:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhCHU0l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Mar 2021 15:26:41 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:44637 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhCHU0X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Mar 2021 15:26:23 -0500
Received: by mail-io1-f45.google.com with SMTP id 81so11377066iou.11;
        Mon, 08 Mar 2021 12:26:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6UTjJ3jOvKiCus9H3n1TcHEJKB0LVrltl+hAbPpXslY=;
        b=r8tw7LXpdXG1ZJ9JOm72egImX4nXFEu1u+nYI5Bz+sSxrLMFjzkTyN+mEVxhGARD6v
         GvLkKDrjd3FQPMdUpAiIQ/wyZtUFU6GR/mkHLRcgw/zEXuFmZCgiQQGMl+3nxSGSCYvn
         9deTBWFE1vnmstVzyPwmXDpsLlnrhZk5EENBIEe7MOgZvmgdOGvfQ1PWwlbua0H06jza
         Fh6EKEM4RDBJur1Ji/lYqZNdpNWtm1kQfwz79V0x2YSd+a4I8FbAVC3aLP6u2WOMb6/M
         gF8Q5CGYJuuZaMXoDMCLEAB0rn/dOtop5fm+khrk2hEd1oDwhlAujJf4h1/eXdAYwAHJ
         +fsA==
X-Gm-Message-State: AOAM532e9O+1hUyFtALIiAuDePU1KnrUxCK0IBS787wIXjNFW7aaYaDB
        cn+urJ20zw8TyLHo5YTZoQ==
X-Google-Smtp-Source: ABdhPJwOBTaPE0xKY0k0bCLQdONZXa85agktHmthvLzU6KA0D/iYjgFAJ9bn940AtIEul0SRUWlLAw==
X-Received: by 2002:a02:7086:: with SMTP id f128mr24916049jac.104.1615235182626;
        Mon, 08 Mar 2021 12:26:22 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id m4sm6704226ilc.53.2021.03.08.12.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 12:26:21 -0800 (PST)
Received: (nullmailer pid 2904189 invoked by uid 1000);
        Mon, 08 Mar 2021 20:26:19 -0000
Date:   Mon, 8 Mar 2021 13:26:19 -0700
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Alexander Graf <graf@amazon.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Olof Johansson <olof@lixom.net>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>
Subject: Re: [RFT PATCH v3 02/27] dt-bindings: vendor-prefixes: Add apple
 prefix
Message-ID: <20210308202619.GA2904129@robh.at.kernel.org>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-3-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304213902.83903-3-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 05 Mar 2021 06:38:37 +0900, Hector Martin wrote:
> This is different from the legacy AAPL prefix used on PPC, but
> consensus is that we prefer `apple` for these new platforms.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
