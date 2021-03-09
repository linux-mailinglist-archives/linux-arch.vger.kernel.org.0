Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD51332FE6
	for <lists+linux-arch@lfdr.de>; Tue,  9 Mar 2021 21:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhCIUag (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Mar 2021 15:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhCIUad (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Mar 2021 15:30:33 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83276C06174A;
        Tue,  9 Mar 2021 12:30:33 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id D16A73FA6A;
        Tue,  9 Mar 2021 20:29:54 +0000 (UTC)
Subject: Re: [RFT PATCH v3 10/27] docs: driver-api: device-io: Document
 ioremap() variants & access funcs
To:     Arnd Bergmann <arnd@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-11-marcan@marcan.st>
 <CACRpkdYeeUb6WUe_RBxBEjNnTJ9o55Z-8Ma7CLokFOdCtF0M+Q@mail.gmail.com>
 <CAHp75VfEshraJMUfmCNvMgm5yVRNLk-yDkbJ+6m6NuLV4tme7g@mail.gmail.com>
 <CAK8P3a20yXBktB_QqgqgSP69-PXnfs1AwNOf01v-DYFWktmRYQ@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <5eb23b42-5fda-0524-8666-0eb2c37b4ac1@marcan.st>
Date:   Wed, 10 Mar 2021 05:29:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a20yXBktB_QqgqgSP69-PXnfs1AwNOf01v-DYFWktmRYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 06/03/2021 00.51, Arnd Bergmann wrote:
> On Fri, Mar 5, 2021 at 4:09 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Fri, Mar 5, 2021 at 12:25 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>>> On Thu, Mar 4, 2021 at 10:40 PM Hector Martin <marcan@marcan.st> wrote:
>>>
>>>> This documents the newly introduced ioremap_np() along with all the
>>>> other common ioremap() variants, and some higher-level abstractions
>>>> available.
>>>>
>>>> Signed-off-by: Hector Martin <marcan@marcan.st>
>>>
>>> I like this, I just want one change:
>>>
>>> Put the common ioremap() on top in all paragraphs, so the norm
>>> comes before the exceptions.
>>>
>>> I.e. it is weird to mention ioremap_np() before mentioning ioremap().
>>
>> +1 here. That is what I have stumbled upon reading carefully.
> 
> In that case, the order should probably be:
> 
> ioremap
> ioremap_wc
> ioremap_wt
> ioremap_np
> ioremap_uc
> ioremap_cache
> 
> Going from most common to least common, rather than going from
> strongest to weakest.

Yeah, I was dwelling on the issue of ioremap_np being first when I wrote 
that... this alternative works for me, I'll sort it like this then. 
It'll just need some re-wording to make it all flow properly.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
