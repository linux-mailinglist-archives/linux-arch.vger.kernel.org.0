Return-Path: <linux-arch+bounces-7745-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDBE992752
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 10:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63B61C22A30
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 08:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0527E18C34D;
	Mon,  7 Oct 2024 08:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="kzubhdtV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MyWCzTNa"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF3C18BBA6;
	Mon,  7 Oct 2024 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290508; cv=none; b=J9yve+OItqs41m/4O2vp4q6FwIoTJpr9USX/4sn+Vx8SZ6SZ3bFckn2JalI8LPfU+UWN4RNEtuBUpQ7EQjoBc/2XIZU/V06KuqrJ3r5HVFSuyyUHulzcOvOhBds2EHE3qa+VQIrZx6jjoLb8OusDtT5Q4TuXGmJ14v64fqiiRwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290508; c=relaxed/simple;
	bh=nb272j8NqUMzeDxPqjhQYe7tAqqJx4dXBATXGd8PicA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4Kp/vpy8UnxYCYLr6T9o9IPp8yzTnee+YyWI/NtShvB5NTaCXlLfzaxezk6c79F/eKodKyqxjqGHdMNKxXoBNGbgacf5ygR88Dzl8OX0nKFGR0lOj/Et6fZShEtY6ZSYOBXb14aPBSJEju82KsvhA/RaV5vWnrAXko5ZlMj2So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=kzubhdtV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MyWCzTNa; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A45FF11400AB;
	Mon,  7 Oct 2024 04:41:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 07 Oct 2024 04:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1728290504; x=
	1728376904; bh=HW1/nAnoZg+IChobN7xn2IJtM/YKr7Y7ke8CNTMEY+M=; b=k
	zubhdtVs6m2be1vjrm0Iv4AhLP3u/bU2Hds2JxoESNdhvf0Ff1MBZBI9HTzLxlth
	tPtlGxQ9M98pZakjDbelKKRPmdv9HGU454yYxntDhuhOKwlszSOwXJ7Vuz7r3f4I
	Hq5k1E9NFNHubpu3R421HBQhNg1PWMO2SVZyKnkCEdwvQSmVoC1BbYqpn7CRZzR1
	YRRv4KbVfIqCf09DMzrjWZe9CkNrnlxSg3V8g55NOA6mVZhA3CNP8A44MsIcRbhl
	M49yGzNljbrDa+9q3F/h5x2RX+z1GFKO97J2qdg7rl7ox3HirQ+IflLLReFd0QUd
	FKkmBq0ae+yiVh3k0Ya6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728290504; x=1728376904; bh=HW1/nAnoZg+IChobN7xn2IJtM/YK
	r7Y7ke8CNTMEY+M=; b=MyWCzTNatMPWz/TlQmyjHa/b2i/wB9c2FdNz3+ISrDuH
	m2gh0ywkKDXCqPQM0ZJbCisZ8GWfpGzPzyK7TrLyKZxZCJFthIIS03dWQXH3OHWZ
	2PIwubmfNuqY/ezi+h7QBq5SvnOyfuIL9Jm7mi67eGLBXUw6lXjebi3V4K/YAP7v
	uH2WygXalGmapiTTHOAsRLMWzq3QkbxZRGAdcgIzbxWcPg2gqWvYVlf1EQEFIRsG
	KJT2hxGUc5+Tc6KMKDsSMKANxQSpZt3upjj4MdT4EcbJfGgNtKE8+r79drcGCIey
	Q/aujLiMkxwE3jjdojsMaGak5JfK1QwkFFlhIXmpsg==
X-ME-Sender: <xms:xp4DZyen6g6Lf62d2G2Iu6zOCha6qa57xpC5sTnK_5KO1OMqm8VTdQ>
    <xme:xp4DZ8NRAF65_Uwwfj5q-YWaOru7eiWZXW-t5xtWVIcxhD30hpxOw4GaBOHeUq6jo
    09ruVUSfnXywwZGR1w>
X-ME-Received: <xmr:xp4DZzhavMDIfBTCxwPLK3ZjeZVEG2sQ3U2muWkOycZr7CHsi2XK9JP4uZEhw2UnaPOP5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepvdegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegrnhhthhhonhihrdihiihnrghgrgesohhrrggtlhgvrdgtohhmpdhrtghpthht
    oheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhope
    ifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepmhgrrhhkhhgvmhhm
    sehgohhoghhlvghmrghilhdrtghomhdprhgtphhtthhopehvihhrohesiigvnhhivhdrlh
    hinhhugidrohhrghdruhhkpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhm
    pdhrtghpthhtohepkhhhrghlihgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnh
    gurhgvhihknhhvlhesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvgdrhhgrnhhs
    vghnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:xp4DZ_8lxEkRA8BiUs6tbtUE3yPLCKMqYM92zQn4KoR37dtYy3eL5w>
    <xmx:xp4DZ-sL_wdgpkiypgMads1lTa7AkCIkTevzAlRJAPvH8S024-jDhg>
    <xmx:xp4DZ2HR19NVTfxrwuiiQEzGHz3Pq5rCEPhX7vhpMxHnl0YnDuTtxg>
    <xmx:xp4DZ9PdCq86PRv6uTEzjZ8TgWfPivUIZctKOr6utIiMGoV8vqT_xQ>
    <xmx:yJ4DZ1-4tNMoKn6zSIx8bWeCioJF3dUqE-r7-NNWawsYZpbTA2zR9GCZ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 04:41:35 -0400 (EDT)
Date: Mon, 7 Oct 2024 11:41:30 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, 
	markhemm@googlemail.com, viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org, 
	andreyknvl@gmail.com, dave.hansen@intel.com, luto@kernel.org, brauner@kernel.org, 
	arnd@arndb.de, ebiederm@xmission.com, catalin.marinas@arm.com, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mhiramat@kernel.org, rostedt@goodmis.org, vasily.averin@linux.dev, 
	xhao@linux.alibaba.com, pcc@google.com, neilb@suse.de, maz@kernel.org
Subject: Re: [RFC PATCH v3 08/10] mm/mshare: Add basic page table sharing
 support
Message-ID: <crakkuynbh373evxs5tbqp2jeq4h3rmvuprjq73sc3gjex6w5q@tnzempendkz7>
References: <20240903232241.43995-1-anthony.yznaga@oracle.com>
 <20240903232241.43995-9-anthony.yznaga@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903232241.43995-9-anthony.yznaga@oracle.com>

On Tue, Sep 03, 2024 at 04:22:39PM -0700, Anthony Yznaga wrote:
> From: Khalid Aziz <khalid@kernel.org>
> 
> Add support for handling page faults in an mshare region by
> redirecting the faults to operate on the mshare mm_struct and
> vmas contained in it and to link the page tables of the faulting
> process with the shared page tables in the mshare mm.
> Modify the unmap path to ensure that page tables in mshare regions
> are kept intact when a process exits. Note that they are also
> kept intact and not unlinked from a process when an mshare region
> is explicitly unmapped which is bug to be addressed.
> 
> Signed-off-by: Khalid Aziz <khalid@kernel.org>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
> ---
>  mm/internal.h |  1 +
>  mm/memory.c   | 62 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  mm/mshare.c   | 38 +++++++++++++++++++++++++++++++
>  3 files changed, 98 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 8005d5956b6e..8ac224d96806 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1578,6 +1578,7 @@ void unlink_file_vma_batch_init(struct unlink_vma_file_batch *);
>  void unlink_file_vma_batch_add(struct unlink_vma_file_batch *, struct vm_area_struct *);
>  void unlink_file_vma_batch_final(struct unlink_vma_file_batch *);
>  
> +extern vm_fault_t find_shared_vma(struct vm_area_struct **vma, unsigned long *addrp);
>  static inline bool vma_is_shared(const struct vm_area_struct *vma)
>  {
>  	return VM_SHARED_PT && (vma->vm_flags & VM_SHARED_PT);
> diff --git a/mm/memory.c b/mm/memory.c
> index 3c01d68065be..f526aef71a61 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -387,11 +387,15 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>  			vma_start_write(vma);
>  		unlink_anon_vmas(vma);
>  
> +		/*
> +		 * There is no page table to be freed for vmas that
> +		 * are mapped in mshare regions
> +		 */
>  		if (is_vm_hugetlb_page(vma)) {
>  			unlink_file_vma(vma);
>  			hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
>  				floor, next ? next->vm_start : ceiling);
> -		} else {
> +		} else if (!vma_is_shared(vma)) {
>  			unlink_file_vma_batch_init(&vb);
>  			unlink_file_vma_batch_add(&vb, vma);
>  
> @@ -399,7 +403,8 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>  			 * Optimization: gather nearby vmas into one call down
>  			 */
>  			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
> -			       && !is_vm_hugetlb_page(next)) {
> +			       && !is_vm_hugetlb_page(next)
> +			       && !vma_is_shared(next)) {
>  				vma = next;
>  				next = mas_find(mas, ceiling - 1);
>  				if (unlikely(xa_is_zero(next)))
> @@ -412,7 +417,9 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>  			unlink_file_vma_batch_final(&vb);
>  			free_pgd_range(tlb, addr, vma->vm_end,
>  				floor, next ? next->vm_start : ceiling);
> -		}
> +		} else
> +			unlink_file_vma(vma);
> +
>  		vma = next;

I would rather have vma->vm_ops->free_pgtables() hook that would be defined
to non-NULL for mshared and hugetlb VMAs

>  	} while (vma);
>  }
> @@ -1797,6 +1804,13 @@ void unmap_page_range(struct mmu_gather *tlb,
>  	pgd_t *pgd;
>  	unsigned long next;
>  
> +	/*
> +	 * No need to unmap vmas that share page table through
> +	 * mshare region
> +	 */
> +	 if (vma_is_shared(vma))
> +		return;
> +

Ditto. vma->vm_ops->unmap_page_range().

>  	BUG_ON(addr >= end);
>  	tlb_start_vma(tlb, vma);
>  	pgd = pgd_offset(vma->vm_mm, addr);
> @@ -5801,6 +5815,7 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>  	struct mm_struct *mm = vma->vm_mm;
>  	vm_fault_t ret;
>  	bool is_droppable;
> +	bool shared = false;
>  
>  	__set_current_state(TASK_RUNNING);
>  
> @@ -5808,6 +5823,21 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>  	if (ret)
>  		goto out;
>  
> +	if (unlikely(vma_is_shared(vma))) {
> +		/* XXX mshare does not support per-VMA locks yet so fallback to mm lock */
> +		if (flags & FAULT_FLAG_VMA_LOCK) {
> +			vma_end_read(vma);
> +			return VM_FAULT_RETRY;
> +		}
> +
> +		ret = find_shared_vma(&vma, &address);
> +		if (ret)
> +			return ret;
> +		if (!vma)
> +			return VM_FAULT_SIGSEGV;
> +		shared = true;

Do we need to update 'mm' variable here?

It is going to be used to account the fault below. Not sure which mm has
to account such faults.

> +	}
> +
>  	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
>  					    flags & FAULT_FLAG_INSTRUCTION,
>  					    flags & FAULT_FLAG_REMOTE)) {
> @@ -5843,6 +5873,32 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>  	if (is_droppable)
>  		ret &= ~VM_FAULT_OOM;
>  
> +	/*
> +	 * Release the read lock on the shared mm of a shared VMA unless
> +	 * unless the lock has already been released.
> +	 * The mmap lock will already have been released if __handle_mm_fault
> +	 * returns VM_FAULT_COMPLETED or if it returns VM_FAULT_RETRY and
> +	 * the flags FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT are
> +	 * _not_ both set.
> +	 * If the lock was released earlier, release the lock on the task's
> +	 * mm now to keep lock state consistent.
> +	 */
> +	if (shared) {
> +		int release_mmlock = 1;
> +
> +		if ((ret & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)) == 0) {
> +			mmap_read_unlock(vma->vm_mm);
> +			release_mmlock = 0;
> +		} else if ((flags & FAULT_FLAG_ALLOW_RETRY) &&
> +				(flags & FAULT_FLAG_RETRY_NOWAIT)) {
> +			mmap_read_unlock(vma->vm_mm);
> +			release_mmlock = 0;
> +		}
> +
> +		if (release_mmlock)
> +			mmap_read_unlock(mm);
> +	}
> +
>  	if (flags & FAULT_FLAG_USER) {
>  		mem_cgroup_exit_user_fault();
>  		/*
> diff --git a/mm/mshare.c b/mm/mshare.c
> index f3f6ed9c3761..8f47c8d6e6a4 100644
> --- a/mm/mshare.c
> +++ b/mm/mshare.c
> @@ -19,6 +19,7 @@
>  #include <linux/spinlock_types.h>
>  #include <uapi/linux/magic.h>
>  #include <uapi/linux/msharefs.h>
> +#include "internal.h"
>  
>  struct mshare_data {
>  	struct mm_struct *mm;
> @@ -33,6 +34,43 @@ struct msharefs_info {
>  static const struct inode_operations msharefs_dir_inode_ops;
>  static const struct inode_operations msharefs_file_inode_ops;
>  
> +/* Returns holding the host mm's lock for read.  Caller must release. */
> +vm_fault_t
> +find_shared_vma(struct vm_area_struct **vmap, unsigned long *addrp)
> +{
> +	struct vm_area_struct *vma, *guest = *vmap;
> +	struct mshare_data *m_data = guest->vm_private_data;
> +	struct mm_struct *host_mm = m_data->mm;
> +	unsigned long host_addr;
> +	pgd_t *pgd, *guest_pgd;
> +
> +	mmap_read_lock(host_mm);

Hm. So we have current->mm locked here, right? So this is nested mmap
lock. Have you tested it under lockdep? I expected it to complain.

> +	host_addr = *addrp - guest->vm_start + host_mm->mmap_base;
> +	pgd = pgd_offset(host_mm, host_addr);
> +	guest_pgd = pgd_offset(guest->vm_mm, *addrp);
> +	if (!pgd_same(*guest_pgd, *pgd)) {
> +		set_pgd(guest_pgd, *pgd);
> +		mmap_read_unlock(host_mm);
> +		return VM_FAULT_NOPAGE;
> +	}
> +
> +	*addrp = host_addr;
> +	vma = find_vma(host_mm, host_addr);
> +
> +	/* XXX: expand stack? */
> +	if (vma && vma->vm_start > host_addr)
> +		vma = NULL;
> +
> +	*vmap = vma;
> +
> +	/*
> +	 * release host mm lock unless a matching vma is found
> +	 */
> +	if (!vma)
> +		mmap_read_unlock(host_mm);
> +	return 0;
> +}
> +
>  /*
>   * Disallow partial unmaps of an mshare region for now. Unmapping at
>   * boundaries aligned to the level page tables are shared at could
> -- 
> 2.43.5
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

