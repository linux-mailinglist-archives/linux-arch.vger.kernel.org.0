Return-Path: <linux-arch+bounces-14610-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2145C4840A
	for <lists+linux-arch@lfdr.de>; Mon, 10 Nov 2025 18:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5F13ADAF6
	for <lists+linux-arch@lfdr.de>; Mon, 10 Nov 2025 17:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3EE28CF66;
	Mon, 10 Nov 2025 17:07:49 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B421482F2;
	Mon, 10 Nov 2025 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762794469; cv=none; b=dVYNt4K22J9syhn4BGvqETwDPB4eJ2KjCn1Z69aVAQUS9N0HlRsKUkWTef7VEV3vUbZgSEPuWSyAZBGeW9NFSsT33P66k7Bqf7IlZEj3c0V8Sf+9PZbF1icL00menSAxkMo9jUYyZDb3VwM4tJFb4ZFiHTlxaGXeGTyrwsOAi8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762794469; c=relaxed/simple;
	bh=dhwFoVZH855sNNnvFr+kUywoBgmhfc5p6zynI771LDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/h/KzyVV6ubmh3P7CcwSnCkR16uYqvqLu2YVte9XZJ45d0aWugOh3H47+zfiA7IN+sI+2mJVFD3HU5X4w14FyPoEGsccYPn+BT6wQ40vzwOIc0yPXjMjewJjiAF/VWaC9fnyztwxcXjOiF90iLprpLcKyVgIKulojVpkWybtz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D6522B;
	Mon, 10 Nov 2025 09:07:39 -0800 (PST)
Received: from [10.57.39.147] (unknown [10.57.39.147])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 305613F66E;
	Mon, 10 Nov 2025 09:07:44 -0800 (PST)
Message-ID: <5fdb6952-ebfd-4a12-b372-04229763579b@arm.com>
Date: Mon, 10 Nov 2025 18:07:41 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm: Remove unnecessary __GFP_HIGHMEM in
 __p*d_alloc_one_*()
To: Huacai Chen <chenhuacai@loongson.cn>, Huacai Chen
 <chenhuacai@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Vishal Moola <vishal.moola@gmail.com>,
 Jan Kara <jack@suse.cz>, linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251109021817.346181-1-chenhuacai@loongson.cn>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20251109021817.346181-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/11/2025 02:18, Huacai Chen wrote:
> __{pgd,p4d,pud,pmd,pte}_alloc_one_*() always allocate pages with GFP
> flag GFP_PGTABLE_KERNEL/GFP_PGTABLE_USER. These two macros are defined
> as follows:
>
>  #define GFP_PGTABLE_KERNEL	(GFP_KERNEL | __GFP_ZERO)
>  #define GFP_PGTABLE_USER	(GFP_PGTABLE_KERNEL | __GFP_ACCOUNT)
>
> There is no __GFP_HIGHMEM in them, so we needn't to clear __GFP_HIGHMEM

Nit: "needn't clear" (or simply "don't need to")

> explicitly.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

- Kevin

