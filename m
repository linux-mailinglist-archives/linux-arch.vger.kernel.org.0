Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEED5397C2
	for <lists+linux-arch@lfdr.de>; Tue, 31 May 2022 22:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347593AbiEaUH6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 May 2022 16:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiEaUH5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 May 2022 16:07:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBD557B16;
        Tue, 31 May 2022 13:07:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A89BC612AC;
        Tue, 31 May 2022 20:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F684C341C4;
        Tue, 31 May 2022 20:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654027675;
        bh=/1wVto7J+rSqm/l8RRWgQmztiSvDwgDUiwq+ybY++qk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nnOyM2vetkXO5nF+8WqAxhOHfGINwlvwqwk9ahclsj42ZB/cNeb9Wrykiyuz9BOiF
         rp51wWgT0fC/bLa2AvHdpvMYh7EykJAYtGNmTw1O0BWxmlDLtNoL6NQqbaXTNj8H4G
         g2EfMFyPev/1FNqPq/KInLD82OuI5MuFI8q849ILP7EhJDI9v+OowCoaOvXNzXLzU+
         ajmDwDChPLvU2hnRGCdN+CV6PO4zM7vh9z/xEXShsWXJVRf4/FrMKQ4ItR73DNihVY
         mPii7EC77EcAvyYxpIZO8UvX520hJnP2C5yGa1bpp2y05/3BC3NI83Ls3vgpi0OCI5
         Hhi6Dnytdb6Sw==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2f83983782fso152022407b3.6;
        Tue, 31 May 2022 13:07:54 -0700 (PDT)
X-Gm-Message-State: AOAM532lOavoeGY1NRnD0quJTpznbHE4jfNbTAM5aW06Yv9lG3jviqWG
        wvy6ptFVWFgpi3n99qm65MTbr/tF+We1NRHPHS8=
X-Google-Smtp-Source: ABdhPJynwUPoxY4t1hEYSHRrYE+UitoNiBfNg7p61MOvqW2Sflpn/6hG0o4DNgEIJG28nrjOsQjHJgiqqS1BijW2AEc=
X-Received: by 2002:a81:28b:0:b0:30c:5e57:fac3 with SMTP id
 133-20020a81028b000000b0030c5e57fac3mr11684988ywc.249.1654027673950; Tue, 31
 May 2022 13:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2_52JPnBWNvTTkFVwLxPAa7=NaQ4whwC1UeH_NYHeUKQ@mail.gmail.com>
 <CAK8P3a0SpU1n+29KQxzKnPRvzmDE=L0V9RUpKxhemv=74kevcQ@mail.gmail.com>
 <df5c406c-eec6-c340-2847-49670b7fe8bf@xen0n.name> <CAK8P3a3awFdB1-G65DC38NBuSTvo6SvFTaS0m9YBxunHjHjQvQ@mail.gmail.com>
 <CAAhV-H6sNr-yo8brBFtzziH6k9Tby0dFp7yehK55SfH5HjZ8hQ@mail.gmail.com>
 <358025d1-28e6-708b-d23d-3f22ae12a800@xen0n.name> <CAK8P3a1ge2bZS13ahm_LdO3jEcbtR4w3do-gLjggKvppqnBDkw@mail.gmail.com>
 <CAAhV-H5NCUpR6aBtR9d7c9vW2KiHpk3iFQxj7BeTSS0boMz8PQ@mail.gmail.com>
 <CAK8P3a2JgrW5a7_udCUWen-gOnJgVeRV2oAd-uq4VSuYkFUqNQ@mail.gmail.com>
 <CAAhV-H6wfmdcV=a4L43dcabsvO+JbOebCX3_6PV+p85NjA9qhQ@mail.gmail.com>
 <CAK8P3a0c_tbHov_b6cz-_Tj6VD3OWLwpGJf_2rj-nitipSKdYQ@mail.gmail.com> <CAAhV-H4_qqQtTp2=mJF=OV+qcKzA0j8SPWKRMR-LJgC0zNfatQ@mail.gmail.com>
In-Reply-To: <CAAhV-H4_qqQtTp2=mJF=OV+qcKzA0j8SPWKRMR-LJgC0zNfatQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 31 May 2022 22:07:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3UfDJkoAkA6an2kXyAYSzz2vt__19JoQmum8LZehXrgg@mail.gmail.com>
Message-ID: <CAK8P3a3UfDJkoAkA6an2kXyAYSzz2vt__19JoQmum8LZehXrgg@mail.gmail.com>
Subject: Re: [musl] Re: [GIT PULL] asm-generic changes for 5.19
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     musl@lists.openwall.com, WANG Xuerui <kernel@xen0n.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        linux-pci <linux-pci@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 31, 2022 at 6:01 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> On Tue, May 31, 2022 at 7:15 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > On Tue, May 31, 2022 at 10:17 AM Huacai Chen <chenhuacai@kernel.org> wrote:

> https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/log/?h=loongarch-next
> has been updated. Now this branch droped irqchip drivers and pci
> drivers. But the existing irqchip drivers need some small adjustment
> to avoid build errors [1], and I hope Marc can give an Acked-by.

Ok, glad you got that working.

 What about the ACPI changes? I see that these are needed to get a clean build,
and as I understood it, they are supposed to get merged through the
acpica tree.

> This branch can be built with defconfig and allmodconfig (except
> drivers/platform/surface/aggregator/controller.c, because it requires
> 8bit/16bit cmpxchg, which I was told to remove their support).

Right, that is ok to keep in there, we should fix that by adding a Kconfig
dependency for the driver. It looks like it has a CONFIG_ACPI dependency,
so it is currently limited to x86/arm64/ia64, which all have the short
cmpxchg(),
but in reality this driver can only work on x86 and arm64.

       Arnd
