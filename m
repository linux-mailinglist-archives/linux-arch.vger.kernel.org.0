Return-Path: <linux-arch+bounces-10275-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36042A3F4CD
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 14:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F59716F02B
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 13:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B9720C485;
	Fri, 21 Feb 2025 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WrEGPCgn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB49F20B7E2;
	Fri, 21 Feb 2025 13:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143024; cv=none; b=omoVFaoP7funBalHxkl03dh2U7ikp95PfL+GGT0KY4EH8K9X6geGN4XsUhWbIHzJXrWUgq/wvVZ+OT0ygz3CPKsyQqq/g+RjBrZyVGh4Y7r5GF8cYhvE1IQSz4MR6WEFTNZdY1FUZP9kzG8TKWBfeW4/7ZGRhnxHe2cld8UTcEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143024; c=relaxed/simple;
	bh=YuTZuPM8fsNmASUzmGSbKLvC77k5AXhZhjx4kfap1ow=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=D1lLbezGBXLrSUz5hsPgWx9iGRsnfOjuiKzvcthL8r615T5fWR68p3wvtGVaWjDhyPHjgAsh0dEH6Pg/PwCKYESV2E2MAXaQ++Jpce+0t6A87C3KR8N2Apqgo65XfYgMaw0Q+Rktnt+nn4d+EBIyCa5dlfgIE+jTmP4KqprIRCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WrEGPCgn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L5WA3b008310;
	Fri, 21 Feb 2025 13:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Jrf2seTrRs2kHXX0JDUsRw
	6WJbyG652B6YuDCk/1ywM=; b=WrEGPCgnXS+A3yQhrfKsjtSTbv+scw5hW34L4M
	IBWwj7OE+c+gUs7rXg6n7EnUPJNd060FBWOiXEQ/ZGI/PKIud+90+k8uq4sjm23o
	ORiIjaqjHGIqZa/griFhcrcJCXLhk08ckHjjfv+BdShRPp1I/6v3p3bX22L2lCSZ
	Kp1R4z2UI58B+7HSx43+78JfP12irExnw1gPfajpK+qlVFA94r2H63wwGPDBGhBC
	dqjFEFnjbgPzBJYpn+jn/IpsJihYZCMiSVzsQ0cnzePughdheRFTnKD9u3XspqXH
	hLgxOajBvXTHzkxxMD5BaYvuywfD16Owq1lDaEjllNwaXG6w==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy3j2mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 13:02:41 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51LD2T6m020137
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 13:02:29 GMT
Received: from hu-zijuhu-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 21 Feb 2025 05:02:28 -0800
From: Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH *-next 00/18] Remove weird and needless 'return' for void
 APIs
Date: Fri, 21 Feb 2025 05:02:05 -0800
Message-ID: <20250221-rmv_return-v1-0-cc8dff275827@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE55uGcC/x3MQQqAIBBA0avILCNBh4LqKhEROdYsshgtgujuS
 cu3+P+BSMIUoVMPCF0ceQ8ZtlQwr1NYSLPLBjRYG0SrZbtGoXRK0N66uUFXtegN5OAQ8nz/sx4
 KHehOMLzvB1Tls1xkAAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon
	<will@kernel.org>,
        Aneesh Kumar K.V <aneesh.kumar@kernel.org>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra
	<peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner
	<tglx@linutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S.
 Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Danilo Krummrich" <dakr@kernel.org>,
        Eric Dumazet <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Jamal
 Hadi Salim" <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>, Jiri
 Pirko <jiri@resnulli.us>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Bartosz
 Golaszewski" <brgl@bgdev.pl>, Lee Jones <lee@kernel.org>,
        Thomas Graf
	<tgraf@suug.ch>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski
	<m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Miquel
 Raynal" <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC: Zijun Hu <zijun_hu@icloud.com>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <iommu@lists.linux.dev>, <linux-mtd@lists.infradead.org>,
        Zijun Hu
	<quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NDRu5OKSayRbCwCev8nS9u-wqeqQNEdY
X-Proofpoint-GUID: NDRu5OKSayRbCwCev8nS9u-wqeqQNEdY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502210096

This patch series is to remove weird and needless 'return' for
void APIs under include/ with the following pattern:

api_header.h:

void api_func_a(...);

static inline void api_func_b(...)
{
	return api_func_a(...);
}

Remove the needless 'return' in api_func_b().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Zijun Hu (18):
      mm/mmu_gather: Remove needless return in void API tlb_remove_page()
      cpu: Remove needless return in void API suspend_enable_secondary_cpus()
      crypto: api - Remove needless return in void API crypto_free_tfm()
      crypto: scomp - Remove needless return in void API crypto_scomp_free_ctx()
      sysfs: Remove needless return in void API sysfs_enable_ns()
      skbuff: Remove needless return in void API consume_skb()
      wifi: mac80211: Remove needless return in void API _ieee80211_hw_set()
      net: sched: Remove needless return in void API qdisc_watchdog_schedule_ns()
      ipv4/igmp: Remove needless return in void API ip_mc_dec_group()
      IB/rdmavt: Remove needless return in void API rvt_mod_retry_timer()
      ratelimit: Remove needless return in void API ratelimit_default_init()
      siox: Remove needless return in void API siox_driver_unregister()
      gpiolib: Remove needless return in two void APIs
      PM: wakeup: Remove needless return in three void APIs
      mfd: db8500-prcmu: Remove needless return in three void APIs
      rhashtable: Remove needless return in three void APIs
      dma-mapping: Remove needless return in five void APIs
      mtd: nand: Do not return void function in void function

 include/asm-generic/tlb.h           |  2 +-
 include/crypto/internal/scompress.h |  2 +-
 include/linux/cpu.h                 |  2 +-
 include/linux/crypto.h              |  2 +-
 include/linux/dma-mapping.h         | 12 ++++++------
 include/linux/gpio.h                |  4 ++--
 include/linux/igmp.h                |  2 +-
 include/linux/mfd/dbx500-prcmu.h    |  6 +++---
 include/linux/mtd/nand.h            | 18 ++++++++++++------
 include/linux/pm_wakeup.h           |  6 +++---
 include/linux/ratelimit.h           |  4 ++--
 include/linux/rhashtable.h          |  6 +++---
 include/linux/siox.h                |  2 +-
 include/linux/skbuff.h              |  2 +-
 include/linux/sysfs.h               |  2 +-
 include/net/mac80211.h              |  2 +-
 include/net/pkt_sched.h             |  2 +-
 include/rdma/rdmavt_qp.h            |  2 +-
 18 files changed, 42 insertions(+), 36 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250221-rmv_return-f1dc82d492f0

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


