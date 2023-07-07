Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EABE74B41E
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jul 2023 17:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjGGP0L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jul 2023 11:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbjGGP0H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jul 2023 11:26:07 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2083.outbound.protection.outlook.com [40.107.6.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1951213F;
        Fri,  7 Jul 2023 08:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8Q5fF4hvYsZlIqDJIaDZwAjumlgFTV4j5eTd5BtzAI=;
 b=9u0yvlvRyMfhoIEQruQzh2M8DKowbpPSMcQtEQi0YvmHgjWTHoro1QJyxW+RIB2Jp3AQsqPeX51ylclbmBFn1SG/GeQpGFVszfWRYKqmGQtMICEiky/Qeu+A4sLSGdIHe0T3ZrVXcyaqW2/hHsGLShvnXNZtRuasJBKbpSYZsc8=
Received: from DBBPR09CA0031.eurprd09.prod.outlook.com (2603:10a6:10:d4::19)
 by AS2PR08MB9390.eurprd08.prod.outlook.com (2603:10a6:20b:596::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 15:25:34 +0000
Received: from DBAEUR03FT036.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:d4:cafe::21) by DBBPR09CA0031.outlook.office365.com
 (2603:10a6:10:d4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Fri, 7 Jul 2023 15:25:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT036.mail.protection.outlook.com (100.127.142.193) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.25 via Frontend Transport; Fri, 7 Jul 2023 15:25:33 +0000
Received: ("Tessian outbound f5de790fcf89:v145"); Fri, 07 Jul 2023 15:25:33 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f01b1f76621ccda2
X-CR-MTA-TID: 64aa7808
Received: from 5ccbeafcd8df.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id CA387735-31CF-4F53-9F14-7D1DEA12BFFE.1;
        Fri, 07 Jul 2023 15:25:26 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5ccbeafcd8df.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 07 Jul 2023 15:25:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8UBm/iqMTHxPevrDarqCDkK40oPrYPpVMm/gms0/Px4w2/EzHQnKQ1ljIz9+nc2j9Ieuda4MUtn6sjs35X1jMAhOd4+0xhgB46H2nrCaPbdEsQqAYp/+5N9iTXaOH4SEA/e0VA1mjBcx06rdlKOSOSixNoaBXPvTKn8SHSlt6e8Zs5rhIjzYbYS+wZIOV8qydmHKaAHbW61lXPTQANAp2/GRCOLcTG+jkxN/3wtvGxftDw9ql6pxaBd23aT4jmdvh+LyJPR9MQgliq0NXUi4+SB4Yd6T0wbu1+aEBHuma+puZOCkUz7yeE81Yf/qzEjqMBUQ8rJAxaa62hkvWC84w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8Q5fF4hvYsZlIqDJIaDZwAjumlgFTV4j5eTd5BtzAI=;
 b=T8wcvAIAfYmrgJEbohDV9FMY9B1NJ7AMvdYbIAHMTXRGvGLztLM3B6Hh9ZTSThH0jAlG/5BEsso0HUELEFWruWEsH/htbuhDx+omLb+oXCEXQeMVQiTCJqTOAoVAd1ictxYTLKvdQouoK+RsbanznkWREtrj71IaT8IpyL/84RrLSqtNpFSUKWeBBF/kKYHGPO8Iq4i0ulXB1i44SCEpiyDUuEhKHDYTvqFIoXXharbxshpOLQg6mqDt1GrbTexyRf1IlKX5AYR8afOFibifhUJ8rdmvpgi+5iS2prIwOyYy4/WSvkbDyzEpkIFdwn0fURaM2V7YNl+79K2BSzw4Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8Q5fF4hvYsZlIqDJIaDZwAjumlgFTV4j5eTd5BtzAI=;
 b=9u0yvlvRyMfhoIEQruQzh2M8DKowbpPSMcQtEQi0YvmHgjWTHoro1QJyxW+RIB2Jp3AQsqPeX51ylclbmBFn1SG/GeQpGFVszfWRYKqmGQtMICEiky/Qeu+A4sLSGdIHe0T3ZrVXcyaqW2/hHsGLShvnXNZtRuasJBKbpSYZsc8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by DBAPR08MB5768.eurprd08.prod.outlook.com (2603:10a6:10:1b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 15:25:25 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559%4]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 15:25:24 +0000
Date:   Fri, 7 Jul 2023 16:25:08 +0100
From:   "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>
Cc:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Message-ID: <ZKguVAZe+DGA1VEv@arm.com>
References: <ZJQR7slVHvjeCQG8@arm.com>
 <CALCETrW+30_a2QQE-yw9djVFPxSxm7-c2FZFwZ50dOEmnmkeDA@mail.gmail.com>
 <ZJR545en+dYx399c@arm.com>
 <1cd67ae45fc379fd82d2745190e4caf74e67499e.camel@intel.com>
 <ZJ2sTu9QRmiWNISy@arm.com>
 <e057de9dd9e9fe48981afb4ded4b337e8a83fabf.camel@intel.com>
 <ZKMRFNSYQBC6S+ga@arm.com>
 <eda8b2c4b2471529954aadbe04592da1ddae906d.camel@intel.com>
 <ZKa8jB4lOik/aFn2@arm.com>
 <68b7f983ffd3b7c629940b6c6ee9533bb55d9a13.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68b7f983ffd3b7c629940b6c6ee9533bb55d9a13.camel@intel.com>
X-ClientProxiedBy: LO4P265CA0229.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::18) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|DBAPR08MB5768:EE_|DBAEUR03FT036:EE_|AS2PR08MB9390:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c33ce4-8878-44cd-8e16-08db7efe684a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: oBiXMI2qXnmtNlssZwnXREHo9ucw3QnTOOnzND3GD1ckP/nomAIKRe6qzn2H1wPsluzBPiF5mHxmVFRhN4vDfwJZ10hwXy25G47pwJUxvwQi56p0BDMs0GY5kroFvjTCaBDZEch0ShVHlHJ+5U+x0ia4RmhzP3BVwRcooRg0u1wBOtUIVYG6Useh8aXNtkqs3G7yLhwmqAutP9USCy9o/yB4fQr//0xrKwLy0c44s/DAbIcxAlBeV4cTYau2nLB/0JqqJuD0lNkPz7Ok8tcFbrCJWjCqsuFyIvpxy0Z5fsY/bTnvYP8vqMb9OEFVh07LdOFv/RqpvLa5Nbp7UBndzfbrQGL7kvZccT5ziV1T5mm3E3JxKOeOT8rYDb+KoaL1yIrYhNPaUyu5nxEZhYoCKbZdWTxpoyhYt2DN6QklqMcjl0I8WrLDBnD0ttJuvVRZi6TarfI8GUWaneTXXjiArBAT8B3Xa6L5P9RDf/64cQcG02AVBu9H++ufFoYO+2wC/GfhbEfJUxQh8QQ9P0u+G0W8PUHjCwUA4X/zDu1Ge5OhHy0xLmLix5wqxdBACytqoZbZekHnHXNAvnK1IDnOoAqHN+Eaf5zxJcvrP0wc15E=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199021)(5660300002)(8936002)(8676002)(2906002)(7406005)(316002)(83380400001)(7416002)(41300700001)(4326008)(2616005)(66556008)(66476007)(66946007)(38100700002)(86362001)(186003)(6512007)(478600001)(110136005)(26005)(54906003)(6506007)(6486002)(6666004)(36756003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5768
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT036.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: fd1f0f02-3364-4d49-33e0-08db7efe629e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ZCN/FX1TSrjTjFqtvPLRdT8mfqwiLkcofKjDcYBsdmKY2yNCoY4X4EoAT42KAAAnEgvG6bDRGmJo9PxZ+TNYdohHxOQObTEneH9Z+gnuKrAqz7i6B4T+Dmg9PL6GReTF1/kv9NNCTw50nnoe76qnd8WG2ovo1J3V5hx7Wegi2BJNalrUjy9+x1H03clBm+B5ewvAhYP4E8A9V2x3LCQ4yLaL7jyf838bvnHp2mI87LA5iuY/Z9pSf8DpnPy+ZoXwr+Vi8UgaorrUnhBElNzE9RBFju/nDfAa4VIFkZSDKXjm8PT/rEmeKpN38TytT+1oFTgxqqXWZZnTK3CZapkuChXlyYfmYMp5tQ+rx4N4zfDLXL+mf/pKHwCRQHwyGNjM3f+9hMFyKbE0NlO3t1pFrmrnP2phlWFgz5Teh5RzUCu6njd49n1CveO5s87+YbWS1XRlBGhmxvVe6RC4Xj3yfX9EmWkS6sLRRGp0+aoMOmt5Zg5FJP44bpfHxRRTvjrovdWgTOacSinD5Tv4q1Mvou9voWer5UyDHSjnMLmPx2CgiJ4ocwnxcMmvkuLlE5bMx7bXuX3rCGspn238atZ/MPdevwlJgz26kUTly6kKcApW2r/R+5naBD+w/FTS6v7LW16WzoUKNU2n3oZFkHi4HUO1EIu/uPtRJ5CYue5ntn01oWwLdNLjEuoKIFy7UdbB02oTDdWS8tBG/alsoR4sFyFFtB21xocfABRmdc8Q+pXEBQGtRkbuD/xBwha7splyqPCYgp9CRvVOqDfTVG7WA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(36840700001)(46966006)(40470700004)(450100002)(70206006)(356005)(6506007)(4326008)(70586007)(82740400003)(2616005)(40480700001)(81166007)(86362001)(186003)(6666004)(6512007)(36756003)(26005)(110136005)(478600001)(107886003)(6486002)(40460700003)(82310400005)(54906003)(36860700001)(8936002)(8676002)(41300700001)(83380400001)(5660300002)(47076005)(2906002)(316002)(336012)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:25:33.9254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c33ce4-8878-44cd-8e16-08db7efe684a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT036.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9390
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 07/06/2023 18:25, Edgecombe, Rick P wrote:
> On Thu, 2023-07-06 at 14:07 +0100, szabolcs.nagy@arm.com wrote:
> 
> [ snip ]
> > 
> > instead of priority, i'd say "posix conform c apps work
> > without change" is a benchmark i use to see if the design
> > is sound.
> 
> This involves leaking shadow stacks for sigaltstack and makecontext,
> though, right? This seems kind of wrong. It might be useful for
> avoiding crashes at all costs, but probably shouldn't be the long term
> solution. I thought your API updates were the right direction.

new apis are not enough.

existing apis either must do something reasonable or shstk must
be disabled when that api is used (sigaltstack, makecontext).

the disable does not really work as the apis are widely used
and there is no 'disable shstk locally' it is viral when a
widely used dependency is affected.

so apis must do something reasonable. however there will be
remaining issues and that will need new apis which can take
a long time to transition to.

> > one nasty case is shadow stack overflow handling, but i
> > think i have a solution for that (not the nicest thing:
> > it involves setting the top bit on the last entry on the
> > shadow stack instead of adding a new entry to it. + a new
> > syscall that can switch to this entry. i havent convinced
> > myself about this yet).
> 
> There might be some complicated thing around storing the last shadow
> stack entry into the shadow stack sigframe and restoring it on
> sigreturn. Then writing a token from the kernel to where the saved
> frame was to live there in the meantime.

this only works if you jump from the alt stack to the overflowed
stack, not if you jump somewhere else in between.

this is a would be nice to solve but not the most important case.

> 
> But to me this whole search, restore and INCSSP thing is suspect at
> this point though. We could also increase compatibility and performance
> more simply, by adding kernel help, at the expense of security.

what is the kernel help? (and security trade-off)

and why is scan+restore+incssp suspect?

the reasoning i've seen are

- some ppl might not add restore token: sounds fine, it's already
  ub to jump to such stack either way.

- it is slow: please give an example where there is slowdown.
  (the slowdown has to be larger than the call/ret overhead)

- jump to overflowed shadow stack: i'm fairly sure this can be done
  (but indeed complicated), and if that's not acceptable then not
  supporting this case is better than not supporting reliable
  crash handling (alt stack handler can overflow the shadow stack
  and shadow stack overflow cannot be handled).

> > slow longjmp is bad. (well longjmp is actually always slow
> > in glibc because it sets the signalmask with a syscall, but
> > there are other jump operations that don't do this and want
> > to be fast so yes we want fast jump to be possible).
> > 
> > jumping up the shadow stack is at least linear time in the
> > number of frames jumped over (which already sounds significant
> > slowdown however this is amortized by the fact that the stack
> > frames had to be created at some point and that is actually a
> > lot more expensive because it involves write operations, so a
> > zero cost jump will not do any asymptotic speedup compared to
> > a linear cost jump as far as i can see.).
> > 
> > with my proposed solution the jump is still linear. (i know
> > x86 incssp can jump many entries at a time and does not have
> > to actually read and check the entries, but technically it's
> > linear time too: you have to do at least one read per page to
> > have the guardpage protection). this all looks fine to me
> > even for extreme made up workloads.
> 
> Well I guess we are talking about hypothetical performance. But linear
> time is still worse than O(1). And I thought longjmp() was supposed to
> be an O(1) type thing.

longjmp is not O(1) with your proposed abi.

and i don't think linear time is worse than O(1) in this case.

> Separate from all of this...now that all the constraints are clearer,
> if you have changed your mind on whether this series is ready, could
> you comment at the top of this thread something to that effect? I'm
> imagining not many are reading so far down at this point.
> 
> For my part, I think we should go forward with what we have on the
> kernel side, unless glibc/gcc developers would like to start by
> deprecating the existing binaries. I just talked with HJ, and he has
> not changed his plans around this. If anyone else in that community has
> (Florian?), please speak up. But otherwise I think it's better to start
> getting real world feedback and grow based on that.
> 

the x86 v1 abi tries to be compatible with existing unwinders.
(are there other binaries that constrains v1? portable code
should be fine as they rely on libc which we can still change)

i will have to discuss the arm plan with the arm kernel devs.
the ugly bit i want to avoid on arm is to have to reimplement
unwind and jump ops to make alt shadow stack work in a v2 abi.

i think the worse bit of the x86 v1 abi is that crash handlers
don't work reliably (e.g. a crash on a tiny makecontext stack
with the usual sigaltstack crash handler can unrecoverably fail
during crash handling). i guess this can be somewhat mitigated
by both linux and libc adding an extra page to the shadow stack
size to guarantee that alt stack handlers with certain depth
always work.

