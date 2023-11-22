Return-Path: <linux-arch+bounces-402-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E717F52BC
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 22:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F5F0B20D99
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 21:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A481C2AC;
	Wed, 22 Nov 2023 21:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yW75kvZE"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A85C1C6AC;
	Wed, 22 Nov 2023 21:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24948C433C8;
	Wed, 22 Nov 2023 21:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1700689186;
	bh=EEOjqT3UP3KXbuKk0Jj/F1pAkbZLbGDrS5Q7GLNt3kQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yW75kvZEoV+UoryZy5nutpVrdTdfKrZylBloJVNcdBKnrm/bTfmro8iuK+493oP2s
	 nlWVzwEU3RJ6Tu6A/Q+h1esyk5F7uptmg+4VMz0nFGwPRY63sM+KyJ0QdxeBbBV0qi
	 yV08pwkr1E7N9P1Lhg7vw8qLRyzhcymj2WDrqHCU=
Date: Wed, 22 Nov 2023 13:39:44 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Vinicius Petrucci <vpetrucci@gmail.com>
Cc: linux-mm@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-api@vger.kernel.org, minchan@kernel.org, dave.hansen@linux.intel.com,
 x86@kernel.org, Jonathan.Cameron@huawei.com, aneesh.kumar@linux.ibm.com,
 gregory.price@memverge.com, ying.huang@intel.com, dan.j.williams@intel.com,
 hezhongkun.hzk@bytedance.com, fvdl@google.com, surenb@google.com,
 rientjes@google.com, hannes@cmpxchg.org, mhocko@suse.com,
 Hasan.Maruf@amd.com, jgroves@micron.com, ravis.opensrc@micron.com,
 sthanneeru@micron.com, emirakhur@micron.com, vtavarespetr@micron.com,
 Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC PATCH] mm/mbind: Introduce process_mbind() syscall for
 external memory binding
Message-Id: <20231122133944.297ce0001fb51214096dfb6c@linux-foundation.org>
In-Reply-To: <ZV5zGROLefrsEcHJ@r13-u19.micron.com>
References: <ZV5zGROLefrsEcHJ@r13-u19.micron.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Nov 2023 15:31:05 -0600 Vinicius Petrucci <vpetrucci@gmail.com> wrote:

> From: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
> 
> This patch introduces `process_mbind()` to enable a userspace orchestrator with 
> an understanding of another process's memory layout to alter its memory policy. 


I'm having deja vu.  Not 10 minutes ago, Gregory sent out a patchset
which does the same thing.

https://lkml.kernel.org/r/20231122211200.31620-1-gregory.price@memverge.com

Please share notes ;)

