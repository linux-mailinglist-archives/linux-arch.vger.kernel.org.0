Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AB570B4A4
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 07:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjEVFpi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 01:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjEVFpg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 01:45:36 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECCECF;
        Sun, 21 May 2023 22:45:31 -0700 (PDT)
X-UUID: daa4ff3af86311ed9cb5633481061a41-20230522
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=EsDmTzL8ivZGNLDIgDBn+YiSiOUpd9phsMSc+Rve7s4=;
        b=C1YZFqMW26gb1SBQROkTMvHB7fcLr2Myb6NkeOMmVzShWrWcyh1nyV0lm+OP58UCoRB1uWUmvkvjcJ3XQVHK41Bf3V4Nzuqw2oLtT9VafWN1GZJVQOYgue5HFvXnYCPWnIVV5ivuTUYhPQLsqzzT4wfekes5uPme3wOhVgCgfH8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:61568f25-c0d7-42ed-bf3f-90f6d94af4fc,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.25,REQID:61568f25-c0d7-42ed-bf3f-90f6d94af4fc,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:d5b0ae3,CLOUDID:d36e916c-2f20-4998-991c-3b78627e4938,B
        ulkID:2305221345296VEM5IAA,BulkQuantity:0,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
        SA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: daa4ff3af86311ed9cb5633481061a41-20230522
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1774595458; Mon, 22 May 2023 13:45:27 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 22 May 2023 13:45:27 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 22 May 2023 13:45:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXpPjUCnQVoq9wXEAiScSLJOLbim62k37imrW3eT+uO2X5CdSXP60Z6i6IrEx02ORkJa4WTcHGszA7Vf9vHTJDKcRNzk9jxUzxB6cnSld84IwjcTDINoSSroEqGBNp8s/g0AeYhRJ0+S9DbU39QZZojedPOm5sjRLPcKIrD1LKsVg9yVvkE7pEMdzewgg/0uqtQGEuQ7Ej+GfX2ZqCMW/KgqeCzx5vrV7xOH6z5nnalXZ87NEgN6Elg1jHOk1E/Tru5IF89vXR4IA7vCgBb7FyhrFoNPDui4mjlLbu5SnzioPkEpQ9Eucp5hg28L1UrixKR1+0svuSioqhWpvpyCHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsDmTzL8ivZGNLDIgDBn+YiSiOUpd9phsMSc+Rve7s4=;
 b=HlZVAQAa7wQ37tkjq7tIew5grILC9DBc9zDnieTflQKXNZK1IbHElVkH0RFCSLrHhMoKAD0VnGTt8gyEEwvc/3eANJsIwNTAfTIgYNW8P3TO9yihELTNkumDIi/Cu3Tgvy04lQTVdkO+0SEtx0OCdV5lMDVMPxViWG7sXABhW2Sia30XqdZyJpXYurETjxtE5jL9CMzlEFhF6nA/Z6qudeNq4agX6rvxjgpXHlj+GmJ2iJBhsQjh/FD7wiWKwDmlIMbKW0bCzO3QNR7jUE1tVmd2q9Uh5nGwc8npnnmJV8LynrBejzJJdk0fWyQheyeNxm2qlQNjFekLMNvGTUPI/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsDmTzL8ivZGNLDIgDBn+YiSiOUpd9phsMSc+Rve7s4=;
 b=EumDi8VBGh7O+vNe6vMiNBWrVclab0C1ps1k/+ZwZVqmOtpIX4N44Kk1GzViNKh0xH9kdfWQfCrFRz817TwnlyHklHhGNX5vFhEQBtfgU1W1536hb+VE2VNeNC0ik7JL+Zsxlf3i7oARF7+rLZsjU/WkGhaYlGZQx9vYHL/2fuI=
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com (2603:1096:4:14f::8) by
 SEYPR03MB6995.apcprd03.prod.outlook.com (2603:1096:101:bd::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.27; Mon, 22 May 2023 05:45:24 +0000
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b]) by SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b%9]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 05:45:24 +0000
From:   =?utf-8?B?WWktRGUgV3UgKOWQs+S4gOW+tyk=?= <Yi-De.Wu@mediatek.com>
To:     "pavel@ucw.cz" <pavel@ucw.cz>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        =?utf-8?B?TVkgQ2h1YW5nICjojormmI7ouo0p?= <MY.Chuang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>,
        =?utf-8?B?U2hhd24gSHNpYW8gKOiVreW/l+elpSk=?= 
        <shawn.hsiao@mediatek.com>,
        =?utf-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <Miles.Chen@mediatek.com>,
        =?utf-8?B?UGVpTHVuIFN1ZWkgKOmai+WfueWAqyk=?= 
        <PeiLun.Suei@mediatek.com>,
        =?utf-8?B?TGlqdS1jbHIgQ2hlbiAo6Zmz6bqX5aaCKQ==?= 
        <Liju-clr.Chen@mediatek.com>,
        "yi-de.wu@mediatek.corp-partner.google.com" 
        <yi-de.wu@mediatek.corp-partner.google.com>,
        =?utf-8?B?SmFkZXMgU2hpaCAo5pa95ZCR546oKQ==?= 
        <jades.shih@mediatek.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "dbrazdil@google.com" <dbrazdil@google.com>,
        "yipei.chang@gmail.com" <yipei.chang@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?WWluZ3NoaXVhbiBQYW4gKOa9mOepjui7kik=?= 
        <Yingshiuan.Pan@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        =?utf-8?B?WmUteXUgV2FuZyAo546L5r6k5a6HKQ==?= 
        <Ze-yu.Wang@mediatek.com>, "will@kernel.org" <will@kernel.org>,
        =?utf-8?B?SXZhbiBUc2VuZyAo5pu+5b+X6LuSKQ==?= 
        <ivan.tseng@mediatek.com>
Subject: Re: [PATCH v2 1/7] docs: geniezone: Introduce GenieZone hypervisor
Thread-Topic: [PATCH v2 1/7] docs: geniezone: Introduce GenieZone hypervisor
Thread-Index: AQHZeb1j86IJ58u560yye9npvu25W69W8GSAgA79VIA=
Date:   Mon, 22 May 2023 05:45:24 +0000
Message-ID: <efd22069cb92b6ebc3d5e9c4e3ed440808615f80.camel@mediatek.com>
References: <20230428103622.18291-1-yi-de.wu@mediatek.com>
         <20230428103622.18291-2-yi-de.wu@mediatek.com> <ZF5ud9CedwBnWXBN@localhost>
In-Reply-To: <ZF5ud9CedwBnWXBN@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6167:EE_|SEYPR03MB6995:EE_
x-ms-office365-filtering-correlation-id: 66b1f080-6c58-4832-c38f-08db5a87bd20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L4k0GUeTG7aj54RkEbhd45N46iMFSrU/Su0Z6nNfya9gZthoIUo6jVHZ9xd6S5LAEkMMUQWuVeDnIaRDj/6/sfW4Ve71RuawS0Ws8kUAO76AAy3+QYuKL90WBSv/oqVESG/hGeHbF39LI44otESyMO9q8xHlfXz0V60GEiHKKaKy+CI+wmtDMBBd1V6r/Hzl92kuj6rFfcbYlDyhHinXEHivRzovb1PfNEYjVrj78Z7uRLdNzR/nI9cLadZOyvQeLmrYUCgqAO7Xb6Zu1K8gc70FLaqq+ovV1eflReJGL+yXqnyfF9wj4UFFtDgqBIlZAJo9FC9J1kWWryTE2X6ZZ6fQyIEbueN1FvoZ1ifFW0DZuxoqWcIkO/XqYpJWguBEVQK/mhd78kp4Uu1zR0H9jcyHVGj99omV6TrbHQ7jRntFSUujdT8Pz/bHtXuZ46SJwS6hcj6pzLVi3cCvnwwEczGR6ubPw8i/PdXCb337W1hTZ/+AOkfwI7H1zco+y+8g2xBluHEbslCtYkiCqLAnOP6TgN4coNxk9Q5P9apGMVtd/SRWLbvOJlqiSEx/SmgcwSiLp3KcmrcTzPySDPjCDDuQKWo5L4s9aqLSg+/sr/CFUWBG9Pj2g09ya3Tn2ADC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6167.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199021)(2906002)(54906003)(5660300002)(7416002)(8676002)(8936002)(66446008)(41300700001)(91956017)(76116006)(85182001)(316002)(478600001)(64756008)(66946007)(66476007)(66556008)(6916009)(4326008)(36756003)(71200400001)(6486002)(83380400001)(26005)(6512007)(6506007)(122000001)(38100700002)(86362001)(2616005)(186003)(38070700005)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFdHaGczSmRnS2RaOEVrWTZZeHl2cEtqTlJjelBUZUE3bHRmaEVWSVVlTE1v?=
 =?utf-8?B?VUFCc2pud20wQTJwQmN6blM0RE9xdnd5aURlMzMxbTlTNVpHR0pCSmRVYWpT?=
 =?utf-8?B?aS9pc1lKdWZsMDBJMU1VM21vU1NxVmV0eFBEb0Z3Ti9SemRRNWdodnpMREcv?=
 =?utf-8?B?b0dJKzNJWlByRTAzQmJEUEJCbVNaWnVzQ2VPQW5wa3I2OEMyU0ZtYmdVV3Ex?=
 =?utf-8?B?RVlkY0ZrOFNmQ094YWFSclMrQzh0Z2UwOE85YjF1L0N4RjJYRTV2ZE95M2NM?=
 =?utf-8?B?K3BnTUdTSGxtUUd6WnBtYTJFL1U5RG5GV1B4R3J1cS80eXNhM0dlWTk2TW1u?=
 =?utf-8?B?SVo4bGRxVTRHQStVZ2o5MWtjSGFFOGMxOVlJY0tvakE3Um9Wdm1WOU1Xbmg4?=
 =?utf-8?B?ZndGTUgyS3loQlFMdzBHNGJTM09ZMnhpUE9HeWhhQjVZL1BJcnFDWWFrcXVU?=
 =?utf-8?B?L3hLQmMzWThkZDJxMU0vV05vMWloQ0c4cnRyZHZxeWgzak53TUdLTmlBb0l0?=
 =?utf-8?B?MFNReDc3NzhUQURQcVdpSUFnTWt0MVZQelZUMUNoelRjTzhFb2djMXJZYXpu?=
 =?utf-8?B?ei9EU1lmWWFvcUZBQmE3Uk5ZdWFnZjVXclV6S1pnNzNmVXhkQit5c2dlOGc5?=
 =?utf-8?B?N21kMUtUb0VNRlB6MFFJak5GU04zZGpicXZ5cGw3cG9hNm9MWEdyYzZGRzhU?=
 =?utf-8?B?aUFPT3hHR0RXaCtNL3BkU1pWY1p1ajBuUVJQK2RkTVpRZnBLbVlKU0o2eit6?=
 =?utf-8?B?U0c5M09JK01NVFlRWVRKTlp3QjRyc1ZlYmswL2s4RjUySG9LbVJXRnlraGF1?=
 =?utf-8?B?b1pWVCtzTmVUR0czSkM0dkZ3QU5hblVnZXFTUCsyS3krT2g4WGlkbEVRRmYr?=
 =?utf-8?B?NWhOenM3MGtwVFM0NmNrRFRselhuZml0aElqVUV0ZUNMVW1JeDVPQVBDUmZQ?=
 =?utf-8?B?MytsTFRhNnd5ZEcva2Zic1FFdFhFc3hzcjIvR3h6OVpxaG10WG11bWFycDN2?=
 =?utf-8?B?NFZRanc1L1JpYjYycWYrd2tVekM2OEtzOHorSUFTWGFZM2pRa2UrV2UrRWRH?=
 =?utf-8?B?VElJRzBPWEc3SU5jRVpTY1hiKzFPN01kcVFTTG9HSTNqcTBya0VHY1Z1dkhi?=
 =?utf-8?B?MWgwV050ZXJ2Zkd4My80c1kvZUhCMVFWSlVzMFphODV3b0hrcWhuWldBOU9P?=
 =?utf-8?B?MVJvZDZDbjhBUVVFVFFuRzB1UktSNzdJZzlybGpUR2VnbHpEQVRuUS80Qm1W?=
 =?utf-8?B?S1hBdkVrb2VEVW5Ud2luaUkwUU5vOWdLTjZ0MW1EeUlyajVPNXF0VWxnbFcw?=
 =?utf-8?B?VFJ0ckpHNDBpK0s2VnN4SkxLa2Jzekx0cDd4dXNpYVBuekJ1WWFwNE5jWXVh?=
 =?utf-8?B?REU0bmNYVTQyWjY0YlpZVmFob3BCUVMzV2Y2dE1rVDNlSzluSWtldldkRnFx?=
 =?utf-8?B?ZkYvR21UNWd1aTNpeThKcyt2Wkl2R3N0YjkxYXd2a09tTitmNEorWVMxOUpu?=
 =?utf-8?B?QXdUTFhxTUJlVkZGcUNhS1c1V3ZuQWpLcE0vY0MwUjVJeXhOWExTQ0oyeFp4?=
 =?utf-8?B?a3JaRndOVGxzd3pzU3h6bUM2ZHQvZlBWcDVQcVNFQUl4Qk9tNktVK3J6ZzdB?=
 =?utf-8?B?Uk56WDJpWDZxL3Y2cW4zN3dLSG85b3pRaks5ZXdqM1MzZFBxSWtsNHdMVjBM?=
 =?utf-8?B?UklSaTY4cmJSZlIrSDljbGFmRXBRWXRmRXpvMHhMU0s3Wi9iWUNtZzJEVmVq?=
 =?utf-8?B?K2t6cjJhWEsxdlVsb0tmRm1RWmRxeW9FSHZrYUV2dGFQL2JFU0NidUtVY3U5?=
 =?utf-8?B?ZldhdkU5QUhpNXVLbjVtOUo3NldBeWw1OEVtdGhacGR5YkhzZlljYWZFUlgz?=
 =?utf-8?B?SGxyWisvQVJLcU1NTDlVRUk0WmRLZ3hncFJmckFTZ2NzSTcxbjBFdHI4UjU4?=
 =?utf-8?B?a1BrdjBndVkzdElET2pPWGx2WUtWY3VTWTFSQm1wemFXV1Rrd0Y3Z2lIdjBN?=
 =?utf-8?B?Z3RkZFlVWUJLbE1kUXBLY2lwbG5UR2pXN2lidEw2OEp3eDJneTFkQWc0alYx?=
 =?utf-8?B?QjR0S0pWWGljQWxCM080QldYb3p6ZHRCZWJwN0pBTXZwSnJZaG5PRFJqM0NO?=
 =?utf-8?B?NmlSL3hIY3hzWU5tdUl1K2wwTTJlaXdGSnR2T2E1eTBRRmdEdW9TRVlJc3Jn?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42DE81992429D241873E4C37AEFE1B69@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6167.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b1f080-6c58-4832-c38f-08db5a87bd20
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 05:45:24.2677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RyO0nxEsrnXE+l4TSR8YUzU6pVF2W5zmo3dWTGMSgONH38MH9d6G+XPNYaTX+XymNflpUzUSnKT/R8iDbXaIbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6995
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTA1LTEyIGF0IDE4OjUxICswMjAwLCBQYXZlbCBNYWNoZWsgd3JvdGU6DQo+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuDQo+IA0KPiANCj4gSGkhDQo+IA0KPiA+IEdlbmllWm9uZSBpcyBNZWRpYVRlayBwcm9wcmll
dGFyeSBoeXBlcnZpc29yIHNvbHV0aW9uLCBhbmQgaXQgaXMNCj4gPiBydW5uaW5nDQo+ID4gaW4g
RUwyIHN0YW5kIGFsb25lIGFzIGEgdHlwZS1JIGh5cGVydmlzb3IuIEl0IGlzIGEgcHVyZSBFTDIN
Cj4gPiBpbXBsZW1lbnRhdGlvbiB3aGljaCBpbXBsaWVzIGl0IGRvZXMgbm90IHJlbHkgYW55IHNw
ZWNpZmljIGhvc3QgVk0sDQo+ID4gYW5kDQo+ID4gdGhpcyBiZWhhdmlvciBpbXByb3ZlcyBHZW5p
ZVpvbmUncyBzZWN1cml0eSBhcyBpdCBsaW1pdHMgaXRzDQo+ID4gaW50ZXJmYWNlLg0KPiA+ICsr
KyBiL0RvY3VtZW50YXRpb24vdmlydC9nZW5pZXpvbmUvaW50cm9kdWN0aW9uLnJzdA0KPiA+IEBA
IC0wLDAgKzEsMzQgQEANCj4gPiArUGxhdGZvcm0gVmlydHVhbGl6YXRpb24NCj4gPiArPT09PT09
PT09PT09PT09PT09PT09PT0NCj4gPiArV2UgbGV2ZXJhZ2VzIGFybTY0J3MgdGltZXIgdmlydHVh
bGl6YXRpb24gYW5kIGdpYyB2aXJ0dWFsaXphdGlvbg0KPiA+IGZvciB0aW1lciBhbmQNCj4gPiAr
aW50ZXJydXB0cyBjb250cm9sbGVyLg0KPiANCj4gJ2ludGVycnVwdCcuDQo+IA0KTm90ZWQuDQoN
Cj4gPiArRGV2aWNlIFZpcnR1YWxpemF0b24NCj4gPiArPT09PT09PT09PT09PT09PT09PT0NCj4g
PiArV2UgYWRvcHRzIFZNTSdzIHZpcnRpbyBkZXZpY2VzIGVtdWxhdGlvbnMgYnkgcGFzc2luZyBp
byB0cmFwIHRvDQo+ID4gVk1NLCBhbmQgdmlydGlvDQo+IA0KPiAnYWRvcHQnLCAnZGV2aWNlIGVt
dWxhdGlvbicNCj4gDQpOb3RlZC4NCg0KPiA+ICtpcyBhIHdlbGwta25vd24gYW5kIHdpZGVseSB1
c2VkIHZpcnR1YWwgZGV2aWNlIGltcGxlbWVudGF0aW9uLg0KPiA+ICsNCj4gDQo+IFBsdXMsIEkn
ZCBleHBlY3QgZG9jdW1lbnRhdGlvbiB0byBiZSBtb3JlIGRldGFpbGVkIG9yIGhhdmUgcG9pbnRl
cg0KPiB3aGVyZQ0KPiB0byBsZWFybiBtb3JlLg0KPiANCj4gQlIsICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQYXZlbA0KPiANCj4gLS0NClN1cmUs
IHdlIHRlbmQgdG8gZW51bWVyYXRlIHRoZSBoaWdoLWxldmVsIGZlYXR1cmVzIG9mIEdlbmllWm9u
ZSBhbmQgdGhlDQpkZXNpZ24gY29uc2lkZXJhdGlvbnMgb2YgZWFjaCBtb2R1bGUgb24gdGhlIG5l
eHQgdmVyc2lvbiBvZiBvdXINCmRvY3VtZW50YXRpb24uDQo=
