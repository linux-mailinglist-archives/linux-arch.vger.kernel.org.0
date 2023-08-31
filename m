Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160C678E79E
	for <lists+linux-arch@lfdr.de>; Thu, 31 Aug 2023 10:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241155AbjHaIKD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 31 Aug 2023 04:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjHaIKC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 31 Aug 2023 04:10:02 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39571A2;
        Thu, 31 Aug 2023 01:09:54 -0700 (PDT)
X-UUID: c072c2c047d511eeb20a276fd37b9834-20230831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=PrEOwMBWf9MlCzRE+dPoraLju6miclVEg5sT0RqhXNQ=;
        b=F69ZazfmBLqnma3VPkLSsc3xstrqS9bj2ikVdzuDIijCiIfMTuDWujGuYiSWITwmxoNIvU9dVxVCQlj44UTfrULDQWLLOZF/EmL4lueX+d+fSRkz6qGIoLEi6EMJiv9Yx781ObmmrWP/NzbPqRTGKnzq4xsvYEr73PxUR3j5ZWk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:a997ba80-0168-49bf-b629-0a1d6b35472f,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:0ad78a4,CLOUDID:c1e86513-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: c072c2c047d511eeb20a276fd37b9834-20230831
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2141834850; Thu, 31 Aug 2023 16:09:47 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 31 Aug 2023 16:09:46 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 31 Aug 2023 16:09:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgGEqNAE1clVJdXdFNx5S9qtCtgItUcam1Rjpj8ry0soqMLkuaJWdFKGDWYbkaRjQTghM3Z+ViwnTQUeYZC464hd9P/PX0FkuYVCDmoodz/3O7mDsh02QZq8G2ctFE0V+um9gp6y0ivyeklZ9E+iFku+tZdBdS8IfaPUhDqUEsw5WbJ2F00A5VZxAYVy7ZMjOgc/I5rHEWAdGdK6PDlu+DeRx0uhZ2atbfjP4Zb48zps7dtpD+lqcOIeYD0DPxzRUJWO1ffneUjnJneOWF+My2GxyJLOSvU85shgV7Z1p0W0icBQR8VXCONE/spEGH+HRxcI0RXdAmadLMm0YrPALA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrEOwMBWf9MlCzRE+dPoraLju6miclVEg5sT0RqhXNQ=;
 b=R5TS54h8Hu6GPIiNrKb8Wkctt40UDYNTLj1X22xtYgLyVbUsj34Op3Qk9F/rcgFvFZAOrChTtvYpj1ssRLxRlaWNZ+9ytcv0p+VAYQEwizfxWbl3UOtag9kSHFzxSStvQJAuatnyfSBKEe5JY6nSt5IHsBsUefzL9RJy5Gtjl/YYPF39G5ORNUiq64YlObPSJzRJnKKQz7Lmp0ALY90ZCffczrPcheHKQR9dxogAlTE5s4al+T20m5hxXCoQyF2vVX9a12LlKJnJrl6mUO0sdoM9OuyDfaXrmkwly/Q1hGTWn9mfd94sdKZomWXtvKCQE/+a7FL+vHND6//5wQd6xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrEOwMBWf9MlCzRE+dPoraLju6miclVEg5sT0RqhXNQ=;
 b=Cmn9V0ILYWoonVBbV6BCCZz34M5ruSM3rWr1DkJIRMjvvOMSa7FPwiJhEGEBADZCXAkGeMh1xAIb3TTp78F+RJ2QE7M5rTlPQdjlR4dlssdcwbeeg3tmB0TaxKgT4UQSDwFm944GAzcfjJRqJ6bTW6JMsbTC5dLCrhXj0cpsUtM=
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com (2603:1096:4:14f::8) by
 JH0PR03MB7321.apcprd03.prod.outlook.com (2603:1096:990:15::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.35; Thu, 31 Aug 2023 08:09:44 +0000
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::a944:f5f3:d44f:8498]) by SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::a944:f5f3:d44f:8498%5]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 08:09:43 +0000
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
        =?utf-8?B?Q2hpLXNoZW4gWWVoICjokYnlpYfou5Ip?= 
        <Chi-shen.Yeh@mediatek.com>,
        =?utf-8?B?U2hhd24gSHNpYW8gKOiVreW/l+elpSk=?= 
        <shawn.hsiao@mediatek.com>,
        =?utf-8?B?UGVpTHVuIFN1ZWkgKOmai+WfueWAqyk=?= 
        <PeiLun.Suei@mediatek.com>,
        =?utf-8?B?TGlqdS1jbHIgQ2hlbiAo6Zmz6bqX5aaCKQ==?= 
        <Liju-clr.Chen@mediatek.com>,
        =?utf-8?B?SmFkZXMgU2hpaCAo5pa95ZCR546oKQ==?= 
        <jades.shih@mediatek.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
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
Subject: Re: [PATCH v5 00/12] GenieZone hypervisor drivers
Thread-Topic: [PATCH v5 00/12] GenieZone hypervisor drivers
Thread-Index: AQHZwGB03EK4wPTFHUyhJ3nzDQrEXq/lZ6CAgAjRaoCAFgsyAA==
Date:   Thu, 31 Aug 2023 08:09:43 +0000
Message-ID: <62be4ec46d685cc411a5b38d9710f99be2a15239.camel@mediatek.com>
References: <20230727080005.14474-1-yi-de.wu@mediatek.com>
         <20230811165219.GA3593414-robh@kernel.org>
         <4b81b7fbd50c04958c27fbb6e620a15ae4fe0d54.camel@mediatek.com>
In-Reply-To: <4b81b7fbd50c04958c27fbb6e620a15ae4fe0d54.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6167:EE_|JH0PR03MB7321:EE_
x-ms-office365-filtering-correlation-id: 297e7ffe-cb2c-4a12-dccc-08dba9f9a260
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: noSrgeHO0zPsvfZREuTTTtw6LRrn1c4oax/hbIrOjJ+CB5Bl5k6eP53WeBCcwZhIZn8Lkusx/E3LMkXNDMTJ7qwZHmK7bhvoCBvE5VxBILfX39NaVPUF4YxAKArVxUYhXPNKjmnJBEZDdKhWuhovJrhduKvpihHXSr5Xm4dGmmE5ZVTGrWyfN1DkRRgig+jUJwCfvxtHGn6e3KCdZKysWZBGqPKJlGdh1I17igHcNY2wq5mxdVIcUIpSoWjJJKpc2tAR7Smbi3Gtowr5i/h1ZdSxxOIHkX/j8vMe0Ss15cio8WikysJpjiwK9my9CdS1eVq3CXZ4DVgX8V6wKPKo7O0m19ywvC0lx7LeZyqaDsPQFP8pnI6zlPiAkfPOLwwibJjuaCwHPwFOzFFumhcz9qkclzVqo9CN6yu8XOo5UJZZkCnWzWSPhdpx59XErVTulWJGrq3nFPlDqrxGrTLpWtTE84hWWdFufkoTGh4ruxUhp3st9UMZYUY3hAsadimprAtlLDcF/Dx3S9D38OKCUtKnhmXlizt9ee57I3ykhGgbWLTaLcBGr1wnCNJIYEHiB6vLRECVPbA0VVHpEedBTMCz/Xhkmh27tbvP5Gx6Q7v9aBuOS8b6JX98U/wvT4qCBxAOFm/5WFE6iR4MBnZGPggHuCZx6o/ZPeXokO0Nz4nca0sQoTHS49vnx3pd4zMz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6167.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199024)(186009)(1800799009)(71200400001)(8676002)(8936002)(122000001)(76116006)(66946007)(64756008)(66446008)(91956017)(54906003)(66476007)(66556008)(6486002)(966005)(6506007)(478600001)(6512007)(38070700005)(41300700001)(316002)(38100700002)(6916009)(85182001)(26005)(36756003)(107886003)(83380400001)(5660300002)(86362001)(2616005)(7416002)(2906002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emxFeUZsM1grMlQ2UXkzLzgvZEFqVFBLRjJCck1PbGlISkJENCtiTHZ3YXAw?=
 =?utf-8?B?TXFINkVJazB6MVVGZ0J5R25yRVVEMmFaMHNNTmpGNEFqaUJNQkc0UGg0YVBH?=
 =?utf-8?B?WjhEelNTalQ3REExWndZTndjUHhnZ2syQ1JXQ1BHdmNtOGNEcTF2QnZIb0ZD?=
 =?utf-8?B?Y1RGNXd2dSs3ZllscTRUVUFGaTA5Und0eWF2a08rZDFQU2lERThKbWRzM0h4?=
 =?utf-8?B?a2EyK09IcWtyR2lzUG42U1Q5NGVyZ1A2dzQ3YlBnM0FlRWUvSW1ib0tLeFV2?=
 =?utf-8?B?Y1MybU9LNVNWaHppUGhCVy9CSlFrOTlQK3UvT1dFc1RWOEZ2ZkFpZGg1TnZS?=
 =?utf-8?B?Vjdob0JUa0EvcUhtTUZ4YnZJUnZteVFLRlhMdXpNbHJUVVdNc09oYVJOdERJ?=
 =?utf-8?B?bVViS0ltUXc1MVBJb1BSTUFuZWVCK256U1REUXZranVGbmhTMGt3TUpYd3dM?=
 =?utf-8?B?OTVWRUZ5MmUxQ2pyMUZ4TVk0T3FzbUNCVkdFMXc2d3BSMkJmMU1ueXJ4UVB4?=
 =?utf-8?B?cmx5WTRIWk5EaWNCRUd4RkRqN1Q1Q0ZnNmgyalRURzkzV2hpM0xDeER3U3Iw?=
 =?utf-8?B?TmpESDU1WkkyV01heU5Xbi9tQmhZVnFSWERvVlNVc1IyNVdsV2xoNUZLSHZh?=
 =?utf-8?B?SFFUdnc0eUM1Tk1YZkZuTmoxZmQ4Mjh0alVRdEdoUkNPNllsU0JMdTlobkhv?=
 =?utf-8?B?MGgycXZUZ3BoUUF4ekpNbDFLN3JldXVsUkpFVXliN0VNRjVzOGxIQitpUHcw?=
 =?utf-8?B?RTlaT3J1UHlvc3NRblJJQk8rMXc2T2xzdG8vR2Q1ZklYL0d2UHYxMDZhbSt1?=
 =?utf-8?B?VEFTQUczSG5iRnJsWTFJOE1PYVhEMlBvWTZpLzN1bldLaEd5UEdncFY4S3Yx?=
 =?utf-8?B?V2NadjZPdk9Rd01Hb25URVZQTVVLQjB2TXduME5BNmZYSnJBYStFc1BDTzgw?=
 =?utf-8?B?NnZyaWtUNzN4Y0R2UlhSSGZlRUNRblpJVVB5c2tXUkFaVVZpYU1YdXB6dzRX?=
 =?utf-8?B?WkRLQWRYejFvZFVITE1YbHdsSVhLZlNnZXlKcTlYTCtXbzhRT3JMYklQd1hF?=
 =?utf-8?B?a2ZEYThCd0dibnZQdUw1RmcyNG01Y2pEeVh4ZlN4cHNlNXVaMEQzaktkWGRP?=
 =?utf-8?B?bTR6WWtZRi94dW9WaDErSW13UmhGVHhxeGlIUjhwbnpxVGViRDFoaDlVTEhs?=
 =?utf-8?B?S3dIN1JKWjFHQitiamMyQ0pSckNTT2M5QVBkSGdrZm0yVUxhcDJPUlFiUTFn?=
 =?utf-8?B?VDhtdHVqZ1prMG41UzZ3L2tZcUhSbU0vZEJnK0JVOVUzRmpVcEh4NkU1SXF1?=
 =?utf-8?B?dmQ2RldNMXdUNFQ0UStLdVJFOHRiVGV6VFpRNlh1S3N2Rm5FTmlQblVtUXZ5?=
 =?utf-8?B?dHd1MlRRTExpa2tjb1QwWHpYRk9hQTMzNm11MmRLZG1hRkRlaEU0Y0ZiaUJK?=
 =?utf-8?B?ZTIrT1Z2VGNFdGhBd2ExcDJYVkRZL1NabUFjZXgzZDhxUDVKR1hkMko0TnVR?=
 =?utf-8?B?VU1Zbmc1UUs2RzFpZ3BjUytKWkhlUjZvMENiMzczSDBtNUdidVg3RnY2NnJO?=
 =?utf-8?B?S0llVFRLT0NmWUtEcFFlMTVNVXJpeGQyaFVKc0JIbHE3RklUeFdxTVVuQ2Fk?=
 =?utf-8?B?KzJjYTRyQzAvUWRldC9DY3JKWXhxUitBMkx0d2MyclFZUnBzRjdiaTRSbGI1?=
 =?utf-8?B?WS85aW5WQjU4S3RLaytBVjBENDdZYTNlTjBsd0VtdlN5blVTK2FWemh0V0xq?=
 =?utf-8?B?am9JYmo0Nkl2cnBuSys0RWRFczdhaVU1TGNSUnFwdHNrY1l3S3lISmNWUmda?=
 =?utf-8?B?VlpIRlNZa3ZDQndscWhxZU9yTnJFMmlWTUhNZ0pOS2xvTkoraml4WHMzaUk3?=
 =?utf-8?B?Y1ZvTmxkeko5bUNXaEtleUw3NEdnaXZnWk53bktXNm0wRjU1U0hsZUxCZSty?=
 =?utf-8?B?NTVjZ2IzZi8zazJQUkFZSUdlRDd5aVB4K2NkTExWUVBxam5QNEFEcmdCaTdK?=
 =?utf-8?B?WHAzQmg0K1YvQXZSaTdXZXZDQU1QR0V6TG9QVG13TGJldXdVazIyd1AwR1dz?=
 =?utf-8?B?WW1YYnhHZWhOZjFFbXdzdmJxcUluWE9RUkM1REJWREt6czB3RDBTWkpTUzF2?=
 =?utf-8?B?YkpzaGcrVUFsdVl1dGtGYW01UUZlN1pGaW1yMjBydnJyYVJoVWNxTm1YRWRx?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC54F5606207944A88807DABED213B71@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6167.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297e7ffe-cb2c-4a12-dccc-08dba9f9a260
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 08:09:43.9211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MzAUhd7j+rRbg2z+W39IdLNT/vRrlI5R4e2uShYcswa/mEIXMoXWe1NVNPtO2w9T6Psc4qkkIq1AtCJG/AB3ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7321
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RDNS_NONE,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIzLTA4LTE3IGF0IDE1OjMxICswODAwLCBZaS1EZSBXdSB3cm90ZToNCj4gT24g
RnJpLCAyMDIzLTA4LTExIGF0IDEwOjUyIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4gPiAg
CSANCj4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cw0KPiA+IHVudGlsDQo+ID4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gPiAgT24gVGh1LCBKdWwgMjcsIDIwMjMgYXQgMDM6NTk6NTNQ
TSArMDgwMCwgWWktRGUgV3Ugd3JvdGU6DQo+ID4gPiBUaGlzIHNlcmllcyBpcyBiYXNlZCBvbiBs
aW51eC1uZXh0LCB0YWc6IG5leHQtMjAyMzA3MjYuDQo+ID4gPiANCj4gPiA+IEdlbmllWm9uZSBo
eXBlcnZpc29yKGd6dm0pIGlzIGEgdHlwZS0xIGh5cGVydmlzb3IgdGhhdCBzdXBwb3J0cw0KPiA+
IA0KPiA+IHZhcmlvdXMgdmlydHVhbA0KPiA+ID4gbWFjaGluZSB0eXBlcyBhbmQgcHJvdmlkZXMg
c2VjdXJpdHkgZmVhdHVyZXMgc3VjaCBhcyBURUUtbGlrZQ0KPiA+IA0KPiA+IHNjZW5hcmlvcyBh
bmQNCj4gPiA+IHNlY3VyZSBib290LiBJdCBjYW4gY3JlYXRlIGd1ZXN0IFZNcyBmb3Igc2VjdXJp
dHkgdXNlIGNhc2VzIGFuZA0KPiA+ID4gaGFzDQo+ID4gPiB2aXJ0dWFsaXphdGlvbiBjYXBhYmls
aXRpZXMgZm9yIGJvdGggcGxhdGZvcm0gYW5kIGludGVycnVwdC4NCj4gPiANCj4gPiBBbHRob3Vn
aCB0aGUNCj4gPiA+IGh5cGVydmlzb3IgY2FuIGJlIGJvb3RlZCBpbmRlcGVuZGVudGx5LCBpdCBy
ZXF1aXJlcyB0aGUNCj4gPiA+IGFzc2lzdGFuY2UNCj4gPiANCj4gPiBvZiBHZW5pZVpvbmUNCj4g
PiA+IGh5cGVydmlzb3Iga2VybmVsIGRyaXZlcihnenZtLWtvKSB0byBsZXZlcmFnZSB0aGUgYWJp
bGl0eSBvZg0KPiA+ID4gTGludXgNCj4gPiANCj4gPiBrZXJuZWwgZm9yDQo+ID4gPiB2Q1BVIHNj
aGVkdWxpbmcsIG1lbW9yeSBtYW5hZ2VtZW50LCBpbnRlci1WTSBjb21tdW5pY2F0aW9uIGFuZA0K
PiA+IA0KPiA+IHZpcnRpbyBiYWNrZW5kDQo+ID4gPiBzdXBwb3J0Lg0KPiA+ID4gDQo+ID4gPiBD
aGFuZ2VzIGluIHY1Og0KPiA+ID4gLSBBZGQgZHQgc29sdXRpb24gYmFjayBmb3IgZGV2aWNlIGlu
aXRpYWxpemF0aW9uDQo+ID4gDQo+ID4gV2h5PyBJdCdzIGEgc29mdHdhcmUgaW50ZXJmYWNlIHRo
YXQgeW91IGRlZmluZSBhbmQgY29udHJvbC4gTWFrZQ0KPiA+IHRoYXQgDQo+ID4gaW50ZXJmYWNl
IGRpc2NvdmVyYWJsZS4NCj4gPiANCj4gPiBSb2INCj4gDQo+IGhpIFJvYiwNCj4gDQo+IExldCBt
ZSByZWNhcCBhIGJpdCBhYm91dCB0aGlzIGFzIHlvdSBtaWdodCBub3Qgbm90aWNlIG91ciBwcmV2
aW91cw0KPiByZXNwb25zZVsxXS4gSW4gb3JkZXIgdG8gZGlzY292ZXIgb3VyIEdlbmllWm9uZSBo
eXBlcnZpc29yLCB0aGVyZQ0KPiB3ZXJlDQo+IDIgc29sdXRpb25zIGJlaW5nIHRhbGtlZCBhYm91
dCwgbmFtZWx5IHdpdGggZHQgb3Igd2l0aG91dCBkdC4NCj4gDQo+IFRoZSByZWFzb25zIHdlIHVz
ZSBkdCBub3cgd2VyZSBsaXN0ZWQgaW4gc29tZSBwcmV2aW91cyBtYWlsDQo+IHRocmVhZFsyXS4N
Cj4gSSdsbCBqdXN0IGNvcHkgdGhlIHN0YXRlbWVudHMgaGVyZSBmb3IgYmV0dGVyIHN5bmMtdXAu
DQo+IC0gQWx0aG91Z2ggZHQgaXMgZm9yIGhhcmR3YXJlLCBpdCdzIGRpZmZpY3VsdCB0byBkaXNj
b3ZlciBhIHNwZWNpZmljDQo+IGh5cGVydmlzb3Igd2l0aG91dCBwcm9iaW5nIG9uIGFsbCBzdWJz
eXN0ZW0gYW5kIHRodXMgcG9sbHV0ZSBhbGwgb2YNCj4gb3RoZXIgdXNlcnMgYXMgYSBjb25zZXF1
ZW5jZS4NCj4gLSBUaGUgR2VuaWVab25lIGh5cGVydmlzb3IgY291bGQgYmUgY29uc2lkZXJlZCBh
cyBhIHZlbmRvciBtb2RlbCB0bw0KPiBhc3Npc3QgcGxhdGZvcm0gdmlydHVhbGl6YXRpb24gd2hv
c2UgaW1wbGVtZW50YXRpb24gaXMgaW5kZXBlbmRlbnQNCj4gZnJvbQ0KPiBMaW51eGlzbS4NCj4g
DQo+IEluIGNvbnRyYXN0IHRvIHRoZSBzb2x1dGlvbiB3aXRoIGR0LCB3aGF0IHdlIHdlcmUgZG9p
bmcgd2FzIHByb2JpbmcNCj4gdmlhDQo+IGh5cGVyY2FsbCB0byBzZWUgd2hldGhlciBvdXIgaHlw
ZXJ2aXNvciBleGlzdHMuDQo+IEhvd2V2ZXIsIHRoaXMgY291bGQgcmFpc2Ugc29tZSBjb25jZXJu
cyBhYm91dCAicG9sbHV0aW5nIGFsbCBzeXN0ZW1zIg0KPiBldmVuIGZvciB0aG9zZSBzeXN0ZW1z
IHdpdGhvdXQgR2VuaWVab25lIGh5cGVydmlzb3IgZW1iZWRkZWRbM10uDQo+IA0KPiBXZSdyZSB3
b25kZXJpbmcgaWYgdGhlcmUncyBhbnkgc3BlY2lmaWMgaW1wbGVtZW50YXRpb24gaW4gbWluZCBm
cm9tDQo+IHlvdXIgc2lkZSB0aGF0IHdlIGNvdWxkIGluaXRpYWxpemUgb3VyIGRldmljZSBpbiBh
IGRpc2NvdmVyYWJsZQ0KPiBtYW5uZXJzDQo+IHdoaWxlIG5vdCBhZmZlY3Rpbmcgb3RoZXIgc3lz
dGVtcy4gV2UnbGwgYXBwcmVjaWF0ZSBmb3IgdGhlIGhpbnQuDQo+IA0KPiBSZWdhcmRzLA0KPiAN
Cj4gUmVmZXJlbmNlDQo+IDEuIA0KPiANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8xNGMw
MzgxYmUzOGVhNDBmY2QwMzEwNGJmZjMyYmNhYTA5YjkyMGQzLmNhbWVsQG1lZGlhdGVrLmNvbS8N
Cj4gMi4gDQo+IA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9lYTUzMWJhODBkYjY3Y2Nj
YjAzZWExNzNlNzE0ZmU4NjhmODY5ZTkxLmNhbWVsQG1lZGlhdGVrLmNvbS8NCj4gMy4gDQo+IA0K
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzJmZTBjN2Y5LTU1ZmMtYWU2My0zNjMxLTg1MjZh
MDIxMmNjZEBsaW5hcm8ub3JnLw0KPiANCj4gDQo+IFJlZ2FyZHMsDQoNCkEgZ2VudGxlIHBpbmcu
DQoNCldlIHN1cHBvc2UgYSBzaW1wbGUgZHQgd291bGQgYmUgYSBjb25zaXNlIHNvbHV0aW9uIGhl
cmUgdG8gaW5pdGlhbGl6ZQ0KdGhlIEdlbmllWm9uZSBoeXBlcnZpc29yLiBXZSBhbHNvIGZvdW5k
IHNvbWUgb3RoZXIgc29mdHdhcmUgcGllY2VzIHVzZQ0KZHQgYXMgd2VsbFs0XS4gUGVyaGFwcyBp
dCBjb3VsZCBiZSBicm91Z2h0IGludG8gZGlzY3Vzc2lvbiB0aGF0IGR0DQpzaGFsbCBiZSBzdWl0
YWJsZSB1bmRlciBvdXIgdXNlIGNhc2UuDQoNClJlZmVyZW5jZQ0KNC4gT1AtVEVFIFRydXN0ZWQg
T1MgbWFpbnRhaW5lZCBieSBMaW5hcm8NCg0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGlu
dXgvdjYuMS9zb3VyY2UvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9maXJt
d2FyZS90bG0sdHJ1c3RlZC1mb3VuZGF0aW9ucy55YW1sDQoNCg==
