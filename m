Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD82750369
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jul 2023 11:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjGLJk6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jul 2023 05:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjGLJkz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Jul 2023 05:40:55 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B13B1718;
        Wed, 12 Jul 2023 02:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZV3aCldftQVbgDjmhgdYU3AxdEUrufALszFAvm1zb1I=;
 b=p9ZorpoIXzEi/b9hrkgbTcmt/Gd+IB/61orAceMcJFEcImekwgSJqNEaR67vJdImWsJBbkXimSTiophkSq2plZHZK1gjRucIYOdw18ClmIC3KckzwZFUupTXV2loNYcEsqlTOy5OSMPJCpk7SYh+G8xiYukA4meD4aDf3UrZ5g4=
Received: from AS9PR05CA0029.eurprd05.prod.outlook.com (2603:10a6:20b:488::8)
 by DU0PR08MB8232.eurprd08.prod.outlook.com (2603:10a6:10:3b2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 09:40:50 +0000
Received: from AM7EUR03FT052.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:488:cafe::1a) by AS9PR05CA0029.outlook.office365.com
 (2603:10a6:20b:488::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 09:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT052.mail.protection.outlook.com (100.127.140.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 09:40:50 +0000
Received: ("Tessian outbound 997ae1cc9f47:v145"); Wed, 12 Jul 2023 09:40:49 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8d3069a0fdc03f10
X-CR-MTA-TID: 64aa7808
Received: from 2d3e748b3625.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D1367353-8D9E-4EF6-B689-A50480162F7D.1;
        Wed, 12 Jul 2023 09:40:40 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 2d3e748b3625.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 12 Jul 2023 09:40:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m77/Y9J2ZcZjhbuXTsd+VbYNipH+VKxAuXkPs+X+iP5jcw2QrKu7dKO83bM10Xqb+mYVfQL4W1ZA8qqktlA7qzqC5ZuueYitLUYP912qbZKUZv6BK3OWv458xYmsl/QUHGEoRPexd4nQ8+NtAwm49GgrEvBxl+kkSn/3u/+qDC7m6XeypFHTZXTF3Yjl3u7GwlGEKiww/0koOXcT4jdarJMNBXInld1St0jNFtDdfzAVO5akLmbAPGWytfH3lc7M6HtVzPgmftr+o4z4ifOxW/QwH4+GHyfYrBBl3MkmTeQ1vOl+LXn6VpGYFWqLjxGerI3ywczqu0vrz84zJxgwaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZV3aCldftQVbgDjmhgdYU3AxdEUrufALszFAvm1zb1I=;
 b=OTBgNZureOvRS43FUqAeXFM+mko1KY13APJjpNY6L/3OyoGFm0rTeRIJK5oUrZ2g5QHfP/33CFjnlLguGokDYG4tMNQlVvtf6+htkhoPm3BOdgcAwPRx1qqUo49vZAlex6z4JKKW1MuG7/jcXACNodFSvwf8vSCRFMOk9fqBtCFJ/GUQpX0pz1d9vFZDCr0HfXmdICyOWArxFu5X4L7ngWLwjbS88xVOEjYtYruL0mvCFaF55TTZAMm6Ld340Fh6FAopRdaWS7mdCU00MvnY64iyC9AeJhISPBWvJTZXKPWAh7GKorxGzCdNm3EPQl2CNTCd5cmbhD8rEHXbg2CasA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZV3aCldftQVbgDjmhgdYU3AxdEUrufALszFAvm1zb1I=;
 b=p9ZorpoIXzEi/b9hrkgbTcmt/Gd+IB/61orAceMcJFEcImekwgSJqNEaR67vJdImWsJBbkXimSTiophkSq2plZHZK1gjRucIYOdw18ClmIC3KckzwZFUupTXV2loNYcEsqlTOy5OSMPJCpk7SYh+G8xiYukA4meD4aDf3UrZ5g4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by GV2PR08MB9325.eurprd08.prod.outlook.com (2603:10a6:150:d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 09:40:36 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559%4]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 09:40:36 +0000
Date:   Wed, 12 Jul 2023 10:39:57 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
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
Message-ID: <ZK507ULSUcWB2YK8@arm.com>
References: <e057de9dd9e9fe48981afb4ded4b337e8a83fabf.camel@intel.com>
 <ZKMRFNSYQBC6S+ga@arm.com>
 <eda8b2c4b2471529954aadbe04592da1ddae906d.camel@intel.com>
 <ZKa8jB4lOik/aFn2@arm.com>
 <68b7f983ffd3b7c629940b6c6ee9533bb55d9a13.camel@intel.com>
 <ZKguVAZe+DGA1VEv@arm.com>
 <1c2f524cbaff886ce782bf3a3f95756197bc1e27.camel@intel.com>
 <ZKw3zSKxCug0IbC1@arm.com>
 <1c0460a2042480b6a2d4cc1f6b99b27ab1371f3a.camel@intel.com>
 <ZK0N65CEAd8HMOjm@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZK0N65CEAd8HMOjm@arm.com>
X-ClientProxiedBy: SN7PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:806:f2::21) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|GV2PR08MB9325:EE_|AM7EUR03FT052:EE_|DU0PR08MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: 33bb6d7c-7c3a-439b-e6dd-08db82bc13f9
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ar+QQA7AA/TBEWvghhB3gTXasXN1nLNP5nGaswVFM8SApLNZDm5FHyXPaLu6KM9O2goOFYsTjcCilM4+s5m/OBnPnJfCLXU6auNqmOWZhBnwJ6qDw1iYo2dc/S+5eQoiZqLlZ+I28hicHNcrfinqx1p2JUPF7Kilgt5tBDzGmiqp9SExdRyErvQ5khLf7TlyyaYTx5uyY7a8GAY01Z1cJ9z+4SllclWILvEtWMPRHal/s+pxtK/Qa3H3Uz4VGghlQLR79Zp/Bs7jUsgFvQV2Wlb5Ivb/PukdSRYUG1u52y22iXx+tLMY3+AbOc4YkfFlrLSEyIFNN6zhzxuUZ6nx9k8WA4+i5sOzCOMRhSPutHWQVw0UZOtfthtiKj+8+eFjKG9/C1XQ8qEa6RkvwI9VEdr0jgvuHvErU2hZw/75VSDdxxndg8E8Imr99OtRwWfzMUu2e11Gd3etsszt3fX2CpR3hqBQPZKIXYklf9sOx72VBZ/otEWl2jO80JtvXphNqHx3GIHYcKNS2VAsCCuFrGgoRcA75lYv5Z34i1KRy+it27nFJPKQOvwkCpf+KkFN
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199021)(6666004)(6486002)(478600001)(83380400001)(86362001)(6512007)(4326008)(66946007)(66556008)(54906003)(66476007)(6506007)(26005)(186003)(38100700002)(110136005)(2616005)(5660300002)(7406005)(7416002)(44832011)(316002)(8676002)(8936002)(2906002)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9325
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT052.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d53b521a-163d-410f-c705-08db82bc0b4e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2/acKso8LEg+MDVXCeWGuseMCZXJVUVGJyenJivJcMYhrUe3uUTYf1cPcWQO/OkDcoFIkL6hsXKt2cvARFN9A+2PJ/rN2OLVy8wPYg5z1WuaJMdPq+bKtRnuCkSAjH1RQ2qzwPT7jRn/redkDdV++zha4vLCCM6GDsNcPHy+7Hb2NkjhYM8mH4kFDY+Nrj01zSNzBdg2M/l1o0Vb0jWBoYK3kK7JlgCpS+S9xmwuO0akaKGxwhjxaaH+aoNjbZpq5q4oiYeAnNs7rZPDfGj7EQ+gbLVOwwMqdU+g5x1NiPZ6tADZUX84cg2iD3X2LJiw7Jbi76HK2O7NWhkdwPNymZjhqNI9EAwLwBd1kCbcwuNOrvcfp8f++lyuFaBMO+Pgg0oCjJIalXLE7GQ5vrhjo6YqeJX7SUxlcqq0c2CDvVwPLOfPshhz6+lGJBlMxdTyoRQhyyJ6Mr1+/7ZniZIZN/lpyI3mewhzvIlioAhZuwIWo/FeB1wz48X8U3ZtCzXLQBbevUIFct+gs7J1CPEmBek+x8MvOExPIpQ0Yxn/zTat4dUG6w12UdvG3XyBz6Gwf5SCaMSDWvR8eVq6Tam1wMiBPnpG080XM//ZYBKHsUKHmSkmOzLMrL/1EHc3KQBfj66WRjZmbgZ+ed7TRrgLGt33rHbReejWRbvzz8U2+vyuLqX9HY8TemIjPg9I6m6jyLbPr2lz3kJntiDr+L0JdO2fGQngI3RS3VZa29yv+8YzivbnEuCYVRJ21tVU9DXD
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(186003)(26005)(6506007)(6512007)(336012)(2616005)(5660300002)(83380400001)(4326008)(44832011)(8936002)(478600001)(47076005)(36860700001)(41300700001)(2906002)(316002)(8676002)(70586007)(54906003)(450100002)(70206006)(110136005)(40480700001)(36756003)(6666004)(6486002)(356005)(81166007)(82740400003)(82310400005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:40:50.2570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33bb6d7c-7c3a-439b-e6dd-08db82bc13f9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT052.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8232
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 07/11/2023 09:08, szabolcs.nagy--- via Libc-alpha wrote:
> the decision is for x86 shadow stack linux abi to use
> 
>   shadow stack size = stack size
> 
> or
> 
>   shadow stack size = stack size + 1 page
> 
> as default policy when alt stack signals use the same
> shadow stack, not a separate one.
> 
> note: smallest stack frame size is 8bytes, same as the
> shadow stack entry. on a target where smallest frame
> size is 2x shadow stack entry size, the formula would
> use (stack size / 2).

i convinced myself that shadow stack size = stack size
works:

libc can reserve N bytes on the initial stack frame so
when the stack overflows there will be at least N bytes
on the shadow stack usable for signal handling.

this is only bad for tiny user allocated stacks where libc
should not consume too much stack space. but e.g. glibc
already uses >128 bytes on the initial stack frame for its
cancellation jumpbuf so 16 deep signal call stack is
already guaranteed to work.

the glibc makecontext code has to be adjusted, but that's
a libc side discussion.

the shadow stack of the main stack can still overflow, but
that requires increasing RLIMIT_STACK at runtime which is
not very common.
