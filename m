Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717C470B499
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 07:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjEVFha (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 01:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjEVFh3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 01:37:29 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99954CA;
        Sun, 21 May 2023 22:37:25 -0700 (PDT)
X-UUID: b86ff100f86211ed9cb5633481061a41-20230522
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+c2sMhp3ksxtZnyKuqD8RBRSrSWvcN3zO7aUCJf34Vc=;
        b=A9BltyEjZl2WpK5DSqew8JcUsywLqakDuesnQ0pnKhIpOFUbWLSHnhf5WAHT0jHfYKsmxOq3/tKln+3JSLkOWTzLrR/rZA18CCSyhEnSi8P0YVf9DD6XdpwgzmpSwuUTBC95B071mfd57o5Wx5QafSyT/NOMkyuk5aSrm12tjHs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:3a947da7-2b4a-452c-9012-527f14274bd8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:4f2aec3b-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: b86ff100f86211ed9cb5633481061a41-20230522
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 937895179; Mon, 22 May 2023 13:37:20 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 22 May 2023 13:37:19 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 22 May 2023 13:37:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cif5smfn5vI3kX0aIaLAZJwmdQXjcDg7w7PDP9XfluGzTFGiL3LiSQbOT/Akfye8l5Eo5IZK/zJAKolmPig4XZemozTOIjafcE6jv+ZaJ51ZNgSArUsO6Ylv6+5X4kCNuGzEUiRpMdTln5QCAqsqoKy1c6in5RjqiKRWqI2ELSYqskyGjV3kd3jWpzm3ge1QFEXPVpmulYULfiiXgc0vqeThEkC6xfIS6z28+DCwwe/UpR41q9Nlo6+BbJV01cB1UTqjmm9eY+PTzgEG9WQ6WMZXBZ9TzdmY0C18xkG9N12TPuEPUGUO+//i7WF5g7MDNdBxyUX+p4axRHdOxhcY1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+c2sMhp3ksxtZnyKuqD8RBRSrSWvcN3zO7aUCJf34Vc=;
 b=hh2jQ12fyFWoUsQQGl1+3mNfNkWzz3y0rEBZn7tt4KzCWuz3swT2sWii/lrE80joEFduUzKkKA1/6WCt54KEi2gSxyGl1X5aPFXhb4xY834+6ru+dkWSZB3CCZv2g+w67KeOiFfjvpgKvoV/havTeijpmmxu1qGeNSXHAVb1fnED2mDddcpcAAMarVwP2uGvSzsHh5k+vDeophMzhQ0z4kiq1Y/HxFkYmft/hOLPwaxF7PBSfY1ZUDKb/aIqu0SUkgn2AQxxjfFkYkW/d4qlM1DbME0PmJIg9jsmP+YP0CRrVF2zFGiMiJgb2KcB700z9T9TZhHO3FNXlAtnM12HHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+c2sMhp3ksxtZnyKuqD8RBRSrSWvcN3zO7aUCJf34Vc=;
 b=Xc9pWWCTBW8I7WbchmXkaNHfzdrxAcan0YqYvyQN+upc5WufPAPc1hclKegcKx5S2x2bkc09in2bdhnr6WcYcywJkz7CtXcp2sXwTBbyMu+FbZzoLdZ0C2qeD1BcLRZyH441rMeaEdyT5KgtpZD7JgJmqqUDLG05c3twY//umMk=
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com (2603:1096:4:14f::8) by
 SEYPR03MB7968.apcprd03.prod.outlook.com (2603:1096:101:168::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 05:37:16 +0000
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b]) by SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b%9]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 05:37:16 +0000
From:   =?utf-8?B?WWktRGUgV3UgKOWQs+S4gOW+tyk=?= <Yi-De.Wu@mediatek.com>
To:     "maz@kernel.org" <maz@kernel.org>
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
Subject: Re: [PATCH v3 3/7] virt: geniezone: Introduce GenieZone hypervisor
 support
Thread-Topic: [PATCH v3 3/7] virt: geniezone: Introduce GenieZone hypervisor
 support
Thread-Index: AQHZhKhkrEHc1cLg3ka9ebiExQeQbq9fu/2AgAYZoIA=
Date:   Mon, 22 May 2023 05:37:16 +0000
Message-ID: <eebbda6330367957ea1bd082fd8a775389688bf0.camel@mediatek.com>
References: <20230512080405.12043-1-yi-de.wu@mediatek.com>
         <20230512080405.12043-4-yi-de.wu@mediatek.com>
         <86h6sakprk.wl-maz@kernel.org>
In-Reply-To: <86h6sakprk.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6167:EE_|SEYPR03MB7968:EE_
x-ms-office365-filtering-correlation-id: 11ad7c7f-4ec0-4fff-fa2a-08db5a869a37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sWb7Yw+l5biB5vlbSwMvRtntGMRycYdN/iycwHxrAFbdfWQts1UBPBLJ0WIgW2BCmh1wqhwZKLSvVYGmnfHQ+dYOvDr9GAcRjTzK4BlpqykkWZfTzV1QwW/RQS/LLrRFfCxbvYoy+AtYC9NRDGxCoVTwvNyHXYFGg4j4kG6PSqigvcF+CIMQVY0rmdLpg3Yzyj8ZiBKjZaPJgrKQ5Pp4kF8Gi4JRONG/eKfRfw3pESrXWZVibLnfv8T1rPpHcDFEtmqC6fT+RILo7lUzASHhQg/ATLsTuJVkgnyct5voifn1CPiZEBfBG0XM2ePuvq19eMKc7F8Wy6ip4QqbFw+zOetKSSdT2/Fxn/522IKGF32brgBrkiU0Pdm0ZD1BflYXRsiH/4EXVvmP0pGXb4pD0Ah4wXKgXuIPkJV1fiOd4Wi2vX9kt34YNzixRquryg2yGYkBPJIRDp7T1q2mGeWUBOU/aK8IxtCWD6WnL+jjruneQLmYvgrPkUYz/GcBcawZ6NvJqVx1eJXlNkvSUxhukGG+dRnzpb291GwIxGbmIKtAK7Sy5OTjGvnAkQjsMn7ByMwvxohWxcXZpiClWjNLCr3cn4AXtAifpS2QVKkwylxJWiG/cOXkEJ2eTlBg8eIqKvn6/JPAdirRCFm+2wfXgFlCpKsqQm7CpIfawHCK3qA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6167.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199021)(2616005)(83380400001)(186003)(2906002)(6916009)(4326008)(64756008)(66446008)(66476007)(91956017)(76116006)(66946007)(66556008)(41300700001)(6486002)(316002)(71200400001)(54906003)(478600001)(7416002)(5660300002)(26005)(6506007)(6512007)(107886003)(8676002)(8936002)(38070700005)(38100700002)(122000001)(36756003)(85182001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjFjYWpjcWxqMjZJaWFuN2NyTThLYzdxOFk4alNkYmMwYUdRQlVPUWoyMVFl?=
 =?utf-8?B?WlJ3ZnFpZXYzNmt4YWlYbFltOEJQODBLUUlhRzlpdTdkTkFRd2VoNlRiK1h5?=
 =?utf-8?B?WDZrSWE0RVF0MDhhZWFRUUlqQnpnTE5UYzFEbzRjWE5SZy9JR0VyeDdQeVdB?=
 =?utf-8?B?Ung5RWx4bjU1cjcvODBlOHZtVkZ0VmZURjg4cjU3a2lsbVNSd01ONFVROGZ6?=
 =?utf-8?B?djlKVDdTRU0zU2hIMDlkYVk3Vk1OUENGUzh0dXZueDRQMURCY3BiM3YwTXlu?=
 =?utf-8?B?TUNNckFVTHhPQ0xVbEYvUXkvL1BidndPUDh4R0MwR3BrS3lTSkdIMWxpN1lq?=
 =?utf-8?B?UEFPR3Nyei85Uk0zeEVwM2R6djRHOVREYnp4ZUhZRUh6YXA4UGZpZStkNnhu?=
 =?utf-8?B?OXZ2TC9MUWxzbWlzNEdDcG1PSEEwOHBOeU9qaC9nT2xyOENFRFFSTlRCTlFj?=
 =?utf-8?B?bGZGaDZQaTMveXBIS2dHbGlVb3YzZEdRS2xjdXZub2RSWUpTVE5MQnBUbEp1?=
 =?utf-8?B?Rmc3QWFsLzUwUFRDTzNjcENKOGNuNGp5b3Q5dS9mWSt2UXlNWnFaWDQ3RFFT?=
 =?utf-8?B?dTg4b1ZmS0hJb2orQkZkQit4SVhKay9VV3ZaRm1pWGdPRnFwalo5eE9vLzJl?=
 =?utf-8?B?YjRMbmRkQUpWUFpwTFpXbGJMemMvY01lSXdOaDFVei82NjJUSWtORlQvT0Vx?=
 =?utf-8?B?RkFGT0U1dDNWMjVBUVZFUElhSXNXejBHU3A1V3RNcHR5SDdxeWh1c2FZYjIz?=
 =?utf-8?B?d3ZzeXFkVUxOaFpRVW5qN2lxSkhIQncwUjJOYm13R0RoZE9EeTJhYmRGMGlG?=
 =?utf-8?B?aEh4dkIydnBuK0Q1TU5qQXo2UHI1SEdEbloyOFo0NHFwOEZXZnVjM2VkSTds?=
 =?utf-8?B?N0krQmNEUnBhalo1TWRLSytGR012SXJuYTdsM1dKdU1uK2JsTU84dWROUjE2?=
 =?utf-8?B?OTd5Y2xqdS9aMFVleE5SZlc5d1lEQjYzaEFjSFlSdTcyOW1OM05FSUk1SERX?=
 =?utf-8?B?ejVtWkM0NTVUcHRjdUNYS1pCclVTM2tIVkxLVDk2alZtT0IybHBpYUljTTBo?=
 =?utf-8?B?YUI3eGxiNER1VUIzTHR5WmRydHlyZWF6K1VoRGxSTWVkckV3SktJa2ErR0Ex?=
 =?utf-8?B?Y20wSy9Ha0RaTVVORVRTblJoYVM2TXJHWmFBRnBKTDdaQXcwaVVmT3hMMlc5?=
 =?utf-8?B?WkxnckpZNGdNcVFxTmVjaWpZWWVseVBHYm8zNm8vMnpMaXV4V1hMWkZrWVBl?=
 =?utf-8?B?N1Y1VkxZRGc3anZtVDBQVUhUd1RQY1M4OUk3TVBSQTBBbmJqZEtyNkhGYkFv?=
 =?utf-8?B?N2dDeDM1RU11eFRsaXI4MjBWT3c5U0g4dGxVc3BGZ0Voczgvdm54OTl6TmdJ?=
 =?utf-8?B?NGUzN0ZRdTF0emtua0N3WTFabnFLQmFkVG9HcVZqT1hGbzc4dk1ZUUo3SVp0?=
 =?utf-8?B?Sm5VYUlXcjA5SlVXMzZSWFltL0F0QTViZ1BxS2cyQlF1OU5CM2JIUXhZMEE2?=
 =?utf-8?B?SVV0YnJpdXZwTWgwQjRBSDZST1ovbVFVUG42WlljWW1JQXZ1QlR1dzA5SUh6?=
 =?utf-8?B?NGx2NW9IRTZ4eS9EL0pRTGc4RjhCSzd5UUhFc0taaFhLTjRSVUNkbTBielp4?=
 =?utf-8?B?ZTQvVE1yTjF3Yit0ekxFVmxJSjBvN2l0RnhRTVl2T2liSmhEWDMrVzB4M21r?=
 =?utf-8?B?SjVyZHFObHhvcldSUnlxMkQyVmZCQzAycXJiN3lERW90Sy9KSmkrdG13amxV?=
 =?utf-8?B?QllETEREMUdlMDVud3Zvblh3WW5JaUdwNVFmc3RzZk1LOHQwVm0wdHlHRlFR?=
 =?utf-8?B?Yk0yWGNZSTQ5bEY2UlRPNWlnZTRDc2JvMUE4VC83eG9UeVM2azN4dkRwLzhN?=
 =?utf-8?B?OVZ3M3N6Y1dTYnlKMzlOYUY3YzdEemV0RGRoWlgreFBkMnQraFhQUDBycnFW?=
 =?utf-8?B?Y0owODZnaUlNMGNFa3pabkRLaU5Ra3hDWWR1VlE5ZlhEUlh4NTRNbm10Z1d6?=
 =?utf-8?B?YVNSalBQcDFQWWdQbklxK3ZuUlBLSE5vUERKb1MrVEZ3WE1mZThTRUFRT0Zi?=
 =?utf-8?B?L2llQ3NBR09Tc0NLT1ZtNDhITUx2aCtFeW1EamdqYU1mUmM0dU44czFJbmIv?=
 =?utf-8?B?ZTFxNFFOSTNMc2Z1Wk1TVE5paEx3Szk5NWc4Z29lT3NuUVdRelg0bC84NDF0?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78E14EF49649164B90F4C47042BBCFA5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6167.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ad7c7f-4ec0-4fff-fa2a-08db5a869a37
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 05:37:16.1955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tEmQ+hMdhPQMUzOjMo+ExPGYW7BIw5Us9Oi6d3Iu2l6K0rQPjkEmelwq52mTeNacUw/1Dn+GoeVvrKyXyCVEAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7968
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIzLTA1LTE4IGF0IDA5OjI3ICswMTAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuDQo+IA0KPiANCj4gT24gRnJpLCAxMiBNYXkgMjAyMyAwOTowNDowMSArMDEwMCwNCj4gWWkt
RGUgV3UgPHlpLWRlLnd1QG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gRnJvbTogIllp
bmdzaGl1YW4gUGFuIiA8eWluZ3NoaXVhbi5wYW5AbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IEdl
bmllWm9uZSBpcyBNZWRpYVRlayBoeXBlcnZpc29yIHNvbHV0aW9uLCBhbmQgaXQgaXMgcnVubmlu
ZyBpbiBFTDINCj4gPiBzdGFuZCBhbG9uZSBhcyBhIHR5cGUtSSBoeXBlcnZpc29yLiBUaGlzIHBh
dGNoIGV4cG9ydHMgYSBzZXQgb2YNCj4gPiBpb2N0bA0KPiA+IGludGVyZmFjZXMgZm9yIHVzZXJz
cGFjZSBWTU0gKGUuZy4sIGNyb3N2bSkgdG8gb3BlcmF0ZSBndWVzdCBWTXMNCj4gPiBsaWZlY3lj
bGUgKGNyZWF0aW9uIGFuZCBkZXN0cm95KSBvbiBHZW5pZVpvbmUuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogWWluZ3NoaXVhbiBQYW4gPHlpbmdzaGl1YW4ucGFuQG1lZGlhdGVrLmNvbT4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBZaS1EZSBXdSA8eWktZGUud3VAbWVkaWF0ZWsuY29tPg0KPiANCj4g
Wy4uLl0NCj4gDQo+ID4gKy8qKg0KPiA+ICsgKiBnenZtX2dmbl90b19wZm5fbWVtc2xvdCgpIC0g
VHJhbnNsYXRlIGdmbiAoZ3Vlc3QgaXBhKSB0byBwZm4NCj4gPiAoaG9zdCBwYSksDQo+ID4gKyAq
ICAgICAgICAgICAgICAgICAgICAgICAgICByZXN1bHQgaXMgaW4gQHBmbg0KPiA+ICsgKg0KPiA+
ICsgKiBMZXZlcmFnZSBLVk0ncyBnZm5fdG9fcGZuX21lbXNsb3QoKS4gQmVjYXVzZQ0KPiA+IGdm
bl90b19wZm5fbWVtc2xvdCgpIG5lZWRzDQo+ID4gKyAqIGt2bV9tZW1vcnlfc2xvdCBhcyBwYXJh
bWV0ZXIsIHRoaXMgZnVuY3Rpb24gcG9wdWxhdGVzIG5lY2Vzc2FyeQ0KPiA+IGZpbGVkcw0KPiA+
ICsgKiBmb3IgY2FsbGluZyBnZm5fdG9fcGZuX21lbXNsb3QoKS4NCj4gPiArICoNCj4gPiArICog
UmV0dXJuOg0KPiA+ICsgKiAqIDAgICAgICAgICAgICAgICAgICAgICAgIC0gU3VjY2VlZA0KPiA+
ICsgKiAqIC1FRkFVTFQgICAgICAgICAtIEZhaWxlZCB0byBjb252ZXJ0DQo+ID4gKyAqLw0KPiA+
ICtzdGF0aWMgaW50IGd6dm1fZ2ZuX3RvX3Bmbl9tZW1zbG90KHN0cnVjdCBnenZtX21lbXNsb3Qg
Km1lbXNsb3QsDQo+ID4gdTY0IGdmbiwgdTY0ICpwZm4pDQo+ID4gK3sNCj4gPiArICAgICBoZm5f
dCBfX3BmbjsNCj4gPiArICAgICBzdHJ1Y3Qga3ZtX21lbW9yeV9zbG90IGt2bV9zbG90ID0gezB9
Ow0KPiA+ICsNCj4gPiArICAgICBrdm1fc2xvdC5iYXNlX2dmbiA9IG1lbXNsb3QtPmJhc2VfZ2Zu
Ow0KPiA+ICsgICAgIGt2bV9zbG90Lm5wYWdlcyA9IG1lbXNsb3QtPm5wYWdlczsNCj4gPiArICAg
ICBrdm1fc2xvdC5kaXJ0eV9iaXRtYXAgPSBOVUxMOw0KPiA+ICsgICAgIGt2bV9zbG90LnVzZXJz
cGFjZV9hZGRyID0gbWVtc2xvdC0+dXNlcnNwYWNlX2FkZHI7DQo+ID4gKyAgICAga3ZtX3Nsb3Qu
ZmxhZ3MgPSBtZW1zbG90LT5mbGFnczsNCj4gPiArICAgICBrdm1fc2xvdC5pZCA9IG1lbXNsb3Qt
PnNsb3RfaWQ7DQo+ID4gKyAgICAga3ZtX3Nsb3QuYXNfaWQgPSAwOw0KPiA+ICsNCj4gPiArICAg
ICBfX3BmbiA9IGdmbl90b19wZm5fbWVtc2xvdCgma3ZtX3Nsb3QsIGdmbik7DQo+ID4gKyAgICAg
aWYgKGlzX2Vycm9yX25vc2xvdF9wZm4oX19wZm4pKSB7DQo+ID4gKyAgICAgICAgICAgICAqcGZu
ID0gMDsNCj4gPiArICAgICAgICAgICAgIHJldHVybiAtRUZBVUxUOw0KPiA+ICsgICAgIH0NCj4g
DQo+IEkgaGF2ZSBjb21tZW50ZWQgb24gdGhpcyBiZWZvcmU6IHRoZXJlIGlzIGFic29sdXRlbHkg
Km5vIHdheSogdGhhdA0KPiB5b3UNCj4gY2FuIHVzZSBLVk0gYXMgdGhlIHVud2lsbGluZyBoZWxw
ZXIgZm9yIHlvdXIgc3R1ZmYuIFlvdSBhcmUgcGFzc2luZw0KPiB1bmluaXRpYWxpc2VkIGRhdGEg
dG8gdGhlIGNvcmUgS1ZNLCBjb21wbGV0ZWx5IGlnbm9yaW5nIHRoZSBzZW1hbnRpY3MNCj4gb2Yg
YWxsIHRoZSBvdGhlciBmaWVsZHMuDQo+IA0KPiBNb3JlIGltcG9ydGFudGx5LCB5b3UgYXJlIG5v
dyBob2xkaW5nIHVzIHJlc3BvbnNpYmxlIGZvciBhbnkgYnJlYWthZ2UNCj4gdGhhdCB3b3VsZCBi
ZSBjYXVzZWQgdG8geW91ciBjb2RlIGlmIHdlIGNoYW5nZSB0aGUgaW50ZXJuYWxzIG9mIHRoaXMN
Cj4gKlBSSVZBVEUgRlVOQ1RJT04qLg0KPiANCj4gRG8geW91IHNlZSBYZW4gb3IgSHlwZXItViB1
c2luZyBLVk0ncyBpbnRlcm5hbHMgYXMgc29tZSBzb3J0IG9mDQo+IGJhY2tlbmQgdG8gbWFrZSB0
aGVpciBsaWZlIGVhc2llcj8gTm8sIGJlY2F1c2UgdGhleSB1bmRlcnN0YW5kIHRoYXQNCj4gdGhp
cyBpcyBvZmYtbGltaXRzLCBhbmQgY3JlYXRlcyBhbiB1bmhlYWx0aHkgZGVwZW5kZW5jeSBmb3Ig
Ym90aA0KPiBoeXBlcnZpc29ycy4NCj4gDQo+IFNvIHRoaXMgaXMgYSBzdHJvbmcgTkFLLiBBbmQg
eW91IGNhbiB0cnVzdCBtZSB0byBrZWVwIHZvaWNpbmcgbXkNCj4gb3Bwb3NpdGlvbiB0byB0aGlz
IHNvcnQgb2YgaG9ycm9yLCB3aGVyZXZlciBJIHdpbGwgc2VlIHRoZXNlIHBhdGNoZXMuDQo+IA0K
PiAgICAgICAgIE0uDQo+IA0KPiAtLQ0KPiBXaXRob3V0IGRldmlhdGlvbiBmcm9tIHRoZSBub3Jt
LCBwcm9ncmVzcyBpcyBub3QgcG9zc2libGUuDQoNCk5vdGVkIGFuZCBmdWxseSB1bmRlcnN0b29k
LiBUaGUgcGF0Y2ggZm9yIHRoaXMgYnVnIGZpeCB1c2luZyBvdXIgb3duDQppbXBsZW1lbnRhdGlv
biB3b3VsZCBiZSBzdWJtaXR0ZWQgc29vbi4NCg==
