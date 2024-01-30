Return-Path: <linux-arch+bounces-1852-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3AA8427D7
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 16:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8767928893E
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 15:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FDE823D6;
	Tue, 30 Jan 2024 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="JPxN6dTK"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D6481AD7;
	Tue, 30 Jan 2024 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628001; cv=none; b=M2QdieCFNK20fQxHwd3wC3HW7VFIZDTclXTHHKsT5HnRkKryr92yS0SJiLDKn+1bMkUDGKsb+3RVFoqKzyPETnE468uZ1+EXk3yGq12M4LFHCf8RDrjPWv1GzyHCcJblbbGEQ/NLv4asDJJsQHF8ISAtzHtUtFjLOhIYQOtczxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628001; c=relaxed/simple;
	bh=JcOCpUNYX78olAmn5ygAlWF9kq291PrVVIR9mH3wcsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c6PH7obHgvDcEDwtRaKfoulunFERNEQIYOGU478oGbgW9ti8usbhYxC4UjiF69sbdR3fcHAUIOuPV2pwBR9AG29L1corbWCuUsATOu9uWQY57/+pT4oTz+s2k/w30JqqeVeExf6tJTACfv9mCvp4IXQ7I0sWIktWCS/witAcE/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=JPxN6dTK; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706627999;
	bh=JcOCpUNYX78olAmn5ygAlWF9kq291PrVVIR9mH3wcsw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JPxN6dTK5Q/bxQsHTEY7XK3l9oczuiVZ8vLxKQcJxa2mwxLnyRXFfZ0eMzcgww5Xf
	 18w3qMdFKykJmcWmlvPKFEkJKtpjVu543M1cpvx+Q62f5ni7hbSq213PHQfS2Ijoue
	 yyGSjYKH/spBUmO+wADEcwcyKcVGmEG4aGWcaMg7iQENaKg4UU6p1UOfGPMJwz2Z5t
	 xpS+TLWvlBjCul4Sh2Ewv7LTPEOaPlaluyTeYEqnBosrSALyZWaBpqztSwsGuS7Ss2
	 gR4PHzgCZc20LNxisnTqnLhEtlcIkgleQSh4X+V5fRCoYhl6ul2Ar/s8mKocJiey7O
	 5Jg5oRgFCWEGA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TPTPB6JR9zVj1;
	Tue, 30 Jan 2024 10:19:58 -0500 (EST)
Message-ID: <c60044d2-4b61-45db-9036-6383b1677d20@efficios.com>
Date: Tue, 30 Jan 2024 10:19:51 -0500
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/7] xfs: Use dax_is_supported()
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 linux-kernel@vger.kernel.org, Chandan Babu R <chandan.babu@oracle.com>,
 "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
References: <20240129210631.193493-1-mathieu.desnoyers@efficios.com>
 <20240129210631.193493-8-mathieu.desnoyers@efficios.com>
 <ZbhhNnQ+fqd4Hda+@dread.disaster.area>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZbhhNnQ+fqd4Hda+@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-29 21:38, Dave Chinner wrote:
> On Mon, Jan 29, 2024 at 04:06:31PM -0500, Mathieu Desnoyers wrote:
>> Use dax_is_supported() to validate whether the architecture has
>> virtually aliased caches at mount time.
>>
>> This is relevant for architectures which require a dynamic check
>> to validate whether they have virtually aliased data caches
>> (ARCH_HAS_CACHE_ALIASING_DYNAMIC=y).
> 
> Where's the rest of this patchset? I have no idea what
> dax_is_supported() actually does, how it interacts with
> CONFIG_FS_DAX, etc.
> 
> If you are changing anything to do with FSDAX, the cc-ing the
> -entire- patchset to linux-fsdevel is absolutely necessary so the
> entire patchset lands in our inboxes and not just a random patch
> from the middle of a bigger change.

Sorry, I will Cc linux-fsdevel on all patches for the next round.

Meanwhile you can find the whole series on lore:

https://lore.kernel.org/lkml/20240129210631.193493-1-mathieu.desnoyers@efficios.com/

[...]

> 
> Assuming that I understand what dax_is_supported() is doing, this
> change isn't right.  We're just setting the DAX configuration flags
> from the mount options here, we don't validate them until
> we've parsed all options and eliminated conflicts and rejected
> conflicting options. We validate whether the options are
> appropriate for the underlying hardware configuration later in the
> mount process.
> 
> dax=always suitability is check in xfs_setup_dax_always() called
> later in the mount process when we have enough context and support
> to open storage devices and check them for DAX support. If the
> hardware does not support DAX then we simply we turn off DAX
> support, we do not reject the mount as this change does.
> 
> dax=inode and dax=never are valid options on all configurations,
> even those with without FSDAX support or have hardware that is not
> capable of using DAX. dax=inode only affects how an inode is
> instantiated in cache - if the inode has a flag that says "use DAX"
> and dax is suppoortable by the hardware, then the turn on DAX for
> that inode. Otherwise we just use the normal non-dax IO paths.
> 
> Again, we don't error out the filesystem if DAX is not supported,
> we just don't turn it on. This check is done in
> xfs_inode_should_enable_dax() and I think all you need to do is
> replace the IS_ENABLED(CONFIG_FS_DAX) with a dax_is_supported()
> call...

Thanks a lot for the detailed explanation. You are right, I will
move the dax_is_supported() check to xfs_inode_should_enable_dax().

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


