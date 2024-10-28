Return-Path: <linux-arch+bounces-8665-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B349B3BED
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 21:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18EE01F22C53
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 20:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B1F1E883F;
	Mon, 28 Oct 2024 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/uTw8Hh"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3A31E25F8;
	Mon, 28 Oct 2024 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147696; cv=none; b=EpORyVAb5cFxWaanF+Ol58lEqefO+uSzma62PuZUqMj9dBscaZSMtMTLsbG3NC6hkMzHUSHfkKa+7iEIh6AcXxEjmMksan1gT3MBRGVyxA3Wfl/vUkQkDIFWXy2cqcSR3iXFV1tmJK/rV+b4Jl1PdwhfCv5wWr0qN3cpMiQKn74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147696; c=relaxed/simple;
	bh=WIncviCWRj+OdzswXW0NKfNuuT3DkEk5n+CWBkE+ZzU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=uqUM/1GVoyi2ryr9/FBJnvqz9oX9fNuKRm8ThmGLBBNvzMotBAtHbr8zyQA0wZzp5YNEvlYG+2a5cG5lBPWvlWJ4vH8lII7aYwcWxLASyWoyGzKhjrHcyxdyasjgxaTHhl9MwpTw1imIp+k4yR1f89LDCQMRi/FGUuj8NXB1FWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/uTw8Hh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDC4C4CEC3;
	Mon, 28 Oct 2024 20:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730147696;
	bh=WIncviCWRj+OdzswXW0NKfNuuT3DkEk5n+CWBkE+ZzU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=W/uTw8HhH3RV8nUVU03c4ziChuS31b5wD7V2zuUuxUcAiKUwOC/TxP4OKTE0V92jB
	 kXdEIKxKhpsrCA/gQbXJ4CXeUv4kPRd/ClsXVgvrmsOf8JUQ8gAOZQss0dPwIPn2op
	 IEdq/ABhGmuqTHwbZdpdqe3K47x+uVvcROuNodCNCMBlX1hNDrQ9rIUx4IX9W0I+PD
	 xnq6bgnzScZXGPk/s42tJfdKqez/rzjICgK6XUWwzlxr/+CY45ugO83ZzuZz5fAJHo
	 KfFpgOj/IOV+EOVunXbUMtPbcSsk01og7ANlrwtN4oNbup2mNsvif/e+p/+PHMwhbg
	 eLRG4yQqCpOyA==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Oct 2024 22:34:51 +0200
Message-Id: <D57Q652K9SCW.2LESCVR7ZK8BK@kernel.org>
Cc: "Suren Baghdasaryan" <surenb@google.com>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, "Matthew Wilcox" <willy@infradead.org>,
 "Vlastimil Babka" <vbabka@suse.cz>, "Paul E . McKenney"
 <paulmck@kernel.org>, "Jann Horn" <jannh@google.com>, "David Hildenbrand"
 <david@redhat.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 "Muchun Song" <muchun.song@linux.dev>, "Richard Henderson"
 <richard.henderson@linaro.org>, "Matt Turner" <mattst88@gmail.com>, "Thomas
 Bogendoerfer" <tsbogend@alpha.franken.de>, "James E . J . Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Helge Deller" <deller@gmx.de>,
 "Chris Zankel" <chris@zankel.net>, "Max Filippov" <jcmvbkbc@gmail.com>,
 "Arnd Bergmann" <arnd@kernel.org>, <linux-alpha@vger.kernel.org>,
 <linux-mips@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
 <linux-arch@vger.kernel.org>, "Shuah Khan" <shuah@kernel.org>, "Christian
 Brauner" <brauner@kernel.org>, <linux-kselftest@vger.kernel.org>,
 "Sidhartha Kumar" <sidhartha.kumar@oracle.com>, "Jeff Xu"
 <jeffxu@chromium.org>, "Christoph Hellwig" <hch@infradead.org>,
 <linux-api@vger.kernel.org>, "John Hubbard" <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 2/5] mm: add PTE_MARKER_GUARD PTE marker
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Andrew Morton"
 <akpm@linux-foundation.org>
X-Mailer: aerc 0.18.2
References: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
 <7f81287792eef318a7a711d358c00e2e48216f15.1729699916.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <7f81287792eef318a7a711d358c00e2e48216f15.1729699916.git.lorenzo.stoakes@oracle.com>

On Wed Oct 23, 2024 at 7:24 PM EEST, Lorenzo Stoakes wrote:
> Add a new PTE marker that results in any access causing the accessing
> process to segfault.
>
> This is preferable to PTE_MARKER_POISONED, which results in the same
> handling as hardware poisoned memory, and is thus undesirable for cases
> where we simply wish to 'soft' poison a range.
>
> This is in preparation for implementing the ability to specify guard page=
s
> at the page table level, i.e. ranges that, when accessed, should cause
> process termination.
>
> Additionally, rename zap_drop_file_uffd_wp() to zap_drop_markers() - the
> function checks the ZAP_FLAG_DROP_MARKER flag so naming it for this singl=
e
> purpose was simply incorrect.
>
> We then reuse the same logic to determine whether a zap should clear a
> guard entry - this should only be performed on teardown and never on
> MADV_DONTNEED or MADV_FREE.
>
> We additionally add a WARN_ON_ONCE() in hugetlb logic should a guard mark=
er
> be encountered there, as we explicitly do not support this operation and
> this should not occur.
>
> Acked-by: Vlastimil Babka <vbabkba@suse.cz>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/mm_inline.h |  2 +-
>  include/linux/swapops.h   | 24 +++++++++++++++++++++++-
>  mm/hugetlb.c              |  4 ++++
>  mm/memory.c               | 18 +++++++++++++++---
>  mm/mprotect.c             |  6 ++++--
>  5 files changed, 47 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 355cf46a01a6..1b6a917fffa4 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -544,7 +544,7 @@ static inline pte_marker copy_pte_marker(
>  {
>  	pte_marker srcm =3D pte_marker_get(entry);
>  	/* Always copy error entries. */
> -	pte_marker dstm =3D srcm & PTE_MARKER_POISONED;
> +	pte_marker dstm =3D srcm & (PTE_MARKER_POISONED | PTE_MARKER_GUARD);
> =20
>  	/* Only copy PTE markers if UFFD register matches. */
>  	if ((srcm & PTE_MARKER_UFFD_WP) && userfaultfd_wp(dst_vma))
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index cb468e418ea1..96f26e29fefe 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -426,9 +426,19 @@ typedef unsigned long pte_marker;
>   * "Poisoned" here is meant in the very general sense of "future accesse=
s are
>   * invalid", instead of referring very specifically to hardware memory e=
rrors.
>   * This marker is meant to represent any of various different causes of =
this.
> + *
> + * Note that, when encountered by the faulting logic, PTEs with this mar=
ker will
> + * result in VM_FAULT_HWPOISON and thus regardless trigger hardware memo=
ry error
> + * logic.
>   */
>  #define  PTE_MARKER_POISONED			BIT(1)
> -#define  PTE_MARKER_MASK			(BIT(2) - 1)
> +/*
> + * Indicates that, on fault, this PTE will case a SIGSEGV signal to be
> + * sent. This means guard markers behave in effect as if the region were=
 mapped
> + * PROT_NONE, rather than if they were a memory hole or equivalent.
> + */
> +#define  PTE_MARKER_GUARD			BIT(2)
> +#define  PTE_MARKER_MASK			(BIT(3) - 1)
> =20
>  static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
>  {
> @@ -464,6 +474,18 @@ static inline int is_poisoned_swp_entry(swp_entry_t =
entry)
>  {
>  	return is_pte_marker_entry(entry) &&
>  	    (pte_marker_get(entry) & PTE_MARKER_POISONED);
> +
> +}
> +
> +static inline swp_entry_t make_guard_swp_entry(void)
> +{
> +	return make_pte_marker_entry(PTE_MARKER_GUARD);
> +}
> +
> +static inline int is_guard_swp_entry(swp_entry_t entry)
> +{
> +	return is_pte_marker_entry(entry) &&
> +		(pte_marker_get(entry) & PTE_MARKER_GUARD);
>  }
> =20
>  /*
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 906294ac85dc..2c8c5da0f5d3 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6353,6 +6353,10 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, str=
uct vm_area_struct *vma,
>  				ret =3D VM_FAULT_HWPOISON_LARGE |
>  				      VM_FAULT_SET_HINDEX(hstate_index(h));
>  				goto out_mutex;
> +			} else if (WARN_ON_ONCE(marker & PTE_MARKER_GUARD)) {
> +				/* This isn't supported in hugetlb. */
> +				ret =3D VM_FAULT_SIGSEGV;
> +				goto out_mutex;
>  			}
>  		}
> =20
> diff --git a/mm/memory.c b/mm/memory.c
> index 0f614523b9f4..551455cd453f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1455,7 +1455,7 @@ static inline bool should_zap_folio(struct zap_deta=
ils *details,
>  	return !folio_test_anon(folio);
>  }
> =20
> -static inline bool zap_drop_file_uffd_wp(struct zap_details *details)
> +static inline bool zap_drop_markers(struct zap_details *details)
>  {
>  	if (!details)
>  		return false;
> @@ -1476,7 +1476,7 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct=
 *vma,
>  	if (vma_is_anonymous(vma))
>  		return;
> =20
> -	if (zap_drop_file_uffd_wp(details))
> +	if (zap_drop_markers(details))
>  		return;
> =20
>  	for (;;) {
> @@ -1671,7 +1671,15 @@ static unsigned long zap_pte_range(struct mmu_gath=
er *tlb,
>  			 * drop the marker if explicitly requested.
>  			 */
>  			if (!vma_is_anonymous(vma) &&
> -			    !zap_drop_file_uffd_wp(details))
> +			    !zap_drop_markers(details))
> +				continue;
> +		} else if (is_guard_swp_entry(entry)) {
> +			/*
> +			 * Ordinary zapping should not remove guard PTE
> +			 * markers. Only do so if we should remove PTE markers
> +			 * in general.
> +			 */
> +			if (!zap_drop_markers(details))
>  				continue;
>  		} else if (is_hwpoison_entry(entry) ||
>  			   is_poisoned_swp_entry(entry)) {
> @@ -4003,6 +4011,10 @@ static vm_fault_t handle_pte_marker(struct vm_faul=
t *vmf)
>  	if (marker & PTE_MARKER_POISONED)
>  		return VM_FAULT_HWPOISON;
> =20
> +	/* Hitting a guard page is always a fatal condition. */
> +	if (marker & PTE_MARKER_GUARD)
> +		return VM_FAULT_SIGSEGV;
> +
>  	if (pte_marker_entry_uffd_wp(entry))
>  		return pte_marker_handle_uffd_wp(vmf);
> =20
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 0c5d6d06107d..1f671b0667bd 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -236,9 +236,11 @@ static long change_pte_range(struct mmu_gather *tlb,
>  			} else if (is_pte_marker_entry(entry)) {
>  				/*
>  				 * Ignore error swap entries unconditionally,
> -				 * because any access should sigbus anyway.
> +				 * because any access should sigbus/sigsegv
> +				 * anyway.
>  				 */
> -				if (is_poisoned_swp_entry(entry))
> +				if (is_poisoned_swp_entry(entry) ||
> +				    is_guard_swp_entry(entry))
>  					continue;
>  				/*
>  				 * If this is uffd-wp pte marker and we'd like

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

