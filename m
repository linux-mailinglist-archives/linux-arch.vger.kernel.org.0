Return-Path: <linux-arch+bounces-13640-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB80B587D7
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 00:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB2F47A396D
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 22:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4D323957D;
	Mon, 15 Sep 2025 22:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rh4TMpm5"
X-Original-To: linux-arch@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DCE2D238A;
	Mon, 15 Sep 2025 22:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976499; cv=fail; b=Qk7u/CEAtWdY2GAJWWf0N3duUfTMfN7ZtQH3YrOxK7gqTOGLS+nOh+0bUImePeC9s8KwQQf3OWUDDSYWhmTYxtqBe68qglwYl1mGlqvxX541lS3nES6TgZqMXvwQD1yoKvDljlbcYJ81uFoV8N7kv6N2Fvm36av/07e1zSSPCB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976499; c=relaxed/simple;
	bh=kAV91l4JnFlhixok0TspBY7i7ulz2Jlobp8RcX+1GwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VDjvj8QL9XO914SFrO7wUrjZhm73loeaozGhsce8BzP7nwPFJQGHBmuYX4VBFBiG0UpPOC2n0Hx3YwVIxlMu4m9DenPYX/CdF5m2JIxH4uLTVbPPboMPLCdzfaZrZu9/cXcqpQChkJVJhV8hDoxAQ0Rap9CrgZwyslhdNAj8UCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rh4TMpm5; arc=fail smtp.client-ip=52.101.56.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6pgbmROVYIm6Wh1K8GkfgkcJ54A9U++TYSzHAHe5WGZafZb7UZNYPHMSdrx5Ka4wits4j9bzS7N/AG1Ugru8XRiVTRcjFQcWSo+/cb6VKoa2NizF2LVlKrNsunWCzcAjdK43ISE7bxu2lmPY1dP5pr30gAOSd73tyFw13AWtzTvgMdCdt5IZrcvdfs7NYdQBnsftNmheawvw+1QtBVQASwhXaIULj1Wt/gGapso1enSGG0oJq4K9r0+A4j/LgCxIk3gjmaJVTTmjd0wzHbJ043+WpNNn8EARhicOSAas228rC0G0Yiy4JAei1AcT8xA86/0RhR3LKcBwC2HIkep3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/FPeaknZAmsUpLfZ4YNuKx6J2ze7e20syNVSyGA3no=;
 b=LnzoNH4z8qz1Iu7vR4zJpfg1ZiCDykpzNcrzrBqQulFK7qc/GZ1yuZqsUFA8U+fn1aejLcmn/G87jmnY5/xG6rSzlKhF+NVwuSv/65BLlhDgFFCaRr+AtaYOl8nGXNygpbzBc2XJWFe3ax2RPwV2Tx0bXbmTNWGOV6seE0wOxAulVXWhBOd66CrOhU/hzgnLhRLBxTn+HcGP7IXhJ9DzVyCfkIFKK2SZ7gAl7fQhKV5+1Ah9KamK0390V4KkxPSA4APkIqoVi5D8nmIiu9js5zM6wTssx5CHJGPbFer1AGpsn7gU5l5PS2JW8lu82UKO1W0ukNAEkNltkemLxTRHBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/FPeaknZAmsUpLfZ4YNuKx6J2ze7e20syNVSyGA3no=;
 b=rh4TMpm5tfytVqZ5R1YPEbbjycM9j/y4+yLrXt94TZdhlJZXwgCtzZe/+hFsTYglgQtbtpRy9ztsCPQEpxnDt1O7pU9E84wfL7cyZKJ3Y6iV1hAUFcCKnBfvsRFtWylpw3Gn7iBs6Ea7eiViD9a4wo/3DGD6TbetNcLgOCWc93IKaPBF1OC7p48YtZ2YcnhXPSVY5+NTHUl9HyuLXNp+8PQV5Z4JHJTyNd0Wa1HnBpT1t+yK9ZStSXVoEwZ7AK1EC7DJdgeipMvEumxLPTjqqhrjDj8wX2/GWAMHgADmoleE68fZa5hA2dIziIGhRd55mnz7MYrogjcr/ebKn6QT6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by PH7PR12MB7872.namprd12.prod.outlook.com (2603:10b6:510:27c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 22:48:13 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 22:48:12 +0000
Date: Mon, 15 Sep 2025 19:48:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
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
	Jijie Shao <shaojijie@huawei.com>,
	Patrisious Haddad <phaddad@nvidia.com>
Subject: Re: [PATCH net-next V2] net/mlx5: Improve write-combining test
 reliability for ARM64 Grace CPUs
Message-ID: <20250915224810.GM1024672@nvidia.com>
References: <1757925308-614943-1-git-send-email-tariqt@nvidia.com>
 <20250915221859.GB925462@ax162>
 <20250915222758.GC925462@ax162>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915222758.GC925462@ax162>
X-ClientProxiedBy: BL1PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:208:256::8) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|PH7PR12MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: 389bfce6-f515-46e9-2cf6-08ddf4a9f36a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UjVuGZSGybUCAEm6e47Sj97K0/o91wXzSTJq0JyyVisfcpae6ggwQM0XZjv1?=
 =?us-ascii?Q?sbQoB52h5hEry0C4nvzPohW9MZbyLqzUsTrIQys5fiqvZdcm7vl7e5CVDDna?=
 =?us-ascii?Q?CzwPqYYdq3ZLFA5o54TdJqoi2kbFB2FM60cSRH0g6RljtBQjIpovhRy9Ywcc?=
 =?us-ascii?Q?+hlM8icZ3QDNuRINO5SqNX9vROWIA7K+ivglXSxaRZT4roLugow8uWN1tuWw?=
 =?us-ascii?Q?K9mM7TC4l9LJpb9vhRp1V1mFGH1HHskeTHfTqtPG/l/mO+AWo0MIex6QjAIY?=
 =?us-ascii?Q?CLlN/Kofisw4uHR4AuKJDACAqHAhOpv+dFZL3x2lZHJFc6/4M5woL5ZnqU9u?=
 =?us-ascii?Q?XBQmWRY+OqxB/ecTgn+KQMj3kDpSZ3xfJa6pXnRaVz+5hHcCHqwZqP9XsUUK?=
 =?us-ascii?Q?zmXVT7CmC3XVpoJ6IErPKKD3INkbhGt+4o4gforO21iLiFyjqqnwNux93nvV?=
 =?us-ascii?Q?ZhjYzg/scYwl06AOikbHn7fB1eBMu9FrGNASvqdzlWMNOGrSwi8m4zETXjPD?=
 =?us-ascii?Q?2EhSKTlaW+J7xC4DkEVRR4wHc9p4GV4PaLWj3CTump4f+BAg3FcvlFGt5EoS?=
 =?us-ascii?Q?gP2JD7KAfv9dlm85C9FXRVqnfNYF+i4Gsefdnx+nvsmfpBUyd8Ega8quhSpu?=
 =?us-ascii?Q?9/7I9+ctOXBJCQJ9dL8hI1+oiosa4SefT59c3ceBwofWShUPvax/pmCuMPOW?=
 =?us-ascii?Q?1aW0D3f4qp3tplWSEFdod5Qv26IHvri3CKwY9wPmMSrw7NlCsUVCEzHZy/Yo?=
 =?us-ascii?Q?yngXVcQ6IOvYtIgdbVT0AU2eoVQGzjM4z6xp2knEPygRgLiKX2kCRqfCjdAg?=
 =?us-ascii?Q?TJYl42vyuXzuSxZ3QDdX9FTpx/0+tXnGj51fwVhNetloJKRONYP0W6bSe3/R?=
 =?us-ascii?Q?yCo5Rms4PKMB6I207ocsYZADvCZOkGrca08AzJHSD9uVUIvaA2WBGR8u41nz?=
 =?us-ascii?Q?mjzkYovvcFrzPgKXUZUbTpf3eqLdjMA9uW/6yBZLJl4/jXJnSzdq0/51pNga?=
 =?us-ascii?Q?tQBavCZMjP81uyGChNZ9JbVm30Ll+84vimguoLoVjYbqvgoGYIsnbcad5trm?=
 =?us-ascii?Q?Vjg1trVyJ1DtB5SKtjf8XiEw1vd08D5I8UnTd46bEsaWqnmwZfeR3Ijg/tgB?=
 =?us-ascii?Q?mzX7NVrCSjrWTGB4Idgou6GWlqW222bG0J13kuGM/HtrWtQV+Dp+R2smhmYp?=
 =?us-ascii?Q?V17zL366NtFQaAeNJPyuKR6vCa7Vuz+0EjHLVhJsc7G8YG1+gfvFeizdjOu2?=
 =?us-ascii?Q?YCQPMwxYJeDNghQrTT48QNtVUykFOMLun7aQbFsqvx3CcXyl1cgF9vEtXZE2?=
 =?us-ascii?Q?KqZB5pti1TknJ0cOIJYKFvo07M5CnPZe42wPEAhmWvdTudcVCv6BMUIplkGU?=
 =?us-ascii?Q?5cbmPE4q+Dwj741VqQa/FcVCP/LK+RSzzIYwiJp+DsJHiDPz1v3SmqeL1Ism?=
 =?us-ascii?Q?kbiAQ+MYYoY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CmAVoVCub03E9YtJwlJhCPB7qVNtBALuemzRsOmxAba7s58Fh+x4SXH2SoUx?=
 =?us-ascii?Q?b3iYHDNnzhTsJaINFvcmH+gtO8+FDTGrOLOLr/Z9DGRWod3YYCxB6I1xTkd7?=
 =?us-ascii?Q?dRmR4MFdg64opCZSzxWkcW5REIY0cbYPGBUf9oGSSUPrzhQgPTb91sL5KeI5?=
 =?us-ascii?Q?PkoqQhCf8UX6NjasW80igDGq1lY0YGX7C1yBbLmD9gqRZeqrqTHmTdxd+RUv?=
 =?us-ascii?Q?WpH694F72z7n/Kb2aoEzzfssV/avu4fAJqYMx7dkFPM4dUOV4eiZxtpUPXsY?=
 =?us-ascii?Q?JrPhD3j7teWVBZZQWS4pWK/i0d+AC0lw0g6zfccc0x3KvYzTYRYUWIWPazw6?=
 =?us-ascii?Q?5IbjP3bJ54Awcy3vZ9sCkBkoxjP+PaNkWLOsNz/RTstdcB+HIvEEG/QbjbgS?=
 =?us-ascii?Q?tdpxSVYYIDk369KvPDl4ZRXUNxRMt3Z5IgLA/HlieR/ItnNCzXRa1/HR6/ca?=
 =?us-ascii?Q?TQgwDgd9igJu1KiklU3t4mFa3bgGGEZn6CUBR8zU9nX4HVoRY+p5TBFpFkVZ?=
 =?us-ascii?Q?//BOHSpfRauAjiBk4/EYhLXat5m1pwQQpw7C+ZVcZoKgtxmm1+EIVYh2y/vg?=
 =?us-ascii?Q?vzcvabs87K1Ze1TW3bKYrCGlwTRQfsoxxaW/NzIgAEkTqDxdY2Bs8f6XTsaA?=
 =?us-ascii?Q?ysm7EfODA1Uds4pimN11IrHbKAjKmjqC4qz0W9Wf521ekeBHfRTe6FZQcjuv?=
 =?us-ascii?Q?9RXIKsxYcAT1DxhSDIZrJV+hXyQXw1YHQ8/3HzBX9TXPnw8+Aw6GfSluhqV6?=
 =?us-ascii?Q?CAB1DqUmeBF118wTbjHegnanuj6NBIqbbgRMqNzA58NnoWXmjowbiuiPo3rO?=
 =?us-ascii?Q?3RLrZ2uYMjIKuyc8NpFl2EU49MQ63Rvh2tZsg3Cuj5QFbiZNSqtoeMfBwU30?=
 =?us-ascii?Q?nj5xZUuKHt8oftzFJ8qWABHYwGu1QniZlV4853T3kqOt3RIzDJCOBu6t0/Ba?=
 =?us-ascii?Q?IW8lLkQHrworXb85HnrdeGbjhI8CaqtlqhKBXUQSfvZXYNXVSov33fTBry48?=
 =?us-ascii?Q?KGXn8bXendaoScpFmtshu8YjPenv8EFCWJyAA03x4Rcpf74RI/HX08wsD923?=
 =?us-ascii?Q?ANRei3Z76I/5RJ/6SZgIAOBkpuVwIniwp+a3XSy/ZQrTYlOP6EI/fun2aFAj?=
 =?us-ascii?Q?EQuorBjOKwAlMtO/cqOHaMAv2hXVIHvDND4snHNvAZwNGxfR1GIVWuuKxmJF?=
 =?us-ascii?Q?tFVjhaTNHMttkuP5BmCvx98VWPtA3faavj1RMabNrv81oY9erwpWFDlyoXCC?=
 =?us-ascii?Q?7T3cuu5hY9CP8EHBC35j1qoxyIpoHGlLT29ZocMVGixIJL2Oo0Q2whwJAcjv?=
 =?us-ascii?Q?dNrCrpTy/cMbRWEQdLQ0g6sLbdQaQrN1Ok8/DtuThbyUDVElyrkCKrVX1IvA?=
 =?us-ascii?Q?8LfiH6lBgyZSwUnuQtkgkUd8RXeexw51oKW5O4zGSMnbgA2AjpFYhFATnJYp?=
 =?us-ascii?Q?/RpgK5hPPJ6EEGe4fmsHG7hBQ/k1mgM+Ryu4au6PPBRMI5tQwj08tZ5b1ie4?=
 =?us-ascii?Q?+gFY8Q0ngz5Y/Pd/ZU0dI3+ycP6GRkCG4Q3eRNxAbInwkqLgwQNSNhAfe8+4?=
 =?us-ascii?Q?6v+BZe3ndZoHObUcNHzhF2S31qIhKS9eNtVywHv7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389bfce6-f515-46e9-2cf6-08ddf4a9f36a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 22:48:12.8909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F12WmQbx0UZTb2tYFNK7Zxt8+uyFewwSzlmgkIW9lQlcBRQ7lmzYGDNn1b1ysC1c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7872

On Mon, Sep 15, 2025 at 03:27:58PM -0700, Nathan Chancellor wrote:
> On Mon, Sep 15, 2025 at 03:18:59PM -0700, Nathan Chancellor wrote:
> > On Mon, Sep 15, 2025 at 11:35:08AM +0300, Tariq Toukan wrote:
> > ...
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> > > index d77696f46eb5..06d0eb190816 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> > > @@ -176,3 +176,9 @@ mlx5_core-$(CONFIG_PCIE_TPH) += lib/st.o
> > >  
> > >  obj-$(CONFIG_MLX5_DPLL) += mlx5_dpll.o
> > >  mlx5_dpll-y :=	dpll.o
> > > +
> > > +#
> > > +# NEON WC specific for mlx5
> > > +#
> > > +mlx5_core-$(CONFIG_KERNEL_MODE_NEON) += lib/wc_neon_iowrite64_copy.o
> > > +FLAGS_lib/wc_neon_iowrite64_copy.o += $(CC_FLAGS_FPU)
> > 
> > Does this work as is? I think this needs to be CFLAGS instead of FLAGS
> > but I did not test to verify.
> 
> Also, Documentation/core-api/floating-point.rst states that code should
> also use CFLAGS_REMOVE_ for CC_FLAGS_NO_FPU as well as adding
> CC_FLAGS_FPU.
> 
>   CFLAGS_REMOVE_lib/wc_neon_iowrite64_copy.o += $(CC_FLAGS_NO_FPU)

I wondered if you needed the seperate compilation unit at all since it
it all done with inline assembly.. Since the makefile seems to have a
typo, it suggests you don't need the compilation unit and it could
just be a little inline protected by CONFIG_KERNEL_MODE_NEON.

Jason

