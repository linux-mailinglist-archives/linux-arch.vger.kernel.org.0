Return-Path: <linux-arch+bounces-5504-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8106793703A
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 23:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287062825A6
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 21:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB04145B13;
	Thu, 18 Jul 2024 21:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="U+I4x50K"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450507FBAC
	for <linux-arch@vger.kernel.org>; Thu, 18 Jul 2024 21:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721339185; cv=none; b=nf9LFEWE3kYfGNIPPH0a6DSpT/ngJjXI2KGTOTM9w5z1kr5jj2Pl5bsC5i6VJpThW6y6dAn0A1QL7qgKWv5/u8r3GHh3ZwDh6b5Xc76bv6j6oCQeqDPEmdX5h/RxoS50UYvx/dPyf3zBQSnpveiep+U70AF/SyC30w9F6R2jTHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721339185; c=relaxed/simple;
	bh=QIe/2kbFHCA11Q9TL7mLMduOjYNsGQd/Tv+tn4jIdAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oyw5vbXbtYM3Yw776fPfo0GomzEIlVa+yc38nJkgjEkJqtfmKMpnu2AUYodcSCUQayVIIJlTXOpiP61MyHAGh5O11ycQFUxobP5JZc/tQdQrcnkEg6uBTqasnqxHimOYkXyXLWAII3lbAasZuNIzFhYIqEujOG/EEVikQojIZKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=U+I4x50K; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7eee7728b00so51089239f.3
        for <linux-arch@vger.kernel.org>; Thu, 18 Jul 2024 14:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721339181; x=1721943981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b/3KVXgmf69sNo7YCAFBU75fVyP3kLvsv8BGm2iEjzc=;
        b=U+I4x50KPl4X8RHNN5WKXgaZlEHjW1XglGeBCiLPeDrA3B+KPiBhvahd+FDuWPjb3+
         87XEXsm4pfnSHwtps3MIP+TEfZCsdspc+yTjRy2CuGXrEoam95Al6g0CygaBSnC7ExCA
         RyHihQX9Zo7+MvnRzEr8pj4uCXjohr23/SwVBcsrkRfsRX2fqDkhdWkK11O/eSelP+eL
         /d3uDT3c4Ryb2bL0kMYavtCuYoMYn2E5sOc6EGM3M2zuFmF625pNWCLDfHfN8m1dypcR
         YCbJlYmcrqMljxJYDSm/J4J+WSao69397c5/M406TScUTHCJTPHsBmberRIPN7VbEQzd
         3+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721339181; x=1721943981;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/3KVXgmf69sNo7YCAFBU75fVyP3kLvsv8BGm2iEjzc=;
        b=OBlc9kMiBgulHthRWKMz+Z/eX4/EHn5cGHrD6+0DQlms44iyLC5nArWIK1LLfLcWNG
         601SvRDRgRprUvBzvYPhvO9SOj4cdsRRRt/gDcPqEV2SwM1bEetrDum8M1Wk2lju56W5
         DTV4gbdouQtwafrybTSao7nS4wx3pncTcRSet3YB5dpv/vulPp37ik4XI7ZS10/UQ1Kb
         kvx4S+dT9+Rw4Nav/vUNjnzRWy1azgrmbPH8E+OonHxt2qIBblT/xsGmbPyeQTBRArlE
         I4oFbR7Nw/c4NX9DMFNLHUFAtbTLUbrfh/BcRDsh4K0cKlY89G7k80HBuAjQ6TKAe2Cj
         piwA==
X-Forwarded-Encrypted: i=1; AJvYcCUJid1VCzlmt8jo+aC2K+6oQiRZjAcHGBOrV8vFTFZEjKk2u9nobiXe0L3tnSzE/dwTto4YSKK4tZg712Qk1SmXFCwQG3AWXbpVzg==
X-Gm-Message-State: AOJu0Ywq6DfMJIbX0LoLNi50Hl9X5NRcOZ1y1QxIcbJzA3Y60iGvDfJ4
	zybQYv29c+DeTjt8eG0khxslmfho+o+j5b/47h9XIJz1c5yV/QhN6DKKuXHBWU0=
X-Google-Smtp-Source: AGHT+IFfmYe/UsMSfgkCsdMUFOYZdCp937Ia8bMlaDCUPuHT0PtpOJmSb9jac6FVvVir80F2WXRXbQ==
X-Received: by 2002:a05:6602:26c7:b0:806:7f5a:1fb7 with SMTP id ca18e2360f4ac-81710605dacmr801576939f.5.1721339181354;
        Thu, 18 Jul 2024 14:46:21 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c2342f164esm35433173.69.2024.07.18.14.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 14:46:20 -0700 (PDT)
Message-ID: <8b402e92-d874-4b30-9108-f521bd20d36c@sifive.com>
Date: Thu, 18 Jul 2024 16:46:17 -0500
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/17] mm: move numa_distance and related code from x86 to
 numa_memblks
To: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dan Williams <dan.j.williams@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt <palmer@dabbelt.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org,
 x86@kernel.org
References: <20240716111346.3676969-1-rppt@kernel.org>
 <20240716111346.3676969-14-rppt@kernel.org>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20240716111346.3676969-14-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-07-16 6:13 AM, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Move code dealing with numa_distance array from arch/x86 to
> mm/numa_memblks.c
> 
> This code will be later reused by arch_numa.
> 
> No functional changes.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/x86/mm/numa.c                   | 101 ---------------------------
>  arch/x86/mm/numa_internal.h          |   2 -
>  include/linux/numa_memblks.h         |   4 ++
>  {arch/x86/mm => mm}/numa_emulation.c |   0
>  mm/numa_memblks.c                    | 101 +++++++++++++++++++++++++++
>  5 files changed, 105 insertions(+), 103 deletions(-)
>  rename {arch/x86/mm => mm}/numa_emulation.c (100%)

The numa_emulation.c rename looks like it should be part of the next commit, not
this one.


