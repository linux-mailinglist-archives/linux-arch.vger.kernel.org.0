Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692F6601131
	for <lists+linux-arch@lfdr.de>; Mon, 17 Oct 2022 16:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiJQOfa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Oct 2022 10:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiJQOf3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Oct 2022 10:35:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617C060CB4;
        Mon, 17 Oct 2022 07:35:24 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29H8TjJR004305;
        Mon, 17 Oct 2022 14:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=FtyycUyuhKYBmGn7UTv66U5oqNOHt1B89jo+XcBIFQA=;
 b=RprYx8Yt1s/ZPcnYQImPi3YchV1STq+lWLl1n4wsSl9KZlNQda91pKxg9bKodxLuFwey
 W+k+BsxJ1Aj18SRFDv6kvB/UnZ2vtL8Jh13togrAOJaYIhnpycK8cIcoobOFXP3dOlyw
 Qemo5fIqnSJkjQeh3JHyS7svm7acoHC0DIrCHduj3ilLB5hVVFCGJ0BMwgwXqvKe5Eiv
 m3ey3VdqgEFPlPwLJS5TVzAehOPveX75INDXQR1uD00hWzrIzQBlcqBWs/2ovCeyxMX0
 KB5jlknPJjW2kRin2vloOkYKD5URcmXg17eE+Y3sV9mbgbNf5dzxBGiGbLqzr9E73MCR LA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k7ku0e0dx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 14:35:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29HEZ8e8016139
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 14:35:08 GMT
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 17 Oct 2022 07:35:05 -0700
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <quic_satyap@quicinc.com>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Subject: [PATCH] asm-generic/io: Add _RET_IP_ to MMIO trace for more accurate debug info
Date:   Mon, 17 Oct 2022 20:04:50 +0530
Message-ID: <20221017143450.9161-1-quic_saipraka@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Y7-gMlcWk6-UNhRYZtTDNsGML83d-YC8
X-Proofpoint-ORIG-GUID: Y7-gMlcWk6-UNhRYZtTDNsGML83d-YC8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_11,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=974
 lowpriorityscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210170084
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Due to compiler optimizations like inlining, there are cases where
MMIO traces using _THIS_IP_ for caller information might not be
sufficient to provide accurate debug traces.

1) With optimizations (Seen with GCC):

In this case, _THIS_IP_ works fine and prints the caller information
since it will be inlined into the caller and we get the debug traces
on who made the MMIO access, for ex:

rwmmio_read: qcom_smmu_tlb_sync+0xe0/0x1b0 width=32 addr=0xffff8000087447f4
rwmmio_post_read: qcom_smmu_tlb_sync+0xe0/0x1b0 width=32 val=0x0 addr=0xffff8000087447f4

2) Without optimizations (Seen with Clang):

_THIS_IP_ will not be sufficient in this case as it will print only
the MMIO accessors itself which is of not much use since it is not
inlined as below for example:

rwmmio_read: readl+0x4/0x80 width=32 addr=0xffff8000087447f4
rwmmio_post_read: readl+0x48/0x80 width=32 val=0x4 addr=0xffff8000087447f4

So in order to handle this second case as well irrespective of the compiler
optimizations, add _RET_IP_ to MMIO trace to make it provide more accurate
debug information in all these scenarios.

Before:

rwmmio_read: readl+0x4/0x80 width=32 addr=0xffff8000087447f4
rwmmio_post_read: readl+0x48/0x80 width=32 val=0x4 addr=0xffff8000087447f4

After:

rwmmio_read: qcom_smmu_tlb_sync+0xe0/0x1b0 -> readl+0x4/0x80 width=32 addr=0xffff8000087447f4
rwmmio_post_read: qcom_smmu_tlb_sync+0xe0/0x1b0 -> readl+0x4/0x80 width=32 val=0x0 addr=0xffff8000087447f4

Fixes: 210031971cdd ("asm-generic/io: Add logging support for MMIO accessors")
Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
---
 include/asm-generic/io.h      | 80 +++++++++++++++++------------------
 include/trace/events/rwmmio.h | 43 ++++++++++++-------
 lib/trace_readwrite.c         | 16 +++----
 3 files changed, 75 insertions(+), 64 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index a68f8fbf423b..4c44a29b5e8e 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -80,24 +80,24 @@ DECLARE_TRACEPOINT(rwmmio_read);
 DECLARE_TRACEPOINT(rwmmio_post_read);
 
 void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
-		    unsigned long caller_addr);
+		    unsigned long caller_addr, unsigned long caller_addr0);
 void log_post_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
-			 unsigned long caller_addr);
+			 unsigned long caller_addr, unsigned long caller_addr0);
 void log_read_mmio(u8 width, const volatile void __iomem *addr,
-		   unsigned long caller_addr);
+		   unsigned long caller_addr, unsigned long caller_addr0);
 void log_post_read_mmio(u64 val, u8 width, const volatile void __iomem *addr,
-			unsigned long caller_addr);
+			unsigned long caller_addr, unsigned long caller_addr0);
 
 #else
 
 static inline void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
-				  unsigned long caller_addr) {}
+				  unsigned long caller_addr, unsigned long caller_addr0) {}
 static inline void log_post_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
-				       unsigned long caller_addr) {}
+				       unsigned long caller_addr, unsigned long caller_addr0) {}
 static inline void log_read_mmio(u8 width, const volatile void __iomem *addr,
-				 unsigned long caller_addr) {}
+				 unsigned long caller_addr, unsigned long caller_addr0) {}
 static inline void log_post_read_mmio(u64 val, u8 width, const volatile void __iomem *addr,
-				      unsigned long caller_addr) {}
+				      unsigned long caller_addr, unsigned long caller_addr0) {}
 
 #endif /* CONFIG_TRACE_MMIO_ACCESS */
 
@@ -188,11 +188,11 @@ static inline u8 readb(const volatile void __iomem *addr)
 {
 	u8 val;
 
-	log_read_mmio(8, addr, _THIS_IP_);
+	log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
 	__io_br();
 	val = __raw_readb(addr);
 	__io_ar(val);
-	log_post_read_mmio(val, 8, addr, _THIS_IP_);
+	log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -203,11 +203,11 @@ static inline u16 readw(const volatile void __iomem *addr)
 {
 	u16 val;
 
-	log_read_mmio(16, addr, _THIS_IP_);
+	log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
 	__io_br();
 	val = __le16_to_cpu((__le16 __force)__raw_readw(addr));
 	__io_ar(val);
-	log_post_read_mmio(val, 16, addr, _THIS_IP_);
+	log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -218,11 +218,11 @@ static inline u32 readl(const volatile void __iomem *addr)
 {
 	u32 val;
 
-	log_read_mmio(32, addr, _THIS_IP_);
+	log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
 	__io_br();
 	val = __le32_to_cpu((__le32 __force)__raw_readl(addr));
 	__io_ar(val);
-	log_post_read_mmio(val, 32, addr, _THIS_IP_);
+	log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -234,11 +234,11 @@ static inline u64 readq(const volatile void __iomem *addr)
 {
 	u64 val;
 
-	log_read_mmio(64, addr, _THIS_IP_);
+	log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
 	__io_br();
 	val = __le64_to_cpu(__raw_readq(addr));
 	__io_ar(val);
-	log_post_read_mmio(val, 64, addr, _THIS_IP_);
+	log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -248,11 +248,11 @@ static inline u64 readq(const volatile void __iomem *addr)
 #define writeb writeb
 static inline void writeb(u8 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 8, addr, _THIS_IP_);
+	log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
 	__io_bw();
 	__raw_writeb(value, addr);
 	__io_aw();
-	log_post_write_mmio(value, 8, addr, _THIS_IP_);
+	log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 
@@ -260,11 +260,11 @@ static inline void writeb(u8 value, volatile void __iomem *addr)
 #define writew writew
 static inline void writew(u16 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 16, addr, _THIS_IP_);
+	log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
 	__io_bw();
 	__raw_writew((u16 __force)cpu_to_le16(value), addr);
 	__io_aw();
-	log_post_write_mmio(value, 16, addr, _THIS_IP_);
+	log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 
@@ -272,11 +272,11 @@ static inline void writew(u16 value, volatile void __iomem *addr)
 #define writel writel
 static inline void writel(u32 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 32, addr, _THIS_IP_);
+	log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
 	__io_bw();
 	__raw_writel((u32 __force)__cpu_to_le32(value), addr);
 	__io_aw();
-	log_post_write_mmio(value, 32, addr, _THIS_IP_);
+	log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 
@@ -285,11 +285,11 @@ static inline void writel(u32 value, volatile void __iomem *addr)
 #define writeq writeq
 static inline void writeq(u64 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 64, addr, _THIS_IP_);
+	log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
 	__io_bw();
 	__raw_writeq(__cpu_to_le64(value), addr);
 	__io_aw();
-	log_post_write_mmio(value, 64, addr, _THIS_IP_);
+	log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 #endif /* CONFIG_64BIT */
@@ -305,9 +305,9 @@ static inline u8 readb_relaxed(const volatile void __iomem *addr)
 {
 	u8 val;
 
-	log_read_mmio(8, addr, _THIS_IP_);
+	log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
 	val = __raw_readb(addr);
-	log_post_read_mmio(val, 8, addr, _THIS_IP_);
+	log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -318,9 +318,9 @@ static inline u16 readw_relaxed(const volatile void __iomem *addr)
 {
 	u16 val;
 
-	log_read_mmio(16, addr, _THIS_IP_);
+	log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
 	val = __le16_to_cpu(__raw_readw(addr));
-	log_post_read_mmio(val, 16, addr, _THIS_IP_);
+	log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -331,9 +331,9 @@ static inline u32 readl_relaxed(const volatile void __iomem *addr)
 {
 	u32 val;
 
-	log_read_mmio(32, addr, _THIS_IP_);
+	log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
 	val = __le32_to_cpu(__raw_readl(addr));
-	log_post_read_mmio(val, 32, addr, _THIS_IP_);
+	log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -344,9 +344,9 @@ static inline u64 readq_relaxed(const volatile void __iomem *addr)
 {
 	u64 val;
 
-	log_read_mmio(64, addr, _THIS_IP_);
+	log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
 	val = __le64_to_cpu(__raw_readq(addr));
-	log_post_read_mmio(val, 64, addr, _THIS_IP_);
+	log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -355,9 +355,9 @@ static inline u64 readq_relaxed(const volatile void __iomem *addr)
 #define writeb_relaxed writeb_relaxed
 static inline void writeb_relaxed(u8 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 8, addr, _THIS_IP_);
+	log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
 	__raw_writeb(value, addr);
-	log_post_write_mmio(value, 8, addr, _THIS_IP_);
+	log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 
@@ -365,9 +365,9 @@ static inline void writeb_relaxed(u8 value, volatile void __iomem *addr)
 #define writew_relaxed writew_relaxed
 static inline void writew_relaxed(u16 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 16, addr, _THIS_IP_);
+	log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
 	__raw_writew(cpu_to_le16(value), addr);
-	log_post_write_mmio(value, 16, addr, _THIS_IP_);
+	log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 
@@ -375,9 +375,9 @@ static inline void writew_relaxed(u16 value, volatile void __iomem *addr)
 #define writel_relaxed writel_relaxed
 static inline void writel_relaxed(u32 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 32, addr, _THIS_IP_);
+	log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
 	__raw_writel(__cpu_to_le32(value), addr);
-	log_post_write_mmio(value, 32, addr, _THIS_IP_);
+	log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 
@@ -385,9 +385,9 @@ static inline void writel_relaxed(u32 value, volatile void __iomem *addr)
 #define writeq_relaxed writeq_relaxed
 static inline void writeq_relaxed(u64 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 64, addr, _THIS_IP_);
+	log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
 	__raw_writeq(__cpu_to_le64(value), addr);
-	log_post_write_mmio(value, 64, addr, _THIS_IP_);
+	log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 
diff --git a/include/trace/events/rwmmio.h b/include/trace/events/rwmmio.h
index de41159216c1..a43e5dd7436b 100644
--- a/include/trace/events/rwmmio.h
+++ b/include/trace/events/rwmmio.h
@@ -12,12 +12,14 @@
 
 DECLARE_EVENT_CLASS(rwmmio_rw_template,
 
-	TP_PROTO(unsigned long caller, u64 val, u8 width, volatile void __iomem *addr),
+	TP_PROTO(unsigned long caller, unsigned long caller0, u64 val, u8 width,
+		 volatile void __iomem *addr),
 
-	TP_ARGS(caller, val, width, addr),
+	TP_ARGS(caller, caller0, val, width, addr),
 
 	TP_STRUCT__entry(
 		__field(unsigned long, caller)
+		__field(unsigned long, caller0)
 		__field(unsigned long, addr)
 		__field(u64, val)
 		__field(u8, width)
@@ -25,56 +27,64 @@ DECLARE_EVENT_CLASS(rwmmio_rw_template,
 
 	TP_fast_assign(
 		__entry->caller = caller;
+		__entry->caller0 = caller0;
 		__entry->val = val;
 		__entry->addr = (unsigned long)addr;
 		__entry->width = width;
 	),
 
-	TP_printk("%pS width=%d val=%#llx addr=%#lx",
-		(void *)__entry->caller, __entry->width,
+	TP_printk("%pS -> %pS width=%d val=%#llx addr=%#lx",
+		(void *)__entry->caller0, (void *)__entry->caller, __entry->width,
 		__entry->val, __entry->addr)
 );
 
 DEFINE_EVENT(rwmmio_rw_template, rwmmio_write,
-	TP_PROTO(unsigned long caller, u64 val, u8 width, volatile void __iomem *addr),
-	TP_ARGS(caller, val, width, addr)
+	TP_PROTO(unsigned long caller, unsigned long caller0, u64 val, u8 width,
+		 volatile void __iomem *addr),
+	TP_ARGS(caller, caller0, val, width, addr)
 );
 
 DEFINE_EVENT(rwmmio_rw_template, rwmmio_post_write,
-	TP_PROTO(unsigned long caller, u64 val, u8 width, volatile void __iomem *addr),
-	TP_ARGS(caller, val, width, addr)
+	TP_PROTO(unsigned long caller, unsigned long caller0, u64 val, u8 width,
+		 volatile void __iomem *addr),
+	TP_ARGS(caller, caller0, val, width, addr)
 );
 
 TRACE_EVENT(rwmmio_read,
 
-	TP_PROTO(unsigned long caller, u8 width, const volatile void __iomem *addr),
+	TP_PROTO(unsigned long caller, unsigned long caller0, u8 width,
+		 const volatile void __iomem *addr),
 
-	TP_ARGS(caller, width, addr),
+	TP_ARGS(caller, caller0, width, addr),
 
 	TP_STRUCT__entry(
 		__field(unsigned long, caller)
+		__field(unsigned long, caller0)
 		__field(unsigned long, addr)
 		__field(u8, width)
 	),
 
 	TP_fast_assign(
 		__entry->caller = caller;
+		__entry->caller0 = caller0;
 		__entry->addr = (unsigned long)addr;
 		__entry->width = width;
 	),
 
-	TP_printk("%pS width=%d addr=%#lx",
-		 (void *)__entry->caller, __entry->width, __entry->addr)
+	TP_printk("%pS -> %pS width=%d addr=%#lx",
+		 (void *)__entry->caller0, (void *)__entry->caller, __entry->width, __entry->addr)
 );
 
 TRACE_EVENT(rwmmio_post_read,
 
-	TP_PROTO(unsigned long caller, u64 val, u8 width, const volatile void __iomem *addr),
+	TP_PROTO(unsigned long caller, unsigned long caller0, u64 val, u8 width,
+		 const volatile void __iomem *addr),
 
-	TP_ARGS(caller, val, width, addr),
+	TP_ARGS(caller, caller0, val, width, addr),
 
 	TP_STRUCT__entry(
 		__field(unsigned long, caller)
+		__field(unsigned long, caller0)
 		__field(unsigned long, addr)
 		__field(u64, val)
 		__field(u8, width)
@@ -82,13 +92,14 @@ TRACE_EVENT(rwmmio_post_read,
 
 	TP_fast_assign(
 		__entry->caller = caller;
+		__entry->caller0 = caller0;
 		__entry->val = val;
 		__entry->addr = (unsigned long)addr;
 		__entry->width = width;
 	),
 
-	TP_printk("%pS width=%d val=%#llx addr=%#lx",
-		 (void *)__entry->caller, __entry->width,
+	TP_printk("%pS -> %pS width=%d val=%#llx addr=%#lx",
+		 (void *)__entry->caller0, (void *)__entry->caller, __entry->width,
 		 __entry->val, __entry->addr)
 );
 
diff --git a/lib/trace_readwrite.c b/lib/trace_readwrite.c
index 88637038b30c..62b4e8b3c733 100644
--- a/lib/trace_readwrite.c
+++ b/lib/trace_readwrite.c
@@ -14,33 +14,33 @@
 
 #ifdef CONFIG_TRACE_MMIO_ACCESS
 void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
-		    unsigned long caller_addr)
+		    unsigned long caller_addr, unsigned long caller_addr0)
 {
-	trace_rwmmio_write(caller_addr, val, width, addr);
+	trace_rwmmio_write(caller_addr, caller_addr0, val, width, addr);
 }
 EXPORT_SYMBOL_GPL(log_write_mmio);
 EXPORT_TRACEPOINT_SYMBOL_GPL(rwmmio_write);
 
 void log_post_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
-			 unsigned long caller_addr)
+			 unsigned long caller_addr, unsigned long caller_addr0)
 {
-	trace_rwmmio_post_write(caller_addr, val, width, addr);
+	trace_rwmmio_post_write(caller_addr, caller_addr0, val, width, addr);
 }
 EXPORT_SYMBOL_GPL(log_post_write_mmio);
 EXPORT_TRACEPOINT_SYMBOL_GPL(rwmmio_post_write);
 
 void log_read_mmio(u8 width, const volatile void __iomem *addr,
-		   unsigned long caller_addr)
+		   unsigned long caller_addr, unsigned long caller_addr0)
 {
-	trace_rwmmio_read(caller_addr, width, addr);
+	trace_rwmmio_read(caller_addr, caller_addr0, width, addr);
 }
 EXPORT_SYMBOL_GPL(log_read_mmio);
 EXPORT_TRACEPOINT_SYMBOL_GPL(rwmmio_read);
 
 void log_post_read_mmio(u64 val, u8 width, const volatile void __iomem *addr,
-			unsigned long caller_addr)
+			unsigned long caller_addr, unsigned long caller_addr0)
 {
-	trace_rwmmio_post_read(caller_addr, val, width, addr);
+	trace_rwmmio_post_read(caller_addr, caller_addr0, val, width, addr);
 }
 EXPORT_SYMBOL_GPL(log_post_read_mmio);
 EXPORT_TRACEPOINT_SYMBOL_GPL(rwmmio_post_read);

base-commit: dca0a0385a4963145593ba417e1417af88a7c18d
-- 
2.17.1

