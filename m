Return-Path: <linux-arch+bounces-921-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 046EA80EFA8
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 16:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B49D1F21583
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 15:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F8C745FC;
	Tue, 12 Dec 2023 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UEV5KMyZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2449AEA;
	Tue, 12 Dec 2023 07:08:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WI8TKw2ciedZLjG78hJpvoywrx7yF/KQZbvFRSS9vDMa0Z4BGvyRUoynYh3Odo129+/WwX2GT0nMks7/RgimHMq/ZAeH2ai6LBgdg2jbfl5EsCgpYPHYnI7pLqLZGSIj9MUPc+BeRCAbaC7V8jXQBx+EVDBnsdqLMTiaPDTZ3LwU1JO4GD2HoWHWIRO6NgFH6EqN3QSuvWwXu4p+cj011p7M7S6BY28Ntps2Zpi+ZvbKpizB86py9rWIMZMI1WXcOd97+pl/zFFBm0n6q/6Eh7+YQ5X6MFAt1wUow8lUF11vM+faTQH3+l5BCiVioq+XM9L57r24u1jIGf/IBrPv0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YByBA4oxfQwXTXAXysbLeGABlNGSnZnlorup2IUTvZk=;
 b=NQsaC3VP3r3cv7iHUrwaUt8BsSgKiZxx+J5r3AHiJLYE6kwXBdBa636T2Rhj5LKc33UNnKs37otHzN9PdsS/jK50dr2RoSaLKDO4Qp9wZ20AXSpZ+YkE28XNCnjxkGCEKjDu3OKCbDAq9ek5Gfci4e0A9iZKdRWxD43Qb1apq2gc+STR7cGwtGIdKEGtEvQv6+kA+zal3K/hoiIzkpZ65Nurtun6kwuxfT3+WuRVvaGmwaubttDh1mDdydAWAyNb98i6D89jl7kzJdA18dxRqfkNGs7OrtNHUqSP7mAFob+T5E0JdxZy8UUTgIOhA5CBEuz+E/CxQXGwFcNgbPontQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YByBA4oxfQwXTXAXysbLeGABlNGSnZnlorup2IUTvZk=;
 b=UEV5KMyZUZDzHJakZFGZ1NcaXmSZ0R1aav3/4wLMbkB68DbXuNsX4YuWf37OPGs9r7XqsrHnXevaOyc/uXb9RGRey5LAPNF1zsmjz6vsyrNr5FAnutNdCcHYc5NAXD9krX/9lNVilc/T+iVzb4be1M1kYP845zMiUuVkQzNh+Kkrk1czEiIkjdVHeTfNf9ajPC4WpSBVLPYQuiqyDQrhuIQH6JC46jiUqJP/IjuYPyx+x/yI7+1BIy0QTU81BFoLSXYf3enO1vcUuuv/xXuz6M6e83HReeijNuP1ou4B6zMAF6JjuTLLpWoOhzQ5+xqBtWPlshjjGT1fcgrpYF1CHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5722.namprd12.prod.outlook.com (2603:10b6:8:5d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 15:08:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7091.022; Tue, 12 Dec 2023
 15:08:35 +0000
Date: Tue, 12 Dec 2023 11:08:34 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Shakeel Butt <shakeelb@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [net-next v1 08/16] memory-provider: dmabuf devmem memory
 provider
Message-ID: <20231212150834.GI3014157@nvidia.com>
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-9-almasrymina@google.com>
 <20231212122535.GA3029808@nvidia.com>
 <CAHS8izMVMx0fpT=dWsnD7piqs1g7Fam8Xf5dK3iOFNxeOQD9vQ@mail.gmail.com>
 <20231212143942.GF3014157@nvidia.com>
 <CAHS8izNHtemjjkMf43grCHP1RZ=2UFiMtgea0M6+PaAgC=DDMQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izNHtemjjkMf43grCHP1RZ=2UFiMtgea0M6+PaAgC=DDMQ@mail.gmail.com>
X-ClientProxiedBy: MN2PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:208:c0::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e77963-7a4e-47b7-5674-08dbfb24365a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GUfRm4Cu/wM1W78LaY01CcMxPpZ86o8WxOrzGItsyyOzMMz1i49I5c0fGcBeBjstddiBLrNnRwOlXS8M4VvWEinYizo0Fbh7+YkEBSHRsOmsgd7bhL4/19vdbVMbGVoqXvc7S3vEoiX5aTzCducWmrlIL4C/inqtVCmUQI2YbzImqjB5dD5qiYpQoKvfCOjz1rRgxxLgDtIHRcidZTcYI/B00L0913okY8ZKbOWGc/T+ZtmIAYVg2Wkac8yDr+nsP1sz4TUboGnQIPKTeP4G/vdZ/Q8zNxSoi86tZsvX726fL5ij0VL8KD1jY8JqA4h4ioil7+Ej49SNaPMgqIG9mefoZ6dCyc1xKnXKvb1Tzisc+jNmGNshxMIbr3RodaQbQNqpQeofSHIQZGvdiuVhBbQRsNXqUeUN2ioI9OzH0IQ0dV5YBU8rMamMl8IMEV2NUOxIxHIgGszTIaO6/mqB2rNzvS10/g2hUCdrObR8vxToc5BTGCssXPIBbeIyFdH0wNvRkZRhIINSsjRri1Jg5172xiVleWA/ZjBWXNNLvR/Jg3QZmc5+Wkx402KBzgRbVJfpoNxfTOT5cUmIcjYXWo7aJ4llciuz1IQwbPg1jhk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(54906003)(66556008)(66946007)(66476007)(41300700001)(6506007)(1076003)(6512007)(2616005)(26005)(36756003)(86362001)(38100700002)(33656002)(966005)(478600001)(6486002)(8936002)(8676002)(4326008)(2906002)(7416002)(7406005)(5660300002)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mrEyRSkTR3gUgnuY1J2tdZGe/P6rs8W4YBEfEQXcPcFgl07D/PbU8F41j7N/?=
 =?us-ascii?Q?FGywTcY5ZQUsUmzEFgMSJtM8gFs1aiOcVWhSg+GPrGsaSnaLBqN2KeV5DzDL?=
 =?us-ascii?Q?41IyPeJ9TgVJLscS90sRseRwgskTN713sA9QSLX4445rje2qUzCYwPIuG+lv?=
 =?us-ascii?Q?8UZL5CNYr0w64Zj1aswGb8v9fmHI7L3GlUHynBaZQvZymNIWWc09bW4XrbMX?=
 =?us-ascii?Q?xwzXU8yzekOMtuaQk/gF1kowRA5gx7zRJCZs6+gS3a7smAwHZOZfDaK+Tj5Q?=
 =?us-ascii?Q?Mxm0TMV/2U0QFLzgPYs4TjNe8zeSAzulLpGhN6ZoYDqrmR/C18wipHE59MxW?=
 =?us-ascii?Q?k8iFIsN6sCwWPbWQytdPRk8yP0dbuH7LsBA/R5eNM7kR0g29ZoXGAgjZsrIF?=
 =?us-ascii?Q?VSNCBJReQtRfHhfyv5UgVmBVE47zC7x/RuJizrxICxvt1t7J/N8U203NFhpA?=
 =?us-ascii?Q?Y1Q4IT2fGGMD1oXOXExekl3D9QyseQ4Ao1BbHG8qy0H8VDS+WAo/hz2llkfa?=
 =?us-ascii?Q?VN7QKS6GiU7FXMg6iktyewheQLX0261Vac2TjLTfGnMRBIccWyRI3gIUJbKm?=
 =?us-ascii?Q?Xe2OXoFuV7ny7rMgJbg77gfCxroqRODDEUj/ZATk5qW6MsyxMCIh7VvhaONa?=
 =?us-ascii?Q?b3ivJAG33hUA5LLpLksPjAQRRK4WwWeMqAaPUz5hg6HfhSN+PpkfWCtIY03g?=
 =?us-ascii?Q?jE4ZrY88iTzBMCsiJRp+w/jh1gUG7c0BFlnJeF6TALqsvZgF02A6N+aicIIx?=
 =?us-ascii?Q?dxfnTRNXxBJgOoGBvLZdrhpPVPVsnFDDqtCb751rQhJ5OfmkF15PZATAjJJp?=
 =?us-ascii?Q?nYnEDPWKGqPfTV2Wba4DODihvuUgbOHa5yHuGSJWCry+QY1UUeAN6enWk2IB?=
 =?us-ascii?Q?CLCmHZomsquft7dIDVuQYiNlOgR4++Bv59LphBhMG+xb8DVOQGSMvPj1vhET?=
 =?us-ascii?Q?VS0ZdNgN45O9vLYkkveSqCrbRFDTA1p4emQFHdchHfJ4iEYvnUSkplNBVOew?=
 =?us-ascii?Q?bHtAwKCTWABaGz1t6fVu7RA5QQqHWoJcR8S9/MCp9WFruHRXi85OUHErgKnh?=
 =?us-ascii?Q?Mr/JU4qYTEuEw8W4J9NQUW7wxNEbmHQ+/b0kO2ypB5qr8JfqlYvCLu3P0V7M?=
 =?us-ascii?Q?7AIUrHHQjetxDmzGtp+LONn4KnC4EmUHRkOniZJpGWPgAFyrWmsn3Ajrx9Ey?=
 =?us-ascii?Q?lkbzq5l1Fe1iDWyXsxIMKAZZLnXp10HzTalqJ7TcGHFIV1gtWB9JjLTGYU4f?=
 =?us-ascii?Q?SQN+DJOyrqcKRv1GhD0EBo21R08lGVdLVLtQ4tFpbDMA4erUotcGVL/t76cs?=
 =?us-ascii?Q?jk1scj27LnjchzJFChyyynn+2QhlX8beSWCe2J6CuQFRRca9NxPLuYCaxF2o?=
 =?us-ascii?Q?pZ1mf/OTeAhkLljGT1YDtpQEBH+F0RbvOzgdbVp7as6fTx2k8frB9IDkfCxS?=
 =?us-ascii?Q?xoQNMEp6BL5o+Ul2WAYtQoaCTrysScjvCoGTBDB599FhLGO4YAfG5SxxVg+R?=
 =?us-ascii?Q?L1DPU5oEMm7Te3tguCLYmdENqRk8w/wuGEF2iZajLXxCvzw06nlPvNK3HBxf?=
 =?us-ascii?Q?dzyMvzDiKKDe3XdHmO59yQYeaZX77P8phcd8FfT9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e77963-7a4e-47b7-5674-08dbfb24365a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 15:08:35.3779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWLKQFKjSNhxNlo+bcKSshFN7zqiaPkLLotEj/GU512i4fMIL6yPfhGNEQwhFm54
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5722

On Tue, Dec 12, 2023 at 06:58:17AM -0800, Mina Almasry wrote:

> Jason, we set the LSB on page_pool_iov pointers before casting it to
> struct page pointers. The resulting pointers are not useable as page
> pointers at all.

I understand that, the second ask is about maintainability of the mm
by using correct types.

> > Perhaps you can simply avoid this by arranging for this driver to also
> > exclusively use some special type to indicate the dual nature of the
> > pointer and leave the other drivers as using the struct page version.
> 
> This is certainly possible, but it requires us to rename all the page
> pointers in the page_pool to the new type, and requires the driver
> adding devmem TCP support to rename all the page* pointer instances to
> the new type. It's possible but it introduces lots of code churn. Is
> the LSB + cast not a reasonable compromise here? I feel like the trick
> of setting the least significant bit on a pointer to indicate it's
> something else has a fair amount of precedent in the kernel.

Linus himself has complained about exactly this before, and written a cleanup:

https://lore.kernel.org/linux-mm/20221108194139.57604-1-torvalds@linux-foundation.org/

If you mangle a pointer *so it is no longer a pointer* then give it a
proper opaque type so the compiler can check everything statically and
require that the necessary converters are called in all cases.

You call it churn, I call it future maintainability. :(

No objection to using the LSB, just properly type a LSB mangled
pointer so everyone knows what is going on and don't call it MM's
struct page *.

I would say this is important here because it is a large driver facing
API surface.

Jason

