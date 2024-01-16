Return-Path: <linux-arch+bounces-1382-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1BA82F339
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jan 2024 18:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA5A1B239E1
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jan 2024 17:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936381CA8C;
	Tue, 16 Jan 2024 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fVsb7nFq"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0344B1CAA9;
	Tue, 16 Jan 2024 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705426418; cv=fail; b=hyGDoS/Cno+WvkXBgo1zFWB/S1zqknJ0C8FWfQI1IigxLgtO8MkF82eCAEQ46j1UenU8wqXKtrVlVUi33mtDv6zhv1+qNlUEQx0UkeN4PPUvb5lpNna55MYe78IZpiEiENsEyYVEeKTbVUR4beedJNtbR2O1JFoN+Skl3Tiz9L4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705426418; c=relaxed/simple;
	bh=C+CGU7bVTGuIJBZyyAtaEl6IoFzO7w6hkoGxdKJGkvg=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=H48/wMKlnhlYpRkKa6qgUcSnCilWgQIi2JRk/wHRJw0Skjy75bnDHZaaWIaU/JMJnZTrENdZAmPELSjncOf7chk7VrAXCUKg2/qdtT9gmYkEuGs5CVh10MKXVVrodlymk5POFkoqhWmhmWh38F5h0RK9XLTG2DhChggOvzs59AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fVsb7nFq; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gys31cFE59QZmmwiX+8jU8oBoxEN9XHgT9DSVrVBaqgKr/t0u5yebAysviWy+QtUowmn4+K0oDMrrPwWBwjrM8XdAJJMWXUY/OgH95o+3LTYmd+lEUkT1tlgfIhtrU7RMtYqM/xPo93wwSR7ch8rSbEH6SBHTVHpXMuJzFucVpixUF5fZ5TF/uMAOhSH4qjWV8NFOdppo1d99Z59eYfpCs3YTRCrnz+NOOCGK0V40sGvF33x3bPg8xOdxjac3xG8p3Xdd++PS/W90wVNDYyNW7ONcgaSUADhXem+/VrNPw6Pde03OLY/nnxMzWzEfOWeFT7epiYfPran7P713BNPPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+dIfWPJJPhFGQFTb2NcU574z6O3FnjX/+KaOMtl5Ug=;
 b=VmLN4KWDrnzDvnYvkfmnXe0X8DZGwLrt7h+kVbWJDcJrrTZyePCWG1zu1XDQXsGFWFLQdpRKe1gy26KqUH5w7w4WBxwuah1VdovYKtEdeDh9XorfQfNzE+M4yhSzjrLDSkhRSDm68nXSeFQW9pwC4NdQsS1knMn5Mifvz+7j8byXrO1HH33oDMh+U34hl6hYPNBGlCOTO7BSquZST+90dfL1nxcWvSAY7j4LCnOdzcXGHteHwTyTCjz0lxYb3FeWKysNPe1DViu2OuGLt9XZe+UlrEdnhpoj1UJoEme9ob9ESHVMcwRv4XazCziDdzN0UesbLaG6j0WGkab0/hdYHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+dIfWPJJPhFGQFTb2NcU574z6O3FnjX/+KaOMtl5Ug=;
 b=fVsb7nFqajBWjRo/ucOZJFBubbAQIPhCtOTZeJMT0T92sptjgJoRu9noQAuLTfmxB+Dwba0oOc6aSPjY5GKxzMdfNp9F2Jwc/Xb5ziZk6Jn+1TZJR1FN4Kc9RVux7qgw0wr0qwH82G2t6QHKDYaOBANoHHx6ONboqd5aaMomuaJLeLe31kGYVlL9i0oLdqijSQgaEvU17civO8i26PqtlbexG/hv4E6iouPkCO7KVAZBy8hX0u+neQw9wxxx7jggM0CVgzEb8SawX1FLbovne9yJTMDAP0SIxlkP0/5Wxlz1PCBeFqafpbdB31OLtqFlgsYczRw9Ti5OaTfsZ5iAjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6537.namprd12.prod.outlook.com (2603:10b6:510:1f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Tue, 16 Jan
 2024 17:33:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7181.020; Tue, 16 Jan 2024
 17:33:34 +0000
Date: Tue, 16 Jan 2024 13:33:30 -0400
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
Message-ID: <20240116173330.GA980613@nvidia.com>
References: <c3ae87aea7660c3d266905c19d10d8de0f9fb779.1700766072.git.leon@kernel.org>
 <c102bdef10b280f47f5fe4538eb168ac730d7644.camel@linux.ibm.com>
 <20231124142049.GF436702@nvidia.com>
 <14103e31e0c47c0594e7479126ce7fe34f2de467.camel@linux.ibm.com>
 <20231124145529.GG436702@nvidia.com>
 <b3250b9a9af2f29ee3d06830746fb6e8ac49271d.camel@linux.ibm.com>
 <20231124160627.GH436702@nvidia.com>
 <637dcc4d69c380bd939dfdd1b14a5c82c2ddfaa4.camel@linux.ibm.com>
 <20231127175115.GC1165737@nvidia.com>
 <002043477bba726f7dfb38573bf33990e38e3a51.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <002043477bba726f7dfb38573bf33990e38e3a51.camel@linux.ibm.com>
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 081b1894-b76a-4ea8-f962-08dc16b94396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2ImKqe5HXhVLDgluq1KY7v5gOmlOBeE3Gz+neQnfdyxzlhkRSk+wLQsm0oqrSx6aj0agHjLFOODy97CaYfLMZlXsyYUkfUqQH3laffz57gboi1yxgnvKHnIvMK/eFmnfdVgR7tw3BEHrgoHUBv4J2EJBTrGX10O+g9MzD5OfMVjZVeo0qkajDJi15tFV9SdbHW99WEeH0MDsvXBSOeKQEhnXnX1RX3Q/N6Om14dON/nbUDW02m/Vf3nPWFQ7KMaUFEh1RKFKLjuQuudd2bIixLKHEAKKuMBH9x5OelxXOUTNEytMq23rveK/esGU8NkFkLafP1au9woq4PsfmH94lSZYSxyzyhapsUs+hO9akVvUm442gRxzJ5Rh0QH12sBTN5EKvEc/cU37kZGANaoKUPwJ/wU5FiMKFNstieVMD2dxt4IG+aLqCNkPWLZ/jYP5lzD90k0rFhNWYMyz9usx+WIum/MzyI6DR8VVoOfCjv/Y7E16a9yu4CXpwrlUThLesg4emA70dj6hGczM3bOpBLlCcFZKU4mTvMULwS81RybiD3LIUkAgsVJ5QGIf+uWeP+x97P1DHJyRtzvhg4h1SEf3GegdupHrqFOp94s9m7E0UlC57kxZPvPVtjMh6ADM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(396003)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(5660300002)(8676002)(4326008)(8936002)(6916009)(4001150100001)(7416002)(54906003)(2906002)(316002)(66476007)(66946007)(66556008)(6506007)(6666004)(6512007)(6486002)(1076003)(478600001)(33656002)(83380400001)(26005)(36756003)(2616005)(41300700001)(86362001)(38100700002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTRBekkwZitQcDlxa214bzhmSG1UTW5aeU5haFFBa0JVNzJ1YkFXWkdYRy8v?=
 =?utf-8?B?dnA2bVBYSnc4L0daTmpyQ1VvczZ3SWpUeHk2MjA0S3duei9KZEVPbm5tZUxx?=
 =?utf-8?B?dmNHejVaaUFuZHFWcDFYVStSSmJac2JzZXR6R3hqQm5EZ1RJUjFCYnVrU1V3?=
 =?utf-8?B?QVliMThLTHpMMnQ2QlZ5UlpTaWx5ODRYZFBCeWJPZ2xjaFJMcjV1WE8zQ1M1?=
 =?utf-8?B?QXVzdVpYQWs3UHVEUUwvZXBDUnFwdkRsSWQ0RnFOZEg3eGROUDlGMm5JajhP?=
 =?utf-8?B?dHIwakEvMnhyYVdYVUhGS09UaC80MUhsa3FKWVAyVkdaai91OHZ2VVhSWVQ1?=
 =?utf-8?B?dkh2UGRaQlJDWDhud2xZZnIzODcxWXRFTmpGUXRjemg1NnBUcXptVmorRG5h?=
 =?utf-8?B?SzVUOGRvOUNVUEZ6bHBmb0pacXAyalNNSzlBaWJtZG4yZ3NHRGlsWlZwMGhn?=
 =?utf-8?B?SmdCaENnQnFXRVVocWs2aVBuOEpPNWxUbXlFOXl4NWZIeVVZQWFTdkZFVzdP?=
 =?utf-8?B?ZHZIWEQ1WlJpcE41QThRbk9MdERzQ21LNThHdENSOUM3UE1rNGJveitLamJL?=
 =?utf-8?B?UW1sSUxhVVdxVERPTm1BTTZJblJjQkw3dFowNGdJTDR0aG5TeGxnYml5Vk1J?=
 =?utf-8?B?c21QSFNnT1dGM0llY1o0YWhPSmJTdUV1WVBTMTRTNnM0VG1EdTlyQnF2SnJL?=
 =?utf-8?B?S21aVEZFVjJLRVFwTDgzVVRSK2lVSjdwZ0ZUNkcxSEJKSWJIVkVXUlVOb05v?=
 =?utf-8?B?ejRNQTRtT0ZUQW9BeEJrMjdJeHJPOWh2M2ZZRkMyYVdzRXhjM2VpRm1VbkVB?=
 =?utf-8?B?dnpBcHVSOE5EUlUzMmhjS3ZXYVZyNnhlMDUxa08yTDdTWlZwVThWOUc5YU9z?=
 =?utf-8?B?Z1d4aEdQMm9waTF3OExieDVPNlFQVDJEajBCakhacjlBczU5NWlsQ204VU8w?=
 =?utf-8?B?ck9jb01VY2M1UU9NQWFOcTB6UzVCS3BFbzJ3a0dTdkZDYmxJWWV6Wk9leGRE?=
 =?utf-8?B?aFJzZjRKVW9URDNNakJRNzNJSlo1Rk1QTGF4cC93V3JuSWpJcTErRjdsNDRD?=
 =?utf-8?B?VysvakhnTXE5TU1QVGJLeis2aWpKMW52UFdEa0dycDQ1RkZhcnh6MFo0NlEx?=
 =?utf-8?B?MDJIVkZvenQ1NmRqRlpBQ1JhS0xlY0ZJM2tVallwS1pRWFRaVjY0TDF6c3lB?=
 =?utf-8?B?K2lVZzBRMWROWjFpSnFNOGJBcTJ4THFBOHhpZW9PbHBpWXRHSmt5NzVvN0tS?=
 =?utf-8?B?T2lUZnMwUXJwTVhrRTZmdkt4RkxLWENjbHdybTlsTlhWbDEwaFh5akR0Z3Vq?=
 =?utf-8?B?U2dvYWFSYW1PTnovRUFITzE0SFlsVlJpazZsSWltbkhZZDBUUXNHRXpSMlph?=
 =?utf-8?B?MjMvOUJOYjZzcXdndERwR0dBMTBHWlo2S1FLbDA3azhleGJia3lkTkVmSjFr?=
 =?utf-8?B?SzZZbUYyWjF4S3ZjQ0R3YVZsa2lWbHFMQkFieExvaDVNSk1CaGxmQ0FqTWVQ?=
 =?utf-8?B?aXI0UThUTGg2NUp4SHFCMVhwTmZ5OUFRdXVzbVBTZU9xS3FGMW5TQjdWcjRu?=
 =?utf-8?B?dXQyVmpHVzY5Z3RLVDA0MVdlTnVXeHVoMytaMXAwQmsycjJQdHZ3MWF0ZnZt?=
 =?utf-8?B?eVBlZDBlcUFjc1pLajljeUxMQm9HdytQRWFhcjd3Skl1Q2lLM3M0UHgvS0hH?=
 =?utf-8?B?ako4dDZ2ZjYzZHZCeXZKTkxkZDZEeFNLaDd4QTNiWkRoWWJabWV0SE9FLzlF?=
 =?utf-8?B?Z3ZsYi9BaUJIdnN3SmF0WE1YR0dYMytCZnhtZWJUWU9kTUFoMnZNbDhUa0w3?=
 =?utf-8?B?c3hrWEZQQWswS2lxQytpUGgyUDZGeG5uV0E4WGJETCtTcTJFNzlQeHZsTGpK?=
 =?utf-8?B?UnEwZ3JRcC8vdzRLUXBGNnlId1cyM3paVjhMdDNNcURuR285QnBDSjdCK1Zw?=
 =?utf-8?B?MDhtdURjTTdzSlFLcGtrWStXQVpXUDdsYmRLdTRHeXlaNmRDWEVwcWJwYkFV?=
 =?utf-8?B?U1BSQWRpZmozQldEWjAxZ3QyS0syQnByUzJlYlRXUG5jUDBwTVNBUkp1dzVh?=
 =?utf-8?B?RUJlL1BNQUJGVWdrUXp3QlZqTzdEYVpLd0VGc2VZVnA0M09WTnlHQ1hKdGpO?=
 =?utf-8?Q?2LJTtYt0rE7C+jMoMyf1aaecX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 081b1894-b76a-4ea8-f962-08dc16b94396
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 17:33:34.0045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rc4PkDUhASY422/tT4jC24wWmuis28yvGBPcJv3iH4S+v1C1oeEu2MUNR1LnMQ+t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6537

On Tue, Nov 28, 2023 at 05:28:36PM +0100, Niklas Schnelle wrote:
> On Mon, 2023-11-27 at 13:51 -0400, Jason Gunthorpe wrote:
> > On Mon, Nov 27, 2023 at 06:43:11PM +0100, Niklas Schnelle wrote:
> > 
> > > Also it turns out the writeq() loop we had so far does not produce the
> > > needed 64 byte TLP on s390 either so this actually makes us newly pass
> > > this test.
> > 
> > Ooh, that is a significant problem - the userspace code won't be used
> > unless this test passes. So we need this on S390 to fix a bug as well
> > :\
> 
> Yes ;-(
> 
> In the meantime I also found out that zpci_write_block(dst, src, 64) is
> not correct for all cases because the PCI store block requires the
> (pseudo-)MMIO write not to cross a 4K boundary and we need src/dst to
> be double word aligned. In rdma-core this is neatly handled by the
> get_max_write_size() but the kernel variant of that
> zpci_get_max_write_size() isn't just a lot harder to read and likely
> less efficient but also too strict thus breaking the 64 byte write up
> needlessly.
> 
> In total we have 5 conditions for the PCI block stores:
> 
> 1. The dst+len must not cross a 4K boundary in the (pseudo-)MMIO space
> 2. The length must not exceed the maximum write size
> 3. The length must be a multiple of 8
> 4. The src needs to be double word aligned
> 5. The dst needs to be double word aligned
> 
> So I think a good solution would be to improve zpci_memcpy_toio() with
> an enhanced zpci_get_max_write_size() based on the code in rdma-core
> extended to also handle the alignment and length restrictions which in
> rdma-core are already assumed (see comment there). Then we can use
> zpci_memcpy_toio(dst, src, 64) for memcpy_toio_64() and rely on the
> compiler to optimize out the unnecessary checks (2, 3 and possibly 4,
> 5).
> 
> So yeah this is getting a bit more  complicated than originally
> thought. Let me cook up a patch.

Did you come up with something?

Jason

