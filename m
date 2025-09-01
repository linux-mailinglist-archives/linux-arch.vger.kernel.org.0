Return-Path: <linux-arch+bounces-13349-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C8BB3E205
	for <lists+linux-arch@lfdr.de>; Mon,  1 Sep 2025 13:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28FB64E279A
	for <lists+linux-arch@lfdr.de>; Mon,  1 Sep 2025 11:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5004231DDAF;
	Mon,  1 Sep 2025 11:48:00 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A85031DDA0;
	Mon,  1 Sep 2025 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756727280; cv=none; b=IWX/3T8TNDMxBVsWZyjqdCGJ7xT8Wj8yvc8I0AXxafxPa3rKg0BEE4V98DV5QPItg0Lae5vXV1LmFdX8X7T0tJdXY9q6sNKQgI2ihzbPbLDLa4+v6Y5SeTdEaW6tC+dyf1aSHmcCUjxIpSO+tzh03p2GS+ep5IfoPCof4lGJ7s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756727280; c=relaxed/simple;
	bh=zy3+4GXehIyGKxZynwV7inAzyAIj+YKgJ6SO7/0fBXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqRlZ6OKHxEfN/BmiVqVA7sZ/QKtGTSqOL/FDcB4uVJHeXo3U0JXed3dPStLnaiC2EsPTYOdiAiLEIhcW+SS11PF6Pjf1a42kWE7WF9FKylCNgmh5V3hTssG9E//bx4W+QNgv3dSXrF7oSBKYY9ZZFSK03ekfAddYKJVg6OXg2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE296C4CEF0;
	Mon,  1 Sep 2025 11:47:56 +0000 (UTC)
Date: Mon, 1 Sep 2025 12:47:54 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	arnd@arndb.de, will@kernel.org, peterz@infradead.org,
	akpm@linux-foundation.org, mark.rutland@arm.com,
	harisokn@amazon.com, cl@gentwo.org, ast@kernel.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v4 4/5] asm-generic: barrier: Add
 smp_cond_load_acquire_timewait()
Message-ID: <aLWH6ilDfz2ZgmNL@arm.com>
References: <20250829080735.3598416-1-ankur.a.arora@oracle.com>
 <20250829080735.3598416-5-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829080735.3598416-5-ankur.a.arora@oracle.com>

On Fri, Aug 29, 2025 at 01:07:34AM -0700, Ankur Arora wrote:
> Add the acquire variant of smp_cond_load_relaxed_timewait(). This
> reuses the relaxed variant, with an additional LOAD->LOAD
> ordering.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

