Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68977382DA
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jun 2023 14:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjFULhE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jun 2023 07:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbjFULgz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2023 07:36:55 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749481706;
        Wed, 21 Jun 2023 04:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arRt+vGCv2qyqFgpjFPzNfg8B5jAF90AAzcu6NzF5yA=;
 b=NouoLpz76E1om2W+bYAFfBz6w5XQW+IVRctAPlYzcS0o9wWnvKxqwpwYiEM7vk0M6zMMfTEajbZWJTll0NIW5hQ5nRt6jXNljwzIQKcxb+k7xAaTAQVBGKBPX5Js1frXvas8IbCZaXs703cCtuLOrp2IOwBT1umGQJ1cWSoYD0E=
Received: from AS9PR06CA0527.eurprd06.prod.outlook.com (2603:10a6:20b:49d::27)
 by GV2PR08MB9232.eurprd08.prod.outlook.com (2603:10a6:150:d9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 11:36:37 +0000
Received: from AM7EUR03FT006.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:49d:cafe::ad) by AS9PR06CA0527.outlook.office365.com
 (2603:10a6:20b:49d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Wed, 21 Jun 2023 11:36:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT006.mail.protection.outlook.com (100.127.141.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23 via Frontend Transport; Wed, 21 Jun 2023 11:36:37 +0000
Received: ("Tessian outbound 546d04a74417:v142"); Wed, 21 Jun 2023 11:36:36 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 509d84184603b17e
X-CR-MTA-TID: 64aa7808
Received: from 75faade6b654.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A9616377-EC36-459A-BBE9-E4C8722E49E5.1;
        Wed, 21 Jun 2023 11:36:29 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 75faade6b654.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 21 Jun 2023 11:36:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLkmc/9hvdDspXs9ZuAXtXWuVgLKPc5sraOO+xOyWGLC3vLQzUmwXEpGyDnFW454pqKuX74JirZdt7KV4msW5J9KYJ0oqGpWXZpb8gOMqc86UCFP1QH9Pn7gcV1xqbnIgd6ZwAT8KnurQRmeuvmr8EPnv0kn/7Sc6F+dcOUF1SeDa3viusCJP0hMGvrtg8bVF7Atd7oLpLgOxkhLRvmWt7UK2QtqsnRMyW1/6jEr0J3kTqJFYLSb3Qea9DH5KOzFXQOTTlu+Iljvak1hqWZnf2zK4qeHT85vHZwWAkywUk9hBHSqMoUFx7pW0algDZzcRK9eoZMHz7IBk9WkM8b6Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arRt+vGCv2qyqFgpjFPzNfg8B5jAF90AAzcu6NzF5yA=;
 b=B3+1v1v6sUOBPPE8FRSJSoS0CFhm2QWR1XWz3mgBeZ4Z9zaAvzvtEhFnPbf1XgHa443nH+7vhQhGAmtvKPg5WGNoY8HOj8Rb8NOk48imnbiA8q8D5gR8fUhm6lBI4UMdure1F5dXENYnvTHiqDfzH4vqgzeffO56dEZoZPD20T7XGxeOifHTHj/nHecglU43W8HvQaP01k6WBG33WPnJ81xKX9EjM7GhgwyNk1uSetIiVJAxOCw7l3rNXo6hzjXd+sRV4HYIsZRkWCw8gNNcAMjGrf2U/EhmzwA4jT3l2tcdnlYgRQgeQNvO1cXexKBTDw/P/G+uYjCA/JTYsgTZPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arRt+vGCv2qyqFgpjFPzNfg8B5jAF90AAzcu6NzF5yA=;
 b=NouoLpz76E1om2W+bYAFfBz6w5XQW+IVRctAPlYzcS0o9wWnvKxqwpwYiEM7vk0M6zMMfTEajbZWJTll0NIW5hQ5nRt6jXNljwzIQKcxb+k7xAaTAQVBGKBPX5Js1frXvas8IbCZaXs703cCtuLOrp2IOwBT1umGQJ1cWSoYD0E=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AS2PR08MB9620.eurprd08.prod.outlook.com (2603:10a6:20b:607::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 11:36:24 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559%4]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 11:36:24 +0000
Date:   Wed, 21 Jun 2023 12:36:07 +0100
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
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nd@arm.com" <nd@arm.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Message-ID: <ZJLgp29mM3BLb3xa@arm.com>
References: <1f04fa59-6ca9-4f18-b138-6c33e164b6c2@sirena.org.uk>
 <49eabafa97032dec8ace7361bccae72c6ecf3860.camel@intel.com>
 <fc2ebfcf-8d91-4f07-a119-2aaec3aa099f@sirena.org.uk>
 <a0f1da840ad21fae99479288f5d74c7ab9095bb6.camel@intel.com>
 <ZImZ6eUxf5DdLYpe@arm.com>
 <64837d2af3ae39bafd025b3141a04f04f4323205.camel@intel.com>
 <ZJAWMSLfSaHOD1+X@arm.com>
 <5794e4024a01e9c25f0951a7386cac69310dbd0f.camel@intel.com>
 <ZJFukYxRbU1MZlQn@arm.com>
 <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
X-ClientProxiedBy: LO6P123CA0049.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::9) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|AS2PR08MB9620:EE_|AM7EUR03FT006:EE_|GV2PR08MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cfd04e9-c11a-4b06-a35b-08db724bc60e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: K/pxmpyfEStWj0nR+csHUoYu4HNosyu5UYS4GMTAsApBSkeOKAG2ut087l1D8xH3kpYduokN6xMvwTRSikZ7kRKQHXg53dY/sfXTJaHhluOwQxai36p1ZBrJdVA0d490dqJG1/PmFiU7sYsNs483FViOSdINiDsOi35ta3GnTHHKqWKa/mBHYcNTx8UU0wBDon9KcIz8FpQtjl/FoBrBz3Ar1QNI3CEExKUGeMmI/ErYotcSKsyRrj6EWRmyNqPiFbzF2GVUHIUmVal9xHjqJNKNHNJ9VFyIkXWJ4spvo/1cDFBzorZFG1ybH+tSbbGC0Htr1gwOVvE6VdwAVzvNC9DFKaMMy6/+KirJ1zEWm8Au5EaIUqoRadQw0FH+YriyH8K5p4C29XdYEBV3b4KfChox0LKoz3Tda1soeix7Vv5bmqUKlbzh1hbwYyHAARhxC46ZQsEdKL32Q8ZBSZHr51DZC0/KI7wRqEYgYSs0NiQSFdaU4MLgWXK3lugF3LJ6Q4NXmsJdvgRqH7jNY0OuSRuCPb8OUVfr5A46g2APr94Y2zUH1d7s+ljg2NusRo/X
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199021)(316002)(5660300002)(8676002)(4326008)(2906002)(8936002)(7416002)(7406005)(110136005)(54906003)(66946007)(66556008)(66476007)(41300700001)(66899021)(6486002)(6666004)(478600001)(186003)(83380400001)(2616005)(26005)(6512007)(6506007)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9620
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT006.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: bde16cd4-0a67-4a11-1d54-08db724bbe30
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oOIvmXeTRRPJMpfA1i1QUC/l6OlmgP29DLX4JLm0lWz9i8vR7LM+lh/rojIgVRWqPlJRV3LWtAtWTazEupYYxe0APUambj2yH+HRPtdXAoMlhCt7blYVw9mbppF2ZYk2aeVcYENQ1hLhlxvopMmvyQrb08cbf/QQPAW0NaNl9ZGJ3vKkedQWkfvv/AuLnmqRrvPpip95iylgq6LIgdaB7JD9MidFcbU6K5aVT4gWfDpKJOqkoEOpxlLte7JUT4nNTDHVVE/nHK4s6v5JeFsesbIlVdorsLPUIPpV/AO1tHrrqw7HXtYvyBfoQbN0QK0NkiyFc4x+2nkSUo3qda8vAB6UKA5s5Ck4T6RPqdpoK3Ux24Q4/CdroM8JMOHV8ah6ZehDMHkDPNIBJWlOCIYt/FuakzVLvzyYA3oFd4EbBDbIXdqS1j+ahJJt4OEL+6KENu0PAssDsM+1e5TUmczrqb5oz8La6iaDnkvoti5iz8Vf4tX8S30zeF8UpLOX3RvJxHVjp60r6Qzl6BzC5QiQmvOrjfClY4xDzOofJPK1j1YEVOW9GlDKCeKa8xmrsKOHUH0Jp0LMq0jCeumB/DUe3gTlG0ubXPnjBvxMt/axN2X9cD9uivOGhsXKdVU/gPoBof+bi7iZRvJ7gW4F8cKFjbGGWqSD5RZbVxP+9kjJKHhmYf4/N6pWcV16JbvxGmja2Ldp5hf8UQtgrFQr2EZffcv6eB2bpedDWrO4Bnso+gbX+tc8/Va5yHViU5AtSs++
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(40470700004)(46966006)(36840700001)(2906002)(478600001)(2616005)(336012)(47076005)(5660300002)(8676002)(86362001)(36860700001)(83380400001)(316002)(70586007)(4326008)(356005)(41300700001)(70206006)(40460700003)(66899021)(81166007)(26005)(6506007)(8936002)(6512007)(186003)(107886003)(450100002)(82740400003)(36756003)(40480700001)(54906003)(82310400005)(110136005)(6666004)(6486002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 11:36:37.2925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cfd04e9-c11a-4b06-a35b-08db724bc60e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT006.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9232
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 06/20/2023 19:34, Edgecombe, Rick P wrote:
> On Tue, 2023-06-20 at 10:17 +0100, szabolcs.nagy@arm.com wrote:
> > if there is a fix that's good, i haven't seen it.
> > 
> > my point was that the current unwinder works with current kernel
> > patches, but does not allow future extensions which prevents
> > sigaltshstk to work. the unwinder is not versioned so this cannot
> > be fixed later. it only works if distros ensure shstk is disabled
> > until the unwinder is fixed. (however there is no way to detect
> > old unwinder if somebody builds gcc from source.)
> 
> This is a problem the kernel is having to deal with, not causing. The
> userspace changes were upstreamed before the kernel. Userspace folks
> are adamantly against moving to a new elf bit, to start over with a
> clean slate. I tried everything to influence this and was not
> successful. So I'm still not sure what the proposal here is for the
> kernel.

i agree, the glibc and libgcc patches should not have been accepted
before a linux abi.

but the other direction also holds: the linux patches should not be
pushed before the userspace design is discussed. (the current code
upstream is wrong, and new code for the proposed linux abi is not
posted yet. this is not your fault, i'm saying it here, because the
discussion is here.)

> I am guessing that the fnon-call-exceptions/expanded frame size
> incompatibilities could end up causing something to grow an opt-in at
> some point.

there are independent userspace components and not every component
has a chance to opt-in.

> > how does "fixed shadow stack signal frame size" relates to
> > "-fnon-call-exceptions"?
> > 
> > if there were instruction boundaries within a function where the
> > ret addr is not yet pushed or already poped from the shstk then
> > the flag would be relevant, but since push/pop happens atomically
> > at function entry/return -fnon-call-exceptions makes no
> > difference as far as shstk unwinding is concerned.
> 
> As I said, the existing unwinding code for fnon-call-excecptions
> assumes a fixed shadow stack signal frame size of 8 bytes. Since the
> exception is thrown out of a signal, it needs to know how to unwind
> through the shadow stack signal frame.

sorry but there is some misunderstanding about -fnon-call-exceptions.

it is for emitting cleanup and exception handler data for a function
such that throwing from certain instructions within that function
works, while normally only throwing from calls work.

it is not about *unwinding* from an async signal handler, which is
-fasynchronous-unwind-tables and should always work on linux, nor for
dealing with cleanup/exception handlers above the interrupted frame
(likewise it works on linux without special cflags).

as far as i can tell the current unwinder handles shstk unwinding
correctly across signal handlers (sync or async and cleanup/exceptions
handlers too), i see no issue with "fixed shadow stack signal frame
size of 8 bytes" other than future extensions and discontinous shstk.

> > there is no magic, longjmp should be implemented as:
> > 
> >         target_ssp = read from jmpbuf;
> >         current_ssp = read ssp;
> >         for (p = target_ssp; p != current_ssp; p--) {
> >                 if (*p == restore-token) {
> >                         // target_ssp is on a different shstk.
> >                         switch_shstk_to(p);
> >                         break;
> >                 }
> >         }
> >         for (; p != target_ssp; p++)
> >                 // ssp is now on the same shstk as target.
> >                 inc_ssp();
> > 
> > this is what setcontext is doing and longjmp can do the same:
> > for programs that always longjmp within the same shstk the first
> > loop is just p = current_ssp, but it also works when longjmp
> > target is on a different shstk assuming nothing is running on
> > that shstk, which is only possible if there is a restore token
> > on top.
> > 
> > this implies if the kernel switches shstk on signal entry it has
> > to add a restore-token on the switched away shstk.
> 
> I actually did a POC for this, but rejected it. The problem is, if
> there is a shadow stack overflow at that point then the kernel can't
> push the shadow stack token to the old stack. And shadow stack overflow
> is exactly the alt shadow stack use case. So it doesn't really solve
> the problem.

the restore token in the alt shstk case does not regress anything but
makes some use-cases work.

alt shadow stack is important if code tries to jump in and out of
signal handlers (dosemu does this with swapcontext) and for that a
restore token is needed.

alt shadow stack is important if the original shstk did not overflow
but the signal handler would overflow it (small thread stack, huge
sigaltstack case).

alt shadow stack is also important for crash reporting on shstk
overflow even if longjmp does not work then. longjmp to a makecontext
stack would still work and longjmp back to the original stack can be
made to mostly work by an altshstk option to overwrite the top entry
with a restore token on overflow (this can break unwinding though).

