Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520B46EB804
	for <lists+linux-arch@lfdr.de>; Sat, 22 Apr 2023 10:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjDVIkN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 22 Apr 2023 04:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDVIkM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 22 Apr 2023 04:40:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2186C1BF7;
        Sat, 22 Apr 2023 01:40:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A594761707;
        Sat, 22 Apr 2023 08:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DAAC4339E;
        Sat, 22 Apr 2023 08:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682152810;
        bh=QXG5T42tVx2Zc3hVYTGfLvngOMBM37xTg5jMxu8Vaf8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dgZoPEmyURGx8GO6GV9YJt++08mo4Jfcb78n9MD6yMcczqoFrzth2mtqyRFPXrq5S
         snUbjsLbFCxeIWPtIsAuAFk1DMWqzvQ/wGhE4vy253OyfrTODrOvzEpMk+C6Jd4O9p
         L/keUyvvi1gAA35kmpr90w6NkTy5NnHmbtmJo8nbmjS1c9X/i2CIRTDpMAEFWwVmC6
         TP51hRCCHpSbSC+q6jaMCCKPCLHO27+pIYDpAfJxeeSWBDJ1yzCf/OclKVOPf68pym
         60cqkEU1FRj1iwSL3gVMYwvEQvKtqvExa5jf20kRYv+xIcCCkZuFKfZs8oI6GqvdER
         Ax3V4hko0OHbw==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-94a34d3812cso439695866b.2;
        Sat, 22 Apr 2023 01:40:09 -0700 (PDT)
X-Gm-Message-State: AAQBX9c58pMjUV1DJ7vMvEVQv2g+leItBTll9VBiLjScjPh9qYRY4V37
        +4Nhg1FdPwN1Rh/96ii+76wvFH/VHWnw/6Js8IE=
X-Google-Smtp-Source: AKy350ZhlLgO7vpVjaH4qh+FFLlSyRoGrJ1ZfEitx2+rsb6XEzrnoseIH1kiMEU1pVxXIX+ei8CW2tuxLEVJdCRQlfU=
X-Received: by 2002:a17:906:a2da:b0:946:be05:ed7a with SMTP id
 by26-20020a170906a2da00b00946be05ed7amr4668557ejb.70.1682152808057; Sat, 22
 Apr 2023 01:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230416173326.3995295-1-kernel@xen0n.name> <e593541e7995cc46359da3dd4eb3a69094e969e2.camel@xry111.site>
 <6ca642a9-62a6-00e5-39ac-f14ef36f6bdb@xen0n.name> <f54abfae989023fcfdabb4e9800a66847c357b85.camel@xry111.site>
 <CAAhV-H7zTjSsz=e+0r-9Z0KOF-Gxr-chXnVgWo+4eNA1ptWw1g@mail.gmail.com> <2e8d357d-e006-bda8-3711-dcbafbd4c53e@xen0n.name>
In-Reply-To: <2e8d357d-e006-bda8-3711-dcbafbd4c53e@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 22 Apr 2023 16:39:55 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6PfjkYPYsBEzHY5i=74-tyqSHCRC65Fbz3O0Jaggypmg@mail.gmail.com>
Message-ID: <CAAhV-H6PfjkYPYsBEzHY5i=74-tyqSHCRC65Fbz3O0Jaggypmg@mail.gmail.com>
Subject: Re: [PATCH 0/2] LoongArch: Make bounds-checking instructions useful
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev,
        WANG Xuerui <git@xen0n.name>,
        Eric Biederman <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 20, 2023 at 5:38=E2=80=AFPM WANG Xuerui <kernel@xen0n.name> wro=
te:
>
> On 2023/4/20 16:36, Huacai Chen wrote:
> > Hi, Xuerui,
> >
> > I hope V2 can be applied cleanly without the patch series "LoongArch:
> > Better backtraces", thanks.
>
> I believe it's already the case (just try; I've moved the BADV printing
> for BCE into the better backtraces series before sending this).
>
> I'm only waiting for comments from the other UAPI maintainers on the CC
> list.
You changed arch/loongarch/include/asm/kdebug.h, does it have
something to do with UAPI?
On the other hand, kprobe has dropped the notifier mechanism, so this
piece should be changed, I think.

+ /*
+ * notify the kprobe handlers, if instruction is likely to
+ * pertain to them.
+ */
+ if (notify_die(DIE_BOUNDS_CHECK, "Bounds check error", regs, 0,
+       current->thread.trap_nr, SIGSEGV) =3D=3D NOTIFY_STOP)
+ goto out;

Huacai

>
> --
> WANG "xen0n" Xuerui
>
> Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/
>
