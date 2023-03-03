Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC76C6A9DDE
	for <lists+linux-arch@lfdr.de>; Fri,  3 Mar 2023 18:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjCCRkS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Mar 2023 12:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjCCRkR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Mar 2023 12:40:17 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2073.outbound.protection.outlook.com [40.107.247.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7DB19693;
        Fri,  3 Mar 2023 09:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zb0z77rTLxbhwHIJ+nIMWrqRkaU1VxL9wNbFu4NMnIo=;
 b=Pa6A8S3yrlit6l13R4GqkSC4TfZa8O/dFy6da7Th3KX2Kn1rsafvG58rMdS12DGkkODw64q8Vv/ckbAvFyvA5VefCWZnJ4C3BnpR7uX3mSAEZrrWbNda7uZCexKDtP+xKVbuGPNRHLDIGAAx6GPT/Ddia1OdSYo+K04mrz6vbNI=
Received: from DBBPR09CA0028.eurprd09.prod.outlook.com (2603:10a6:10:d4::16)
 by AM8PR08MB6531.eurprd08.prod.outlook.com (2603:10a6:20b:355::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.21; Fri, 3 Mar
 2023 17:39:43 +0000
Received: from DBAEUR03FT015.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:d4:cafe::bd) by DBBPR09CA0028.outlook.office365.com
 (2603:10a6:10:d4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Fri, 3 Mar 2023 17:39:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT015.mail.protection.outlook.com (100.127.142.112) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.21 via Frontend Transport; Fri, 3 Mar 2023 17:39:43 +0000
Received: ("Tessian outbound 2ba0ed2ebb9f:v135"); Fri, 03 Mar 2023 17:39:42 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7c1788aba651410f
X-CR-MTA-TID: 64aa7808
Received: from 4f51883f0994.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0094D8F4-9AA1-438C-850C-71E0AB3A0364.1;
        Fri, 03 Mar 2023 17:39:35 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4f51883f0994.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 03 Mar 2023 17:39:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArLaq7Atrf76DWOuSsiyILktawCEHXo7BJWFRSs41Ze50AYciJiQgxCKKsokwsJEATkJ7CpiOQlugX/8YlpUv9ASP9JcCNF1IqBRvOpsUGr9CWrmCFJErF42N/lZ1ksTldaFw1j/yHAAF0KXcD5eUBPKtYT7RRS/FPvkU7bzQH8SPeVq61Wifr4nLMMGTfeBtqZUoPJ76O6e9lPx9gWK2m6ks4VQpQh5OeAWtWTrTQWbAtrplHsLikqEiQEfVceTm7t10DyvwqzIECzqhu8Xjv0CUwnJk82YQwvD5pFJ8xd1HZtWwRaqQ3g//j/2bBVjE/1ERBVo31+Ky/NKSnaAaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zb0z77rTLxbhwHIJ+nIMWrqRkaU1VxL9wNbFu4NMnIo=;
 b=oC39TH9G9p3miBJFaROJQa6ttEXAFSiV6lTYFghk/vIMyCWEZdCa6dkAUCi4dyUsoxgxP87wZ5LvUQ2E+oJe/shU2/5ertC5q6kR4AuvvrFGEkQ8jF6RBUAFvZi9Xs6+Jg5Ag+ziCi+mYKf0oGTE+/KaQEsyJkgZoGDZiUIuDKDfvSfUePmFCnd+oLjoEnefaUu9i+7RtrxpwlcuZMYKjVhJOzmiJh3vCGJfIH4T+d6SH6XlL4qnAPaTWjvgl+hl1SaP+0Pjw4jzbsVBd0r4X55DenhqNdUk/eertQ4gcoDNm02t/6fEYi3b6XtQ7SkyPtBIDQBsLgBgCKmF2qaKWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zb0z77rTLxbhwHIJ+nIMWrqRkaU1VxL9wNbFu4NMnIo=;
 b=Pa6A8S3yrlit6l13R4GqkSC4TfZa8O/dFy6da7Th3KX2Kn1rsafvG58rMdS12DGkkODw64q8Vv/ckbAvFyvA5VefCWZnJ4C3BnpR7uX3mSAEZrrWbNda7uZCexKDtP+xKVbuGPNRHLDIGAAx6GPT/Ddia1OdSYo+K04mrz6vbNI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by DB4PR08MB9262.eurprd08.prod.outlook.com (2603:10a6:10:3f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Fri, 3 Mar
 2023 17:39:34 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::e3d1:5a4:db0c:43cc]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::e3d1:5a4:db0c:43cc%6]) with mapi id 15.20.6134.027; Fri, 3 Mar 2023
 17:39:34 +0000
Date:   Fri, 3 Mar 2023 17:39:06 +0000
From:   "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
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
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>, "nd@arm.com" <nd@arm.com>
Subject: Re: [PATCH v7 01/41] Documentation/x86: Add CET shadow stack
 description
Message-ID: <ZAIwuvfPqNW/w3yt@arm.com>
References: <Y/9fdYQ8Cd0GI+8C@arm.com>
 <636de4a28a42a082f182e940fbd8e63ea23895cc.camel@intel.com>
 <ZADLZJI1W1PCJf5t@arm.com>
 <8153f5d15ec6aa4a221fb945e16d315068bd06e4.camel@intel.com>
 <ZAIgrXQ4670gxlE4@arm.com>
 <CAMe9rOrM=HXBY25rYrjLnHzSvHFuui06qRpc4xufxeaaGW-Fmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMe9rOrM=HXBY25rYrjLnHzSvHFuui06qRpc4xufxeaaGW-Fmw@mail.gmail.com>
X-ClientProxiedBy: SN7P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::17) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|DB4PR08MB9262:EE_|DBAEUR03FT015:EE_|AM8PR08MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aca97c7-08db-4bd0-34d8-08db1c0e45ec
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: YwH8ViLKUZAnX3aytvxUXeAJBlN5q6Tcwp1WN0R+FEsFzM7gYdIETRYy9Bh/o4FHyfJK181QZBqEeCuxrChKYnZgflT8UMCylAWzrGZmKqRS5qvzUIB8cfTPT42JAYksI5++ekBRlpy4fom5vfyNlV1KcJZzLzJJbQyfs04Wxj4zhIyyb+0pBrT506krDswwdJ+UGeZB9Ii8yXVF1RXh0KnBVpBMcYBSg/MEpkMQsJPicq8iaAVRHBmo8Jl4uawmVmMmQB1av2HxP/E0YjF5qxcQ+YgLv0EM/iWRdRakAInJFYoZCW1z1E0k4SxOUDSCr76fjVbPcBPHj25jA/ROppv3ExNNup+r43lCO5DSngVPBj42YYTAeWRnk1GTE+Y0PUZWmE3J49QDa4dm8L1xgIDZiFvczhYWFKmm29u/jYiBZQJVR5oq2XF+UaiRFz/Zd1Gj2ho8x77I+bAsxmdKSw9NGbSA0cLS0XAtghT217ap6sq5DadtqXh6bJGmiYhe90PFmiHQOriX9bGntPTvOj6cjE5fxDo1Ph1VvmuLe1dB1Mwy7jLXjsxxVhQsYVvTO3rwtpLV/YytgPuxSDrrrLkC+dZgfJQMkcBfRv3dloiU5O1yutj9OX7KwLF8G/e1MP+bIjyyTp+qeijLOEsOGg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199018)(66476007)(6916009)(66556008)(36756003)(54906003)(8676002)(66946007)(4326008)(316002)(2906002)(41300700001)(83380400001)(6486002)(26005)(6506007)(478600001)(6666004)(53546011)(6512007)(186003)(86362001)(38100700002)(4744005)(2616005)(7416002)(5660300002)(7406005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9262
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT015.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5e7b7c14-a57c-4919-9a7e-08db1c0e3fda
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fADR57DSBj6HB5+q16tguZC5OkAmPvNYX/oSn8IzMW3Xk8OQWjNh8VnuDSwVeTdpZHDFhhmMowLvaPd37QkX2JoH9FcHADbao869WX+arZjHpv61ezveQPGwhWt1UNIn0e5B84smvfqPjgkRYzIQ5HzD+T9NRoc1b1Uo70+bWmxbsd3htS7ZSMuOI2uymaLy1Abfw/bRvVUkrcB9eWaGUd2D3Z3t+OGYyyT9t/2+5fV88oJRzPd+tZmtxQJd3sg1SLAnNJmoavz0CmJJ/ATxBWDbh8C2JhoV6do4F5j4UULFqIPNObUFlOAyZ7DdRmOsICt1h+WbPnAWCN39xFa32nLuiXpnOzhiQuSTYfzBONsePPBqAd/Q/KoDADSmGBViNdD5TXI718q7KU5OMcyIWqzodc2oirUIFJSXzC7kHcQ7+GhOutMf1/staD76q051J9uWeUPKCLxPXkumhvdqy8kqeB/KeB+3icqldjk7OHJRyIQ0Ex6/CUIX4FZDCycjyQBmeUb8KqflrmaQR9E9oAKaAfBtryNCGduydlVhMcoBXJlAC9K/z/aCie/h3hFobaI/2HOrsHj66+SmhxOUe+WkfN/DaLRjxI/wTleJh3aJWtgS8iKnV4GEvr3Y0DB0DPfWPS5l10Xg55aRCWgW8c8DKDoTm9lXNjnHlT0f4jcy60QNIUAZKmoUp54yp1ROP3khhJ++CHdTmfLA/XnG9g==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199018)(46966006)(36840700001)(40470700004)(47076005)(40460700003)(36756003)(336012)(6666004)(6506007)(6512007)(6486002)(41300700001)(2616005)(26005)(186003)(316002)(54906003)(4326008)(450100002)(70206006)(8676002)(4744005)(70586007)(2906002)(6862004)(5660300002)(478600001)(86362001)(82740400003)(81166007)(53546011)(82310400005)(40480700001)(356005)(83380400001)(8936002)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 17:39:43.1128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aca97c7-08db-4bd0-34d8-08db1c0e45ec
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT015.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6531
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 03/03/2023 08:57, H.J. Lu wrote:
> On Fri, Mar 3, 2023 at 8:31 AM szabolcs.nagy@arm.com
> <szabolcs.nagy@arm.com> wrote:
> > longjmp to different stack should work: it can do the same as
> > setcontext/swapcontext: scan for the pivot token. then only
> > longjmp out of alt shadow stack fails. (this is non-conforming
> > longjmp use, but e.g. qemu relies on it.)
> 
> Restore token may not be used with longjmp.  Unlike setcontext/swapcontext,
> longjmp is optional.  If longjmp isn't called, there will be an extra
> token on shadow
> stack and RET will fail.

what do you mean longjmp is optional?

it can scan the target shadow stack and decide if it's the
same as the current one or not and in the latter case there
should be a restore token to switch to. then it can INCSSP
to reach the target SSP state.

qemu does setjmp, then swapcontext, then longjmp back.
swapcontext can change the stack, but leaves a token behind
so longjmp can switch back.
