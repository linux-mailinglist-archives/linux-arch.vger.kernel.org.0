Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A385895DE
	for <lists+linux-arch@lfdr.de>; Thu,  4 Aug 2022 04:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbiHDCM7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Aug 2022 22:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiHDCM6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Aug 2022 22:12:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31B82B637;
        Wed,  3 Aug 2022 19:12:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54FEF61789;
        Thu,  4 Aug 2022 02:12:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B358BC43142;
        Thu,  4 Aug 2022 02:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659579176;
        bh=epAxio5diH96CFBkzTZwKEWSTogy6nSq9q1SQoW4viM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ceCGZfQWkWmI6GpvHGENHKlJTVKAuQBEnZSFMbNMwdL3adkcUOIQii3S0f4Kyp8Bb
         KoXLuNDTPpeM+tbNcQ49P9oq8jVA9vMK4FMy6z8jR/3HCqVL1weN5EOOqETXge6yJG
         nBFGD8bOrJmR9Mw5WhHCIO5W1I09DiyNemQ1xw8F2jamvkzlU7drDgbdstNxPtv0gF
         Vixg+rpEEnKCDbYzHgOPtaX3dCOJO0pZPkL1wllA1/1afczoKpJ0EKktRsTh3uV5ga
         i+abEpZGK1uyPnCu7xZC1uylg7v9v8aWRlyowogN82MXD6DXPnsGgaBQAXlS/xu4Mc
         2iS4HY3nt22KQ==
Received: by mail-ot1-f52.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso13352658otb.6;
        Wed, 03 Aug 2022 19:12:56 -0700 (PDT)
X-Gm-Message-State: ACgBeo1BKPO8fpuH6hBwAfev+OfzBqv7vzRq61X7gxqiclPoJa9U9hjI
        tfC58w3/0Tg9F67hs+qdcMawPWrocxFUZo3qBlI=
X-Google-Smtp-Source: AA6agR4F20j452D1vIKrFY4A90rWCSqTF2vNMheqHPpQqXXnlAlq4zSIa+r6cn2/wD2OCL0hfuxWK19txHwype4SI50=
X-Received: by 2002:a05:6830:18fc:b0:633:9af8:f137 with SMTP id
 d28-20020a05683018fc00b006339af8f137mr4813011otf.140.1659579175844; Wed, 03
 Aug 2022 19:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220613142947.GA4110@lst.de> <mhng-f091aa29-2a87-4d82-9bab-f35533de7161@palmer-ri-x1c9>
In-Reply-To: <mhng-f091aa29-2a87-4d82-9bab-f35533de7161@palmer-ri-x1c9>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 4 Aug 2022 10:12:43 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQPX0bbFvkkXCA2hUf2ei0KK1ZCHtNWj+JMDgsMP-M4oA@mail.gmail.com>
Message-ID: <CAJF2gTQPX0bbFvkkXCA2hUf2ei0KK1ZCHtNWj+JMDgsMP-M4oA@mail.gmail.com>
Subject: Re: [PATCH] uapi: Fixup strace compile error
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Eugene Syromiatnikov <esyr@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thx for the reply, I even forgot that patch. I would update V2 with
your acked, and Christoph advice.


On Thu, Aug 4, 2022 at 8:40 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Mon, 13 Jun 2022 07:29:47 PDT (-0700), Christoph Hellwig wrote:
> > The change looks fine, but the commit log could use some work, please
> > move the notes from the back to the front and make them a standalone
> > commit log and just drop the rest.
>
> I'm digging through old stuff and don't see a v2, not sure if I just
> missed it.  Either way I don't think it's really a RISC-V thing so
>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> in case that helps.
>
> Thanks!



--
Best Regards

 Guo Ren
