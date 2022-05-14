Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79288527132
	for <lists+linux-arch@lfdr.de>; Sat, 14 May 2022 15:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiENN0q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 14 May 2022 09:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiENN0k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 14 May 2022 09:26:40 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C762228E;
        Sat, 14 May 2022 06:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1652534792; bh=pC7ATJhs3EsGRHO1UiPmK5qYpfIgk4XEXCvayC9fAwQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NJ/8J6seSS5HLzO91rheo4WgSn+beszMl5a1beVpBpzIO9LMxwP5GjHCR/ijYeUuV
         d7UbnPjlR3QAOH5HM/LE99LoCo0mkp6+B7yl1iaGHzbiK3OkXm+D5h5ez9upUhzQlT
         ai3e6sY1/t29RpCPW1sl/3C1x0NJcdSh7SQTevOo=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 261DC60691;
        Sat, 14 May 2022 21:26:32 +0800 (CST)
Message-ID: <7dc1abfd-e811-85b8-2a5b-8ace6ccb1ec7@xen0n.name>
Date:   Sat, 14 May 2022 21:26:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0a1
Subject: Re: [PATCH V10 02/22] Documentation/zh_CN: Add basic LoongArch
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
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alex Shi <alexs@kernel.org>
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
 <20220514080402.2650181-3-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220514080402.2650181-3-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 5/14/22 16:03, Huacai Chen wrote:
> Add some basic documentation (zh_CN version) for LoongArch. LoongArch is
> a new RISC ISA, which is a bit like MIPS or RISC-V. LoongArch includes a
> reduced 32-bit version (LA32R), a standard 32-bit version (LA32S) and a
> 64-bit version (LA64).
>
> Reviewed-by: Alex Shi <alexs@kernel.org>
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   Documentation/translations/zh_CN/index.rst    |   1 +
>   .../translations/zh_CN/loongarch/features.rst |   8 +
>   .../translations/zh_CN/loongarch/index.rst    |  26 ++
>   .../zh_CN/loongarch/introduction.rst          | 326 ++++++++++++++++++
>   .../zh_CN/loongarch/irq-chip-model.rst        | 167 +++++++++
>   5 files changed, 528 insertions(+)
>   create mode 100644 Documentation/translations/zh_CN/loongarch/features.rst
>   create mode 100644 Documentation/translations/zh_CN/loongarch/index.rst
>   create mode 100644 Documentation/translations/zh_CN/loongarch/introduction.rst
>   create mode 100644 Documentation/translations/zh_CN/loongarch/irq-chip-model.rst
>
> diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
> index 88d8df957a78..41c59950523c 100644
> --- a/Documentation/translations/zh_CN/index.rst
> +++ b/Documentation/translations/zh_CN/index.rst
> @@ -171,6 +171,7 @@ TODOList:
>      riscv/index
>      openrisc/index
>      parisc/index
> +   loongarch/index
>   
>   TODOList:
>   
> diff --git a/Documentation/translations/zh_CN/loongarch/features.rst b/Documentation/translations/zh_CN/loongarch/features.rst
> new file mode 100644
> index 000000000000..3886e635ec06
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/loongarch/features.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/loongarch/features.rst
> +:Translator: Huacai Chen <chenhuacai@loongson.cn>

Actually, here's an interesting situation:

Every LoongArch (or Loongson) developer is native speaker of Chinese, 
not English, so most likely the "original" version of the various 
LoongArch documentation is actually the *Chinese* one, i.e. those added 
in this commit. As one can see, the English version has many unnatural 
expression recognizable even by a Chinese speaker (such as myself). I've 
seen worse translations (not necessarily in this patch series), broken 
to the point that even Chinese speakers with an adequate understanding 
of English (again, such as myself) *cannot* mentally map back into 
Chinese. (Usually such broken English are in fact perfect Chinese 
expression if mapped back word-for-word).

So, how do we handle situation like this for the kernel documentation? 
Do we keep the English version as the "original" or "authoritative" 
version, even though they may be inaccurate compared to the 
"translation", or do we just switch a bit and move this "original" and 
"translator" information to the English version instead?

> +
> +.. kernel-feat:: $srctree/Documentation/features loongarch
> diff --git a/Documentation/translations/zh_CN/loongarch/index.rst b/Documentation/translations/zh_CN/loongarch/index.rst
> new file mode 100644
> index 000000000000..367dead02e3a
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/loongarch/index.rst
> @@ -0,0 +1,26 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/loongarch/index.rst
> +:Translator: Huacai Chen <chenhuacai@loongson.cn>
> +
> +=================
> +LoongArch特性文档
The point raised in v9 hasn't been addressed yet -- "特性文档" is incorrect 
translation for "...-specific documentation".
> +=================
> +
> +.. toctree::
> +   :maxdepth: 2
> +   :numbered:
> +
> +   introduction
> +   irq-chip-model
> +
> +   features
> +
> +.. only::  subproject and html
> +
> +   Indices
> +   =======
> +
> +   * :ref:`genindex`
> diff --git a/Documentation/translations/zh_CN/loongarch/introduction.rst b/Documentation/translations/zh_CN/loongarch/introduction.rst
> new file mode 100644
> index 000000000000..d033e97d02b8
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/loongarch/introduction.rst
> @@ -0,0 +1,326 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/loongarch/introduction.rst
> +:Translator: Huacai Chen <chenhuacai@loongson.cn>
> +
> +=============
> +LoongArch介绍
> +=============
> +
> +LoongArch是一种新的RISC ISA，在一定程度上类似于MIPS和RISC-V。LoongArch指令集
> +包括一个精简32位版（LA32R）、一个标准32位版（LA32S）、一个64位版（LA64）。
> +LoongArch有四个特权级（PLV0~PLV3），其中PLV0是最高特权级，用于内核；而PLV3是
> +最低特权级，用于应用程序。本文档介绍了LoongArch的寄存器、基础指令集、虚拟内
> +存以及其他一些主题。
> +
> +寄存器
> +======
> +
> +LoongArch的寄存器包括通用寄存器（GPRs）、浮点寄存器（FPRs）、向量寄存器（VRs）
> +和用于特权模式（PLV0）的控制状态寄存器（CSRs）。
> +
> +通用寄存器
> +----------
> +
> +LoongArch包括32个通用寄存器（$r0 - $r31），LA32中每个寄存器为32位宽，LA64中
> +每个寄存器为64位宽。$r0的内容总是0，而其他寄存器没有特殊功能。然而，我们有
> +如下所示的一套ABI寄存器使用约定。
> +
> +================= =============== =================== ==========
> +寄存器名          别名            用途                跨调用保持
> +================= =============== =================== ==========
> +``$r0``           ``$zero``       常量0               不使用
> +``$r1``           ``$ra``         返回地址            否
> +``$r2``           ``$tp``         TLS（线程局部存储） 不使用
> +``$r3``           ``$sp``         栈指针              是
> +``$r4``-``$r11``  ``$a0``-``$a7`` 参数寄存器          否
> +``$r4``-``$r5``   ``$v0``-``$v1`` 返回值              否
> +``$r12``-``$r20`` ``$t0``-``$t8`` 临时寄存器          否
> +``$r21``          ``$u0``         保留                不使用
> +``$r22``          ``$fp``         帧指针              是
> +``$r23``-``$r31`` ``$s0``-``$s8`` 静态寄存器          是
> +================= =============== =================== ==========
> +
> +注意：v0/v1命名法已经废弃，请使用a0/a1。r21寄存器在Linux内核中命名
> +为u0，用于保存每CPU变量基地址。
Same comment regarding "u0" applies here too, as do the other comments 
on the previous patch related to places below. I'll not repeat myself 
for these.
> +
> +浮点寄存器
> +----------
> +
> +LoongArch有32个浮点寄存器（$f0 - $f31），每个寄存器均为64位宽。我们同样
> +有如下所示的一套ABI寄存器使用约定。
> +
> +================= ================== =================== ==========
> +寄存器名          别名               用途                跨调用保持
> +================= ================== =================== ==========
> +``$f0``-``$f7``   ``$fa0``-``$fa7``  参数寄存器          否
> +``$f0``-``$f1``   ``$fv0``-``$fv1``  返回值              否
> +``$f8``-``$f23``  ``$ft0``-``$ft15`` 临时寄存器          否
> +``$f24``-``$f31`` ``$fs0``-``$fs7``  静态寄存器          是
> +================= ================== =================== ==========
> +
> +注意：fv0/fv1命名法已经废弃，请使用fa0/fa1。
> +
> +向量寄存器
> +----------
> +
> +LoongArch拥有128位向量扩展（LSX，全称Loongson SIMD eXtention）和256位向量扩展
> +（LASX，全称Loongson Advanced SIMD eXtension）。共有32个向量寄存器，对于LSX是
> +$v0 - $v31，对于LASX是$x0 - $x31。浮点寄存器和向量寄存器是复用的，比如：$x0的
> +低128位是$v0，而$v0的低64位又是$f0，以此类推。
> +
> +控制状态寄存器
> +--------------
> +
> +控制状态寄存器只用于特权模式（PLV0）:
> +
> +================= ==================================== ==========
> +地址              全称描述                             简称
> +================= ==================================== ==========
> +0x0               当前模式信息                         CRMD
> +0x1               异常前模式信息                       PRMD
> +0x2               扩展部件使能                         EUEN
> +0x3               杂项控制                             MISC
> +0x4               异常配置                             ECFG
> +0x5               异常状态                             ESTAT
> +0x6               异常返回地址                         ERA
> +0x7               出错虚拟地址                         BADV
> +0x8               出错指令                             BADI
> +0xC               异常入口地址                         EENTRY
> +0x10              TLB索引                              TLBIDX
> +0x11              TLB表项高位                          TLBEHI
> +0x12              TLB表项低位0                         TLBELO0
> +0x13              TLB表项低位1                         TLBELO1
> +0x18              地址空间标识符                       ASID
> +0x19              低半地址空间页全局目录基址           PGDL
> +0x1A              高半地址空间页全局目录基址           PGDH
> +0x1B              页全局目录基址                       PGD
> +0x1C              页表遍历控制低半部分                 PWCL
> +0x1D              页表遍历控制高半部分                 PWCH
> +0x1E              STLB页大小                           STLBPS
> +0x1F              缩减虚地址配置                       RVACFG
> +0x20              CPU编号                              CPUID
> +0x21              特权资源配置信息1                    PRCFG1
> +0x22              特权资源配置信息2                    PRCFG2
> +0x23              特权资源配置信息3                    PRCFG3
> +0x30+n (0≤n≤15)   数据保存寄存器                       SAVEn
> +0x40              定时器编号                           TID
> +0x41              定时器配置                           TCFG
> +0x42              定时器值                             TVAL
> +0x43              计时器补偿                           CNTC
> +0x44              定时器中断清除                       TICLR
> +0x60              LLBit相关控制                        LLBCTL
> +0x80              实现相关控制1                        IMPCTL1
> +0x81              实现相关控制2                        IMPCTL2
> +0x88              TLB重填异常入口地址                  TLBRENTRY
> +0x89              TLB重填异常出错虚地址                TLBRBADV
> +0x8A              TLB重填异常返回地址                  TLBRERA
> +0x8B              TLB重填异常数据保存                  TLBRSAVE
> +0x8C              TLB重填异常表项低位0                 TLBRELO0
> +0x8D              TLB重填异常表项低位1                 TLBRELO1
> +0x8E              TLB重填异常表项高位                  TLBEHI
> +0x8F              TLB重填异常前模式信息                TLBRPRMD
> +0x90              机器错误控制                         MERRCTL
> +0x91              机器错误信息1                        MERRINFO1
> +0x92              机器错误信息2                        MERRINFO2
> +0x93              机器错误异常入口地址                 MERRENTRY
> +0x94              机器错误异常返回地址                 MERRERA
> +0x95              机器错误异常数据保存                 MERRSAVE
> +0x98              高速缓存标签                         CTAG
> +0x180+n (0≤n≤3)   直接映射配置窗口n                    DMWn
> +0x200+2n (0≤n≤31) 性能监测配置n                        PMCFGn
> +0x201+2n (0≤n≤31) 性能监测计数器n                      PMCNTn
> +0x300             内存读写监视点整体控制               MWPC
> +0x301             内存读写监视点整体状态               MWPS
> +0x310+8n (0≤n≤7)  内存读写监视点n配置1                 MWPnCFG1
> +0x311+8n (0≤n≤7)  内存读写监视点n配置2                 MWPnCFG2
> +0x312+8n (0≤n≤7)  内存读写监视点n配置3                 MWPnCFG3
> +0x313+8n (0≤n≤7)  内存读写监视点n配置4                 MWPnCFG4
> +0x380             取指监视点整体控制                   FWPC
> +0x381             取指监视点整体状态                   FWPS
> +0x390+8n (0≤n≤7)  取指监视点n配置1                     FWPnCFG1
> +0x391+8n (0≤n≤7)  取指监视点n配置2                     FWPnCFG2
> +0x392+8n (0≤n≤7)  取指监视点n配置3                     FWPnCFG3
> +0x393+8n (0≤n≤7)  取指监视点n配置4                     FWPnCFG4
> +0x500             调试寄存器                           DBG
> +0x501             调试异常返回地址                     DERA
> +0x502             调试数据保存                         DSAVE
> +================= ==================================== ==========
> +
> +ERA，TLBRERA，MERREEA和ERA有时也称为EPC，TLBREPC，MERREPC和DEPC。
> +
> +基础指令集
> +==========
> +
> +指令格式
> +--------
> +
> +LoongArch的指令字长为32位，一共有9种指令格式::
> +
> +  2R-type:    Opcode + Rj + Rd
> +  3R-type:    Opcode + Rk + Rj + Rd
> +  4R-type:    Opcode + Ra + Rk + Rj + Rd
> +  2RI8-type:  Opcode + I8 + Rj + Rd
> +  2RI12-type: Opcode + I12 + Rj + Rd
> +  2RI14-type: Opcode + I14 + Rj + Rd
> +  2RI16-type: Opcode + I16 + Rj + Rd
> +  1RI21-type: Opcode + I21L + Rj + I21H
> +  I26-type:   Opcode + I26L + I26H
> +
> +Opcode是指令操作码，Rj和Rk是源操作数（寄存器），Rd是目标操作数（寄存器），Ra是
> +4R-type格式特有的附加操作数（寄存器）。I8/I12/I16/I21/I26分别是8位/12位/16位/
> +21位/26位的立即数。其中21位和26位立即数在指令字中被分割为高位部分与低位部分，
> +所以你们在这里的格式描述中能够看到I21L/I21H和I26L/I26H这样的表述。
> +
> +指令名称（助记符）
> +------------------
> +
> +我们在此只简单罗列一下指令名称，详细信息请阅读 :ref:`参考文献 <loongarch-references>`
> +中的文档。
> +
> +1. 算术运算指令::
> +
> +    ADD.W SUB.W ADDI.W ADD.D SUB.D ADDI.D
> +    SLT SLTU SLTI SLTUI
> +    AND OR NOR XOR ANDN ORN ANDI ORI XORI
> +    MUL.W MULH.W MULH.WU DIV.W DIV.WU MOD.W MOD.WU
> +    MUL.D MULH.D MULH.DU DIV.D DIV.DU MOD.D MOD.DU
> +    PCADDI PCADDU12I PCADDU18I
> +    LU12I.W LU32I.D LU52I.D ADDU16I.D
> +
> +2. 移位运算指令::
> +
> +    SLL.W SRL.W SRA.W ROTR.W SLLI.W SRLI.W SRAI.W ROTRI.W
> +    SLL.D SRL.D SRA.D ROTR.D SLLI.D SRLI.D SRAI.D ROTRI.D
> +
> +3. 位域操作指令::
> +
> +    EXT.W.B EXT.W.H CLO.W CLO.D SLZ.W CLZ.D CTO.W CTO.D CTZ.W CTZ.D
> +    BYTEPICK.W BYTEPICK.D BSTRINS.W BSTRINS.D BSTRPICK.W BSTRPICK.D
> +    REVB.2H REVB.4H REVB.2W REVB.D REVH.2W REVH.D BITREV.4B BITREV.8B BITREV.W BITREV.D
> +    MASKEQZ MASKNEZ
> +
> +4. 分支转移指令::
> +
> +    BEQ BNE BLT BGE BLTU BGEU BEQZ BNEZ B BL JIRL
> +
> +5. 访存读写指令::
> +
> +    LD.B LD.BU LD.H LD.HU LD.W LD.WU LD.D ST.B ST.H ST.W ST.D
> +    LDX.B LDX.BU LDX.H LDX.HU LDX.W LDX.WU LDX.D STX.B STX.H STX.W STX.D
> +    LDPTR.W LDPTR.D STPTR.W STPTR.D
> +    PRELD PRELDX
> +
> +6. 原子操作指令::
> +
> +    LL.W SC.W LL.D SC.D
> +    AMSWAP.W AMSWAP.D AMADD.W AMADD.D AMAND.W AMAND.D AMOR.W AMOR.D AMXOR.W AMXOR.D
> +    AMMAX.W AMMAX.D AMMIN.W AMMIN.D
> +
> +7. 栅障指令::
> +
> +    IBAR DBAR
> +
> +8. 特殊指令::
> +
> +    SYSCALL BREAK CPUCFG NOP IDLE ERTN DBCL RDTIMEL.W RDTIMEH.W RDTIME.D ASRTLE.D ASRTGT.D
> +
> +9. 特权指令::
> +
> +    CSRRD CSRWR CSRXCHG
> +    IOCSRRD.B IOCSRRD.H IOCSRRD.W IOCSRRD.D IOCSRWR.B IOCSRWR.H IOCSRWR.W IOCSRWR.D
> +    CACOP TLBP(TLBSRCH) TLBRD TLBWR TLBFILL TLBCLR TLBFLUSH INVTLB LDDIR LDPTE
> +
> +虚拟内存
> +========
> +
> +LoongArch可以使用直接映射虚拟内存和分页映射虚拟内存。
> +
> +直接映射虚拟内存通过CSR.DMWn（n=0~3）来进行配置，虚拟地址（VA）和物理地址（PA）
> +之间有简单的映射关系::
> +
> + VA = PA + 固定偏移
> +
> +分页映射的虚拟地址（VA）和物理地址（PA）有任意的映射关系，这种关系记录在TLB和页
> +表中。LoongArch的TLB包括一个全相联的MTLB（Multiple Page Size TLB，页大小可变）
> +和一个组相联的STLB（Single Page Size TLB，页大小固定）。
> +
> +缺省状态下，LA32的整个虚拟地址空间配置如下：
> +
> +============ =========================== ===========================
> +区段名       地址范围                    属性
> +============ =========================== ===========================
> +``UVRANGE``  ``0x00000000 - 0x7FFFFFFF`` 分页映射, 可缓存, PLV0~3
> +``KPRANGE0`` ``0x80000000 - 0x9FFFFFFF`` 直接映射, 非缓存, PLV0
> +``KPRANGE1`` ``0xA0000000 - 0xBFFFFFFF`` 直接映射, 可缓存, PLV0
> +``KVRANGE``  ``0xC0000000 - 0xFFFFFFFF`` 分页映射, 可缓存, PLV0
> +============ =========================== ===========================
> +
> +用户态（PLV3）只能访问UVRANGE，对于直接映射的KPRANGE0和KPRANGE1，将虚拟地址的第
> +30~31位清零就等于物理地址。例如：物理地址0x00001000对应的非缓存直接映射虚拟地址
> +是0x80001000，而其可缓存直接映射虚拟地址是0xA0001000。
> +
> +缺省状态下，LA64的整个虚拟地址空间配置如下：
> +
> +============ ====================== ==================================
> +区段名       地址范围               属性
> +============ ====================== ==================================
> +``XUVRANGE`` ``0x0000000000000000 - 分页映射, 可缓存, PLV0~3
> +             0x3FFFFFFFFFFFFFFF``
> +``XSPRANGE`` ``0x4000000000000000 - 直接映射, 可缓存 / 非缓存, PLV0
> +             0x7FFFFFFFFFFFFFFF``
> +``XKPRANGE`` ``0x8000000000000000 - 直接映射, 可缓存 / 非缓存, PLV0
> +             0xBFFFFFFFFFFFFFFF``
> +``XKVRANGE`` ``0xC000000000000000 - 分页映射, 可缓存, PLV0
> +             0xFFFFFFFFFFFFFFFF``
> +============ ====================== ==================================
> +
> +用户态（PLV3）只能访问XUVRANGE，对于直接映射的XSPRANGE和XKPRANGE，将虚拟地址的第
> +60~63位清零就等于物理地址，而其缓存属性是通过虚拟地址的第60~61位配置的（0表示强序
> +非缓存，1表示一致可缓存，2表示弱序非缓存）。目前，我们仅用XKPRANGE来进行直接映射，
> +XSPRANGE保留给以后用。此处给出一个直接映射的例子：物理地址0x00000000 00001000的强
> +序非缓存直接映射虚拟地址是0x80000000 00001000，其一致可缓存直接映射虚拟地址是
> +0x90000000 00001000，而其弱序非缓存直接映射虚拟地址是0xA0000000 00001000。
> +
> +Loongson与LoongArch的关系
> +=========================
> +
> +LoongArch是一种RISC指令集架构（ISA），不同于现存的任何一种ISA，而Loongson（即龙
> +芯）是一个处理器家族。龙芯包括三个系列：Loongson-1（龙芯1号）是32位处理器系列，
> +Loongson-2（龙芯2号）是低端64位处理器系列，而Loongson-3（龙芯3号）是高端64位处理
> +器系列。旧的龙芯处理器基于MIPS架构，而新的龙芯处理器基于LoongArch架构。以龙芯3号
> +为例：龙芯3A1000/3B1500/3A2000/3A3000/3A4000都是兼容MIPS的，而龙芯3A5000（以及将
> +来的型号）都是基于LoongArch的。
> +
> +.. _loongarch-references:
> +
> +参考文献
> +========
> +
> +Loongson与LoongArch的官方网站（龙芯中科技术股份有限公司）：
> +
> +  http://www.loongson.cn/index.html
> +
> +Loongson与LoongArch的开发者网站（软件与文档资源）：
> +
> +  http://www.loongnix.cn/index.php
> +
> +  https://github.com/loongson
> +
> +LoongArch指令集架构的文档：
> +
> +  https://github.com/loongson/LoongArch-Documentation/releases/latest/download/LoongArch-Vol1-v1.00-CN.pdf （中文版）
> +
> +  https://github.com/loongson/LoongArch-Documentation/releases/latest/download/LoongArch-Vol1-v1.00-EN.pdf （英文版）
> +
> +LoongArch的ELF ABI文档：
> +
> +  https://github.com/loongson/LoongArch-Documentation/releases/latest/download/LoongArch-ELF-ABI-v1.00-CN.pdf （中文版）
> +
> +  https://github.com/loongson/LoongArch-Documentation/releases/latest/download/LoongArch-ELF-ABI-v1.00-EN.pdf （英文版）
> +
> +Loongson与LoongArch的Linux内核源码仓库：
> +
> +  https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git
> diff --git a/Documentation/translations/zh_CN/loongarch/irq-chip-model.rst b/Documentation/translations/zh_CN/loongarch/irq-chip-model.rst
> new file mode 100644
> index 000000000000..9f6c32f3bad0
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/loongarch/irq-chip-model.rst
> @@ -0,0 +1,167 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/loongarch/irq-chip-model.rst
> +:Translator: Huacai Chen <chenhuacai@loongson.cn>
> +
> +==================================
> +LoongArch的IRQ芯片模型（层级关系）
> +==================================
> +
> +目前，基于LoongArch的处理器（如龙芯3A5000）只能与LS7A芯片组配合工作。LoongArch计算机
> +中的中断控制器（即IRQ芯片）包括CPUINTC（CPU Core Interrupt Controller）、LIOINTC（
> +Legacy I/O Interrupt Controller）、EIOINTC（Extended I/O Interrupt Controller）、
> +HTVECINTC（Hyper-Transport Vector Interrupt Controller）、PCH-PIC（LS7A芯片组的主中
> +断控制器）、PCH-LPC（LS7A芯片组的LPC中断控制器）和PCH-MSI（MSI中断控制器）。
> +
> +CPUINTC是一种CPU内部的每个核本地的中断控制器，LIOINTC/EIOINTC/HTVECINTC是CPU内部的
> +全局中断控制器（每个芯片一个，所有核共享），而PCH-PIC/PCH-LPC/PCH-MSI是CPU外部的中
> +断控制器（在配套芯片组里面）。这些中断控制器（或者说IRQ芯片）以一种层次树的组织形式
> +级联在一起，一共有两种层级关系模型（传统IRQ模型和扩展IRQ模型）。
> +
> +传统IRQ模型
> +===========
> +
> +在这种模型里面，IPI（Inter-Processor Interrupt）和CPU本地时钟中断直接发送到CPUINTC，
> +CPU串口（UARTs）中断发送到LIOINTC，而其他所有设备的中断则分别发送到所连接的PCH-PIC/
> +PCH-LPC/PCH-MSI，然后被HTVECINTC统一收集，再发送到LIOINTC，最后到达CPUINTC。
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
> +扩展IRQ模型
> +===========
> +
> +在这种模型里面，IPI（Inter-Processor Interrupt）和CPU本地时钟中断直接发送到CPUINTC，
> +CPU串口（UARTs）中断发送到LIOINTC，而其他所有设备的中断则分别发送到所连接的PCH-PIC/
> +PCH-LPC/PCH-MSI，然后被EIOINTC统一收集，再直接到达CPUINTC。
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
> +ACPI相关的定义
> +==============
> +
> +CPUINTC::
> +
> +  ACPI_MADT_TYPE_CORE_PIC;
> +  struct acpi_madt_core_pic;
> +  enum acpi_madt_core_pic_version;
> +
> +LIOINTC::
> +
> +  ACPI_MADT_TYPE_LIO_PIC;
> +  struct acpi_madt_lio_pic;
> +  enum acpi_madt_lio_pic_version;
> +
> +EIOINTC::
> +
> +  ACPI_MADT_TYPE_EIO_PIC;
> +  struct acpi_madt_eio_pic;
> +  enum acpi_madt_eio_pic_version;
> +
> +HTVECINTC::
> +
> +  ACPI_MADT_TYPE_HT_PIC;
> +  struct acpi_madt_ht_pic;
> +  enum acpi_madt_ht_pic_version;
> +
> +PCH-PIC::
> +
> +  ACPI_MADT_TYPE_BIO_PIC;
> +  struct acpi_madt_bio_pic;
> +  enum acpi_madt_bio_pic_version;
> +
> +PCH-MSI::
> +
> +  ACPI_MADT_TYPE_MSI_PIC;
> +  struct acpi_madt_msi_pic;
> +  enum acpi_madt_msi_pic_version;
> +
> +PCH-LPC::
> +
> +  ACPI_MADT_TYPE_LPC_PIC;
> +  struct acpi_madt_lpc_pic;
> +  enum acpi_madt_lpc_pic_version;
> +
> +参考文献
> +========
> +
> +龙芯3A5000的文档：
> +
> +  https://github.com/loongson/LoongArch-Documentation/releases/latest/download/Loongson-3A5000-usermanual-1.02-CN.pdf (中文版)
> +
> +  https://github.com/loongson/LoongArch-Documentation/releases/latest/download/Loongson-3A5000-usermanual-1.02-EN.pdf (英文版)
> +
> +龙芯LS7A芯片组的文档：
> +
> +  https://github.com/loongson/LoongArch-Documentation/releases/latest/download/Loongson-7A1000-usermanual-2.00-CN.pdf (中文版)
> +
> +  https://github.com/loongson/LoongArch-Documentation/releases/latest/download/Loongson-7A1000-usermanual-2.00-EN.pdf (英文版)
> +
> +注：CPUINTC即《龙芯架构参考手册卷一》第7.4节所描述的CSR.ECFG/CSR.ESTAT寄存器及其中断
> +控制逻辑；LIOINTC即《龙芯3A5000处理器使用手册》第11.1节所描述的“传统I/O中断”；EIOINTC
> +即《龙芯3A5000处理器使用手册》第11.2节所描述的“扩展I/O中断”；HTVECINTC即《龙芯3A5000
> +处理器使用手册》第14.3节所描述的“HyperTransport中断”；PCH-PIC/PCH-MSI即《龙芯7A1000桥
> +片用户手册》第5章所描述的“中断控制器”；PCH-LPC即《龙芯7A1000桥片用户手册》第24.3节所
> +描述的“LPC中断”。
