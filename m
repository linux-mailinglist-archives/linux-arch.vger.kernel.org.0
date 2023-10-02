Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03D57B59C7
	for <lists+linux-arch@lfdr.de>; Mon,  2 Oct 2023 20:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbjJBSDy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Oct 2023 14:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjJBSDx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Oct 2023 14:03:53 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8B09B;
        Mon,  2 Oct 2023 11:03:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePOgtnG3EOPkGnXA/ySSKMn3ofu6m4kVuynies93FxwGsmXOk+jpC/ZxjKlrHUplPbUwfRUesxoWDotd3viPeFCg4aFI7/A9Fw1RycZyrkBCTkWyVJN1opQgbD9QICtJjoVoABUVGZJxirb1J+t3ILtbGbMKwg2vhosG9vHFO9yCVFC6MwU+Ti2CGR+qzvdChp/DAFWgcaV+sPWYr3EjunjH67E//pjnuLq2HY1hgcafbKIvS9cidONrtP5X7ZyMeje0b7/381B8nuOH7joz5qnyHgeSTBwZBnpdi+jbqwnIS4vTb6m3xp8KFjhRlPAXEo41uxy6dzFLnV6Id2xUNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZzHEyicg5uHdRB9wUAyJPXLxM6t5Fqd3do55hO5pqE=;
 b=E6eaeA0eno+50XuXIc3qTVBaOizNPkrqLXQ1FNGzVwnzUplYyddiPm5IM4FQDkMqPEdqTJqoYW6J0a7yrP9BEBIkCZtcSjBjEsmGAANI2+vQtmTFwYy6wM2TkXV61NWrb4DF6ofKprPrsOlmSyIg4IGAIv3BcTaKA++wQYHQ425TXMvP3KF9oiUqjPMfxNAg5fvdUiiJ60X9eJq6181rU2d78Of4XlQEw8SIFV4o7bm7GXb7gFDnaSiwvfHJppPwBbz3cXu0BICareUXWGrc3cuAnikifU+tqjFXYJ/D3H1PrWQ02tRucqNzdqj0RzqJ2ycDw481JCOOqDMgp96sLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZzHEyicg5uHdRB9wUAyJPXLxM6t5Fqd3do55hO5pqE=;
 b=QF9c2ciA+5sjIs0k5FHSkozuC2K6wX5bBJkY+SdDWdLsj+ppvanIq7LmLsQK1ubKR4malnJlE22EOMTQO3ReatI2jR8hgAB7WCB/k8qjXnBG18DWaJ0/+YkP30rXK6pbmzSVDtSCHlySEZyvbEU+QpioT9fRuQnqz6tEf2bmf64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by IA1PR17MB6599.namprd17.prod.outlook.com (2603:10b6:208:3f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Mon, 2 Oct
 2023 18:03:46 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5565:d559:61b0:e2df]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5565:d559:61b0:e2df%6]) with mapi id 15.20.6813.027; Mon, 2 Oct 2023
 18:03:46 +0000
Date:   Mon, 2 Oct 2023 14:03:41 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        owner-linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-cxl@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, arnd@arndb.de, akpm@linux-foundation.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 2/3] mm/mempolicy: Implement set_mempolicy2 and
 get_mempolicy2 syscalls
Message-ID: <ZRsF/ZoYXH/77XH6@memverge.com>
References: <20230914235457.482710-1-gregory.price@memverge.com>
 <20230914235457.482710-3-gregory.price@memverge.com>
 <20231002143008.000038ac@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002143008.000038ac@Huawei.com>
X-ClientProxiedBy: BY3PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:a03:255::10) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|IA1PR17MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: 21bb8ff4-894c-4ee1-596e-08dbc371eb6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lQtEida4Pv9CNFNH3R+qBDDvseffe3NpwlWtUMeDb7GZYNjg08MoqkhsVJWxJFjl7RYmZmtnC9DW/uj1Ropfm02eJ/h0BCY8LguLA2VS0y3EJK/KYLp0h743vnRATe45Mcp2XFhExPNIVrXPeVl1/amqMS7dZpGachM1dZEdQAJhyEBmWKYqKD5nAZU7lur0AJueK2aazxuvKom/kyQTS/4CUMTle5UVyTtu8PWSsIEQUpC9v7732rR/qc6msVlSn9ujW6H8gUXFoEWYdpnK25MUFdTh8c0y8A1dXVx+H/NDmpOT8ym3/hbIFaYsBqpk5hGYD165fjhXRzKEvwZSFA4bkK8NPkL7zBXeMXln0UYljI5pzd7CJlqpwiEChUNXgadzbXZETNii1Um12u5XuExHd33MDRcZ0jpgKyy18M7wU/StYqgCbixciD+4c0VXfTySy/LZna5/UBYBcQPIQcL2ibgPujJIs78YyUECzsCozFLWyrfxEtOkSTshSfqflRNbxJdNpl4LHsbpAYfrwKhWrze2mF5MNnZJHinMPG1LXO5Xo3PzfgjdpxBm0i6k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39850400004)(396003)(136003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6666004)(478600001)(6486002)(6506007)(38100700002)(86362001)(2906002)(7416002)(41300700001)(6512007)(26005)(2616005)(36756003)(66946007)(4744005)(316002)(8676002)(6916009)(66556008)(66476007)(4326008)(5660300002)(44832011)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a6jQeJXHkf+s0K8X1ttvlhz0azK9nRhflnDBSCnKm5PsAUcTvyNHTdKKQ6ue?=
 =?us-ascii?Q?bXrhd/KY+2n9QyVO0jXrs31wWrJD+/5KCf5uqo8hGl5F9+Z/r7Rbv154ko+d?=
 =?us-ascii?Q?f5/GE/cXbQ8gHNRI25lhm8wD8JAziM55E9eu85YAnvEk9vADO61jeIxlIv5S?=
 =?us-ascii?Q?gBmCsgrHKP0nrXBG7caTAkgP2yOFd8JSw2kYiD+a/vAd5gLyKgqRkVy8NzEb?=
 =?us-ascii?Q?uioS5clWWA6WKIXuFjFlj0x2j0vPuNDlObGMfXjbu4yzE6wT+3MoA2RsGgnx?=
 =?us-ascii?Q?8oWYfXt5X1HAZ3Slint4+vyO4qCqvnAlht0MQxOEKkQtJzqoRsGbSwsmLsMi?=
 =?us-ascii?Q?ZpkeG10AKTBZ4XQzH0u9Tu+XA3DPELPjYVrgccRUOb7ClZZ5mQHF/HjgDmQt?=
 =?us-ascii?Q?eB/PZq1tLWcQfY0BP/vcqytICjL0jXSLdPmRcxts/sywf0apVzMjZBK3wVR6?=
 =?us-ascii?Q?4hYVVicwjH4ZySECA3g/SPrlRg/o/80OSoO/fZanSAY4vCL2C6RRdG81dM+z?=
 =?us-ascii?Q?VlMHdz/x4lr8N/LrFtGTgrbQgXyiP0LYYVYbGeyTqBQmonm38t0e3sWESkA7?=
 =?us-ascii?Q?Jtew094nNfpkRZBa6f9T/DHvFHowJHUNdCVY+zzg7ffEmx0DEfLH3vXgV7sn?=
 =?us-ascii?Q?0T34OS0N24cx7Kqe+diRsuyTFDNDJ4KHoEvZJmmXj8REO5M27KR3RmhVMTLL?=
 =?us-ascii?Q?7UQYDhSLuAlmi07nv5df3N3klWLnGwpBBtIPIzOK9kzGXZjomRS/ULCgetJw?=
 =?us-ascii?Q?rJ/1i4rKKbRhzYK7a1yMiES0T5Dfyr3UHYP7be5VSMxrNuz47GtUsxOxwjAG?=
 =?us-ascii?Q?7uMfbEWILjkfWUygMRBUIOHZe9HNCxp7MdLGfDxlf+VwjcqsxWF0JBR/qGRH?=
 =?us-ascii?Q?p95o98QkvajU/SstAL4A9y3G8aeMI4iv8BJqO86flXw+AywlPplpyYPndoR4?=
 =?us-ascii?Q?gOuezqDjWdZ8LdNL9rl/RSfureW1bDJjU+dZz4C2J0YGkXRogrh71Duj/7wK?=
 =?us-ascii?Q?6stnf/Sg4N2xfXgMY3IoIpx36pbnFLYtSlxeCLTNxvXolMuE0aXYWdfNO3by?=
 =?us-ascii?Q?YyQe8e4YyFxjXRuKsff0mzZAjQ9tpxO5oaEt2grOSWrPJIGLgFwBqay5XxKZ?=
 =?us-ascii?Q?tDt9ZJ4Y0TCdiWB9FaCyd+DUmaR4z8UZvK8PIOXVBI5pJZ+6KMTO6S2K02nL?=
 =?us-ascii?Q?ORZITkTyKspYLvNQtpSMliMwv6Gw2nixFxkFXkhh13m1YF5UJZsKGCKnCyfa?=
 =?us-ascii?Q?tWLZaAzhg2NPfTJ5AGGvNmoukfB/3HciVOxwTu42dzWqOJqpew9gsL4Eeppa?=
 =?us-ascii?Q?MYskHKJfOmzEfN1XMRSNXIolLgD5829svk5b5VdvoZD2crhgfqVYUBuJahee?=
 =?us-ascii?Q?9mbXbAQGcTgAmEeQX2SEW0VUMHoRO4bPm4zm5nez/32RziUXooI++E/tFoj7?=
 =?us-ascii?Q?lpaWbKUq0Dbci00D6ztrPHb26c9mjwxk5xSntSbDoClNIHMzQpqDfWsGAiNE?=
 =?us-ascii?Q?8SFLuCGO0uuxjYRbUTz1jGq6yHwFgUsqH6F2aY+qtB+OExNR32FQR6mLTk8l?=
 =?us-ascii?Q?Hf1pbNtPffBWteyMMl8x9kYHNioa6s/hm508MTNeRVJ3Q9QHmLc9RZff1sJW?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21bb8ff4-894c-4ee1-596e-08dbc371eb6f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 18:03:45.3978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KHi0IR0gRajb0IVfj/q3UoYDR1KOLmuGS9VDqAW7tF/R4xjHWKxkx3hSEUf5z9XF5Ie8ZtWAbwSUSLgCn7ucwVL94/bygv+9gxsQjeWUkcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR17MB6599
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 02, 2023 at 02:30:08PM +0100, Jonathan Cameron wrote:
> On Thu, 14 Sep 2023 19:54:56 -0400
> Gregory Price <gourry.memverge@gmail.com> wrote:
> 
> > diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> > index 1d6eee30eceb..ec54064de8b3 100644
> > --- a/arch/x86/entry/syscalls/syscall_64.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> > @@ -375,6 +375,8 @@
> >  451	common	cachestat		sys_cachestat
> >  452	common	fchmodat2		sys_fchmodat2
> >  453	64	map_shadow_stack	sys_map_shadow_stack
> > +454	common	set_mempolicy2		sys_set_mempolicy2
> > +455	common	get_mempolicy2		sys_get_mempolicy2
> >  

^^ this is the discrepency.  map_shadow_stack is at 453, so NR_syscalls
should already be 454, but map_shadow_stack has not be plumbed through
the rest of the kernel.

This needs to be addressed, but not in this RFC.

> >  #undef __NR_syscalls
> > -#define __NR_syscalls 453
> > +#define __NR_syscalls 456
> +3 for 2 additions?
> 

see above
