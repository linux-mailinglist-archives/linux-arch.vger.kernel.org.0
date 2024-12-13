Return-Path: <linux-arch+bounces-9377-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969019F031F
	for <lists+linux-arch@lfdr.de>; Fri, 13 Dec 2024 04:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61ED285C67
	for <lists+linux-arch@lfdr.de>; Fri, 13 Dec 2024 03:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF5D149C53;
	Fri, 13 Dec 2024 03:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QyWoHagh"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982A92A1BB;
	Fri, 13 Dec 2024 03:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734060943; cv=none; b=JL+EqmkYtTrcRSmUtayFDdKFghn17pq7YF/AnLsq+JqfoHA84SrL0mcKI87UCDDxGC3QrX2G2pAnRfSGaXsK0L9xLXTR6Cm3vfEqmqevDZOKCI6SWjmEy/oNdtA9Tn196pJhBOqwcRbEOdbJPlzR5a4IRmLPk6v9i3I9kV+zvfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734060943; c=relaxed/simple;
	bh=G5QCpdwYGh2Mz5KQh/GEBZ3avnRe8+3shrENbKK+BqM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pxHQpcEWVExbRwerZTsygfMOMBbiD/XOKls8JHXCzmrMH3aR7023J99nlwpM+1GiN3P9ia3OYJHTdzqmuSxd6S6iB/h4G0S1cSFfdZo/br2/M5y7KO+Fa7zbPL5D79VwCAPXx9qbxxXLx/kMMn+FIa/u95YEov3pBsyKu7WbkCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QyWoHagh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E6AC4CED2;
	Fri, 13 Dec 2024 03:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1734060943;
	bh=G5QCpdwYGh2Mz5KQh/GEBZ3avnRe8+3shrENbKK+BqM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QyWoHaghKaBJMZSboGpGE58nH3S5ZEEujrVnb0wgtQyw9BC/gKWq/FyMhivsws231
	 pRIQSxxAhdiFl9C2S1VAz05O7+gIE0NNcL0j3ZwugWY5M+NLG07wd8xGiLenH84Tps
	 nbaUNN1CO5MZ6Pv3RKUltq3pxdiWsueMyTWUoKjc=
Date: Thu, 12 Dec 2024 19:35:41 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, linux-arch@vger.kernel.org,
 netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Dennis Zhou
 <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter
 <cl@linux.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andy
 Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Nadav Amit
 <nadav.amit@gmail.com>, Brian Gerst <brgerst@gmail.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, "H . Peter Anvin" <hpa@zytor.com>, Peter
 Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 0/6] Enable strict percpu address space checks
Message-Id: <20241212193541.fa3dcac867421a971c38135c@linux-foundation.org>
In-Reply-To: <20241208204708.3742696-1-ubizjak@gmail.com>
References: <20241208204708.3742696-1-ubizjak@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  8 Dec 2024 21:45:15 +0100 Uros Bizjak <ubizjak@gmail.com> wrote:

> Enable strict percpu address space checks via x86 named address space
> qualifiers. Percpu variables are declared in __seg_gs/__seg_fs named
> AS and kept named AS qualified until they are dereferenced via percpu
> accessor. This approach enables various compiler checks for
> cross-namespace variable assignments.
> 
> Please note that current version of sparse doesn't know anything about
> __typeof_unqual__() operator. Avoid the usage of __typeof_unqual__()
> when sparse checking is active to prevent sparse errors with unknowing
> keyword. The proposed patch by Dan Carpenter to implement
> __typeof_unqual__() handling in sparse is located at:

google("what the hell is typeof_unequal") failed me.

I think it would be nice to include within the changelog (and code
comments!) an explanation-for-others of what this thing is and why
anyone would want to use it.  Rather than assuming that all kernel
developers are typeof() experts!


