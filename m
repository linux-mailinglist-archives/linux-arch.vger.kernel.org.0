Return-Path: <linux-arch+bounces-1399-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D520831D7B
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jan 2024 17:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0BF284A94
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jan 2024 16:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D9228DDA;
	Thu, 18 Jan 2024 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WjIDOOle"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A0A29436;
	Thu, 18 Jan 2024 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705594897; cv=fail; b=jVZ2jtm3gNb4g0ZfoSl3CQ5GnwNF3x6VVRjojUUiydHsyVgNeK4xKUVd42J9LWNpcKnRT6RizOMVMD0gFOlHxLp3aZwRaRhE8MmGBYfGaufFj/5eVRkPR+h6xl9Ug3gP2vxzfP77yavFaomFCM4vgFoFfqmsLIhXKwLOvlfNEe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705594897; c=relaxed/simple;
	bh=bbdHbLoc0XlTFDLWj/6QlyIAV8LQHHMZMuZDRnXsm3k=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=OO5ZYVAmgPmzSSUqek6xuxcsa/LPs94PiL30OHPJroGcbJmpADr7gUgQTNbjhhs1xMVDVPe5z/NTExVW4npr3RDG/a8z6XW9mjNnjANHXzdMRECq+KOYYxg0NI/nwR68YNX6eArd1g1AOy3HEhN7LTF+zTmnSGxk9ehLyVyo3gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WjIDOOle; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUFryWcxbgi/Wjlp05YIqLz7uoQanKqTYGlje7nAE2OdXToNoUjGRhzTIyMXJLRsBps4EMqc/FheKsNGA31Ro94WjhUeENUt4tOZBryS65NFRpMXy2OV6euIboNagR/7YcQjeo8baGeSIrxu12m9ESNe1hyk5uCVIs2hF6WNEcaGqKs2NVFll2SaeBRXzyohH3A/FsNYntCZAaiTfNUwc2iKHt8IWernFgNLj5ejCo8KtsZL3ylkF6CIIjCCmvUEM2ZCh85GxfwGQav4AC+avDfA2o8tqOeFE/doUr3C17C6aq69x9IEw2cZROTILwiJAdtO9ubrpU0KVkRdL8Pc6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSXSjPxaK/b/nL1kXpufY73GaJa05Y6YwJlP1IZowLs=;
 b=NPtfIyrpzTkY+hPbQ7ZO1TUrtxuRx/Jr80QylJcXIfcBMSd/glReodKMmyg3XGzw+9HLSaZaCgNooLbD50O3rM53ZfbKMd3BxJe+m90824iapHPBSFxutLfXqI3OMQsnAaIUb0PV8YTn6f96T2W7CDs/BQBI5Niw5a/Bv6wbSTELcaejbJMhPB+NzgmJD/rAvxdYPCiDrdg7A0WVBf8d5zYslCrynnhwFrbrnro9HpNPgbCxZ2OHB+uWnBP0MRNTgFQDH9Y0R6cnGvyNgdT/97Gll4ifLla8DWvPI00sVDmcBWNq7uhffL5a7Fm5VHGYRPB714Xl/aB/2Dwc8IdP8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSXSjPxaK/b/nL1kXpufY73GaJa05Y6YwJlP1IZowLs=;
 b=WjIDOOleAOw+Fk7POIX0Qn3NGH7WLIDnGg4hVUX2WP3g9Qbsq3zRH/f7FOb8UxFdlOGbslLQkWqGF2ZhgH2eCrUca4a+CtnH3PR+4jTolaJB7zmBZd64NZXLNS7DYL6JEtzh+DggGU+dqxnIfc9ScNDMv+MFFXmebad8PvHu2bo7ibsG6xDGIwQNqI0P59Lj0aO/+ASCXoGaLigl+Lf56SCn7l3GHRIiznGTfEtSvW2hgNn8MGJ8FfJJpAeLXhOy9UsHQq8DR4tWNIzaFQ7BctCL6B2ZOMaB+kt824R7UJC0Hy3dzUSFOk7eAKgIqddP3YjLplujvAEmloD2YQoZrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB8487.namprd12.prod.outlook.com (2603:10b6:610:18c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 16:21:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 16:21:31 +0000
Date: Thu, 18 Jan 2024 12:21:29 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <20240118162129.GO734935@nvidia.com>
References: <637dcc4d69c380bd939dfdd1b14a5c82c2ddfaa4.camel@linux.ibm.com>
 <20231127175115.GC1165737@nvidia.com>
 <002043477bba726f7dfb38573bf33990e38e3a51.camel@linux.ibm.com>
 <20240116173330.GA980613@nvidia.com>
 <ddd56db15bd2c87073a2f839e06cdb80d693272c.camel@linux.ibm.com>
 <20240117132613.GH734935@nvidia.com>
 <20240117175518.GJ734935@nvidia.com>
 <8e043042f425b4c574d1d3c3ed686253c8cd3517.camel@linux.ibm.com>
 <20240118140039.GL734935@nvidia.com>
 <071e2d2e301769d523dd613e77c6541a61bd496b.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <071e2d2e301769d523dd613e77c6541a61bd496b.camel@linux.ibm.com>
X-ClientProxiedBy: SN7PR04CA0055.namprd04.prod.outlook.com
 (2603:10b6:806:120::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: ddbc23c1-3582-4d7b-e0bf-08dc184187ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JqacZz7cI6IGHGQScavTB/jWhyuX7n52AUdLPV2Y0MNcY3KbmbbRhCI0saR7Xg6xgLJ4qevGb6iIUwtyqAPsfRDNmDjwe3QU1hVPDSFMTWc0dIXfevryAXJY6t4zhxOlq1VtqbkvZEEU/F+sByI09V31He2xiKZAFW1Jkvl94O6buhTWjiUSuJFArnbsQxlb1fdugnPVkrwgSscT/0snolJW7YAxAi9oFQ/RVYWmAg3un9y0HSg0DYQaBWG52C4+HfYgUtphn9t4LHNMUY+ZlQRTHLZm4EhT+PEU6XTGAZJXQqwrukutN0iBbZLMerrJq132F5aMGmz5VanDxtCwzMFfPOyTkDxxIPcyQE4wo3VVussDfKq4Ylrv8A8e4DIPKNK6jmaJQG5u6OuqeXy39+uGJyi7qfpABwt2c1LOMo9d8c1Z2zo0JxfKHb1e5z5LWNyUu5v95cGlN40Ncb/Hz7qMlLojN2/1aKHHcRp5qSl498lJjVHFGs3/oXM0LU4+mYAE6K0ZRTPL5OGSy9tzIh6ZlAmAmPP312KmCDAY2bmOAfZY8+lhl4qMFq1RWGOZDntWb6GbLdm/eEWB4OBdsTQZoGa+kG2BZAMBTS2zmiqzP/NqBEuYbdTlB2mYZCSUkn5KpqifG+rPP9jFHTePqw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(376002)(366004)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(66946007)(66476007)(66556008)(83380400001)(54906003)(6916009)(316002)(2906002)(36756003)(8936002)(8676002)(4326008)(7416002)(33656002)(86362001)(5660300002)(38100700002)(41300700001)(6486002)(966005)(1076003)(26005)(478600001)(6506007)(2616005)(6512007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PzT5Jy8VW7uCWfGMYkXUZWheZm9E7fD7PbQNRAWjSZSqr7nRO5fIK6avkuyC?=
 =?us-ascii?Q?w4c6Jt7g5IN07LJDhFFXMQ/KysOYH2lIuu9MYVhd+sjUcnaySCMvtSOSQDYJ?=
 =?us-ascii?Q?8r5WRh2NxZELNlj/iXJ/pEhn4dP8roEaSJbLFWnYfg1Y1eFzljvo4kU57xDe?=
 =?us-ascii?Q?2BWl9xScfkGRV+Z+RFWdJ6RGL0B3RkRm8ioZX0xWpwNyDEhgA45wo1axgjN1?=
 =?us-ascii?Q?+lm33DSon4HiAGUcWiIC3H5E2wJG9axqTNcmQ34+uwVvrQsA4ZBULO/qvh2G?=
 =?us-ascii?Q?HNTXx//sor5ESeadB5S647EgDJJfS9P0/FQ6d7bZSb0qUYG5Na3oJLBPyxFh?=
 =?us-ascii?Q?tkI1d3UD9C1z7VNyXn5sbpeT3IWs2+nfepP/41X87209wbvzNxUoxzFWI3Ch?=
 =?us-ascii?Q?rO9LNrVEF2ZEqMEQqEiSkeQqPqt0gmO8Vwm9F2r6MJ6WRaCwSEXiCf3PqngQ?=
 =?us-ascii?Q?gcGBXlhpX+dmvSESA5too+87WnkCDsjs1EWUeOkuN5t20LZZDFtDcMTBt6WQ?=
 =?us-ascii?Q?AdvZ679Cg4umHTS2G0Y49VhzpE6jBXz9UhnZBBBXWsvAZ13Tv/thBkFgut4E?=
 =?us-ascii?Q?WSk+jb17dHH8YRtMFe7c1MQWN4XLVaScSYRKXbWxTQ2AlEJQpb3Gv6vOM8Gv?=
 =?us-ascii?Q?MObgZfUosSLJV0ajYUTow4Mu8i0w1OvIf5oS+9K6WNi3Xf2Kiy8WGPaGh0yp?=
 =?us-ascii?Q?tmVt+4/MNhXf8GEJparvTR7s/mc8WyoQ3YJILrM683Ca9XAXUBTjoFmSjPHa?=
 =?us-ascii?Q?Iqp4o60uSD/FU3iK8fQjTXDC/suX2QlN7pvO2NShh3wtv7RhiOLKbQRsE+tH?=
 =?us-ascii?Q?qFj9/Q4liC6DR8JpYLU9i3Ng3PX/bJb4yXvUbyIEc5aHFf8ocoCpcTEIqV8T?=
 =?us-ascii?Q?+TIB9aoFhhJUA80cR2nrIYIvibX63vbLzB2e3xcHgvKwKVPWc3RBZ5dVuzNn?=
 =?us-ascii?Q?cPkN8TD6iV89bBbkY33aZk/sKTIRdR4nrbaNvZXBs/D5ZegKFdYUiLVKAjaQ?=
 =?us-ascii?Q?Tyiiwauf4KPZZejMcTbxijmjf9ybZHdAKT+8Kg/N6TDOvVDDZQhiJt2z6whW?=
 =?us-ascii?Q?a/3lNVsjC1uz/anvDUR4xF0Acs8qcx91CCT7kLmcGk3tGrFjMIUxNNpibWla?=
 =?us-ascii?Q?2gHOIuAglZ71jc8XrYt9ZdY39V4O+nj29KZtpjTQy8tQYFchzxVjzviLAu15?=
 =?us-ascii?Q?3dL1q0j+yh9NBxRltrnfKs4iKTUIaVQo/hJoxjACcQMMKajtuFwZydrZIIQ4?=
 =?us-ascii?Q?4kXikzhSZhHs7jWhxIaQN6bpuviLAvGmYTRewQEAbOGCAlipJuzSGV6SvRP6?=
 =?us-ascii?Q?yWt42N7P3F9FN9105dbm3wm52lqNA/YTkADmF7IwqDNWu2gkZ/U4OJu1tsxQ?=
 =?us-ascii?Q?JgxmfmY1kJA+hl2Tf2Bkft0AJo7TUkzCMbauWWaZ+d50InR326cOpgZ+oJlL?=
 =?us-ascii?Q?UcRQw3YnroWfmTGSCG6HSaxn913BIA0l1f6dm/ytZHDXLEFQ7eXjfk75XMDL?=
 =?us-ascii?Q?EpBhDu7YjDYhKXFwwiiIviT6B927o645KkVgFAlNcdNFyUOGwebdF7RwCIgo?=
 =?us-ascii?Q?9/GZfChVTPPuh9zjaXubooFMXLz9RMqlNWpus01A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbc23c1-3582-4d7b-e0bf-08dc184187ba
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 16:21:31.0026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8auO5/5aAQPrAH1dc36P7EkwIrqb3TSRIia2hsbLtkhb63X2JrD1YjZFvMf9+KcP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8487

On Thu, Jan 18, 2024 at 04:59:47PM +0100, Niklas Schnelle wrote:
> On Thu, 2024-01-18 at 10:00 -0400, Jason Gunthorpe wrote:
> > On Thu, Jan 18, 2024 at 02:46:40PM +0100, Niklas Schnelle wrote:
> > 
> > > Yes, we need zpci_memcpy_toio(to, from, count * 8) since our count is
> > > in bytes like for memcpy_toio().
> > 
> > https://github.com/jgunthorpe/linux/commits/mlx5_wc/
> > 
> > Jason
> > 
> 
> Thanks, the s390 patches:
> 
> 
> s390: Implement __iowrite32_copy() 
> s390: Use the correct count for __iowrite64_copy() 
> s390: Stop using weak symbols for __iowrite64_copy() 
> 
> Look good to me. I.e. you may add my.
> 
> Acked-by Niklas Schnelle <schnelle@linux.ibm.com>

Great, thanks. I'll post this once rc1 comes out

> I did test your patches too and by accident confirmed again that these
> do need commit 80df7d6af7f6 ("s390/pci: fix max size calculation in
> zpci_memcpy_toio()") from the s390 feature branch to get the mlx5
> driver to detect Write-Combining as supported. Note, as far as I know
> Alexander Gordeev is targeting that one for v6.8-rc2 since we had quite
> a few changes for v6.8-rc1.

OK, but we can still run these two things in parallel?

Jason

