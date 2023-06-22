Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B70739849
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 09:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjFVHlE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 03:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVHlD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 03:41:03 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7541995;
        Thu, 22 Jun 2023 00:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxRLu+P4+Cgp4adSzK7bl/W10lpLSVlv7h+SC4sZClM=;
 b=xNEjr3uqpzkmTbfRL1G12uAjPfYAZksw6E9CyJa+IOeTX8RRVNtMvmcey8dtlbA7kp9lcf7+tIsgB6+zLty+j4nEjoSi05xFvXOvYDV+/Fkdy03hmeSnPBimfLWrfXj278EaV9cyermNVWZ+5JGk9Q/zDDxjoAtGlaX2eidjrzU=
Received: from AM0PR06CA0103.eurprd06.prod.outlook.com (2603:10a6:208:fa::44)
 by AS4PR08MB8072.eurprd08.prod.outlook.com (2603:10a6:20b:58b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 07:40:57 +0000
Received: from AM7EUR03FT015.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:208:fa:cafe::77) by AM0PR06CA0103.outlook.office365.com
 (2603:10a6:208:fa::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 07:40:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT015.mail.protection.outlook.com (100.127.140.173) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24 via Frontend Transport; Thu, 22 Jun 2023 07:40:57 +0000
Received: ("Tessian outbound c63645f235c1:v142"); Thu, 22 Jun 2023 07:40:56 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 017feae5ac82cc45
X-CR-MTA-TID: 64aa7808
Received: from 9834e2ad7492.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 13F81A30-5F37-45C4-8A7A-3A2868AC6504.1;
        Thu, 22 Jun 2023 07:40:50 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9834e2ad7492.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 22 Jun 2023 07:40:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAE4xh9SiHBGcVDoyo9Ss+dP9SJs5kidcTflK2yZpv2tcMYIjauO+c7YG5uRQc9ooue7sx7B/VYqhGR7L/gIHNidv1n0E3X3l7bWVrsTPgB1mzMZeUP49BCOQnlQgHtgubRWdS079WjGYEGsFPzddFtuoL3yOm981Q+4CVOdELmm9cVU2bU+4jwSY5ylSU4Pxts0ZRpgvHjPjAsh5KX17br89hjvm2fqq6kbuJUCy//g+D3OHboalJTf73ZZI/dvIxzdE9hMMVfR0HqGWNRmD2ejiCoP1rCNPrz+U4lJi2GdJkNm97f/GKUxzhVG2C/8+HyTO6Z4OUMWgutcq7qJlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxRLu+P4+Cgp4adSzK7bl/W10lpLSVlv7h+SC4sZClM=;
 b=Oi2wKYFoNQbx9NY2zSbctaf/sr9w35ixHJG/fiTWGMRgGC0+VLIUXOPijK6DSmt6o9qKjRZzNWdHc+mSbzbI4VwyODmUeyMlpSSwQ/t5tyBBNuoWT7LFc8G9bzeqoxQ2X6RYWQ9JR3+NRAZJese1I1OOVPiyu7gy0Gau/gbH8dWgABMNdr9S4ADZ0IJBrWudzCBlHv1VJJExCy0hLNHEuGXkOcbH4WcIiTjfMNeH0NihGL3kxDKbS3T1u9Y88nB7QinJ1b7Rgg4uTifamWW1APoqrR7GXnFCMujTXUZwBNBQ8TtqQtnGUQ2+xQaSMTfXWIpIdLpPHUs4t3NEkV5nPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxRLu+P4+Cgp4adSzK7bl/W10lpLSVlv7h+SC4sZClM=;
 b=xNEjr3uqpzkmTbfRL1G12uAjPfYAZksw6E9CyJa+IOeTX8RRVNtMvmcey8dtlbA7kp9lcf7+tIsgB6+zLty+j4nEjoSi05xFvXOvYDV+/Fkdy03hmeSnPBimfLWrfXj278EaV9cyermNVWZ+5JGk9Q/zDDxjoAtGlaX2eidjrzU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by VE1PR08MB5661.eurprd08.prod.outlook.com (2603:10a6:800:1b3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 07:40:44 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559%4]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 07:40:43 +0000
Date:   Thu, 22 Jun 2023 08:40:27 +0100
From:   "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
To:     "H.J. Lu" <hjl.tools@gmail.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
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
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Message-ID: <ZJP664odSJC+tGzT@arm.com>
References: <a0f1da840ad21fae99479288f5d74c7ab9095bb6.camel@intel.com>
 <ZImZ6eUxf5DdLYpe@arm.com>
 <64837d2af3ae39bafd025b3141a04f04f4323205.camel@intel.com>
 <ZJAWMSLfSaHOD1+X@arm.com>
 <5794e4024a01e9c25f0951a7386cac69310dbd0f.camel@intel.com>
 <ZJFukYxRbU1MZlQn@arm.com>
 <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
 <ZJLgp29mM3BLb3xa@arm.com>
 <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
 <CAMe9rOrmgfmy-7QGhNtU+ApUJgG1rKAC-oUvmGMeEm0LHFM0hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMe9rOrmgfmy-7QGhNtU+ApUJgG1rKAC-oUvmGMeEm0LHFM0hw@mail.gmail.com>
X-ClientProxiedBy: LNXP123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::32) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|VE1PR08MB5661:EE_|AM7EUR03FT015:EE_|AS4PR08MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: a46650a4-aa45-4c6e-9367-08db72f40442
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: q+f7mDrFzlTT58h5TzL6fbmrVlD9pxlAjfpQUX6P8YX6GNVDIiB4oT3JxXn80umDJ9YMVzdPjlJVqL4MCnO4+RrUPIzu0h7STgPTNzHB92MALBU5KyuwA6nKpkMeCrQduPvWVKYuZq+ut1FSIZjEOgjwvKqML0sjHA5fT5m2Gt6c0axby1IjVqkaftEo7wVhfCOFEjc2nDcW+vNqEB1qrLgMNixuArhVqIG1mj6FDbfklfAAOqodSjCnx1eZAd5yc9o+hObM0WtGXRLSBYyWYLVRCOPwsX7xKfN3MhaHB6eAy4fS36220HEShT9AtHsOznKA0S6LEpJT8osuxVcpWVvUNBRMIXs+4fiCKj2vHu9u6LotvfzacROIO8Lj9qZ404Hl9nTtUccKqRn55bZofhOf53QMbYo+9GA7DlDj5DVPl10qkDgqmQ9ZwasAan9wbQ0FnrVCclWMK+6HbdJ86Zql8a3BgiM+HMfdJbzlVK7nwIckpfkLGTV/6hMK8HmmO6/9PswhI541PK5OEvS1CEcM9owYjM8T4WGRICBBZZf69qfL+nDC6oOpR9ZZF/GBl82ld2ns7XqK8irW7PTfG94wBQBid9hVmo45miQBGQY=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199021)(41300700001)(5660300002)(66556008)(66476007)(54906003)(66946007)(316002)(478600001)(4326008)(36756003)(2616005)(110136005)(6666004)(6486002)(966005)(53546011)(186003)(6506007)(6512007)(26005)(7416002)(8676002)(7406005)(8936002)(2906002)(4744005)(38100700002)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5661
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT015.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: be24133f-abc7-47d7-050f-08db72f3fc1b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t77pw8VZVaaKskhnehqlSx9gk9cDDhgR6VmCGShT4gTGTALdcsEcoStR/IIw8ywMzpWdcQgnyU9gJcUARzilso6/Gr+VcoLtBLA/G/M1RjIKQaFfKKAu+BYblGQ+SkAbuLcOZbnfZ/vV2HQhwOnEAiifkly1Dcovd257xzAAgURDPPJzh9MNtsdChrvW6jmKRUkZb+8GjdjJtRbnOiiElbWi7UZJPeU2cS/RTNCoftXYsGUySiHmW1szHSspoqeR2GIi2HwMRRJsGMWIP6RxZrxY9tH5tXXVw2hEvsDkIcSnZT1nm1r+pavyIK+FLpnUAxh5nL//lKMFEH0nVGhaYEwFgI6un7ufVqSZgcffMhJ2okPkoltDcORnWNhSuS13aG5XNqPbOtBsl2iU3T7dbgLC/ZwRTLRmUHUUiblsHxxd/I8hWuTrcUNcbCpHmnmFgr4ZngvzVJ41E00jQuAgJz+cBWKfuneCuIO+G1tmMMdXMp3Rq/n5aLdkRd3rlBphCU2RLTBRsECef5YCmkSNtvCGqAVIrKVt1Z9+itnZjRWrppuVkM3vfXyU1ZiSfjZLMYRYB6eGsXvQeyvlaKV64ZsnvnYg0jO+HMpfxXvm4EIrgNCxeGEB+0XquZB7iXt9Xu2fVQqvVpvkg7fIrQfeIy2/O3+jchce580fIjS75MJbNz4tzpUoHKF89AVQi4qIBeu3expAGXSy4iMayS4QDw59GAE8/uQcoq/zwLHVpUKPyHSBE7ink8VzS4bkuFqQ
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199021)(36840700001)(46966006)(40470700004)(53546011)(6486002)(110136005)(478600001)(70206006)(450100002)(6666004)(54906003)(70586007)(2616005)(36860700001)(40480700001)(336012)(47076005)(40460700003)(86362001)(36756003)(2906002)(966005)(4744005)(186003)(107886003)(6512007)(26005)(82310400005)(6506007)(81166007)(356005)(82740400003)(41300700001)(4326008)(8676002)(316002)(8936002)(5660300002)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 07:40:57.0865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a46650a4-aa45-4c6e-9367-08db72f40442
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT015.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8072
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 06/21/2023 16:02, H.J. Lu wrote:
> On Wed, Jun 21, 2023 at 11:54 AM Edgecombe, Rick P
> <rick.p.edgecombe@intel.com> wrote:
> > HJ, can you link your patch that makes it extensible and we can clear
> > this up? Maybe the issue extends beyond fnon-call-exceptions, but that
> > is where I reproduced it.
> 
> Here is the patch:
> 
> https://gitlab.com/x86-gcc/gcc/-/commit/aab4c24b67b5f05b72e52a3eaae005c2277710b9

ok i don't see how this is related to fnon-call-exceptions..

but it is wrong if the shstk is ever discontinous even though the
shstk format would allow that. this was my original point in this
thread: with current unwinder code you cannot add altshstk later.
and no, introducing new binary markings and rebuild the world just
for altshstk is not OK. so we have to decide now if we want alt
shstk in the future or not, i gave reasons why we would want it.
