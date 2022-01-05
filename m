Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D69C485BB8
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 23:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245094AbiAEWdh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jan 2022 17:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245080AbiAEWde (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jan 2022 17:33:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68371C061245;
        Wed,  5 Jan 2022 14:33:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2590EB81E3D;
        Wed,  5 Jan 2022 22:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4498FC36AF4;
        Wed,  5 Jan 2022 22:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641422011;
        bh=V+pJxEa7+aavL4U6A2VgxzbbvSp1DeQ4c/dXqTqcxLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fWnEb653GKPS44yyddsJLus2Hz7kMix9+5exfDPx8qbDMjRFZoxDwe0+XDZgiG/+J
         HMlSxytT9mfEQfDkJLx6rdlxTToo962BGRW/EonZc2xxGeplYd3NIC2W4rQrnOTur7
         yF6SMSmYB6HIKVWhgmNAhzc7/jiaGBUGdJd4J+hLvutYzseoZZKztt9znepRfWsJs6
         ooLjoXCYg9ZODkwL6oZtfdfZJ7/94auTuroAU1QTlWWZ0rYyLb5rO8AaPMuM8ZEpmG
         9M1fN/0TPdKACh5cZE2h6ppduarqWtSXTzU6FDQtNVjkOffe6dxuVY+sOQ0LAf/5wX
         8ZUlLkjRmilvA==
Date:   Wed, 5 Jan 2022 15:33:26 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>, llvm@lists.linux.dev
Subject: Re: [PATCH 0000/2297] [ANNOUNCE, RFC] "Fast Kernel Headers" Tree
 -v1: Eliminate the Linux kernel's "Dependency Hell"
Message-ID: <YdYctmnM6kdN5R5s@archlinux-ax161>
References: <YdIfz+LMewetSaEB@gmail.com>
 <YdM4Z5a+SWV53yol@archlinux-ax161>
 <YdQlwnDs2N9a5Reh@gmail.com>
 <YdSI9LmZE+FZAi1K@archlinux-ax161>
 <YdTpAJxgI+s9Wwgi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdTpAJxgI+s9Wwgi@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 05, 2022 at 01:40:32AM +0100, Ingo Molnar wrote:
> 
> * Nathan Chancellor <nathan@kernel.org> wrote:
> 
> > Unfortunately, while the kernel now builds, it does not boot in QEMU. I 
> > tried to checkout at 9006a48618cc0cacd3f59ff053e6509a9af5cc18 to see if I 
> > could reproduce that breakage there but the build errors out at that 
> > change (I do see notes of bisection breakage in some of the commits) so I 
> > assume that is expected.
> 
> Yeah, there's a breakage window on ARM64, I'll track down that 
> bisectability bug.
> 
> Decoupling thread_info and task_struct incrementally, so that it bisects 
> cleanly on all architectures, was always a big challenge. :-/
> 
> > There is no output, even with earlycon, so it seems like something is 
> > going wrong in early boot code. I am not very familiar with the SCS code 
> > so I will see if I can debug this with gdb later (I'll try to see if it 
> > is reproducible with GCC as well; as Nick mentions, there is support 
> > being added to it and I don't mind building from source).
> 
> Just to make sure: with SCS disabled the same kernel boots fine?

Correct (thank you for making sure, I have definitely not tested that
before...).

$ make -skj"$(nproc)" ARCH=arm64 LLVM=1 O=.build/arm64 defconfig Image.gz

$ boot-qemu.sh -a arm64 -k .build/arm64 -t 30s
...
[    0.000000] Linux version 5.16.0-rc8-798083-g1755441e323b (nathan@archlinux-ax161) (ClangBuiltLinux clang version 14.0.0 (https://github.com/llvm/llvm-project 4602f4169a21e75b82261ba1599046b157d1d021), LLD 14.0.0) #1 SMP PREEMPT Wed Jan 5 21:51:29 UTC 2022
...

$ make -skj"$(nproc)" ARCH=arm64 LLVM=1 O=.build/arm64.scs defconfig

$ scripts/config --file .build/arm64.scs/.config -e SHADOW_CALL_STACK

$ make -skj"$(nproc)" ARCH=arm64 LLVM=1 O=.build/arm64.scs olddefconfig Image.gz
...
qemu-system-aarch64: terminating on signal 15 from pid 690472 (timeout)
+ RET=124
+ set +x

Going back to v5.16-rc8, everything works fine.

$ boot-qemu.sh -a arm64 -k .build/arm64 -t 30s
...
[    0.000000] Linux version 5.16.0-rc8-795784-gc9e6606c7fe9 (nathan@archlinux-ax161) (ClangBuiltLinux clang version 14.0.0 (https://github.com/llvm/llvm-project 4602f4169a21e75b82261ba1599046b157d1d021), LLD 14.0.0) #1 SMP PREEMPT Wed Jan 5 22:27:39 UTC 2022
...

I don't think I will have time to look at this today but I will try
tomorrow. Having the bisectability bug fixed would help narrow things
down but I am almost certain it is something up with the new per_task
infrastructure but I'll have to dig around and see if I can understand
that first.

Cheers,
Nathan
