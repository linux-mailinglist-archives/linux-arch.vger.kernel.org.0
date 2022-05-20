Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FB552E66E
	for <lists+linux-arch@lfdr.de>; Fri, 20 May 2022 09:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346543AbiETHoG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 May 2022 03:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345214AbiETHoF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 May 2022 03:44:05 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0768B14B66E;
        Fri, 20 May 2022 00:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1653032636; bh=x0xYa0LBezZirht7lUcewcXV5yh8eIpA525zzxAMvGA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VISIawV2pPCwtOe0dYAob+msSevvQeSQRtd3ijyHSnEmzffFzbERxutuhycAgl4FA
         Jdmcar87TZuBGeE1rq9Fx0wWWiR5WQN3Qy0D7kh7O50Nv+LQcXoiqgtA52wNXYmbgf
         EALoiGqj7FZrOG4DlPa8l1PGT9FvixJKjAyOYYjA=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id CACC760074;
        Fri, 20 May 2022 15:43:55 +0800 (CST)
Message-ID: <28ff0ebb-5344-1bdb-5ae0-2bc4bd5ec812@xen0n.name>
Date:   Fri, 20 May 2022 15:43:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0a1
Subject: Re: [PATCH V11 02/22] Documentation/zh_CN: Add basic LoongArch
 documentations
To:     Guo Ren <guoren@kernel.org>, Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alex Shi <alexs@kernel.org>
References: <20220518092619.1269111-1-chenhuacai@loongson.cn>
 <20220518092619.1269111-3-chenhuacai@loongson.cn>
 <CAJF2gTSO0DA2tv+MhdygRZ2JDDS8mPTGpSFAugutVNH-+Usv4w@mail.gmail.com>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAJF2gTSO0DA2tv+MhdygRZ2JDDS8mPTGpSFAugutVNH-+Usv4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 5/20/22 15:37, Guo Ren wrote:
> On Wed, May 18, 2022 at 5:27 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
>> [snip]
>>
>> +
>> +指令列表
>> +--------
>> +
>> +为了简便起见，我们在此只罗列一下指令名称（助记符），需要详细信息请阅读
>> +:ref:`参考文献 <loongarch-references-zh_CN>` 中的文档。
>> +
>> +1. 算术运算指令::
>> +
>> +    ADD.W SUB.W ADDI.W ADD.D SUB.D ADDI.D
>> +    SLT SLTU SLTI SLTUI
>> +    AND OR NOR XOR ANDN ORN ANDI ORI XORI
>> +    MUL.W MULH.W MULH.WU DIV.W DIV.WU MOD.W MOD.WU
>> +    MUL.D MULH.D MULH.DU DIV.D DIV.DU MOD.D MOD.DU
>> +    PCADDI PCADDU12I PCADDU18I
>> +    LU12I.W LU32I.D LU52I.D ADDU16I.D
>> +
>> +2. 移位运算指令::
>> +
>> +    SLL.W SRL.W SRA.W ROTR.W SLLI.W SRLI.W SRAI.W ROTRI.W
>> +    SLL.D SRL.D SRA.D ROTR.D SLLI.D SRLI.D SRAI.D ROTRI.D
>> +
>> +3. 位域操作指令::
>> +
>> +    EXT.W.B EXT.W.H CLO.W CLO.D SLZ.W CLZ.D CTO.W CTO.D CTZ.W CTZ.D
>> +    BYTEPICK.W BYTEPICK.D BSTRINS.W BSTRINS.D BSTRPICK.W BSTRPICK.D
>> +    REVB.2H REVB.4H REVB.2W REVB.D REVH.2W REVH.D BITREV.4B BITREV.8B BITREV.W BITREV.D
>> +    MASKEQZ MASKNEZ
>> +
>> +4. 分支转移指令::
>> +
>> +    BEQ BNE BLT BGE BLTU BGEU BEQZ BNEZ B BL JIRL
>> +
>> +5. 访存读写指令::
>> +
>> +    LD.B LD.BU LD.H LD.HU LD.W LD.WU LD.D ST.B ST.H ST.W ST.D
>> +    LDX.B LDX.BU LDX.H LDX.HU LDX.W LDX.WU LDX.D STX.B STX.H STX.W STX.D
>> +    LDPTR.W LDPTR.D STPTR.W STPTR.D
>> +    PRELD PRELDX
>> +
>> +6. 原子操作指令::
>> +
>> +    LL.W SC.W LL.D SC.D
>> +    AMSWAP.W AMSWAP.D AMADD.W AMADD.D AMAND.W AMAND.D AMOR.W AMOR.D AMXOR.W AMXOR.D
>> +    AMMAX.W AMMAX.D AMMIN.W AMMIN.D
>> +
>> +7. 栅障指令::
>> +
>> +    IBAR DBAR
> Is IBAR is pipeline flush? I think DBAR is for LSU fence. loongarch is
> weak consistency, right?
>
> I think we just leave DBAR here, and put IBAR into 8. Flush pipeline
> is not for memory consistency.
I believe he's just listing the instructions in the exact same 
organization as the ISA manual. LoongArch memory model is indeed weak, 
and IBAR most certainly just flushes the instruction fetch pipeline wrt. 
the memory stores happening in the same core (this is what the manual 
says, section 2.2.8.1).
>
> Overall, I give:
> Reviewed-by: Guo Ren <guoren@kernel.org>
