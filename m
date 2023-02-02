Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464E1687AFB
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 11:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjBBK71 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 05:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjBBK70 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 05:59:26 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55F76A736
        for <linux-arch@vger.kernel.org>; Thu,  2 Feb 2023 02:59:24 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id m7so1311858wru.8
        for <linux-arch@vger.kernel.org>; Thu, 02 Feb 2023 02:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgTiIPOmBXxBHCBI1SPf1jYsG2ew/s8emelTVcWqHf4=;
        b=P1qpBtdki4WxrIQDdZyF0/6Ft1BgTb9reSHsBkHTObHXZm7BXDLjR1iZ6CotQKJfdE
         /+v+bohLXLLTthPJZoGMqlj4fLH2NKDhoRPv/5fILRZ5vnUkCpX0IPMQEHZ14Bo2YckI
         eoWMZzYBsWEsAlxnhqObjdRaKXU1lXlbFJgLjhBpvgDzSbJyE80azV7nCvx5yA/oO6ay
         M+oQLgFp+H8Q922L2xI9VHWn3bAtwS95NLB/ER+p6JuCPupGAVI2CMLkLOIr+d57wees
         1rSjTmpp3pVeFKBx4gGm60S5b2s2cauSiRELF5/IYI57uXB8rcBjM0nHqJy2sowIUB4g
         Fxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgTiIPOmBXxBHCBI1SPf1jYsG2ew/s8emelTVcWqHf4=;
        b=wPGG419SoGJpR8El94gbHB0sckKCT3pAI2BuDcexTyB7JrF6RFLuS1QHXsZi8EaKNH
         OwTgyf0uJsP2CF4jLu+hkDUn8R6TlXdRBZi5HmI7HT2ywGumWnqomhBQDb68udBx7GhB
         bhC+XcsGeQXkIsaRjq+26rm0ZiwqxHYPYVqmjHYsK+tiO7pwRK8zXKcxWG1kcxeG5Y5a
         +NJPiTaTWbxKFChr1ufBuaozDxTj7V3P/tvv/iEB1ZZY6XQ4iDtK2rn7pyMFd6W2TLVv
         VSX28THieFOjiGIn4M69HuZxXuKKN1CmwxU9bqhF39e4W9zoQnKKifa2vh2LFDWBDLl9
         Gl7A==
X-Gm-Message-State: AO0yUKWtEVyPoAtL8FJPTL5UE8yTNE7Gvy1/CYdHdAaRdlg9zdIa5eRu
        BOjC1JVrTgKNg/b9eGy33hp9WdFXked+mRJOLu98Sw==
X-Google-Smtp-Source: AK7set+pJGkZErNzearfcH92dOwxU8jILjbDFDcwGIsKvNIPaDT8LjSefGTMV9xz/L7MFQEJyTsuUw==
X-Received: by 2002:a05:6000:2:b0:2bf:cbf0:e021 with SMTP id h2-20020a056000000200b002bfcbf0e021mr4738287wrx.71.1675335563311;
        Thu, 02 Feb 2023 02:59:23 -0800 (PST)
Received: from smtpclient.apple (global-5-143.n-2.net.cam.ac.uk. [131.111.5.143])
        by smtp.gmail.com with ESMTPSA id u15-20020a5d6daf000000b002bfe266d710sm1266499wrs.90.2023.02.02.02.59.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Feb 2023 02:59:22 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] riscv: kprobe: Fixup misaligned load text
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <87cz6s75ze.fsf@all.your.base.are.belong.to.us>
Date:   Thu, 2 Feb 2023 10:59:22 +0000
Cc:     Guo Ren <guoren@kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        liaochang1@huawei.com, linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Bjorn Topel <bjorn.topel@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5C373F4A-983E-4ACA-AAB0-54E629D5F501@jrtc27.com>
References: <20230201064608.3486136-1-guoren@kernel.org>
 <87tu05pvur.fsf@all.your.base.are.belong.to.us>
 <CAJF2gTSj12E9+peMF0rNY_psGDyEG5BbMY6V-s4dK0FpkCC9Yw@mail.gmail.com>
 <87cz6s75ze.fsf@all.your.base.are.belong.to.us>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2 Feb 2023, at 09:48, Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wrote:
>=20
> Guo Ren <guoren@kernel.org> writes:
>=20
>> On Wed, Feb 1, 2023 at 5:40 PM Bj=C3=B6rn T=C3=B6pel =
<bjorn@kernel.org> wrote:
>>>=20
>>> guoren@kernel.org writes:
>>>=20
>>>> From: Guo Ren <guoren@linux.alibaba.com>
>>>>=20
>>>> The current kprobe would cause a misaligned load for the probe =
point.
>>>> This patch fixup it with two half-word loads instead.
>>>>=20
>>>> Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
>>>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>>>> Signed-off-by: Guo Ren <guoren@kernel.org>
>>>> Link: =
https://lore.kernel.org/linux-riscv/878rhig9zj.fsf@all.your.base.are.belon=
g.to.us/
>>>> Reported-by: Bjorn Topel <bjorn.topel@gmail.com>
>>>> ---
>>>> arch/riscv/kernel/probes/kprobes.c | 4 +++-
>>>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/arch/riscv/kernel/probes/kprobes.c =
b/arch/riscv/kernel/probes/kprobes.c
>>>> index 41c7481afde3..c1160629cef4 100644
>>>> --- a/arch/riscv/kernel/probes/kprobes.c
>>>> +++ b/arch/riscv/kernel/probes/kprobes.c
>>>> @@ -74,7 +74,9 @@ int __kprobes arch_prepare_kprobe(struct kprobe =
*p)
>>>>              return -EILSEQ;
>>>>=20
>>>>      /* copy instruction */
>>>> -     p->opcode =3D *p->addr;
>>>> +     p->opcode =3D (kprobe_opcode_t)(*(u16 *)probe_addr);
>>>> +     if (GET_INSN_LENGTH(p->opcode) =3D=3D 4)
>>>> +             p->opcode |=3D (kprobe_opcode_t)(*(u16 *)(probe_addr =
+ 2))
>>>>      << 16;
>>>=20
>>> Ugh, those casts. :-( What about the memcpy variant you had in the =
other
>>> thread?
>> The memcpy version would force load probe_addr + 2. This one would
>> save an lh operation. The code text guarantees half-word alignment. =
No
>> misaligned load happened. Second, kprobe wouldn't write the last half
>> of 32b instruction.
>=20
> Ok, something more readable, like:
>=20
> diff --git a/arch/riscv/kernel/probes/kprobes.c =
b/arch/riscv/kernel/probes/kprobes.c
> index f21592d20306..3602352ba175 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -50,14 +50,16 @@ static void __kprobes arch_simulate_insn(struct =
kprobe *p, struct pt_regs *regs)
>=20
> int __kprobes arch_prepare_kprobe(struct kprobe *p)
> {
> -	unsigned long probe_addr =3D (unsigned long)p->addr;
> +	u16 *insn =3D (u16 *)p->addr;
>=20
> -	if (probe_addr & 0x1)
> +	if ((uintptr_t)insn & 0x1)
> 		return -EILSEQ;
>=20
> 	/* copy instruction */
> -	p->opcode =3D *p->addr;
> -
> +	p->opcode =3D *insn++;
> +	if (GET_INSN_LENGTH(p->opcode) =3D=3D 4)
> +		p->opcode |=3D *insn << 16;

*insn gets promoted to int not unsigned so this is UB if bit 15 is set.

Jess

> +=09
> 	/* decode instruction */
> 	switch (riscv_probe_decode_insn(p->addr, &p->ainsn.api)) {
> 	case INSN_REJECTED:	/* insn not supported */
>=20
>=20
> Bj=C3=B6rn
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

