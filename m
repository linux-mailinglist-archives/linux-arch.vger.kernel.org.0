Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9773032FE58
	for <lists+linux-arch@lfdr.de>; Sun,  7 Mar 2021 02:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhCGBhG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Sat, 6 Mar 2021 20:37:06 -0500
Received: from mail.loongson.cn ([114.242.206.163]:46620 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229788AbhCGBgh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 6 Mar 2021 20:36:37 -0500
Received: from [127.0.0.1] (unknown [101.206.168.69])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxr9cQLkRgpMcVAA--.6957S2;
        Sun, 07 Mar 2021 09:36:20 +0800 (CST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Mailer: BlackBerry Email (10.3.3.3216)
Message-ID: <20210307013618.5783639.28921.9491@loongson.cn>
Date:   Sun, 07 Mar 2021 09:36:18 +0800
Subject: Re: [PATCH 1/3] MIPS: sync arrangement of pt_regs with user_pt_regs and regoffset_table
From:   =?utf-8?b?6buE5rKb?= <huangpei@loongson.cn>
In-Reply-To: <20210306074711.GA4744@alpha.franken.de>
References: <20210305100310.26627-1-huangpei@loongson.cn>
 <20210305100310.26627-2-huangpei@loongson.cn>
 <20210306074711.GA4744@alpha.franken.de>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     ambrosehua@gmail.com, Bibo Mao <maobibo@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
X-CM-TRANSID: AQAAf9Dxr9cQLkRgpMcVAA--.6957S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1DZr1fWrWDurWUXr18Zrb_yoW8uFy5pF
        srCa1DKF4Ig348K3y7urZ5uryUJr1DG392gFZrt340qa4Yv3WfWrWSyw1DJr48ArWvqa48
        Cayavwn8CrZFva7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
        W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc2xSY4AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
        VjvjDU0xZFpf9x0JUChFxUUUUU=
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

What about other two patches? 


Current ftrace implementation is not safe on MIPS/SMP,

When disabling  tracing, we need to change 

Jal 
Addiu sp,sp,-offset

Into 

Nop
Nop

Atomically, but mips issue two writes, no 
matter ‎ in what order these writes are seen by
other cpu, ‎ it is wrecked in  these two case

Jal 
Nop

Or,

Nop
‎addiu sp,sp, _offset

‎Huang Pei


  Original Message  
From: Thomas Bogendoerfer
Sent: 2021年3月6日星期六 16:06
To: Huang Pei
Cc: ambrosehua@gmail.com; Bibo Mao; Andrew Morton; linux-mips@vger.kernel.org; linux-arch@vger.kernel.org; linux-mm@kvack.org; Jiaxun Yang; Paul Burton; Li Xuefeng; Yang Tiezhu; Gao Juxin; Huacai Chen; Jinyang He
Subject: Re: [PATCH 1/3] MIPS: sync arrangement of pt_regs with user_pt_regs and regoffset_table

On Fri, Mar 05, 2021 at 06:03:08PM +0800, Huang Pei wrote:
> Signed-off-by: Huang Pei <huangpei@loongson.cn>
> ---
> arch/mips/include/asm/ptrace.h | 10 +++++-----
> arch/mips/kernel/asm-offsets.c | 6 +++---
> arch/mips/kernel/ptrace.c | 10 +++++-----
> 3 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
> index 1e76774b36dd..e51691f2b7af 100644
> --- a/arch/mips/include/asm/ptrace.h
> +++ b/arch/mips/include/asm/ptrace.h
> @@ -34,16 +34,16 @@ struct pt_regs {
> /* Saved main processor registers. */
> unsigned long regs[32];
> 
> +	unsigned long lo;
> +	unsigned long hi;
> /* Saved special registers. */
> +	unsigned long cp0_epc;
> +	unsigned long cp0_badvaddr;
> unsigned long cp0_status;
> -	unsigned long hi;
> -	unsigned long lo;
> +	unsigned long cp0_cause;
> #ifdef CONFIG_CPU_HAS_SMARTMIPS
> unsigned long acx;
> #endif
> -	unsigned long cp0_badvaddr;
> -	unsigned long cp0_cause;
> -	unsigned long cp0_epc;
> #ifdef CONFIG_CPU_CAVIUM_OCTEON
> unsigned long long mpl[6]; /* MTM{0-5} */
> unsigned long long mtp[6]; /* MTP{0-5} */

sorry this is pointless, I'm not taking this.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea. [ RFC1925, 2.3 ]

