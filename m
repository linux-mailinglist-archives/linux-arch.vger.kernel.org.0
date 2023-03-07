Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367A26ADFB5
	for <lists+linux-arch@lfdr.de>; Tue,  7 Mar 2023 14:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjCGNFO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Mar 2023 08:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjCGNFJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Mar 2023 08:05:09 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on061e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::61e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A114D4C14;
        Tue,  7 Mar 2023 05:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9wjEM+BXrUgXzeL253Oh7TI6xqk/bvmsEcrcAgBCpk=;
 b=V/e049aKAUKOrFUy30U1Q1anGILL6BshMPbJWUsHeHPD/wZpeVMglOff/0BNKebpTxWgBlo02O5zso7z4HDSBq3l1dnqa5DJZObScfHnIcRWkW2P+judEb4eO3WjihI7e2bXR861FDUDxakshkHXsFKCPK3Z7G+wdGU1zypn3NM=
Received: from DU2PR04CA0269.eurprd04.prod.outlook.com (2603:10a6:10:28e::34)
 by GVXPR08MB7701.eurprd08.prod.outlook.com (2603:10a6:150:6d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 13:04:10 +0000
Received: from DBAEUR03FT030.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:28e:cafe::33) by DU2PR04CA0269.outlook.office365.com
 (2603:10a6:10:28e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29 via Frontend
 Transport; Tue, 7 Mar 2023 13:04:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT030.mail.protection.outlook.com (100.127.142.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.29 via Frontend Transport; Tue, 7 Mar 2023 13:04:10 +0000
Received: ("Tessian outbound b29c0599cbc9:v135"); Tue, 07 Mar 2023 13:04:09 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: fbf96094be138c9e
X-CR-MTA-TID: 64aa7808
Received: from d596103510da.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 38AF58CA-0745-4C11-A8B7-2E631332AA62.1;
        Tue, 07 Mar 2023 13:04:03 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d596103510da.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 07 Mar 2023 13:04:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThZSGarOVjX4SzRmJMrnGUz7SRLJhq6/vJBMqvTon6mZJ479zg0GXFhlyXpyV92XWavns5aiYa/cVS1/y+Vr1gONCgvybeLgVHDrUvm51SJktZZPuRSNIItET3PaHGrYOTKYZGg7B0Vkmht1KwT4TAH2KkOkTNQ9VMwlcX7rPONPRSGnzcY8YbKNGd7020poOKxNmccG4rKWNFLGOSv1E66t+7WOfY8p8UuKX36WJuAWpa/88dEKF+hrqHxdimtnwPUwjDM6nmMBIkSjYer5qbTJD1YrCU3M8fVptJcT5nnFXiredXlcsk+02TfGauklz5rdCF8nVFNrmzwXpynKaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9wjEM+BXrUgXzeL253Oh7TI6xqk/bvmsEcrcAgBCpk=;
 b=V3MuoKc6YawCHfzUg096Bq0yP32wQ6DygRFG+L2Gp3PpFc3IdoXBKxGBveHTEBuK+cnxpVoyBJU32DMe8zBR/bVhLdYuwl/mhPBd+T93AsH+hRNJL8i5B2PWIqFfpBjYKrH3OYZO0uFJWdsLgmjj0o17+R/zBOtLqzeZiu3GxErEiHg7SfDrk+zTUsMp7VRiUAqnQWfC1eQrWEAS13P66KGUtUupDhJOFszZJ9iqi2WTOj4UBlw4+//x9pKQwYaZ3U7qo3lublJHUtlgSOzSXihMrOzrjSDV05BwPWR0AlJAPY8RO7hsQzcijqrBNYYAKZ3cSvgV7XH3Xet8pI51tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9wjEM+BXrUgXzeL253Oh7TI6xqk/bvmsEcrcAgBCpk=;
 b=V/e049aKAUKOrFUy30U1Q1anGILL6BshMPbJWUsHeHPD/wZpeVMglOff/0BNKebpTxWgBlo02O5zso7z4HDSBq3l1dnqa5DJZObScfHnIcRWkW2P+judEb4eO3WjihI7e2bXR861FDUDxakshkHXsFKCPK3Z7G+wdGU1zypn3NM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by DU2PR08MB10105.eurprd08.prod.outlook.com (2603:10a6:10:46c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.23; Tue, 7 Mar
 2023 13:03:57 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::e3d1:5a4:db0c:43cc]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::e3d1:5a4:db0c:43cc%6]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 13:03:57 +0000
Date:   Tue, 7 Mar 2023 13:03:41 +0000
From:   "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>
Cc:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
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
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>, "nd@arm.com" <nd@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 01/41] Documentation/x86: Add CET shadow stack
 description
Message-ID: <ZAc2LQEfvRLCknQQ@arm.com>
References: <Y/9fdYQ8Cd0GI+8C@arm.com>
 <636de4a28a42a082f182e940fbd8e63ea23895cc.camel@intel.com>
 <df8ef3a9e5139655a223589c16a68393ab3f6d1d.camel@intel.com>
 <ZADQISkczejfgdoS@arm.com>
 <9714f724b53b04fdf69302c6850885f5dfbf3af5.camel@intel.com>
 <ZAYS6CHuZ0MiFvmE@arm.com>
 <87wn3tsuxf.fsf@oldenburg.str.redhat.com>
 <a205aed2171a0a463e3bb7179e8dd63bd4012e7e.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a205aed2171a0a463e3bb7179e8dd63bd4012e7e.camel@intel.com>
X-ClientProxiedBy: LO3P265CA0016.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::21) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|DU2PR08MB10105:EE_|DBAEUR03FT030:EE_|GVXPR08MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: a00dce6e-e15f-4c84-cdd7-08db1f0c711c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: yYGPmxYeNWEoRIdcLQmOVQM2uEI9HDgORbZGJjKq06OUzn4QbVUOVIQBNfS4nHH//FmkCH6nbcmW4r5RPY9MijUDEupQ0kXG3vq3DxeTLzrWq6YTIOKpkREvia8ceja5h9NRy81yur4Dnkw8qj+UPC7tWKcWeA6vLpBG4OO4jJMFCn09Wyvs5cBD0sxYZOEVlhZvjNu3eJOfJzc3IbZYsFXgqETu9/atAkvRbe+xNFUjMFdm+AsqSUOWrgZWEhyWueQ3R7QjssOuqnBggySQhP2vLA7lB9c095Kl3Nw99IyZvOGrrre9QKnrjTe7QadSLwuNh7RJvfhKxLcfncWI9OLOiIAumTsBDe66vSea+Bcw4YytwggNa418mUnail7KNpmntQd1VJeF1bC7RpiVzctZRSEO1vMgPBV93iUi6i3IbMW3V3V56uiOMAEwjqE4exUMe0Krq5DiI7Db3/+M5g7fmWq2o+5XTxPED24V11WjpHxXa4ff1PvsocIKKuSv20ALAXodQobAdd9tEkz9aduLiQyzksTZMwtd8W9RcQ8ywjJ9uvcldSjuMgsQGy6fCFN9hoVg2PkK+Q6r0F94li04BLSRVeWZ8ho7NWqYm/s8pBA50xcFoa3ZhT2Ps7Oaw66Vuzji50waUYv9vK45Sw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199018)(66899018)(478600001)(83380400001)(6666004)(36756003)(110136005)(54906003)(316002)(38100700002)(186003)(6512007)(26005)(6486002)(6506007)(66556008)(2906002)(2616005)(5660300002)(7406005)(7416002)(8936002)(4326008)(41300700001)(66476007)(66946007)(86362001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10105
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT030.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9d5f05ba-a605-456f-a355-08db1f0c6889
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mpaxp6nTJm470b0iVppdp750omS7rsC78wDkULbC+h1FkGjdiytBVUy29rxsBjWVnYjLV9uc9dC6K4iF7P3Sf2F197oPHGH3GLeWtOIW7K91jX4aSrRmJa6kHFlcfG611ILw8adfL5i0Bxxlvg6SFt0i/srNUPBBMKb2zLN2AMkmHFf49DdIh0JZ5DKUOAhv/enHrR8Yh0vV2GLZSDaTwadlIw3cWA7gimVVAug5HVbvuJZeEn0eoRtnyz4SpagTu3EJaOuyw7AiGE2+dz3aIRGtwnC/HOjR9IOvxA9+7iTtCl4atOAqhueHcIJ1UPT/H58jKZIaoGCqe76HDecrTRROkwsXPA9PYblVgXa76svcQThPdeHhUbBJ8meDEvXV5BS1gJABkS860MuEPuxSism49mau3tiD9d0Ss0IoTdT1emqPwKXQDz9IebZRZKJxDdw7TP9ZyHzy2iCwBDEnlRzIwr9O0gWfHE0/63kQsWOy6DCiN2SEiVEU3hLzyjP6RBvmq6xlFTgLVd3O2tV4trFGer/SKcIk7HE0mvkpLXnIO11oDaybGjUYxjblOOsj8YDHUorJncJcSeUvLhj94z2VKyKIEGaiy2jSz54EbwivdOJ/UWZfmp+Le14pqanoIp/+B7gr3xln6dLJj6gtpX1GR7Vo+Diluysd1M5ruBEbe4c/syOcnrVjo++8obbyTFgvX1C0Sown+V0LJNko+Q==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199018)(40470700004)(46966006)(36840700001)(83380400001)(336012)(82310400005)(2906002)(2616005)(47076005)(66899018)(450100002)(70206006)(4326008)(8676002)(5660300002)(36860700001)(26005)(186003)(70586007)(41300700001)(81166007)(8936002)(36756003)(6666004)(107886003)(82740400003)(478600001)(6486002)(40480700001)(356005)(40460700003)(54906003)(6512007)(6506007)(316002)(110136005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 13:04:10.0682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a00dce6e-e15f-4c84-cdd7-08db1f0c711c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT030.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7701
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 03/06/2023 18:08, Edgecombe, Rick P wrote:
> On Mon, 2023-03-06 at 17:31 +0100, Florian Weimer wrote:
> > I assume there is no desire at all on the kernel side that
> > sigaltstack
> > transparently allocates the shadow stack?  
> 
> It could have some nice benefit for some apps, so I did look into it.
> 
> > Because there is no
> > deallocation function today for sigaltstack?
> 
> Yea, this is why we can't do it transparently. There was some
> discussion up the thread on this.

changing/disabling the alt stack is not valid while a handler is
executing on it. if we don't allow jumping out and back to an
alt stack (swapcontext) then there can be only one alt stack
live per thread and change/disable can do the shadow stack free.

if jump back is allowed (linux even makes it race-free with
SS_AUTODISARM) then the life-time of alt stack is extended
beyond change/disable (jump back to an unregistered alt stack).

to support jump back to an alt stack the requirements are

1) user has to manage an alt shadow stack together with the alt
   stack (requies user code change, not just libc).

2) kernel has to push a restore token on the thread shadow stack
   on signal entry (at least in case of alt shadow stack, and
   deal with corner cases around shadow stack overflow).
