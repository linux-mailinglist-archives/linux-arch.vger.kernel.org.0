Return-Path: <linux-arch+bounces-914-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E2F80EBB4
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 13:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CBF21C20AC2
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 12:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8065EE69;
	Tue, 12 Dec 2023 12:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HTeGupEZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AECF7;
	Tue, 12 Dec 2023 04:25:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKq3zlj5S4iCpO418DUSLR5VmI8iFb21MYYdlux1UPrRN3mVE/TRusXiZWNIqrrOgK2mG5/i5zHStWICBc68OSBIy0q9nnqfczhWPawbEATnz7ldQvRWbh643K7ujRBXykiV5TquIDZeSiUgy67ZlsA0ReBfrZpA0xlRiY82vrtR41taqVjkNpG2BJ19KVyC9+OC1WI5ibNXXWibDCJXrMIZ2ezgk3CFEG8Iu6fcv2jzgd0C3yHA9B65NdE/eH42z/qRobiA078wVJtZIcWM3ZwNUffK3HrSMSTpUfOCAEhVbgORPtfdthE4G0vieIIOh5u+7AMVSfuZYCAmdlcD0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NrrWAlQ7ILJL5VW/t+qCUR/J5lO8tq4fOuYTDBK4v4=;
 b=cmv2kkKWJGeLWTMFShpQHNSSj9uWaw2CwKlzhj3BB6gj+cpJCVOqd4FOrmvxvM3zIdniGzHLfyu/S1bVTvnfc6q6E4FPc6YfOWIfdp3XpWDJk/AZj69986K0ogmAljCnFAdelEsEKS3sCk0wP60eiVB8cWIZAW1fGgSdLWHqxKkoxOVwi0atXw2ZqR2VA2oqUhdz+7fmmFXS885yKOspZGiXsPYOTE5AK0Ba6TKN+IZilgK2AbU6Zczi7ysiEV5G4ah9Rhowou5KMVXD04JpcbaKF3/pWeUBBU0XfDRvmDAIDizzyVHL/XmsXr4YVl2UUnTc/ae7EY7ahCMYDrIXoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NrrWAlQ7ILJL5VW/t+qCUR/J5lO8tq4fOuYTDBK4v4=;
 b=HTeGupEZqN+e3/D/wlg9RYpVk+9yy88BlwcOdJWm7DOPWkOuL2GlzDSQdyRcW+SI/uiQJdo1+CJew5lrnlmyLb0qlGBQ6fjZnucCCXrHY2Xp2F3spS6NY9e3X51r9XDkLtOmv3dGtLoDgfm+gaNDjmJPduHSGfWI0rGDlTHgc5Qrz/91C/43+7J/VXZ49cmRvPI+5rurU21covq85ENUCtwmpHDKFRhLkzDPeynHB5NJMQTghf2JF6lEyPvgsZzWfimqaBsFvJ0A0+HD+Tp2p/A+tFX7kU35t/ZltAcRr9L6AyhTainuI4bulU4v68Azqy8WVFlPmJngz1P1y7vEMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26; Tue, 12 Dec 2023 12:25:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7091.022; Tue, 12 Dec 2023
 12:25:36 +0000
Date: Tue, 12 Dec 2023 08:25:35 -0400
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
Message-ID: <20231212122535.GA3029808@nvidia.com>
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-9-almasrymina@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208005250.2910004-9-almasrymina@google.com>
X-ClientProxiedBy: BL1PR13CA0085.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: 31487c9e-7413-40e2-fc23-08dbfb0d71c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dr3LnQeG7pKa2o1xRmhtmeZvzytY3pzh+BCptlMfPF3UetOkAOdQiRRGXXEnBUlL2FCMm8A45MVcu/Zal4J/kgCSpUENIlmaT2DbH/FOZycE++0aehcKWmyGL9r1LIG901qINk2xywrZ688YnX1dE8sOx0hUz8TpetZ+Rtnvk5Np/3tuK5FPwEIZG3/SVgrKcYAba4eA9JPMfTcPwI3CI3iTiLornqivhKxktL6u0si32e/F0HUPAbdw4iE0KCwfa5xf3/fWgOhldrkdiLqahwdnHwsctXcJwH8iLSFibvqXani6HhJTudhdRwyp2M9jWTNnykqGS5lkdpVq+u7FaGWu/Q+Pw2WLEb1qTBe3ZrGR0wQe/SuF21tSmMS/gb0lkDNCuG+Ya3JVPX+hHdojftmOY9pgflGayc+A9NCyYCbHJm45xQY+bcpqNZsiRlU0w9MuSjrfyAO45IY3RrXCbwb4uM3L1r6L6MEmhqko8UTb++c/Q+n7NM8QTmh2WmoKmlhi7nWUq3ikUAVJAjxk9wAC2yPfFAGzC/mZmYjaKqo6r0l8EJfzCO4UzBf96IZM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(6506007)(6512007)(2616005)(1076003)(5660300002)(4326008)(8936002)(7406005)(8676002)(41300700001)(7416002)(4744005)(2906002)(6486002)(478600001)(38100700002)(316002)(6916009)(66476007)(54906003)(66556008)(66946007)(33656002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FNzvK+ZPaUM4zj+4pHalQiAz7Hb9dYLj2YtCoSZw4B82oIueziOpU3RHpqZY?=
 =?us-ascii?Q?0QW0Ycjp1c5NL+dLkHzwC9F4m8SCRf3rU8Antxatx7bn4e242n2vioDRex0T?=
 =?us-ascii?Q?e8IexuY08eR5iExMWAnM8z3ZtK+eZVw3EzKozvx7VK6yvJRvDlR/sVLkot4l?=
 =?us-ascii?Q?nibKfJHzwcUmLizjCn6XS2rkb/qo33Q0jcuytw/mz39qgx9aAaZdIWQQz4lY?=
 =?us-ascii?Q?uzyxkyu+4iaM+Ixm2FQPVHs7o99dlDWkJaU49HfaXNngX7mIJ/3LYBraTeqF?=
 =?us-ascii?Q?9+6wPw62EKu7VRo7w//svTA3fHCmo7cX6UgNSC+Ljmioam4+BCvEuODG82Ai?=
 =?us-ascii?Q?FLuU2x34+M1yq1sOFTC96O3MDgtfAcq0jnBxM428I1J+PioHQLKqjVWhk6Xw?=
 =?us-ascii?Q?WY79EY9KOV4V2VUv+fepzxqctqM5vSNKSG7Uwv1Wf3BevrgEl3mRfaA4ZrzK?=
 =?us-ascii?Q?dBcB+FaB9hZDHbw5gs3+eKRqbA1EMpgC5plRJh5M8qipNialIxP+0tZdnPV/?=
 =?us-ascii?Q?cfcLR84KlBs7snZb1pJa0p3aj9QIZM8cdyRtjwYGfsF3Q9PK5tgZSkFtWLmG?=
 =?us-ascii?Q?Dlg8I9b6gbPWDd8GoeH6Wt8pVI0LuKxzFQ/5NCTddajmFqh3Ltzfaus5QQ9X?=
 =?us-ascii?Q?CiRb6ymtM1hTlo/h3AB+XAk5gezU2rubZ7IVV7PPxQ6tWRYn6NEGIIhwJ6V1?=
 =?us-ascii?Q?AW8yvNQkVUieCYHx1qUhH2jviNXlBjnpCeU/e7W+cFABU5Bk5BH0uDgODVTb?=
 =?us-ascii?Q?e0SoBcysDyirqGWh2Ktkw2eeIHbcO2JFy4rFthxhwEUnBvNgDCozHe4hE/54?=
 =?us-ascii?Q?UNZBBOGhiIcQDSjmfXBSxNevKOeNvhRSslTeK9OAdhsdXvv1uTLnXDFkZsVw?=
 =?us-ascii?Q?5QrAkkaBwIn6W//kWY08HRuS+GSypDyxDwjeq3ZKzTUTXa6AD4BUCXIWeSbZ?=
 =?us-ascii?Q?8rMg1UI2s4gn6o20hras3fDZtY1MA699v2tjvOtvrWA2wAI3+e3VGqVt5a7M?=
 =?us-ascii?Q?l223Wgm5tg/JcJGd01qP12LHBGPyby0PAEXak+5kKYypgbAOg0EvJC/u7Igu?=
 =?us-ascii?Q?V+vSFEg1lOSw4F5xcrG72ARg3o0gtIG/cWhSbcDqu+Up1SoVapr2DPXEqwgr?=
 =?us-ascii?Q?LBVpgV4kS0TgNYfXvah0QlaokksmxfA+GrNkgQNLLSkeHS174qQFjyl8KACb?=
 =?us-ascii?Q?M2hK4awM+r5Jj8mVDb7ELws+/GI6KWDWBLnqXSFZXrEHXIFAdnMY2+qYGhlf?=
 =?us-ascii?Q?2UAcapyFU0MTjyrcEjUsD/Ce43ePmeR/gB5vVzLZZyntM2FNvd6konGf+ydl?=
 =?us-ascii?Q?A/JjWCtdZXfbYCJM0tSYIMRA+fjbEqgjtQQg0wssenlQXKy/FVXbs3AbXm5c?=
 =?us-ascii?Q?ut0iyXixtF22UUj9q79DUs7aMSWgddRHOOkK4TOWCfZpTXy2EP4ULJ+YsXrV?=
 =?us-ascii?Q?OQ9PY0Z66D3TUXiGx4tq59++rdxmJWYLf/BBiuRYiSzGjyt8iOGkg9ya4zY1?=
 =?us-ascii?Q?2b7717rZDdeCOncf4MkrSTBqNQBKsQeIZkP/j6W3/wxD74zjF6zLsHyph9+X?=
 =?us-ascii?Q?A9p4O3FI0RbMbdtRhcxRw999f0Okszs2zeZ8TL8B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31487c9e-7413-40e2-fc23-08dbfb0d71c3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 12:25:36.7674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Q5gs0AcAc1Bx/5MQ0/EIYWiX/LAV6vqMpVkY4v0SjKi8VYIOm6Wy2akKsUVRlTX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256

On Thu, Dec 07, 2023 at 04:52:39PM -0800, Mina Almasry wrote:

> +static inline struct page_pool_iov *page_to_page_pool_iov(struct page *page)
> +{
> +	if (page_is_page_pool_iov(page))
> +		return (struct page_pool_iov *)((unsigned long)page & ~PP_IOV);
> +
> +	DEBUG_NET_WARN_ON_ONCE(true);
> +	return NULL;
> +}

We already asked not to do this, please do not allocate weird things
can call them 'struct page' when they are not. It undermines the
maintainability of the mm to have things mis-typed like
this. Introduce a new type for your thing so the compiler can check it
properly.

Jason

