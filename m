Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77387000C2
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 08:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240061AbjELGnM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 May 2023 02:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239956AbjELGnE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 02:43:04 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B633DDBC;
        Thu, 11 May 2023 23:43:00 -0700 (PDT)
X-UUID: 39e47196f09011ed9cb5633481061a41-20230512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=H6Oc17itsDVoLkAEpJ8lu7kfUY98xsJnhCGy+f35KyA=;
        b=tut2cJ3YKeo86JR1IQVUi3s96NsMh/7KrS2xC2EM3Wblsogj3x4zXJFSjITYIY15AVQnlqXeVcnPe6Hcl7TK7D07fT5TEJ9wEFmAEXqGRnXM5mM3lPG/cAdAkcfexkURqH7olnlcscOzvw3jg1ZVCcgAH9W6gelqJwDMf3nL/o8=;
X-CID-CACHE: Type:Local,Time:202305121442+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:a712cd9a-a4ab-4473-988d-1a97c8337a2b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:178d4d4,CLOUDID:b52b976b-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 39e47196f09011ed9cb5633481061a41-20230512
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1445719078; Fri, 12 May 2023 14:42:55 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 May 2023 14:42:54 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 May 2023 14:42:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxpT0uIkP23+Yf1pQFJcgE8tcMfiaDrXxWxETxmab3Lkf+HA2MX5WOzIO5kwZNZL15/ikySbA1kbkz4LW5GgmKLjBTTRcsVLS/sT7lyCJ6uB4deenn7dBXvxyQtZj00tG3e6mnXvBeZ+/WgMBcbaOsmZvR25Pw3VO6KO/8HGadKaaRQeumhJjJGMtsipGs3sVuNs6dwbAndNXK6KHz3kctqu4RwfquW/zemRXGPgulCRleIzRB5dA5OlP0jqjOjMgYVKFjnATzW7TqlYr8ywck9+Cwi1SlK2dmlArx4CGWp/Osz0quuyoOlV5oycbGrGboClETU8LdEtD+RgW/2fnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6Oc17itsDVoLkAEpJ8lu7kfUY98xsJnhCGy+f35KyA=;
 b=kjPJxJgOtG5NPr1K401xSWxWooxCaqigCTvaorQPhjs1jwz0LB8gsf8xKNVRojurQM27flhFOn+rR2poA4nPcNr5qQIKfmpedk+NqWHJc8SWheORm3TlYUFZtzr9udzQa8vTjV2zFi8luzhRw0JzQC042jAZhShYJ3pcucNePEeqUXd3lxSPcoH00vmEffTYYWC+mCM7P4axCDfSHxydfeE7XHxScnpfe90babYp5ly1hNqfZHUKrg0ykpbiNBi6VajmM8TbTUO4++caWtZsUmenHBGVqzGRUwTk7vzYONY/kBLoeUzxkjzPljlCiUvLQeC1Ose3AN+oxu1kSvzt0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6Oc17itsDVoLkAEpJ8lu7kfUY98xsJnhCGy+f35KyA=;
 b=thH+eG6p1JPvxESbvSiKaOp2csG0kHOWZ++sHmTG9621VYuKNDonN6koRC9P/6aF2fzlfyX1R3PH6J0MWXomuUzs9bXvw/4dUzFI9jopZXA1yhoB5rXZ7oo2Qn+A4A2wsCh7vPuDM2JcRWZlVavC0SIHCPghpVeLeWv/Ddx7KgU=
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com (2603:1096:4:14f::8) by
 SEZPR03MB6810.apcprd03.prod.outlook.com (2603:1096:101:65::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.21; Fri, 12 May 2023 06:42:51 +0000
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b]) by SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b%9]) with mapi id 15.20.6387.023; Fri, 12 May 2023
 06:42:51 +0000
From:   =?utf-8?B?WWktRGUgV3UgKOWQs+S4gOW+tyk=?= <Yi-De.Wu@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?utf-8?B?TVkgQ2h1YW5nICjojormmI7ouo0p?= <MY.Chuang@mediatek.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
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
Subject: Re: [PATCH v2 2/7] dt-bindings: hypervisor: Add MediaTek GenieZone
 hypervisor
Thread-Topic: [PATCH v2 2/7] dt-bindings: hypervisor: Add MediaTek GenieZone
 hypervisor
Thread-Index: AQHZeb1mU9LdvrjJWkKKQBIpP+78BK9BPBGAgBUKZAA=
Date:   Fri, 12 May 2023 06:42:51 +0000
Message-ID: <ec4cae2e6da4a64bc3983ffdde03f51e185d3609.camel@mediatek.com>
References: <20230428103622.18291-1-yi-de.wu@mediatek.com>
         <20230428103622.18291-3-yi-de.wu@mediatek.com>
         <20230428212411.GA292303-robh@kernel.org>
In-Reply-To: <20230428212411.GA292303-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6167:EE_|SEZPR03MB6810:EE_
x-ms-office365-filtering-correlation-id: 237868f2-a93d-40f7-3e49-08db52b41bc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sr2cnDQnHv0ph1ajBRv/Ryno8nzWJu5lwWwEGUO+xe6kJ5k+/+xWulSguaE7gq469/i4KWfxLa6dAKj8D0ML3R+UX3wyDKCIZ6ibFEyTa56g6zDDASpn89rMteU5knnCUhz6kljd47qXYmJIU+DTNyb1IVxP3P1jM/bMKDWsqi9GBgxgZTXXauESv7SVrSQNlN5p260Yhw9NF1+Z/6hcde+teEZxAmJq3TX+XL4PzEVYal+EZDvAB/HpnoOOAFuMxfypsI6S19rOJOfipeqPgHOqaZ/BwB6D943f0C/8cvBX96aaj+DAruB8XOXPtMx35aBBDqt/dTz5f06imhaoeSepp/ix/X/HYbSD/YzBl9RHtLDNmhPX2G7GY8nslFmkgH95Em1xUeznLVdVNRx+BotTyqVrI+rxSr/mG4iuAD4bQjwsA0UDQradIOtq0OoGZ2oeKH9S10sF556aWTo09eUR+exUi0bE9mBlM/rprRJu1N7SAiOL73MmsVq1qHG5G5R63pGNoXn8XPU9h7OZ/4NTNLKInxQWoS93ENANMkvEGy9A6RUH91n8KKZ1PWJ1LyBRguWI0LSHQqxG7GC73wQXk4nJ1oCUvEmK7SKuyEssJg+qDvCDAsxJQ+zBXGc8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6167.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(122000001)(71200400001)(41300700001)(6506007)(107886003)(26005)(6512007)(8676002)(8936002)(7416002)(5660300002)(4744005)(6486002)(83380400001)(2616005)(186003)(2906002)(38100700002)(91956017)(64756008)(76116006)(86362001)(38070700005)(4326008)(66446008)(66556008)(66476007)(316002)(478600001)(54906003)(36756003)(85182001)(6916009)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWNxWWxKTGRxSXhGazE1eEtyQi82T1p2OVVOeGs1cFZEdjZ5TjgrQmVERE9X?=
 =?utf-8?B?TDBhdjNVQVBqTG1QZ2RGV3UxdXcvQVllSVE4ZHhBUUJ5ZU8vVkthZ3YxRVR1?=
 =?utf-8?B?ZDNvTlZZYTFja2pFU1MyMllkSGs3NW1iY1pRZUc5K21IdTFtNXlXVXJ4MlEz?=
 =?utf-8?B?MzMrV05WUzdpU1ZwTEM0cXpSUm5tM1J5WWJwajNsdTdUdjA0TDRtbWhhSzFD?=
 =?utf-8?B?cUNWVEx0RmJBRVVpNktUb0ZhN0ZRZnhYd1VpT2l3Y3UvL3M3Y2IydFlsYU1Y?=
 =?utf-8?B?UjdGMTk5RWYzRW0zR2NXUmRjSVh3Y3lSOHVkWmxNeUZBekMvZzUrZXd1SVNk?=
 =?utf-8?B?dGFSQmt4aWpPOGwvdGtKWGhPMTlGY3BkSDlYVzJvNnBUSXRORjhaem56akZt?=
 =?utf-8?B?OXJaNkxMdXNhaWhVdXZvR0V5dkQ0UmlBcW5GeVJkUTVaV2gzSk1WL2hRZnM0?=
 =?utf-8?B?OW5MdHp2N01GcnJKK0sxbFlVcVFnRmFIRkgxNkNlUjFjdU41ZXk4QzluK2Rk?=
 =?utf-8?B?MkR5WnBQZlhPUjdmVHBPMlpSZk5CNkIwRm5KZ0NZRXIvZHFPZTBIenA0VExX?=
 =?utf-8?B?Q1RoS1ByWlNzb3ZoOGlvazFZZXd0UjYrQmtnNm5SYk5MUGVGckxSR3pGN08z?=
 =?utf-8?B?M0k1NS85aXZyTVVGM29CZUVReWhNVVZjdHFxaCt2MTZwcU40TGlpWEJPSXM5?=
 =?utf-8?B?TTJONis5SVEwajRpN3VZald4ajAwdTlySHdVN3NVbnZucncyT0FmT0NSQ2NV?=
 =?utf-8?B?TElvYWQwWHFEeWRNcm9GVFJRNU90M05rem56RWh4eVE0bGxHMWt2dzlGdk5s?=
 =?utf-8?B?bExnU3orWU5PSlpJbGx3bG1hTEpheTJWMjFoOXBXejJwV29NMjQrOXlzM3JM?=
 =?utf-8?B?bFR4TFRqV0wzbStkRlRKZXhXK3Zyb1pDSHE0aVkrVE5aNUx2aG9jVFpEWWw1?=
 =?utf-8?B?MnROcHZDeHJ1R21Ha3pIQjFOZVlJWkJxUXFUMGlQMWxRK0JSWEJKTVE0Y1FQ?=
 =?utf-8?B?bGMyc3N4a2lGcDB1RUN1TFhsNUxZYUdwbUQzS2RLZk5IMmx1MWZ3OExvTXps?=
 =?utf-8?B?L1hkTWdiMGFHKyttemdaK3BzOGJSaWNQMEE0S2VOQnBQaUZCancxLzdKUGZ6?=
 =?utf-8?B?dzhHbUFBK3JXZUk3ZGw1dmFaeGd0V1ExVm1wK1FRRktTOWxGR3FFa1VYeG4z?=
 =?utf-8?B?UC9Vd0UvTTNwTGxLSWExanZQRHFxZ3B5U3hldkFuckRkOGhseGI2N1htak1u?=
 =?utf-8?B?blRMZ2tNSlM0aWVFRXNlRldTaWhKQ2FkWXVBd2xVc3FYN1NzdjI2VEt2aFNw?=
 =?utf-8?B?OXdmdjV2QXlXclFSbjJDdEhjRDIycm95NFY0SzlYRU1WOGZ2NGVTMEM3NUla?=
 =?utf-8?B?dnNqTXBrT0JnclVpMUNxZUkzZXU5Z2xZZkJrT3hsTmNQS0pKMFJGOVh2d3hE?=
 =?utf-8?B?YlpodXM4bDY2T2s1MU9kYjhMUmpXaU1rR0w5bkh1MnkxaW92emZoWmRVS052?=
 =?utf-8?B?RjlUZG5jUjZoaGdoYSt4VTUwMFozc2ttN1Y5VDllc2xYc0h0b3RtcUdhMUM3?=
 =?utf-8?B?bzVFellJV3d3a2dQemJtOXFLcnNGbUtrbVBsYmNNbnZLNzhPV0M2TmpvYWxk?=
 =?utf-8?B?bzVrOFlBTmtxVlJKTlVqL1lUWXhyRW9wVExISUkwRFd5dXh1aVVOOFcvcWwr?=
 =?utf-8?B?QmJXeVBxazBmWnBneGZQajJCdVljblcvNHh0eURMUWx2R2d4L2IwL01Vb1A5?=
 =?utf-8?B?elhWWTRNeGJZNGlicURFMGtBRkxyQ0xOK2Y0Zm90S3FHQnVLZzRYRzNueVIr?=
 =?utf-8?B?TE9Id1hlcGFYVFJnWE9pRExiWVVxOXhnU3FYNUl3YmQ1L2FFUTROK3IxUWxq?=
 =?utf-8?B?eG5RSXFPTWtjYjhIVXkrbDFIdHRZT3JUV0JkTUxUZitPaTdyUnNYZ1h4bGJZ?=
 =?utf-8?B?bDJVRjhmTmJicE5TMWs2MFlWSktlU3JmaEJ1aW5SeTMzeVByajZDRkNkMjVE?=
 =?utf-8?B?UTB3WStnQ2t2TnhxaVp3U0R5dHlubjJrWEx4K2U4bDk0QnY5UzhDUWxpQzRj?=
 =?utf-8?B?M0JVem5lUzQ4VDFzQ29WYWlmb3VNVnhvd0JXYVhXU3VNd1dZVlBIbUVsOGpM?=
 =?utf-8?B?Q2ppS3o4UTZHeTBtYmJIb0x5QzhISlB1REVTQjc4Z3BVTUlkV0YxNTF5VUg0?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6646A01D8D28D7419E55C28019124387@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6167.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 237868f2-a93d-40f7-3e49-08db52b41bc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 06:42:51.6182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KrbiluAWP+WvrB15C7OXf+4Ul2MnC7Bsg6/GpPpRcb/93rgiDiGOrQIDZgKFHGcxMcLZZBAlyyRC/ewe3lCGJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6810
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTA0LTI4IGF0IDE2OjI0IC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVu
dC4NCj4gDQo+IA0KPiBPbiBGcmksIEFwciAyOCwgMjAyMyBhdCAwNjozNjoxN1BNICswODAwLCBZ
aS1EZSBXdSB3cm90ZToNCj4gPiBGcm9tOiAiWWluZ3NoaXVhbiBQYW4iIDx5aW5nc2hpdWFuLnBh
bkBtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4gQWRkIGRvY3VtZW50YXRpb24gZm9yIEdlbmllWm9u
ZShnenZtKSBub2RlLiBUaGlzIG5vZGUgaW5mb3JtcyBnenZtDQo+ID4gZHJpdmVyIHRvIHN0YXJ0
IHByb2JpbmcgaWYgZ2VuaWV6b25lIGh5cGVydmlzb3IgaXMgYXZhaWxhYmxlIGFuZA0KPiA+IGFi
bGUgdG8gZG8gdmlydHVhbCBtYWNoaW5lIG9wZXJhdGlvbnMuDQo+IA0KPiBXaHkgY2FuJ3QgdGhl
IGRyaXZlciBqdXN0IHRyeSBhbmQgZG8gdmlydHVhbCBtYWNoaW5lIG9wZXJhdGlvbnMgdG8NCj4g
c2VlDQo+IGlmIHRoZSBoeXBlcnZpc29yIGlzIHRoZXJlPyBJT1csIG1ha2UgeW91ciBzb2Z0d2Fy
ZSBpbnRlcmZhY2VzDQo+IGRpc2NvdmVyYWJsZS4gRFQgaXMgZm9yIG5vbi1kaXNjb3ZlcmFibGUg
aGFyZHdhcmUuDQo+IA0KPiBSb2INCg0KQ2FuIGRvLCBvdXIgaHlwZXJ2aXNvciBpcyBkaXNjb3Zl
cmFibGUgdGhyb3VnaCBpbnZva2luZyBwcm9iaW5nDQpoeXBlcmNhbGwsIGFuZCB3ZSB1c2UgdGhl
IGRldmljZSB0cmVlIHRvIHByZXZlbnQgdW5uZWNlc3NhcnkgbW9kdWxlDQpsb2FkaW5nIG9uIGFs
bCBzeXN0ZW1zLg0K
