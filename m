Return-Path: <linux-arch+bounces-7746-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4651699275C
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 10:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA8C1C22ACA
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 08:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC8118BB9F;
	Mon,  7 Oct 2024 08:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="xZcbLOXs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fO2LJhza"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF54518B467;
	Mon,  7 Oct 2024 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290661; cv=none; b=KY+ADKQ+3KTP1vSOXABf8naj72xe19k3OoYXsb5ghCiipdWy0PWzTkfiEZaep9GXQ/T/QVeJ6ioj1svR1dUJfYm8jnQ6OhlhMgCOjuDVYLnSd4mw827Jj65XWyPiRXzoJHn0uoZ7NdOT0y/R23ieVUtD1FBWMoys8zruO+AjA5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290661; c=relaxed/simple;
	bh=Z5R8+yP0HA/NQUemXrMlONKZ5GJ9wbsUFWun6gb3o1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8UuFzWWCyfW4pJ695uThjqLroN7oo6T6BF91s5FxqBeOjgqGWTbduOtC9Eb3eH4oaGGs5KRCJyMr7WVXx8k0kvmKDq/GoR6TTbvIr7ZuKrj5+DPlJtE+OQInsp61iIGrArFf/+WRDSIzBh2lcDlGk4lCYkhNSlsNDn4hM2518U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=xZcbLOXs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fO2LJhza; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D45DD1140239;
	Mon,  7 Oct 2024 04:44:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 07 Oct 2024 04:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1728290657; x=
	1728377057; bh=pReAlbAp+RVZKMZPw8OzBm+oVocBKEzeB7uhsl5SfPU=; b=x
	ZcbLOXs6H3dMG3I/3jO2oYLp09QiGNqLxgOz76DNRk3LAZWaIXPq7pcfdqeJUygS
	KIYlN4Dk2FC/SH3NhnrRoTO77YdwhTTLw55LIVzJIIk7/hoI/+62GI1yy3s2otIY
	spvBpo1i/gd5H/Vxaqi2FXYPc0zxO9mxFSnuqqOTSqmLwNF8TAbmBwWk1lUvumal
	X1T2ffkW2PsTHd625RbLw9JdIReMmqaGUbAJjqKhgShaKRLrRt/EtuT35s0LSQQv
	cd/XmJs9Zqxqs96L54Zf8+VhhwVRdSvCZyY9z9nse3oUjvU4WxAv/v606JGvo55C
	BmUe7Dzr/r7PsbElEvgTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728290657; x=1728377057; bh=pReAlbAp+RVZKMZPw8OzBm+oVocB
	KEzeB7uhsl5SfPU=; b=fO2LJhzabR8jo7pHX9s6UkIFUtNI1MTFGfJ3MJnGXUW8
	nSgFoyQS4O/EqGHlfB7TLuV9gGUUcxSA/u7npit2roOQJxhZR3mPpZTvTmWM/bjs
	xwf1uQelPbCKodvbTe4kdgx1vKlU9s2LWVEnWGzq66kgF/1eCwchMy4KnEwUO3ey
	sWwrQKIUiusG4xhu5AbupplmQE5/kEGuOMJEctMnrLI6NOxn67aJuHKEK7rJzEzL
	1Bg5ThmgLi89drrnQn3NBeilBT3omzNWDmfcZYQJ/y/ceCEz75PN5p1FKcX/u8t7
	nYNThmEDeJLsvUBNjQ9VrJZpZ7PEiFJnc5lJNwD+TA==
X-ME-Sender: <xms:YZ8DZ50jtA0smBX-hTs4JUhwmJuw2yv7ftmTPsUK2JwCyHShJSDn-Q>
    <xme:YZ8DZwFUZPDynkcGKoRFEGP4KrW75aahVEOoxkVPfSnYiVYO3rQgPdqXFmDvlDHlv
    7q5bjKfl2j02KNpWAs>
X-ME-Received: <xmr:YZ8DZ54CfcSGlpTthFEOMMGIbgRuXVkUVZr6mBwPkgfcoxqJqhND7DWm4DmBOcTh3mkKdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepvdegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegrnhhthhhonhihrdihiihnrghgrgesohhrrggtlhgvrdgtohhmpdhrtghpthht
    oheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhope
    ifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepmhgrrhhkhhgvmhhm
    sehgohhoghhlvghmrghilhdrtghomhdprhgtphhtthhopehvihhrohesiigvnhhivhdrlh
    hinhhugidrohhrghdruhhkpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhm
    pdhrtghpthhtohepkhhhrghlihgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnh
    gurhgvhihknhhvlhesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvgdrhhgrnhhs
    vghnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:YZ8DZ219H6y75t49sbtvr9IF1VZVhDqw0ndB2pSVDuBesXUejzL_FQ>
    <xmx:YZ8DZ8EZ2PaYD90Eoeba4pl8eWefmMGCnjL8QDz0N3wTrXBEDSUU2w>
    <xmx:YZ8DZ3_5-N0cy7rnxFbonCGjXKE-94qTbkJk9X2GgbVHM9rnUqUKQQ>
    <xmx:YZ8DZ5nm28gKJJhTyqbcr_6CrVQsYs4FXP_Dh9ixTjhuh7-NvkMckA>
    <xmx:YZ8DZ8WLXye2wADwd0wC4LVEoe9K2ADvNCcFNk8-PzEcDTyIh87DJS96>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 04:44:10 -0400 (EDT)
Date: Mon, 7 Oct 2024 11:44:05 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, 
	markhemm@googlemail.com, viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org, 
	andreyknvl@gmail.com, dave.hansen@intel.com, luto@kernel.org, brauner@kernel.org, 
	arnd@arndb.de, ebiederm@xmission.com, catalin.marinas@arm.com, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mhiramat@kernel.org, rostedt@goodmis.org, vasily.averin@linux.dev, 
	xhao@linux.alibaba.com, pcc@google.com, neilb@suse.de, maz@kernel.org
Subject: Re: [RFC PATCH v3 09/10] mm: create __do_mmap() to take an mm_struct
 * arg
Message-ID: <sgrdkcwjzoazuqqutzmzlsjo5outzsp5gh7zsn6ur5qvhaslgw@b74envmtrahz>
References: <20240903232241.43995-1-anthony.yznaga@oracle.com>
 <20240903232241.43995-10-anthony.yznaga@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903232241.43995-10-anthony.yznaga@oracle.com>

On Tue, Sep 03, 2024 at 04:22:40PM -0700, Anthony Yznaga wrote:
> In preparation for mapping objects into an mshare region, create
> __do_mmap() to allow mapping into a specified mm. There are no
> functional changes otherwise.
> 
> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
> ---
>  include/linux/mm.h | 18 +++++++++++++++++-
>  mm/mmap.c          | 12 +++++-------
>  2 files changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 3aa0b3322284..a9afbda73cb0 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3409,11 +3409,27 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
>  
>  extern unsigned long mmap_region(struct file *file, unsigned long addr,
>  	unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
> -	struct list_head *uf);
> +	struct list_head *uf, struct mm_struct *mm);
> +#ifdef CONFIG_MMU
> +extern unsigned long __do_mmap(struct file *file, unsigned long addr,
> +	unsigned long len, unsigned long prot, unsigned long flags,
> +	vm_flags_t vm_flags, unsigned long pgoff, unsigned long *populate,
> +	struct list_head *uf, struct mm_struct *mm);
> +static inline unsigned long do_mmap(struct file *file, unsigned long addr,
> +	unsigned long len, unsigned long prot, unsigned long flags,
> +	vm_flags_t vm_flags, unsigned long pgoff, unsigned long *populate,
> +	struct list_head *uf)
> +{
> +	return __do_mmap(file, addr, len, prot, flags, vm_flags, pgoff,
> +			 populate, uf, current->mm);
> +}
> +#else
>  extern unsigned long do_mmap(struct file *file, unsigned long addr,
>  	unsigned long len, unsigned long prot, unsigned long flags,
>  	vm_flags_t vm_flags, unsigned long pgoff, unsigned long *populate,
>  	struct list_head *uf);
> +#endif
> +
>  extern int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
>  			 unsigned long start, size_t len, struct list_head *uf,
>  			 bool unlock);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d0dfc85b209b..4112f18e7302 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1250,15 +1250,14 @@ static inline bool file_mmap_ok(struct file *file, struct inode *inode,
>  }
>  
>  /*
> - * The caller must write-lock current->mm->mmap_lock.
> + * The caller must write-lock mm->mmap_lock.
>   */
> -unsigned long do_mmap(struct file *file, unsigned long addr,
> +unsigned long __do_mmap(struct file *file, unsigned long addr,
>  			unsigned long len, unsigned long prot,
>  			unsigned long flags, vm_flags_t vm_flags,
>  			unsigned long pgoff, unsigned long *populate,
> -			struct list_head *uf)
> +			struct list_head *uf, struct mm_struct *mm)

Argument list getting too long. At some point we need to have a struct to
pass them around.

>  {
> -	struct mm_struct *mm = current->mm;
>  	int pkey = 0;
>  
>  	*populate = 0;
> @@ -1465,7 +1464,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  			vm_flags |= VM_NORESERVE;
>  	}
>  
> -	addr = mmap_region(file, addr, len, vm_flags, pgoff, uf);
> +	addr = mmap_region(file, addr, len, vm_flags, pgoff, uf, mm);
>  	if (!IS_ERR_VALUE(addr) &&
>  	    ((vm_flags & VM_LOCKED) ||
>  	     (flags & (MAP_POPULATE | MAP_NONBLOCK)) == MAP_POPULATE))
> @@ -2848,9 +2847,8 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>  
>  unsigned long mmap_region(struct file *file, unsigned long addr,
>  		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
> -		struct list_head *uf)
> +		struct list_head *uf, struct mm_struct *mm)
>  {
> -	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma = NULL;
>  	struct vm_area_struct *next, *prev, *merge;
>  	pgoff_t pglen = len >> PAGE_SHIFT;
> -- 
> 2.43.5
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

