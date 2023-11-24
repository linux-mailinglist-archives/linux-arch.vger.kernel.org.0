Return-Path: <linux-arch+bounces-437-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5447F73B8
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 13:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23921C20C07
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 12:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60587241F7;
	Fri, 24 Nov 2023 12:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qpAxrrZ9"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BB2D69;
	Fri, 24 Nov 2023 04:23:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GamiZPJCthYAWjRgejtTPgYkXDIS3D/c0QQHRV3MGN7cKvNsemxdlc1fEFPcI5MxwJo3EjnORq6VhQJqir/4FXJELWQ1vRJhm8nw5uOloWifPQy44WHolv8J19UtlmB/cByZfiH77qQWHTvTQtTWLVTMm/Z0AE7xFDdqPuiV+tHLrCQim+14S9cyDnddqZxGbX3d+UjUK4pMMdldAhiB91NyTKZCM/ubwpSkySBgh1qiKa6Wb1ZX3BD96h2Gxxo14KHzFYV1POhgYkP1STPjBfhA0bynXufIlFNC5j9IxTsmHnh1Dcx0CXgZ7VTHzExVvqSrIy4Mk+//xbMHz3Co+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uB8kU5w936FRZa+uH3DJnbzbMs2v7LJB0DlsA987dME=;
 b=JP/LZ4gpQHdscvJQdzwH4io+6vTncIMh+wBss1MC7NdlIrVQ0lSP2GSPWJFehETlXY+1EwxSD1OXLhhVkXgi1WgcLYDNQ2uIWLw4Jz399fJKrbQM7mc4r0a2itpZRBNYnrOjT0DXv3BX86BhrBSm4R/prQz15Vd3GD5EanHw7i/XMniD+2e2eGKG7Gbh+axgzdpFSamHdCvfJmvuv1NN4nzS77VkNy/5kDEzEHql+HLOHmsjDIZMAERH6eyVu0O9XiYYRIUeWkWqSGSZX0ezrUXFxc6lkB8R6RodVi3ejdQ2vKM8ascZCHV5haHKAPvp0jDZ/qRdKfbBFNs84hJGcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uB8kU5w936FRZa+uH3DJnbzbMs2v7LJB0DlsA987dME=;
 b=qpAxrrZ9XX1gVsny2ppZHddbcUr5NktZxF5zuOcJiTiKmGV4NXr8Uejpz9lDWmbFD0rcE59pww65Yn3xrIw0GykWZsGwAe/UQX9LYwuO0j7UkG/q7kwJ1shKbJux92hc3fjBBDoEhOvg/qtt5heDU8XGJIdTnxuNiBsS+w93g0VZPs8izRR1YFrIapiY9H8MBJ3n4ViHAblGJnxS2HJROag50J9AQbqkApVNa+9rq87+I+nKNvrna90sxMCMJOH+OczQRSoTdBWLCmRYzmZ7ubV/17SHYBId1GFTrS0CFOURckXE1fbCOBaNsxYG/y64kd8EiQk2LauyQXB9MQZY0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5366.namprd12.prod.outlook.com (2603:10b6:408:103::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 12:23:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7025.020; Fri, 24 Nov 2023
 12:23:53 +0000
Date: Fri, 24 Nov 2023 08:23:52 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <20231124122352.GB436702@nvidia.com>
References: <cover.1700766072.git.leon@kernel.org>
 <c3ae87aea7660c3d266905c19d10d8de0f9fb779.1700766072.git.leon@kernel.org>
 <ZWB373y5XuZDultf@FVFF77S0Q05N>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWB373y5XuZDultf@FVFF77S0Q05N>
X-ClientProxiedBy: DS7PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5366:EE_
X-MS-Office365-Filtering-Correlation-Id: 38539b40-d2d3-4358-4839-08dbece83901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1MuSQsJZqKAAw6pPuNbDig+8BQkTM3jf5dfPOX68dEP8Af22R1u4PKhCDp4O4RxMd1PqZqsPSJTKIYFTdDqQy+aRKlyxhfxt8ohnhQJM+3tb+jv7rIG+WqA1f5xTEhC8jzHbaq4ZMvNOfSNNhC3hMemEg8EwkgxQGKXOmLK3TWmAb8NbhRPwjc/xKH8lJ7p8gvEL5vwSyLLm9OnquiAhvPNWW9yH9eJdi7odoHaysTodJ4TnTjpm8/hk+HateUnuw6C/ZqVaCNg/mq7R5vd3lKgKA7uKWpzDQhFqsZcsPLul6A/YdrSNQXTmAWxUeKmAy2AdaJNbO7OtU/RZzIc9JNGd4JSwXCStsImkulss+ksFj1T20Nc48bIitXLOexdGNWJ6pVlhmSygPXSybkn9IAsjI2dpUDJHIhuYMa6Sx1ASL/emvUWN1x+w9kbR9MOZwx5Y/t2Gle9acP8sgjdEk2LLkL5gem+bna8xhLLALvWsdQXdvZw7vKlReJS5N2uCE+2rKZSuh/Kd4YNWVvalcbTLND71T0hhfF8uuEEb4lBwYTwgO2ZF4MLJUlMNhtuTmn2plzJZw5euEYf+wvIbR6B8dW/9BreXJuYFCW7c/5M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(136003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(38100700002)(33656002)(36756003)(86362001)(8936002)(8676002)(54906003)(66946007)(66556008)(316002)(4326008)(66476007)(6916009)(41300700001)(7416002)(5660300002)(2906002)(26005)(6512007)(2616005)(1076003)(478600001)(6486002)(6506007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JQ8zHCyYIEH7vyz/fPwaVEa52SYWwNrlNjivkfq7kMs3IP/eCKjNCcFPJ3fG?=
 =?us-ascii?Q?Kjda8u//LAe59VQkblt+IrSDXQWpS3+k/uDIMMyb70TuxQglW0p9OEL1F6IV?=
 =?us-ascii?Q?dPWRL7qqWVC1oLHqAkdXjr2i5VIQXSNZErR1XEpNU2LL5Dha+2TjoUVpCLv+?=
 =?us-ascii?Q?e+cXc3/Cz8cGip+12B5W+1sjjE7Uay0m/xJK97YKdV50qKSBpJxt92BPH3xf?=
 =?us-ascii?Q?F/z5kaS4yAeMGQpt7x1eQEQoipc9cn1x1ZBvcWYimXUVhhcJx7KVdoDjZFkJ?=
 =?us-ascii?Q?52qAmj9EZy1XUG1nPpOmzqzsVQBwxtBQKn2vUEkWkX48UP6mH35ZSf7ttaQH?=
 =?us-ascii?Q?9dMYJL6sXhlJ5bUMBxHuMZd9w5pHaEiRnC3X52V4bdBVAxfan2H3232XnOUM?=
 =?us-ascii?Q?i/NuRdTtn7mpMKwdMY71gFuB6Ln4BhA8Lq6IABaft8h2w7iKc+hYJkK8hZRa?=
 =?us-ascii?Q?xutqGh+6L15DlGq/QhGPqK2svdRar2l9c3bT/Ar49PrUoEW1tOq8cQ6QKvKL?=
 =?us-ascii?Q?U02R35pZ6dOR0Cgh4wBZt5p4Qd0rqy8Mpkp5gEwiEKenzuWPhLJwK+u2Z9lq?=
 =?us-ascii?Q?+3vRFcKS1HZdmNyiI+jpZ3xl3inlF+c8EmHWTDGVgOjLCqAvGwfEDsN4k5qi?=
 =?us-ascii?Q?kU/CBpAIuxdd3qYZYDVJvYr/iLJD3uvRFE95FSZCd4/G+DUWVbdNI2u6duRX?=
 =?us-ascii?Q?IkuP9useqTx+QWX/MhsJJFiL4WyG3qlVTjjeABLhzmJyB25ZuLmiy8JeT26M?=
 =?us-ascii?Q?gt10Jcnz2OkeC/I9EMIoiloFozDkxGZzBQAFxd2c810F434CS+VyzBifJvg7?=
 =?us-ascii?Q?+9+vKLUQrhuRSwYN6+6w14RzjgGdlWdiIcGEvb+y0yKa0qoHyANo6GczSnzg?=
 =?us-ascii?Q?wnkjQkEn4PRBjtQpZEha2vJArq6Ti1ty7spZyBzel9QXjxvCBFp+gvodaliB?=
 =?us-ascii?Q?khB3C1W4xvUAysP3AWABQiwKpI7bdc7iSb1jicbJ8aGW+UQq9DtgYTNWCwkV?=
 =?us-ascii?Q?DXgp6ttzsze2R4zHtHyCNC9DiHZub45L5GqUobtVMJ3eS04lPunlo0BTDOJY?=
 =?us-ascii?Q?mbsc4Sj3Rj8e4Ux2TVHZfVPm5kZOnUJUGsMcE5t0a97gsSqneORAzsVF1jIb?=
 =?us-ascii?Q?h59lDES0atbhlqIcu0ixCDl1olGlR+vyNx9byqcZrr20nQ+qkmjGl9jZ9WGs?=
 =?us-ascii?Q?hk7vGOP292vy6iV2a2Wj2cXRuqUQM5rIXILQCKG3Mv+JlpwyKT3j0wIR6s3g?=
 =?us-ascii?Q?5u05t24c9edb0Kgmo4kXRVhUfTt19fJFnTF9KpgR5kVTRCHT1Ro4HAAVHMMl?=
 =?us-ascii?Q?Pss/yP0yyAYV8PmnCu6xTp6JzgNlSmq2Oqe9Vq/CGzXf7US9I4/+pxIgWlvE?=
 =?us-ascii?Q?tcwjZoCM6ForfwMGUQDMblqn+NS20gMz8TV5X60HkY+BygRJBvMB426/goDy?=
 =?us-ascii?Q?EGut6gY1ygEisiqTfSptFefc+CeTPDZjK9KAKf2snAenK37a6ubjb2+dudNl?=
 =?us-ascii?Q?uMPk8vujSpLs5/TpvlSCna9yGMY6XVY3Ci8ZggdiRbeOBp01X6o0t02S1e8u?=
 =?us-ascii?Q?856vHtyHyMnrdlyeNojKXnyQToarVpQjJnKz3u/n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38539b40-d2d3-4358-4839-08dbece83901
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 12:23:53.7449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhR9LwYB3QymPzNxp+oc0iy8Q1qIMMjpQZbkHMlya+j2PHIEG4X0UFuG0Jwe6GXy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5366

On Fri, Nov 24, 2023 at 10:16:15AM +0000, Mark Rutland wrote:
> On Thu, Nov 23, 2023 at 09:04:31PM +0200, Leon Romanovsky wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > The kernel supports write combining IO memory which is commonly used to
> > generate 64 byte TLPs in a PCIe environment. On many CPUs this mechanism
> > is pretty tolerant and a simple C loop will suffice to generate a 64 byte
> > TLP.
> > 
> > However modern ARM64 CPUs are quite sensitive and a compiler generated
> > loop is not enough to reliably generate a 64 byte TLP. Especially given
> > the ARM64 issue that writel() does not codegen anything other than "[xN]"
> > as the address calculation.
> > 
> > These newer CPUs require an orderly consecutive block of stores to work
> > reliably. This is best done with four STP integer instructions (perhaps
> > ST64B in future), or a single ST4 vector instruction.
> > 
> > Provide a new generic function memcpy_toio_64() which should reliably
> > generate the needed instructions for the architecture, assuming address
> > alignment. As the usual need for this operation is performance sensitive a
> > fast inline implementation is preferred.
> 
> There is *no* architectural sequence that is guaranteed to reliably generate a
> 64-byte TLP, and this sequence won't guarnatee that (e.g. even if the CPU
> *always* merged adjacent stores, we can take an interrupt mid-sequence that
> would prevent that).

WC is not guaranteed on any arch, that is well known.

The HW has means to handle fragmented TLPs, it just hurts performance
when it happens. "reliable" here means we'd like to see something like
a > 90% chance of the large TLP instead of the < 1% chance with the C
loop.

Future ARM CPUs have the ST64B instruction which does provide the
architectural guarantee, and x86 has a similar guaranteed instruction
now too. 

> What's the actual requirement here? Is this just for performance?

Yes, just performance.

Jason

