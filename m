Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B995751627F
	for <lists+linux-arch@lfdr.de>; Sun,  1 May 2022 09:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiEAHw3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 May 2022 03:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiEAHw2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 1 May 2022 03:52:28 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7FE644FF;
        Sun,  1 May 2022 00:49:00 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id c14so1320891pfn.2;
        Sun, 01 May 2022 00:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9D3Lq5XH8cX+mqYobQY1M2p3jmqiyGiPW3euMYQWOT8=;
        b=ZmUmKkKK9b0SVZSmOqpxfa9onXASYC2QO3zoKOi4zoO6FuAD25w+k0wN5UcBfYhrWt
         QVBgKwtfJW/xPc0WWU/IY+PTKL8CnPx2SOPzwrZeU6wQQ2Xye0UT46+2RO68ZFGiUcJ0
         1TtU5B0oLg0UuvrcA08z70tlSLGyzzbYnPwkeU8RB16QrVG9qR20hV5LXzdj/w77TXj6
         n9ZviMICkzStKo43k/gBcXz3//KBQnKcRfT5j49BoARO8x+4bCiUyg/+ebU3btA9oZ/O
         9rffQeotJ5ik7//UV7pVSF+RRQ2SfiJ+KhLl8Y3LMzm1adrYTNpNPGQzhaQpo5GOMz0j
         J8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9D3Lq5XH8cX+mqYobQY1M2p3jmqiyGiPW3euMYQWOT8=;
        b=KcDZDbmWy2F4Oa0jWCjvjsaEe8YHGbcbbJW+N10mgFUmLXOqVKgFyUGmyeLON1RQH3
         SVZ68+AjGvV9C+7w4ZfKAQ6j3BA2jIPeb+r/6H9ln1WgJmhGeqamgoJSTX0rxTMrQch3
         gcD2FS3ZV4EYu3fjVMrHxbUbS+e0U2oOnQsU4EHkzIXttTKJbbTQS5jmO4Z1qvZLEF+x
         y4usw0dp/t/+jIXiu15W+iR93RqFMSEwAHg8BdpNaCX4ZHZ3uDNFJgCCjlNNSh1FmSmh
         kbwSbPJgFTFe5v5TrnusFbV7xjT2uJfq1vr9kAIU2VR1jBmLf0QUdGKnbf8mXDWjHlx3
         cw6A==
X-Gm-Message-State: AOAM530MK8gkg0EnJDV+zc/VR3U8H85toDxOUe7bnyLbz6gEHYKkjfnj
        gcMoMQkhtJ1Xo+ZlQ41tya4=
X-Google-Smtp-Source: ABdhPJz7+aEQApAcZSxqL0LX+yKaYkSBSiJMv+AAU1Rr4qKVY3SXBnJdFDCxUgXz9e5nGQfm75POVQ==
X-Received: by 2002:a63:9141:0:b0:3ab:ea6:694d with SMTP id l62-20020a639141000000b003ab0ea6694dmr5571486pge.49.1651391339850;
        Sun, 01 May 2022 00:48:59 -0700 (PDT)
Received: from localhost (subs09b-223-255-225-231.three.co.id. [223.255.225.231])
        by smtp.gmail.com with ESMTPSA id n25-20020a62e519000000b0050dc7628182sm2575418pff.92.2022.05.01.00.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 00:48:59 -0700 (PDT)
Date:   Sun, 1 May 2022 14:48:52 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V9 01/24] Documentation: LoongArch: Add basic
 documentations
Message-ID: <Ym47ZAuwEA9as98h@debian.me>
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
 <20220430090518.3127980-2-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220430090518.3127980-2-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Apr 30, 2022 at 05:04:55PM +0800, Huacai Chen wrote:
> +Instruction names (Mnemonics)
> +-----------------------------
> +
> +We only list the instruction names here, for details please read the references.
> +
> +Arithmetic Operation Instructions::
> +
> +  ADD.W SUB.W ADDI.W ADD.D SUB.D ADDI.D
> +  SLT SLTU SLTI SLTUI
> +  AND OR NOR XOR ANDN ORN ANDI ORI XORI
> +  MUL.W MULH.W MULH.WU DIV.W DIV.WU MOD.W MOD.WU
> +  MUL.D MULH.D MULH.DU DIV.D DIV.DU MOD.D MOD.DU
> +  PCADDI PCADDU12I PCADDU18I
> +  LU12I.W LU32I.D LU52I.D ADDU16I.D
> +
> +Bit-shift Instructions::
> +
> +  SLL.W SRL.W SRA.W ROTR.W SLLI.W SRLI.W SRAI.W ROTRI.W
> +  SLL.D SRL.D SRA.D ROTR.D SLLI.D SRLI.D SRAI.D ROTRI.D
> +
> +Bit-manipulation Instructions::
> +
> +  EXT.W.B EXT.W.H CLO.W CLO.D SLZ.W CLZ.D CTO.W CTO.D CTZ.W CTZ.D
> +  BYTEPICK.W BYTEPICK.D BSTRINS.W BSTRINS.D BSTRPICK.W BSTRPICK.D
> +  REVB.2H REVB.4H REVB.2W REVB.D REVH.2W REVH.D BITREV.4B BITREV.8B BITREV.W BITREV.D
> +  MASKEQZ MASKNEZ
> +
> +Branch Instructions::
> +
> +  BEQ BNE BLT BGE BLTU BGEU BEQZ BNEZ B BL JIRL
> +
> +Load/Store Instructions::
> +
> +  LD.B LD.BU LD.H LD.HU LD.W LD.WU LD.D ST.B ST.H ST.W ST.D
> +  LDX.B LDX.BU LDX.H LDX.HU LDX.W LDX.WU LDX.D STX.B STX.H STX.W STX.D
> +  LDPTR.W LDPTR.D STPTR.W STPTR.D
> +  PRELD PRELDX
> +
> +Atomic Operation Instructions::
> +
> +  LL.W SC.W LL.D SC.D
> +  AMSWAP.W AMSWAP.D AMADD.W AMADD.D AMAND.W AMAND.D AMOR.W AMOR.D AMXOR.W AMXOR.D
> +  AMMAX.W AMMAX.D AMMIN.W AMMIN.D
> +
> +Barrier Instructions::
> +
> +  IBAR DBAR
> +
> +Special Instructions::
> +
> +  SYSCALL BREAK CPUCFG NOP IDLE ERTN DBCL RDTIMEL.W RDTIMEH.W RDTIME.D ASRTLE.D ASRTGT.D
> +
> +Privileged Instructions::
> +
> +  CSRRD CSRWR CSRXCHG
> +  IOCSRRD.B IOCSRRD.H IOCSRRD.W IOCSRRD.D IOCSRWR.B IOCSRWR.H IOCSRWR.W IOCSRWR.D
> +  CACOP TLBP(TLBSRCH) TLBRD TLBWR TLBFILL TLBCLR TLBFLUSH INVTLB LDDIR LDPTE
> +

Since these above are list of instruction categories, it's better to use
enumerated lists. Also, make use of ReST labels to link to References
sections, like this:

-- >8 --

diff --git a/Documentation/loongarch/introduction.rst b/Documentation/loongarch/introduction.rst
index 420c0d2ebcfbe7..2d83283ecf28b9 100644
--- a/Documentation/loongarch/introduction.rst
+++ b/Documentation/loongarch/introduction.rst
@@ -194,60 +194,61 @@ can see I21L/I21H and I26L/I26H here.
 Instruction names (Mnemonics)
 -----------------------------
 
-We only list the instruction names here, for details please read the references.
+We only list the instruction names here, for details please read the
+:ref:`references <loongarch-references>`.
 
-Arithmetic Operation Instructions::
+1. Arithmetic Operation Instructions::
 
-  ADD.W SUB.W ADDI.W ADD.D SUB.D ADDI.D
-  SLT SLTU SLTI SLTUI
-  AND OR NOR XOR ANDN ORN ANDI ORI XORI
-  MUL.W MULH.W MULH.WU DIV.W DIV.WU MOD.W MOD.WU
-  MUL.D MULH.D MULH.DU DIV.D DIV.DU MOD.D MOD.DU
-  PCADDI PCADDU12I PCADDU18I
-  LU12I.W LU32I.D LU52I.D ADDU16I.D
+     ADD.W SUB.W ADDI.W ADD.D SUB.D ADDI.D
+     SLT SLTU SLTI SLTUI
+     AND OR NOR XOR ANDN ORN ANDI ORI XORI
+     MUL.W MULH.W MULH.WU DIV.W DIV.WU MOD.W MOD.WU
+     MUL.D MULH.D MULH.DU DIV.D DIV.DU MOD.D MOD.DU
+     PCADDI PCADDU12I PCADDU18I
+     LU12I.W LU32I.D LU52I.D ADDU16I.D
 
-Bit-shift Instructions::
+2. Bit-shift Instructions::
 
-  SLL.W SRL.W SRA.W ROTR.W SLLI.W SRLI.W SRAI.W ROTRI.W
-  SLL.D SRL.D SRA.D ROTR.D SLLI.D SRLI.D SRAI.D ROTRI.D
+     SLL.W SRL.W SRA.W ROTR.W SLLI.W SRLI.W SRAI.W ROTRI.W
+     SLL.D SRL.D SRA.D ROTR.D SLLI.D SRLI.D SRAI.D ROTRI.D
 
-Bit-manipulation Instructions::
+3. Bit-manipulation Instructions::
 
-  EXT.W.B EXT.W.H CLO.W CLO.D SLZ.W CLZ.D CTO.W CTO.D CTZ.W CTZ.D
-  BYTEPICK.W BYTEPICK.D BSTRINS.W BSTRINS.D BSTRPICK.W BSTRPICK.D
-  REVB.2H REVB.4H REVB.2W REVB.D REVH.2W REVH.D BITREV.4B BITREV.8B BITREV.W BITREV.D
-  MASKEQZ MASKNEZ
+     EXT.W.B EXT.W.H CLO.W CLO.D SLZ.W CLZ.D CTO.W CTO.D CTZ.W CTZ.D
+     BYTEPICK.W BYTEPICK.D BSTRINS.W BSTRINS.D BSTRPICK.W BSTRPICK.D
+     REVB.2H REVB.4H REVB.2W REVB.D REVH.2W REVH.D BITREV.4B BITREV.8B BITREV.W BITREV.D
+     MASKEQZ MASKNEZ
 
-Branch Instructions::
+4. Branch Instructions::
 
-  BEQ BNE BLT BGE BLTU BGEU BEQZ BNEZ B BL JIRL
+     BEQ BNE BLT BGE BLTU BGEU BEQZ BNEZ B BL JIRL
 
-Load/Store Instructions::
+5. Load/Store Instructions::
 
-  LD.B LD.BU LD.H LD.HU LD.W LD.WU LD.D ST.B ST.H ST.W ST.D
-  LDX.B LDX.BU LDX.H LDX.HU LDX.W LDX.WU LDX.D STX.B STX.H STX.W STX.D
-  LDPTR.W LDPTR.D STPTR.W STPTR.D
-  PRELD PRELDX
+     LD.B LD.BU LD.H LD.HU LD.W LD.WU LD.D ST.B ST.H ST.W ST.D
+     LDX.B LDX.BU LDX.H LDX.HU LDX.W LDX.WU LDX.D STX.B STX.H STX.W STX.D
+     LDPTR.W LDPTR.D STPTR.W STPTR.D
+     PRELD PRELDX
 
-Atomic Operation Instructions::
+6. Atomic Operation Instructions::
 
-  LL.W SC.W LL.D SC.D
-  AMSWAP.W AMSWAP.D AMADD.W AMADD.D AMAND.W AMAND.D AMOR.W AMOR.D AMXOR.W AMXOR.D
-  AMMAX.W AMMAX.D AMMIN.W AMMIN.D
+     LL.W SC.W LL.D SC.D
+     AMSWAP.W AMSWAP.D AMADD.W AMADD.D AMAND.W AMAND.D AMOR.W AMOR.D AMXOR.W AMXOR.D
+     AMMAX.W AMMAX.D AMMIN.W AMMIN.D
 
-Barrier Instructions::
+7. Barrier Instructions::
 
-  IBAR DBAR
+     IBAR DBAR
 
-Special Instructions::
+8. Special Instructions::
 
-  SYSCALL BREAK CPUCFG NOP IDLE ERTN DBCL RDTIMEL.W RDTIMEH.W RDTIME.D ASRTLE.D ASRTGT.D
+     SYSCALL BREAK CPUCFG NOP IDLE ERTN DBCL RDTIMEL.W RDTIMEH.W RDTIME.D ASRTLE.D ASRTGT.D
 
-Privileged Instructions::
+9. Privileged Instructions::
 
-  CSRRD CSRWR CSRXCHG
-  IOCSRRD.B IOCSRRD.H IOCSRRD.W IOCSRRD.D IOCSRWR.B IOCSRWR.H IOCSRWR.W IOCSRWR.D
-  CACOP TLBP(TLBSRCH) TLBRD TLBWR TLBFILL TLBCLR TLBFLUSH INVTLB LDDIR LDPTE
+     CSRRD CSRWR CSRXCHG
+     IOCSRRD.B IOCSRRD.H IOCSRRD.W IOCSRRD.D IOCSRWR.B IOCSRWR.H IOCSRWR.W IOCSRWR.D
+     CACOP TLBP(TLBSRCH) TLBRD TLBWR TLBFILL TLBCLR TLBFLUSH INVTLB LDDIR LDPTE
 
 Virtual Memory
 ==============
@@ -315,6 +316,8 @@ MIPS, while New Loongson is based on LoongArch. Take Loongson-3 as an example:
 Loongson-3A1000/3B1500/3A2000/3A3000/3A4000 are MIPS-compatible, while Loongson-
 3A5000 (and future revisions) are all based on LoongArch.
 
+.. _loongarch-references:
+
 References
 ==========
 

> +
> + +---------------------------------------------+
> + |::                                           |
> + |                                             |
> + |    +-----+     +---------+     +-------+    |
> + |    | IPI | --> | CPUINTC | <-- | Timer |    |
> + |    +-----+     +---------+     +-------+    |
> + |                     ^                       |
> + |                     |                       |
> + |                +---------+     +-------+    |
> + |                | LIOINTC | <-- | UARTs |    |
> + |                +---------+     +-------+    |
> + |                     ^                       |
> + |                     |                       |
> + |               +-----------+                 |
> + |               | HTVECINTC |                 |
> + |               +-----------+                 |
> + |                ^         ^                  |
> + |                |         |                  |
> + |          +---------+ +---------+            |
> + |          | PCH-PIC | | PCH-MSI |            |
> + |          +---------+ +---------+            |
> + |            ^     ^           ^              |
> + |            |     |           |              |
> + |    +---------+ +---------+ +---------+      |
> + |    | PCH-LPC | | Devices | | Devices |      |
> + |    +---------+ +---------+ +---------+      |
> + |         ^                                   |
> + |         |                                   |
> + |    +---------+                              |
> + |    | Devices |                              |
> + |    +---------+                              |
> + |                                             |
> + |                                             |
> + +---------------------------------------------+
> +
...
> +
> + +--------------------------------------------------------+
> + |::                                                      |
> + |                                                        |
> + |         +-----+     +---------+     +-------+          |
> + |         | IPI | --> | CPUINTC | <-- | Timer |          |
> + |         +-----+     +---------+     +-------+          |
> + |                      ^       ^                         |
> + |                      |       |                         |
> + |               +---------+ +---------+     +-------+    |
> + |               | EIOINTC | | LIOINTC | <-- | UARTs |    |
> + |               +---------+ +---------+     +-------+    |
> + |                ^       ^                               |
> + |                |       |                               |
> + |         +---------+ +---------+                        |
> + |         | PCH-PIC | | PCH-MSI |                        |
> + |         +---------+ +---------+                        |
> + |           ^     ^           ^                          |
> + |           |     |           |                          |
> + |   +---------+ +---------+ +---------+                  |
> + |   | PCH-LPC | | Devices | | Devices |                  |
> + |   +---------+ +---------+ +---------+                  |
> + |        ^                                               |
> + |        |                                               |
> + |   +---------+                                          |
> + |   | Devices |                                          |
> + |   +---------+                                          |
> + |                                                        |
> + |                                                        |
> + +--------------------------------------------------------+
> +

I think just literal blocks is enough for the diagrams above.

-- 
An old man doll... just what I always wanted! - Clara
