Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B986875B0
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 07:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBBGR2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 01:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBBGR2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 01:17:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9266FD06;
        Wed,  1 Feb 2023 22:17:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE208B824DA;
        Thu,  2 Feb 2023 06:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCE6C4339C;
        Thu,  2 Feb 2023 06:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675318644;
        bh=lIQRjELp3Php5uFWPaHMcz+Z9q+Ruw90XMNIKquPkpA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hMg2QgjSlJHN6UgkTHxwek55KSFcYKIZXn/yLjbghQ/yuVx/6E0gorCohXkQh8oo8
         J6kGoUBMHa+B5tAP3/OkFKXN3KZ5ukeYohzMac82JV6lRk1OdPvby5gedY7UPtH1YU
         KpYitBxiKM/KRVnLv2nr9gQRgBi9dLo+Mfor8837SV2of7tFX8ztVbkHYpu3JG9nXU
         CvWTR1GGPYbwyEHU7AOY2qpO83q/nbEZdE97jJr3ZqiuR19Luk+SHsa8lp29S4YoMp
         wGZO3/6GfWDp/3VwmxDY2pGtt5mTG6tyddknSXjL2flHY0wYvepqdotMLTbZP7vsmj
         Su5HH0sM2WDtQ==
Received: by mail-ed1-f49.google.com with SMTP id z11so959271ede.1;
        Wed, 01 Feb 2023 22:17:24 -0800 (PST)
X-Gm-Message-State: AO0yUKW1ySA4OcF44rQxnKHHbpDY+qPZMTRFt63sP5tbHmRQ3YRLjD5d
        PVb7xZkzC8m3YEJH17SQdWg3eSQVwA/dnj9pmKU=
X-Google-Smtp-Source: AK7set+hvsuF+zcV0/OBsBn6/jJeEBczdyeQe9Yr+Fmtrt5m6gEqIeWjIa+VQ5b2Wh5DOkGM/8mrGt7hwGn/wOknxfs=
X-Received: by 2002:aa7:c585:0:b0:4a0:e29d:18c9 with SMTP id
 g5-20020aa7c585000000b004a0e29d18c9mr1520324edq.69.1675318642913; Wed, 01 Feb
 2023 22:17:22 -0800 (PST)
MIME-Version: 1.0
References: <20230201064608.3486136-1-guoren@kernel.org> <87tu05pvur.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87tu05pvur.fsf@all.your.base.are.belong.to.us>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 2 Feb 2023 14:17:10 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSj12E9+peMF0rNY_psGDyEG5BbMY6V-s4dK0FpkCC9Yw@mail.gmail.com>
Message-ID: <CAJF2gTSj12E9+peMF0rNY_psGDyEG5BbMY6V-s4dK0FpkCC9Yw@mail.gmail.com>
Subject: Re: [PATCH] riscv: kprobe: Fixup misaligned load text
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     palmer@rivosinc.com, conor.dooley@microchip.com,
        liaochang1@huawei.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Bjorn Topel <bjorn.topel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 1, 2023 at 5:40 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wro=
te:
>
> guoren@kernel.org writes:
>
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The current kprobe would cause a misaligned load for the probe point.
> > This patch fixup it with two half-word loads instead.
> >
> > Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Link: https://lore.kernel.org/linux-riscv/878rhig9zj.fsf@all.your.base.=
are.belong.to.us/
> > Reported-by: Bjorn Topel <bjorn.topel@gmail.com>
> > ---
> >  arch/riscv/kernel/probes/kprobes.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/pro=
bes/kprobes.c
> > index 41c7481afde3..c1160629cef4 100644
> > --- a/arch/riscv/kernel/probes/kprobes.c
> > +++ b/arch/riscv/kernel/probes/kprobes.c
> > @@ -74,7 +74,9 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
> >               return -EILSEQ;
> >
> >       /* copy instruction */
> > -     p->opcode =3D *p->addr;
> > +     p->opcode =3D (kprobe_opcode_t)(*(u16 *)probe_addr);
> > +     if (GET_INSN_LENGTH(p->opcode) =3D=3D 4)
> > +             p->opcode |=3D (kprobe_opcode_t)(*(u16 *)(probe_addr + 2)=
)
> >       << 16;
>
> Ugh, those casts. :-( What about the memcpy variant you had in the other
> thread?
The memcpy version would force load probe_addr + 2. This one would
save an lh operation. The code text guarantees half-word alignment. No
misaligned load happened. Second, kprobe wouldn't write the last half
of 32b instruction.

--=20
Best Regards
 Guo Ren
