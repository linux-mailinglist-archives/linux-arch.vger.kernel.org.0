Return-Path: <linux-arch+bounces-6212-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0351C952939
	for <lists+linux-arch@lfdr.de>; Thu, 15 Aug 2024 08:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F1A51C21CD4
	for <lists+linux-arch@lfdr.de>; Thu, 15 Aug 2024 06:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C717E583;
	Thu, 15 Aug 2024 06:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnUjRseN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDA318D62D;
	Thu, 15 Aug 2024 06:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723702681; cv=none; b=lfT1ipO0DnNlkimqXafxeXA4R+sRRxIrwCf0DCPXjh8ocX2uoIFA0cGUKsQ1DXJrIBcbG+pc+CRV6khUK1PcUzhRPMMrvqcuxT9p1S5m8R+0KRy6qa9X7othTrMjoqPc0bfwsl/DPqRApFKVDP7yi68QUrbOuF66c431sJTRwP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723702681; c=relaxed/simple;
	bh=2ieEkSgkeeXHKQaOG4S/bYJ9as9XsQf3erKR7zsdkP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TtWLA+p7c5CeSqh+MmmZOEhQdGoavuJzDfLBn3PBX3oYenCtNVFYkWDQYm+kQgYyF54GjSDeA0oAbJzW5TQKnr1i/hsuNduUwXcCDmpfmmtsvWgp6d9qQacHcY1JXC8Zk7u2AZBLNTIYojhNOjVjfOOGjCMJYxO9vTS4dpdi5CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnUjRseN; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-27010ae9815so60505fac.2;
        Wed, 14 Aug 2024 23:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723702679; x=1724307479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SAHWmUt5jip0y+u22BsHFrHANReT/fLelSD2WuMjZ6U=;
        b=MnUjRseN2at0C+f7SKvEXTlEFcEiLibYTdDQpcMG/Kh6p6h7RJ29/sT1jRqOxBhSiQ
         wgYmio5VWFVo57F8o+wazVRbWVCpz8fQTkRmROKAeTu3jlmo/9VlZvCpk3wG03IsWpzm
         3NchaO0pK0gFm7hhcxZz1FSJS+dg1W/Sw4zgdsY9KUk6Z5xVT07z2fINjbqfdN4d8NIt
         tBKhDWNciZjp468v4ByiRVSV8wKjnisp9CVKfgPzrJdzL1vs7GIuD5yi/qX6U+phcIO1
         Au862rw5Pd+MTwrYmCD7Z6vSb77QA5ZVYv7sl8oZoq6gWfZQ8RF33eBjRbS3+/95qCB3
         c0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723702679; x=1724307479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAHWmUt5jip0y+u22BsHFrHANReT/fLelSD2WuMjZ6U=;
        b=DXI5hMZbHa9johpZcfmhczaf9bHQ6jvMUNnAChAF9pLNFkFS9xfBR5tUAp0FM+NaXt
         obR5zhQez19XxGtyDvKFmkzZ8XQrf4ZNFK1ei+6HXGY5pRDaUEEWZEPErYEwtVchxsDL
         Nivt5YdEH+OhYyL933+mxN1aULe8TRrrbRO0F726zQW15JaDDrSOEveoBGinZdwBS3MO
         D+3SeMDNR/zzeODMDB3jJpWi6VG5hiYhWHXyDpKAPCV/qnB5IwpcP3FK09nRUPrMJowg
         5wjL2h5eBlOmCQMXloCQQXD83ocrgsYa+NCO7EUsccc2wY3+cxLzPJKE7uhYt2YmNreY
         Rmng==
X-Forwarded-Encrypted: i=1; AJvYcCXY3t6/O9KS1X1KJ1i01nP75vbt24n1+SdFo1hQJ+adU5FJ9RiFF1nznWDBr3jge1bwwRlNmPv9U1QG/WZdiS2mPWAZ2OZ+87txN43rSjVBgBhGssXeE+HRtuObeGl/k7ZLJek3/tAIi0A2EHZNqUfIgaYX7mjV/bKKzQxkwh7yU6cpbcBbRPBsCFn3r2O0maUkcxTzdE8VhlBs3iapSmt/P7kaHp5xUGkaJtlplNJJBVru/0vELDOpikAIsaiq+kFOxOUU+jey+g8CvO5TignzEeMZRaEfEd6Hb1Fo2N4f
X-Gm-Message-State: AOJu0YzP1XsmyT/9EzEraGdOhpqu72aGH8XLWhEYCPVQUXJFPYTD9+wC
	SuBUByUd0zmouTIJ1opkeFl2RQsy9Dw+nIdlEQckbnxxUe21fu2n
X-Google-Smtp-Source: AGHT+IGJpazxnkj0vrfs0qcLRP6qpL8RKPrwMyfkdNMVp4bX1EZv/Ik/vGgVpgkEp8G6HmJcF19Ukw==
X-Received: by 2002:a05:6870:8a12:b0:258:3455:4b02 with SMTP id 586e51a60fabf-26fe5ca588amr5544755fac.51.1723702678720;
        Wed, 14 Aug 2024 23:17:58 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add6b3dsm479443b3a.8.2024.08.14.23.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 23:17:58 -0700 (PDT)
Message-ID: <02d7b8a2-b0d6-4713-b03e-5b22968387c3@gmail.com>
Date: Thu, 15 Aug 2024 14:17:45 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/18] use struct ptdesc to replace pgtable_t
To: Matthew Wilcox <willy@infradead.org>, alexs@kernel.org
Cc: Will Deacon <will@kernel.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Brian Cain <bcain@quicinc.com>,
 WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Naveen N Rao <naveen@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Bibo Mao <maobibo@loongson.cn>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Vishal Moola <vishal.moola@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Lance Yang <ioworker0@gmail.com>,
 Peter Xu <peterx@redhat.com>, Barry Song <baohua@kernel.org>,
 linux-s390@vger.kernel.org, Guo Ren <guoren@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>, Mike Rapoport <rppt@kernel.org>,
 Oscar Salvador <osalvador@suse.de>, Alexandre Ghiti
 <alexghiti@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>, Anup Patel
 <anup@brainfault.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Breno Leitao <leitao@debian.org>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20240730064712.3714387-1-alexs@kernel.org>
 <ZrzlnIWrnaUx66rY@casper.infradead.org>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <ZrzlnIWrnaUx66rY@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/15/24 1:13 AM, Matthew Wilcox wrote:
> On Tue, Jul 30, 2024 at 02:46:54PM +0800, alexs@kernel.org wrote:
>> We have struct ptdesc for page table descriptor a year ago, but it
>> has no much usages in kernel, while pgtable_t is used widely.
> 
> Hum, I thought I responded to this to point out the problem, but
> I don't see the response anywhere, so I'll try again.
> 
>> The pgtable_t is typedefed as 'pte_t *' in sparc, s390, powerpc and m68k
>> except SUN3, others archs are all same as 'struct page *'.
> 
> And there's a very good reason for that.  On s390 and powerpc (I cannot
> speak to the sparc/m68k), each page table is (potentially) smaller
> than PAGE_SIZE.  So we cannot do what your patch purports to do, as
> we would not know whether we're referring to the first or subsequent
> page tables contained within a page.
>> Maybe at some point in the distant future we'll be able to allocate
> a ptdesc per page table instead of per page allocated for use by page
> tables.  But we cannot do that yet.


Got it. Thanks a lot for the info!

