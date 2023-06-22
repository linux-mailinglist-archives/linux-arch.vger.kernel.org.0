Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A97E7399B1
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 10:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjFVI3S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 04:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjFVI3R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 04:29:17 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2070.outbound.protection.outlook.com [40.107.8.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E4C1FF9;
        Thu, 22 Jun 2023 01:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoGomNk2bbnUeGoqy9olvSlyDMBJOgxLH0AyRqp2uEo=;
 b=n2pDnRTmjsoCrLHuo5mFY5XusvJc9QdGAo1Jn4dv8PVCn7fnr1010Ee7EUI1PvRKavB6NWDQ8KyFE/ffPKfxCj3pOpfoKR0prG+XKq1wPRQ6yspE5lmsuzL4rCQ30v/EsHDax2wwEwQ+bXPqPtlHhPcsC3c1wNzfmoj8vh88xBM=
Received: from DBBPR09CA0002.eurprd09.prod.outlook.com (2603:10a6:10:c0::14)
 by AS2PR08MB9812.eurprd08.prod.outlook.com (2603:10a6:20b:603::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 08:27:51 +0000
Received: from DBAEUR03FT025.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:c0:cafe::ce) by DBBPR09CA0002.outlook.office365.com
 (2603:10a6:10:c0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 08:27:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT025.mail.protection.outlook.com (100.127.142.226) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24 via Frontend Transport; Thu, 22 Jun 2023 08:27:51 +0000
Received: ("Tessian outbound e2424c13b707:v142"); Thu, 22 Jun 2023 08:27:50 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1a48b65363cfc1fc
X-CR-MTA-TID: 64aa7808
Received: from 32353250eeb9.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6C6DE126-84BD-4E22-ACA8-53CB5A7D21D5.1;
        Thu, 22 Jun 2023 08:27:44 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 32353250eeb9.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 22 Jun 2023 08:27:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqSfL4l2cOV1Tkm599somsdWgplHlblW0Pt+eNHIZVEfBAE6UT9xymdWEu47jbL6gbUT4TbeYu/qgHHPl+BqA1csSgr4Pozy9/6JcHuhDgmKtnbxDeCRG1gNrKrkgAQPeFVHt8UezEMwvhavvXd49PxIMt5TrjkeONVGgxscK95KAt1H+cjooSbmihuHNfB53rkX/TjYHqCfrkKSz9fBpglgE9HUj1K21ejUi9FPqfMp+0gcw3u0Q+tZ4ZifM7yjgRtn90rx1xxHmZ97FNqi5sbcQK36hy+8/8pl1fFIecV5NeYMpB2l2f4HG2Bx7cLi76MfWOt7LZSP3Pv7FrSjtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoGomNk2bbnUeGoqy9olvSlyDMBJOgxLH0AyRqp2uEo=;
 b=CoOrMFnmoSETSOp9MXFhmmduCCWdrHT4nM5xSBCRY6w5NQXMKsbzdNbED1Tjxbn3cWS3C40QRJCMy+QbE2MEandqHYPgLaq09EnNU8D0jL3joQEeqvgXl18vkF9LMF+EqP0yK31uE9wOSeMQRlqn107iUrb6fzrb+nstopXgITMLilB2osSUIkgaEobd7lbRy/28CAttrAV1AZ/zTKQQrRE/7mZKBXvh7kh7JPBKj6C+hHbOa2/s4i5i+KnUn90CB6RdoWb9nyucducITNn5Wul7f1h6fOQQTFBSyCe1uRVkHNADHBMvOZifDPeWpANauHu70nZj5mrEE6JBqfWroA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoGomNk2bbnUeGoqy9olvSlyDMBJOgxLH0AyRqp2uEo=;
 b=n2pDnRTmjsoCrLHuo5mFY5XusvJc9QdGAo1Jn4dv8PVCn7fnr1010Ee7EUI1PvRKavB6NWDQ8KyFE/ffPKfxCj3pOpfoKR0prG+XKq1wPRQ6yspE5lmsuzL4rCQ30v/EsHDax2wwEwQ+bXPqPtlHhPcsC3c1wNzfmoj8vh88xBM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AS2PR08MB8429.eurprd08.prod.outlook.com (2603:10a6:20b:558::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 08:27:37 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559%4]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 08:27:37 +0000
Date:   Thu, 22 Jun 2023 09:27:23 +0100
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
Message-ID: <ZJQF636p80oywgqZ@arm.com>
References: <a0f1da840ad21fae99479288f5d74c7ab9095bb6.camel@intel.com>
 <ZImZ6eUxf5DdLYpe@arm.com>
 <64837d2af3ae39bafd025b3141a04f04f4323205.camel@intel.com>
 <ZJAWMSLfSaHOD1+X@arm.com>
 <5794e4024a01e9c25f0951a7386cac69310dbd0f.camel@intel.com>
 <ZJFukYxRbU1MZlQn@arm.com>
 <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
 <ZJLgp29mM3BLb3xa@arm.com>
 <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
 <5ae619e03ab5bd3189e606e844648f66bfc03b8f.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ae619e03ab5bd3189e606e844648f66bfc03b8f.camel@intel.com>
X-ClientProxiedBy: LO6P265CA0024.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::19) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|AS2PR08MB8429:EE_|DBAEUR03FT025:EE_|AS2PR08MB9812:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b9de50-0521-404d-9b35-08db72fa9188
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 6PnGYBhF+R57YQ60xDMh54U8GUzAt9TRP6hDo6QsdVcy/RcjfiagloM2cUzDrCQRGWx5RPIMXb57d0wdlvBfIbF5xNzEr2DEHR3rhBCoXOOBW/IwMlZRF9sgpHhCSvjuTA2tPE69fMv99ZWjYdri1mmW6GmdpibqUhljyggrmsIk1FVN8jVwUHifolILmF4J6Uas0vqZKNLoDc+QCTDGFGrTttteMcC066EoaRn59yJ7H6e9BSqO/gFfZsp5dF/LaTjD+GeY1cgkhiJ+bzRQxNRCV1tFyPMeeczexp9Mqbd3i4Pr6zvpNHmPNAA5taNQFuF/QcZ+XPHo727V/tlyI4FLufWobbrLSc1zs3rEe5UrcWJegpWRZ963WcQDu6tBeQ9GPANSjzYScGPQDlY1Nu1QrvTP1mh+jXdXCQhWZmff54AGspyKk1ZUeEa4DU1V5bnt4NFwOiRZtx+ZJg05kDG85CEhQo9aPJdvqpbfF4GD5Zo0lQDTtQ4NpIYRiHxgwDb2287TPxyqHBfkLEinLEv/TnVwJtMdmajAdTJUG7aMJKty8D6KZJtw9LLRIvMv
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199021)(2906002)(6486002)(38100700002)(6666004)(2616005)(83380400001)(6512007)(186003)(26005)(86362001)(110136005)(54906003)(41300700001)(478600001)(316002)(36756003)(66476007)(66946007)(66556008)(4326008)(6506007)(5660300002)(7416002)(7406005)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8429
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT025.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e5ae655c-0c28-4946-4810-08db72fa894e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ViBSbb02y29b/I/dAnyOrDHb4odezVFNO2R+dJpWZQggg4NyI+cNWFgxVuvNpLHEX4U50Rs64Mc7x61wyscN3YSswMhSWJdsJ9JAhn4jCvkGmVA9Yad1i1CzA7uJIR20+Fb2EDAcmfWGacHSANkwGqTORD08Gv1SYDQP6n/vTZnIKWK2E7Mgm/NHAxt7+yRm6KnsiMz6kNd8etOXB4mrI2omacYzyQTh0y9EUI1vVnNy4S85ETbUSmxNX2Jir34b1o4I8MSfR+b8M+2ENURvQjZiaG74ZWK+g3kqxh7nNVBsH9uVxBkQ0sT1MSiv/trAx9A4GYtuWx42viZS41wrcza5NyOUzPAu7GYHKK84MQEs45SrIh7fmOMyBx2cagiUmRbUsnZYy5p2W1lCh8kfUNCqNRAgtbOvBnDFPInCQyxtUVZTKDWUJuJnqWVBUM8UDASxvpmYNMPnQUgr3qk/ka6D16uFFoqrRXp/KuspGj4djWBpKRbgY756nUIZgpxhwhCoB73LvHzxuZlykGao7dRjqpBmBAIEjIqf3LcldWpElU8lE92JrQtb2erRIHTIociIPBm/hPk8Om3e1mytK3scqC4S46SUi5HWIh8WD31R8oeHs+sdb4+q56HwbvhYmp1YzA0saawy8B+LvZG39Dsq8Bmzp8/ybCib/JceRhn49KPlM0IuqFjTsZYZ3X/bLEHptwiPOzxZ1n5chJPwvgy2CzMMQiV5IG4fV8Ye0oXy4QhkbpDw3ETjRaCrW/T/
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(46966006)(36840700001)(40470700004)(82740400003)(5660300002)(81166007)(356005)(6506007)(47076005)(26005)(6512007)(336012)(83380400001)(186003)(2616005)(36860700001)(107886003)(40480700001)(41300700001)(2906002)(8936002)(36756003)(6666004)(6486002)(4326008)(478600001)(70586007)(70206006)(40460700003)(86362001)(450100002)(110136005)(54906003)(316002)(8676002)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 08:27:51.1940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b9de50-0521-404d-9b35-08db72fa9188
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT025.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9812
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 06/21/2023 22:22, Edgecombe, Rick P wrote:
> On Wed, 2023-06-21 at 11:54 -0700, Rick Edgecombe wrote:
> > > > > > > > there is no magic, longjmp should be implemented as:
> > > > > > > > 
> > > > > > > >         target_ssp = read from jmpbuf;
> > > > > > > >         current_ssp = read ssp;
> > > > > > > >         for (p = target_ssp; p != current_ssp; p--) {
> > > > > > > >                 if (*p == restore-token) {
> > > > > > > >                         // target_ssp is on a different
> > > > > > > > shstk.
> > > > > > > >                         switch_shstk_to(p);
> > > > > > > >                         break;
> > > > > > > >                 }
> > > > > > > >         }
> > > > > > > >         for (; p != target_ssp; p++)
> > > > > > > >                 // ssp is now on the same shstk as
> > > > > > > > target.
> > > > > > > >                 inc_ssp();
> > > > > > > > 
> > > > > > > > this is what setcontext is doing and longjmp can do the
> > > > > > > > same:
> > > > > > > > for programs that always longjmp within the same shstk
> > > > > > > > the
> > > > > > > > first
> > > > > > > > loop is just p = current_ssp, but it also works when
> > > > > > > > longjmp
> > > > > > > > target is on a different shstk assuming nothing is
> > > > > > > > running
> > > > > > > > on
> > > > > > > > that shstk, which is only possible if there is a restore
> > > > > > > > token
> > > > > > > > on top.
> > > > > > > > 
> > > > > > > > this implies if the kernel switches shstk on signal entry
> > > > > > > > it has
> > > > > > > > to add a restore-token on the switched away shstk.
> 
> Wait a second, the claim is that the kernel should add a restore token
> on the current shadow stack before handling a signal, to allow to
> unwind from an alt shadow stack, right? But in this series there is not
> an alt shadow stack, so signal will be handled on the current shadow
> stack. If the user stays on the current shadow stack, the existing
> simple INCSSP based solution will work.

yes.

> If the user swapcontext()'s away while handling a signal (which *is*
> currently supported) they will leave their own restore token on the old
> stack. Hypothetically glibc could unwind back through a series of
> ucontext stacks by pivoting, if it kept some metadata somewhere about
> where to restore to. So there are actually already enough tokens to
> make it back in this case, glibc just doesn't do this.

swapcontext is currently *not* supported: for it to work you have to
be able to jump *back* into the signal handler, which does not work if
the swapcontext target is on the original thread stack (instead of
say a makecontext stack).

jumping back can only be supported if alt stack can be paired with
an alt shadow stack.

unwinding across a series of signal interrupts should work even
with discontinous shstk. libgcc does not implement this which is
a problem i think.

> But how does the proposed token placed by the kernel on the original
> stack help this problem? The longjmp() would have to be able to find
> the location of the restore tokens somehow, which would not necessarily
> be near the setjmp() point. The signal token could even be on a
> different shadow stack.

i posted the exact longjmp code and it takes care of this case.

setjmp does not need to do anything special.

the invariant is that an shstk is either capped by a restore token
or in use by some executing task. this is guaranteed architecturally
(when shstk is switched with an instruction) and should be guaranteed
by the kernel too (when shstk is switched by the kernel).

> I'm also not sure leaving a token on signal doesn't weaken the security
> it it's own way as well. Any thread could then swap to that token.
> Where as the shadow stack signal frame ssp pointer can only be used
> from the shadow stack the signal was handled on.

as far as i'm concerned it is a valid programming model to switch
to a stack that is currently not in use and we should always allow
that. (signal handled on an alt stack may not return)

> So I think, in addition to blocking the shadow stack overflow use case
> in the future, leaving a token behind on signal will not really help
> longjmp(). (or at least I'm not following)

the restore token must only be added if shstk is switched
(currently it is not switched so don't add it, however if
we agree on this then the unwinder can be fixed accordingly.)
