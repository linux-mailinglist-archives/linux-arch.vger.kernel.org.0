Return-Path: <linux-arch+bounces-9448-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 157369F90CB
	for <lists+linux-arch@lfdr.de>; Fri, 20 Dec 2024 11:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C29C1881327
	for <lists+linux-arch@lfdr.de>; Fri, 20 Dec 2024 10:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07E91BEF63;
	Fri, 20 Dec 2024 10:58:21 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC14A1ABEB7;
	Fri, 20 Dec 2024 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734692301; cv=none; b=hHmzX/BicmrECwVQ1DtAjyyksNspS6kt3VX4yVhJp9FXdsLE2Je2jtH+uOPw/0rnoHAYng0Bij2EInCquXkQVDWL1ozR9ooC8UEj7xzuGTmDMCeIr6m7tTJwn2g6MyMT0pSA/5Yg9ePMgLqXamVSYyl4ssS9UQZl4lwQpbFsTyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734692301; c=relaxed/simple;
	bh=zBx2G/uyr1DsWaYTCu2FJk2j9r8nBvoTt83AewYBXVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O008qeacho8fHfzmV4UhgRnK56iTF/TXmNEG9TZyyxTitrm1xDDZTT+LiH3UuoOiFXeIzydYuwZETFzzBPhOrELiO6Wy4z50PJwqgforpegEr2Yh7pPNau5/kodSehwUK2GF63cHZky/v3xTlk4/XQPkd5fKxj2leze+aG8GQoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DDC71480;
	Fri, 20 Dec 2024 02:58:47 -0800 (PST)
Received: from [10.57.72.191] (unknown [10.57.72.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0C613F58B;
	Fri, 20 Dec 2024 02:58:10 -0800 (PST)
Message-ID: <765aec36-55a4-4161-bb30-4ff838bc2d98@arm.com>
Date: Fri, 20 Dec 2024 11:58:08 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] Account page tables at all levels
To: Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, linux-alpha@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-um@lists.infradead.org, loongarch@lists.linux.dev, x86@kernel.org
References: <20241219164425.2277022-1-kevin.brodsky@arm.com>
 <a7398426-56d1-40b4-a1c9-40ae8c8a4b4b@intel.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <a7398426-56d1-40b4-a1c9-40ae8c8a4b4b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/12/2024 18:13, Dave Hansen wrote:
> On 12/19/24 08:44, Kevin Brodsky wrote:
>>   +---------------+-------------------------+-----------------------+--------------+------------------------------------+
>>   | x86           | Y                       | Y                     | Y/N          | kmem_cache at pgd level if PAE     |
>>   +---------------+-------------------------+-----------------------+--------------+------------------------------------+
> This is a really rare series that adds functionality _and_ removes code
> overall. It looks really good to me. The x86 implementation seems to be
> captured just fine in the generic one:

Thank you for the review, very appreciated!

> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Just to double-check, are your ack'ing the x86 changes specifically? If
so I'll add your Acked-by on patch 6, 7 and 9.

> One super tiny nit is that the PAE pgd _can_ be allocated using
> __get_free_pages(). It was originally there for Xen, but I think it's
> being used for PTI only at this point and the comments are wrong-ish.
>
> I kinda think we should just get rid of the 32-bit kmem_cache entirely.

That would certainly simplify things on the x86 side! I'm not at all
familiar with that code though, would you be happy with providing a
patch? I could add it to this series if that's convenient.

- Kevin

