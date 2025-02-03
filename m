Return-Path: <linux-arch+bounces-9969-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C2DA25A50
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 14:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8889163D30
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 13:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED03C2040B5;
	Mon,  3 Feb 2025 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="bczyINVn";
	dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="h36zBVTP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABEA1FBC83;
	Mon,  3 Feb 2025 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738587820; cv=pass; b=LMyNuewcbztc3dQFRAuXPiUiJliTrf77yy8Eh8K5x6G52r16PVUuK+qb7q0ekbAud+KmkQNkfgLIF7SofENzzJGezmuzsH2IywJf8N50Q+AQxJuUL/rRKHRYq6X5WwGk8YtCfoexYzwboXUobuV+kxlRJbuHRundDxstcSmbxSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738587820; c=relaxed/simple;
	bh=RHkUtKG17hG1dPkkjeDE2eGTAKbcCzISWsfzofxp4bE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=sbjf6H5l0/gxuh7psA8ixFJDjDRf96quJzNTJxT9l2YTZoQ6B4d1+/yURsy3Fx/3UFQ6qxxSRvjMt+mRK86MkVQmJvFXs1d+XzhGkt5fRBRl34LDk9wNFMAFCSl0M36wYy2ffMniAIiDuxwwY+j+sY3cmlQ8Dt4O4M+icvIXO6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outer-limits.org; spf=none smtp.mailfrom=outer-limits.org; dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=bczyINVn; dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=h36zBVTP; arc=pass smtp.client-ip=85.215.255.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=outer-limits.org
ARC-Seal: i=1; a=rsa-sha256; t=1738587809; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jTZtBkM8HFmL8Q3MYW6N6NKG+CruY2jYqImWCpjjroynyJlDCJa6oxWYb8CpWcQMK3
    sxoA0t/zXyRxaFYgNYRVomtNCPRTTipZMH1kdapd/ZuTfJgsHjRzAvsvzi3TFW80yA4n
    ffllKpLJ27vmtOMyoONbicOYfyUfyeIQ49IMXYrQ36V/oyP/fOeAaUglF++njyTWlnm7
    cbSOiXzHKE6UmyH3ElK8dlpNbiU0UogbQz6No1JNhMVM0hRQ2e20xgI9SyYNjHkdTRSC
    SD1IJGbQesTWVAD7hlRwm5aWvYTrFlE1hMKOAQ84qm/mWxdHS2+tbyxo5+yZJihHC7lA
    U03A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1738587809;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=S3lcOqbLJeUcdH7QtYhShHY08A9wLxNxrh3ZChrRuKM=;
    b=gG1lAt4AAfE78J9cN5bF3/mNpBPvj/wXUJTG0e2vxKhBzgHlVaD0oAxX4FwP1WzBNX
    kqK7GsZtdRm4wLB4zrgB8Gl1/nMUI84LadfsA4suwg3rdcaAqULPExU/SSixCcXOUkOa
    XxYRcus5Qwb2kR5p1lnKZ/J+Q8+hnZ+BCJY5i3E+t1jNbiuXjnlGvfCIx9qlbNpAOcJA
    5t8Pwaf9tBDxTVhJsZCBVBsSvDWQ0BYlKt4RxIErvMb2kdWBaAqQBM2NnA1B777tvs03
    AXMJlPazbNrN4BFEAGwM3kO62wY7Qi3hh5P9ZimrRueKmOZBLztYltFoqAlxWDi9XmS5
    M21w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1738587809;
    s=strato-dkim-0002; d=outer-limits.org;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=S3lcOqbLJeUcdH7QtYhShHY08A9wLxNxrh3ZChrRuKM=;
    b=bczyINVnMk+TRcr5wl04LL9g6sDZzBOq4vG/3tzgj84xsCEtcRseVl0/OKmZ3f2A+R
    8cpueMkHtoU0HRuxjm7UJiMvEYJY0eLWXdHjGHn77Qh5kzb6SyWTkOpJ3Z/WTbCKFNqo
    eU7MXuEvT5h85UNAzJ7S7oqPd8wttp3n01w19SHHhjGW3uxtbBR7O7jn1HQZ3Qpy9TWC
    b4tBOCtHqIQdm2kWmAR2R/F3GmdBpyIfjCQGa7dUStKH7MHniUinMBx6nrEf2fogUgtw
    WxavT0W9maS0SxRVCTBicWOWMAzyJBDigcZ+D8cJDaoie1Wgif43ZsktPTvJtAkbEXt/
    OcXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1738587809;
    s=strato-dkim-0003; d=outer-limits.org;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=S3lcOqbLJeUcdH7QtYhShHY08A9wLxNxrh3ZChrRuKM=;
    b=h36zBVTPJk26nt195cFcbEiSC2ijPsyNKMSAgdhWRlVinblAtmcoOSixquenG1rrCp
    +eTFL8NRaZrEgZGLzHAw==
X-RZG-AUTH: ":JnkIfEGmW/AMJS6HttH4FbRVwc4dHlPLCp4e/IoHo8zEMMHAgwTfqBEHcVJSv9P5mRTGd2ImeA=="
Received: from ws2104.lan.kalrayinc.com
    by smtp.strato.de (RZmta 51.2.17 AUTH)
    with ESMTPSA id J1a251113D3TDOh
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 3 Feb 2025 14:03:29 +0100 (CET)
From: Julian Vetter <julian@outer-limits.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Vetter <julian@outer-limits.org>
Subject: [PATCH] asm-generic: allow unaligned buffers in reads/writes{w,l,q}
Date: Mon,  3 Feb 2025 14:03:23 +0100
Message-Id: <20250203130323.8172-1-julian@outer-limits.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Access buffers in reads/writes{w,l,q} via get_unaligned and
put_unaligned, to protect from potential unaligned traps.

Signed-off-by: Julian Vetter <julian@outer-limits.org>
---
 include/asm-generic/io.h | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index a5cbbf3e26ec..920fecd512fc 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -12,6 +12,7 @@
 #include <linux/sizes.h>
 #include <linux/types.h>
 #include <linux/instruction_pointer.h>
+#include <linux/unaligned.h>
 
 #ifdef CONFIG_GENERIC_IOMAP
 #include <asm-generic/iomap.h>
@@ -422,7 +423,8 @@ static inline void readsw(const volatile void __iomem *addr, void *buffer,
 
 		do {
 			u16 x = __raw_readw(addr);
-			*buf++ = x;
+			put_unaligned(x, buf);
+			buf++;
 		} while (--count);
 	}
 }
@@ -438,7 +440,8 @@ static inline void readsl(const volatile void __iomem *addr, void *buffer,
 
 		do {
 			u32 x = __raw_readl(addr);
-			*buf++ = x;
+			put_unaligned(x, buf);
+			buf++;
 		} while (--count);
 	}
 }
@@ -455,7 +458,8 @@ static inline void readsq(const volatile void __iomem *addr, void *buffer,
 
 		do {
 			u64 x = __raw_readq(addr);
-			*buf++ = x;
+			put_unaligned(x, buf);
+			buf++;
 		} while (--count);
 	}
 }
@@ -486,7 +490,9 @@ static inline void writesw(volatile void __iomem *addr, const void *buffer,
 		const u16 *buf = buffer;
 
 		do {
-			__raw_writew(*buf++, addr);
+			u16 val = get_unaligned(buf);
+			__raw_writew(val, addr);
+			buf++;
 		} while (--count);
 	}
 }
@@ -501,7 +507,9 @@ static inline void writesl(volatile void __iomem *addr, const void *buffer,
 		const u32 *buf = buffer;
 
 		do {
-			__raw_writel(*buf++, addr);
+			u32 val = get_unaligned(buf);
+			__raw_writel(val, addr);
+			buf++;
 		} while (--count);
 	}
 }
@@ -517,7 +525,9 @@ static inline void writesq(volatile void __iomem *addr, const void *buffer,
 		const u64 *buf = buffer;
 
 		do {
-			__raw_writeq(*buf++, addr);
+			u64 val = get_unaligned(buf);
+			__raw_writeq(val, addr);
+			buf++;
 		} while (--count);
 	}
 }
-- 
2.34.1


