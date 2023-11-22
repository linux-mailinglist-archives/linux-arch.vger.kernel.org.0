Return-Path: <linux-arch+bounces-403-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5954A7F52D2
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 22:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E85B281451
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 21:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7D31CF8C;
	Wed, 22 Nov 2023 21:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="rP6ou0Hs"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E68BD46;
	Wed, 22 Nov 2023 13:45:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuMUPN89voos3AxT34e/wW1O/NUhki8F30sTJXhjs0N5dobl2cST0XdD+DcmkjU2gI75HrV9/Ocaq8RTFoqDd4JbVB/2d3nAHTjgxAjKuJ9XhWvKlHoeX1icoZG83ORVyp5r7lX/+fYPML5rN0mkDXOK+ImnowUCIIbd7DcoPiWLT5VeJZCXaXDvlud8r8kN6j0j9fcXxbREQV3kithbli9XRtsitZVIE2foMFXZ2haRwVjk+uQU5V7W8KijRwn8dFRtCw2xq7l89aSN5vQB9IKBSyp2yu1H1e7noPq9o+7OlKAOUTRVnrx8blCvD04Y7oOuaXlz6sSPstmyA1vWdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvqXsIqGBjD1RzWHvbnfzrZdkHyJzTeR5D+t2t2H85A=;
 b=JAQDY0jjoJ9oUANSCnMkWq9IwVm7LAQy7RuRkNqrw7FvrvpD+TuN/GL8L5CedO+QBZgmwMkcHxdotPR6i3cS0xegfbDTwh/NrlNg7A7KINfjc9nbSkNHkwlp1xdiSf2/EO8YHwbJz/E4HNilSYTvZIa4v4i4bpDVOa7XVLIHA2l2/p3zVMx+0VcvH6al1WSfB4F1RpnRP1ehNHuSQtUEbr/qw342h1kIc8yjTt2BEoGdqZ6FubhwamAb2npKUxtEDTba322dQvffj668Kjn/k1ssa5FMI1eARUwyvFvBMiRJxpDd9Rrdp3gjLQveD97xPlMvkM8yB4wunEstknShQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvqXsIqGBjD1RzWHvbnfzrZdkHyJzTeR5D+t2t2H85A=;
 b=rP6ou0HsRrdDAv19kAK5v4JAZSJUuD9Bp5eJSkijLnUL4FgdwVnFRGpQRiytAhKVrQ5dca/D6tfpwyLN4MzsmXhpo3zn7wwuQh3TqhK9gtLMXtrEpmMDhp2efYzPg7tkIg6ylVrl+Ie1CdL6zA+wPey6mVZLnShszj1oQiacKAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by CH3PR17MB6385.namprd17.prod.outlook.com (2603:10b6:610:14d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 21:45:12 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 21:45:12 +0000
Date: Wed, 22 Nov 2023 16:45:08 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vinicius Petrucci <vpetrucci@gmail.com>, linux-mm@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
	minchan@kernel.org, dave.hansen@linux.intel.com, x86@kernel.org,
	Jonathan.Cameron@huawei.com, aneesh.kumar@linux.ibm.com,
	ying.huang@intel.com, dan.j.williams@intel.com,
	hezhongkun.hzk@bytedance.com, fvdl@google.com, surenb@google.com,
	rientjes@google.com, hannes@cmpxchg.org, mhocko@suse.com,
	Hasan.Maruf@amd.com, jgroves@micron.com, ravis.opensrc@micron.com,
	sthanneeru@micron.com, emirakhur@micron.com,
	vtavarespetr@micron.com
Subject: Re: [RFC PATCH] mm/mbind: Introduce process_mbind() syscall for
 external memory binding
Message-ID: <ZV52ZD7AbIBoYs2t@memverge.com>
References: <ZV5zGROLefrsEcHJ@r13-u19.micron.com>
 <20231122133944.297ce0001fb51214096dfb6c@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122133944.297ce0001fb51214096dfb6c@linux-foundation.org>
X-ClientProxiedBy: BYAPR08CA0051.namprd08.prod.outlook.com
 (2603:10b6:a03:117::28) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|CH3PR17MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: ad34de01-c7a3-46ff-33c5-08dbeba44e42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HGCORgtspQqw6B64fnv2KUnEQBmu+TANbwLNHhxdU/EjEOXNvAq2q4psSnqY4nfo66WMAc8v7av45v6Fb9JrDu3potUWKWECdhvo4+p6nLUIbrKw3dQHukg27JYwQ3AogS8jYWsVhCuLEDB9QnPiqbjG/gO6DZOQVvNT4UuDSQvC2nOQ7FaHFAd24dE0KMW9d7aZYrcpTPZYysNJSwKSwVRY6lXhasMGrRiXruphsYwYJPnRgbMmBN4QR1gmpTVbyjbfV2vKEQfQKyaN7s7wva02kCVK2yCeZVW+l3IIOz6FRSXaWEru4bqnmT8/PXT2BNXCA+sZboXui0i/WUVdPdRC8EJMKIlSmdf1EiakOVaB10ALu8yIiUVZ54WB54jpZViMQ1UpVHHc+3FvgtLk+PLf2iQRPwCDynr000z1owO6aKOErHPjCXBxXQxwB0vagqIE8yn3tuW7fG4qnWkK5uAcx8B776r8o6Mmzt3K62X9mYDMI/UIHWORkOfDM2o5xNbozE5TBfmFgpvz9R42TAQVuoiy/Nf5cVDTkQLANFQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39840400004)(346002)(376002)(136003)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(66899024)(66946007)(66476007)(66556008)(36756003)(38100700002)(86362001)(6506007)(26005)(2616005)(6512007)(6666004)(6486002)(966005)(7416002)(4744005)(2906002)(316002)(6916009)(478600001)(4326008)(5660300002)(8676002)(8936002)(44832011)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P0TAT4jcwKUSRXH77d/tooh9aB5K82SVBmxU9+HSuYlfbbxRQKbtZigPT/47?=
 =?us-ascii?Q?8qqJrHBzn4sA522uHMDAKXCiTA6PubL7TweJ05NK6TYlGQ9DC0pnFUf01gPz?=
 =?us-ascii?Q?Qu3PKDvJUcCdsSbGsoCZcnEz6d0f2roNcjQVNf8duUSjCZEVmVM80tQxNE/B?=
 =?us-ascii?Q?UMOL4CaX2K2vJTtkT8gc4+8uy1lHyJdFcxULvQuxUvuOI1BjXkIrbvaUBlTm?=
 =?us-ascii?Q?BpaqZWSYgWWhyfhd7jkBw0hh6KzSvGAV88B7d/s/ox4amJCEYOvZIIYlegIK?=
 =?us-ascii?Q?7J4Fs0ffviZRrZIPotuX6yB2AqIM7T75wNti7gvJ0Q4MjwIh2S0xB6oEFf3r?=
 =?us-ascii?Q?XxtmzMYXAWfYBPvF8/FYX9Ec9yviLPz+qp7nGo9Sy2SvUbZvk3/51GaDkihB?=
 =?us-ascii?Q?15Wtpj8MNnxtKt/E1FZiejGSLSpEpMVIsDIDFNpVwrW0i+tzxwkSZ+kJJV9G?=
 =?us-ascii?Q?UAtMqpP4tmLGs1ve7Fnr88H6sb+pZVf3CHBgzUvJ5w5R9GhGm/+Eo3kNGxRM?=
 =?us-ascii?Q?+es1Vs+BZv0YQkTIINB7YTRAZ3IsJ4Zox6USmRNIqiFgJR8pC8c9LnqkVrL7?=
 =?us-ascii?Q?JsUMy/9qUS25OTIXJYLQ/Su4xhFX/HT7Ou64HWxDEPvA9cX83XAQQb2aWh/v?=
 =?us-ascii?Q?2NWRcyluB2fHauo6uKvmPIM/36RzsHzeyvKMea7ImJV+NE8ssKRC/xY4CAo/?=
 =?us-ascii?Q?LmM0UW8Snh9M0prfHjQpLW6DUdNeo4NwRrYZ0QWi19aXbx0ieScYdYx4OTdz?=
 =?us-ascii?Q?1R9Go/r2Dz6BEygrQcWE+yN5M+/dsjAYo8V9lgVC9h7pyofbBReLaIY09kU0?=
 =?us-ascii?Q?wROGGhbQMhw0SojGl/aJomDaINFlpebPuIUbbbhfPGTAxYbkN/AI6rAEO9Ys?=
 =?us-ascii?Q?F+EIpE8sGfsYTb96JblTPBALsVmOooPv1fXQ5Nc32+T2tTa0ckASslrMCt1z?=
 =?us-ascii?Q?LjI14d6RfRQ2HvcDq/5uRxFv9JlzJ0arSK111wWC5Sh8V9PBAXjat30e45Ov?=
 =?us-ascii?Q?VELO8PISfKsqpn8t/BjaVp7fgU45FC8/nJrp79iKFUk2KuchGkV/kneZu2mo?=
 =?us-ascii?Q?T2UVc4OVRDzwCUhtNfY4HcN4ytlrAACa0fxdhxvA9VJwlSy8+XNyk4TAupeJ?=
 =?us-ascii?Q?Nsi1MMj32a5RJctltXmhDH+1w0hT1JtN3MzGRX4Bp3X9lZ7tWSjKGdeEOSoy?=
 =?us-ascii?Q?vouxFORWqLNuPS3En94c4c13+yZApXGd0BZNO+Sjike+1oO8AWtPlFZFgv92?=
 =?us-ascii?Q?UM536g6tEvGCCMe8u6TVXE02M8NH///t4hoGACuqd8tb+p/nxRFCleYI1KQ5?=
 =?us-ascii?Q?WRFBk9LbM0ieZuzoHSwGxfQ81aSoGSNUJ8KG/mWXx4UODEqXwOHs4OTejkkm?=
 =?us-ascii?Q?LP+kHpwNJFBkO2d6b0ZMYmW9Lr0eKI2dWSrYZHpWOOngmhHEO5AvQF+s7IXX?=
 =?us-ascii?Q?ABvt1nHPfHCkiuc9/EWV8KicH812jfsiYNy+SCWmliY5aLn/MN8A+nAWb3cb?=
 =?us-ascii?Q?3UtoNMbHO64nJxhWGt6/Yie3l9I6Oarj7EJzIlYC0HojEt78oHt4m6sEcUmx?=
 =?us-ascii?Q?yrnTqlB+WLQpZd1meA1jcKocszOdXgEwF7d04figxoZ6hEUO9hap/jKeNXYQ?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad34de01-c7a3-46ff-33c5-08dbeba44e42
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 21:45:12.4463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37PQzyjHeWR2GBQLcEIB+ivXiqeDk3Yp9KLpsbKBKE79HYa5GGxkKtrEdqpOzZuByzQI/NBWEvhOxQUhv11QXeSD8icnnG3t1zOD200QtmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR17MB6385

On Wed, Nov 22, 2023 at 01:39:44PM -0800, Andrew Morton wrote:
> On Wed, 22 Nov 2023 15:31:05 -0600 Vinicius Petrucci <vpetrucci@gmail.com> wrote:
> 
> > From: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
> > 
> > This patch introduces `process_mbind()` to enable a userspace orchestrator with 
> > an understanding of another process's memory layout to alter its memory policy. 
> 
> 
> I'm having deja vu.  Not 10 minutes ago, Gregory sent out a patchset
> which does the same thing.
> 
> https://lkml.kernel.org/r/20231122211200.31620-1-gregory.price@memverge.com
> 
> Please share notes ;)

Heh, we discussed doing this at linux plumbers, as well as a long set of
RFC's related to weighted mempolicies.

Guess we were in a bit of a race to RFC without knowing!

more context: mhocko suggested this interface would be welcome and useful
before the introduction of weighted inteleave.

link: https://lore.kernel.org/linux-mm/ZVNBMW8iJIGDyp0y@tiehlicka/

~Gregory

