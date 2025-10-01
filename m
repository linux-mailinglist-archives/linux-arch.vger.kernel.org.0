Return-Path: <linux-arch+bounces-13823-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F22F1BB0E6E
	for <lists+linux-arch@lfdr.de>; Wed, 01 Oct 2025 17:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F274819C03A5
	for <lists+linux-arch@lfdr.de>; Wed,  1 Oct 2025 15:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A7A26158B;
	Wed,  1 Oct 2025 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HWjXeuua"
X-Original-To: linux-arch@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013064.outbound.protection.outlook.com [40.93.196.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEAE268690;
	Wed,  1 Oct 2025 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330525; cv=fail; b=suWDviXezJEBs81EWvRZKgeaYnWHS/EAQ0YbfniVA+d4gwNqjczQJ8to/Iq08E4w5U3eEihOVY97IefDOJ0V3X/RfLK/cRruE9yFBIpTTSumeaS5AmIck+4LiGnTZ2lG9T1I97Zbp/IiwR6wfftrsxg11/Qs/4L/ew095X5hLbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330525; c=relaxed/simple;
	bh=kt8TZXqA17uHL6M2TVz1a8yp+K+cvLffatuRj9EUZtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TjpbVQ7bkmxXL9fU79RYQC0thVg0J5AXK1RzQBFs1hPT2czFM4SOBe3NTC2PgKaiTwiejqRAYA4S41z7KCJje+96gGBpHHSS3Zk1qjr0S3QP6V0L6/anP37Sw8asyteeNi2lNEsD3yEu9S0WXJmE9JG/XmeiuHoAQNhmNds9B0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HWjXeuua; arc=fail smtp.client-ip=40.93.196.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s17deeI3XKTFUjeeqkPBne6HxnLfcafDcRcNCIf6L48zbiA3aMkWX0bzJ6r5DbHci+cnIL1MDKbZRM6ZMzeT1mz708WhyKz+WERSP6cdLbK7GQ62Q0TeUFmHTCqI621pFYrNDCjX3Ixf/H1I4vqKDWIjwSSK05kmY5APtlfCTAaRPyMwJDEgrT+3qNPglDu8bcRrtbyGiW3+nYBg8gCM9UWCH0dbcfuE7gFFzIjynpH9kGg0AXxZT3sfxTa19bzsTtSTI5PvAA+Kqa+LJl4ACMwmOKEayJbctHI3QqkdzMO4uaKx6E1WflVCxuimVlJHSuI+Y7Vy4ZEL2f5vDL9Xwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEvSda5lta/Myu6xOwJVEsqfiTBLkYZ9WnycBg8br6c=;
 b=Wv9QQzmNTipLcWT5EDQux4h2+jYTF1sp88cPdZJVwz4dnaZ2Dd2kd76ziPYeKigyrBmCcureYHroPsn+iPhOvOQ2D1LL7rRTH6A4IDnwEIofsYSK79og/Dl6x1XyuyhDze6BLs5+GXr5d/KoDquXev4Pq69bFipcExx54OEcs43YJGkPx/mJgDqHS0e1CMygdgOvRqQdsmZaVmCz6x+i+ojE4jnwpND4vqd4zlh99F4TSYp1Udby73KzowXw8YIl4WIuXgmLIEdTRfUMpLyzqDwB6ULqkFeG79s4/ZkT1QvVyDo1paMXDtmZ9kChAQ++R9JcQrMGSnuoy4IwSFj8WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEvSda5lta/Myu6xOwJVEsqfiTBLkYZ9WnycBg8br6c=;
 b=HWjXeuuamWcJYWV4OrXwAT/KsTlwNg7o+UYiEdBj0gEF8YgMdC1YMm+fYb1vj7IptWHLD1bBmTehMx1SAJDAfQGpyRgWutjc78lYFhX37STxFkm6yBPWwCtEQ3Zb96FuGBGMjZO3/7oe3oRQZLDJAE2dnRGxeig3Om3Purrs6TkFKJTWsx14DG3VDddqObqGNybgR7K4K1q5YBX0a50EDDfRpBBQmZa4u7R8BNWpuDR/Op0QiyoLwjsV2UlYERrurz6xSFQjbt1VZkL27Z5qbSkvd6PkEfI9lzxd48+2VLdZ+IxNk4Ss/QzDH6ZVXwZvLm8BsxUwTJ0nsQAGBN0Ewg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by PH7PR12MB8124.namprd12.prod.outlook.com (2603:10b6:510:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 14:55:16 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 14:55:16 +0000
Date: Wed, 1 Oct 2025 11:55:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>, Will Deacon <will@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Justin Stitt <justinstitt@google.com>, linux-s390@vger.kernel.org,
	llvm@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leon Romanovsky <leonro@mellanox.com>, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Guralnik <michaelgur@mellanox.com>, patches@lists.linux.dev,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Jijie Shao <shaojijie@huawei.com>, Simon Horman <horms@kernel.org>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next V6] net/mlx5: Improve write-combining test
 reliability for ARM64 Grace CPUs
Message-ID: <20251001145514.GC3024065@nvidia.com>
References: <1759093688-841357-1-git-send-email-tariqt@nvidia.com>
 <651ee9fe-706e-4471-a71b-e7a12b42cc3e@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <651ee9fe-706e-4471-a71b-e7a12b42cc3e@redhat.com>
X-ClientProxiedBy: BL1P221CA0038.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::9) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|PH7PR12MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: 18102bbe-057b-4625-6cb7-08de00fa8861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZxEoaGuo/Tu34gNiB8jtNwYodSsFCcqc1UJmVAhzeNAOjGg1lAZkNx0vWlU0?=
 =?us-ascii?Q?8vrwAP+7nm2ELU79e6Y3trfBCx6jEovb3krh0mYE1eFygKS/MOyCnzQ9iFwF?=
 =?us-ascii?Q?K8T2tKSsmTG1XO7Olcgu2x1kbAPqDIr58cOFQviBSIohRj6dpm/ebNSSEMoo?=
 =?us-ascii?Q?NCGj6by+wCs15Zh/7vylbeqdJOCb9bBmkBZP9GOctUBkEg4Nf3ZUxKrQebms?=
 =?us-ascii?Q?0dC8tFQlntKHDbRRIXim1tK9FR4TQCLaVRBf34CPhm687P7QB+1AOftdzeeH?=
 =?us-ascii?Q?N5ZGFoQRpkcJ54y1nhmVFq2tyeToVKA7n4aNqsnx/xdqDMmIPnGbUp/S5Ae8?=
 =?us-ascii?Q?4AXUoQ53U2jW30wGvpxexzEJhYN6dtqQwfzgWeb5Y1o2GC8ctRAichEXrn75?=
 =?us-ascii?Q?IgRW+AOr3MKJAefW5SjUicH88rYmOFBu97OIjiH0CQjIvZjpQnNg3PM90Kl3?=
 =?us-ascii?Q?d7S2SRbTL688Qcn8zqD9NNfdbuzLxY/yTd7pRjhXRCvIzl4RdPHFAH6/t88z?=
 =?us-ascii?Q?mxmkkj/k5Gfuz2lT2tRr8BOGwXGM6RnwMlGBhM+5jMUN+lIO2fqjOFba3u7Y?=
 =?us-ascii?Q?pBSgyi5sQW4TgZfUZ5GPLJRCUMxYTyZyK6Dqu1RpZD9ZGQykhfJPgyi/tnRP?=
 =?us-ascii?Q?NtcKZ/08XASjqNFfXUqNzn8w8WlJPXdh7RolYYNfpy91Lv1rddSyhI2wfd+B?=
 =?us-ascii?Q?tyTys3xxBwvKtTzQaCdiw0a7CEO53R/KmH3E/G+EH1UXyxdfemxR6uyuDaQa?=
 =?us-ascii?Q?uq+IIQeitJ6xNKClui2CCKFiJB955NxC9uxGcHXk4ongVgflW9ndzf4CSKrM?=
 =?us-ascii?Q?2LFJ8+0+qiutfuZlw9h5QFtJzsy2GsEeu0kNqb+VL/Zvx2eO+DUsTpYpxsaA?=
 =?us-ascii?Q?Fwx6QMd2vVBx+LnNd/0SXAKqCaeGX4tuTbksHtic2mBkjjsrz0+unu5qG/ZI?=
 =?us-ascii?Q?fkY0m214u5y8ntlffxuQc44sV+fD3VbvCun+L2HJJmv856TZHyMEgKkrY8hp?=
 =?us-ascii?Q?naO2VE5fSJ08eytrl+cXEwhuM3o8Y2bPlYgEMn+0kS0NdnelKXQ6iKhZ/wXq?=
 =?us-ascii?Q?+WTpG2Be9Sbv8doXkQcKSbcjOKgowscZb3MCKLRbfKrloLiEV99UnVmVQtEj?=
 =?us-ascii?Q?5bjkucrgME6WCj0hLvITLxGkp8TwgXYcfLPFWGqbnFBxd3GJyIMkl5SZjVmA?=
 =?us-ascii?Q?GRW3M6FmTCQclPcxuPmNxBqS6qxEw3/d9SA3B9T/JkXRi+ZUYrcAZk1Y7T3a?=
 =?us-ascii?Q?2zvOD+t94dW3yUO9qPNfCj5oIudQbyoR0D8r1QgxDwKWKYgC9WKqqFK441pN?=
 =?us-ascii?Q?A4zkmn89j4dTwtMYt0QfVq5WqzOQpl2jxo1VYxOAivlTkKlF5e6B5ZniK58K?=
 =?us-ascii?Q?N8GNJKdlaP+ixhJsvXv7SNRraaQhEU5g5GML9UZ03dLcaodS2+u549Z3LZ0U?=
 =?us-ascii?Q?FFOrrLAQkDaotxKjFfrJQrq3NWLuulec?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rI+WKn7IVvyHWAv1xbkZfMR8xop4JClEqNTRDh5vUy/cL4+KbZwTCSNCOkTw?=
 =?us-ascii?Q?dWeOhYaWmtJAGvlfnhNy+Xw2dVE8MZ5dxFvWmVwt31JbfNtaMthNgCn6r/Ug?=
 =?us-ascii?Q?z7WfuNnzyyg38yWhUkMfL+veTz9CSXJ/Wqm3efxWdkeSjIzMWdIoBu5dhS4A?=
 =?us-ascii?Q?fODJ1wijrfIAdXHb+a+owU+0xaebbyWt2am15btoI8gYRpGjg9oNgesepPsD?=
 =?us-ascii?Q?aNa4UgxTjHjmf6hVigmad8YS9hzxtdwwvWV79FB2zSVv7SxfKopgH+IoN9/4?=
 =?us-ascii?Q?HJfIjuvlkHdL+2q1i6YstsGe/bSkIe+QeYPU5MByMuWl/8X5utV/VSg0sO9p?=
 =?us-ascii?Q?xXSDsjsA16mJIWV9tZnY5IgM5MdTf+H/t/AtMW8lmxpWqoM42xf7J/Cs3T5z?=
 =?us-ascii?Q?d0dOMRAgr5ozpO2YuWIyik5T2dPxRMDwzE7x89I5ww7a4QNcrvs8lvmF6QDM?=
 =?us-ascii?Q?wrIy/edyxo2LaxmZT4XcrPVh5S44AGGJ/1fDYTEPnHwdrRT0d8CL69oUjyY4?=
 =?us-ascii?Q?MmuHth5oelgdqZk3AZWJqGQzibpplzEA7/7TUppXHdpGBsI7hNbGGyUodf2z?=
 =?us-ascii?Q?MvAPu/y5IpZKIaawjSUQL7M3+iRt1sgip+IDkqEzNx/rCc4MjFuQBzYUQ+3u?=
 =?us-ascii?Q?Nji3cH/nX9jwN5eAl5S7mMfNAtf+JayjbIIfaUtfQT1tP7rJeq4A/dLGg+91?=
 =?us-ascii?Q?Gk8af9ykqh9ttc4dzFNkgJRMaQKCZFroWcWjCQ8st+RF++jb0AJYCeZ7BmkD?=
 =?us-ascii?Q?Y49fQFejEEnvpLmNE+zIUcNTVKAIvXrYpfUBS/EiQfQVsRPiuB1SovPBvqE8?=
 =?us-ascii?Q?S9onBm5Mk6kru3+hixCCSl7+mzKIeYIVYk+d5ug70U+1rAAOj+ryewvRV1Tv?=
 =?us-ascii?Q?CVjVZjDxI555IrfTSV7b93R8rYHW32WgMPKfLuxvM2zGTKZjOto5hK922/Ec?=
 =?us-ascii?Q?R8+KqfaLqn/O+cKCNrMwkf2XuNKrFZ0wBaZtOtTgaus6cTPkuBbBuHqC4fz9?=
 =?us-ascii?Q?StUwlDeAIoQyX2fffx2aUYevdX88gRTd1pinfGcnHWPII7DTl2gbtkK3bVaf?=
 =?us-ascii?Q?6pBfArgqABK+44Mau2HZ3ZDeaeTd80RsFLmpY96CIECPCGPIB/IoeGPk/+Bz?=
 =?us-ascii?Q?kHJrIUxyltXw9OFe9dsURKq8rQP/JjLStgTbbxx/FKlYB0Xylf6IReu6q6/u?=
 =?us-ascii?Q?aiR5wDDgCnzd4m+WukxHnVo8DV8VhVNDN/9/Ink/Q8RPHluMPgFnny3Kun8q?=
 =?us-ascii?Q?GIcLOXyRFawXXSirlbEMaw+RKNAvVXaWDVf9PlBIn4qJoiKJnyRemAYn9ZFV?=
 =?us-ascii?Q?WFB0CbP9l0QvkpzVBmUu1x4JFJR14BNnrsptp9FblmvT8EB2W4R+xILk07vT?=
 =?us-ascii?Q?2MhWqR1z5RAkljmjleoLImFZV5aVIuRkaewfqBcUGEtFGX5rukcfABrPsDem?=
 =?us-ascii?Q?AFTkH/0H4AQah3coh6snJnKV/4IJk9JEh0+26TQzBd+pkumB2PLQLz8+8VHR?=
 =?us-ascii?Q?hXciXbnecgk9WSWjCThF7zVMXkhCU2yAidw4DzKnIgKDz9BFS+GXNeYtflCR?=
 =?us-ascii?Q?hgnv6iGlcvE2Mf0Lvxlu+oGUJsf0MLzUJF2773yW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18102bbe-057b-4625-6cb7-08de00fa8861
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 14:55:16.6019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URQannyL54K7HA6IikBOV2i7EG7u8Zs8xyXUceGiY+nf6BVaM2Q8ss+YULQTd8n/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8124

On Wed, Oct 01, 2025 at 11:28:09AM +0200, Paolo Abeni wrote:

> > +static void mlx5_iowrite64_copy(struct mlx5_wc_sq *sq, __be32 mmio_wqe[16],
> > +				size_t mmio_wqe_size, unsigned int offset)
> > +{
> > +#if IS_ENABLED(CONFIG_KERNEL_MODE_NEON) && IS_ENABLED(CONFIG_ARM64)
> > +	if (cpu_has_neon()) {
> > +		kernel_neon_begin();
> > +		asm volatile
> > +		(".arch_extension simd;\n\t"
> 
> Here I'm observing build errors with aarch64-linux-gnu-gcc 12.1.1
> 20220507 (Red Hat Cross 12.1.1-1):

> /tmp/cchqHdeI.s: Assembler messages:
> /tmp/cchqHdeI.s:746: Error: unknown architectural extension `simd;'

This is a binutils error not gcc.. What is the binutils version?

2.30 is the lowest that v6.16 supports..

Jason

