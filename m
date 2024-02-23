Return-Path: <linux-arch+bounces-2699-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4B28611FA
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 13:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E167F283199
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 12:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123C27CF02;
	Fri, 23 Feb 2024 12:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hu3r2Jrj"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769E263104;
	Fri, 23 Feb 2024 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708692829; cv=fail; b=smZiBIn2T6vO9bHfK7OcGOiJBX1Pf8w8sxL3FsXPkJb9FfMao1JZbNA04qCoWqhPtNikwXC6sjAZHo6s9JaPe2RDkKodErlH/joOnvSgaLTN0KFX6sWmFI5+DOdBR6oMG3GIx2MlRjbQ6pel92dHaTsaA5dzjsiJ6vi/XARsxdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708692829; c=relaxed/simple;
	bh=32k8TnThexKLdRXwUQ6soGX56pqIPZ3MVgc6VgJDdLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h8cfsCzqo0mv0jw5be0iv+L33160H4/Mtr6XpM50pieBpOre/TtzOEdLTMVf27UTruol9cFAN10aFg0hFxsLnzBxbdYHuIIbj9RvwzFXlsrbzTC5SuMto1ZISGaXfBlZdFBBXPdR/sniZwxEK7HPLKGqySTrK3RoZlkoaYQBwmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hu3r2Jrj; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0pxou1Ex7qe9NaN3gbsvF2UJCXVSiIhGLdIWTX4ZS9f1dRobu5V+FGlLuq3hOVd6yLCkzgZbbjfkSYF1K+U74/XrSFIgEekI2YXKAna2ZTw4zJinW/VzVFMYY05bzxrhre077FZiUkdj1DX1pIOvfU2ObNB/5IhQbn2tdSkh/SayNy2ulZUzPSF5mVoTGAbbO0DSwoG30T+uTkSi5Wkv3pEHHj+L1NceYw2uwvlfCDLldMpdgrCcIgwy6uFMPV/RPzpna6y2+V8Vw4/L4TuLzAXc1Zout0WwBe4tiTYd/V+C6q66tU/30L8U+VO0o0XfZC1w6CrveHdNd5ZGsQjeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6KbCqWh3W4PUizEk2SJa2l4UFdWPr0u3ZHEXxQlCok=;
 b=FvUSMoIzfeJxQ3wLwVQMnM9cZWnALrKDdkBQuGsXHuGjBJ8tSgXZx1QcfVMOZmbBNMXKmtix5ywRFN8e7kw0f9ZEcqZiuukF8NPQKIwS0TkdIB6o/SqrdGPJVYvkKsQbB3tjuv/q34Kj6+6Ea2V1lZlrEmVWZSsZST/ZPq1PCoHcvE1ksCFM1lYdNYYHbRDu7MqTvIlRv1ucN1U6yRIVqVigDmJe6EQjFD4XpFy1cKGvKm1Lugsg8l+6KoK6IeHREft8TVNnqzgB3x1unIQTOMxz7v7CCfUnxVHgL9WGfm0sm+1R81besFb6O1UWK7+LExAHLw71IAPPTTMy85St0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6KbCqWh3W4PUizEk2SJa2l4UFdWPr0u3ZHEXxQlCok=;
 b=Hu3r2JrjTa260KbZdiJBe9Re5DJXTYFChDfrb8qYFi2wWhhYc1Wk+AWqw8AxQK0rz7Zqlb7tlPrJI711JzRzEb7hNSeS+bipOeW4WViM8E07Bk7ItlB9nuraM1YqwZqfNWeBt/cGvzd+EBqW1dXoL/vogqV03QuebiO+E0kUQGruollnsWAxYLCj5vhWyZ2+ucBaHjPV/jbva4brf+RUBWhj0lwqkwKNKAEGDqKUDiLO1Nh5Np1Y2FBc7vulJetrQYdx2+OjEM8KCnBsSAV3yZhOODH25HakpInwmZC7Lf9An0uuMDUcusU4+rgb6uxnw406U96biuiGNmj1mOws4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4317.namprd12.prod.outlook.com (2603:10b6:208:1d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 12:53:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 12:53:44 +0000
Date: Fri, 23 Feb 2024 08:53:43 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Laight <David.Laight@aculab.com>
Cc: 'Niklas Schnelle' <schnelle@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
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
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"x86@kernel.org" <x86@kernel.org>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Guralnik <michaelgur@mellanox.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 4/6] arm64/io: Provide a WC friendly __iowriteXX_copy()
Message-ID: <20240223125343.GD13330@nvidia.com>
References: <0-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
 <4-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
 <6d335e8701334a15b220b75d49b98d77@AcuMS.aculab.com>
 <20240222223617.GC13330@nvidia.com>
 <efc727fbb8de45c8b669b6ec174f95ce@AcuMS.aculab.com>
 <61931c626d9bc54369d73fda8f8ee59bbb5e95bc.camel@linux.ibm.com>
 <3227d5224a9745e388738d016fdae87a@AcuMS.aculab.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3227d5224a9745e388738d016fdae87a@AcuMS.aculab.com>
X-ClientProxiedBy: MN2PR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:208:23d::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4317:EE_
X-MS-Office365-Filtering-Correlation-Id: 9338de0c-0d98-40d2-0c32-08dc346e782a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	62faXi04X8LVuRImMFCVzhQDfIRpsUlTxYrBn23b/yfO/k7x1nnVfg6ynrrR2aeLWdqxDXcimLcPq15OxEYl8bLpBXpGRpXslXNIc32sPEK3lypgyLJ0y7qis96zBJJV9PI2mZJlPhxCcEk2uxtzEbYHNgQznirYbWSCC4xxhOyHSnc48qdB0LBrniI1zZfzMxFfi1DydH5u70R1q0klydNjdG2uhEhMuiTtfAhJ4anOMfdQYLQILNdnMm8VWn2UnoTOxK5wI2rXAhil8pFFdOQ27AD5n3s0hiZBcnBABpI7hI0wpQtTtPi+0GWt+h+ZYUlkUZIA6tS/Z8I1fBu4flLyneItXHt7ERQjSB08z9Tjqo8ErC+q0wdIbUL1aoabtucGkN4NVN8F33wZ+mEz+LXUNjYnFc2yakwLa2C0hJU3w55yOeYYhNulX0G5a5POM+UCK8/kNB85GlvAthmiQ5LrlDH0iNBzDrnX+UtT/A1e6lvQusCgxaVv8tM8zBBF+rPv/JZznBCWb18GnLVueuL2EWJcglmAy1V5hS8nkFcDpBAUCZxk0uLhzpVaXn2mamuuNDpdeSXZeIbY7HClPQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h+0yuVyXQwee6qxTfRfLsVlsHsPHCR2gMKxeQDlpFVGNKYzpAghuPQr+bQhi?=
 =?us-ascii?Q?9yiUnjr3JlZPe+bprzBTxQeN58Qgta11dynnnErPZM3hYKgpsucoAVSzOZMQ?=
 =?us-ascii?Q?J+QsBvtFouT9m9zRXlt9mm7BbF7CU5LkMEnR8fADquyHPKDakX8itvTG9Uy7?=
 =?us-ascii?Q?KU6vthGoMoQRvJwb1kSSo/JNwJ+RRckmnTS03UEm37GJHH0Ac9wIvP0Fnc/z?=
 =?us-ascii?Q?Gd1KmuaG6bFiD1ldZs/bgzqTBEhnt25kH9547dz9eT6Bvd7HX+R0IOrGchmL?=
 =?us-ascii?Q?A0U2VHmcy72WknZv7K7hEYWgFPx232UyxsGb0bqEj7yjYXgxJc6gPAQO1VaC?=
 =?us-ascii?Q?n/RokUcE6wfJ/q3w22o/5ccB3nfzKW+0aqXg0X8b3Re5qYDa4v8p3UflXHwF?=
 =?us-ascii?Q?VBxMz2eutJSjw2P1pqyz4PyEMI571zbNRkm3gOQB+xTEmQImickmZkTwzGpp?=
 =?us-ascii?Q?XkOS6CEALxHG2PYlYkfuiAAsNlzPQmPdSh9OwdopSap76qS6/FUhXubud5fv?=
 =?us-ascii?Q?vG9gWrlH6qYSSHzoJpZ3XxCy+zryMIUvWhYtY3uhULB2ASKqH1ZwjoXcH6hp?=
 =?us-ascii?Q?A/2RxhyXYup1A0B2dYkxOF8ctrpT7TTr+k7vlzuFOIuqWRTyKMdT5Xg8QfIB?=
 =?us-ascii?Q?+pabET2nfSu8JC7NLlfCK8UABmzsE1Pz+Yg/8P+TffiOitd0SjmUZ76LzDH2?=
 =?us-ascii?Q?ISdpee+rNQRtUXhWIlXPM/2EwNKy6rLc3VOmQUom674q6lKiTfrSKGa520V7?=
 =?us-ascii?Q?miM3iiqWE0pDlexljT2FrneyorbpmBEtMZy+m8n1cntKoWa0wGJwwkzOgJN4?=
 =?us-ascii?Q?FI8kFQ+q03+fzxe/xrVOMuDcgz65Dc7Z3/4BcNEEyp2jyJlsbXs3f/nxs4Jv?=
 =?us-ascii?Q?yO0XhVcvdUZkE82KaCUJNMJoF6EGESwL/1adFO+HL7txBksGMimK85ExiQiE?=
 =?us-ascii?Q?Po8k8svjCdHzgrwL7LH8don4ZinDNnavL9iTp+9iSh5H3WqCgcVH9dyoiTdq?=
 =?us-ascii?Q?WZ8bjdV0NwIe02yQTC+gBH9CXMVyixW4voz77Mte/JzWnUN2qV+gIHFCRRt/?=
 =?us-ascii?Q?s815tqXxaLXUKpzvBV6n0zQtogCbe1/zJQMCAYVaNiLRVUwyK7cOHD5y9F0R?=
 =?us-ascii?Q?Lol7HYA7BKmfoamVDQQzsgped5mSx47RZdLlhULlBpMpIsJLVM81Le38QITb?=
 =?us-ascii?Q?EYp9WrbA6Csj9YuVi41E14gKIW2K+Ds4B/OqmRwepU7akvHB8XATs7oEtEVK?=
 =?us-ascii?Q?F131i7BWLu8ol5gys7Ibobvp1uAxdES6YO0l1+YNXt1QMPzwiautXlvu5oA4?=
 =?us-ascii?Q?ZDkNxYZrrMmOukR+5nC4gBsES02qDOottI9OsInSrYJlAV1hSlgCAZ3BQLoh?=
 =?us-ascii?Q?XYnzusssu4uwu1jbHS8TL9syZIjrHKXm8tfh3X+J4VKkbn8fD9jvLVTNPFzv?=
 =?us-ascii?Q?wAm85qUCOs7IRHpQzl6K573dScHRAUHEBe4RoCoRzjTMhbXnS6xCJuSi1wId?=
 =?us-ascii?Q?EQDXneQxd49zULqr1jzlHxPIaRkczQYdtWSyj7H7PeCQoORcjCwXsVyePpkX?=
 =?us-ascii?Q?cQMbQKOoF6v7OwWh9iq6EdbHzdL+oUSBoblCNnxA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9338de0c-0d98-40d2-0c32-08dc346e782a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 12:53:44.8050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlJzcp0o04P0u0hguxooAVeiAr36Weq5Kn9Vs/puqQ5J5I8ENEjjhTmygKcmJo8l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4317

On Fri, Feb 23, 2024 at 11:05:29AM +0000, David Laight wrote:
> ...
> > > > > > +		if ((_count % 8) >= 4) {
> > > > >
> > > > > If (_count & 4) {
> > > >
> > > > That would be obfuscating, IMHO. The compiler doesn't need such things
> > > > to generate optimal code.
> > >
> > > Try it: https://godbolt.org/z/EvvGrTxv3
> > > And it isn't that obfuscated - no more so than your version.
> > 
> > The godbolt link does "n % 8 > 4" instead of "... >= 4" as in Jason's
> > original code. With ">=" the compiled code matches that for "n & 4".
> 
> Bugger :-)

Yes, I already fine tuned things to get good codegen.

Jason

