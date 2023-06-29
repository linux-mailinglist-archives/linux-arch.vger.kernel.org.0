Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D00742A44
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jun 2023 18:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjF2QIP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jun 2023 12:08:15 -0400
Received: from mail-db8eur05on2088.outbound.protection.outlook.com ([40.107.20.88]:61472
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232035AbjF2QIK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Jun 2023 12:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htpwCZPSKbFK/lAh6xoU7JNipvvRjPsm+GUSNR3AFq8=;
 b=U+f/6QxfqNq8akJ0U9oyw5cg7UFNTPcb4r5DK301oTbF6ga5oSTGpTQ4F9mhqEC/B225ZHcrwnsX1BTgLfNfdCEyjW6dV6t0ZFlJgB7dUSvLBuohQGwS7GHByLc8TaL2qeHpC3mfdAESI263W3P9mJBkvninbvz8qNkBNgKbAx0=
Received: from DB7PR05CA0067.eurprd05.prod.outlook.com (2603:10a6:10:2e::44)
 by AS8PR08MB10077.eurprd08.prod.outlook.com (2603:10a6:20b:63e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 29 Jun
 2023 16:08:07 +0000
Received: from DBAEUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:2e:cafe::e1) by DB7PR05CA0067.outlook.office365.com
 (2603:10a6:10:2e::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.20 via Frontend
 Transport; Thu, 29 Jun 2023 16:08:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT004.mail.protection.outlook.com (100.127.142.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.20 via Frontend Transport; Thu, 29 Jun 2023 16:08:07 +0000
Received: ("Tessian outbound c08fa2e31830:v142"); Thu, 29 Jun 2023 16:08:07 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 18bc51183e159456
X-CR-MTA-TID: 64aa7808
Received: from 7277d59e5d02.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F086B373-8C7E-46A5-BCBC-57607F88F16F.1;
        Thu, 29 Jun 2023 16:08:00 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7277d59e5d02.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 29 Jun 2023 16:08:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOoVEqTG8I5SvC8AK/Km+IUevE1Oxr4XHMlcqrALzlbTc3Ts0M0KJJf3iLhDg97mEtychYl7dCUPR5DqWUzF210Jwna7jxxPNUgshIwlbaBDKcLP0f0jNWEeWLKX26e3VpihBsJBk0PHNtOZ/J7+4fP3zvk76ZAGYdZy+KvItbFXRNIggoICGiLo1HI+ToennIL6m896HhgsM/mZNT6IiAcYFLvi4CUikWWDLgnPI4TZw/+Y3c2xenbwST+1yVJum5nwCvnVdFHy62/eEx0fDmyXre5XIFvKxLDWmYCTh6jWTS7kctMVmdqXbWQgw8MbTpJD5giP3vbnj/LKOoFuHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htpwCZPSKbFK/lAh6xoU7JNipvvRjPsm+GUSNR3AFq8=;
 b=lDm1LnbpTlVslGnEWPYh+s/8imwRBohlM8XCm1iP0Tqqq+WluX0XYh0N9fj/di9iK/ZbCvpBcRH/Qfm7acmwInd3cJqVyHuCcgePFXz/XiTh8cVnxg7IYQnCojr63aBx+tSiAWD/fOlGQTg2hNEjnh7iMcaG0q+PpbkKX7Zeww1TL12klityabgwG+T3t9J3jlaPSX/VIMqVKkjsHJhFaGTT0ip11V88m9Y5/K6QylWPt0pYQE0rBTnVFZ5nomrJN+xJGouMRH7pu8J9JSCeCo9HW50SAMTgboidIsthqWvWSsUxChXXNoDyMvo78kfHjGHpxcyzi4KtU1cvUC3hTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htpwCZPSKbFK/lAh6xoU7JNipvvRjPsm+GUSNR3AFq8=;
 b=U+f/6QxfqNq8akJ0U9oyw5cg7UFNTPcb4r5DK301oTbF6ga5oSTGpTQ4F9mhqEC/B225ZHcrwnsX1BTgLfNfdCEyjW6dV6t0ZFlJgB7dUSvLBuohQGwS7GHByLc8TaL2qeHpC3mfdAESI263W3P9mJBkvninbvz8qNkBNgKbAx0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AS8PR08MB8442.eurprd08.prod.outlook.com (2603:10a6:20b:568::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.46; Thu, 29 Jun
 2023 16:07:57 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559%4]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 16:07:57 +0000
Date:   Thu, 29 Jun 2023 17:07:42 +0100
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
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "jannh@google.com" <jannh@google.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Message-ID: <ZJ2sTu9QRmiWNISy@arm.com>
References: <ZJAWMSLfSaHOD1+X@arm.com>
 <5794e4024a01e9c25f0951a7386cac69310dbd0f.camel@intel.com>
 <ZJFukYxRbU1MZlQn@arm.com>
 <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
 <ZJLgp29mM3BLb3xa@arm.com>
 <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
 <ZJQR7slVHvjeCQG8@arm.com>
 <CALCETrW+30_a2QQE-yw9djVFPxSxm7-c2FZFwZ50dOEmnmkeDA@mail.gmail.com>
 <ZJR545en+dYx399c@arm.com>
 <1cd67ae45fc379fd82d2745190e4caf74e67499e.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1cd67ae45fc379fd82d2745190e4caf74e67499e.camel@intel.com>
X-ClientProxiedBy: LO4P123CA0316.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::15) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|AS8PR08MB8442:EE_|DBAEUR03FT004:EE_|AS8PR08MB10077:EE_
X-MS-Office365-Filtering-Correlation-Id: 761ebab7-18bb-49c8-0740-08db78bb072d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: SuAiMI4pwQJkFTtkSCnZjVMeg2wIwzlDOnjwHCZJkUR9Jie4C0atK5k85Oh3r4ldi+oVJiCmqAQA0Ffp2OQ3rKvXLs/kgTv0OBSxJy0cT0zvUPFcGjg6QdrVu7VRojCmsj3rY2e/JWXSVzDqHfTLf6usIfMnH/zT9j8D205SpIBolfW2iY33/JnlGMgq/loR6ukjvEkpeYU1nT3PN+RQRYX4xzN0FYgXMzN1PCNkTxqDowiUq8UgGVfcUpcU66M1JCTy2ZGPinzbB7asnuEqW96QNj2Fvr6dnVEi6sGv2VveXwsvwlYGgn0luzE71J9geVELpNtzhRxKOpDf+nG9QxTOJXxdBl1VkE7Re/B9W4x6+GEVvmG45mZV5we+BZ9n5JBW77UoWD0yUTSAkkf9H2v9Ong6fJtUn1xPTyzo5qnRyr53+G0Tnl5TDEPgRfJLvYZolIf7gsOgg1r+KdzjF71V6aCuGuejwNJ8nyeNLR90cgSzaf220CqwtSFM4uSIu9+FE1G4J3KUtT1cQ8l+p/PppLXLMJXKEzW1GtBlST0RGqcNOLOZJzgamqystSqv
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199021)(66899021)(66476007)(6666004)(66946007)(66556008)(36756003)(4326008)(478600001)(54906003)(110136005)(86362001)(26005)(186003)(2616005)(83380400001)(7406005)(5660300002)(7416002)(2906002)(41300700001)(316002)(6486002)(38100700002)(6506007)(8936002)(8676002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8442
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT004.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b1adbf0b-af17-406f-05d1-08db78bb00ac
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qHyxqSVub8Y68ty/WIEsTI7+tmeRwd1nSXWw0AVF3NfiO9TNXxy/mXQEn+UQRbq4KHL6xNdS5GIwtDxeNDFl1uCY0H5HXN4qiChPP4HXNUPAtF/65ljHmhLH7xnOWZbPcvN0nMQvbV8AdmpORFncnfLCIaIa3emcQSSelL5g6RNWHbRU0ktxxCoomksEUOd3mKCnn1knNAaIL111kxGWjC2tFS9gCMFrVb2kfMRdQw5QpxKWJIApLxtYqboFh6lsI5mZ+U8ypb06tQ1Fc+l/B+VWBSYGZ5HCLz29p5tcuFCfuU46poKwWPszIi9xoubIn8+uODwvXv5IGuU2M29J0/DLCRNNSTVWQReiRe2PVQzy1sSlthwL6kZ8v+jZ1WCF9HeUnJwqU4EPn8xJBBQs04lMujrILszmxWBxv5bAkveYcvpKRlsTI19KwxW6bbBOb8pjmxc/Tlxtu6h9YgpYLmtWj4adNfrUii+ULyephXWWIwNGDo2p3IxfuhRU5eIT+aHPviKk6HKzHrnXqVumEjQKwsk1SsoVUgrbHKLubPs+5EphzARAf7sJ39WfRLwrfBH2x6FTjbqKJw/Q+EpDFA+D8V3TDCUwul9vZgg9xDY6UKlS8ZldnkcoHluOVvPMFtl5mMRU8r4B9xsoZzXo6dmbAX7FKVME1zpjh+/3/dDrnvGXYbc+SflDpTLfD9WZtNJDhUaKWgI3guqy85YVeljJ7Nbt0M8R5B1p3tMGbVUvCvqIlXJlfywQDQb5tyWw
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(5660300002)(450100002)(70586007)(316002)(478600001)(36756003)(4326008)(70206006)(6506007)(66899021)(8936002)(8676002)(86362001)(2906002)(6512007)(26005)(110136005)(54906003)(36860700001)(40460700003)(40480700001)(41300700001)(6666004)(6486002)(82310400005)(356005)(186003)(336012)(82740400003)(47076005)(107886003)(83380400001)(2616005)(81166007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 16:08:07.7509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 761ebab7-18bb-49c8-0740-08db78bb072d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT004.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10077
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 06/22/2023 23:18, Edgecombe, Rick P wrote:
> I'd also appreciate if you could spell out exactly which:
>  - ucontext
>  - signal
>  - longjmp
>  - custom library stack switching
> 
> patterns you think shadow stack should support working together.
> Because even after all these mails, I'm still not sure exactly what you
> are trying to achieve.

i'm trying to support two operations (in any combination):

(1) jump up the current (active) stack.

(2) jump to a live frame in a different inactive but live stack.
    the old stack becomes inactive (= no task executes on it)
    and live (= has valid frames to jump to).

with

(3) the runtime must manage the shadow stacks transparently.
    (= portable c code does not need modifications)

mapping this to c apis:

- swapcontext, setcontext, longjmp, custom stack switching are jump
  operations. (there are conditions under which (1) and (2) must work,
  further details don't matter.)

- makecontext creates an inactive live stack.

- signal is only special if it executes on an alt stack: on signal
  entry the alt stack becomes active and the interrupted stack
  inactive but live. (nested signals execute on the alt stack until
  that is left either via a jump or signal return.)

- unwinding can be implemented with jump operations (it needs some
  other things but that's out of scope here).

the patterns that shadow stack should support falls out of this model.
(e.g. posix does not allow jumping from one thread to the stack of a
different thread, but the model does not care about that, it only
cares if the target stack is inactive and live then jump should work.)

some observations:

- it is necessary for jump to detect case (2) and then switch to the
  target shadow stack. this is also sufficient to implement it. (note:
  the restore token can be used for detection since that is guaranteed
  to be present when user code creates an inactive live stack and is
  not present anywhere else by design. a different marking can be used
  if the inactive live stack is created by the kernel, but then the
  kernel has to provide a switch method, e.g. syscall. this should not
  be controversial.)

- in this model two live stacks cannot use the same shadow stack since
  jumping between the two stacks is allowed in both directions, but
  jumping within a shadow stack only works in one direction. (also two
  tasks could execute on the same shadow stack then. and it makes
  shadow stack size accounting problematic.)

- so sharing shadow stack with alt stack is broken. (the model is
  right in the sense that valid posix code can trigger the issue. we
  can ignore that corner case and adjust the model so the shared
  shadow stack works for alt stack, but it likely does not change the
  jump design: eventually we want alt shadow stack.)

- shadow stack cannot always be managed by the runtime transparently:
  it has to be allocated for makecontext and alt stack in situations
  where allocation failure cannot be handled. more alarmingly the
  destruction of stacks may not be visible to the runtime so the
  corresponding shadow stacks leak. my preferred way to fix this is
  new apis that are shadow stack compatible (e.g. shadow_makecontext
  with shadow_freecontext) and marking the incompatible apis as such.
  portable code then can decide to update to new apis, run with shstk
  disabled or accept the leaks and OOM failures. the current approach
  needs ifdef __CET__ in user code for makecontext and sigaltstack
  has many issues.

- i'm still not happy with the shadow stack sizing. and would like to
  have a token at the end of the shadow stack to allow scanning. and
  it would be nice to deal with shadow stack overflow. and there is
  async disable on dlopen. so there are things to work on.

i understand that the proposed linux abi makes most existing binaries
with shstk marking work, which is relevant for x86.

for a while i thought we can fix the remaining issues even if that
means breaking existing shstk binaries (just bump the abi marking).
now it seems the issues can only be addressed in a future abi break.

which means x86 linux will likely end up maintaining two incompatible
abis and the future one will need user code and build system changes,
not just runtime changes. it is not a small incremental change to add
alt shadow stack support for example.

i don't think the maintenance burden of two shadow stack abis is the
right path for arm64 to follow, so the shadow stack semantics will
likely become divergent not common across targets.

i hope my position is now clearer.
