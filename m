Return-Path: <linux-arch+bounces-12858-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DEAB0AAEB
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jul 2025 22:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A261698AE
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jul 2025 20:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD991D7995;
	Fri, 18 Jul 2025 20:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n8XTjR2A"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3AA101FF;
	Fri, 18 Jul 2025 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752868851; cv=fail; b=RX8jNWxC5gaVKYPiwrxiH8Cmm7xDSTPC8jS4DAzHrSzOlQXYieyiy2QzpSsja7ZzJzDV69b3rUyFRY3Hqd3FXWmDmfhlJOaS+1wMMKs08KHSsJiv6htGPio1NqMt7vzWXiHiYqH9V7v3GW1FaJRiH5/mtAlq5X/FovBQ7Lugteo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752868851; c=relaxed/simple;
	bh=myIwKQ03cfJ3xCGHdJQEYMnut4jJvHfbfmfdjpXEqzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=huz7vQY0jOqDytUctbJaxTMZ65E9JwSeUpf/QR0lmP+/tIz6XUNWArLRVxx48mo0zuapm8mzPp9adNjiZxgpPy0XJ2blNx+Q2t78cvvOmLm+tTFuE62TsIDB4mDSmE7EIiNJQbC13/lt0FyF1gDUHjEyTv119AvwlidugnXvpgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n8XTjR2A; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpQz8UdCAMEneFhGc4m/IuWT+RR0/smYrXlpzho966+DKKiDOmFHaOr6DW8i11vTU1LEAUPgsBD4YtCmue/fEXM/0uQbUKXSORPmqqdshFkEmSRjHCHZOePntV93ZD1bd1ISQqOSPNsIbfyXte7/PxKO4eRqdPAgybCtftNSX66RYcYa5P2b0zFmJvW/htlqrO3e1Dl/MtwZ+IpOIkJgI1yP5u7AjlR61yGA6TD5sD6bbY4/WdAp9kPvGDf4vWDYicsDa9+x3SipY8FHLcTR6PSiZMovgkR2XoEgo3FSjk1XfBPd3lhosT/8G/dnfcFQHRJMl+BasH2T2+3EMm57NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bZTql4wfPNZ0COTbEumhewspO5zrRL/n5v49ZvsMKo=;
 b=h18Mvq+RI/GY4aiCWctpZbVgQUPDl8lfww70HvulXlDDwSPO2srFoorcBGJQdvu+vDiRmYOBrlOCTNZmUl1hEux9+eKVZfLLu7iEcV4MLsACYq2NxDUV/q+DDEcxpHQ8XJ4j9mIluiA7Y0UjjJ5vHUnnfEb7hRFACRIhc5m2H53OnfNh8kq6GKWgAOVusDbed+qA4UpGezwLDv5UEFWGbs8JyxdT3TG7So0fvq45tKCriIkf7btlrqKpjtqBZwmmOUbqr2u8ChnoIm5CMUt9IJH8B2xRmxqBt0AdVjQhUJLpFo1oqsLEc8HwPvqqr1wMsMIhH4BCHWCl1ye6mw10fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bZTql4wfPNZ0COTbEumhewspO5zrRL/n5v49ZvsMKo=;
 b=n8XTjR2Azz1VLA69mRyQZ4gzrvIpi6uWYQtmNZCloLg4/geYLDw/SxmFkJf5lsm7KFNoF32vd/TMOT2RWsqFrZMZyx/tKbqs4ZDS5kDfYP5gswe0VtZIzZPYvhB3i+6kDQZcBHM3CJB44v0m5fFFFRQnwG+QAO7JG7+6VtnjuE4EmMbI3L41XEstAtA+mrFhwApthvw/uarjWqdvyn8/8aJseLYhPOnDExx0K/9wkmzZFrNyhgxK6eXeAal1GU3DIJHTAl6J0EbopP7NKQX1n/9SwAy4dnp2D1S9zCmBmrKLCepSG9GjY/79uzdICJwUBaRo+fvpfpLayVPM7iKStQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7730.namprd12.prod.outlook.com (2603:10b6:930:85::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Fri, 18 Jul
 2025 20:00:46 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Fri, 18 Jul 2025
 20:00:46 +0000
Date: Fri, 18 Jul 2025 17:00:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>,
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
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	llvm@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
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
	Jijie Shao <shaojijie@huawei.com>
Subject: Re: [PATCH v3 6/6] IB/mlx5: Use __iowrite64_copy() for write
 combining stores
Message-ID: <20250718200045.GG2250220@nvidia.com>
References: <0-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
 <6-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
 <20250714215504.GA2083014@nvidia.com>
 <aHYqPRqgcl5DQOpq@willie-the-truck>
 <20250715115200.GJ2067380@nvidia.com>
 <aHqN_hpJl84T1Usi@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHqN_hpJl84T1Usi@arm.com>
X-ClientProxiedBy: BLAP220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: 53455fcf-c423-4607-3f02-08ddc635c8ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sMgZHTdE6/tD1/sk4mfa3eIBiLFUarXwf/R00eW8I7iTNM5k3eVlKStL/hYw?=
 =?us-ascii?Q?C7b3V5OmZZeV2rXsmgkpModk+HDOe38Wa5BD3MPOPDPNzTCippARw3+30Y2Z?=
 =?us-ascii?Q?H7wPS1asf9RCyosidKwD1VYlxBs16wwX4b16LYQgag9VCZ/aSZOkz2Kt5PKh?=
 =?us-ascii?Q?fvJzeaemH8a2PhcZ5izTZArzHB6k1jesopWGDEwCMlEpRwYFAKV45ctFIKIf?=
 =?us-ascii?Q?jbAe+xVZ5myqVdYo5/5WI9muPZTy7J/1R1AROMh1cRVt9hsZgm4GGcc77IP/?=
 =?us-ascii?Q?YV/c+BK3ipBdeABQfnCM0MzfPlfPnpji/73IkwjC9XMvd2UFVhusUu0GuLE/?=
 =?us-ascii?Q?f81cj8Ulz2u+x8oC0OoFVNQvBXxozoYjyC6JFcnEK/OZ6SKastipRUwawXJd?=
 =?us-ascii?Q?FSt4EDPJioFPcWJuYCneaf2s0ox2LsG46X2LTIma3kSVf7jbF7Xxbp65pLVO?=
 =?us-ascii?Q?lI64q+AJYPbyyp1VUspUV+VRkuLy96jZSuj7UMcF2EBdfQqjQcX2fbzQJc/D?=
 =?us-ascii?Q?oEebCUNrgPkQm9BJicfs0+1bEQ2lhVd578jKBncLYdleIadt1h4qJhuVJiDg?=
 =?us-ascii?Q?7QUMWRpTpDI6XV95WBEOBTRR4Qnmeb8bir+yGziWUVX0fwNoPr8qEczAvqIC?=
 =?us-ascii?Q?aa59ZrT3OPCP3XgzI7dxMrpkb294wgNtdDPFwz2RGcA5U1SKfHKgOuYObhi5?=
 =?us-ascii?Q?5GJiCO9CM3Akh6UNYt6LSX8+m+wY3TnkMqb4fjoRdlUd0VL3b3gst/Tn7Yrv?=
 =?us-ascii?Q?gfR4GPOEGr+OnB9SKyESK3FqInSTbXinOOcVnTPrx4meUcuFPwVicQI+cfPX?=
 =?us-ascii?Q?MHBvaZQR3EjG1qEDz31XA4L4xDcHOAlEhJDHgHJW9lMKR3Wxkr82ZGJrgsqk?=
 =?us-ascii?Q?P8MRkWwZytzW98QEI4OzYCiW331JpGb6V8lxnD6V2fVi6SikwvPBMmrnuOQy?=
 =?us-ascii?Q?oAPJX2EaDdhJ3RTgiVYp9PVlewT8DOZXfGkBg/8y03EPD6MibBuhb4ByvSqb?=
 =?us-ascii?Q?tVq7TTqfvSx9sCGKWm6FdAf4ZwXmUYw3WjWC+UIq9HDZfzYnIyD5XyrQuoCH?=
 =?us-ascii?Q?aPz07L6BOrv081J93JIu+3xb8kQH5qewUMlLVED3sts/POsRcXbil4vIxipi?=
 =?us-ascii?Q?4GHUOYp21Nr1O9sS7/SRnbW4ryZHZTFJf/qe2AalLnJ1jl9pDpm+L2CQe26Z?=
 =?us-ascii?Q?qDvdi5V1NfLA1eTfH9Pz9aQLWTV67gjQe5Ms2zwrlqR34LbtnQnbZUnQD8jW?=
 =?us-ascii?Q?h0W7lQF1xpiDl/3hvK6EYqR+he1tE/3uaJD7KBx7GLwhc7+wJEnK2FsuWvnt?=
 =?us-ascii?Q?z1+5sDztgyaSKPg/aC75lbRDzz4LSwvmZpEn9SvjDRlwNrwC+0OoZt6stYK/?=
 =?us-ascii?Q?bYvWDX1PejDy7NzQS94ASyRuOy8w9s6SCG5vZTUxTSX9gD7/RPzgqyKhgdro?=
 =?us-ascii?Q?3XWJzg0if7E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MtjleNSmdfXWmHbJGo870zYjw8oTgXRqOYaYjZMicSEDBsHAx0foq2c08qN4?=
 =?us-ascii?Q?Op42FRVWxizlfrqyATQ7N60MyiSlaVOko8AGAV1ohOC/Qi1kijtDHuycbIVR?=
 =?us-ascii?Q?eaYV4Ju5GLrHB5Fjr17WpqNE8+RvzMaMj5jmEzRjvjWRgdxarZwAD4KAKSE3?=
 =?us-ascii?Q?254aTCvgQR8yknYXW41N5Asf0DZvWeF1jLJZqdiygYseVanqSeq6uRF+S/J0?=
 =?us-ascii?Q?7XAQdhehPNFnGVoKlU0lu1JfKom4h8Y2WfPLux6kFp3UuJMRbc8/+Ld8lEBY?=
 =?us-ascii?Q?rYMYKhRiFOtWQM5MeLxXZ2af+IzGaTH53QhRGqF7qrf9lSV0D55jmnTQQo30?=
 =?us-ascii?Q?q6xacCtafuX4awstrJdbeKu6GzSyICHzO95yBDiCEvjUFRFwWv/wLLC9lJln?=
 =?us-ascii?Q?uimHAUmL1k2QXkV1ZyvrGDgljv0NLZp1broQfVc3msexQG4ILO2P36OE3I3f?=
 =?us-ascii?Q?8TRtjrQB9L3IvI7goBVEXqtRUUa0OMYyZ3ID88ijMtLiRhjqwXuhovZW2Ggm?=
 =?us-ascii?Q?0ar9XIs0fJZAX54g29+whvbp0b1ZLeqG+v33lvm3RCTx59qACB0iV4FwpsUb?=
 =?us-ascii?Q?0u8qmVkB3je5b4rKP68XlUZTDvY5j2D1ap/f0DKALmO6FyA5eVn3EWBzTCBj?=
 =?us-ascii?Q?0hGKruNTwg0d0uWUUUZHxJdZwFxI7Fv3UUCPzuxhoOYSqe3lbXB0LNc84LRs?=
 =?us-ascii?Q?nQ4ZnkzPnksfyXWsQPXIf+I4HXu/3IaPPn4dDx5/AytYohG7mvY5w93KOT+V?=
 =?us-ascii?Q?vd2rxoI21ThwrPPAZX6LSAz+AsTw8P6tmSx0QgbIHMRDtvOaowEpZ3vuA3LG?=
 =?us-ascii?Q?02YR1E76gM3wD3ph0jPpLwNXGQQOJpcK4oehuisMxdiyOEucXcn7MSb9EKYl?=
 =?us-ascii?Q?6A2yHe3qPdEXwQc73JVY1fuESdDgh2Gah7C/svS4Q20Y41dZUvulm/PDajeG?=
 =?us-ascii?Q?MGfusFSR4yOnxfYGbHVdUHDVC0SEcw0ra3mrsfynXs/oQdqcibqJD6h6HJQ9?=
 =?us-ascii?Q?Cx03ynde4R2yosyUhc7zpXHpytBPdXtwNthbC5MzsoCo0ES09d9h9i6yy1mo?=
 =?us-ascii?Q?H+DQ+3WOD8GSkCoKgPZPXQrBRSj/Ezd82rGASrU5R54/aaVvt4S83/V5SVbI?=
 =?us-ascii?Q?odrlnPPJ9PaYKmwfZ7AEWnnqR85wdsqIf7yYLSF80YZoanBuF7ONqGZNtYSl?=
 =?us-ascii?Q?6xSGQ+5O5rc5bexVrhHf+ncOcfkBMKuD5FgjjJ9wL5vH76V731LsLzRlyyMh?=
 =?us-ascii?Q?2hRPmqcyOxQOjdkJn8GF4DOHAWv4q/c9bEEPBQ67sRF1MQs9e+wejHC7bi89?=
 =?us-ascii?Q?jAj0svMhsuqHL6Pxvolh2IoaRnAAvRUjyaMJEjEjrvlC+OlK8aGHLzqrTTyF?=
 =?us-ascii?Q?c1Vv77+X4izFQ7P5d0+EyBFKPgu8AINIEEd0d1o49TV38ir3gP4fYk8B4qOj?=
 =?us-ascii?Q?SmDG1C42AFGbGkSukaGnxzgzVsWiW8FVa8yBNp0Uwx7QJ9XxmKnhl2LDCqVK?=
 =?us-ascii?Q?hQ+Y/WQKbdlrlAFScybA3Jjd49USIGNTmgboLikPQv4kBobKarv7bv0KBVdV?=
 =?us-ascii?Q?RZp1J0uj7r4cR6+v4pI2RNlg3D2z7DGGWzNBApcL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53455fcf-c423-4607-3f02-08ddc635c8ef
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 20:00:46.5486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fGd03t2gPEmy+QL288EyYpcaCwf2p8ecBkgra5c9vPyr8tRT8mbevBnoYXAkt2T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7730

On Fri, Jul 18, 2025 at 07:10:06PM +0100, Catalin Marinas wrote:
> On Tue, Jul 15, 2025 at 08:52:00AM -0300, Jason Gunthorpe wrote:
> > On Tue, Jul 15, 2025 at 11:15:25AM +0100, Will Deacon wrote:
> > > > Since STP was rejected alread we've only tested the Neon version. It
> > > > does make a huge improvement, but it still somehow fails to combine
> > > > rarely sometimes. The CPU is really bad at this :(
> > > 
> > > I think the thread was from last year so I've forgotten most of the
> > > details, but wasn't STP rejected because it wasn't virtualisable? 
> > 
> > Yes, that was the claim.
> > 
> > > In which case, doesn't NEON suffer from exactly the same (or possibly
> > > worse) problem?
> > 
> > In general yes, in specific no.
> 
> For a generic iowrite function, I wouldn't use STP or Neon since it may
> end up being used on emulated MMIO.

Yes, my feeling too
 
> BTW, for Neon, don't you need kernel_neon_begin/end()? This may have its
> own overhead and also BUG_ON for different contexts. Again, not suitable
> for a generic function.

Yes, exactly right.
 
> I can't think of any generic solution here, it may have to be a hack
> specific to mlx5. We can also add add support for ST64B and have some
> condition on system_supports_st64b() for future systems.

Ok, we will send the hack

> We can also add add support for ST64B and have some
> condition on system_supports_st64b() for future systems.

I have asked someone to work on the ST64B version so we can talk about
that then..

> Even if we could handle virtualisation, I wonder whether
> __iowrite64_copy() is the right function to implement 128-bit stores or
> the larger 64-byte atomic stores. At least the comment for the generic
> function suggests that it writes in 64-bit quantities. Some MMIO may
> only handle such writes. A function like memcpy_toio() is more generic,
> it doesn't imply any restrictions on the size of the writes (though I
> think it guarantees natural alignment for the stores).

IMHO the '64' here refers to the alignment and multiple, not
necessarily the transfer granule size. This could be clarified in the
kdocs. Also, IIRC, there were few users and they were all doing WC
stores which give large TLPs on the PCIe - meaning there is no size
restriction issue.

Last time around we didn't use memcpy_toio() because it has not
requirement on alignment, requiring more checks and things which
didn't see desirable. To use ST64B under iowrite64 we only have to
check if the destination is 64 byte aligned.

Jason

