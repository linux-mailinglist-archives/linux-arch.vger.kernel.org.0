Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F58C28DBA4
	for <lists+linux-arch@lfdr.de>; Wed, 14 Oct 2020 10:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgJNIdq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Oct 2020 04:33:46 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42440 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727766AbgJNIdn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Oct 2020 04:33:43 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09E8Sbj1079320;
        Wed, 14 Oct 2020 08:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=N2brVn+1Poo0Ren9oK0iyu9Zpo2iIS7LndLrg9tk4Ck=;
 b=V73J0TZqdhEaSF8XOaRaygnrm/IXGHIMihqMhoHp3gnoxah4MR3DZeaJO9o/J/648bIV
 oA7UeGBG4mZY14zXCa5jZNZcr5U6asLtkQ8BGa24PpFKnGlsFT+hcla8x7SZ0N00wmav
 1sRqVlnPZ6fPj9qFi1ocDvJBpl4oRkbm+v3J0fzL+Ecy257b++hP4OxFtTeLIQ1oL6kM
 HqiqzwoE2863wunhBjFnyTtzFBslp4hM2bKstlOHvptWK+DCtEV6tBaZYcpfDKcC43SS
 KLbusJwGPY1VeACMbidIVIy9A/DAQUSQnBXzuIVnTVRf80Sq5j4CbwBGu9yQyWGc/U1d BA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 343pajvt6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Oct 2020 08:33:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09E8Tg3N125760;
        Wed, 14 Oct 2020 08:33:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 343php850t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Oct 2020 08:33:21 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09E8XE39000426;
        Wed, 14 Oct 2020 08:33:14 GMT
Received: from monad.ca.oracle.com (/10.156.74.184)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Oct 2020 01:33:13 -0700
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     kirill@shutemov.name, mhocko@kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>, linux-arch@vger.kernel.org
Subject: [PATCH 5/8] x86/clear_page: add clear_page_uncached()
Date:   Wed, 14 Oct 2020 01:32:56 -0700
Message-Id: <20201014083300.19077-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201014083300.19077-1-ankur.a.arora@oracle.com>
References: <20201014083300.19077-1-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010140061
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 malwarescore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010140061
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Define clear_page_uncached() as an alternative_call() to clear_page_nt()
if the CPU sets X86_FEATURE_NT_GOOD and fallback to clear_page() if it
doesn't.

Similarly define clear_page_uncached_flush() which provides an SFENCE
if the CPU sets X86_FEATURE_NT_GOOD.

Also, add the glue interface clear_user_highpage_uncached().

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/page.h    |  6 ++++++
 arch/x86/include/asm/page_32.h |  9 +++++++++
 arch/x86/include/asm/page_64.h | 14 ++++++++++++++
 include/asm-generic/page.h     |  3 +++
 include/linux/highmem.h        | 10 ++++++++++
 5 files changed, 42 insertions(+)

diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index 7555b48803a8..ca0aa379ac7f 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -28,6 +28,12 @@ static inline void clear_user_page(void *page, unsigned long vaddr,
 	clear_page(page);
 }
 
+static inline void clear_user_page_uncached(void *page, unsigned long vaddr,
+					    struct page *pg)
+{
+	clear_page_uncached(page);
+}
+
 static inline void copy_user_page(void *to, void *from, unsigned long vaddr,
 				  struct page *topage)
 {
diff --git a/arch/x86/include/asm/page_32.h b/arch/x86/include/asm/page_32.h
index 94dbd51df58f..7a03a274a9a4 100644
--- a/arch/x86/include/asm/page_32.h
+++ b/arch/x86/include/asm/page_32.h
@@ -39,6 +39,15 @@ static inline void clear_page(void *page)
 	memset(page, 0, PAGE_SIZE);
 }
 
+static inline void clear_page_uncached(void *page)
+{
+	clear_page(page);
+}
+
+static inline void clear_page_uncached_flush(void)
+{
+}
+
 static inline void copy_page(void *to, void *from)
 {
 	memcpy(to, from, PAGE_SIZE);
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index bde3c2785ec4..5897075e77dd 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -55,6 +55,20 @@ static inline void clear_page(void *page)
 			   : "cc", "memory", "rax", "rcx");
 }
 
+static inline void clear_page_uncached(void *page)
+{
+	alternative_call(clear_page,
+			 clear_page_nt, X86_FEATURE_NT_GOOD,
+			 "=D" (page),
+			 "0" (page)
+			 : "cc", "memory", "rax", "rcx");
+}
+
+static inline void clear_page_uncached_flush(void)
+{
+	alternative("", "sfence", X86_FEATURE_NT_GOOD);
+}
+
 void copy_page(void *to, void *from);
 
 #endif	/* !__ASSEMBLY__ */
diff --git a/include/asm-generic/page.h b/include/asm-generic/page.h
index fe801f01625e..60235a0cf24a 100644
--- a/include/asm-generic/page.h
+++ b/include/asm-generic/page.h
@@ -26,6 +26,9 @@
 #ifndef __ASSEMBLY__
 
 #define clear_page(page)	memset((page), 0, PAGE_SIZE)
+#define clear_page_uncached(page)	clear_page(page)
+#define clear_page_uncached_flush()	do { } while (0)
+
 #define copy_page(to,from)	memcpy((to), (from), PAGE_SIZE)
 
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 14e6202ce47f..f842593e2474 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -232,6 +232,16 @@ static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
 }
 #endif
 
+#ifndef clear_user_highpage_uncached
+static inline void clear_user_highpage_uncached(struct page *page, unsigned long vaddr)
+{
+	void *addr = kmap_atomic(page);
+
+	clear_user_page_uncached(addr, vaddr, page);
+	kunmap_atomic(addr);
+}
+#endif
+
 #ifndef __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 /**
  * __alloc_zeroed_user_highpage - Allocate a zeroed HIGHMEM page for a VMA with caller-specified movable GFP flags
-- 
2.9.3

