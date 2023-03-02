Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B876A87CB
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 18:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjCBRW6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 12:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCBRW5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 12:22:57 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2073.outbound.protection.outlook.com [40.107.15.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A73E4;
        Thu,  2 Mar 2023 09:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pj8/GuZFRj5A2HK+TIuV2q9nJOl3/038ewsSkcZSCFE=;
 b=sEp2M+H8DZ9FjPJkgEquGHAFJ6S7Uf5dZeekxU3QOwmqjeFn8T1hFq7XPEeZ78q5mG85chuBAbRRnJwnVuOTlBc/dcNaaJvv9+zPDgh66h5YfI3GRINbFPuGO0OocYBjGaBXnSfUWq4iAyxweFpIYyEOdU7jKj78mQb5FN5OVHE=
Received: from DB9PR06CA0014.eurprd06.prod.outlook.com (2603:10a6:10:1db::19)
 by DB9PR08MB9684.eurprd08.prod.outlook.com (2603:10a6:10:460::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 17:22:47 +0000
Received: from DBAEUR03FT011.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:1db:cafe::9a) by DB9PR06CA0014.outlook.office365.com
 (2603:10a6:10:1db::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 17:22:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT011.mail.protection.outlook.com (100.127.142.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.20 via Frontend Transport; Thu, 2 Mar 2023 17:22:47 +0000
Received: ("Tessian outbound cfb430c87a1e:v135"); Thu, 02 Mar 2023 17:22:46 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 792ff07a717a2c49
X-CR-MTA-TID: 64aa7808
Received: from 577749fc1fbc.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 43449BA5-A136-4DA6-BA09-8648F1DECC4C.1;
        Thu, 02 Mar 2023 17:22:36 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 577749fc1fbc.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 02 Mar 2023 17:22:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lB4QnfWPJs4t8EIM8ooLjS8wooraQdXLbBRTPMPmDvhiZnOy7sFfNISP4tYo05yDX9+JGI9Vywtk3jkfn5bVWVmoD9Ebb0iylYWF0FLD+9fgFb0bAAWKKWPvk20KG2dVEtgxOzwVz+sv3oGs1hXFPKRuDpWEY5JYpsNhsjKgOraFF7gfrtI+pQfg5p24E8XADvbAEZL45UMNaxxjHQKj8CA6DHN3hWPEIg82CnAlNCBf2QVAKTqNMpj+DIptZgfp+O1CuoVX4Ngw1i8ehoBTEJlm8uTm0JvgwywIQLyQwvTSTDIa3LEY4p/0ucmnKIyzME2dxx+yhnUvD5REt9DMuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pj8/GuZFRj5A2HK+TIuV2q9nJOl3/038ewsSkcZSCFE=;
 b=fYZgGOGtjstJKz5wgTaBjmfTGBbnwTqBTF2LFX3AsSVIik9eO6I28c87StQQ6NCj2zfyS34EGaUJQEIazUDUNgUZQCndFb2M6VMPejqnO+53Zo3SdX9yv1jtuypRkZ+zdHpizK+4hoY/tEYMwvGRPyXrtmIMvB9oszN/jKhnMbG9G97y3LBtwhSSS2HHPTmK1Wy3DZVQCp7afORUvkGD6KRkgIvovrnk9RqEsNUBp0s8cGC7AqLtV6dUNJNK4ZKpQSkFZJRL54oZ8WeVeWDcy9BGsCRKDPA7yQlBxOLOavnHchtfbBPVML4DpBYorZujYfyv6KoLOlRDzXm5cv4xdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pj8/GuZFRj5A2HK+TIuV2q9nJOl3/038ewsSkcZSCFE=;
 b=sEp2M+H8DZ9FjPJkgEquGHAFJ6S7Uf5dZeekxU3QOwmqjeFn8T1hFq7XPEeZ78q5mG85chuBAbRRnJwnVuOTlBc/dcNaaJvv9+zPDgh66h5YfI3GRINbFPuGO0OocYBjGaBXnSfUWq4iAyxweFpIYyEOdU7jKj78mQb5FN5OVHE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AM7PR08MB5304.eurprd08.prod.outlook.com (2603:10a6:20b:10e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 17:22:22 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::e3d1:5a4:db0c:43cc]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::e3d1:5a4:db0c:43cc%6]) with mapi id 15.20.6134.027; Thu, 2 Mar 2023
 17:22:22 +0000
Date:   Thu, 2 Mar 2023 17:22:07 +0000
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
        david@redhat.com, debug@rivosinc.com
Cc:     nd@arm.com, al.grant@arm.com
Subject: Re: [PATCH v7 33/41] x86/shstk: Introduce map_shadow_stack syscall
Message-ID: <ZADbP7HvyPHuwUY9@arm.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-34-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230227222957.24501-34-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: LO2P123CA0092.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::7) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|AM7PR08MB5304:EE_|DBAEUR03FT011:EE_|DB9PR08MB9684:EE_
X-MS-Office365-Filtering-Correlation-Id: 48fdda02-b8c2-4563-c140-08db1b42be35
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: u/91laHY+UOhrbKGbX+FBpYcIppEdZ6guaSXiPiMED5Cozact7OXOODTAQWHIZSDkaq4/T819i1poQi9MdVhD6MlKI6BYcWPPeGXmWy/l5Mw6wvK5m1sYKHGbPa6307JFDD0DVl4wVrziRg20UbiaSk3YR4HG6WANKTAvmMyAoElLVHtIiymlDHmIi/yQ5JUQDW2YJ/nZZLv/EpuKihjSswHr4PCuFu3X9GroeNieii7ori/Z5Fv0IVHlyfNH+xPBgUOzz/xqyVT++jDGLZz0vo4dPYx9GtUDIQm1Ufgw9BVLawliYI5gX+2QPtBxqbruSU663vOczfbsVnsU4F3Lhkf18R1mIdIHEG/9xlMCShq7KpjIvrJHd+ekab8X1fYUhz1QLljTzVkipQV/VJIttwnxKhjruiuBUIoz8qT+rU4HQ3dZWi4ytDqlWxRvYigz/bUbHcWwf03+i8U/Z4m+VfmOqIVyyCXhS5E6m7OfYHsdJKFP2j3zVSkcceZbAzbJqwNZPMh7+jtPWNI6/AxbYjt6lqz9M6p7ujcyHX9GsxHkeSZ/CQ5JasgQUmtMk5urP67jRrVhwT3xtPt+KLNgenPp+efLZ4zClRhgoi8mxYmKKve9qoA0PRH0XJ0YxrVXQ7/7icFTeiHJte6HvldQpRN6cg3ffUOnHJTN5yH6wo1QFAKv/j99MrnLGekV93Z
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199018)(26005)(38100700002)(44832011)(186003)(8936002)(7416002)(5660300002)(7406005)(66899018)(6512007)(921005)(2906002)(6506007)(41300700001)(6666004)(2616005)(8676002)(4326008)(6486002)(66476007)(66556008)(66946007)(316002)(86362001)(110136005)(83380400001)(478600001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5304
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4c0cd65a-06f5-44f3-6bd3-08db1b42aeae
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kmJULEtsoaBvxNEs0/hguPco3dytaYiEaae5GtK3FmgU8Kqvg0NL63kIAJRrqRtR1pWS8RrsDq92rp8GuknmhsyuxfoRJgTtcJr5gIEhdwZ7/O2CXOyd4bdW2TIubuxLTzfEKTns+BtD94JEB4/cdSw9xoSQ4tMvNP7P4K9Hzm/VXdPCTxHGM+7M4fLNARu7jirssTeUKbq24edwgJWJuqzThrdW5k7+L3Pego84KTzdVM78Zxf7Uw+C5Kb3wZ2U5tNdie9f6V1rbNCOnxjd+23fSfx0L2GX33zOvhT8gIRLe8K8inAJhi8+sJvmmHd8VFWoOuunJLtlvln/5ogOs8kzZrXrqUgqdCWQ6nq84csQibejqptBq+TMyA8oKNY9eh7rf45SKHbn8MYADCMsf1ixq8gydXS+UNJ7GwXRmGfNenGMkZOHySQ0hkvVrbKhrLSYhEW7GuQiiQJe1hfCAKwMvYRcySd1YAzqqspzjYollLpNpiZmFeNMLJ7eSQB+KJ3nI6tXHs2I3ratQKFP3W/amdy+6nfI7JecrXIQwSobQDR25OlM9yeFvtoLhAWTuxeBM1D5hRYeLsYa5X97RmbwMSNUEvHwq6bA5b44T7JxyMHftqrF/JMqiyZQKp1fZwXVS7TD37k2+VVCGuJ0pTFS40jE7ZOYn/40303ngZaj4BDFtn2C6d6WTsO9oc/SU+eVxruErNYezwRD2VcYuqqZxRgfkPfnsyRkkhxbynQ=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199018)(40470700004)(46966006)(36840700001)(83380400001)(70206006)(36860700001)(66899018)(47076005)(6666004)(36756003)(40460700003)(5660300002)(478600001)(81166007)(82740400003)(8936002)(356005)(921005)(86362001)(82310400005)(40480700001)(2616005)(26005)(186003)(336012)(6512007)(6486002)(6506007)(2906002)(44832011)(8676002)(70586007)(4326008)(450100002)(316002)(41300700001)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 17:22:47.5886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48fdda02-b8c2-4563-c140-08db1b42be35
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9684
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 02/27/2023 14:29, Rick Edgecombe wrote:
> Previously, a new PROT_SHADOW_STACK was attempted,
...
> So rather than repurpose two existing syscalls (mmap, madvise) that don't
> quite fit, just implement a new map_shadow_stack syscall to allow
> userspace to map and setup new shadow stacks in one step. While ucontext
> is the primary motivator, userspace may have other unforeseen reasons to
> setup it's own shadow stacks using the WRSS instruction. Towards this
> provide a flag so that stacks can be optionally setup securely for the
> common case of ucontext without enabling WRSS. Or potentially have the
> kernel set up the shadow stack in some new way.
...
> The following example demonstrates how to create a new shadow stack with
> map_shadow_stack:
> void *shstk = map_shadow_stack(addr, stack_size, SHADOW_STACK_SET_TOKEN);

i think

mmap(addr, size, PROT_READ, MAP_ANON|MAP_SHADOW_STACK, -1, 0);

could do the same with less disruption to users (new syscalls
are harder to deal with than new flags). it would do the
guard page and initial token setup too (there is no flag for
it but could be squeezed in).

most of the mmap features need not be available (EINVAL) when
MAP_SHADOW_STACK is specified.

the main drawback is running out of mmap flags so extension
is limited. (but the new syscall has limitations too).
