Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C881E6CEEF7
	for <lists+linux-arch@lfdr.de>; Wed, 29 Mar 2023 18:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjC2QOV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Mar 2023 12:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjC2QOK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Mar 2023 12:14:10 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A517E6195;
        Wed, 29 Mar 2023 09:13:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noQNwDuwDcZHNafWTyhg2uxLb5UhkReMliBRX4bp49ds0Dwqvk7Hxlj8iuxc38lLYr34cg+KubG4wFr+UoKlzs9z9LKKMsIzciLda2gFs7bCKvHesj2jKrFhANXKEvzj3Sd3zX9qb+JEYNvn3UQfnR9ZszNsheiyAXWyy4PT8NaFjPiWuLyx+H3TbKi2Hu0UbHbX0j39Fv8vIceV1PmOaiogPE13NCjfE6KmyWbCFOC1ryzsnQ7AASx5vZm018BYgwdYROznkAc5jAIQ5I3dAYaJi5qgvYzuBnynxSdRaKd2yja8Hk0SQllumCe7lHe3r3Mt0tyO87GVsLUT8fX7YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMrin/bbw9+/uh750pOTmBDA76IAnjVuwx+1IzBt4oc=;
 b=gRukvZqFS1KfK3IxGm8qu+DNUHv77GW9gpwwiA+EbeacUXNylcfy07hdjsl00wh8A7nu94RjII9AOGYwxwX8zD8aTKkgRmPxtJhUrP8k+uvaEcnBJ8KYguwr7kyYSzjHC/R6W/WbMTUlp2KJQnJQPPOPhKin673Ai4ZfbinYSWr7hfJEkR4R0yTysGSAdlzc0DCmAf07DyiBUW5Ou/W7zlIPjdhd6yFAt9g1QBTe1Hu9k4LxtbxPrg7q4jsyqTwn9wN2OpOMQl2lzgD8VpSaxFB7HBU5K2oXYtiXbAxG12Dsa3Q51BMw/y9XJI57iP1LDLBX0Cg+dVxi0vsfGBfbWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMrin/bbw9+/uh750pOTmBDA76IAnjVuwx+1IzBt4oc=;
 b=GZ4usHWJ1AVQRGxGHLvtyTxYTiy7s0xoYuHbVQ4cZMy93dsawHxHhOtq9md9b9m5RyQmUGEofd1vYwBY3xzZumiWMoxmnrrD3xbMRq/glCM+2theparTY/161rEQ2uu2EyJb2g0b/l/PcQcSxZ1UOY3xNWAyKsnfe9JIrqGs88A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB4600.namprd17.prod.outlook.com (2603:10b6:a03:371::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 16:13:26 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%5]) with mapi id 15.20.6222.033; Wed, 29 Mar 2023
 16:13:26 +0000
Date:   Tue, 28 Mar 2023 23:56:01 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux-Arch <linux-arch@vger.kernel.org>, avagin@gmail.com,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, krisman@collabora.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, shuah <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, tongtiangen@huawei.com,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v14 1/4] asm-generic,arm64: create task variant of
 access_ok
Message-ID: <ZCO20bzX/IB8J6Gp@memverge.com>
References: <20230328164811.2451-1-gregory.price@memverge.com>
 <20230328164811.2451-2-gregory.price@memverge.com>
 <20230329151515.GA913@redhat.com>
 <9a456346-e207-44e1-873e-40d21334e01b@app.fastmail.com>
 <20230329160322.GA4477@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329160322.GA4477@redhat.com>
X-ClientProxiedBy: BL1PR13CA0129.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::14) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB4600:EE_
X-MS-Office365-Filtering-Correlation-Id: 14bd1650-30ac-44d3-1cd2-08db307086d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: viVDPq7284MxarkJEPVZDEaFJikcSu6xsUjMl0qSvsMaV/IzZGsWz9iq572POw8IxHdH9NRIibXj6I4UNXWW0cc3pMo6DdeD8blegcxL8OBgkXmWYQ1QmV3BXU6JTPMpZGTD/WYaX5A1H9VlM8hiWS+5v4yeY923Tlby9Myxg514UAGTJSU3pQTUzMRdYAtwfNerbkdqRmgXeza9lzovbR2GjZiDuQYgnxT9JgC57aW8mbnMI4NGRgYqd5zBNNVl/iKOJZcjTOauwV2XlL+bYxeUwFZBRYEqq+FLbg9lNVIUfU6/IHqSWt/Sme2hz42ocbrBZT2NldGOp/Nl6loTg/yepigaI7vksPQ3OqQpBl9xceQLSH1qTYSbCcFrArOPtzENsIKAdH/4sZnak1X8adYtCE8t/rXw0Gl6A7bE8vhj4EWrmX/Gv7QnoiJWP4oyQ1mP6eM7hH7m4LHiEZ2nfiDprg9dxqTdd6v3UnPFBhATf1HR4JWBwRZhGdKiEHYTHDlym13P6Fp+BMrP/Y4Him68VeLpNKqAbS0yY2VMDik1Mc1sMOGyENQaEstYKssA/jyfOK1SqgGZKUVOsHj/NIBoWHuOnqH91JtyNq3zwuM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(39840400004)(346002)(376002)(451199021)(6666004)(6506007)(6512007)(26005)(6486002)(6916009)(316002)(54906003)(478600001)(66556008)(66476007)(8676002)(66946007)(186003)(83380400001)(2616005)(41300700001)(8936002)(2906002)(7416002)(4326008)(5660300002)(44832011)(38100700002)(86362001)(36756003)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XpJGz43+RC/XrbNtCF9CPCTiRrtcuw0EZb5QxSC2ZahijhZng89VKP41lgah?=
 =?us-ascii?Q?0nST0aft4SyG9g/drJn4pwmTLDWKxnorkI1zY6f2LtjOYdDMtp7w8V26f4jV?=
 =?us-ascii?Q?pZTj5OfBMU3LoPRHe+pT/SC+APAaGuKhPjrIzylvh2IGoyMOa/OqLyycRHKe?=
 =?us-ascii?Q?SnZgQgc6zPHOIKcwLPM9Rb39KCspT1VnLNyNHLUEiwJLqphr7Gfa4Xzb9dJp?=
 =?us-ascii?Q?QyyjvWtbNCJ3WR2qJyO84rI9/4RJLAZo5ew/nC9lt+xN2RBCbwNw/vTVBhDf?=
 =?us-ascii?Q?onkwzYE8I7CYltbbcJ2vSfLME90Rbsc8V594rjl6gT7IewUwu7kdqQezlPna?=
 =?us-ascii?Q?kx3kweh+LVhPgR43CoGN4d+O599cSmEv39UKItblTYu220l/mbLPvCrEuB7C?=
 =?us-ascii?Q?qb5hsfSpWAGu5GPZesDREJilnx9vj1FHNxRzreteTqg/s9UZhDosIjSwvLRu?=
 =?us-ascii?Q?uHfEWF3Lguows7fyxcW5OilK5tIi3BmLxpBUGkWlmrgQmDASLfDQqxRDYA2W?=
 =?us-ascii?Q?vKjA0JjUOJdfkeBzvTcCCtzkFp4BiAmKM8wLaL5hHIe8zhVJSmnhSFNKot+a?=
 =?us-ascii?Q?MNs1bKSYYCsyoq/l9x+TahHFV/+NnRJL59mWijBOLqnk3Mz5LvFQyW7HbN26?=
 =?us-ascii?Q?BoKVYpm2mVsmVkEDkmPKzItZi6vombtVsm5nW7ZEnRYoPSRh5TmvLGUnl7qa?=
 =?us-ascii?Q?0+3oTKeTP2s7lSaQTccc5Gj4ep3unkVZN1pLnPqN8OjrP1ycoEFFpqjGwFy1?=
 =?us-ascii?Q?trAeH0Le0xI2zRy2U+FO0VBa/hsqfqKQEJYuO4pcVMOy+FxvAb7IKoKXLggG?=
 =?us-ascii?Q?6LD+9IygEBM8HxHKH3P6MYNycuvPblj4myB2SQ9fHlBu80uGaoBXT1FxAUWU?=
 =?us-ascii?Q?LlOlx0jEVmndMPdwJiF+SpPrs8QJ3+L9tTrUiH59tvUwF63/t//t86jtv/Ch?=
 =?us-ascii?Q?MXPZ3FP/ik7ysxrop5oPsLNGEPHNA3d7Xzg69U8tPOizaU4pwmeTUDmFuk04?=
 =?us-ascii?Q?OBbKAA1vMunN+wvEEdY60O68HRqUJIpjPYZk06PIbNIQYYaZGi2HCU1Dilmy?=
 =?us-ascii?Q?NzCGXYkZ6aMbi+tjH8M476eU2n3YgRNsdQqWKj9sqpqOHmUduRgFWkyveq8A?=
 =?us-ascii?Q?02ONr7mHuOJQ3djPPQjO1AIWFb51bhhht6uylUYas4dzZu08zsif4VVyzMb8?=
 =?us-ascii?Q?Q7EGwMwB6i80JfL36Ojoo6jyPrP3l73B0HuUUd1S0v24BSpvFxwf09+zTPBZ?=
 =?us-ascii?Q?27pSJkRuRvKNRIwdw/JUd14l5nbQMTJtynZOYCCbsI1wsjplJ+x8kXQknK1G?=
 =?us-ascii?Q?XcP+mdbJUPrsvypztEl2SVxvjUNu8KE+mCGrAZEz83IQGsadQB8NmzrTeekz?=
 =?us-ascii?Q?BmWR7Gu4YfkbX/cXq5md9Iy9H75yJlJ7kRvTaY3t7ZXRWCCuCiNT0zxagyRB?=
 =?us-ascii?Q?v9fN3GGmXlkjSNWkFmnss1Z8iuf9B1EPCStdQsXJ/HnVMGK7Abwd9qkU8cgZ?=
 =?us-ascii?Q?cjWAquKdWD46e+5N7MU8VsGzghG1luIBKM3NMwnjF21bxZCM2BvsXZaC2BUL?=
 =?us-ascii?Q?puD42UsNhcqeLu0fzjRcv5XvW+q64AjagOo9FvHNSUXCfGHjrapkcwERU502?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14bd1650-30ac-44d3-1cd2-08db307086d3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 16:13:26.2100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8/0VY0+ZBse6U3Ld3wQx4shLX73gPKolis39IT/T9BOR1mScYjwZE//LAl1LGmjxEnK55JvGTBNu+aN9hlFVOTPcwASkpQeySRmDiXT7IQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB4600
X-Spam-Status: No, score=0.6 required=5.0 tests=DATE_IN_PAST_12_24,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 29, 2023 at 06:03:23PM +0200, Oleg Nesterov wrote:
> On 03/29, Arnd Bergmann wrote:
> >
> > On Wed, Mar 29, 2023, at 17:15, Oleg Nesterov wrote:
> > >
> > > This look as if access_ok() or __access_ok() doesn't depend on task, but
> > > this is not true in general. Say, TASK_SIZE_MAX can check is_32bit_task()
> > > test_thread_flag(TIF_32BIT...) and this uses "current".
> > >
> > > Again, we probably do not care, but I don't like the fact task_access_ok()
> > > looks as if task_access_ok(task) returns the same result as "task" calling
> > > access_ok().
> >
> > I think the idea of TASK_SIZE_MAX is that it is a compile-time constant and in fact independent of current, while TASK_SIZE
> > takes TIF_32BIT into account.
> 
> Say, arch/loongarch defines TASK_SIZE which depends on test_thread_flag(TIF_32BIT_ADDR)
> but it doesn't define TASK_SIZE_MAX, so __access_ok() will use TASK_SIZE.
> 
> Oleg.
> 

I did not notice this at first.  Thinking of solutions, I'd originally
considered writing a similar change in asm-generic that I made in arm64,
but that would have ultimately resulted in "(void) task;" because task
appears unused.

Now it seems like TASK_SIZE/_MAX seems like a dangerous define
combination that hides relevant functionality. Fixing this seeems to
naturally want a "TASK_TASK_SIZE(task)" which is... uh... annoying.

Not sure how I should proceed here, but this makes me wonder if there
are oversights like this elsewhere, as this seems like a pretty easy
thing to overlook.

~Gregory
