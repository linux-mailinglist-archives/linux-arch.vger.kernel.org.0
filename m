Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22FF341784
	for <lists+linux-arch@lfdr.de>; Fri, 19 Mar 2021 09:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbhCSI3Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Mar 2021 04:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbhCSI3B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Mar 2021 04:29:01 -0400
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [IPv6:2001:1600:4:17::190a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10955C06174A
        for <linux-arch@vger.kernel.org>; Fri, 19 Mar 2021 01:29:01 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4F1xr76p6KzMpnlT;
        Fri, 19 Mar 2021 09:28:55 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4F1xr506LQzlh8TD;
        Fri, 19 Mar 2021 09:28:52 +0100 (CET)
Subject: Re: [security:landlock_lsm 8/12] kernel/sys_ni.c:270:1: warning: no
 previous prototype for function '__arm64_sys_landlock_create_ruleset'
To:     kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        James Morris <jamorris@linux.microsoft.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Jann Horn <jannh@google.com>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <202103191225.cgrp2F0E-lkp@intel.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <0491a550-4800-fd39-fea4-468b7aed110b@digikod.net>
Date:   Fri, 19 Mar 2021 09:29:08 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <202103191225.cgrp2F0E-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This kind of warnings will be fixed with
https://lore.kernel.org/lkml/20210301131533.64671-2-masahiroy@kernel.org/


On 19/03/2021 05:56, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git landlock_lsm
> head:   f642729df39003efe2a9bfa341a95759d712eb35
> commit: c5eafae25eb54cc5354f0675a88a34f03c08f559 [8/12] landlock: Add syscall implementations
> config: arm64-randconfig-r033-20210318 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project fcc1ce00931751ac02498986feb37744e9ace8de)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git/commit/?id=c5eafae25eb54cc5354f0675a88a34f03c08f559
>         git remote add security https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
>         git fetch --no-tags security landlock_lsm
>         git checkout c5eafae25eb54cc5354f0675a88a34f03c08f559
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                                   ^
>    <scratch space>:21:1: note: expanded from here
>    __arm64_sys_shutdown
>    ^
>    kernel/sys_ni.c:250:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                       ^
>    kernel/sys_ni.c:251:1: warning: no previous prototype for function '__arm64_sys_recvfrom' [-Wmissing-prototypes]
>    COND_SYSCALL(recvfrom);
>    ^
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                                   ^
>    <scratch space>:22:1: note: expanded from here
>    __arm64_sys_recvfrom
>    ^
>    kernel/sys_ni.c:251:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                       ^
>    kernel/sys_ni.c:253:1: warning: no previous prototype for function '__arm64_sys_sendmsg' [-Wmissing-prototypes]
>    COND_SYSCALL(sendmsg);
>    ^
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                                   ^
>    <scratch space>:27:1: note: expanded from here
>    __arm64_sys_sendmsg
>    ^
>    kernel/sys_ni.c:253:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                       ^
>    kernel/sys_ni.c:255:1: warning: no previous prototype for function '__arm64_sys_recvmsg' [-Wmissing-prototypes]
>    COND_SYSCALL(recvmsg);
>    ^
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                                   ^
>    <scratch space>:32:1: note: expanded from here
>    __arm64_sys_recvmsg
>    ^
>    kernel/sys_ni.c:255:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                       ^
>    kernel/sys_ni.c:261:1: warning: no previous prototype for function '__arm64_sys_mremap' [-Wmissing-prototypes]
>    COND_SYSCALL(mremap);
>    ^
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                                   ^
>    <scratch space>:37:1: note: expanded from here
>    __arm64_sys_mremap
>    ^
>    kernel/sys_ni.c:261:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                       ^
>    kernel/sys_ni.c:264:1: warning: no previous prototype for function '__arm64_sys_add_key' [-Wmissing-prototypes]
>    COND_SYSCALL(add_key);
>    ^
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                                   ^
>    <scratch space>:38:1: note: expanded from here
>    __arm64_sys_add_key
>    ^
>    kernel/sys_ni.c:264:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                       ^
>    kernel/sys_ni.c:265:1: warning: no previous prototype for function '__arm64_sys_request_key' [-Wmissing-prototypes]
>    COND_SYSCALL(request_key);
>    ^
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                                   ^
>    <scratch space>:39:1: note: expanded from here
>    __arm64_sys_request_key
>    ^
>    kernel/sys_ni.c:265:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                       ^
>    kernel/sys_ni.c:266:1: warning: no previous prototype for function '__arm64_sys_keyctl' [-Wmissing-prototypes]
>    COND_SYSCALL(keyctl);
>    ^
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                                   ^
>    <scratch space>:40:1: note: expanded from here
>    __arm64_sys_keyctl
>    ^
>    kernel/sys_ni.c:266:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                       ^
>>> kernel/sys_ni.c:270:1: warning: no previous prototype for function '__arm64_sys_landlock_create_ruleset' [-Wmissing-prototypes]
>    COND_SYSCALL(landlock_create_ruleset);
>    ^
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                                   ^
>    <scratch space>:45:1: note: expanded from here
>    __arm64_sys_landlock_create_ruleset
>    ^
>    kernel/sys_ni.c:270:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                       ^
>>> kernel/sys_ni.c:271:1: warning: no previous prototype for function '__arm64_sys_landlock_add_rule' [-Wmissing-prototypes]
>    COND_SYSCALL(landlock_add_rule);
>    ^
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                                   ^
>    <scratch space>:46:1: note: expanded from here
>    __arm64_sys_landlock_add_rule
>    ^
>    kernel/sys_ni.c:271:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                       ^
>>> kernel/sys_ni.c:272:1: warning: no previous prototype for function '__arm64_sys_landlock_restrict_self' [-Wmissing-prototypes]
>    COND_SYSCALL(landlock_restrict_self);
>    ^
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                                   ^
>    <scratch space>:47:1: note: expanded from here
>    __arm64_sys_landlock_restrict_self
>    ^
>    kernel/sys_ni.c:272:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                       ^
>    kernel/sys_ni.c:277:1: warning: no previous prototype for function '__arm64_sys_fadvise64_64' [-Wmissing-prototypes]
>    COND_SYSCALL(fadvise64_64);
>    ^
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                                   ^
>    <scratch space>:48:1: note: expanded from here
>    __arm64_sys_fadvise64_64
>    ^
>    kernel/sys_ni.c:277:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                       ^
>    kernel/sys_ni.c:280:1: warning: no previous prototype for function '__arm64_sys_swapon' [-Wmissing-prototypes]
>    COND_SYSCALL(swapon);
>    ^
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                                   ^
>    <scratch space>:49:1: note: expanded from here
>    __arm64_sys_swapon
>    ^
>    kernel/sys_ni.c:280:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                       ^
>    kernel/sys_ni.c:281:1: warning: no previous prototype for function '__arm64_sys_swapoff' [-Wmissing-prototypes]
>    COND_SYSCALL(swapoff);
>    ^
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                                   ^
>    <scratch space>:50:1: note: expanded from here
>    __arm64_sys_swapoff
>    ^
>    kernel/sys_ni.c:281:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                       ^
>    kernel/sys_ni.c:282:1: warning: no previous prototype for function '__arm64_sys_mprotect' [-Wmissing-prototypes]
>    COND_SYSCALL(mprotect);
>    ^
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                                   ^
>    <scratch space>:51:1: note: expanded from here
>    __arm64_sys_mprotect
>    ^
>    kernel/sys_ni.c:282:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                       ^
>    kernel/sys_ni.c:283:1: warning: no previous prototype for function '__arm64_sys_msync' [-Wmissing-prototypes]
>    COND_SYSCALL(msync);
>    ^
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                                   ^
>    <scratch space>:52:1: note: expanded from here
>    __arm64_sys_msync
>    ^
>    kernel/sys_ni.c:283:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                       ^
>    kernel/sys_ni.c:284:1: warning: no previous prototype for function '__arm64_sys_mlock' [-Wmissing-prototypes]
>    COND_SYSCALL(mlock);
>    ^
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                                   ^
>    <scratch space>:53:1: note: expanded from here
>    __arm64_sys_mlock
>    ^
>    kernel/sys_ni.c:284:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                       ^
>    kernel/sys_ni.c:285:1: warning: no previous prototype for function '__arm64_sys_munlock' [-Wmissing-prototypes]
>    COND_SYSCALL(munlock);
>    ^
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                                   ^
>    <scratch space>:54:1: note: expanded from here
>    __arm64_sys_munlock
>    ^
>    kernel/sys_ni.c:285:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> 
> 
> vim +/__arm64_sys_landlock_create_ruleset +270 kernel/sys_ni.c
> 
>    268	
>    269	/* security/landlock/syscalls.c */
>  > 270	COND_SYSCALL(landlock_create_ruleset);
>  > 271	COND_SYSCALL(landlock_add_rule);
>  > 272	COND_SYSCALL(landlock_restrict_self);
>    273	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
