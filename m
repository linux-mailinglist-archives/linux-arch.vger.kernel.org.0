Return-Path: <linux-arch+bounces-11803-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA8EAA7781
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 18:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D8B37B43F1
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 16:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797F525F7B2;
	Fri,  2 May 2025 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="gWGsNIyz"
X-Original-To: linux-arch@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8BC25E456;
	Fri,  2 May 2025 16:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746204151; cv=none; b=I4S2NHdY/wGvxKpSmpotLSowSEuqCPygecamrPwHJLH6z71BoIlsv5qXGGCJfJVdavWX7w0DG5rjxLQ0+tF0LMewS/MlZSCOcEh14zR1RV97Yk33qlrJ8o9R5p816VqrNFwkUS+dkB6C+4fH2hCkTWyHbfd1w1K12/OpaGeHiXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746204151; c=relaxed/simple;
	bh=mJseQM4e940ZC+UI+S/KGZQbAf1JWqMo50qReiY9IO4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ieB2kbljfmZjswSXcD0yE0FePTtT58FP2RqqXMNv0JUw7z10sshmlW7FjnshGDoBQ72yxCbFs/bLESSNPsTC1mfF2ZBWrh7Wk7LT5T1DX08ghFUMHX9T5mzs7IB6XMzNPbt3h1Tj+v4vfyFWJAOzGW9KOIgnIj1vvoCgzLcBhjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=gWGsNIyz; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1746204142;
	bh=mJseQM4e940ZC+UI+S/KGZQbAf1JWqMo50qReiY9IO4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=gWGsNIyzDi264sy/by+Q+afF1WXzomrn2/+MHKOv05VJT5nXJaYH4iLcmaUeVPMvS
	 6HB9K4T24iTRveE1mK03GkTsooA5cZ0p0x2Yc8GF6Y9nBukcfXxTJoFB1RZlqO31uI
	 DNHmdNbebq+E2INdiVT0Wj4dD9cMbEg10V32ywpI=
Received: by gentwo.org (Postfix, from userid 1003)
	id E39D9401E4; Fri,  2 May 2025 09:42:22 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id E0CE8401E1;
	Fri,  2 May 2025 09:42:22 -0700 (PDT)
Date: Fri, 2 May 2025 09:42:22 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, arnd@arndb.de, 
    catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org, 
    akpm@linux-foundation.org, mark.rutland@arm.com, harisokn@amazon.com, 
    ast@kernel.org, memxor@gmail.com, zhenglifeng1@huawei.com, 
    xueshuai@linux.alibaba.com, joao.m.martins@oracle.com, 
    boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v2 0/7] barrier: introduce smp_cond_load_*_timewait()
In-Reply-To: <20250502085223.1316925-1-ankur.a.arora@oracle.com>
Message-ID: <a85fbebe-aa44-5ca0-f8ad-f997ea7e6622@gentwo.org>
References: <20250502085223.1316925-1-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 2 May 2025, Ankur Arora wrote:

> smp_cond_load_relaxed_spinwait(ptr, cond_expr, time_expr_ns, time_limit_ns)
> took four arguments, with ptr and cond_expr doing the usual smp_cond_load()
> things and time_expr_ns and time_limit_ns being used to decide the
> terminating condition.
>
> There were some problems in the timekeeping:
>
> 1. How often do we do the (relatively expensive) time-check?

Is this really important? We have instructions that wait on an event and
terminate at cycle counter values like WFET on arm64

The case were we need to perform time checks is only needed if the
processor does not support WFET but must use a event stream or does not
even have that available.

So the best approach is to have a simple interface were we specify the
cycle count when the wait is to be terminated and where we can cover that
with one WFET instruction.

The other cases then are degenerate forms of that. If only WFE is
available then only use that if the timeout is larger than the event
stream granularity. Or if both are not available them do the relax /
loop thing.

So the interface could be much simpler:

   __smp_cond_load_relaxed_wait(ptr, timeout_cycle_count)

with a wrapper

   smp_cond_relaxed_wait_expr(ptr, expr, timeout cycle count)

where we check the expression too and retry if the expression is not true.

The fallbacks with the spins and relax logic would be architecture
specific.

