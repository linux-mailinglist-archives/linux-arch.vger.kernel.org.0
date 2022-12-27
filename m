Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901F8656912
	for <lists+linux-arch@lfdr.de>; Tue, 27 Dec 2022 10:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiL0Jtg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Dec 2022 04:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiL0Jtf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Dec 2022 04:49:35 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9E636467;
        Tue, 27 Dec 2022 01:49:32 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.31:47026.1348480059
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 59D06100135;
        Tue, 27 Dec 2022 17:49:29 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-79f476db8-srhz2 with ESMTP id c198b5c1616f443babc5733098c2abe3 for mhiramat@kernel.org;
        Tue, 27 Dec 2022 17:49:30 CST
X-Transaction-ID: c198b5c1616f443babc5733098c2abe3
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Message-ID: <6f64c5bd-2746-37e5-7e07-1c828fd6b90e@189.cn>
Date:   Tue, 27 Dec 2022 17:49:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 4/4] kernel/trace: remove calling regs_* when compiling
 HEXAGON
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <1670229017-4106-1-git-send-email-chensong_2000@189.cn>
 <20221223231545.e619f35b321192fbaa2f4cf9@kernel.org>
Content-Language: en-US
From:   Song Chen <chensong_2000@189.cn>
In-Reply-To: <20221223231545.e619f35b321192fbaa2f4cf9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



在 2022/12/23 22:15, Masami Hiramatsu (Google) 写道:
> On Mon,  5 Dec 2022 16:30:17 +0800
> Song Chen <chensong_2000@189.cn> wrote:
> 
>> kernel test robot reports below errors:
>>
>> In file included from kernel/trace/trace_events_synth.c:22:
>>>> kernel/trace/trace_probe_kernel.h:203:9: error: call to
>> undeclared function 'regs_get_register'; ISO C99 and later
>> do not support implicit function declarations
>> [-Wimplicit-function-declaration]
>>                     val = regs_get_register(regs, code->param);
>>
>> HEXAGON doesn't define and implement those reg_* functions
>> underneath arch/hexagon as well as other archs. To remove
>> those errors, i have to include those function calls in
>> "CONFIG_HEXAGON"
>>
>> It looks ugly, but i don't know any other way to fix it,
>> this patch can be reverted after reg_* have been in place
>> in arch/hexagon.
>>
> 
> Sorry, NACK. This is too add-hoc patch and this is introduced
> by your patch. Do not introduce an issue and fix it later in
> the same series.
> Please fix it in your first patch. Maybe you should make another
> header file for those APIs.
> 
> Thank you,
I tried not no add a new header file, but looks like i have to, to avoid 
triggering warnings and errors of kernel robot.

Thanks

Song

> 
>> Signed-off-by: Song Chen <chensong_2000@189.cn>
>> Reported-by: kernel test robot <lkp@intel.com>
>> ---
>>   kernel/trace/trace_probe_kernel.h | 21 +++++++++++++++++++--
>>   1 file changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/trace/trace_probe_kernel.h b/kernel/trace/trace_probe_kernel.h
>> index 8c42abe0dacf..7e958b7f07e5 100644
>> --- a/kernel/trace/trace_probe_kernel.h
>> +++ b/kernel/trace/trace_probe_kernel.h
>> @@ -130,8 +130,7 @@ probe_mem_read(void *dest, void *src, size_t size)
>>   	return copy_from_kernel_nofault(dest, src, size);
>>   }
>>   
>> -static nokprobe_inline unsigned long
>> -get_event_field(struct fetch_insn *code, void *rec)
>> +static unsigned long get_event_field(struct fetch_insn *code, void *rec)
>>   {
>>   	struct ftrace_event_field *field = code->data;
>>   	unsigned long val;
>> @@ -194,23 +193,41 @@ static int
>>   process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
>>   		   void *base)
>>   {
>> +#ifndef CONFIG_HEXAGON
>>   	struct pt_regs *regs = rec;
>> +#endif
>>   	unsigned long val;
>>   
>>   retry:
>>   	/* 1st stage: get value from context */
>>   	switch (code->op) {
>>   	case FETCH_OP_REG:
>> +#ifdef CONFIG_HEXAGON
>> +		val = 0;
>> +#else
>>   		val = regs_get_register(regs, code->param);
>> +#endif
>>   		break;
>>   	case FETCH_OP_STACK:
>> +#ifdef CONFIG_HEXAGON
>> +		val = 0;
>> +#else
>>   		val = regs_get_kernel_stack_nth(regs, code->param);
>> +#endif
>>   		break;
>>   	case FETCH_OP_STACKP:
>> +#ifdef CONFIG_HEXAGON
>> +		val = 0;
>> +#else
>>   		val = kernel_stack_pointer(regs);
>> +#endif
>>   		break;
>>   	case FETCH_OP_RETVAL:
>> +#ifdef CONFIG_HEXAGON
>> +		val = 0;
>> +#else
>>   		val = regs_return_value(regs);
>> +#endif
>>   		break;
>>   	case FETCH_OP_IMM:
>>   		val = code->immediate;
>> -- 
>> 2.25.1
>>
> 
> 
