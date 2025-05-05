Return-Path: <linux-arch+bounces-11849-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD8EAA98B2
	for <lists+linux-arch@lfdr.de>; Mon,  5 May 2025 18:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2811886770
	for <lists+linux-arch@lfdr.de>; Mon,  5 May 2025 16:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620BB1A2632;
	Mon,  5 May 2025 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="UKh9OIYn"
X-Original-To: linux-arch@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE374A1D;
	Mon,  5 May 2025 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462092; cv=none; b=beA3t5aj1DW+HfdcrhMwio7CeA0yRMMlYWNewRkIg4jrbz4UfPvzCgNl8cUQrhklDpwZ9xV5GXbMjx1jSmIYStRvWvflZIVBhLHFwKl2zdc/gUPIHRpi02Vv0+gkns6skNDV8XDtG0P1bNupFI9rwqTJrmw4810HUbAMUK1NOnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462092; c=relaxed/simple;
	bh=OiExT28N928KJxGOvNnkBz7+WgsXz97GUgdO7yEN+nc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=F+383EGKJk27HCXioHl9X9hmLf8Vf8kPduL7X095wNXCRhM8dgepsa7aR6JS7Gwfu9xXnTKH3XpPjyXatRGyEWHuM6ru69Tor8uCQW2N1m0WbyDgS9cb4sVs7YxoirxW1mQQNPgqujl2hUrEmTfAp6vydImdkYVEv9MS6UoYRws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=UKh9OIYn; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1746461581;
	bh=OiExT28N928KJxGOvNnkBz7+WgsXz97GUgdO7yEN+nc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=UKh9OIYnlHsOqDjy64J8Ie5+AZcUrPHcGUbWQZoMgc7+Js0vChscbme0LC1cirPWx
	 hrx1NfqO3SBkv6VTDcx9k2ES4EyOUk8tTjQSRfFuBTgXReFIashdsssQpqg7u62DSA
	 2gE+4scUEKjYuw7T7bzJtKsdywjeYxV/LsUaIJEY=
Received: by gentwo.org (Postfix, from userid 1003)
	id 39FE2401EB; Mon,  5 May 2025 09:13:01 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 3728C401C4;
	Mon,  5 May 2025 09:13:01 -0700 (PDT)
Date: Mon, 5 May 2025 09:13:01 -0700 (PDT)
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
In-Reply-To: <87selmok1y.fsf@oracle.com>
Message-ID: <6181ff8b-bb81-4dd0-f8ec-0f9d0944885e@gentwo.org>
References: <20250502085223.1316925-1-ankur.a.arora@oracle.com> <a85fbebe-aa44-5ca0-f8ad-f997ea7e6622@gentwo.org> <87selmok1y.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 2 May 2025, Ankur Arora wrote:

> AFAICT the vast majority of arm64 processors in the wild don't yet
> support WFET. For instance I haven't been able to find a single one
> to test my WFET changes with ;).

Ok then for patch 1-6:

Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>


