Return-Path: <linux-arch+bounces-9458-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B309FA86F
	for <lists+linux-arch@lfdr.de>; Sun, 22 Dec 2024 23:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03341885B08
	for <lists+linux-arch@lfdr.de>; Sun, 22 Dec 2024 22:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A307189F2F;
	Sun, 22 Dec 2024 22:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SZckhlw8"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AD9632;
	Sun, 22 Dec 2024 22:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734906185; cv=none; b=tPdBmUo2y+ltcyMVDcWPwB//pIP2+tv/5gg1yLdhui2c4WEiinnAskUvRSaOI8WIu+ZW3BeOfIAp3SRg9G1d5bmgB07e8SsvPER3ZvtBjtB8taTgUxtcAlqJaAgwan4vSWLfjbmugGdtok3kuPJRTu16NldyIvAvpWoJduBK2zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734906185; c=relaxed/simple;
	bh=OdLf5Eyt5QplhrtHNKAnEnAB6KFzEWflQ/rmPd9JeQs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ed5aDZdZq1LXhiuYWhg5vi+vlQYUFz8BFdhL9KoEwevatRRTwiHWHDBWjKEOP7rq9vUh5z2wfTV78LiBVSG+w6eOkxj7dpI/YZ0wojBnTNalnmDc2W/rfdLPaS2ErtbCsf2BtbVBcXsv8eMYqMHaOK0EcTuiMdLA+2wJ1BQH59s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SZckhlw8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=V6GrayCVmn6S1ypFxxQ1HDjjfMtpzxOmP8gCcGmfaiw=; b=SZckhlw8cSsFt6hNn3IqvJQZwk
	iEccKscpb8ZDntmweXomU0vtw8Wjjt5aP1mxs2F0cEizF3nL6mV4oaVOZyYhQszGTLnIK8WTg1eAA
	2Wn94BltwvArqWngwACs0Gg7NKcJBKTd6Fbse+goL7tuAMLqWeTM3UES3ZSoyWgDT8dFne+LLTqx6
	ZPTghqDnkZch5R7MtHUcclGW1IX479UW/1fsRk4mpadyPmtiMvAqAvqL1EV322Vgd9TQXVR4Gugg6
	t/At1av4/MOaHddO74fodFXAAWanMM21NoQM+Xap6CJkPtw9jaWZzt+fQOpGj6c0HTjNDTI4lldeT
	9fLlkdfQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tPULj-0000000B6ed-14yp;
	Sun, 22 Dec 2024 22:22:59 +0000
Date: Sun, 22 Dec 2024 22:22:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-sh@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, linux-arch@vger.kernel.org
Subject: [PATCH] sh: exports for delay.h
Message-ID: <20241222222259.GF1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	__delay() is either exported or exists as a static inline
on all architectures - except sh.

	Add the missing export of __delay(), move the exports of
the rest of that bunch from sh_ksyms32.c to the place where all
of them are defined (i.e. arch/sh/lib/delay.c).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/arch/sh/kernel/sh_ksyms_32.c b/arch/sh/kernel/sh_ksyms_32.c
index 5858936cb431..0b9b28144efe 100644
--- a/arch/sh/kernel/sh_ksyms_32.c
+++ b/arch/sh/kernel/sh_ksyms_32.c
@@ -2,7 +2,6 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
-#include <linux/delay.h>
 #include <linux/mm.h>
 #include <asm/checksum.h>
 #include <asm/sections.h>
@@ -12,9 +11,6 @@ EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(__copy_user);
-EXPORT_SYMBOL(__udelay);
-EXPORT_SYMBOL(__ndelay);
-EXPORT_SYMBOL(__const_udelay);
 EXPORT_SYMBOL(strlen);
 EXPORT_SYMBOL(csum_partial);
 EXPORT_SYMBOL(csum_partial_copy_generic);
diff --git a/arch/sh/lib/delay.c b/arch/sh/lib/delay.c
index dad8e6a54906..63cd32550b0c 100644
--- a/arch/sh/lib/delay.c
+++ b/arch/sh/lib/delay.c
@@ -7,6 +7,7 @@
 
 #include <linux/sched.h>
 #include <linux/delay.h>
+#include <linux/export.h>
 
 void __delay(unsigned long loops)
 {
@@ -29,6 +30,7 @@ void __delay(unsigned long loops)
 		: "0" (loops)
 		: "t");
 }
+EXPORT_SYMBOL(__delay);
 
 inline void __const_udelay(unsigned long xloops)
 {
@@ -41,14 +43,16 @@ inline void __const_udelay(unsigned long xloops)
 		: "macl", "mach");
 	__delay(++xloops);
 }
+EXPORT_SYMBOL(__const_udelay);
 
 void __udelay(unsigned long usecs)
 {
 	__const_udelay(usecs * 0x000010c6);  /* 2**32 / 1000000 */
 }
+EXPORT_SYMBOL(__udelay);
 
 void __ndelay(unsigned long nsecs)
 {
 	__const_udelay(nsecs * 0x00000005);
 }
-
+EXPORT_SYMBOL(__ndelay);

