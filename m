Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31045277C6
	for <lists+linux-arch@lfdr.de>; Sun, 15 May 2022 15:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236869AbiEONPK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 May 2022 09:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236794AbiEONPJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 May 2022 09:15:09 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6F8DF71;
        Sun, 15 May 2022 06:15:04 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id d22so12951403vsf.2;
        Sun, 15 May 2022 06:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WAPeaO30oY8HxsJjDCCSe6DnypewD0vJ8Q8mCbsz5x4=;
        b=KQJzb4vunmqglXYZsnETujeDPXVTXp2AZA3JPEqYtEn6YHkEPbYEha3aJrKhvXJ/Eg
         DzK1dPx4Wt9bqe9O1c3betzjzCBt2O+urucg3kXgdRE2eNhT9MXa4/jUtkBQFX2karW8
         LBvlI+dPaeFa3T9M8pwVchApnWfLROPXRGjl1khBRkMExDHRv8qloK4DggVlp6IuHfVK
         GbMgZKPspU5E+eGE26cdi74Wa/inZO0g/7qFeK7vMkejFtYKXCY0pgJRVkYJOJ3lA6gd
         X/T0NN32vOG3TgIG+nP8laNKfYeBLis/tCYrYj8DsVDZslvkTPBKuCe4+RVSkD/as5fN
         +vLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WAPeaO30oY8HxsJjDCCSe6DnypewD0vJ8Q8mCbsz5x4=;
        b=UXuMBf238564TSiWyBRVwrfXIqo880Tiz8WXDxqaagOkg9flfTGRtF1VUILmSGNDI5
         Bb8NsBnpFjrJRWdUcIHq87A9SH9/UIi80Z02T2GYs+r5Ko8h8oTUm7+9443KReoI76vU
         empc2FbcR6oUacsfILQPMLEgZvDT+U9rT18C4WH1cl1UMl/uRFWUOq0yVOababn5Ga/k
         iVM/zYB499kH7U+HA3an7Oq4GCi3JRS6MfVh+Q81g10dpbUeHzjRmOHl3G0wv+HwElht
         KBTcZGOAcg+iU0mnADb9n91xaeMNqcgyMJsGkGbnfXKMpD4TktgGNn4W4tnf2zO+oM6N
         z7Jg==
X-Gm-Message-State: AOAM5323L9Eph7RmQcH/A3nCUzr0ASH3FhehCuRBZPvGJQ7UX4/KUGsd
        1Fluc2haaai6+RauUSriD795nZqORjbEzKaUnBQ=
X-Google-Smtp-Source: ABdhPJwuPxSfQTZYZicIZ23dKd9YUFEA8Ho9530posT/H0xeF3lXAQkm/i7ae27AwWgpuR0YcvmPFEOVUntfxmWhBpc=
X-Received: by 2002:a67:be0b:0:b0:32c:d82f:6723 with SMTP id
 x11-20020a67be0b000000b0032cd82f6723mr5246684vsq.67.1652620503426; Sun, 15
 May 2022 06:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
 <20220514080402.2650181-2-chenhuacai@loongson.cn> <64fdb3fc-87bb-53e8-52b5-36288de85cb3@gmail.com>
In-Reply-To: <64fdb3fc-87bb-53e8-52b5-36288de85cb3@gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sun, 15 May 2022 21:14:52 +0800
Message-ID: <CAAhV-H7eFJriSHmU+BqTJXWaKa99-c-81t2nH1h-ceSH_4K6+w@mail.gmail.com>
Subject: Re: [PATCH V10 01/22] Documentation: LoongArch: Add basic documentations
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
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
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

On Sun, May 15, 2022 at 8:41 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 5/14/22 15:03, Huacai Chen wrote:
> > +1. Arithmetic Operation Instructions::
> > +
> > +    ADD.W SUB.W ADDI.W ADD.D SUB.D ADDI.D
> > +    SLT SLTU SLTI SLTUI
> > +    AND OR NOR XOR ANDN ORN ANDI ORI XORI
> > +    MUL.W MULH.W MULH.WU DIV.W DIV.WU MOD.W MOD.WU
> > +    MUL.D MULH.D MULH.DU DIV.D DIV.DU MOD.D MOD.DU
> > +    PCADDI PCADDU12I PCADDU18I
> > +    LU12I.W LU32I.D LU52I.D ADDU16I.D
> > +
> > +2. Bit-shift Instructions::
> > +
> > +    SLL.W SRL.W SRA.W ROTR.W SLLI.W SRLI.W SRAI.W ROTRI.W
> > +    SLL.D SRL.D SRA.D ROTR.D SLLI.D SRLI.D SRAI.D ROTRI.D
> > +
> > +3. Bit-manipulation Instructions::
> > +
> > +    EXT.W.B EXT.W.H CLO.W CLO.D SLZ.W CLZ.D CTO.W CTO.D CTZ.W CTZ.D
> > +    BYTEPICK.W BYTEPICK.D BSTRINS.W BSTRINS.D BSTRPICK.W BSTRPICK.D
> > +    REVB.2H REVB.4H REVB.2W REVB.D REVH.2W REVH.D BITREV.4B BITREV.8B BITREV.W BITREV.D
> > +    MASKEQZ MASKNEZ
> > +
> > +4. Branch Instructions::
> > +
> > +    BEQ BNE BLT BGE BLTU BGEU BEQZ BNEZ B BL JIRL
> > +
> > +5. Load/Store Instructions::
> > +
> > +    LD.B LD.BU LD.H LD.HU LD.W LD.WU LD.D ST.B ST.H ST.W ST.D
> > +    LDX.B LDX.BU LDX.H LDX.HU LDX.W LDX.WU LDX.D STX.B STX.H STX.W STX.D
> > +    LDPTR.W LDPTR.D STPTR.W STPTR.D
> > +    PRELD PRELDX
> > +
> > +6. Atomic Operation Instructions::
> > +
> > +    LL.W SC.W LL.D SC.D
> > +    AMSWAP.W AMSWAP.D AMADD.W AMADD.D AMAND.W AMAND.D AMOR.W AMOR.D AMXOR.W AMXOR.D
> > +    AMMAX.W AMMAX.D AMMIN.W AMMIN.D
> > +
> > +7. Barrier Instructions::
> > +
> > +    IBAR DBAR
> > +
> > +8. Special Instructions::
> > +
> > +    SYSCALL BREAK CPUCFG NOP IDLE ERTN DBCL RDTIMEL.W RDTIMEH.W RDTIME.D ASRTLE.D ASRTGT.D
> > +
> > +9. Privileged Instructions::
> > +
> > +    CSRRD CSRWR CSRXCHG
> > +    IOCSRRD.B IOCSRRD.H IOCSRRD.W IOCSRRD.D IOCSRWR.B IOCSRWR.H IOCSRWR.W IOCSRWR.D
> > +    CACOP TLBP(TLBSRCH) TLBRD TLBWR TLBFILL TLBCLR TLBFLUSH INVTLB LDDIR LDPTE
> > +
>
> I haven't addressed this in v9 [1], so I'm discussing it now.
>
> I think for grouping similar instructions lower-level list numbering can
> be used, like:
>
> 1. Arithmetic Operation Instructions
>    a. ADD.W...
>    b. SLT...
> ...
>
> Why is literal blocks used instead?
Because the instructions listed are not classified in a group. Thanks.

Huacai
>
> [1]: https://lore.kernel.org/linux-doc/Ym47ZAuwEA9as98h@debian.me/
> --
> An old man doll... just what I always wanted! - Clara
