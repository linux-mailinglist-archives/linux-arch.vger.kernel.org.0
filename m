Return-Path: <linux-arch+bounces-13099-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22187B1F851
	for <lists+linux-arch@lfdr.de>; Sun, 10 Aug 2025 06:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D183B9B1D
	for <lists+linux-arch@lfdr.de>; Sun, 10 Aug 2025 04:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D698284A35;
	Sun, 10 Aug 2025 04:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w+V9x+PR"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EF02AEFD
	for <linux-arch@vger.kernel.org>; Sun, 10 Aug 2025 04:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754800438; cv=none; b=pum/HUwHzamLPkVI+vUm5QiDT0V9m74X5KBxz5gS3642ncrGcPyDOmacdOnbqwcCX2LxiNZsD5bXa3atUbgxCr/PT7eQ0fDoGTfn602d67b10A1vl9keiqYDDIw3jtE7C7FBTGyRqrAKtEJcKBZXrTO3aQTn95hl5K8NCIaL9OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754800438; c=relaxed/simple;
	bh=+ow+1NREKSc8fRztHEQX8KuMTiFIaRfqWbJt8HpuMgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b8K6RvnemFW7lmP4ojJtuM499RJPMfz8ATGNiSGgPhqzgfGAA1r1qTgojEITA04twLO/ekguTwZRbOngF3sEY92t9VSNeU5wrI0sH78Bo8OZIeTuC8z9X2Td3QjbciHG/IUUVDkdUbiKIjqkFmyfvzDmXwNHUYH8v6ECIIbYcSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w+V9x+PR; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754800433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0fgAIJfjOAMkD0Mb7Qr9ANhRFOd7/k4gDrAS8zFFIbc=;
	b=w+V9x+PRRzC8ieyGtoDYJLAWiNEwE48DpIS76QpOBhgWDpa0csnXHRiUlZj6Ypbj2kKv3r
	16JiatnLvcmFAitS3ufI3wyDwixLibdA4FB2hjVBB/ECBUe7B2sK3K23xwcEELwPFsjLqF
	XqjJKOz1erySFVdOZq4qx1PwfEP6lnk=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: johannes@sipsolutions.net
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: Re: [PATCH 9/9] um: Add initial SMP support
Date: Sun, 10 Aug 2025 12:33:34 +0800
Message-Id: <20250810043334.530444-1-tiwei.bie@linux.dev>
In-Reply-To: <20250730041838.1821401-1-tiwei.bie@linux.dev>
References: <20250730041838.1821401-1-tiwei.bie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Wed, 30 Jul 2025 12:18:38 +0800, Tiwei Bie wrote:
> On Tue, 29 Jul 2025 17:37:24 +0200, Johannes Berg wrote:
[...]
> > 
> > IOW, I think you've stumbled across an inconsistency in the generic
> > files, and hence we should fix that, rather than having each
> > architecture paper over it.
> 
> That does make sense. I will prepare a patch for that. Thanks!

Hmm, this issue might be a bit tricky to resolve.. The root cause
is that smp_cond_load_relaxed() provided by asm/barrier.h relies
on cpu_relax() [1][2], but the corresponding header isn't included.
The reason why it's not included might be that asm/processor.h
includes too many dependencies, which prevents barrier.h from
including it. I haven't come up with an ideal way to address it
yet. Fortunately, smp_cond_load_relaxed() is a macro, so cpu_relax()
is needed only when smp_cond_load_relaxed() is invoked inside a
function (i.e., when it's expanded during preprocessing).

As for this series, I realized that I should implement spinlock in
$SUBARCH (i.e., in a $SUBARCH native way, which won't require the
above workaround anymore), similar to how atomic and barrier are
implemented. I'll take that approach in the next version.

Thanks again for the review!

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/asm-generic/barrier.h?h=v6.16#n253
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/um/asm/barrier.h?h=v6.16#n27

Regards,
Tiwei

