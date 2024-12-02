Return-Path: <linux-arch+bounces-9233-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC24A9DF9C6
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 05:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B6D7B210BD
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 04:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855E922EEF;
	Mon,  2 Dec 2024 04:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="POgRvMSL"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167C9EC4
	for <linux-arch@vger.kernel.org>; Mon,  2 Dec 2024 04:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733112204; cv=none; b=ghSFTAOSK3LNewfR8aeBBnUDc1Shr7fb2JCTNzuH2tJBxfEoNwDeok93vvlL3SWaO9D7td++l7hBkqoqGMoDaTNhp4Y7JKnUw8FuBtGS6sxnsvv+LkbOuAjdxMvNbBS/aVLD5SfgUqKS5W1ZRMD9IcnoSAhztzaESKBRsCikD+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733112204; c=relaxed/simple;
	bh=7fYcQKGoX1UknGKIVX8DEXvZjRn/msS9EJlM6TBTs8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPl4DxmjpYyS1oVE5uOEB8Q9noJoTVDtY4dLYfboc0tB3D6L6frNyioxORaxCUws1iACf/y+NBWldQlyQYSZmRIruib6qDUlpj+1RUJzi0iymVYn+Qrcpl/icoXH1/lN01cAXHGEpS2Nqj4cqEH7IgzE0LsZb244mvWNbnVQXYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=POgRvMSL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xMIiwnBUaf1TnNHRw2qjwROsN/VKTkiw/reAVb9/OcA=; b=POgRvMSLEwjm5L9/HC7djmcxUr
	RxSuMTR+EUAwVAF9X4doHW1EM9PGd7QZzJimg2N/IKGRh/tUjUvUCjfllHiCy/gcr3TJMnhcOLFht
	ityDu69Bi4joER0O9bi2BiUWv9IMZL5nkDnprAwgo6WDV5cUdkscpuND77R0i7ZJ1I37cjAEnEy3k
	7WNauRVPni5HEJStPcPkeOZrQmOEqN3IvBSGoidH/bkRMaCOaxQHDxoCdZsRn+L1g6cf3mgBiPxCS
	4spg1ixY2mwaI3Af+L/xLQoRKxgubUOFLf/epG3Wvtf2BJ9/iiuBbhS5xx5wUIGtCpYBsRUGHEN4C
	vBn9xDLg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tHxeW-00000003uoB-2bNq;
	Mon, 02 Dec 2024 04:03:16 +0000
Date: Mon, 2 Dec 2024 04:03:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/3] alpha: regularize the situation with asm/param.h
Message-ID: <20241202040316.GB933328@ZenIV>
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

The only reason why alpha can't do what sparc et.al. are doing
is that include/asm-generic/param.h relies upon the value of HZ
set for userland header in uapi/asm/param.h being 100.

We need that value to define USER_HZ and we need that definition
to outlive the redefinition of HZ kernel-side.  And alpha needs
it to be 1024, not 100 like everybody else.

So let's add __USER_HZ to uapi/asm-generic/param.h, defaulting to
100 and used to define HZ.  That way include/asm-generic/param.h
can use that thing instead of open-coding it - it won't be affected
by undefining and redefining HZ.

That done, alpha asm/param.h can be removed and uapi/asm/param.h
switched to defining __USER_HZ and EXEC_PAGESIZE and then including
<asm-generic/param.h> - asm/param.h will resolve to uapi/asm/param.h,
which pulls <asm-generic/param.h>, which will do the right thing
both in the kernel and userland contexts.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/include/asm/param.h      | 12 ------------
 arch/alpha/include/uapi/asm/param.h |  9 ++-------
 include/asm-generic/param.h         |  2 +-
 include/uapi/asm-generic/param.h    |  6 +++++-
 4 files changed, 8 insertions(+), 21 deletions(-)
 delete mode 100644 arch/alpha/include/asm/param.h

diff --git a/arch/alpha/include/asm/param.h b/arch/alpha/include/asm/param.h
deleted file mode 100644
index cfe947ce9461..000000000000
--- a/arch/alpha/include/asm/param.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_ALPHA_PARAM_H
-#define _ASM_ALPHA_PARAM_H
-
-#include <uapi/asm/param.h>
-
-# undef HZ
-# define HZ		CONFIG_HZ
-# define USER_HZ	1024
-# define CLOCKS_PER_SEC	USER_HZ	/* frequency at which times() counts */
-
-#endif /* _ASM_ALPHA_PARAM_H */
diff --git a/arch/alpha/include/uapi/asm/param.h b/arch/alpha/include/uapi/asm/param.h
index 49c7119934e2..e4e410f9bf85 100644
--- a/arch/alpha/include/uapi/asm/param.h
+++ b/arch/alpha/include/uapi/asm/param.h
@@ -2,14 +2,9 @@
 #ifndef _UAPI_ASM_ALPHA_PARAM_H
 #define _UAPI_ASM_ALPHA_PARAM_H
 
-#define HZ		1024
-
+#define __USER_HZ	1024
 #define EXEC_PAGESIZE	8192
 
-#ifndef NOGROUP
-#define NOGROUP		(-1)
-#endif
-
-#define MAXHOSTNAMELEN	64	/* max length of hostname */
+#include <asm-generic/param.h>
 
 #endif /* _UAPI_ASM_ALPHA_PARAM_H */
diff --git a/include/asm-generic/param.h b/include/asm-generic/param.h
index 8d3009dd28ff..8348c116aa3b 100644
--- a/include/asm-generic/param.h
+++ b/include/asm-generic/param.h
@@ -6,6 +6,6 @@
 
 # undef HZ
 # define HZ		CONFIG_HZ	/* Internal kernel timer frequency */
-# define USER_HZ	100		/* some user interfaces are */
+# define USER_HZ	__USER_HZ	/* some user interfaces are */
 # define CLOCKS_PER_SEC	(USER_HZ)       /* in "ticks" like times() */
 #endif /* __ASM_GENERIC_PARAM_H */
diff --git a/include/uapi/asm-generic/param.h b/include/uapi/asm-generic/param.h
index baad02ea7f93..3ed505dfea13 100644
--- a/include/uapi/asm-generic/param.h
+++ b/include/uapi/asm-generic/param.h
@@ -2,8 +2,12 @@
 #ifndef _UAPI__ASM_GENERIC_PARAM_H
 #define _UAPI__ASM_GENERIC_PARAM_H
 
+#ifndef __USER_HZ
+#define __USER_HZ	100
+#endif
+
 #ifndef HZ
-#define HZ 100
+#define HZ __USER_HZ
 #endif
 
 #ifndef EXEC_PAGESIZE
-- 
2.39.5


