Return-Path: <linux-arch+bounces-7636-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364CB98E69A
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 01:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942B52815F2
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 23:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D36199929;
	Wed,  2 Oct 2024 23:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RWKGs3bS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0190E8286A;
	Wed,  2 Oct 2024 23:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727910692; cv=none; b=AhrhwWdbMyzV36whkrskm/IJQ5Lw6/1ZalIQxogA4ZXNd6GWWHM23LBLsnKgaIsL03XSG3qjBQwUMCDw+Mbdjtntn28telGBq1BH9Kf956vwqjQRDXPMXSVfI9Q+83SAwcsmcZHIMU01twV0i7Z2qclmttIGDd72O8defeXoOJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727910692; c=relaxed/simple;
	bh=nK1HJccHlPuB3nSLHcSWkaY3D97X47KrWdomQSrqRUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lH8jUXXUoJYv3+iemKKg9LVpFZ/mbwfr6TNjHA0ola1qSezvCfcwoakvlqOsuM+TpdRQROMTzJeDZWJjr1lpM8HILgOW015uNd/lVH9Y0I540Oy6EOUgeljKIWmIn+AC+V1MR4+0V1jG0v9Vlg4/owbUq/94zeA8KomiEq8sx1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RWKGs3bS; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727910691; x=1759446691;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nK1HJccHlPuB3nSLHcSWkaY3D97X47KrWdomQSrqRUY=;
  b=RWKGs3bSq5zx8I/iA+rSeAnFxR/g5tSvGF8dTL1DV1rpvYDlZ72BMfln
   kIF3x5mOg63eD/9X0pT8se/fdsqoQ4e8ggWi6oPW2VnbOtS3QN88PMHTc
   M5eB910V1jAKG/JYQmnruETC5VsXCdccaFlLijqeJ5XMAT2O6G24I/Oq3
   k5rQgY4yjC11DKHxqJ6HKexTTJWRC9G09LPBTbWfTXZ6m8Nnqjy17GtLO
   7ZDEYAvBT1S5pbgSnB59ExTL17zD0N1bb5eaA2ZJG8bTyrj/uytdfNND0
   JbvUdhbA1J8XvSojdFR1nbrGAYXW4r+uHGrid3EgFr65OUyaSk2IWsney
   Q==;
X-CSE-ConnectionGUID: fvN9ENv6QJmd/CUyEOTPSg==
X-CSE-MsgGUID: 9pLyMIDLQQSCNp1AKhojMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="38478050"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="38478050"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 16:11:30 -0700
X-CSE-ConnectionGUID: YyqDMVXbQ2aDadqywwjg5A==
X-CSE-MsgGUID: S983ZUTCSsqWDmfkuYmczQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="78575144"
Received: from auryshaf-mobl.amr.corp.intel.com (HELO [10.124.220.104]) ([10.124.220.104])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 16:11:28 -0700
Message-ID: <accf2b4b-2a54-4261-b67e-010cb74082ae@intel.com>
Date: Wed, 2 Oct 2024 16:11:27 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/10] Add support for shared PTEs across processes
To: Anthony Yznaga <anthony.yznaga@oracle.com>, akpm@linux-foundation.org,
 willy@infradead.org, markhemm@googlemail.com, viro@zeniv.linux.org.uk,
 david@redhat.com, khalid@kernel.org
Cc: andreyknvl@gmail.com, luto@kernel.org, brauner@kernel.org, arnd@arndb.de,
 ebiederm@xmission.com, catalin.marinas@arm.com, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org,
 rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com,
 pcc@google.com, neilb@suse.de, maz@kernel.org,
 David Rientjes <rientjes@google.com>
References: <20240903232241.43995-1-anthony.yznaga@oracle.com>
 <9927f9a3-efba-4053-8384-cc69c7949ea6@intel.com>
 <2dffaf2e-8a27-44bb-8d54-ef4cc0b08dc5@oracle.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <2dffaf2e-8a27-44bb-8d54-ef4cc0b08dc5@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

About TLB flushing...

The quick and dirty thing to do is just flush_tlb_all() after you remove
the PTE from the host mm.  That will surely work everywhere and it's as
dirt simple as you get.  Honestly, it might even be cheaper than the
alternative.

Also, I don't think PCIDs actually complicate the problem at all.  We
basically do remote mm TLB flushes using two mechanisms:

	1. If the mm is loaded, use INVLPG and friends to zap the TLB
	2. Bump mm->context.tlb_gen so that the next time it _gets_
	   loaded, the TLB is flushed.

flush_tlb_func() really only cares about #1 since if the mm isn't
loaded, it'll get flushed anyway at the next context switch.

The alternatives I can think of:

Make flush_tlb_mm_range(host_mm) work somehow.  You'd need to somehow
keep mm_cpumask(host_mm) up to date and also make do something to
flush_tlb_func() to tell it that 'loaded_mm' isn't relevant and it
should flush regardless.

The other way is to use the msharefs's inode ->i_mmap to find all the
VMAs mapping the file, and find all *their* mm's:

	for each vma in inode->i_mmap
		mm = vma->vm_mm
		flush_tlb_mm_range(<vma range here>)

But that might be even worse than flush_tlb_all() because it might end
up sending more than one IPI per CPU.

You can fix _that_ by keeping a single cpumask that you build up:

	mask = 0
	for each vma in inode->i_mmap
		mm = vma->vm_mm
		mask |= mm_cpumask(mm)

	flush_tlb_multi(mask, info);

Unfortunately, 'info->mm' needs to be more than one mm, so you probably
still need a new flush_tlb_func() flush type to tell it to ignore
'info->mm' and flush anyway.

After all that, I kinda like flush_tlb_all(). ;)

