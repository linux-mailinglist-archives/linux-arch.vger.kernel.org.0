Return-Path: <linux-arch+bounces-5783-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10537943403
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 18:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FC421C21BD3
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 16:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751841B581B;
	Wed, 31 Jul 2024 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z1zHSZM4"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381C317BA0;
	Wed, 31 Jul 2024 16:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722442637; cv=none; b=Cqz8pNU3D0aeNR8x7PNyBQ9MHYF4crv+GVZtTigs6tcNn0s5intdkroUUxlXvaKoQPQ7k9kooP6T3tOTQ6epjffEUeSzR+/B449OM7JELvLH6g3o6pUlvdpa1MPWnT1zrdigW4Tzfasg1sh2fL7fVREz4ZbT7dekm2S1xmygoDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722442637; c=relaxed/simple;
	bh=o4Mg7vGFFDdh5GzpJdq3GqHcTrDwf5S/DobsTje7KZ4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FLV6FA01f25J89dcEtiMrXRDpukNI3arm0pQeT4UWCucC0tyrlQBywT64H1BWPec+FoZ54K67cewdjcDBv0ac+AU3W6t6rlshcOw1/Uz/Ak3GWYDQy3dACDM8FFzBkDiBGwe/GeBwWKFm1HFj/D2pF66e4NXfKtGrhQZifJ5BVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Z1zHSZM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F2FC116B1;
	Wed, 31 Jul 2024 16:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722442636;
	bh=o4Mg7vGFFDdh5GzpJdq3GqHcTrDwf5S/DobsTje7KZ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z1zHSZM48wVFFlJqF1StVZOLw9IG/5ID/2e4qXWkhfUgK1S62W74TkucFn3eixaa6
	 BBsstP1IUCZyQMPE/DAvSqZJq5diHwxXSiPTHLoH7Xcm7M6qIbfz1XbnT4p+Bgi84d
	 C5Up9oY/oVPtVn4kfqnCL1+L4+URhAF2nXLQFQBk=
Date: Wed, 31 Jul 2024 09:17:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Zhiguo Jiang <justinjiang@vivo.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Will Deacon
 <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick
 Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Arnd
 Bergmann <arnd@arndb.de>, Johannes Weiner <hannes@cmpxchg.org>, Michal
 Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 linux-arch@vger.kernel.org, cgroups@vger.kernel.org, Barry Song
 <21cnbao@gmail.com>, kernel test robot <lkp@intel.com>,
 opensource.kernel@vivo.com
Subject: Re: [PATCH v2 0/3] mm: tlb swap entries batch async release
Message-Id: <20240731091715.b78969467c002fa3a120e034@linux-foundation.org>
In-Reply-To: <20240731133318.527-1-justinjiang@vivo.com>
References: <20240731133318.527-1-justinjiang@vivo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 21:33:14 +0800 Zhiguo Jiang <justinjiang@vivo.com> wrote:

> The main reasons for the prolonged exit of a background process is the

The kernel really doesn't have a concept of a "background process". 
It's a userspace concept - perhaps "the parent process isn't waiting on
this process via wait()".

I assume here you're referring to an Android userspace concept?  I
expect that when Android "backgrounds" a process, it does lots of
things to that process.  Perhaps scheduling priority, perhaps
alteration of various MM tunables, etc.

So rather than referring to "backgrounding" it would be better to
identify what tuning alterations are made to such processes to bring
about this behavior.

> time-consuming release of its swap entries. The proportion of swap memory
> occupied by the background process increases with its duration in the
> background, and after a period of time, this value can reach 60% or more.

Again, what is it about the tuning of such processes which causes this
behavior?

> Additionally, the relatively lengthy path for releasing swap entries
> further contributes to the longer time required for the background process
> to release its swap entries.
> 
> In the multiple background applications scenario, when launching a large
> memory application such as a camera, system may enter a low memory state,
> which will triggers the killing of multiple background processes at the
> same time. Due to multiple exiting processes occupying multiple CPUs for
> concurrent execution, the current foreground application's CPU resources
> are tight and may cause issues such as lagging.
> 
> To solve this problem, we have introduced the multiple exiting process
> asynchronous swap memory release mechanism, which isolates and caches
> swap entries occupied by multiple exit processes, and hands them over
> to an asynchronous kworker to complete the release. This allows the
> exiting processes to complete quickly and release CPU resources. We have
> validated this modification on the products and achieved the expected
> benefits.

Dumb question: why can't this be done in userspace?  The exiting
process does fork/exit and lets the child do all this asynchronous freeing?

> It offers several benefits:
> 1. Alleviate the high system cpu load caused by multiple exiting
>    processes running simultaneously.
> 2. Reduce lock competition in swap entry free path by an asynchronous
>    kworker instead of multiple exiting processes parallel execution.

Why is lock contention reduced?  The same amount of work needs to be
done.

> 3. Release memory occupied by exiting processes more efficiently.

Probably it's slightly less efficient.

There are potential problems with this approach of passing work to a
kernel thread:

- The process will exit while its resources are still allocated.  But
  its parent process assumes those resources are now all freed and the
  parent process then proceeds to allocate resources.  This results in
  a time period where peak resource consumption is higher than it was
  before such a change.

- If all CPUs are running in userspace with realtime policy
  (SCHED_FIFO, for example) then the kworker thread will not run,
  indefinitely.

- Work which should have been accounted to the exiting process will
  instead go unaccounted.  

So please fully address all these potential issues.


