Return-Path: <linux-arch+bounces-9064-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3879C70A2
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 14:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44E92B22D12
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 13:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A701DF992;
	Wed, 13 Nov 2024 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a2HcepjT"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC7A1DF257;
	Wed, 13 Nov 2024 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731504037; cv=fail; b=C9OhoM5sfk1M3TMQTO+A1Mi1R4DodoixgKkGf7XQW+IJBZ6HM0B2WQ1YC9gtHv/VR2KDR4BUapsjhXtb3oz22UtDSaiGynDNWsU1wQT4y3rpU7ZJon6VzCTMgq/bbNj3rp8amFwMNyULHXXRrK1rkSYUdxWhDY3hN3HT8ZO7x0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731504037; c=relaxed/simple;
	bh=KDUPsVwJP+twuuTWu/3KcCHtjVhtDpW4FAAa7pOcAvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZFTf6F9mXMaC9s9550XrJAQUrxQxJlAzZxmlQD4zuQvKJiN2RCgUu4gp4cXDine5kaZQhWaEFAKiQYZTHdV64M+JNKPTeyBSJr2U1x/1RePXg6ueJSsiYYqabw2CDSkDfdhFOxW+4raImx1j2o8Y5u+/dWz83y2CRqHcI14BE30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a2HcepjT; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHLuxaFgeWSQS2Vo0AQSXg4ka4/8J784lktU+e+arbyuZc6dsWbreXGh9rpKIDekruoI0Omeq9zatVvPxivoPu4owoTSsKmTEp7nDafPs0micF5EogXuIr3Ir+a67NvQM3vOGFO1S0POG7ZB6c8OuxTq4VmgyI3wC199arNDkLQUS/fQGcd7HCL+KfhHJONq0ML4CjjPhepqe1jvrEo3xNfmwC/rtAY8YuTJ/JjZQD0wd3ui3++lqXf+O97YEj3rFwfyFuW7P41bhb2TCorX5C3pilIRlCtsnwiHj2/hozrWYG2tACsSPbGcNyPr6qg1qPv5okTWCgFgNAsSgK2KRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSKVBlw1aT7k0KIahI7oRmYHNiV0O9vXOyceMUL81os=;
 b=tKNb9YHDWfOcQZaVXxC6GEb1e2vOLAuHUmuAhEElw7nJOIzEAwXBuqTx+eXPPLJEcAYnbSjD9qO6avkctoQB74SZEejpo2Lq1wt0eNOj5njt4WSttfeaPLNaw9TYuJ0uhs+bULeX4w4nHrBZJ+icuxCHgjT2TV7zOlZ6OI9RSxl7a5gKTOmoX8dx/b0nWUf5c2hh1eQt8Lligx5LXfl4msZn/xecyMoHl7y6rzKYEgZv6NqK3gHn6iIn7fdApcP2+hFHy7meiP8Dnkn+3DMd+Cr2vra6S3951KNJB1l3dspgkWKzB7unIf6Hlq/w4PbxYNoU3pyGiYKgkj6bke7UBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSKVBlw1aT7k0KIahI7oRmYHNiV0O9vXOyceMUL81os=;
 b=a2HcepjTWlWxnEmiHIBd+Z0mx3bG5C+e8UHTfPZwNFHtC8c9Uf0bAvhAnJIY/hXzdghBnGQXA941C4PmOey8IJtAXhs3HATiz4eYQD6AsCd/tHjmkCo8gSFmFrTpan7CqGXmQXCYr7/sCNvv+mkA9oR/k+wEuay/j7L/HjXp46Ygl4G0CXpTg4FjIOTIjiQ+cc1DUKfrULP5iQzVa083LhTtH0tosjGWF7t9aZPfJMHQIKDivGRAFMIhP5lG1o2U+U55QJcBYZGqUKLiLxnaQRaNH5b7ugdKjnPFSaAcQ+LnYi21ID0vCeefv8CZYzM0qKWUkFjycL77r+oW1dirXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ0PR12MB6711.namprd12.prod.outlook.com (2603:10b6:a03:44d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 13:20:32 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 13:20:32 +0000
Date: Wed, 13 Nov 2024 09:20:31 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	vasant.hegde@amd.com, Uros Bizjak <ubizjak@gmail.com>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, jon.grimm@amd.com,
	santosh.shukla@amd.com, pandoh@google.com, kumaranand@google.com
Subject: Re: [PATCH v10 05/10] iommu/amd: Introduce helper function to update
 256-bit DTE
Message-ID: <20241113132031.GF35230@nvidia.com>
References: <20241113120327.5239-1-suravee.suthikulpanit@amd.com>
 <20241113120327.5239-6-suravee.suthikulpanit@amd.com>
 <cac1ccd3-4b81-4374-a49d-9afad755b19c@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cac1ccd3-4b81-4374-a49d-9afad755b19c@app.fastmail.com>
X-ClientProxiedBy: BN0PR04CA0104.namprd04.prod.outlook.com
 (2603:10b6:408:ec::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ0PR12MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c569bd-51c2-44a5-7ef8-08dd03e5f35e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1EfFAsbmTEbTj+erUcDsYUAQjySYk7rgku0lb8Ms+dtBjLc0dxq8jKV9+dNb?=
 =?us-ascii?Q?uhZFFqzR7L+CN4rhA60MBe4dDu66NGY2OF1H0FlVjWxYJGsWGODz8Ynm5SMF?=
 =?us-ascii?Q?6QOlOo21gjsaIE+3yuHyZ9ZTrInIpG634ULYEV3U/bjSOnwWFoAMcMypwBg0?=
 =?us-ascii?Q?dg9SFQTRgWoKHAoJWjAZivryw9tkX13Ic0dWPuTR9qg3V1Iv1wj6rBkEIesi?=
 =?us-ascii?Q?fR26IyxmCu3VmrxSEaCXLb8EarwQfMl93j3mIurncNaYe50DWyXna0CvQbpi?=
 =?us-ascii?Q?sLAfQ+l4m0Xe24XAyz02ihdZusnyOuhFrthe/4FE72rY4bPdyOdLvI3yR62u?=
 =?us-ascii?Q?S6+mFUlvCFgsbjR5yfvNuE6J68YA1Oz8I0dwubfz/e5LRgfxhZoWp2RZ2iqS?=
 =?us-ascii?Q?hakoW+5VkEGvUf527O4XEUcS++DXF6Vg0flJvY4vfnh3R6F2Ljf+3o9+BKBc?=
 =?us-ascii?Q?acGq0GdOlGNssSol5Ar0CdDMTuxBaaE2CRQs2c9jT0X/Lg0TgHVkjqrwGD1r?=
 =?us-ascii?Q?50mXN5dT4Ddr23b6EIpixL0/nIRSNAgkHiq29FVmqedzLpp0ivAWRxYyfTGb?=
 =?us-ascii?Q?03jZNvpOy8u15LF/7WzukcPNhZ/MCvGq6bqEGdYncjxVzV8ZKezFI7cwONar?=
 =?us-ascii?Q?oE0wMuQqDZfBEWb9cNC1kB5cWwY83lszjOE1p10hcr4w8B/nmu6ehKasCBCs?=
 =?us-ascii?Q?Tzt+UtLmIToNz59o3mCKJrF4C2fVTOp+swScz9i2MQVjMrYA+vZ56NZMd3jh?=
 =?us-ascii?Q?TSsdoYQBFvauwpYTOfIxJDCHHRpPC8V9vrsNPt+5VtHtpJ5W5baYs2LGLpbO?=
 =?us-ascii?Q?2eGLcL+6c2DgvVzcGJ5Apo2dhjbo+eBe9tGXyF0wYOHABlBGKq5UxmddLeWU?=
 =?us-ascii?Q?AVSRDo8lgzYmxvPkxw5ocXhr+ZQ+R0SoUzsBZ+UBSrqHwPe/oPQiAGsPiQla?=
 =?us-ascii?Q?C0waIlILhgiDI8DhrTKJO2K4rK1xDell+ONUnWKqyBILS3xb7DrMTKXCrrU6?=
 =?us-ascii?Q?PvyWP+6FAZTUGSY3FNDi0EhMhqcG5aDt3Ad8NSoEOgjfcmHv7uon29W9nZF7?=
 =?us-ascii?Q?wIMlVSLhiNV2arljyZI/N51CPjpQHugYhZL8Q+eRDbLiH/+QFxwlMqxwdSPU?=
 =?us-ascii?Q?VIZ6PZkc6vZoH9L4VxDm6O3k3Qd7wYJaIUmDDoi4R+ph9a//5lH23GIIKYb4?=
 =?us-ascii?Q?MQV4zoZX5U1gxEWic37D2yhvQMGSHyvyTexqfuAOFppu6ywKrG00L3sDNeeO?=
 =?us-ascii?Q?1bmKqA2JDNQasOv+v343mOvrmJncevlxeLnKX5ZXSF6H+OiK2LvHwl1k0DcY?=
 =?us-ascii?Q?GURYDGBWnPnhsqn+fDpCIVP8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0K03jyNJItZAmLilC6lpzqsXVb6xszsv3P/WYbngve/0ZvAOiWYOBpVLwb3S?=
 =?us-ascii?Q?diKd1b0cIsVZAul/Khn+bhQTdtZ9kj4AN1+nPyhX+vpq30Y6CiWBuYbBG6mm?=
 =?us-ascii?Q?vn6+Vc+WjtolPizdPcBlm6EmLgeKYQZgQOZngF3JpsqzB5oYyUL2J10US+Bd?=
 =?us-ascii?Q?XuN/0mKlgDd+vE9D2Gem8s6jsdDR4w/pgbYM/eOd9b3VcfkLw0FqZx0rMo8v?=
 =?us-ascii?Q?OOQd1Gl+ErqoFd15OUQMTu+kq7WFJy+UMyS4BFqvla+8MT5I5Kt1as1V3k3V?=
 =?us-ascii?Q?aCMGQVjny1Pff2j7aEukeCoK+34IAbMA12KyH+eud1teSyPD/JY0hF0sQWWW?=
 =?us-ascii?Q?J5HDL9B4PVFfkEB397jc943SIFU7CPSFpl09JDCZOfCB8muTHTDuncjwxhdt?=
 =?us-ascii?Q?Pifo+42kUBliIV4TL2KKg8x1eECT+cBYZA3xIpGRvROybLuw0YOrGYLrVdXY?=
 =?us-ascii?Q?prkdbq8eNgd9sFdPjZf29gsGVAFWhSOTWu8NYcQVjhnm5jFfat7iWDAUan6d?=
 =?us-ascii?Q?Y2ryFy4ZWRojFncQi8jgEun/4VVwLrfuZvHLY7IDFKuWdHWm/OMeTA6Z8Y1N?=
 =?us-ascii?Q?C+J1Y11C1w73slq8LFQ+XK6SoBJhAK/a4M5uIZGr2qu/Aihxg5qiThRYPq6m?=
 =?us-ascii?Q?EPnrDFAI+urf6WYH5y6CXyqIuLOalA9crcAqpeAzXQUSbp30vSvVFv/Wbow+?=
 =?us-ascii?Q?mhLXCSeboLyiybhPsFT/qByLkyWdbmUxPyclmqouOEd3qBeFy2lCUs5ZpyFl?=
 =?us-ascii?Q?xLCaIcDh5YDA+j10tt8cgxfB/FtUJZPDMtd4d0Z9TlEDSw7Y4huGq6UEhPTz?=
 =?us-ascii?Q?hnFqtHMNeNrCv2+M7N3O1/iBGS2GsNsLk2MthuT4mCAM5TtxGc3LhgQfpuJ/?=
 =?us-ascii?Q?/NVYPihz3EmShwuLd53Su5iLEzIYn03VDPlS10ufLoA9X2eUUtTEkQ+FuM6M?=
 =?us-ascii?Q?+fHS8wV5eYZtULP6yTPxYTFqTofRzkVdmJnTUiKMM8fHsYv/28G8QaKRPLND?=
 =?us-ascii?Q?hkE1ehp9LJmGELVXPs4cfzYuOpxIpyWyKPXV+kfID02qlQjprOV7vpDfBIz/?=
 =?us-ascii?Q?x+bppa5ThfaxgxxdjS5wny0iiF+HiDhlQ70IHynFV+shcRAXpZ6AcXTCD9Z4?=
 =?us-ascii?Q?nNjCfAIdR/GO8vonN81rOTwi9ZK3uFUZ3DwBk0XE2gdpzqJxDrmCllPYehwC?=
 =?us-ascii?Q?vNDM5dXWm7mhhmp5cpM4Z0s4+ThnZsGhT4Fhyy67OSKLNoYpcI5K8vSWK9YK?=
 =?us-ascii?Q?s6Mks0vc0j35hGaF8xzJG82tBW5OR8J7IuX1PUIIMbmjo2h0CfgoVH7VWnRc?=
 =?us-ascii?Q?+Y3hOsDA/yQG8lJrZbaY0J1kF00yRjJ4AgV+BCikZt/oQO7sKyO5nujXZuZO?=
 =?us-ascii?Q?29A9L7TrTr8xairTUu4VEuhWUFC2fyhyhf46FjcYFhZFDCkFemOyajGaafcq?=
 =?us-ascii?Q?P32XGqSgSa2LXW3a7EGbnGocjIOlTW0iTOdwhfhGmAr+kSdKhd7UiDfoqb4w?=
 =?us-ascii?Q?m9EVk1s6nRnstCqVf6czJnGkQ85bqVYnU/hXMBJmdPTRBP5AwXufljJbID9i?=
 =?us-ascii?Q?2Qi/NvCf9gRWMhYyUCM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c569bd-51c2-44a5-7ef8-08dd03e5f35e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 13:20:32.3365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5JX4pGyA0uttD38/OQrf5s7HtDCHSdkpLIT24+9XAX9Tb/ZkOCIMCirUGj6OUzu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6711

On Wed, Nov 13, 2024 at 01:50:14PM +0100, Arnd Bergmann wrote:
> On Wed, Nov 13, 2024, at 13:03, Suravee Suthikulpanit wrote:
> > 
> > +static void write_dte_upper128(struct dev_table_entry *ptr, struct 
> > dev_table_entry *new)
> > +{
> > +	struct dev_table_entry old = {};
> > +
> > +	old.data128[1] = __READ_ONCE(ptr->data128[1]);
> 
> The __READ_ONCE() in place of READ_ONCE() does make this a
> lot simpler. After seeing how it is used though, I wonder if
> this should just be an open-coded volatile pointer access
> to avoid complicating __unqual_scalar_typeof() further.

I've been skeptical we even need the READ_ONCE. This is all under a
lock, what is READ_ONCE even protecting against? It is safe to double
read.

> > +	do {
> > +		/*
> > +		 * Preserve DTE_DATA2_INTR_MASK. This needs to be
> > +		 * done here since it requires to be inside
> > +		 * spin_lock(&dev_data->dte_lock) context.
> > +		 */
> > +		new->data[2] &= ~DTE_DATA2_INTR_MASK;
> > +		new->data[2] |= old.data[2] & DTE_DATA2_INTR_MASK;
> > +
> > +	/* Note: try_cmpxchg inherently update &old.data128[1] on failure */
> > +	} while (!try_cmpxchg128(&ptr->data128[1], &old.data128[1], 
> > new->data128[1]));
> 
> Since this is always done under the lock, is there ever
> a chance that the try_cmpxchg128() fails? 

No, but if something goes wrong and it does fail it still has to
progress.

> I see that the existing code doesn't have the loop, which makes
> sense if this is just meant to be an atomic store.

I think AMD architecture imagined this would be done with a SSE 256
bit store operation. cmpxchg128 is sort of a hacky stand in since we
don't have that available.

A more understandable version of all of this might be to have a
store128 wrapper function that invokes cmpxchg internally and
guarantees the new value is stored regardless.

How hard would it be to invoke the SSE 256 bit store instruction from
the kernel? And do all AMD CPUs with IOMMU have it?

Jason

