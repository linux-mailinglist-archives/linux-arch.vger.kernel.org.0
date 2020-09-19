Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D307E270AEC
	for <lists+linux-arch@lfdr.de>; Sat, 19 Sep 2020 07:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgISFiL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Sep 2020 01:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgISFiL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Sep 2020 01:38:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013E9C0613CE;
        Fri, 18 Sep 2020 22:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OBd/vZ/ylskS6jjKEeI18fPw7Z0hNNNvvqMbZg9C4O4=; b=Lb1kNbEonFJJClhH0ChtOT3Eoh
        Xxy94iW5mFgVtDTFUzoKP+CkeAj1BR92BHKYWjvDx62uHpMoJ2F64D2id8kit703Jl7OCSQpp6KQH
        gpQGnfvsEXAuCiibdyIuLlQH05qeUGjsX6Oer96TH4rF116goHbRcLDFOzjyJT0mt+1ieFdJJKhnR
        D4ZBfMKMmzZ0bsDxS9x9yArVXNxuJpIrX2L6nRXyXWYPJRruxdhq/fefoFld0oGVv9EQBYXJqi2CX
        sOmTMXhI0+Hy8hOk/57eiv3e0rZ5Q2unWJoojNCqhFjVKnhfLJp5eI2WpYxwij+qQMkxu1nWIku6p
        SVCjdJPQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJVZX-0000ud-FJ; Sat, 19 Sep 2020 05:38:07 +0000
Date:   Sat, 19 Sep 2020 06:38:07 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH 3/4] mm: remove compat_sys_move_pages
Message-ID: <20200919053807.GK30063@infradead.org>
References: <20200918132439.1475479-1-arnd@arndb.de>
 <20200918132439.1475479-4-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918132439.1475479-4-arnd@arndb.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 18, 2020 at 03:24:38PM +0200, Arnd Bergmann wrote:
> The compat move_pages() implementation uses compat_alloc_user_space()
> for converting the pointer array. Moving the compat handling into
> the function itself is a bit simpler and lets us avoid the
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
>  include/linux/compat.h                    |  5 ---
>  include/uapi/asm-generic/unistd.h         |  2 +-
>  kernel/sys_ni.c                           |  1 -
>  mm/migrate.c                              | 45 +++++++++++------------
>  13 files changed, 32 insertions(+), 39 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index b6517df74037..af793775ba98 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -699,7 +699,7 @@ __SYSCALL(__NR_tee, sys_tee)
>  #define __NR_vmsplice 343
>  __SYSCALL(__NR_vmsplice, compat_sys_vmsplice)
>  #define __NR_move_pages 344
> -__SYSCALL(__NR_move_pages, compat_sys_move_pages)
> +__SYSCALL(__NR_move_pages, sys_move_pages)
>  #define __NR_getcpu 345
>  __SYSCALL(__NR_getcpu, sys_getcpu)
>  #define __NR_epoll_pwait 346
> diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
> index ad157aab4c09..7fa1ca45e44c 100644
> --- a/arch/mips/kernel/syscalls/syscall_n32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
> @@ -279,7 +279,7 @@
>  268	n32	sync_file_range			sys_sync_file_range
>  269	n32	tee				sys_tee
>  270	n32	vmsplice			compat_sys_vmsplice
> -271	n32	move_pages			compat_sys_move_pages
> +271	n32	move_pages			sys_move_pages
>  272	n32	set_robust_list			compat_sys_set_robust_list
>  273	n32	get_robust_list			compat_sys_get_robust_list
>  274	n32	kexec_load			sys_kexec_load
> diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
> index 57baf6c8008f..194c7fbeedf7 100644
> --- a/arch/mips/kernel/syscalls/syscall_o32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
> @@ -319,7 +319,7 @@
>  305	o32	sync_file_range			sys_sync_file_range		sys32_sync_file_range
>  306	o32	tee				sys_tee
>  307	o32	vmsplice			sys_vmsplice			compat_sys_vmsplice
> -308	o32	move_pages			sys_move_pages			compat_sys_move_pages
> +308	o32	move_pages			sys_move_pages
>  309	o32	set_robust_list			sys_set_robust_list		compat_sys_set_robust_list
>  310	o32	get_robust_list			sys_get_robust_list		compat_sys_get_robust_list
>  311	o32	kexec_load			sys_kexec_load
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> index 778bf166d7bd..5c17edaffe70 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -331,7 +331,7 @@
>  292	64	sync_file_range		sys_sync_file_range
>  293	common	tee			sys_tee
>  294	common	vmsplice		sys_vmsplice			compat_sys_vmsplice
> -295	common	move_pages		sys_move_pages			compat_sys_move_pages
> +295	common	move_pages		sys_move_pages
>  296	common	getcpu			sys_getcpu
>  297	common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
>  298	common	statfs64		sys_statfs64			compat_sys_statfs64
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index f128ba8b9a71..04fb42d7b377 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -389,7 +389,7 @@
>  298	common	faccessat			sys_faccessat
>  299	common	get_robust_list			sys_get_robust_list		compat_sys_get_robust_list
>  300	common	set_robust_list			sys_set_robust_list		compat_sys_set_robust_list
> -301	common	move_pages			sys_move_pages			compat_sys_move_pages
> +301	common	move_pages			sys_move_pages
>  302	common	getcpu				sys_getcpu
>  303	nospu	epoll_pwait			sys_epoll_pwait			compat_sys_epoll_pwait
>  304	32	utimensat			sys_utimensat_time32
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> index d45952058be2..3197965d45e9 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -317,7 +317,7 @@
>  307  common	sync_file_range		sys_sync_file_range		compat_sys_s390_sync_file_range
>  308  common	tee			sys_tee				sys_tee
>  309  common	vmsplice		sys_vmsplice			compat_sys_vmsplice
> -310  common	move_pages		sys_move_pages			compat_sys_move_pages
> +310  common	move_pages		sys_move_pages
>  311  common	getcpu			sys_getcpu			sys_getcpu
>  312  common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
>  313  common	utimes			sys_utimes			sys_utimes_time32
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
> index a46edcdd950d..e36ac364e61a 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -370,7 +370,7 @@
>  304	common	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
>  305	common	set_mempolicy		sys_set_mempolicy		compat_sys_set_mempolicy
>  306	common	kexec_load		sys_kexec_load			sys_kexec_load
> -307	common	move_pages		sys_move_pages			compat_sys_move_pages
> +307	common	move_pages		sys_move_pages
>  308	common	getcpu			sys_getcpu
>  309	common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
>  310	32	utimensat		sys_utimensat_time32
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index 7e4140b78aad..b3263b8b2eae 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -328,7 +328,7 @@
>  314	i386	sync_file_range		sys_ia32_sync_file_range
>  315	i386	tee			sys_tee
>  316	i386	vmsplice		sys_vmsplice			compat_sys_vmsplice
> -317	i386	move_pages		sys_move_pages			compat_sys_move_pages
> +317	i386	move_pages		sys_move_pages
>  318	i386	getcpu			sys_getcpu
>  319	i386	epoll_pwait		sys_epoll_pwait
>  320	i386	utimensat		sys_utimensat_time32
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index 9986f5f08278..4a997a0cbf47 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -389,7 +389,7 @@
>  530	x32	set_robust_list		compat_sys_set_robust_list
>  531	x32	get_robust_list		compat_sys_get_robust_list
>  532	x32	vmsplice		compat_sys_vmsplice
> -533	x32	move_pages		compat_sys_move_pages
> +533	x32	move_pages		sys_move_pages
>  534	x32	preadv			compat_sys_preadv64
>  535	x32	pwritev			compat_sys_pwritev64
>  536	x32	rt_tgsigqueueinfo	compat_sys_rt_tgsigqueueinfo
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index a7a5a0ff59ef..db1d7ac2c9e0 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -763,11 +763,6 @@ asmlinkage long compat_sys_set_mempolicy(int mode, compat_ulong_t __user *nmask,
>  asmlinkage long compat_sys_migrate_pages(compat_pid_t pid,
>  		compat_ulong_t maxnode, const compat_ulong_t __user *old_nodes,
>  		const compat_ulong_t __user *new_nodes);
> -asmlinkage long compat_sys_move_pages(pid_t pid, compat_ulong_t nr_pages,
> -				      __u32 __user *pages,
> -				      const int __user *nodes,
> -				      int __user *status,
> -				      int flags);
>  
>  asmlinkage long compat_sys_rt_tgsigqueueinfo(compat_pid_t tgid,
>  					compat_pid_t pid, int sig,
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 83f1fc7fd3d7..4da51702fb21 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -681,7 +681,7 @@ __SC_COMP(__NR_set_mempolicy, sys_set_mempolicy, compat_sys_set_mempolicy)
>  #define __NR_migrate_pages 238
>  __SC_COMP(__NR_migrate_pages, sys_migrate_pages, compat_sys_migrate_pages)
>  #define __NR_move_pages 239
> -__SC_COMP(__NR_move_pages, sys_move_pages, compat_sys_move_pages)
> +__SYSCALL(__NR_move_pages, sys_move_pages)
>  #endif
>  
>  #define __NR_rt_tgsigqueueinfo 240
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index c925d1e1777e..783a24ceee88 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -290,7 +290,6 @@ COND_SYSCALL_COMPAT(set_mempolicy);
>  COND_SYSCALL(migrate_pages);
>  COND_SYSCALL_COMPAT(migrate_pages);
>  COND_SYSCALL(move_pages);
> -COND_SYSCALL_COMPAT(move_pages);
>  
>  COND_SYSCALL(perf_event_open);
>  COND_SYSCALL(accept4);
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 34a842a8eb6a..e9dfbde5f12c 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1835,6 +1835,27 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
>  	mmap_read_unlock(mm);
>  }
>  
> +static int put_pages_array(const void __user *chunk_pages[],
> +			   const void __user * __user *pages,
> +			   unsigned long chunk_nr)
> +{
> +	compat_uptr_t __user *pages32 = (compat_uptr_t __user *)pages;
> +	compat_uptr_t p;
> +	int i;
> +
> +	if (!in_compat_syscall())
> +		return copy_from_user(chunk_pages, pages,
> +				      chunk_nr * sizeof(*chunk_pages));
> +
> +	for (i = 0; i < chunk_nr; i++) {
> +		if (get_user(p, pages32 + i))
> +			return -EFAULT;
> +		chunk_pages[i] = compat_ptr(p);
> +	}
> +
> +	return 0;

I'd just keep the native version inline and have the compat one in
a helper, but that is just a minor detail.
