Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DC05A3578
	for <lists+linux-arch@lfdr.de>; Sat, 27 Aug 2022 09:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiH0HOP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Aug 2022 03:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiH0HOP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Aug 2022 03:14:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1BAB941F;
        Sat, 27 Aug 2022 00:14:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A56ECB82B8D;
        Sat, 27 Aug 2022 07:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6ABC4347C;
        Sat, 27 Aug 2022 07:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661584451;
        bh=bQaVKBfsaLgFQiFbtFaJvcqVdo/u/g4Ip0tVdWmYieQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MuvtgXa0YJPctLv2mT8DfNi0I5KdPrtZD8YgtzWdktEzyf/YogOa/LKGqu5nVWK+H
         Z/Jy1DsA5qi5+ZmGLhJTw6q30Ixe9S4To6brhk8PzAfRbitjd7TULsBwhQrwEU+S4h
         KxTieZLSV2ngyyRacvTGeGvMRvGYw4ccE17vx4jHnsYBEyv0AA26+Egw8EjTGWz6zz
         CdUTbOKzSpAfbv61qT2Cw2DFQvVD2BYJcfIDHAFaHnppPgtv9Qsp48xZUnifVtj70O
         VZzHlRQZpQsXV/vyoNG1zSmyCYj6BoKL7bKeQbWWnpybGFjp6Biny5JZA/EOkd2Qqf
         sqjS9WTInxJAg==
Received: by mail-wm1-f53.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so5455948wmk.3;
        Sat, 27 Aug 2022 00:14:11 -0700 (PDT)
X-Gm-Message-State: ACgBeo2crqYSz1YLQi25NSxQUVPF3Gc74q4m02TB91HuiLt87Z6MTQaZ
        wdF6KqZTUldAGrH6OIaHaz65FW6i/rhIjK9ze8w=
X-Google-Smtp-Source: AA6agR7p8GijcUOtJGznPBKhpfg9HyxCqjidJlhRFBvsrg/twaTrPlEhxNPEg5Uu1s2eYVOnl4WfetJWsHoWy5eWk/c=
X-Received: by 2002:a1c:3b55:0:b0:3a6:7b62:3901 with SMTP id
 i82-20020a1c3b55000000b003a67b623901mr1520421wma.113.1661584449515; Sat, 27
 Aug 2022 00:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220819102037.2697798-1-chenhuacai@loongson.cn> <9b6f0aeaebbd36882b5b40d655f9ccd20c7be496.camel@xry111.site>
In-Reply-To: <9b6f0aeaebbd36882b5b40d655f9ccd20c7be496.camel@xry111.site>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 27 Aug 2022 09:13:58 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFOd+gMHbi6MH0KHWkBEKN9V0LeZbyGRw8h630OxtMrdA@mail.gmail.com>
Message-ID: <CAMj1kXFOd+gMHbi6MH0KHWkBEKN9V0LeZbyGRw8h630OxtMrdA@mail.gmail.com>
Subject: Re: [PATCH V3] LoongArch: Add efistub booting support
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, 27 Aug 2022 at 06:41, Xi Ruoyao <xry111@xry111.site> wrote:
>
> Tested V3 with the magic number check manually removed in my GRUB build.
> The system boots successfully.  I've not tested Arnd's zBoot patch yet.

I am Ard not Arnd :-)

Please use this branch when testing the EFI decompressor:
https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-decompressor-v4
