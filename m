Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8B334A95D
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 15:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhCZONU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Fri, 26 Mar 2021 10:13:20 -0400
Received: from mail.loongson.cn ([114.242.206.163]:50382 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230016AbhCZOM5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Mar 2021 10:12:57 -0400
Received: from [192.168.1.111] (unknown [175.152.148.180])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9CxqcnC611gzhgBAA--.1090S2;
        Fri, 26 Mar 2021 22:12:19 +0800 (CST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 4/6] kprobes/ftrace: Use ftrace_location() when
 [dis]arming probes
From:   Huang Pei <huangpei@loongson.cn>
In-Reply-To: <20210325154433.7ed7e56a@gandalf.local.home>
Date:   Fri, 26 Mar 2021 22:12:18 +0800
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        ambrosehua@gmail.com, Bibo Mao <maobibo@loongson.cn>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <F3EABE66-8F6A-4F12-A8D7-E5653C616AA4@loongson.cn>
References: <20210313064149.29276-1-huangpei@loongson.cn>
 <20210313064149.29276-5-huangpei@loongson.cn>
 <20210325154433.7ed7e56a@gandalf.local.home>
To:     Steven Rostedt <rostedt@goodmis.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-CM-TRANSID: AQAAf9CxqcnC611gzhgBAA--.1090S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr48CrWfCw1rAw45uFy8Zrb_yoW5Cw45pF
        95Kan8tF48JFWjgF9Fgw45Zr10yrW5t347KrZ2ya4FvrnrXr13WFWI9w4UArnxCr9YkFWS
        vFsFvFyqk3WxZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7MxkIecxEwVAFwVW5XwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
        VjvjDU0xZFpf9x0JUJKsUUUUUU=
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Patch 4/5 is from arm64’s KPROBES_ON_FTRACE,  I think which is needed by
all RISC with both KPROBES_ON_FTRACE and -fpatchable-function-entry.

But since V7, no further patches are released, what protocol should I follow if
I need these two patches?

> On Mar 26, 2021, at 3:44 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> On Sat, 13 Mar 2021 14:41:47 +0800
> Huang Pei <huangpei@loongson.cn> wrote:
> 
>> From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
>> 
> 
> Looks like this was sent before, but was missing the proper authorship
> (which is not Jisheng).
> 
>   https://lore.kernel.org/linux-arm-kernel/20191225173219.4f9db436@xhacker.debian/
> 
> -- Steve
> 
> 
>> Ftrace location could include more than a single instruction in case
>> of some architectures (powerpc64, for now). In this case, kprobe is
>> permitted on any of those instructions, and uses ftrace infrastructure
>> for functioning.
>> 
>> However, [dis]arm_kprobe_ftrace() uses the kprobe address when setting
>> up ftrace filter IP. This won't work if the address points to any
>> instruction apart from the one that has a branch to _mcount(). To
>> resolve this, have [dis]arm_kprobe_ftrace() use ftrace_function() to
>> identify the filter IP.
>> 
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
>> ---
>> kernel/kprobes.c | 8 +++++---
>> 1 file changed, 5 insertions(+), 3 deletions(-)
>> 
>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>> index 41fdbb7953c6..66ee28b071c2 100644
>> --- a/kernel/kprobes.c
>> +++ b/kernel/kprobes.c
>> @@ -1045,9 +1045,10 @@ static int prepare_kprobe(struct kprobe *p)
>> static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
>> 			       int *cnt)
>> {
>> +	unsigned long ftrace_ip = ftrace_location((unsigned long)p->addr);
>> 	int ret = 0;
>> 
>> -	ret = ftrace_set_filter_ip(ops, (unsigned long)p->addr, 0, 0);
>> +	ret = ftrace_set_filter_ip(ops, ftrace_ip, 0, 0);
>> 	if (ret) {
>> 		pr_debug("Failed to arm kprobe-ftrace at %pS (%d)\n",
>> 			 p->addr, ret);
>> @@ -1070,7 +1071,7 @@ static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
>> 	 * At this point, sinec ops is not registered, we should be sefe from
>> 	 * registering empty filter.
>> 	 */
>> -	ftrace_set_filter_ip(ops, (unsigned long)p->addr, 1, 0);
>> +	ftrace_set_filter_ip(ops, ftrace_ip, 1, 0);
>> 	return ret;
>> }
>> 
>> @@ -1087,6 +1088,7 @@ static int arm_kprobe_ftrace(struct kprobe *p)
>> static int __disarm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
>> 				  int *cnt)
>> {
>> +	unsigned long ftrace_ip = ftrace_location((unsigned long)p->addr);
>> 	int ret = 0;
>> 
>> 	if (*cnt == 1) {
>> @@ -1097,7 +1099,7 @@ static int __disarm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
>> 
>> 	(*cnt)--;
>> 
>> -	ret = ftrace_set_filter_ip(ops, (unsigned long)p->addr, 1, 0);
>> +	ret = ftrace_set_filter_ip(ops, ftrace_ip, 1, 0);
>> 	WARN_ONCE(ret < 0, "Failed to disarm kprobe-ftrace at %pS (%d)\n",
>> 		  p->addr, ret);
>> 	return ret;

Huang Pei
huangpei@loongson.cn



