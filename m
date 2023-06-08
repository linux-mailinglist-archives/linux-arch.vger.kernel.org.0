Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5035727717
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jun 2023 08:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbjFHGLy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Jun 2023 02:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbjFHGLw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jun 2023 02:11:52 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B997726AA;
        Wed,  7 Jun 2023 23:11:46 -0700 (PDT)
X-UUID: 566aa9d205c311ee9cb5633481061a41-20230608
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=1OFytwcSfT7HEMWZ//hdXR+9Ei5VduxsNxF9LbaYBOo=;
        b=EVsH/fUshQCEfh1g2bFJ/pAT76PKkqC0OtdfGCgL0g1JGJD/n6vrJa40np64OEj747jPDqXIsU678tvxoUQ8vb21Sc7bYhylckvEGmhG+p878hduA9rBFgjJ6E2vD81YJfjhN+vFm2DXNH+j+MVsF1khtUkSR4faHvPEnyNWi2o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:e2288b81-6030-4251-8b11-039f52ac1564,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:14d6f43d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 566aa9d205c311ee9cb5633481061a41-20230608
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 231024555; Thu, 08 Jun 2023 14:11:42 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 8 Jun 2023 14:11:40 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 8 Jun 2023 14:11:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5kLEG02chaQxN0JNSV7li5uKIQRePujlaysC1qiHB6W3Gwavvy9h8z6VXMypA/sSV0YZzksiQ8itQ7/fgkKTumWcU4C8j9v5so89aIjDBtdZXi/BDRdnRnyG8b6y0ckXFv6Dz/UFmQpaatv5e/MvNL6growf9VhETPGSWA5b+BsnCaGrFaZfgT707u8ntnU24OTC6YbyeWXg4SwKrCrQoTw8qGGeXQGyJ7McltlT2UIWw6CYnLWWLFMlAv55AYlr8eFZB9iF3dpN1W2qpSpns6AeWLd2cBMCnjihYEwHUjreUgCfpO68r/9UJwse4uqlkRpLcxioSUStUA3336cQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OFytwcSfT7HEMWZ//hdXR+9Ei5VduxsNxF9LbaYBOo=;
 b=XlYDA53jO8hkwCS4pYtmrW9dQkVLdQxUixaqnLzP1/768XCku41+NCZJF3pSYHK3TXn3fc9hKumwF4FnEAZllO1qfrPX9X6Ra7OSXoZG+QLCe4k7TOOhQbPKO88D4d7pCH6VOqX+/frrrufjpHmtM/btkQ5DpnpKpw8EokCXI5YQKd2jC7ZKRDxs5rkcTNWx5lIrbPegYSKKGqpwfHRsX8DVy4EPoPXX4BTTqT8GqvorVmrJzoyuhbHpJ6wVMk8KNDptz47IpHiXFm78yhmoied52amvC4mvPXe3KG4ng8AuHiN7YX8U7Drtr62Qo6IAw/vOZ3A7te+7tOa1XsLkCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OFytwcSfT7HEMWZ//hdXR+9Ei5VduxsNxF9LbaYBOo=;
 b=bLQG7NQT60o0bDD9/20ovz/muxnFWEc37vv6O8nUzsi/kPoTSCjAx2W9n/O96RYP6MSUTpOpVqb1suzqTmwKsjDrglkTY2OL+RkeJgPqKLfpFXwFNHqJOWYdMoin1eKdoxrpTJ3fZKenm8dV2UKa7cNOAAQUtSVFE/KgVraViuY=
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com (2603:1096:4:14f::8) by
 SI2PR03MB6461.apcprd03.prod.outlook.com (2603:1096:4:1a1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Thu, 8 Jun 2023 06:11:38 +0000
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::18a:8f94:379c:982d]) by SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::18a:8f94:379c:982d%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 06:11:38 +0000
From:   =?utf-8?B?WWktRGUgV3UgKOWQs+S4gOW+tyk=?= <Yi-De.Wu@mediatek.com>
To:     "conor.dooley@microchip.com" <conor.dooley@microchip.com>
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
        =?utf-8?B?SmFkZXMgU2hpaCAo5pa95ZCR546oKQ==?= 
        <jades.shih@mediatek.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "yipei.chang@gmail.com" <yipei.chang@gmail.com>,
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
Subject: Re: [PATCH v3 2/7] dt-bindings: hypervisor: Add MediaTek GenieZone
 hypervisor
Thread-Topic: [PATCH v3 2/7] dt-bindings: hypervisor: Add MediaTek GenieZone
 hypervisor
Thread-Index: AQHZhKhmUF0/38V75UeFrDKRhI8uD69Wex2AgCobuwA=
Date:   Thu, 8 Jun 2023 06:11:38 +0000
Message-ID: <076db7465b2efb29589a00f6346854260664b1f7.camel@mediatek.com>
References: <20230512080405.12043-1-yi-de.wu@mediatek.com>
         <20230512080405.12043-3-yi-de.wu@mediatek.com>
         <20230512-kudos-stunt-489ee651bdd8@wendy>
In-Reply-To: <20230512-kudos-stunt-489ee651bdd8@wendy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6167:EE_|SI2PR03MB6461:EE_
x-ms-office365-filtering-correlation-id: 1322757b-c0d4-4fb9-fdc9-08db67e7386f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +D7c2042meO6Fsj3QIg0MNkggpvSxCzRZInnlGtR18DJL1I4IxuBl6nXpQpK0nrIsOkcMtHg5R5z7S2k4f/8Q5DzwmUCrv9YFDh1zTdlpxPDIm1UEekEWqdNKAe16jNm+/RW/ckuqw+EsuhdX5QQpaokfOqZWX/jknLH1EEfDr5fQ1DEhLKNU6+CaVCtinWPFuvKrawjcQniOkK5EmoxyQPV1bJJLGqinWG3TvAamJrYLjC/wDIamqk+Vgg6/8JkxtK4h3If2YFNImx3r7HUD1m4NlSPxABFL3Kfq6OdiAib8qsWK7+8BBTfpbINJAb6uVSPN0m4o+oifExTKjAgWFMaoeRWD/cVkh4Yx5JgI+OabosBuCvHbqdQjXJzZGBort+eXbfq3HSvyu+0trlkEpS5KI8fFsx07DqoSOf4JC77L7u8pYQkybSyZ0LgSco0gnGLp+1a2Mrlx3cqDobmtqfhch9wWLE6afFNLL/6/3l0J92yaHkt/jRwbAO2alD/sEjAcvq+TOfhYFRFDmooWh0K3c+AlyWtYQU/E1+rkYxFapU1Cm64Mwkl0Hub1xqCtvI0H/S54L2JKR8asfhBMy25vDubwKOk3ttzUS3uuaSHMyfpee1ErAg/qB+ehvd5+srojDRpUXdm0iQGH+lcPMLjjm4lftylu+vHcpDkxss=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6167.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(451199021)(66476007)(76116006)(478600001)(66446008)(66946007)(4326008)(6916009)(316002)(2906002)(64756008)(8936002)(41300700001)(8676002)(54906003)(66556008)(91956017)(5660300002)(7416002)(6486002)(71200400001)(6512007)(6506007)(26005)(107886003)(38100700002)(2616005)(83380400001)(186003)(36756003)(85182001)(86362001)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2hTTW9xeVZqYVBvdGE4a2pmYW5BTmEzZU9TUDRmOFVjeXNoQXJvMzloUnhU?=
 =?utf-8?B?K042eDI0MzlRbkRqb0lpbFF6NkY5ZEVzR25zblNvMzhmd0pKRmF6M09VVWhs?=
 =?utf-8?B?MGxqN1ZkdlB3dzd0QzdlVU11VmJZZkNaM0dSTGRpZTFuQmMrYW1GMTU1M05x?=
 =?utf-8?B?TWkwRWlpazNpQ05VR0RKait3Y0V0NnVjaWNBckdtcWMyR05aZnBtY05lSE03?=
 =?utf-8?B?MWNxNENEVXBVZDJ1eFMvUHN4TDNhYWhhUzdNNlBzSHdjTTczS05hM0JtMmtT?=
 =?utf-8?B?WGptOXlSKzlwVmZFdldwS0hSNUgvRFhDSjBLMFVqTW5sSkVTTWFSNHYxODM4?=
 =?utf-8?B?QlVpN0JlL1BDaG5zKzFyc3ZhT2c1U1kvMlp4d2NQenRFR2JDYVVPSnRROHpy?=
 =?utf-8?B?SHd3bmppM2RudVgrOEMxeVpiYVJzY0dHSllsL0Q5L01pa1dHNXlMSVBtVFM4?=
 =?utf-8?B?NnFKemJWZkY0WUoxQ3psMlBvcFF5NXZXQjNlczc3RG9RNURhSlJuTk5Dc2cz?=
 =?utf-8?B?MXkyRUs0VzArVXVFbzNQU3RodGtWdnhNbDJKa0JNVnJtL3RKa0xFL0Jpa3h2?=
 =?utf-8?B?QlkraGxTUVphcEh2eXVjUENpOW1sNCs4YUZ2QmJqclJQM1dlQjhFc2lMVnBo?=
 =?utf-8?B?b0xQdnllVUdHa0t6Wk1EZ2xHSlZESXF5VmY0dGhwdUpxeXVkUWNxL2lDKzFm?=
 =?utf-8?B?NVJDODhYTGQxSGdhWFh3WDlNTHpUK1pGMWlCQWpRc0E0NGdrc3draHl1REFl?=
 =?utf-8?B?WFI5OUZuRnY5UmFublN1em5xakliSUtCRGNHZzlQTmFUZnZiZTdiZXM3MHZh?=
 =?utf-8?B?NVpnNjRhS2txdUpydGdkQnczK2d0Z1J4V3RiSEZGQUlnTFAwK1ViZy9DcGoy?=
 =?utf-8?B?bmhFZm9DK0JQMGc0dnJGUElvRnA5ZFZPRExQRXUzNGlVaHBZbGVZMFNxWnVi?=
 =?utf-8?B?U1UxMEQ4VlYvaDgzalRrZTUwelFYRWVPS0ZhRWkyZDF0V245QjEvV09KRHFU?=
 =?utf-8?B?dVRIY3c2S1hBN0syVkg2dGNTVGlRNE9aQm9UMjZra0NqWE1XSDd6YWJqUDhi?=
 =?utf-8?B?bmVWcXBNMjN3N3huVDNMakViK3JaeHg1VkpXTjZod29odms5S0JmbHlXUkFr?=
 =?utf-8?B?dzU0SVRiRUw5TVF2cWJqcFg1N0wzVjBhOTBnN1A3dm53R01uZkJ2TTU0cGpl?=
 =?utf-8?B?VFFXZjlZY282Z2dSQ0UvSWdocVFVaHRJU2FBNjhHelpOV1R6L0RCcW43Y0Za?=
 =?utf-8?B?YW5hTEJLVXBOM2FFQU5yM2VUUmlLUU90b0YvbUZFQ25IMm1aaU9KR2MyMGlv?=
 =?utf-8?B?SXNvM2JaSzVlN2M0SXVlUmRScWp5V0VZQzR1YVVmdnI1SFdSZ0ZodVlTM2ky?=
 =?utf-8?B?bXRRZXpZdSttcmN0cFRpWDA1V2NiMjlnOWMxNEN0T0dJVXFlZEVWZ1Q1RGcw?=
 =?utf-8?B?UWxZRnl3V3dkaEVvUGZxVi83a3kxTzFiS2ticDlnQzVvWXU0dDlYK0JLVGc4?=
 =?utf-8?B?cjdGbjhpdHJpVXFkQlc4YlhXOFRVYU0vSXJCK1h5SzdNRTB4WGIvNjVWbmpH?=
 =?utf-8?B?SUh0VFVIZ0FwajZ0OXkvcGEveWw4TmlLcm0yMXdLekNwR0R6cTBkcG1ORDdF?=
 =?utf-8?B?VGl3RVpYZHhwMGpPTGZWbCtLSTB0M1RuYnc5RDhJUytIeElhTmgrckZFWmly?=
 =?utf-8?B?dXBmUEpzVW1ESmNSUXhGYnZsa2s4VmlVNThDNnE5UTFyaEU5b3N6UHd4NTFi?=
 =?utf-8?B?NjRzSmJLRW1OUjd2SjVDZENWM01IM3U0azZMQlU2QWkrelFaOCt5QWtON3ZJ?=
 =?utf-8?B?SXdFMXRMbitTS2UrZGEzQ2RQWDJqa0lZR2g2eFlXVUc5ZTZnVTM1UTI0SU5D?=
 =?utf-8?B?djN6UENJVEtVTks3azM0akwwd05xN3ZkR1RvNUdFNHdmNElITmFPYUdkcHJY?=
 =?utf-8?B?VnNSSERpQzYzY2FSanQxSHRwODk5MG1TaFpCUEQ3Sk5sNUVtWXN6U2JkMXZi?=
 =?utf-8?B?cnR2NmJoaEUxalVmWXlnUWhjbmtTdXRhTXFGeTlaQTlCZ2xIbGJ3ZXNWa2s4?=
 =?utf-8?B?ZWp2V2M2QWJFakNNZlhwc0NLK3JWbWpCYlNQTGxNV05Rd0hnUnBuR3M4ZzNK?=
 =?utf-8?B?QlhiUmJPRTc5R0ZUeVhYN0ZYdjdoK2ozMmhudVRxN1g3UTl1RFlCcnlqb1gz?=
 =?utf-8?B?NlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DE40CB27277BD45B456001CF11DC835@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6167.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1322757b-c0d4-4fb9-fdc9-08db67e7386f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 06:11:38.4651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B4UWEgrglb43T2N+UH5uS+KJLA121gG1kAqYFGTx3G3F6fFU4JtIpmNtRDP8m92p85NdimSmhUIMf2zPbTEY3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6461
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTA1LTEyIGF0IDEyOjA5ICswMTAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIEZyaSwgTWF5IDEyLCAyMDIzIGF0IDA0OjA0OjAwUE0gKzA4MDAsIFlpLURlIFd1IHdyb3Rl
Og0KPiA+IEZyb206ICJZaW5nc2hpdWFuIFBhbiIgPHlpbmdzaGl1YW4ucGFuQG1lZGlhdGVrLmNv
bT4NCj4gPiANCj4gPiBBZGQgZG9jdW1lbnRhdGlvbiBmb3IgR2VuaWVab25lKGd6dm0pIG5vZGUu
IFRoaXMgbm9kZSBpbmZvcm1zIGd6dm0NCj4gPiBkcml2ZXIgdG8gc3RhcnQgcHJvYmluZyBpZiBn
ZW5pZXpvbmUgaHlwZXJ2aXNvciBpcyBhdmFpbGFibGUgYW5kDQo+ID4gYWJsZSB0byBkbyB2aXJ0
dWFsIG1hY2hpbmUgb3BlcmF0aW9ucy4NCj4gDQo+IFByb3BhZ2F0ZWQgZnJvbSB2MjoNCj4gPiA+
IFdoeSBjYW4ndCB0aGUgZHJpdmVyIGp1c3QgdHJ5IGFuZCBkbyB2aXJ0dWFsIG1hY2hpbmUgb3Bl
cmF0aW9ucw0KPiA+ID4gdG8NCj4gPiA+IHNlZQ0KPiA+ID4gaWYgdGhlIGh5cGVydmlzb3IgaXMg
dGhlcmU/IElPVywgbWFrZSB5b3VyIHNvZnR3YXJlIGludGVyZmFjZXMNCj4gPiA+IGRpc2NvdmVy
YWJsZS4gRFQgaXMgZm9yIG5vbi1kaXNjb3ZlcmFibGUgaGFyZHdhcmUuDQo+ID4gDQo+ID4gQ2Fu
IGRvLCBvdXIgaHlwZXJ2aXNvciBpcyBkaXNjb3ZlcmFibGUgdGhyb3VnaCBpbnZva2luZyBwcm9i
aW5nDQo+ID4gaHlwZXJjYWxsLCBhbmQgd2UgdXNlIHRoZSBkZXZpY2UgdHJlZSB0byBwcmV2ZW50
IHVubmVjZXNzYXJ5IG1vZHVsZQ0KPiA+IGxvYWRpbmcgb24gYWxsIHN5c3RlbXMuDQo+IA0KPiBS
b2IgaXMgb3V0IG9mIG9mZmljZSBhdCB0aGUgbW9tZW50LCBidXQgdGhhdCBhcHBlYXJzIHRvIGJl
IGEgcmVxdWVzdA0KPiB0bw0KPiBkcm9wIHRoZSB1c2Ugb2YgZGV2aWNldHJlZSBlbnRpcmVseS4g
TWFpbmx5IHJlLXBvc3Rpbmcgc28gdGhhdCB0aGF0DQo+IGNvbnZlcnNhdGlvbiBhcHBlYXJzIG9u
IHRoZSBsYXRlc3QgdmVyc2lvbiBvZiB0aGUgcGF0Y2hzZXQsIGdpdmVuIHlvdQ0KPiBvbmx5IHJl
cGxpZWQgdG8gUm9iIHRvZGF5Lg0KPiANCj4gVGhhbmtzLA0KPiBDb25vci4NCg0KV2Ugd2lsbCBy
ZW1vdmUgb3VyIGR0IGhlcmUgYW5kIHVzZSB0aGUgZGlzY292ZXJhYmxlIHdheSB0byBpbml0aWFs
aXplDQpvdXIgZGV2aWNlcy4gVjQgcGF0Y2hlcyB3aGljaCBjb250YWluIHRoZSBjaGFuZ2VzIG1l
bnRpb25lZCB3b3VsZCBiZQ0Kc3VibWl0dGVkIHNvb24gaW4gcmVjZW50IGRheXMuDQo=
