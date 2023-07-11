Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EB774E8B1
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 10:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjGKIJn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jul 2023 04:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjGKIJm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jul 2023 04:09:42 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2077.outbound.protection.outlook.com [40.107.13.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE2692;
        Tue, 11 Jul 2023 01:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViMrgVPV1Q4sIrAiGhfaQMWmx5bKgeN5Q0Z2VMpcClc=;
 b=rAqJigMI6bGLz8mbrwRVBygZf4+CG6WIDRlKHxnP4TM7yU9Cp1syrLoVvuGAS61DUFVUd0gWXDrfv6jfOUI4/QpLGfLIuDbW4BA6hytUKGY/9om8ZjzD+InEmS6YS8vx9AnB3e3LL1h3ymwEbI/3n5YddrBv9//6z2bx+0pipOI=
Received: from ZR2P278CA0008.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:50::11)
 by DU0PR08MB9751.eurprd08.prod.outlook.com (2603:10a6:10:445::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 08:08:54 +0000
Received: from VI1EUR03FT056.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:910:50:cafe::e5) by ZR2P278CA0008.outlook.office365.com
 (2603:10a6:910:50::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Tue, 11 Jul 2023 08:08:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VI1EUR03FT056.mail.protection.outlook.com (100.127.144.95) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 08:08:53 +0000
Received: ("Tessian outbound f9124736ff4f:v145"); Tue, 11 Jul 2023 08:08:52 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 77f4db24a3baf5a9
X-CR-MTA-TID: 64aa7808
Received: from 3fdea9231e38.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E4527609-92DF-46DD-A6A8-5BA612B1CFFC.1;
        Tue, 11 Jul 2023 08:08:41 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3fdea9231e38.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 11 Jul 2023 08:08:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3DwERX68z/8l8XtpUbpjSbHB1jkrAitrWR6GbcZwd5Ec0T6kZcuOJVY6iRVYGCm2pXFj5Bwba+4t3LcyOvP90/bsyNTiAsdCL97aC7QVA9MeggNhUZbPW1UjAy+EbqHGBYbVXy14UH9q0SFM7hHQqL0a2HnjvxoAgpTmBjff0OaJv+8Rgtslq7GjT4LV5A8VphPymM25gOHqLrHKOy0SmnSfMO26kFCVIwSgCs6y9r6u0LFZNhJubZQrB3bGLgJYCGC7vS7reNIBnZIi4ZGRBo+P6NFcs4M5kB+2qElwT3xHI+NB2UOiAAnH8cuEXTn5wyI+HQFCLLtNlk3bFy1ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViMrgVPV1Q4sIrAiGhfaQMWmx5bKgeN5Q0Z2VMpcClc=;
 b=Hz3qJ7MWdRLbxolrF1F9q5WUK+G73wSjzK9mXlvKVXKRbMz/rweAnxSE1sx8O5uxdxWreOnVVIpcl4XU+SFuo5MWOLWVbR+IWW7yS2vyA4XPA8exG2s1k0m2c78h1ofyXeEwkxUXYbnC2+3/zcgI/XTi66OVF706HdEVIbp6HG4x/FUZjP9pD5+MxxCijPc1y7797fvx2ykjxJoNehTK6jDxwdJD8TpKbEf25HxZC423jHH3QBq7+53ZaGbk5c4LJNhkDEY+kMvZ28t2w/d+nmfLfHNMoPKoDSmhf5xAFdkBhqghw+eMuWFOonNcSMXg3ltAUS+1MA3e0BuI9c47eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViMrgVPV1Q4sIrAiGhfaQMWmx5bKgeN5Q0Z2VMpcClc=;
 b=rAqJigMI6bGLz8mbrwRVBygZf4+CG6WIDRlKHxnP4TM7yU9Cp1syrLoVvuGAS61DUFVUd0gWXDrfv6jfOUI4/QpLGfLIuDbW4BA6hytUKGY/9om8ZjzD+InEmS6YS8vx9AnB3e3LL1h3ymwEbI/3n5YddrBv9//6z2bx+0pipOI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AS2PR08MB10267.eurprd08.prod.outlook.com (2603:10a6:20b:647::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 08:08:38 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 08:08:38 +0000
Date:   Tue, 11 Jul 2023 09:08:11 +0100
From:   "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>
Cc:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "bp@alien8.de" <bp@alien8.de>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "jannh@google.com" <jannh@google.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Eranian, Stephane" <eranian@google.com>,
        libc-alpha@sourceware.org, dalias@libc.org,
        branislav.rankov@arm.com
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Message-ID: <ZK0N65CEAd8HMOjm@arm.com>
References: <ZJ2sTu9QRmiWNISy@arm.com>
 <e057de9dd9e9fe48981afb4ded4b337e8a83fabf.camel@intel.com>
 <ZKMRFNSYQBC6S+ga@arm.com>
 <eda8b2c4b2471529954aadbe04592da1ddae906d.camel@intel.com>
 <ZKa8jB4lOik/aFn2@arm.com>
 <68b7f983ffd3b7c629940b6c6ee9533bb55d9a13.camel@intel.com>
 <ZKguVAZe+DGA1VEv@arm.com>
 <1c2f524cbaff886ce782bf3a3f95756197bc1e27.camel@intel.com>
 <ZKw3zSKxCug0IbC1@arm.com>
 <1c0460a2042480b6a2d4cc1f6b99b27ab1371f3a.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c0460a2042480b6a2d4cc1f6b99b27ab1371f3a.camel@intel.com>
X-ClientProxiedBy: DM6PR02CA0067.namprd02.prod.outlook.com
 (2603:10b6:5:177::44) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|AS2PR08MB10267:EE_|VI1EUR03FT056:EE_|DU0PR08MB9751:EE_
X-MS-Office365-Filtering-Correlation-Id: dd19ab4b-4422-41b4-8a40-08db81e6118f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: /DmQTz8Dk0Ah3h4psVOP47bZfz5ty/wyAoBH9b+Y/hGBhls9u24UwCAENHhXoM/2BqU8OyPi0JdJQaV2l8yO8WTLCtgObZXnRoxfeboJ/QY+8qdjhXKz8qenBgGhQ/HkDRKj63bOQfpsJpsI/aiIoLBVtK+oZ5BrZnMb1Hyq0tHGSEzhX2TsAiF74IayfuMEzktnNASpDwp5lj2K9n22fAcu+oSDy7iLSVSm6y3+j14FLqXe257naHuhjDCJPbx97G2pOwu5J7bppsOQE5bw0blXIRjxkq3P83Kxpy4WITKIbNXz5nCDjbFuTLR3FQl8baAK5Dt2GYRN3UZrgFiya0nqcd38ICeDj3/DAXJ05KrhDw/76chHY7KDi/NfA7X4I7bvGHQecI2voou/Ygucs8FKpWeek/00BeO0i6bHJ1o32K1Q/pUy3sSS2by1S5UkCsmpGe4pNhYRzPOydd4Zg4b1SNuNXkxgrWmUi8mKTqzXtjFSiVB9a1RTjqrjyPv8dvQtDwwCTu9j2ZsSZYwyPdnoLt+gHN6LDkwOgiSLFC2WcXd/pzPbh/vw0KX8ms70
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199021)(66899021)(478600001)(6486002)(6666004)(110136005)(54906003)(2616005)(83380400001)(36756003)(86362001)(2906002)(66946007)(6506007)(26005)(186003)(6512007)(38100700002)(8936002)(316002)(41300700001)(66556008)(7406005)(5660300002)(7416002)(66476007)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10267
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR03FT056.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 81dd8b25-8081-42c8-90d0-08db81e6083f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v6c19OBgozi+qOrh/3r2vyN6v70ZDp938sUfYl+tgk2yM9UGUgpKxN6gV7lol7ZxzZZPyzI8RdAX1uN1A6Iu4hzuchdDijA4mBMY1QrMid74L/xFjB4w/Ciq5Ermo+fOJarpLdayMMr49JwNIKJCBiVG+wR/qhAmaPkoPMOBJ6RDWDL842QLbjY3Jsu9PrPnviBFdKRgt2hE97XbzFng80yW0yT8pIjgZ/5cHyAvwMDqmCcBUpC3zJWcrsTGU9OJXOeFEsyw1WvZ7NFXYb8pxEr09qxI8K59sssWlRjipyrsPIwfJA3Ng2qdsShOOcyZ53EvUn1WGx87eJBHI1LCuLB7GhwnEwkTl8Ij2+hMYHWwpnRP5bPwJh5p31GbbZlqifxaepetyx0TvgUiR3kBZsw94yU14TXmwS1wolgWswUQaxKlwr2bE/1KqGxZ2D5VHQCGOiW0tCuzdeCvkfZiEij//y8Bt5m71M5dsfh3/+tn1K7C2du/XiZb482bwnE5aT8z07fHc0bN2ecPuotlQMXYH0UMoqbUCpVJkBCyFp82gb0A9W6L1M3WNNUNSXjzeVPg0JJSQzvsFUrRH2uB2u515fUv0mu43ujmVYDq/paaa9ftY6u6VxXVv20vy8D+I6dxpbvzsrlExsMH55XqhXkEyqN1Fb1f/KMaIWsa0QnmDpSycbAILQ11fywdliU0v/hzT7A3+Vpq7HsqPSNLMilxkOPd6mCIDGxhdQQsiiZOlW7Yymaqi0cdbTYvaYQ7
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(40470700004)(46966006)(36840700001)(36860700001)(82310400005)(36756003)(86362001)(40480700001)(40460700003)(81166007)(356005)(82740400003)(478600001)(110136005)(6666004)(54906003)(6486002)(6512007)(8676002)(8936002)(5660300002)(2906002)(316002)(450100002)(4326008)(70586007)(70206006)(41300700001)(2616005)(66899021)(336012)(26005)(6506007)(47076005)(83380400001)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 08:08:53.7482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd19ab4b-4422-41b4-8a40-08db81e6118f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR03FT056.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9751
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 07/10/2023 22:56, Edgecombe, Rick P wrote:
> On Mon, 2023-07-10 at 17:54 +0100, szabolcs.nagy@arm.com wrote:
> > in short the only important change for v1 is shstk sizing.
> 
> I tried searching through this long thread and AFAICT this is a new
> idea. Sorry if I missed something, but your previous answer on this(3)
> seemed concerned with the opposite problem (oversized shadow stacks).
> 
> Quoted from a past mail:
> On Mon, 2023-07-03 at 19:19 +0100, szabolcs.nagy@arm.com wrote:
...
> > - tiny thread stack but big sigaltstack (musl libc, go).

and 4 months earlier:

> Date: Fri, 3 Mar 2023 16:30:37 +0000
> Subject: Re: [PATCH v7 01/41] Documentation/x86: Add CET shadow stack description
> > Looking at this again, I'm not sure why a new rlimit is needed. It
> > seems many of those points were just formulations of that the clone3
> > stack size was not used, but it actually is and just not documented. If
> > you disagree perhaps you could elaborate on what the requirements are
> > and we can see if it seems tricky to do in a follow up.
> 
> - tiny thread stack and deep signal stack.
> (note that this does not really work with glibc because it has
> implementation internal signals that don't run on alt stack,
> cannot be masked and don't fit on a tiny thread stack, but
> with other runtimes this can be a valid use-case, e.g. musl
> allows tiny thread stacks, < pagesize.)
...

that analysis was wrong: it considered handling any signals
at all, but if the stack overflows due to a recursive call
with empty stack frames then the stack gets used up at the
same rate as the shadow stack and since the signal handler
on the alt stack uses the same shadow stack that can easily
overflow too independently of the stack size.

this is a big deal as it affects what operations the libc
can support and handling stack overflow is a common
requirement.

i originally argued for a fix using separate alt shadow
stacks, but since it became clear that does not work for
the x86 v1 abi i am recommending the size increase.

with shadow stack size = stack size + 1 page, libc can
document a depth limit for the alt stack that works.
(longjumping back to the alt stack is still broken
though, but that's rarely a requirement)

> Also glibc would have to size ucontext shadow stacks with an additional

yes, assuming glibc wants to support sigaltstack.

> page as well. I think it would be good to get some other signs of
> interest on this tweak due to the requirements for glibc to participate
> on the scheme. Can you gather that quickly, so we can get this all
> prepped again?

i can cc libc-alpha.

the decision is for x86 shadow stack linux abi to use

  shadow stack size = stack size

or

  shadow stack size = stack size + 1 page

as default policy when alt stack signals use the same
shadow stack, not a separate one.

note: smallest stack frame size is 8bytes, same as the
shadow stack entry. on a target where smallest frame
size is 2x shadow stack entry size, the formula would
use (stack size / 2).

note: there is no api to change the policy from userspace
at this point.
