Return-Path: <linux-arch+bounces-8662-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201E19B3908
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 19:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F7C282CA0
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 18:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D0F1DF26E;
	Mon, 28 Oct 2024 18:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCSmkWVX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E585EEA8;
	Mon, 28 Oct 2024 18:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730139858; cv=none; b=FXoPONFGi/7+N36oM+mYoqsFqaOvzU+hwlkx7LQ02dmjGBgSNXKlLJdtRdyYl/vGeLrqhyeHNqDd0D3DCYBn/lHRHj2y/0i3wNS6K/mngUQ6rU01YWdpFBhWwPc1dHZNIGzHgNO0XkilJQMXM+qebrhQ0C+H77TaP+J3BJsFH70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730139858; c=relaxed/simple;
	bh=Dc2nfSd4gFZOOCQf51oe06WNS9JqcUB5O926K4UYWDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tC6gDgoHuqqHC5DrMUhaRblM3wlx/0wdPhXl5pACPr+aKgkhNCLUwRP7+wPbrCNKdM+KGyKbloAa9/55GLo9j7LP1WldkST7D0qaFzxE1XcWivhalwXMt0attPDfQHjvX62NCWrFEEWfv9Uj0XKxiXxXfgcfPSS1Nm9SVRTS5JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCSmkWVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED80C4CEC3;
	Mon, 28 Oct 2024 18:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730139856;
	bh=Dc2nfSd4gFZOOCQf51oe06WNS9JqcUB5O926K4UYWDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fCSmkWVXt9faMdPUgXr92nQ0Nd+XrerOUvEAhYwHTcr8MRTGylHk4evQh0xHDRjOX
	 SHVZXpDvpxMwMX1M1S5R7Mdl7i5yr7w0C6uCUy+T9SVAGQ5BehH1B7l7Hnruer33ig
	 p0sJd+xHOBlqZMRs2YpfF5WM6IfCsSIA/TUyEeO2krcDFVBqY4nfnwFAym5yoSjiLz
	 RGP/fgh65ns9VVUCARVqDVtrI/Rg4Y4Tt7vkcyhP09vktn9UQGOBLPLFDEdUFrb+1F
	 qTrMZAjZ99HRgBSdsuah6pOGrpsvrP/eiZwYjozx98DtLytURMVqye2eAQ+MZHtCIg
	 opA8bKnAsUR8w==
From: SeongJae Park <sj@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Jann Horn <jannh@google.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Arnd Bergmann <arnd@kernel.org>,
	linux-alpha@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Jeff Xu <jeffxu@chromium.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-api@vger.kernel.org,
	John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v4 0/5] implement lightweight guard pages
Date: Mon, 28 Oct 2024 11:24:13 -0700
Message-Id: <20241028182413.277218-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1730123433.git.lorenzo.stoakes@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 28 Oct 2024 14:13:26 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Userland library functions such as allocators and threading implementations
> often require regions of memory to act as 'guard pages' - mappings which,
> when accessed, result in a fatal signal being sent to the accessing
> process.
> 
> The current means by which these are implemented is via a PROT_NONE mmap()
> mapping, which provides the required semantics however incur an overhead of
> a VMA for each such region.
> 
> With a great many processes and threads, this can rapidly add up and incur
> a significant memory penalty. It also has the added problem of preventing
> merges that might otherwise be permitted.
> 
> This series takes a different approach - an idea suggested by Vlasimil
> Babka (and before him David Hildenbrand and Jann Horn - perhaps more - the

Nit.  s/Vlasimil/Vlastimil/ ;)


Thanks,
SJ

[...]

