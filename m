Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058977AF86B
	for <lists+linux-arch@lfdr.de>; Wed, 27 Sep 2023 05:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjI0DEw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Sep 2023 23:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbjI0DCv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Sep 2023 23:02:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19A976B2;
        Tue, 26 Sep 2023 17:45:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4528EC433CB;
        Wed, 27 Sep 2023 00:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695775539;
        bh=2czlUODplVLqlPwrGiCVrixmp6cbiBPmEv+rpDMNXbE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gNE3/ylOvhRAAoz/vsvv9pN5ZobXtP1piV0MjWp1L0UZj699jNMZbSqPNIug9aveo
         EXIR25LqshXk+WtroxcOWzrX8sHUzX+k3t/iTkQb+0n4hSJqcQBpyIvyXfu9I/C4qo
         9Zcm00JBw0DvFNlOAz8fWYvCC6GGgCZEazaYZbI4zHTzyIbKvT4Zq2Gka+8StvxJbm
         v29idUfwAetZBi/R+2RCOPbQnmrZa09PJdhkBCs59xhijWkwu3iPnjtNfdBBwFsRss
         5a1oyOE+sSaJlNVxR/r5r6JsojfIp8MQYqDhtGqcBdm7bx+thdBaWvs1SwDfT2zeNm
         JIGs47bCHE4wA==
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4053c6f0e50so94643995e9.1;
        Tue, 26 Sep 2023 17:45:39 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx8stZjqNN2cxNj12+4RuiCBQlvRdYPKhR+B4BsTiAYy4yxzfU8
        3Y1ofQQin7Q4dEyq4ZjQx7zutu8yBik1zCTt5LY=
X-Google-Smtp-Source: AGHT+IH7TiTSw495lHvxkQDLdhAGLVNGCEfgqX0IVQetkEk4oU2/PQH5vwKZCIneHOZYWfI/8AGboWlwslKgZwyqJJY=
X-Received: by 2002:adf:ecce:0:b0:31f:98b4:4b62 with SMTP id
 s14-20020adfecce000000b0031f98b44b62mr229081wro.37.1695775537680; Tue, 26 Sep
 2023 17:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230926121031.1901760-1-chenhuacai@loongson.cn> <4abf8ddb-ff93-436f-a834-39e7f4d7a503@xen0n.name>
In-Reply-To: <4abf8ddb-ff93-436f-a834-39e7f4d7a503@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 27 Sep 2023 08:45:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5z5a45PobUQ5xU3rP6bqenoqtuuceX2=ijYhTN6a_vqg@mail.gmail.com>
Message-ID: <CAAhV-H5z5a45PobUQ5xU3rP6bqenoqtuuceX2=ijYhTN6a_vqg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: numa: Fix high_memory calculation
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        stable@vger.kernel.org, Chong Qiao <qiaochong@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 26, 2023 at 11:26=E2=80=AFPM WANG Xuerui <kernel@xen0n.name> wr=
ote:
>
> On 9/26/23 20:10, Huacai Chen wrote:
> > high_memory is the virtual address of the 'highest physical address' in
> > the system. But __va(get_num_physpages() << PAGE_SHIFT) is not what we
> > want because there may be holes in the physical address space. On the
> > other hand, max_low_pfn is calculated from memblock_end_of_DRAM(), whic=
h
> > is exactly corresponding to the highest physical address, so use it for
> > high_memory calculation.
> >
> > Cc: <stable@vger.kernel.org>
> Which commit is this patch intended to amend? A "Fixes:" tag may be
> helpful for stable backporting.
OK, I will add a Fixes: tag.

Huacai

> > Signed-off-by: Chong Qiao <qiaochong@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   arch/loongarch/kernel/numa.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.=
c
> > index c7d33c489e04..6e65ff12d5c7 100644
> > --- a/arch/loongarch/kernel/numa.c
> > +++ b/arch/loongarch/kernel/numa.c
> > @@ -436,7 +436,7 @@ void __init paging_init(void)
> >
> >   void __init mem_init(void)
> >   {
> > -     high_memory =3D (void *) __va(get_num_physpages() << PAGE_SHIFT);
> > +     high_memory =3D (void *) __va(max_low_pfn << PAGE_SHIFT);
> >       memblock_free_all();
> >   }
> >
>
> --
> WANG "xen0n" Xuerui
>
> Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/
>
