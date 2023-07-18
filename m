Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C70175766A
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jul 2023 10:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjGRISt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Jul 2023 04:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjGRISq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Jul 2023 04:18:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0935188;
        Tue, 18 Jul 2023 01:18:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36794614BC;
        Tue, 18 Jul 2023 08:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958DBC433C9;
        Tue, 18 Jul 2023 08:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689668324;
        bh=SqqCUo/IyOCfN69H3Qs2GUHWNOW1wETjdoDH5qpokl0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RGjrhl3aStfeK3ONXUr67y9XhXwmslS7WExzjAg/NMckcpU/FjLy5AfsOsxpx8eRN
         DWHyPgJKgpYEDFBBf4fwdLE5/M0FoDvXGvq/Y9DQgP45oPrIJACXt7MBJEYGmCpaof
         Fj42y1YymWu9JSm4XiLsSFhN8J+K+j6IPZBZ/GG+9tduC9vE4VICkA/p24ewx32Ow6
         vKc6/yLApBnDedtMmv+p8jhJdhW/Wrr1j9uM/vShsmb6/UDNJ/5CamnhWtEl8+cmj9
         I4qwiZDFRzDQW5ssmVpIg16poo4/30nvMg6QzYSc1FZaItl+rxtd3tVWA5zuOS69HM
         /v8SXs7ciE/hw==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-51e590a8ab5so7322643a12.2;
        Tue, 18 Jul 2023 01:18:44 -0700 (PDT)
X-Gm-Message-State: ABy/qLb7tF9+XxCVubeeDC8HM3oWBsf0SUYdCagG4Zpkc7QttxnnBTk1
        z9Gfx3dCIJo+daUZcfx9+GrCWr2WzJ6zO2H840I=
X-Google-Smtp-Source: APBJJlFdNLsCUHWgsP3R+2kAH3KjpiHbt4rGAq7i8aC9TmwOWjh2oU14HbRt13EfWIwlD0Y3WlVeaaQgRNhkH/M0OUc=
X-Received: by 2002:a50:fa98:0:b0:51e:4bc7:3976 with SMTP id
 w24-20020a50fa98000000b0051e4bc73976mr15397229edr.10.1689668322798; Tue, 18
 Jul 2023 01:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230718064819.2549052-1-chenhuacai@loongson.cn> <e06ac133-2fd7-85f0-2ce7-d1209c6bb2ac@xen0n.name>
In-Reply-To: <e06ac133-2fd7-85f0-2ce7-d1209c6bb2ac@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 18 Jul 2023 16:18:30 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6NnvSEtb81q5-TZLvK+cR+m8CxzadWmbYjNCTNSDOcRw@mail.gmail.com>
Message-ID: <CAAhV-H6NnvSEtb81q5-TZLvK+cR+m8CxzadWmbYjNCTNSDOcRw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Cleanup __builtin_constant_p() checking for cpu_has_*
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 18, 2023 at 3:35=E2=80=AFPM WANG Xuerui <kernel@xen0n.name> wro=
te:
>
> On 2023/7/18 14:48, Huacai Chen wrote:
> > In current configuration, cpu_has_lsx and cpu_has_lasx are impossible
> > constants. So cleanup the __builtin_constant_p() checking to reduce the
>
> "cannot be constants"? "impossible constants" sounds like a compile-time
> error to me.
OK, thanks.

Huacai
>
> > complexity.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   arch/loongarch/include/asm/fpu.h | 11 +++--------
> >   1 file changed, 3 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/loongarch/include/asm/fpu.h b/arch/loongarch/include/=
asm/fpu.h
> > index e4193d637f66..f02f4a0d0d64 100644
> > --- a/arch/loongarch/include/asm/fpu.h
> > +++ b/arch/loongarch/include/asm/fpu.h
> > @@ -218,12 +218,7 @@ static inline void restore_lsx(struct task_struct =
*t)
> >
> >   static inline void init_lsx_upper(void)
> >   {
> > -     /*
> > -      * Check cpu_has_lsx only if it's a constant. This will allow the
> > -      * compiler to optimise out code for CPUs without LSX without add=
ing
> > -      * an extra redundant check for CPUs with LSX.
> > -      */
> > -     if (__builtin_constant_p(cpu_has_lsx) && !cpu_has_lsx)
> > +     if (!cpu_has_lsx)
> >               return;
> >
> >       _init_lsx_upper();
> > @@ -294,7 +289,7 @@ static inline void restore_lasx_upper(struct task_s=
truct *t) {}
> >
> >   static inline int thread_lsx_context_live(void)
> >   {
> > -     if (__builtin_constant_p(cpu_has_lsx) && !cpu_has_lsx)
> > +     if (!cpu_has_lsx)
> >               return 0;
> >
> >       return test_thread_flag(TIF_LSX_CTX_LIVE);
> > @@ -302,7 +297,7 @@ static inline int thread_lsx_context_live(void)
> >
> >   static inline int thread_lasx_context_live(void)
> >   {
> > -     if (__builtin_constant_p(cpu_has_lasx) && !cpu_has_lasx)
> > +     if (!cpu_has_lasx)
> >               return 0;
> >
> >       return test_thread_flag(TIF_LASX_CTX_LIVE);
>
> For the foreseeable future, the changes seem appropriate to me. FWIW the
> LoongArch kernel would stay as generic as possible so I expect the
> various predicates to almost never exist as constants.
>
> Reviewed-by: WANG Xuerui <git@xen0n.name>
>
> --
> WANG "xen0n" Xuerui
>
> Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/
>
