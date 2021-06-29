Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BCB3B7A04
	for <lists+linux-arch@lfdr.de>; Tue, 29 Jun 2021 23:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhF2Vro (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Jun 2021 17:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbhF2Vrn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Jun 2021 17:47:43 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EFCC061766;
        Tue, 29 Jun 2021 14:45:15 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d12so504621pfj.2;
        Tue, 29 Jun 2021 14:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=A5oiCFddMBtHVKPaQbxvpza19b53eNx0ygz9PISPkf4=;
        b=AIDp61eHInk1n04MZV/u8w8+58jO2JyoDeveHBymQFpuRWuBHSX35RHi9pvD3Hx+KK
         A1VZNUuiDjE/KXiuV40tMspU62gXVw6LHw4OSO4wO2fSpA5/QT29w9Qqd0dNRR7eAMjM
         2q1IsQTNdPCmW0WfZliQXf9XIzol4d4xPupizcj+V91qCBx2FgwnLd1VaQ1+et8FzJaC
         hy9Iefu+3u/RGz7+DzrawvqlviIa4mW8j79bJf5yWILOI8JpsLpo23maMoxBQHeIfe0V
         FMLOnzobhRFrwxd4zccDtNm0YBg1EGwrGktZ7Y3bGlkZZAwYt1aCxFzjk1lzVCBOXH8b
         nebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=A5oiCFddMBtHVKPaQbxvpza19b53eNx0ygz9PISPkf4=;
        b=i9aeW/dNjgK9HpWUB1+yPkYuNnBvNcEP8PtadQaw5rJfO7BRamoRE+Y+s6UEcbYsIE
         roTatd/6chKgVwsU7AE3NzwokrtZGAe3pN/NfzTWDZSzT/dvPqPWJMVdML3kn86WiLwf
         nzkzJYn04pIObX/3QzDDWB0UKLhF+5Luzc4shznITjyokKmN1vt9pGpEFVcuMB1pjb0I
         A1hNX1ybnwa7+fF2EGW37AAdYuB/roE8t5YAwJ2fNnCbDjij1LNmCk79UerG7H5UvTKc
         nZEM0ENm7i0gPjubhUbuREccRoyLkx4X6fFRzRs3Y+QtBGzgDJ+VOlbSXSqRuFspcUOE
         rU7A==
X-Gm-Message-State: AOAM531A9AWH13ry5ux7bQ+JqPH8NEe/bK23UuCuBd3f+tkO3i4l4GfE
        yYtgbVXiFEwS4s5mbGbgxvoGUp0fmJ5NCA==
X-Google-Smtp-Source: ABdhPJyh3NEXmINhbnE1RF2eiGYvq4qPtXE/11R8Abx6UFHayRCjWkXoczuyAkmxhOMUon7P79oFHg==
X-Received: by 2002:a63:e841:: with SMTP id a1mr30227282pgk.197.1625003114295;
        Tue, 29 Jun 2021 14:45:14 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:a440:d753:2c0f:b830? ([2001:df0:0:200c:a440:d753:2c0f:b830])
        by smtp.gmail.com with ESMTPSA id y6sm19256343pgk.79.2021.06.29.14.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 14:45:13 -0700 (PDT)
Subject: Re: [CFT][PATCH] exit/bdflush: Remove the deprecated bdflush system
 call
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>, Tejun Heo <tj@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org
References: <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
 <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
 <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
 <87a6njf0ia.fsf@disp2133>
 <CAHk-=wh4_iMRmWcao6a8kCvR0Hhdrz+M9L+q4Bfcwx9E9D0huw@mail.gmail.com>
 <87tulpbp19.fsf@disp2133>
 <CAHk-=wi_kQAff1yx2ufGRo2zApkvqU8VGn7kgPT-Kv71FTs=AA@mail.gmail.com>
 <87zgvgabw1.fsf@disp2133> <875yy3850g.fsf_-_@disp2133>
 <YNULA+Ff+eB66bcP@zeniv-ca.linux.org.uk>
 <YNj4DItToR8FphxC@zeniv-ca.linux.org.uk>
 <6e283d24-7121-ae7c-d5ad-558f85858a09@gmail.com>
 <CAMuHMdXSU6_98NbC1UWTT_kmwxD=6Ha5LJxFAtbSuD=y78nASg@mail.gmail.com>
 <7ad6c3a9-b983-46a5-fc95-f961b636d3fe@gmail.com>
 <CAMuHMdUi5Ri=GmWzS8hb7dkfPyAE=HpQHg6OsKSLDse_364E=g@mail.gmail.com>
 <dbb4ca2d-a857-84f0-f167-5ad4e06aa52b@gmail.com>
 <CAMuHMdVKdZNBU-cTUY0zotA5DmtQ=dxH+iFY0_GX=4DzqpycZQ@mail.gmail.com>
 <36123b5d-daa0-6c2b-f2d4-a942f069fd54@gmail.com> <87sg10quue.fsf_-_@disp2133>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <8043e5b4-20d2-0773-44f9-cc73e083e419@gmail.com>
Date:   Wed, 30 Jun 2021 09:45:04 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87sg10quue.fsf_-_@disp2133>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 30/06/21 8:28 am, Eric W. Biederman wrote:
> The bdflush system call has been deprecated for a very long time.
> Recently Michael Schmitz tested[1] and found that the last known
> caller of of the bdflush system call is unaffected by it's removal.
>
> Since the code is not needed delete it.
>
> [1] https://lkml.kernel.org/r/36123b5d-daa0-6c2b-f2d4-a942f069fd54@gmail.com
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Tested-by: Michael Schmitz <schmitzmic@gmail.com>
> ---
>
> I think we have consensus that bdflush can be removed. Can folks please
> verify I have removed it correctly?
>
> Michael could you give me a Tested-by on this patch?
>
>   arch/alpha/kernel/syscalls/syscall.tbl        |  2 +-
>   arch/arm/tools/syscall.tbl                    |  2 +-
>   arch/arm64/include/asm/unistd32.h             |  2 +-
>   arch/ia64/kernel/syscalls/syscall.tbl         |  2 +-
>   arch/m68k/kernel/syscalls/syscall.tbl         |  2 +-
>   arch/microblaze/kernel/syscalls/syscall.tbl   |  2 +-
>   arch/mips/kernel/syscalls/syscall_o32.tbl     |  2 +-
>   arch/parisc/kernel/syscalls/syscall.tbl       |  2 +-
>   arch/powerpc/kernel/syscalls/syscall.tbl      |  2 +-
>   arch/s390/kernel/syscalls/syscall.tbl         |  2 +-
>   arch/sh/kernel/syscalls/syscall.tbl           |  2 +-
>   arch/sparc/kernel/syscalls/syscall.tbl        |  2 +-
>   arch/x86/entry/syscalls/syscall_32.tbl        |  2 +-
>   arch/xtensa/kernel/syscalls/syscall.tbl       |  2 +-
>   fs/buffer.c                                   | 27 -------------------
>   include/linux/syscalls.h                      |  1 -
>   include/uapi/linux/capability.h               |  1 -
>   kernel/sys_ni.c                               |  1 -
>   .../arch/powerpc/entry/syscalls/syscall.tbl   |  2 +-
>   .../perf/arch/s390/entry/syscalls/syscall.tbl |  2 +-
>   20 files changed, 16 insertions(+), 46 deletions(-)
>
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
> index 3000a2e8ee21..85d2bcd9cf36 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -230,7 +230,7 @@
>   259	common	osf_swapctl			sys_ni_syscall
>   260	common	osf_memcntl			sys_ni_syscall
>   261	common	osf_fdatasync			sys_ni_syscall
> -300	common	bdflush				sys_bdflush
> +300	common	bdflush				sys_ni_syscall
>   301	common	sethae				sys_sethae
>   302	common	mount				sys_mount
>   303	common	old_adjtimex			sys_old_adjtimex
> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index 28e03b5fec00..241988512648 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -147,7 +147,7 @@
>   131	common	quotactl		sys_quotactl
>   132	common	getpgid			sys_getpgid
>   133	common	fchdir			sys_fchdir
> -134	common	bdflush			sys_bdflush
> +134	common	bdflush			sys_ni_syscall
>   135	common	sysfs			sys_sysfs
>   136	common	personality		sys_personality
>   # 137 was sys_afs_syscall
> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index 5dab69d2c22b..a35cd6c4909c 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -279,7 +279,7 @@ __SYSCALL(__NR_getpgid, sys_getpgid)
>   #define __NR_fchdir 133
>   __SYSCALL(__NR_fchdir, sys_fchdir)
>   #define __NR_bdflush 134
> -__SYSCALL(__NR_bdflush, sys_bdflush)
> +__SYSCALL(__NR_bdflush, sys_ni_syscall)
>   #define __NR_sysfs 135
>   __SYSCALL(__NR_sysfs, sys_sysfs)
>   #define __NR_personality 136
> diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
> index bb11fe4c875a..7de53a9a2972 100644
> --- a/arch/ia64/kernel/syscalls/syscall.tbl
> +++ b/arch/ia64/kernel/syscalls/syscall.tbl
> @@ -123,7 +123,7 @@
>   # 1135 was get_kernel_syms
>   # 1136 was query_module
>   113	common	quotactl			sys_quotactl
> -114	common	bdflush				sys_bdflush
> +114	common	bdflush				sys_ni_syscall
>   115	common	sysfs				sys_sysfs
>   116	common	personality			sys_personality
>   117	common	afs_syscall			sys_ni_syscall
> diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
> index 79c2d24c89dd..be5abd9c8c07 100644
> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -141,7 +141,7 @@
>   131	common	quotactl			sys_quotactl
>   132	common	getpgid				sys_getpgid
>   133	common	fchdir				sys_fchdir
> -134	common	bdflush				sys_bdflush
> +134	common	bdflush				sys_ni_syscall
>   135	common	sysfs				sys_sysfs
>   136	common	personality			sys_personality
>   # 137 was afs_syscall
> diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
> index b11395a20c20..555fd987f4ab 100644
> --- a/arch/microblaze/kernel/syscalls/syscall.tbl
> +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
> @@ -141,7 +141,7 @@
>   131	common	quotactl			sys_quotactl
>   132	common	getpgid				sys_getpgid
>   133	common	fchdir				sys_fchdir
> -134	common	bdflush				sys_bdflush
> +134	common	bdflush				sys_ni_syscall
>   135	common	sysfs				sys_sysfs
>   136	common	personality			sys_personality
>   137	common	afs_syscall			sys_ni_syscall
> diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
> index d560c467a8c6..2c6b10db3bd5 100644
> --- a/arch/mips/kernel/syscalls/syscall_o32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
> @@ -145,7 +145,7 @@
>   131	o32	quotactl			sys_quotactl
>   132	o32	getpgid				sys_getpgid
>   133	o32	fchdir				sys_fchdir
> -134	o32	bdflush				sys_bdflush
> +134	o32	bdflush				sys_ni_syscall
>   135	o32	sysfs				sys_sysfs
>   136	o32	personality			sys_personality			sys_32_personality
>   137	o32	afs_syscall			sys_ni_syscall
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> index aabc37f8cae3..51c156cb00f1 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -147,7 +147,7 @@
>   131	common	quotactl		sys_quotactl
>   132	common	getpgid			sys_getpgid
>   133	common	fchdir			sys_fchdir
> -134	common	bdflush			sys_bdflush
> +134	common	bdflush			sys_ni_syscall
>   135	common	sysfs			sys_sysfs
>   136	32	personality		parisc_personality
>   136	64	personality		sys_personality
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index 8f052ff4058c..2518e4e6dccf 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -176,7 +176,7 @@
>   131	nospu	quotactl			sys_quotactl
>   132	common	getpgid				sys_getpgid
>   133	common	fchdir				sys_fchdir
> -134	common	bdflush				sys_bdflush
> +134	common	bdflush				sys_ni_syscall
>   135	common	sysfs				sys_sysfs
>   136	32	personality			sys_personality			ppc64_personality
>   136	64	personality			ppc64_personality
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> index 0690263df1dd..ffcf03714f12 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -122,7 +122,7 @@
>   131  common	quotactl		sys_quotactl			sys_quotactl
>   132  common	getpgid			sys_getpgid			sys_getpgid
>   133  common	fchdir			sys_fchdir			sys_fchdir
> -134  common	bdflush			sys_bdflush			sys_bdflush
> +134  common	bdflush			sys_ni_syscall			sys_ni_syscall
>   135  common	sysfs			sys_sysfs			sys_sysfs
>   136  common	personality		sys_s390_personality		sys_s390_personality
>   137  common	afs_syscall		-				-
> diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
> index 0b91499ebdcf..6e7305066a70 100644
> --- a/arch/sh/kernel/syscalls/syscall.tbl
> +++ b/arch/sh/kernel/syscalls/syscall.tbl
> @@ -141,7 +141,7 @@
>   131	common	quotactl			sys_quotactl
>   132	common	getpgid				sys_getpgid
>   133	common	fchdir				sys_fchdir
> -134	common	bdflush				sys_bdflush
> +134	common	bdflush				sys_ni_syscall
>   135	common	sysfs				sys_sysfs
>   136	common	personality			sys_personality
>   # 137 was afs_syscall
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
> index e34cc30ef22c..bf330dda7c61 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -270,7 +270,7 @@
>   222	common	delete_module		sys_delete_module
>   223	common	get_kernel_syms		sys_ni_syscall
>   224	common	getpgid			sys_getpgid
> -225	common	bdflush			sys_bdflush
> +225	common	bdflush			sys_ni_syscall
>   226	common	sysfs			sys_sysfs
>   227	common	afs_syscall		sys_nis_syscall
>   228	common	setfsuid		sys_setfsuid16
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index 4bbc267fb36b..a21a72763d58 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -145,7 +145,7 @@
>   131	i386	quotactl		sys_quotactl
>   132	i386	getpgid			sys_getpgid
>   133	i386	fchdir			sys_fchdir
> -134	i386	bdflush			sys_bdflush
> +134	i386	bdflush			sys_ni_syscall
>   135	i386	sysfs			sys_sysfs
>   136	i386	personality		sys_personality
>   137	i386	afs_syscall
> diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
> index fd2f30227d96..db4e3d09b249 100644
> --- a/arch/xtensa/kernel/syscalls/syscall.tbl
> +++ b/arch/xtensa/kernel/syscalls/syscall.tbl
> @@ -223,7 +223,7 @@
>   # 205 was old nfsservctl
>   205	common	nfsservctl			sys_ni_syscall
>   206	common	_sysctl				sys_ni_syscall
> -207	common	bdflush				sys_bdflush
> +207	common	bdflush				sys_ni_syscall
>   208	common	uname				sys_newuname
>   209	common	sysinfo				sys_sysinfo
>   210	common	init_module			sys_init_module
> diff --git a/fs/buffer.c b/fs/buffer.c
> index ea48c01fb76b..04ddff76c860 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -3292,33 +3292,6 @@ int try_to_free_buffers(struct page *page)
>   }
>   EXPORT_SYMBOL(try_to_free_buffers);
>   
> -/*
> - * There are no bdflush tunables left.  But distributions are
> - * still running obsolete flush daemons, so we terminate them here.
> - *
> - * Use of bdflush() is deprecated and will be removed in a future kernel.
> - * The `flush-X' kernel threads fully replace bdflush daemons and this call.
> - */
> -SYSCALL_DEFINE2(bdflush, int, func, long, data)
> -{
> -	static int msg_count;
> -
> -	if (!capable(CAP_SYS_ADMIN))
> -		return -EPERM;
> -
> -	if (msg_count < 5) {
> -		msg_count++;
> -		printk(KERN_INFO
> -			"warning: process `%s' used the obsolete bdflush"
> -			" system call\n", current->comm);
> -		printk(KERN_INFO "Fix your initscripts?\n");
> -	}
> -
> -	if (func == 1)
> -		do_exit(0);
> -	return 0;
> -}
> -
>   /*
>    * Buffer-head allocation
>    */
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 050511e8f1f8..1bd6e05ea116 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1157,7 +1157,6 @@ asmlinkage long sys_ustat(unsigned dev, struct ustat __user *ubuf);
>   asmlinkage long sys_vfork(void);
>   asmlinkage long sys_recv(int, void __user *, size_t, unsigned);
>   asmlinkage long sys_send(int, void __user *, size_t, unsigned);
> -asmlinkage long sys_bdflush(int func, long data);
>   asmlinkage long sys_oldumount(char __user *name);
>   asmlinkage long sys_uselib(const char __user *library);
>   asmlinkage long sys_sysfs(int option,
> diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
> index 2ddb4226cd23..463d1ba2232a 100644
> --- a/include/uapi/linux/capability.h
> +++ b/include/uapi/linux/capability.h
> @@ -243,7 +243,6 @@ struct vfs_ns_cap_data {
>   /* Allow examination and configuration of disk quotas */
>   /* Allow setting the domainname */
>   /* Allow setting the hostname */
> -/* Allow calling bdflush() */
>   /* Allow mount() and umount(), setting up new smb connection */
>   /* Allow some autofs root ioctls */
>   /* Allow nfsservctl */
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index 0ea8128468c3..adf4d66ffae2 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -414,7 +414,6 @@ COND_SYSCALL(epoll_wait);
>   COND_SYSCALL(recv);
>   COND_SYSCALL_COMPAT(recv);
>   COND_SYSCALL(send);
> -COND_SYSCALL(bdflush);
>   COND_SYSCALL(uselib);
>   
>   /* optional: time32 */
> diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> index 2e68fbb57cc6..ab72dec9dadb 100644
> --- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> +++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> @@ -176,7 +176,7 @@
>   131	nospu	quotactl			sys_quotactl
>   132	common	getpgid				sys_getpgid
>   133	common	fchdir				sys_fchdir
> -134	common	bdflush				sys_bdflush
> +134	common	bdflush				sys_ni_syscall
>   135	common	sysfs				sys_sysfs
>   136	32	personality			sys_personality			ppc64_personality
>   136	64	personality			ppc64_personality
> diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
> index 7e4a2aba366d..f2eba775e676 100644
> --- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
> +++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
> @@ -122,7 +122,7 @@
>   131  common	quotactl		sys_quotactl			sys_quotactl
>   132  common	getpgid			sys_getpgid			sys_getpgid
>   133  common	fchdir			sys_fchdir			sys_fchdir
> -134  common	bdflush			sys_bdflush			sys_bdflush
> +134  common	bdflush			-				-
>   135  common	sysfs			sys_sysfs			sys_sysfs
>   136  common	personality		sys_s390_personality		sys_s390_personality
>   137  common	afs_syscall		-				-
