Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9B170B3BE
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 05:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjEVDX6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 May 2023 23:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjEVDXT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 May 2023 23:23:19 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C30210B;
        Sun, 21 May 2023 20:20:39 -0700 (PDT)
X-UUID: 6ddb45eef84f11ed9cb5633481061a41-20230522
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=pk2DWHSvCySUTo91H9cHgxtqlim9UCr+Vh1qUHRFGa4=;
        b=Df/hetB4z4eHwo/PdLloTspDSZE8Lb9vr1Y/V/dGuzF/Jn70DY+oqgIpqW7AgxvM9nkZvBSs7JbRZJQAHoR3gTmw3EK0bHh1Md0OuQ2HSR/c2zbrTfmpQ1uHUkUm/Zu8pCRZrRvigERRWlxZkx2vRElsfQIMFUENp6CeuuD3QTw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:3818ec28-6a75-4f90-a9f5-40e0150d0dda,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.25,REQID:3818ec28-6a75-4f90-a9f5-40e0150d0dda,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:d5b0ae3,CLOUDID:4f07e83b-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230522111917MCPTWW6A,BulkQuantity:0,Recheck:0,SF:19|38|17|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 6ddb45eef84f11ed9cb5633481061a41-20230522
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1103648303; Mon, 22 May 2023 11:19:14 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 22 May 2023 11:19:13 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 22 May 2023 11:19:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlqWkdXp/WM4nMt7lWownF/BNtEiMOrXYbRY7jMMalSLOPhRMsyTTixWzmOCa7G/lq6/+9FrYH7wLt0c5gs/XnHv3wMtLjt7r4RSeL8H5IzjByPPjsTrD5dWL4pR/2EjLTlUDMSQeEVHfBPy03VL61QeLr+Hc/T/6N8RRLbww46XVQQo1/8qUleONic9xr3TSFVdRsFw6g+bIUz6ojtnS/SMFFlFiz//fgkV+BBt5Fl2pAHE4bo1TSeN4zJN61DjRwFgPREFuma3ex0UgWeQVoUskho+SogTh19v1SShy7h/1zPtriJseiGGSQJDmf6IKUbbHCClm0pFW6TLzSpa5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pk2DWHSvCySUTo91H9cHgxtqlim9UCr+Vh1qUHRFGa4=;
 b=jsjzGBPXe4hkD425lh6xA3MVJuW9Lh3JhzjXoMsrYEIQvDs7qEDSRdGQ7nwd6CbNVWoiYFOl3OFcex+drPGg7pXXLi14rLp+97b//cdV/YD3l581Ac5y4rOev5v8Kw/NJ600EwO4Anb5pCiSpOc7gaP9w1z2pqeplzoD52etqwqXX3/ribWEXizHvrK0ocHuNqH7dMu1Qh0bzDMZzPwhSj0IP3Zhd519YA45PRW+Es7e4ibxjYGPJiU4iuxK9+BZYg3rA3MYudP4Sr7nPEIFBwc2+xZ4im0mAlVPQO5ovlBM4xhoSZXb1WAaSR9hmXdZB3O/N7l8hsyhveG2FZT7lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pk2DWHSvCySUTo91H9cHgxtqlim9UCr+Vh1qUHRFGa4=;
 b=l0GadT5zMobcuIjYLJFTmLJ/mQFxxMjiWTvV9cSukvuENDWZOEgAVkKXq64nwSZLnojCw1gc0vsRjsHp8VxKQ1ACvCKYyuyhW8yVObpU24z11YLygkyuG50UktwmdNPX1lKhqbZFue41II7JkE7s7qqmLBQPzAu+1UgqINE5Hg0=
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com (2603:1096:4:14f::8) by
 SEYPR03MB6460.apcprd03.prod.outlook.com (2603:1096:101:51::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.34; Mon, 22 May 2023 03:18:07 +0000
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b]) by SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b%9]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 03:18:07 +0000
From:   =?utf-8?B?WWktRGUgV3UgKOWQs+S4gOW+tyk=?= <Yi-De.Wu@mediatek.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        =?utf-8?B?WWluZ3NoaXVhbiBQYW4gKOa9mOepjui7kik=?= 
        <Yingshiuan.Pan@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        =?utf-8?B?WmUteXUgV2FuZyAo546L5r6k5a6HKQ==?= 
        <Ze-yu.Wang@mediatek.com>, "will@kernel.org" <will@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>,
        =?utf-8?B?TVkgQ2h1YW5nICjojormmI7ouo0p?= <MY.Chuang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?UGVpTHVuIFN1ZWkgKOmai+WfueWAqyk=?= 
        <PeiLun.Suei@mediatek.com>,
        =?utf-8?B?TGlqdS1jbHIgQ2hlbiAo6Zmz6bqX5aaCKQ==?= 
        <Liju-clr.Chen@mediatek.com>,
        "yi-de.wu@mediatek.corp-partner.google.com" 
        <yi-de.wu@mediatek.corp-partner.google.com>,
        =?utf-8?B?SmFkZXMgU2hpaCAo5pa95ZCR546oKQ==?= 
        <jades.shih@mediatek.com>,
        "dbrazdil@google.com" <dbrazdil@google.com>,
        "yipei.chang@gmail.com" <yipei.chang@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?U2hhd24gSHNpYW8gKOiVreW/l+elpSk=?= 
        <shawn.hsiao@mediatek.com>,
        =?utf-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <Miles.Chen@mediatek.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        =?utf-8?B?SXZhbiBUc2VuZyAo5pu+5b+X6LuSKQ==?= 
        <ivan.tseng@mediatek.com>
Subject: Re: [PATCH v2 0/7] GenieZone hypervisor drivers
Thread-Topic: [PATCH v2 0/7] GenieZone hypervisor drivers
Thread-Index: AQHZeb1bFKX9i17opkyHBcS8vDfEJq9ApdAAgCUewgA=
Date:   Mon, 22 May 2023 03:18:07 +0000
Message-ID: <17763d2f4aed97b4c8167451487d6b41e208d7fb.camel@mediatek.com>
References: <20230428103622.18291-1-yi-de.wu@mediatek.com>
         <9b39118b-afc8-034a-67ad-c748cb76fb71@linaro.org>
In-Reply-To: <9b39118b-afc8-034a-67ad-c748cb76fb71@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6167:EE_|SEYPR03MB6460:EE_
x-ms-office365-filtering-correlation-id: 3dc8fdae-769f-4692-5fc3-08db5a7329e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IfqvYOoacfKbgC3AP4zoxuU8mWx2FLjmR+gBnNCLtn61IwnPtwqFgCVn8PXnM5sgg66dDVAECJBczNh8IclOKLreHTN44/5vsrnoBib6THvVVRyN6YwhrsQjpO6y7cY3NLZ43BQ56YPzIVOeCnxKJQxOP80ro2TaQE+vTk9/8A84QwgKmWElYUkayF+8u48Iuws+2SPXId0is22RL0uFQ2CpnilCfwk5NmFVHA+9dvmvJdHfhv/1w59kMeRxjkQoU3vjzpVKGbsJY2XpoIqllipcBcZog76FIDFBzjc2mTPv0D9Wmql0l0o1Qc6sDP+iRgZPF1EkSCYRCZ2ulD4Ue5BRKDhr/YU81ResFaK6bxwN2gEfxmlMQJKpw0pYNgbWTdpq+IPqmScRx2A6gurhH7ekHl0Yl08BdjI4sJum9l5kFUqgBea1i4mFgQiMzITA01Jl4LH9/2pG8EwXn7G9j6hvT3h/PRV2415g1flOswH3yGx3LogI6c8uZwsHfMFTsbUY8dJ53KRls3nhdvABefs+PPP8Xlj2Lw/9HTOcHeqzG7SvfbO7BYpZieF5TX8Y4Ynw5VW6S8fa6k2RYJXqoahnak5ojfdJIX5KB33bGw6CETjAgmn8PNpbuiGID8cFQCydlBep/d7j3INSzKSePsEoZq8xEl0D1K651mQSukcluxhVKebbPW91jgPOiWDD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6167.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199021)(38100700002)(921005)(38070700005)(36756003)(85182001)(122000001)(86362001)(8676002)(8936002)(7416002)(26005)(107886003)(6506007)(478600001)(6512007)(5660300002)(54906003)(66556008)(83380400001)(2616005)(4744005)(41300700001)(2906002)(66446008)(6486002)(66476007)(71200400001)(91956017)(76116006)(110136005)(186003)(53546011)(4326008)(64756008)(316002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFhXdzdvYmIvVlJqU3FZODhTM2VYdThraitsc0lsaGNtR3BSL21SNmxncG9s?=
 =?utf-8?B?V0JqS1RRYjIvY0IrTlZIZGlpRjBTZTNMZFhFaFhDMEZZNkJSZ1pVYTB1WUFr?=
 =?utf-8?B?STJ3aE84YUo1em1CclljUWdSamFrdmdPbGhKZU1GNVlvdm9oYWwzY3RzQlp6?=
 =?utf-8?B?SHA1bjNaV3hKVkhsdVBXNFJOYXYyaTd5VTN3MDg3Z1RYYWN2cHlQRmZHKzFs?=
 =?utf-8?B?MzNPQW5ieGFzcHdoNTAvQU1VR1RxUFNKQzRNUVA2YmhaRFdBS2JFcmxlSzZE?=
 =?utf-8?B?TU1GaWIzc1JlQ2ovMzd5Y1JWS1NDS0xDUEFFbk1Hd0psRWVHb3psSlF4bE8r?=
 =?utf-8?B?N3NJREkyVXZCeG12TUsxMzcwTG5mbm9CL2I0YjJkRGxNRVpLaWJwSkd4SFg0?=
 =?utf-8?B?WnZmTUFWWFNDQWVLMzN6RjlHUVI5K1ZlNjU3L1FMTkVqbVloUHV6S21NVytF?=
 =?utf-8?B?OVo4Q2w3ZXdaWVdPWDIwQ29jd2w0VW5TOWpOWnB2d1kydlkzK1BIdUhLbHBu?=
 =?utf-8?B?YzQ0Vk9DWGlOcUpxQW9BVmlmQlIxVjZFRDAxN09HSmJyckdJVFhEd0JDKy8v?=
 =?utf-8?B?UEhFaXFCUnhYemEwYWhBSTF2VVpZRnZab3hRY281NDRCdnJTK1dScjlvVGd2?=
 =?utf-8?B?dGwrMko0UzJFZ3VVZDRBRkJhUEwrVW8rRnczQ3NJeWpMSndlamJ3TG9qZHBF?=
 =?utf-8?B?WFh1WlVvM20xM1JncU5HQTIyWWZiNW9NS0VHaXhEQWIxUlFWbTgwbVB2R3oy?=
 =?utf-8?B?VGpuMzN0RUhpZlhnTm4wMURscS96RHFXTWZRYmIrUTROU245OXpkMi9ObHZN?=
 =?utf-8?B?amkrTDd3M3QzVnFVSm5SOHplNU1MMDJlcXpuVkJzRVFEa2xkU3J4OUw1NWxs?=
 =?utf-8?B?MW9waEJLSW1WT3hQaHVhV3E1bzBXMVo0ajlIZ3E2VWlULzY1cGlGNGxrODZU?=
 =?utf-8?B?RHkvYzJ5dlNYMDdsOFg4RkxHMlJpMUVqWHU0c2JrakR0YXFiK2xqb2ppR3Fn?=
 =?utf-8?B?MjFhemdOZWNwbTVBeXFJek5CcmlXQlhtaE9qTVJJRWx5bGFUQlBnVWxHYk9W?=
 =?utf-8?B?aWx5TkJCMFp3S3ZGb3Y2c3lYVkRCajczTHhFNFNXcmt1N0VkSVp1WC9PVFJi?=
 =?utf-8?B?WVQwT3NzUVRzazlJd0FRUHNJcjg0NWQ5NStVRVdZb25FVTdrWFlwcWxCeEFT?=
 =?utf-8?B?dEtWY2hGWFVYckw3NGkzd0FFcWU1alF1bUNnSUZ3c1NCeXdjaytiVHY1NDBU?=
 =?utf-8?B?MWtuTTJBeFdwNmxscDM1ZjVPdTZYNHdqejZIUEpQazBUeVBYaFNEV3lNU01T?=
 =?utf-8?B?NUpYSVAvWncySmF3Q0htVWU1NmE1aVpLQnBHa2NjMzFWVW0zOFcxVWc4Nitu?=
 =?utf-8?B?QmhMenFMc3FadVFHT3pSaWZnNDMxck9VU0hVYnlQcTFhbUdoSEFpbGh4bFRk?=
 =?utf-8?B?YXdxeEkweVEyWU93dUxiU1p6bTB5Qy9OZ3VJVkhLbVdscHJRR01zT3M0Q0k4?=
 =?utf-8?B?dTV3aXRLTHB0T3pYV1NuKzVvY1RCMWRjYllYMzR6dVZDYWJoa1VvSGJjYWxZ?=
 =?utf-8?B?NFR3VFZaWTgxbmlPa0w0SmZKVjByWXVNU1MyUGE0NDJ5TlpyL2dBNmQ4cFUv?=
 =?utf-8?B?cTZIdXdHdjEvMU5PK1NLdW9pZWpRN3NHVTRpbEdzVjVKczlUZFAxbGZsUVN0?=
 =?utf-8?B?MkVSN29Bd3JBc2hTSzZmSTFiYlRFWkQ4QlBJNnNPeEZsMnR5M2ZvdS8rSlV0?=
 =?utf-8?B?dWVHQ2p4c2crbXQ3K3YvdFFkSXpWc3F0a1VPTkdqNG1pZTRLUVlwdFRVSVls?=
 =?utf-8?B?cERuajVyVFpaTUNZVmM5dnE3V21jY3ZFeTUzN0Fma05ZS0pTUGZ6bFZCUC9y?=
 =?utf-8?B?Q3dBNFdKaTZubUxrY2s1NU5OWEpSdUM0Qm5XSUJQZWExbDBZR1ZYai91dnVm?=
 =?utf-8?B?c01aRzlwbVRwakxVeXBpSG1neE9uWXR1Q1k2alRTaHIrOXBJL2EyNUZoM1Zq?=
 =?utf-8?B?V2JwRHdLYm1xN2llWjZBQXNuWjhmejFZak0yYWg2dUhQaVdsM2RnRmhBSlgx?=
 =?utf-8?B?Z3hyaDBOSVRTN0p1amV6TGt0WGM4VEhSNDR3dEdhek5RNUJLYUpHRXVkRVR3?=
 =?utf-8?B?U09GeE9mR1hLdlI0VHc2WktBeGV1L1pJaGZFM3JENVBlOVc3TDFJYVQxMkdu?=
 =?utf-8?B?eUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7997943555E9DB4BBCD8723E68E823E6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6167.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc8fdae-769f-4692-5fc3-08db5a7329e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 03:18:07.2908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jjp1R03lPNKUcuTXibRvHZ8rIw7/wUGWBT3CLN3krRdqdy/Hi3sM7QHdPZrzYBop4LddJutDkn70SU8Sxo4JWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6460
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTA0LTI4IGF0IDE0OjI2ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDI4LzA0LzIwMjMgMTI6MzYsIFlpLURlIFd1IHdyb3Rl
Og0KPiA+IFRoaXMgc2VyaWVzIGlzIGJhc2VkIG9uIGxpbnV4LW5leHQsIHRhZzogbmV4dC0yMDIz
MDQyNy4NCj4gPiANCj4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+IC0gUmVmYWN0b3I6IG1vdmUgdG8g
ZHJpdmVycy92aXJ0L2dlbmllem9uZQ0KPiA+IC0gUmVmYWN0b3I6IGRlY291cGxlIGFyY2gtZGVw
ZW5kZW50IGFuZCBhcmNoLWluZGVwZW5kZW50DQo+ID4gLSBDaGVjayBwZW5kaW5nIHNpZ25hbCBi
ZWZvcmUgZW50ZXJpbmcgZ3Vlc3QgY29udGV4dA0KPiA+IC0gRml4IHJldmlld2VyJ3MgY29tbWVu
dHMNCj4gDQo+IFlvdSBuZWVkIHRvIGJlIHNwZWNpZmljIGFib3V0IHdoYXQgeW91IGNoYW5nZWQu
DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiANCg0KTm90ZWQsIHdlIHdvdWxk
IHNwZWNpZnkgbW9yZSBjbGVhcmx5IG9uIHRoZSBjb2RlIGNoYW5nZSBpbiB0aGUNCmNoYW5nZWxv
Zy4NCg==
