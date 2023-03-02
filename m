Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0BA6A86C6
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 17:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjCBQgR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 11:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjCBQgQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 11:36:16 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA3E4DBFD;
        Thu,  2 Mar 2023 08:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3S/Dwi7wVWU1oAmrFKf7U8S+xvdvhvqm7mkD7J+Si+8=;
 b=Krdwt2qnSCXjqE8H1AolTaKcRiAWgFgJzg3GpGU8wfysrFt1JClDcSmTW2tuKsCioMSMcl/618rXmjxmAp3p4W52e03tbhA+6wqczdu1V++RMCB6/RDLCLoEdHE5yVCUMGYnk4kIfjg4Q2ga0bR3Kn95G69KZqsYMysMqJ88ahg=
Received: from DB6PR07CA0058.eurprd07.prod.outlook.com (2603:10a6:6:2a::20) by
 DU0PR08MB8663.eurprd08.prod.outlook.com (2603:10a6:10:401::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.18; Thu, 2 Mar 2023 16:35:17 +0000
Received: from DBAEUR03FT041.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:2a:cafe::b9) by DB6PR07CA0058.outlook.office365.com
 (2603:10a6:6:2a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17 via Frontend
 Transport; Thu, 2 Mar 2023 16:35:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT041.mail.protection.outlook.com (100.127.142.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.19 via Frontend Transport; Thu, 2 Mar 2023 16:35:17 +0000
Received: ("Tessian outbound 0df938784972:v135"); Thu, 02 Mar 2023 16:35:17 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e6239a1706709dcc
X-CR-MTA-TID: 64aa7808
Received: from cd2cba6ca92d.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6F1A1613-872A-467E-AAB2-20C66F125F64.1;
        Thu, 02 Mar 2023 16:35:10 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id cd2cba6ca92d.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 02 Mar 2023 16:35:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJ+G2Uj95Hw5Q2Sji0f6m6zPAZkEEqgW5v9pYWT+tDZGcEZ9rE0vpSvIj+5vCFwHpl11CsNrlihRhOiEEq9UxTqDqJlsAsbsVYTaI67dsBtnfeczoJRGrv7frzfeyonsSwzzyvsHbUh1H6CCMKHaqURlchnhPrzfMMTuaVrx3NoKjHKVmB5aC/uWirWtMgR3tAahLBM17c6JQq9B4ixzE713DcLNXjc8O69zhqPeZnoHnCYYBmOnhuYD9bFC6WUnhWiSjCvDKwBRMCM/SsEbBt6oLkrSKyNauSi2zlAkdKYvjOFHOZAoPx0uIco2BuqB8XsKUPYwiWf6Vm9uLjx6yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3S/Dwi7wVWU1oAmrFKf7U8S+xvdvhvqm7mkD7J+Si+8=;
 b=aptd2PSS7HJR1s87tX7uzL2q98jbdFzyfVI3LbsR9/erX1OfE6xCZMfB7si2LKHjPU5kwg7IAKU/6uskFKGA39Cf1+RvaNISf6GJmAXBl9JbOWaePMtGRapSlfbEHsd2JuHVumZueWuAgx/J5BXxpgVOb/VvAsCv6ouIbJD4JE1Wq2xf9IYytaleg8KWPjvNMcB45+pdxBHSYaQjAtG1R0efjEphyNrlKY7h38Lid/JF7i8jmzSwWz6pR1BFYc6OeLa0f4fC4/j5Nv71/q5hi4L0+gMxVTj8bfrMcf8/DVXKcrimmcVVibHyqXO1SwSJzvyzhWors1Txj6fqir2MZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3S/Dwi7wVWU1oAmrFKf7U8S+xvdvhvqm7mkD7J+Si+8=;
 b=Krdwt2qnSCXjqE8H1AolTaKcRiAWgFgJzg3GpGU8wfysrFt1JClDcSmTW2tuKsCioMSMcl/618rXmjxmAp3p4W52e03tbhA+6wqczdu1V++RMCB6/RDLCLoEdHE5yVCUMGYnk4kIfjg4Q2ga0bR3Kn95G69KZqsYMysMqJ88ahg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AS8PR08MB7990.eurprd08.prod.outlook.com (2603:10a6:20b:535::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 16:35:08 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::e3d1:5a4:db0c:43cc]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::e3d1:5a4:db0c:43cc%6]) with mapi id 15.20.6134.027; Thu, 2 Mar 2023
 16:35:08 +0000
Date:   Thu, 2 Mar 2023 16:34:41 +0000
From:   "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>, nd@arm.com
Subject: Re: [PATCH v7 01/41] Documentation/x86: Add CET shadow stack
 description
Message-ID: <ZADQISkczejfgdoS@arm.com>
References: <Y/9fdYQ8Cd0GI+8C@arm.com>
 <636de4a28a42a082f182e940fbd8e63ea23895cc.camel@intel.com>
 <df8ef3a9e5139655a223589c16a68393ab3f6d1d.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df8ef3a9e5139655a223589c16a68393ab3f6d1d.camel@intel.com>
X-ClientProxiedBy: DM6PR01CA0022.prod.exchangelabs.com (2603:10b6:5:296::27)
 To DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|AS8PR08MB7990:EE_|DBAEUR03FT041:EE_|DU0PR08MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f5028e-d87e-4c8e-91db-08db1b3c1b5e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: bx8aQCJoQrQNJRCZvFtHyR1IvSacl0aRBUUKTudSUvJGQEh2k0ZNzpDi3aPljGWT8RetLcqArULbx1G51H1SOcTzzEarKHHmjBMf8PO91sGE7Q3nT9aRyCTLQZB9nwQ+kiiIzZY3btRziF276lxyRvbos0LZpzlSwWGG6TQ/8tfqNB61BK4J/BNcqWtFSIdXoGRvXn1s9EYJJcfzwbtHDltxF7bJtGwo08aF7reC4ICmrTag04EkxoNkjYZrknxocCnKsrixTGf8rXsoWwX4kMfU9kXwf2UjrV9YFOcM7yYKLS5CLMwcb+ePGAmLb7t2W5UmlxlXmpoKxv2AUyqe75TXNolscDHAzskq7aKbabZT/wo3laVGhgHZOKf8r5f7/yuGTOk1rtURfSJ09AwZqdges7+tz3Prh9ss7BJDtLnM/vhx/qCA5WYCm5ZyjM3NOkqhhWyDy2OARZrKRZ9Vq1y5SKpkuWzNzAdz5yBVkonP6K2PwMT+rYOt11O39cgiYOvyzFrlanchPMY2Zb6jDvKGPyMLWHk2GsRg6vAqRQw7e1eCjF3SnTP0zJ9toIDR4H3KFmg8Efp0v8qEfk9uIzjLsZe9E6BP5FQ/MqFZN4Oq3KTg+q2kCtt6PgxgdHebnz5zx0ceV31dNWvH1/dqJsHnU77nbfkQ0ZMasclcS+fHK0/D33q5WQuQlWwWrhLB
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199018)(66556008)(66946007)(2906002)(316002)(8676002)(8936002)(36756003)(66476007)(4326008)(41300700001)(83380400001)(26005)(6666004)(186003)(2616005)(6512007)(6506007)(921005)(110136005)(478600001)(86362001)(38100700002)(6486002)(5660300002)(7406005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7990
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT041.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1d3b83c5-eaff-42c7-fd1b-08db1b3c159d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3DrwijJnMDTWFIHUhCRNfWwjXeLEqoylsnH8tUYRNdMopnWbEv6th2P1e+E7tmzmM6R5+uLw3k9put+XuU7wOg59GGihNBurxzlg8W1NG2ierck0FxJYpDMjH0GwQA3ozF6oONni7e9E/OXMmShBQ6vBPQo+G7aX3zTwGnpLv6hybg2N+36rUPvG7LU4RoMi31qZMmCbboJ5XuMM+Vom1tRStjSDDhqAUk1RsuCSfkLm5VDqnF281LeKio5WuFyXWKcxGRjwOuAQ+XeBpGHqWYJL8MjN/FeL19hku8W1kdowojHJ2yV26iMS0S35Adb6/VKHQS3YI4Bd+GrmJ+K971aJG7OTL6O7Z1P1bl0lL5iPL+d1tCPyqSIPMSkG5qdCf48A106L6aRbcWuJuP4qHwZ1kEqB8pRo093hLgsBCbQlaPeGC5e2Dmi+UhqODygFh5gaJhb9ehtfgyv/ISA1qFcQtprzc21kCn5fRmVNmKzUuwYytl2Zejp/ROnJuM1cGUpJTOQPFX4sj8iVh/DiubCKA25VD7M+RX0uvqkZKvAX6WZ/FyQJrEl/2GaIpyYaakR3dDJGl34XKQ/TtaAq7Ee8ZzvqLXiiXDr8+EtBcEVLu104uyn8OikghFrZYiFuLd7ij6Ub+BXb9tYV4gzv8/9HJiOKEBEpGfsIwaLfIJBBAGQ04xyYcYRHBcAFQK/YUyeO9YHF2hbdphb08KNtJM/sVtXNN+mcnnoxYqJR+Og=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199018)(40470700004)(46966006)(36840700001)(36756003)(40460700003)(6666004)(6506007)(6486002)(336012)(2616005)(6512007)(186003)(26005)(316002)(41300700001)(110136005)(450100002)(2906002)(8676002)(70206006)(4326008)(70586007)(81166007)(5660300002)(478600001)(8936002)(82740400003)(82310400005)(40480700001)(86362001)(921005)(356005)(36860700001)(83380400001)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 16:35:17.3914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f5028e-d87e-4c8e-91db-08db1b3c1b5e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT041.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8663
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 03/01/2023 18:32, Edgecombe, Rick P wrote:
> On Wed, 2023-03-01 at 10:07 -0800, Rick Edgecombe wrote:
> > > If one wants to scan the shadow stack how to detect the end (e.g.
> > > fast
> > > backtrace)? Is it useful to put an invalid value (-1) there?
> > > (affects map_shadow_stack syscall too).
> > 
> > Interesting idea. I think it's probably not a breaking ABI change if
> > we
> > wanted to add it later.
> 
> One complication could be how to handle shadow stacks created outside
> of thread creation. map_shadow_stack would typically add a token at the
> end so it could be pivoted to. So then the backtracing algorithm would
> have to know to skip it or something to find a special start of stack
> marker.

i'd expect the pivot token to disappear once you pivot to it
(and a pivot token to appear on the stack you pivoted away
from, so you can go back later) otherwise i don't see how
swapcontext works.

i'd push an end token and a pivot token on new shadow stacks.

> Alternatively, the thread shadow stacks could get an already used token
> pushed at the end, to try to match what an in-use map_shadow_stack
> shadow stack would look like. Then the backtracing algorithm could just
> look for the same token in both cases. It might get confused in exotic
> cases and mistake a token in the middle of the stack for the end of the
> allocation though. Hmm...

a backtracer would search for an end token on an active shadow
stack. it should be able to skip other tokens that don't seem
to be code addresses. the end token needs to be identifiable
and not break security properties. i think it's enough if the
backtrace is best effort correct, there can be corner-cases when
shadow stack is difficult to interpret, but e.g. a profiler can
still make good use of this feature.
