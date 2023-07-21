Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6DA75C1EF
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jul 2023 10:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjGUIqk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jul 2023 04:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGUIqj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jul 2023 04:46:39 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED4E2D6D;
        Fri, 21 Jul 2023 01:46:31 -0700 (PDT)
X-UUID: 12537d2627a311eeb20a276fd37b9834-20230721
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Qv2Sh8VJ3NlVYiLOlSkCF3P24PtLTLl9NPBg7u7usEs=;
        b=fjCeWNnHc8nTqn13uchr2ljxrGu8XxkT1POh4ELF1r5prStSilHik+hWYw8tN++CYH+gb9GCV2+w9Nulq2flXjDJAmVM3+4skJQZUhR1KDRMIOYXORjaqX/Sz9tF+eQArEq7g+PIq18POIVfV275puBAL5CQsA56M06i5thpZVY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:734956e2-9d0a-4590-ae1c-190719e79279,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.28,REQID:734956e2-9d0a-4590-ae1c-190719e79279,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:176cd25,CLOUDID:de0ee287-44fb-401c-8de7-6a5572f1f5d5,B
        ulkID:230721164625GCRRA7SF,BulkQuantity:0,Recheck:0,SF:28|17|19|48|38|29|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,C
        OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,
        TF_CID_SPAM_FAS
X-UUID: 12537d2627a311eeb20a276fd37b9834-20230721
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1426286355; Fri, 21 Jul 2023 16:46:23 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 21 Jul 2023 16:46:22 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 21 Jul 2023 16:46:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEE0k0VmOGxy6ergaud8YSwZi66Rqwr2WhlmhUWhRjnmfWoO9ZkE29jQrroZ0nEMm6sIpUnDp7SulDSaQqhCmdywvujFhMi6jrJcsFAxtfljda3wSEHOwN0pxKbLMdnlAAyI8Mz/++pK0NhZIpDmPuSSD5WCH5tsTx34eZHgkjlibvykNULvVo9Ybdy57pMiVHXPxsMZpdhSjRhVaM2OvZGsQUCYla4dFMAP8HGX26SNk7WpZneJuv0uE0a6SnnMuzEYKTFypVo4kD7TSlum71GEO2wujRFb82aXoValOBrnzFeSJrCmZA3ieLF4V9i6gpzrUwcSBWTOvmff77EHEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qv2Sh8VJ3NlVYiLOlSkCF3P24PtLTLl9NPBg7u7usEs=;
 b=eQVCb6kS/QIEXsVnHw4zi19YmVPlg8ycW4U31CIG6fmDdl7ZqrLkFtKa3dal5YiPL8vqN3pY6vQKqZD2JVFceq8nSuKTMKWtSRGC2/2jrRaoKo1mFrs6b15nrnPwe7ZKTWrX1aNJmvlrbDrloZj9twmn51upCPJ4ASWsDOkSlYT8PfJTFBzWrtqQ3wvI0qGJzdHoxo0/ZBJ0MzLpPK1o0tFa93IVlgRrabjrBhkN93lHT8G3SV4Bs2PpQyibI62SxBwpcLtJDGc3p2v+z/xwLSXOdErPFctdtBNmiMe7jcFBWwHuUBwm/0UYzQNzy5WFHxpoHINfnG9q7EMnsqP+TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qv2Sh8VJ3NlVYiLOlSkCF3P24PtLTLl9NPBg7u7usEs=;
 b=DRDEO/9WPH5vBe8a+uDOweCWxRdTfI51kVpG+5oGdwxw2zRPY0xv83OXYY/FKYM0O3UHXKhjhEok+VphPvpaSFjjbuJlvAkASR8mzaRdwrd2+bWZfZ5q9vkfFdA7kc0nBWwXMeRjJ8kmzNs/qbcs802jLc/JTGHFjBut8lJujp0=
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com (2603:1096:4:14f::8) by
 TYZPR03MB5392.apcprd03.prod.outlook.com (2603:1096:400:3a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.23; Fri, 21 Jul 2023 08:46:20 +0000
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::a944:f5f3:d44f:8498]) by SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::a944:f5f3:d44f:8498%5]) with mapi id 15.20.6609.024; Fri, 21 Jul 2023
 08:46:19 +0000
From:   =?utf-8?B?WWktRGUgV3UgKOWQs+S4gOW+tyk=?= <Yi-De.Wu@mediatek.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        =?utf-8?B?WWluZ3NoaXVhbiBQYW4gKOa9mOepjui7kik=?= 
        <Yingshiuan.Pan@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        =?utf-8?B?WmUteXUgV2FuZyAo546L5r6k5a6HKQ==?= 
        <Ze-yu.Wang@mediatek.com>, "will@kernel.org" <will@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?TVkgQ2h1YW5nICjojormmI7ouo0p?= <MY.Chuang@mediatek.com>,
        "quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        =?utf-8?B?UGVpTHVuIFN1ZWkgKOmai+WfueWAqyk=?= 
        <PeiLun.Suei@mediatek.com>,
        =?utf-8?B?TGlqdS1jbHIgQ2hlbiAo6Zmz6bqX5aaCKQ==?= 
        <Liju-clr.Chen@mediatek.com>,
        =?utf-8?B?SmFkZXMgU2hpaCAo5pa95ZCR546oKQ==?= 
        <jades.shih@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dbrazdil@google.com" <dbrazdil@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?U2hhd24gSHNpYW8gKOiVreW/l+elpSk=?= 
        <shawn.hsiao@mediatek.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        =?utf-8?B?SXZhbiBUc2VuZyAo5pu+5b+X6LuSKQ==?= 
        <ivan.tseng@mediatek.com>,
        =?utf-8?B?Q2hpLXNoZW4gWWVoICjokYnlpYfou5Ip?= 
        <Chi-shen.Yeh@mediatek.com>
Subject: Re: [PATCH v4 2/9] virt: geniezone: Add GenieZone hypervisor support
Thread-Topic: [PATCH v4 2/9] virt: geniezone: Add GenieZone hypervisor support
Thread-Index: AQHZmq+rW9yOddqvm0eELq6V2MM/Yq+ClwGAgEGTQQA=
Date:   Fri, 21 Jul 2023 08:46:19 +0000
Message-ID: <ea531ba80db67cccb03ea173e714fe868f869e91.camel@mediatek.com>
References: <20230609085214.31071-1-yi-de.wu@mediatek.com>
         <20230609085214.31071-3-yi-de.wu@mediatek.com>
         <2fe0c7f9-55fc-ae63-3631-8526a0212ccd@linaro.org>
In-Reply-To: <2fe0c7f9-55fc-ae63-3631-8526a0212ccd@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6167:EE_|TYZPR03MB5392:EE_
x-ms-office365-filtering-correlation-id: 5451be4e-8b38-44ac-ee8d-08db89c6f42f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YB7mWR6YX9MiNcqmJuGgZA2LlTvjvUEztojiO73RpEQAO42ILjkYtdkSlcczouy+aev7zB/f5Nx1BCkUQiKrUnHTBw0ShJCQyXdh8xKtDgEWTF3YGu5vYSZcMZrU6C5Rn+p0Ps6nmLdwynZOKZFvHTEgymLifpKSh/uTYRR50DUOMn513nXgQXLQmy/v/jrq4Km73nfXUDTpJWFB9Zr8RKUGpHJXzSYik4zpkX0i3YGtLTW9MzwZD020YxdBCcnVZc1RtViSXz8SAbg3JA3Zy7iVFPcjEOwQzs2lwRH//MiN8aIA8G61F2IUq0KE1lTF1AfFxXfYjpz8rjmOsbB8D48twUxxbWCgndn9KElm/yHdSZyaTJIomqCPq1ddKh/ih3LsKzI7xhZk71buSI/ugqqnu9wN4kB2mldxJ0OT5qJCWhgCAaHDLgkIrGphwTiPKwkBPwoZtB6mjRX5UPMJunsPCcUyPn6u3cFRAgyD3PrZojOZwHIa4ZD+nIgXfxdcAIMVOGyVrhdV9Vl2f+LlRvyuUDT7MRVsyDKU3R75XbJrfvJtL5RQ6Ggcpw7QlTY2S0Xmj/GZrRvAFNVFEY1ZHo2J8z3eONXm6pIUKrERVReiq4C0ADyLINAupHzWdLhz4nP3TdyE5fR09UlEsMb/yhiHvsxkOoX+wDhe6cv3dkYB+96V5Tj+bfaynb++hKGf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6167.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199021)(966005)(6512007)(6486002)(71200400001)(186003)(85182001)(6506007)(83380400001)(36756003)(2616005)(86362001)(38100700002)(53546011)(38070700005)(122000001)(26005)(66946007)(107886003)(2906002)(5660300002)(4326008)(91956017)(8676002)(8936002)(41300700001)(66556008)(316002)(76116006)(64756008)(66446008)(66476007)(7416002)(478600001)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmY3bVB4MTBYNThTTlBPNFM1ZndpWVNTUFp1bHdjV3ZUWjRycUtkdUw1eVlh?=
 =?utf-8?B?eVF2ajl6Y3plR0cxcklMVVEyNU80dS8xQndzYmJ1WEMxK0NqWmJJNldGc0ta?=
 =?utf-8?B?TFdzakd0QXA3dEFGd3hOS3o0Z0svMjZFdUdRNjVjTGRscHlEQmVzQXVKWkVW?=
 =?utf-8?B?V01Zd3NNNTN0K2JTV0oranBGQi9tRmJwQWtEcHNtUTlqVElyNU41RHYvUktw?=
 =?utf-8?B?aUVLUFBEVWR2RExzOGRua0NNeEY4VkM2ZUVhSzBxZi9ML0tXZW5ueUZFSEYw?=
 =?utf-8?B?ZnF6TXdsT284VzZLQlhNUHdVZlg0NDJNZ2VFTzlOSFh2a0g4NW9kam9IYmN4?=
 =?utf-8?B?V3RmVjU5UUVTeVVTVmJWVjYwK1BKSjh1VHczT1ZwazE0UXJGbnhyNWhlWkQz?=
 =?utf-8?B?RHo4c2FxYUQ2ckRhNUpCMS9vbnBsU3d2UGRvS2wwOWtVengyNjhhaytOckYv?=
 =?utf-8?B?YzQ5dFJvU1NwNTdhcHhxcGFYL3JkaER4WHE2OU91U1B0dVY3Y3Q4eFNMSHZx?=
 =?utf-8?B?aHRjSVhWK1BRR3BpaVh1ZVRuRS9sV3NzYXVPU1JZZ1FKaVVGOEo4cjE0c0Yr?=
 =?utf-8?B?MUN0QjJpMVVWVUFna1lQdU4rem9jUmsxcVJoR0lFQXovMUJnTTBZUTJ4Sk5F?=
 =?utf-8?B?a3NKTFk5bTh1a1FMNytTRVRTT0EvanRiS1FUeldheVZLS3VHQ3NvaGxheHZN?=
 =?utf-8?B?MU5PcDAxczhWSnJDWS9jL0NpamYwYzVud0RJdE9TemlYSlhFak5VaTFLMUlO?=
 =?utf-8?B?eHVOOEpWc1hEdk90SE9aaW1mM3VKV2dHbzRleUg0Wk81alROYkVualVvamw4?=
 =?utf-8?B?Y0FEb3Z0NXV2SEZrbUROZHhERGV2ZVVUQVhhbXFOSXVlZjFaYUJIMmRLb2xW?=
 =?utf-8?B?N01aVFdaUGRaKzhwSWw4WHJ0elRXaTh0SncwODAwY1dLM2syMjluRXZzcmNN?=
 =?utf-8?B?amtUTVVKMm9BK0tQVUFIdTMxVHVBZVd5SUZMNStDK2dNM3FWQTVVNjJML0Nj?=
 =?utf-8?B?MzRXTjg0OGxjcVdVdHJveElNT3dyazd2TjRxSmNhTStUdmVGUDhuZlNSaWNG?=
 =?utf-8?B?QVFjOVJBOG5EdGNmaFRiYm15ZlJRNitZczdZbDhQWnNjcExyOUovaElmd3Vy?=
 =?utf-8?B?MUlMSXNYR0RrMUtKeG1iNUdxdXBrQXRYeno4VDcxaFBvU3R3cnE2amRoeVVp?=
 =?utf-8?B?UHR1REY2aGNERXM3S3NhN21LaWFONDFsUU5rZ2RFMVQzbzlvWmNrTnZwVmp0?=
 =?utf-8?B?SzBWWGtzYllHQWVZenhRZ1dDQkEvMmQrRFJiSnkyRkRDV3hHSXFwR09YcjZz?=
 =?utf-8?B?b3h3ditsZTRyVzhOenFZcGhzd203S25yTytWTUp6d3FkY1hKbjlVT2hGbkpa?=
 =?utf-8?B?UC8yTVd1czBJaVZzdHB5Uit6Q25uaU94Rm5LcFRoeTM5MWgxaXB3Rk5lSTBZ?=
 =?utf-8?B?bDlxb0xSdmsxTEFQSVpzbjJ6OUtXM1BkdjRLMFFoK0pHSWU5VmJMUVhSY0lM?=
 =?utf-8?B?OFYvMlFreVNCK1Mrb2lRTVEzbHZrZk5qc1RNSmZxL0djdFkwd2NNSTR0WnA0?=
 =?utf-8?B?NjdkVkdFTkRzdE1zbUFCZGdQa1NUY096eXNrbjR6WTVIK0J6SXJvRlFub1Fv?=
 =?utf-8?B?aFB4Z2tBOGl5R09NQzNQcHVaOHRYK1haVVZTdThVeDhpeWxyTG13eG1saTNt?=
 =?utf-8?B?VWFWZmZXM2VWWXk1Z1FaUlVkZllrdlZoSHNDRzFoUlliSDVxVldVTWZTZUZY?=
 =?utf-8?B?Yy8wakNoQ2pBR25uK2NFcFZZR0Y5NjR5N2RWbkJ2MWVqU2lZUEg5amdXbTRQ?=
 =?utf-8?B?VzVPQjB1anYxbjNVd2F1UUJuOFlEZTZrQ0dMTlpBUmQxekdqRVBtZ2hKV1dB?=
 =?utf-8?B?ajNWM2t3Y0FwL3RtNE5NT3JrWnR5ekQ0bHdoY09hZXVkTkNEdytXREtQdCto?=
 =?utf-8?B?Mys5TXo2YmRCeGQyRjlqaU5jN1dnZnlJREJ4a1MzblNJckhVdkRGOEhsMHhE?=
 =?utf-8?B?QmcybkRxeWxSVEFDOW5maExmNmg2N2lWM3kzbWxzOHNyOVo3c3ZvQW14bEJl?=
 =?utf-8?B?ZmZnZjBoeVREeERBODFqVHVIamgvRW9HaElUcFhWMHZFVFFOc0JLQXhlR1FW?=
 =?utf-8?B?V0MwTFNHL3hnVmZqYThFdnV5V0tERmZidGNtM2FmaEU2amtaUCtlTDZURHg4?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD2B132F4E570543911CC07CAD438D2F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6167.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5451be4e-8b38-44ac-ee8d-08db89c6f42f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 08:46:19.5765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S4ZOeX+968aTJ0zCjHSt0VDOLO7kZ4R7b1MdL0JwXupZyDHj5D+7ydR07cs9+9J1dW4gLe26IsHrNk0biKQNvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5392
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTA2LTA5IGF0IDE3OjIyICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDA5LzA2LzIwMjMgMTA6NTIsIFlpLURlIFd1IHdyb3Rl
Og0KPiA+IEZyb206ICJZaW5nc2hpdWFuIFBhbiIgPHlpbmdzaGl1YW4ucGFuQG1lZGlhdGVrLmNv
bT4NCj4gPiANCj4gPiBHZW5pZVpvbmUgaXMgTWVkaWFUZWsgaHlwZXJ2aXNvciBzb2x1dGlvbiwg
YW5kIGl0IGlzIHJ1bm5pbmcgaW4gRUwyDQo+ID4gc3RhbmQgYWxvbmUgYXMgYSB0eXBlLUkgaHlw
ZXJ2aXNvci4gVGhpcyBwYXRjaCBleHBvcnRzIGEgc2V0IG9mDQo+IGlvY3RsDQo+ID4gaW50ZXJm
YWNlcyBmb3IgdXNlcnNwYWNlIFZNTSAoZS5nLiwgY3Jvc3ZtKSB0byBvcGVyYXRlIGd1ZXN0IFZN
cw0KPiA+IGxpZmVjeWNsZSAoY3JlYXRpb24gYW5kIGRlc3Ryb3kpIG9uIEdlbmllWm9uZS4NCj4g
DQo+IC4uLg0KPiANCj4gPiArc3RhdGljIGludCBnenZtX2Rydl9wcm9iZSh2b2lkKQ0KPiA+ICt7
DQo+ID4gK2ludCByZXQ7DQo+ID4gKw0KPiA+ICtpZiAoZ3p2bV9hcmNoX3Byb2JlKCkgIT0gMCkg
ew0KPiA+ICtwcl9lcnIoIk5vdCBmb3VuZCBhdmFpbGFibGUgY29uZHVpdFxuIik7DQo+ID4gK3Jl
dHVybiAtRU5PREVWOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtyZXQgPSBtaXNjX3JlZ2lzdGVyKCZn
enZtX2Rldik7DQo+ID4gK2lmIChyZXQpDQo+ID4gK3JldHVybiByZXQ7DQo+ID4gK2d6dm1fZGVi
dWdfZGV2ID0gJmd6dm1fZGV2Ow0KPiA+ICsNCj4gPiArcmV0dXJuIDA7DQo+ID4gK30NCj4gPiAr
DQo+ID4gK3N0YXRpYyBpbnQgZ3p2bV9kcnZfcmVtb3ZlKHZvaWQpDQo+ID4gK3sNCj4gPiArZGVz
dHJveV9hbGxfdm0oKTsNCj4gPiArbWlzY19kZXJlZ2lzdGVyKCZnenZtX2Rldik7DQo+ID4gK3Jl
dHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGd6dm1fZGV2X2luaXQodm9p
ZCkNCj4gPiArew0KPiA+ICtyZXR1cm4gZ3p2bV9kcnZfcHJvYmUoKTsNCj4gDQo+IFNvIGZvciBl
dmVyeSBzeXN0ZW0gYW5kIGFyY2hpdGVjdHVyZSB5b3Ugd2FudCB0bzogcHJvYmUsIHJ1biBzb21l
IFNNQw0KPiBhbmQgdGhlbiBwcmludCBlcnJvciB0aGF0IGl0IGlzIG5vdCBvdGhlIHN5c3RlbSB5
b3Ugd2FudGVkLg0KPiANCj4gSSBkb24ndCB0aGluayB0aGlzIGlzIHdoYXQgd2Ugd2FudC4gWW91
IGJhc2ljYWxseSBwb2xsdXRlIGFsbCBvZg0KPiBvdGhlcg0KPiB1c2VycyBqdXN0IHRvIGhhdmUg
eW91ciBoeXBlcnZpc29yIGd1ZXN0IGFkZGl0aW9ucy4uLg0KPiANCj4gDQo+IEJlc3QgcmVnYXJk
cywNCj4gS3J6eXN6dG9mDQoNCg0KaGkgS3J6eXN6dG9mLA0KDQpBZnRlciBzb21lIGJhY2stYW5k
LWZvcnRoIGRpc2N1c3Npb25bMV1bMl1bM11bNF1bNV0sIHdlJ2QgbGlrZSB0byBicmluZw0KYmFr
YyBhbGwgdGhlIGF0dGVuc2lvbiBvZiByZWxhdGVkIGlzc3VlcyBpbiB0aGlzIHRocmVhZC4NCg0K
V2UncmUgZ29pbmcgdG8gcmVzdG9yZSB0aGUgZHQgc29sdXRpb24gb24gb3VyIG5leHQgdmVyc2lv
biwgd2hpY2ggbWVhbnMNCndlIHdvdWxkIG1haW50YWluIGEgc2ltcGxlIGR0IGZvciBkaXNjb3Zl
cmluZyB0aGUgaHlwZXJ2aXNvciBub2RlIGFuZA0KcHJvYmUgZm9yIHRoZSBzdGF0dXMgb2YgdGhl
IGRldmljZSB3aGVuIG5lZWRlZC4NCg0KVGhlIHJlYXNvbnMgYXJlIGxpc3RlZCBiZWxvdyBmb3Ig
dGhlIHJlY29yZC4NCi0gQWx0aG91Z2ggZHQgaXMgZm9yIGhhcmR3YXJlLCBpdCdzIGRpZmZpY3Vs
dCB0byBkaXNjb3ZlciBhIHNwZWNpZmljDQpoeXBlcnZpc29yIHdpdGhvdXQgcHJvYmluZyBvbiBh
bGwgc3Vic3lzdGVtIGFuZCB0aHVzIHBvbGx1dGUgYWxsIG9mDQpvdGhlciB1c2Vyc1s0XSBhcyBh
IGNvbnNlcXVlbmNlLg0KLSBUaGUgR2VuaWVab25lIGh5cGVydmlzb3IgY291bGQgYmUgY29uc2lk
ZXJlZCBhcyBhIHZlbmRvciBtb2RlbCB0bw0KYXNzaXN0IHBsYXRmb3JtIHZpcnR1YWxpemF0aW9u
IHdob3NlIGltcGxlbWVudGF0aW9uIGlzIGluZGVwZW5kZW50IGZyb20NCkxpbnV4aXNtLg0KDQpQ
bGVhc2UgbGV0IHVzIGlmIHRoZXJlJ3JlIGFueSBvdGhlciBjb25jZXJucy4NCg0KUmVmZXJlbmNl
DQoNClsxXSANCmh0dHBzOi8vYW5kcm9pZC1yZXZpZXcuZ29vZ2xlc291cmNlLmNvbS9jL2tlcm5l
bC9jb21tb24vKy8yNDQ3NTQ3L2NvbW1lbnQvNDk1NTAyZjNfYmI1MjM0NGIvDQpbMl0gDQpodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA0MjgyMTI0MTEuR0EyOTIzMDMtcm9iaEBrZXJu
ZWwub3JnLw0KWzNdIA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2VjNGNhZTJlNmRhNGE2
NGJjMzk4M2ZmZGRlMDNmNTFlMTg1ZDM2MDkuY2FtZWxAbWVkaWF0ZWsuY29tLw0KWzRdIA0KaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yZmUwYzdmOS01NWZjLWFlNjMtMzYzMS04NTI2YTAy
MTJjY2RAbGluYXJvLm9yZy8NCls1XSANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8xNGMw
MzgxYmUzOGVhNDBmY2QwMzEwNGJmZjMyYmNhYTA5YjkyMGQzLmNhbWVsQG1lZGlhdGVrLmNvbS8N
Cg0KDQpSZWdhcmRzLA0KPiANCg==
