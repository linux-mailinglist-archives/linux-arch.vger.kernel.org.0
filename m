Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A610700260
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 10:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239941AbjELIRL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 May 2023 04:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239984AbjELIRK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 04:17:10 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7E4E5B;
        Fri, 12 May 2023 01:17:08 -0700 (PDT)
X-UUID: 5f86074af09d11edb20a276fd37b9834-20230512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=tYgcHGc4OGOXkuGsch3uC5OgihZDAUbASEDRkoIdSKk=;
        b=bbS0jBGJrw+7QmSBcnlZoeXzZX0EGP7TQJNfRbOyyo/UNDSmMtcg0vvGe8SUKPr+OyLuzP1B/YM8gISQwkSnCqDaREC6H2+IAZbUcl9KanpvrIpEROY/FJk3k/SN5hEBENKpi9gaTDiBz5vCT+VKW3gFnu6NJbIRcy6fgMC1HpA=;
X-CID-CACHE: Type:Local,Time:202305121519+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:14f08e5f-7ec9-4f6a-adab-880d1d3710a1,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:178d4d4,CLOUDID:276c986b-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 5f86074af09d11edb20a276fd37b9834-20230512
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 343111148; Fri, 12 May 2023 16:17:02 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 May 2023 16:17:00 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 May 2023 16:17:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8OoBPKPtKdKSh5q1sqMZiTNrhvCM8p7/A8wUoE6aH7HhfLrh6Lk/IKH1TdwTKhXuOab7wygJM5PlAAp2rcxwBw40tiObtKL7p7zQfH0ATwBsQST7JlcLM/9V97fcRtL6ec/9YoLPq9dnGBKkCLhdXAloVTW0BkU/q5MiQ1qIyXAQYMv6vkQ7Bu1qHHuwg6EWbte6iBR7EGsYikgMhXmF0Ntr/cVX0n/Lf8aqZh/yTHjwl+UJ2TbTynqFz1CZvRdU5skGP12AGiw8R9ZYAdi1kYxzuiGNUdHbh6wLeuEYShWCYuPI+Z3soHJIq2xcTA9Tl6g2z6oDD4O2hOQKO8Hsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYgcHGc4OGOXkuGsch3uC5OgihZDAUbASEDRkoIdSKk=;
 b=lqZzU+z0t5vEYogP9yO+dESRqCUyhOKWq0Cfqdgl4KTTtIOxetWda0OAKFYNZ0P2apHHJwn/erbWtk/unWKhgixlizljyeBiOaxXTzClO1zILsYLzHHNPJ84XuouxpcG4/QiVDA1CTCaeEyZgS+96c6XDsIIEWuGkBNKltujrcQLJup5AGCCF24JOnvVbuaD6ywAlAXXYgQNMmcpI1lv38RVC5ABMiZF7AyMZsSrz5yFVTe2TcA5cJlW7Q4TT8UGs+ignUUqd/zyF+RQCudLETSKhJqasSb7u4x55EUEcOMPMdrQjSlC/LojbcrGkw9m7cAAYn53cvpWX8vBDrpzWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYgcHGc4OGOXkuGsch3uC5OgihZDAUbASEDRkoIdSKk=;
 b=ZRNeKMPuHMZJPDsZ4rgktM04JjxDJbr65Vu0E+razZcEiZjFDc7ONkj7VcGT5/u0nbqxBciDyT7uuE7SCXKr8sK/2bD842x/RNjQJNEl8O91C82Dhz2nB2YtQo+W7KYNPeOmGYHb84pYceONVTKOvkNF6CByh1JtsbAL+7bO7bY=
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com (2603:1096:4:14f::8) by
 KL1PR03MB5777.apcprd03.prod.outlook.com (2603:1096:820:64::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.23; Fri, 12 May 2023 08:16:58 +0000
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b]) by SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b%9]) with mapi id 15.20.6387.023; Fri, 12 May 2023
 08:16:58 +0000
From:   =?utf-8?B?WWktRGUgV3UgKOWQs+S4gOW+tyk=?= <Yi-De.Wu@mediatek.com>
To:     "maz@kernel.org" <maz@kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?TVkgQ2h1YW5nICjojormmI7ouo0p?= <MY.Chuang@mediatek.com>,
        "quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SXZhbiBUc2VuZyAo5pu+5b+X6LuSKQ==?= 
        <ivan.tseng@mediatek.com>,
        =?utf-8?B?WmUteXUgV2FuZyAo546L5r6k5a6HKQ==?= 
        <Ze-yu.Wang@mediatek.com>,
        =?utf-8?B?UGVpTHVuIFN1ZWkgKOmai+WfueWAqyk=?= 
        <PeiLun.Suei@mediatek.com>,
        =?utf-8?B?TGlqdS1jbHIgQ2hlbiAo6Zmz6bqX5aaCKQ==?= 
        <Liju-clr.Chen@mediatek.com>,
        =?utf-8?B?SmFkZXMgU2hpaCAo5pa95ZCR546oKQ==?= 
        <jades.shih@mediatek.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "dbrazdil@google.com" <dbrazdil@google.com>,
        =?utf-8?B?U2hhd24gSHNpYW8gKOiVreW/l+elpSk=?= 
        <shawn.hsiao@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <Miles.Chen@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?WWluZ3NoaXVhbiBQYW4gKOa9mOepjui7kik=?= 
        <Yingshiuan.Pan@mediatek.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v2 5/7] virt: geniezone: Add irqchip support for virtual
 interrupt injection
Thread-Topic: [PATCH v2 5/7] virt: geniezone: Add irqchip support for virtual
 interrupt injection
Thread-Index: AQHZeb1n+Te8Qxm6rku5UO/fybejz69BE5YAgBU9HgCAAAjUAIAABzgA
Date:   Fri, 12 May 2023 08:16:58 +0000
Message-ID: <fa864743c550ecd0a0c8052bfe7fddcc3f9be15c.camel@mediatek.com>
References: <20230428103622.18291-1-yi-de.wu@mediatek.com>
         <20230428103622.18291-6-yi-de.wu@mediatek.com>
         <f1c8c1c1c091be87dfbc27b9178fc3e6@kernel.org>
         <762e3494ed468f0337b1c336615065b154396d23.camel@mediatek.com>
         <86wn1em1hx.wl-maz@kernel.org>
In-Reply-To: <86wn1em1hx.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6167:EE_|KL1PR03MB5777:EE_
x-ms-office365-filtering-correlation-id: ae5deb86-c205-438b-0090-08db52c141bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /m/JIuh/ivkKvYXeApeCLhHCIjJbnRli0YHBMnOxqwcE93TQF3gY/4R4fKzm1yCdMt3jys4PToxK0Vy9at+VBP4d4CDdhwCvpgBSxrm5heu8fXj2bXcNxND6jGTjijyoorePlJ3ywI3sxX2cfw7EAt/KjyPvMquujNYWpXHyxiFj1EjSOJT7tDgH1p0gLN/rQgkRHbAfRSlYLH+3QelTvzcpMfj9nvoglOVzUMf83RlJDMLaZzqt5L5ffv/mTIpsXK+hdV+w2/pCEWf5w0cHh001vxcfQZqU9njcxk/159CDigd5kdgfInwlMdj1fNgZDbenMpVOucJYqtBvleBsN0rbNdqqmsXnsRxGh8JA4xymjY6OXgIdPfcdvvNk7CbwoGAhn0lERF1xzs64lSCmARzKP/dKqS0Erv26dh/HXGBreF0dL6S163K5CGjSs52wIkgp4LMCBucvRo4jBXrdn7maUN6SvnHndLL7TKUBvAU5rizcpvu5iRe4cqfw/dJtkENMusD4+e0xRZ1Sr/oEwrMqYoQlwfv+JBfomtS0NjojUoMjDo7zGhceXPY3BsvxgwVZZsLILlBYXkPNbgENdcnjEM0K+NPzpzQ8EEl2exn4nYgPBb0cIsSE46GvoGrRRTCPXbVRB/U2INDZ3ZN5WCrQioh3b+oMjb66mog0Auw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6167.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(4326008)(76116006)(66946007)(66476007)(64756008)(6916009)(66556008)(66446008)(6486002)(478600001)(54906003)(316002)(85182001)(36756003)(86362001)(83380400001)(2616005)(26005)(186003)(6512007)(6506007)(53546011)(71200400001)(8676002)(8936002)(5660300002)(7416002)(2906002)(41300700001)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1g2dk5rYWF3ak14bm9iVHQzdTEyM3hXQVI1YWZITHlvVm9ydnlNdmlzalhw?=
 =?utf-8?B?VldTcGhFTHJBdHlIUTVsWHBjZURqY3ZzSVFRZjllZFdQeTJzSitGcEtYNi9K?=
 =?utf-8?B?M1dYMjIvWC9kMFYyd2JEc3R1Q0o3M2lDRzM0WEJJVXQzK3RydzE4aDFZZmdh?=
 =?utf-8?B?eVZ2Y05PTzJkLzhSdUZ0ZFRpaEJQajlJVm94QmY1VnFnNnlOek1xOHFESmo4?=
 =?utf-8?B?K1E1WmxCMTlRQ2tzbmNXVmx0MjBtSldIZEdiaGZyS3NXT0NSWmNHdStTMjlU?=
 =?utf-8?B?SUd6aVdKQTUzeFp5bDBUWXEwZGNqc3UyT20zL3NhNklyMHRiWXllNEJCcTRy?=
 =?utf-8?B?RkVDZSs0MGhOOTRkbjFQZzRxRDJVNk4yc01CMzljMm13OHRKVm5FSzNmbVpW?=
 =?utf-8?B?dXErOG9sMGgvNmF1bGpteVJ2TzVNdUdwWEV2NlNwMXFNNlRUbUpQVXFxUlph?=
 =?utf-8?B?Y1hueE9QU0dDZzlqMFBnckNWd1dVMDh2cG5uR1hMR0hHcnE3UEpOaGRuNGF4?=
 =?utf-8?B?RTJldTUrOTFqV3JZVWVPV0YvZFdXMDZWTmt4a2xrS0k1NU5nTk5uYzAwQ1JK?=
 =?utf-8?B?Z1YxaHQ5TUVlNldxQ0lLTlM1NjVodk1CWC81UE5OMSs4ZFY1NjhrMHlwRmJo?=
 =?utf-8?B?UDM0d0IzRGg0LzRsWld4bmx6RXl1bmRvZW9nQjFVNFdrZWc2REw5bWljOUVL?=
 =?utf-8?B?cFlKaStoRld6S1lZUHRJT0FJYTJWZHlNd1ZkRWNGK0paaVluTDZqcWt4WERq?=
 =?utf-8?B?VytYcWJOcGdsWHNGT3hWVmVFd3cyaG9pU0wrS2lJZENVS3dNVWhqdGFucUcv?=
 =?utf-8?B?b041MFBla3RBb3hReWxwZktBbWZLOEZMTklFNjFPcEQ5M1I3bFFyZ3dXZEc4?=
 =?utf-8?B?ekRQWU9Gd1Vnc3l1TjNWaTFLQXM5T0V6bDJPL3VGNFNvajZkc3o2L3RuSVZV?=
 =?utf-8?B?SXhCUDdKM3NOUjRzWG95eENRSjA1UlJjdGRkZU9ZbTJNQVkxdStUR3A5ZXly?=
 =?utf-8?B?ZFRoZVdpUDhVbzhUbkxNdmhzdWxkRzlmdTg0djVUcFJuYlN4Q1FReXVsM3or?=
 =?utf-8?B?NnBxNVFEb2p3TEdJK2R4aUs0ZE92Q2pxWWp5cXNEd2djbkljNTVmS3NDdStT?=
 =?utf-8?B?ZFJLalRkS3dwT2hONTZ0MUJmNVlkZDNOdWMraXRoNUpTOTRvL2YvbmdhVEtP?=
 =?utf-8?B?MTJvVUM5L2tDVkVsQ3NQZnNaSVJ3MWJFWmNyMkVwUnJQSW5jUklnRm1JYjFE?=
 =?utf-8?B?ZHFJK0piSWErS0t4N3REcExONUFJdys1aFNiVk4vWVNnbVowREhsVExBVjlt?=
 =?utf-8?B?QWhvUFp2TkRleE9xalVoL0psbVdadm0yWmoxK1VHVXpYeDZxYnd2UFZtelpD?=
 =?utf-8?B?eDFWVlFxNjlYbmswemxlVEc3WFJReEIvQWFJeUhIakpYVUwrQzlaajB5cGZx?=
 =?utf-8?B?eEx2MkZXQ01BK1RHLzZkcncrdzA4d0svSnRNR3lPVUNURnN4QW40L3ZVdG1F?=
 =?utf-8?B?VVYzMDlkSVdBSDNXTjdIcHV4bXBDL3F5aUpHL2lWOU00RWthOGphMS9yYTJh?=
 =?utf-8?B?bEpGOXBTWlozdk94Si81M0ZzSjE2cGk4bzlBbnVLZWVSdkw2QWZweDRUR0Vy?=
 =?utf-8?B?Q2QzaGpEa0kvSHlPU1FQbDdyVGhCSzVKc3JNYkFaT2NNR2NTUzlmMzZ0V2Qw?=
 =?utf-8?B?SzBYVDZoMlJGSldYVlQzSExPYmY4amlhT1FSdnZlQUNoekxFMUJiSDh2ek90?=
 =?utf-8?B?UnppSXdCbU15TzBiUmw5YVAzbXlST0QySFJhRnZCVUovMUV5SDhtRW1vdmQ3?=
 =?utf-8?B?Uis2VGNNTzU2MG1pYk1vNGlXZFNRTzBaWlVsRG5la2ZLT2ZCZ3Q2eW9DempJ?=
 =?utf-8?B?RGFPSzMwM2NnbXg0d1VPQmtzQnRIdUtNNHlKdUNVblVHWmw5ZXRoZjRxRTk2?=
 =?utf-8?B?QkJiRjUxOGFBQ1RicWZ4ZnhEcmV3RXFQZ2ptNzJtc3d3LzF6YytWRTRVdUs4?=
 =?utf-8?B?Y1BBeDE1NkY2VFNReDBRSGJ4VmtHOHg0SzJnU0w4bHVBQlNSTnFheVlnUVlp?=
 =?utf-8?B?aUxNcnFENWVuUXV2SUJNVGY5SmJHSWxuYjJhZEVNc09IZkgvdFZVbTQxT0ZB?=
 =?utf-8?B?Ym83VnVFWFRzSWgvdm9tVmhSRnFJK1dDVVN3Z3JackpadnZWak15cEtyVlBP?=
 =?utf-8?B?UVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DF57443D72AAC478E06F7DBF550EDE9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6167.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5deb86-c205-438b-0090-08db52c141bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 08:16:58.7821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tgkzs7W4IISHpWYYAYYlBkReAO+OJ3XI2rw8a1xgTxJ4zU86vgFfFQJsQR9WRLU6vbhz2l8wK3LRvA91F9wBAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5777
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTA1LTEyIGF0IDA4OjUxICswMTAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuDQo+IA0KPiANCj4gT24gRnJpLCAxMiBNYXkgMjAyMyAwODoxOTozMSArMDEwMCwNCj4gIllp
LURlIFd1ICjlkLPkuIDlvrcpIiA8WWktRGUuV3VAbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPiAN
Cj4gPiBPbiBGcmksIDIwMjMtMDQtMjggYXQgMTk6NTkgKzAxMDAsIE1hcmMgWnluZ2llciB3cm90
ZToNCj4gPiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzDQo+ID4gPiB1bnRpbA0KPiA+ID4geW91IGhhdmUgdmVyaWZpZWQgdGhl
IHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBPbiAyMDIzLTA0
LTI4IDExOjM2LCBZaS1EZSBXdSB3cm90ZToNCj4gPiA+ID4gRnJvbTogIllpbmdzaGl1YW4gUGFu
IiA8eWluZ3NoaXVhbi5wYW5AbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiANCj4gPiA+ID4gRW5hYmxl
IEdlbmllWm9uZSB0byBoYW5kbGUgdmlydHVhbCBpbnRlcnJ1cHQgaW5qZWN0aW9uIHJlcXVlc3Qu
DQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZaW5nc2hpdWFuIFBhbiA8eWluZ3No
aXVhbi5wYW5AbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZaS1EZSBXdSA8
eWktZGUud3VAbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGFyY2gvYXJtNjQv
Z2VuaWV6b25lL01ha2VmaWxlICAgICAgIHwgIDIgKy0NCj4gPiA+ID4gIGFyY2gvYXJtNjQvZ2Vu
aWV6b25lL2d6dm1fYXJjaC5jICAgIHwgMjQgKysrKysrLS0NCj4gPiA+ID4gIGFyY2gvYXJtNjQv
Z2VuaWV6b25lL2d6dm1fYXJjaC5oICAgIHwgMTEgKysrKw0KPiA+ID4gPiAgYXJjaC9hcm02NC9n
ZW5pZXpvbmUvZ3p2bV9pcnFjaGlwLmMgfCA4OA0KPiA+ID4gPiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiA+ID4gPiAgZHJpdmVycy92aXJ0L2dlbmllem9uZS9nenZtX3ZtLmMgICAg
fCA3NQ0KPiA+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gIGluY2x1ZGUv
bGludXgvZ3p2bV9kcnYuaCAgICAgICAgICAgIHwgIDQgKysNCj4gPiA+ID4gIGluY2x1ZGUvdWFw
aS9saW51eC9nenZtLmggICAgICAgICAgIHwgMzggKysrKysrKysrKysrLQ0KPiA+ID4gPiAgNyBm
aWxlcyBjaGFuZ2VkLCAyMzUgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gPiA+ID4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2dlbmllem9uZS9nenZtX2lycWNoaXAuYw0K
PiA+ID4gDQo+ID4gPiBbLi4uXQ0KPiA+ID4gDQo+ID4gPiA+ICsrKyBiL2FyY2gvYXJtNjQvZ2Vu
aWV6b25lL2d6dm1faXJxY2hpcC5jDQo+ID4gPiA+IEBAIC0wLDAgKzEsODggQEANCj4gPiA+ID4g
Ky8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4gPiA+ICsvKg0KPiA+ID4g
PiArICogQ29weXJpZ2h0IChjKSAyMDIzIE1lZGlhVGVrIEluYy4NCj4gPiA+ID4gKyAqLw0KPiA+
ID4gPiArDQo+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgvaXJxY2hpcC9hcm0tZ2ljLXYzLmg+DQo+
ID4gPiA+ICsjaW5jbHVkZSA8a3ZtL2FybV92Z2ljLmg+DQo+ID4gPiANCj4gPiA+IE5BSy4NCj4g
PiA+IA0KPiA+ID4gVGhlcmUgaXMgbm8gd2F5IHlvdSBjYW4gcmVseSBvbiBhbnl0aGluZyBmcm9t
IEtWTSBpbg0KPiA+ID4geW91ciBvd24gaHlwZXJ2aXNvciBjb2RlLg0KPiA+ID4gDQo+ID4gDQo+
ID4gU2FtZSB3aXRoIHByZXZpb3VzIGRpc2N1c3Npb24sIHdlJ2QgbGlrZSB0byBjb3B5IG9yIHJl
bmFtZSB0aGUNCj4gPiByZWxhdGVkDQo+ID4gcGFydCBmcm9tIEtWTSBhbmQga2VlcCB0aGUgbWFp
bnRhaW5hbmNlIGF0IG91ciBvd24gaWYgaXQncyBvay4NCj4gDQo+IFdoeSBkbyB5b3UgbmVlZCAq
QU5ZKiBvZiB0aGUgS1ZNIHN0dWZmPyBQbGVhc2UgZnVsbHkgZW51bWVyYXRlIHRoZXNlDQo+IGRl
cGVuZGVuY2llcyBhbmQgd2h5IHlvdSBoYXZlIHRoZW0uDQo+IA0KPiBEaXJlY3RseSB1c2luZyBL
Vk0gc3R1ZmYgZm9yIHNvbWV0aGluZyBjb21wbGV0ZWx5IHVucmVsYXRlZCBpcyBub3QNCj4gT0ss
DQo+IGFuZCB3aWxsIG5ldmVyIGJlLg0KPiANCj4gICAgICAgICBNLg0KPiANCj4gLS0NCj4gV2l0
aG91dCBkZXZpYXRpb24gZnJvbSB0aGUgbm9ybSwgcHJvZ3Jlc3MgaXMgbm90IHBvc3NpYmxlLg0K
DQpUaGUgcGFydGljdWxhciBwYXJ0IHdlJ2QgbGlrZSB0byBsZXZlcmFnZSBmcm9tIEtWTSBhcmUg
YXMgZm9sbG93ZWQNCjEuIGBnZm5fdG9fcGZuX21lbXNsb3RgIHRvIGNvbnZlcnQgZ3Vlc3QgcGh5
c2ljYWwgYWRkcmVzcyhvcg0KaW50ZXJtZWRpYXRlIHBoeXNpY2FsIGFkZHJlc3MpIHRvIHBoeXNp
Y2FsIGFkZHJlc3MNCjIuIGdldCBBUk0ncyBudW1iZXIgb2YgaW50ZXJydXB0IG9mIGRpZmZlcmVu
dCB0eXBlcyBlLmcuIG51bWJlciBvZiBTR0ksDQpudW1iZXIgb2YgUFBJLi4uZXRjDQoNCg==
