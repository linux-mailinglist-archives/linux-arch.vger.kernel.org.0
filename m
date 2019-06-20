Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF3E4D9A5
	for <lists+linux-arch@lfdr.de>; Thu, 20 Jun 2019 20:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfFTSoz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Jun 2019 14:44:55 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43970 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfFTSoy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Jun 2019 14:44:54 -0400
Received: by mail-pl1-f193.google.com with SMTP id cl9so1724861plb.10;
        Thu, 20 Jun 2019 11:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZUQkb0G4ZCPKDrEvoX1BfK4MWYkIeDwjtEN0vUqPNkw=;
        b=MpFNLiT6zMfv6lZIUsgTarD0saHSc6px9pGCnHVv4o3SwD5Je+t3augvHoqNayH+69
         FW1ExZjtFRu3HjSf0LtHnKMdNSIF+jWt1th6i0kQqPdtfgHbtT7do93b92PJvMlCC9dv
         W1guz/52t6z9GTHUcGBwdmufV0cm0zPru1pXJpwPvMUPcTKNDwtQWDxjQM3IXwE69GFn
         3mU9AV8MeDWlpPf55RPmZPvdAe0H4mhgJci6euF0CjDBf7DQAbC+wbcGsLXzNiYqR/XB
         0G9D0V83hewGZ3mYCv877iAsi2OTTvLVbzh1hkB5ypCIL2XTcOCuTgzQUeEd2i9yh/AQ
         Ry9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZUQkb0G4ZCPKDrEvoX1BfK4MWYkIeDwjtEN0vUqPNkw=;
        b=Hx5wBhlmNwyaWlEqRV9HvYjoLoy+99jEMx5crnYKay5z87BwP/cl9yyzHiU3Zoq9e3
         qgBMxudJMu69YYFlmepWBdzhemIV5MdHZdt6IzqyNdlb+mebHK+y8hRUKiuFdJlMEooW
         Pz0Wt4b3jXDQdpLNxF3hV1pzLpA8/Hl6BzsCvzM7FFcXBS8e8b3tRZFIZW0AS+wmaXAW
         K1OQEDDi67hDrZuqm8ae+6eYn+Afil/aqEZ3N4RL2vfys4vmKYK9Rnu61wzMhPXOaeWk
         oRoI0vtoUvQsPrkTkycK8TSuVvKVpKfCx28/n/bJP+aZnW43GIAPC1SVyghGsZvicM/B
         MJmQ==
X-Gm-Message-State: APjAAAWYnv/p4qBhjoWMiBXduDxPI4uAB6XMvEM2LRFbCemWVn5/dKIH
        sjbdnLUfxNB/HlHgYHRYQUo=
X-Google-Smtp-Source: APXvYqzOnI3pkm62WhhgX9g/X3V1KxMheGzQeaimTCtkTbntSlVPaJT/oLykxHPMufJ0swIi/avZnA==
X-Received: by 2002:a17:902:30a3:: with SMTP id v32mr127734872plb.6.1561056293930;
        Thu, 20 Jun 2019 11:44:53 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l63sm169837pfl.181.2019.06.20.11.44.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 11:44:53 -0700 (PDT)
Date:   Thu, 20 Jun 2019 11:44:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christian Brauner <christian@brauner.io>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, jannh@google.com,
        keescook@chromium.org, fweimer@redhat.com, oleg@redhat.com,
        arnd@arndb.de, dhowells@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 2/2] arch: wire-up clone3() syscall
Message-ID: <20190620184451.GA28543@roeck-us.net>
References: <20190604160944.4058-1-christian@brauner.io>
 <20190604160944.4058-2-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604160944.4058-2-christian@brauner.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 04, 2019 at 06:09:44PM +0200, Christian Brauner wrote:
> Wire up the clone3() call on all arches that don't require hand-rolled
> assembly.
> 
> Some of the arches look like they need special assembly massaging and it is
> probably smarter if the appropriate arch maintainers would do the actual
> wiring. Arches that are wired-up are:
> - x86{_32,64}
> - arm{64}
> - xtensa
> 

This patch results in build failures on various architecetures.

h8300-linux-ld: arch/h8300/kernel/syscalls.o:(.data+0x6d0): undefined reference to `sys_clone3'

nios2-linux-ld: arch/nios2/kernel/syscall_table.o:(.data+0x6d0): undefined reference to `sys_clone3'

There may be others; -next is in too bad shape right now to get a complete
picture. Wondering, though: What is special with this syscall ? Normally
one would only get a warning that a syscall is not wired up.

Guenter

> Signed-off-by: Christian Brauner <christian@brauner.io>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Adrian Reber <adrian@lisas.de>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Florian Weimer <fweimer@redhat.com>
> Cc: linux-api@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: x86@kernel.org
> ---
> v1: unchanged
> v2: unchanged
> v3:
> - Christian Brauner <christian@brauner.io>:
>   - wire up clone3 on all arches that don't have hand-rolled entry points
>     for clone
> ---
>  arch/arm/tools/syscall.tbl                  | 1 +
>  arch/arm64/include/asm/unistd.h             | 2 +-
>  arch/arm64/include/asm/unistd32.h           | 2 ++
>  arch/microblaze/kernel/syscalls/syscall.tbl | 1 +
>  arch/x86/entry/syscalls/syscall_32.tbl      | 1 +
>  arch/x86/entry/syscalls/syscall_64.tbl      | 1 +
>  arch/xtensa/kernel/syscalls/syscall.tbl     | 1 +
>  include/uapi/asm-generic/unistd.h           | 4 +++-
>  8 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index aaf479a9e92d..e99a82bdb93a 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -447,3 +447,4 @@
>  431	common	fsconfig			sys_fsconfig
>  432	common	fsmount				sys_fsmount
>  433	common	fspick				sys_fspick
> +436	common	clone3				sys_clone3
> diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
> index 70e6882853c0..24480c2d95da 100644
> --- a/arch/arm64/include/asm/unistd.h
> +++ b/arch/arm64/include/asm/unistd.h
> @@ -44,7 +44,7 @@
>  #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
>  #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
>  
> -#define __NR_compat_syscalls		434
> +#define __NR_compat_syscalls		437
>  #endif
>  
>  #define __ARCH_WANT_SYS_CLONE
> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index c39e90600bb3..b144ea675d70 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -886,6 +886,8 @@ __SYSCALL(__NR_fsconfig, sys_fsconfig)
>  __SYSCALL(__NR_fsmount, sys_fsmount)
>  #define __NR_fspick 433
>  __SYSCALL(__NR_fspick, sys_fspick)
> +#define __NR_clone3 436
> +__SYSCALL(__NR_clone3, sys_clone3)
>  
>  /*
>   * Please add new compat syscalls above this comment and update
> diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
> index 26339e417695..3110440bcc31 100644
> --- a/arch/microblaze/kernel/syscalls/syscall.tbl
> +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
> @@ -439,3 +439,4 @@
>  431	common	fsconfig			sys_fsconfig
>  432	common	fsmount				sys_fsmount
>  433	common	fspick				sys_fspick
> +436	common	clone3				sys_clone3
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index ad968b7bac72..80e26211feff 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -438,3 +438,4 @@
>  431	i386	fsconfig		sys_fsconfig			__ia32_sys_fsconfig
>  432	i386	fsmount			sys_fsmount			__ia32_sys_fsmount
>  433	i386	fspick			sys_fspick			__ia32_sys_fspick
> +436	i386	clone3			sys_clone3			__ia32_sys_clone3
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index b4e6f9e6204a..7968f0b5b5e8 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -355,6 +355,7 @@
>  431	common	fsconfig		__x64_sys_fsconfig
>  432	common	fsmount			__x64_sys_fsmount
>  433	common	fspick			__x64_sys_fspick
> +436	common	clone3			__x64_sys_clone3/ptregs
>  
>  #
>  # x32-specific system call numbers start at 512 to avoid cache impact
> diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
> index 5fa0ee1c8e00..b2767c8c2b4e 100644
> --- a/arch/xtensa/kernel/syscalls/syscall.tbl
> +++ b/arch/xtensa/kernel/syscalls/syscall.tbl
> @@ -404,3 +404,4 @@
>  431	common	fsconfig			sys_fsconfig
>  432	common	fsmount				sys_fsmount
>  433	common	fspick				sys_fspick
> +436	common	clone3				sys_clone3
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index a87904daf103..45bc87687c47 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -844,9 +844,11 @@ __SYSCALL(__NR_fsconfig, sys_fsconfig)
>  __SYSCALL(__NR_fsmount, sys_fsmount)
>  #define __NR_fspick 433
>  __SYSCALL(__NR_fspick, sys_fspick)
> +#define __NR_clone3 436
> +__SYSCALL(__NR_clone3, sys_clone3)
>  
>  #undef __NR_syscalls
> -#define __NR_syscalls 434
> +#define __NR_syscalls 437
>  
>  /*
>   * 32 bit systems traditionally used different
