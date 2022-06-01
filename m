Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A1A53A96F
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 16:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353409AbiFAO4m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jun 2022 10:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241149AbiFAO4m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2022 10:56:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914DF1A0;
        Wed,  1 Jun 2022 07:56:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30561B81B9D;
        Wed,  1 Jun 2022 14:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31F6C385B8;
        Wed,  1 Jun 2022 14:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654095397;
        bh=tFJMRsa1oK1XN1rTTucNDNSPNTxVk9Tt9GgcBYnt2k8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SnirSTJy/ElaX05FWkLlnBDhOlYKLzNlcuysXwsS6DwfoRRAJtrx10OVjyWwq9XPa
         T9E6H/5ROFf7DEw41KyOCR6imsT9ineblfLmCIjPKkROVicDjYiymmfZdDuJu4qjQ6
         PqDk6NY1cELnTYOhGuVVpEgQySwSIO0fRU8S5lzLGPYAuWn5T1/jWlglJP7d9OZRxW
         whyJn32QEIXoiTzFIv5tgGvBiIjRvVUzf3xfA0AQ/jnUhnDSltQBeCwjpbhzAXPU5g
         s58zR8+ZjE/omNigYieterbNdjvi/YriFiC3gMFg0VQnaAjg7g0poCaTN10k3NQ5lg
         G8hZIRG+m/+kA==
Received: by mail-ua1-f46.google.com with SMTP id l12so654975uan.5;
        Wed, 01 Jun 2022 07:56:37 -0700 (PDT)
X-Gm-Message-State: AOAM531Z/w4FMwQQE6zt4h7MYd8eqwmbfD6075yeDe57pjPy2yEDcKL3
        ns0Jo2DS4vxRAS6WwBre1co1eRtZ1xnaM4FBjg8=
X-Google-Smtp-Source: ABdhPJymxDAuPOMQkZwFFaw8OHs6paDEyKWLtYFrlsLGqgyiowwRz+CgTMyaafamSqSo8HkagBMfVgWrE1r2uO3vHJw=
X-Received: by 2002:a05:6130:90:b0:362:891c:edef with SMTP id
 x16-20020a056130009000b00362891cedefmr23919588uaf.106.1654095396587; Wed, 01
 Jun 2022 07:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220601100005.2989022-1-chenhuacai@loongson.cn>
 <20220601100005.2989022-25-chenhuacai@loongson.cn> <cc1bae30-ff29-48c0-90c5-817b2320cbb6@www.fastmail.com>
In-Reply-To: <cc1bae30-ff29-48c0-90c5-817b2320cbb6@www.fastmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 1 Jun 2022 22:56:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR4w1a15jK+Wh_r5c32-c7YsiXw=6d0q5v7_KyMM36zdg@mail.gmail.com>
Message-ID: <CAJF2gTR4w1a15jK+Wh_r5c32-c7YsiXw=6d0q5v7_KyMM36zdg@mail.gmail.com>
Subject: Re: [PATCH V12 24/24] MAINTAINERS: Add maintainer information for LoongArch
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Xuerui Wang <kernel@xen0n.name>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        WANG Xuerui <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cheers

Reviewed-by: Guo Ren <guoren@kernel.org>

On Wed, Jun 1, 2022 at 8:35 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
>
>
> =E5=9C=A82022=E5=B9=B46=E6=9C=881=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=E5=
=8D=8811:00=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> > Add the maintainer information for the LoongArch (LA or LArch for short=
)
> > architecture.
> >
> > Signed-off-by: WANG Xuerui <git@xen0n.name>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>
> You guys deserve it.
>
> Thanks.
>
> > ---
> >  MAINTAINERS | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f1b4b77daa5f..3e592ea84557 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11544,6 +11544,16 @@ S:   Maintained
> >  F:   Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.=
yaml
> >  F:   drivers/gpu/drm/bridge/lontium-lt8912b.c
> >
> > +LOONGARCH
> > +M:   Huacai Chen <chenhuacai@kernel.org>
> > +R:   WANG Xuerui <kernel@xen0n.name>
> > +S:   Maintained
> > +T:   git
> > git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson=
.git
> > +F:   arch/loongarch/
> > +F:   drivers/*/*loongarch*
> > +F:   Documentation/loongarch/
> > +F:   Documentation/translations/zh_CN/loongarch/
> > +
> >  LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
> >  M:   Sathya Prakash <sathya.prakash@broadcom.com>
> >  M:   Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> > --
> > 2.27.0
>
> --
> - Jiaxun



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
