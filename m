Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9236CF59A
	for <lists+linux-arch@lfdr.de>; Wed, 29 Mar 2023 23:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjC2Vvn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Mar 2023 17:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjC2Vvm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Mar 2023 17:51:42 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDA2BD;
        Wed, 29 Mar 2023 14:51:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwXfORcUEUS7/DEB+R+dTaMkxGulQ8VV8F4ywPXTLQh/NgHUYMiowN3bwQcgEiGhOdvvRXFdl6dAOR8HsVcXZsxwu+agHzVAx/D+sGJ9zKae2UX5WcbMgRBNwtVBLBJo5N7ioEhQWI5l9h9D4pPPDFCeNEqbaeCDlICi1ABA1OG/dBFtxeIBXJpowLMb3Ab42C3HGUus6L9KvV70/LFic7FEwEFvD5RpTkcC+Hw2OIZW2adFqgrIBqwcS6Oz1KDIbYh7r9McrWq2kp6fiTuvbtJZNumSOOLHqB2u00IwyGbwOs9FLvTvrXNLT0RByjBjN8yLtGmx4oy4GxcELFqobg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/Rc1hEHZBgSghDenN/ZUGcyv+CMCV17PKOvDoRxDfw=;
 b=gqxQ/+Ll4/jvlCZwz1qeSEwajfRXHw7WwNP1x7WyKCTdhvDeG3W3xK94YJhZ0B1sNaNtn9l2DGUahzpm0HtD3kze094pcDfjrYL+0fZ6bNsjKf7KYpv4MabEfbILnDqnQZ1Qk31a17p00HGDtbS01mEpxOHp16yAO3bFCM4cDEeuVeDaU8yUKtg8h3PsRRmmw6DUXbcK0A/6UFUC+BZd6IYUvfoe5NGyqd9uHSwYmZAt2NbM/0ayTGNkqUd2db7WQKcDv6W5IJLsjf7zSpuo+kirYaMtPOrNYJgdP3IvvnCcX1FJgcMx9mOiJKaEyKnW7zS3Yyw4NrvyDPtRZTNAEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/Rc1hEHZBgSghDenN/ZUGcyv+CMCV17PKOvDoRxDfw=;
 b=aWb9iA3UcFeP+nIXireGGbdcAJZ7xaqhOdbGNt6YRz6coCz/vf15w/s+y+L1tLCfOrEYsuTWWfTurnd43qokEjm2FUjdwe/ROKGOoZqBzSVx8b/DvmlVNXHgknyaFSlTER2Kol1cdujq7sY9JtcnCPO96Bd4cuNNjq7PmOipsOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SA1PR17MB4753.namprd17.prod.outlook.com (2603:10b6:806:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 21:51:38 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%5]) with mapi id 15.20.6222.033; Wed, 29 Mar 2023
 21:51:38 +0000
Date:   Wed, 29 Mar 2023 06:02:25 -0400
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
Message-ID: <ZCQMsWNfkMJ0xHSy@memverge.com>
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
X-ClientProxiedBy: BYAPR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::32) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SA1PR17MB4753:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d9417e-302a-48c8-7c61-08db309fc5f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /MyRV8O4uugR7hyZ5kFC+eiuUza4q/jlSx25hCnXm2Ob2pP2rZv0a9E9ExGftZg3Hm/B1LpP/mbKVUxTCSNeTsA4GUfOKEz+lgTZM7ruTKM9wVTitzClfZZjLxPIC5wh0N2P5KQPJWY90446wVm9UXVmDOZg9kWdqol80AInkXofV8ZJlUnMPqPPCNd2oWif6lFmfAxGDdbFR5wy6DG6hkywYm2X3FZvsk0I49hp94obtXC1xtGF7Ix44W+ayI6hflPsI4xaSZV8HuGhPfG50y6Dw5Yg4li/htkC4KNiejsDwNO1zEJreMJJCM5dLTFO5tXadzej/XGDsQ4T8BdjT/GuCkeZ4odvKpIl994MHjFc4UVv+zIwqh09zkpnZnrXazJwNs3ou7jY0V39aeY0xg7wXVAZeT/E2mV9hcaH6TQrt6Bmrl5kLbiaVFcThNV2dRrCCrjfcL4+V55drjf7xtY1grevQpBd5BNPI8w0hPCNU4EgC9lF7h9gsCWWmeDiUcTCPTgqvR7GVhLyvFmgy8x7yyyIdKaTEoEfLk0r2v84oqENzHfHlaHZf8JHkBpet13Ma4YAwxeNH4vavmvIoyVEQ912wtFzGY1plaPW0hw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39840400004)(396003)(366004)(346002)(376002)(451199021)(6666004)(6512007)(6506007)(26005)(6486002)(6916009)(54906003)(316002)(478600001)(186003)(83380400001)(66946007)(66899021)(8676002)(2616005)(66556008)(41300700001)(5660300002)(4326008)(7416002)(2906002)(44832011)(38100700002)(66476007)(8936002)(86362001)(36756003)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QZJIeKg43bIHxXFeIbn/UWYKvLdGqqJGcVhbdUnc7SJygFKceV8GeSqySWAy?=
 =?us-ascii?Q?MX98KCjMLrqoMbBjU8dIYGq7RDcAlUHWFhPz2MyTXikWSKCuoj9RjbMzbr0G?=
 =?us-ascii?Q?n96DyTuoonfDYevqUpbjp1B7hOwT6YmcZrnTHRFWk6VMDbMPLsGNNqiNX5nD?=
 =?us-ascii?Q?/6+07GGe0MdrvAK5X0RGbXHnEiE0s+h8c2tlUZq9Z0WHG8RXzfAWu2Dz5x2A?=
 =?us-ascii?Q?zhaVJUJvDzyxTXgW7DywmFexNHDMVuex4wXnYB6dTPcN2KCoAsWfcK5GVhd1?=
 =?us-ascii?Q?uSEJiJxSqphiUvVEma9uJMXjjzc1wYBCk0fPtBwt0dVJu2F6/1TkwHWGYZoS?=
 =?us-ascii?Q?pr8l71R5z3SEAUsqJdJ5ugdwBq/PFt78+a0h/L3tPSi4RhPBDH9lSAgbfs+X?=
 =?us-ascii?Q?XeVj1e6xTsFaXKl4/vs6KFGzlDViW9e0kDNvOUqP0zad4WsOuejUVgymstPc?=
 =?us-ascii?Q?IuMQSND62R+lbu0gHPEnQgajJUOjRs6PQohTstL9dy/wLIpVIb88RhVKCBwk?=
 =?us-ascii?Q?ad0vFdBqJdpFYOzTl809UkrlOhnoSFran1CR2RHKcde3yjQ+Hs/3/RpHOaU2?=
 =?us-ascii?Q?B2o4WtNS3ZepKhl4A9qt29/gBQzK+cOxNQBKFoGlO2LmVTEzycfhUH8PBiZD?=
 =?us-ascii?Q?bMW82hC2WoVNrQ5msILA3cqsS7R+yPd1xTLFx5BhzmvgqhtJ8Bq834eunCsQ?=
 =?us-ascii?Q?FzFFLTo90QV6BfGrHOgwsbywPT8wNgdvGjgFOL/GhtPyp5Zh5Fb2PCQh/A3a?=
 =?us-ascii?Q?IygYLvLqQjx18nyCIzYZIdg+83/p1vP4lkukMKIOp4gILClcd7KoaZhI6/fA?=
 =?us-ascii?Q?vdRt06XicbEMII0JNmdIgRsxaA9vJPtI8A4B4QAj+7z3nA4d/zlLR4BcejZV?=
 =?us-ascii?Q?mEt/aDwzzj7x3zY1FcI2Y9+XEV1kOrTJ9cW4ha8Pv2JBeG0ohRBRudlMPxra?=
 =?us-ascii?Q?9+b26lwwAt85Y9Q0iTXZGTlKMNxHnpIdJ8yD83L7G/3Vs5VOg/cx7leSrwvr?=
 =?us-ascii?Q?395O3oDXNaFgMD3G3D2AFIcDTSHes2g5UP1HEo/AhLnwophjZ6ZCW/zchCm4?=
 =?us-ascii?Q?peNXAiw+RnSpkYdMAACjTPC4wC+gf+sTXf9pw1joEy128hBamDyo6nqB7ZRF?=
 =?us-ascii?Q?cHIkHPrhpyjCuS69tFu7lHfRPDHJPwrCiGRazH68kTeemhVDstivx4HAXUfc?=
 =?us-ascii?Q?h5LXsze0u7Q4iDelA7bnHK7avfb0D89JPbJDhnf3Y+XfGX/SH1aUo/+SoCJP?=
 =?us-ascii?Q?qEEY3h4aDUrNZD1Tj4cfOqFTHFjExuEFGo0md64Cpf52TBXTjrSaAC4GN8D+?=
 =?us-ascii?Q?9VdIy283WdMKCk6c/Me5JUoPt+6dVCLwsRGAmTFNwejO7wAZ9A3qKWbuKdvY?=
 =?us-ascii?Q?CIwr8Zjm3yvzXZIP19WOnZtqz6snkaS2Z1gUlgaf0Y1f6LLOgXoBBYaQLhE7?=
 =?us-ascii?Q?ieKvbZ/05G5v+z66ZRs/o5l6Mns0afxaywl10M/h6DLMVwioaCTtN+8xeNuu?=
 =?us-ascii?Q?cFIExouXrVqU/dR/7hMoOXptJDx6UdGkQUvDuWCJS2UHFmxeVKCU+zJykaN2?=
 =?us-ascii?Q?8Kb1+XklVwL0345PRDnO8koF7We2v0fyXtOGa4iecxiVxkIkZBzD1aGgN82G?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d9417e-302a-48c8-7c61-08db309fc5f7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 21:51:38.4712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VnOUiEKc9jLjinw+LeuKwG0eyqXVz7dhZP3aEDEp332NarT3eNZZbfZz0xqOS4TEKKdcwMliaqoy5m794rMGfPMZDd+g4TtmGhsRRgECY2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB4753
X-Spam-Status: No, score=0.9 required=5.0 tests=DATE_IN_PAST_06_12,DKIM_SIGNED,
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

Last note on this before I push up another patch set.

The change from __get_user to get_user also introduces a call to
might_fault() which adds a larger callstack for every syscall /
dispatch.  This turns into a might_sleep and might_reschedule, which
represent a very different pattern of execution from before.

At the very least, syscall-user-dispatch will be less performant as the
selector is validated on every syscall.  I have to assume that is why
they chose to validate it upon activating SUD - to avoid the overhead.

The current cost of a dispatch is about 3-5us (2 context switches + the
signal system).  This could be a small amount of overhead comparatively.
However, this additional overhead would apply to ALL system calls,
regardless of whether they dispatch or not.  That seems concerning for
syscall hotpath code.


So given this, the three options I presently see available are:

1) drop access_ok on SUD setup, validate the pointer on every syscall
   with get_user instead of __get user, or

2) create task_access_ok and deal with the TASK_SIZE implications (or
   not? there seems to be some argument for and against)

3) indescriminately untag all pointers and allow tracers to set selector
   to what otherwise would be a bad value in a particuarly degenerate
   case.  (There seems to be some argument for/against this?)

Will leave this for comment for a day or so before I push another set.

Personally I fall on the side of untagging the pointer for the access_ok
check, as its only real effect is the situation where a tracer has tagging
and enabled, and is tracing an untagged task.  That seems extremely narrow,
and not particularly realistic, and the result is the tracee firing a
SIGSEGV - which is equivalent to allowing the pointer being invalid in
the first place without the additional overhead.

~Gregory
