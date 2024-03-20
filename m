Return-Path: <linux-arch+bounces-3048-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13680880AEC
	for <lists+linux-arch@lfdr.de>; Wed, 20 Mar 2024 07:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33F741C20C78
	for <lists+linux-arch@lfdr.de>; Wed, 20 Mar 2024 06:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F19717558;
	Wed, 20 Mar 2024 06:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EXMnjGBu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0671B592;
	Wed, 20 Mar 2024 06:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710914597; cv=none; b=TbNpQIpSI1gm9M+0s7poRJw1Stz7KBi9/K1vFsAHqiN6kRDwuJcBwBWm7+htO3YTnJ3D0N41vziTbDRMvYQfFgY1bsvzAPH+2A2KUCY/GFpsYHx7BBzGOoEYy61tho+gViWbWNgs2Zw/AG81JIYUa6T/QNLnOGB9LWGqNLWo/yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710914597; c=relaxed/simple;
	bh=z1njJyZGUsYE0iBG4Mm7oywOrUx+EDxwyI1v9sCPhrE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i4bX++j1XI4qmIejdfPgWkNZHHs0IK9Vz7TrLb97kwP6FpqkdBNQe4h18PigB54UYlcIvqkw7LvqGTHx07MWmCrqmNQoo/nGNNDPa4YXtpN8XUjf7VCQ+HqjhKAJ5XEilL/PP2HWkWl80XeiLSUbIwQ+DQxX4mMKi6hS5sEQQvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EXMnjGBu; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710914595; x=1742450595;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=z1njJyZGUsYE0iBG4Mm7oywOrUx+EDxwyI1v9sCPhrE=;
  b=EXMnjGBufWXJ9+lt8F/E0SI4MCdSp3jF8V2cmnHjqwoU247W9nIEVi9D
   PgwcNLza7y6s442hxRRbzlnoyT06cRts20oomCRzR0qez7I1i655sKamI
   vm9Ok9+yOWr7Aw9zcncdcfut5GBUuveW1sycx/DwgvCcmLU5ZC4kQK/zr
   NgF/Nms7BjopfGKqnP62hbJvOjMFfQv3GBHnSsH1QMua08UYHyecUs3yW
   fYDeLWhCwkcEKCOUHcS53rsOy2pcKkelih6CCssaMvDmdnXLEfKlmlXPL
   I04+8x5RiULigIKy/f4Q2b/NIj0tSTZPScT7FjTm+cHSl8NSQs/zjb6qw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5941778"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="5941778"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 23:03:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="18775698"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 23:03:11 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gregory.price@memverge.com>
Cc: Gregory Price <gourry.memverge@gmail.com>,  <linux-mm@kvack.org>,
  <linux-api@vger.kernel.org>,  <linux-arch@vger.kernel.org>,
  <linux-kselftest@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <dan.j.williams@intel.com>,  <honggyu.kim@sk.com>,  <corbet@lwn.net>,
  <arnd@arndb.de>,  <luto@kernel.org>,  <akpm@linux-foundation.org>,
  <shuah@kernel.org>
Subject: Re: [RFC v3 0/3] move_phys_pages syscall - migrate page contents given
In-Reply-To: <Zfpohg3EGxxOEcWg@memverge.com> (Gregory Price's message of "Wed,
	20 Mar 2024 00:39:34 -0400")
References: <20240319172609.332900-1-gregory.price@memverge.com>
	<87v85hsjn7.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<Zfpohg3EGxxOEcWg@memverge.com>
Date: Wed, 20 Mar 2024 14:01:17 +0800
Message-ID: <87r0g5saqa.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Wed, Mar 20, 2024 at 10:48:44AM +0800, Huang, Ying wrote:
>> Gregory Price <gourry.memverge@gmail.com> writes:
>> 
>> > Doing this reverse-translation outside of the kernel requires considerable
>> > space and compute, and it will have to be performed again by the existing
>> > system calls.  Much of this work can be avoided if the pages can be
>> > migrated directly with physical memory addressing.
>> 
>> One difficulty of the idea of the physical address is that we lacks some
>> user space specified policy information to make decision.  For example,
>> users may want to pin some pages in DRAM to improve latency, or pin some
>> pages in CXL memory to do some best effort work.  To make the correct
>> decision, we need PID and virtual address.
>> 
>
> I think of this as a second or third order problem.  The core problem
> right now isn't the practicality of how userland would actually use this
> interface - the core problem is whether the data generated by offloaded
> monitoring is even worth collecting and operating on in the first place.  
>
> So this is a quick hack to do some research about whether it's even
> worth developing the whole abstraction described by Willy.
>
> This is why it's labeled RFC.  I upped a v3 because I know of two groups
> actively looking at using it for research, and because the folio updates
> broke the old version.  It's also easier for me to engage through the
> list than via private channels for this particular work.
>
>
> Do I suggest we merge this interface as-is? No, too many concerns about
> side channels.  However, it's a clean reuse of move_pages code to
> bootstrap the investigation, and it at least gets the gears turning.

Got it!  Thanks for detailed explanation.

I think that one of the difficulties of offloaded monitoring is that
it's hard to obey these user specified policies.  The policies may
become more complex in the future, for example, allocate DRAM among
workloads.

> Example notes from a sidebar earlier today:
>
> * An interesting proposal from Dan Williams would be to provide some
>   sort of `/sys/.../memory_tiering/tierN/promote_hot` interface, with
>   a callback mechanism into the relevant hardware drivers that allows
>   for this to be abstracted.  This could be done on some interval and
>   some threshhold (# pages, hotness threshhold, etc).
>
>
> The code to execute promotions ends up looking like what I have now
>
> 1) Validate the page is elgibile to be promoted by walking the vmas
> 2) invoking the existing move_pages code
>
> The above idea can be implemented trivially in userland without
> having to plumb through a whole brand new callback system.
>
>
> Sometimes you have to post stupid ideas to get to the good ones :]
>

--
Best Regards,
Huang, Ying

