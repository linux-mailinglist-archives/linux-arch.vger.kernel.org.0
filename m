Return-Path: <linux-arch+bounces-8511-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B319AD856
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 01:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 220D42840BF
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 23:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C32200105;
	Wed, 23 Oct 2024 23:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0jXpVYQP"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE0F155345;
	Wed, 23 Oct 2024 23:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729725128; cv=none; b=t1vKbvpCWF9aPGQCDM7vhEJAlXDgIYdChm5bIpDQfBxvZDNofUkLjSYtgOOzcAKk1XoOpm/+m4KbjD4zw4o4OSTm6rNHfgzjp4v1TjyltGedupuQ4VggpdxmbqBF5epspuJ0iiCHL+AWQK/mUx/DjgKsFocMn00m571ISgXfy/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729725128; c=relaxed/simple;
	bh=Xv3OkoVC+KcKBKqBTXxL8TjiJXtnkAaQxtterVVAUDo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RCUOqlE92Jpk3OwP3rT2LGBVJ4DHKUP/z4g5yRzkow5LrGDOszI4NldO9eg+iKcuTcdE/LpnufCg3PRrCI4K3/iyonzRKVsv6ax3Mtl7i/7mnHvpzlmYEuP+bu1o1rR3wXKK8c0G94mypVKYmS5VECkGvD/8V5pj4w8a2YHa9nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0jXpVYQP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA2FC4CEC6;
	Wed, 23 Oct 2024 23:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729725127;
	bh=Xv3OkoVC+KcKBKqBTXxL8TjiJXtnkAaQxtterVVAUDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0jXpVYQPcu/BWEDQR1MJA6q9T5x9sGey1lE/UhrQvX9BTRgIG1l0bBXUECLpLGANh
	 jLVo3KNOeDYtkPzvcprnjgO2KJuc3gLGrDPb7AMnjmsICYqWMfBZvjgHf8pFMK+gda
	 0XPn1ddH/ndxfm4XW+YsTXCpfSYJq2PhfKIbUAwc=
Date: Wed, 23 Oct 2024 16:12:05 -0700
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
Subject: Re: [PATCH v3 3/5] mm: madvise: implement lightweight guard page
 mechanism
Message-Id: <20241023161205.003ad735d5f6ec50ec2eb054@linux-foundation.org>
In-Reply-To: <415da1e6c5828d96db3af480d243a7f68ccabf6d.1729699916.git.lorenzo.stoakes@oracle.com>
References: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
	<415da1e6c5828d96db3af480d243a7f68ccabf6d.1729699916.git.lorenzo.stoakes@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 17:24:40 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> We permit this operation on anonymous memory only

What is the reason for this restriction?

(generally, it would be nice to include the proposed manpage update at
this time, so people can review it while the code change is fresh in
their minds)

