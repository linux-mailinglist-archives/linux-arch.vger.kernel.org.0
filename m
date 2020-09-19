Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE69D270AF5
	for <lists+linux-arch@lfdr.de>; Sat, 19 Sep 2020 07:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgISFlz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Sep 2020 01:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgISFlz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Sep 2020 01:41:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDA9C0613CE;
        Fri, 18 Sep 2020 22:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MnmgHy8cJBUx/KSlCgo032ZlGzjOIL/Jxxf9dPtxg34=; b=pdjRtqjINaoK/vTT5PFlyssNyt
        W4aRhv4wE5TNMgLB+sNEDjp9jGNnDYVG57Nr7l7s8373UEGs/4iiGygFSKwcsVpO+r+/LI8qX/MnD
        4erfctuWzjfN6StJ2c0BYo1tVEL0P1VZ/X/iDs0rp1KNMKB7TtAGfD7cLvo1Hxpk2w8zKFudP0lwF
        Fku/fxBsXa5XCsZ0eBARurkonMTcmLfifoTBw9DiHzrurWx05o3n+NyRxWFdvfe/r70pPo5aTTlcb
        5dwwwStkrX+dEtg+XpfNOshqqvKBCxJeZLCUc6GZeWNOm0O6vlE0tzy82G2SrgAU7JJdjjXmMyE7f
        ieXnlLGw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJVd6-0001Dy-MY; Sat, 19 Sep 2020 05:41:48 +0000
Date:   Sat, 19 Sep 2020 06:41:48 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH 4/4] mm: remove compat numa syscalls
Message-ID: <20200919054148.GL30063@infradead.org>
References: <20200918132439.1475479-1-arnd@arndb.de>
 <20200918132439.1475479-5-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918132439.1475479-5-arnd@arndb.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 18, 2020 at 03:24:39PM +0200, Arnd Bergmann wrote:
> The compat implementations for mbind, get_mempolicy, set_mempolicy
> and migrate_pages are just there to handle the subtly different
> layout of bitmaps on 32-bit hosts.
> 
> The compat implementation however lacks some of the checks that
> are present in the native one, in particular for checking that
> the extra bits are all zero when user space has a larger mask
> size than the kernel. Worse, those extra bits do not get cleared
> when copying in or out of the kernel, which can lead to incorrect
> data as well.
> 
> Unify the implementation to handle the compat bitmap layout directly
> in the get_nodes() and copy_nodes_to_user() helpers.  Splitting out
> the get_bitmap() helper from get_nodes() also helps readability of the
> native case.
> 
> On x86, two additional problems are addressed by this: compat tasks can
> pass a bitmap at the end of a mapping, causing a fault when reading
> across the page boundary for a 64-bit word. x32 tasks might also run
> into problems with get_mempolicy corrupting data when an odd number of
> 32-bit words gets passed.
> 
> On parisc the migrate_pages() system call apparently had the wrong
> calling convention, as big-endian architectures expect the words
> inside of a bitmap to be swapped. This is not a problem though
> since parisc has no NUMA support.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/include/asm/unistd32.h         |   8 +-
>  arch/mips/kernel/syscalls/syscall_n32.tbl |   8 +-
>  arch/mips/kernel/syscalls/syscall_o32.tbl |   8 +-
>  arch/parisc/kernel/syscalls/syscall.tbl   |   6 +-
>  arch/powerpc/kernel/syscalls/syscall.tbl  |   8 +-
>  arch/s390/kernel/syscalls/syscall.tbl     |   8 +-
>  arch/sparc/kernel/syscalls/syscall.tbl    |   8 +-
>  arch/x86/entry/syscalls/syscall_32.tbl    |   2 +-
>  include/linux/compat.h                    |  15 --
>  include/uapi/asm-generic/unistd.h         |   8 +-
>  kernel/kexec.c                            |   6 +-
>  kernel/sys_ni.c                           |   4 -
>  mm/mempolicy.c                            | 193 +++++-----------------
>  13 files changed, 79 insertions(+), 203 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index af793775ba98..31479f7120a0 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -649,11 +649,11 @@ __SYSCALL(__NR_inotify_add_watch, sys_inotify_add_watch)
>  #define __NR_inotify_rm_watch 318
>  __SYSCALL(__NR_inotify_rm_watch, sys_inotify_rm_watch)
>  #define __NR_mbind 319
> -__SYSCALL(__NR_mbind, compat_sys_mbind)
> +__SYSCALL(__NR_mbind, sys_mbind)
>  #define __NR_get_mempolicy 320
> -__SYSCALL(__NR_get_mempolicy, compat_sys_get_mempolicy)
> +__SYSCALL(__NR_get_mempolicy, sys_get_mempolicy)
>  #define __NR_set_mempolicy 321
> -__SYSCALL(__NR_set_mempolicy, compat_sys_set_mempolicy)
> +__SYSCALL(__NR_set_mempolicy, sys_set_mempolicy)
>  #define __NR_openat 322
>  __SYSCALL(__NR_openat, compat_sys_openat)
>  #define __NR_mkdirat 323
> @@ -811,7 +811,7 @@ __SYSCALL(__NR_rseq, sys_rseq)
>  #define __NR_io_pgetevents 399
>  __SYSCALL(__NR_io_pgetevents, compat_sys_io_pgetevents)
>  #define __NR_migrate_pages 400
> -__SYSCALL(__NR_migrate_pages, compat_sys_migrate_pages)
> +__SYSCALL(__NR_migrate_pages, sys_migrate_pages)
>  #define __NR_kexec_file_load 401
>  __SYSCALL(__NR_kexec_file_load, sys_kexec_file_load)
>  /* 402 is unused */
> diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
> index 7fa1ca45e44c..15fda882d07e 100644
> --- a/arch/mips/kernel/syscalls/syscall_n32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
> @@ -239,9 +239,9 @@
>  228	n32	clock_nanosleep			sys_clock_nanosleep_time32
>  229	n32	tgkill				sys_tgkill
>  230	n32	utimes				sys_utimes_time32
> -231	n32	mbind				compat_sys_mbind
> -232	n32	get_mempolicy			compat_sys_get_mempolicy
> -233	n32	set_mempolicy			compat_sys_set_mempolicy
> +231	n32	mbind				sys_mbind
> +232	n32	get_mempolicy			sys_get_mempolicy
> +233	n32	set_mempolicy			sys_set_mempolicy
>  234	n32	mq_open				compat_sys_mq_open
>  235	n32	mq_unlink			sys_mq_unlink
>  236	n32	mq_timedsend			sys_mq_timedsend_time32
> @@ -258,7 +258,7 @@
>  247	n32	inotify_init			sys_inotify_init
>  248	n32	inotify_add_watch		sys_inotify_add_watch
>  249	n32	inotify_rm_watch		sys_inotify_rm_watch
> -250	n32	migrate_pages			compat_sys_migrate_pages
> +250	n32	migrate_pages			sys_migrate_pages
>  251	n32	openat				sys_openat
>  252	n32	mkdirat				sys_mkdirat
>  253	n32	mknodat				sys_mknodat
> diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
> index 194c7fbeedf7..6591388a9d88 100644
> --- a/arch/mips/kernel/syscalls/syscall_o32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
> @@ -279,9 +279,9 @@
>  265	o32	clock_nanosleep			sys_clock_nanosleep_time32
>  266	o32	tgkill				sys_tgkill
>  267	o32	utimes				sys_utimes_time32
> -268	o32	mbind				sys_mbind			compat_sys_mbind
> -269	o32	get_mempolicy			sys_get_mempolicy		compat_sys_get_mempolicy
> -270	o32	set_mempolicy			sys_set_mempolicy		compat_sys_set_mempolicy
> +268	o32	mbind				sys_mbind
> +269	o32	get_mempolicy			sys_get_mempolicy
> +270	o32	set_mempolicy			sys_set_mempolicy
>  271	o32	mq_open				sys_mq_open			compat_sys_mq_open
>  272	o32	mq_unlink			sys_mq_unlink
>  273	o32	mq_timedsend			sys_mq_timedsend_time32
> @@ -298,7 +298,7 @@
>  284	o32	inotify_init			sys_inotify_init
>  285	o32	inotify_add_watch		sys_inotify_add_watch
>  286	o32	inotify_rm_watch		sys_inotify_rm_watch
> -287	o32	migrate_pages			sys_migrate_pages		compat_sys_migrate_pages
> +287	o32	migrate_pages			sys_migrate_pages
>  288	o32	openat				sys_openat			compat_sys_openat
>  289	o32	mkdirat				sys_mkdirat
>  290	o32	mknodat				sys_mknodat
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> index 5c17edaffe70..30f3c0146abf 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -292,9 +292,9 @@
>  258	32	clock_nanosleep		sys_clock_nanosleep_time32
>  258	64	clock_nanosleep		sys_clock_nanosleep
>  259	common	tgkill			sys_tgkill
> -260	common	mbind			sys_mbind			compat_sys_mbind
> -261	common	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
> -262	common	set_mempolicy		sys_set_mempolicy		compat_sys_set_mempolicy
> +260	common	mbind			sys_mbind
> +261	common	get_mempolicy		sys_get_mempolicy
> +262	common	set_mempolicy		sys_set_mempolicy
>  # 263 was vserver
>  264	common	add_key			sys_add_key
>  265	common	request_key		sys_request_key
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index 04fb42d7b377..4f5216320721 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -338,10 +338,10 @@
>  256	64	sys_debug_setcontext		sys_ni_syscall
>  256	spu	sys_debug_setcontext		sys_ni_syscall
>  # 257 reserved for vserver
> -258	nospu	migrate_pages			sys_migrate_pages		compat_sys_migrate_pages
> -259	nospu	mbind				sys_mbind			compat_sys_mbind
> -260	nospu	get_mempolicy			sys_get_mempolicy		compat_sys_get_mempolicy
> -261	nospu	set_mempolicy			sys_set_mempolicy		compat_sys_set_mempolicy
> +258	nospu	migrate_pages			sys_migrate_pages
> +259	nospu	mbind				sys_mbind
> +260	nospu	get_mempolicy			sys_get_mempolicy
> +261	nospu	set_mempolicy			sys_set_mempolicy
>  262	nospu	mq_open				sys_mq_open			compat_sys_mq_open
>  263	nospu	mq_unlink			sys_mq_unlink
>  264	32	mq_timedsend			sys_mq_timedsend_time32
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> index 3197965d45e9..70c0b830d14f 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -274,9 +274,9 @@
>  265  common	statfs64		sys_statfs64			compat_sys_statfs64
>  266  common	fstatfs64		sys_fstatfs64			compat_sys_fstatfs64
>  267  common	remap_file_pages	sys_remap_file_pages		sys_remap_file_pages
> -268  common	mbind			sys_mbind			compat_sys_mbind
> -269  common	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
> -270  common	set_mempolicy		sys_set_mempolicy		compat_sys_set_mempolicy
> +268  common	mbind			sys_mbind			sys_mbind
> +269  common	get_mempolicy		sys_get_mempolicy		sys_get_mempolicy
> +270  common	set_mempolicy		sys_set_mempolicy		sys_set_mempolicy
>  271  common	mq_open			sys_mq_open			compat_sys_mq_open
>  272  common	mq_unlink		sys_mq_unlink			sys_mq_unlink
>  273  common	mq_timedsend		sys_mq_timedsend		sys_mq_timedsend_time32
> @@ -293,7 +293,7 @@
>  284  common	inotify_init		sys_inotify_init		sys_inotify_init
>  285  common	inotify_add_watch	sys_inotify_add_watch		sys_inotify_add_watch
>  286  common	inotify_rm_watch	sys_inotify_rm_watch		sys_inotify_rm_watch
> -287  common	migrate_pages		sys_migrate_pages		compat_sys_migrate_pages
> +287  common	migrate_pages		sys_migrate_pages		sys_migrate_pages
>  288  common	openat			sys_openat			compat_sys_openat
>  289  common	mkdirat			sys_mkdirat			sys_mkdirat
>  290  common	mknodat			sys_mknodat			sys_mknodat
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
> index e36ac364e61a..50ff839a2661 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -365,10 +365,10 @@
>  299	common	unshare			sys_unshare
>  300	common	set_robust_list		sys_set_robust_list		compat_sys_set_robust_list
>  301	common	get_robust_list		sys_get_robust_list		compat_sys_get_robust_list
> -302	common	migrate_pages		sys_migrate_pages		compat_sys_migrate_pages
> -303	common	mbind			sys_mbind			compat_sys_mbind
> -304	common	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
> -305	common	set_mempolicy		sys_set_mempolicy		compat_sys_set_mempolicy
> +302	common	migrate_pages		sys_migrate_pages
> +303	common	mbind			sys_mbind
> +304	common	get_mempolicy		sys_get_mempolicy
> +305	common	set_mempolicy		sys_set_mempolicy
>  306	common	kexec_load		sys_kexec_load			sys_kexec_load
>  307	common	move_pages		sys_move_pages
>  308	common	getcpu			sys_getcpu
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index b3263b8b2eae..d07c3fbd4697 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -286,7 +286,7 @@
>  272	i386	fadvise64_64		sys_ia32_fadvise64_64
>  273	i386	vserver
>  274	i386	mbind			sys_mbind
> -275	i386	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
> +275	i386	get_mempolicy		sys_get_mempolicy
>  276	i386	set_mempolicy		sys_set_mempolicy
>  277	i386	mq_open			sys_mq_open			compat_sys_mq_open
>  278	i386	mq_unlink		sys_mq_unlink
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index db1d7ac2c9e0..be06367b336c 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -749,21 +749,6 @@ asmlinkage long compat_sys_execve(const char __user *filename, const compat_uptr
>  /* mm/fadvise.c: No generic prototype for fadvise64_64 */
>  
>  /* mm/, CONFIG_MMU only */
> -asmlinkage long compat_sys_mbind(compat_ulong_t start, compat_ulong_t len,
> -				 compat_ulong_t mode,
> -				 compat_ulong_t __user *nmask,
> -				 compat_ulong_t maxnode, compat_ulong_t flags);
> -asmlinkage long compat_sys_get_mempolicy(int __user *policy,
> -					 compat_ulong_t __user *nmask,
> -					 compat_ulong_t maxnode,
> -					 compat_ulong_t addr,
> -					 compat_ulong_t flags);
> -asmlinkage long compat_sys_set_mempolicy(int mode, compat_ulong_t __user *nmask,
> -					 compat_ulong_t maxnode);
> -asmlinkage long compat_sys_migrate_pages(compat_pid_t pid,
> -		compat_ulong_t maxnode, const compat_ulong_t __user *old_nodes,
> -		const compat_ulong_t __user *new_nodes);
> -
>  asmlinkage long compat_sys_rt_tgsigqueueinfo(compat_pid_t tgid,
>  					compat_pid_t pid, int sig,
>  					struct compat_siginfo __user *uinfo);
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 4da51702fb21..4e31f9b68a8f 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -673,13 +673,13 @@ __SYSCALL(__NR_madvise, sys_madvise)
>  #define __NR_remap_file_pages 234
>  __SYSCALL(__NR_remap_file_pages, sys_remap_file_pages)
>  #define __NR_mbind 235
> -__SC_COMP(__NR_mbind, sys_mbind, compat_sys_mbind)
> +__SYSCALL(__NR_mbind, sys_mbind)
>  #define __NR_get_mempolicy 236
> -__SC_COMP(__NR_get_mempolicy, sys_get_mempolicy, compat_sys_get_mempolicy)
> +__SYSCALL(__NR_get_mempolicy, sys_get_mempolicy)
>  #define __NR_set_mempolicy 237
> -__SC_COMP(__NR_set_mempolicy, sys_set_mempolicy, compat_sys_set_mempolicy)
> +__SYSCALL(__NR_set_mempolicy, sys_set_mempolicy)
>  #define __NR_migrate_pages 238
> -__SC_COMP(__NR_migrate_pages, sys_migrate_pages, compat_sys_migrate_pages)
> +__SYSCALL(__NR_migrate_pages, sys_migrate_pages)
>  #define __NR_move_pages 239
>  __SYSCALL(__NR_move_pages, sys_move_pages)
>  #endif
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 1ef7d3dc906f..0fecf2370be1 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -30,11 +30,13 @@ static int copy_user_segment_list(struct kimage *image,
>  	image->nr_segments = nr_segments;
>  	segment_bytes = nr_segments * sizeof(*segments);
>  	if (in_compat_syscall()) {
> -		struct compat_kexec_segment __user *cs = (void __user *)segments;
> +		struct compat_kexec_segment __user *cs;
>  		struct compat_kexec_segment segment;
>  		int i;
> +
> +		cs = (struct compat_kexec_segment __user *)segments;
>  		for (i=0; i< nr_segments; i++) {
> -			copy_from_user(&segment, &cs[i], sizeof(segment));
> +			ret = copy_from_user(&segment, &cs[i], sizeof(segment));
>  			if (ret)
>  				break;
>  
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index 783a24ceee88..0850111f888e 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -282,13 +282,9 @@ COND_SYSCALL(mincore);
>  COND_SYSCALL(madvise);
>  COND_SYSCALL(remap_file_pages);
>  COND_SYSCALL(mbind);
> -COND_SYSCALL_COMPAT(mbind);
>  COND_SYSCALL(get_mempolicy);
> -COND_SYSCALL_COMPAT(get_mempolicy);
>  COND_SYSCALL(set_mempolicy);
> -COND_SYSCALL_COMPAT(set_mempolicy);
>  COND_SYSCALL(migrate_pages);
> -COND_SYSCALL_COMPAT(migrate_pages);
>  COND_SYSCALL(move_pages);
>  
>  COND_SYSCALL(perf_event_open);
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index eddbe4e56c73..2e1b90143b2c 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1374,16 +1374,30 @@ static long do_mbind(unsigned long start, unsigned long len,
>  /*
>   * User space interface with variable sized bitmaps for nodelists.
>   */
> +static int get_bitmap(unsigned long *mask, const unsigned long __user *nmask,
> +		      unsigned long maxnode)
> +{
> +	unsigned long nlongs = BITS_TO_LONGS(maxnode);
> +	int ret;
> +
> +	if (in_compat_syscall())
> +		ret = compat_get_bitmap(mask, (void __user *)nmask, maxnode);

I'd either pass void __user all the way, or do an explicit case from
the native to the compat version in the compat handler.

> +	else
> +		ret = copy_from_user(mask, nmask, nlongs*sizeof(unsigned long));

That whole BITS_TO_LONGS(b) * sizeof(unsigned long) pattern is
duplicated in various places including the checking of compat vs native
and probably want a helper that includes the in_compat_syscall() check.
