Return-Path: <linux-arch+bounces-8510-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CB89AD826
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 01:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F371C218FA
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 23:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055E11F80B8;
	Wed, 23 Oct 2024 23:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K3xUv+m/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9041155345;
	Wed, 23 Oct 2024 23:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729724647; cv=none; b=jdksllQslCS5k/+jQzjbql8PAHcIKUVuLHsD8OBvO2ezCqsgfhugD/nuJogf47BPME7g9QHwgBFy2RDkw1ixnACFdEaTxObnMXFNCUgGBQ4PkvXZachfAY4cg08wdyCWMAZBkltSIYs3qg99Thcat6uY5Ns6IkJnUISwZNFJ4dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729724647; c=relaxed/simple;
	bh=SW7zk5YIdDFzBZiXaPsu8LMcyr3b9ExBrJBUQkf3olo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UUONu6fmkUo18HlTdDjiLrfzYJimbk0sd6emJJoOMAPTxrLMoLsJm1wpiZUBiZdG+vFVez66LGRLzRlHZmnKI9QB0bv+qOWsG+tKDD6eatC4vYHjdeL11pTzKfI/8see8cC4+o/6aP/8bqZWBkgq+GpVHEqVOIyfEByCldgqZPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=K3xUv+m/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622E3C4CEC6;
	Wed, 23 Oct 2024 23:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729724647;
	bh=SW7zk5YIdDFzBZiXaPsu8LMcyr3b9ExBrJBUQkf3olo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K3xUv+m/KQuYP+4Jbr6VP77i2LjZj+ZZpjW5f6vY+ymdzzXKonCFLAFiuQPn4KWF1
	 FOV4IWRH8CCkN0eVKriG0PL5Kyc4OyDZC1kr5QgWPgbxEF8T3mTepn9ohoTPzMJTuJ
	 BpZQTKPkEJkK/0IQfIixeN9rNU0+UiypaxpSdQgQ=
Date: Wed, 23 Oct 2024 16:04:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, Vlastimil
 Babka <vbabka@suse.cz>, "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn
 <jannh@google.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Muchun Song
 <muchun.song@linux.dev>, Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, "James E . J . Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Arnd
 Bergmann <arnd@kernel.org>, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-arch@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Christian
 Brauner <brauner@kernel.org>, linux-kselftest@vger.kernel.org, Sidhartha
 Kumar <sidhartha.kumar@oracle.com>, Jeff Xu <jeffxu@chromium.org>,
 Christoph Hellwig <hch@infradead.org>, linux-api@vger.kernel.org, John
 Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 1/5] mm: pagewalk: add the ability to install PTEs
Message-Id: <20241023160405.33995c68f20c141325a8fadb@linux-foundation.org>
In-Reply-To: <9be732fd0e897453116b433fe2f468ef7795602e.1729699916.git.lorenzo.stoakes@oracle.com>
References: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
	<9be732fd0e897453116b433fe2f468ef7795602e.1729699916.git.lorenzo.stoakes@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 17:24:38 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> 
> ...
>
> Existing mechanism for performing a walk which also installs page table
> entries if necessary are heavily duplicated throughout the kernel,

How complicated is it to migrate those to use this?

> ...
>
> We explicitly do not allow the existing page walk API to expose this
> feature as it is dangerous and intended for internal mm use only. Therefore
> we provide a new walk_page_range_mm() function exposed only to
> mm/internal.h.
>

Is this decision compatible with the above migrations?

