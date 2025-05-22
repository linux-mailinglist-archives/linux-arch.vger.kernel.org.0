Return-Path: <linux-arch+bounces-12074-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4853FAC0CDC
	for <lists+linux-arch@lfdr.de>; Thu, 22 May 2025 15:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858673A6CEE
	for <lists+linux-arch@lfdr.de>; Thu, 22 May 2025 13:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A83428BA91;
	Thu, 22 May 2025 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="jQd4bDjC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBDD35949;
	Thu, 22 May 2025 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747920686; cv=none; b=YXmOtQtCYoJGKkSxLLHYUyza9TPwgU0y8qjqg3bJAF4aArNVM37zgtjkeDTsiwxG+CXJDmzJjV1XxtNtjNSc8iTUpwNWBzTKz4usbJzxp74Bj2PSzKH2acUF370YOMYU/sJ7dpQBKZrubYp4ZhQUtfCKI7ghHl+YOttt/vKK9tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747920686; c=relaxed/simple;
	bh=jwWiLe42S9SsbU+ebldx8V794Mu/3hXTJRdX5N3/+X0=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FCuYQKRCeSe9/QwA+ILOYZAdjTL9eyQaemx6N3H+PU1W6P5AyXqoXAJtXg9PkSJjsEk94X3/eCEW5iPSzTYXWxG4tduR8bqM5W8+AiIouD3BuvH1u1NGb7lDAV3l1zM+khBnJUkRw0R3IwM/YMamW+DmQFbT6HgQ6pHcxu+3Jmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=jQd4bDjC; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1747920684; x=1779456684;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=OlB+2OtTrJazNk0kELLux61Y/VPnAYDjFX1pVaDScWs=;
  b=jQd4bDjCZHBGVyAA+NHskUIFRN2g0yQZxBNRmkzrfNnTZjvJsDOgpUM7
   WRkDj+3KNR4zT2AyWQQXhMIbx/7NmF7Wv+1gWwz/v1oDFO51NJstP1/74
   Gs6lw0YuD9jXNNNBFowt7GrS9itvPeopRy2n5xRqsi9OfuN0cmSfoTaog
   fvBx6/o9HZWGYaEVKvOCsjoLbQ13ZxEu5U3+qob3DXh+yOlLhMIZAUZS5
   sARD4myrD9E0JyoQCVL98tEn2OzdYG1loi1E7moS9kJmlvB/2Uez0YFLG
   NChyTiza0BGT38LFDYLizEXl4YjTY4oKROXqFIsW/FteJvpLc+FusMP37
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,306,1739836800"; 
   d="scan'208";a="96236152"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 13:31:16 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:64371]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.109:2525] with esmtp (Farcaster)
 id befc10d2-e35f-4a55-9b8d-6a66acedb4c3; Thu, 22 May 2025 13:31:15 +0000 (UTC)
X-Farcaster-Flow-ID: befc10d2-e35f-4a55-9b8d-6a66acedb4c3
Received: from EX19EXOUWC001.ant.amazon.com (10.250.64.135) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:31:14 +0000
Received: from EX19MTAUWA002.ant.amazon.com (10.250.64.202) by
 EX19EXOUWC001.ant.amazon.com (10.250.64.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:31:13 +0000
Received: from email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Thu, 22 May 2025 13:31:13 +0000
Received: from dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com [172.19.91.144])
	by email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com (Postfix) with ESMTP id 59D7B4080E;
	Thu, 22 May 2025 13:31:13 +0000 (UTC)
Received: by dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id E490B157A; Thu, 22 May 2025 15:31:12 +0200 (CEST)
From: Pratyush Yadav <ptyadav@amazon.de>
To: Mike Rapoport <rppt@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Alexandre Ghiti
	<alexghiti@rivosinc.com>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/cma: make detection of highmem_start more robust
In-Reply-To: <aCwW70QKGFtXVxEH@kernel.org>
References: <20250519171805.1288393-1-rppt@kernel.org>
	<mafs0plg4tgee.fsf@amazon.de> <aCwW70QKGFtXVxEH@kernel.org>
Date: Thu, 22 May 2025 15:31:12 +0200
Message-ID: <mafs04ixcu5zz.fsf_-_@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Mike,

On Tue, May 20 2025, Mike Rapoport wrote:

> On Mon, May 19, 2025 at 11:55:05PM +0200, Pratyush Yadav wrote:
>> Hi Mike,
>>
>> On Mon, May 19 2025, Mike Rapoport wrote:
>>
>> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>> >
>> > Pratyush Yadav reports the following crash:
>> >
>> >     ------------[ cut here ]------------
>> >     kernel BUG at arch/x86/mm/physaddr.c:23!
>> >     ception 0x06 IP 10:ffffffff812ebbf8 error 0 cr2 0xffff88903ffff000
>> >     CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.15.0-rc6+ #231 PREEMPT(undef)
>> >     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
>> >     RIP: 0010:__phys_addr+0x58/0x60
>> >     Code: 01 48 89 c2 48 d3 ea 48 85 d2 75 05 e9 91 52 cf 00 0f 0b 48 3d ff ff ff 1f 77 0f 48 8b 05 20 54 55 01 48 01 d0 e9 78 52 cf 00 <0f> 0b 90 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
>> >     RSP: 0000:ffffffff82803dd8 EFLAGS: 00010006 ORIG_RAX: 0000000000000000
>> >     RAX: 000000007fffffff RBX: 00000000ffffffff RCX: 0000000000000000
>> >     RDX: 000000007fffffff RSI: 0000000280000000 RDI: ffffffffffffffff
>> >     RBP: ffffffff82803e68 R08: 0000000000000000 R09: 0000000000000000
>> >     R10: ffffffff83153180 R11: ffffffff82803e48 R12: ffffffff83c9aed0
>> >     R13: 0000000000000000 R14: 0000001040000000 R15: 0000000000000000
>> >     FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
>> >     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> >     CR2: ffff88903ffff000 CR3: 0000000002838000 CR4: 00000000000000b0
>> >     Call Trace:
>> >      <TASK>
>> >      ? __cma_declare_contiguous_nid+0x6e/0x340
>> >      ? cma_declare_contiguous_nid+0x33/0x70
>> >      ? dma_contiguous_reserve_area+0x2f/0x70
>> >      ? setup_arch+0x6f1/0x870
>> >      ? start_kernel+0x52/0x4b0
>> >      ? x86_64_start_reservations+0x29/0x30
>> >      ? x86_64_start_kernel+0x7c/0x80
>> >      ? common_startup_64+0x13e/0x141
>> >
>> >   The reason is that __cma_declare_contiguous_nid() does:
>> >
>> >           highmem_start = __pa(high_memory - 1) + 1;
>> >
>> >   If dma_contiguous_reserve_area() (or any other CMA declaration) is
>> >   called before free_area_init(), high_memory is uninitialized. Without
>> >   CONFIG_DEBUG_VIRTUAL, it will likely work but use the wrong value for
>> >   highmem_start.
>> >
>> > The issue occurs because commit e120d1bc12da ("arch, mm: set high_memory in
>> > free_area_init()") moved initialization of high_memory after the call to
>> > dma_contiguous_reserve() -> __cma_declare_contiguous_nid() on several
>> > architectures.
>> >
>> > In the case CONFIG_HIGHMEM is enabled, some architectures that actually
>> > support HIGHMEM (arm, powerpc and x86) have initialization of high_memory
>> > before a possible call to __cma_declare_contiguous_nid() and some
>> > initialized high_memory late anyway (arc, csky, microblase, mips, sparc,
>> > xtensa) even before the commit e120d1bc12da so they are fine with using
>> > uninitialized value of high_memory.
>>
>> I don't know if they are fine or they haven't realized this is a bug
>> yet.
>
> For those that initialized high_memory in their mem_init() it would have
> been a bug quite some time.

Agreed. This patch fixes the regression caused by e120d1bc12da5 ("arch,
mm: set high_memory in free_area_init()"). I don't think you need to go
around fixing long standing bugs. I was just thinking out loud with this
comment.

[...]

-- 
Regards,
Pratyush Yadav



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


