Return-Path: <linux-arch+bounces-1801-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C98841367
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 20:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD451C23C05
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 19:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD8E76051;
	Mon, 29 Jan 2024 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WN71L1hV"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE7E76021;
	Mon, 29 Jan 2024 19:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556412; cv=none; b=rHpbNX6jqvsvuOtIZAFI3d3Ey/PfQy4C71BVKpaXWZU+vVwRCBt5PLoVYUFH5CzHqN7zE0q5axc1rr11dPcmcV8FWOm0ygrx6Q/+wsISG4rjqPdwm5G+KL4d/sOs8Z9ukiUqpvV8lZ6oyL7iX1TuJmCjzZaxu1Fw+YxcFbfZjEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556412; c=relaxed/simple;
	bh=6OCiC4FJvH1puMIfLD93cYqmFZGQ2Vf7xz9Nc/cNcoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BP2tI5p0bl+9kt5fPTzX/XDCTEt6BGogl2hSU1CmlIb1BBWFGWbkSUZBkyJtq6mgVN7SAfmb35tsKiNnx2BuVUj9cuHchNh7Q7hU4U+b1n7pq4sAIeIg3yNWw1mnrZSyTCvo1slWoMPDAECWalFt6FV36sui/1HZQZrcmGxXM0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WN71L1hV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XXYS9TkQoqVsA2/j1ZpPOarxxbCcsVezOFnQzSRmewI=; b=WN71L1hVDnV73rQGCe1x5FDleW
	sYb7DdMVHM89sqGnrR8vPtZ42XF+EMe6oLumSmpBaMuumjyo0bVPr1jOZQ+pkQka9LWJxnttcRoem
	o/vLR1aYBMIEJWGTZjvKZrJ5UyBukiVjgoKSyLUobeGB/dh3TFhWIvigEoA0qj2DDRU4/u53tMNrb
	O2xqnDzgVPu5uph/EIkrWgP2fwZOBkZiOOOlTFwwhubcq7RK8T3ihZmgIufg3j4fghnMn0+f73Pix
	vV8CxxXfbCPq+3epwL3Gk6KR/WMde16v5toaOz3R8VWp9KJHUm85V+GpRoutqFZOkdZP92HENVO4z
	PAMtEV7g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUXHN-0000000E67l-2blY;
	Mon, 29 Jan 2024 19:26:49 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: masahiroy@kernel.org,
	deller@gmx.de
Cc: mcgrof@kernel.org,
	arnd@arndb.de,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] modules: Ensure 64-bit alignment on __ksymtab_* sections
Date: Mon, 29 Jan 2024 11:26:41 -0800
Message-ID: <20240129192644.3359978-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129192644.3359978-1-mcgrof@kernel.org>
References: <20240129192644.3359978-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

From: Helge Deller <deller@gmx.de>

On 64-bit architectures without CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
(e.g. ppc64, ppc64le, parisc, s390x,...) the __KSYM_REF() macro stores
64-bit pointers into the __ksymtab* sections.
Make sure that those sections will be correctly aligned at module link time,
otherwise unaligned memory accesses may happen at runtime.

The __kcrctab* sections store 32-bit entities, so use ALIGN(4) for those.

Testing with the kallsyms selftest on x86_64 we see a savings of about
1,958,153 ns in the worst case which may or not be within noise. Testing
on parisc would be useful and welcomed.

On x86_64 before:

 Performance counter stats for '/sbin/modprobe test_kallsyms_b':

        86,430,119 ns   duration_time
        84,407,000 ns   system_time
               213      page-faults

       0.086430119 seconds time elapsed

       0.000000000 seconds user
       0.084407000 seconds sys

 Performance counter stats for '/sbin/modprobe test_kallsyms_b':

        85,777,474 ns   duration_time
        82,581,000 ns   system_time
               212      page-faults

       0.085777474 seconds time elapsed

       0.000000000 seconds user
       0.082581000 seconds sys

 Performance counter stats for '/sbin/modprobe test_kallsyms_b':

        87,906,053 ns   duration_time
        87,939,000 ns   system_time
               212      page-faults

       0.087906053 seconds time elapsed

       0.000000000 seconds user
       0.087939000 seconds sys

After:

 Performance counter stats for '/sbin/modprobe test_kallsyms_b':

        82,925,631 ns   duration_time
        83,000,000 ns   system_time
               212      page-faults

       0.082925631 seconds time elapsed

       0.000000000 seconds user
       0.083000000 seconds sys

 Performance counter stats for '/sbin/modprobe test_kallsyms_b':

        87,776,380 ns   duration_time
        86,678,000 ns   system_time
               213      page-faults

       0.087776380 seconds time elapsed

       0.000000000 seconds user
       0.086678000 seconds sys

 Performance counter stats for '/sbin/modprobe test_kallsyms_b':

        85,947,900 ns   duration_time
        82,006,000 ns   system_time
               212      page-faults

       0.085947900 seconds time elapsed

       0.000000000 seconds user
       0.082006000 seconds sys

Signed-off-by: Helge Deller <deller@gmx.de>
[mcgrof: ran kallsyms selftests on x86_64]
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 scripts/module.lds.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index bf5bcf2836d8..b00415a9ff27 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -15,10 +15,10 @@ SECTIONS {
 		*(.discard.*)
 	}
 
-	__ksymtab		0 : { *(SORT(___ksymtab+*)) }
-	__ksymtab_gpl		0 : { *(SORT(___ksymtab_gpl+*)) }
-	__kcrctab		0 : { *(SORT(___kcrctab+*)) }
-	__kcrctab_gpl		0 : { *(SORT(___kcrctab_gpl+*)) }
+	__ksymtab		0 : ALIGN(8) { *(SORT(___ksymtab+*)) }
+	__ksymtab_gpl		0 : ALIGN(8) { *(SORT(___ksymtab_gpl+*)) }
+	__kcrctab		0 : ALIGN(4) { *(SORT(___kcrctab+*)) }
+	__kcrctab_gpl		0 : ALIGN(4) { *(SORT(___kcrctab_gpl+*)) }
 
 	.ctors			0 : ALIGN(8) { *(SORT(.ctors.*)) *(.ctors) }
 	.init_array		0 : ALIGN(8) { *(SORT(.init_array.*)) *(.init_array) }
-- 
2.42.0


