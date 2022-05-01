Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC42351633E
	for <lists+linux-arch@lfdr.de>; Sun,  1 May 2022 10:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbiEAI7A (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 May 2022 04:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbiEAI65 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 1 May 2022 04:58:57 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F646571;
        Sun,  1 May 2022 01:55:25 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id o132so5464832vko.11;
        Sun, 01 May 2022 01:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aOUmnl7BKu1huo7JhRvlC6s5ifyyE6pCVv3geLjblJE=;
        b=iw71wdeVgX/zqOqatNvV37VC5uK48TPq+zz/4eoVern9BMCrd+yw1BVQJhENpcrAY2
         Y6X1JzJ860vYmWLV+Rc8ED2iFlSJhWX9pTmRJxoOThy1cnnNUrgstPJD0mXXCTrs3Ltq
         cIaSTPwONr6lyKL86B1BEP9qA0kA4yKjo8NPmkt04+sH9QNPE2kPUxb8QBmaPW2uE81h
         NHZtiPwQ2ezrLyi+dEY35WkeF49mauv4N/xlLrBVBKmvpScjODdA+zY++S3ht6RDVrv3
         IJUiMixnC3tvHkaQ1TqrMmZsmOkxSfkW5UkWKr3lKS8zCFq5ZZr1Dn72zwiy2dhQbEoC
         c+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aOUmnl7BKu1huo7JhRvlC6s5ifyyE6pCVv3geLjblJE=;
        b=IymEvJ8VLvWky//dDlGZuWB+u6EvE7IuswCPjMrfKUf8cSZGjW2p4NlEKAfd5PN0nX
         tXQg9PB+ZYIVY4KiY9KGNJLzfaemZapI1K3e0QBL780+cTdIGkRqzKv7IUjNPciMKJlf
         V59zctSsJBo4X5sHQUbqFgQDYzMAKoDZMB3H33HJRkc3MxQb80FKsws6/yunYqKClH0A
         +Vf6osoVWSLRPWxfbkpWM2bVjorFw0pENFDkINcWp1OYwzDvHJsgP470koUVCcWEUwl3
         u4KCeQ4qolZxvJ6iNY5Ebhd0snYR6bGTRt+7rZfXczOWHczD0xzSeo+POMvlwQbKZNC1
         /4xQ==
X-Gm-Message-State: AOAM530tqbJ0HNdH4i0PKYGrHWmeOzu/Vkl6uctextqUqHdGI1NE6FWT
        M0Ipy2i+nSiovTU9z+4i2Pi6a9xyj8vPD1jVKiU=
X-Google-Smtp-Source: ABdhPJxS0HQA086kEmfeUwIUB4rXhF25fUjifO/tOBjk288xwlcLd601Qz4wOZZ6JkTl16aFo02CLuudHF0mnMcaPS0=
X-Received: by 2002:a1f:e606:0:b0:34d:76c1:722c with SMTP id
 d6-20020a1fe606000000b0034d76c1722cmr1806372vkh.17.1651395323323; Sun, 01 May
 2022 01:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
 <20220430090518.3127980-2-chenhuacai@loongson.cn> <Ym47ZAuwEA9as98h@debian.me>
In-Reply-To: <Ym47ZAuwEA9as98h@debian.me>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sun, 1 May 2022 16:55:12 +0800
Message-ID: <CAAhV-H4evqhFc+cqPs-6X-CL71aQJ3ZnbVKGPdOfNeuizzAWeg@mail.gmail.com>
Subject: Re: [PATCH V9 01/24] Documentation: LoongArch: Add basic documentations
To:     Bagas Sanjaya <bagasdotme@gmail.com>
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
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Bagas,

On Sun, May 1, 2022 at 3:49 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On Sat, Apr 30, 2022 at 05:04:55PM +0800, Huacai Chen wrote:
> > +Instruction names (Mnemonics)
> > +-----------------------------
> > +
> > +We only list the instruction names here, for details please read the references.
> > +
> > +Arithmetic Operation Instructions::
> > +
> > +  ADD.W SUB.W ADDI.W ADD.D SUB.D ADDI.D
> > +  SLT SLTU SLTI SLTUI
> > +  AND OR NOR XOR ANDN ORN ANDI ORI XORI
> > +  MUL.W MULH.W MULH.WU DIV.W DIV.WU MOD.W MOD.WU
> > +  MUL.D MULH.D MULH.DU DIV.D DIV.DU MOD.D MOD.DU
> > +  PCADDI PCADDU12I PCADDU18I
> > +  LU12I.W LU32I.D LU52I.D ADDU16I.D
> > +
> > +Bit-shift Instructions::
> > +
> > +  SLL.W SRL.W SRA.W ROTR.W SLLI.W SRLI.W SRAI.W ROTRI.W
> > +  SLL.D SRL.D SRA.D ROTR.D SLLI.D SRLI.D SRAI.D ROTRI.D
> > +
> > +Bit-manipulation Instructions::
> > +
> > +  EXT.W.B EXT.W.H CLO.W CLO.D SLZ.W CLZ.D CTO.W CTO.D CTZ.W CTZ.D
> > +  BYTEPICK.W BYTEPICK.D BSTRINS.W BSTRINS.D BSTRPICK.W BSTRPICK.D
> > +  REVB.2H REVB.4H REVB.2W REVB.D REVH.2W REVH.D BITREV.4B BITREV.8B BITREV.W BITREV.D
> > +  MASKEQZ MASKNEZ
> > +
> > +Branch Instructions::
> > +
> > +  BEQ BNE BLT BGE BLTU BGEU BEQZ BNEZ B BL JIRL
> > +
> > +Load/Store Instructions::
> > +
> > +  LD.B LD.BU LD.H LD.HU LD.W LD.WU LD.D ST.B ST.H ST.W ST.D
> > +  LDX.B LDX.BU LDX.H LDX.HU LDX.W LDX.WU LDX.D STX.B STX.H STX.W STX.D
> > +  LDPTR.W LDPTR.D STPTR.W STPTR.D
> > +  PRELD PRELDX
> > +
> > +Atomic Operation Instructions::
> > +
> > +  LL.W SC.W LL.D SC.D
> > +  AMSWAP.W AMSWAP.D AMADD.W AMADD.D AMAND.W AMAND.D AMOR.W AMOR.D AMXOR.W AMXOR.D
> > +  AMMAX.W AMMAX.D AMMIN.W AMMIN.D
> > +
> > +Barrier Instructions::
> > +
> > +  IBAR DBAR
> > +
> > +Special Instructions::
> > +
> > +  SYSCALL BREAK CPUCFG NOP IDLE ERTN DBCL RDTIMEL.W RDTIMEH.W RDTIME.D ASRTLE.D ASRTGT.D
> > +
> > +Privileged Instructions::
> > +
> > +  CSRRD CSRWR CSRXCHG
> > +  IOCSRRD.B IOCSRRD.H IOCSRRD.W IOCSRRD.D IOCSRWR.B IOCSRWR.H IOCSRWR.W IOCSRWR.D
> > +  CACOP TLBP(TLBSRCH) TLBRD TLBWR TLBFILL TLBCLR TLBFLUSH INVTLB LDDIR LDPTE
> > +
>
> Since these above are list of instruction categories, it's better to use
> enumerated lists. Also, make use of ReST labels to link to References
> sections, like this:
OK, thanks, let me try.

Huacai
>
> -- >8 --
>
> diff --git a/Documentation/loongarch/introduction.rst b/Documentation/loongarch/introduction.rst
> index 420c0d2ebcfbe7..2d83283ecf28b9 100644
> --- a/Documentation/loongarch/introduction.rst
> +++ b/Documentation/loongarch/introduction.rst
> @@ -194,60 +194,61 @@ can see I21L/I21H and I26L/I26H here.
>  Instruction names (Mnemonics)
>  -----------------------------
>
> -We only list the instruction names here, for details please read the references.
> +We only list the instruction names here, for details please read the
> +:ref:`references <loongarch-references>`.
>
> -Arithmetic Operation Instructions::
> +1. Arithmetic Operation Instructions::
>
> -  ADD.W SUB.W ADDI.W ADD.D SUB.D ADDI.D
> -  SLT SLTU SLTI SLTUI
> -  AND OR NOR XOR ANDN ORN ANDI ORI XORI
> -  MUL.W MULH.W MULH.WU DIV.W DIV.WU MOD.W MOD.WU
> -  MUL.D MULH.D MULH.DU DIV.D DIV.DU MOD.D MOD.DU
> -  PCADDI PCADDU12I PCADDU18I
> -  LU12I.W LU32I.D LU52I.D ADDU16I.D
> +     ADD.W SUB.W ADDI.W ADD.D SUB.D ADDI.D
> +     SLT SLTU SLTI SLTUI
> +     AND OR NOR XOR ANDN ORN ANDI ORI XORI
> +     MUL.W MULH.W MULH.WU DIV.W DIV.WU MOD.W MOD.WU
> +     MUL.D MULH.D MULH.DU DIV.D DIV.DU MOD.D MOD.DU
> +     PCADDI PCADDU12I PCADDU18I
> +     LU12I.W LU32I.D LU52I.D ADDU16I.D
>
> -Bit-shift Instructions::
> +2. Bit-shift Instructions::
>
> -  SLL.W SRL.W SRA.W ROTR.W SLLI.W SRLI.W SRAI.W ROTRI.W
> -  SLL.D SRL.D SRA.D ROTR.D SLLI.D SRLI.D SRAI.D ROTRI.D
> +     SLL.W SRL.W SRA.W ROTR.W SLLI.W SRLI.W SRAI.W ROTRI.W
> +     SLL.D SRL.D SRA.D ROTR.D SLLI.D SRLI.D SRAI.D ROTRI.D
>
> -Bit-manipulation Instructions::
> +3. Bit-manipulation Instructions::
>
> -  EXT.W.B EXT.W.H CLO.W CLO.D SLZ.W CLZ.D CTO.W CTO.D CTZ.W CTZ.D
> -  BYTEPICK.W BYTEPICK.D BSTRINS.W BSTRINS.D BSTRPICK.W BSTRPICK.D
> -  REVB.2H REVB.4H REVB.2W REVB.D REVH.2W REVH.D BITREV.4B BITREV.8B BITREV.W BITREV.D
> -  MASKEQZ MASKNEZ
> +     EXT.W.B EXT.W.H CLO.W CLO.D SLZ.W CLZ.D CTO.W CTO.D CTZ.W CTZ.D
> +     BYTEPICK.W BYTEPICK.D BSTRINS.W BSTRINS.D BSTRPICK.W BSTRPICK.D
> +     REVB.2H REVB.4H REVB.2W REVB.D REVH.2W REVH.D BITREV.4B BITREV.8B BITREV.W BITREV.D
> +     MASKEQZ MASKNEZ
>
> -Branch Instructions::
> +4. Branch Instructions::
>
> -  BEQ BNE BLT BGE BLTU BGEU BEQZ BNEZ B BL JIRL
> +     BEQ BNE BLT BGE BLTU BGEU BEQZ BNEZ B BL JIRL
>
> -Load/Store Instructions::
> +5. Load/Store Instructions::
>
> -  LD.B LD.BU LD.H LD.HU LD.W LD.WU LD.D ST.B ST.H ST.W ST.D
> -  LDX.B LDX.BU LDX.H LDX.HU LDX.W LDX.WU LDX.D STX.B STX.H STX.W STX.D
> -  LDPTR.W LDPTR.D STPTR.W STPTR.D
> -  PRELD PRELDX
> +     LD.B LD.BU LD.H LD.HU LD.W LD.WU LD.D ST.B ST.H ST.W ST.D
> +     LDX.B LDX.BU LDX.H LDX.HU LDX.W LDX.WU LDX.D STX.B STX.H STX.W STX.D
> +     LDPTR.W LDPTR.D STPTR.W STPTR.D
> +     PRELD PRELDX
>
> -Atomic Operation Instructions::
> +6. Atomic Operation Instructions::
>
> -  LL.W SC.W LL.D SC.D
> -  AMSWAP.W AMSWAP.D AMADD.W AMADD.D AMAND.W AMAND.D AMOR.W AMOR.D AMXOR.W AMXOR.D
> -  AMMAX.W AMMAX.D AMMIN.W AMMIN.D
> +     LL.W SC.W LL.D SC.D
> +     AMSWAP.W AMSWAP.D AMADD.W AMADD.D AMAND.W AMAND.D AMOR.W AMOR.D AMXOR.W AMXOR.D
> +     AMMAX.W AMMAX.D AMMIN.W AMMIN.D
>
> -Barrier Instructions::
> +7. Barrier Instructions::
>
> -  IBAR DBAR
> +     IBAR DBAR
>
> -Special Instructions::
> +8. Special Instructions::
>
> -  SYSCALL BREAK CPUCFG NOP IDLE ERTN DBCL RDTIMEL.W RDTIMEH.W RDTIME.D ASRTLE.D ASRTGT.D
> +     SYSCALL BREAK CPUCFG NOP IDLE ERTN DBCL RDTIMEL.W RDTIMEH.W RDTIME.D ASRTLE.D ASRTGT.D
>
> -Privileged Instructions::
> +9. Privileged Instructions::
>
> -  CSRRD CSRWR CSRXCHG
> -  IOCSRRD.B IOCSRRD.H IOCSRRD.W IOCSRRD.D IOCSRWR.B IOCSRWR.H IOCSRWR.W IOCSRWR.D
> -  CACOP TLBP(TLBSRCH) TLBRD TLBWR TLBFILL TLBCLR TLBFLUSH INVTLB LDDIR LDPTE
> +     CSRRD CSRWR CSRXCHG
> +     IOCSRRD.B IOCSRRD.H IOCSRRD.W IOCSRRD.D IOCSRWR.B IOCSRWR.H IOCSRWR.W IOCSRWR.D
> +     CACOP TLBP(TLBSRCH) TLBRD TLBWR TLBFILL TLBCLR TLBFLUSH INVTLB LDDIR LDPTE
>
>  Virtual Memory
>  ==============
> @@ -315,6 +316,8 @@ MIPS, while New Loongson is based on LoongArch. Take Loongson-3 as an example:
>  Loongson-3A1000/3B1500/3A2000/3A3000/3A4000 are MIPS-compatible, while Loongson-
>  3A5000 (and future revisions) are all based on LoongArch.
>
> +.. _loongarch-references:
> +
>  References
>  ==========
>
>
> > +
> > + +---------------------------------------------+
> > + |::                                           |
> > + |                                             |
> > + |    +-----+     +---------+     +-------+    |
> > + |    | IPI | --> | CPUINTC | <-- | Timer |    |
> > + |    +-----+     +---------+     +-------+    |
> > + |                     ^                       |
> > + |                     |                       |
> > + |                +---------+     +-------+    |
> > + |                | LIOINTC | <-- | UARTs |    |
> > + |                +---------+     +-------+    |
> > + |                     ^                       |
> > + |                     |                       |
> > + |               +-----------+                 |
> > + |               | HTVECINTC |                 |
> > + |               +-----------+                 |
> > + |                ^         ^                  |
> > + |                |         |                  |
> > + |          +---------+ +---------+            |
> > + |          | PCH-PIC | | PCH-MSI |            |
> > + |          +---------+ +---------+            |
> > + |            ^     ^           ^              |
> > + |            |     |           |              |
> > + |    +---------+ +---------+ +---------+      |
> > + |    | PCH-LPC | | Devices | | Devices |      |
> > + |    +---------+ +---------+ +---------+      |
> > + |         ^                                   |
> > + |         |                                   |
> > + |    +---------+                              |
> > + |    | Devices |                              |
> > + |    +---------+                              |
> > + |                                             |
> > + |                                             |
> > + +---------------------------------------------+
> > +
> ...
> > +
> > + +--------------------------------------------------------+
> > + |::                                                      |
> > + |                                                        |
> > + |         +-----+     +---------+     +-------+          |
> > + |         | IPI | --> | CPUINTC | <-- | Timer |          |
> > + |         +-----+     +---------+     +-------+          |
> > + |                      ^       ^                         |
> > + |                      |       |                         |
> > + |               +---------+ +---------+     +-------+    |
> > + |               | EIOINTC | | LIOINTC | <-- | UARTs |    |
> > + |               +---------+ +---------+     +-------+    |
> > + |                ^       ^                               |
> > + |                |       |                               |
> > + |         +---------+ +---------+                        |
> > + |         | PCH-PIC | | PCH-MSI |                        |
> > + |         +---------+ +---------+                        |
> > + |           ^     ^           ^                          |
> > + |           |     |           |                          |
> > + |   +---------+ +---------+ +---------+                  |
> > + |   | PCH-LPC | | Devices | | Devices |                  |
> > + |   +---------+ +---------+ +---------+                  |
> > + |        ^                                               |
> > + |        |                                               |
> > + |   +---------+                                          |
> > + |   | Devices |                                          |
> > + |   +---------+                                          |
> > + |                                                        |
> > + |                                                        |
> > + +--------------------------------------------------------+
> > +
>
> I think just literal blocks is enough for the diagrams above.
>
> --
> An old man doll... just what I always wanted! - Clara
