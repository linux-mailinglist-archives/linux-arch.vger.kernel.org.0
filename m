Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2EB3331942
	for <lists+linux-arch@lfdr.de>; Mon,  8 Mar 2021 22:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhCHVSt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Mar 2021 16:18:49 -0500
Received: from mail-il1-f174.google.com ([209.85.166.174]:39729 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhCHVSo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Mar 2021 16:18:44 -0500
Received: by mail-il1-f174.google.com with SMTP id d5so10210300iln.6;
        Mon, 08 Mar 2021 13:18:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uFKF7Ehal8qDNFKzZWjamQRwuD7KmoXBh34xqd+Th3c=;
        b=DYeGhNetYZOGjuhsIAIbW2FZMKOCf6eCI80xs6nFPfQdsi16+HRXnI+afr7pP6NQS5
         CD00xKj6c2zsi23mLn6eZCQtFbtiukDc4jldWeLyFJnPqbd0qDlwgXfP+qUdJbCYesJK
         46FrAY5jLL8aTPKO2au0ih3+13vnTIhKvQMV1BPWGspfSRuztL1TVmt/v4GIH1VcOz5H
         FkC0mxI34q3rr2wioB6BW/UHhMSuA3lVc3tAYizs9d00nU6RUE+Brj5PgAqr1tgJS1Hk
         /ORjvsVG/aGJ8F6PdXfAxcLzr4XiSpFU6xQqP2OZ3VAjGeGeT2WEHg8RhprebS6yILKA
         aO4A==
X-Gm-Message-State: AOAM533Slf6AgOQt9tvS6lkFoBJjmOYFCjKLlG0UHNNwdwI4QD6akfti
        0FT91jEqZ28VDE0SeXwUDg==
X-Google-Smtp-Source: ABdhPJxBOnxGY1CT6tf1GLE6+NPZR6ZqtVKILY/ZQTQhNtWjUOj8w6IHuDTiedg4e85U+B8ac9mjAA==
X-Received: by 2002:a92:b003:: with SMTP id x3mr23330447ilh.15.1615238323858;
        Mon, 08 Mar 2021 13:18:43 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id x6sm6495412ioh.19.2021.03.08.13.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 13:18:43 -0800 (PST)
Received: (nullmailer pid 2973128 invoked by uid 1000);
        Mon, 08 Mar 2021 21:18:40 -0000
Date:   Mon, 8 Mar 2021 14:18:40 -0700
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-samsung-soc@vger.kernel.org,
        Stan Skowronek <stan@corellium.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Alexander Graf <graf@amazon.com>, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFT PATCH v3 26/27] dt-bindings: display: Add
 apple,simple-framebuffer
Message-ID: <20210308211840.GA2973077@robh.at.kernel.org>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-27-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304213902.83903-27-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 05 Mar 2021 06:39:01 +0900, Hector Martin wrote:
> Apple SoCs run firmware that sets up a simplefb-compatible framebuffer
> for us. Add a compatible for it, and two missing supported formats.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../devicetree/bindings/display/simple-framebuffer.yaml      | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
