Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A950B60B0CC
	for <lists+linux-arch@lfdr.de>; Mon, 24 Oct 2022 18:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbiJXQKf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Oct 2022 12:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbiJXQJZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2022 12:09:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737DC7C774;
        Mon, 24 Oct 2022 08:00:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5879E6141B;
        Mon, 24 Oct 2022 14:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AE7C433C1;
        Mon, 24 Oct 2022 14:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666623444;
        bh=LindwTh1Qo/AddyyMTSjL+f1nvZgRAp36VOMRzg29oA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eYjAqYSUIwikiCrj7DRRL1Pl+MtegPrEI1QLpVXB/vqvdj9Ai3181YEGyn/fG40nJ
         VRFHKU9NuVPnimOW0VWuisrR1DNsM/U4KyQvd7dTkYMJM8LZ/91/sMyKlVolfY7EdZ
         eF7O71qj4Tssz7A3bcfl3ZUmPzbhl4Lcd7K60H1A9nqnf6mpKU2kya2OpyiK0/9SEe
         vVBDoS13Pv4tLuKtOtdPrsWAtghyn1pV3YTZdeicuLggG8GBf0vwrMvkBhOlQtxNV0
         1fOrycgy2lhA2CJaJ3UTVhyjhCVwgpE6BDtiionr/ZL5k+PA6mBDcbn5Z+VMNPIlQq
         szGL3tDMlkgKw==
Received: by mail-ej1-f50.google.com with SMTP id d26so5570177eje.10;
        Mon, 24 Oct 2022 07:57:24 -0700 (PDT)
X-Gm-Message-State: ACrzQf2+jQH9U9ZACNoUZHa1+3eQB6mhNYDtAHppxLIDXqxwrF5PdXmZ
        iaioer7bMB+IdGF5ZR8z1NH6y9PcszqT79Omgng=
X-Google-Smtp-Source: AMsMyM69fW1BoHun8j01PT52mt1XyUsFvBqhn1jerBOkQHz7pmyhr0PJR/MyIR05LZZJXrd6W66gm/5NbyWHv1ZIEw0=
X-Received: by 2002:a17:907:2cf7:b0:78d:c7fc:29ff with SMTP id
 hz23-20020a1709072cf700b0078dc7fc29ffmr28621933ejc.748.1666623442612; Mon, 24
 Oct 2022 07:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221024070438.306820-1-chenhuacai@loongson.cn> <adac75f5-e49e-0f63-c106-08c24050137f@loongson.cn>
In-Reply-To: <adac75f5-e49e-0f63-c106-08c24050137f@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 24 Oct 2022 22:57:08 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4jD_QOPrOAUHfdZ2oH8QtCtw=m5XXYfKSWyuyf_bT8jw@mail.gmail.com>
Message-ID: <CAAhV-H4jD_QOPrOAUHfdZ2oH8QtCtw=m5XXYfKSWyuyf_bT8jw@mail.gmail.com>
Subject: Re: [PATCH 1/2] LoongArch: Add alternative runtime patching mechanism
To:     Jinyang He <hejinyang@loongson.cn>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, Jun Yi <yijun@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Jinyang,

On Mon, Oct 24, 2022 at 8:51 PM Jinyang He <hejinyang@loongson.cn> wrote:
>
> Hi, Huacai,
>
>
> On 2022/10/24 =E4=B8=8B=E5=8D=883:04, Huacai Chen wrote:
> > Introduce the "alternative" mechanism from ARM64 and x86 for LoongArch
> > to apply runtime patching. The main purpose of this patch is to provide
> > a framework. In future we can use this mechanism (i.e., the ALTERNATIVE
> > and ALTERNATIVE_2 macros) to optimize hotspot functions according to cp=
u
> > features.
> >
> > Signed-off-by: Jun Yi <yijun@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   arch/loongarch/include/asm/alternative-asm.h |  82 ++++++
> >   arch/loongarch/include/asm/alternative.h     | 176 ++++++++++++
> >   arch/loongarch/include/asm/bugs.h            |  15 ++
> >   arch/loongarch/include/asm/inst.h            |  10 +
> >   arch/loongarch/kernel/Makefile               |   2 +-
> >   arch/loongarch/kernel/alternative.c          | 266 ++++++++++++++++++=
+
> >   arch/loongarch/kernel/module.c               |  16 ++
> >   arch/loongarch/kernel/setup.c                |   7 +
> >   arch/loongarch/kernel/vmlinux.lds.S          |  12 +
> >   9 files changed, 585 insertions(+), 1 deletion(-)
> >   create mode 100644 arch/loongarch/include/asm/alternative-asm.h
> >   create mode 100644 arch/loongarch/include/asm/alternative.h
> >   create mode 100644 arch/loongarch/include/asm/bugs.h
> >   create mode 100644 arch/loongarch/kernel/alternative.c
> >
> > diff --git a/arch/loongarch/include/asm/alternative-asm.h b/arch/loonga=
rch/include/asm/alternative-asm.h
> > new file mode 100644
> > index 000000000000..f0f32ace29b1
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/alternative-asm.h
> > @@ -0,0 +1,82 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_ALTERNATIVE_ASM_H
> > +#define _ASM_ALTERNATIVE_ASM_H
> > +
> > +#ifdef __ASSEMBLY__
> > +
> > +#include <asm/asm.h>
> > +
> > +/*
> > + * Issue one struct alt_instr descriptor entry (need to put it into
> > + * the section .altinstructions, see below). This entry contains
> > + * enough information for the alternatives patching code to patch an
> > + * instruction. See apply_alternatives().
> > + */
> > +.macro altinstruction_entry orig alt feature orig_len alt_len
> > +     .long \orig - .
> > +     .long \alt - .
> > +     .2byte \feature
> > +     .byte \orig_len
> > +     .byte \alt_len
> I tried '.byte 256' and gas warned but still finished compiling.
>   " warning: value 0x0000000000000100 truncated to 0x0000000000000000 "
> How about add '.if .error .endif' here to check the length.
I think a warning is just enough.

> > +.endm
> > +
> > +/*
> > + * Define an alternative between two instructions. If @feature is
> > + * present, early code in apply_alternatives() replaces @oldinstr with
> > + * @newinstr. ".fill" directive takes care of proper instruction paddi=
ng
> > + * in case @newinstr is longer than @oldinstr.
> > + */
> > +.macro ALTERNATIVE oldinstr, newinstr, feature
> > +140 :
> > +     \oldinstr
> > +141 :
> > +     .fill - (((144f-143f)-(141b-140b)) > 0) * ((144f-143f)-(141b-140b=
)) / 4, 4, 0x03400000
> > +142 :
> > +
> > +     .pushsection .altinstructions, "a"
> > +     altinstruction_entry 140b, 143f, \feature, 142b-140b, 144f-143f
> > +     .popsection
> > +
> > +     .subsection 1
> > +143 :
> > +     \newinstr
> > +144 :
> > +     .previous
> > +.endm
> > +
> > +#define old_len                      (141b-140b)
> > +#define new_len1             (144f-143f)
> > +#define new_len2             (145f-144f)
> > +
> > +#define alt_max_short(a, b)  ((a) ^ (((a) ^ (b)) & -(-((a) < (b)))))
> > +
> > +/*
> > + * Same as ALTERNATIVE macro above but for two alternatives. If CPU
> > + * has @feature1, it replaces @oldinstr with @newinstr1. If CPU has
> > + * @feature2, it replaces @oldinstr with @feature2.
> > + */
> > +.macro ALTERNATIVE_2 oldinstr, newinstr1, feature1, newinstr2, feature=
2
> > +140 :
> > +     \oldinstr
> > +141 :
> > +     .fill - ((alt_max_short(new_len1, new_len2) - (old_len)) > 0) * \
> > +             (alt_max_short(new_len1, new_len2) - (old_len)) / 4, 4, 0=
x03400000
> > +142 :
> > +
> > +     .pushsection .altinstructions, "a"
> > +     altinstruction_entry 140b, 143f, \feature1, 142b-140b, 144f-143f,=
 142b-141b
> > +     altinstruction_entry 140b, 144f, \feature2, 142b-140b, 145f-144f,=
 142b-141b
> > +     .popsection
> > +
> > +     .subsection 1
> > +143 :
> > +     \newinstr1
> > +144 :
> > +     \newinstr2
> > +145 :
> > +     .previous
> > +.endm
> > +
> > +#endif  /*  __ASSEMBLY__  */
> > +
> > +#endif /* _ASM_ALTERNATIVE_ASM_H */
> > diff --git a/arch/loongarch/include/asm/alternative.h b/arch/loongarch/=
include/asm/alternative.h
> > new file mode 100644
> > index 000000000000..b4fe66c7067e
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/alternative.h
> > @@ -0,0 +1,176 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_ALTERNATIVE_H
> > +#define _ASM_ALTERNATIVE_H
> > +
> > +#ifndef __ASSEMBLY__
> > +
> > +#include <linux/types.h>
> > +#include <linux/stddef.h>
> > +#include <linux/stringify.h>
> > +#include <asm/asm.h>
> > +
> > +struct alt_instr {
> > +     s32 instr_offset;       /* offset to original instruction */
> > +     s32 replace_offset;     /* offset to replacement instruction */
> > +     u16 feature;            /* feature bit set for replacement */
> > +     u8  instrlen;           /* length of original instruction */
> > +     u8  replacementlen;     /* length of new instruction */
> > +} __packed;
> > +
> > +/*
> > + * Debug flag that can be tested to see whether alternative
> > + * instructions were patched in already:
> > + */
> > +extern int alternatives_patched;
> > +extern struct alt_instr __alt_instructions[], __alt_instructions_end[]=
;
> > +
> > +extern void alternative_instructions(void);
> > +extern void apply_alternatives(struct alt_instr *start, struct alt_ins=
tr *end);
> > +
> > +#define b_replacement(num)   "664"#num
> > +#define e_replacement(num)   "665"#num
> > +
> > +#define alt_end_marker               "663"
> > +#define alt_slen             "662b-661b"
> > +#define alt_total_slen               alt_end_marker"b-661b"
> > +#define alt_rlen(num)                e_replacement(num)"f-"b_replaceme=
nt(num)"f"
> > +
> > +#define __OLDINSTR(oldinstr, num)                                    \
> > +     "661:\n\t" oldinstr "\n662:\n"                                  \
> > +     ".fill -(((" alt_rlen(num) ")-(" alt_slen ")) > 0) * "          \
> > +             "((" alt_rlen(num) ")-(" alt_slen ")) / 4, 4, 0x03400000\=
n"
> > +
> > +#define OLDINSTR(oldinstr, num)                                       =
       \
> > +     __OLDINSTR(oldinstr, num)                                       \
> > +     alt_end_marker ":\n"
> > +
> > +#define alt_max_short(a, b)  "((" a ") ^ (((" a ") ^ (" b ")) & -(-(("=
 a ") < (" b ")))))"
> > +
> > +/*
> > + * Pad the second replacement alternative with additional NOPs if it i=
s
> > + * additionally longer than the first replacement alternative.
> > + */
> > +#define OLDINSTR_2(oldinstr, num1, num2) \
> > +     "661:\n\t" oldinstr "\n662:\n"                                   =
                       \
> > +     ".fill -((" alt_max_short(alt_rlen(num1), alt_rlen(num2)) " - (" =
alt_slen ")) > 0) * "  \
> > +             "(" alt_max_short(alt_rlen(num1), alt_rlen(num2)) " - (" =
alt_slen ")) / 4, "    \
> > +             "4, 0x03400000\n"       \
> > +     alt_end_marker ":\n"
> > +
> > +#define ALTINSTR_ENTRY(feature, num)                                  =
     \
> > +     " .long 661b - .\n"                             /* label         =
  */ \
> > +     " .long " b_replacement(num)"f - .\n"           /* new instructio=
n */ \
> > +     " .2byte " __stringify(feature) "\n"            /* feature bit   =
  */ \
> > +     " .byte " alt_total_slen "\n"                   /* source len    =
  */ \
> > +     " .byte " alt_rlen(num) "\n"                    /* replacement le=
n */
> > +
> > +#define ALTINSTR_REPLACEMENT(newinstr, feature, num) /* replacement */=
     \
> > +     b_replacement(num)":\n\t" newinstr "\n" e_replacement(num) ":\n\t=
"
> > +
> > +/* alternative assembly primitive: */
> > +#define ALTERNATIVE(oldinstr, newinstr, feature)                     \
> > +     OLDINSTR(oldinstr, 1)                                           \
> > +     ".pushsection .altinstructions,\"a\"\n"                         \
> > +     ALTINSTR_ENTRY(feature, 1)                                      \
> > +     ".popsection\n"                                                 \
> > +     ".subsection 1\n" \
> > +     ALTINSTR_REPLACEMENT(newinstr, feature, 1)                      \
> > +     ".previous\n"
> > +
> > +#define ALTERNATIVE_2(oldinstr, newinstr1, feature1, newinstr2, featur=
e2)\
> > +     OLDINSTR_2(oldinstr, 1, 2)                                      \
> > +     ".pushsection .altinstructions,\"a\"\n"                         \
> > +     ALTINSTR_ENTRY(feature1, 1)                                     \
> > +     ALTINSTR_ENTRY(feature2, 2)                                     \
> > +     ".popsection\n"                                                 \
> > +     ".subsection 1\n" \
> > +     ALTINSTR_REPLACEMENT(newinstr1, feature1, 1)                    \
> > +     ALTINSTR_REPLACEMENT(newinstr2, feature2, 2)                    \
> > +     ".previous\n"
> > +
> > +/*
> > + * Alternative instructions for different CPU types or capabilities.
> > + *
> > + * This allows to use optimized instructions even on generic binary
> > + * kernels.
> > + *
> > + * length of oldinstr must be longer or equal the length of newinstr
> > + * It can be padded with nops as needed.
> > + *
> > + * For non barrier like inlines please define new variants
> > + * without volatile and memory clobber.
> > + */
> > +#define alternative(oldinstr, newinstr, feature)                     \
> > +     (asm volatile (ALTERNATIVE(oldinstr, newinstr, feature) : : : "me=
mory"))
> > +
> > +#define alternative_2(oldinstr, newinstr1, feature1, newinstr2, featur=
e2) \
> > +     (asm volatile(ALTERNATIVE_2(oldinstr, newinstr1, feature1, newins=
tr2, feature2) ::: "memory"))
> > +
> > +/*
> > + * Alternative inline assembly with input.
> > + *
> > + * Pecularities:
> > + * No memory clobber here.
> > + * Argument numbers start with 1.
> > + * Best is to use constraints that are fixed size (like (%1) ... "r")
> > + * If you use variable sized constraints like "m" or "g" in the
> > + * replacement make sure to pad to the worst case length.
> > + * Leaving an unused argument 0 to keep API compatibility.
> > + */
> > +#define alternative_input(oldinstr, newinstr, feature, input...)     \
> > +     (asm volatile (ALTERNATIVE(oldinstr, newinstr, feature)         \
> > +             : : "i" (0), ## input))
> > +
> > +/*
> > + * This is similar to alternative_input. But it has two features and
> > + * respective instructions.
> > + *
> > + * If CPU has feature2, newinstr2 is used.
> > + * Otherwise, if CPU has feature1, newinstr1 is used.
> > + * Otherwise, oldinstr is used.
> > + */
> > +#define alternative_input_2(oldinstr, newinstr1, feature1, newinstr2, =
            \
> > +                        feature2, input...)                           =
    \
> > +     (asm volatile(ALTERNATIVE_2(oldinstr, newinstr1, feature1,       =
    \
> > +             newinstr2, feature2)                                     =
    \
> > +             : : "i" (0), ## input))
> > +
> > +/* Like alternative_input, but with a single output argument */
> > +#define alternative_io(oldinstr, newinstr, feature, output, input...) =
       \
> > +     (asm volatile (ALTERNATIVE(oldinstr, newinstr, feature)         \
> > +             : output : "i" (0), ## input))
> > +
> > +/* Like alternative_io, but for replacing a direct call with another o=
ne. */
> > +#define alternative_call(oldfunc, newfunc, feature, output, input...) =
       \
> > +     (asm volatile (ALTERNATIVE("call %P[old]", "call %P[new]", featur=
e) \
>
> Not 'call' but 'bl'? And IMHO it is better to separate these patches
> to several patches and convenient for code review. Such as this patch,
> the 'ALTERNATIVE_2' and 'C inline assembly' is not used in [patch2/2],
> these features can be added after [patch2/2] or in the future.
OK, unused macros will be removed at this time, and be added in future.

>
>
> > +             : output : [old] "i" (oldfunc), [new] "i" (newfunc), ## i=
nput))
> > +
> > +/*
> > + * Like alternative_call, but there are two features and respective fu=
nctions.
> > + * If CPU has feature2, function2 is used.
> > + * Otherwise, if CPU has feature1, function1 is used.
> > + * Otherwise, old function is used.
> > + */
> > +#define alternative_call_2(oldfunc, newfunc1, feature1, newfunc2, feat=
ure2,   \
> > +                        output, input...)                             =
     \
> > +     (asm volatile (ALTERNATIVE_2("call %P[old]", "call %P[new1]", fea=
ture1,\
> > +             "call %P[new2]", feature2)                               =
     \
> > +             : output, ASM_CALL_CONSTRAINT                            =
     \
> > +             : [old] "i" (oldfunc), [new1] "i" (newfunc1),            =
     \
> > +               [new2] "i" (newfunc2), ## input))
> > +
> > +/*
> > + * use this macro(s) if you need more than one output parameter
> > + * in alternative_io
> > + */
> > +#define ASM_OUTPUT2(a...) a
> > +
> > +/*
> > + * use this macro if you need clobbers but no inputs in
> > + * alternative_{input,io,call}()
> > + */
> > +#define ASM_NO_INPUT_CLOBBER(clbr...) "i" (0) : clbr
> > +
> > +#endif /* __ASSEMBLY__ */
> > +
> > +#endif /* _ASM_ALTERNATIVE_H */
> > diff --git a/arch/loongarch/include/asm/bugs.h b/arch/loongarch/include=
/asm/bugs.h
> > new file mode 100644
> > index 000000000000..651fffe1f743
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/bugs.h
> > @@ -0,0 +1,15 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * This is included by init/main.c to check for architecture-dependent=
 bugs.
> > + *
> > + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_BUGS_H
> > +#define _ASM_BUGS_H
> > +
> > +#include <asm/cpu.h>
> > +#include <asm/cpu-info.h>
> > +
> > +extern void check_bugs(void);
> > +
> > +#endif /* _ASM_BUGS_H */
> > diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include=
/asm/inst.h
> > index 889d6c9fc2b6..bd4c116aa73d 100644
> > --- a/arch/loongarch/include/asm/inst.h
> > +++ b/arch/loongarch/include/asm/inst.h
> > @@ -8,6 +8,7 @@
> >   #include <linux/types.h>
> >   #include <asm/asm.h>
> >
> > +#define INSN_NOP             0x03400000
> >   #define INSN_BREAK          0x002a0000
> >
> >   #define ADDR_IMMMASK_LU52ID 0xFFF0000000000000
> > @@ -28,6 +29,7 @@ enum reg0i26_op {
> >   enum reg1i20_op {
> >       lu12iw_op       =3D 0x0a,
> >       lu32id_op       =3D 0x0b,
> > +     pcaddi_op       =3D 0x0c,
> >       pcaddu12i_op    =3D 0x0e,
> >       pcaddu18i_op    =3D 0x0f,
> >   };
> > @@ -35,6 +37,8 @@ enum reg1i20_op {
> >   enum reg1i21_op {
> >       beqz_op         =3D 0x10,
> >       bnez_op         =3D 0x11,
> > +     bceqz_op        =3D 0x12,
> > +     bcnez_op        =3D 0x12,
> >   };
> >
> >   enum reg2_op {
> > @@ -315,6 +319,12 @@ static inline bool is_imm_negative(unsigned long v=
al, unsigned int bit)
> >       return val & (1UL << (bit - 1));
> >   }
> >
> > +static inline bool is_pc_ins(union loongarch_instruction *ip)
> > +{
> > +     return ip->reg1i20_format.opcode >=3D pcaddi_op &&
> > +                     ip->reg1i20_format.opcode <=3D pcaddu18i_op;
> > +}
> > +
> >   static inline bool is_branch_ins(union loongarch_instruction *ip)
> >   {
> >       return ip->reg1i21_format.opcode >=3D beqz_op &&
> > diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Mak=
efile
> > index 2ad2555b53ea..86744531b100 100644
> > --- a/arch/loongarch/kernel/Makefile
> > +++ b/arch/loongarch/kernel/Makefile
> > @@ -8,7 +8,7 @@ extra-y               :=3D vmlinux.lds
> >   obj-y               +=3D head.o cpu-probe.o cacheinfo.o env.o setup.o=
 entry.o genex.o \
> >                  traps.o irq.o idle.o process.o dma.o mem.o io.o reset.=
o switch.o \
> >                  elf.o syscall.o signal.o time.o topology.o inst.o ptra=
ce.o vdso.o \
> > -                unaligned.o
> > +                alternative.o unaligned.o
> >
> >   obj-$(CONFIG_ACPI)          +=3D acpi.o
> >   obj-$(CONFIG_EFI)           +=3D efi.o
> > diff --git a/arch/loongarch/kernel/alternative.c b/arch/loongarch/kerne=
l/alternative.c
> > new file mode 100644
> > index 000000000000..43434150b853
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/alternative.c
> > @@ -0,0 +1,263 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include <linux/mm.h>
> > +#include <linux/module.h>
> > +#include <asm/alternative.h>
> > +#include <asm/cacheflush.h>
> > +#include <asm/inst.h>
> > +#include <asm/sections.h>
> > +
> > +int __read_mostly alternatives_patched;
> > +
> > +EXPORT_SYMBOL_GPL(alternatives_patched);
> > +
> > +#define MAX_PATCH_SIZE (((u8)(-1)) / LOONGARCH_INSN_SIZE)
> > +
> > +static int __initdata_or_module debug_alternative;
> > +
> > +static int __init debug_alt(char *str)
> > +{
> > +     debug_alternative =3D 1;
> > +     return 1;
> > +}
> > +__setup("debug-alternative", debug_alt);
> > +
> > +#define DPRINTK(fmt, args...)                                         =
       \
> > +do {                                                                 \
> > +     if (debug_alternative)                                          \
> > +             printk(KERN_DEBUG "%s: " fmt "\n", __func__, ##args);   \
> > +} while (0)
> > +
> > +#define DUMP_WORDS(buf, count, fmt, args...)                         \
> > +do {                                                                 \
> > +     if (unlikely(debug_alternative)) {                              \
> > +             int _j;                                                 \
> > +             union loongarch_instruction *_buf =3D buf;               =
 \
> > +                                                                     \
> > +             if (!(count))                                           \
> > +                     break;                                          \
> > +                                                                     \
> > +             printk(KERN_DEBUG fmt, ##args);                         \
> > +             for (_j =3D 0; _j < count - 1; _j++)                     =
 \
> > +                     printk(KERN_CONT "<%08x> ", _buf[_j].word);     \
> > +             printk(KERN_CONT "<%08x>\n", _buf[_j].word);            \
> > +     }                                                               \
> > +} while (0)
> > +
> > +#define __SIGNEX(X, SIDX) ((X) >=3D (1 << SIDX) ? ~((1 << SIDX) - 1) |=
 (X) : (X))
> > +#define SIGNEX16(X) __SIGNEX(((unsigned long)(X)), 15)
> > +#define SIGNEX20(X) __SIGNEX(((unsigned long)(X)), 19)
> > +#define SIGNEX21(X) __SIGNEX(((unsigned long)(X)), 20)
> > +#define SIGNEX26(X) __SIGNEX(((unsigned long)(X)), 25)
> > +
> > +static inline unsigned long bs_dest_16(unsigned long now, unsigned int=
 si)
> > +{
> > +     return now + (SIGNEX16(si) << 2);
> > +}
> > +
> > +static inline unsigned long bs_dest_21(unsigned long now, unsigned int=
 h, unsigned int l)
> > +{
> > +     return now + (SIGNEX21(h << 16 | l) << 2);
> > +}
> > +
> > +static inline unsigned long bs_dest_26(unsigned long now, unsigned int=
 h, unsigned int l)
> > +{
> > +     return now + (SIGNEX26(h << 16 | l) << 2);
> > +}
> > +
> > +/* Use this to add nops to a buffer, then text_poke the whole buffer. =
*/
> > +static void __init_or_module add_nops(union loongarch_instruction *ins=
n, int count)
> > +{
> > +     while (count--) {
> > +             insn->word =3D INSN_NOP;
> > +             insn++;
> > +     }
> > +}
> > +
> > +/* Is the jump addr in local .altinstructions */
> > +static inline bool in_alt_jump(unsigned long jump, void *start, void *=
end)
> > +{
> > +     return jump >=3D (unsigned long)start && jump < (unsigned long)en=
d;
> > +}
> > +
> > +static void __init_or_module recompute_jump(union loongarch_instructio=
n *buf,
> > +             union loongarch_instruction *dest, union loongarch_instru=
ction *src,
> > +             void *start, void *end)
> > +{
> > +     unsigned int si, si_l, si_h;
> > +     unsigned long cur_pc, jump_addr, pc;
> > +     long offset;
> > +
> > +     cur_pc =3D (unsigned long)src;
> > +     pc =3D (unsigned long)dest;
> > +
> > +     si_l =3D src->reg0i26_format.immediate_l;
> > +     si_h =3D src->reg0i26_format.immediate_h;
> > +     switch (src->reg0i26_format.opcode) {
> > +     case b_op:
> > +     case bl_op:
> > +             jump_addr =3D bs_dest_26(cur_pc, si_h, si_l);
> > +             if (in_alt_jump(jump_addr, start, end))
> > +                     return;
> > +             offset =3D jump_addr - pc;
> > +             BUG_ON(offset < -SZ_128M || offset >=3D SZ_128M);
> > +             offset >>=3D 2;
> > +             buf->reg0i26_format.immediate_h =3D offset >> 16;
> > +             buf->reg0i26_format.immediate_l =3D offset;
> > +             return;
> > +     }
> > +
> > +     si_l =3D src->reg1i21_format.immediate_l;
> > +     si_h =3D src->reg1i21_format.immediate_h;
> > +     switch (src->reg1i21_format.opcode) {
> > +     case beqz_op:
> > +     case bnez_op:
> > +     case bceqz_op:
> > +             jump_addr =3D bs_dest_21(cur_pc, si_h, si_l);
> > +             if (in_alt_jump(jump_addr, start, end))
> > +                     return;
> > +             offset =3D jump_addr - pc;
> > +             BUG_ON(offset < -SZ_4M || offset >=3D SZ_4M);
> > +             offset >>=3D 2;
> > +             buf->reg1i21_format.immediate_h =3D offset >> 16;
> > +             buf->reg1i21_format.immediate_l =3D offset;
> > +             return;
> > +     }
> > +
> > +     si =3D src->reg2i16_format.immediate;
> > +     switch (src->reg2i16_format.opcode) {
> > +     case beq_op:
> > +     case bne_op:
> > +     case blt_op:
> > +     case bge_op:
> > +     case bltu_op:
> > +     case bgeu_op:
> > +             jump_addr =3D bs_dest_16(cur_pc, si);
> > +             if (in_alt_jump(jump_addr, start, end))
> > +                     return;
> > +             offset =3D jump_addr - pc;
> > +             BUG_ON(offset < -SZ_128K || offset >=3D SZ_128K);
> > +             offset >>=3D 2;
> > +                buf->reg2i16_format.immediate =3D offset;
>
> code indent should use tabs where possible
OK, thanks.

>
>
> > +             return;
> > +     }
> > +}
> > +
> > +static int __init_or_module copy_alt_insns(union loongarch_instruction=
 *buf,
> > +     union loongarch_instruction *dest, union loongarch_instruction *s=
rc, int nr)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < nr; i++) {
> > +             buf[i].word =3D src[i].word;
> > +
> > +             if (is_branch_ins(&src[i]) &&
> > +                 src[i].reg2i16_format.opcode !=3D jirl_op) {
> > +                     recompute_jump(&buf[i], &dest[i], &src[i], src, s=
rc + nr);
> > +             } else if (is_pc_ins(&src[i])) {
> > +                     pr_err("Not support pcrel instruction at present!=
");
> > +                     return -EINVAL;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * text_poke_early - Update instructions on a live kernel at boot time
> > + *
> > + * When you use this code to patch more than one byte of an instructio=
n
> > + * you need to make sure that other CPUs cannot execute this code in p=
arallel.
> > + * Also no thread must be currently preempted in the middle of these
> > + * instructions. And on the local CPU you need to be protected again N=
MI or MCE
> > + * handlers seeing an inconsistent instruction while you patch.
> > + */
> > +static void *__init_or_module text_poke_early(union loongarch_instruct=
ion *insn,
> > +                           union loongarch_instruction *buf, unsigned =
int nr)
> > +{
> > +     int i;
> > +     unsigned long flags;
> > +
> > +     local_irq_save(flags);
> > +
> > +     for (i =3D 0; i < nr; i++)
> > +             insn[i].word =3D buf[i].word;
> > +
> > +     local_irq_restore(flags);
> > +
> > +     wbflush();
> > +     flush_icache_range((unsigned long)insn, (unsigned long)(insn + nr=
));
>
> nr * LOONGARCH_INSN_SIZE
insn is a pointer, so (insn + nr) is just OK.

Huacai
>
>
> Thanks,
>
> Jinyang
>
>
> > +
> > +     return insn;
> > +}
> > +
> > +/*
> > + * Replace instructions with better alternatives for this CPU type. Th=
is runs
> > + * before SMP is initialized to avoid SMP problems with self modifying=
 code.
> > + * This implies that asymmetric systems where APs have less capabiliti=
es than
> > + * the boot processor are not handled. Tough. Make sure you disable su=
ch
> > + * features by hand.
> > + */
> > +void __init_or_module apply_alternatives(struct alt_instr *start, stru=
ct alt_instr *end)
> > +{
> > +     struct alt_instr *a;
> > +     unsigned int nr_instr, nr_repl, nr_insnbuf;
> > +     union loongarch_instruction *instr, *replacement;
> > +     union loongarch_instruction insnbuf[MAX_PATCH_SIZE];
> > +
> > +     DPRINTK("alt table %px, -> %px", start, end);
> > +     /*
> > +      * The scan order should be from start to end. A later scanned
> > +      * alternative code can overwrite previously scanned alternative =
code.
> > +      * Some kernel functions (e.g. memcpy, memset, etc) use this orde=
r to
> > +      * patch code.
> > +      *
> > +      * So be careful if you want to change the scan order to any othe=
r
> > +      * order.
> > +      */
> > +     for (a =3D start; a < end; a++) {
> > +             nr_insnbuf =3D 0;
> > +
> > +             instr =3D (void *)&a->instr_offset + a->instr_offset;
> > +             replacement =3D (void *)&a->replace_offset + a->replace_o=
ffset;
> > +
> > +             BUG_ON(a->instrlen > sizeof(insnbuf));
> > +             BUG_ON(a->instrlen & 0x3);
> > +             BUG_ON(a->replacementlen & 0x3);
> > +
> > +             nr_instr =3D a->instrlen / LOONGARCH_INSN_SIZE;
> > +             nr_repl =3D a->replacementlen / LOONGARCH_INSN_SIZE;
> > +
> > +             if (!cpu_has(a->feature)) {
> > +                     DPRINTK("feat not exist: %d, old: (%px len: %d), =
repl: (%px, len: %d)",
> > +                             a->feature, instr, a->instrlen,
> > +                             replacement, a->replacementlen);
> > +
> > +                     continue;
> > +             }
> > +
> > +             DPRINTK("feat: %d, old: (%px len: %d), repl: (%px, len: %=
d)",
> > +                     a->feature, instr, a->instrlen,
> > +                     replacement, a->replacementlen);
> > +
> > +             DUMP_WORDS(instr, nr_instr, "%px: old_insn: ", instr);
> > +             DUMP_WORDS(replacement, nr_repl, "%px: rpl_insn: ", repla=
cement);
> > +
> > +             copy_alt_insns(insnbuf, instr, replacement, nr_repl);
> > +             nr_insnbuf =3D nr_repl;
> > +
> > +             if (nr_instr > nr_repl) {
> > +                     add_nops(insnbuf + nr_repl, nr_instr - nr_repl);
> > +                     nr_insnbuf +=3D nr_instr - nr_repl;
> > +             }
> > +             DUMP_WORDS(insnbuf, nr_insnbuf, "%px: final_insn: ", inst=
r);
> > +
> > +             text_poke_early(instr, insnbuf, nr_insnbuf);
> > +     }
> > +}
> > +
> > +void __init alternative_instructions(void)
> > +{
> > +     apply_alternatives(__alt_instructions, __alt_instructions_end);
> > +
> > +     alternatives_patched =3D 1;
> > +}
> > diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/mod=
ule.c
> > index 097595b2fc14..669e750917a3 100644
> > --- a/arch/loongarch/kernel/module.c
> > +++ b/arch/loongarch/kernel/module.c
> > @@ -17,6 +17,7 @@
> >   #include <linux/fs.h>
> >   #include <linux/string.h>
> >   #include <linux/kernel.h>
> > +#include <asm/alternative.h>
> >
> >   static int rela_stack_push(s64 stack_value, s64 *rela_stack, size_t *=
rela_stack_top)
> >   {
> > @@ -456,3 +457,18 @@ void *module_alloc(unsigned long size)
> >       return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
> >                       GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE, __built=
in_return_address(0));
> >   }
> > +
> > +int module_finalize(const Elf_Ehdr *hdr,
> > +                 const Elf_Shdr *sechdrs,
> > +                 struct module *mod)
> > +{
> > +     const Elf_Shdr *s, *se;
> > +     const char *secstrs =3D (void *)hdr + sechdrs[hdr->e_shstrndx].sh=
_offset;
> > +
> > +     for (s =3D sechdrs, se =3D sechdrs + hdr->e_shnum; s < se; s++) {
> > +             if (!strcmp(".altinstructions", secstrs + s->sh_name))
> > +                     apply_alternatives((void *)s->sh_addr, (void *)s-=
>sh_addr + s->sh_size);
> > +     }
> > +
> > +     return 0;
> > +}
> > diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setu=
p.c
> > index 1eb63fa9bc81..96b6cb5db004 100644
> > --- a/arch/loongarch/kernel/setup.c
> > +++ b/arch/loongarch/kernel/setup.c
> > @@ -31,7 +31,9 @@
> >   #include <linux/swiotlb.h>
> >
> >   #include <asm/addrspace.h>
> > +#include <asm/alternative.h>
> >   #include <asm/bootinfo.h>
> > +#include <asm/bugs.h>
> >   #include <asm/cache.h>
> >   #include <asm/cpu.h>
> >   #include <asm/dma.h>
> > @@ -80,6 +82,11 @@ const char *get_system_type(void)
> >       return "generic-loongson-machine";
> >   }
> >
> > +void __init check_bugs(void)
> > +{
> > +     alternative_instructions();
> > +}
> > +
> >   static const char *dmi_string_parse(const struct dmi_header *dm, u8 s=
)
> >   {
> >       const u8 *bp =3D ((u8 *) dm) + dm->length;
> > diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kerne=
l/vmlinux.lds.S
> > index efecda0c2361..733b16e8d55d 100644
> > --- a/arch/loongarch/kernel/vmlinux.lds.S
> > +++ b/arch/loongarch/kernel/vmlinux.lds.S
> > @@ -54,6 +54,18 @@ SECTIONS
> >       . =3D ALIGN(PECOFF_SEGMENT_ALIGN);
> >       _etext =3D .;
> >
> > +     /*
> > +      * struct alt_inst entries. From the header (alternative.h):
> > +      * "Alternative instructions for different CPU types or capabilit=
ies"
> > +      * Think locking instructions on spinlocks.
> > +      */
> > +     . =3D ALIGN(4);
> > +     .altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
> > +             __alt_instructions =3D .;
> > +             *(.altinstructions)
> > +             __alt_instructions_end =3D .;
> > +     }
> > +
> >       .got : ALIGN(16) { *(.got) }
> >       .plt : ALIGN(16) { *(.plt) }
> >       .got.plt : ALIGN(16) { *(.got.plt) }
>
