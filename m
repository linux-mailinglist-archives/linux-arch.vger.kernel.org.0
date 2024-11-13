Return-Path: <linux-arch+bounces-9068-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE74E9C7458
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 15:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8E82872B6
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 14:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B152036F4;
	Wed, 13 Nov 2024 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X2vsL1D/"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EF91DF978;
	Wed, 13 Nov 2024 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508097; cv=fail; b=dbfpNqnKw1UPPNqTcvo1BWAe927atGhzL4gdMa+VAKH2zmiVqbpXz01Ged1KswyyQXovO+wkyQHXHJ9+a7tNgT8d8z0qgR/jaPlX6R5xbK0XV9z+Z7KKbypbkjeaWz5ttj1DZbh2DAbpY28N9VrqAO39g+069jproHcq3BLiNck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508097; c=relaxed/simple;
	bh=9P5fIn0AF8QPYYDq7hLO0CFNads2J5b+Dz6anFvKvDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iOX2BFOXO+IIt3fIeJ08wHQEOZbYJydSY0szsN4aYhMgTORfkYnSIDxKu5I9/io1SEIb7z2UMWGMl8nGxXliSoEjbGOnMs2PHnNazEbj0Cg8FloulH6pNqTT3Nft9zeP3JyZoLmjCxt6b+wK3nItHnpIgkK3IY87w/QVkWDt+YM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X2vsL1D/; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErV6yVIjUbnwpJOJGoHRQ6zMvM3RX9KlYON4TAYfAWEJ6XT3JIPj1k0OkJOYDquomlR8F0+NL0F/Urk6wz0Ng9qMrIVNtsFvBlgjLNyNxDqGgNyxpDFwLo/214jgxk+tzb7Kc3LDqdMsZyealMSEBXuQfRvnNFToVg4WPrTKxtr8kwUzAgjBYM/nBHh2PYor8K4z8z1rsDC90FkKLrJs8SXTcagtX4SYGpkcZzVONxdlz2viiDvorn1WkZPnkmURUM+WfPPADvBPDFLvjxHrJidsJk3JKbnTbiroua5k6UQaHSbpjLlazCKf6Fq6Nz7WFvx08UWrOuwdqEDXecpEBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiusvLRQmw0AAYDj4WojJN9O7qu7yz4hAGEgIgof+d0=;
 b=RFTevuLJbqA35zUoP3ratbzJAEJUdOlE6bsYcEb0gpKlA2bVv2LlysF7NiCJB3eMaqY2gVCtiq5d7F99juwsgWMZC0Q/ZXp45DPcVptkHOCJHQpHoeXcCc4KrXTUWtJizCJOAT5Ldd3LxZib0ZQzMWXVhs8AT/WAopsdTHg5Fsjzq7CDoGcZmYq7dUz64NWMTBZzXy8X3yS9ble+rtiqLYmD/mziqFIEv/RWBT4wUiCKtDXJNI0uZsg0FYIvGQ7Ri70aL65Iz4nUCMXHmFVn4/9dmsQvSMkykti9ecpmlzdRiY2Q3mw4Wq//XSHfr6XfvLidE1cNnLOTuhiqKlQnvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiusvLRQmw0AAYDj4WojJN9O7qu7yz4hAGEgIgof+d0=;
 b=X2vsL1D/3HEDwtAgsFKhtaeu5jY0Gdorw+1BRHT5GLzFHJFGoAONK4Hv+LAIGxWirzD0K8/FVlTfc42BCAOU49zWx5+8uE/pJgIooJk8iPrSsq4YaBqfjcRGLhQd15pd0Ow6nD2Dzuo3DmbHx0h55Z22TICMXmpMmJZT1dLZu+7mqk8eGreAZtRm0wuegxt6xot6R1yxYnBGEoxCsEHlCBe2YYYn5rSFDtbPAKFh0RTBdMEVAtA3StaYZXAsNkmAjXGihgo+iHVMGPJdgfdaNaavOcttMM+7MvtXKdkB09JiXaxshN/KVe3UCBefCuqMHmQvtBa4ssc/q7WR+fLVLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB7189.namprd12.prod.outlook.com (2603:10b6:303:224::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 14:28:08 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 14:28:08 +0000
Date: Wed, 13 Nov 2024 10:28:07 -0400
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
Message-ID: <20241113142807.GJ35230@nvidia.com>
References: <20241113120327.5239-1-suravee.suthikulpanit@amd.com>
 <20241113120327.5239-6-suravee.suthikulpanit@amd.com>
 <cac1ccd3-4b81-4374-a49d-9afad755b19c@app.fastmail.com>
 <20241113132031.GF35230@nvidia.com>
 <CAFULd4a1PHREX6ws9Gyu=TaaZvdgLfh6peoE5Tt010uGyY9Hgw@mail.gmail.com>
 <20241113140914.GI35230@nvidia.com>
 <CAFULd4aGDM5ySO-PeOH0+_U89mnqYqQ7v+U0ZsMode3bxs_X7w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFULd4aGDM5ySO-PeOH0+_U89mnqYqQ7v+U0ZsMode3bxs_X7w@mail.gmail.com>
X-ClientProxiedBy: BN9PR03CA0370.namprd03.prod.outlook.com
 (2603:10b6:408:f7::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: 73ba90dd-b039-472e-16a9-08dd03ef64ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6O/o4wNgWp5XE2dZYuYnAtvhANSWByjxIdwtkKRxr6QWb46ONnHX0u4SZei3?=
 =?us-ascii?Q?M28LffATJd7iDAF0KaKKAtRNoQQ5HYyor+vKAGz64nf5TGcRInvegBtFWUTa?=
 =?us-ascii?Q?OO8DeU5fnIPVwP0H8OtAfGrouzdZQEeTiM79cgNZ2f/BcTRbeV9eKH+zk+GV?=
 =?us-ascii?Q?TVSW4OcjUBdRkAV/xM8+ewGohtNvo58spuNoPp89pzUUTG38/agrpRirYXqM?=
 =?us-ascii?Q?9Mw/591uc2SsbPTGwX7FdbGOHkmzBX++aaoVSjSjSYtoWn5kTpdvjDQ/yleh?=
 =?us-ascii?Q?q1dlQUK+nyQRITvxUJYL7IAjfc7x0/avP9cUjQo6rWX/73fIW0BRXfT5Oyth?=
 =?us-ascii?Q?LWavbGIV4/+3J9hSrI9fTkaWItHDxi5bqgw2Wtni2vslqpBMKHbXBXCD5fpT?=
 =?us-ascii?Q?+j9IYByT3aUXD4aBFiS2c1n3KLR6aEUw79JjkTE8x+xE/1qQWqUTQHTBA8CF?=
 =?us-ascii?Q?a0UI6XCzEYsZOSdznkOHDciFREzM7BL/oxsJb/xR2pnpG/7v3GxmS3IooflS?=
 =?us-ascii?Q?Onz3IokOLE1Zw9yybJJdZ6qEwKl2fvMSZo0hJmHweee07mVDO3HvP4LWrKEz?=
 =?us-ascii?Q?+a6hLLbSR7fjCzhh+RHdePjspYtMfoSz1DsVeSH6J+gwKdbzu9EWSyBvX0z1?=
 =?us-ascii?Q?/6Nu1baOZcxt1i97lTjIV1vO7KvbY/qS/vMvDhYPLPgFBwvc6kS0cZ4SOBZ0?=
 =?us-ascii?Q?36cCSP21suJNRb3Ze9yJl0YMsZrVnE6iXyzyjnAgj+pVSjuYrUFoghS747nx?=
 =?us-ascii?Q?OQbCmzO2ktfX0V65+mi2xo+PVQZnc3f2GWbBM2kLW7Gh7frMMVNS00umairq?=
 =?us-ascii?Q?vuKrqpIzQNfAIjDjqpTUo0Hf6Au97e+2+7ZlUsFuo5FUpCS/wyAgfE6KxSiu?=
 =?us-ascii?Q?KS5TLQeom1XcDIopDF5XP5qCtl5UbGRW0xTqoNTUTEe2bW1TSjQxfq5lHu36?=
 =?us-ascii?Q?pbwyWIMWAW0Uyv0dzAK4cIWnb1YY1oYPgeX1qRMyGV60CIK/ZMU2suNQSdg5?=
 =?us-ascii?Q?pJZpFXzC6PH1wTVHPjvVgBzn5E9/tw0KaE0Z2puq/67zw2ms7usW9Jnwvy8H?=
 =?us-ascii?Q?JaclQCmOerF7NvCseIKuIScgIyquCTTmX+wRttQKpcCJNIPytU2Zhif3Pfbj?=
 =?us-ascii?Q?yJx5RQZ5JR9kmg/JXf9snos/Q7Igdjh4yOd7pfvm8QCPBYFRvj18UIbeInTM?=
 =?us-ascii?Q?/1sgPxzAb4yEEFJRHnyJHjzjF1ZvH9+67acrNxW54YkhS5QiXr37eTwW9QqA?=
 =?us-ascii?Q?A674bcS7efroCp6QYqvTBFmFt+6YplZEWoOft1VcwLKrvbeZuCS+zIc3yUdi?=
 =?us-ascii?Q?k+w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tUd+JuOYGIKdE2dNAYOsjelsrWIyOlGpnRTzlFJAvtXD6II+GxIGBBctKKQF?=
 =?us-ascii?Q?XxZv+e8IFcu5U6089s9dDuZ5XCj45x+n7VloGvfO9SCbFbaoNfofBL1ukr1z?=
 =?us-ascii?Q?fukR2NDeDEI4mYLatALx5JsujoIGQNkcm1uBEOYjj/ZT4UGxKbiHeq9eXe6M?=
 =?us-ascii?Q?kI7Yc4lGNyM30XENzKPpt0LSeIBUemkthcqqjEiqm9OH+yd2Azn7k4r8ZdFu?=
 =?us-ascii?Q?Ia4h2rVtEi3V7oLOGwVRMukLSb1ULFbim3d+nJ+twFzsjUeuXGlJYeLLoEJ0?=
 =?us-ascii?Q?Z6+0BDY0iHOn04JdEKcEy5g2PkS6CzxTKUvbuyO53a4aJRGlijfSd5yC7vrc?=
 =?us-ascii?Q?qu2SybWOfeCEVrja/qnL4pXdPed9E9cl6YB6pRT8AVyHLAolZvPy3/4r8X1B?=
 =?us-ascii?Q?fx0uf5R+LhfGeYWUAk4p4oy8Dit14z15CmU4ADPqc3IxboVt2qoTM7l0b3xL?=
 =?us-ascii?Q?FN3j48R+CKbn0torBCe+c3olH7Sd87r9/NOXfnWs2LhaQuO8SO5dD6RRCYvx?=
 =?us-ascii?Q?BQQCD+jVEHRpAcMimNgLLFoZSXGA1xU9M88GEtF+8rnO2CStT57uHFKaa7s6?=
 =?us-ascii?Q?48+5XedwTnuB4vYeRvPcqv58w6i4mxeAO91f8LSLYykXv/opcMLwJMN6N73o?=
 =?us-ascii?Q?O2Fw+hXrpXWlft6XQEmpX/yPyaJ9KB052zxprDgPi8+ChDGkoH5WX67IqvkU?=
 =?us-ascii?Q?QgqF110Q2J+4MU8R3gJylKzW1zowYioGHIH+bqO9+b2skwoyVOgc5D1avxpj?=
 =?us-ascii?Q?z47hWLCjgHDNCO7dmVzQ+djkOMW7wRMYI/YWVWGKdGjqwD28wzljifAmmdgt?=
 =?us-ascii?Q?j712yWw5ybc0/22cH9m3XlThbCZupL6/MQ1CeAubVjLcQ51+nX/eAol2uzOp?=
 =?us-ascii?Q?iU1Wmp+1suXW91riWniv/8r4sKK1anQWJxs2FGcZ9HpxeMV3vlXp8lS8hpnA?=
 =?us-ascii?Q?fIbSPa6lhtm+Dq0zreleDBT/MNf6tsA+o6vNzyXLIOzZ/c5QER4Y3Pbwew5Q?=
 =?us-ascii?Q?L6dutOAhH9vaI3za6HdUf/hwgWji2Mkra8qyx1E9FYag5UYADJODPEgfN5YC?=
 =?us-ascii?Q?rXNB9B13fw1fxBmwHOZpZ3kciDmQSifX/Wc+pk/Cpe86OxV6AO2SMixVG84Z?=
 =?us-ascii?Q?Zls7Sq/fnnLzh1vgYG2SWxkwCdnxn8jfsiIEB8ey0cARnx9Z8EI+DpVAo7ph?=
 =?us-ascii?Q?NdUUQcq3q1JrVdtkCWkbPUSbRs0r/nJB6tg4BOiFI1jmFMLVnecRkNR/Fc/o?=
 =?us-ascii?Q?LphuYOtTT30sVe2DnSkPb8moPsrxX2+nHh0aNLf8tcNlKpnYX3jn+QFrZsmj?=
 =?us-ascii?Q?IRqEuUS0PbB0qj4l49TXkSRIVDtjKyje5JQpY9CJfR2T8hAp2kXhsqJcEgSO?=
 =?us-ascii?Q?UK1wdTIwtZlr8T5j3AwCZf2vMenqxT1Rw5zhscJ0L+nmYHGb0gwBLueEavMW?=
 =?us-ascii?Q?eHuaAwxx8ry3f8HSUY0xfF0ne2gQUzg7rjZMeyNxANZtzMI/y8RWNXIiYp4L?=
 =?us-ascii?Q?rx9vpZewF/NE+4SzH4eXIGF+QVBBifa8VWLe7SYqokX79MTt7aR+z/LgkMBy?=
 =?us-ascii?Q?9wXXjYKoJ483xLmU22U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ba90dd-b039-472e-16a9-08dd03ef64ec
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 14:28:08.3506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wE68kaSkCxInQUQe4r1lVdW/HE4+92+uueiFYaOP6581uAQZzj/4sF1J6aShdE5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7189

On Wed, Nov 13, 2024 at 03:14:09PM +0100, Uros Bizjak wrote:
> > > Even without atomicity guarantee, __READ_ONCE() still prevents the
> > > compiler from performing unwanted optimizations (please see the first
> > > comment in include/asm-generic/rwonce.h) and unwanted reordering of
> > > reads and writes when this function is inlined. This macro does cast
> > > the read to volatile, but IMO it is much more readable to use
> > > __READ_ONCE() than volatile qualifier.
> >
> > Yes it does, but please explain to me what "unwanted reordering" is
> > allowed here?
> 
> It is a static function that will be inlined by the compiler
> somewhere, so "unwanted reordering" depends on where it will be
> inlined. *IF* it will be called from safe code, then this limitation
> for the compiler can be lifted.

As long as the values are read within the spinlock the order does not
matter. READ_ONCE() is not required to contain reads within spinlocks.

Jason

