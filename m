Return-Path: <linux-arch+bounces-1729-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B32B83E2A7
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 20:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA88AB2408D
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 19:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20129224EC;
	Fri, 26 Jan 2024 19:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="CYryvNhP"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA0E225CE;
	Fri, 26 Jan 2024 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706297643; cv=none; b=JngSd0klYSeBmaOxuB3lLpJ8a+S8wDuuksF23krnds09Z+cEOTwD9Ztb7Iomj3iId2AdFnbpcoVt6cr4sB/COnDi+oJYcB7yaK2ilzMPzmbSzSSnLa5CiFv12xq9vr6daFuYlEcIVBDYdFyggDnG+4GaHeO4p89vIXDmESWq/Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706297643; c=relaxed/simple;
	bh=X2tv7YC7rvxoUUooCnssnmB276xID1n7i+KGcjgXyaY=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=gCl4el3NiA+Pecvm/NWYSFxFxHuBbPcvn5MPZ30MpzEGYh3RPzZxup4vvJ4ywUPj2GkjFZE+H3vD8wJJbwfZS5uNhduzFdz0ESnLpKN0k76XNTtsF4gE3eUUsGqb2eQNy4Q44UXShqCB4Qw7FvQNNcVJOp6hzBxqlweJ/Sn6eYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=CYryvNhP; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706297639;
	bh=X2tv7YC7rvxoUUooCnssnmB276xID1n7i+KGcjgXyaY=;
	h=Date:From:To:Subject:From;
	b=CYryvNhPZbC7x2vM29ob6YlU9y7XqdYN1eE+S0JMTNZyFT6FwPl1FFNqD+a7/3OUg
	 363JrNqGqicCxn1V0gzmJktc5SGfN5Q8hC5GwNmbXcb319GcfZRSAdMDf2LQIX6oC+
	 lSxIcSLX3c/Ymagubv0PVRA6dDJJAjaAz/H1FkwBC/ixYQx0tXlnzCzCx5cOvEkold
	 HkWWXgW0zcyim0acOvi0AoVPw1CIgk4mbGbJYNaEAr8+JhoLp0wx9vgkrPYTNu79IF
	 KbWX5iKoCx6k/HjFrH1cjNfKeof6FDhCfoj/1KDcMcAr8o0JhZK5J+EMm/O1D8m9xo
	 XOnbGShcIXNUQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TM7D72M8NzVDZ;
	Fri, 26 Jan 2024 14:33:59 -0500 (EST)
Message-ID: <e523b29c-0fd0-4b7c-bf8c-d3424ee2c031@efficios.com>
Date: Fri, 26 Jan 2024 14:33:57 -0500
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm
 <linux-mm@kvack.org>, linux-arch@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Subject: [REGRESSION] v5.13: FS_DAX unavailable on 32-bit ARM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This commit introduced in v5.13 prevents building FS_DAX on 32-bit ARM,
even on ARMv7 which does not have virtually aliased dcaches:

commit d92576f1167c ("dax: does not work correctly with virtual aliasing caches")

It used to work fine before: I have customers using dax over pmem on ARMv7, but
this regression will likely prevent them from upgrading their kernel.

The root of the issue here is the fact that DAX was never designed to handle
virtually aliased dcache (VIVT and VIPT with aliased dcache). It touches the
pages through their linear mapping, which is not consistent with the userspace
mappings on virtually aliased dcaches.

I can see a few ways forward to address this:

A) I have prepared a patch series introducing cache_is_aliasing() with new Kconfig
    options:

   * ARCH_HAS_CACHE_ALIASING
   * ARCH_HAS_CACHE_ALIASING_DYNAMIC

and implemented it for all architectures. The "DYNAMIC" implementation
implements cache_is_aliasing() as a runtime check, which is what is needed
on architectures like 32-bit ARM.

With this we can basically narrow down the list of architectures which are
unsupported by DAX to those which are really affected, without actually solving
the issue for architectures with virtually aliased dcaches.

B) Another approach would be to dig into what exactly DAX is doing with the linear
    mapping, and try to fix this. I see two options there:

B.1) Either we extend vmap to allow vmap'd pages to be aligned on specific multiples,
      and use a coloring trick based on SHMLBA like userspace mappings do for all DAX
      internal pages accesses, or

B.2) We introduce flush_dcache_folio() at relevant spots (perhaps dax_flush() ?) to
      synchronize the linear mapping wrt userspace mappings. (would this work ?)

Any thoughts on how to best move forward with this issue are welcome.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

