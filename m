Return-Path: <linux-arch+bounces-966-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAC9810BC1
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 08:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5805D1C20510
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 07:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E951A584;
	Wed, 13 Dec 2023 07:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="IfxPMc5e"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2127.outbound.protection.outlook.com [40.107.243.127])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44B0D0;
	Tue, 12 Dec 2023 23:49:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZYczsKMA1jYFryT7K3AJHeoVjCpI//g8z+Ae71F3uLxUhXxjGvVnUPCieV05nAZ1zugmiRX3WpKphim2+6EYRasDffyHw1bXCo8U7k64SpqK/BTkQeXfrSIy6Bd6VDrT1rmqdcefJP87Rn1gRAw3fBX7bJvegWPK2daaZAwuyoMhpokWT2AbeBv4rS6qBwJzQFjIbJJgl8J/uGemJ1jxLM5x2SXn5POcJnZtVExCMgUbAqjN/0uhrGp/GqW91igODF8EJSwfRUDo4IeoQSQyg4TF0wy+VF29N6nJtOZ2I8aly9ywdpqXbmHlrKyyyX+jb/wuQJ7Ms1YzVzzMdDm5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4EN4hxm4yC3+hbu01w6YOLOueOVafh1vFMtbiyyAlM=;
 b=XwHbI8/5VNECi9s3utDIDNvISeexz71FHyjPtxflvhTN8ooGAHZqTuifSjTjQnetx4EvfJ1ZIzej/UWpXvAL3SG+bBjlvqriRYQkA3sxTKnMHNI323bHJWzaNzlAn6gURRU9bbRlbEfoX7IDbMOCcrjSeB5n0d3BtipHTbx/ctmVwHUF6offz7oPA932czMzrjoGINtmc1MDjPpxyxqy+zSBO5BkshgyTyGKNMzdJLh8QDNQM+g+bjHFghTNMvZOKZkTc7nQLrUsUQEhobRDPBqCH+A3SZ6Wl1lAXWSSg/DUaNZojGVqXjdhildCGbtdiWOzhjQCM3wmfTiJZGSveA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4EN4hxm4yC3+hbu01w6YOLOueOVafh1vFMtbiyyAlM=;
 b=IfxPMc5emAfGqmYt9nWbJROAM7j4IecpWQ868AJsW6xu/BNRUOzkyAjZGo2UP53jTDwshQLZEkEPYiRw6JTAz9ll50JtB7aoWSfYB168qIdBmUL0P+UiJPgOHEVtb7fex+zFqGTcYnRqDAZF6zNYcDBr9/oPKeJHkqR4ji5XUfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB3705.namprd13.prod.outlook.com (2603:10b6:5:24c::16)
 by MN2PR13MB3911.namprd13.prod.outlook.com (2603:10b6:208:268::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 07:49:18 +0000
Received: from DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::91e8:b139:26e3:f374]) by DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::91e8:b139:26e3:f374%3]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 07:49:18 +0000
From: Yinjun Zhang <yinjun.zhang@corigine.com>
To: almasrymina@google.com
Cc: arnd@arndb.de,
	bpf@vger.kernel.org,
	christian.koenig@amd.com,
	corbet@lwn.net,
	davem@davemloft.net,
	dri-devel@lists.freedesktop.org,
	dsahern@kernel.org,
	edumazet@google.com,
	hawk@kernel.org,
	hramamurthy@google.com,
	ilias.apalodimas@linaro.org,
	jeroendb@google.com,
	kaiyuanz@google.com,
	kuba@kernel.org,
	linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org,
	linyunsheng@huawei.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	pkaligineedi@google.com,
	shailend@google.com,
	shakeelb@google.com,
	shuah@kernel.org,
	sumit.semwal@linaro.org,
	willemb@google.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [net-next v1 08/16] memory-provider: dmabuf devmem memory provider
Date: Wed, 13 Dec 2023 15:49:12 +0800
Message-Id: <20231213074912.1275130-1-yinjun.zhang@corigine.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231208005250.2910004-9-almasrymina@google.com>
References: <20231208005250.2910004-9-almasrymina@google.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To DM6PR13MB3705.namprd13.prod.outlook.com
 (2603:10b6:5:24c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB3705:EE_|MN2PR13MB3911:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ffd81d8-5acf-4e69-b4fb-08dbfbb00298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u/TFxhMaUPlO9CrG39J2/Pl6caQYn7popi3+XThmNNeawNdL0CA0v6K8IbQrveg5QO2OttFrpymBQ3EAGpFCPya2TUUC+ilE/GRlRL8YWhsFn/Q/OyRAD9VmgVLPWPRq1Rubvxnvep1n8MN9bok1dZr+VLEmmEXIshlHECTefN5W9kmfRycjAiObNWHL9FPbKAQl4xfrI+aceIF7+HTcgUuwu7a2yWd082rQuQGw7/VtKVQpsL3OJ/ZbArJmR3ravSpzeM/Hjnl9bKeJqt9LQFrkxpjqLHva9Obz0eR1wzPCTcY9Y9lI7M9RsPlYrMCXXF7pJUQd5B80dz/ez/lV/Qp9vVbLCkBFosisF6A5y1swNgB+Pgl6Dk9SCwjf4aWxdUQYiHb2QfuSkpHxNDJzuf7qEhVgUqCPiN8XWfD0M0AKJHz5HuncfwDuB1QOR1uuy3Pk/O3cLNKnFd+it8PObbPEzv4x0ntKKd2VA2VEklvoARLs10REkLL0ROboFTTQ4XncgEs11ZLw1W2m5m2t1up3sHnDLNe9/xFVKR44tbM5T+JIf9I9PapZWrjQzCiDsHi3YCEc3tJ7f2wf7LuXkBN3s+tbSYFM6Ixgkeuk2eL/gWenjN5DTWOeCfc65n3eD0Y/+JeWvg20zNSyYugE0rvXzs994jHLmiheHsZOjiM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3705.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(346002)(396003)(376002)(136003)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(38350700005)(66476007)(66946007)(66556008)(38100700002)(36756003)(86362001)(26005)(83380400001)(1076003)(52116002)(6512007)(6506007)(2616005)(2906002)(7416002)(7406005)(6486002)(6916009)(316002)(478600001)(6666004)(5660300002)(8936002)(8676002)(4326008)(44832011)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GJH1GrK/kcD+ggAEBKftEI72XHFTrDvAHUiUqPb43B9V6IB/iob6DX4nTInO?=
 =?us-ascii?Q?H/6eMN1QFQIIL/0Z41eCxtR+S2vlsUVJbHV4avP/VFLsD5o8V0XuaXTa5Aq7?=
 =?us-ascii?Q?QSDblKvK+8vrJpoaa0ko3bnJ+C8gdNX5QtbBYClusaAUVPVgeWXLCXL8K/R6?=
 =?us-ascii?Q?wXdDvkb99euwpbUw2aQruCIWl/GrkkwCGpXAzht8bCTpuYVhrm7yNqfL6nl5?=
 =?us-ascii?Q?PPGPO9fzRddEzAqGfSfn7mm4waheg57pWWtP6NjUiTv0NZXSbRWIw+b31Cgj?=
 =?us-ascii?Q?n0EvN5mNOHAy4YeMtkmgRHAsWMu0MsvD1ug3Wu7yUm8awPsyA93/sAUHzGwS?=
 =?us-ascii?Q?zhTjZiY11kI7/FXx5mYnzeq9rjAeXJwSjZ9A8isWhq8MCuxocKyXqJw/FKM9?=
 =?us-ascii?Q?O861Sd7MliRlGb0Yhq0jPMDy4biJXpHroPJSkpgwz6GaeRj5cYwbZtAJp0/n?=
 =?us-ascii?Q?rX8uy20r/sFd1Qj89HwvgigZY5n6QEvSPMb6JHHUVV+pwIUXINEmWXGeeyBw?=
 =?us-ascii?Q?QFGfYE/+2HHR7KQt7tQ9cElQAk5giAO1HPLyA7uto/pOImapiVKKzbycGBhi?=
 =?us-ascii?Q?ZXlS0JDNmnzy/CtNqWoC9vj764qlr16ByUYTVZ8a+joIEVZOJBwE5i4/xXLd?=
 =?us-ascii?Q?DJ77Y2jq+eEO5ZZ3p3nAG569NN/+zJ+UgFYwVPZLz5pDoSEh7gduv7U8uy6r?=
 =?us-ascii?Q?Tmx4uc4I7aShhbf4TSVnjLYiZvsnA5B2ybayjxggI7WNFG5JJmV4SDbGuTXU?=
 =?us-ascii?Q?SCvmzYqja6wefPr7I9Atc1OvDDbbiGFny2quETHPfKgsKuA5NG0dXtZdTL9d?=
 =?us-ascii?Q?Wm8AixU07Sz3NqAeI6tZXOuaO358QPSqlGUlzjwmkALXrqAjSKuFSViYaLRH?=
 =?us-ascii?Q?hOeBTnB6entC2EFxHRhlQGvhnwZ+mkyzbQsyXlC6cmCKj4ElWlM/dmko6mtI?=
 =?us-ascii?Q?NT08b0JpObax7s956MM5Jj7eku0vdxj3OG/s3YG9iaMDmlbqFq5uA+Z/xNIw?=
 =?us-ascii?Q?nPpH3akwGPfNtrZCYDMbEs08U2hfxlg1YleHmb8Z8hVwghXTcyOlVkSIbd6h?=
 =?us-ascii?Q?6Ol2eMfA7gdjSwUUQ8QPlx5HztwCThIHxO3gl5z/EMOI+HcLzf5khXu+d6ZD?=
 =?us-ascii?Q?a6ZY1xyOS6NLtgu4tgsDfEswxvA+uPzkJj3bFlxBm5n8nNBobya6jURi8DA+?=
 =?us-ascii?Q?hObg27au4MDBgQt33AU3HzkPiwM2EEbOzxTpZ7hJOAuZ6Ampzh4wrEMH/wsk?=
 =?us-ascii?Q?rlGEhaccSyeAH+PvXQxCLJsNO3Tlz3SBrqf21wIgUrjSvcJi8zs3/NDfbss1?=
 =?us-ascii?Q?xCvC9qMlW6xVeMhaULQ+uetM89CBfJ22M2NyO8fMkBMmhQuV1fYsOLZaowOb?=
 =?us-ascii?Q?c66aQ15RM3P8mgHUSNQXoIunhY3Y/HJ2rxEvhfCCURad+YCrJA/PRcbmMOoB?=
 =?us-ascii?Q?/b5VFGqU2v42Ie4PGFce5iBH9SqNApjzPBMuEzN6t77aAwNulddI9Nr2Ctoa?=
 =?us-ascii?Q?HPyKh9fJIT5T0t9wT/VyVIL3b/unQU4zz/pIJOfsj8O9fgQIiUZd/J1Fd4X/?=
 =?us-ascii?Q?nEtfa2esrgKAlVjmmx0u6sZnUJW8+T89bFq/FswaTJrpI7731PhLBTKwyDO7?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffd81d8-5acf-4e69-b4fb-08dbfbb00298
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3705.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 07:49:18.4956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJGSBc4CBjl7hFKShRgkL1Xzv/9yW4v4oPFloOwak53LJsK0BMCy1D4Ste8jp4L7nt3qYEm2fgNWgJusDeJGu8VB1BavXe1OIAF4jiqyo+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3911

On Thu,  7 Dec 2023 16:52:39 -0800, Mina Almasry wrote:
<...>
> +static int mp_dmabuf_devmem_init(struct page_pool *pool)
> +{
> +	struct netdev_dmabuf_binding *binding = pool->mp_priv;
> +
> +	if (!binding)
> +		return -EINVAL;
> +
> +	if (!(pool->p.flags & PP_FLAG_DMA_MAP))
> +		return -EOPNOTSUPP;
> +
> +	if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
> +		return -EOPNOTSUPP;
> +
> +	netdev_dmabuf_binding_get(binding);
> +	return 0;
> +}
> +
> +static struct page *mp_dmabuf_devmem_alloc_pages(struct page_pool *pool,
> +						 gfp_t gfp)
> +{
> +	struct netdev_dmabuf_binding *binding = pool->mp_priv;
> +	struct page_pool_iov *ppiov;
> +
> +	ppiov = netdev_alloc_dmabuf(binding);

Since it only supports one-page allocation, we'd better add a check in
`ops->init()` that `pool->p.order` must be 0.

> +	if (!ppiov)
> +		return NULL;
> +
> +	ppiov->pp = pool;
> +	pool->pages_state_hold_cnt++;
> +	trace_page_pool_state_hold(pool, (struct page *)ppiov,
> +				   pool->pages_state_hold_cnt);
> +	return (struct page *)((unsigned long)ppiov | PP_IOV);
> +}
<...>


