Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DFC3559D8
	for <lists+linux-arch@lfdr.de>; Tue,  6 Apr 2021 18:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346704AbhDFQ7n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Apr 2021 12:59:43 -0400
Received: from marcansoft.com ([212.63.210.85]:40464 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232131AbhDFQ7m (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Apr 2021 12:59:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 142E3419B4;
        Tue,  6 Apr 2021 16:59:24 +0000 (UTC)
Subject: Re: [PATCH v4 12/18] of/address: Add infrastructure to declare MMIO
 as non-posted
To:     Rob Herring <robh@kernel.org>
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
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210402090542.131194-1-marcan@marcan.st>
 <20210402090542.131194-13-marcan@marcan.st>
 <20210406164748.GA1937719@robh.at.kernel.org>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <b97eff12-5ace-8f93-99f3-2e391a5492ca@marcan.st>
Date:   Wed, 7 Apr 2021 01:59:22 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210406164748.GA1937719@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 07/04/2021 01.47, Rob Herring wrote:
>> +EXPORT_SYMBOL_GPL(of_mmio_is_nonposted);
> 
> Is this needed outside of of/address.c? If not, please make it static
> and don't export.

Ah, yes, that was cargo culted from of_dma_is_coherent. Not sure how I 
missed that it's obviously unnecessary. Thanks for pointing it out.

> 
> With that,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks!

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
