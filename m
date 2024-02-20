Return-Path: <linux-arch+bounces-2494-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D24B985BA81
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 12:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2381F2489E
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 11:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AEE664CC;
	Tue, 20 Feb 2024 11:26:49 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EA7664C6;
	Tue, 20 Feb 2024 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708428409; cv=none; b=clYSJxp+VXa4n2zgJtQB1gyRZNgVG3wKSOnANhe2YOXpFFCh6BzPyQSC6nD0iwrb0wqZ4EGUzXYUL4Ra/ZMEkVoMgQU4GhAAM74VQ0iWaJl3PXsu0Dp/ziAdyJdGqOE1E+7SxK50nrQ7dBKm2C1bo+rzDX0MFlEg2V/2JgLynLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708428409; c=relaxed/simple;
	bh=SkQ/sTEoMINt2E/gNw7cKAVDKtuqBdyfXNZsFkvtik4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MkHluWVa8WBitNfELFrvpm8+MtocfwdVDw4NAPLcAq0rRLM/IU6VOYTl+TfOvyXbTRgF9PInCr+9e8PMGqX10PdLBJonBVHLo0aLsNr9amq1wBj9J6oGRmQxVkqaht0Lf0fwYY2kXZrvHPeGTMjT8YmPwz5tb0gq6fFn6rzKEGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4F9BFEC;
	Tue, 20 Feb 2024 03:27:25 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE4513F762;
	Tue, 20 Feb 2024 03:26:41 -0800 (PST)
Date: Tue, 20 Feb 2024 11:26:38 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, pcc@google.com, steven.price@arm.com,
	anshuman.khandual@arm.com, david@redhat.com, eugenis@google.com,
	kcc@google.com, hyesoo.yu@samsung.com, rppt@kernel.org,
	akpm@linux-foundation.org, peterz@infradead.org,
	konrad.wilk@oracle.com, willy@infradead.org, jgross@suse.com,
	hch@lst.de, geert@linux-m68k.org, vitaly.wool@konsulko.com,
	ddstreet@ieee.org, sjenning@redhat.com, hughd@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: arm64 MTE tag storage reuse - alternatives to MIGRATE_CMA
Message-ID: <ZdSMbjGf2Fj98diT@raptor>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

This is a request to discuss alternatives to the current approach for
reusing the MTE tag storage memory for data allocations [1]. Each iteration
of the series uncovered new issues, the latest being that memory allocation
is being performed in atomic contexts [2]; I would like to start a
discussion regarding possible alternative, which would integrate better
with the memory management code.

This is a high level overview of the current approach:

 * Tag storage pages are put on the MIGRATE_CMA lists, meaning they can be
   used for data allocations like (almost) any other page in the system.

 * When a page is allocated as tagged, the corresponding tag storage is
   also allocated.

 * There's a static relationship between a page and the location in memory
   where its tags are stored. Because of this, if the corresponding tag
   storage is used for data, the tag storage page is migrated.

Although this is the most generic approach because tag storage pages are
treated like normal pages, it has some disadvantages:

 * HW KASAN (MTE in the kernel) cannot be used. The kernel allocates memory
   in atomic context, where migration is not possible.

 * Tag storage pages cannot be themselves tagged, and this means that all
   CMA pages, even those which aren't tag storage, cannot be used for
   tagged allocations.

 * Page migration is costly, and a process that uses MTE can experience
   measurable slowdowns if the tag storage it requires is in use for data.
   There might be ways to reduce this cost (by reducing the likelihood that
   tag storage pages are allocated), but it cannot be completely
   eliminated.

 * Worse yet, a userspace process can use a tag storage page in such a way
   that migration is effectively impossible [3],[4].  A malicious process
   can make use of this to prevent the allocation of tag storage for other
   processes in the system, leading to a degraded experience for the
   affected processes. Worst case scenario, progress becomes impossible for
   those processes.

One alternative approach I'm looking at right now is cleancache. Cleancache
was removed in v5.17 (commit 0a4ee518185e) because the only backend, the
tmem driver, had been removed earlier (in v5.3, commit 814bbf49dcd0).

With this approach, MTE tag storage would be implemented as a driver
backend for cleancache. When a tag storage page is needed for storing tags,
the page would simply be dropped from the cache (cleancache_get_page()
returns -1).

I believe this is a very good fit for tag storage reuse, because it allows
tag storage to be allocated even in atomic contexts, which enables MTE in
the kernel. As a bonus, all of the changes to MM from the current approach
wouldn't be needed, as tag storage allocation can be handled entirely in
set_ptes_at(), copy_*highpage() or arch_swap_restore().

Is this a viable approach that would be upstreamable? Are there other
solutions that I haven't considered? I'm very much open to any alternatives
that would make tag storage reuse viable.

[1] https://lore.kernel.org/all/20240125164256.4147-1-alexandru.elisei@arm.com/
[2] https://lore.kernel.org/all/CAMn1gO7M51QtxPxkRO3ogH1zasd2-vErWqoPTqGoPiEvr8Pvcw@mail.gmail.com/
[3] https://lore.kernel.org/linux-trace-kernel/4e7a4054-092c-4e34-ae00-0105d7c9343c@redhat.com/
[4] https://lore.kernel.org/linux-trace-kernel/92833873-cd70-44b0-9f34-f4ac11b9e498@redhat.com/

Thanks,
Alex

