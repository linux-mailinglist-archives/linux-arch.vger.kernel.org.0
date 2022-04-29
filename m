Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF5F514BE3
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 15:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376947AbiD2N6f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 09:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376816AbiD2N5V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 09:57:21 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870D8CEE3D;
        Fri, 29 Apr 2022 06:52:10 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TD2p9K039654;
        Fri, 29 Apr 2022 13:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=VNGUwoqIgPNTFEhWY2Lf2UcR4aFUGIcpOewUJXnDFO4=;
 b=Dqg3thkRTwiOhf8ecJn/JBZt2sT/8rwO1yzpetTKCnu1QYzDzTRRBMfmN8P/L24KBWDZ
 6d145HqubAnD4ug0AOo/jFDVirMyKv/+SPRfDp0znpzGzCNdPOn3bWPDQt4zKywgtyzE
 mCuxk448Gg5NS7BCPkIQPP7lsP9w2FGvVE2faT5GoY3xpJvjLx0wULJXZhRCrSJbof/R
 SgtoUXaHxjv7Z8jGl2qeuTAoDoKZZsBYqS4/OWMPWqBEdkIyHMQ18ihjkFH2Ayw5LDBb
 mmkJCqaiiVfHbAfXuZ+xuFKr290ttrNt5jQVV5yT2UQka2p2dnRkVNGqOGDJ8hpIV5D9 LA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqu6p5156-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:55 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23TDNN6B000908;
        Fri, 29 Apr 2022 13:51:54 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqu6p514j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:54 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TDSl03024613;
        Fri, 29 Apr 2022 13:51:52 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3fm938yacc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:52 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TDpo4H41157084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:51:50 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48B3C4C044;
        Fri, 29 Apr 2022 13:51:50 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5FC24C040;
        Fri, 29 Apr 2022 13:51:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 13:51:49 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>
Subject: [RFC v2 39/39] asm-generic/io.h: drop inb() etc for HAS_IOPORT=n
Date:   Fri, 29 Apr 2022 15:51:08 +0200
Message-Id: <20220429135108.2781579-71-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429135108.2781579-1-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U8mvRsb3-IgdRtH2Oa5uyD55suurNUKX
X-Proofpoint-ORIG-GUID: M7DnpLppfJkDke8JEWqV2JkbZ1xcXkLb
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204290078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With all subsystems and drivers either declaring their dependence on
HAS_IOPORT or ifdeffing I/O port specific code sections we can finally
make inb()/outb() and friends compile-time dependent on HAS_IOPORT as
suggested by Linus in the linked mail. The main benefit of this is that
on platforms such as s390 which have no meaningful way of implementing
inb()/outb() their use without the proper HAS_IOPORT dependency will
result in easy to catch and fix compile-time errors instead of compiling
code that can never work.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/lkml/CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com/
Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 include/asm-generic/io.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 7ce93aaf69f8..b2572b2eab07 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -448,6 +448,7 @@ static inline void writesq(volatile void __iomem *addr, const void *buffer,
 #define IO_SPACE_LIMIT 0xffff
 #endif
 
+#ifdef CONFIG_HAS_IOPORT
 /*
  * {in,out}{b,w,l}() access little endian I/O. {in,out}{b,w,l}_p() can be
  * implemented on hardware that needs an additional delay for I/O accesses to
@@ -522,9 +523,12 @@ static inline void _outl(u32 value, unsigned long addr)
 	__io_paw();
 }
 #endif
+#endif /* CONFIG_HAS_IOPORT */
 
 #include <linux/logic_pio.h>
 
+#ifdef CONFIG_HAS_IOPORT
+
 #ifndef inb
 #define inb _inb
 #endif
@@ -703,6 +707,7 @@ static inline void outsl_p(unsigned long addr, const void *buffer,
 	outsl(addr, buffer, count);
 }
 #endif
+#endif /* CONFIG_HAS_IOPORT */
 
 #ifndef CONFIG_GENERIC_IOMAP
 #ifndef ioread8
-- 
2.32.0

