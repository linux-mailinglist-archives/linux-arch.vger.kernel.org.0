Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB2B330062
	for <lists+linux-arch@lfdr.de>; Sun,  7 Mar 2021 12:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhCGLgd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 7 Mar 2021 06:36:33 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49514 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhCGLgQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 7 Mar 2021 06:36:16 -0500
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lIrgX-0001pN-Do
        for linux-arch@vger.kernel.org; Sun, 07 Mar 2021 11:34:57 +0000
Received: by mail-ed1-f70.google.com with SMTP id p12so3570300edw.9
        for <linux-arch@vger.kernel.org>; Sun, 07 Mar 2021 03:34:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Op5mu56rLKVeXZ5BYHLLFs3XBf2gdeKehd8++u/6LDA=;
        b=T4ady93jdXXzZu02QOkck01Xur8MdpL/Klwc632MJaZxWinqv1gs2O3bbKzcHYcCx0
         Y1jsNKtljkn4enJm7HSE9ovUqc2+6Ky4wNFGvyQQUNIWJXQ3su75GS7u5hrZnBibDxCY
         oiySNTWiSRuz+Kky5wrUtWKC93xW+0GIhNqLWE37jLlmWFe7o9vOCsMKAcg4q5kxyS76
         cDodDHcqk36pp1ubXhEoi1rhtVGhCc4F0aQnI4dmKIz1qbYQl4ye9Wxj8wU8v3pL6E/N
         z7bEjvsP6QcZ1Q+RagHPql6lW/04Z+n69rb85sjo5y/ZWey0oaVCYeSlFIjFIfObsURK
         p+UA==
X-Gm-Message-State: AOAM533EmT5ZqIBwn/aZFM7N2mFh8YlCvzsysL1x4xtLlA04q+DuPjXx
        pWGCmrXnsjqVCpREHMaQ9V2YvBd1ryXvzobLShFYByHsgAKE207P6k5fH/fCtdnqRZ3tsQ0XaM6
        TYgq/aGCIMvtbJiKa6K9hFWy2Uu5l8bf3gYwkmVo=
X-Received: by 2002:a50:fa04:: with SMTP id b4mr17812442edq.293.1615116896806;
        Sun, 07 Mar 2021 03:34:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwN50SNAvRJvyv1TTGSoHps9ZM3d2RwZosjPBjKJrezHq2PpQu4f0MDG5tTUROmsW8Jne4o4A==
X-Received: by 2002:a50:fa04:: with SMTP id b4mr17812435edq.293.1615116896694;
        Sun, 07 Mar 2021 03:34:56 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id g25sm5016167edp.95.2021.03.07.03.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Mar 2021 03:34:56 -0800 (PST)
Subject: Re: [RFT PATCH v3 21/27] tty: serial: samsung_tty: IRQ rework
To:     Hector Martin <marcan@marcan.st>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-22-marcan@marcan.st>
 <CAHp75Vc+t9_FNHZ0xYNaJ1+Ny+FFeZKA79abxV2NAsZvpBh3Bg@mail.gmail.com>
 <535ff48e-160e-4ba4-23ac-54e478a2f3ee@marcan.st>
 <CAHp75Vd_kwdjbus3iq_39+p_xRk3rum2ek3nLLFbBDzMwggnKA@mail.gmail.com>
 <05ccc09f-ffea-71cd-4288-beed3020bd45@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <d33fffec-28bd-99b2-a8b1-cc83b628e4b3@canonical.com>
Date:   Sun, 7 Mar 2021 12:34:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <05ccc09f-ffea-71cd-4288-beed3020bd45@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 05/03/2021 17:29, Hector Martin wrote:
> On 06/03/2021 01.20, Andy Shevchenko wrote:
>>> I am just splitting an
>>> existing function into two, where one takes the lock and the other does
>>> the work. Do you mean using a different locking function? I'm not
>>> entirely sure what you're suggesting.
>>
>> Yes, as a prerequisite
>>
>> spin_lock_irqsave -> spin_lock().
> 
> Krzysztof, is this something you want in this series? I was trying to 
> avoid logic changes to the non-Apple paths.

I don't quite get the need for such change (the code will be still
called in interrupt handler, right?), but assuming the "why?" is
properly documented, it can be a separate patch here.

Best regards,
Krzysztof
