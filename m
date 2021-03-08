Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DCD331888
	for <lists+linux-arch@lfdr.de>; Mon,  8 Mar 2021 21:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhCHU2T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Mar 2021 15:28:19 -0500
Received: from mail-io1-f52.google.com ([209.85.166.52]:40863 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhCHU2C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Mar 2021 15:28:02 -0500
Received: by mail-io1-f52.google.com with SMTP id i8so11404466iog.7;
        Mon, 08 Mar 2021 12:28:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OuzoORNmqZtsOkt7vmwS9GqTt+Ss3WOMR27yr37P6IM=;
        b=dgh9qJOwBWmnvfwp8ASTfmUb82OmHiLtoUJPWIS7THutHq9chMD+abJ3kHgl67Puh7
         76V9LcXAqijHd7wFOlpmlWEKTBQuJa8xWteZE9yW8F+0fjJJcnQlWBS6/lCkxWk7Ud3t
         RnhI+J8OvlXPmJD/ym6wTtdyfh6sL9VLAYmWAQH8WEmpK3GOhy+ZWGgHjW3Atz3VEoAk
         OpjlxsheKwg1DcC9do1c1mWyYinJWh9eFZkU4fy7I5h59Oq8w0xSRNSHiuSxmX1HZMy1
         UsusUHSCyNYXDrAuuAfJQKJ35i1SC0GNJX9FGBkXeKnb6eEvPtb6gsBqn8VpeoIThT8a
         UpuQ==
X-Gm-Message-State: AOAM532IISl/fvwZ8dsOO6YeQOn0u71e9uS+HuznLopY0Qaipi9IoUmF
        eVFtjmhhLADO1PU/cJ7/LA==
X-Google-Smtp-Source: ABdhPJw5MwLkDkCL03lFNIcctDzRYwnOHt5adfnH+RXQ/w1AnumdlukRVJP7z73Qdwcx3+sl0tRYkg==
X-Received: by 2002:a6b:7112:: with SMTP id q18mr19755311iog.174.1615235281614;
        Mon, 08 Mar 2021 12:28:01 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id o7sm6622647ilj.67.2021.03.08.12.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 12:28:00 -0800 (PST)
Received: (nullmailer pid 2906533 invoked by uid 1000);
        Mon, 08 Mar 2021 20:27:57 -0000
Date:   Mon, 8 Mar 2021 13:27:57 -0700
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Alexander Graf <graf@amazon.com>, Arnd Bergmann <arnd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-serial@vger.kernel.org,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Will Deacon <will@kernel.org>, linux-doc@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-arch@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Olof Johansson <olof@lixom.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stan Skowronek <stan@corellium.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH v3 04/27] dt-bindings: arm: cpus: Add apple,firestorm
 & icestorm compatibles
Message-ID: <20210308202757.GA2906486@robh.at.kernel.org>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-5-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304213902.83903-5-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 05 Mar 2021 06:38:39 +0900, Hector Martin wrote:
> These are the CPU cores in the "Apple Silicon" M1 SoC.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
