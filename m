Return-Path: <linux-arch+bounces-3593-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF6C8A1CF9
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 20:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7B41C23C2F
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 18:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400BF1C660E;
	Thu, 11 Apr 2024 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S85+0jqm"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC7E1C6603;
	Thu, 11 Apr 2024 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853990; cv=fail; b=qD9D/zPaRCchs+K8qZ/fYmD2bbNjpb1iHgnuyiwwhhDRkIxdZnfk3t+SqJjxWUfATDMpqzx0ZDscFvrmHtVNsNcD7oFqplaPqpLfIjlxEV362st219BhkNj9s40gy0RyTK9lIcW1JOKIWbEzqGue7Wo04SdgjLrXb3YtmPkr51s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853990; c=relaxed/simple;
	bh=e4m91W4UlLexF96Ehoh1+/PfJSahVk8Hic63bLrgQuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FM78C63tLofHf2t9nzmE6UVVRyCiMoY9NxJqpJufICkTkgRpUQEbXZWKctQqLZX7fEEb0FPHFaswMKtm31oPWabcoogvHp1ZM2r/7YFApSinKu3l7ST3gl76zg4DooFntzIgaawWhDOuzDxL50kmm214nGmCdxHAAwa3lQ1fdCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S85+0jqm; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVmFYM0hSCAgGZWHj7nU1V2dIk+WtG0QT2F2Xo5uJPacGomujQ/MlIp40a4WuL08T56OgYt32V3V3MHkn/dyygnKwEfgSMq+tyHo6KaL73ldu7lx573XMQvK0RQ43gPgIgPVz/ZweytuevYj/iyY8LiJOIwatNaqpfy7QN4f5LC88wH8CZ3WlccX0Cq3ZTYK3EjdiZBnswsywf/X8Sk1QZvipSkVE8MC/6VF8yXe+mwSfcSUylt77KWY/d6chJApYg/jF7WqgmkeHCR/2kPinaH5LWPDBDUx3RlGBs8KUxNBV6sLBw5j14Ti40l6dfcFZj30FpK108zlFu/UVZhMTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRPh4dhsyZVmxVVomsPWCtm81IAZr2FMm5Xc6ZHkaQc=;
 b=kUyTAXQSUoeDGPWYuvbJGsu0vHfg37vQrMtTFm+DXsaMQRUpQDY+iQblBwABmT3xjeKOC3xFaPwP92eE6YHrVN/DxJBKQ3bkE9/QYYRLSvDvuodRBXhxHf7fRJT940MTSz5tnv1lPw7aS7IBmpbXkinl5sxv3biH32N4S5v5pZS9Y9IwIbB05ggOJFCYGJ5ls31DtD8ceOVRRDd0zH7KdvXEYlXYxf1me6B/F6N1hpuFqc3AZqeRBNxLzMV69A6NLA66wGftna5pE8IwitQGUXNaU4LxXOV8xgflWp6C4OSX5xj3CkAJYEHqD+5CJmEaYIWwddMcewxJty8uaTxAxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRPh4dhsyZVmxVVomsPWCtm81IAZr2FMm5Xc6ZHkaQc=;
 b=S85+0jqmnugPP6n4ZY8lRDAtefp0lT07vp5JmNZq45jh56K0nlogCLHG8i4qAZLcyEUdIH2pc3wTHGJGecGFneoDfPPWHPi2N8fZXoaCsfDbW9IcUQ/pf5oAabiWQ0IXpp585hluKyAfJl+9mhlkmtvyqGAZlZLwtiGEAPf4DXTb/UlJXcuPC9Uig9WNuZOAYSiJFdKyjqmBu2bUr0KuSPobsYRuy1TzSs4iIZ6ypLZB4iOERQJixh6v617gUzEEP+w1j+5lfpuoq6WqKRgz4LN7MioRKW9gju2+M3gCqkTcJH0Ag5GQHH36Dn7k1C6qM4xfhblqlwqD9cSm5TpWCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ2PR12MB8064.namprd12.prod.outlook.com (2603:10b6:a03:4cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 16:46:22 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 16:46:22 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Justin Stitt <justinstitt@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	llvm@lists.linux.dev,
	Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org,
	Yisen Zhuang <yisen.zhuang@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Guralnik <michaelgur@mellanox.com>,
	patches@lists.linux.dev,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v3 2/6] s390: Implement __iowrite32_copy()
Date: Thu, 11 Apr 2024 13:46:15 -0300
Message-ID: <2-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
In-Reply-To: <0-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0264.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::29) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ2PR12MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: 276b625d-16cd-4755-020a-08dc5a46eaa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0z+KsGAxioAC5gG7TV1cZ+Z9lvKbtsTo28Hf7uyMUlY2HskjDQKH7qKBUFklCXfgiBV0GyUc5ueU8dhPWq7X+/H9jHTAqg+ZO+80B4groWEFyp7e6hQbc84fefhNkfIKK+KGC8jjs8z1KLPRnC+xx9+P35/2Fd5/3QA74eaDls8IJLSy3kK0ohRRFiLBmdNcPMVgYLyMbBkr7zFjEeuJzUXO6DdrCwpifoeioO/IxaWTHHZZ2dBtLmaFU8wRQs+eqWsquFL8R1ZPpcuzQ3sgekW48ODKyxjvBhANWK/puny7BAOobMnbfFsPYCoFjTtXFo9dDRfyxrDpKaxpydLmOvbZHXy+gGF/IeWqQiV9nDlqacizA0Q6opdtdhpCwlatq3hYFvfRhTHiqTQa3CRKlOWupd33w/akUOkh87RtFzryfeOhZWUK4sKdiuhZZ/h0WHJH+vCJLC+uv8sYaQsjgZDblUivQo0knn6aQYp6rTjCCRkcCk7SYgvQB8OrUo1AuikKAfqG9MozM7ZZw3tnWKuSo7DC0bfnDbD27SvIvjmHJycU5Oko6/N4V246l/9fgh2Ron/L5yB9jD7ORMp/zsCpuqcpmzaZzJ96z552AlNJ7OQJse2Xr9/ZNncxOKLeTDIw7ORGIxLp+8W7KltM4TOTO+fqhjCFRblQAXYxj7qfyurZFOwBSoakAu/YqiT1xU/1OQWU5pZPE3JmAINtuA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i7lXgCdif+kwxcoaKncQ+KlIN8n2nlbjbUAok+EWcO2iMQ2pnaCZQ2UfQ1RR?=
 =?us-ascii?Q?jSwdhNfo/0pzuS0DsmEzPVUjGYMZBqB2EoiKxAv/c9GD5/BuqXjrUg8ZILas?=
 =?us-ascii?Q?0S8cdPZ8N/Q7TCZg0i/eWn9RH7xMWvEDlXQTTE0Xu19Ly5EuXdDQglVaxgt2?=
 =?us-ascii?Q?M+gbYmqMcIC1blUkC+qq4HsvGKLBHMNvzRSSO2zQQnXkZqhE/SXCVU4IWddC?=
 =?us-ascii?Q?GYy7pvJoNvr6kfbcE2vkH1NE65Wc7ITGr/afjVLIv6DQa7x07uHs38F6PGXF?=
 =?us-ascii?Q?iY/74aQN+6ngLE4is98hPOPzYmxePcWz2y3sFjRIVJhCxIZbv4RwU+YJvhnx?=
 =?us-ascii?Q?s97HeYco07X1tId3qVGQ2jBHx5vFN0648MKo9EKFX6hmDeZHsRJWfRZiEL3I?=
 =?us-ascii?Q?fzihHdTGhSAoTSqEYi3wND71PFk4WGLYo8gr1S/sWPMW/CTwR/GF1uVG+SFU?=
 =?us-ascii?Q?JuuTHILx5tGM7HYCm9llJdE6023F1TwIZCDP1+3GiTzSO4R555vrqH81sxHm?=
 =?us-ascii?Q?DcEbt2Vjh5NPX30SD/3/13+DYxbsTs7CwDFn9SkFoqEGQ+ZUiAwmjb9IFce6?=
 =?us-ascii?Q?cBKQb7CqG8Cy223EDDb4eyY5NQyPLN2ve91VCxepAExIUMfMXh9gLiuLDS3P?=
 =?us-ascii?Q?svo7p1OlgSMl+Csy7Dc1qfVc8SVsKfx9jzUewKLvCQ70MFO8nXbosbFTFLLX?=
 =?us-ascii?Q?v/TjQ4CTDiBtBb+NrA+Ob8qiP5mtLxMcXIiLsOrylgukEEDTMZrygEvjoEBs?=
 =?us-ascii?Q?m1f9h8PU+WfxkuxqQNnooDTdbXaH7Yp9IKxYRpwVwoPdnrcYDZeKQAcFPo7+?=
 =?us-ascii?Q?+5jZ3VoH5VSkKd8dNOVfNrYxtkfkvnmbsSTSToSTNdx4U/ywgk7qp23iXIYS?=
 =?us-ascii?Q?CO3arvDtU/oJxcKC6u0F8dZSA2S25+UgeGzzXvrUykwKvMMRSSDrf3mJeEZ8?=
 =?us-ascii?Q?iBG7Pb3LK8XaCsOP5yeu0rRQf5fDno6aifBwX4jXAqk1e1/XoRNJGVOwm8er?=
 =?us-ascii?Q?CnCkfaMJKLSLb165pJqV6uPRoL3iInInGRVOvAYhFxJI+BfCOM7itXJ46K2f?=
 =?us-ascii?Q?VQmGgyJuCkVZmAOX6C6tW2B8i3oMSCa7qB9qHsnYWOrFDdoSlPdwtNp7bifP?=
 =?us-ascii?Q?ta3rPNGV8MgnGHciidR3vuG3SR3GGuPkLVJww5CVl4/iJwftppzkT7kFDv9U?=
 =?us-ascii?Q?x90/YdygJV1aatUm7qQVhRRFiSev3XdIjDgMLvVbZCg+kRwKPTFhL4sGdx+D?=
 =?us-ascii?Q?NYEh1+1+lexuYqfLiIApJfT5oIGS1Xtm+shl2pCLzgbf85Hvd19LUofqaSXr?=
 =?us-ascii?Q?IRGSN/Y/QxPe2c8tyIJd/rBYidVr7KVv8XZzKF3lseps4szrTm5xy1aeOtXk?=
 =?us-ascii?Q?HNwiYlLF/RTemPzGnXvCt2BiefnnYs2Vniz2jCWU66Sq/Eke9roNoXVS3WJD?=
 =?us-ascii?Q?Nxxkt784rY7VisCpZpciNIWIPpqupjx/fNcSQjiK+Dj/yKT/En7N7lvQQUag?=
 =?us-ascii?Q?RpWabOEnpcufAJp1nhb4ICHnE6SnMCMxj6UvXYD+Tiv8CfGRLk/QgmVDkXNN?=
 =?us-ascii?Q?MKX9oLu4Zg+m2X1lTBif5ZRhlpgYPtAx6vN3ToPJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276b625d-16cd-4755-020a-08dc5a46eaa5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 16:46:21.1873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDOJi1NGltfsyrIP6cojeXtmR+KV8RlY70GOwHhCZSJ+GUNVihQTNT/ZLw+OG12O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8064

It is trivial to implement an inline to do this, so provide it in the s390
headers. Like the 64 bit version it should just invoke zpci_memcpy_toio()
with the correct size.

Acked-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 arch/s390/include/asm/io.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
index 4453ad7c11aced..00704fc8a54b30 100644
--- a/arch/s390/include/asm/io.h
+++ b/arch/s390/include/asm/io.h
@@ -73,6 +73,14 @@ static inline void ioport_unmap(void __iomem *p)
 #define __raw_writel	zpci_write_u32
 #define __raw_writeq	zpci_write_u64
 
+/* combine single writes by using store-block insn */
+static inline void __iowrite32_copy(void __iomem *to, const void *from,
+				    size_t count)
+{
+	zpci_memcpy_toio(to, from, count * 4);
+}
+#define __iowrite32_copy __iowrite32_copy
+
 #endif /* CONFIG_PCI */
 
 #include <asm-generic/io.h>
-- 
2.43.2


