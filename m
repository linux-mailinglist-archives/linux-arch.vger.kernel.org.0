Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BCC739CEE
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 11:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjFVJ2M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 05:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjFVJ1k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 05:27:40 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2043.outbound.protection.outlook.com [40.107.105.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8112A30ED;
        Thu, 22 Jun 2023 02:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5k7XCf5B1pDsHOAGX0ZIEyFrwYcrSyuWkj5C8WZaQro=;
 b=XnSHxi38T6oqoZlbI0Fy3inZ/aP3rEMQU2AMSsupz8Gfy30lSe5g5VIdfvHHk9Q2jftjWr54gEO8ivvK+6JNG7dvVKGjiO5kOX7xmzYUjYvr/Qv2hRXSFqa69xrg1mbKIEENmfvKe9eclh0DUMvbZrsRyMfYqlMzNqpYqY8rUOU=
Received: from AS4PR10CA0016.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::8)
 by PAWPR08MB8935.eurprd08.prod.outlook.com (2603:10a6:102:33f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 09:19:05 +0000
Received: from AM7EUR03FT018.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:5d8:cafe::aa) by AS4PR10CA0016.outlook.office365.com
 (2603:10a6:20b:5d8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Thu, 22 Jun 2023 09:19:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT018.mail.protection.outlook.com (100.127.140.97) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24 via Frontend Transport; Thu, 22 Jun 2023 09:19:05 +0000
Received: ("Tessian outbound e2424c13b707:v142"); Thu, 22 Jun 2023 09:19:04 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 99a5ce0491afae30
X-CR-MTA-TID: 64aa7808
Received: from 186d5a01a5ab.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C9F25E68-0F24-436B-B230-F0A839A556A7.1;
        Thu, 22 Jun 2023 09:18:57 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 186d5a01a5ab.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 22 Jun 2023 09:18:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WK+2Kbp3LSJcI+ePj0X1TBJyVLtdf1K2rc+i9m4d2xeP14+yXy8bGknQuGo9B3yGG1LEizWxHo+vbLeDrXUqqjK6Hmh9lNfG0BDS/QbBhk5WnYZKa80iOlCkq+94CDuQrPFSPBLllwmIvn3EcvX4OKqhGVMIEAetTVOOJH2Uhp1kRCCmoA5jtZTBa0qnvRdbs64Ti98gZJvqnKhn3QNlTWdPg4qi8GvHE1SWIzWzaFmDPivERc2SL0Yg2QtCgwTHC/QjPyCHf3PuFsmvMV/kYhSPybg1Ff67PcOeJQgcHQcX1KU6DiNGwk/S8UwrVxoFPJ2nbiubfVDpSRWo+yOqVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5k7XCf5B1pDsHOAGX0ZIEyFrwYcrSyuWkj5C8WZaQro=;
 b=OxJkCuVmggrgJXSKjMBy6CtVN7kGSMHK8bT1rEcnvCX2M09gLoufwmpS6X17o5szw+gDtsPRAAmbNyMInSYYfHSjN12Y+4An1LHcHUzISXZuB5QLqPHFqUpacideinBNg+1oxM+SvmQJwEGfpYV+ZbWa5HBcOEQo1cFPzK3POPRpv3AwcwpqSclMJ22a83le5FISGebA8Iesy15cvXdWxIGrv99lwKwSdObIH4jLMCdyWV/UDf7e/uc/L6OAQ/XXmH2fYKOF8NKzlKh790UpX7BHK9tZf22Gx+nalxEzfhQmDmb1T4DQAEsnU8ROmHX3Iib02IeOR+zt9oov5h7sVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5k7XCf5B1pDsHOAGX0ZIEyFrwYcrSyuWkj5C8WZaQro=;
 b=XnSHxi38T6oqoZlbI0Fy3inZ/aP3rEMQU2AMSsupz8Gfy30lSe5g5VIdfvHHk9Q2jftjWr54gEO8ivvK+6JNG7dvVKGjiO5kOX7xmzYUjYvr/Qv2hRXSFqa69xrg1mbKIEENmfvKe9eclh0DUMvbZrsRyMfYqlMzNqpYqY8rUOU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by GV2PR08MB7956.eurprd08.prod.outlook.com (2603:10a6:150:a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 09:18:52 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559%4]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 09:18:52 +0000
Date:   Thu, 22 Jun 2023 10:18:38 +0100
From:   "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Cc:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
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
Message-ID: <ZJQR7slVHvjeCQG8@arm.com>
References: <fc2ebfcf-8d91-4f07-a119-2aaec3aa099f@sirena.org.uk>
 <a0f1da840ad21fae99479288f5d74c7ab9095bb6.camel@intel.com>
 <ZImZ6eUxf5DdLYpe@arm.com>
 <64837d2af3ae39bafd025b3141a04f04f4323205.camel@intel.com>
 <ZJAWMSLfSaHOD1+X@arm.com>
 <5794e4024a01e9c25f0951a7386cac69310dbd0f.camel@intel.com>
 <ZJFukYxRbU1MZlQn@arm.com>
 <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
 <ZJLgp29mM3BLb3xa@arm.com>
 <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
X-ClientProxiedBy: LO4P265CA0036.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::12) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|GV2PR08MB7956:EE_|AM7EUR03FT018:EE_|PAWPR08MB8935:EE_
X-MS-Office365-Filtering-Correlation-Id: 3895ca1b-84d0-4bb9-8366-08db7301ba2c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: YRWnrzwfb2Ty0Xt5pefOZIW2muOzoSwEkzQcQGObdoSwsVEXZXZ7bGKjWu6/RtfWnxJnlc9Gh3VFQIebCAoaRraGv4SGEN7HPEB+/zTDXZEtYHA7HAHFT852ElBV9A9smbd+6nR2/fzoJoR17FNTj87ik6W4E1fnSf9NE3rGEipI3qWoVUdGTjEoS/2D/RPvJ8CJulOSL2IkFZ2bg2pCE7xqwrV2wgwC+SKFk3qK1/wkZPWz8V+p05TlkuteeuTwPj5ukAeQ5EZ7AvEi3EigguDlw2+ZN0w0AthmPKe8hjHac3zn/CeB37QqX5AHrKNSHGdrC4mAlnTQgdOJbZmevR55LN6UKkR4P4cpt3kF78CHvFrido8gZKjWmQZNSAwbREPPFYIKcFWDrs4hHuB2BUgVmLOrGnYJ/qQkXDQCRKiIDwYbbQr+pqmcgNRQeLGuYU/ERscUZZHJ0P4dLpzuPqq1IwQHGEmDfd0OeZC46zAB4TmCzDACuYiUVmz5Cbsue4jmpf/4tMG1xAFGhhiDxaieygt+MonhbKqa8xzrELYXqfMZpaiDKyFTx6HJZD0U
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199021)(54906003)(2616005)(86362001)(110136005)(478600001)(6666004)(6486002)(186003)(4326008)(41300700001)(316002)(83380400001)(6512007)(6506007)(26005)(66476007)(66946007)(66556008)(8936002)(8676002)(5660300002)(36756003)(7416002)(7406005)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB7956
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT018.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 67c16379-6672-4029-0c86-08db7301b1f1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S+2+B5mXJYceYW+nD3EqDq42Xkq4WDFx/3kSRwjpMrzuGr1TxBOCdcXnBqLhlVfxTaYglPpzytDKEsvoRhyeBlMla6msiJi2dIkjv3NqG8KYO7iF24gzPIOnA8Aoq5TABBcQMz7h5HcZOFHILjxxfZ9K0I7f1qy8P1Z96Zqe+qN2M6sTjLQdyOtRShSn3Wv0LuESdtXK9udmgoiZxYu+U+EmTBxGJqtgaxZ1r1luDvbnAHI5uInh7CQq8rsUo7gxXzC5KwC8Clkfc+necAK7U4plppl7R77ZVd2ixbkTXvnipZvz9y1150Lgy1ORDMYYKfb9ZKjrbh4oFI0z8aWSYsKGWBKmtQV055Ki5k76g5ap7tqjLUet3RJbi2uR2JQyG7kc6mn+b9TQ6rGeRPgeBgg4KBcCuQlXXim8xRbsX0PDz+sr29ezzy0iCXDSVnP2qGcJDHA8PGN7JAObw3NglhDopYEYQgxWymVVqSKMDCFFHurjciliI//NBwzsrftNR9ZpQr8YiwSEU0UIPP8GlFfny32scnmpphNhAYZk10O+N0GAKhyCRg1TjBEDqsi9ZJUlhAOI9BpZbKvvUyCtvswIIi/zC7Ge7N3U0XlGKs7Lmr1S9fR8SXx7+OLFMEa11qZO7kElp+T/OV9Iwow1YYA7e9XkUb0nEhnEUY6dbGMGnkJM3+PN1uwTiAAeRBHd4GqmIgojRigGCP/+LEaOF7GQozVj/2bHvxxDW4Pz5IeJiYb8kjfEvcSAim4JkSSu
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199021)(40470700004)(46966006)(36840700001)(6506007)(8676002)(8936002)(70586007)(70206006)(450100002)(36756003)(478600001)(40480700001)(316002)(4326008)(5660300002)(2906002)(40460700003)(36860700001)(110136005)(54906003)(41300700001)(86362001)(82310400005)(6486002)(47076005)(186003)(26005)(6512007)(336012)(356005)(82740400003)(6666004)(83380400001)(81166007)(107886003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 09:19:05.7448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3895ca1b-84d0-4bb9-8366-08db7301ba2c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT018.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8935
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 06/21/2023 18:54, Edgecombe, Rick P wrote:
> On Wed, 2023-06-21 at 12:36 +0100, szabolcs.nagy@arm.com wrote:
> > > The 06/20/2023 19:34, Edgecombe, Rick P wrote:
> > > > > I actually did a POC for this, but rejected it. The problem is,
> > > > > if
> > > > > there is a shadow stack overflow at that point then the kernel
> > > > > > > can't
> > > > > push the shadow stack token to the old stack. And shadow stack
> > > > > > > overflow
> > > > > is exactly the alt shadow stack use case. So it doesn't really
> > > > > > > solve
> > > > > the problem.
> > > 
> > > the restore token in the alt shstk case does not regress anything
> > > but
> > > makes some use-cases work.
> > > 
> > > alt shadow stack is important if code tries to jump in and out of
> > > signal handlers (dosemu does this with swapcontext) and for that a
> > > restore token is needed.
> > > 
> > > alt shadow stack is important if the original shstk did not
> > > overflow
> > > but the signal handler would overflow it (small thread stack, huge
> > > sigaltstack case).
> > > 
> > > alt shadow stack is also important for crash reporting on shstk
> > > overflow even if longjmp does not work then. longjmp to a
> > > makecontext
> > > stack would still work and longjmp back to the original stack can
> > > be
> > > made to mostly work by an altshstk option to overwrite the top
> > > entry
> > > with a restore token on overflow (this can break unwinding though).
> > > 
> 
> There was previously a request to create an alt shadow stack for the
> purpose of handling shadow stack overflow. So you are now suggesting to
> to exclude that and instead target a different use case for alt shadow
> stack?

that is not what i said.

> But I'm not sure how much we should change the ABI at this point since
> we are constrained by existing userspace. If you read the history, we
> may end up needing to deprecate the whole elf bit for this and other
> reasons.

i'm not against deprecating the elf bit, but i think binary
marking will be difficult for this kind of feature no matter what
(code may be incompatible for complex runtime dependent reasons).

> So should we struggle to find a way to grow the existing ABI without
> disturbing the existing userspace? Or should we start with something,
> finally, and see where we need to grow and maybe get a chance at a
> fresh start to grow it?
> 
> Like, maybe 3 people will show up saying "hey, I *really* need to use
> shadow stack and longjmp from a ucontext stack", and no one says
> anything about shadow stack overflow. Then we know what to do. And
> maybe dosemu decides it doesn't need to implement shadow stack (highly
> likely I would think). Now that I think about it, AFAIU SS_AUTODISARM
> was created for dosemu, and the alt shadow stack patch adopted this
> behavior. So it's speculation that there is even a problem in that
> scenario.
> 
> Or maybe people just enable WRSS for longjmp() and directly jump back
> to the setjmp() point. Do most people want fast setjmp/longjmp() at the
> cost of a little security?
> 
> Even if, with enough discussion, we could optimize for all
> hypotheticals without real user feedback, I don't see how it helps
> users to hold shadow stack. So I think we should move forward with the
> current ABI.

you may not get a second chance to fix a security feature.
it will be just disabled if it causes problems.
