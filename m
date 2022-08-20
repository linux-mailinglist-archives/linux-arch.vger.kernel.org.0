Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C2659AA82
	for <lists+linux-arch@lfdr.de>; Sat, 20 Aug 2022 03:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241560AbiHTBbJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 21:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiHTBbI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 21:31:08 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B98811C0A;
        Fri, 19 Aug 2022 18:31:06 -0700 (PDT)
Received: from [10.130.0.63] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxrmtMOQBjc3QFAA--.12870S3;
        Sat, 20 Aug 2022 09:30:55 +0800 (CST)
Subject: Re: [PATCH 6/9] LoongArch: modules/ftrace: Initialize PLT at load
 time
To:     Jinyang He <hejinyang@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20220819081657.7254-1-zhangqing@loongson.cn>
 <6fad1ac6-b5ee-39a6-4a7d-2ed2f7efa198@loongson.cn>
From:   Qing Zhang <zhangqing@loongson.cn>
Message-ID: <60993156-0f7d-8d2e-894c-a9941fc7264f@loongson.cn>
Date:   Sat, 20 Aug 2022 09:30:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6fad1ac6-b5ee-39a6-4a7d-2ed2f7efa198@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxrmtMOQBjc3QFAA--.12870S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1rGFWktFyfAw47tF4UCFg_yoWrGrWUpF
        yvyFs5GrWUGrn3GF47Zr1UuFy5ArWxG3yqqF1xW3W7Ar4DZr1jvF1jqrn09ryrJw48Wryx
        Zr18urnruFWUXrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
        W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
        jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43
        ZEXa7VUbLiSPUUUUU==
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2022/8/19 下午6:43, Jinyang He wrote:
> On 2022/8/19 16:16, Qing Zhang wrote:
> 
>> To Implement ftrace trampiones through plt entry.
>>
>> Tested by forcing ftrace_make_call() to use the module PLT, and then
>> loading up a module after setting up ftrace with:
>>
>> | echo ":mod:<module-name>" > set_ftrace_filter;
>> | echo function > current_tracer;
>> | modprobe <module-name>
>>
>> Since FTRACE_ADDR/FTRACE_REGS_ADDR is only defined when 
>> CONFIG_DYNAMIC_FTRACE
>> is selected, we wrap its use along with most of 
>> module_init_ftrace_plt() with
>> ifdeffery rather than using IS_ENABLED().
>>
>> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/ftrace.h     |  4 ++
>>   arch/loongarch/include/asm/inst.h       |  2 +
>>   arch/loongarch/include/asm/module.h     | 14 +++--
>>   arch/loongarch/include/asm/module.lds.h |  1 +
>>   arch/loongarch/kernel/ftrace_dyn.c      | 79 +++++++++++++++++++++++++
>>   arch/loongarch/kernel/inst.c            | 12 ++++
>>   arch/loongarch/kernel/module-sections.c | 11 ++++
>>   arch/loongarch/kernel/module.c          | 48 +++++++++++++++
>>   8 files changed, 166 insertions(+), 5 deletions(-)
> [...]
>> @@ -36,14 +39,15 @@ Elf_Addr module_emit_plt_entry(struct module *mod, 
>> unsigned long val);
>>   static inline struct plt_entry emit_plt_entry(unsigned long val)
>>   {
>> -    u32 lu12iw, lu32id, lu52id, jirl;
>> +    u32 addu16id, lu32id, lu52id, jirl;
>> -    lu12iw = (lu12iw_op << 25 | (((val >> 12) & 0xfffff) << 5) | 
>> LOONGARCH_GPR_T1);
>> +    addu16id = larch_insn_gen_addu16id(LOONGARCH_GPR_T1, 
>> LOONGARCH_GPR_ZERO,
>> +        ADDR_IMM(val, ADDU16ID));
> 
> Hi, Qing,
> 
> Why change lu12iw to addu16id? They have same effect here.
> 
Hi. Jinyang

Yes, the effect is the same.
I will modify it to lu12iw in V2, which can be consistent with the 
user's plt style.

Thanks,
- Qing

> 
>>       lu32id = larch_insn_gen_lu32id(LOONGARCH_GPR_T1, ADDR_IMM(val, 
>> LU32ID));
>>       lu52id = larch_insn_gen_lu52id(LOONGARCH_GPR_T1, 
>> LOONGARCH_GPR_T1, ADDR_IMM(val, LU52ID));
>> -    jirl = larch_insn_gen_jirl(0, LOONGARCH_GPR_T1, 0, (val & 0xfff));
>> +    jirl = larch_insn_gen_jirl(0, LOONGARCH_GPR_T1, 0, (val & 0xffff));
>> -    return (struct plt_entry) { lu12iw, lu32id, lu52id, jirl };
>> +    return (struct plt_entry) { addu16id, lu32id, lu52id, jirl };
>>   }
> [...]
>> +static int module_init_ftrace_plt(const Elf_Ehdr *hdr, const Elf_Shdr 
>> *sechdrs,
>> +                  struct module *mod)
>> +{
>> +#ifdef CONFIG_DYNAMIC_FTRACE
>> +    const Elf_Shdr *s;
>> +    struct plt_entry *ftrace_plts;
>> +
>> +    s = find_section(hdr, sechdrs, ".ftrace_trampoline");
>> +    if (!s)
>> +        return -ENOEXEC;
> 
> Return value is not used later, may we do something or drop returning 
> value.
> 
Yes, Should return module_init_ftrace_plt(hdr, sechdrs, mod) here.

Thanks,
-Qing
> Thanks,
> 
> Jinyang
> 
>> +
>> +    ftrace_plts = (void *)s->sh_addr;
>> +
>> +    ftrace_plts[FTRACE_PLT_IDX] = emit_plt_entry(FTRACE_ADDR);
>> +
>> +    if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS))
>> +        ftrace_plts[FTRACE_REGS_PLT_IDX] = 
>> emit_plt_entry(FTRACE_REGS_ADDR);
>> +
>> +    mod->arch.ftrace_trampolines = ftrace_plts;
>> +#endif
>> +    return 0;
>> +}
>> +
>> +int module_finalize(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs, 
>> struct module *mod)
>> +{
>> +    module_init_ftrace_plt(hdr, sechdrs, mod);
>> +
>> +    return 0;
>> +}
> 

