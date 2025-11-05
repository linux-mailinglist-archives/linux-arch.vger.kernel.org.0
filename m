Return-Path: <linux-arch+bounces-14514-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4BFC33CB4
	for <lists+linux-arch@lfdr.de>; Wed, 05 Nov 2025 03:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 542984F433C
	for <lists+linux-arch@lfdr.de>; Wed,  5 Nov 2025 02:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B2923BCED;
	Wed,  5 Nov 2025 02:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEmS+3I9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396DB2367BA
	for <linux-arch@vger.kernel.org>; Wed,  5 Nov 2025 02:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762310507; cv=none; b=KilWqZ1TPDzH/2nV1sNMDwEYB58C2eowWI8QIrrr5eKr7PpZiEKno8n6bWLeNtJITn7qEpRmCUxCF9SXtAfVJbMMKZMS5wg/OdHpzULsc17uTLbN/a+44VzzrsoF7jQ1TW1DRW+b4pfHDHhx3Ga1XfsXqvWjM66F6RroYjuA6Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762310507; c=relaxed/simple;
	bh=PjIh0DtXOzHZkEPK6bUNpRhZZkxl57GmW5vYJSH5bug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cedVz8CikykQSbh5Nl9stkUy9cGxyw9GSHPcbHCrANtOj/sFOHSHsoQ3YQps0AttEXMiTu6jVSN8h97DbQ0p7ndbHTrfmUFHnsgNeN7EEwnrKFa6ypLZteV1rz9uD3a50CHJUpqbfasV9Y3Q/UOIPP9qskgqh22hGL9+wWd4UNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEmS+3I9; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-641018845beso1012242a12.3
        for <linux-arch@vger.kernel.org>; Tue, 04 Nov 2025 18:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762310504; x=1762915304; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViiTvlr9WUOouJ2tSO6oIz/u1XimAQZsK9c62kBG2uQ=;
        b=UEmS+3I9/hWpaA6OKA3gwPYvDGjQZg3IGW1HP/3wCWG9kEB3amaSiTktVjeMwtU9Vz
         9OitmKXnGY4KREybzlnGF3d1LK5aAppXOW/gtwszcFFaVxaQEAU4OhjIlvMznlz/0o9E
         gx5uI4+5U5vS/y2w1lLiOkuG1OtpQw/DLmZ1y6SYCLa6f6aLXq4afsr0QH83PI5p1ki3
         pcidTr6r4XlEZEEn/jJd0ovEVJZcsccOYi2ZKeakJ4cAJOmayzAZDiqETB0wfN8oJaBy
         VIyxTj/cTgPIdSzj0eP4O+TNdsl3W3EVS7SgbqonvxBQ275a7FrSNlaOei4w8TLydHnY
         K13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762310504; x=1762915304;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ViiTvlr9WUOouJ2tSO6oIz/u1XimAQZsK9c62kBG2uQ=;
        b=T5xo2X5k6/tHs0OTpomwaZ2feEnPMjF7aFMGZjiFR0xRcNUB22bRKiIt4fsLAIg00L
         poBmaaJfWbGC5I2uY0fU6LTNIwkfix6c1sm85nnsNIGUB6b1n45MtlGVlAb2qovflDYs
         aw8vIgqfwlAi84otZOcMF25SnT0xN5B3eP15mzb1Jg8xOjihzDsCzckzRbFS7B5EP8/W
         N6FdCjJX9RYfrUImhGAI1xwq7QeEI7B8zyokEiemm8XOS9tz4wCMU4pOqJc3TLwzd4CF
         qhmlMaDh9w1MIQexMs9ZRAHdsoP6HnIy9Q7tO6yw6g6/vRuRsB8O1DOeMYnYBh4j8Ryy
         FJrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3ety0oEePJf8piwB2pEYZBDOOaEnSOqqyC0tVo0idIuOh2olptmvKtdDnxfJoOnvUVJvsek/dLq9T@vger.kernel.org
X-Gm-Message-State: AOJu0Yzry0O81qNRkbpc1SED1pDtrM/Vsjyj6qr1SjhAUytSC5bNIodz
	uU44qn5atqi8tcZonz6f9SlEXobZeVnTLh+F3mE+WG6e3OiQKjpqOaSR
X-Gm-Gg: ASbGncvi2F64f7ZQBo+DmZvRoHU7F+Y1Rrp/HJynXXd2/Fv2EXzasqmFIULnW1hF+Ix
	97q51T2IGmg6I9ZDsYAOXDlWumCfTeyD7AVtz28Q+kk3fFWq9flf5E9DaJZs3n90TdSb9cCvnyY
	loaRsW088/wAvBLf0bg4kc3fKuu2WfH9VvVQZ0uf7I3kcPZX2slzi4nZFMup0DO9TxU4LcPaRoz
	FA9zVqDn/CtSuUxdFia7FZ65I76bA1EXRVhw81KwoCeFFtKUORXWfcaZV1KQ8/MhEbNQ3uLXYgR
	6UbsaHXhnlT8qssqVorFddXZvxcdu01/CHqkU9uZCaqosgG19BZ42PxYffrKZ8f7U2SfSVlJElp
	LRNVviPazmlscS9ewkh8GKLSQr08TipiBSfN7rmHw7wbNT7qa6GPhDbB48raGgbR9Xhb0gL8Ng9
	Xo4SC4ZywVQg==
X-Google-Smtp-Source: AGHT+IEhst8qtfGo16G97VsH5MJRSalariFjSPTu9KPWOjxNsyChIg/n4Cvg6QvPn/kA2H/rBkbMGQ==
X-Received: by 2002:a05:6402:450f:b0:640:9b62:a8bb with SMTP id 4fb4d7f45d1cf-64105a44a6amr1195466a12.22.1762310503278;
        Tue, 04 Nov 2025 18:41:43 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6a5c7e5sm3420577a12.24.2025.11.04.18.41.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Nov 2025 18:41:41 -0800 (PST)
Date: Wed, 5 Nov 2025 02:41:40 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
	SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
	Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH 00/16] mm: remove is_swap_[pte, pmd]() + non-swap
 entries, introduce leaf entries
Message-ID: <20251105024140.kmxo4dltsl6toyil@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Nov 03, 2025 at 12:31:41PM +0000, Lorenzo Stoakes wrote:
>There's an established convention in the kernel that we treat leaf page
>tables (so far at the PTE, PMD level) as containing 'swap entries' should
>they be neither empty (i.e. p**_none() evaluating true) nor present
>(i.e. p**_present() evaluating true).
>
>However, at the same time we also have helper predicates - is_swap_pte(),
>is_swap_pmd() - which are inconsistently used.
>
>This is problematic, as it is logical to assume that should somebody wish
>to operate upon a page table swap entry they should first check to see if
>it is in fact one.
>
>It also implies that perhaps, in future, we might introduce a non-present,
>none page table entry that is not a swap entry.
>
>This series resolves this issue by systematically eliminating all use of
>the is_swap_pte() and is swap_pmd() predicates so we retain only the
>convention that should a leaf page table entry be neither none nor present
>it is a swap entry.
>
>We also have the further issue that 'swap entry' is unfortunately a really
>rather overloaded term and in fact refers to both entries for swap and for
>other information such as migration entries, page table markers, and device
>private entries.
>
>We therefore have the rather 'unique' concept of a 'non-swap' swap entry.
>
>This series therefore introduces the concept of 'leaf entries' to eliminate
>this confusion.
>
>A leaf entry in this sense is any page table entry which is non-present,
>and represented by the leaf_entry_t type.
>
>This includes 'none' or empty entries, which are simply represented by an
>zero leaf entry value.
>
>In order to maintain compatibility as we transition the kernel to this new
>type, we simply typedef swp_entry_t to leaf_entry_t.
>
>We introduce a number of predicates and helpers to interact with leaf
>entries in include/linux/leafops.h which, as it imports swapops.h, can be
>treated as a drop-in replacement for swapops.h wherever leaf entry helpers
>are used.
>
>Since leafent_from_[pte, pmd]() treats present entries as they were
>empty/none leaf entries, this allows for a great deal of simplification of
>code throughout the code base, which this series utilises a great deal.
>
>We additionally change from swap entry to leaf entry handling where it
>makes sense to and eliminate functions from swapops.h where leaf entries
>obviate the need for the functions.
>

Hi, Lorenzo

Thanks for the effort on cleanup this, which helps me clearing the confusing
on checking swap entry.


-- 
Wei Yang
Help you, Help me

