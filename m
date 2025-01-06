Return-Path: <linux-arch+bounces-9597-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA20EA020FC
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jan 2025 09:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 483447A2A46
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jan 2025 08:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F68B1D5CD9;
	Mon,  6 Jan 2025 08:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NFsLUn+3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5358118B46E
	for <linux-arch@vger.kernel.org>; Mon,  6 Jan 2025 08:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736152728; cv=none; b=FmqPNF44FS4jGyhq2NYpcbEaObwxqPqOU9CPMM0p5fazj045yKzp6sTyrMF+SkNw3wRhU02KkNR6JyuTeMpOKcNRksnO4AMoxH3xN7bUsEeVkh5XQVC/JagFUae50AbAxSgPlgMHZ5sR4UOsnQ5HAPfJg0WZsg5YThv347gPbWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736152728; c=relaxed/simple;
	bh=+p2WuEDH6YSUra8No0eTrFef4hHj25RtnE5OhVgbkBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kRYS4OMqAUcXTBpebYGwDZ5KgGM5FWrK3sAuYQLoFhyvki24Nr1VLDszL+JQRhee1JIN4JWMKQpTleXtAA+euqJBHP+cJbWvIAxO5QmcOP6v3hU4BbsEXY5+hJLdmqCbXSUHH9aeLOYxlMBs2ddMbYYE9D/k3ckpaXv//SGXt6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NFsLUn+3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2165cb60719so204181275ad.0
        for <linux-arch@vger.kernel.org>; Mon, 06 Jan 2025 00:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736152725; x=1736757525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YiOAOk5kGRx9rmUPaHmWdeff0Y5xhlY6UwwEsQqm8Hw=;
        b=NFsLUn+3yEM2FDTjs/PJX3tSiRKo819ajchol7CEUEIqTKnnIetUFjv7UyKk9Xv0ET
         q7aG6uRRbHIpX+KcVjhoJ1Emnprv+3yQxZQXGOSnF1LI+OvH3WEF2pf7QwtTCu8uLjjn
         9jW/akY85hecYcHCRchRcsstDpum6+k4TsAU+hM9A7kjJtE4PiLS+Fm0mQfqZrmCKFTu
         crVPszzp3SRiel79bd/whBbXsp+IsYr7N8tCTRHLahdnVCe71ujvrd6wRyPCcGQ0sQ6U
         xnTifguMp98uznuCkMH4eyl3EokFEp3ndOhqdaqtGP9P6UVtEG7l5et861Y6tt6TQnpe
         Jhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736152725; x=1736757525;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YiOAOk5kGRx9rmUPaHmWdeff0Y5xhlY6UwwEsQqm8Hw=;
        b=WK8Ek17ozI3pQJyaktJeAgsLLKv1OyIkAonBjAnroMUar/MvKrf51AT/629TQlO/TF
         fHFn9d1ykEDgRflT4GgGGrUCrI9ADwWETEEnoq+gToCy+DXHULPqXhGBoIpnFp5ZSh0I
         FyPSN2yZF3rrlqiqI1FNFpzvgBFrnUJtSki4fN6LW6ZaECUVjBPhfITPuHYFjUGlFAhY
         1xoEgeUH471rVLNUkFM9LemPLi6WOcKZBFnBBpovn+OIA0dFPDErmtoHVImnqtBr8hhI
         hEyfDIvq4sCnnhNHXcoNMGOqCvb7iP7acmn7n9cN39mca8e/ZzQcimiq2HhRJR3SyXkF
         dtgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjsBLOfxpItH5jNKWQG9Paa0b2iZR0B46O6Jnb6LVTCu8ENdPiLUvVTKI1iYkwGJPg/tlLJFASttaD@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5pY/+vFhGFv/8noYlKLOd7DEvILF5KJ3EWLg7xCYnR81jrnXl
	yIV7rmuYOLt8EsLBQP5EPJT/EIw9cQPd77WGCsWjaybYFRl5y2PjMONnQ4koQQ4=
X-Gm-Gg: ASbGncv9hTmC2Uq91Xn+rAg0ZXFH3cEqjblcrgWX92E/A21hnuLvLCcTTMGn6JC1Yp6
	Vhyocmt2ptzU+XTkuNlpL/xI01EgJyb4CfHEWrxWUWzUElUwMKn6s4YQ84Ktq0ql5b8t3GWLl1m
	hJk4KHH1zHP0J9iop4ynDeqcv6GfRl7g0kPHVgb95gSYA4e3pDPR0Hp2WKuaIPrFGN6AGc9xeOQ
	st/6ifi0c7tISdJU4GgEu+XJCzwCt7r1jsQTykNZJeiHxjDflbJl/ZyIYqxoZ9xvATn8jyJ0ajv
	GW2y1Q==
X-Google-Smtp-Source: AGHT+IGUVd4iqCCZ9lciazZSWpc6AL/Za8b2BM7ngUBHt9ys8AcRhMXZRUNC6JrwIwMnpr/5pGC4Lg==
X-Received: by 2002:a17:903:234c:b0:215:5a53:edee with SMTP id d9443c01a7336-219e6e85b25mr837178605ad.9.1736152725600;
        Mon, 06 Jan 2025 00:38:45 -0800 (PST)
Received: from [10.84.148.23] ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f5087sm282364745ad.202.2025.01.06.00.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 00:38:45 -0800 (PST)
Message-ID: <ae8aa8d7-4121-4939-9890-c54e0aee7896@bytedance.com>
Date: Mon, 6 Jan 2025 16:38:32 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Account page tables at all levels
Content-Language: en-US
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
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
References: <20250103184415.2744423-1-kevin.brodsky@arm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20250103184415.2744423-1-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/1/4 02:44, Kevin Brodsky wrote:
> v1: https://lore.kernel.org/linux-mm/20241219164425.2277022-1-kevin.brodsky@arm.com/
> 
> This series should be considered in conjunction with Qi's series [1].
> Together, they ensure that page table ctor/dtor are called at all levels
> (PTE to PGD) and all architectures, where page tables are regular pages.
> Besides the improvement in accounting and general cleanup, this also
> create a single place where construction/destruction hooks can be called
> for all page tables, namely the now-generic pagetable_dtor() introduced
> by Qi, and __pagetable_ctor() introduced in this series.
> 
> v2 is essentially v1 rebased on top of mm-unstable, which includes Qi's
> v4 series. A number of patches from v1 were dropped:
> 
> * v1 patch 4 is superseded by patch 6 in Qi's series.
> * v1 patch 5 and 6 moved to Qi's series from v3 onwards.
> * v1 patch 7 is superseded by patch 4 in Qi's series.
> 
> Changes from v1 in the remaining patches:
> 
> * Patch 1 only introduces __pagetable_ctor() as there is now a single
>    generic pagetable_dtor().
> 
> * Patch 3 and 6: in arch/m68k/mm/motorola.c, free_pointer_table() can
>    now unconditionally call pagetable_dtor() since it is the same for all
>    levels.
> 
> * Patch 6 just uses pagetable_dtor() instead of introducing
>    pagetable_pgd_dtor().
> 
> * Added Dave Hansen's Acked-by to all patches.
> 
> - Kevin
> 
> [1] https://lore.kernel.org/linux-mm/cover.1735549103.git.zhengqi.arch@bytedance.com/
> ---
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Qi Zheng <zhengqi.arch@bytedance.com>
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-csky@vger.kernel.org
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-openrisc@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-um@lists.infradead.org
> Cc: loongarch@lists.linux.dev
> Cc: x86@kernel.org
> ---
> Kevin Brodsky (6):
>    mm: Move common part of pagetable_*_ctor to helper
>    parisc: mm: Ensure pagetable_pmd_[cd]tor are called
>    m68k: mm: Add calls to pagetable_pmd_[cd]tor
>    ARM: mm: Rename PGD helpers
>    asm-generic: pgalloc: Provide generic __pgd_{alloc,free}
>    mm: Introduce ctor/dtor at PGD level

For this series:

Acked-by: Qi Zheng <zhengqi.arch@bytedance.com>

Thanks!


