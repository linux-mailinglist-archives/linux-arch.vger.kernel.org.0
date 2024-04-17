Return-Path: <linux-arch+bounces-3741-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6E48A80DF
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 12:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665EE281D27
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 10:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E5713B29C;
	Wed, 17 Apr 2024 10:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEFiqQxJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6612C13B280;
	Wed, 17 Apr 2024 10:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713349654; cv=none; b=E92uw+nj2Req4Q2Z8GClqKo4t++7slS1cu8EuZNQXhGZYFG5HoJjsfSBkYXZajyVDsdEi/hZdI6/wfWQqIM6La672V1FbMx1RoPPdfq15Gv0mYcab9lk4xL2ypm4xmT5geKwiNjYV4M9/NPxehWPkqLAovTD1rKSE+bfmrjBePw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713349654; c=relaxed/simple;
	bh=Kn55+1luOn7/FcJIZC3jmFgE9ttr5he8xI+XlEEncLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMzLjF6hPq4/fzQrju7tHcYqmykNmWOyq0THK2kBgoDDOZFVwR14KPpktAmtY1ne5qDoI4PMQcjhSzw1gAHubRazUN2VelUUixe5SjK6p/zgS2KXM72WtB+aIpHE4WP7/uioXEXEsIpxrmE0Lwa6A2e20rAWUH+ePxOuKNt5JvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEFiqQxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700D2C072AA;
	Wed, 17 Apr 2024 10:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713349653;
	bh=Kn55+1luOn7/FcJIZC3jmFgE9ttr5he8xI+XlEEncLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DEFiqQxJikBmYetX669hS5i6+49i3etN/k12je52FNMd3AEbvv6F/WNPUq4XpQdoH
	 Pey9pRqtiFJ6ZxfPQ423YXzhUgKPNN3izpgUPmfhSH392RRB8V2FKSTFmIHWgO2YDI
	 Sq617YCRsZmA0CIAvVcsIiUoP5kU0WivRAEhT+ltkgYR1Yee6GjwffBnzUIarIYMIK
	 E6qzV1Hnmi+O1f/Kfgb/q5y9fprLgHc72diHQ5D2U0BubxRr+HHAGUqHFRkVP4etDR
	 26iQbeBlx0rNDDsiSS9E06RKRgp8VGfBsjSIy0CC0K2Pul/0wqDpMY2iFVuSYryWRk
	 Peq5m7BlJk+Uw==
Date: Wed, 17 Apr 2024 12:27:30 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
	Ingo Molnar <mingo@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2 RESEND 0/5] sched/vtime: vtime.h headers cleanup
Message-ID: <Zh-kEvJbNR2krwmx@localhost.localdomain>
References: <cover.1712760275.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1712760275.git.agordeev@linux.ibm.com>

Le Wed, Apr 10, 2024 at 05:09:43PM +0200, Alexander Gordeev a écrit :
> Hi All,
> 
> There are no changes since the last post, just a re-send.
> 
> v2:
> - patch 4: commit message reworded (Heiko)
> - patch 5: vtime.h is removed from Kbuild scripts (PowerPC only) (Heiko)
> 
> v1:
> Please find a small cleanup to vtime_task_switch() wiring.
> I split it into smaller patches to allow separate PowerPC
> vs s390 reviews. Otherwise patches 2+3 and 4+5 could have
> been merged.
> 
> I tested it on s390 and compile-tested it on 32- and 64-bit
> PowerPC and few other major architectures only, but it is
> only of concern for CONFIG_VIRT_CPU_ACCOUNTING_NATIVE-capable
> ones (AFAICT).
> 
> Thanks!

It probably makes sense to apply the whole series to the scheduler tree.
Does any powerpc or s390 maintainer oppose to that?

Thanks.

> 
> 
> Alexander Gordeev (5):
>   sched/vtime: remove confusing arch_vtime_task_switch() declaration
>   sched/vtime: get rid of generic vtime_task_switch() implementation
>   s390/vtime: remove unused __ARCH_HAS_VTIME_TASK_SWITCH leftover
>   s390/irq,nmi: include <asm/vtime.h> header directly
>   sched/vtime: do not include <asm/vtime.h> header
> 
>  arch/powerpc/include/asm/Kbuild    |  1 -
>  arch/powerpc/include/asm/cputime.h | 13 -------------
>  arch/powerpc/kernel/time.c         | 22 ++++++++++++++++++++++
>  arch/s390/include/asm/vtime.h      |  2 --
>  arch/s390/kernel/irq.c             |  1 +
>  arch/s390/kernel/nmi.c             |  1 +
>  include/asm-generic/vtime.h        |  1 -
>  include/linux/vtime.h              |  5 -----
>  kernel/sched/cputime.c             | 13 -------------
>  9 files changed, 24 insertions(+), 35 deletions(-)
>  delete mode 100644 include/asm-generic/vtime.h
> 
> -- 
> 2.40.1
> 

