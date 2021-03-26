Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BC734A2BD
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 08:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhCZHyr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Mar 2021 03:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhCZHyg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Mar 2021 03:54:36 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E391C0613AA;
        Fri, 26 Mar 2021 00:54:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id B111341982;
        Fri, 26 Mar 2021 07:54:26 +0000 (UTC)
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
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
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-2-marcan@marcan.st>
 <20210324180546.GA13181@willie-the-truck> <875z1gs4oj.wl-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [RFT PATCH v3 01/27] arm64: Cope with CPUs stuck in VHE mode
Message-ID: <badbec31-0ddc-aae4-78cd-de3b6c3fef83@marcan.st>
Date:   Fri, 26 Mar 2021 16:54:24 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <875z1gs4oj.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 25/03/2021 05.00, Marc Zyngier wrote:
> I've come up with this on top of the original patch, spitting a
> warning when the right conditions are met. It's pretty ugly, but hey,
> so is the HW this runs on.

[...]

Folded into v4 and tested; works fine with `kvm-arm.mode=nvhe`, throwing 
the ugly WARN.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
