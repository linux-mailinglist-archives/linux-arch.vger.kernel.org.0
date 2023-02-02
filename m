Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A47068797C
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 10:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjBBJtg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 04:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjBBJtK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 04:49:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CAB87D15;
        Thu,  2 Feb 2023 01:48:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F2B8B82272;
        Thu,  2 Feb 2023 09:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B580C433D2;
        Thu,  2 Feb 2023 09:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675331319;
        bh=WCEiLESm2ErJPjaBal/9ZH056ER36/vOC8v5zxr8nDg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QU3DBFMaYt3H52FCXpQ/dn5eElV6wyf0aO2iEA7WX1mELk6K+v6U3A59kneLz2ZO2
         lbbfzPKKkF5z/N9Qi4Lt0OAHOY0hak5++nTUrREWjXbhuXHELa9TKdYXl8FvhUPBza
         7wmtImjIvVemz6PVlopJmINq3ppHmrnK4vuJaed+TwdLF5K25pJTq8fqNPbSjhLIDY
         SPLp9g4A2kLnaFp9+UmjB3fuv/s07iw6IWMv4AgVGAJ05FjnnU/qOW80J6McKkMCen
         Jax6YD/mIP35BiClLwjh8lTN0G4uXQkj8J9QOkMmciEQMj0BIfDnq0Dxoj3JP+SYgX
         M9tO4ZMtealig==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     palmer@rivosinc.com, conor.dooley@microchip.com,
        liaochang1@huawei.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Bjorn Topel <bjorn.topel@gmail.com>
Subject: Re: [PATCH] riscv: kprobe: Fixup misaligned load text
In-Reply-To: <CAJF2gTSj12E9+peMF0rNY_psGDyEG5BbMY6V-s4dK0FpkCC9Yw@mail.gmail.com>
References: <20230201064608.3486136-1-guoren@kernel.org>
 <87tu05pvur.fsf@all.your.base.are.belong.to.us>
 <CAJF2gTSj12E9+peMF0rNY_psGDyEG5BbMY6V-s4dK0FpkCC9Yw@mail.gmail.com>
Date:   Thu, 02 Feb 2023 10:48:37 +0100
Message-ID: <87cz6s75ze.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Guo Ren <guoren@kernel.org> writes:

> On Wed, Feb 1, 2023 at 5:40 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> w=
rote:
>>
>> guoren@kernel.org writes:
>>
>> > From: Guo Ren <guoren@linux.alibaba.com>
>> >
>> > The current kprobe would cause a misaligned load for the probe point.
>> > This patch fixup it with two half-word loads instead.
>> >
>> > Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
>> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>> > Signed-off-by: Guo Ren <guoren@kernel.org>
>> > Link: https://lore.kernel.org/linux-riscv/878rhig9zj.fsf@all.your.base=
.are.belong.to.us/
>> > Reported-by: Bjorn Topel <bjorn.topel@gmail.com>
>> > ---
>> >  arch/riscv/kernel/probes/kprobes.c | 4 +++-
>> >  1 file changed, 3 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/pr=
obes/kprobes.c
>> > index 41c7481afde3..c1160629cef4 100644
>> > --- a/arch/riscv/kernel/probes/kprobes.c
>> > +++ b/arch/riscv/kernel/probes/kprobes.c
>> > @@ -74,7 +74,9 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>> >               return -EILSEQ;
>> >
>> >       /* copy instruction */
>> > -     p->opcode =3D *p->addr;
>> > +     p->opcode =3D (kprobe_opcode_t)(*(u16 *)probe_addr);
>> > +     if (GET_INSN_LENGTH(p->opcode) =3D=3D 4)
>> > +             p->opcode |=3D (kprobe_opcode_t)(*(u16 *)(probe_addr + 2=
))
>> >       << 16;
>>
>> Ugh, those casts. :-( What about the memcpy variant you had in the other
>> thread?
> The memcpy version would force load probe_addr + 2. This one would
> save an lh operation. The code text guarantees half-word alignment. No
> misaligned load happened. Second, kprobe wouldn't write the last half
> of 32b instruction.

Ok, something more readable, like:

diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/=
kprobes.c
index f21592d20306..3602352ba175 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -50,14 +50,16 @@ static void __kprobes arch_simulate_insn(struct kprobe =
*p, struct pt_regs *regs)
=20
 int __kprobes arch_prepare_kprobe(struct kprobe *p)
 {
-	unsigned long probe_addr =3D (unsigned long)p->addr;
+	u16 *insn =3D (u16 *)p->addr;
=20
-	if (probe_addr & 0x1)
+	if ((uintptr_t)insn & 0x1)
 		return -EILSEQ;
=20
 	/* copy instruction */
-	p->opcode =3D *p->addr;
-
+	p->opcode =3D *insn++;
+	if (GET_INSN_LENGTH(p->opcode) =3D=3D 4)
+		p->opcode |=3D *insn << 16;
+=09
 	/* decode instruction */
 	switch (riscv_probe_decode_insn(p->addr, &p->ainsn.api)) {
 	case INSN_REJECTED:	/* insn not supported */


Bj=C3=B6rn
