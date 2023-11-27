Return-Path: <linux-arch+bounces-477-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 654457FA851
	for <lists+linux-arch@lfdr.de>; Mon, 27 Nov 2023 18:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 967291C20961
	for <lists+linux-arch@lfdr.de>; Mon, 27 Nov 2023 17:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF463A8FE;
	Mon, 27 Nov 2023 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VrIvg7Qh"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA07E111;
	Mon, 27 Nov 2023 09:51:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4is2usFp9fK9OWtCk+F+oQdLknajecrIZu67K5LMt9Ku3ThD+dkUlhWLJOxXAnCRRMWpwupV8soxNquYnNs5zOtQrItlkdtX1+Ir3dzBZ2xa6v0dwCgirneyxp/eYzD/aQf0TO6vov3ChFIskSIPSpMdY0h9Q0572iMZna1UnuK0XZJuynQTqnvAlawAQpSYSbcoEX3JwnVfsDXpdw5tGdWCGPTC5p9CeujGJeMBKoTH+ra2ghWMoSNSUoP4cYx8NmGWpZp6lHy7lmKwB0XkBjIbvNvT7LrqcYIPqzgOmsB4lYYluiImZzHuNJOXrAO0E9LSA5SPL2ZJoOwoxsbfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KGdhl1RH843c57cu0Pqg0AabByqV/s2p1iT9HdCBV8=;
 b=ASk35SEDQuAbaj8FHvAmE7QRHuJool+/bMviPh702hpfCPSCzegZ3A1WNeoAiy2G8M4H7A9Gkoo1seuvSU0WH5ynT+GfxidyMD2xcY5WSG07ALOrumzK7gAHxI4RGj/fjgnWkRlNioX0wupR0IXdQsDMyoMporkwJtkZCWbrkDipIHf73Q47UKxTLK9Lyk2bLgOF04UehFJ3/jw2Tjl9bxe79QDBD/F+Wn4ofgDm6qfmRWIzkGlRU/R0Y6l/wjLDOGyW79XihULuiTKZBibuvpp5ETxyLk9JWLg6yjL8Lvhi9UmXr+otoqhJGZXSu8BSCxmcuKBZRlRHAYIHifosdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KGdhl1RH843c57cu0Pqg0AabByqV/s2p1iT9HdCBV8=;
 b=VrIvg7QhlrtCBtLWCzA71KQFdm2jBoo7Om9BzpM283cbHHW4ecc2I/8mavGY8rj24Pn8mIiJjYoZdDP57ZGjY9m7p/F8zX5dBM02mZPJhNqjpVK864tl8aI+h2WC2DLLXESh8nrevM+yZP9frbE5DIdEwUr/8v+c/hIOBcGECD95zA9eJYoEsPyY2MgyuyYiM2AwKfaOALh8/qPeN5g/sumfTFhhVR4WAhdSruzKKTtiIr615fIkpDd51N3nVUmfatW5Q6gtCshSmobR6r7yGJGnTnKjYlwG84YJmc+mT+MKm+nR4Bx/36CT/1eGOAe+2KHwmRosqFKXgVTERmjHmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6187.namprd12.prod.outlook.com (2603:10b6:208:3e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 17:51:16 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 17:51:16 +0000
Date: Mon, 27 Nov 2023 13:51:15 -0400
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
Message-ID: <20231127175115.GC1165737@nvidia.com>
References: <cover.1700766072.git.leon@kernel.org>
 <c3ae87aea7660c3d266905c19d10d8de0f9fb779.1700766072.git.leon@kernel.org>
 <c102bdef10b280f47f5fe4538eb168ac730d7644.camel@linux.ibm.com>
 <20231124142049.GF436702@nvidia.com>
 <14103e31e0c47c0594e7479126ce7fe34f2de467.camel@linux.ibm.com>
 <20231124145529.GG436702@nvidia.com>
 <b3250b9a9af2f29ee3d06830746fb6e8ac49271d.camel@linux.ibm.com>
 <20231124160627.GH436702@nvidia.com>
 <637dcc4d69c380bd939dfdd1b14a5c82c2ddfaa4.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <637dcc4d69c380bd939dfdd1b14a5c82c2ddfaa4.camel@linux.ibm.com>
X-ClientProxiedBy: MN2PR20CA0050.namprd20.prod.outlook.com
 (2603:10b6:208:235::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 97106635-8ff2-419c-380c-08dbef717453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iuSNV7YMOzI7Ozdx9W7BgGJltuEyxmisVfhbQdWeGlI8Mj5+VqtE2PhEDdfb2b+2q4cCCw/gFVABatQgvkyvJYQWjRHZ3Ew1VWP2J/+UQD2znXNnfv4VIWqACvzfTMQElIFkElvaNrrCm2wuyjOtJ/Zu5dJMrE/2eikr0ap81f6cp9OHdcnPNFpIpOof/tc6E3A0Ekg6enasogFgcGG4EAjw3PuGXm84HrgHxC1DI7jdpI/oj8lN6B6WuBjUK0VfCPw9Z/NblyQP/czvnalFIFQ87wGN5Eu/meAdr3ntYMO/EfKr0n7cvbq2Ci1fn03REYceoqdss2eMq/hw3pDLbxNxDVNBu43r4yDi9ptVA4jWR/Ag7Nm4SgnKzg4LC1bc68icH0hn5jFPsDrAri9pgWMZ8yzX4/0kcl3DEJwswZ0YP8INLYjZ2yW+hVMN/3Y6YSUyV8D8j9vMHdLjRrsC0wRZpPF13iDFhPFcBHqZw57nTISGd+5RxvLlj+F/1zeSJHJKHTBx6W6siaR5U+ZpmvB6Gq/AJlKatoFxPeCRnFS5fkk/hT7sv2B7HvwLyw3X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(39860400002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38100700002)(41300700001)(36756003)(33656002)(1076003)(4744005)(7416002)(5660300002)(26005)(86362001)(2616005)(2906002)(66476007)(6512007)(6506007)(8936002)(8676002)(4326008)(478600001)(6486002)(316002)(66946007)(66556008)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wCZkZ5+N/iossujM4XeaSj/9h7BmzomV1G2yt3jIaOqpXrEO0KRalLup/g05?=
 =?us-ascii?Q?Jt2UcOBq8CQwLvmRiAS5Qf8QK7VgtvX0iL9AwMeROh7x8wDXD5JEXMd7nfb3?=
 =?us-ascii?Q?Q5/qWaEL0sl60pMmDS7zlx+/x4PEqKS1jnyzAY7hQpmXhqrbu2hzfe9uFEZ4?=
 =?us-ascii?Q?UoU64AbHFsahPNHaX0XJlRAVE6qtkEivyqdq/NUPwM9J78u5tGYbaOlcU+nI?=
 =?us-ascii?Q?ifaj1nd24JqxIzlKqrnh6BWxh4efybDSh0O2HZYqdkFX3UsACjKG/r4RZQVV?=
 =?us-ascii?Q?t82wsfIYWSY+zg8f7YrOoRAPy8RCPeEDqIUIJ2hnYnhrxAGXRf0ADIYo1G+G?=
 =?us-ascii?Q?8hqmyLfH0v1SEYmJKwI4jSiFeAYKDDrDlM435heXK5tVU1pyZnk3mf8sdsQg?=
 =?us-ascii?Q?mFio7bGmKanhxO00If4tQBKILYZHPZ8UUMh7YDApLN++75THe4u2UhVFJEyb?=
 =?us-ascii?Q?j5jMGussxxTLsYIN385ZVgrzezxdkoOT4zGTqVH00/ex6HveUBpZ8wBZh5Wp?=
 =?us-ascii?Q?Ve67GQwh07gTSQenlcE8GmCwdVA1cToqe5gSePjb11upWjYqEfgmGriYy4k1?=
 =?us-ascii?Q?blvhhto8ZBFi3DKE95sTxTXKRGJTDRcIM7D26Gm8kFm2b5IJ4Ryg+cskMbiv?=
 =?us-ascii?Q?xTLWt+tBy0/DZOTlc+7XDXx7M+APl/nvLWMA6xwxDZlxX0gknlMeQmOn1PRt?=
 =?us-ascii?Q?30KK+sMc9LBgYpa6qM6LXgMPUN8sXoHuEILS9TirCxhRRAwmGD98wI9KMOj/?=
 =?us-ascii?Q?rnUO9s+gI8LMkoBTctUOnSgG+9efdbFkiKsLoczEQPrGS6gcSy+61rDVI32l?=
 =?us-ascii?Q?10AnS8xOztWVtREsjxfgfCEDQm4EdDN7etSEoF4Je/UIBpNLPh0uvWrDqz9D?=
 =?us-ascii?Q?uZaOrH7jtmLQ04+wy5RAcgqy4Bu8MfH3UGQEfnpqqMFVWkTNjp2paJ9e3zJX?=
 =?us-ascii?Q?lL+QOEPfPIskvP696QPjXYpaRreNWcSsCtDfFCJDwq35AHhB5tUMbo7Zi1Cs?=
 =?us-ascii?Q?6lGkgVN5PgAOfmKFbs35Z67NfnGwEbGaclnUqwQP6MSgB8MiIqgSkJyU2r+u?=
 =?us-ascii?Q?3RpvLbNgH5M5JMejyuFyxV7DrR6VCKCKOgEPtJmwnyWtq0jUMBNK9IvbCOQo?=
 =?us-ascii?Q?oEH866c7pX/fvUD9xzUyyI9DI+CQmn/PIiA2pkAETjTz+MmHEAH0kLzwUVyF?=
 =?us-ascii?Q?8HeRciV6OKYQyK0mRtHXRdPuswZOIJOuMvmtV8sG8yxxACMAf01tXa2d2vGn?=
 =?us-ascii?Q?U3jVyzT23OzA/PTxj/ukl9MjXTDFZclC7gPSbNhAHRL4BDDtQq2mZUZe+Czj?=
 =?us-ascii?Q?gWikRRW/6yRYTnT3hnawxd02W8iF74g87vC0aK2mHtvbtYTN1Acha0GJH+D2?=
 =?us-ascii?Q?3StNloP8CtUQ/xD9gLgsKFs2DLrTy7wYuEIlXDKzDnBw6OQy9gjcAjaVy9l6?=
 =?us-ascii?Q?EqPzVkbuTXzzT4L+utozyne6BrCjgWon2YA6HB6i5eStvriazeQkdVyW8NjU?=
 =?us-ascii?Q?/OdXB0lSUwQkNBlvTPA7kpHPPNtxStcnGCWHolzqXmbupPJtLH33HGBjLcL/?=
 =?us-ascii?Q?klXsExjttamYLX9XSBAdJLvYEWpmh6ZMUwAsX/Lb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97106635-8ff2-419c-380c-08dbef717453
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 17:51:16.6291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDCN1EYDOhS6z4NtatnJ+Vx2I9Zr2psfmBm4p6xkFwBJJt0Y8fohj5onooU6FEo9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6187

On Mon, Nov 27, 2023 at 06:43:11PM +0100, Niklas Schnelle wrote:

> Also it turns out the writeq() loop we had so far does not produce the
> needed 64 byte TLP on s390 either so this actually makes us newly pass
> this test.

Ooh, that is a significant problem - the userspace code won't be used
unless this test passes. So we need this on S390 to fix a bug as well
:\

Thanks,
Jason

