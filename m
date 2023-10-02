Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B99D7B569C
	for <lists+linux-arch@lfdr.de>; Mon,  2 Oct 2023 17:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238118AbjJBPbF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Oct 2023 11:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238112AbjJBPbD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Oct 2023 11:31:03 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BBBDC;
        Mon,  2 Oct 2023 08:30:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2rszhlbya7MJigbir+2EuyC4f12+6KEQy+ysHw9VEs4og3fKy6/gLknPt7rzWhTXuodKpS1V8/lkhEHIibdS+JJbqQyNfKOYRlCCBNgDO2/Kxk6u8QG0JswG0nGk68VCF6M4V+4A+09h6BpLm2x8WfpZ9J/yndm8hEeiYxHlj4iGrG5Cnn655L6tSnQ/fGWYO2jB+c2QsE737w3Z9twQVQV0Gn6YOBPc/ScI4Qa2m4QpjFWIOD2IZO0UU4CelwKGJt6Sn4qFGD2S8b0wRcpi8+Anda87jrvRFeV/J5CrAfc+J6zk1ZLmfuHukPDYy9rH8lbQHV8Ozl6klKGsraSng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LY0CJR7qert7RGJgCFAZaGLTA4B265M68sbeAwasCBU=;
 b=HTCF9WPP0vrXee3dbCIFokvKAMA0OEuR1fmkkMi976qfXpCdT+FT+YpwoRK8Qcux1qoXfxllSbT8v60Y0X7qxfP3paq6s6ZNdnUFdT5syDhYdfGccFb/yVEbdF7b/uZ6b7sA8IqLgf7Cw54fGnbXPxk7P+gejqpKqQcMuFnTSbG0c6MuNU2BD9yrwnEnN7UsC9Kq8OuqSPKy9mf4UyYo6ZbldwQUgxMkLPfTcu7N0ik+1zfB2EHlggsC121Zj2I5Jmgf0koZeDex4gFCCScDAV82+Pygc/DkKVIzL6xQ3+JP5b9sBU32HC/yBW0EzCQ3u0PqpPO4EawfTFQ2J0v7nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LY0CJR7qert7RGJgCFAZaGLTA4B265M68sbeAwasCBU=;
 b=NDAeCkxepWzwPoWIE3V/8ee0dQ7ueUb+Hjh/969tU1Uy3zhZOxfK+7GxBBHEqTwdXou6iQk9bQyFEUXVTbsHnDVfIciSK7YDYH4EXT/ky/1in6PoE4nZb+21Q4uwUEmIrT7Uw7spO1l7PK28McPBPP/R2uYpqlM0mEwplxApwSw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DM6PR17MB3755.namprd17.prod.outlook.com (2603:10b6:5:22c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 2 Oct
 2023 15:30:51 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5565:d559:61b0:e2df]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5565:d559:61b0:e2df%6]) with mapi id 15.20.6813.027; Mon, 2 Oct 2023
 15:30:51 +0000
Date:   Mon, 2 Oct 2023 11:30:42 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-cxl@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, arnd@arndb.de, akpm@linux-foundation.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 2/3] mm/mempolicy: Implement set_mempolicy2 and
 get_mempolicy2 syscalls
Message-ID: <ZRriIpYETsRdWZet@memverge.com>
References: <20230914235457.482710-1-gregory.price@memverge.com>
 <20230914235457.482710-3-gregory.price@memverge.com>
 <20231002143008.000038ac@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002143008.000038ac@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0265.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::30) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DM6PR17MB3755:EE_
X-MS-Office365-Filtering-Correlation-Id: cc26fb84-4cf9-48e3-786a-08dbc35c8f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oaDIe0CPxLJntsLjiUrcvg8JJEgzWG+ZJairwVW/sj0idPrL4CMxj7EHQtt8gh2sWmJ4dzBHMnreS8AodZ+hjbMLRK7B+DFmBLOUoU/5u8eacgPnmFrqxi+Q3+7feBjF+0jcHhditLAVJXlq6Afevh8nQdb1pGqD1YIxHPrP8rJn67kzgqFqa0KfPBZqJf/eL0q79yY3KrIpnEN9a9mUU9pHCJ08VHe5v/oj24lMmHPBb+I/Tm+3Gi/tvBXVG10UJRGxoxdEbfkzFWFTe7I7+sAdKGMEoRA+RVUYx0gPMsF+94l1zk5InaOWOPy09MZtZDM8mDwdQZRpQ19y0aPRzO3OTHIzaIA+CpJaKlkbd8X0oVVxC4yjMSoMufoFl8GI4HPgY7/gNvXr9DzGw2Qy5utT+mOq/2Y33FpXniJNLDzojRkLzV+s+OM2DoOMF5Oa68G8OVaWMPeW2F/YrQTfiZ/3NxDItepJP0wq8qrMWvmI5Hyz3E4XuElanrSx1/wvli8UPffiuuSPVX+kH/chk5whhxmyEJ8OOtvZ7lVKvEEwY68yRWUtQWmKY+/ztByi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39840400004)(366004)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(66556008)(66476007)(66946007)(316002)(6916009)(2906002)(478600001)(2616005)(8936002)(8676002)(4326008)(26005)(44832011)(5660300002)(6506007)(6512007)(6666004)(7416002)(6486002)(41300700001)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w9k70vMeDI6pRh0gtk8C4d9eW5IFcwXJYW65r+XfUpBpPxoU7z9YIXVa3kiL?=
 =?us-ascii?Q?vPYnVjHS/4aD1SdR88Ifd2T3zmdhJ6cIB+Snzv1Eig5nQoDV6kNrqrHpZMNf?=
 =?us-ascii?Q?gaAfnu2FRfd4N80sNPgoQ+SVr2zl0VEcyAg1LSUjvMiRO+sDAKGaJ2+4Vx9Y?=
 =?us-ascii?Q?r0KHWZIDYJT8xtOcoFMGNvjK+0EKlLbOtb9PuEDhB2P8ix5LsElph1o+yiVX?=
 =?us-ascii?Q?7fIVpbMotf1dPTbcdSzER1Xijj3rC9ZbVWRlepQAfr9EOCfNXj6mX9Qc4RVd?=
 =?us-ascii?Q?lOWVN7qyYyr1wVmXqbdg4QEv9jYCU16HtH81Flc98lvoU2Wjf6zKXLNSY/oA?=
 =?us-ascii?Q?zcX/5bdRuG5XE9JFcLPwvLozNnFe8FuonwCE0CylHBKtd2vXW/upJxJyDnwU?=
 =?us-ascii?Q?b49/h9bdul9nrkU1vUfNz8gMoTG+eWmRN3BrY47DIT5ipCpuj4QuB34BTqDH?=
 =?us-ascii?Q?AYPsp2SmCzwq7L+o9STKCpMgjUlJdvsr4gyZYgeNLzZIGORuA3t+xVPlCBA1?=
 =?us-ascii?Q?2ka/BJVlWpd6nDDCJkVq7rEDkq5deu6Ac54CzIY3W4Z4tnrxyplm0X7ImiXl?=
 =?us-ascii?Q?Fs0uQVNsFconRHBuG3Zr/hSR7vPzyqpF8xWVy4WFv/MbylsPxUU0gxnBQ++F?=
 =?us-ascii?Q?/PpOZUJlA/PUrpbpGFIRogfAvO+8SKJ2PnSacD37c9BQn7aHhMqcSuaGfRis?=
 =?us-ascii?Q?sK1MkcvvbiM7lMov9b3KA8nLqAIPS1betllNsbmPixgJLZZ4ldLXlbDMQmh0?=
 =?us-ascii?Q?DdHEVzjHiU7x/YGVni8ilvdd0tzzX1Xn+wDkNWdOOlfGqwFdmGF2f9Pculym?=
 =?us-ascii?Q?9fo0mRmr1M0YXo8oGl7Ds6wbOdltT3xQ5gY6rflHxONCbKmIxvA69A88L2JU?=
 =?us-ascii?Q?Dk17cBTbNh5V78hYG8xBDh80I9s/bLx/Lk+qcfnurJXDgMsVqkqDMseYWq9g?=
 =?us-ascii?Q?hZhWSzwKXlyEiC+uuTc2KaGSjo7PHGD3J+8sSS9JXC/rY5ubL4ecXWdqfomr?=
 =?us-ascii?Q?JEHxGlQHRfK4mi0HxFZV1B/525P8pb03px1PQGWpwFlooPT8+mCryKs6amrl?=
 =?us-ascii?Q?gXd6IqJtxsiaLdRb1VeUes6bztVyPwV819e02WIpjAA4aAdPO0jNFvf9wB23?=
 =?us-ascii?Q?DWgUmshcJdZ652BGz/iRUWWJj4NIvl56ajA9IP4yPDyUlzW9hFLMQUEAeyac?=
 =?us-ascii?Q?MrYi1zFaI/5zy+Lwl/iKgpNVyk4yl6CzVg3Rcv9s8lxsJq2ZWh2v5Hc3iAb2?=
 =?us-ascii?Q?6AhUQhPy8Pe4x/hvyK7GC3b60vlhh+Acyz8sLQ+5V0zR4WmoXi4NIyyXfXxu?=
 =?us-ascii?Q?AmGte7hNj1g37o2LLYQljXhsj/B3GIKkvWy2XNcF8piWe1ESb4yds5YUH5Ng?=
 =?us-ascii?Q?vEDaIPJRuU0kx5I0JTytHBhD1EL4Yd9fHCGiyxecscVKiPMKEIsqJ5F62dGQ?=
 =?us-ascii?Q?MzDEmdIW1+lVZUyOM8Oy3oxNFxObS8ylEdSR1zVgSElni08ME6IDjFi/uJMy?=
 =?us-ascii?Q?8mrhR2X0p8RyEEYrmr+uuNA2h6d0HmLbRJr9xko3D0zlA8OaBrSLqCzdUcmV?=
 =?us-ascii?Q?LVYO3hc3ZoLQJdmHYQcK9U+MQFYX+YDy0NBASrUOFtzGUmvUgBupFTMAV1Fv?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc26fb84-4cf9-48e3-786a-08dbc35c8f26
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 15:30:51.1241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y3/A5cqQHETY8ZOIKkVI2+yXikaANhQqdMpH2kOrqIeWGidyOtzYMjIDMP9hPBQazy6KQyWA+Ihcg0kVxj4SxWv1c1Jkg4Ts53xDblyDD5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR17MB3755
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
> > diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> > index abe087c53b4b..397dcf804941 100644
> > --- a/include/uapi/asm-generic/unistd.h
> > +++ b/include/uapi/asm-generic/unistd.h
> > ...
> >  #undef __NR_syscalls
> > -#define __NR_syscalls 453
> > +#define __NR_syscalls 456
> +3 for 2 additions?
> 

When i'd originally written this, there was a partially merged syscall
colliding with 453, and this hadn't been incremented yet.  Did a quick
grep and it seems like that might have been reverted, so yeah this would
drop down to 453/454 & __NR=455.

> > +	/* Legacy modes are routed through the legacy interface */
> > +	if (kargs->mode <= MPOL_LEGACY)
> > +		return false;
> > +
> > +	if (kargs->mode >= MPOL_MAX)
> > +		return false;
> > +
> > +	return true;
> 
> This is a range check, so I think equally clear (and shorter) as..
> 	/* Legacy modes are routed through the legacy interface */
> 	return kargs->mode > MPOL_LEGACY && kargs->mode < MPOL_MAX;
>

I'll combine the range, but i left the two true/false conditions
separate because it's intended that follow on patches will add logic
before true is returned.

> > +		kargs->get.allowed.err = err ? err : 0;
> > +		kargs->err |= err ? err : 1;
> 		if (err) {
> 			kargs->get.allowed.err = err;
> 			kargs->err |= err;
> 		} else {
> 			kargs->get.allowed.err = 0;
> 			kargs->err = 1;
> 	Not particularly obvious why 1 and if you get an error later it's going to be messy
>         as will 1 |= err_code

My original intent was to just allow each section to error separately,
but honestly this seems overly complicated and somewhat against the
design of almost every other syscall, so i'm going to rip all these
error code spaces out and instead just have everything return on error.

Thanks!
Gregory
