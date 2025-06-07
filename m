Return-Path: <linux-arch+bounces-12263-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1751AD0DCF
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 16:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F013A8F32
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 14:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459F31A704B;
	Sat,  7 Jun 2025 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KpeVND0H"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974FD288DB;
	Sat,  7 Jun 2025 14:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749305527; cv=none; b=ZhK7LiRoT+BM6bdvwxRkAz/1Q2yJg86bTzoJO5VF5On60IKcu2mt/7ncAaTU0JEeahkL+krb4Uk+0oROmRQczYAIi0WChuWaWMXwVGg/UR4RLwLllhfNoO6ypX2nzN3w/S8Txrpkfhxw5RhVdBWqbTdbmfEswEANYqg0AiGIpVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749305527; c=relaxed/simple;
	bh=tOsURfwpu5JIYYGzjKsueBWYxy8LFs6ja4Urw/zMLwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6/VT96qd4sDPvdVJk/kgDHYUM23yI2iyTR7esEJLmaSINR1g9JGoqFVh5P8nCqpQMgh2zyt+7XSmKS2a1zCCceNEXfiy3boO8rczwKimvr/EoW2pSdWb3ZM6a5M2Bri3ULp78+jR9lyL42OHitvYVElUp9MjxpTJsJwVmKZOV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KpeVND0H; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749305526; x=1780841526;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tOsURfwpu5JIYYGzjKsueBWYxy8LFs6ja4Urw/zMLwY=;
  b=KpeVND0HpNdRdUWOOYhGagscfYV6c8q4anW6d0ispW3IIV7fRWKSszZ+
   DD+5hNl/0L0xnplEKRQ/M407Ax9I6Ljawvc943FCziMJSV6tMzRLCBWTK
   bPxIHT3RENY0wntHeNgWLYJvW3o//m6Egewr/rCU0BBtB5ajCt7GvpXVp
   BRG9dzElXeuEToftc3s8UmGFsta38fjRFJwz9hOEU/pCo/BqVassX3tMt
   +l+GPkndw415gLG2O/ai+pl2371B92beWyy2hLMDI0e/oM1sPWvGIVsD0
   a0ASzR4w+GiaDsdt8m/7HEWWB4Qkmu5Rn1YAb7yCSn0SVy84QTwHOhYq6
   w==;
X-CSE-ConnectionGUID: J46COigUTqKLvFlqxTQSAA==
X-CSE-MsgGUID: rO7rDcMkSHiJA61/bGG2Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11457"; a="55231460"
X-IronPort-AV: E=Sophos;i="6.16,218,1744095600"; 
   d="scan'208";a="55231460"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2025 07:12:05 -0700
X-CSE-ConnectionGUID: tBMhaICIR3CN1VGkDijZZw==
X-CSE-MsgGUID: QIrKOpfMQBC9VEoVh73s9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,218,1744095600"; 
   d="scan'208";a="169264059"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.111.75]) ([10.125.111.75])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2025 07:12:03 -0700
Message-ID: <34a2bfa5-30e1-4ba0-ac36-bf07a0d60d97@intel.com>
Date: Sat, 7 Jun 2025 07:12:02 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Large modules with 6.15 [was: [PATCH v4 6/6] percpu/x86: Enable
 strict percpu checks via named AS qualifiers]
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, x86@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-arch@vger.kernel.org, netdev@vger.kernel.org,
 Nadav Amit <nadav.amit@gmail.com>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20250127160709.80604-1-ubizjak@gmail.com>
 <20250127160709.80604-7-ubizjak@gmail.com>
 <02c00acd-9518-4371-be2c-eb63e5d11d9c@kernel.org>
 <b27d96fc-b234-4406-8d6e-885cd97a87f3@intel.com>
 <CAFULd4Ygz8p8rD1=c-S2MjJniP6vjVNMsWG_B=OjCVpthk0fBg@mail.gmail.com>
 <9767d411-81dc-491b-b6da-419240065ffe@kernel.org>
 <6412d84a-edc3-4723-89f1-b2017fb0d1ea@intel.com>
 <CAFULd4asiDaj1OTrqWNMr5coyPeqM1NT6v2uEqKvJicRUhekSQ@mail.gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <CAFULd4asiDaj1OTrqWNMr5coyPeqM1NT6v2uEqKvJicRUhekSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/7/25 01:52, Uros Bizjak wrote:
> Let me reiterate what the patch brings to the table. It prevents
> invalid references of per cpu variables to non-percpu locations.

Yes, it's a very useful mechanism. That's exactly why I want to preserve
it for developers or things like 0day that do build tests and don't care
about modules quadrupling in size.

> Hiding these checks behind the CONFIG_EXPERT option breaks the
> intention of the patch. IMO, it should be always enabled to avoid
> errors, mentioned in the previous paragraph, already during the
> development time.

I agree, it should always be enabled ... eventually. But now now. That's
why we're having this conversation: it's breaking too many things and
needs to be disabled.

> I'm much more inclined to James' proposal. Maybe we can disable these
> checks in v6.15 stable series, but leave them in v6.16? This would
> leave a couple of months for distributions to update libbpf.

I'd be worried that it will hit a whole bunch of folks doing 6.16 work.
I was expecting to revert it _everywhere_ for now, if we go the revert
route.

James, by partial revert, did you mean to revert in stable but not
mainline? I assumed you meant to just revert patch 6/6 of the series
(stable and mainline) but leave 1-5 in place so turning it back on later
was easier.

