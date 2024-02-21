Return-Path: <linux-arch+bounces-2537-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF1E85CD55
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 02:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A511C228BD
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 01:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAB96FCB;
	Wed, 21 Feb 2024 01:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AlnvEmJ3"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A357C2C9A;
	Wed, 21 Feb 2024 01:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708478264; cv=fail; b=eZg16nk8KQyQknYsv96+z/lqbWzB4PP7LhPb8C8imjDcwVTHD2QO+BuTpCE5MYQkGZorXmYokBDBlZt0H6e70czNojQpJXKX8uCUeb7CwMQsc+O/FBPh2xH7BTQ0KwSlTjsOQybyepDd83XyqkcFpddOBUdV1X0Fm2UfY2odq54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708478264; c=relaxed/simple;
	bh=e4m91W4UlLexF96Ehoh1+/PfJSahVk8Hic63bLrgQuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qDwpJuu+u9p4LBkld/kOeYGI1Z3zHHBNk34gJF6JKLgQNVnlf7jmzUtc6V6Z8SGqdotPVGwsStTqAY2LkvxOUHX7eYVm0MwgB2otwy5MHRQVL49dhtwXVApJmFev1cpyFpS8i1OQrJ4f99Vms9FI93iTJV32dbvzbhYWAeBdeH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AlnvEmJ3; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVtwZz62wdgWteFNDOyItC5grrOL1Tj4/7ieud8SZsYQZMJldoY7hTfILSIw06DaHR4J3bVUpN3+h/8AYdB4woixifCf9SRv/HeRbEVOyMLMD6+eNeDXQdrhBya5I08aMNDO8KE9I6xVdCjRm1dW+/KTTh5pkXYDWE2/ptutxA8kRJ/pJf9Lo8tzg3LQSFAKmUK1wyaNyiIc+pbPTqBbgsW7b9yVuaaewZH6+k+SJ4htX4oaqhH5JGX/BU3XsIAjTQmOt2S22Z4j7OrnD9RGNAHJsO0hub+VBSHyPNUsXMEMTh4WkiLPovR/Eqlke5qhC9z56xzQP+I0xJeiwrUeew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRPh4dhsyZVmxVVomsPWCtm81IAZr2FMm5Xc6ZHkaQc=;
 b=OZ/YuBkZDNLcU5tMyls3jz04VSGkxj3mDUgrlOjA+5G+nkVAVJ7IRxXSJXXWffv8vEM3wurMU5OFDUCB0bQ+PengpC4bXw+zVqJLTMF6j2DpHJCKDEWwQK+AS5O6i0FDGDIUuKSGbbhOy6SAOy3ikIkuTqstaIp6DRENC7tdHj0KpCIlsp7Hs0H3NLc3OeG7TNI/uvxJSszbIOKda9dr9IbTs7ArM2VIJKmatUk+qBfboRza2gpTdPFPJa5/PdgMQpX6O5lOEhi7sGjAwKEXQb9uwiGB6LOQlA3FsPdvJStVVyxTdQUa5COVhRir4D6KYGqVEYuCF17dbp3cpbapfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRPh4dhsyZVmxVVomsPWCtm81IAZr2FMm5Xc6ZHkaQc=;
 b=AlnvEmJ3js910k80SZfRiFl3lnuIhA813nk7syRboWIwlzprjGt9BCwqcTn2oInMG3x1Ohw+w5TgcMAYwWsy9jKUSOhWvEhep+wvFvwhM5RhQp/EtU9QtjQU4r5hSKwT0gdVCtZwalgAwE9Z2jg3tO6q2GJbCIq0/z2GMgz0f0PACA+PjgvonJs9+T8h0fAWjc97dTZ1fKzoQYHq+s08atJDnr1O9gnkey68ln/jF/sgBpEgJf/jKpSREo9sAvrD0OF/gj4/oQFzHeYdrWzWw+qPdGLb7V5OpVEIjMADcvgJw7hciYM97odIgos/tlm3fee34c8y6SNUDCzNM7SwoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Wed, 21 Feb
 2024 01:17:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 01:17:13 +0000
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
	Jijie Shao <shaojijie@huawei.com>,
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
	Will Deacon <will@kernel.org>
Subject: [PATCH 2/6] s390: Implement __iowrite32_copy()
Date: Tue, 20 Feb 2024 21:17:06 -0400
Message-ID: <2-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
In-Reply-To: <0-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0064.namprd20.prod.outlook.com
 (2603:10b6:208:235::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: 86fdd14e-590c-4538-a4bb-08dc327ad4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3yxRJxO5aIbj3hDw6tlkBvfl/bHS/toyc0WPFpJn7I/p4qar7U4TVNN77AMvfjdV1WeRhUbg8Yqlz2ogZhKh9FhfLfzYdjYYRpqQd4pq4ZUrGqbgmxiBRSd21KMIlt/Pk4K3icKslGo4eE1uskxPWUdt7rHVf3XGaD9FLgdKlcTEt6M8UHc9vdVrw3wRJPZdcUvDXztpWqQr+NgZpUajskPcwmZvkkkEsxM5uMgvHdrWirzZT05sCar3kdbEWh3cPrOdLQhC7olmYB8FH6JSAJT3lqDaSsycdULfQtmAQDm7Ve86qyIlBS6+rlOLfA/cQsg/JGZzYdbr5cNGeztpqiuo8M5vB4dQAld5uDGr3P9jTDK2qq/pIxDLWMhyeIYqvRhF29HM31jl23ItHjuXtrGk0HUXdUib4/9t63VTheCga88CxuOMFTw0XbIX+t5vK09M+KDvrFy6p2h/s+yFtUVSPA2e/ncrVnw9ZlVMZliRF+VeulRQnrGZ6HBccTJd0jGzqsnIa1iHoqqptWPQ42gqsSH63m96+0RI2OaeADOwEOrTmC9qsgz8n0bUduIuPxC6XCm/iaUkxcv6VhRXfLsTB8oN2HjCItjAf6/3N2w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YTmOas5ayFNIiC+T9hc0t8eaVEE1/d8RO4aKgENd7USt9TyGZn+k83VSpHUQ?=
 =?us-ascii?Q?XYjr7pSWQUm0Zm4MN2ztkjI2k9aOZBqVIImVgIMRXlBPcLuFEUgFBMtRocN/?=
 =?us-ascii?Q?V29DhrJKroq/H9igV8UF7SL9CJG8FiP0jcZVI24LnwB9kzk1DHOHOwKDZU1Q?=
 =?us-ascii?Q?yde7QXwsgIKVQIIrMkn1CSqalOZ2uLBbnksyZw7g2ML429qjAEm3K7to4d0/?=
 =?us-ascii?Q?9VrrcNet1pJk3s0QP/4VHHiVA3Puacb5W8vCY94FnlPx8wVtXAA8LU6umHIG?=
 =?us-ascii?Q?NI8stIaTas+yOaB3pPvV6VlWBi+WaGE8mAdpvlsf/WYcUcXefmxTxuCx4PCX?=
 =?us-ascii?Q?zlC5kcDjtxtpDImK4aKdQkwN/EmozjbsKpUfOuNP8e7OJF6Qk6B2b98XBOc4?=
 =?us-ascii?Q?6STcLhYlhL+ivZZZwfx/v+q9zwTHhDS5+Fl1Bc/iNH5P/KVuJ6KDbKkDAiBK?=
 =?us-ascii?Q?gDy/JlQZH4L+3E9xO4U0Ylbh1bh41zrBJcXctaC00kPlZ0ioEeh/SV/nvdvk?=
 =?us-ascii?Q?sB3YjoVH6E1JOAWxbZmmTm5KqsVvGyZ+/vhr2I72hcEvaGohzKj0pg+DTUBm?=
 =?us-ascii?Q?KgBrccQOjs3kEyvbqDmGJHRjqbPF/8jlatTFCiaSPuIVW3HsY7XBV7KL5V+w?=
 =?us-ascii?Q?97NjEhzKIQW3JsqaxCMyBaZ/l+4b0QAoOlCcQdvQXOkzsCd5a/9uuHTre68F?=
 =?us-ascii?Q?d6OlGst+hBCJYy3EX7mnPfQFWhvfMaaf61UWgZgdekpzAobQipt+4Ty8DpWw?=
 =?us-ascii?Q?ysiik+gU1wyViqpKhdObu0fUopE5t9u7ZysP3Nmp1kMLyjeviFznMBgHxcsC?=
 =?us-ascii?Q?YqChlWzXnQIaEb57zKPh5csCj1Xrgev122RJmqI9KgIkk9FFXrY5/TZWdse3?=
 =?us-ascii?Q?GLmYcPdBGXuwij8jkWwQNcHBe51/nzhLR4NQjki7WQdyjE4cQFT5l6luaMan?=
 =?us-ascii?Q?i9Nx5uYE/jsaEwm6pXZAG2b7+KiN2bndH0t98TEtHj1vIVQNg+3Gm/1boh8R?=
 =?us-ascii?Q?rRy8GjvgrtAUdNzV4AYHstFUqwfGMC/bWTLBkpgpp2zaSIraAfN1U6UJDkDi?=
 =?us-ascii?Q?evt2Wd++ldJTZ2YJzUHqHMzMCa6FpgQ8Da0dHG2elEvH7DIIPDY241Gixjlc?=
 =?us-ascii?Q?D6aLXrWBO3S3UFZtfmG+12jRZArGKZAhc2eL5hZ2KzPFeEmUtxpWr57P5N2s?=
 =?us-ascii?Q?hXY3Tfbr3ENjPboE1CVf+k06WKBq+DWE+z//nuLXaqYzLitMLkbPJKRRs233?=
 =?us-ascii?Q?lpse3hc5YY6/nkjNaw5cUAZkPtgUwq/syN92HQqQZ1vmn2+0rMJsH83lrHhs?=
 =?us-ascii?Q?eXrLx9a0FczbjsEMEEs7GXgoQT8sdqxPzSOsU5TGzceF5HCIW1Tk9uwBt8Ds?=
 =?us-ascii?Q?TbCSzDOQyCWy8/GjmEGS+sZytJ7qU1ov4d/63MPn8/F6KTmlubuPrkzRk6Y+?=
 =?us-ascii?Q?i292kB8TBBlAkh6IZQfKWpiH0hiZCcTH5ef9cmt/6jdx2QHWBSWWVSuE0fv5?=
 =?us-ascii?Q?KTBuq+HN9Cavu+Uk71Ve1G2y8ot/vSE8ZIokKRm0abFnSirovycAgwtiH4Pi?=
 =?us-ascii?Q?/SOeituRddD0Qqqpxfxz2s1QckFuu8EqLLLSjyZx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fdd14e-590c-4538-a4bb-08dc327ad4c5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 01:17:11.8061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tg73HYJbMGHhYEl58jh/6me1JvXLicZLpyJN7/bN9FgQygsnZgoI3UgK3JmE1O5z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714

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


