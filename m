Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777B8356D46
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 15:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241490AbhDGN2K (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 09:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbhDGN2J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 09:28:09 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095A9C061756;
        Wed,  7 Apr 2021 06:27:59 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id ay2so9343905plb.3;
        Wed, 07 Apr 2021 06:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gPk0txwiQH41tkl6+Ko80XOzDT7sy08dTJ8kEynQ9CU=;
        b=nYAHgMcQiiw77htOI1QpiWyBzhidrkQ6G/F/MbfbkXN0dZFZb6ZYWfuCB6iIcTiWs9
         0uSxShhivoJZAh/okUk5qPjVNXwLoDH45RCT8tIfW1A9H0Bw6mV/AjcMSuLTjUe5KTs5
         2FcILVsdH7wuD2/e7xivF2L1ril9u3T07mqi6iCGlZR7dOV7uKt8mEMReWpjFAt/IxBD
         zx17dyOY9Pyttf13SAnQ8z3gOJy5NmiAUoad8owKvkWaVxq2oYmQMf5vUHdyJzcBoIhV
         6nC56N3ajJkJZQ7hDNIlI2YRfcVHgmPnuv/anFMd+M0g09QYzZkiKT16hXM4vlZPX0eC
         dCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gPk0txwiQH41tkl6+Ko80XOzDT7sy08dTJ8kEynQ9CU=;
        b=W2H+Sld3oNqySvkL4CJKLijSzSUv3zPlpWB3kw31lAl4dNilJPoj74gljMUkY4haBy
         DjnAosmN7fgfPNNXxy+yqUwMDB/deZ3nLl3fqwrI3sMV+sslnwv46FS34kqkumEMvCDE
         rbVeyyoVBr0duzdCrRo4xQOK/PNc2FNVI99iA/PlmRRF68/JxU19Ke69NF+eDUGpTGV5
         9XuDydKbtidhAZ96XL8vDNPr48bqX3mf1kSey6MHJX2GR1uDW29jfNw3pRu141jZEAnF
         lfm+Nb/3WP8r63fT1n43W2rXiRamOnv67Jrkmwd5vw237qw/fh+QAghmlVXN6KkTODhN
         5C+g==
X-Gm-Message-State: AOAM530rRlLbj33qCQ353P1gsRbCB+yFcqPwdAa+fBX9rTaq4U26bpQv
        TMBSrH1iNvn8KkVbV3IYoQ7c+ebISqxPYVt26mg=
X-Google-Smtp-Source: ABdhPJxINTgdzGxgxpyx7J3bDDMYfqiVzgSvvr9cLG3u0qIDaQdOp29ZfGUSOS2zQVfphaDqdijzJ2sm00mrrmGaTqM=
X-Received: by 2002:a17:90a:5407:: with SMTP id z7mr3379125pjh.228.1617802078532;
 Wed, 07 Apr 2021 06:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210402090542.131194-1-marcan@marcan.st> <20210402090542.131194-12-marcan@marcan.st>
In-Reply-To: <20210402090542.131194-12-marcan@marcan.st>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Apr 2021 16:27:42 +0300
Message-ID: <CAHp75Vcghw6=05vbhX5J8sHoo78JMoq5z4w9__XcocrtRVjF3g@mail.gmail.com>
Subject: Re: [PATCH v4 11/18] asm-generic/io.h: implement pci_remap_cfgspace
 using ioremap_np
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
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
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 2, 2021 at 12:07 PM Hector Martin <marcan@marcan.st> wrote:
>
> Now that we have ioremap_np(), we can make pci_remap_cfgspace() default
> to it, falling back to ioremap() on platforms where it is not available.
>
> Remove the arm64 implementation, since that is now redundant. Future
> cleanups should be able to do the same for other arches, and eventually
> make the generic pci_remap_cfgspace() unconditional.

...

> +       void __iomem *ret = ioremap_np(offset, size);
> +
> +       if (!ret)
> +               ret = ioremap(offset, size);
> +
> +       return ret;

Usually negative conditions are worse for cognitive functions of human beings.
(On top of that some patterns are applied)

I would rewrite above as

void __iomem *ret;

ret = ioremap_np(offset, size);
if (ret)
  return ret;

return ioremap(offset, size);

-- 
With Best Regards,
Andy Shevchenko
