Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC7E589735
	for <lists+linux-arch@lfdr.de>; Thu,  4 Aug 2022 06:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiHDEzZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Aug 2022 00:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiHDEzY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Aug 2022 00:55:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457419FE2;
        Wed,  3 Aug 2022 21:55:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5D40B82493;
        Thu,  4 Aug 2022 04:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE07C433D6;
        Thu,  4 Aug 2022 04:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659588920;
        bh=HnsU+b8k30Q3vGwqLH//3BHKuwTI/NeOTRFdsLejRrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pHPZDwP7URy67k76afgFsEaz5LW9tQzOCmSft6/vcJu8aciaTzdAWofgx+XM8Sq4N
         DjB17lmc1LbgW5iBiMzTw8yGUXnhz1Trs8soeRPY8jJOZwie3qHaATQaCtquHk1cGX
         kDK2tsPnl5kA5ZQdYLWVwPG3DDt06onaQaFF9EcfS+/pEVkb2PVBet5MbfLbJlm2bN
         Tyvdz0T56hm4iulHmW6/hGgQQDU3TeCF/1VgEP0/SVSQpO3YiC17hQYsaMlm6kCpC3
         eQ1y1wOWTPNJM+1uhjqquAfyDiDIaHzyf6gTs5Ng2qNfa+2nGZhq05qL3p/G+L1U9M
         NRxPO6GkMnULg==
Date:   Wed, 3 Aug 2022 21:55:18 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mbenes@suse.cz
Subject: Re: [PATCH] Revert "x86/unwind/orc: Don't skip the first frame for
 inactive tasks"
Message-ID: <20220804045518.bfhe3rxhpkxzn4hk@treble>
References: <20220727031506.59322-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220727031506.59322-1-chenzhongjin@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 27, 2022 at 11:15:06AM +0800, Chen Zhongjin wrote:
> This reverts commit f1d9a2abff66aa8156fbc1493abed468db63ea48.
> 
> When CONFIG_GCOV_PROFILE_ALL is enabled, show_stack() and related
> functions (e.g. dump_stack) will break for x86 ORC unwinder.
> 
> Call Trace:
>  <TASK>
>  ? dump_stack_lvl+0x83/0xb7
>  ? schedule+0x1/0x190
>  ? dump_stack+0x13/0x1f
>  ? handler_pre0+0x3f/0x53 [kp_unwind]
>  ...
> 
> show_trace_log_lvl() searches text address on stack to validate
> whether unwind results are reliable. The code:

Hi,

Thanks for the patch.  The change itself makes sense, though I'm having
trouble recreating the bug described in the patch description.

I enabled CONFIG_GCOV_PROFILE_ALL and did 'echo l >
/proc/sysrq-trigger', but I got a valid stack trace:

  # echo l > /proc/sysrq-trigger
  [  343.916728] sysrq: Show backtrace of all active CPUs
  [  343.917459] NMI backtrace for cpu 2
  [  343.917884] CPU: 2 PID: 1007 Comm: bash Not tainted 5.19.0-rc8+ #68
  [  343.918562] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-1.fc36 04/01/2014
  [  343.919534] Call Trace:
  [  343.919904]  <TASK>
  [  343.920226]  dump_stack_lvl+0xcc/0x11b
  [  343.920742]  dump_stack+0x17/0x24
  [  343.921199]  nmi_cpu_backtrace.cold+0xb5/0x10d
  [  343.921795]  ? lapic_can_unplug_cpu+0xa0/0xa0
  [  343.922375]  nmi_trigger_cpumask_backtrace+0x171/0x200
  [  343.923053]  arch_trigger_cpumask_backtrace+0x21/0x30
  [  343.923599]  sysrq_handle_showallcpus+0x1f/0x30
  [  343.924104]  __handle_sysrq.cold+0x81/0x234
  [  343.924576]  write_sysrq_trigger+0x6a/0x90
  [  343.925098]  proc_reg_write+0x99/0x120
  [  343.925587]  vfs_write+0x16c/0x350
  [  343.926093]  ksys_write+0x8c/0x180
  [  343.926597]  __x64_sys_write+0x21/0x30
  [  343.927144]  do_syscall_64+0x76/0x100
  [  343.927676]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
  [  343.928343] RIP: 0033:0x7f555e8f7b50
  [  343.928822] Code: 73 01 c3 48 8b 0d 38 83 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 79 db 2c 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 1e e3 01 00 48 89 04 24
  [  343.930801] RSP: 002b:00007ffdd20d0978 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
  [  343.931761] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f555e8f7b50
  [  343.932551] RDX: 0000000000000002 RSI: 000055ff471bfe20 RDI: 0000000000000001
  [  343.933347] RBP: 000055ff471bfe20 R08: 00007f555ebc2740 R09: 00007f555f80f700
  [  343.934155] R10: 0000000000000073 R11: 0000000000000246 R12: 0000000000000002
  [  343.934962] R13: 0000000000000001 R14: 00007f555ebc15e0 R15: 00007f555ebbd3c0
  [  343.935798]  </TASK>
  [  343.936341] Sending NMI from CPU 2 to CPUs 0-1,3:
  [  343.937163] NMI backtrace for cpu 3
  [  343.937167] CPU: 3 PID: 600 Comm: systemd-journal Not tainted 5.19.0-rc8+ #68

Was this with an upstream kernel?  Can you share the config and
toolchain versions?

-- 
Josh
