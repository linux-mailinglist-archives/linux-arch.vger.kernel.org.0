Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F220C68BA08
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 11:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjBFKZB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 05:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjBFKY6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 05:24:58 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2250E659F;
        Mon,  6 Feb 2023 02:24:55 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.155])
        by gateway (Coremail) with SMTP id _____8DxTut21eBjiyEPAA--.29779S3;
        Mon, 06 Feb 2023 18:24:54 +0800 (CST)
Received: from [10.20.42.155] (unknown [10.20.42.155])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxXL511eBj7tIqAA--.17311S3;
        Mon, 06 Feb 2023 18:24:53 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Make -mstrict-align be configurable
To:     WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
References: <20230202084238.2408516-1-chenhuacai@loongson.cn>
 <5fc85453-1e2c-1f00-7879-1b5fa318c78a@xen0n.name>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <5303aeda-5c66-ede6-b3ac-7d8ebd73ec70@loongson.cn>
Date:   Mon, 6 Feb 2023 18:24:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5fc85453-1e2c-1f00-7879-1b5fa318c78a@xen0n.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxXL511eBj7tIqAA--.17311S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3Gr1kJFW3Jw4xXrW7Kw17KFg_yoWfJr1Dpr
        WavryYkrWrXFykA3W7K34UXFW5X348CF15XryfK3W7uw1DXFyUXrn2grs0gF13Wr4xWryj
        qF1IyF1YvF18JaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2
        jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
        AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
        6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIY
        CTnIWIevJa73UjIFyTuYvjxU2MKZDUUUU
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2023/2/2 下午6:30, WANG Xuerui wrote:
> On 2023/2/2 16:42, Huacai Chen wrote:
>> Introduce Kconfig option ARCH_STRICT_ALIGN to make -mstrict-align be
>> configurable.
>>
>> Not all LoongArch cores support h/w unaligned access, we can use the
>> -mstrict-align build parameter to prevent unaligned accesses.
>>
>> This option is disabled by default to optimise for performance, but you
>> can enabled it manually if you want to run kernel on systems without h/w
>> unaligned access support.
> 
> It's customary to accompany "performance-related" changes like this with 
> some benchmark numbers and concrete use cases where this would be 
> profitable. Especially given that arch/loongarch developer and user base 
> is relatively small, we probably don't want to allow customization of 
> such a low-level characteristic. In general kernel performance does not 
> vary much with compiler flags like this, so I'd really hope to see some 
> numbers here to convince people that this is *really* providing gains.
> 
> Also, defaulting to emitting unaligned accesses would mean those future, 
> likely embedded models (and AFAIK some existing models that haven't 
> reached GA yet) would lose support with the defconfig. Which means 
> downstream packagers that care about those use cases would have one more 
> non-default, non-generic option to carry within their Kconfig. We 
> probably don't want to repeat the history of other architectures (think 
> arch/arm or arch/mips) where there wasn't really generic builds and 
> board-specific tweaks proliferated.
> 

Hi, Xuerui

I think the kernels produced with and without -mstrict-align have mainly 
following differences:
- Diffirent size. I build two kernls (vmlinux), size of kernel with 
-mstrict-align is 26533376 bytes and size of kernel without 
-mstrict-align is 26123280 bytes.
- Diffirent performance. For example, in kernel function jhash(), the 
assemble code slices with and without -mstrict-align are following:

without -mstrict-align:
900000000032736c <jhash>:
900000000032736c:       15bd5b6d        lu12i.w         $t1, 
-136485(0xdeadb)
9000000000327370:       03bbbdad        ori             $t1, $t1, 0xeef
9000000000327374:       001019ad        add.w           $t1, $t1, $a2
9000000000327378:       001015ae        add.w           $t2, $t1, $a1
900000000032737c:       0280300c        addi.w          $t0, $zero, 
12(0xc)
9000000000327380:       00150091        move            $t5, $a0
9000000000327384:       001501d0        move            $t4, $t2 

9000000000327388:       001501c4        move            $a0, $t2 

900000000032738c:       6c009585        bgeu            $t0, $a1, 
148(0x94)     # 9000000000327420 <jhash+0xb4>
9000000000327390:       02803012        addi.w          $t6, $zero, 
12(0xc)
9000000000327394:       24000a2f        ldptr.w         $t3, $t5, 8(0x8) 

9000000000327398:       2400022d        ldptr.w         $t1, $t5, 0
900000000032739c:       2400062c        ldptr.w         $t0, $t5, 4(0x4)
90000000003273a0:       001011e4        add.w           $a0, $t3, $a0 

90000000003273a4:       001111af        sub.w           $t3, $t1, $a0 

90000000003273a8:       001039ef        add.w           $t3, $t3, $t2 

90000000003273ac:       004cf08e        rotri.w         $t2, $a0, 0x1c
90000000003273b0:       0010418c        add.w           $t0, $t0, $t4
...

with -mstrict-align:
90000000003310c0 <jhash>:
90000000003310c0:       15bd5b6f        lu12i.w         $t3, 
-136485(0xdeadb)
90000000003310c4:       03bbbdef        ori             $t3, $t3, 0xeef
90000000003310c8:       001019ef        add.w           $t3, $t3, $a2
90000000003310cc:       001015e6        add.w           $a2, $t3, $a1
90000000003310d0:       0280300d        addi.w          $t1, $zero, 12(0xc)
90000000003310d4:       0015008c        move            $t0, $a0
90000000003310d8:       001500d2        move            $t6, $a2
90000000003310dc:       001500c4        move            $a0, $a2
90000000003310e0:       6c0101a5        bgeu            $t1, $a1, 
256(0x100)    # 90000000003311e0 <jhash+0x120>
90000000003310e4:       02803011        addi.w          $t5, $zero, 12(0xc)
90000000003310e8:       2a002589        ld.bu           $a5, $t0, 9(0x9)
90000000003310ec:       2a00218d        ld.bu           $t1, $t0, 8(0x8)
90000000003310f0:       2a002988        ld.bu           $a4, $t0, 10(0xa)
90000000003310f4:       2a000587        ld.bu           $a3, $t0, 1(0x1)
90000000003310f8:       2a002d8e        ld.bu           $t2, $t0, 11(0xb)
90000000003310fc:       2a00018b        ld.bu           $a7, $t0, 0
9000000000331100:       2a000994        ld.bu           $t8, $t0, 2(0x2)
9000000000331104:       2a001593        ld.bu           $t7, $t0, 5(0x5)
9000000000331108:       2a000d8f        ld.bu           $t3, $t0, 3(0x3)
900000000033110c:       00412129        slli.d          $a5, $a5, 0x8
9000000000331110:       2a00118a        ld.bu           $a6, $t0, 4(0x4)
9000000000331114:       2a001990        ld.bu           $t4, $t0, 6(0x6)
9000000000331118:       00153529        or              $a5, $a5, $t1
...

It seems that it's difficult for me to test the performance difference 
in a real kernel path with unaligned-access code. So, I use a kernel 
module (use simple test code) to show some difference on 3A5000 as 
following:

c code:

         preempt_disable();
         start = ktime_get_ns();
         for (i = 0; i < n; i++)
                 assign(p1[i], q1[i]);
         end = ktime_get_ns();
         preempt_enable();

         printk("mstrict-align-test took: %lld nsec\n", end - start);

assemble code without -mstrict-align:
0:   260000ac        ldptr.d         $t0, $a1, 0
4:   2700008c        stptr.d         $t0, $a0, 0
8:   4c000020        jirl            $zero, $ra, 0

assemble code with -mstrict-align:
0:   2a0000b3        ld.bu           $t7, $a1, 0
4:   2a0004b2        ld.bu           $t6, $a1, 1(0x1)
8:   2a0008b1        ld.bu           $t5, $a1, 2(0x2)
c:   2a000cb0        ld.bu           $t4, $a1, 3(0x3)
10:   2a0010af        ld.bu           $t3, $a1, 4(0x4)
14:   2a0014ae        ld.bu           $t2, $a1, 5(0x5)
18:   2a0018ad        ld.bu           $t1, $a1, 6(0x6)
1c:   2a001cac        ld.bu           $t0, $a1, 7(0x7)
20:   29000093        st.b            $t7, $a0, 0
24:   29000492        st.b            $t6, $a0, 1(0x1)
28:   29000891        st.b            $t5, $a0, 2(0x2)
2c:   29000c90        st.b            $t4, $a0, 3(0x3)
30:   2900108f        st.b            $t3, $a0, 4(0x4)
34:   2900148e        st.b            $t2, $a0, 5(0x5)
38:   2900188d        st.b            $t1, $a0, 6(0x6)
3c:   29001c8c        st.b            $t0, $a0, 7(0x7)
40:   4c000020        jirl            $zero, $ra, 0

and test results (run 3 times) following:

the module without -mstrict-align testing:
[root@openEuler loongson]# insmod align-test.ko
[   39.029931] mstrict-align-test took: 29603510 nsec
[root@openEuler loongson]# rmmod align-test.ko
[root@openEuler loongson]# insmod align-test.ko
[   41.356007] mstrict-align-test took: 28816710 nsec
[root@openEuler loongson]# rmmod align-test.ko
[root@openEuler loongson]# insmod align-test.ko
[   43.506624] mstrict-align-test took: 30030700 nsec
[root@openEuler loongson]# rmmod align-test.ko

the module with -mstrict-align testing:
root@openEuler ~]# insmod align-test.ko
[   92.656477] mstrict-align-test took: 59629000 nsec
[root@openEuler ~]# rmmod align-test.ko
[root@openEuler ~]# insmod align-test.ko
[   99.473011] mstrict-align-test took: 58972250 nsec
[root@openEuler ~]# rmmod align-test.ko
[root@openEuler ~]# insmod align-test.ko
[  104.620103] mstrict-align-test took: 59419260 nsec
[root@openEuler ~]# rmmod align-test.ko

Thanks!
Jianmin

>>
>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>>   arch/loongarch/Kconfig  | 10 ++++++++++
>>   arch/loongarch/Makefile |  2 ++
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index 9cc8b84f7eb0..7470dcfb32f0 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -441,6 +441,16 @@ config ARCH_IOREMAP
>>         protection support. However, you can enable LoongArch DMW-based
>>         ioremap() for better performance.
>> +config ARCH_STRICT_ALIGN
>> +    bool "Enable -mstrict-align to prevent unaligned accesses"
>> +    help
>> +      Not all LoongArch cores support h/w unaligned access, we can use
>> +      -mstrict-align build parameter to prevent unaligned accesses.
>> +
>> +      This is disabled by default to optimise for performance, you can
>> +      enabled it manually if you want to run kernel on systems without
>> +      h/w unaligned access support.
>> +
>>   config KEXEC
>>       bool "Kexec system call"
>>       select KEXEC_CORE
>> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
>> index 4402387d2755..ccfb52700237 100644
>> --- a/arch/loongarch/Makefile
>> +++ b/arch/loongarch/Makefile
>> @@ -91,10 +91,12 @@ KBUILD_CPPFLAGS += -DVMLINUX_LOAD_ADDRESS=$(load-y)
>>   # instead of .eh_frame so we don't discard them.
>>   KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
>> +ifdef CONFIG_ARCH_STRICT_ALIGN
>>   # Don't emit unaligned accesses.
>>   # Not all LoongArch cores support unaligned access, and as kernel we 
>> can't
>>   # rely on others to provide emulation for these accesses.
>>   KBUILD_CFLAGS += $(call cc-option,-mstrict-align)
>> +endif >
>>   KBUILD_CFLAGS += -isystem $(shell $(CC) -print-file-name=include)
> 

