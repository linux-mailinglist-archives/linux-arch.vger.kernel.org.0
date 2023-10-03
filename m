Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2FF7B6035
	for <lists+linux-arch@lfdr.de>; Tue,  3 Oct 2023 07:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjJCFHT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Oct 2023 01:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjJCFHT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Oct 2023 01:07:19 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CF6A9;
        Mon,  2 Oct 2023 22:07:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjCl9KnO6MyGkNB1RPwjBv+OIlAyzsTscMd9pvgF0Y3QGq+au9G6LG/r9B3xV0XNiFlF66+N8U6Er7j7X28l2wzPcJD9DVpXPzCrZiOEYjY1oJrtIb6SMXNrmbWJoCU5xbUBEui8k8Qe1GAy192pU3dVkO69J43zoho9OKLIpeA7nbhFLZsMJ02c61u8hX64A5VBNiuHlHK8NGTGHB7TQiJdMEDXqaiF+5UHEfwbkQngwXVl+Zbx+/m1ERehOxmldQVk0lPP/1RpNHLtkew6CAM2fVKgUEL+4oHQK8LsxbIUoO7jekxIfn0M3OjFxgG+izS53tsX5+8nOuFVWjTmGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IjjJV73tb1uR5tm+EJa6oxhTuzazV3RhmoDK3EYdnA=;
 b=ZskEaRlosN3PzsnNEmxtX9wMzmytcn3A9ST2Ruph0GPu27RzQOJQ5QYI82QxygZ2xHB4VWbnez0t73KQr8hozDsuqRLQLTTa8kKz4i5bZ+bCsmge3d/uPzK1EDyCoV7JtcFdk2g43XregaradD7QdGGedvik+Kyl1WZH/a6unk3K1dBXM5CUbfGzGY6zbp3lR57B2z97dp5omzD9zJFQM9NH0h8leD3/8ofFkfp6oo54jyzpinf4AocJ1BMjaxHvDavJ2FGsy1j/T6MFvMFCuPzOkDiK9v7xAU/asICNBAvRNKy+kEhOznMsddBEEpO2ZjOgk7ajXz9pHT99CZC8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IjjJV73tb1uR5tm+EJa6oxhTuzazV3RhmoDK3EYdnA=;
 b=p4cYQHoWcO8MYtgmsAgNTe6LL5jypIZpwXqvyWbu756oslz4CKp1uUDabvutcG0TOutlVVx00V2bPq4iHqREqwNiI6wggimcTxTfjTNSBdo3B1Wc77Z33gvxkXzccHP6y1u77JOLNf89/xQIH6FxJX7Axuy0Rbqc8RcgDfizze9MaIKDsOK3FLbCPH2KH91H5ZDci76yOYmd1BnDXoDeuMUioWsSGGFT6f+S3EM3rovpPAUnxqgzHoAJ8fXjisWpGOUzfL3WypujLl5L7keTgW84E3bfMuCc334NTXTMa6F6iBoCloNF5MCUT32eM0anLyC9q8KTL5mSZvC8l1c5+w==
Received: from PH0PR08MB7955.namprd08.prod.outlook.com (2603:10b6:510:11a::17)
 by BN0PR08MB7294.namprd08.prod.outlook.com (2603:10b6:408:14a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 05:07:10 +0000
Received: from PH0PR08MB7955.namprd08.prod.outlook.com
 ([fe80::ee86:3818:3342:933d]) by PH0PR08MB7955.namprd08.prod.outlook.com
 ([fe80::ee86:3818:3342:933d%7]) with mapi id 15.20.6813.027; Tue, 3 Oct 2023
 05:07:10 +0000
From:   Srinivasulu Thanneeru <sthanneeru@micron.com>
To:     "Huang, Ying" <ying.huang@intel.com>,
        Ravis OpenSrc <Ravis.OpenSrc@micron.com>
CC:     "linux-mm@vger.kernel.org" <linux-mm@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de" <arnd@arndb.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        John Groves <jgroves@micron.com>,
        Eishan Mirakhur <emirakhur@micron.com>,
        Vishal Tanna <vtanna@micron.com>
Subject: Re: [EXT] Re: [RFC PATCH 0/2] mm: mempolicy: Multi-tier interleaving
Thread-Topic: [EXT] Re: [RFC PATCH 0/2] mm: mempolicy: Multi-tier interleaving
Thread-Index: AQHZ8SgSd7VrgZiMdUSwwsnheXTUbLAvxRyogAe/Czs=
Date:   Tue, 3 Oct 2023 05:07:10 +0000
Message-ID: <PH0PR08MB79559353E5C579D066C992B6A8C4A@PH0PR08MB7955.namprd08.prod.outlook.com>
References: <20230927095002.10245-1-ravis.opensrc@micron.com>
 <87v8burfhz.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87v8burfhz.fsf@yhuang6-desk2.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Enabled=True;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SetDate=2023-10-03T05:07:08.833Z;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Name=Confidential;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ContentBits=0;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=micron.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR08MB7955:EE_|BN0PR08MB7294:EE_
x-ms-office365-filtering-correlation-id: aee41b1b-6082-409c-8873-08dbc3ce9927
x-ld-processed: f38a5ecd-2813-4862-b11b-ac1d563c806f,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zczp6A4zR5RjAD6ibNoYDh/yz1IPDOwGKg8oWOyHUhlvpTo95jsIgueJ/PXqCDcpPsuOY9wblNNJYl5Zam0sMDuKyPlCXK7u4vFuwDwz3+rsOQTd176u4d5llxCPIL1ugaT642S+RscCs8sGU0RkUytPi0oaF5rjI+QIFENq/MyTncfvf/vhxw5ULzwgMQ5It2u4bl0t9bozdNFxjaz5KUeSzvn7Nwvx5AYVxLc6f0gSROMFP4eCN4Hk03+jsK8yE3ucgPTtQ8zEjz+X6yg4k3kww+UOiI/S7y4kVKVAha7bc2PAinNAw3nVVRJ2RQbvn5lXr7YsK5qn5HYtxluSdcS3Q3+sZc4avp1LN/kceS7BEZxQxl5VwHzIWGtV+7OzAcKtgQlNeucGuZzXw63eRCZKXxMWrbro8ea/0tA2ZwTHNTbjeTNpwNddTVb/zrmUeIzPwQrUcEzBbYCZ6/H4fxTEY70+wVNRasqK6OHGr02HGONDJyvdQKxrLLOP+c/1au1Lf1dIKx971Yma7XXrgFqg24ZBQ11Q5H7+/VQ0Z+r0CbPtS0HErfG+lZL1CiPwzDoHR4Pw4xU8eeto30nWxCkeEbOcKQ1f+61+5/5++tk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR08MB7955.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(39860400002)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(2906002)(83380400001)(7416002)(86362001)(33656002)(38100700002)(38070700005)(122000001)(55016003)(53546011)(316002)(66946007)(76116006)(6636002)(54906003)(66446008)(66476007)(66556008)(64756008)(9686003)(7696005)(6506007)(91956017)(110136005)(107886003)(41300700001)(966005)(45080400002)(478600001)(71200400001)(52536014)(4326008)(8676002)(5660300002)(26005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?MnYvQzNCQUI4Smtid1FERmRkblJyWVVSZDFHUjUycGRsNkR2dDZnbjBrb2ti?=
 =?utf-7?B?OGNZeFVnNHlPMVpZQlc0MUY1VGRIVTc0eXY0ODBmNzJsUE5mMC83NWpOdUM4?=
 =?utf-7?B?b2didG4xaExRQWJkMkNmYUd5YjlzUmttUmY0VHNHTystS0RUZUdqdUpsV0pl?=
 =?utf-7?B?WTI3Z1RlNnlsRjgyanptREZDQldyQXVnaVM5RkxCQ0ZWdmlvMEFWb3FIZWVS?=
 =?utf-7?B?MmFLbnZWb3ZYVUk5eWwxY0FWVUhtMEU5cSstWTlQeWMwUDg0TnBYTVpIR2xn?=
 =?utf-7?B?MmMxOGhKbFpuQ3Uva1NvU0ZuY0dUb0dFalovRW52Ry9UN2RpaEVqbGhwWTI1?=
 =?utf-7?B?L3JzKy04Um9UUjZqZ1pPKy1LZURsY2hNMjB2dWNCQ2dqbHd0cDdnUU5IUnJD?=
 =?utf-7?B?Qm1jT2hGdVFNcXlETGozSE5VKy1oVjVYYkgrLXhxSDNFZjJRamtlSDlIaE4y?=
 =?utf-7?B?MlVXSG5wa2JIMldTeDR6WnExTngwU1FaenEvVzdIUHR5UVIrLTdvU2QyU2Q=?=
 =?utf-7?B?Ky1rS3I1Y0Nib3N6Vncvakx1cWJ4TEl1d0ZxUjlaVnkvdzB6ZUNGQ2JRVklR?=
 =?utf-7?B?NWhSV0JwQjF2bVg5dGozdFM0TGFkaUxlVDU5VW5wdzhVVHpYdUQwVzhTYVla?=
 =?utf-7?B?Ym85bXZFOU96Mjl4MXhBQjNwYTljUTFoaGp1anViRUlma3lCakE2a2VFeXFl?=
 =?utf-7?B?RlEvTUNpRktKT1JFSFczdklib2JKUCstV3NqZ1Exc2wrLTlvYUJCVzZ1Ky1L?=
 =?utf-7?B?WUZNd29zZC9CWmlab0ZmRjhOOWJycHIyNistV2RoWEN3TS94TystZks1MFgw?=
 =?utf-7?B?TVlwbklCRzZpNXM4Z2tEZC9zRHllU1pvNVZtU2Y3aGtrSnVZRVI2Y1pLWkFD?=
 =?utf-7?B?a1J0ejlIQU9GUUZ5V2I2MlZsQkprSzZoNnNGSzRFcDFxdDIvdklpWTJLTlJv?=
 =?utf-7?B?VTJvdHlsLzVSSXJmQm50Vzd5Qk9XalJoRG1JN01kaGM3Qk0yeGltdkdTS0g2?=
 =?utf-7?B?dkhNS1ovRnF2UmVEYk1Uemw3REFSNVN1WmJlZDVONHp4d0tLTlJSaTY0Y09E?=
 =?utf-7?B?cVJ0ODdwMHdlWll5NWZUbFkxV0IyL0NqcFcyMzY0bmRTM3JrZXhyL3VpNllN?=
 =?utf-7?B?NjdtZVpZSm5ZZmdiL0xjT253bmZTbXNXaTNlNThJSERQZEEyRFZMQ3NyREhm?=
 =?utf-7?B?ZFlsQU9pT0NMRnhuOTJVaWJ3eFpHa04rLTZ4ZkFVNjhTaXRnV3FpV2ZXdmIv?=
 =?utf-7?B?M3R0dFRWUUN1Mk1KSS9zQWpMcW1sQTRMbVpaQjBiZi9rMEN1Tk5oQ3ArLVhx?=
 =?utf-7?B?bXlrcXpXYjdDdDJ2dy9aOVl1bE9DM1h1cC9BMmM5Q0Vzc0ZRSjN2QTFoNkxj?=
 =?utf-7?B?OXJkTGVmSkdXbUdydFhCa2diUGVnU1REbDg5RXR0WTJIZlVYTW9XVUsxQjV3?=
 =?utf-7?B?U3g2NVJIUmNudzlyUGU5aTJNZmpZdXNjRWNnc1BSTnNQV0RmZkZzMktQS3hM?=
 =?utf-7?B?YjJ1YystSGxJSzF1a3pwN0ZLNzYrLWNGZ0VkbFlEUzAxd3p2d01lbHczYkE=?=
 =?utf-7?B?Ky1nZGNib1VrdzRWTllSY3NTT1VYKy1ZRHJROVpsYi9tL0VER3NyWTVSOGNS?=
 =?utf-7?B?VWF0RFpVcGU0VUt2YzVLWFhkT242bTRJTFpTdTdQYThQWEZ5MXhtR0dVMGtX?=
 =?utf-7?B?enFzWHlEQ3R5R1ZFSUZqOWg2TG5Dd3NWaGIwL284THh2anFnZlNZTFZYTXBI?=
 =?utf-7?B?NWw1VGYvN3ZUY2t3amE0d1pCQ2JTZ0JEbkhmMU9LVUdHUm1HeGRQMmVRanZQ?=
 =?utf-7?B?QmlrOW0wUlNxeEZ4d3lwVzI3bnd1RVdhZkllb3ozaGJRb04rLUd0V3hDd2Nu?=
 =?utf-7?B?c2djd1FRS0RHUElPeVQzcmZGUUc2MjFCNnlpU0lyc1FZNXhrWVdQQlRFenVw?=
 =?utf-7?B?ZmpSU2lOMG0yc2N4RUJYcWY1Yk9NYU0zQnBLU3JCMERRUjM3MUZhQ2hWSC8w?=
 =?utf-7?B?b1NUYSstaGQ4MFlkc01DTnNiZ253d1lMTlBkZjdXL2c5eDgxamxLNTU3N25R?=
 =?utf-7?B?dDk4WWt4Sm1tZzhaUzVLMVAvOWR4VVFjNk9QQ0IrLVljclpGTTlmVmNxdUpz?=
 =?utf-7?B?S1J0ZmhUZm5JSUNnaEd2MktQak1vZ1llaFJCSjJoUzcwdXZ4WXllQzhIVGk1?=
 =?utf-7?B?UkFwVg==?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR08MB7955.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee41b1b-6082-409c-8873-08dbc3ce9927
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 05:07:10.2791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tsqOWzpsof6DcjzI20c8cxxuf8sWq3T/0gC/gEeiZzZrylAQ7moCawG3V4lcDsVgsAzR4X+EyJgxvqZDH88M/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR08MB7294
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Micron Confidential

Hi Huang,

Thanks to you for your comments and in the next version, these suggestions =
will be incorporated.

Regards,
Srini

Micron Confidential
+AF8AXwBfAF8AXwBfAF8AXwBfAF8AXwBfAF8AXwBfAF8AXwBfAF8AXwBfAF8AXwBfAF8AXwBfAF=
8AXwBfAF8AXwBfAF8AXwBfAF8AXwBfAF8-
From: Huang, Ying +ADw-ying.huang+AEA-intel.com+AD4-
Sent: Thursday, September 28, 2023 11:44 AM
To: Ravis OpenSrc
Cc: linux-mm+AEA-vger.kernel.org+ADs- linux-cxl+AEA-vger.kernel.org+ADs- li=
nux-kernel+AEA-vger.kernel.org+ADs- linux-arch+AEA-vger.kernel.org+ADs- lin=
ux-api+AEA-vger.kernel.org+ADs- luto+AEA-kernel.org+ADs- tglx+AEA-linutroni=
x.de+ADs- mingo+AEA-redhat.com+ADs- bp+AEA-alien8.de+ADs- dietmar.eggemann+=
AEA-arm.com+ADs- vincent.guittot+AEA-linaro.org+ADs- dave.hansen+AEA-linux.=
intel.com+ADs- hpa+AEA-zytor.com+ADs- arnd+AEA-arndb.de+ADs- akpm+AEA-linux=
-foundation.org+ADs- x86+AEA-kernel.org+ADs- aneesh.kumar+AEA-linux.ibm.com=
+ADs- gregory.price+AEA-memverge.com+ADs- John Groves+ADs- Srinivasulu Than=
neeru+ADs- Eishan Mirakhur+ADs- Vishal Tanna
Subject: +AFs-EXT+AF0- Re: +AFs-RFC PATCH 0/2+AF0- mm: mempolicy: Multi-tie=
r interleaving

CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless you =
recognize the sender and were expecting this message.


Hi, Ravi,

Thanks for the patch+ACE-

Ravi Jonnalagadda +ADw-ravis.opensrc+AEA-micron.com+AD4- writes:

+AD4- From: Ravi Shankar +ADw-ravis.opensrc+AEA-micron.com+AD4-
+AD4-
+AD4- Hello,
+AD4-
+AD4- The current interleave policy operates by interleaving page requests
+AD4- among nodes defined in the memory policy. To accommodate the
+AD4- introduction of memory tiers for various memory types (e.g., DDR, CXL=
,
+AD4- HBM, PMEM, etc.), a mechanism is needed for interleaving page request=
s
+AD4- across these memory types or tiers.

Why do we need interleaving page allocation among memory tiers?  I think
that you need to make it more explicit.  I guess that it's to increase
maximal memory bandwidth for workloads?

Yes, it is to increase the maximal memory bandwidth.

+AD4- This can be achieved by implementing an interleaving method that
+AD4- considers the tier weights.
+AD4- The tier weight will determine the proportion of nodes to select from
+AD4- those specified in the memory policy.
+AD4- A tier weight can be assigned to each memory type within the system.

What is the problem of the original interleaving?  I think you need to
make it explicit too.

The original approach, page distribution is fixed 1:1, user/admin cannot be=
 changed as required. The need to use different ratios has become evident f=
rom the introduction of new memory tiers that cover a wide range of memory =
types.

With default interleaving we observed memory bandwidth utilization is less =
compare to the proposed approach with 85:15, when interleave between DRR an=
d CXL.

We will capture this information in next series.

+AD4- Hasan Al Maruf had put forth a proposal for interleaving between two
+AD4- tiers, namely the top tier and the low tier. However, this patch was
+AD4- not adopted due to constraints on the number of available tiers.
+AD4-
+AD4- https://lore.kernel.org/linux-mm/YqD0+ACU-2FtzFwXvJ1gK6+AEA-cmpxchg.o=
rg/T/
+AD4-
+AD4- New proposed changes:
+AD4-
+AD4- 1. Introducea sysfs entry to allow setting the interleave weight for =
each
+AD4- memory tier.
+AD4- 2. Each tier with a default weight of 1, indicating a standard 1:1
+AD4- proportion.
+AD4- 3. Distribute the weight of that tier in a uniform manner across all =
nodes.
+AD4- 4. Modifications to the existing interleaving algorithm to support th=
e
+AD4- implementation of multi-tier interleaving based on tier-weights.
+AD4-
+AD4- This is inline with Huang, Ying's presentation in lpc22, 16th slide i=
n
+AD4- https://lpc.events/event/16/contributions/1209/attachments/1042/1995/=
/
+AD4- Live+ACU-20In+ACU-20a+ACU-20World+ACU-20With+ACU-20Multiple+ACU-20Mem=
ory+ACU-20Types.pdf

Thanks to refer to the original work about this.

+AD4- Observed a significant increase (165+ACU-) in bandwidth utilization
+AD4- with the newly proposed multi-tier interleaving compared to the
+AD4- traditional 1:1 interleaving approach between DDR and CXL tier nodes,
+AD4- where 85+ACU- of the bandwidth is allocated to DDR tier and 15+ACU- t=
o CXL
+AD4- tier with MLC -w2 option.

It appears that +ACI-mlc+ACI- isn't an open source software.  Better to use=
 a
open source software to test.  And, even better to use a more practical
workloads instead of a memory bandwidth/latency measurement tool.

Sure, will try it.

+AD4- Usage Example:
+AD4-
+AD4- 1. Set weights for DDR (tier4) and CXL(teir22) tiers.
+AD4- echo 85 +AD4- /sys/devices/virtual/memory+AF8-tiering/memory+AF8-tier=
4/interleave+AF8-weight
+AD4- echo 15 +AD4- /sys/devices/virtual/memory+AF8-tiering/memory+AF8-tier=
22/interleave+AF8-weight
+AD4-
+AD4- 2. Interleave between DRR(tier4, node-0) and CXL (tier22, node-1) usi=
ng numactl
+AD4- numactl -i0,1 mlc --loaded+AF8-latency W2
+AD4-
+AD4- Srinivasulu Thanneeru (2):
+AD4-   memory tier: Introduce sysfs for tier interleave weights.
+AD4-   mm: mempolicy: Interleave policy for tiered memory nodes
+AD4-
+AD4-  include/linux/memory-tiers.h +AHw-  27 +-+-+-+-+-+-+-+--
+AD4-  include/linux/sched.h        +AHw-   2 +-
+AD4-  mm/memory-tiers.c            +AHw-  67 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+=
--------
+AD4-  mm/mempolicy.c               +AHw- 107 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+=
-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+---
+AD4-  4 files changed, 174 insertions(+-), 29 deletions(-)

--
Best Regards,
Huang, Ying
