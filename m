Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF932749D28
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jul 2023 15:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjGFNPX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jul 2023 09:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjGFNPV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jul 2023 09:15:21 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2049.outbound.protection.outlook.com [40.107.7.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF89310F5;
        Thu,  6 Jul 2023 06:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csAgfxG58cy/B+/CL2TB3r0dqgnUHgo7Mb79riO+1gc=;
 b=iWzv3w77oTwSUaO4odpUlfvUn0qs23p2nn4yJKcThnVTff39Oq2mwmvH+50okiAB+lkJCWRJjcFzKvA0nMYdRM2YMzAzd0Z4BfCyXQwzBXpVbxcJBsKXAJaNLSpnrjNgdBTpRZJjS6F5con1e+2jmxN9pXxEUsflN85uZTNVpBI=
Received: from DUZPR01CA0065.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::8) by DB9PR08MB6505.eurprd08.prod.outlook.com
 (2603:10a6:10:23e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 13:15:12 +0000
Received: from DBAEUR03FT063.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:3c2:cafe::56) by DUZPR01CA0065.outlook.office365.com
 (2603:10a6:10:3c2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Thu, 6 Jul 2023 13:15:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT063.mail.protection.outlook.com (100.127.142.255) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.24 via Frontend Transport; Thu, 6 Jul 2023 13:15:12 +0000
Received: ("Tessian outbound e2424c13b707:v142"); Thu, 06 Jul 2023 13:15:11 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1fcc43ea6d031beb
X-CR-MTA-TID: 64aa7808
Received: from a28e1b84ebfa.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0E26DC80-2B11-4753-A17E-78AE5CC1956E.1;
        Thu, 06 Jul 2023 13:15:04 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a28e1b84ebfa.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 06 Jul 2023 13:15:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMkA7oc39tCCmfaRfEM8Em65JPFitAsHql8QovH3OwtHicO3MV1drpi5PE87gNdg5Ea1RQ91tx8bzS6j/WJ+SONAREqkB4G+hFbAUTCYVpVzJPHufp/Ke5VHv5HozkNb05l/LJ+n764FWtf8xAgjgXQrLjNCqdr25f9mWkyEYUSMTW9uKIoOdj+XqZjrhrK6Po8nd1YhztLgIQkoLo2oTTjqNgEPrOo8lahQkRrvxdJO0TS7f6Z9BVDrGhrBYUbsK8LuvqxoN2n/h9oUp0clgR87c7fFLoRI0TJUB0iJlhWMyJREKRd3DRl/QSwbsdmKuFOsvlccCEPiRJquRHSNLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csAgfxG58cy/B+/CL2TB3r0dqgnUHgo7Mb79riO+1gc=;
 b=g0FDojXKU/xyVWnDUJb0qb/bxIiLgBA2t3BEsZLptXWVab3RWQLCevgmEkS97/8RvbcjQdm4mNp+NDB7a7UD8TMCNf7JWMpT/SwG5whoqCIgvH6O5SSQHcii1BudmC1fIa+c2LRlHykt8zLG2mQEP+IU/LxRmuykW3OPMCz4aHAu/U8oYz8qa181ooXWUvy79BuLBXUWCCpfpRiM98M8Ji7A+empaPlEZ4VG886ZDoCdhiXQvfyGV/FlTa6B8kPz7FFQwqm3spy2bqxJD3M4RSWBBSgp/KiQrNY5e6HYqTIkfKFBTK9xfw+ZfQRAqP1eGzoYtIk7YAorjX5xZ3DdPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csAgfxG58cy/B+/CL2TB3r0dqgnUHgo7Mb79riO+1gc=;
 b=iWzv3w77oTwSUaO4odpUlfvUn0qs23p2nn4yJKcThnVTff39Oq2mwmvH+50okiAB+lkJCWRJjcFzKvA0nMYdRM2YMzAzd0Z4BfCyXQwzBXpVbxcJBsKXAJaNLSpnrjNgdBTpRZJjS6F5con1e+2jmxN9pXxEUsflN85uZTNVpBI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by DBAPR08MB5864.eurprd08.prod.outlook.com (2603:10a6:10:1a0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 13:14:54 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 13:14:54 +0000
Date:   Thu, 6 Jul 2023 14:14:40 +0100
From:   "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
To:     Mark Brown <broonie@kernel.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "david@redhat.com" <david@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
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
Message-ID: <ZKa+QFKHSyqMlriG@arm.com>
References: <eda8b2c4b2471529954aadbe04592da1ddae906d.camel@intel.com>
 <2a30ac58-d970-45c3-87d2-55396c0a83f9@sirena.org.uk>
 <0a9ade13b989ea881fd43fabbe5de1d248cf4218.camel@intel.com>
 <ccce9d4a-90fe-465a-88ae-ea1416770c77@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ccce9d4a-90fe-465a-88ae-ea1416770c77@sirena.org.uk>
X-ClientProxiedBy: LO4P123CA0209.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::16) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|DBAPR08MB5864:EE_|DBAEUR03FT063:EE_|DB9PR08MB6505:EE_
X-MS-Office365-Filtering-Correlation-Id: dadc37e1-8453-4cea-cc00-08db7e2307e2
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: lkVlNQhI5AXUENHk4rKIJeC9n7Mtuzk1DZdc0s6SHIqkStw4KEHfeo5f+XyMdcWDhlazsY5UIvyk3RX1c74SRKSHc0Q2j2nbo6ob2fqm1/Z1z8d4uKeDOe9Sk3Ou6h2lGh64nkN7OVg31h17zm9UuVZznYFWOCbOWzxxnEew6sMVjP3E0he4MYIAGj6cjg0V1ffp3LSVlKVZefajiGraQUXP1oPmDNdtZenScH30MP+xKXm8bMsuoDYpkkkmfOoc6laY50BW6sJV2HzUgWIDa7UaSs06VtL/LM95lzenYP/zWMdtw4iGcyIAzH8Dh/Plbw8xrWwVqWXebdXpq6yeJPObgCOK6m2nY9UXfyWfEbbxTiqwff+LCTdK4rnb70gOHehwyN64JyOVIk7n4XYN/9Hi1ohyyT9/eC1GI5pZkBnyiHNVZwY7SyDPHn2y2djJ3Wz96VRYRRUWC4CtxXu6zZkNs23vbRweWjF+Qu54GBCaeFw7trpbbywTayhyx+xipDM45Qln2Oy+RiG9XDpNgMaMv1qWBsSpq1m1RAhIC1G6EpX3s8XFdO16jMQyrvoCarQ6bs97pbfY+BW9s/hVjetclUwn88Ta/HzoaAy6QgR3/gfESamF2ZE5z16yT10s1e3szo2AFwZJGdl3Zl1Kjh9eloguxvolIeDkAYwA0Tk=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(451199021)(7416002)(7406005)(8936002)(8676002)(4744005)(41300700001)(316002)(2906002)(5660300002)(2616005)(66946007)(38100700002)(66556008)(66476007)(4326008)(110136005)(86362001)(478600001)(186003)(54906003)(26005)(6506007)(6512007)(6486002)(36756003)(6666004)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5864
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT063.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: fa5ba0d4-aff6-459a-fdfd-08db7e22fd04
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zmgRVTv3/BlXzh5xRjtyR5Uimfvu4n5QHV+ID+GTvBGFGmStGM0wWzSde9PtOnVtbBd7RxlG4i7VQjhy9qtOg2Tk/A56mam3ASsFKGY6ts3THlTFSWBktVFvmKGmcKcb5DfmM3iukVK+9ZsbWuEppZ71VxnGF9/te/rcwZB/fc06iHaFjPkI2XMvWAqQeMloaHBLc3D7nYM7gQZWN3pIAAgiW9jQZ6mgxNKRZ3ga32gxwnVJOUqvpXDceHJ5JiQwb+s63PyBHJ4+DR0CGm2J6tB5zh6PRvkT6iCU349CrTsBuTA6ZPSbi4WKQJRuIs58YklljtCCYni5RSeCoB3hq/1EmWV/6vsFqhEGwPxh3uk7BwNd8YC33NzOt4WhS5nty7kC0LaaER4sASHm0Q0nQ7bqIYA/MGPsYnYtYd+LLykre+/Bi9vHzCY2vQ9cVKAhOkgqeOl3G7XypGtyKWwflA8G2D6T1XlLDSbEJnKxzFBhtwMlNH7Cm2m38RANbDhvXgJHq76b/6yQ6PaA32LqlMcCGeVLLekIC6CbIXBZdVB86h/vUw599Gf3v4N/4gRC948yrnlxJkTaP9sMigFwefYkbBBKgVicAmoT89iIxgqseqAiCW2L9mHjSglR51pNhQ1ByC2NlC1ddRF8cwUKjRv+tflcrW4wiDHKVYLPa5L5k6QHzOTeYN/e5bBvX0co1KmbwQ7c3BKLMKW3RpDEo/7xUlcH6NfVk60sMNXZWITzl5KCOJ82fOPqByMzeIK+lVwHF1sfx+kkMzcbOM3tWQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(81166007)(110136005)(6666004)(450100002)(54906003)(82740400003)(6486002)(356005)(70586007)(478600001)(70206006)(41300700001)(8676002)(8936002)(316002)(2616005)(4326008)(336012)(107886003)(186003)(36860700001)(47076005)(6512007)(6506007)(26005)(82310400005)(86362001)(2906002)(4744005)(36756003)(5660300002)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 13:15:12.4003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dadc37e1-8453-4cea-cc00-08db7e2307e2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT063.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6505
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 07/05/2023 20:29, Mark Brown wrote:
> On Wed, Jul 05, 2023 at 07:17:25PM +0000, Edgecombe, Rick P wrote:
> 
> > Ah, interesting, thanks for the extra info. So which features is glibc
> > planning to use? (probably more of a question for Szabolcs). Are push
> > and pop controllable separately?
> 
> Push and pop are one control, you get both or neither.
> 
> I'll defer to Szabolcs on glibc plans.

gcspopm is always available (esentially *ssp++, this is used
for longjmp).

i haven't planned anything yet for other modes (i dont know
anything where writable shadow stack is better than just
turning the feature off, so i expect we at most have a
glibc tunable env var to enable it but it will not affect
glibc behaviour otherwise).
