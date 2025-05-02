Return-Path: <linux-arch+bounces-11801-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E391AA7762
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 18:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966144A3E9A
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 16:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526E625DCEA;
	Fri,  2 May 2025 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iveQl/14"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3759925D90D;
	Fri,  2 May 2025 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746203783; cv=none; b=TTqYPOSnM7yjA3Huuq0vvGeTsxMnGoaEr+myHq2Nud7RJw2JrBTncmT0BqKx/83rf3U/1jQh4ffMKSk4DF475it0WREQKVFhuId6sw1CpLlfGQIJLJnE0VlZaa8S5TQbXb6EVjEcqZi0ZPJKRrpPXhblrXFWDClm1WrsqQDaiL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746203783; c=relaxed/simple;
	bh=ivA8S7TDV/NgCvRXyM+VhtT6b0bkMArt6486jbH8r94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Laq26Jm2Gt9twuzo6v3Stc5bkjmJATQwg0PDwT5xduxSZQoEc75TZDOWVnXFQAMetuac8avLI4YjLURcSfx87pbhma7kzq1cFjPscO4Yw/t27TobSvG2ngLoNlAXID4ZhYpz6PmzaDUiTuxdqdPDWrcyP5QFFtW3gVnjTpLr3KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iveQl/14; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746203781; x=1777739781;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ivA8S7TDV/NgCvRXyM+VhtT6b0bkMArt6486jbH8r94=;
  b=iveQl/14SsZ4JE+V+peyB0dCC9P5O2T8JjGSAz90NjfCLwoY+UHKKUPv
   pXfo45CRJ1VYT/M9315BPFnkzaIkn8dhDg2fPfWfJtSLMtWDHvPeTsdR+
   HrStVo/zoGIhQLRUiRCV5xRgRETicesvjUWl0iXzf1LbVN7uqRmlLw7b2
   AaU8nul5a2PT3BygLorYygf95zleSWZ0qFImV3Lj57GbUGmYj3kd6im0v
   08N0Ea/x4UbET0Bv2DUcR7zQibrvoxqanUmVytws2Uyos0anm7w7Nl7J+
   aaeMPE/k863z/KDV9lbPakgN4Gx747TS1XqiSJeOHyg07TgWyoIIx6T4l
   Q==;
X-CSE-ConnectionGUID: 2e+oYUoyREaKGqWHrbv8Yg==
X-CSE-MsgGUID: VG7RhlvyT2KNewoDvYXhSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="47778639"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="47778639"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 09:36:16 -0700
X-CSE-ConnectionGUID: tOv0ur8ST2yGWTeD12RPzg==
X-CSE-MsgGUID: s6AxkAxuRe2enBp5bP0HSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="134641312"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO [10.124.220.153]) ([10.124.220.153])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 09:36:15 -0700
Message-ID: <1eefc8a3-a54f-44e7-ae60-739047230ac4@intel.com>
Date: Fri, 2 May 2025 09:36:13 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: x86 RAR implementation
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-arch@vger.kernel.org,
 Josh Poimboeuf <jpoimboe@kernel.org>, Daniel Wagner <dwagner@suse.de>,
 Sean Christopherson <seanjc@google.com>, Juergen Gross <jgross@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Rik van Riel <riel@fb.com>
References: <20250429113242.998312-1-vschneid@redhat.com>
 <fefcd1a6-f146-4f3c-b28b-f907e7346ddd@intel.com>
 <20250430132047.01d48647@gandalf.local.home>
 <019f6713-cfbd-466b-8fb5-dcd982cf8644@intel.com>
 <20250502112216.GZ4198@noisy.programming.kicks-ass.net>
 <6c44fa0e-28ed-400e-aaf2-e0e0720d3811@intel.com>
 <20250502152002.GX4439@noisy.programming.kicks-ass.net>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20250502152002.GX4439@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Trimming down the cc list (and oh, what a cc list it was!!!) to x86 folks.

On 5/2/25 08:20, Peter Zijlstra wrote:
> So where IPI is:
> 
>  - IPI all CPUs
>  - local invalidate
>  - wait for completion

To drill down on this a bit, the IPI is actually something like

	for_each_cpu(IPI_cpumask)
		per_cpu_ptr(cpu)->csd = 1;
	send_ipi(IPI_cpumask)
	// local invalidate
	// wait for completion

... and the send_ipi() can be a for loop too if it's in clustered mode.
So there is at least _a_ for loop in this case in practice because each
CPU has a per-cpu structure to tell it what to do in the IPI.

> This then becomes:
> 
>  for ()
>    - RAR some CPUs
>    - wait for completion

Were you thinking that the "some CPUs" was limited to 64 because of the
size of the payload table and action vectors? Maybe I was thinking of
arranging the data structures differently.

I was figuring that we could use one entry in the payload table per IPI
operation, *not* one per CPU. Something like:

	e = alloc_payload_entry();
	payload_table[e] = payload;
	for_each_cpu(RAR_cpumask)
		per_cpu_ptr(cpu)->action_vector[e] = RAR_PENDING;
	send_ipi(RAR_cpumask)
	// local invalidate
	// wait for completion
	free_table_entry(e);

In that silly scheme, the allocation can fail. But in that case it's
easy to just fall back to IPIs. I _think_ that works, but it's all in my
head and maybe I'm missing something silly.

I think the mechanism you were thinking of was something like this
(diff'd from what I had above):

-	e = alloc_payload_entry();
+	e = smp_processor_id();
	payload_table[e] = payload;
	for_each_cpu(RAR_cpumask)
		per_cpu_ptr(cpu)->action_vector[e] = RAR_PENDING;
	send_ipi(RAR_cpumask)
	// local invalidate
	// wait for completion
-	free_table_entry(e);

That beats my scheme because it doesn't have any allocation, free or
locking overhead and can't fail to allocate. But it would be limited to
<=64 CPUs because the payload table and action vector are only 64
entries long.



