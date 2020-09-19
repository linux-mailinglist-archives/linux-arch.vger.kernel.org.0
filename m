Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C3F270AE4
	for <lists+linux-arch@lfdr.de>; Sat, 19 Sep 2020 07:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgISFhU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Sep 2020 01:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgISFhU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Sep 2020 01:37:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBB8C0613CE;
        Fri, 18 Sep 2020 22:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j8gd2J38CQGPOtl7pbxiqN3Ezj7h2hPQL0LgUPAk0yI=; b=wTeYUBxdokCr8AsfmKB0K8Aarq
        EnAKGIY44sxEfhUYWl0wK+MHp8y+YZxrB9mWK4FvXJ/2U7hyaFOzO7H08MV8jaUZnSKJUetycH/A1
        5z9x/oqWqV0j/jzIpfzeIUKOFkRZi/2cjcqbOVitzVCGYPRE7Pl8XT4xehNVYIPmEA6KDRp+clA/B
        /IYbSvSSLkc7+5ayQ4NrUI8Eal54Wb9qyrGkRY8rPv8mvST575+EyOITN4oWJtWwe1MaLAeT07WXW
        bhnxX8hxUXKuDGHR+/AXuCCwuO8dzZvLWkQRRm7qRxSsfMV1rAx+zDEIx0ETPz+1iPOTCBEYI2no/
        oNouNldQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJVYi-0000rm-Fj; Sat, 19 Sep 2020 05:37:16 +0000
Date:   Sat, 19 Sep 2020 06:37:16 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH 2/4] kexec: remove compat_sys_kexec_load syscall
Message-ID: <20200919053716.GJ30063@infradead.org>
References: <20200918132439.1475479-1-arnd@arndb.de>
 <20200918132439.1475479-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918132439.1475479-3-arnd@arndb.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 18, 2020 at 03:24:37PM +0200, Arnd Bergmann wrote:
> The compat version of sys_kexec_load() uses compat_alloc_user_space to
> convert the user-provided arguments into the native format.
> 
> Move the conversion into the regular implementation with
> an in_compat_syscall() check to simplify it and avoid the
> compat_alloc_user_space() call.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/include/asm/unistd32.h         |  2 +-
>  arch/mips/kernel/syscalls/syscall_n32.tbl |  2 +-
>  arch/mips/kernel/syscalls/syscall_o32.tbl |  2 +-
>  arch/parisc/kernel/syscalls/syscall.tbl   |  2 +-
>  arch/powerpc/kernel/syscalls/syscall.tbl  |  2 +-
>  arch/s390/kernel/syscalls/syscall.tbl     |  2 +-
>  arch/sparc/kernel/syscalls/syscall.tbl    |  2 +-
>  arch/x86/entry/syscalls/syscall_32.tbl    |  2 +-
>  arch/x86/entry/syscalls/syscall_64.tbl    |  2 +-
>  include/linux/compat.h                    |  6 --
>  include/uapi/asm-generic/unistd.h         |  2 +-
>  kernel/kexec.c                            | 75 ++++++-----------------
>  12 files changed, 29 insertions(+), 72 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index 734860ac7cf9..b6517df74037 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -705,7 +705,7 @@ __SYSCALL(__NR_getcpu, sys_getcpu)
>  #define __NR_epoll_pwait 346
>  __SYSCALL(__NR_epoll_pwait, compat_sys_epoll_pwait)
>  #define __NR_kexec_load 347
> -__SYSCALL(__NR_kexec_load, compat_sys_kexec_load)
> +__SYSCALL(__NR_kexec_load, sys_kexec_load)
>  #define __NR_utimensat 348
>  __SYSCALL(__NR_utimensat, sys_utimensat_time32)
>  #define __NR_signalfd 349
> diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
> index f9df9edb67a4..ad157aab4c09 100644
> --- a/arch/mips/kernel/syscalls/syscall_n32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
> @@ -282,7 +282,7 @@
>  271	n32	move_pages			compat_sys_move_pages
>  272	n32	set_robust_list			compat_sys_set_robust_list
>  273	n32	get_robust_list			compat_sys_get_robust_list
> -274	n32	kexec_load			compat_sys_kexec_load
> +274	n32	kexec_load			sys_kexec_load
>  275	n32	getcpu				sys_getcpu
>  276	n32	epoll_pwait			compat_sys_epoll_pwait
>  277	n32	ioprio_set			sys_ioprio_set
> diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
> index 195b43cf27c8..57baf6c8008f 100644
> --- a/arch/mips/kernel/syscalls/syscall_o32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
> @@ -322,7 +322,7 @@
>  308	o32	move_pages			sys_move_pages			compat_sys_move_pages
>  309	o32	set_robust_list			sys_set_robust_list		compat_sys_set_robust_list
>  310	o32	get_robust_list			sys_get_robust_list		compat_sys_get_robust_list
> -311	o32	kexec_load			sys_kexec_load			compat_sys_kexec_load
> +311	o32	kexec_load			sys_kexec_load
>  312	o32	getcpu				sys_getcpu
>  313	o32	epoll_pwait			sys_epoll_pwait			compat_sys_epoll_pwait
>  314	o32	ioprio_set			sys_ioprio_set
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> index def64d221cd4..778bf166d7bd 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -336,7 +336,7 @@
>  297	common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
>  298	common	statfs64		sys_statfs64			compat_sys_statfs64
>  299	common	fstatfs64		sys_fstatfs64			compat_sys_fstatfs64
> -300	common	kexec_load		sys_kexec_load			compat_sys_kexec_load
> +300	common	kexec_load		sys_kexec_load
>  301	32	utimensat		sys_utimensat_time32
>  301	64	utimensat		sys_utimensat
>  302	common	signalfd		sys_signalfd			compat_sys_signalfd
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index c2d737ff2e7b..f128ba8b9a71 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -350,7 +350,7 @@
>  265	64	mq_timedreceive			sys_mq_timedreceive
>  266	nospu	mq_notify			sys_mq_notify			compat_sys_mq_notify
>  267	nospu	mq_getsetattr			sys_mq_getsetattr		compat_sys_mq_getsetattr
> -268	nospu	kexec_load			sys_kexec_load			compat_sys_kexec_load
> +268	nospu	kexec_load			sys_kexec_load
>  269	nospu	add_key				sys_add_key
>  270	nospu	request_key			sys_request_key
>  271	nospu	keyctl				sys_keyctl			compat_sys_keyctl
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> index 10456bc936fb..d45952058be2 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -283,7 +283,7 @@
>  274  common	mq_timedreceive		sys_mq_timedreceive		sys_mq_timedreceive_time32
>  275  common	mq_notify		sys_mq_notify			compat_sys_mq_notify
>  276  common	mq_getsetattr		sys_mq_getsetattr		compat_sys_mq_getsetattr
> -277  common	kexec_load		sys_kexec_load			compat_sys_kexec_load
> +277  common	kexec_load		sys_kexec_load			sys_kexec_load
>  278  common	add_key			sys_add_key			sys_add_key
>  279  common	request_key		sys_request_key			sys_request_key
>  280  common	keyctl			sys_keyctl			compat_sys_keyctl
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
> index 4af114e84f20..a46edcdd950d 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -369,7 +369,7 @@
>  303	common	mbind			sys_mbind			compat_sys_mbind
>  304	common	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
>  305	common	set_mempolicy		sys_set_mempolicy		compat_sys_set_mempolicy
> -306	common	kexec_load		sys_kexec_load			compat_sys_kexec_load
> +306	common	kexec_load		sys_kexec_load			sys_kexec_load
>  307	common	move_pages		sys_move_pages			compat_sys_move_pages
>  308	common	getcpu			sys_getcpu
>  309	common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index 3db3d8823dc8..7e4140b78aad 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -294,7 +294,7 @@
>  280	i386	mq_timedreceive		sys_mq_timedreceive_time32
>  281	i386	mq_notify		sys_mq_notify			compat_sys_mq_notify
>  282	i386	mq_getsetattr		sys_mq_getsetattr		compat_sys_mq_getsetattr
> -283	i386	kexec_load		sys_kexec_load			compat_sys_kexec_load
> +283	i386	kexec_load		sys_kexec_load			sys_kexec_load
>  284	i386	waitid			sys_waitid			compat_sys_waitid
>  # 285 sys_setaltroot
>  286	i386	add_key			sys_add_key
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index f30d6ae9a688..9986f5f08278 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -384,7 +384,7 @@
>  525	x32	sigaltstack		compat_sys_sigaltstack
>  526	x32	timer_create		compat_sys_timer_create
>  527	x32	mq_notify		compat_sys_mq_notify
> -528	x32	kexec_load		compat_sys_kexec_load
> +528	x32	kexec_load		sys_kexec_load
>  529	x32	waitid			compat_sys_waitid
>  530	x32	set_robust_list		compat_sys_set_robust_list
>  531	x32	get_robust_list		compat_sys_get_robust_list
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index 3d96a841bd49..a7a5a0ff59ef 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -643,12 +643,6 @@ asmlinkage long compat_sys_setitimer(int which,
>  				     struct old_itimerval32 __user *in,
>  				     struct old_itimerval32 __user *out);
>  
> -/* kernel/kexec.c */
> -asmlinkage long compat_sys_kexec_load(compat_ulong_t entry,
> -				      compat_ulong_t nr_segments,
> -				      struct compat_kexec_segment __user *,
> -				      compat_ulong_t flags);
> -
>  /* kernel/posix-timers.c */
>  asmlinkage long compat_sys_timer_create(clockid_t which_clock,
>  			struct compat_sigevent __user *timer_event_spec,
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 995b36c2ea7d..83f1fc7fd3d7 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -342,7 +342,7 @@ __SC_COMP(__NR_setitimer, sys_setitimer, compat_sys_setitimer)
>  
>  /* kernel/kexec.c */
>  #define __NR_kexec_load 104
> -__SC_COMP(__NR_kexec_load, sys_kexec_load, compat_sys_kexec_load)
> +__SYSCALL(__NR_kexec_load, sys_kexec_load)
>  
>  /* kernel/module.c */
>  #define __NR_init_module 105
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index f977786fe498..1ef7d3dc906f 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -29,7 +29,25 @@ static int copy_user_segment_list(struct kimage *image,
>  	/* Read in the segments */
>  	image->nr_segments = nr_segments;
>  	segment_bytes = nr_segments * sizeof(*segments);
> -	ret = copy_from_user(image->segment, segments, segment_bytes);
> +	if (in_compat_syscall()) {
> +		struct compat_kexec_segment __user *cs = (void __user *)segments;
> +		struct compat_kexec_segment segment;
> +		int i;
> +		for (i=0; i< nr_segments; i++) {

Missing empty line after the variable declarations and really strange
indentation.

> +			copy_from_user(&segment, &cs[i], sizeof(segment));

Missing return value check.

> +			if (ret)
> +				break;
> +
> +			image->segment[i] = (struct kexec_segment) {
> +				.buf   = compat_ptr(segment.buf),
> +				.bufsz = segment.bufsz,
> +				.mem   = segment.mem,
> +				.memsz = segment.memsz,
> +			};
> +		}

I'd split the whole compat handling into a helper, and I'd probably
use the unsafe_get/put user to optimize it a little more.

> +	} else {
> +		ret = copy_from_user(image->segment, segments, segment_bytes);
> +	}
>  	if (ret)
>  		ret = -EFAULT;

Why not just

		if (copy_from_user(image->segment, segments, segment_bytes))
			ret = -EFAULT;

?
