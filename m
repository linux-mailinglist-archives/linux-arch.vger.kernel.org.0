Return-Path: <linux-arch+bounces-13106-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB59B1FFF5
	for <lists+linux-arch@lfdr.de>; Mon, 11 Aug 2025 09:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA22189BF35
	for <lists+linux-arch@lfdr.de>; Mon, 11 Aug 2025 07:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D992D94A1;
	Mon, 11 Aug 2025 07:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSgMoSnb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B102D9EC5
	for <linux-arch@vger.kernel.org>; Mon, 11 Aug 2025 07:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754896180; cv=none; b=hZ4ChNtL+KB1WaVUJnmVzH54b4SDdqXReZQ9+oCOuWTmHbwJ5osP2wCfHxAoasm6zTWfBETXiWum1RjF3ZXldUIpsD1HzN6ps0xUG+q0cCCP4uENDDzaD6Qy0fbXf8dUoLuogH22KN/hEgJFNLwpT45CUkePfaPB2/ACQCVPYqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754896180; c=relaxed/simple;
	bh=7z//XUu8T6I5PWiVUYkgzX56lekKtAuXc9LA1vkAIVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldzAAqBK6HIyr3FkfHpR97woa5VdxVHkCWWczb6kve1BHcNidhWqJrjLf95Z7/+6AyJslgHfhlaH8YUsmbxE63TBlhWRhlnH7i4DWRzDGh7UZrhdaYakVPLazHih9hNemw1EPBBfIwrKu69RiWLajAtmz6e8PEvhZRdmKqG17U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSgMoSnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED5EC4CEF6;
	Mon, 11 Aug 2025 07:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754896179;
	bh=7z//XUu8T6I5PWiVUYkgzX56lekKtAuXc9LA1vkAIVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jSgMoSnbXdeC3hTmMa5rxqnU+TWuL44ft9yhN6jzlYEmA7jwdSGYiQnLF6BFOYKsr
	 5R/fr9QjyFbzxrlBrIv2gCok7gC8JkgAppw6IXD/F87bUVX5sLc2JR+i0hiKjHB/eg
	 cfP9T2kKrEeWB53CBUEIYKgIVeFsIdkopEWkV1obWsWDyqrTyQ0SMRBRBszN1XGf6p
	 a/x4EjKoAuphTOp/i4iZkdRFQSga+eMCJZDAvNlPeoiQXnyWXFuLlWT0mOaSgKnz9o
	 oU2KCRXlBAKJHbtJRS6w71U3Eb8UeQ9PSpr4qZWggtwXe60/vHe8hYUg6SLwi5/Qqk
	 j0QU/Hr3uRHzA==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 61606F40068;
	Mon, 11 Aug 2025 03:09:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 11 Aug 2025 03:09:37 -0400
X-ME-Sender: <xms:MZeZaAKhv47jBdQVbZBUzCxovzHYH_0rrP55uhLzR3Dqu-Hy8rtmog>
    <xme:MZeZaDm4-FA4AmkgD2YQQA1xH-F3sHPexYTS35ALEVFWRqWFjvQXtfar8y28gGpiS
    cXt0_A1OFnzm3zDBmM>
X-ME-Received: <xmr:MZeZaM-CyM-RA_V15WzO_HJwVVjXwS5bJQX1q813TA-nJyYUmhcLGBheIsW3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedukeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepheeikeeuveduheevtddvffekhfeufefhvedtudehheektdfhtdehjeevleeuffeg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepkedtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehhrghrrhihrdihohhosehorhgrtghlvgdrtghomhdprhgtphhtthhopeguvghnnh
    hisheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhu
    nhgurghtihhonhdrohhrghdprhgtphhtthhopehrhigrsghinhhinhdrrgdrrgesghhmrg
    hilhdrtghomhdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegsphesrghlihgvnhekrdguvgdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvg
    grugdrohhrghdprhgtphhtthhopehluhhtoheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepthhglhigsehlihhnuhhtrhhonhhigidruggv
X-ME-Proxy: <xmx:MZeZaGZbB5w_M42lUmZvSVfIC5VjvScMKskxvkLxG0mVV0m3V7kKAw>
    <xmx:MZeZaBc00jAWL5dtGe5myKZzMdQ7PLHS6rajsmRqWQuvhtwgycMP1g>
    <xmx:MZeZaGGN3-BRzRyZ3VTcErLpqp_9MdvkA37zFIuvtc29YHSY7cqBRg>
    <xmx:MZeZaEPqxrTYCm-gaYlP41qi_-NhCIWpAR2UzkynZnOmQu5E2MBG4Q>
    <xmx:MZeZaO4ZV2QSxZoQAn7qeAHqpWYLVxkPnxGf8XyRRwOEAG9Iw4NuNkCY>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 03:09:36 -0400 (EDT)
Date: Mon, 11 Aug 2025 07:46:13 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Dennis Zhou <dennis@kernel.org>,
 	Andrew Morton <akpm@linux-foundation.org>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, x86@kernel.org,
 	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 	Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 	Dave Hansen <dave.hansen@linux.intel.com>,
 Christoph Lameter <cl@gentwo.org>, 	David Hildenbrand <david@redhat.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 	Vincenzo Frascino <vincenzo.frascino@arm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, kasan-dev@googlegroups.com,
 	Mike Rapoport <rppt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org, 	Dmitry Vyukov <dvyukov@google.com>,
 Alexander Potapenko <glider@google.com>,
 	Vlastimil Babka <vbabka@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, 	Thomas Huth <thuth@redhat.com>,
 John Hubbard <jhubbard@nvidia.com>,
 	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Michal Hocko <mhocko@suse.com>,
 	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
 Oscar Salvador <osalvador@suse.de>, 	Jane Chu <jane.chu@oracle.com>,
 Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
 	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Joerg Roedel <joro@8bytes.org>, 	Alistair Popple <apopple@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, 	linux-arch@vger.kernel.org
Subject: Re: [PATCH V4 mm-hotfixes 0/3] mm, x86: fix crash due to missing
 page table sync and make it harder to miss
Message-ID: <qsprh2qiisldfsielpx6inuiw3rrh5owr3urin7maxvwtlhipz@zbioc6hgqe3r>
References: <20250811053420.10721-1-harry.yoo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811053420.10721-1-harry.yoo@oracle.com>

On Mon, Aug 11, 2025 at 02:34:17PM +0900, Harry Yoo wrote:
> # The solution: Make page table sync more code robust and harder to miss
> 
> To address this, Dave Hansen suggested [3] [4] introducing
> {pgd,p4d}_populate_kernel() for updating kernel portion
> of the page tables and allow each architecture to explicitly perform
> synchronization when installing top-level entries. With this approach,
> we no longer need to worry about missing the sync step, reducing the risk
> of future regressions.

Looks sane:

Acked-by: Kiryl Shutsemau <kas@kernel.org>

> The new interface reuses existing ARCH_PAGE_TABLE_SYNC_MASK,
> PGTBL_P*D_MODIFIED and arch_sync_kernel_mappings() facility used by
> vmalloc and ioremap to synchronize page tables.
> 
> pgd_populate_kernel() looks like this:
> static inline void pgd_populate_kernel(unsigned long addr, pgd_t *pgd,
>                                        p4d_t *p4d)
> {
>         pgd_populate(&init_mm, pgd, p4d);
>         if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)
>                 arch_sync_kernel_mappings(addr, addr);
> }
> 
> It is worth noting that vmalloc() and apply_to_range() carefully
> synchronizes page tables by calling p*d_alloc_track() and
> arch_sync_kernel_mappings(), and thus they are not affected by
> this patch series.

Well, except ARCH_PAGE_TABLE_SYNC_MASK is not defined on x86-64 until
now. So I think it is affected.

-- 
Kiryl Shutsemau / Kirill A. Shutemov

