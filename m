Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1554F758595
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jul 2023 21:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGRTdW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Jul 2023 15:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjGRTdV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Jul 2023 15:33:21 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70714198D;
        Tue, 18 Jul 2023 12:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbcWwves2v4iicynp9C3iqq3rUEVjyS9KDYBiXaecNI=;
 b=YIEmAZDLssbfG+RPsXfxcigYslJn9VaVjzmVI9VADFBlWkfSgLh9SulQ46lL5kTDRASvROheTH6Cwn7FvstXxA1lKl50GUA/yXmI2LYbPHQxIPpk686C0SuT2qjGCuZw1dsc+C3y45ts46upv3387B3LMCukE0l7s3RahEabaII=
Received: from DB8PR04CA0025.eurprd04.prod.outlook.com (2603:10a6:10:110::35)
 by DU0PR08MB9393.eurprd08.prod.outlook.com (2603:10a6:10:420::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Tue, 18 Jul
 2023 19:33:13 +0000
Received: from DBAEUR03FT012.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:110:cafe::41) by DB8PR04CA0025.outlook.office365.com
 (2603:10a6:10:110::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Tue, 18 Jul 2023 19:33:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT012.mail.protection.outlook.com (100.127.142.126) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.33 via Frontend Transport; Tue, 18 Jul 2023 19:33:13 +0000
Received: ("Tessian outbound 95df046a2e2c:v145"); Tue, 18 Jul 2023 19:33:13 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a512fcba0873fea2
X-CR-MTA-TID: 64aa7808
Received: from 1389fd84b299.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 49F7C953-1C87-494C-931F-358AE7072268.1;
        Tue, 18 Jul 2023 19:33:06 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1389fd84b299.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 18 Jul 2023 19:33:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdG7ivjRBBR67heySxEen4axvhChrfdtx79cCT5q6noEDF9BxF9TMm+r1q+Tcy9KtyytKF4fzb6UF3wkuAwpREdVgttXBmYtebfQhyW3rOG7FLSXJ099DFYAkmxmteUgl4OZFyEcumy2CIexvY3bPHgHXnMSXSSIKjcLDegJIvBTaJcblPQESbBCUr/82lcmaL4AgpoZfdkmA4OJNhgnWZldJUzQxbgKJnmStE05k8RRtXEf7UuzW93cxzXW9ybhA7gz9hlEMJxVlNV9w96wDoPVyvOE8lEjellJ1pBYVxAsuElUjAVMRo0DVOaeK/yWzBauXTvyPOibt8Rso+ZcKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbcWwves2v4iicynp9C3iqq3rUEVjyS9KDYBiXaecNI=;
 b=Ph6icODrVMavSP9nvAwc2JGNUUw43cRtUpGIJILwBUvVTzVZYD7AUIyik2oeuzSaqdvjHUwVq4cRuVqQ3Nj2I1JTVOFVR74YMl8BQr2RgKyCO6brRO9c2U98ywfuxWGyE5TGln0NX/BRI3fLRdOcZ4yLf8HR+hMea9ZhhZTpse1b0wqnRsCOr1GbVD02X5KJxi2LFvgT2Y1l/OGYwm/STt+OkwBfPdfX2+qc/pFAfBXtMYjJp/mjDqIY/KvIhQEopsu+9Ca5kIBtL2Bqdr77zjbY7y9W40NZ4F7g5Tcb8HJxycFDvlGs6iJ4HP8o+Ipn98/r6e1rKsZcsgNuOyvyQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbcWwves2v4iicynp9C3iqq3rUEVjyS9KDYBiXaecNI=;
 b=YIEmAZDLssbfG+RPsXfxcigYslJn9VaVjzmVI9VADFBlWkfSgLh9SulQ46lL5kTDRASvROheTH6Cwn7FvstXxA1lKl50GUA/yXmI2LYbPHQxIPpk686C0SuT2qjGCuZw1dsc+C3y45ts46upv3387B3LMCukE0l7s3RahEabaII=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB7176.eurprd08.prod.outlook.com (2603:10a6:20b:407::12)
 by VE1PR08MB5678.eurprd08.prod.outlook.com (2603:10a6:800:1a0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Tue, 18 Jul
 2023 19:33:03 +0000
Received: from AS8PR08MB7176.eurprd08.prod.outlook.com
 ([fe80::84b4:c4e1:c645:6384]) by AS8PR08MB7176.eurprd08.prod.outlook.com
 ([fe80::84b4:c4e1:c645:6384%5]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 19:33:02 +0000
Date:   Tue, 18 Jul 2023 20:32:33 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com,
        torvalds@linux-foundation.org, broonie@kernel.org
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Message-ID: <ZLbo0XWOJhXm6gWK@arm.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-24-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230613001108.3040476-24-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: SA1P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::14) To AS8PR08MB7176.eurprd08.prod.outlook.com
 (2603:10a6:20b:407::12)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR08MB7176:EE_|VE1PR08MB5678:EE_|DBAEUR03FT012:EE_|DU0PR08MB9393:EE_
X-MS-Office365-Filtering-Correlation-Id: 371d8eb3-88c4-4fbe-59ef-08db87c5d3f8
x-checkrecipientrouted: true
Content-Transfer-Encoding: quoted-printable
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: /YijKyJvPQX5DW2r1LZhZTVD6b2pZ7Vs2sCipn4M6a8J2Z4Bdhvahgifi+xP6cdqJLDHCYJrpskVvHetS8iaVvbeAjweV0Dt+GGarSNZdJqDL4782CL13Xg1MCyLq9zoc5gO7SpphDLea/y9KeyP71pHw1iYXc2hmxm0VT/t9y3V7aWlAuznwhGPgwy7/zjmd2/IibVFGbzAYzE+tDSaEYc3ia6nHGy6076DdnPnxR1DxbsfnGpi1AdNpoJHzGXMoE5WSxU309+WoFFn9GrCWDtSa+9xUhuo64pd63SYD1cUnw1mIwc2CtHNz2DGIEjS9szzp7KwCblJHwwgHHHoPf+S6rbyD/2Q3kexqdrIn7z+hsQo3SCb4b56h+bWQFXcZetuLwuwDZ+2iuhWi5g+ACqUe4GOTK6cots9KHG18GIYCnPoEfltImOevUEHsHyj6U1WvbRncXtQCVTXUjMWMKJIn1NoBxLpNYCXFb0KqmJQwQj9dSeKZFE3tvuStAco3ewfU0D4VbzoV4CLmQ79he0N+1HJWhzfUbZFq95a7ZzXXCDlsZDoyd8Kr64OD+jbO7dE+CutNRzj0P7fHpFc+2c4djp+Zpfe54w6zB7DQUA=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB7176.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199021)(6506007)(54906003)(110136005)(478600001)(26005)(186003)(921005)(6666004)(6486002)(4326008)(66556008)(66476007)(66946007)(83380400001)(2616005)(6512007)(38100700002)(5660300002)(44832011)(8936002)(8676002)(4744005)(2906002)(41300700001)(7416002)(7406005)(316002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5678
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT012.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2ecabaeb-0970-4ba9-10a0-08db87c5cc92
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Kc60r3VH2XVCQnTuPBPQWRoJ4FASSAxcJ1ne2+2to9noIxE+dFoyy3uF5stpIe8muMlA2FW6fsOTL+xLyZAQnjgqNZBE5E/k4qWgjQ0/PqCVKhLmbwMenxqTJjKxDFSodGUYh9bnmkQoqLd2mqcayj4kFUasB0w2zIfC8nfra35gtkkLetd2HERu7vF/8i+J4SXtdre1JJNSK3Pu+AhZePvA/kTT6zAPoB+VwxfwG81+nSxsBRKeH4450dVZ1fTbRsA1Lb0Q4xyuWNng1UYrhuPL40s8HN3Y1KVcZr4oP0zC+zyY/vAIYnUrlwbU/G7MXaNrF1C0M5DxK8nTBGSazz4WljZA6Dfp7qF4djNQfFS7MggpxFsJ9iiozrK3Lq/KXqxSIJsZrgzqGqsJd96hVC7MNRXEbMjn04hk5In8wF7w3srGGaKChc8maQR3+GnkWOwfRP2payzfft55H0y0IK7fMU4efsDZwTaxaPxnR8GVq0q4XnC4t2aZlyevuwO1L21cXydqXV/H80tYK7TxxBfEd9KuEKKcO9BKR0n224UWYLKidQ/z/aNjXR3TeJoW7DrNJ5KdKQMQrO/HpQFZWlZYktTA0m/O4z/oGwWw/VP+I1hZGq3wdMoMLX4umYsWQlB1TNNM9U5vBqB9lOJaQ5LQ9OroVWyu9RaS9dEFnWvgmAkBFvZ2enmISUgyCP6QuCFc+MAnjrocqxfSJhkhlxGHlHuec7yo+KUJLV0uw9VavtKUCyp+7Ht5GKPZKup
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(41300700001)(2906002)(316002)(44832011)(8936002)(8676002)(5660300002)(4744005)(40460700003)(36756003)(40480700001)(86362001)(6486002)(6666004)(356005)(921005)(81166007)(110136005)(54906003)(82740400003)(478600001)(6506007)(26005)(107886003)(336012)(186003)(6512007)(2616005)(36860700001)(70586007)(70206006)(450100002)(4326008)(47076005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 19:33:13.7476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 371d8eb3-88c4-4fbe-59ef-08db87c5d3f8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT012.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9393
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 06/12/2023 17:10, Rick Edgecombe wrote:
> Introduce a new document on Control-flow Enforcement Technology (CET).
>
> Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Tested-by: Kees Cook <keescook@chromium.org>

i don't have more comments on this.

Reviewed-by: Szabolcs Nagy <szabolcs.nagy@arm.com>

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
