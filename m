Return-Path: <linux-arch+bounces-13478-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC6CB52612
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 03:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE6A166FB7
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 01:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257421F03D9;
	Thu, 11 Sep 2025 01:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="dzcj/Qjw"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1368E4503B;
	Thu, 11 Sep 2025 01:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555491; cv=none; b=IUzGjb0Uq4H6KU37GtP5WxyjMxZ31jNQCBA2tuTsl3x/FfGwgO+3VUzXMWGvGbmVUPmtaMW7dvB3SOILGUuH+CGSCwxKlFPwbj1snSSL5eS0mp5cUzkXbb97XP8UIvgVkAbNMmPwS9EUyY++PebwafM5tWt2t8jgin7NyJliVHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555491; c=relaxed/simple;
	bh=hWhlaWUSSqXUCCqhZ3YUzwPlcGmQ+BbgKTH2i4Q0ivk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qLtWY5eIinyn89KXFpqdqXp3eBNeNQXE1Xg8ptgxJPW5lc1yIp5/dG3w0uCTJygQIgLD4IAwvQ2uXpDUaFe9BxwtN/RoPYo20knCHC0DVCeTETdhohAMkS+N5osSvJQrbHrVK2MFzPAZUjzYd1cEt1VcE+6itrXExEE/xYr+K/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=dzcj/Qjw; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=LxefAVzYvnx2nYqqbwLtNe6Vs0NvQFLHqWcYv50y1ks=; b=dzcj/Qjw4X9wPbXxRczxzBeghb
	FKK0QaVMB/f5toJqRXV6r4TahKPHRtS0PEa4UyZeL78OOytyIluy0+WqVExu327UBEKrCyPx0+mZS
	yGQM/QBanB3vW/AucyNqvNr8P9c3lwLzTa47OzVlbggbmPHevFMKeE0CGD0ay5AM08E37YW5gt+VZ
	RqrB/INtspyN4cNcMPe21JwKlzPccAv/4EOUA4SocO2DUNt2j3TjTdi6bUwV4lJ7vOBCsjX84lRwx
	MSFZXGBxcaecyCAmh3GGcKn+DFsMXgvUTxyh5g6Y1CNeKlN5fD7C6cOCoPjHnLejGteu7f3ytGHuN
	ULX5rwdw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwWT6-0000000AvLz-1MSA;
	Thu, 11 Sep 2025 01:51:24 +0000
Date: Thu, 11 Sep 2025 02:51:24 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
	linux-alpha@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>, Max Filippov <jcmvbkbc@gmail.com>,
	Jonas Bonn <jonas@southpole.se>
Subject: [PATCHES] misc dead code removals in arch/* - mostly asm/pgtable.h
Message-ID: <20250911015124.GV31600@ZenIV>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Several old patches that had been bouncing around in
my tree for a while.  This stuff sits in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.misc
if any architecture tree would like to pick some of those - just
yell, I'll be only glad to get that off my hands.  Anything left
unclaimed will go to Linus come next window, so if you have objections,
please say so.
	Individual patches in followups.

Shortlog:
	csky: remove BS check for FAULT_FLAG_ALLOW_RETRY
	PAGE_PTR() had been last used outside of arch/* in 1.1.94
	SET_PAGE_DIR() users had been gone since 2.3.12pre1
	alpha: get rid of the remnants of BAD_PAGE and friends
	kill FIRST_USER_PGD_NR
	alpha: unobfuscate _PAGE_P() definition

Diffstat:
 arch/alpha/include/asm/pgtable.h      | 25 +------------------------
 arch/alpha/mm/init.c                  | 27 ---------------------------
 arch/csky/mm/fault.c                  |  2 +-
 arch/m68k/include/asm/pgtable_mm.h    | 10 ----------
 arch/microblaze/include/asm/pgtable.h |  1 -
 arch/openrisc/include/asm/pgtable.h   | 17 -----------------
 arch/xtensa/include/asm/pgtable.h     |  1 -
 7 files changed, 2 insertions(+), 81 deletions(-)

