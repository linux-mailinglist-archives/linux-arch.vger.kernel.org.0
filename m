Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B2673E198
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jun 2023 16:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjFZOJV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jun 2023 10:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjFZOJU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2023 10:09:20 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC30210DD;
        Mon, 26 Jun 2023 07:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NczVlE4rm1dmoAtNmI9sz0l5FsTEO2Q+XfOTXtAKj7E=;
 b=eg+gpVVbqXH2McVF04EOdG0d+JUvbvVB1pOyZIoD5x4cPmsqKj0XzxoAPBF7Iuz7Foxm1GP/E0Dmc61ZN79hRqhOIyqsA9etXuwp2v1SreWSX0MGiiA5v0zJ+qCWH1wwXjH4EGU720vpYAYhRW7MV4uz8Jasdr5BXV250dDpNgs=
Received: from AM0PR02CA0005.eurprd02.prod.outlook.com (2603:10a6:208:3e::18)
 by AS8PR08MB7767.eurprd08.prod.outlook.com (2603:10a6:20b:527::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 14:09:15 +0000
Received: from AM7EUR03FT042.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:208:3e:cafe::b6) by AM0PR02CA0005.outlook.office365.com
 (2603:10a6:208:3e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 14:09:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT042.mail.protection.outlook.com (100.127.140.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.15 via Frontend Transport; Mon, 26 Jun 2023 14:09:14 +0000
Received: ("Tessian outbound e2424c13b707:v142"); Mon, 26 Jun 2023 14:09:14 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e6fcde887157c6f0
X-CR-MTA-TID: 64aa7808
Received: from 6845ba131bef.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 70DE98DF-F72B-430A-80F1-E35EA9219AAB.1;
        Mon, 26 Jun 2023 14:09:07 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 6845ba131bef.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 26 Jun 2023 14:09:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTvAuttMm3RD3whg4fVCtLShyuIdmX9bsbor5Hukl5znEaGOhg6GDfZTV+nKlvVAtSYPukezIGtL2xlagvl1yK2Dy8C4eSJuky0gGGfjlZcHEyKJlIYJ2ctrwA21JzxLeXZHYa3t+tJfcbc/3PiF6aMJ3+hFycgUQ1Bl69nFsvuolgGfJnKw9uB+D7mYPypxJwTCYrfsIglmKqx57mXUbgI37o4kDV2XPzUwBkG0qpOC1dpNx+820wMA9nQ/lPjY0BsdTJzt4H2QfVyClKTkFLCwzDNM9ArRhZ3VXBceHjJVwqtXEwqlPKAFaFPEKWQA1pBkbdO7olTUHgNJlHjubA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NczVlE4rm1dmoAtNmI9sz0l5FsTEO2Q+XfOTXtAKj7E=;
 b=fuH1umBFVufTjBZ66uuNI3SO7NipAEiNeQyJdLFu1iBOtIO2sUaqRiR45+T0zyGxb6lmuxO0kwB4OaGAZIg7GW847v3jSoW//6lJvg8dtLj9lkN5r02zx23yJSdDRWZFSqwqcz2k9xy8ZixyVMHmOFXGDr1AR7SjbuqYHx6BACXlqd17o7wbBb588r93whJ1QFNuz9Mb0fly/do/pYKDhiRmLrnBJ07tRw+xfHxWABe1BHgWbx7WNxReIWVuR3Qox6YCeET9ydf5z6ITvgJQISeRMcsQo0/9n2H3P+Cp969MW2bG/ETnRmF3oDzHGhKvygvzyBwPyubw3aHRnJpoRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NczVlE4rm1dmoAtNmI9sz0l5FsTEO2Q+XfOTXtAKj7E=;
 b=eg+gpVVbqXH2McVF04EOdG0d+JUvbvVB1pOyZIoD5x4cPmsqKj0XzxoAPBF7Iuz7Foxm1GP/E0Dmc61ZN79hRqhOIyqsA9etXuwp2v1SreWSX0MGiiA5v0zJ+qCWH1wwXjH4EGU720vpYAYhRW7MV4uz8Jasdr5BXV250dDpNgs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by GV1PR08MB8353.eurprd08.prod.outlook.com (2603:10a6:150:a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 14:09:01 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 14:09:01 +0000
Date:   Mon, 26 Jun 2023 15:08:27 +0100
From:   "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>
Cc:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Message-ID: <ZJmb24iHBQBXIpxB@arm.com>
References: <64837d2af3ae39bafd025b3141a04f04f4323205.camel@intel.com>
 <ZJAWMSLfSaHOD1+X@arm.com>
 <5794e4024a01e9c25f0951a7386cac69310dbd0f.camel@intel.com>
 <ZJFukYxRbU1MZlQn@arm.com>
 <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
 <ZJLgp29mM3BLb3xa@arm.com>
 <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
 <CAMe9rOrmgfmy-7QGhNtU+ApUJgG1rKAC-oUvmGMeEm0LHFM0hw@mail.gmail.com>
 <ZJP664odSJC+tGzT@arm.com>
 <39786e2e74013d3006cc6081e4f7faffadcab8f2.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39786e2e74013d3006cc6081e4f7faffadcab8f2.camel@intel.com>
X-ClientProxiedBy: SA1P222CA0032.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::13) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|GV1PR08MB8353:EE_|AM7EUR03FT042:EE_|AS8PR08MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: a6f598ae-234c-4387-080c-08db764eec7f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: QwLzSmwu4Lqid3z21MShMSD6aRQtrQqqyICfRcJ3RlIX1/3WiE+pf4SaM2B/A7eV7wm0t0wovCFpmHuDcnIGau3/rcLXcaAw5zrojQ+J2a/r+et2JkwIiyoDg6U4heZgYLEuoRB+yqI6hhmEt2VujjXv9+gRArpHt15ZySpxdqnDwD0lNV1Jigdt0J1vuW7+0aKN5E4ZaV3//bd26XanN/OaXviP3eDMy7TJK5QSjzh52po60QSM9zQKMSyNLzu/3VO3WuBuuvTDTwyvjT8EdJhmPuyK9a29VWCbBRKGuh8nExKMsE7W9x4Y/UrM3QtBv/YDrPpSv92odhpbYfcK7IxklWJnxJqsqQjgt7Zk45MWw9nSXG50wiU5w64gxMN0ipVi+VSHmOzVGbw1zlLHKUkGMg1OrPMA3GvjpXnmWZoxLbhMyjbSVj4/44ILmJKWe6w3+4Z06KHjdnaWcK+EQZC+69HjcPI5/bfCEAq4tWwp5+ibFtWOZB1TUfTQCxAyV5/G1lyY4U5ODEHUUWr2MRwz+KdARK/zMxC1D7DckLk5S6vJoKNCQWElMpR0bJJc
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(451199021)(38100700002)(36756003)(86362001)(478600001)(54906003)(110136005)(2616005)(6486002)(6666004)(41300700001)(66476007)(66556008)(66946007)(316002)(8676002)(8936002)(26005)(4326008)(6506007)(6512007)(186003)(2906002)(66899021)(7406005)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8353
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT042.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4366f2c8-ab62-48d5-4c2d-08db764ee3d6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zs0YZyghd9jIySM+iDC9wqI4oIp/IHNGZD+wJhmKP1NMDjlkLnqrmsPKXqxkmvJcz7Vn5X6KMK+hOuOb2B6OGH6u+lAg48TpbeG8cLu0+QgrYV0eEhcPOfvYwyb9aWwxtBzoKklzFFx4pBVoAWuz5rSb7Vo/2gAyfhPJ20QSLpBowC+KvtjTJD5OhX9OS5tGNpOuSgcEAm4mYRxcM4t8ZC/eCbFJmONHE0x0z5VC6YvCz4BFEyP3wcEdtIz62gLYf3ADRiqq99zk8herucKQ8rRA5u+mwB2jcNzeGtDjoV+ZSWx8uSrv8Dx13eZLUODUqNuZgWHDVREUF6ABSKUHz83OPa3TqUo6++cybdcS/iicBv81OF7LULG27XV2MAPMagpr/7Bh7IrtrX79LBe3XCPJVrfo/6iOekWGIpnWUE3O88Q+d3O2XXE2TgEzIwxPn3Hd0URKA02Z3oxKEUBfSL0p/00cXDgQAGIr1Od3eLsY05ZfcOlqbX2uPcCUR/yLJhtqK75ToWBo5muzUX4OaeK6M3X9j46c+9iT11IqFKk0N9+2id7DoWtNr2MaOIUxa9sh5Rm7lr+5u1kL3c3L7h4E+3p3T3a/VLJUlZg1sbTWr795l4i3zbccZmBsqWQBvrYQh5OO5iJf5VxsTRqgiiV+bbIQunmkK7YkZyVS9JnGATGuhvcr86Leg4v/mXCseaGPjlVrZULqU1hUoFQzjvraX4qZZStikCqXWAhuJ2Q=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(5660300002)(70586007)(70206006)(4326008)(450100002)(478600001)(36756003)(316002)(66899021)(8676002)(8936002)(2906002)(40460700003)(40480700001)(36860700001)(110136005)(54906003)(86362001)(41300700001)(6486002)(82310400005)(336012)(6512007)(6506007)(26005)(47076005)(186003)(356005)(2616005)(6666004)(107886003)(82740400003)(81166007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 14:09:14.9238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f598ae-234c-4387-080c-08db764eec7f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT042.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7767
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 06/22/2023 16:46, Edgecombe, Rick P wrote:
> You previously said:
> 
> On Wed, 2023-06-21 at 12:36 +0100, szabolcs.nagy@arm.com wrote:
> > as far as i can tell the current unwinder handles shstk unwinding
> > correctly across signal handlers (sync or async and
> > cleanup/exceptions
> > handlers too), i see no issue with "fixed shadow stack signal frame
> > size of 8 bytes" other than future extensions and discontinous shstk.
> 
> I took that to mean that you didn't see how the the existing unwinder
> prevented alt shadow stacks. Hopefully we're all on the same page now. 

well alt shstk is discontinous.

there were two separate confusions:

- your mention of fnon-call-exception threw me off since that is a
very specific corner case.

- i was talking about an unwind design that can deal with altshstk
which requires ssp switch. (current uwinder does not support this,
but i assumed we can add that now and ignore old broken unwinders).
you are saying that alt shstk support needs additional shstk tokens
in the signal frame to maintain alt shstk state for the kernel.

i think now we are on the same page.

> BTW, when alt shadow stack's were POCed, I hadn't encountered this GCC
> behavior yet. So it was assumed it could be bolted on later without
> disturbing anything. If Linus or someone wants to say we're ok with
> breaking these old GCCs in this way, the first thing I would do would
> be to pad the shadow stack signal frame with room for alt shadow stack
> and more. I actually have a patch to do this, but alas we are already
> pushing it regression wise.

sounds like it will be hard to add alt shstk later.

(i think maintaining alt shstk state on the stack instead of
shstk should work too. but if that does not work, then alt
shstk will require another abi opt-in.)
