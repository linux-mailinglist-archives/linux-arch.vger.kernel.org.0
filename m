Return-Path: <linux-arch+bounces-14272-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB57ABFE041
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 21:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7354F3A3016
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 19:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0AE3370F5;
	Wed, 22 Oct 2025 19:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YFN8csLz"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B982EF64C;
	Wed, 22 Oct 2025 19:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160962; cv=none; b=TA+lAlRosHrYTZwZQJrrHQxGZ+S+AA8UjTZhmSFMmS6XXIvCleB0MJNyU0KpBk6yRM+rQbB6sYGpWtIHioTIU1d1nNiCwlDddry9kTZ268aASg4/SrGGtXAZ6XRx1FwNuJdWsT9oOvd/BXQm657Mtu1zJTJgRl9jMul2Lc0QGMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160962; c=relaxed/simple;
	bh=hQnzupzHHgSi4cofh0YJDQqv3isCGVIcYStvBh1mYXM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=H0ExVEfRIDRlRYOq01iVtOyDCpaeCYphchhvzWrX/b4FPu5tEWiSuwzABc6quMDaPHBN++Acz2mb/a8hcu9mNhPWEopTVu4k3TLQbdTgQK2lkr7TXIgBVk1VkJs7HdZep+Wmld9bOlGUBZlksAqJ0Tc06aZllaMWdTP6N+eq2TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YFN8csLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E000C4CEE7;
	Wed, 22 Oct 2025 19:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761160962;
	bh=hQnzupzHHgSi4cofh0YJDQqv3isCGVIcYStvBh1mYXM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YFN8csLzGHpCp1X+A3OFEYYmru95A84qxriKEZDIvqcO9DbY03YYDjGxsPFDMcyug
	 SH7fQU7WKReNKK+KIvM+6V3tHyX97UI34YaBI4kETmkAkXpexe4hFaeA4+09VR0TmH
	 ufb727p9iiRS6WiIKFXSVtYb8KTDO/LRkUoJLPEc=
Date: Wed, 22 Oct 2025 12:22:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Conor Dooley <conor@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, <linux-cxl@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-arch@vger.kernel.org>,
 <linux-mm@kvack.org>, Dan Williams <dan.j.williams@intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 <james.morse@arm.com>, Will Deacon <will@kernel.org>, Davidlohr Bueso
 <dave@stgolabs.net>, <linuxarm@huawei.com>, Yushan Wang
 <wangyushan12@huawei.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, Andy Lutomirski
 <luto@kernel.org>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v4 0/6] Cache coherency management subsystem
Message-Id: <20251022122241.d2aa0d7864f67112aa7691bf@linux-foundation.org>
In-Reply-To: <20251022113349.1711388-1-Jonathan.Cameron@huawei.com>
References: <20251022113349.1711388-1-Jonathan.Cameron@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 12:33:43 +0100 Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Support system level interfaces for cache maintenance as found on some
> ARM64 systems. This is needed for correct functionality during various
> forms of memory hotplug (e.g. CXL). Typical hardware has MMIO interface
> found via ACPI DSDT.
> 
> Includes parameter changes to cpu_cache_invalidate_memregion() but no
> functional changes for architectures that already support this call.

I see additions to lib/ so presumably there is an expectation that
other architectures might use this.

Please expand on this.  Any particular architectures in mind?  Any
words of wisdom which maintainers of those architectures might benefit
from?

> How to merge?  When this is ready to proceed (so subject to review
> feedback on this version), I'm not sure what the best route into the
> kernel is. Conor could take the lot via his tree for drivers/cache but
> the generic changes perhaps suggest it might be better if Andrew
> handles this?  Any merge conflicts in drivers/cache will be trivial
> build file stuff. Or maybe even take it throug one of the affected
> trees such as CXL.

Let's not split the series up.  Either CXL or COnor's tree is fine my
me.


