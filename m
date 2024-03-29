Return-Path: <linux-arch+bounces-3342-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA51189323E
	for <lists+linux-arch@lfdr.de>; Sun, 31 Mar 2024 18:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1FE282ACA
	for <lists+linux-arch@lfdr.de>; Sun, 31 Mar 2024 16:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D98146A66;
	Sun, 31 Mar 2024 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0N/h/M4o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pmoyIzmQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18186146012;
	Sun, 31 Mar 2024 16:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711900929; cv=pass; b=rSA6sr2tSLig6ygjz6i+V8jeQykMAQk4i/Ka7mPWWjIjPq+fIlfRA7cYqHpSeao4oipip8nZoXWNwTPcgSkNL9e4Qi0EWjXTjFlVArueoDck/rSxabEoBr9hc22hOMIycXfxuB6gP3PajSx3M34m4OSmmoCoQ7R5BMq4DRAfcYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711900929; c=relaxed/simple;
	bh=1F3bC9AfluAx91aimWFrXnEkMkyhFJNbxwKmrZG2b8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1/wcAjOkvCam+LHS5CCQrQEyQePg8dPQK1E65JpRtXshEqTiIs9BFQEeg8zZ6ioVZUftL7HnW33e8wpQZ/5jkE2f137RrlU8e1Vi8X//dd1n04W6ryHhOskiTBu4RYOrRNn2mYVMgOZZakqmqEwgNuShZkp3375UPwzih401nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=fail smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0N/h/M4o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pmoyIzmQ; arc=none smtp.client-ip=195.135.223.130; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.de
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 83AFF2083B;
	Sun, 31 Mar 2024 18:02:05 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GGDmlquZ0rfe; Sun, 31 Mar 2024 18:02:04 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 7AD1320847;
	Sun, 31 Mar 2024 18:02:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 7AD1320847
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 6B52E80004A;
	Sun, 31 Mar 2024 18:02:03 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:02:03 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 15:52:40 +0000
X-sender: <linux-kernel+bounces-125395-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAqwprGbMv3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAYgAKAHwAAADKigAABQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-ESSEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 19630
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125395-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 6546C20270
Authentication-Results: b.mx.secunet.com;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0N/h/M4o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pmoyIzmQ"
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711744502; cv=none; b=fjcYnOCS7m7++i3mArJETlO99jp5LHVpDekfQ1dZyeMRjBF0Cpe2hAUeUh2A4DcERRQvb3/72zlFOhXnasMv3uwJDatB2vi6zhTUazXTg8DkWm3iACGEOAO17G8ZyrRSvG2VBCQOb1TYOIZ8Ue6RVuO2+O0Zb7+44GJq7IXaYNk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711744502; c=relaxed/simple;
	bh=1F3bC9AfluAx91aimWFrXnEkMkyhFJNbxwKmrZG2b8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5m4m4klNzHchv/BCT9LAxOunHNrRG5DniTGhZxfquKU2Y+5GL5EBmjVQhVT8gyUxaqW9x8dKZHhDQyqbgpeTkCOlH0oaYaAi2JgP+/hXICleYyN1nG/9uDj6lqzsMNni7Vl6viIdW0A3GDviyJB4Ixk0z4xyDAK1WJnM3JMMzg=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0N/h/M4o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pmoyIzmQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711744499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MEcgOTyAQAoXByBYKUR2lBKOa8ZhmGZAbpGTc5urdcs=;
	b=0N/h/M4oFKP9e6JE78XEh1S/v6uJSKh1uvA1wPsCajar4AYYVB5MtoSQURwicU0FjTA3ZA
	61MBm+lwJkoVB7qIrNvH3IDBG4ar+09OTaZYiATVbRQqTa3K+2VbkUVT17xAR/I3rqyXWN
	Z87CE1W9k4JpKCgCEwSFnBh/TZXfcOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711744499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MEcgOTyAQAoXByBYKUR2lBKOa8ZhmGZAbpGTc5urdcs=;
	b=pmoyIzmQMCIpxEEegRU389t/9HfEGPbkrxeN/Z4w3PlV59F1yC09nX/ACLDPrFrN/Qx5Ay
	FEGw4evB+gjhIACQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
From: Thomas Zimmermann <tzimmermann@suse.de>
To: arnd@arndb.de,
	sam@ravnborg.org,
	javierm@redhat.com,
	deller@gmx.de,
	sui.jingfeng@linux.dev
Cc: linux-arch@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-parisc@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	loongarch@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-snps-arc@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 1/3] arch: Select fbdev helpers with CONFIG_VIDEO
Date: Fri, 29 Mar 2024 21:32:10 +0100
Message-ID: <20240329203450.7824-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329203450.7824-1-tzimmermann@suse.de>
References: <20240329203450.7824-1-tzimmermann@suse.de>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++
X-Spamd-Result: default: False [2.89 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.de];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_TWELVE(0.00)[28];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,intel.com:email];
	 FREEMAIL_TO(0.00)[arndb.de,ravnborg.org,redhat.com,gmx.de,linux.dev];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EFC633528A
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Various Kconfig options selected the per-architecture helpers for
fbdev. But none of the contained code depends on fbdev. Standardize
on CONFIG_VIDEO, which will allow to add more general helpers for
video functionality.

CONFIG_VIDEO protects each architecture's video/ directory. This
allows for the use of more fine-grained control for each directory's
files, such as the use of CONFIG_STI_CORE on parisc.

v2:
- sparc: rebased onto Makefile changes

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/parisc/Makefile      | 2 +-
 arch/sparc/Makefile       | 4 ++--
 arch/sparc/video/Makefile | 2 +-
 arch/x86/Makefile         | 2 +-
 arch/x86/video/Makefile   | 3 ++-
 5 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index 316f84f1d15c8..21b8166a68839 100644
--- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -119,7 +119,7 @@ export LIBGCC
 
 libs-y	+= arch/parisc/lib/ $(LIBGCC)
 
-drivers-y += arch/parisc/video/
+drivers-$(CONFIG_VIDEO) += arch/parisc/video/
 
 boot	:= arch/parisc/boot
 
diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index 2a03daa68f285..757451c3ea1df 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -59,8 +59,8 @@ endif
 libs-y                 += arch/sparc/prom/
 libs-y                 += arch/sparc/lib/
 
-drivers-$(CONFIG_PM) += arch/sparc/power/
-drivers-$(CONFIG_FB_CORE) += arch/sparc/video/
+drivers-$(CONFIG_PM)    += arch/sparc/power/
+drivers-$(CONFIG_VIDEO) += arch/sparc/video/
 
 boot := arch/sparc/boot
 
diff --git a/arch/sparc/video/Makefile b/arch/sparc/video/Makefile
index d4d83f1702c61..9dd82880a027a 100644
--- a/arch/sparc/video/Makefile
+++ b/arch/sparc/video/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-$(CONFIG_FB_CORE) += fbdev.o
+obj-y	+= fbdev.o
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 662d9d4033e6b..b80d15c29ecc6 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -260,7 +260,7 @@ drivers-$(CONFIG_PCI)            += arch/x86/pci/
 # suspend and hibernation support
 drivers-$(CONFIG_PM) += arch/x86/power/
 
-drivers-$(CONFIG_FB_CORE) += arch/x86/video/
+drivers-$(CONFIG_VIDEO) += arch/x86/video/
 
 ####
 # boot loader support. Several targets are kept for legacy purposes
diff --git a/arch/x86/video/Makefile b/arch/x86/video/Makefile
index 5ebe48752ffc4..9dd82880a027a 100644
--- a/arch/x86/video/Makefile
+++ b/arch/x86/video/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_FB_CORE)		+= fbdev.o
+
+obj-y	+= fbdev.o
-- 
2.44.0



