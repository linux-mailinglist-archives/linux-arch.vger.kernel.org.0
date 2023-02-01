Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC916862EC
	for <lists+linux-arch@lfdr.de>; Wed,  1 Feb 2023 10:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjBAJg2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Feb 2023 04:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjBAJg1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Feb 2023 04:36:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F5035271;
        Wed,  1 Feb 2023 01:36:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42A5361743;
        Wed,  1 Feb 2023 09:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C195DC433D2;
        Wed,  1 Feb 2023 09:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675244185;
        bh=nAUpo7Q/j5KNuIbds1/t9+qLE0Sz0LS9dwd79h6snqA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MnUP0akeHlBOwbavhm30X5chkZO3+OJe3TOoJNsAHr5hnMZic8jEIGc5X7gUZRMyc
         nf3tGrXHj8+IfEuq+xt6tKKwq2OkUU3ZMGSc19KEJg/OIaNdiVooZ+LDYoFKan05i+
         ZMGHI0mWWutb5N8Z+vIxC4fF9cujxJu+QC7VTNgDCMos3HWWXHrYuRPjcpzXJO6CoP
         LrwNVz2Sme6JqnAneVfbBukd2axbn+hVsGAJ6aPCGwQUJcWqxbmCBDmKzBDih3NKDB
         nUeYXaNhOKoofac1aS25Yz/7CMfyfcYSVC70Dt/4EmplrFdmBSlPUY8JzkEmnY/jat
         0C18H99CFcptg==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     guoren@kernel.org, guoren@kernel.org, palmer@rivosinc.com,
        conor.dooley@microchip.com, liaochang1@huawei.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V2] riscv: kprobe: Fixup kernel panic when probing an
 illegal position
In-Reply-To: <20230201040604.3390509-1-guoren@kernel.org>
References: <20230201040604.3390509-1-guoren@kernel.org>
Date:   Wed, 01 Feb 2023 10:36:22 +0100
Message-ID: <87y1phpw15.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

guoren@kernel.org writes:

> From: Guo Ren <guoren@linux.alibaba.com>
>
> The kernel would panic when probed for an illegal position. eg:
>
> (CONFIG_RISCV_ISA_C=3Dn)
>
> echo 'p:hello kernel_clone+0x16 a0=3D%a0' >> kprobe_events
> echo 1 > events/kprobes/hello/enable
> cat trace
>
> Kernel panic - not syncing: stack-protector: Kernel stack
> is corrupted in: __do_sys_newfstatat+0xb8/0xb8
> CPU: 0 PID: 111 Comm: sh Not tainted
> 6.2.0-rc1-00027-g2d398fe49a4d #490
> Hardware name: riscv-virtio,qemu (DT)
> Call Trace:
> [<ffffffff80007268>] dump_backtrace+0x38/0x48
> [<ffffffff80c5e83c>] show_stack+0x50/0x68
> [<ffffffff80c6da28>] dump_stack_lvl+0x60/0x84
> [<ffffffff80c6da6c>] dump_stack+0x20/0x30
> [<ffffffff80c5ecf4>] panic+0x160/0x374
> [<ffffffff80c6db94>] generic_handle_arch_irq+0x0/0xa8
> [<ffffffff802deeb0>] sys_newstat+0x0/0x30
> [<ffffffff800158c0>] sys_clone+0x20/0x30
> [<ffffffff800039e8>] ret_from_syscall+0x0/0x4
> ---[ end Kernel panic - not syncing: stack-protector:
> Kernel stack is corrupted in: __do_sys_newfstatat+0xb8/0xb8 ]---
>
> That is because the kprobe's ebreak instruction broke the kernel's
> original code. The user should guarantee the correction of the probe
> position, but it couldn't make the kernel panic.
>
> This patch adds arch_check_kprobe in arch_prepare_kprobe to prevent an
> illegal position (Such as the middle of an instruction).
>
> Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
> Changelog
> V2:
>  - Fixup misaligned load (Thx Bjorn)

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
