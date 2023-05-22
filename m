Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A89770B45B
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 07:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjEVFKM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 01:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjEVFKC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 01:10:02 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6350C10EA;
        Sun, 21 May 2023 22:09:29 -0700 (PDT)
X-UUID: bba9c5c0f85e11ed9cb5633481061a41-20230522
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Ta3dzAmiZpLGt4rJa2q9LK/E3XSQLq48gJBSZHobEQI=;
        b=uAfXlB3tTK7HhriwUJZgIyDu0toOz7rnKV4CbOsipUNbN54/ZB4uxsMsv/u+9Z8ChrLczz4jOehrNrqN7qxRiuIxfK33Pq26ulkCX0rFz4BwKQSCx+Wp7KGkSceq76BlhHWy2lMVrmgyvZGquQbcC4LuJkBJyZCimop+M6pJj4w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:393a20f4-0a7a-4f32-bc61-68cf5d2d01b7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.25,REQID:393a20f4-0a7a-4f32-bc61-68cf5d2d01b7,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:d5b0ae3,CLOUDID:12d297c1-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:230522112902IMI6PLM6,BulkQuantity:12,Recheck:0,SF:17|19|102,TC:nil,C
        ontent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,O
        SA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: bba9c5c0f85e11ed9cb5633481061a41-20230522
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 647831871; Mon, 22 May 2023 13:08:47 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with ShadowRedundancy id
 15.2.1118.7; Mon, 22 May 2023 05:08:46 +0000
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 22 May 2023 11:29:00 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 22 May 2023 11:29:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcTFNI/jNLTXo5UBODi6Sx42teF1uSKtPisXxUvNBefzpBzOBgPNQut62g73vDuMSu5rj6Mbi4nYjVNGsLSZPm8TRCrwVW5a7DE9xdn0F79l/D8nHQMvTOmp+1/nRQa60zr2+m9nQcWLD0Zo5+IQWjLv5izdDQM5YvQNrwClzMofa0Hcat5lCcvmAbMW4hfxnUK72gUU3peBF71epXka0Nkp911gQmXJwMLUWNwcOsx4qfWg/H9rNjn8qBK3vtFKasd0t7ZhJORGaQI6gbSUHEJvY2rwD159rGDJmyWnw/3AZ+flspr4ONn7qihowMiN+CTwsAv3RleBsVAVA3YWgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ta3dzAmiZpLGt4rJa2q9LK/E3XSQLq48gJBSZHobEQI=;
 b=KT0aLKxZH3IKw1jKal4gYIw6eztLQAH/wpgpqakztZVRzm09u79gPdkWg4UsobYxfyYeGhEHlm58Dk/FpkZ2l30pDOPr8IT3bKByCa7ZNQ0nL20BAt7tGjubpPhBGaDtdbvajYDZOGjM/0xGEI8sldSKRz9rksZy0RXUnT/AkNQFP4UeDbGc8/16rDsFGCkHUZwISTdldxXa0n5KJP1SWfyTdKhUvqubBe6EAmQv1Ut+/HUQGC+2AbqqaNeUVlIqnKDe8YKnsOsIj0wk8SQUuUj6ExKhiisY3E1uRdUIl7NYRHFxbCqC/g+bo7TxKtLhH8ph6feqah5OP08p5Kvm8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ta3dzAmiZpLGt4rJa2q9LK/E3XSQLq48gJBSZHobEQI=;
 b=MiWhoxHypa9b6nPDPPVsM5dk2qa4/OU1/mm8Q7SBM5aWuSRHGyq3uq6+A37JSTMw8Ik6D8rH07VBM/htwQ5+AKzgqmhq4M6OOBiFSmnfbnDMKNXt4hdQ2y5/82u/4tjBfo3u9C2CqPk66xvnHdIB5C1QEQh5JY7FmyJfE/iWnGE=
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com (2603:1096:4:14f::8) by
 KL1PR03MB6228.apcprd03.prod.outlook.com (2603:1096:820:8e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28; Mon, 22 May 2023 03:28:58 +0000
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b]) by SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b%9]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 03:28:58 +0000
From:   =?utf-8?B?WWktRGUgV3UgKOWQs+S4gOW+tyk=?= <Yi-De.Wu@mediatek.com>
To:     "conor.dooley@microchip.com" <conor.dooley@microchip.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TVkgQ2h1YW5nICjojormmI7ouo0p?= <MY.Chuang@mediatek.com>,
        "quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SXZhbiBUc2VuZyAo5pu+5b+X6LuSKQ==?= 
        <ivan.tseng@mediatek.com>,
        =?utf-8?B?WmUteXUgV2FuZyAo546L5r6k5a6HKQ==?= 
        <Ze-yu.Wang@mediatek.com>,
        "yipei.chang@gmail.com" <yipei.chang@gmail.com>,
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
        "robh@kernel.org" <robh@kernel.org>,
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
Subject: Re: [PATCH v2 2/7] dt-bindings: hypervisor: Add MediaTek GenieZone
 hypervisor
Thread-Topic: [PATCH v2 2/7] dt-bindings: hypervisor: Add MediaTek GenieZone
 hypervisor
Thread-Index: AQHZeb1mU9LdvrjJWkKKQBIpP+78BK9BPBGAgBUKZACAAEg3AIAPOO0A
Date:   Mon, 22 May 2023 03:28:57 +0000
Message-ID: <5256bc0bb0560651a093391287a3cccc828a98ad.camel@mediatek.com>
References: <20230428103622.18291-1-yi-de.wu@mediatek.com>
         <20230428103622.18291-3-yi-de.wu@mediatek.com>
         <20230428212411.GA292303-robh@kernel.org>
         <ec4cae2e6da4a64bc3983ffdde03f51e185d3609.camel@mediatek.com>
         <20230512-marine-kilowatt-44a642124ac7@wendy>
In-Reply-To: <20230512-marine-kilowatt-44a642124ac7@wendy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6167:EE_|KL1PR03MB6228:EE_
x-ms-office365-filtering-correlation-id: 238e779b-d3c6-4066-1647-08db5a74ad55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S8Em603Nd/HHD5MVMmfzOyXBsfDwa8WOlxgTaJ/LUXBuEUFl0qQXdBTp+M5g1RU86+jLqPPBuzXtFvLjLag4ECIKM6zHCjxO3lx8xOVuDcSNQx1P/9Cm1euua7aGgxzxt75kPt6+dJgjGoMOT7qs/+PMQSDajNBr/ZPENFlwu7IzCYF29tkyroB7gP2sdc5cajhGPk8WRVRPoQj0CKJnpAptONUCEXy5EzbPypUdopdCJlcmmslOJQzGmcuRyrl4lF9Sh+0D9yvUVty4TfogPhTA9fxCWvzdXJCnYzqMM416c0rJo+/xbdg0Qu+JzhZYiOh9HXnsZq0J0ttCZkjo2wpM++YLdjnx9+3sSS9o6cmj/ln8/5Otq86kNKuSLCxSg9dlkjQC76ty4sjO+MPG/V8wmlaZtJGjSUCENDM8RMmRRF1BtqTk0N5Z/PzirAg/fuHxcdBhQ6l0MMWxKm6gZo1kUyOUvuBktNIHnxW56VYmpPwq95X2n2NNOJmfDrEVRR2PzhTEdPEcT6YrojNv6q6G+tzMkuhQbRqWnRLRacU/XRPKSDRmsPU+IkxqgqweAW+c7C88+M1pmtiygcCPA4LUQop9awfsr+b9pa3tGunum1DMmDCeCFtOwtcbNflQDGiQ0gGjyJm4OTvhRs3QAbKhx6BMJdSOp8/uQEAocWw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6167.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199021)(8936002)(8676002)(5660300002)(7416002)(83380400001)(186003)(6512007)(6506007)(26005)(2616005)(86362001)(122000001)(38100700002)(38070700005)(41300700001)(71200400001)(6486002)(478600001)(66476007)(6916009)(64756008)(66446008)(66946007)(76116006)(66556008)(91956017)(4326008)(85182001)(316002)(36756003)(54906003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVJuWFlJWkordENPVmVFRzMwY05tK21NOVhRakRtUDdoMmJiZHRuc0VrVlIy?=
 =?utf-8?B?a3UrbDRQYXRuczVreC9rM0pIb1ZRUXRIOHAzUUpwYkQ0d0tMMUtvaFRSY2Ev?=
 =?utf-8?B?M0t3Wmk5MFVWSisyc1IwN1RqSXlsQm9iV3hVVkt2bmFxQ1ZIU05uL1RjSGRm?=
 =?utf-8?B?VzE4bjBLamU3dWtXOWI4azVocGJsTWdKUXlaclJiUzI1VUswbTJiekRxcExQ?=
 =?utf-8?B?bWUrOHgxa002MDl4ZGNmblQvVEJSUGdFZ3NJMFgyVjZFblpDM1BWVjMveUs2?=
 =?utf-8?B?djlySXlTeDRhejBXdWRkeWV0SkRGVFFpaXZsNFN1MTlwTFNQUlRPZ2xhVktu?=
 =?utf-8?B?UXlkVFoxakNYd2VIYlBSSk5RZy9MWXFyOVk2Y3FLcVprNTg1Q1NBaE10dDU5?=
 =?utf-8?B?eVZRc1BXazBIbThiVjIxTGpXNVZjNmdBWEpRT2c5bDR2c29td2lqZVVhUTVP?=
 =?utf-8?B?dzFNc0J0QnBBTk1oYlVFbldwNlpmWFZoOTZvdlB4MDdidnJ0SzJjdXZSa2Mx?=
 =?utf-8?B?NFBKSWthSDFnMElTbEg2UEd3Y2FVd3JNTWtROWZyZzNmejZleG9TOU5jWXd6?=
 =?utf-8?B?OWxwMDVzZm85RjZsQ0IveTVNQ2JQdDU4T2MxbXdja1E3RGhoRk04QWtTZGhO?=
 =?utf-8?B?eVZqcGFqb2U1MUFLdXplbnJHMldtK2pCaGt5cDEvT09FeElFQ1RlWjFnKzdL?=
 =?utf-8?B?cmtES0h5OFdhb2lPOGdyNnQ4M0txMGhuNW5OWFZjQkM3RmZtMHhiUWNOaUxQ?=
 =?utf-8?B?VUUxalZlT2NoejZCdzF3Ui9HQStGVzV1ZWlLVFlid3g0bDArdmZuN3pLNUVK?=
 =?utf-8?B?cGFNSHlOTGdRUjVXZnZROFBGRHJSRTE1ODlrT2hiZ255RTBPc1JFMkpabVBh?=
 =?utf-8?B?YmlOS0d5Qks1MkV4T3JUS3d3alpoMlFHTmtKWlg3T0IrOHVsdGdqMmtHd2pO?=
 =?utf-8?B?aTZZaGs5dXlRYUtpdTl4N0dEVWR5NTBNSCttTy9JbzFqRlorc0hRUFdndE92?=
 =?utf-8?B?NHdzVm9mYjdLVHU4TlRTUWJzbTk3UVJlUDRodHllangzbVJLWVFZREFENms3?=
 =?utf-8?B?THAwRVFldGROL2xxai9YZ2VGWkN4WVNXNU9yRDQyVGhyRUlyaXpnd0hUUHY5?=
 =?utf-8?B?cDFlb2kzbk1CT0lXWklPRlV4Y0V6c2RrSy9xandpT0dncmN6aUZDcXpnMk9O?=
 =?utf-8?B?SzR2U1p2NWRLUzZ3eC9YeFBCSUZQRmYyd1RrVTJNR1ltVXZ6bURzbHNWMVZN?=
 =?utf-8?B?ZHpnQzRDck90dktoR2FNWXpVREY5cXYyU284QWhSbHB6R0Z5cjJlczB3azM2?=
 =?utf-8?B?bUZMTmtsTGEyY1BWOXhrbklJd3RrUlhZYnczOUZtbFRlTmdvQUN1KzVldFRh?=
 =?utf-8?B?aTFHTWk1ZENwMGdKMSt2YWlzbUY3VVVpVDhiN1MwQi9GR2tya2Y4MDBCamUv?=
 =?utf-8?B?aEhxNUZCR3U2cHhwYkM1VTMvVTJSaUprMW9NaU5jZUovV1c5V3NVNTZFWU5r?=
 =?utf-8?B?RDVxWC9hQ0U2T0JZL2dqdE1IRFZFMnJDYjlTdjNhbTM3VGdwaERsYnV2QVVo?=
 =?utf-8?B?T201VlZPS3dkZTJCQU5UV1RxSnZYdkRhclE4MzVpM1Z3cDdUZnV6cWU2Ymx5?=
 =?utf-8?B?dlJpUGZvbnkwUndOQjN5OTRMUUZFN2RsWGlSM0phK2J0ZVVmVjNNd29sS3Zs?=
 =?utf-8?B?eituSmRuZzFEWmduQnE0WW1MVmRMZ2kvNHdCRzZGclhLVnd5YmI0UnhBU1Fs?=
 =?utf-8?B?Q0NFdlhtWmVQbW9mMXlRNVZLYitETGJiZDUrbXBuUFE4TUMzQ2VacERKUnFC?=
 =?utf-8?B?TkRDczFzc0h4dkNReHFhN2dic3drTnllQkFTZTR1VlE3bnB2Q0dWSmpTWXhi?=
 =?utf-8?B?U2Y1QklQaXQ0Qjd6QTlHUWhBZi9YS05kUHljL09qTDk3NnFYeHdjRkFaZzlm?=
 =?utf-8?B?R2k0eWxGNlhZQnZjaXBzd1hobG56SzdPOWJGbXE1NHJ1V0xnZnE3KzFQYko2?=
 =?utf-8?B?WWhablJrQ3NIR2FtR0s2TFhsVzZLMkZTLzBBY29KalF0QlZzY1dGdHQ0K2hD?=
 =?utf-8?B?QmphOVZoWjk3bGZlRVJYc0phL3BHUDBYUm4zQTZzK1dhVU9IK3NBa0p3dE9p?=
 =?utf-8?B?VlMvT3g1WDgvTEtwbTJZMWFEbFVxUUh2emwyMGMzaWZRelR5QU9OYUJKTWpH?=
 =?utf-8?B?K3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07A1F6A973631F48827F4545C42E66FC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6167.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238e779b-d3c6-4066-1647-08db5a74ad55
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 03:28:57.3623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 51IlkHTcXmWeIMg/RM1PCeL+eUAyLwwlIDAwV0TX3bN6r6p/saACQcvAKluDmtngIAMBbefR2+If9CD/sezlyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6228
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTA1LTEyIGF0IDEyOjAxICswMTAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIEZyaSwgTWF5IDEyLCAyMDIzIGF0IDA2OjQyOjUxQU0gKzAwMDAsIFlpLURlIFd1ICjlkLPk
uIDlvrcpIHdyb3RlOg0KPiA+IE9uIEZyaSwgMjAyMy0wNC0yOCBhdCAxNjoyNCAtMDUwMCwgUm9i
IEhlcnJpbmcgd3JvdGU6DQo+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xp
Y2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiA+ID4gdW50aWwNCj4gPiA+IHlvdSBoYXZl
IHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ID4gPiANCj4gPiA+IA0KPiA+
ID4gT24gRnJpLCBBcHIgMjgsIDIwMjMgYXQgMDY6MzY6MTdQTSArMDgwMCwgWWktRGUgV3Ugd3Jv
dGU6DQo+ID4gPiA+IEZyb206ICJZaW5nc2hpdWFuIFBhbiIgPHlpbmdzaGl1YW4ucGFuQG1lZGlh
dGVrLmNvbT4NCj4gPiA+ID4gDQo+ID4gPiA+IEFkZCBkb2N1bWVudGF0aW9uIGZvciBHZW5pZVpv
bmUoZ3p2bSkgbm9kZS4gVGhpcyBub2RlIGluZm9ybXMNCj4gPiA+ID4gZ3p2bQ0KPiA+ID4gPiBk
cml2ZXIgdG8gc3RhcnQgcHJvYmluZyBpZiBnZW5pZXpvbmUgaHlwZXJ2aXNvciBpcyBhdmFpbGFi
bGUNCj4gPiA+ID4gYW5kDQo+ID4gPiA+IGFibGUgdG8gZG8gdmlydHVhbCBtYWNoaW5lIG9wZXJh
dGlvbnMuDQo+ID4gPiANCj4gPiA+IFdoeSBjYW4ndCB0aGUgZHJpdmVyIGp1c3QgdHJ5IGFuZCBk
byB2aXJ0dWFsIG1hY2hpbmUgb3BlcmF0aW9ucw0KPiA+ID4gdG8NCj4gPiA+IHNlZQ0KPiA+ID4g
aWYgdGhlIGh5cGVydmlzb3IgaXMgdGhlcmU/IElPVywgbWFrZSB5b3VyIHNvZnR3YXJlIGludGVy
ZmFjZXMNCj4gPiA+IGRpc2NvdmVyYWJsZS4gRFQgaXMgZm9yIG5vbi1kaXNjb3ZlcmFibGUgaGFy
ZHdhcmUuDQo+ID4gPiANCj4gPiA+IFJvYg0KPiA+IA0KPiA+IENhbiBkbywgb3VyIGh5cGVydmlz
b3IgaXMgZGlzY292ZXJhYmxlIHRocm91Z2ggaW52b2tpbmcgcHJvYmluZw0KPiA+IGh5cGVyY2Fs
bCwgYW5kIHdlIHVzZSB0aGUgZGV2aWNlIHRyZWUgdG8gcHJldmVudCB1bm5lY2Vzc2FyeSBtb2R1
bGUNCj4gPiBsb2FkaW5nIG9uIGFsbCBzeXN0ZW1zLg0KPiANCj4gUGxlYXNlIGRvIG5vdCB3YWl0
IHVudGlsIGltbWVkaWF0ZWx5IHByaW9yIHRvIHN1Ym1pdHRpbmcgdmVyc2lvbiBOKzENCj4gYmVm
b3JlIHJlcGx5aW5nIHRvIGFueSBvZiB0aGUgY29tbWVudHMgb24gdmVyc2lvbiBOLg0KPiBUaGlz
IGNyZWF0ZXMgYSBjb25mdXNpbmcgc2NlbmFyaW8sIHdoZXJlIHNvbWUgcmV2aWV3IGNvbW1lbnRz
IG1heSBiZQ0KPiBtaXNzZWQgZHVlIHRvIHBhcmFsbGVsIGRpc2N1c3Npb24uDQo+IA0KPiBUaGFu
a3MsDQo+IENvbm9yLg0KPiANCk5vdGVkLCB3ZSB3b3VsZCBzdG9wIHVwZGF0aW5nIG5ld2VyIHZl
cnNpb24gdW50aWwgdGhlcmUncyBzb21lDQpjb25zZW5zdXMgdG8gZG8gc28uDQo=
