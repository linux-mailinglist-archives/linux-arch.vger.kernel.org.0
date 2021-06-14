Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC403A6BD5
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jun 2021 18:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbhFNQdj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Jun 2021 12:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbhFNQdi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Jun 2021 12:33:38 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C257C061574;
        Mon, 14 Jun 2021 09:31:35 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id nd37so9941436ejc.3;
        Mon, 14 Jun 2021 09:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zlmxi2wCgt9WhbtdmvFXQwYxxvsh3PG6DG0dZOeCj8M=;
        b=oYEjwtSw1ps8mtrR4cJTl6qYja4hUIlPpys5trsCq74B+IRJcUtSedDyvxzUrqoLh3
         FM88Sjtn4wnILy4IKzv3XlCKVnKIRHfY2uFkvTXBpdak58ISgbzhIhOS4Yu2YVULKAJg
         l3dwAb0CeRU3GkiqtsrvCKYKBTeOo3Kx1SC/2HCyKmUmCzRMv5o9zOaBwlWWYO5tTfej
         /hsTtqtmD9tS8Kq1yMwRpBwv0ckkb9vtedPUugM/RHm5xS/N4Rof4lbNlq0xP/YBRCIR
         qZvJgrmJSg6gGVQk7jqVJZ3Q4bAM71hhZx3hcKIx/CFIgf/1iur2bVfOjeTcjNV2xU/2
         8/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zlmxi2wCgt9WhbtdmvFXQwYxxvsh3PG6DG0dZOeCj8M=;
        b=WxMKRZFzoURoiwVysG7gHe1mLGf+xjF1bRC4SxYxasrqYA54CiwBCyxiWvErl9IcH1
         NvkqoG6vEa2SSRwhXQDQcLfd7CJ+Hm5ii5lP5JmZdS1BawBv5C9XpnHpe3Vq2auchxAT
         aKwy4e+p6nGbBmY/8t6tmlqtwXCBeh9CXfwMoEvbcqFDT74F7y1xBAhkXjtPrVBhmHQI
         MTlAMUOr/3u1vB5Yn9kOHipuR2zwHyVY5OLjJ3OB2WQN7XV+bAxxw/ZzbrZNSRfU6igT
         pZnKOwfThjfhDr4THySXvvZRW5pg1mgTqjyw1zhMEh7lJ/HscSNNBeQLCYoOUIrBGAwr
         5OWQ==
X-Gm-Message-State: AOAM532vVL706sNAd9n6OqM6bwmlTDmIBZ9/GOVCgAKTm+3Gnst9dFwH
        bkKAonf9N9xuxk+MgLOYcvU=
X-Google-Smtp-Source: ABdhPJzHoirpErYXI6gCLkKFOD+VtOVFU/oE4C7pVu5IM7atl14XV25sRPwkvKtViQinTNnZPgFY4w==
X-Received: by 2002:a17:906:b754:: with SMTP id fx20mr15347815ejb.201.1623688293747;
        Mon, 14 Jun 2021 09:31:33 -0700 (PDT)
Received: from kista.localnet (cpe1-4-249.cable.triera.net. [213.161.4.249])
        by smtp.gmail.com with ESMTPSA id h24sm7701239ejy.35.2021.06.14.09.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 09:31:33 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Maxime Ripard <maxime@cerno.tech>, Guo Ren <guoren@kernel.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Drew Fustini <drew@beagleboard.org>, liush@allwinnertech.com,
        Wei Wu =?utf-8?B?KOWQtOS8nyk=?= <lazyparser@gmail.com>,
        wefu@redhat.com, linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: Re: [RFC PATCH v2 09/11] riscv: soc: Initial DTS for Allwinner D1 NeZha board
Date:   Mon, 14 Jun 2021 18:31:31 +0200
Message-ID: <4070697.crMumLFoW0@kista>
In-Reply-To: <CAJF2gTTfMAGbHv3PN_0BmA1pRqU1UvZny4mKg14AtWKjAm8=vw@mail.gmail.com>
References: <1622970249-50770-1-git-send-email-guoren@kernel.org> <20210614153341.z2nkx6sazaahhjfd@gilmour> <CAJF2gTTfMAGbHv3PN_0BmA1pRqU1UvZny4mKg14AtWKjAm8=vw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Dne ponedeljek, 14. junij 2021 ob 18:28:28 CEST je Guo Ren napisal(a):
> On Mon, Jun 14, 2021 at 11:33 PM Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > On Mon, Jun 07, 2021 at 04:07:37PM +0800, Guo Ren wrote:
> > > On Mon, Jun 7, 2021 at 3:24 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > > > > +             reset: reset-sample {
> > > > > +                     compatible = "thead,reset-sample";
> > > > > +                     plic-delegate = <0x0 0x101ffffc>;
> > > > > +             };
> > > >
> > > > This compatible is not documented anywhere?
> > >
> > > It used by opensbi (riscv runtime firmware), not in Linux. But I think
> > > we should keep it.
> >
> > This should have a documentation still.
> 
> Could we detail the above in [1]?

All DT nodes must be documented in
Documentation/devicetree/bindings folder in yaml format, so DTs can be machine 
verified.

Best regards,
Jernej

> 
> 1: https://github.com/riscv/opensbi/blob/master/docs/platform/thead-c9xx.md
> 
> >
> > Maxime
> 
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 
> ML: https://lore.kernel.org/linux-csky/
> 
> 


