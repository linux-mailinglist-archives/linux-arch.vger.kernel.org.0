Return-Path: <linux-arch+bounces-3046-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B3A8809F6
	for <lists+linux-arch@lfdr.de>; Wed, 20 Mar 2024 03:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1880B244C3
	for <lists+linux-arch@lfdr.de>; Wed, 20 Mar 2024 02:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7F32904;
	Wed, 20 Mar 2024 02:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BXO0M8j0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C21FC17;
	Wed, 20 Mar 2024 02:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710903043; cv=none; b=OHoKGC+Jeor8yrBIb60mwnqRT/2plOWMaPxiJI79HPeo6k4g8W/DlFyL9vU4frGMqC3pHR7L6BL85vpkKG2w7ADvZqzKix9UCllRAeq7ZDRtRECKwKYTrB+Y2+OEGeNr67FZcu9OP0EylDF+8jgxItzm5AircfhqJLxAta8bY3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710903043; c=relaxed/simple;
	bh=q2C5sPp5hDLmsM86/ov3qGNGGWpRQK3bmN/ElXRFtaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mUvKpCM2cZv7ZQ9ecZ+WGAzHUYC9YHoWTZw5wpgEK6rmRKGB867oIxvmBGdPHZWHttu86kYr6VJcb+gAcTKDqYPXpYLSCPhIMY4Y2sKTmtSWZUDK/zuTn6E30Dwv9FyvXw+lDubQebPd1fDRJ48zh6Nkf+Q7rp1kMsbGf5aoUsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BXO0M8j0; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710903042; x=1742439042;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=q2C5sPp5hDLmsM86/ov3qGNGGWpRQK3bmN/ElXRFtaw=;
  b=BXO0M8j0uIxuDoqD1Or24SEn84CYtiBboc2rhjPGWIUkiLnt8MBvDsyi
   GFjfHl9bQ80azSLB7PuJgUv53+Zrbqa8Fr1XyQZYfUCKubNDkTzs4ahDA
   sRdkhKq1Or+LXnMY1QLZNQnFyjn7H2YK1yS+WoCsxzFTzYLpmVGLIaeBO
   8z3tM0YBOtMFM4rX41nZTSin/vqtozdlLGzx9kTpQNVQqJXeTO6YcW65u
   F57A936EzxwB+/q1Yq2cQNi+zKzUK6QsN14n2VVSzCKqPVcuUpncRy0nl
   mdDYUn7sWGF86Ku0td8ZjTAEi/mgOEbeelW23Ruvue1UNsoPbuYv6N1Xv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="17213078"
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="17213078"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 19:50:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="14089850"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 19:50:38 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gourry.memverge@gmail.com>
Cc: linux-mm@kvack.org,  linux-api@vger.kernel.org,
  linux-arch@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org,  dan.j.williams@intel.com,
  honggyu.kim@sk.com,  corbet@lwn.net,  arnd@arndb.de,  luto@kernel.org,
  akpm@linux-foundation.org,  shuah@kernel.org,  Gregory Price
 <gregory.price@memverge.com>
Subject: Re: [RFC v3 0/3] move_phys_pages syscall - migrate page contents given
In-Reply-To: <20240319172609.332900-1-gregory.price@memverge.com> (Gregory
	Price's message of "Tue, 19 Mar 2024 13:26:06 -0400")
References: <20240319172609.332900-1-gregory.price@memverge.com>
Date: Wed, 20 Mar 2024 10:48:44 +0800
Message-ID: <87v85hsjn7.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry.memverge@gmail.com> writes:

> v3:
> - pull forward to v6.8
> - style and small fixups recommended by jcameron
> - update syscall number (will do all archs when RFC tag drops)
> - update for new folio code
> - added OCP link to device-tracked address hotness proposal
> - kept void* over __u64 simply because it integrates cleanly with
>   existing migration code. If there's strong opinions, I can refactor.
>
> This patch set is a proposal for a syscall analogous to move_pages,
> that migrates pages between NUMA nodes using physical addressing.
>
> The intent is to better enable user-land system-wide memory tiering
> as CXL devices begin to provide memory resources on the PCIe bus.
>
> For example, user-land software which is making decisions based on
> data sources which expose physical address information no longer
> must convert that information to virtual addressing to act upon it
> (see background for info on how physical addresses are acquired).
>
> The syscall requires CAP_SYS_ADMIN, since physical address source
> information is typically protected by the same (or CAP_SYS_NICE).
>
> This patch set broken into 3 patches:
>   1) refactor of existing migration code for code reuse
>   2) The sys_move_phys_pages system call.
>   3) ktest of the syscall
>
> The sys_move_phys_pages system call validates the page may be
> migrated by checking migratable-status of each vma mapping the page,
> and the intersection of cpuset policies each vma's task.
>
>
> Background:
>
> Userspace job schedulers, memory managers, and tiering software
> solutions depend on page migration syscalls to reallocate resources
> across NUMA nodes. Currently, these calls enable movement of memory
> associated with a specific PID. Moves can be requested in coarse,
> process-sized strokes (as with migrate_pages), and on specific virtual
> pages (via move_pages).
>
> However, a number of profiling mechanisms provide system-wide information
> that would benefit from a physical-addressing version move_pages.
>
> There are presently at least 4 ways userland can acquire physical
> address information for use with this interface, and 1 hardware offload
> mechanism being proposed by opencompute.
>
> 1) /proc/pid/pagemap: can be used to do page table translations.
>      This is only really useful for testing, and the ktest was
>      written using this functionality.
>
> 2) X86:  IBS (AMD) and PEBS (Intel) can be configured to return physical
>      and/or vitual address information.
>
> 3) zoneinfo:  /proc/zoneinfo exposes the start PFN of zones
>
> 4) /sys/kernel/mm/page_idle:  A way to query whether a PFN is idle.
>    So long as the page size is known, this can be used to identify
>    system-wide idle pages that could be migrated to lower tiers.
>
>    https://docs.kernel.org/admin-guide/mm/idle_page_tracking.html
>
> 5) CXL Offloaded Hotness Monitoring (Proposed): a CXL memory device
>    may provide hot/cold information about its memory. For example,
>    it may report the hottest device addresses (0-based) or a physical
>    address (if it has access to decoders for convert bases).
>
>    DPA can be cheaply converted to HPA by combining it with data
>    exposed by /sys/bus/cxl/ information (region address bases).
>
> See: https://www.opencompute.org/documents/ocp-cms-hotness-tracking-requirements-white-paper-pdf-1
>
>
> Information from these sources facilitates systemwide resource management,
> but with the limitations of migrate_pages and move_pages applying to
> individual tasks, their outputs must be converted back to virtual addresses
> and re-associated with specific PIDs.
>
> Doing this reverse-translation outside of the kernel requires considerable
> space and compute, and it will have to be performed again by the existing
> system calls.  Much of this work can be avoided if the pages can be
> migrated directly with physical memory addressing.

One difficulty of the idea of the physical address is that we lacks some
user space specified policy information to make decision.  For example,
users may want to pin some pages in DRAM to improve latency, or pin some
pages in CXL memory to do some best effort work.  To make the correct
decision, we need PID and virtual address.

Yes, I found that you have tried to avoid to break the existing policy
in the code.  But it seems better to consider the policy beforehand to
avoid to make the wrong decision in the first place.

--
Best Regards,
Huang, Ying

