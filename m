Return-Path: <linux-arch+bounces-9086-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C90549C90D0
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 18:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88916B3DEEE
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 16:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EC151C4A;
	Thu, 14 Nov 2024 16:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GlmpWbHD"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D08A165EFC;
	Thu, 14 Nov 2024 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601766; cv=fail; b=mAs5e9/7TiJUPj0lbhrI0N95MQ6MsisRiNylKX/muZIwez/P+jlPQt+pCfpWweetUJKAPJkPQLqa/qpVNyP4pnxTtbC02805GNqB70g9ZnCxsFgNpTa/fQtK5nhKRD0zdgk+CGQyw/DVXoyXq2GbuTysAKdA72xGRubq970Mxos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601766; c=relaxed/simple;
	bh=LDuTaUXsnWiDe4PaOPOMGmZv5cDNXY6chNNBCCpkEY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mTjrNkq2cMLnFyZvPhGEgm5uMzTZt77zMX2DY3kkmWq9d4v1ubEon6y0Edun5anflXT1i30MaQ4DKSJkmjJK1uC+kJuvMt/WJGaT9GRgp+d+qOrLEbYf0gMASdnA7mwleS+7Pz3RXhtOnt5wCuBZxF2GKdyG8xGd7xWzmaWYE04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GlmpWbHD; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJGvK3zSyFEYUXTUvpzspf+5W9f/DMoihMRqQgirHxNt8+GJ2IwH6No+2sUYml4hZVHucQO+22czD7DbDyOQySTX5N2zjFLcqFLMDOAisIGxe5oOY8Jl4m1NsRh5vrPl/FKlXoeikOlH0de3oYRgH7Tzy9GW4w0zERcS7bF6G8ZfSW2l8yfVOA1oA4R8dzGEPSDGt6ZIv0stiF0EhViyUC3a95RNuQpMtrY04a2Tvm0Sj4bJYolDrtsTTYCa1YRVMtIYqr6Z18Zeh6xNEam1DSAGW767YWw6FRaN8MJQcyf1pboflaxEfmdsCJcMykPJH0xgCUmvlvALT6GGIWLvGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuBQgNREF3RQV7tIFiuO0cBpgf3Y0SL1vhrR/2SrDQE=;
 b=odmMbcgo408/qOgPIBfKQJy2nzBPwTWJHQzsjeUDWbJFzBMSd+tVpl8k59Cp/BsXTScO+pfSSGC9PFM4MVHby9RCGh4W7CHjFiAIJdAlUKEbQqbn/ttPY5J0uy69I33YlDYVbpA91iUYaA2hnHF59IwyLFk0MCOJpGB9ZMLIac5wjDXGna+gjXpc7Ew24/2zYT+V29Rie6mwvY5WtXX1ZHBqke/3RXb7itNZqiUdX5tOPPEggKnNb3oINBRs2/+dqdSzD7JlAtmgDvkKghHDm0ZLDyIOdtYyJmmKyqZj2CfxyiBH6e0VFQKci+EZFK2daX/Zg4gDyMj7SCx+9ynVCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuBQgNREF3RQV7tIFiuO0cBpgf3Y0SL1vhrR/2SrDQE=;
 b=GlmpWbHDVtthN5zMcMf+s9o1lTR8hmnmYXoMnGGtILlgdes4Em8CRQlEp21XSXfRAK95s9QlFr0SqHuXywJE226c8rIHWm3ZgsYS7jGw1HoPYZ3g0ud1CvnEkEYo2JXJP1NKZysnvo0mFU/p+T0093Pc8/WP6jwkN5wYQ18hs3tTd8NLz9Naa5a2I0shUY3pc81tGYGXiBtK8fwPCPy1buLPiTR9YNW6q+nEtDAsVBpscVkijSd3ozmnsM2A2Emrstrs+H7NzWKjrh6WR3hlI/PYXBylnxHHVhj3jTfuYTrJYxNSgipVj/222tRXJKo/HzyuZbOHt2yum0HaoS4jOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB8538.namprd12.prod.outlook.com (2603:10b6:208:455::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 16:29:20 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 16:29:20 +0000
Date: Thu, 14 Nov 2024 12:29:18 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	vasant.hegde@amd.com, Linux-Arch <linux-arch@vger.kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, jon.grimm@amd.com,
	santosh.shukla@amd.com, pandoh@google.com, kumaranand@google.com
Subject: Re: [PATCH v10 05/10] iommu/amd: Introduce helper function to update
 256-bit DTE
Message-ID: <20241114162918.GS35230@nvidia.com>
References: <20241113120327.5239-6-suravee.suthikulpanit@amd.com>
 <cac1ccd3-4b81-4374-a49d-9afad755b19c@app.fastmail.com>
 <20241113132031.GF35230@nvidia.com>
 <CAFULd4a1PHREX6ws9Gyu=TaaZvdgLfh6peoE5Tt010uGyY9Hgw@mail.gmail.com>
 <20241113140914.GI35230@nvidia.com>
 <CAFULd4aGDM5ySO-PeOH0+_U89mnqYqQ7v+U0ZsMode3bxs_X7w@mail.gmail.com>
 <20241113142807.GJ35230@nvidia.com>
 <CAFULd4aFvGj=kz5Si9WpAr33KFtJDO5+sdNO=NBB+boS=E-E_Q@mail.gmail.com>
 <20241113163451.GK35230@nvidia.com>
 <CAFULd4bvDhfSprPEyirvX9VmKK_fpxaVNRO02oqT_KQAdLFhfg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFULd4bvDhfSprPEyirvX9VmKK_fpxaVNRO02oqT_KQAdLFhfg@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:208:256::30) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB8538:EE_
X-MS-Office365-Filtering-Correlation-Id: 46a6fe32-c6b5-4cd7-53ff-08dd04c97d88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y/OGNuUjw55VWyGxyXHAcUdW24VKki3MQU3BVrkWot5/09PjPZKxZHXfMcGr?=
 =?us-ascii?Q?NEvEMoBqjZoby93D4itcszvtOF3VhKiwIlPOO0+X2jZvcJCL7vJnnUS+f/xx?=
 =?us-ascii?Q?+unyOqz3rA9z2WIgAOVXrAisBHWWuTqJWHQ6EmAF06b8/HSqfO71AGkaeISx?=
 =?us-ascii?Q?/0jAUqdPgp8/lqKOuHaXM7/14mHBsz1ijlf2Sy4Vyb7KmWYYn3u+GT/+7uEe?=
 =?us-ascii?Q?yWPW0/YhjjGwtOnfx4I7F+QSReUbGD7OeKFIedtEjPq+QUL1UYHrWfLl6XRx?=
 =?us-ascii?Q?97S8Jqa4Mj1zewL8W6lua8ysoIptxJpfAAo9LuZlCboqrcVMzvOqsTTIcshz?=
 =?us-ascii?Q?l5qndnq7D65fQkKiksUFj0Bcz3G/37H57miYktIetznk2TyBoIUsYYUypHB6?=
 =?us-ascii?Q?V9LelGYP2E0MLaEep2cqgdntohgILZz/1M3fyHP/HlVGq866OYIO2KEr93Gl?=
 =?us-ascii?Q?VviVaaX/dpZLKvM0sHizxXKV3osjimiU3WC/mmP5sW5ab+VW4kzkMfdnNbRk?=
 =?us-ascii?Q?fTLNpw9jw2sb3wSCois0wAf/IrvxcwDPGotJxGK/x9oQ2bMlq6oCDcxi5gGB?=
 =?us-ascii?Q?y5UnwSeb3cIEEkZbGvuvs79YI+kgP4+AyhpfiHVq2jaVgccbQvdGssOxjKRX?=
 =?us-ascii?Q?/5+/G+FLBjJunRF9B0TrqYOPPJo875dP9lmraexbGEfA97Lzb4b7dE9dG3Z8?=
 =?us-ascii?Q?KFyuH/yZCD/nfQSCHPWGIBogps1y50witx6EmBE5mOwm+ErL3WPBiTdfijd2?=
 =?us-ascii?Q?1WJxOWq98vbtH/I04JIxRAaJqe8XwBiI724gZvkdL6wyPaduZ0TEhrA+pw27?=
 =?us-ascii?Q?dXx4AEltVhQYZc6/RS7/mGaEhITLVI5guTcuOyNSnppiqpgQCLeUSdnOyOWT?=
 =?us-ascii?Q?TNiVaMNcOoiKRb1MNEcmwLxsOjW93gkVsm6bAc+03jYYVPKuk5Wfz4t8nWHy?=
 =?us-ascii?Q?VnjCs8r9iCe+sjOilTxnQdVSwr9ZJLH/LCPIeMJ6YNFa9IbNBJi5xWvUdPyz?=
 =?us-ascii?Q?COqK46WV99nAyk7ujjYngtOishmeo8tsece/vDGqL/ZMQEtbR4dI/Uoxc7Do?=
 =?us-ascii?Q?t06EOlcLIvrW5ifsKGA3Gc/ofuErOStwzOdBjXiMohymQLQmWXa1fE6NqGET?=
 =?us-ascii?Q?ccY9ONQsw1Kz/bwetN67G67ya1+xRFRHhug8FtZt/m9fdqz5OpEcwO4Em6Iz?=
 =?us-ascii?Q?UX2B0k+oYsLpnWEIy+AF6yKX7SBIXsVmLnO8F7rMJlIYLTlPznDk+m7S77XA?=
 =?us-ascii?Q?GWgk7mLqA9rjL/7jktmFwFl//zkCnGwYHIhGCd5+nHAE3ONk03um/ZPVqUcN?=
 =?us-ascii?Q?aZSL6l1m0CGwja/wrw8sAkJa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c2f8H/hzae/zemldA443EVwTIYsGP8L7jxiLvQEtUEYjtVkiNHn7jqPJow1O?=
 =?us-ascii?Q?cZywcbv8L59nUx1oHvOpA5x4WqdXzXsd6A8O78EVciUHkdKaK7mr2kXHDJci?=
 =?us-ascii?Q?xU+6b9Ea+IgVAF1WRnwM5Mbsu85VBXGnCf1FPgGtO6a8Wk6s89NpiJhYAQg8?=
 =?us-ascii?Q?rOa+ntODmZiefRslZc+l5XMTx0j6LwC7/W7SdT1Ex1FTPzM6+cY62LsX9tBF?=
 =?us-ascii?Q?x75sSbYNJBuNGJe7wqiyR9VVfGIlxeMkVT9FGCxaYvDL01vC3I2H1mQQB76Y?=
 =?us-ascii?Q?u/f45oURxsPSWAWipLOHlFMe+GI+bSIkxkPwx+9t+kQWK99Nd7i52WaRYHal?=
 =?us-ascii?Q?KGd8nGNrhzUrFcTNpnZeZBeUWq1SiJGzE6MJA6xFmILoUhrNmImUqWAFo07r?=
 =?us-ascii?Q?KynISwaepzoosvWCfuU79z2P2ozIlyG4JaXL03ou6zoCSQWFGOaVrpE4wXEm?=
 =?us-ascii?Q?FZ/HSYej6n3WIJa/reGPvFZXaZzJ7YdkbuVFcseDaXyWrFVyZzcDLdylRE2z?=
 =?us-ascii?Q?+ZXi3Ye6h3cF4daFSvUQgM66rkMT2YWfpw2QAzdN0aAOwgdlhxhdt93fYThy?=
 =?us-ascii?Q?bPGgR/9+d+hT5mImu+AwXsx09sesGQ07pWqHu77EqYnaEyN8O9K9NilScoeE?=
 =?us-ascii?Q?UL+wSZkeaqOyYUBaXzNa6LHXfyB+Gg6OZsII6lPjbAhAnMVRolAc5J/t8VtB?=
 =?us-ascii?Q?ZKoBB2akQrzdsqawM12rd2wiMTclKXIjiVC9iMmRiZr06RzpXiL65zWWnLCz?=
 =?us-ascii?Q?RugAD7r88Hv9zX1i+M7yH6Mr/7Tw8scdF7xej9UaSgw4U7QjhARu6tNTYeBt?=
 =?us-ascii?Q?XkiBfKhsJNI7CJnMqNdWAbfdc/fZf1xwf9avTaTXx6AAcKMJEsRu7HtssFfw?=
 =?us-ascii?Q?PAugfT63Yjox6CH1RLH77jhZnsmwwRHYlVqUWBsaGXMRRwSDJB8HNfIFfROa?=
 =?us-ascii?Q?00HNIVzLXOhrLX3dkLl/BvFEPi4tapO239rQw/V8N0E+6klFzwXyA84FFOtQ?=
 =?us-ascii?Q?SzENc/9pI2wb1FDpwz1QsRBlnviCN5hiWTVOWu9FMaXGyn08VDw45nrAQ9aB?=
 =?us-ascii?Q?i5dJwBX5ebjqxS0zJnAXyg+HPoeRojll1h2jlPPntF6Ony89mTLh+0Hx5vV1?=
 =?us-ascii?Q?o+Yju1voDp99IFs4U0ZhzBHGtzUht+MW+tgpfEmPsqhMrAlNQ8CRnEd0uhDm?=
 =?us-ascii?Q?EnhwMatsJ6qpxA9mwztrwXvDHJ6EOSkokY3/dF6uFpobs8Z5NdLIN4ht22iH?=
 =?us-ascii?Q?soVSgANqLwF1pFxG3XwQsg71KofGUj0lqiFMcfm0tX3PaZZM3gePXAvlFril?=
 =?us-ascii?Q?mEtfdh2t7c4mqmzA2sAG5aOhvIycGINkbNcpua0vyoytUNuRDFXauzfz0JJb?=
 =?us-ascii?Q?bGqaP9F0cJHSVURB0KJYSpPmvIdweu8gwUqLihgPHvQQgXd7Be6W4trW92+W?=
 =?us-ascii?Q?+CUs05wvow7aiHY/Qtda+Enmb+iAJDFcPPTpksFTGnY1X1S460M2FzwMmUt2?=
 =?us-ascii?Q?sbk+NosTLnatNTOAJC7BDVnDe0pPGi49Eac6ypsnme6e4DIr9wl1hly5P9x1?=
 =?us-ascii?Q?e5GruOrCStQn+w2Q7Vg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a6fe32-c6b5-4cd7-53ff-08dd04c97d88
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 16:29:19.9029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kGUjUkzaWTsqwcvCcTKEC3fDU4k1pLibVK7ex/RkfuPIV5wf/vkhgWp2XBEwfwSW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8538

On Wed, Nov 13, 2024 at 08:50:08PM +0100, Uros Bizjak wrote:

> Then write_dte_upper128() would look like:
> 
> static void write_dte_upper128(struct dev_table_entry *ptr, struct
> dev_table_entry *new)
> {
>     struct dev_table_entry old = {}; <--- do we need to initialize struct here?
> 
>     old.data128[1] = ptr->data128[1];
> 
>     /*
>      * Preserve DTE_DATA2_INTR_MASK. This needs to be
>      * done here since it requires to be inside
>      * spin_lock(&dev_data->dte_lock) context.
>      */
>     new->data[2] &= ~DTE_DATA2_INTR_MASK;
>     new->data[2] |= old.data[2] & DTE_DATA2_INTR_MASK;
> 
>     iommu_atomic128_set(&ptr->data128[1], new->data128[1]);
> }
> 
> and in a similar way implement write_dte_lower128().

That makes sense to me, but also we have drifted really far from the
purpose of this series and missed this merge window because of this :\

Let's conclude something please

Jason

