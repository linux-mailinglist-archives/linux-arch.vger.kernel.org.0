Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8929A6CEFC1
	for <lists+linux-arch@lfdr.de>; Wed, 29 Mar 2023 18:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjC2Qsj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Mar 2023 12:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjC2Qsi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Mar 2023 12:48:38 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2489C4C2D;
        Wed, 29 Mar 2023 09:48:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0kvZp6fM2lKRt+m0jbaRPBfyqm2cCik9BUxjDqt8PMFPnIrpR/KlJ3sGf1rOJXbhSAgxx1eJiW4/jSjH+hrigWVV6LK8I0ViVS9GhJFKK84ByPG/DfG5kR/W8/Ak/XwDtrYQi7WQM2kKpt9ck5yc6EfvAjEx4x1Sf1jCrxUv2fZEbQEyO69KdwDPUpt+cLOjn5DivXXMkgydOIlbU4UVJQd+5ZAJv+rD0qXCSZy/LStCor/EUVlIIrnSjNUZe3hKSz/FVPFqDF1+qzWbznsILdOtXveMpLef6jN1xGTvef7XSOoKuDZ2iWx4SBIEx+diWVpbMb7vwkiePOkm9Ho5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4s4qp0TRdXmgvY2tGBbT3lZIGHVrs/F3SjbaOehEQe8=;
 b=R8bqMZdTTkMaSG8BC9fl3PIcIEOdr6HwbPl+zNxyNEPxi2/yZdEJMmdyTweVwo0f9euOpN8zOEx2fCY7A3vILdGlEpqgstpwSZJZBGzRRhUwO4xxWsgAaXb3jK5SXSDEPFFTbiTeB44c+d7WqKs8Wps4mGtNCAbxC0kjmwBy85ccBCsNtD32Y8D+RRxCZTZySVJKhPhKkUL54xVqTKq5qYte0TxCZ51gPKc5AXgyDXtXXnnyHQvQ+ujmJPQ2mvNtWCfX5HR9jTMrRL9TO6L8nPROl09gVGxw777AG+pDYkOeaGY7/y/1duikjFt0h1CowilwadTdpB2t8FofhW+fqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4s4qp0TRdXmgvY2tGBbT3lZIGHVrs/F3SjbaOehEQe8=;
 b=B6m8ZWNrb9kAyfmhvtFrDoMeMnZ+5OtzYWu5Uwax4m/vONukGeYLpHTV5DJKdgTAGiLYbXIDwv0TNf2DkdreAGulYH/rnwwfH6S2N1NW7vsGJwFJ5GSKkrB4VgTuS4eAAYvVvGoeAJXsSCgXHtB/07lCriPmcBR2bqR7eLpNq5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH0PR17MB4263.namprd17.prod.outlook.com (2603:10b6:510:1a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Wed, 29 Mar
 2023 16:48:34 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%5]) with mapi id 15.20.6222.033; Wed, 29 Mar 2023
 16:48:33 +0000
Date:   Wed, 29 Mar 2023 00:34:04 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        oleg@redhat.com, avagin@gmail.com, peterz@infradead.org,
        luto@kernel.org, krisman@collabora.com, tglx@linutronix.de,
        corbet@lwn.net, shuah@kernel.org, arnd@arndb.de, will@kernel.org,
        mark.rutland@arm.com, tongtiangen@huawei.com, robin.murphy@arm.com
Subject: Re: [PATCH v14 1/4] asm-generic,arm64: create task variant of
 access_ok
Message-ID: <ZCO/vNYlGdwthZX2@memverge.com>
References: <20230328164811.2451-1-gregory.price@memverge.com>
 <20230328164811.2451-2-gregory.price@memverge.com>
 <ZCRl2ZDsNK2nKAfy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCRl2ZDsNK2nKAfy@arm.com>
X-ClientProxiedBy: SJ0PR03CA0274.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::9) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH0PR17MB4263:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b2dbc5-96d6-43ca-d403-08db30756ecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RbChvIVIvTeSh/qiJvrddZKddP9YaAQ/+xhxpHAB2KpQViVGxJiSW8XGEgqdHB0CgvHDRBzxqpz3aiawJf3PBdJPn+wrZzjPCt7135Hk0x4gWKsf1ZdQkSr2xMS2Kbs2Svv1FJGK+N0/m3DAOPa1wPlrhZJ68aLQK5aSIv3B8x46NtnYTdB3aWwOnjvnLLBlIA39/mojSRwT2o6OtDs5lYt55L7nsNDhcp03IByYLCraOLZrwGApEri1ePqTmmpx+257poJ+4xcaU/wN4XI4LdRBkIiZIjMqpq5cRAOmsF7alTDTjIUzQMV9TZzaJZqnja/Pp2IalmhJFA2C5rvpOaBOcn9/LVvuJgIO8cCwSjJcXRSBW28aJkrYNJGIhvcutxYDw7+XJlwW/8h7L+thyP1JsDVVTRs7lxOCu+13ru+qg6knBWzkjT2MShU9lrEXgUMra+E6Snm/W7a4GYsI/Tt+iUIIn18KxCMST6pDzbbiYdYrqEwHmeZdMlkwjlSnP96yhXpva2906zsaN4SB71+A6Ld7fwnqItHIA63p2bgNMVxDbexCMmMkQZ9/Ntif4mE9JesSOxLIV0WA0jmsySFTt02YWCoqbBc54gPXTZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39830400003)(366004)(396003)(136003)(346002)(451199021)(66476007)(6666004)(6506007)(83380400001)(26005)(36756003)(6512007)(186003)(966005)(86362001)(6486002)(4326008)(5660300002)(8936002)(316002)(2906002)(7416002)(38100700002)(44832011)(66946007)(66556008)(41300700001)(6916009)(478600001)(2616005)(8676002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+WD7C7IwKontQEoR4l933EbPdcz5wqYJKSAwQdP36hVaEtwqY90iKk1YyM1G?=
 =?us-ascii?Q?ebe+bc0YnE0/TCvO9to5egFJwDyiMVqxlheVjIN9Srrfi/twmTfVcWIntEFb?=
 =?us-ascii?Q?4ghn+F8KF0zuePGUuvCIeWHBKq+EKDRtCUO0mkXRbKiPU9eNGY4zmYAMMzH2?=
 =?us-ascii?Q?V8C+GwyNNEUoj4DXjdiQGQOVuepYHo806VdqNQv3QlXPKHTv0A4yS/piHppS?=
 =?us-ascii?Q?XIfhRT67oLU4gQLZY0KbkLlFbe29NW11yx3oQZMbF7/ftCaavsCd+KRzaet1?=
 =?us-ascii?Q?jiKIwz5DQzsBPIFLYf+Ctb/sGxh2qaDKs52qFe0FRn16wupEn2bnHJ5K175O?=
 =?us-ascii?Q?U0MqpFP/9ggsSKqLkz8etnR3+cH6CYLtvK3X2XtObUUGykDEetcoTYVkKEoG?=
 =?us-ascii?Q?DoWF8ikPw9C23/4HESgLBSB4ZoSPb4vSFzJz+Lw5jSto7DxNlcJtkT/sVms2?=
 =?us-ascii?Q?9IByjF441gtbVZM/rPGtngXJVLUOm67QkRDeY6W+NNGsUHXKFMDR8+5KgT5O?=
 =?us-ascii?Q?0biU0bBvJiv8JXaEraIvcG2nvyp6q7KiLfxaHh6YaWhi0D/4eNB1rfZ+Jtzv?=
 =?us-ascii?Q?8Nq9QhvbWtiFL0jT8DkQN8x+T5kTTp6OUry/mTziJ9qzBTd/iaHi0L4qzi1T?=
 =?us-ascii?Q?eVRTSlWOKILEbd/I3j7pIa3ycC9uXJqyRrQYbBoPqbQgYDus9eThILIk5khF?=
 =?us-ascii?Q?K+dbfmvk1D19Al/A8mCYeNpkWPMyRZngG1+co8H2lIlMLnyvXdd6Cg47VN04?=
 =?us-ascii?Q?7oSp3iefl21QlHVtXMrjhr7fQt3rCBjykRVT6ehvGRJa3kuaU2xfWed2Ivd8?=
 =?us-ascii?Q?7dk6G4YvJ/W8X3ASCWWhviyd+D/5Ip/08m6m5iQ2tQZ7yEkM3yJlzpuWg1O7?=
 =?us-ascii?Q?Be5e95rHbQBQysE8m8n+Ckfi/PTNvNNHDr4QTvK96UoKiVFGL3nkq3NA0Vfu?=
 =?us-ascii?Q?a8jNJg8Fl+2ZWzLm0mbNJrDuSBLkfsDpHUSH3E2B0Laaky9IqlZSDa3iL/vd?=
 =?us-ascii?Q?sj97OBtmAAawNCvjchNAF659cyl8fgyItxWy9XxbvCDIoK2orgUa4DT50vWv?=
 =?us-ascii?Q?q8IQQJinN+X1TFcAUUEWxtdrZlgz05uXNZDvVmD7xL6ntbkBrJ8oSQgi0orI?=
 =?us-ascii?Q?hRXhbE1Qu0LthsIWg1QgrIT+8RUvboccuggBDUEtZ7nX+kwSZDNxRubVtpcM?=
 =?us-ascii?Q?K6MHAtxx+gg8LKzcMqRqnLwbxmPl3HbK7zQz70evItmeg3wZ2nn4wQ4Jbnvd?=
 =?us-ascii?Q?TRFm/YS0wtSEWlBfAf3Q+n38IrYu2bCe+NY2eqMNnHmvjsC2VJLzsOJgoDPA?=
 =?us-ascii?Q?dZzI85tW0P6iNgL5nmCovYqtbitoRJO0jeTVL9PzMPvFXN6Fa4ygqq+IJe4t?=
 =?us-ascii?Q?hD3U8aBhgPUHKVBQACbNYdIjeQ3dPQraIUJ0TmIrjt13neKDBUoUBl92f3Gv?=
 =?us-ascii?Q?GwB592J7P5pVT9ynxXV+bl0lNXaL1Mk73A3MYMavVOTxqvFOH5hnGnYVq6XZ?=
 =?us-ascii?Q?F93VsIaQDx+On6HzKvIqQ2zXERDAApQUO6DkkOlcVD1rjHcikcRQXmKmD7RF?=
 =?us-ascii?Q?TVHZ/KsISmU+cd1lx0EPRUP33nRreRk7gtI6FIOW+FPyEkCBj4ssidiNbIjI?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b2dbc5-96d6-43ca-d403-08db30756ecf
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 16:48:33.7258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ai/UGV3iyn9Ob7C0K3lC9wH+0JOvY/UiI2ovf++JL0A6KADzbec+9JeZ4shS+iQhIflW+dA9B+hMhWdPS3qHg4PFudT/Ym/xWz9m+dkNwN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB4263
X-Spam-Status: No, score=0.6 required=5.0 tests=DATE_IN_PAST_12_24,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 29, 2023 at 05:22:49PM +0100, Catalin Marinas wrote:
> On Tue, Mar 28, 2023 at 12:48:08PM -0400, Gregory Price wrote:
> > diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> > index 5c7b2f9d5913..1a51a54f264f 100644
> > --- a/arch/arm64/include/asm/uaccess.h
> > +++ b/arch/arm64/include/asm/uaccess.h
> > @@ -35,7 +35,9 @@ static inline int __access_ok(const void __user *ptr, unsigned long size);
> >   * This is equivalent to the following test:
> >   * (u65)addr + (u65)size <= (u65)TASK_SIZE_MAX
> >   */
> > -static inline int access_ok(const void __user *addr, unsigned long size)
> > +static inline int task_access_ok(struct task_struct *task,
> > +				 const void __user *addr,
> > +				 unsigned long size)
> >  {
> >  	/*
> >  	 * Asynchronous I/O running in a kernel thread does not have the
> > @@ -43,11 +45,18 @@ static inline int access_ok(const void __user *addr, unsigned long size)
> >  	 * the user address before checking.
> >  	 */
> >  	if (IS_ENABLED(CONFIG_ARM64_TAGGED_ADDR_ABI) &&
> > -	    (current->flags & PF_KTHREAD || test_thread_flag(TIF_TAGGED_ADDR)))
> > +	    (task->flags & PF_KTHREAD || test_ti_thread_flag(task, TIF_TAGGED_ADDR)))
> >  		addr = untagged_addr(addr);
> >  
> >  	return likely(__access_ok(addr, size));
> >  }
> > +
> > +static inline int access_ok(const void __user *addr, unsigned long size)
> > +{
> > +	return task_access_ok(current, addr, size);
> > +}
> > +
> > +#define task_access_ok task_access_ok
> 
> I'd not bother with this at all. In the generic code you can either do
> an __access_ok() check directly or just
> access_ok(untagged_addr(selector), ...) with a comment that address
> tagging of the ptraced task may not be enabled.
> 
> -- 
> Catalin

This was my original proposal, but the comment that lead to this patch
was the following:

"""
If this would be correct, then access_ok() on arm64 would
unconditionally untag the checked address, but it does not. Simply
because untagging is only valid if the task enabled pointer tagging. If
it didn't a tagged pointer is obviously invalid.

Why would ptrace make this suddenly valid?
"""

https://lore.kernel.org/all/87a605anvx.ffs@tglx/

I did not have a sufficient answer for this so I went down this path.

It does seem simpler to simply untag the address, however it didn't seem
like a good solution to simply leave an identified bad edge case.

with access_ok(untagged_addr(addr), ...) it breaks down like this:

(tracer,tracee) : result 

tag,tag     : untagged - (correct)
tag,untag   : untagged - incorrect as this would have been an impossible
              state to reach through the standard prctl interface.  Will
	      lead to a SIGSEGV in the tracee upon next syscall
untag,tag   : untagged - (correct)
untag,untag : no-op - (correct), tagged address will fail to set

Basically if the tracer is a tagged process while the tracee is not, it
would become possible to set the tracee's selector to a tagged pointer.

It's beyond me to say whether or not this situation is "ok" and "the
user's fault", but it does feel like an addressable problem.

Thoughts?
~Gregory
