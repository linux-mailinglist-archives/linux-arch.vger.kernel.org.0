Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217CD4F02C3
	for <lists+linux-arch@lfdr.de>; Sat,  2 Apr 2022 15:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiDBNo1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 2 Apr 2022 09:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiDBNo1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Apr 2022 09:44:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF88CB018;
        Sat,  2 Apr 2022 06:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4818961480;
        Sat,  2 Apr 2022 13:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F09C34114;
        Sat,  2 Apr 2022 13:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648906954;
        bh=Gu+xq607wcJLBd5767EU4rcp1lhQFK3gX5NsYIlfwpk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P5SNXXiZYJlwtDY9K7ILgja4Zc87hqaPdzZuA4XcIfQiCgWqgEAqauONat3Oymksi
         87Z+SmQtQCTWwkSUosNSjXfEN/6Jo7qguivEZVbHhPO+6f6ILrIyWD7+UlL+sR9eJi
         vcVJx+BsnnC1yfzFNFurIc6kR9rmo9R49wRg7UcSyTRxRPxKcLrwpgVt+0sOVwfu6c
         4Rw1eHf9eLdaWDKUZgEDb0kGbGBBTkThcnsCarYvj8Dv8khaCb4nOXAguU3V3I6XGi
         Mm/KhWYBr79E28kngvHTPnvvO3WVy6LkMMukedXIJwUV/9UhFvHbYbapjP7HcxRTx/
         Tr0ioD8VxBNgA==
Received: by mail-vs1-f46.google.com with SMTP id u207so5117304vsu.10;
        Sat, 02 Apr 2022 06:42:34 -0700 (PDT)
X-Gm-Message-State: AOAM530nhgSzGqX/lBewz8Y+FWZung9MFpUku/jdJLcJoRmYEi9mRMG+
        JbSgi2Xp7JOIKD49bnoXCq80arfjY1uuNJJm+Hk=
X-Google-Smtp-Source: ABdhPJzkOByPICbGCNWRRHvRte+HkSIGERCcxR6bEJaVQtPFOc687kt90hJEYHoJbA8dMpQCnDf3561ZC2qPkk8E2t0=
X-Received: by 2002:a05:6102:1241:b0:325:6bfb:ab75 with SMTP id
 p1-20020a056102124100b003256bfbab75mr22778557vsg.2.1648906953574; Sat, 02 Apr
 2022 06:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220402133544.2690231-1-guoren@kernel.org> <20220402133544.2690231-5-guoren@kernel.org>
 <CAK7LNAS8i2xe2zFQo7mcJeujymhWB7hyp36UWS4Rp9T9dMUu2g@mail.gmail.com>
In-Reply-To: <CAK7LNAS8i2xe2zFQo7mcJeujymhWB7hyp36UWS4Rp9T9dMUu2g@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 2 Apr 2022 21:42:22 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQvDHFijfq+ekjZV4qj75Yyer84tY_eggsdxz3dL3SrYA@mail.gmail.com>
Message-ID: <CAJF2gTQvDHFijfq+ekjZV4qj75Yyer84tY_eggsdxz3dL3SrYA@mail.gmail.com>
Subject: Re: [PATCH V10 04/20] kconfig: Add SYSVIPC_COMPAT for all architectures
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        X86 ML <x86@kernel.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Apr 2, 2022 at 9:39 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Sat, Apr 2, 2022 at 10:36 PM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The existing per-arch definitions are pretty much historic cruft.
> > Move SYSVIPC_COMPAT into init/Kconfig.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > ---
>
> Please use "arch:" or something for the commit subject.
>
> I want to see "kconfig:" for
> changes under scripts/kconfig/.
Okay

>
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
