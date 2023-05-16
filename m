Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAA6704778
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 10:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjEPIMB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 04:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjEPIL6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 04:11:58 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B5C132;
        Tue, 16 May 2023 01:11:53 -0700 (PDT)
X-UUID: ca2f4376f3be11ed9cb5633481061a41-20230516
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ZirTPjBKlSA/of3NCQvHZ3XoEDKYuPQwPpAIZX3zZkY=;
        b=qpGMw4LgqHQPDWGMNJyOU59GNZjRfnfOJEUhDlBkIpi7+P/xPQASGb5hbnluVaL4ho19rd5v7osrLVUQe25clSCtiK/CacxXBy7sNXtf2a87HW+Nw9MIZ698tb9Jf7VddjX44v4CNzvj6fK/irtb2S8M/VG2ymH9zvfmIIH9O+4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:607a013b-71e0-4a98-8e9a-4c3325156b72,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:00fb513b-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: ca2f4376f3be11ed9cb5633481061a41-20230516
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 766356573; Tue, 16 May 2023 15:53:47 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 16 May 2023 15:53:46 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 16 May 2023 15:53:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNYYa41xXVPNBmQlmU21NIedtf1wLM2+/hPng+Qb5SeerA3l4QgnFZlGMXxvbMeDcJata/6AQFiPH979Me/xi0F1G3ae0Xs4KAWl8umspjG1y18o6nQNlKMXFWSc3pBs0y/odxMxBaQsf2zABSLHu/d85RJzfAOjzJ+KpSiruK+T9ptqLjO8O6D1MI3M9kRwoaLEYd20bF9oAKNFkOER2hpsw5iok5ULEFtmXvgPrnY6LWK+fWIjHVC+CFe5I/+fGI4PuTHK3KrnwasiIdi2eNGWkjwqgnb0qZgpZUE2n7BITqVT1ThWghpSYN3X1hbCudxbc6NlJjeAJfGgahnf/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZirTPjBKlSA/of3NCQvHZ3XoEDKYuPQwPpAIZX3zZkY=;
 b=LQNn3hJeq+wDFX8IyZy2k8Nq/X31lvNZ7uK35qcRCYJ+CfqfkRYyL/h1hz5IBX6MCL11L1a61cBPdyhsv/Bq1u+p74hhO25YQfXNGl97CdyoD5moC4htrMiN1JOCH4U0mBbOVAbkxY7/SxjSUXfYTNatip3ViuzHQEcrFuQlV3tCDreK3cHDgU2J4+d7dThXaDRhoB663wDP5klNDKnzefSS/jnNwwpMZD4xbZTSeOF9lQXoxvcRyUogbZJzvnfbU6pU9aYrKiYANKDPUkBsxKNklFqiCl484X/qfSj1ALbJNmXhgAzbQDBnaXT5xuN1mXWVAlvUkDzPCiTclG9HXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZirTPjBKlSA/of3NCQvHZ3XoEDKYuPQwPpAIZX3zZkY=;
 b=AcPHuRuP1z9u9ziLA/vZT0f/984o4gaIvXD8MtRDNr6QLqXYs8N1p+dULIzpN1mjqXzugP1WJ47DJOVHfQRjqtpb8/NZ5gV0V1sPVprucqtnwXmdAw/y9Nyp9vmLTIvENfQksniARmUc3k+lw2ld0RRuM2hZrIIzCM352J98irY=
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com (2603:1096:4:14f::8) by
 TYZPR03MB7274.apcprd03.prod.outlook.com (2603:1096:400:1f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Tue, 16 May
 2023 07:53:03 +0000
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b]) by SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b%9]) with mapi id 15.20.6387.032; Tue, 16 May 2023
 07:53:03 +0000
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
        =?utf-8?B?WWlwZWkgQ2hhbmcgKOW8teS8iuS9qSk=?= 
        <ds_yipei.chang@mediatek.com>,
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
Thread-Index: AQHZeb1bFKX9i17opkyHBcS8vDfEJq9ApaIAgBv9xAA=
Date:   Tue, 16 May 2023 07:53:03 +0000
Message-ID: <7646e9e8075e0bc6543ce3e8f7b4d789bb947155.camel@mediatek.com>
References: <20230428103622.18291-1-yi-de.wu@mediatek.com>
         <00e293fc-e5f7-d451-5547-def284ac2214@linaro.org>
In-Reply-To: <00e293fc-e5f7-d451-5547-def284ac2214@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6167:EE_|TYZPR03MB7274:EE_
x-ms-office365-filtering-correlation-id: 2219a877-d574-46d1-e466-08db55e293d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gojozAzcQIULSkcZUU9fGaNKYx9WJ3NKk6bkrElKQz9vatTVtWJR49Ty4UccC8A0Q2o7m06uVQokdA276Kv1y02g9glczJgfNwkfffMLrw4jfYZK8ANT+CjC5HrUVgRkRxJrf43G9tUrBZEMxqejzlODQxO7KcZRsbZJYZwMm5ps2bf6KXnQY58TFxh69ZDLpLMfQtsLTIMI/gRdpD8H89dGfxOXCS9DoJmCvhBmWFizcg/dRKkay13yVb0xTbiIjd/OWD2BQqrm8lfBsXRDQAGRthTtpecSpaDqrX+mB9IoIbpMaa+N/Z4AELhXOOC7SpXVyXrR3pjL8OnEFacjkGP8cReNjHoFCpHuuK3etKDZ3UETCafd90F8kErt0KMcbnW6het4moK1pMbKgQa+GZbS9h2uISQnrIVSbzZ4ThbD+WTLms9NMc0c2es0Gk4zuOfODnLadgGahX0gBZ+GsMyrNpT79X92tv5mrMlVvpPk+8Q8Jg2zB6eukULcOsJGqjmEsf06PvgqeRaCP8MQmuAB7I/DdWFtBCpjQyQtNxZgkerb03YaAAY8Lry107qXAf1iC4tszxJIvL7I2XLh1L+q1Q6Zxr/lqhC9zCcFkFrGrj/7WiwmXowi04yedtZjnQBEn8ewG5MdnthkWdUjfVrkGlAXxVSRNkTfbC/x3Z3yHx6H6mt8dm4gjKz5SpDr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6167.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199021)(38070700005)(71200400001)(8676002)(7416002)(38100700002)(8936002)(41300700001)(5660300002)(36756003)(122000001)(921005)(107886003)(4326008)(85182001)(2616005)(86362001)(110136005)(83380400001)(478600001)(316002)(53546011)(91956017)(6486002)(66556008)(4744005)(66946007)(76116006)(64756008)(26005)(66476007)(66446008)(2906002)(54906003)(186003)(6512007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WENpY1pBdFFHb1RmUjVwWjc1ekhIbXVyUm5LVGUyZnU3MVlOWjZxTXVYSDRx?=
 =?utf-8?B?eVlHS1dVTkI5WktMZkRnSWd2NEJFWllsRDlGRlhRcUROdU1WbHZXYlk3Q2l3?=
 =?utf-8?B?d1FsY1RzWDkvU1lKdTdsQTNSbmpyVzI4SVViVjlzRzNHVWJRWXZ2c2Y3SlFm?=
 =?utf-8?B?MDlGRmJpeGdTMHlrV1pCVEdxV1VmN0ZvZWhQMDE2QUF2V25xY2RQbUJEYlRQ?=
 =?utf-8?B?Uzk4RWs1WXVIeTE5ODdjeENjL291S0k1SUpCV2U0a1k3emFjSzd6Z0xScFMz?=
 =?utf-8?B?SGdyT1FzSzNXOGs4UUJxcmxBbGQzZVVaN0VJRTA5Q2NYWDdTYmR2R0hnRCsx?=
 =?utf-8?B?eS9DQU82YTBlS2xaVk8wUWdOR285R0c1YjBqb1Z1N2c5UmwyOGFBK1JJMUJt?=
 =?utf-8?B?SUVINkIxVXBoSXB5aEcrdHNPS0VoclBPU0poMkNDRzNRbGhraG04Mkhxczk0?=
 =?utf-8?B?ajMrK3hna01zbVlyUnBUSTNFdGR4dkl5Q0hjdGJNUkRMQUNlV1BCZm0wZnZO?=
 =?utf-8?B?RXI4bFQyeCtDdVVtYmFxdTQ1WUFvY2QxYW9ONlZwb25paDZ6THYyN0JUV0JE?=
 =?utf-8?B?bWV1b29kSmZSUTEyTGxybFQva1lvUTI0dk5UL2NUYzViM3ZTK0FDQXl1dTdU?=
 =?utf-8?B?am9waTFJSERGQ1BkeC9kbU1IRk9VT1hYem1QcUVVditkMGxpQjFkaTFmeXU3?=
 =?utf-8?B?YjJoVURONGw0Q3JCQ1NmT0E3Wmw4bGwyYnpSRUs1Sjc0YmxXUU83K3l0bnk0?=
 =?utf-8?B?YURuQ1RRUzB3VzBiUmtyeFJwR1RweGRna0p4T2RveHpRR0FkdFZrekpkRU9m?=
 =?utf-8?B?VHAwWDMveVBRWmVsSmJ5QXJTZnBkcnkxRENWV2pIc1pLNmRWejZ3Sy91K0xl?=
 =?utf-8?B?NXg4c3FzRlAvWmdLbnpTUFRGajcyR25iTGNRS2JPd3BMR0d2dHE3bi9YTERy?=
 =?utf-8?B?eUxyNWd3NHNrWXNCL2tOamJZUFNUUGM3Q0lPVzZnblYxQkZVZndGSitjWHFZ?=
 =?utf-8?B?MXpHbmtWYmJLR0pJWU9GNzZTVC9DU2hpdG5yOExheXpyM1lXbjAzWmpYZUxr?=
 =?utf-8?B?Y2wvckRNM2MyYXg2aFpQY3FjcFA4MXp2ODlnWkRESGFFY2lMdzBZV0pMeHhm?=
 =?utf-8?B?SU8rOFVRMGo0bVJ0QXFVemhSU1k4TG5TdzBGODY2SS94b3Z3UUFDRFR0VjVK?=
 =?utf-8?B?SStPZ0hVWEpES253T20ybzN4R1h4T1JQb1IrTlJOU3FGOWMxcnVZeld0Q3Ju?=
 =?utf-8?B?S1F4eXFIZUdQQ0lRaTNUY0xYL0F6MFF5QkhQdTVReTBYb1g4d0JWaHQ5SmRk?=
 =?utf-8?B?OGJGOElWS0NnWjdUMUg3NlB0OEh3NUJxdTJPVzdzYVA1R1RESk9YSFdqMGtn?=
 =?utf-8?B?WStxa0ZBNUllZ0lYV2ljU2dDazY5WVdaUW5MZjA4Tm9BSkQ3SU1XeW1jcFU2?=
 =?utf-8?B?bzMyTnQ2b29Mb2FNdVJxWitOYkhDaW1WV25jYnBTT1RLOEpNSmRaUEZKM3Iz?=
 =?utf-8?B?MVJlZUtTaHVhb2xnUE1LOXdmcndGdU9VT3RHbDFZRmFQSXNVbFhpS2hqdXZT?=
 =?utf-8?B?dy9wM1BBQlU4NzROdHAwK1RjMnR6STIrZ0VWcmlmRlhmT0JFdko0OXBhUUdQ?=
 =?utf-8?B?eHJaWjF2bGxrME5JWHYvdm8yZEg1MmYzMHZVMmhZcWF5VFhSUmRYZFI1SGhr?=
 =?utf-8?B?RncxSFBiRCt0MUZpZmlsZytGa0FvM3lxbWpKcExydWVic29vT0t3bG1KZ2Nm?=
 =?utf-8?B?RTJRSlJ6UjN6MVlCYkh3VDdmYUdQYkk3bERGUnZuUnU1LzhkYU9KbjBnaXRS?=
 =?utf-8?B?QmpqN1R1SzF3VW91SnpxSks2TWtMTkRUMVVRbWZ5L3BqVUladGZCczFOK0tI?=
 =?utf-8?B?Q2krWUh6U1hIQktUU3pYdDFraitkbHBQQ0VzekpXUWJjT0tVQXVwRVBEUWFR?=
 =?utf-8?B?cjVLWVgxWXR5UGRBeG96c3VmN2NQVDNaV0ErNXY5L3hDMXlickNPenFMNEl1?=
 =?utf-8?B?T1hOZXBueEE0Rys4cmw5WlBDcDZzSVNXK2Npby9tTUdiTGhpL0xYVEdUd0tT?=
 =?utf-8?B?RnZWQ1EyR3VKUjVMSTl2bWdGekg0WmRlaWRsaEJ6MGxQdEhpNlBTVFJib1RO?=
 =?utf-8?B?NmhIMm01NXJpaE9KZFVjclpGWkpDaVlaZERPaWFvSEVBanB5MjhVTVlVNjUx?=
 =?utf-8?B?NEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BD3C6A41DE9E348A228BF84ACDE899C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6167.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2219a877-d574-46d1-e466-08db55e293d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 07:53:03.3871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AZ8nAQLJAjyuDdBVrju6YvVi4OEuRnRf3vSOxyeeuvl0ByHyIxUunyMeqCdmhULiM8rgDLsQh+wrhuVuiFRLag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7274
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTA0LTI4IGF0IDE0OjI1ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDI4LzA0LzIwMjMgMTI6MzYsIFlpLURlIFd1IHdyb3Rl
Og0KPiA+IFRoaXMgc2VyaWVzIGlzIGJhc2VkIG9uIGxpbnV4LW5leHQsIHRhZzogbmV4dC0yMDIz
MDQyNy4NCj4gPiANCj4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+IC0gUmVmYWN0b3I6IG1vdmUgdG8g
ZHJpdmVycy92aXJ0L2dlbmllem9uZQ0KPiA+IC0gUmVmYWN0b3I6IGRlY291cGxlIGFyY2gtZGVw
ZW5kZW50IGFuZCBhcmNoLWluZGVwZW5kZW50DQo+ID4gLSBDaGVjayBwZW5kaW5nIHNpZ25hbCBi
ZWZvcmUgZW50ZXJpbmcgZ3Vlc3QgY29udGV4dA0KPiA+IC0gRml4IHJldmlld2VyJ3MgY29tbWVu
dHMNCj4gPiANCj4gDQo+IFBsZWFzZSBleHBsYWluIHdoYXQgaXMgR2VuaWV6b25lLCB3aGVyZSB3
ZSBjYW4gZmluZCBpdCwgd2hhdCdzIHRoZQ0KPiBwbGFuDQo+IGZvciBvcGVuLXNvdXJjaW5nIGl0
IGV0Yy4NCj4gDQo+IFRoYXQncyB3aGF0IGNvdmVyIGxldHRlciBpcyBmb3IuDQo+IA0KPiBCZXN0
IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiANClRoZSBpbnRyb2R1dGlvbiBvZiBHZW5pZVpvbmUg
aW4gY292ZXIgbGV0dGVyIGluIHYxIHdhcyBtaXNzaW5nIGluIHYyLg0KV2UndmUgYnJvdWdodCBp
dCBiYWNrIGluIHYzLCBhbmQgd291bGQga2VlcCBpdCB1cGRhdGVkIGluIHRoZSBmdXR1cmUuDQo=
