Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D10226FD5C
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 14:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgIRMri (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 08:47:38 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:55965 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgIRMq4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 08:46:56 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mr8zO-1knLTA2coI-00oGkp; Fri, 18 Sep 2020 14:46:34 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christoph Hellwig <hch@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 1/9] mm/maccess: fix unaligned copy_{from,to}_kernel_nofault
Date:   Fri, 18 Sep 2020 14:46:16 +0200
Message-Id: <20200918124624.1469673-2-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200918124624.1469673-1-arnd@arndb.de>
References: <20200918124624.1469673-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:aM+IxhTWQ8zLEy6I5xMM14Ev05fAqzi2N6KWBwjGmrTs5WlEUtT
 h3d/Ek0+MD7Kg+UFacJgz6oWfZKeIYwr4MM2bOz3usLS6zOvlxqXzO+j1mOgipiLpoWR2SD
 5K6CrFeWW5//N3cy9JMAg2AO19WmtU3iNg006du/rVt/cP2Aa1dqQ0+GdFtoh+I1fO8EW4r
 aTvEWserNBkjpzkGWOOuQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:t7msc0UXfsQ=:yaYfo6Eb6GxlQw0v2fCfgT
 qfpkjhEkog+a5swVrJWRLI0F60ZAoQa+U72qb8Dm4gq3x2tUgEn4wddszH62L6tjKGbUgg0ma
 vv2qlf2F5gMIXlIEKTRPr7MP0E7h658vOczUAtSP9ULseis7pnmHdXl5mY1o8bv6x2h+moCol
 pUZKxC2avRCwspOZYSqaWOJqTaecq5Kp5j38nJIpwfH7GepL4JmeElY6K+prcigvu2b/KGzLt
 rzR8UxhOt3ILMlL4zIcQ83t35YaRRce7iFh29RIWWV5RGuo7GS2sPr0Xqm0NCLNd5xsJirFmH
 d6q07QmGQzg9HIkWjyEz6ochFwmR8Bbds6hT8jb+LYefWbdMwlEaG3yebGqvR2AbSgrAGySGx
 bwgquAH3VI8ifEi31v601nWLoPohbfUDjLLvxZP/ud2cPnJFir3ntvThVPvaxEhpFrZJbvimP
 u2wy7qe9bqtokp4OHIx5D8mqu0XpgDYFq//rCsYqg+1jifdcfcSomDujlg45g0eM9fgCXDG68
 Gn54qF2GMix5PSMOWWE+IQxHzRQXj5GUghUjAG/wxM2JD+juq6t9ul7AJKeotoue5gtBfVEJe
 92lmPtwB87ccXhEbD6OrywRci3W5jl3s6YwNIgsv6XQU7/UjOa7Gz4fpNDIm5dktfQwfjFUXv
 nayGdJc/vWr86qx+LItPMChsRCRpcyHqxxA/esHHJeCeyohXYCseWppKuP/1f2hAAkq8BIGy4
 Uj337rpz5iNoUmGJU2x/XjiYqPziCVKKhjYFv6Tg/SL4BO0pV6d8l2eBrFUJiVpY6GlcjXKdz
 3yxbq0G6dBJ/N50FfWidrUtiDKawO2xbzBq8KoqXgMPql3f1q2P6a17UKjqNjxNFnjrnBkd
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On machines such as ARMv5 that trap unaligned accesses, these
two functions can be slow when each access needs to be emulated,
or they might not work at all.

Change them so that each loop is only used when both the src
and dst pointers are naturally aligned.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/maccess.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/mm/maccess.c b/mm/maccess.c
index 3bd70405f2d8..d3f1a1f0b1c1 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -24,13 +24,21 @@ bool __weak copy_from_kernel_nofault_allowed(const void *unsafe_src,
 
 long copy_from_kernel_nofault(void *dst, const void *src, size_t size)
 {
+	unsigned long align = 0;
+
+	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
+		align = (unsigned long)dst | (unsigned long)src;
+
 	if (!copy_from_kernel_nofault_allowed(src, size))
 		return -ERANGE;
 
 	pagefault_disable();
-	copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
-	copy_from_kernel_nofault_loop(dst, src, size, u32, Efault);
-	copy_from_kernel_nofault_loop(dst, src, size, u16, Efault);
+	if (!(align & 7))
+		copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
+	if (!(align & 3))
+		copy_from_kernel_nofault_loop(dst, src, size, u32, Efault);
+	if (!(align & 1))
+		copy_from_kernel_nofault_loop(dst, src, size, u16, Efault);
 	copy_from_kernel_nofault_loop(dst, src, size, u8, Efault);
 	pagefault_enable();
 	return 0;
@@ -50,10 +58,18 @@ EXPORT_SYMBOL_GPL(copy_from_kernel_nofault);
 
 long copy_to_kernel_nofault(void *dst, const void *src, size_t size)
 {
+	unsigned long align = 0;
+
+	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
+		align = (unsigned long)dst | (unsigned long)src;
+
 	pagefault_disable();
-	copy_to_kernel_nofault_loop(dst, src, size, u64, Efault);
-	copy_to_kernel_nofault_loop(dst, src, size, u32, Efault);
-	copy_to_kernel_nofault_loop(dst, src, size, u16, Efault);
+	if (!(align & 7))
+		copy_to_kernel_nofault_loop(dst, src, size, u64, Efault);
+	if (!(align & 3))
+		copy_to_kernel_nofault_loop(dst, src, size, u32, Efault);
+	if (!(align & 1))
+		copy_to_kernel_nofault_loop(dst, src, size, u16, Efault);
 	copy_to_kernel_nofault_loop(dst, src, size, u8, Efault);
 	pagefault_enable();
 	return 0;
-- 
2.27.0

