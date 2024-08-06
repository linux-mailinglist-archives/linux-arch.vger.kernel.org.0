Return-Path: <linux-arch+bounces-6063-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE5E949946
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 22:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0D21C21751
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 20:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E7815AD9E;
	Tue,  6 Aug 2024 20:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UwsWqPyF"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E39158D91;
	Tue,  6 Aug 2024 20:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976705; cv=none; b=DRnSlCAhNLRhEc/F5Kkimhhtd8GfAm5ALeVfwavFsom1iPO+U5nyV/5uBxSHI7N/OsGrGMmZsTe+Kvnp5zb6urF80Olm8PN6JZcqurRV6PyTsazU2kOYS5sPl26gYgKgycMEH8UHBwJh6kD3H3kRA8I/XJ0xwnLZ8WiKR+h1g84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976705; c=relaxed/simple;
	bh=HaVxTBr+TZyUR8nKHP0+7C/5oP0eNXAiiCPV3AQKlCI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=O3NnIvhJ8VmML72ROw5BKCqdMevsnl6T5D0sii9OZrgJcGFtwr5QEcAuHDlv1WCVDprIViQUVFfz8v+LL7M1cviN4IKZHTm9YciOnoBtSR4yNVhbmNN+2nIFiXQflpWcfUMkYrSnmvohz9DCRRCES7EePUz20QhX38Q+zysTSAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UwsWqPyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3D6C32786;
	Tue,  6 Aug 2024 20:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722976705;
	bh=HaVxTBr+TZyUR8nKHP0+7C/5oP0eNXAiiCPV3AQKlCI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UwsWqPyF194XQ6mvU9rZ/D43H20Vr/VG23nzCprpy3uedY6gs4CICFuomI1ZC6lo8
	 M+ZUrV5CbdJJOg0XUr+PZumVG7vh1THHgA7rMx2uDnXD46Xjw1FYyLnCdKWhDgrG7h
	 PJGzkMFR5N4rrKTI3QWJCLNDiyBcXAkOJki3IbTY=
Date: Tue, 6 Aug 2024 13:38:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: zhiguojiang <justinjiang@vivo.com>
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
Message-Id: <20240806133823.5cb3f27ef30c42dad5d0c3e8@linux-foundation.org>
In-Reply-To: <dbead7ca-e9a4-4ee8-9247-4e1ba9f6695c@vivo.com>
References: <20240731133318.527-1-justinjiang@vivo.com>
	<20240731091715.b78969467c002fa3a120e034@linux-foundation.org>
	<dbead7ca-e9a4-4ee8-9247-4e1ba9f6695c@vivo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Aug 2024 14:30:52 +0800 zhiguojiang <justinjiang@vivo.com> wrote:

> > Dumb question: why can't this be done in userspace?  The exiting
> > process does fork/exit and lets the child do all this asynchronous freeing?
> The logic optimization for kernel releasing swap entries cannot be
> implemented in userspace. The multiple exiting processes here own
> their independent mm, rather than parent and child processes share the
> same mm. Therefore, when the kernel executes multiple exiting process
> simultaneously, they will definitely occupy multiple CPU core resources
> to complete it.

What I'm asking is why not change those userspace processes so that they
fork off a child process which shares the MM (shared mm_struct) and
then the original process exits, leaving the asynchronously-running
child to clean up the MM resources.


