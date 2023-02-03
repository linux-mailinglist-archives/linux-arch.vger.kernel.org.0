Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE0E688CE9
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 03:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjBCCI6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 21:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjBCCI5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 21:08:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396AD68114;
        Thu,  2 Feb 2023 18:08:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9390861D63;
        Fri,  3 Feb 2023 02:08:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E557FC4339B;
        Fri,  3 Feb 2023 02:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675390134;
        bh=9SFVMDLXP6rCxw0koy5AsHtvGYm4KS5eagd3gakC66Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h2naxLKy2Uss1KEo2gbiTB7Jr985m1oWr3pC7QD/Qky7TZICT+6Wb1+kinNfll89a
         35TkDelMkbayRnL+GGsK+o2r4zaRESh6FYjhJKj88Ka2MqFPOgtdjywUywk6W7dXtW
         x3g2jSbN0U/qq9aEl6B4L/xUlWn7d3vkE4ve0kvMJPRI8mZ2Yb9gzlZI5BWkDqQQod
         qE3+9WoIb++WfibqIaHxwnQLiP/CvAtlpD0vlzSkFXTVf6cQQ0POJgVIU9qykH1Qb8
         5NuFF0623cgffWWwd6sXw95AqpldiG2BFu0ppu+xF6T1kSlG9twjw2kB78yP5NWyuH
         CF5RIMTM2REkw==
Received: by mail-ej1-f42.google.com with SMTP id hx15so11468718ejc.11;
        Thu, 02 Feb 2023 18:08:54 -0800 (PST)
X-Gm-Message-State: AO0yUKU+DdEIlK50fRB2DK1IXcx2XOpTNJVPda8iedc/rbTR/MaSO+T0
        +37jmIz8Nlqw28/XvufJIMcC0Cjhau9tkbeucEQ=
X-Google-Smtp-Source: AK7set/ydpY+oP3Z+t+NArVdALXiqzOsn4rcGlM7loxkZ8n+4hJG8dOtM1ETH3IvToN2WCewRC5xSUJ3FVILiorZwGg=
X-Received: by 2002:a17:906:338d:b0:879:b98d:eb0b with SMTP id
 v13-20020a170906338d00b00879b98deb0bmr2023573eja.88.1675390133191; Thu, 02
 Feb 2023 18:08:53 -0800 (PST)
MIME-Version: 1.0
References: <20230202084238.2408516-1-chenhuacai@loongson.cn> <ccf74ebd-ccc1-4de5-a425-dcde4ac39a8d@app.fastmail.com>
In-Reply-To: <ccf74ebd-ccc1-4de5-a425-dcde4ac39a8d@app.fastmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 3 Feb 2023 10:08:42 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6kuzfjw5i8-6L_68c50nsXzFipHY5hxtbShuv16bqRbg@mail.gmail.com>
Message-ID: <CAAhV-H6kuzfjw5i8-6L_68c50nsXzFipHY5hxtbShuv16bqRbg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Make -mstrict-align be configurable
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Thu, Feb 2, 2023 at 5:47 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Feb 2, 2023, at 09:42, Huacai Chen wrote:
> > Introduce Kconfig option ARCH_STRICT_ALIGN to make -mstrict-align be
> > configurable.
> >
> > Not all LoongArch cores support h/w unaligned access, we can use the
> > -mstrict-align build parameter to prevent unaligned accesses.
> >
> > This option is disabled by default to optimise for performance, but you
> > can enabled it manually if you want to run kernel on systems without h/w
> > unaligned access support.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> This feels like it's a way too low-level option, I would not expect
> users to be able to answer this correctly.
>
> What I would do instead is to have Kconfig options for specific
> CPU implementations and derive the alignment requirements from
> that.
You mean provide something like CONFIG_CPU_XXXX as MIPS do?  That
seems not a good idea, too. If there are more than 3 CONFIG_CPU_XXXX,
the complexity is more than CONFIG_ARCH_STRICT_ALIGN. Then users are
also unable to do a correct selection. On the other hand, we can add
more words under CONFIG_ARCH_STRICT_ALIGN to describe which processors
support hardware unaligned accesses.

Huacai

>
> > +config ARCH_STRICT_ALIGN
> > +     bool "Enable -mstrict-align to prevent unaligned accesses"
> > +     help
> > +       Not all LoongArch cores support h/w unaligned access, we can use
> > +       -mstrict-align build parameter to prevent unaligned accesses.
> > +
> > +       This is disabled by default to optimise for performance, you can
> > +       enabled it manually if you want to run kernel on systems without
> > +       h/w unaligned access support.
> > +
>
>
> There is already a global CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> option, I think you should use that one instead of adding another
> one. Setting HAVE_EFFICIENT_UNALIGNED_ACCESS for CPUs that can
> do unaligned access will enable some important optimizations in
> the network stack and a few other places.
>
>     Arnd
