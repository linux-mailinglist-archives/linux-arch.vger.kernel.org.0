Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4085252776D
	for <lists+linux-arch@lfdr.de>; Sun, 15 May 2022 14:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbiEOMlh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 May 2022 08:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbiEOMlh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 May 2022 08:41:37 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B414011C0C;
        Sun, 15 May 2022 05:41:32 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id q7so609717plx.3;
        Sun, 15 May 2022 05:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kA3N244HR0B/WxpzUM2TTlWPU7qXJvhWmssUtsOSc8U=;
        b=b5AgYbLXyfXl/XWctvOvnhun+2qT68pBmWthVew4xn7RRPcUxm5I7PMrs//Hq/Rs0W
         V/8h5snrhCxZuRskZ5XivTgOqz0ZXoz21xJge3rV4bLITSV8YxLslgH2wXSCkONgwNrZ
         IiJbwqiK96t3y233KApUYvsL+2FksUWH5tD8G3/pQo9cuRHCPrAlX9kqmDxWzcunTKQc
         s0QEz6TZKWB9xtok/oC/LKSi1mwZLhvE6ngQ3dNaapFtKwd4xCTTsVcF2LAT4Olou/qc
         2pFErHg7itKm/PdmkHVMzhepbGYTeE2Qb+ac0SQJPMjtvlMRJiJf0VWhshohevusQ6k+
         HYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kA3N244HR0B/WxpzUM2TTlWPU7qXJvhWmssUtsOSc8U=;
        b=bQrNYEh81n4TQ8EdZSK9mN/Z3U+0l1YflwpMsGFuQueMEpzm7rclrXlZ3mLQBfsnHG
         lh0NmOuqSxrksTQSnCs3O9ZDam1oSCrMAmsdgUqJGnQ2e5CG0Ht7BYbegrP20F7//qza
         rWS7NGe5EVxq99hOyoo9jXML3K5nUZTyQEt1ip3DINLGK8xUBpboVyYi6cOpTqmrUe5N
         poM0xEpFgK1i3IVLsnxxGSQec/QjQsyt7NO4/8gFoComTqEc/X9OzA+OuzYhb24T7eht
         8yAkQnqH3dLkgGQOF4Jgax86Q7P9VjXcWUmUbiAs+62beIN2cr/6nfUjzUQBDYAbEjYq
         XAvA==
X-Gm-Message-State: AOAM531NMeBhxoHI2N2Yheqde+aiB43iNrW55Owb4QNMV4w39QW5JkbK
        HLcqOVrC5E7JV224LdUMtfo=
X-Google-Smtp-Source: ABdhPJw9AJs02Kuf9vGh0FbjVkrWA/U3EDrwslzHW6wPe/EbCBUrBP7JSaEudGvNFD4wZClR1k5rRw==
X-Received: by 2002:a17:902:bc8c:b0:15e:c103:940c with SMTP id bb12-20020a170902bc8c00b0015ec103940cmr12745187plb.154.1652618492188;
        Sun, 15 May 2022 05:41:32 -0700 (PDT)
Received: from [192.168.43.80] (subs09a-223-255-225-69.three.co.id. [223.255.225.69])
        by smtp.gmail.com with ESMTPSA id o22-20020a17090ac09600b001d9acbc3b4esm4574655pjs.47.2022.05.15.05.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 May 2022 05:41:31 -0700 (PDT)
Message-ID: <64fdb3fc-87bb-53e8-52b5-36288de85cb3@gmail.com>
Date:   Sun, 15 May 2022 19:41:25 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V10 01/22] Documentation: LoongArch: Add basic
 documentations
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
 <20220514080402.2650181-2-chenhuacai@loongson.cn>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220514080402.2650181-2-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/14/22 15:03, Huacai Chen wrote:
> +1. Arithmetic Operation Instructions::
> +
> +    ADD.W SUB.W ADDI.W ADD.D SUB.D ADDI.D
> +    SLT SLTU SLTI SLTUI
> +    AND OR NOR XOR ANDN ORN ANDI ORI XORI
> +    MUL.W MULH.W MULH.WU DIV.W DIV.WU MOD.W MOD.WU
> +    MUL.D MULH.D MULH.DU DIV.D DIV.DU MOD.D MOD.DU
> +    PCADDI PCADDU12I PCADDU18I
> +    LU12I.W LU32I.D LU52I.D ADDU16I.D
> +
> +2. Bit-shift Instructions::
> +
> +    SLL.W SRL.W SRA.W ROTR.W SLLI.W SRLI.W SRAI.W ROTRI.W
> +    SLL.D SRL.D SRA.D ROTR.D SLLI.D SRLI.D SRAI.D ROTRI.D
> +
> +3. Bit-manipulation Instructions::
> +
> +    EXT.W.B EXT.W.H CLO.W CLO.D SLZ.W CLZ.D CTO.W CTO.D CTZ.W CTZ.D
> +    BYTEPICK.W BYTEPICK.D BSTRINS.W BSTRINS.D BSTRPICK.W BSTRPICK.D
> +    REVB.2H REVB.4H REVB.2W REVB.D REVH.2W REVH.D BITREV.4B BITREV.8B BITREV.W BITREV.D
> +    MASKEQZ MASKNEZ
> +
> +4. Branch Instructions::
> +
> +    BEQ BNE BLT BGE BLTU BGEU BEQZ BNEZ B BL JIRL
> +
> +5. Load/Store Instructions::
> +
> +    LD.B LD.BU LD.H LD.HU LD.W LD.WU LD.D ST.B ST.H ST.W ST.D
> +    LDX.B LDX.BU LDX.H LDX.HU LDX.W LDX.WU LDX.D STX.B STX.H STX.W STX.D
> +    LDPTR.W LDPTR.D STPTR.W STPTR.D
> +    PRELD PRELDX
> +
> +6. Atomic Operation Instructions::
> +
> +    LL.W SC.W LL.D SC.D
> +    AMSWAP.W AMSWAP.D AMADD.W AMADD.D AMAND.W AMAND.D AMOR.W AMOR.D AMXOR.W AMXOR.D
> +    AMMAX.W AMMAX.D AMMIN.W AMMIN.D
> +
> +7. Barrier Instructions::
> +
> +    IBAR DBAR
> +
> +8. Special Instructions::
> +
> +    SYSCALL BREAK CPUCFG NOP IDLE ERTN DBCL RDTIMEL.W RDTIMEH.W RDTIME.D ASRTLE.D ASRTGT.D
> +
> +9. Privileged Instructions::
> +
> +    CSRRD CSRWR CSRXCHG
> +    IOCSRRD.B IOCSRRD.H IOCSRRD.W IOCSRRD.D IOCSRWR.B IOCSRWR.H IOCSRWR.W IOCSRWR.D
> +    CACOP TLBP(TLBSRCH) TLBRD TLBWR TLBFILL TLBCLR TLBFLUSH INVTLB LDDIR LDPTE
> +

I haven't addressed this in v9 [1], so I'm discussing it now.

I think for grouping similar instructions lower-level list numbering can
be used, like:

1. Arithmetic Operation Instructions
   a. ADD.W...
   b. SLT...
...

Why is literal blocks used instead?

[1]: https://lore.kernel.org/linux-doc/Ym47ZAuwEA9as98h@debian.me/
-- 
An old man doll... just what I always wanted! - Clara
