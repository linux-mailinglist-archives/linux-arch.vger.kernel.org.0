Return-Path: <linux-arch+bounces-10072-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F8CA2E319
	for <lists+linux-arch@lfdr.de>; Mon, 10 Feb 2025 05:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37001886B20
	for <lists+linux-arch@lfdr.de>; Mon, 10 Feb 2025 04:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A60D13A3ED;
	Mon, 10 Feb 2025 04:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ngLB8p9i"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761197FBD6;
	Mon, 10 Feb 2025 04:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739161787; cv=none; b=eLtZrNpBGGR4LYza2EqkTGB4oNkD9OtQ887/Y8x3mFnjezBriJM76j+5gMh0YSeWsSvXjEMT/hLbyIRaOy9PZScoP/lZ3ak2/cIzirpDKbrIXOZwAROUsXWZdmFCbqPhbMQ8rxezw0aW0vdKEp6fO2/WLR+PHmlvkyh3Zveg8U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739161787; c=relaxed/simple;
	bh=Ke1mIKcFCXuM5xU3t6CrbyKLXX4Z0MhE5MCx3Zo5kTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ocfhig8Re1iRo4kJ4ZXyHjoBaib8XWkTMV8OGR8Unen9S1g+wkHfSnGXnNenVXAyE8SLIJmwTGh1Irs346cA7U3rPZRX9BA/iulOGW8h54t+G7EgeRdbd3pjmZ+nl/3jzmYACxa74QOjDZ9MRKoAa7zL402EBQN6YmHLMMapVvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ngLB8p9i; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739161786; x=1770697786;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ke1mIKcFCXuM5xU3t6CrbyKLXX4Z0MhE5MCx3Zo5kTU=;
  b=ngLB8p9iXyAPOUW8S2TYt1Nj1t0m2pqdCBz6TpUSFryaRhTHNbb15QHx
   SXLriuNy/PSt6DaXOB2ksM1UTCvpOuLRX/vj+Hf9SM6Xtc/o0adCLqLTD
   br17yXdKqYlvZ6iYxAz/briHMcA43JWQD2J5jZ0VQE1ZNv1V15k8jPEBY
   0zZbDyUx52IR6iBbroSFvYNvNEyCjhADgsvCAH3i5oIZUMXC8KUdyYnwH
   0J1QpDFzSMWW9t7cgAR6jbb41rGLUfKU2kUFrsHK7NJA5oC1oNux6Jn4B
   1Q710HE5Y6PRXygwpu54JRNFsWWGao6r6gNl1mSVZGSOikaw/C2+QRjp4
   w==;
X-CSE-ConnectionGUID: kNkqMRzbSBO2i7KLYYIdug==
X-CSE-MsgGUID: nQNWFZ7MSgaZ6la8GPyclw==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="43491839"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="43491839"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 20:29:45 -0800
X-CSE-ConnectionGUID: QNZNtOYOQ3CbAViJvIfKSg==
X-CSE-MsgGUID: sJnpTm+fQ1m8C55P59UKKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="112590967"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 20:29:44 -0800
Date: Sun, 9 Feb 2025 20:29:42 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-arch@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 1/1] x86: In x86-64 barrier_nospec can always be lfence
Message-ID: <Z6mAtkG9DnDDNFvn@tassilo>
References: <20250209191008.142153-1-david.laight.linux@gmail.com>
 <CAHk-=wiQQQ9yo84KCk=Y_61siPsrH=dF9t5LPva0Sbh_RZ0-3Q@mail.gmail.com>
 <20250209214047.4552e806@pumpkin>
 <CAHk-=wiSnNEWsvDariBQ4O-mz7Nc7LbkdKUQntREVCFWiMe9zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiSnNEWsvDariBQ4O-mz7Nc7LbkdKUQntREVCFWiMe9zw@mail.gmail.com>

> So on x86, both read and write barriers are complete no-ops, because
> all reads are ordered, and all writes are ordered. So those only need
> compiler barriers to guarantee that the compiler itself doesn't
> re-order them.
> 
> (Side note: earlier reads are also guaranteed to happen before later
> writes, so it's really only writes that can be delayed past reads, but
> we don't haev a barrier for that situation anyway. Also note that all
> of this is not "real" ordering, but only a guarantee that the
> user-visible semantics are AS IF they were actually ordered - if
> things are local in cache, ordering doesn't matter because no external
> CPU can *see* what the ordering was).

However in the local case *FENCE still orders, so it's actually not a
nop. Just normally you can't tell the difference in ordering semantics,
but it's visible in side effects like RDTSC.

-Andi

