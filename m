Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE8D734E85
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jun 2023 10:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjFSIuQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Jun 2023 04:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjFSItp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Jun 2023 04:49:45 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2058.outbound.protection.outlook.com [40.107.7.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AC8BC;
        Mon, 19 Jun 2023 01:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3vi6fMoto5C61seTyHli6jpOjS3Tna7OttLmbp1CYo=;
 b=tQdoeCyLvfUhvaSJmivi7aYli7BrQLK9qH8uwBWFDnb+HSyzuGUWraL0P5WgYkOOALle4S9dEGxhd/RKOLH7nmj1y6t+9TbANdb6gV7si/+NaYfOYxh75QISI8SsBpxsoJKP9W92nWKfSHmzPMZxnau6wgsZSFIpr5cNoZfal+U=
Received: from DU2PR04CA0170.eurprd04.prod.outlook.com (2603:10a6:10:2b0::25)
 by PAVPR08MB9089.eurprd08.prod.outlook.com (2603:10a6:102:32a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 08:48:11 +0000
Received: from DBAEUR03FT027.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:2b0:cafe::1a) by DU2PR04CA0170.outlook.office365.com
 (2603:10a6:10:2b0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36 via Frontend
 Transport; Mon, 19 Jun 2023 08:48:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT027.mail.protection.outlook.com (100.127.142.237) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.20 via Frontend Transport; Mon, 19 Jun 2023 08:48:10 +0000
Received: ("Tessian outbound 3a01b65b5aad:v136"); Mon, 19 Jun 2023 08:48:10 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5a40aaa07bd03fc3
X-CR-MTA-TID: 64aa7808
Received: from aad9bd157281.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id AFF05BB2-1F3B-45B5-BA8E-304F17042518.1;
        Mon, 19 Jun 2023 08:48:03 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id aad9bd157281.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 19 Jun 2023 08:48:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2cgxmZ+8/qm2cV4WuAR0I0AKRsrrnf4KAC2EGjlAv0zlAuIZteaMN2LqkBhZB/9RWF/vmZoZa8OmAMJy9YdQhV1XonD9A+yNAPRWoy+IZUj9FOOwp8/7tTS6POW42pXrOGJnXqKR/0yyMopLJeDHIYJIngxbjCkr/mm0/DZ3AqUsXCtei+W6PQgX9bVxDOgkeiSFNJEjAeAKsSxUN4duV0GwxSIcys4f6XwQFjTnT2pzB8QubBJ6jDh2kVGV6SVnfYUhvl3dffgpZ2A/Fbob9pnticeo/d+k12NzSITPPfp8HfAa1d5J4fgL/nSIlInypJb2zxHOg5/TxFEe7UuuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3vi6fMoto5C61seTyHli6jpOjS3Tna7OttLmbp1CYo=;
 b=iJrRcm10TbbzWp4vuzt7EdI3wPuGEPeKzSHOJ1m+pECFvq1N+ehCkHCbyqswdePMucWEbvGIfRe2R9woPgTewhzbvYrxN35mOiB54CnN2B9xfCcEkVajyQOg4KqA75782ZD2Wd4AWb/Jk7Q3B1ofdoj7jbRqnn8qDYsqPIYeam72PgDR30UlHF1O0LkwDjWR5LZ+mVRbVMfKAjN9AAnhpDFFFuBZntCSvlBNvdeK5ybfWvIq1bRPBN1bnPIDoJGXGFkjHVXAIpd0HNzqyxMxe+OlDHn2bTs6gjTfmWP3negJ6ZvpboUZMWMkgEkDUVfshZPR9+3hLj4bwZc5eU7ucg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3vi6fMoto5C61seTyHli6jpOjS3Tna7OttLmbp1CYo=;
 b=tQdoeCyLvfUhvaSJmivi7aYli7BrQLK9qH8uwBWFDnb+HSyzuGUWraL0P5WgYkOOALle4S9dEGxhd/RKOLH7nmj1y6t+9TbANdb6gV7si/+NaYfOYxh75QISI8SsBpxsoJKP9W92nWKfSHmzPMZxnau6wgsZSFIpr5cNoZfal+U=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AS8PR08MB10223.eurprd08.prod.outlook.com (2603:10a6:20b:629::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 08:48:00 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559%4]) with mapi id 15.20.6455.043; Mon, 19 Jun 2023
 08:48:00 +0000
Date:   Mon, 19 Jun 2023 09:47:45 +0100
From:   "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Cc:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Eranian, Stephane" <eranian@google.com>, nd@arm.com
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Message-ID: <ZJAWMSLfSaHOD1+X@arm.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-24-rick.p.edgecombe@intel.com>
 <0b7cae2a-ae5b-40d8-9ae7-10aea5a57fd6@sirena.org.uk>
 <87y1knh729.fsf@oldenburg.str.redhat.com>
 <1f04fa59-6ca9-4f18-b138-6c33e164b6c2@sirena.org.uk>
 <49eabafa97032dec8ace7361bccae72c6ecf3860.camel@intel.com>
 <fc2ebfcf-8d91-4f07-a119-2aaec3aa099f@sirena.org.uk>
 <a0f1da840ad21fae99479288f5d74c7ab9095bb6.camel@intel.com>
 <ZImZ6eUxf5DdLYpe@arm.com>
 <64837d2af3ae39bafd025b3141a04f04f4323205.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <64837d2af3ae39bafd025b3141a04f04f4323205.camel@intel.com>
X-ClientProxiedBy: LO4P265CA0128.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::16) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|AS8PR08MB10223:EE_|DBAEUR03FT027:EE_|PAVPR08MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: 283f0f5a-3dcf-4f6c-3768-08db70a1e95d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: CMU9sAtp3NuKsHgHHBktjXYqL4axXNcny9ARcq1tisjHiJBaH4R57v0gAK77/PHgCUHeadDuRnkbfxFSO44fu1FKZeJlDinq6yvPB/kkuQrmbLZDHAFipyAQ5R9TdTW8rJ/jF6frZS9KUE7EqX2delBgJqNVd0FeLRgkewVjdfSERo4HTK04UkMB95T1tuEEqCDso69eRZ2TU4Wa4VWGTbckwHUHc6qjmqIX+cpuAEaR9QlqpOQwUfuAHlQ8FrzYCXbxRg54hYUFQSS4pqktSQKGsfwVps0d9x5s/g8l9CWBgad9xAdW50IuvWJenCcqt9XrMNy35mx7I+LkT+Fle/a1XV4frDmEleso31p8+uEh/sFa+rRMx3eS8hOpdKOqy71B/Hg8y0JRRsAgYtNB6cRfEdZ2atKvdX1lSdRyScxQMQkxzbcA7yfbZto+edabcmBGgsaNB9Hr6SYbiXLYgQ+IoQ62KLdNXpPthMMPYykW4sBkr+V3Ai2xYoBIBKhotZp5tGJktB2mYq18v5P5ty4n3CF6K9avUTtXYv++dJpqbGeeu/3tILCilINwEQmxNrBXUgN4MJ5yArC914zum4HOC59hwL31TrvxgM2tkM8=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199021)(186003)(8676002)(8936002)(66946007)(66556008)(66476007)(66899021)(5660300002)(110136005)(54906003)(4326008)(6666004)(6486002)(316002)(38100700002)(478600001)(41300700001)(36756003)(966005)(26005)(6506007)(6512007)(7406005)(7416002)(86362001)(2906002)(83380400001)(2616005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10223
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT027.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 21f74845-71a3-40f7-5d6d-08db70a1e2cc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cU5628zAVrdZOncMv0v3pifNVhc/bPRdEtPB0HDaEU3vmQSP/i6j8zjkP5XuM4X7y04EatA5W16fixLKILp8of0Ynk9bhnDX4gG53/WxCtGMsZjss+wnrGf/S0SNOJeIZcssNbaqBb9maFuu43UlxZz8mD9T46781a0XO6dCphKYaJ4n6SPHr3CwREsa4e3Rwiv7WbNmDba0bBBflSW4fyoGqIM8603VjICiauTZXe2AYJe8SHCPLCpF1E3hMakHRrM5SXJNew1Q3WB06pPAdWA4nMZBYrlLtujlzFkd4sCBKeCsTq/msti4P9iLvb/LPTRKlK0IKfkO/IaJO12o6H1D9EF0C8Th/tSq8KfBQdvLsORV7h4xT2YiFdi2/hepQQN3NggfOk9l71bbQBZOZPWCLcPk44/XbuzuNar7KgGK3JLB5Wt2jWPOkbx6cpqQNk1Z+fcbZdkBWRyuv4UDnESzOnVlZRG23i7IlHAeq2X26T5IwAJzgENBUAw9pzCeP4EUzVt8VeAha5Sr4UeksaF1Gwji5AFySHR1CzxugmoOQ7uduphxY3LbAeVceKZf+MnOXvjHHV0AnBk7xCp8jaD/P2iWj7dLK7MUfjd3nXHqfmj0nt3/2DIKrbz40ISCJkrmUuID8XWHGBKTy8bX6hbexTdskUBjUQsuvW26KqhmAyYdi8S0y4vLOW+UFUc1oT/EMD52u39eWe+bw2ivH/oApiGQ1hFO/GUENRoyUxssNADCO2R+4I2NMKWTaaM/
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(186003)(82310400005)(70206006)(8676002)(70586007)(8936002)(82740400003)(66899021)(5660300002)(110136005)(54906003)(40460700003)(4326008)(6666004)(6486002)(316002)(478600001)(41300700001)(36756003)(966005)(26005)(6506007)(6512007)(40480700001)(450100002)(336012)(356005)(81166007)(47076005)(86362001)(2906002)(83380400001)(36860700001)(2616005)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 08:48:10.9990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 283f0f5a-3dcf-4f6c-3768-08db70a1e95d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT027.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9089
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 06/14/2023 16:57, Edgecombe, Rick P wrote:
> On Wed, 2023-06-14 at 11:43 +0100, szabolcs.nagy@arm.com wrote:
> > i dont think you can add sigaltshstk later.
> > 
> > libgcc already has unwinder code for shstk and that cannot handle
> > discontinous shadow stack.
> 
> Are you referring to the existing C++ exception unwinding code that
> expects a different signal frame format? Yea this is a problem, but I
> don't see how it's a problem with any solutions now that will be harder
> later. I mentioned it when I brought up all the app compatibility
> problems.[0]

there is old unwinder code incompatible with the current patches,
but that was fixed. however the new unwind code assumes signal
entry pushes one extra token that just have to be popped from the
shstk. this abi cannot be expanded which means

1) kernel cannot push more tokens for more integrity checks
   (or to add whatever other features)

2) sigaltshstk cannot work.

if the unwinder instead interprets the token to be the old ssp and
either incssp or switch to that ssp (depending on continous or
discontinous shstk, which the unwinder can detect), then 1) and 2)
are fixed.

but currently the distributed unwinder binary is incompatible with
1) and 2) so sigaltshstk cannot be added later. breaking the unwind
abi is not acceptable.

> The problem is that gcc expects a fixed 8 byte sized shadow stack
> signal frame. The format in these patches is such that it can be
> expanded for the sake of supporting alt shadow stack later, but it
> happens to be a fixed 8 bytes for now, so it will work seamlessly with
> these old gcc's. HJ has some patches to fix GCC to jump over a
> dynamically sized shadow stack signal frame, but this of course won't
> stop old gcc's from generating binaries that won't work with an
> expanded frame.
> 
> I was waffling on whether it would be better to pad the shadow stack
> [1] signal frame to start, this would break compatibility with any
> binaries that use this -fnon-call-exceptions feature (if there are
> any), but would set us up better for the future if we got away with it.

i don't see how -fnon-call-exceptions is relevant.

you can unwind from a signal handler (this is not a c++ question
but unwind abi question) and in practice eh works e.g. if the
signal is raised (sync or async) in a frame where there are no
cleanup handlers registered. in practice code rarely relies on
this (because it's not valid in c++). the main user of this i
know of is the glibc cancellation implmentation. (that is special
in that it never catches the exception so ssp does not have to be
updated for things to work, but in principle the unwinder should
still verify the entries on shstk, otherwise the security
guarantees are broken and the cleanup handlers can be hijacked.
there are glibc abi issues that prevent fixing this, but in other
libcs this may be still relevant).

> On one hand we are already juggling some compatibility issues so maybe
> it's not too much worse, but on the other hand the kernel is trying its
> best to be as compatible as it can given the situation. It doesn't
> *need* to break this compatibility at this point.
> 
> In the end I thought it was better to deal with it later.
> 
> >  (may affect longjmp too depending on
> > how it is implemented)
> 
> glibc's longjmp ignores anything everything it skips over and just does
> INCSSP until it gets back to the setjmp point. So it is not affected by
> the shadow stack signal frame format. I don't think we can support
> longjmping off an alt shadow stack unless we enable WRSS or get the
> kernel's help. So this was to be declared as unsupported.

longjmp can support discontinous shadow stack without wrss.
the current code proposed to glibc does not, which is wrong
(it breaks altshstk and green thread users like qemu for no
good reason).

declaring things unsupported means you have to go around to
audit and mark binaries accordingly.

> > we can change the unwinder now to know how to switch shstk when
> > it unwinds the signal frame and backport that to systems that
> > want to support shstk. or we can introduce a new elf marking
> > scheme just for sigaltshstk when it is added so incompatibility
> > can be detected. or we simply not support unwinding with
> > sigaltshstk which would make it pretty much useless in practice.
> 
> Yea, I was thinking along the same lines. Someday we could easily need
> some new marker. Maybe because we want to add something, or maybe
> because of the pre-existing userspace. In that case, this
> implementation will get the ball rolling and we can learn more about
> how shadow stack will be used. So if we need to break compatibility
> with any apps, we would not really be in a different situation than we
> are already in (if we are going to take proper care to not break
> userspace). So if/when that happens all the learning's can go into the
> clean break.
> 
> But if it's not clear, unwinder's that properly use the format in these
> patches should work from an alt shadow stack implemented like that RFC
> linked earlier in the thread. At least it will be able to read back the
> shadow stack starting from the alt shadow stack, it can't actually
> resume control flow from where it unwound to. For that we need WRSS or
> some kernel help.

wrss is not needed to resume control flow on a different shstk.

(if you needed wrss then the map_shadow_stack would be useless.)

> 
> [0]
> https://lore.kernel.org/lkml/7d8133c7e0186bdaeb3893c1c808148dc0d11945.camel@intel.com/
> 
