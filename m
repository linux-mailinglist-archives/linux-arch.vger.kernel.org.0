Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CC634A935
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 15:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhCZODB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Fri, 26 Mar 2021 10:03:01 -0400
Received: from mail.loongson.cn ([114.242.206.163]:48892 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229871AbhCZOCf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Mar 2021 10:02:35 -0400
Received: from [192.168.1.111] (unknown [175.152.148.180])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxr8tU6V1gRRgBAA--.961S2;
        Fri, 26 Mar 2021 22:01:58 +0800 (CST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 2/6] MIPS: move FTRACE_SYSCALLS from ftrace.c into
 syscall.c
From:   Huang Pei <huangpei@loongson.cn>
In-Reply-To: <20210325153845.759b242e@gandalf.local.home>
Date:   Fri, 26 Mar 2021 22:01:56 +0800
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
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <BE3DCFBC-7FF1-4636-8625-6A985A8341BC@loongson.cn>
References: <20210313064149.29276-1-huangpei@loongson.cn>
 <20210313064149.29276-3-huangpei@loongson.cn>
 <20210325153845.759b242e@gandalf.local.home>
To:     Steven Rostedt <rostedt@goodmis.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-CM-TRANSID: AQAAf9Dxr8tU6V1gRRgBAA--.961S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JrW7Gw1DCF4rWrWrAw4Dtwb_yoWkXrcEyF
        WxKFyvkw1UtFn5JFW5tr4rXFy3Ww45Xw4kZ3WqgrW5ZasxJa1DJFWDtrW3Xr1xXF18XFs0
        yw1fAryxtw12qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbVxFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
        1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
        cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
        ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc2xSY4AK67AK6ry5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjfUYXdjDUUUU
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I was intended to add -fpatchable-function-entry based new ftrace implementation in parallel 
with old -pg based one, which is enabled by supported gcc version at build time, since 

+. the fix for -fpatchable-function-entry is not merge into upstream; 

+. the -fpatchable-function-entry does not support static function tracing which is rarely used today, 
which is only implemented in the old -pg based implementation;

Move FTRACE_SYSCALLS into syscall.c, so both new and old implementation can easily be switched
freely. When everything is all right, old one can be easily removed, and that is patch 1/2/3 intended for

> On Mar 26, 2021, at 3:38 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> On Sat, 13 Mar 2021 14:41:45 +0800
> Huang Pei <huangpei@loongson.cn> wrote:
> 
> Why?
> 
> -- Steve
> 
>> Signed-off-by: Huang Pei <huangpei@loongson.cn>
>> ---
>> arch/mips/kernel/Makefile  |  1 -
>> arch/mips/kernel/ftrace.c  | 33 ---------------------------------
>> arch/mips/kernel/syscall.c | 32 ++++++++++++++++++++++++++++++++
>> 3 files changed, 32 insertions(+), 34 deletions(-)

