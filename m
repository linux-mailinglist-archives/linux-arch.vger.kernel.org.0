Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643366CF15C
	for <lists+linux-arch@lfdr.de>; Wed, 29 Mar 2023 19:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjC2RrV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Mar 2023 13:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjC2RrU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Mar 2023 13:47:20 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9105254;
        Wed, 29 Mar 2023 10:47:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncP1XdOJWFPJXckYvD2rVT7aEab8FxDmV3eLSSs83azHJaVoB/Qiuthx2TMHDip9NGosp5pNVanA1zgwuEPUWCDkKG29DP+XaetU+//5W5vzsunNZx1zHnnvWCaiogPP1WYOT8Pcsv+cawBEzJespD6OVbC0RY12q5FgpWeZtg70tvlz9XRpZqE85mkxnvBbKvU34dpUinPnOwcfwZIRtD0krn3QihViZqM9UUMxueMAGf8IlC4DTMQne98zFmdPfuQbuDctqij0MiQmLUqEuSXP5iQMG80HWUqWLIjQHOBh997leXwB+ip4a/6X5RxQZcowbpDaRypZFZsNaBi9eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+H672fmBLWuVMAkYCy9KGjxIebb3h3al54gNOPVw4Y=;
 b=PSJiaDd1xUUjrdQ8qbEf9CaAY7zvXxk/mpyMAtKhoq+Z4i+skp/jtFQkxsRGa3n2HPlshgAkHXRrOYArCRBr7aVnC60XslEM32CHZQaXU3OC4zWgW6L/ix7dJMR5+MPSTPxGWU7Br8EWLjJWRdC29lz0RHorr7eyXBvYXtFPFIVKwI2g5WLgS0nBHX5Twc5V9mj7Ml+klLMpxH6PzQXpx5UcRxXcknMmyKNRjnSIVgcr0v/LZFMVaBgSJeXNuGIFCTfqgL/U8dImHE3Z6J1elePzpSlfi6+CfVNa8zD6q1kWYAClmAkfJvEzsg0iDdz8v1eckxAHPLORW++ri/0M9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+H672fmBLWuVMAkYCy9KGjxIebb3h3al54gNOPVw4Y=;
 b=yc+8Xhkqit/V59f37Y8HYaRhi0jXUlZZy0VQINd9uRBr0yOeVNA8mV9Ff5Tp3Z8X2rntg7UleK4xQz6h+UNtZboddqFaUdEsHSTksu4iVV/a3E4nEqCKHLoigVqI/E7tKVtZKBVUlOErbdIBO8zJ6D0DP2ImMzijcAFmAoCSMN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DS0PR17MB6231.namprd17.prod.outlook.com (2603:10b6:8:139::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 17:47:16 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%5]) with mapi id 15.20.6222.033; Wed, 29 Mar 2023
 17:47:16 +0000
Date:   Wed, 29 Mar 2023 01:37:40 -0400
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
Message-ID: <ZCPOpClZ3hOQCs7a@memverge.com>
References: <20230328164811.2451-1-gregory.price@memverge.com>
 <20230328164811.2451-2-gregory.price@memverge.com>
 <20230329151515.GA913@redhat.com>
 <9a456346-e207-44e1-873e-40d21334e01b@app.fastmail.com>
 <20230329160322.GA4477@redhat.com>
 <ZCO20bzX/IB8J6Gp@memverge.com>
 <20230329171322.GB4477@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329171322.GB4477@redhat.com>
X-ClientProxiedBy: SJ0PR03CA0210.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::35) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DS0PR17MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b83c461-3d78-40c8-9b55-08db307da292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1thSsfIW/mpKg+SS/dDU7ESqixwQ6Bs4Tral3qlZkKhJg9pwCRP4B5c3T1/w4P08W3DXjii1OfB/07fO52J6Jik8nN6r9AGcunC/tyXwFzWFa83bi+HGnimqqY/OYFIcSQmeVD8w0O+2ZUKdCqxCTyNt9FMhwy+rur48zsWtP7V5mVRVhXMXSF/Qpj2uFtBw6Lkz4Vrn6ff+BKv66BN5MA4GZQNGVgeD+KiTs1p4MT/VlDDhtDz42KTyb5Dd3sqme5XIg5BnMx8gMM1qMwhGdxC4rmOj3azUV9gT5Ax24Tq2b8zQ9thtjhBHLGgEyPGFT+porA/WdDfNaNbYpQwUdI5tR8ou/m0VIl+06gyyBDeyn+iZeMAjfZFiRI5+uuIyKWIzqDXOvEQNtoz1jWXsyLCzF7NeMSmMOLGfpCeocovUnFWuI65RPywCM8t7RwE51q3DCSk26pgvg7Kw+6ET2FsNes4fXhoj4ml+qMIcGgyr/lnKLJw16meK3dSfiltPO7lUAqOfkNUI1fPsLOHnOSkypYuYeX4evVJtWppqRXKj1rD3vGyzLoRYMnHgWeThq7ZkfWJ3P7ucZl4zr62r7u8TBYonAAj/HWkJaynEcX0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39840400004)(136003)(366004)(396003)(346002)(451199021)(38100700002)(2906002)(36756003)(83380400001)(44832011)(7416002)(5660300002)(8936002)(86362001)(2616005)(41300700001)(6666004)(54906003)(6512007)(26005)(6486002)(6506007)(316002)(478600001)(4326008)(8676002)(66556008)(186003)(66946007)(6916009)(66476007)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IL0QseYVkM5e6JAYqnGj+8V5a+JBlDBl9d7vgeJ5Fa26s/P0YuoghxjhrdWZ?=
 =?us-ascii?Q?qudVv1pMvPePpXnSyrfUVf7jmUinSzHCKsZAK9DdwFR7f24GT1/J4Ix5no1G?=
 =?us-ascii?Q?aHK+RiBFMFg4OHBwIpyWfKrByyN5OvnZ0xtk/7Su59a+iCi5r5oCpHXu3qwi?=
 =?us-ascii?Q?x9fCrEOIBNUCG9TPUrrZWntkpL/FKrTXxY60m+T19dW0V+7hbttsU6gNGTNL?=
 =?us-ascii?Q?VCyiGKQ4TCdvtRfY4MjnFAaUW2wyGGHmKiz9Jg97VCD+Gk7KwQGN7F84Tuot?=
 =?us-ascii?Q?FH4Kfw8riOnKbYc37FoQBAM15Fx9bxDkfsQa0QyQTv+JZKZUBwTkiPBTKx3j?=
 =?us-ascii?Q?LQv2vA8VWhe8mtklc0JoVrOslycfRz0q41p4nA7W36xvIt5iLZerAT5Hc5JP?=
 =?us-ascii?Q?iVttfqGBWTCzXg4ElC4wZM5+RY5e84EwQEmx0DhzyNkPAzFkprmmVvqUXpim?=
 =?us-ascii?Q?MPHlswKw+eFlTS18O+Nz/8gdAarh1LLaubqE7IFfe+LpwzOwEchLjA7ZbGCo?=
 =?us-ascii?Q?Refp/+LIUiW0f0If0HR2nRhCbacZdArFWtCdsYqhI96qX8bK1rzqnBTQ4ubZ?=
 =?us-ascii?Q?yppA/bdYMRQEO0dB8ISb2mVTeBVkBqonJA+2yloOyKuhXAAPAYrB3c5MecC/?=
 =?us-ascii?Q?AuDEdA8jUHGvcAsmhhoGdxwOeLmY9Xbig92zczm7LR2imC2ZWL/odT4mKyQQ?=
 =?us-ascii?Q?utS+zGKsFc9xlHHSc7wchgJBFDXhcsP4dJH7ALTTG5xNK6nhpJyMoLum1hLi?=
 =?us-ascii?Q?a7Fgh1SA8bOvDsldXLoyrU50Q5JweaK6+7erzN0gcRtceKc+1LpJgM3hhzdM?=
 =?us-ascii?Q?D7v4lLaoPmyHhttH8jDnkX28I2X3kRMBWe8VLWFcAutkA0Zp28QRy4fL+MIU?=
 =?us-ascii?Q?avgpEvVa67eopIk1mdTTbBVncKJPAZz4iI/toCK+MTanisip3izQaRCmTVK4?=
 =?us-ascii?Q?/LpSGVC0z3WocY3nVhkLm4GeduUUmYjcQ1njY0jK14TL+hQOCwtcUcQ516Ra?=
 =?us-ascii?Q?B5vE1Q2IT4a0Em+7d5uhAXVcsgWpa+SEZemQLsMVaNVdRAXuWCcrw8+0s3Ll?=
 =?us-ascii?Q?OYn9vY18Bo+n5Q0+EAx0ODDJmWifZrRnESzSR72IiVQKoND3DOvXV2SGd7sp?=
 =?us-ascii?Q?KWlv+lf5NGI5kHpSyfduYK17/uEiviiwqsbjMFFrGeeQBP8PJl6TJZKlzLaQ?=
 =?us-ascii?Q?wLuYcZmAD1nodjPBx8BzINhNQylAfSKo9n7TSOFC5MVJkWhmj8FlOoSgEbig?=
 =?us-ascii?Q?kGEDrKr5efuwFVoYLKWKUxWyxPCt2Xa+2Asd9U59nBoNxwcmsnA67Al7tPTE?=
 =?us-ascii?Q?kuisjkMjs0nqvDOzF9Dk96vjOQ7ITRY8/ItILViZivpfM2IauttAzqcXiXz0?=
 =?us-ascii?Q?6LULultzvMP3sE1hZpyUyxC7hNA50TreREY92dHvTGJM3F+l77SXuvqSZnAn?=
 =?us-ascii?Q?PRNBt/SvHIdrf+BWUECaQzx4MAoEMhVfT69G6mdA4KjDVzpOIMqER5kfRr8T?=
 =?us-ascii?Q?zt+03zPSbJ2RaOdvv+4V6GXwPp1jZIoEp1VaLjvLDkdwB+SEza/O6wbVNNtf?=
 =?us-ascii?Q?OZfcVmQ1GlU4eNynUyCwHCqp+Q0k726yE+5AYx9vfWfKbLqXfLFr72noPwai?=
 =?us-ascii?Q?mQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b83c461-3d78-40c8-9b55-08db307da292
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 17:47:16.1873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22wLxO0vdCUDDEWihdpSyZW2BnACHZarOkKT/4Kr4zMagQsok31J8wCh72zEkOWj/8hjIfWW9jGt4+K4dicYdYavwBOXo5eacwFkh/bUYMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR17MB6231
X-Spam-Status: No, score=0.6 required=5.0 tests=DATE_IN_PAST_12_24,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 29, 2023 at 07:13:22PM +0200, Oleg Nesterov wrote:
> On 03/28, Gregory Price wrote:
> >
> > Not sure how I should proceed here,
> 
> Can't we just kill this access_ok() in set_syscall_user_dispatch() ?
> I don't think it buys too much.
> 
> Oleg.
> 
> diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
> index 0b6379adff6b..d2e516ece52b 100644
> --- a/kernel/entry/syscall_user_dispatch.c
> +++ b/kernel/entry/syscall_user_dispatch.c
> @@ -43,11 +43,7 @@ bool syscall_user_dispatch(struct pt_regs *regs)
>  		return false;
>  
>  	if (likely(sd->selector)) {
> -		/*
> -		 * access_ok() is performed once, at prctl time, when
> -		 * the selector is loaded by userspace.
> -		 */
> -		if (unlikely(__get_user(state, sd->selector))) {
> +		if (unlikely(get_user(state, sd->selector))) {
>  			force_exit_sig(SIGSEGV);
>  			return true;
>  		}
> @@ -86,9 +82,6 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
>  		if (offset && offset + len <= offset)
>  			return -EINVAL;
>  
> -		if (selector && !access_ok(selector, sizeof(*selector)))
> -			return -EFAULT;
> -
>  		break;
>  	default:
>  		return -EINVAL;
> 

The result of this would be either a task calling via prctl or a tracer
calling via ptrace would be capable of setting selector to a bad pointer
and producing a SIGSEGV on the next system call.

It's a pretty small footgun, but maybe that's reasonable?

From a user perspective, debugging this behavior would be nightmarish.
Your call to prctl/ptrace would succeed and the process would continue
to execute until the next syscall - at which point you incur a SIGSEGV,
and depending on the syscall that could mean anything?

Everything feels bad here lol.

~Gregory
