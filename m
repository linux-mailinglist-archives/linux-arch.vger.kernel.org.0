Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FF86CF1A1
	for <lists+linux-arch@lfdr.de>; Wed, 29 Mar 2023 20:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjC2SDB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Mar 2023 14:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjC2SDA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Mar 2023 14:03:00 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2132D1733;
        Wed, 29 Mar 2023 11:02:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/aZ2W0Db9TooeBX3DlzlggoLFrKVdAD/ytFpcYZ1BRAKo9fpIWsbzUdI2gesZiJxoYZ5zacxgaE+zd6pMtDRGlDXeNW0LtMJXkjn56S+mF3JUk/gDyekC/g7x2ZBgBOcjc45UBTvQnJeLd1X40mk8SqlJIPeh0IJsin9AeTSo383x5Uus/tATERmJX91/LeJmui2FJDhv/rx1kTNVOWwYVHomGwM09mu80Lbt2zyXc7ijguEsgoQfMIRUW1HHkYOruKocdALhc5nadh8bIaKrwo/jg5jGT9o8qI7tEpdg3TgA5BzJ9RFoX0QWRUQ1UBeMosKg+LU2YpZUP7vqegFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcCE8fsS+2OVquRyLgo3jfPr2w0cbIh5VuuaV1rXVGQ=;
 b=XFit/15GXGBUbQiwmnrfRBQj3XuDBMyyxCTBTGUyvLcX8pqVqoU+j54Rb80tMoppBnl27bUR+g4vjfgozWrHihDbyYkMWkLR6Z3WsAlXqNE4QNFdNU+pYKlh9t8QxGpzvS9t8DnyoRP3nzLIhCnveqUTaxo9WtcEj5iBCrYMqjGR34LJAFgIn8tj36UPL2xal2cOg0TUCe0thY500tgk5Ay0rS/FSYJjnndbnbGD/2ppCtQs8gHnkGr+nuZtvRp9U1henGx4ucFtPYjAbUMOtRiAt9Y3UKV+8xcNd9cxXXfEfjK2EZ2fHE7T15iYJOXgFXSbz7vvQWP9d4iT/0gXwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcCE8fsS+2OVquRyLgo3jfPr2w0cbIh5VuuaV1rXVGQ=;
 b=SUkMDRY4bpPvMkNjbogsKlKYQFCUF1GdmuxH3qi927aOkYcCg9QYiFEijJgIUjxjTOrE5o260hH9GxdEgCS1s6UND37PInUY3ilRZ+BaVqYqKELVIGmMQvB3UfMM9gFOXblEBQwIyuMfpF7OiT5O3omB7Se3l+sa4Czi6YXgnJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DM6PR17MB4058.namprd17.prod.outlook.com (2603:10b6:5:25e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 18:02:54 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%5]) with mapi id 15.20.6222.033; Wed, 29 Mar 2023
 18:02:54 +0000
Date:   Wed, 29 Mar 2023 01:54:37 -0400
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
Message-ID: <ZCPSnVgvyv3uaAKY@memverge.com>
References: <20230328164811.2451-1-gregory.price@memverge.com>
 <20230328164811.2451-2-gregory.price@memverge.com>
 <20230329151515.GA913@redhat.com>
 <9a456346-e207-44e1-873e-40d21334e01b@app.fastmail.com>
 <20230329160322.GA4477@redhat.com>
 <ZCO20bzX/IB8J6Gp@memverge.com>
 <20230329171322.GB4477@redhat.com>
 <ZCPOpClZ3hOQCs7a@memverge.com>
 <20230329175850.GA8425@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329175850.GA8425@redhat.com>
X-ClientProxiedBy: BYAPR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::26) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DM6PR17MB4058:EE_
X-MS-Office365-Filtering-Correlation-Id: e9720e03-3302-499d-1e6d-08db307fd1c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yF8tW33Uukcwu3jO6CBpGNGHIBTqZudftwYkPkfeEKLOiXke0ZOF9iz3fZYgX/pbkXmqjeb5r9CSSZuKLP4IGcypf9J6K+2YMUZ72z8DfLInILQmSd4GXb0cNZsuqkXmay69vgsg6fw4h9OHqh8dlFU/qzW2m07woKdvXNF9ZcrBz2Kg6KqjYGe6CEt+NAwBvGBDwl6IK/76WvyqLlzd5vOjeIep/EFs1PKc7cQnwM4bsY+R1bLwg1mUV71ojJPt0tuUYBxH/g84I87QegvgXFOmK6oJPrjrhmHqGfQLsXkNPUzn8HOkPQUdcobXwq8fWD5S0y9plJbnJPF9p9cHDDpgwp6DiT1SnJJpuNmpQFTif7oA3pepIdM1tAB2SmdlZvKz+MeBjMZWX8lMl0LGHB9DUKX4x+CQFcO2T9hti+wC6CRijZXfb5NI5fCw7MjXOdUDvNceIDI2Pi6HEe+pXJEoEo8MIzWKpDuOeR0tHY0TgwQ8cBT933oyznf6yvi24UeF9/P9o9d+ODc9+RoUxQxxB69Z6l2mPS6toEBIDEODsvOW1nZojCja+bN6t2jO9SjMkZBZX9Vx2lN44Wp8Dw8BIOy0pkbDBhIKVeIxYq8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(136003)(366004)(39840400004)(451199021)(478600001)(83380400001)(44832011)(2906002)(38100700002)(7416002)(6486002)(2616005)(8936002)(5660300002)(54906003)(6666004)(316002)(6506007)(6512007)(86362001)(186003)(26005)(6916009)(41300700001)(66946007)(66556008)(4326008)(8676002)(66476007)(36756003)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h7n8gL+WkGd2No0vxQipaKCFnwSqlqtwFE71vgWrTsce81MfHNsp1Q5SSeXw?=
 =?us-ascii?Q?wmvh7vStm+7orlhslN+cKDDXThafPFbgdkYfXUwJLmA2WQhXXwUqO6z2vKMt?=
 =?us-ascii?Q?7QViI+nMeirSTpM/RejOQ9qD7aKXnQMBaz60ntbhtK/e9Own0Sq9rGCBBEpV?=
 =?us-ascii?Q?RMghnRBin7MP5a7z9ztQt9C/5Q6bdgF7XmYlsfEN0fLBLGOSQa3cqnLVmV86?=
 =?us-ascii?Q?dhH5gHsb9VOtoltHh2Z/6WLvZJp0QL9979D/n9q5N62MXLXwfsK54NfDTG39?=
 =?us-ascii?Q?/l41mZek9a+ZnuixvLpfwZ11ypuUGA+bGEPCYqqm4vOCYBda/VIMYltrNBL2?=
 =?us-ascii?Q?KLQggG0rXiBgef6luRgozpohdV7ht664u5Jt/GUAnf3DQ927MBGffcPsCOGB?=
 =?us-ascii?Q?bdOuHAnHaMsliuVsEgAjNTm8YSC1SSAkolnwEwuCKDwTf6aTUD6rtvJJ5B2p?=
 =?us-ascii?Q?LqCxzADdaaN5YVPqhAcUxsm21s43z1+N3LOdYqliq+TjEUxHeiDBxEEIOYjc?=
 =?us-ascii?Q?MXUSiAhjIyHZmzVaWxYbX1Uk1EgQDyiFb3NqlAxATWtUTOxGRhrQo/s4HyIr?=
 =?us-ascii?Q?5bhzXYKuoJb1EVpbmyfoX8h4btguFsaZ3su5kJf+zb7YQmTndSgT26MIRt1A?=
 =?us-ascii?Q?Gpd2iMrigS4li7K9yQda/nkPzytObQd+W8nCHii9F1TDvpiTyUZ2FDmgoBnK?=
 =?us-ascii?Q?VFU59uD4rfByO0y99v4olNEq2OEexB51RyqZA9Btd8IBDUJs5Qe5ffWxwNSg?=
 =?us-ascii?Q?r8diWC+n3Gi8pj8EH73zehVeZSLWsHtSp5riQ0bYCtDZ20gtF+VM3+3dBb7C?=
 =?us-ascii?Q?f72MIjAD0HrtrtaHEQ/VhdmvKo2I06eZBFjkDTIC5bY6U1sXBuLUrjxP1RvW?=
 =?us-ascii?Q?JTUgLKOS5mDPSX7gjV6rGbjoPz8qTaSRqHXhQLmFKVhNT+ylhf+wZqKu/Qgi?=
 =?us-ascii?Q?Apmcl1O3fcCBPNx81Uevj17Rga5xJYvprGL3P8eNkBry2g0UepB/vPk1gFU5?=
 =?us-ascii?Q?VMx+xLHqE5PS9QEMtuIKph1G28t72CM0YMPAP4bFDEyaj/7qluYb7fukqQaO?=
 =?us-ascii?Q?+4Ne/FxxSne9ojdGgf9ddD4pYLSL9peV+Tdiiu6gO9Mfzgp8kr5am17ZXVS0?=
 =?us-ascii?Q?iJ2WT3OHex5jd8DC/xZHIWLqD+cFaA9adiKDRvMDy40H4icXzezMvZNFKnzE?=
 =?us-ascii?Q?lTc0Y9mOK0I+Z0yI29e5gx3WJIvjFk6Po3So1lmfzM9ypWstPJ+fQe+oQNyE?=
 =?us-ascii?Q?goq2lMwX8Wk/RGWy0T60Q7DUBOhybVICGueMBTk0vMXEabxRZbw9adVrb5PO?=
 =?us-ascii?Q?DeAf0jyuLNBK/OYFqxW+dSlAZHAxKDsXVKWY/VxkPHHJSwbjyw3vEvEGaV/X?=
 =?us-ascii?Q?q6trsUvlh4JZ1PKrRXMz+8KozlcfQafvOquWYww0J57fn73ULtbcRXnuVg6q?=
 =?us-ascii?Q?uun6cx4IY8bvuA7ROqRtwVy5TMY0dGZ5TEwJH54AxxYhPGE3HGCz0oA9cGhX?=
 =?us-ascii?Q?JrbEjvq3+6HrarlgWhry943KOdzvvpUvy2gVfSNW5/ElcYK97thbH9lorqyC?=
 =?us-ascii?Q?4NyXGlmCCKuXGsAgMMJ1otOXDG8DtiXo1+WzRPXeTDuu6cgDERMqYzHmGBrC?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9720e03-3302-499d-1e6d-08db307fd1c5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 18:02:54.3894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0ePGMqsylr6Ki4QqgnKO8bcKLGnQQ+PTHalCusZhvPbar5WZPkEgRbXG/UHzeyGlWuGQTudd797DaCyDciB57KFFrCI4btHCK5kuyTgg8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR17MB4058
X-Spam-Status: No, score=0.6 required=5.0 tests=DATE_IN_PAST_12_24,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 29, 2023 at 07:58:51PM +0200, Oleg Nesterov wrote:
> On 03/29, Gregory Price wrote:
> >
> > On Wed, Mar 29, 2023 at 07:13:22PM +0200, Oleg Nesterov wrote:
> > >
> > > -		if (selector && !access_ok(selector, sizeof(*selector)))
> > > -			return -EFAULT;
> > > -
> > >  		break;
> > >  	default:
> > >  		return -EINVAL;
> > >
> >
> > The result of this would be either a task calling via prctl or a tracer
> > calling via ptrace would be capable of setting selector to a bad pointer
> > and producing a SIGSEGV on the next system call.
> 
> Yes,
> 
> > It's a pretty small footgun, but maybe that's reasonable?
> 
> I hope this is reasonable,
> 
> > From a user perspective, debugging this behavior would be nightmarish.
> > Your call to prctl/ptrace would succeed and the process would continue
> > to execute until the next syscall - at which point you incur a SIGSEGV,
> 
> Yes. But how does this differ from the case when, for example, user
> does prtcl(PR_SET_SYSCALL_USER_DISPATCH, selector = 1) ? Or another
> bad address < TASK_SIZE?
> 
> access_ok() will happily succeed, then later syscall_user_dispatch()
> will equally trigger SIGSEGV.
> 
> Oleg.
> 

I'm convinced now, this feels like the correct solution.  I will pull
your suggested patch ahead and drop the task variant of access_ok.

Am I ok to add your signed-off-by to the suggested patch, and i'll add
it to the series?  Not quite sure what the correct set of tags is,
since i don't have any suggested changes to your patch.

~Gregory
