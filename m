Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E717863B919
	for <lists+linux-arch@lfdr.de>; Tue, 29 Nov 2022 05:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbiK2EZq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Nov 2022 23:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbiK2EZo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Nov 2022 23:25:44 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11012002.outbound.protection.outlook.com [52.101.63.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3294B3AC29;
        Mon, 28 Nov 2022 20:25:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEP34gApR6PBHPxWrBH18ULvAJukluq2VVV0MVkkYeOfoMujrgwNUEM+a2HAbYWkFlxcU5YMsteJ+vL6PBvRAk8BRBfmb0WFMAy0EmOAiR5mxCGaDYmCGBy5r/iyywTc4N2xoFw/lDWbRSiwuNpJQhS+wjz+S9Cu0g2+lz1wfvHGTUEE4AXaspvibtKMnunQ49fu2mvsXqhszF1cpzMIZMSdaBmWkMAtrOELVk9GuYhQdhlCXZLmi1JTcEWrGXJDjLRYb2qEDq8vvz4y0IFHnX1ihJJOogE05kBBc4P6R+RihEcKTRw01Mt2xM0UpZJZXbwJq8MOUkRGq5MEhAOGKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XPY/cLjmtIOwUqQvy+ekL9u1mcQ6yRKxe59hoY17xU=;
 b=mMJ+qruhQNEgQ1ymVopthsMyaTBi8VXBSIX8yi3hwa5hRC21kokLGfdcR2egsS5aLxPkzrgqkzhjLlr1b4239qyFQL02TYEo1ryYZryIhPPTPRzCL3uTmflSaxuanmys2YwsZwb2+7/eFv7me8ktBrIOBIZR+PAq/3gGpHn7zsMsMyqcegdv+VX/GdMqUIcFF8N91CTwUz1rdMNohi1Cuzz2WAgNVsWfcChgtVhji16CwXKPukkKxwF+zIP2HcStXsghv7pT71O0qi/uleIFG6i/dL5EVZWoO9m1gkemmvBvI/ZFQ3o+sjfQ3ANMHP3xmktpbbrUvTCFbEXCoAjxNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XPY/cLjmtIOwUqQvy+ekL9u1mcQ6yRKxe59hoY17xU=;
 b=ZvSJdxKiOviYspXghR1tqbifCMf5TOxIBrQkQiHr8Wyxf4kYuPf0te70lFYBph4446Qfa5Ttgl2WlNdPamdtmESu+wTsWoAPaUu5/iRVJxPupir34F6G1xfT5efXxB2e7Kt/ktrtXB3G+vX/qUbI0T7alzU04GokCiIvZ2PhPes=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BL0PR05MB5507.namprd05.prod.outlook.com (2603:10b6:208:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Tue, 29 Nov
 2022 04:25:39 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f57e:85ed:97ea:b642]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f57e:85ed:97ea:b642%9]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 04:25:39 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] compiler: inline does not imply notrace
Thread-Topic: [PATCH 3/3] compiler: inline does not imply notrace
Thread-Index: AQHY/qw4yX0fCsinjkK7j3XEu4rqM65LXzUAgAAL0gCACc5dAIAAG7QAgAAC0wA=
Date:   Tue, 29 Nov 2022 04:25:38 +0000
Message-ID: <2CFF9131-48E9-44D3-93CA-976C47106092@vmware.com>
References: <20221122195329.252654-1-namit@vmware.com>
 <20221122195329.252654-4-namit@vmware.com>
 <de999ab8-78ff-44f7-aacc-68561897c6e2@app.fastmail.com>
 <B764D38F-470D-4022-A818-73814F442473@vmware.com>
 <4BDE3655-CCC3-412B-9DDB-226485113706@vmware.com>
 <20221128231532.40210855@gandalf.local.home>
In-Reply-To: <20221128231532.40210855@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|BL0PR05MB5507:EE_
x-ms-office365-filtering-correlation-id: 5535a56c-3e0d-4306-36a3-08dad1c1c4fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Ka6lkH6UeIriH3GBSMsZhm7orkwPP3JiM9gBVSargIHTVhWYMib3yR0gko6s6csWI3jmW8US71nlpwH5wqV/RVkmFbHKaDF/v9MW9VbeXiH8jf+eitZU5sgrp/YQwL82xYi6yc9WF4Ql+GTwhAlcbKL7ya6JKh8bjfEKfnjkfZVZr1WWAosX0/AMmdZrWholzteEC3K61CT4AehRmbx0mBa3l9V6rBSqYvpeLRs1fNPmOSCJNQRo2T+SWmH+Mc0YNHR8mhedT0vYjz8TljD3wRUcJjBtmlykT+rMmJHQtP76+HlgUhQ5xBeU073PB+Xbv5K51HuO2ug0zRAiZQQqOxg7yxXchk6mZoQzPId/UnGsvGZLG8BFMIG737Wgnym5KjgL6UyApuz/Xq7Vt9WOYDGoetyN54CMhwxJHZJNDsJzIIDnlrpmVHDmcbW2J/Hwj9nYrbBJgUVdce6p7pyv/I0/LbSVgBWe8MDbH01yiIMARvmMS15kLnNbrvlMML1M0SGbZklxdv86lhm3bCLx+aipymlokOuqj6wxL3uyKWiPw/PDIrfsr5wmZtLqiNw3SfJRZ9vm7pcR/uZQuHvJArB68yD9cRMbd36USWNkbjWPY5A0IindipNacv5W8XOIjURQDbWtgepkWNGasvt9k+cHAu6rgHWpa1fINQyhJyw0LbVXNHotQDD6QPjX4VsIWa4AkJw3d8q4TNxi9cR751AsYzUC5cxKZJuBIwTfyyBHI1nLwpr7d3eR8fVNOZ97ihjFt/3fpEfvIO7i+oRRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199015)(71200400001)(6506007)(6512007)(26005)(76116006)(316002)(478600001)(53546011)(6916009)(6486002)(2616005)(83380400001)(41300700001)(66946007)(8936002)(7416002)(8676002)(64756008)(66556008)(66476007)(54906003)(186003)(66446008)(5660300002)(4326008)(2906002)(36756003)(122000001)(86362001)(38100700002)(38070700005)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzRIMWFHYzUxL3JXRUNjeUJUZFZKUitBTzRTSFRkRnYxMno1NjBaeFhGVCtw?=
 =?utf-8?B?SkNTTkRCVXJXYk1jL0RJd2VnaEF5bko2dlQwMEo2MDRvSk1EdmcxOUxHMkRP?=
 =?utf-8?B?Z29la2ozU1d2VUhFeTM5M2I1ZWg2QXZSNVMwb2t5bkk4U25kakxhZkJYNERH?=
 =?utf-8?B?S1U3LzFNZXhlemI2K3ltOHkzblFXUGZBaERITnZneEduTXBOZ2o2aVJ4TzMz?=
 =?utf-8?B?YnpRVE1zYVB1YkpCNXhZRWh2bnBTNy9iaElRZ3dsbm9uSmhvdVBqMDcvQU5w?=
 =?utf-8?B?aGhOaGU0OHhubmhKNHVPNnpmdm94NmhYbmptTEFBQ0Nvbk5XNHQ5YzRxWVZv?=
 =?utf-8?B?elhGYjVJSDFnaTFqd0ZzM2JENitPM1I3bis3Wmp2cUovS1g3dnhsVW0rSVJO?=
 =?utf-8?B?ZWkrSzRxM0xBTmNacVJ2SVhjQWtvRHpTaFY0cGhvemczZlRyUVFkcGtheDdm?=
 =?utf-8?B?KzFoeUoxNDc5K0NCKytIZGJBdzhJZzF1UlgvclNJNktjemsxLzh3SC84MC9Q?=
 =?utf-8?B?UTl6R3czQ3ZOQVJjdDFzTmF4eERHNXE4ZTFwRmpDcVFabTdSYml4Vi9yNmtw?=
 =?utf-8?B?WVkyTS9TS0N4SG1Ed09yVGJMamxGSjRVcmRqcmh2SG1KdENHL1BQaUVzUkNh?=
 =?utf-8?B?QVRZN3JrZEloZ3BYdHRwQnlRTnJjTnV1MkUxQVRpWS9iMGFSTHJ6RjdHK0xK?=
 =?utf-8?B?RytKS1lQclFtU3JZa0pjUHZURExCMTc5UWg4RktCZ1ZLZGs3dDVxVXgrMUl1?=
 =?utf-8?B?TS94YU9TWEdEaDRXVDBsM3JhbnFoUENyL29GS0RZS2JoQUxpTVZDTldxOVJT?=
 =?utf-8?B?eXVnaDd3ckJkaXdvUGYrMCs5UGY2L1FhaW1vWkQyMFJTMmo1aEFnazEwU0ZK?=
 =?utf-8?B?ODRkTWZEQzBheW8yblZsMkFYaFUxOWhha2RnMGhPb0dRd2xaUmZpOERTZWdN?=
 =?utf-8?B?c2IyRzYzSUlxbGV4d3NqcjdlMCtvNVQyS1MyN2NxcUZLd3VKeWtDWk9PaWc2?=
 =?utf-8?B?QUZQM0VzQytNNHdwRHNUUzJhREI5cDFhL2ZiY0tBWENqM0xwVWNMaWhVM1hh?=
 =?utf-8?B?Sk5XRi9OeGdnemkyV1laS1RtWThNK2Eyb3VvbnR2cGQzVDZOL096bjhiV3Ny?=
 =?utf-8?B?YnQvVW1sN29aaHVkK2Zwczg3WExxa0VPaHAwTmJIYy9icW9IVm9hLzhwdGxn?=
 =?utf-8?B?d0hYckg1QXZaSDNIVDlTUkhQSmZ5bFZmN2VjZjMrTXRwK0drYy9XcHAvRFZB?=
 =?utf-8?B?NHZsTkxWYjVtVGdSSlBiMGR6MlJKL0Z5WUxCRDhwbk5pdW9TY2lBaDNLYWF3?=
 =?utf-8?B?VXJnV0VEK2M0V2hPZTdUL0FraHk5dXZuNDRDeGp5VmNuSGJobHprcVhuZEhm?=
 =?utf-8?B?TlJRU0xoVldMMHBtVWVhTVBpTWdTKzlGQy9vTkp3b1JvTVhTeG1PdnZQNkF0?=
 =?utf-8?B?WVA1SlZ2T1RyZ3Y4dUFIaklZWHZlRW1IQUhzRStpQXlOc3VLK3RnKzZWdnJK?=
 =?utf-8?B?RUlIeWhaNm9rOHkxM25wa04yWFVjUm5lWC92M3A3VE9lY3Q0QStBVmQ0bWVi?=
 =?utf-8?B?VzN5bmV1Tm4zU1BjVzJCeUxGNkhIUFVFVjd5bURoaTh3VU51a3g4ZVpFYzRH?=
 =?utf-8?B?UGxGUE1HMGI4NkxpM29EbEYxZDh4M1lXcVpURjlkTkFsenArWXVkWXcybEhE?=
 =?utf-8?B?MDhEWHkreEdWTmM2U2RSejdadFpUVklqN0JKaURkbkhYaVl5YXJTNmhDMyt1?=
 =?utf-8?B?L2JnRmdRNWdXZEJiekM3cjU1TEpmVW5YMjJibTJLKzdRbHg0WElRTDNLT0sy?=
 =?utf-8?B?T0pBMXJsaTByTlp0N0piaDgxU0N4V3ZlNldaMTlCNC9ESEVLUm1Ya3JBOWJv?=
 =?utf-8?B?RmxwQTBTYTRYSFB1QThWWEE4eWN3WHBMTXVLVG5uZVdVYlhPanlVTjdsbTEv?=
 =?utf-8?B?WWo5QmlpVUM3eWgrL1liTFQ1Q0tZYWtLUVF3K0JEK05sSkpBY2d3Qit4Rm55?=
 =?utf-8?B?OUViMlhDM2JSVkdNaVpRQkZEWkxjRXJkZjZjU1lCT0ttT3hoZ0crc0t1Skc5?=
 =?utf-8?B?MXY5aUJaVlM4bXRTWTh5a21GUGdGT3hkTURkY3BGWXFQSElXakcvS1VabDRm?=
 =?utf-8?Q?9FFFlf2M51Gf2DEM+oNFkz0AV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C435735893CE2047B4FC8FB77ACCF1FC@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5535a56c-3e0d-4306-36a3-08dad1c1c4fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 04:25:39.0077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GyCWsE6NpW5lF7Ga4yYq0G30qNZV5wchtYsW0b8SjJ+VJoUcO8jGIBLBp1+rzQ4Pj2IKHQXa2Rrr9wbRNAbFAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB5507
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTm92IDI4LCAyMDIyLCBhdCA4OjE1IFBNLCBTdGV2ZW4gUm9zdGVkdCA8cm9zdGVkdEBnb29k
bWlzLm9yZz4gd3JvdGU6DQoNCj4gISEgRXh0ZXJuYWwgRW1haWwNCj4gDQo+IE9uIFR1ZSwgMjkg
Tm92IDIwMjIgMDI6MzY6MjIgKzAwMDANCj4gTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4g
d3JvdGU6DQo+IA0KPj4gT24gTm92IDIyLCAyMDIyLCBhdCAxMjo1MSBQTSwgTmFkYXYgQW1pdCA8
bmFtaXRAdm13YXJlLmNvbT4gd3JvdGU6DQo+PiANCj4+PiBCdXQgbW9yZSBpbXBvcnRhbnRseSwg
dGhlIGN1cnJlbnQg4oCcaW5saW5l4oCdLT7igJ1ub3RyYWNl4oCdIHNvbHV0aW9uIGp1c3QgcGFw
ZXJzDQo+Pj4gb3ZlciBtaXNzaW5nIOKAnG5vdHJhY2XigJ0gYW5ub3RhdGlvbnMuIEFueW9uZSBj
YW4gcmVtb3ZlIHRoZSDigJxpbmxpbmXigJ0gYXQgYW55DQo+Pj4gZ2l2ZW4gbW9tZW50IHNpbmNl
IHRoZXJlIGlzIG5vIGRpcmVjdCAob3IgaW5kaXJlY3QpIHJlbGF0aW9uc2hpcCBiZXR3ZWVuDQo+
Pj4g4oCcaW5saW5l4oCdIGFuZCDigJxub3RyYWNl4oCdLiBJdCBzZWVtcyB0byBtZSBhbGwgcmFu
ZG9tIGFuZCBib3VuZCB0byBmYWlsIGF0IHNvbWUNCj4+PiBwb2ludC4NCj4+IA0KPj4gUGV0ZXIs
IFN0ZXZlbiwgKGFuZCBvdGhlcnMpLA0KPj4gDQo+PiBCZXlvbmQgdGhlIGlzc3VlcyB0aGF0IGFy
ZSBhZGRyZXNzZWQgaW4gdGhpcyBwYXRjaC1zZXQsIEkgZW5jb3VudGVyZWQgb25lDQo+PiBtb3Jl
LCB3aGljaCByZWl0ZXJhdGVzIHRoZSBmYWN0IHRoYXQgdGhlIGhldXJpc3RpY3Mgb2YgbWFya2lu
ZyDigJxpbmxpbmXigJ0NCj4+IGZ1bmN0aW9ucyBhcyDigJxub3RyYWNl4oCdIGlzIG5vdCBnb29k
IGVub3VnaC4NCj4+IA0KPj4gQmVmb3JlIEkgc2VuZCBhIHBhdGNoLCBJIHdvdWxkIGxpa2UgdG8g
Z2V0IHlvdXIgZmVlZGJhY2suIEkgaW5jbHVkZSBhIHNwbGF0DQo+PiBiZWxvdy4gSXQgYXBwZWFl
cnMgdGhlIGV4ZWN1dGlvbiBtaWdodCBnZXQgc3R1Y2sgc2luY2Ugc29tZSBmdW5jdGlvbnMgdGhh
dA0KPj4gY2FuIGJlIHVzZWQgZm9yIGZ1bmN0aW9uIHRyYWNpbmcgY2FuIGJlIHRyYWNlZCB0aGVt
c2VsdmVzLg0KPj4gDQo+PiBGb3IgZXhhbXBsZSwgX19rZXJuZWxfdGV4dF9hZGRyZXNzKCkgYW5k
IHVud2luZF9nZXRfcmV0dXJuX2FkZHJlc3MoKSBhcmUNCj4+IHRyYWNlYWJsZS4gSSB0aGluayB0
aGF0IHdlIG5lZWQgdG8gZGlzYWxsb3cgdGhlIHRyYWNpbmcgb2YgYWxsIGZ1bmN0aW9ucw0KPj4g
dGhhdCBhcmUgY2FsbGVkIGRpcmVjdGx5IGFuZCBpbmRpcmVjdGx5IGZyb20gZnVuY3Rpb25fc3Rh
Y2tfdHJhY2VfY2FsbCgpDQo+PiAoaS5lLiwgdGhleSBhcmUgaW4gdGhlIGR5bmFtaWMgZXh0ZW50
IG9mIGZ1bmN0aW9uX3N0YWNrX3RyYWNlX2NhbGwpLg0KPiANCj4gSG93IGRpZCB0aGlzIGhhcHBl
bi4gSXQgc2hvdWxkIGJlIGFibGUgdG8gaGFuZGxlIHJlY3Vyc2lvbjoNCj4gDQo+IHN0YXRpYyB2
b2lkDQo+IGZ1bmN0aW9uX3N0YWNrX3RyYWNlX2NhbGwodW5zaWduZWQgbG9uZyBpcCwgdW5zaWdu
ZWQgbG9uZyBwYXJlbnRfaXAsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZnRy
YWNlX29wcyAqb3AsIHN0cnVjdCBmdHJhY2VfcmVncyAqZnJlZ3MpDQo+IHsNCj4gICAgICAgIHN0
cnVjdCB0cmFjZV9hcnJheSAqdHIgPSBvcC0+cHJpdmF0ZTsNCj4gICAgICAgIHN0cnVjdCB0cmFj
ZV9hcnJheV9jcHUgKmRhdGE7DQo+ICAgICAgICB1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiAgICAg
ICAgbG9uZyBkaXNhYmxlZDsNCj4gICAgICAgIGludCBjcHU7DQo+ICAgICAgICB1bnNpZ25lZCBp
bnQgdHJhY2VfY3R4Ow0KPiANCj4gICAgICAgIGlmICh1bmxpa2VseSghdHItPmZ1bmN0aW9uX2Vu
YWJsZWQpKQ0KPiAgICAgICAgICAgICAgICByZXR1cm47DQo+IA0KPiAgICAgICAgLyoNCj4gICAg
ICAgICAqIE5lZWQgdG8gdXNlIHJhdywgc2luY2UgdGhpcyBtdXN0IGJlIGNhbGxlZCBiZWZvcmUg
dGhlDQo+ICAgICAgICAgKiByZWN1cnNpdmUgcHJvdGVjdGlvbiBpcyBwZXJmb3JtZWQuDQo+ICAg
ICAgICAgKi8NCj4gICAgICAgIGxvY2FsX2lycV9zYXZlKGZsYWdzKTsNCj4gICAgICAgIGNwdSA9
IHJhd19zbXBfcHJvY2Vzc29yX2lkKCk7DQo+ICAgICAgICBkYXRhID0gcGVyX2NwdV9wdHIodHIt
PmFycmF5X2J1ZmZlci5kYXRhLCBjcHUpOw0KPiAgICAgICAgZGlzYWJsZWQgPSBhdG9taWNfaW5j
X3JldHVybigmZGF0YS0+ZGlzYWJsZWQpOw0KPiANCj4gICAgICAgIGlmIChsaWtlbHkoZGlzYWJs
ZWQgPT0gMSkpIHsgPDw8LS0tLSBUaGlzIHN0b3BzIHJlY3Vyc2lvbg0KPiANCj4gICAgICAgICAg
ICAgICAgdHJhY2VfY3R4ID0gdHJhY2luZ19nZW5fY3R4X2ZsYWdzKGZsYWdzKTsNCj4gICAgICAg
ICAgICAgICAgdHJhY2VfZnVuY3Rpb24odHIsIGlwLCBwYXJlbnRfaXAsIHRyYWNlX2N0eCk7DQo+
ICAgICAgICAgICAgICAgIF9fdHJhY2Vfc3RhY2sodHIsIHRyYWNlX2N0eCwgU1RBQ0tfU0tJUCk7
DQo+ICAgICAgICB9DQo+IA0KPiAgICAgICAgYXRvbWljX2RlYygmZGF0YS0+ZGlzYWJsZWQpOw0K
PiAgICAgICAgbG9jYWxfaXJxX3Jlc3RvcmUoZmxhZ3MpOw0KPiB9DQo+IA0KPiBFYWNoIG9mIHRo
ZSBzdGFjayB0cmFjZSBmdW5jdGlvbnMgbWF5IHJlY3Vyc2UgYmFjayBpbnRvIHRoaXMgZnVuY3Rp
b24sIGJ1dA0KPiBpdCB3aWxsIG5vdCByZWN1cnNlIGZ1cnRoZXIuIEhvdyBkaWQgaXQgY3Jhc2g/
DQoNClVnaC4gVGhhbmtzLiBJIGRpZG7igJl0IGtub3cgdGhhdCAtIHNvIHlvdXIgaW5wdXQgaXMg
cmVhbGx5IGhlbHBmdWwuDQoNCkkgd2lsbCBuZWVkIHRvIGZ1cnRoZXIgZGVidWcgaXQsIGJ1dCB0
aGlzIGlzc3VlIGRvZXMgbm90IG9jY3VyIGV2ZXJ5IHRpbWUuDQoNClRoZSBrZXJuZWwgZGlkbuKA
mXQgY3Jhc2ggZXhhY3RseSAtIGl04oCZcyBtb3JlIG9mIGEgZGVhZGxvY2suIEkgaGF2ZSBsb2Nr
ZGVwDQplbmFibGVkLCBzbyBpdCBpcyBub3QgYSBkZWFkbG9jayB0aGF0IGxvY2tkZXAga25vd3Mu
IENvdWxkIGl0IGJlIHRoYXQNCnNvbWVob3cgdGhpbmdzIGp1c3Qgc2xvd2VkIGRvd24gZHVlIHRv
IElQSXMgYW5kIG1vc3RseS1kaXNhYmxlZCBJUlFzPyBJIGhhdmUNCm5vIGlkZWEuIEkgd291bGQg
bmVlZCB0byByZWNyZWF0ZSB0aGUgc2NlbmFyaW8uIA0KDQpGb3IgdGhlIHJlY29yZCwgSSB0cmll
ZCB0byBzYXZlZCBzb21lIGRldGFpbHMgaW4gdGhlIHByZXZpb3VzIGVtYWlsLiBJdCB3YXMNCmtp
bmQgb2YgaGFyZCB0byB1bmRlcnN0YW5kIHdoYXTigJlzIGdvaW5nIG9uIG9uIHRoZSBvdGhlciBj
b3Jlcywgc2luY2UgdGhlDQp0cmFjZSBvZiBvdGhlciBjb3JlcyB3YXMgaW50ZXJsZWF2ZWQuIEkg
ZXh0cmFjdCB0aGUgcGFydHMgZnJvbSB0aGF0IEkgdGhpbmsNCnRoZSByZWZlciB0byB0aGUgYW5v
dGhlciBDUFUgKHllcywgdGhlIG91dHB1dCBpcyByZWFsbHkgc2xvdywgYXMgc2VlbiBpbiB0aGUN
CnRpbWVzdGFtcHMpOg0KDQpbNTMxNDEzLjkyMzYyOF0gQ29kZTogMDAgMDAgMzEgYzAgZWIgZjEg
MGYgMWYgODAgMDAgMDAgMDAgMDAgZTggMWIgMmUgMTYgM2UgNTUgNDggODkgZTUgYzYgMDcgMDAg
MGYgMWYgMDAgZjcgYzYgMDAgMDIgMDAgMDAgNzQgMDYgZmIgMGYgMWYgNDQgMDAgMDAgPGJmPiAw
MSAwMCAwMCAwMCBlOCA5OSBkYSBmMSBmZSA2NSA4YiAwNSBmMiA5OSBkNyA3ZCA4NSBjMCA3NCAw
MiA1ZA0KDQpBbGwgY29kZQ0KPT09PT09PT0NCjA6IDAwIDAwIGFkZCAlYWwsKCVyYXgpDQoyOiAz
MSBjMCB4b3IgJWVheCwlZWF4DQo0OiBlYiBmMSBqbXAgMHhmZmZmZmZmZmZmZmZmZmY3DQo2OiAw
ZiAxZiA4MCAwMCAwMCAwMCAwMCBub3BsIDB4MCglcmF4KQ0KZDogZTggMWIgMmUgMTYgM2UgY2Fs
bCAweDNlMTYyZTJkDQoxMjogNTUgcHVzaCAlcmJwDQoxMzogNDggODkgZTUgbW92ICVyc3AsJXJi
cA0KMTY6IGM2IDA3IDAwIG1vdmIgJDB4MCwoJXJkaSkNCjE5OiAwZiAxZiAwMCBub3BsICglcmF4
KQ0KMWM6IGY3IGM2IDAwIDAyIDAwIDAwIHRlc3QgJDB4MjAwLCVlc2kNCjIyOiA3NCAwNiBqZSAw
eDJhDQoyNDogZmIgc3RpIA0KMjU6IDBmIDFmIDQ0IDAwIDAwIG5vcGwgMHgwKCVyYXgsJXJheCwx
KQ0KMmE6KiBiZiAwMSAwMCAwMCAwMCBtb3YgJDB4MSwlZWRpIDwtLSB0cmFwcGluZyBpbnN0cnVj
dGlvbg0KMmY6IGU4IDk5IGRhIGYxIGZlIGNhbGwgMHhmZmZmZmZmZmZlZjFkYWNkDQozNDogNjUg
OGIgMDUgZjIgOTkgZDcgN2QgbW92ICVnczoweDdkZDc5OWYyKCVyaXApLCVlYXggIyAweDdkZDc5
YTJkDQozYjogODUgYzAgdGVzdCAlZWF4LCVlYXgNCjNkOiA3NCAwMiBqZSAweDQxDQozZjogNWQg
cG9wICVyYnANCg0KQ29kZSBzdGFydGluZyB3aXRoIHRoZSBmYXVsdGluZyBpbnN0cnVjdGlvbg0K
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KMDogYmYgMDEgMDAg
MDAgMDAgbW92ICQweDEsJWVkaQ0KNTogZTggOTkgZGEgZjEgZmUgY2FsbCAweGZmZmZmZmZmZmVm
MWRhYTMNCmE6IDY1IDhiIDA1IGYyIDk5IGQ3IDdkIG1vdiAlZ3M6MHg3ZGQ3OTlmMiglcmlwKSwl
ZWF4ICMgMHg3ZGQ3OWEwMw0KMTE6IDg1IGMwIHRlc3QgJWVheCwlZWF4DQoxMzogNzQgMDIgamUg
MHgxNw0KMTU6IDVkIHBvcCAlcmJwDQoNCls1MzE0MTQuMDY2NzY1XSBSU1A6IDAwMTg6ZmZmZmM5
MDAwYzlhNzdkOCBFRkxBR1M6IDAwMDAwMjA2DQpbNTMxNDE0LjA3Nzk0M10gUklQOiAwMDEwOnNt
cF9jYWxsX2Z1bmN0aW9uX21hbnlfY29uZCAoa2VybmVsL3NtcC5jOjQ0MyBrZXJuZWwvc21wLmM6
OTg4KSANCls1MzE0MTYuOTg3MzUxXSBvbl9lYWNoX2NwdV9jb25kX21hc2sgKGtlcm5lbC9zbXAu
YzoxMTU1KSANCls1MzE0MTYuMjA1ODYyXSA/IHRleHRfcG9rZV9tZW1zZXQgKGFyY2gveDg2L2tl
cm5lbC9hbHRlcm5hdGl2ZS5jOjEyOTYpIA0KWzUzMTQxNi42ODEyOTRdID8gdGV4dF9wb2tlX21l
bXNldCAoYXJjaC94ODYva2VybmVsL2FsdGVybmF0aXZlLmM6MTI5NikgDQpbNTMxNDE3LjQ2ODQ0
M10gdGV4dF9wb2tlX2JwX2JhdGNoIChhcmNoL3g4Ni9rZXJuZWwvYWx0ZXJuYXRpdmUuYzoxNTUz
KSANCls1MzE0MTguOTM5OTIzXSBhcmNoX2Z0cmFjZV91cGRhdGVfdHJhbXBvbGluZSAoYXJjaC94
ODYva2VybmVsL2Z0cmFjZS5jOjUwMCkNCls1MzE0MTkuODgyMDU1XSA/IGZ0cmFjZV9ub19waWRf
d3JpdGUgKGtlcm5lbC90cmFjZS9mdHJhY2UuYzo3ODY0KSANCls1MzE0MjAuNTEwMzc2XSBmdHJh
Y2VfdXBkYXRlX3BpZF9mdW5jIChrZXJuZWwvdHJhY2UvZnRyYWNlLmM6Mzc0IChkaXNjcmltaW5h
dG9yIDEpKQ0KWzUzMTQyMC43ODQ3MDNdIGZ0cmFjZV9waWRfb3BlbiAoa2VybmVsL3RyYWNlL2Z0
cmFjZS5jOjI5MTgga2VybmVsL3RyYWNlL2Z0cmFjZS5jOjI5MzIga2VybmVsL3RyYWNlL2Z0cmFj
ZS5jOjc3MjUga2VybmVsL3RyYWNlL2Z0cmFjZS5jOjc4MzUga2VybmVsL3RyYWNlL2Z0cmFjZS5j
Ojc4NjUpIA0KWzUzMTQyMS44NTEyOTRdIHZmc19vcGVuIChmcy9vcGVuLmM6MTAxNykNCg0KDQoN
Cg==
