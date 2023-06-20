Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCEE73677F
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jun 2023 11:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjFTJSH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jun 2023 05:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbjFTJSC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jun 2023 05:18:02 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2089.outbound.protection.outlook.com [40.107.241.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20551711;
        Tue, 20 Jun 2023 02:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ba04VqryGuy+tqXQdUvmvxgxRNRefAVnUB4a/VFb0yM=;
 b=vstRLOoI4ORg/i/DSfCaRY/rZ0A27Rg/9lM67xFcrWQpq5Xg67MwCqkxevEexk+pAy78xH2W4C1kM3fkd76uBJudSNATwNPI/3I3hFlobwu/9y4O6w+tm6LVCQfFPKKygs6ydxUdDBrkVqvZ7s+2SmO/qpgSjSlr5iE4B3vvQPs=
Received: from AS9PR04CA0116.eurprd04.prod.outlook.com (2603:10a6:20b:531::17)
 by AM7PR08MB5349.eurprd08.prod.outlook.com (2603:10a6:20b:107::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 09:17:47 +0000
Received: from AM7EUR03FT003.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:531:cafe::83) by AS9PR04CA0116.outlook.office365.com
 (2603:10a6:20b:531::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Tue, 20 Jun 2023 09:17:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT003.mail.protection.outlook.com (100.127.140.227) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.21 via Frontend Transport; Tue, 20 Jun 2023 09:17:47 +0000
Received: ("Tessian outbound e13c2446394c:v136"); Tue, 20 Jun 2023 09:17:46 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: aaa0583481bf17ed
X-CR-MTA-TID: 64aa7808
Received: from b7a8ad7b66eb.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 32C5965C-E491-44A3-AB4D-FD5FE9F89C0F.1;
        Tue, 20 Jun 2023 09:17:40 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b7a8ad7b66eb.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 20 Jun 2023 09:17:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJ1eDon7Aob86Bo1WnWUhgPbcryFGEvSFjmigdmgT2sWI6dv4qaCBslEee3zOJDS0PCJ9um2c5HSNVRHxHs2M6I8TMCK44pl22b7QCQl8HN/O1ACrWSu2eDWp6h2NyCu6Dy8f9R/zdkrKJPbnOKpYz5/dkUkt4XgeTq0D9Dmg17dVvfPcPHuxpvHXUJfol7twF6eWPawFlVNVWF/2rK+MdU7lcBdAw8xE2xzR7HUIjtF3/9RumYnuvP5I0yg2c9leblcPvRtBxfJ2RonW/x9UiBAMuLuCeoevUaUCEnQ92LsaQnhlsXci6SspcbQ06wzeGZ8YtKKpNbMdurccQk4YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ba04VqryGuy+tqXQdUvmvxgxRNRefAVnUB4a/VFb0yM=;
 b=J55wxYHjTmTbV1vvlz3jJlk94R1XW+EI8qnuVdHGjnSh7mZLD9fp3AEzG75vsEjc1JsfBnZbaP7ON02eWRX4tpkQ7RcIpOXdxT/EekuULSmF53qLHWJ1HlYioDv92sczhMG/R8tSisoT1ve4ZTsP8N1ZylkP3IO7+iUfHNMzgZVSuamqCP7+PoV1xwDB1xLeiXM6J/GaVFp1u3hGQah6/CQWVEy8hbsYjjlH68PZvBMaGXtJqu2A03y8I6P6Y8sTQPlGphFPk1JXkVbBUC41RDZ2F4+PjGKb9bRhawvW0dlRpfC5Zhi0rKDXxMJ6m3g+J51tnSoJC2BaSseTnrxLgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ba04VqryGuy+tqXQdUvmvxgxRNRefAVnUB4a/VFb0yM=;
 b=vstRLOoI4ORg/i/DSfCaRY/rZ0A27Rg/9lM67xFcrWQpq5Xg67MwCqkxevEexk+pAy78xH2W4C1kM3fkd76uBJudSNATwNPI/3I3hFlobwu/9y4O6w+tm6LVCQfFPKKygs6ydxUdDBrkVqvZ7s+2SmO/qpgSjSlr5iE4B3vvQPs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AS1PR08MB7562.eurprd08.prod.outlook.com (2603:10a6:20b:471::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 09:17:35 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 09:17:34 +0000
Date:   Tue, 20 Jun 2023 10:17:05 +0100
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
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nd@arm.com" <nd@arm.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "x86@kernel.org" <x86@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Message-ID: <ZJFukYxRbU1MZlQn@arm.com>
References: <0b7cae2a-ae5b-40d8-9ae7-10aea5a57fd6@sirena.org.uk>
 <87y1knh729.fsf@oldenburg.str.redhat.com>
 <1f04fa59-6ca9-4f18-b138-6c33e164b6c2@sirena.org.uk>
 <49eabafa97032dec8ace7361bccae72c6ecf3860.camel@intel.com>
 <fc2ebfcf-8d91-4f07-a119-2aaec3aa099f@sirena.org.uk>
 <a0f1da840ad21fae99479288f5d74c7ab9095bb6.camel@intel.com>
 <ZImZ6eUxf5DdLYpe@arm.com>
 <64837d2af3ae39bafd025b3141a04f04f4323205.camel@intel.com>
 <ZJAWMSLfSaHOD1+X@arm.com>
 <5794e4024a01e9c25f0951a7386cac69310dbd0f.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5794e4024a01e9c25f0951a7386cac69310dbd0f.camel@intel.com>
X-ClientProxiedBy: SA1PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::23) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|AS1PR08MB7562:EE_|AM7EUR03FT003:EE_|AM7PR08MB5349:EE_
X-MS-Office365-Filtering-Correlation-Id: 509811bf-85bb-4320-ae8d-08db716f367b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: epyqe+8nYSG5PScShfxO+iomwrmdR8tDL74QHB/vmqVAXvAm+LHd5OMPmLI211ySnLUoMu+5MlIlUW2fat7dav2YREOEeSSKvslw6+B8Jci7Ih6wiFbStxB9IXxrl69AmJ3M0i1F5cL2zkUXU0DzB1ZZsG19614vXQujHZljwXIUEvZ8+A4RqNnT6si8pqb+Z8n0tsjWP5CCU/Eqtmau+RSGdu6ihZfh+aoN0WcF2q7EbNvzYV0nRxs1Zv09mdp/AUoN67GIpTjZW4tJyYDKv7XIr98vPpZ13Wg++hGNYRkNLXpXzkZ9vTgsKde329mirj5sNGfQlgsCJBfbCnETRV1exGfXPUV/RQZgJZUwzdofsY3RcSho7swQywU0+b50lTzqpKE4zlqdKxQOs4XgUPE5Afc+hkbrBMKKeVPhS17kwItUVRNFg87Dh1xxTAoGz2YZLZ44BUn2Bza4OCcLM+b9KQ2hU26B+vOi2K1A1rWesjtI3Cn1eMBk+f4ZHov+AajuCyT8ksqgeee6hoaYaRintDefj24Eko1cYC3eTIhWnSg1ntcNeGWZTwMk5Eoo
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199021)(7416002)(7406005)(66556008)(4326008)(66476007)(66946007)(36756003)(316002)(5660300002)(66899021)(2906002)(8676002)(8936002)(41300700001)(6486002)(54906003)(110136005)(86362001)(478600001)(38100700002)(6506007)(6512007)(26005)(186003)(6666004)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7562
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT003.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 149c9a64-87f7-44f7-10d2-08db716f2e55
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SPaG1NsSVfX2/LOyrRAZhNrvuQX0ASDn49Phddl/5taQqnLxA4iddbBtkUzrtb222DnkarAAN2UpD8ggJEUSv6FKrkXV0xumtkV8+LA9oxmWRDlWn71CJelgVBJSd7XCTzsUVL9+CtGQthEvsAG0Kt4Wvsq9HDQsQvyCJ8T0Bg2LtbLaUgG7xQ/VtoNmCOdV9pmbrRCf0OKXv/vpPQRerHy43ZYU6c+FTwg1khY35fD3iczoG0Rj1rOo4umLvNzXm6T6f0c9FEfiX3EPLSwC4bHOenNs9XPU+cMmj0YZfGkeanVixpMkZ+ek3xLT4UXh7eCw/R4fe6AjCc7pm18WRnH+wkOhKTQVRFUKDvGFen3R4uGTjJVL3LzJJWk9qs71REq0ppdQTGmOSjdRkeWiBH8uKX5ZKGNv2tuNu21SFRlEfx3Fj/QoR+NzY8ZHwrbd73ymH9JJ9BVRFO6SQ3N+K9tz6mNsMhR3w5oGknZPhGl/U6Za7PQcMLd0U/dIf5tp0utxoBYtWM2lMDiqRwiLddg7LVUf4u3IMjTIhuA0zLtkg6vXb6tboCAIW+0+rKEQJdK5W9qEcHexYCF7zMyUChdPHLt+824OIjvj3lUVZPkkOQBKxLws6oAZeEySnuoOfn69NEhBxgSsxd9SOyWqZgczqaGLP6P6p1jQ17i7Jlpr101njpe25zsJQYtcDDoIbNvAbDUr9r4F7OiRoIcU5EQ5AFxwBEUNDRWOeE0Zi68V/SRIpZtVI9/bPVPGIbOZ
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(5660300002)(70586007)(70206006)(316002)(450100002)(4326008)(36756003)(66899021)(2906002)(8936002)(8676002)(41300700001)(40460700003)(40480700001)(110136005)(6486002)(47076005)(54906003)(86362001)(82310400005)(478600001)(6506007)(107886003)(6512007)(26005)(186003)(36860700001)(6666004)(81166007)(356005)(82740400003)(83380400001)(336012)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 09:17:47.1034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 509811bf-85bb-4320-ae8d-08db716f367b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT003.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5349
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 06/19/2023 16:44, Edgecombe, Rick P wrote:
> On Mon, 2023-06-19 at 09:47 +0100, szabolcs.nagy@arm.com wrote:
> > The 06/14/2023 16:57, Edgecombe, Rick P wrote:
> > > On Wed, 2023-06-14 at 11:43 +0100, szabolcs.nagy@arm.com wrote:
> > > > i dont think you can add sigaltshstk later.
> > > > 
> > > > libgcc already has unwinder code for shstk and that cannot handle
> > > > discontinous shadow stack.
> > > 
> > > Are you referring to the existing C++ exception unwinding code that
> > > expects a different signal frame format? Yea this is a problem, but
> > > I
> > > don't see how it's a problem with any solutions now that will be
> > > harder
> > > later. I mentioned it when I brought up all the app compatibility
> > > problems.[0]
> > 
> > there is old unwinder code incompatible with the current patches,
> > but that was fixed. however the new unwind code assumes signal
> > entry pushes one extra token that just have to be popped from the
> > shstk. this abi cannot be expanded which means
> > 
> > 1) kernel cannot push more tokens for more integrity checks
> >    (or to add whatever other features)
> > 
> > 2) sigaltshstk cannot work.
> > 
> > if the unwinder instead interprets the token to be the old ssp and
> > either incssp or switch to that ssp (depending on continous or
> > discontinous shstk, which the unwinder can detect), then 1) and 2)
> > are fixed.
> > 
> > but currently the distributed unwinder binary is incompatible with
> > 1) and 2) so sigaltshstk cannot be added later. breaking the unwind
> > abi is not acceptable.
> 
> Can you point me to what you are talking about? I tested adding fields
> to the shadow stack on top of these changes. It worked with HJ's new
> (unposted I think) C++ changes for gcc. Adding fields doesn't work with
> the existing gcc because it assumes a fixed size.

if there is a fix that's good, i haven't seen it.

my point was that the current unwinder works with current kernel
patches, but does not allow future extensions which prevents
sigaltshstk to work. the unwinder is not versioned so this cannot
be fixed later. it only works if distros ensure shstk is disabled
until the unwinder is fixed. (however there is no way to detect
old unwinder if somebody builds gcc from source.)

also note that there is generic code in the unwinder that will
deal with this and likely the x86 patches will conflict with
arm and riscv etc patches that try to fix the same issue..
so posting patches on the tools side of the abi would be useful
at this point.

> > > The problem is that gcc expects a fixed 8 byte sized shadow stack
> > > signal frame. The format in these patches is such that it can be
> > > expanded for the sake of supporting alt shadow stack later, but it
> > > happens to be a fixed 8 bytes for now, so it will work seamlessly
> > > with
> > > these old gcc's. HJ has some patches to fix GCC to jump over a
> > > dynamically sized shadow stack signal frame, but this of course
> > > won't
> > > stop old gcc's from generating binaries that won't work with an
> > > expanded frame.
> > > 
> > > I was waffling on whether it would be better to pad the shadow
> > > stack
> > > [1] signal frame to start, this would break compatibility with any
> > > binaries that use this -fnon-call-exceptions feature (if there are
> > > any), but would set us up better for the future if we got away with
> > > it.
> > 
> > i don't see how -fnon-call-exceptions is relevant.
> 
> It uses unwinder code that does assume a fixed shadow stack signal
> frame size. Since gcc 8.5 I think. So these compilers will continue to
> generate code that assumes a fixed frame size. This is one of the
> limitations we have for not moving to a new elf bit.

how does "fixed shadow stack signal frame size" relates to
"-fnon-call-exceptions"?

if there were instruction boundaries within a function where the
ret addr is not yet pushed or already poped from the shstk then
the flag would be relevant, but since push/pop happens atomically
at function entry/return -fnon-call-exceptions makes no
difference as far as shstk unwinding is concerned.

> > you can unwind from a signal handler (this is not a c++ question
> > but unwind abi question) and in practice eh works e.g. if the
> > signal is raised (sync or async) in a frame where there are no
> > cleanup handlers registered. in practice code rarely relies on
> > this (because it's not valid in c++). the main user of this i
> > know of is the glibc cancellation implmentation. (that is special
> > in that it never catches the exception so ssp does not have to be
> > updated for things to work, but in principle the unwinder should
> > still verify the entries on shstk, otherwise the security
> > guarantees are broken and the cleanup handlers can be hijacked.
> > there are glibc abi issues that prevent fixing this, but in other
> > libcs this may be still relevant).
> 
> I'm not fully sure what you are trying to say here. The glibc shadow

you mentioned -fnon-call-exceptions and i'm saying even without that
unwinding from signal handler is relevant and has to track shstk and
ideally even update it for eh control transfer (i.e. properly switch
to a different shstk in case of discontinous shstk).

> stack stuff that is there today supports unwinding through a signal
> handler. The longjmp code (unlike fnon-call-exections) doesn't look at
> the shstk signal frame. It just does INCSSP until it reaches its
> desired SSP, not caring what it is INCSSPing over.

x86 longjmp has differnet problems (cannot handle discontinous
shstk now).

glibc cancellation is a mix of unwinding and special longjmp and
it is currently broken in that the unwind bit cannot verify the
return addresses. the unwinder does control transfer to cleanup
handlers so control flow hijack is possible in principle on a
corrupt stack (though i don't think cancellation is a practical
attack surface).

> > longjmp can support discontinous shadow stack without wrss.
> > the current code proposed to glibc does not, which is wrong
> > (it breaks altshstk and green thread users like qemu for no
> > good reason).
> > 
> > declaring things unsupported means you have to go around to
> > audit and mark binaries accordingly.
> 
> The idea that all apps can be supported without auditing has been
> assumed to be impossible by everyone I've talked to, including the
> GLIBC developers deeply versed in the architectural limitations of this
> feature. So if you have a magic solution, then that is a notable claim
> and I think you should propose it instead of just alluding to the fact
> that there is one.

there is no magic, longjmp should be implemented as:

	target_ssp = read from jmpbuf;
	current_ssp = read ssp;
	for (p = target_ssp; p != current_ssp; p--) {
		if (*p == restore-token) {
			// target_ssp is on a different shstk.
			switch_shstk_to(p);
			break;
		}
	}
	for (; p != target_ssp; p++)
		// ssp is now on the same shstk as target.
		inc_ssp();

this is what setcontext is doing and longjmp can do the same:
for programs that always longjmp within the same shstk the first
loop is just p = current_ssp, but it also works when longjmp
target is on a different shstk assuming nothing is running on
that shstk, which is only possible if there is a restore token
on top.

this implies if the kernel switches shstk on signal entry it has
to add a restore-token on the switched away shstk.

> The only non-WRSS "longjmp from an alt shadow stack solution" that I
> can think of would have something like a new syscall performing some
> limited shadow stack actions normally prohibited in userspace by the

there is setcontext and swapcontext already doing an shstk
switch, i don't see why you think longjmp is different and
needs magic syscalls or wrss.

> architecture. We'd have to think through how this would impact the
> security. There are a lot of security/compatibility tradeoffs to parse
> in this. So also, just because something can be done, doesn't mean we
> should do it. I think the philosophy at this point is, lets get the
> basics working that can support most apps, and learn more about stuff
> like where this bar is in the real world.

i think longjmp should really be discussed with libc devs,
not on the kernel list, since they know the practical
constraints and trade-offs better. however longjmp is
relevant for the signal abi design so it's not ideal to
push a linux abi and then have the libc side discussion
later..
