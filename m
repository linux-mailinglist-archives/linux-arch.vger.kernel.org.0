Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7E16AC858
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 17:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjCFQjT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 11:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjCFQjC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 11:39:02 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on061d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::61d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565D03B853;
        Mon,  6 Mar 2023 08:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQNgJEDFoUKXy4ThF0M8Np59faSoB1rf2uF7KLFVNPA=;
 b=IpYc3/86OAfHqLh2+etMndPaDE/OOcwzmuO6v/NuQfx7jJSiEd/wLQYN5cAEiZqOnKJosGKGQRIiPtCHVAEeL3/Sy6jUDytrgXC1at+bagdwsm+I3Cvtx6xSicZ5Mo5qO8f09o7Lmnm0Nkety/12nDbikX/ZiY5yKWkQEQ5tVnU=
Received: from AM6PR04CA0053.eurprd04.prod.outlook.com (2603:10a6:20b:f0::30)
 by GV1PR08MB8402.eurprd08.prod.outlook.com (2603:10a6:150:a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Mon, 6 Mar
 2023 16:21:46 +0000
Received: from VI1EUR03FT035.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:f0:cafe::1e) by AM6PR04CA0053.outlook.office365.com
 (2603:10a6:20b:f0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 16:21:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VI1EUR03FT035.mail.protection.outlook.com (100.127.145.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.28 via Frontend Transport; Mon, 6 Mar 2023 16:21:45 +0000
Received: ("Tessian outbound 2ba0ed2ebb9f:v135"); Mon, 06 Mar 2023 16:21:45 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a6cc002718f8ae22
X-CR-MTA-TID: 64aa7808
Received: from d7de9c93e0c7.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id EC51BBBD-05A6-4453-A2CC-CDC2C26D8830.1;
        Mon, 06 Mar 2023 16:21:38 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d7de9c93e0c7.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 06 Mar 2023 16:21:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSQ014iZC6cIiZy0I3TakA4CL10qT6e2BthU5nSFgYedc8n9wpZPB9mjR99ffX7KE1ryJgnxi9t0ddEznpizIrtesSXvRebvVHNi8S3vfbLkuwuK1QfwRlQybs471Izs/Q5O2x7k9X30W3fjIVlWkPXSxeUQlGfXSOd424pXwaUpUbkydtptlbrX1y5sW+HJoa7EA+i9o5nopj5R4vOdi4WbpuxIP315BdqUpC7ZR9qWLrq42aZB7CL01RAhNv814U0mwTKap1OhmEFQiQ6Rib13vDoticAEInSb7lVC5WQIVxGlAZhtp9V1hzMZYSjS6/J+hr+0dmS6zrlmjLOs8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQNgJEDFoUKXy4ThF0M8Np59faSoB1rf2uF7KLFVNPA=;
 b=Sjymlq059sU0QJTHrx4ElUrS5gOCGkqdSotMAVmM60/ARp2h4aNajvTPgFu6lYQOxULhWkfYYkJQ/ZHH2Ty9+1Ujjw/3N5Jn1/mEfZFojTuMEt4NAQEovkpZHMb4AxUl/W+fGcGrSZqd6vJIuoPIuEwihU94Rgwl0bGZWdd3agVWuQCx0PnyTTU7ENv4U9IgNBaYnMjMzLQniozp2FhMg8b1imPLSnmLMfKprK1Zg+Munt1Qzy1JKItpSZaR4ylJ7Sm8WEshpfoXRGqmCvcBqAHTAtVBvFJgMN/YgjSAzetX4CbMcFPReR3RZvc+mkFpD05WS6Ztrk3XofAcxSEllg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQNgJEDFoUKXy4ThF0M8Np59faSoB1rf2uF7KLFVNPA=;
 b=IpYc3/86OAfHqLh2+etMndPaDE/OOcwzmuO6v/NuQfx7jJSiEd/wLQYN5cAEiZqOnKJosGKGQRIiPtCHVAEeL3/Sy6jUDytrgXC1at+bagdwsm+I3Cvtx6xSicZ5Mo5qO8f09o7Lmnm0Nkety/12nDbikX/ZiY5yKWkQEQ5tVnU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by DB9PR08MB6361.eurprd08.prod.outlook.com (2603:10a6:10:261::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 16:21:25 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::e3d1:5a4:db0c:43cc]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::e3d1:5a4:db0c:43cc%8]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 16:21:25 +0000
Date:   Mon, 6 Mar 2023 16:20:56 +0000
From:   "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
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
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>, "nd@arm.com" <nd@arm.com>
Subject: Re: [PATCH v7 01/41] Documentation/x86: Add CET shadow stack
 description
Message-ID: <ZAYS6CHuZ0MiFvmE@arm.com>
References: <Y/9fdYQ8Cd0GI+8C@arm.com>
 <636de4a28a42a082f182e940fbd8e63ea23895cc.camel@intel.com>
 <df8ef3a9e5139655a223589c16a68393ab3f6d1d.camel@intel.com>
 <ZADQISkczejfgdoS@arm.com>
 <9714f724b53b04fdf69302c6850885f5dfbf3af5.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9714f724b53b04fdf69302c6850885f5dfbf3af5.camel@intel.com>
X-ClientProxiedBy: SN7PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:806:f2::9) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|DB9PR08MB6361:EE_|VI1EUR03FT035:EE_|GV1PR08MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: a1443a4f-349f-442c-19e6-08db1e5ee15c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: RfT5tvhJOoGmOCieGsWqsYWBArlz1hKznr98Xnp8KiD6XoDfFh/9dGElhqmsuomIr5qVcdTQwdQ3tqnC2Y+pCEHoai+xA1ZcahICUyKnqh6hwsj8t2/azsQ3yUU7s/AIg+neChb4wDpCwJ+srKzYxQqvUjHcvROE1sWmZcL74fmnIPAf9+C8FiFx/Pwmp3sQUFyuA4br/rgupDMsGKqMM8B/Ow0DXbDyiio/amBuzmRkUfOxWge6x80nJ7VO1uyfz7R3D+kd/il8c8hPYUeDa/x+OLMWipgID5V/icXZEXWEqrw2qNlcmjqtSzbALx732w5obD3DGy/hGFqLxbdgEGybLxdkgB66DVPqs7m1OeH5hr7D9W1ISi1c26Cb2JwgW2KD/vOO/pghoRocSSJZJ/rv/XZAR2YD1bPMeddx3SxHI4G5TXqvQxnCbjPBlDnNA73rlEHwHwOD2JXsZlgMsXwcjLu9PWesaiZQPnJnmYXGDDFfs97rrYSYIEc/H3qKMHy2VN+cZQnbXA3F89WKQ4t/Uufsh6e0wUxDodYQ1/eL2PgnV6vedXnjc/GTvawlcqfX65d9dTOr1bMGI0ktMYE6zEgNuz6bWQ1klGTKOk/jBUFBTWuCe+lt3v2dtmGA13BvAlu7hlJL8AwDhzSLpE1REMaDwX8JBvIgT2GWVh6XuX4EAkkHKq5pPGs0uF1l
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199018)(8936002)(5660300002)(7416002)(7406005)(66556008)(66946007)(2906002)(66476007)(8676002)(4326008)(54906003)(110136005)(316002)(478600001)(36756003)(6666004)(6512007)(6506007)(6486002)(26005)(2616005)(41300700001)(921005)(86362001)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6361
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR03FT035.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: cff02f66-8e96-4e0f-9862-08db1e5ed457
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9X/8ch43QmX4AFOoTAi+tqP/orDhtSppw3a8EtEX5eT9VWWzBCn2CQe2WOTxu1gZFSZFrNO0Zb7i/zbsP5/uNPhFy3AaWzNcnj3Q/MWGifwKPxI5wQlHVNi7PJ3txdBmKwhlMepYfMLREX9YttzDSSf6OYIL/ZScrAhF90E7mBBtYk4DOZVjpCvELhcLtkjKFZ3SUYwrte0fvq/7SjPNTjaDuxEVN++m5sxMbe50D646hDPjztNFoHdDOM0suFp9SkN0HjwJ10ZU+I9rHx/o3q6OVSHS3vcrvJTRYHPjsOIZ2nWHrWRsjq3msX8H+R9whNY/HOUcT78pd1Xf5ggdqCw1vMiRSljip0iIrVxej2uRQHSEeTpvEXyFXrwHLkDmTxw2RFJ9S2DJwr3g+4iTimh0A5pSYhoNKSv3vDRKvndtsxsOLr21kdIEwavrEXRlrRWG3uyuWOMvOoGxn9AjUW21lwtPL3GAP+gc7N9vXZLVKtVuCYdCZjFWrmOPoUhVwEx0Gw0DH3AcmhfUDqQfoT5LfmVqwbBGOjgbzp/F2xtQ1lbPzBCgKPB4+GbAkq16z4KOAedVlA9h9MBnWomQ9SwGfaT7eLd+U8fYqofun1wRTJr1nE1Pfv9/+FiRTobhLcW47uDACa6SAaf29v4es2T9fZ08fGx2+mLqwqmsMdUmkJCQLwsjE9RKqZuy2lPg5HpN8OiztohyFj8x14KWoyeNLKD0+gtcjelPqOdbpq4=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199018)(40470700004)(36840700001)(46966006)(8936002)(5660300002)(70586007)(450100002)(70206006)(2906002)(8676002)(4326008)(110136005)(54906003)(316002)(478600001)(36860700001)(36756003)(47076005)(6666004)(6512007)(6506007)(6486002)(26005)(2616005)(41300700001)(82740400003)(86362001)(82310400005)(921005)(40460700003)(40480700001)(356005)(186003)(81166007)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 16:21:45.7225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1443a4f-349f-442c-19e6-08db1e5ee15c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR03FT035.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8402
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 03/03/2023 22:35, Edgecombe, Rick P wrote:
> I think I slightly prefer the former arch_prctl() based solution for a
> few reasons:
>  - When you need to find the start or end of the shadow stack can you
> can just ask for it instead of searching. It can be faster and simpler.
>  - It saves 8 bytes of memory per shadow stack.
> 
> If this turns out to be wrong and we want to do the marker solution
> much later at some point, the safest option would probably be to create
> new flags.

i see two problems with a get bounds syscall:

- syscall overhead.

- discontinous shadow stack (e.g. alt shadow stack ends with a
  pointer to the interrupted thread shadow stack, so stack trace
  can continue there, except you don't know the bounds of that).

> But just discussing this with HJ, can you share more on what the usage
> is? Like which backtracing operation specifically needs the marker? How
> much does it care about the ucontext case?

it could be an option for perf or ptracers to sample the stack trace.

in-process collection of stack trace for profiling or crash reporting
(e.g. when stack is corrupted) or cross checking stack integrity may
use it too.

sometimes parsing /proc/self/smaps maybe enough, but the idea was to
enable light-weight backtrace collection in an async-signal-safe way.

syscall overhead in case of frequent stack trace collection can be
avoided by caching (in tls) when ssp falls within the thread shadow
stack bounds. otherwise caching does not work as the shadow stack may
be reused (alt shadow stack or ucontext case).

unfortunately i don't know if syscall overhead is actually a problem
(probably not) or if backtrace across signal handlers need to work
with alt shadow stack (i guess it should work for crash reporting).

thanks.
