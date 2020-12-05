Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703122CFA13
	for <lists+linux-arch@lfdr.de>; Sat,  5 Dec 2020 07:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgLEG6j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Dec 2020 01:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgLEG6j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Dec 2020 01:58:39 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DDBC061A52;
        Fri,  4 Dec 2020 22:57:53 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id b26so5359273pfi.3;
        Fri, 04 Dec 2020 22:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wf66xeGBT+zLBJ325IKif/6Ivp+txfeM6xGRJ6CQfBE=;
        b=fcGKhIppJJa4HGaXNdZBhdNLob29Ivf9BES+4C8PfV5PbxTaC14ALc7yzgbzTh1Cf2
         LjY1qEbDYZiXN0mvRHB9kiU1bHI8141d6FpINWNGUwiZuAMlwJh7UbCitM0jugtSzM+e
         uuVzySGmGdz/Yxt1V7K/3YHoHcW8tcgLe1Yp12EMc82n5ttvwmI/rb1/KAYWS1plwtbs
         C3P/hnxWcEW+9SZQ68McBxZbgcmjUDMkfkRVryruxzpH8n3TAVWd3jxOUtaInOlv1kWv
         90Gz53+ICxtmSLTNCU1YyD9uSx4stnX42USHoS8I9tMkYSCB4FkeuO7N/K7et3LRpziZ
         MFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wf66xeGBT+zLBJ325IKif/6Ivp+txfeM6xGRJ6CQfBE=;
        b=HrnUl+w1j+hmGtIb2s4wFL1PppAIXGpxu1THjTV+9CDWcGW9XdtB9jqX8ADbldRT8i
         MngyDLySH0sP/py9IY+i+GqFIYJAi2RxKGk8KAQWJmMehV/z5AZwNmR7VxIyW3BonhNm
         woFCO/3kQKXpjr3O7VtoLJ4P3j6dJwzlwxeZfGur5XV0iniICsBroPByKnJoqzeM4xnP
         t45wrtO2KGkrQSm8Y4OIrBeHw3r2ZEFvbmHq5BJ+QOCexuF7sZonrG1+V2XY+E2zfMCk
         GCrrws51Jtq61m6ZQOI3XaARD4Xc4rnKpQimalvRiuiZEdS6JE27zy8GL5bsCZyZfFIN
         4pTA==
X-Gm-Message-State: AOAM533DWO7aqi26saTyXEy5li57DqFVfZKuXwGulXMdOoSeSIsi3uYr
        KPMABYSeEZzDX6dp3ynHGmvltbVsm9xBjg==
X-Google-Smtp-Source: ABdhPJxONuxdsKc3Y9tSWgtmcHfGYtNDoscWaaTlNa/hUFWSKu5YHYgn5z4+YBtAOkosOqfGAZt7dA==
X-Received: by 2002:a62:ab13:0:b029:197:ca83:7720 with SMTP id p19-20020a62ab130000b0290197ca837720mr7159021pff.78.1607151472903;
        Fri, 04 Dec 2020 22:57:52 -0800 (PST)
Received: from bobo.ozlabs.ibm.com ([1.129.145.238])
        by smtp.gmail.com with ESMTPSA id a14sm1110848pfl.141.2020.12.04.22.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 22:57:52 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v9 03/12] mm/vmalloc: rename vmap_*_range vmap_pages_*_range
Date:   Sat,  5 Dec 2020 16:57:16 +1000
Message-Id: <20201205065725.1286370-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201205065725.1286370-1-npiggin@gmail.com>
References: <20201205065725.1286370-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The vmalloc mapper operates on a struct page * array rather than a
linear physical address, re-name it to make this distinction clear.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/vmalloc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index f85124e88bdb..42326dbffaf0 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -189,7 +189,7 @@ void unmap_kernel_range_noflush(unsigned long start, unsigned long size)
 		arch_sync_kernel_mappings(start, end);
 }
 
-static int vmap_pte_range(pmd_t *pmd, unsigned long addr,
+static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
 		pgtbl_mod_mask *mask)
 {
@@ -217,7 +217,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr,
 	return 0;
 }
 
-static int vmap_pmd_range(pud_t *pud, unsigned long addr,
+static int vmap_pages_pmd_range(pud_t *pud, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
 		pgtbl_mod_mask *mask)
 {
@@ -229,13 +229,13 @@ static int vmap_pmd_range(pud_t *pud, unsigned long addr,
 		return -ENOMEM;
 	do {
 		next = pmd_addr_end(addr, end);
-		if (vmap_pte_range(pmd, addr, next, prot, pages, nr, mask))
+		if (vmap_pages_pte_range(pmd, addr, next, prot, pages, nr, mask))
 			return -ENOMEM;
 	} while (pmd++, addr = next, addr != end);
 	return 0;
 }
 
-static int vmap_pud_range(p4d_t *p4d, unsigned long addr,
+static int vmap_pages_pud_range(p4d_t *p4d, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
 		pgtbl_mod_mask *mask)
 {
@@ -247,13 +247,13 @@ static int vmap_pud_range(p4d_t *p4d, unsigned long addr,
 		return -ENOMEM;
 	do {
 		next = pud_addr_end(addr, end);
-		if (vmap_pmd_range(pud, addr, next, prot, pages, nr, mask))
+		if (vmap_pages_pmd_range(pud, addr, next, prot, pages, nr, mask))
 			return -ENOMEM;
 	} while (pud++, addr = next, addr != end);
 	return 0;
 }
 
-static int vmap_p4d_range(pgd_t *pgd, unsigned long addr,
+static int vmap_pages_p4d_range(pgd_t *pgd, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
 		pgtbl_mod_mask *mask)
 {
@@ -265,7 +265,7 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr,
 		return -ENOMEM;
 	do {
 		next = p4d_addr_end(addr, end);
-		if (vmap_pud_range(p4d, addr, next, prot, pages, nr, mask))
+		if (vmap_pages_pud_range(p4d, addr, next, prot, pages, nr, mask))
 			return -ENOMEM;
 	} while (p4d++, addr = next, addr != end);
 	return 0;
@@ -306,7 +306,7 @@ int map_kernel_range_noflush(unsigned long addr, unsigned long size,
 		next = pgd_addr_end(addr, end);
 		if (pgd_bad(*pgd))
 			mask |= PGTBL_PGD_MODIFIED;
-		err = vmap_p4d_range(pgd, addr, next, prot, pages, &nr, &mask);
+		err = vmap_pages_p4d_range(pgd, addr, next, prot, pages, &nr, &mask);
 		if (err)
 			return err;
 	} while (pgd++, addr = next, addr != end);
-- 
2.23.0

