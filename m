Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B801A585F95
	for <lists+linux-arch@lfdr.de>; Sun, 31 Jul 2022 17:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbiGaPtB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 31 Jul 2022 11:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiGaPtA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 31 Jul 2022 11:49:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BED9E0DA;
        Sun, 31 Jul 2022 08:48:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32C8860AE5;
        Sun, 31 Jul 2022 15:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A855CC433D6;
        Sun, 31 Jul 2022 15:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659282538;
        bh=BpVa9XKiTUOgz9LsKONU0g8nIyCwFAdKHoQkKOfJZG0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ezrAupgkv1KT72574l5osh6l5yi3NzrFxWmQrBAx9UstB4YHCONW1fFz8yFAV0saC
         B9+OERGYa+EPlvvjHFIUUbPQgPaoml64eG6icHsFPeU74HxsZ5izPdeuzzC2p/UKXx
         /0rAyJevGiPvBiEajNnxgxELO3JUMD2APZdSXABzMkH8pMKLfqkfPPsSlXbFqw3nlZ
         RXF2PfAjKLH0Vm9+wWVCXbpOPPkRpY2ESn47bvf+S82AJ8jOrJQ/OKJpH8YruFnmwF
         7YLjnv8X5NFNoZq2U8x6xP51UPWsryFZCHI+CP+X4nGOwigZWWEjbw3ZSSeSCy7Svp
         dREEN86bbTm5Q==
Date:   Mon, 1 Aug 2022 00:48:54 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <mhiramat@kernel.org>
Subject: Re: [PATCH] kprobes: Forbid probing on kprobe_insn_slot
Message-Id: <20220801004854.9c2b36f38fe5ad19b2271196@kernel.org>
In-Reply-To: <20220727032058.60444-1-chenzhongjin@huawei.com>
References: <20220727032058.60444-1-chenzhongjin@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 27 Jul 2022 11:20:58 +0800
Chen Zhongjin <chenzhongjin@huawei.com> wrote:

> Syzkaller reported a BUG on arm64:
> Unrecoverable kprobe detected.
> Dumping kprobe:
> Name: (null)
> Offset: 0
> Address: 0xffffa00010019000
> ------------[ cut here ]------------
> kernel BUG at arch/arm64/kernel/probes/kprobes.c:235!
> Internal error: Oops - BUG: 0 [#1] SMP
> Modules linked in:
> CPU: 1 PID: 31060 Comm: syz-executor.6 Not tainted 5.10.0 #11
> ...
> Call trace:
>  reenter_kprobe arch/arm64/kernel/probes/kprobes.c:234 [inline]
>  kprobe_handler+0x23c/0x26c arch/arm64/kernel/probes/kprobes.c:339
>  kprobe_breakpoint_handler+0x24/0x34 arch/arm64/kernel/probes/kprobes.c:406
>  call_break_hook+0xf4/0x13c arch/arm64/kernel/debug-monitors.c:322
>  brk_handler+0x2c/0xa0 arch/arm64/kernel/debug-monitors.c:329
>  do_debug_exception+0x140/0x230 arch/arm64/mm/fault.c:867
>  el1_dbg+0x38/0x50 arch/arm64/kernel/entry-common.c:182
>  el1_sync_handler+0xf4/0x150 arch/arm64/kernel/entry-common.c:219
>  el1_sync+0x74/0x100 arch/arm64/kernel/entry.S:665
>  0xffffa00010019000
>  do_futex+0x2f4/0x370 kernel/futex.c:3735
>  __do_sys_futex kernel/futex.c:3798 [inline]
>  __se_sys_futex kernel/futex.c:3764 [inline]
>  __arm64_sys_futex+0x168/0x3a0 kernel/futex.c:3764
>  __invoke_syscall arch/arm64/kernel/syscall.c:36 [inline]
>  invoke_syscall arch/arm64/kernel/syscall.c:48 [inline]
>  el0_svc_common.constprop.0+0xf4/0x414 arch/arm64/kernel/syscall.c:155
>  do_el0_svc+0x50/0x11c arch/arm64/kernel/syscall.c:217
>  el0_svc+0x20/0x30 arch/arm64/kernel/entry-common.c:353
>  el0_sync_handler+0xe4/0x1e0 arch/arm64/kernel/entry-common.c:369
>  el0_sync+0x148/0x180 arch/arm64/kernel/entry.S:683
> Code: 91018360 97ff1838 aa1703e0 97ff1fdf (d4210000)
> ---[ end trace 767503e946e01b15 ]---
> 
> Syzbot tried to porbe on a kprobe_insn_slot.
> 
> kprobe will replace instruciton with a break and store the origin one
> on kprobe_insn_slot. However these slots are not in .kprobes.text and
> exported by perf_event_ksymbol so can be probed by perf interface.
> 
> Probing these slots will triggers kprobe handler inside single step
> process and for some architectures such as arm64 this will causes a
> bug().
> 
> These slots are kprobe process so they should not be probed anyway.
> Add kprobe_insn_slot check when register_kprobe to forbid probing on
> these slots.

Oops, good catch!

Previously this was not counted as text area, but now the kernel_text_address()
returns true for these trampoline buffers.

In this case, I think kprobes should be limited to probe only
core_kernel_text and module_text.
Can you use is_module_text_address() and core_kernel_text() instead?
Below can allow kprobes probing on other trampolines like ftrace and
bpf.
Also, you may need this tag;

Fixes: 5b485629ba0d ("kprobes, extable: Identify kprobes trampolines as kernel text area")

Thank you,

> 
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>  kernel/kprobes.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index f214f8c088ed..3e798b62db70 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1562,6 +1562,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
>  	/* Ensure it is not in reserved area nor out of text */
>  	if (!kernel_text_address((unsigned long) p->addr) ||
>  	    within_kprobe_blacklist((unsigned long) p->addr) ||
> +	    is_kprobe_insn_slot((unsigned long) p->addr) ||
> +	    is_kprobe_optinsn_slot((unsigned long) p->addr) ||
>  	    jump_label_text_reserved(p->addr, p->addr) ||
>  	    static_call_text_reserved(p->addr, p->addr) ||
>  	    find_bug((unsigned long)p->addr)) {
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
