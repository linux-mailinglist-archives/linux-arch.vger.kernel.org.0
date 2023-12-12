Return-Path: <linux-arch+bounces-918-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7691C80EEFA
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 15:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CDB4281A8F
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 14:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E496745C8;
	Tue, 12 Dec 2023 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lXhvQM4U"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEDDD2;
	Tue, 12 Dec 2023 06:39:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGWKSkukbtknhxGOtHugGyz8SJYWAZxF1MbG3h6d4X/eXQ8Qr4pDf5DzWzWRLQMLSCyrvfwApGC8V2FJJTqwbeJ2GfYeI79aOUoTuY1c65dl6VnI5SlDvNr4vsoeQ+h+0/iOpsEb0ImIv/c3rRkBlBeR6Ixp8eSkb/okoWRWGk1EPtXnUHrx507iropkTJDJ6S4Wz4kU+2uzPjgo8/i8CTp/UTjx4A/2m0pQFXWNIk/wkfKSjvgvZdatOV1ocqvYc6Unm5gwTtQIFhcHP/jWw+jFIU8vbDaaQmskL2GV26TpUYDlll4QXdYomVxd4dQudGGtAVwaykDZfQd1xf/4Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60HBBWINjhv3np+zHYZFIeDsai/Y2e+4IoMDbnDWuoc=;
 b=YIC4ufIZ7S5SL2Ee/NjpnfzL6TF79NoD4Ts1ZXQkBrHgyuqmniOPXrGuSDoJLfPchHomqpvwZRBzexa14SQWA3c95KuHIr/ly7MVVGzkw4hgboOhRNsLUYa4wmpygFq5JlAil2eMjVV+GSDplWV78BectsSleUCYRMAL+v/A8Ajz//Z86gP+0pB61shnXTeZPwyDakI/lLi5L625/Uk8AI1bLBFmG0CcQGTjJ5CRK1x8EcV2mGqIBSjK3j29ELnSBQpE1zJtIhB8zclX5yrruWThYMnhxs4UVDbWBUJaRTyIr9eNhySnJg+gJbzI33yuR8WqyjtPk4CZ1KX/DjD/ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60HBBWINjhv3np+zHYZFIeDsai/Y2e+4IoMDbnDWuoc=;
 b=lXhvQM4UWNBxe01wW9kR8JC3GPJ3NMYcdb8QbhNsGgfj/KDrLEdEq2j9JCwdofLIpoiGJYJdkhQlEkS0Czn1+QbtQlM5Y9A4d6BV+mzJG3ulnf1SqSgulKXzTEbQsWc3IFZPNCJdjWktRujU/s8/Q93p4EPOjyaYGTb5D8aAffR7whsQ9loBODfvT5BCiZn0PGbY2zDuQ8jsSGTRk2w8rMPL3LlRIgvPPTArQ4MdO5yqEQt/SRXKu9mvBM46wHJUwAtD7NDPjKBtByOwKbMMEIPn9smMS6m+biE6Opl8G8J2GDWejh30Q6NPfL5dhkcAYHuw+m7OpFrUTbpom3GEgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7889.namprd12.prod.outlook.com (2603:10b6:510:27f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 14:39:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7091.022; Tue, 12 Dec 2023
 14:39:44 +0000
Date: Tue, 12 Dec 2023 10:39:42 -0400
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
Message-ID: <20231212143942.GF3014157@nvidia.com>
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-9-almasrymina@google.com>
 <20231212122535.GA3029808@nvidia.com>
 <CAHS8izMVMx0fpT=dWsnD7piqs1g7Fam8Xf5dK3iOFNxeOQD9vQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMVMx0fpT=dWsnD7piqs1g7Fam8Xf5dK3iOFNxeOQD9vQ@mail.gmail.com>
X-ClientProxiedBy: MN2PR20CA0021.namprd20.prod.outlook.com
 (2603:10b6:208:e8::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: 5680d03c-e323-4f5b-7afb-08dbfb202e7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UuIYqwdDMapiqaAI841n5k2jvrudkwDIgnYHWPZxTfVMmUjFJj9cyAVWy4NP2CkYl7Onm2TocgQqRvyltAsswnRV/k1FvWckTdLe+TFu7vnRBu/btHqeLwXO95Ei8/JcKHEAoLZw1U1aBnFUn3BlEIl9IB/PBdvoZRFI3loZipW8bCzYnZzt5kR4umA8d+x8I4jlulPLxCFf5i8iV8P0US0/YrZUJAw6ow7EEvIU1h8bRx5dikzUSPtnQKTsFj83dJNBjd7PpnWT2B3i7vdfPydL96BWkQ/2p5IncrNmXoukNdoAzzN9u6deJ+iIp70X4iP1YAsBjPENLpqll+5H1+i9Xs51f4+x+BEM5NXNP781oY+7Q4qg4uPeA55nEwDO8074v1zjT3WdDCUneXgrUkW31QkFKvQsCXiVL3TgOmvcITXf1nqcXViLcEdcP9CjlgXlpBNwL/JSKX2y59c1UD9iU/Zfnxs25CzBbc5MrctdL6PwugaedwaoNmK55cuOLHS44lXV4atsOzmVa/GFSzhN/Ox9mWdTE+Fh9DOyEhhBnRA0oGUyngcAZJpJGfAV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(2906002)(8676002)(8936002)(316002)(5660300002)(7416002)(7406005)(4326008)(6512007)(6506007)(6486002)(2616005)(478600001)(54906003)(86362001)(33656002)(36756003)(66946007)(66556008)(66476007)(6916009)(38100700002)(53546011)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTA2TnpCMjVPaHVZTWJnaWo5RmJ2UlZleEhyOUNXYWtRN2U0dzFDeHpldXlj?=
 =?utf-8?B?b1dUOVJWU1F2dm9obmUwRVJrWUZCUmtSeGJmNjk5RGhISTYyNjdNTXovYkJz?=
 =?utf-8?B?TXcyNFc0YXFUd3pNK0xzZ1h1VzJMakZuSUUxcEJsdjhvV1YvOHJlU1hCRjhL?=
 =?utf-8?B?cmV3UG1DWVIwRHdBL3luUG9BMk5LWitSZGZIWGdic2VCeEpKV0NBeE50bHRs?=
 =?utf-8?B?bFRWdDZuZHkwNnJrR3JHemRubk9PZFdyVGVtM3A0YVM3TkZtaXRjQUNBVjlK?=
 =?utf-8?B?SFdQeGZpRCtFdmpHT2NXTlhBTHlwaW54UkNBd0lHdXdwTFh2SUYwT0poUEJX?=
 =?utf-8?B?NnNVSkhoSVJSMll3OTREZGRvYXR3dVFXSHRnMXFVM3gyL0xTQ1lzZllNRlBn?=
 =?utf-8?B?cjQwUEJLc3lETmJMN1J0bkt3WG50N3RiZ1R3MlhyZk9CYXJ6R3AwcnFtd2oz?=
 =?utf-8?B?ckl4aUVkNEZHV0hEZHVmcXBkZldtekFKQjZxWDZuczdsamIweDlDQ2xwaFFK?=
 =?utf-8?B?WlErb3lYeTM2TXVweVAzRkRQcnNEdzhjUXpRY3JCeVdJN2NnWHpBekJVL1FR?=
 =?utf-8?B?WncrOWo3TUxrZDlYMU5ObVRMa29nblViVFFMN0tGQmk1bHVpWThDM3VnTG5h?=
 =?utf-8?B?R3pWSTJpdndKTXVXendHeXlkVXpPdk5BdGJIUG96cUt3ZFV5Ri9oK09JTkVQ?=
 =?utf-8?B?YVU0SEhGUUdUcGRqN1plNjJWUzZTTmgyK1dvYklYS3l1QVFvY0pPSWt1QXVX?=
 =?utf-8?B?TURhUkFSN1ZRcExUOXUvcmF3cWtKbDRmdG1rTVp3ckp3S3p2NlNrZjVQNkVu?=
 =?utf-8?B?YXRHaFg1czZSSlQrUW1DcU1ZVzhwRFlyWWxjcXE1S05NTXV5UjJjS3pvZFJC?=
 =?utf-8?B?eUJra3lOa3ZkdVVKaUlCbzF4WlBxU3E5WTZWZDlTdzRsa20wc1hTSkNTTDRq?=
 =?utf-8?B?OFV6d2VFczQxdzg5VkJmK3JXbkc1YTdQSWt5eUdjVVQ0WU5lNmc0Unpncmlk?=
 =?utf-8?B?SVdXTlJuMm5wUmRwZzFwSWNiTjcrZGJnNDVOdWJZYTkwd3VFaExRWk1PV1F1?=
 =?utf-8?B?R2tEenFMc2poQWJDdnhtZDhOLzk1TVBDNVZGK0ZSd25pTk1oM0ZkSnVOVHo2?=
 =?utf-8?B?cnFVSkJVb29qeGhBdzhvbnlZNVhrYWc3RkVKZDVjSWREQ0ZudGRQaXBKZllk?=
 =?utf-8?B?NzhWYnA0cTc2U1UzRlNoQkdXNm9EajZ4ek0rTjdVZkMvYTdHalAySHFqcVVX?=
 =?utf-8?B?VWU5SGpoLzlZc25qa3FzZkZrc3lnSHF6RFRDbzVFUTBPU1FHRGkxTTBqTGVN?=
 =?utf-8?B?YXdjQkZnQ3pzVUlJWG9HWHZMTVI0N0hxSUVDbEI2WXcxZFJtNHpadjZ5RlA4?=
 =?utf-8?B?VC9NQXl2STFXaHkwNmdFRzVaMDMyZzBBQTN5NUZodFFuVTRPZWI4QUhzdENK?=
 =?utf-8?B?OWQ0WUc0K01mVE5mRXNBUWlhd3NYVUE5bUMzb1krUEFOeHFBdDVoV1JvN0RF?=
 =?utf-8?B?aW42QVBCUUk1bGtTTUU4b056SXJseVNSVU5hMlZ4MHRSYmc3THplaFNhRXlB?=
 =?utf-8?B?QXlTOTRNU2NKL1liMVBSYU9iT1daYXliOU4xY0VIYytzU2xjQk9HYlArODRZ?=
 =?utf-8?B?SWczOTd6NHNVVW56YmtHRTZ5QngrMVZBUXh6R1hxbTJmNm5IK0NnRWJaSVk4?=
 =?utf-8?B?UHFnaW1WWHV3S2EyK0ZKWjZMd1NKbUI0ck5WRDEvbUdId256MnNjUnBFVGFu?=
 =?utf-8?B?OHArYXgwUGxRcFQ5NlZnZFBYNUlBQzV5Sml0NUI1V1ZrMG0yM2lQRU9Sdkhi?=
 =?utf-8?B?TzFzeEZ3UU5HSVlpOG9xMXQ3UzRxRnhST0tDcnZOS2NNaVBJUVoxTHpNQnJQ?=
 =?utf-8?B?bUtuc2NERFRLb3M4L1lvWVc4M25WNS9mVkoya05TOUc5bUNzWjBlNlF2VnRT?=
 =?utf-8?B?alc3bklYN0tsWXlRcEdsdlRJR05teWxnMmNBeVlQbGtZL1RhQzlUbW1lbGl2?=
 =?utf-8?B?MlZicHRKY3krcHZCaUNSLy9VbkJuL284ZE1iYkJIQTQxNzFPUDdxbXlLY2px?=
 =?utf-8?B?REZweFRzc2lnMGEydDFHTWp0cElJbEsxUGNoVklwVEVvTWpuVFArbUppWVhx?=
 =?utf-8?Q?VaUq6bnBhoGbuM0LBLJFvV3iZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5680d03c-e323-4f5b-7afb-08dbfb202e7c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 14:39:44.2602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+AmbUoeP0zhwQ8FxJf57G0tD0LUPLeDwMN9DgfIKdBe5xIHaAAYBvGyeVIBWV9B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7889

On Tue, Dec 12, 2023 at 06:26:51AM -0800, Mina Almasry wrote:
> On Tue, Dec 12, 2023 at 4:25 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Thu, Dec 07, 2023 at 04:52:39PM -0800, Mina Almasry wrote:
> >
> > > +static inline struct page_pool_iov *page_to_page_pool_iov(struct page *page)
> > > +{
> > > +     if (page_is_page_pool_iov(page))
> > > +             return (struct page_pool_iov *)((unsigned long)page & ~PP_IOV);
> > > +
> > > +     DEBUG_NET_WARN_ON_ONCE(true);
> > > +     return NULL;
> > > +}
> >
> > We already asked not to do this, please do not allocate weird things
> > can call them 'struct page' when they are not. It undermines the
> > maintainability of the mm to have things mis-typed like
> > this. Introduce a new type for your thing so the compiler can check it
> > properly.
> >
> 
> There is a new type introduced, it's the page_pool_iov. We set the LSB
> on page_pool_iov* and cast it to page* only to avoid the churn of
> renaming page* to page_pool_iov* in the page_pool and all the net
> drivers using it. Is that not a reasonable compromise in your opinion?
> Since the LSB is set on the resulting page pointers, they are not
> actually usuable as pages, and are never passed to mm APIs per your
> requirement.

There were two asks, the one you did was to never pass this non-struct
page memory to the mm, which is great.

The other was to not mistype things, and don't type something as
struct page when it is, in fact, not.

I fear what you've done is make it so only one driver calls these
special functions and left the other drivers passing the struct page
directly to the mm and sort of obfuscating why it is OK based on this
netdev knowledge of not enabling/using the static branch in the other
cases.

Perhaps you can simply avoid this by arranging for this driver to also
exclusively use some special type to indicate the dual nature of the
pointer and leave the other drivers as using the struct page version.

Jason

