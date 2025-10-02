Return-Path: <linux-arch+bounces-13830-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F26BB299E
	for <lists+linux-arch@lfdr.de>; Thu, 02 Oct 2025 08:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3CAA321C54
	for <lists+linux-arch@lfdr.de>; Thu,  2 Oct 2025 06:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA9E632;
	Thu,  2 Oct 2025 06:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bps/jHLa"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BC034BA47
	for <linux-arch@vger.kernel.org>; Thu,  2 Oct 2025 06:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759385525; cv=none; b=PJqFKxGJx/4wkQq/HgahSSYXAYWLAib5dq8EP7oK2ha6jHF4MgGCzqHqbGd0RhRmXm9oKA+3IWgk9f/ktkmjQL0guG0hVq/t249NOzd9h8NXU6inGOXk8xsGHaORLC2YVOePF0xO1hrT2tffQ/Z1/OiNU481D55EcfziOkLyU7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759385525; c=relaxed/simple;
	bh=dudDrSmyAnmIwnEea6hkJCcFEHHVqPZ3cWYKZN6eHcM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OMm2VCZvgPSR4Ud0AeI7YmOOQI75Y0JQUqz1oH9UxsoZBCMDmXywFP/Z+kmja2qDPCCP0nej/HIonEUVlDGAnRBEZ8W2EFfa6aSjj6p0mfzvp4+jpE0XiEWe7MNocpfcQbuCZGALVbyD/WAn/TqBbwmuAtOtTf1e2I829rRzeQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bps/jHLa; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=XeGs/A7JZKt44zompJ6AE70C6JySorOcriRy8XM93E0=; b=bps/jHLa1rCW4zQnTrjKin/zwx
	tZXTIe4JyJaoxXt+nD+XVvRkYRE2NMO7SI5WfuN1WTcC8PmMqwOhgoNlesM+PSdEkXsghYvXcy+OD
	q6bcwvvgDQ1flbDrg7UOyVreoilFjzgBh6j3P2CgT3YWVr/AGSCMXN8AhWs8WXgzCceBuwzBZGKGS
	u+4zi38Oj27CpeccwgyLa5yCnZgbDx8WTDV9oi2nIdo46LrcuIL5I+SiM0bxsLdsHnmouAf7BDrDQ
	pzaBONoFud0xygp+075fIdB3cMi2hGwe/nkKBkjQIxramh5vaCbjV/dAPaP2UBJ1yqGcyi6uOlZnG
	aRZ9Gopg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4CXn-0000000Card-2Whh;
	Thu, 02 Oct 2025 06:12:00 +0000
Date: Thu, 2 Oct 2025 07:11:59 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org
Subject: [git pull] non-vfs misc stuff
Message-ID: <20251002061159.GL39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-misc

for you to fetch changes up to f037fd7fbca4d111955b5889417ddf6fb24498e5:

  alpha: unobfuscate _PAGE_P() definition (2025-09-15 21:12:05 -0400)

----------------------------------------------------------------
assorted dead code removal around asm/pgtable.h

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (6):
      csky: remove BS check for FAULT_FLAG_ALLOW_RETRY
      PAGE_PTR() had been last used outside of arch/* in 1.1.94
      SET_PAGE_DIR() users had been gone since 2.3.12pre1
      alpha: get rid of the remnants of BAD_PAGE and friends
      kill FIRST_USER_PGD_NR
      alpha: unobfuscate _PAGE_P() definition

 arch/alpha/include/asm/pgtable.h      | 25 +------------------------
 arch/alpha/mm/init.c                  | 27 ---------------------------
 arch/csky/mm/fault.c                  |  2 +-
 arch/m68k/include/asm/pgtable_mm.h    | 10 ----------
 arch/microblaze/include/asm/pgtable.h |  1 -
 arch/openrisc/include/asm/pgtable.h   | 17 -----------------
 arch/xtensa/include/asm/pgtable.h     |  1 -
 7 files changed, 2 insertions(+), 81 deletions(-)

