Return-Path: <linux-arch+bounces-15545-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B6012CDAB02
	for <lists+linux-arch@lfdr.de>; Tue, 23 Dec 2025 22:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C1B1E301B103
	for <lists+linux-arch@lfdr.de>; Tue, 23 Dec 2025 21:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3E82D6E53;
	Tue, 23 Dec 2025 21:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LR748CgI"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69DD2D248C;
	Tue, 23 Dec 2025 21:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766525872; cv=none; b=hAtx+fSwhFeWTfPr8x5n4C6i49STYL/PlWnR+TJNmybVqRGP5gYxS4rKpqwVL5h20rfB655CGd3AyXcJdAqLJzatJ16TsswY/HwMFLu7DylojZNLH6jKiu7ZIuaSYEpq/nPHgO+Lq/qn+s/fhoO82lLwdK5m7oPZH6hZzl0A4ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766525872; c=relaxed/simple;
	bh=q6AI67NwJvG0d5MePX9VplhpPUwUqzhtBZgditDmiMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ipi3h88YJTh/4Zd8EL8OPWoGwAhD3ziWd5tOHp2yRYeyX2GTuIqMQZbwiot3mTfi65THdsJlvXmhCi74TGO4CFPl5+jAZqXT6yattEYW8PtwUO/+uOe/wN7g7xCbzC5XhbBUT3RpSSMzCpjrMOG/O86zqWEBYpHuV0c8AJkMmHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LR748CgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78289C113D0;
	Tue, 23 Dec 2025 21:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766525870;
	bh=q6AI67NwJvG0d5MePX9VplhpPUwUqzhtBZgditDmiMI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LR748CgIoq5JJA9NDUF8u+wYPMpWF8Xelj4aJGLy/CdNNl0F01oIzd2UG1llNB46/
	 kORk78WwJaiX40Snzt4msG2bqX4uEOACjsFuoSCDrVKiKnQSARWJ7iLhXc7utOp3ao
	 jExEP8YChhF8bFnki75VkNu1r4Lj061SWPGnj7yoJeki1oXGRhXyo0bFp1rRl7r96e
	 5lB3anxVm8rDiUe8Rg/AqhHYYMp8mOtikOeyLRapzzhXR3tqOeYJR+AY3whfcgEdi8
	 Ha3nm4ceD/vi8fd3y7ntxStCt+tb/3lZg1D+eDFyOHiiRvdGQQjqMNzwyTfWQDFd2i
	 RaYg5F2sNd4Ww==
Message-ID: <4e680315-5530-4900-a59e-d61cd8209c6a@kernel.org>
Date: Tue, 23 Dec 2025 22:37:41 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] mm/hugetlb: fixes for PMD table sharing (incl.
 using mmu_gather)
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Laurence Oberman <loberman@redhat.com>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Nadav Amit <nadav.amit@gmail.com>
References: <20251223205046.565162-1-david@kernel.org>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251223205046.565162-1-david@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/23/25 21:50, David Hildenbrand (Red Hat) wrote:
> One functional fix, one performance regression fix, and two related
> comment fixes.

Ignore this one, I forgot to include the first patch. Will resend in a sec.

-- 
Cheers

David

