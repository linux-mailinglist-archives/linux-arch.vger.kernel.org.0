Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E7A700146
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 09:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbjELHUF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 May 2023 03:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240238AbjELHTX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 03:19:23 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143FC2133;
        Fri, 12 May 2023 00:18:59 -0700 (PDT)
X-UUID: 405e323cf09511edb20a276fd37b9834-20230512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=undJtsKfaplzPWodzG2dwUG/0JBAFhmeTqGvOsPqxTo=;
        b=SF2wAGzOaMUuNAFaq587c/XQgl1vQhVfs1RFDn4Xb998z0YA4AMFj21B8cvx7XzP61MQy049C8MdRN5o+pC0fDu4X4B2DJZsTwgQPehu3IkL7t+ahN7iU+ftxT8qIdXtAxbz4WDUk1Iu25Pi2ynjAiRlZspjR2NCpg30VVbEXq8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:777512e8-36a2-4164-a004-032a425b3adb,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:1
X-CID-INFO: VERSION:1.1.24,REQID:777512e8-36a2-4164-a004-032a425b3adb,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:re
        lease,TS:1
X-CID-META: VersionHash:178d4d4,CLOUDID:0870f33a-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230512151805GVAGZYZO,BulkQuantity:4,Recheck:0,SF:19|38|17|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 405e323cf09511edb20a276fd37b9834-20230512
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 881188063; Fri, 12 May 2023 15:18:53 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 May 2023 15:18:52 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 May 2023 15:18:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsimzOP2mmNHbAmZ//0Ui2AidM5aSIhpvoZ1RwfcMUPxrnRKVpOTFVOyHuRNhZQgBsLtIEsnWbHbvnC0oflUU1GW++olQrDlujyHH5aZ0nELppNM58IYWKhGiqIuccpZxrgxv8fEoM8KNy3qHtwXEYIp+daGKb2HizRXsyA1zF0BlBcP13SR2Fbw7Z8b5g36PJMtY5xjWcKYMScjMo4NPHNo0mqfDGOqUrz2jxaIlxaZ5YMwV5ih0RiSPA+cV9HsdA/0tUSekPRipTj6EWYDngzl/5zJuFp3mlGs75PmShwixFkxBaWRhjMCRB7My/1bYhBjfZk4GOie01f14klavQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=undJtsKfaplzPWodzG2dwUG/0JBAFhmeTqGvOsPqxTo=;
 b=nRH8IEWaD331+6RdnAGthjPINb1TX4GIchRM9/djPGy/e9Da693pALb1VPnIxpveTwMaxNM2tXo+OLsH7IpqA0JKNbkFzR+KBDSTVrcMLArWc3j2Yf5GwCPtAkuwDC8klAmnAjg70+f4Y9J+BwY0fLR4PPW/Pe9YCIxENeOgy72jqQAg9yu1s4RT9ThtFjzC9wIVgOuTxDzqNWbf8psa+YrdENoZn7iifx6CYw0GU911XoqIHztp29EfRglOXUKUbr7bdfM0arW7dmkv+zM8Yidy+v6sWJ+ObRfVlNmnLk0WVkXequbNu+JT7Xaq4zTPZ2ZsDsJSpHELKaYJAnanKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=undJtsKfaplzPWodzG2dwUG/0JBAFhmeTqGvOsPqxTo=;
 b=npoEa0eU1+rpY0Zq16Me9uDtV/XIx3xs8wwsSKwJWt+aYKUarb/D6oMttb87Wk3aFhKQ+acIFgTm6m+nvAm2dDfuvgyGM615yjbFTETRdzT93BxQRO1i1I7cPe20iyUGsi9xVIgUuR+IotpsMiJ5zvRoUGmkn3x9h5wTvZLgm2c=
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com (2603:1096:4:14f::8) by
 SEZPR03MB7592.apcprd03.prod.outlook.com (2603:1096:101:12b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.23; Fri, 12 May 2023 07:18:48 +0000
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b]) by SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b%9]) with mapi id 15.20.6387.023; Fri, 12 May 2023
 07:18:48 +0000
From:   =?utf-8?B?WWktRGUgV3UgKOWQs+S4gOW+tyk=?= <Yi-De.Wu@mediatek.com>
To:     "maz@kernel.org" <maz@kernel.org>,
        "quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>
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
        =?utf-8?B?U2hhd24gSHNpYW8gKOiVreW/l+elpSk=?= 
        <shawn.hsiao@mediatek.com>,
        =?utf-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <Miles.Chen@mediatek.com>,
        =?utf-8?B?UGVpTHVuIFN1ZWkgKOmai+WfueWAqyk=?= 
        <PeiLun.Suei@mediatek.com>,
        =?utf-8?B?TGlqdS1jbHIgQ2hlbiAo6Zmz6bqX5aaCKQ==?= 
        <Liju-clr.Chen@mediatek.com>,
        =?utf-8?B?SmFkZXMgU2hpaCAo5pa95ZCR546oKQ==?= 
        <jades.shih@mediatek.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "dbrazdil@google.com" <dbrazdil@google.com>,
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
Subject: Re: [PATCH v2 3/7] virt: geniezone: Introduce GenieZone hypervisor
 support
Thread-Topic: [PATCH v2 3/7] virt: geniezone: Introduce GenieZone hypervisor
 support
Thread-Index: AQHZeb1aX90tY1i6HkGV8pI87sQlea9BSaOAgAAKAICAFPzegA==
Date:   Fri, 12 May 2023 07:18:48 +0000
Message-ID: <ce63cfc3844a3b071d99d7c847c7188041daaa50.camel@mediatek.com>
References: <20230428103622.18291-1-yi-de.wu@mediatek.com>
         <20230428103622.18291-4-yi-de.wu@mediatek.com>
         <904abf67ec4ba7d37fc1e500e8a2dbd1@kernel.org>
         <70acccee-22d7-0d35-b943-346a435b9eab@quicinc.com>
In-Reply-To: <70acccee-22d7-0d35-b943-346a435b9eab@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6167:EE_|SEZPR03MB7592:EE_
x-ms-office365-filtering-correlation-id: 06676869-4b18-4e27-d210-08db52b92137
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wkPWE1WB5FWb968TWT6YiExAPrX9QB6oYu0mkxboAA/mYlJNOtcuMaPNEYU+V3jIXIvkX0bdI3QTkFJ7m5H3Kz8+WsqVRi9OcB3wbepUdsxdnvxfJYuBykpzmsQ8WTjv1WBWlvMb3DcFBADPUdF3fXerVhP47R2qVX1tW6szlRkJC6+WxlypmtfIMMgjVs3LkgLtv4ldHxvJvODGpmTmzC41zeT6/wwXwlLiFWonHFWss/nkPRZINyDNGjimNfbRdLx+RONtqgCZH0mGxQuRgdA0BYHYmgRVDxZhJdGIYtjwDJ2xaKsS2Lgg1AYbbBfRVNzb5nproaPXsGOIbE8trjTaHL+tHvw1RMGcnpLvWuK8OUO5AuapYAlWh8WHuld4NNJrxOS3ddB3lLRsenpxJ3FYxKsxiS085e5HTrVPrZAy0ZSfaD4onkR8J79/RNJYb/L2jDw240Z1hvU7L4+zgTkcEFLw0fAMgm81mmPNk8+zR/lLEj7AaqgtqrlLrEzM61Ry6yQzIS/htrEL7jeu5C3hUWsoKBFBAACYvIEbumgbadqYpCVLCoQysmPIoteU8Oo5S3rv8aeSSG2a3TGKAClEKTPXC0KZ6YRvWuirlKrRayLtG9F4XbTlJ8kyYuOy4tcMC4OepzCmfB4cSOHueDqy4nnv1uPcSgiqQtR663E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6167.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(76116006)(66446008)(4326008)(64756008)(66476007)(66556008)(54906003)(110136005)(2906002)(66946007)(478600001)(7416002)(8676002)(8936002)(5660300002)(316002)(41300700001)(71200400001)(6486002)(186003)(107886003)(6506007)(6512007)(26005)(2616005)(85182001)(83380400001)(36756003)(38070700005)(122000001)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlNZOFpvQ0c5YXM1UDRvcFA1ZWk2SFlpMlZCdHFkdmd2eDEwWWcxRWJkVG93?=
 =?utf-8?B?TjIwU0FKbU1HQ1QwMVlVcEE2azY2OU9tK1BCM2lHL1RpeDZaYjV3MStaUUtR?=
 =?utf-8?B?Q1ZTT3VBemtVbnVMaFhHcERYV0VZd1NsNkxIZkxpUzVMK09DdVF1c2dXU3ZE?=
 =?utf-8?B?K3NPWm40dStSMXp1eXVZcjZWMEpOdkJpS1BrWWZ3WElqMzczZFFsS2ZuNkRm?=
 =?utf-8?B?R2V6RUJjYjlpbXpYZ29vdTQwKzF1RWlCYjkwN0d1cmViSXRYSWZNT1FQWVVq?=
 =?utf-8?B?Ny8zSms0UUhGNGdDM1dpa25Wd3U2VWtzUDZBeFlHQnYzcFVWZnEyWW5rZkpx?=
 =?utf-8?B?a28xOTZrNjErV2RzaTN1b0FRUGJEQ2c2bEpXYWYxSDlEemxHemtCYzVCR29k?=
 =?utf-8?B?dmxHR2xGeDVVRTVMano4VHlKdnc5M0l2UUpCR3J6MUZnTU1ob2VSSndqRWIv?=
 =?utf-8?B?NnJaWS9KWVhkeklaVytQaXJZVTBwT1QxYlBjemF0Y28rRmJER1FEY0VWV3RZ?=
 =?utf-8?B?bFJOZ3ZuNW5WeUc4QTQzdmRBcjJ2N1B1UE1yaHpqNm43VUg4RzhpY0tHN28z?=
 =?utf-8?B?OTRHQXE2VEt6ZkoyY3VocGJudm03RlFpK21GQkwxWnhld3ZsWHQvK1h4WEVh?=
 =?utf-8?B?VlM3OTF3SVZuaFl0N3JVVWt4ejQvZkg2Q2x0QWpHMWtkU3dSc0U3SDcrZ1lU?=
 =?utf-8?B?NUwwK3JmZGdScFJCMUowc2oyVWlFNUFQOFVXVGpNOGxjWExoM01XeWZObWtX?=
 =?utf-8?B?d2VMaEpzZXpiSkJvbVFWMzlSeUxlVkdXUGdmTVdWdnk0KzdIZktMUDJHRERP?=
 =?utf-8?B?dk1OR3JGcWIzR0xrUENDWFRvN1d2YkdjRGF5YXdrY3o3WjE3OUxNVmdkejU4?=
 =?utf-8?B?NlJEZjFSVFhZeThKbVFkYVlwUUVtNCs3OUtRKzF5ZUpXb1FWS0pleWJiZFp5?=
 =?utf-8?B?Qm5RTnY0clJzaTg3cWIzbi91L3NVVjJ2ZEZhejdzWjZ4MXB1ajlBVnlzUk9T?=
 =?utf-8?B?NW9oNVBITkFzMVRMUklPdGtmenFqdGpnaWYzckxQSzR2d25xWks3WS9pWERL?=
 =?utf-8?B?bTBPK1dCUnNKVDRaanNMVFlOdTFrRUQyM0Vhd1I4Q2RmcCtEbi9RZDdTY2g0?=
 =?utf-8?B?UGY4THdCa3FvSFhyVmtSRkdDNGVieDZyeEk3Q3VRUUtTcENGOGFJbGdiblpu?=
 =?utf-8?B?OGJWaWRWREt5OG80MzJSUjFGRnZzOUZzem9DdG0vcmZqMHh1MjJSMGUrT0Vz?=
 =?utf-8?B?YmE4NUVFekJZb2xwV1I5aEVTSHpyb1Y5VXU0K1pnRGsrTG9YcU9hMGJJYWx5?=
 =?utf-8?B?akwrNUpZN3VDNzc2SjhLaG5iQWZqaUR5NVVTdkkzS0wvTWlXcXJiVkR1NHd6?=
 =?utf-8?B?dWV3b3ZVZEMwVFQ5YTMzMVRxN01Lai9RbnBXVHdWelJaazlyajNSQm1kZlNy?=
 =?utf-8?B?YndpNFVTajRZeEJPemdTaTVoT3IvYUpDY1ZmQndxb085TUF6bTk1VklIOE1H?=
 =?utf-8?B?aWh1VUhNVjUxQmZtYitzU0N3UmtRdmx3TUhTM0VmVjRQT2VlUnQwbG05ME1S?=
 =?utf-8?B?NU14a1AwN0hwakM0dDRISG82OGNPR2xGTWpqVk5SRFM0Wm9XNFNZbXFSaDJL?=
 =?utf-8?B?Uk5wWlc4RlhKc1A1bUFBek54OEZhWHV1K2tXTjlrTjRGUklqd2IrYldoKzBS?=
 =?utf-8?B?bU1pbEovRnFNK241SXBMNTNqS0liYVJ3TWJqdEtVdHZRcm9XT21yVjFTb01O?=
 =?utf-8?B?Q2NiVEZCU0UwVzN6YW1uTmVvUUhZK09xem9adSs5VWZKM2FkY0JUb2VndlM2?=
 =?utf-8?B?ZGgzbVFPVzFGWURzUVVQZkJWTk9vYXZNbjI0QkxtRWpreDIxL3VNOXRJeG1P?=
 =?utf-8?B?N0Y1WTg3TE1LNk1FTVZWd0RvKzlwWkVrcUtzSkkzeDNKdDFGVVN3MC80Y0Y5?=
 =?utf-8?B?OW5YU2tMUjkrcW42UFgvUFNhWCtTZ1pPZ041anZhZUQwL3o1NnV0T0owTmtQ?=
 =?utf-8?B?MW9kSUg4OXJEK1ZjT1V5SlFZMVkxU05GMk5MR0tac0J4MnlQUXYxb0dMY0pn?=
 =?utf-8?B?R3QvR1lwaFNrOE1IckRUV0RXbXpRQWZxaFFHMTJ2alROMEg3TkpTRFp4UmVU?=
 =?utf-8?B?WXJ2WWNCTzYvMjUwQjF0VWtjR3NXMTdraE83QXROdHoxZ00yNyt1cWVSbDBs?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <576AB780F69ADC4588E87291108D871E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6167.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06676869-4b18-4e27-d210-08db52b92137
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 07:18:48.2548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V9sZKv9QKSlJvx+l4vChmDrduey5Z1Lv7APP+ocDh87RQ2e1SsT5jN0CKdYmLBXtyFN7pAyOjBd1Ox9Bq7zEEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7592
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTA0LTI4IGF0IDE1OjQ4IC0wNzAwLCBUcmlsb2sgU29uaSB3cm90ZToNCj4g
RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVu
dC4NCj4gDQo+IA0KPiBIaSBNYXJjLA0KPiANCj4gPiANCj4gPiBbLi4uXQ0KPiA+IA0KPiA+ID4g
Ky8qKg0KPiA+ID4gKyAqIGd6dm1fZ2ZuX3RvX3Bmbl9tZW1zbG90KCkgLSBUcmFuc2xhdGUgZ2Zu
IChndWVzdCBpcGEpIHRvIHBmbg0KPiA+ID4gKGhvc3QNCj4gPiA+IHBhKSwNCj4gPiA+ICsgKiAg
ICAgICAgICAgICAgICAgICByZXN1bHQgaXMgaW4gQHBmbg0KPiA+ID4gKyAqDQo+ID4gPiArICog
TGV2ZXJhZ2UgS1ZNJ3MgZ2ZuX3RvX3Bmbl9tZW1zbG90KCkuIEJlY2F1c2UNCj4gPiA+IGdmbl90
b19wZm5fbWVtc2xvdCgpDQo+ID4gPiBuZWVkcw0KPiA+ID4gKyAqIGt2bV9tZW1vcnlfc2xvdCBh
cyBwYXJhbWV0ZXIsIHRoaXMgZnVuY3Rpb24gcG9wdWxhdGVzDQo+ID4gPiBuZWNlc3NhcnkNCj4g
PiA+IGZpbGVkcw0KPiA+ID4gKyAqIGZvciBjYWxsaW5nIGdmbl90b19wZm5fbWVtc2xvdCgpLg0K
PiA+ID4gKyAqDQo+ID4gPiArICogUmV0dXJuOg0KPiA+ID4gKyAqICogMCAgICAgICAgICAgIC0g
U3VjY2VlZA0KPiA+ID4gKyAqICogLUVGQVVMVCAgICAgICAgLSBGYWlsZWQgdG8gY29udmVydA0K
PiA+ID4gKyAqLw0KPiA+ID4gK3N0YXRpYyBpbnQgZ3p2bV9nZm5fdG9fcGZuX21lbXNsb3Qoc3Ry
dWN0IGd6dm1fbWVtc2xvdCAqbWVtc2xvdCwNCj4gPiA+IHU2NA0KPiA+ID4gZ2ZuLCB1NjQgKnBm
bikNCj4gPiA+ICt7DQo+ID4gPiArICAgIGhmbl90IF9fcGZuOw0KPiA+ID4gKyAgICBzdHJ1Y3Qg
a3ZtX21lbW9yeV9zbG90IGt2bV9zbG90ID0gezB9Ow0KPiA+ID4gKw0KPiA+ID4gKyAgICBrdm1f
c2xvdC5iYXNlX2dmbiA9IG1lbXNsb3QtPmJhc2VfZ2ZuOw0KPiA+ID4gKyAgICBrdm1fc2xvdC5u
cGFnZXMgPSBtZW1zbG90LT5ucGFnZXM7DQo+ID4gPiArICAgIGt2bV9zbG90LmRpcnR5X2JpdG1h
cCA9IE5VTEw7DQo+ID4gPiArICAgIGt2bV9zbG90LnVzZXJzcGFjZV9hZGRyID0gbWVtc2xvdC0+
dXNlcnNwYWNlX2FkZHI7DQo+ID4gPiArICAgIGt2bV9zbG90LmZsYWdzID0gbWVtc2xvdC0+Zmxh
Z3M7DQo+ID4gPiArICAgIGt2bV9zbG90LmlkID0gbWVtc2xvdC0+c2xvdF9pZDsNCj4gPiA+ICsg
ICAga3ZtX3Nsb3QuYXNfaWQgPSAwOw0KPiA+ID4gKw0KPiA+ID4gKyAgICBfX3BmbiA9IGdmbl90
b19wZm5fbWVtc2xvdCgma3ZtX3Nsb3QsIGdmbik7DQo+ID4gDQo+ID4gQWdhaW4sIEkgYWJzb2x1
dGVseSBvcHBvc2UgdGhpcyBob3Jyb3IuIFRoaXMgaXMgaW50ZXJuYWwgdG8gS1ZNLA0KPiA+IGFu
ZCB3ZSB3YW50IHRvIGJlIGFibGUgdG8gY2hhbmdlIHRoaXMgd2l0aG91dCBoYXZpbmcgdG8gbWVz
cw0KPiA+IHdpdGggeW91ciBvd24gY29kZSB0aGF0IHdlIGNhbm5vdCB0ZXN0IGFueXdheS4NCj4g
PiANCj4gPiBXaGF0IGlmIHdlIHN0YXJ0IHVzaW5nIHRoZSBleHRyYSBmaWVsZHMgdGhhdCB5b3Ug
ZG9uJ3QgcG9wdWxhdGUNCj4gPiBhcyB0aGV5IG1lYW4gbm90aGluZyB0byB5b3U/IE9yIGFkZCBh
IGJhY2twb2ludGVyIHRvIHRoZSBrdm0NCj4gPiBzdHJ1Y3R1cmUgdG8gZG8gZmFuY3kgYWNjb3Vu
dGluZz8NCj4gPiANCj4gPiBZb3UgaGF2ZSB5b3VyIG93biBoeXBlcnZpc29yLCB0aGF0J3Mgd2Vs
bCBhbmQgZ29vZC4gU2luY2UgeW91cg0KPiA+IG1haW4gYXJndW1lbnQgaXMgdGhhdCBpdCBpcyBz
dXBwb3NlZCB0byBiZSBzdGFuZGFsb25lLCBtYWtlIGl0DQo+ID4gKnJlYWxseSogc3RhbmRhbG9u
ZSBhbmQgZG9uJ3QgdXNlIEtWTSBhcyBhIHByb3AuDQo+IA0KPiANCj4gQWdyZWVkLCBzYW1lIGNv
bW1lbnRzIHdlcmUgbWFkZSBlYXJsaWVyIHRvby4gSSB3b3VsZCBwcmVmZXIgdGhhdA0KPiBHZW5p
ZVpvbmUgaGF2ZSBpdHMgb3duIGlkZW50aWZ5IHJhdGhlciB0aGFuIHNoYXJpbmcgdGhlDQo+IEFQ
SXMvZGF0YS1zdHJ1Y3R1cmVzIGhlcmUuDQo+IA0KPiAtLS1Ucmlsb2sgU29uaQ0KDQpTYW1lIHdp
dGggcHJldmlvdXMgZGlzY3Vzc2lvbiwgd2UnZCBsaWtlIHRvIGNvcHkgb3IgcmVuYW1lIHRoZSBy
ZWxhdGVkIA0KcGFydCBmcm9tIEtWTSBhbmQga2VlcCB0aGUgbWFpbnRhaW5hbmNlIGF0IG91ciBv
d24gaWYgaXQncyBvay4NCg==
