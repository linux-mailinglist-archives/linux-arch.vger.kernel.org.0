Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909673D9795
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jul 2021 23:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhG1VfK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jul 2021 17:35:10 -0400
Received: from mail-bn8nam11on2066.outbound.protection.outlook.com ([40.107.236.66]:62515
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231888AbhG1VfK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Jul 2021 17:35:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Be2kYl+btEyzHKrgZTFA+SKYuYnwAGDOMunMMif2dCPvBw4hCmY13WLXDX4qmVnCkOnh6DT9Erio2MU1do7af4ifpXtPnc4/yFNRkn2NLeHEQRR05OfHDLgqCPknFRORkDczwFDunSFfXP/rDtFCRJmhylr9oB3RtMifojAH5kKUR5/tkxUG44OP8Lpsp5ZQWPNokSxYtP4gfKpCUu+VVGY2h5ltPiYAt3IpYxj9z9fm5fouYwecoAukyoj4OFn+RmIP4oZorxq25/WnjObdNQwFZR5qSOGpVka/W3aqCnn13asdwBLQZWm+uAQfpcNf0dwb1yABwcrrZ8+uFa0itg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahQOxh0jAfcFyrcfmnS4KhLkgE5zJixZbFGfyZLCsqo=;
 b=d2uUWtSQiPSRWsmo7fUHwaIGLECLRBWQJtndFGCUzPa+3VfEX7CxDyuF0RFWfmzpHT9KtqhilKyxGoLPkDhJWI8tvq+XhFyGwMCcyfUeVLyU/U8lXDyVfQLj7YIDUQkgBDVUO5zYfkuo7tEcubxB2dnUjf72/Qy/JjcUTvZUMzBdIxAzjSpR1EhxrhNuzpGmYHhp2IvHJMUczhSx6hFHP0+5QO9h39psBYRF73mg7Rj3YEG/5sqNPwXTjPoDbF81pK029enGhsjdb6+zZkEiQEDDT1tRvJdbq2km8hmzMMHAnfoGJyAdegElgGfQqxUY5o9UmXr5sRUdhAm/O2qLzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahQOxh0jAfcFyrcfmnS4KhLkgE5zJixZbFGfyZLCsqo=;
 b=y4LmpKiEDgXuVPc/oltZ4yXT9eXp3ZgnIEGgaoj2ik/m0wq4VGL4yQZDpuo8/mXWMDMTuZ+9e3TDcwq3ldp3/Ud4t3w4oSAySbzboz+vYu9krGnT1QnF6IZvR08wKjQ5RA0DUE0PZuRk0ziiI2fhh2ErpgbH9y3MgoBCPzjn3GM=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Wed, 28 Jul 2021 21:35:06 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::4092:5d49:d028:e0df]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::4092:5d49:d028:e0df%7]) with mapi id 15.20.4373.018; Wed, 28 Jul 2021
 21:35:06 +0000
Date:   Wed, 28 Jul 2021 16:34:55 -0500
From:   John Allen <john.allen@amd.com>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     Florian Weimer <fweimer@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v27 24/31] x86/cet/shstk: Handle thread shadow stack
Message-ID: <YQHNf3HpBhp5fT3L@AUS-LX-JohALLEN.amd.com>
References: <20210521221211.29077-1-yu-cheng.yu@intel.com>
 <20210521221211.29077-25-yu-cheng.yu@intel.com>
 <YPhkIHJ0guc4UNoO@AUS-LX-JohALLEN.amd.com>
 <87h7gnldx4.fsf@oldenburg.str.redhat.com>
 <ee98275e-cd1d-ad94-73cd-470bf89ca344@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee98275e-cd1d-ad94-73cd-470bf89ca344@intel.com>
X-ClientProxiedBy: SJ0PR13CA0102.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::17) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-JohALLEN.amd.com (165.204.53.104) by SJ0PR13CA0102.namprd13.prod.outlook.com (2603:10b6:a03:2c5::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.14 via Frontend Transport; Wed, 28 Jul 2021 21:35:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71a7a228-5945-485a-1829-08d9520f90cf
X-MS-TrafficTypeDiagnostic: DM8PR12MB5430:
X-Microsoft-Antispam-PRVS: <DM8PR12MB5430DFC5FF5B6C1D1F15C4EA9AEA9@DM8PR12MB5430.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QmVhUjxIk0ZQvbQ9bCLyJRyGPxO1oJVWDe1tL3ZYzkWL8TWxkBfc3XHUvlby13WXkdgbS62MoJqf58nXSnUEPehYA1S74kwrkaQS0584M1qqSxafDCPBZ58UCqqIAYJu5N2056foxrTbQz1qW8vHRM/xWZyo1q8V1/AnknZnmsEJNyRLWPPxg5mZM54CxSMFaBdXMfHdFB2oK5h4+4QkA6lQ8GcyRyY6sGM1QSLlyO8lFqdGeOgwmJmGUZc5yt9bTLaxeqyTyo0FrYtfs0UiCGWx/V8CxKSclC1OqVsMs1CPPVWH7dBxSBOUJI+lTHDUQxKdmgM4U+8Y7A2qSMIDcRuP3HKeZFXKTnOp0ho9i/soSvzWHqR10Svezat6Zb15apQ1Daw/cCzqpCVifKYf11n3t1U9beP6360LgVHLbVgTUNsKpvUYZ+ys4zKKvHnHtjK4FPGhQttC4BPiqRMKqtnbk9wHjKaZk2ifiha4L30LR/9uIEaHp4mU+AuondUFqO1L14MKwV0JN4tSqKD0OgH+qxmv5w603WUP4Rkfp6HfEfoEsgM2fjPz+DttEQy1fm1fh/apgfFj7WMF1CQ8eOoibxiMQPLH10XcprmD8dRYtqj4/GT4J5BlPzWdVhtku/AVCHVHrEJlCOhBF3ezdTqwsTtm9sZDCJpy0YyZHNQJGamWwi+SQQh8yNo9jo+VhYBJHWIwAK9kZrpFhOpcGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5549.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(316002)(4744005)(7696005)(5660300002)(6916009)(6666004)(53546011)(8676002)(55016002)(2906002)(7416002)(52116002)(7406005)(26005)(186003)(4326008)(66946007)(86362001)(44832011)(508600001)(8936002)(38350700002)(66476007)(66556008)(956004)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jz/ARtMqmRlvi1RELEKw7juTpvROe7PyRvizelouar7FUdGYNsk1rzrRypia?=
 =?us-ascii?Q?wa8Aa0nNBdlu2UCaA+uW5EThX6QpqZH4DePlSKHU23PYLG+0ItRUjUXsP5Yk?=
 =?us-ascii?Q?QJkMPNpSRYuHJmm3+PB+TpDvy4VBu6fA6Srace4m+LzGMY5K93rUJqscSZd8?=
 =?us-ascii?Q?13qSJj+sCg9+CukgfHx8LUzR09Af4YA3jGizRFnJ6GRiEBAEiXCzbSCMk3W2?=
 =?us-ascii?Q?bJJ30Vr6lhxFGaE7nQjZz1yF8mRIB/XwlaLwRNAQu2/k7Xfge2tG6UrfVGW2?=
 =?us-ascii?Q?+i7XEyrOpCGj1Nu4LGDsNNmSNU6z1szoedl7qZ22KzrnzdLmJmwJp2Dn2449?=
 =?us-ascii?Q?usSHzHHi4axLTkjAfeu9WjNiipYHi7XYceJyicauH7BGj2KCWpUB6o7KTifd?=
 =?us-ascii?Q?Gt/q18vMZQIWNoGici3gOj3WOHrZELG9Hq8dNJojP8IwBMpnD0FxTHh8uEOL?=
 =?us-ascii?Q?WGLC8md/REYx0HVZLX4F4jWvjcaubK32wMXxPYRTK+m68XVXg56iws8zQgoZ?=
 =?us-ascii?Q?Gq2OU2Wu6VQm0E4kyMkFxgMgXZIn6Td26//AWT+FMQC64NDTu6NXqzyvcCMJ?=
 =?us-ascii?Q?W2alCFg3q+7kGyIC/CAflqfyone/5wTmKfn/GFtPJ1PqE6srwgQLunhgOzgk?=
 =?us-ascii?Q?0YHUEIn9xLLTGKUTXoIU2GZHbP9OXA5cOy7qTZrmYS1Q6LEekh6lSugT5Q4N?=
 =?us-ascii?Q?8rJkfl3x1BAIgsd4MMjvTg6Bx/Pa9LlQfwiJ+45i69pwXAGy/12CLZPju/YI?=
 =?us-ascii?Q?PlCFeMVZAids4BlJEYbtvkM3iUM5+qlE+4wePnf2eeF6EpBmry5a3OubsmxR?=
 =?us-ascii?Q?VuVCBl9tIHhWdrPi+RINIyC7hNHaNpX1Bj5At6IQdrAqReCP6fwYcJr+DCtx?=
 =?us-ascii?Q?oZMf4eoNMHhsT0EvpnWC9iGWpyP2PhuXVaJRLmT+osHJ2yyH/EmEA7NwBZLh?=
 =?us-ascii?Q?GwduktqzrSJWiTFXTgKrPWFGjkXfbUDNlJdtpbKJ4i+fLaapsYRF8Ph6gQzE?=
 =?us-ascii?Q?1+XfCj6DjNE7RZIlXcr5dVnod+3nPVlf4fj9xUMT8ughBaWNIi0nz+49YmI9?=
 =?us-ascii?Q?dw8FCfnz86FTETBQTjtinbfCwdHMvM4lu7F79CwSvmJcW7rmxhvTE2YullLU?=
 =?us-ascii?Q?aPS+XNYqNQ0UXsArfbYLefLKgJRrRt9s19ikXjyKFwHZxbXUHA8GSCwL5ogs?=
 =?us-ascii?Q?8qLavom+YXJqIIGAhZo9bppPOJCGPcNa2xT7qMx5w2RWQtpr8jUjRQcPASW7?=
 =?us-ascii?Q?NFoQNKChHSMXpDbYu4Kv2j0gfed0HziSjPx4p5i8mNEBeDrP2TOB3Xw1whWK?=
 =?us-ascii?Q?oVKwcYLobC850KqeeR7m4XBB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a7a228-5945-485a-1829-08d9520f90cf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 21:35:06.0170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNQP9loZ+/Ju92m21Quj56GiuCQ+jMa4HnngdUWd48UYCZDDKNoTBxIGRX0wPkZCE30Rj+HMzeFlAmJL86DXTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5430
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 21, 2021 at 11:34:53AM -0700, Yu, Yu-cheng wrote:
> On 7/21/2021 11:28 AM, Florian Weimer wrote:
> > I expect that container runtimes turn clone3 into clone in the same way
> > (via ENOSYS), at least for the medium term.  So it would make sense to
> > allocate some sort of shadow stack for clone as well, if that's possible
> > to implement in some way.
> > 
> > Thanks,
> > Florian
> > 
> 
> Thanks Florian!  And because of that reason, we will put back clone2 support
> in my next v28 patches.
> 
> Yu-cheng

I tested with v28 of the patches on the same system and it appears to
fix the issue I was seeing.

Thanks,
John
