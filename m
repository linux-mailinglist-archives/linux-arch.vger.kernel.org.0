Return-Path: <linux-arch+bounces-9232-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B18C19DF9C5
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 05:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A72D16226F
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 04:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5A822EEF;
	Mon,  2 Dec 2024 04:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MkmvfN/1"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A63EC4
	for <linux-arch@vger.kernel.org>; Mon,  2 Dec 2024 04:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733112167; cv=none; b=XbWO4oX63p/CTsw+7qvmRTi9tMEUNAvChjYzyMBC+OrNh4eZHTIhX622wO45BHmjhtt5QpI7gwBFIBbtyVwOALGXc8BVszDuBHy8BNNQ9jc5M3SI4qhcdefaDXw/Mu57KZ1srDaFEASM9ssP5qjGjIbRfU9xvTtx93Cgfrsfw3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733112167; c=relaxed/simple;
	bh=7op1AztCRM8V2Snvbzzntp4nRulvlgd5gPPpAcNF+dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVmh2tqQowcQyTVpAwteUwHTdrVo/K3dAKlAW0bjg62Qmv7plTIlLF8j6jfBW1C2xVwOuXPmrFkeOpA12ouB0sZSW6mRRc5kyrjf/YbdTxVQjl0Xuxu6FlkUn/dbZING5MQlc+pStQXvAXvJkJjxAnEPhJM3lbmG+fqtUxCx/Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MkmvfN/1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HOMC9wufNm/rz/TzMeaGpmCHDb56u71ktpU2/KJg1Vk=; b=MkmvfN/1St/wsGkAC8vxaECh2D
	CE0zfMQEj0MOmznBuKT0PZBVesRV8Ul+vj7wUWkDlcVf4GW6uyWyUs/rc4YADvJZpUIDGSe9it14l
	nKaRDHWrUtWk1bErf/VZxkvSuRWl0LpmkMiXLi0NPWOdwOLpQdwDjLOiS6k/QsA5OC4Ko/NqnCY4L
	9xz7hjO6jLjdQndX4LuhLckV1WCw7xcrTA9KJrm5n5SZI/d4T2wkHH99SIqmjl67393sFJQRo2d6Q
	muG173RWknRKb4AMAQGlnJ3XukC8H6bAhlcSmXP5OJZyfCszcSAJ3Kch/dyYeZ5Z55DDqjRC6vH2u
	0KPaFIDg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tHxdz-00000003unp-1hPn;
	Mon, 02 Dec 2024 04:02:43 +0000
Date: Mon, 2 Dec 2024 04:02:43 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/3] xtensa: get rid uapi/asm/param.h
Message-ID: <20241202040243.GA933328@ZenIV>
References: <20241202040207.GM3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202040207.GM3387508@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

The only difference between it and generic is the stray (and utterly
useless) definition of NGROUPS.  It had been removed on all architectures
back in 2004; xtensa port began prior to that and hadn't been merged
until 2005, so it had missed the purge.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/xtensa/include/uapi/asm/param.h | 31 ----------------------------
 1 file changed, 31 deletions(-)
 delete mode 100644 arch/xtensa/include/uapi/asm/param.h

diff --git a/arch/xtensa/include/uapi/asm/param.h b/arch/xtensa/include/uapi/asm/param.h
deleted file mode 100644
index e6feb4ee0590..000000000000
--- a/arch/xtensa/include/uapi/asm/param.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * include/asm-xtensa/param.h
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2001 - 2005 Tensilica Inc.
- */
-
-#ifndef _UAPI_XTENSA_PARAM_H
-#define _UAPI_XTENSA_PARAM_H
-
-#ifndef __KERNEL__
-# define HZ		100
-#endif
-
-#define EXEC_PAGESIZE	4096
-
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
-#ifndef NOGROUP
-#define NOGROUP		(-1)
-#endif
-
-#define MAXHOSTNAMELEN	64	/* max length of hostname */
-
-#endif /* _UAPI_XTENSA_PARAM_H */
-- 
2.39.5


