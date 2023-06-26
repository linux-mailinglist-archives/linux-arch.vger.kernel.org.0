Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E99973DAD4
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jun 2023 11:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjFZJIl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jun 2023 05:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjFZJIL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2023 05:08:11 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C7835A4;
        Mon, 26 Jun 2023 02:05:24 -0700 (PDT)
X-UUID: 942a9d4a140011ee9cb5633481061a41-20230626
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=qTo60WSjk+w5lS3tIG0TZtrkdhohAxs2AtOXt78tjF0=;
        b=ruEmkTU2rZjSdxQkWXE6C1ljXnVF2hiWeMbfCIc6mpIXQPHEOP7KN1SeH5iSQLTci5JSy6I2Hy4rQnT2Ok5Kjq0gEvByQOagc1PWLSigiQraCQh2vrqkk7z+PO1HCz0YNKcNuTmTjEt8RVKynoPClq7OvfWVG/DSv60ejxo9vYA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:85ca0e19-b131-4046-b465-51ead23ab62f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.27,REQID:85ca0e19-b131-4046-b465-51ead23ab62f,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:01c9525,CLOUDID:882d7d3f-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230626170522OURT7ZVS,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48|102,
        TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:
        0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
        TF_CID_SPAM_ULS
X-UUID: 942a9d4a140011ee9cb5633481061a41-20230626
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1925276763; Mon, 26 Jun 2023 17:05:21 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 26 Jun 2023 17:05:20 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 26 Jun 2023 17:05:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdlm8yKdPLkuto+mIMgDwdP7iDRSZzQ+bujavkhKpY6UxomYXM2ExfoncOsnak20TW/0Ky61UCm2HInnHUXGB30AvdcD7gCE7/wbu9xjCU6n5JtP0tIiWnDOJJnStZzP7afj79pxcckfLhMjvnXWMUH6omOQoOz3WfolLV4OFCklhOHpZ5MAvjZiOpnTvY4gTVHVqQZfztBPOPtF/q7IYMOO/n79uw/SdSZJy8f2gkvo82GpQ/BbL4zYt83Yh11m456oIMqPCp6Ab+hBSVEvKlNNNb6MBilpzRnGVCsZHGdM1Dg6lO/sm3M3knfAzmR9BpJ/I/6EKrUIVhAv2oIW0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTo60WSjk+w5lS3tIG0TZtrkdhohAxs2AtOXt78tjF0=;
 b=oNtKwP6cpXHBUVFKU7ZmmD9/l9fu+PYxYPKZJ/UtIq4/qcTaaPj/swQ+rnD2Nmm5AwBhkk3NrtsVR4PFrzLhZrFzF6SK1Tdv5TDl6cQbp4KEY3j0eT/L32DYSLTdUxiprR8g44fSeyR8Bgbf2h9XM1kTO+5Rs0XbK+8RfaO39AD8VHwDWv6YlmPkENaA/M7SeTmAK7VFX/nQ3HOxpnKHPCNH9HJdOkVcsafzn9UtQYfl1Ug0O6mI1Ahz3hNppkibijumL7hVCatfTwrh4im2zkr0qU78v6clrlPNLSR/KsiHr8l9K/+KdKbVZc+F4HtdD8HXE/j556pv31TVs3MqAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTo60WSjk+w5lS3tIG0TZtrkdhohAxs2AtOXt78tjF0=;
 b=IIT2A70GUSjxaKKzMTYg9OVVXeRJdrq+l0SRTlpcfFVFive6bgaXtWPDEYUkp70zYRB03mwO6DcFEneOgB/9Zw7B4wLRqLqzsFl+XkCY8buS/yvWdNgTTLd9WA2ML1CAGAaYRpMM6F1bxk2lZ2V3CRyxALU9QVK4FFy5EpJvhLI=
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com (2603:1096:4:14f::8) by
 KL1PR03MB5636.apcprd03.prod.outlook.com (2603:1096:820:54::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Mon, 26 Jun 2023 09:05:18 +0000
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::18a:8f94:379c:982d]) by SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::18a:8f94:379c:982d%7]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 09:05:18 +0000
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
Thread-Index: AQHZeb1mU9LdvrjJWkKKQBIpP+78BK9BPBGAgBUKZACARuC1AA==
Date:   Mon, 26 Jun 2023 09:05:17 +0000
Message-ID: <14c0381be38ea40fcd03104bff32bcaa09b920d3.camel@mediatek.com>
References: <20230428103622.18291-1-yi-de.wu@mediatek.com>
         <20230428103622.18291-3-yi-de.wu@mediatek.com>
         <20230428212411.GA292303-robh@kernel.org>
         <ec4cae2e6da4a64bc3983ffdde03f51e185d3609.camel@mediatek.com>
In-Reply-To: <ec4cae2e6da4a64bc3983ffdde03f51e185d3609.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6167:EE_|KL1PR03MB5636:EE_
x-ms-office365-filtering-correlation-id: 166e73a6-93ae-40ca-546d-08db76247662
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cby96yAGcELHN50aYU2bFvbhWGYYf6MXomwm+sATyY42Xaz1vyTeezO6oE9kCv9y6atY6nvHcJ3FThpnAgGj4R8QFCZZTEHql07QHB31TlFeLrsAyeWJxdKYwiYWzecLH0nv58JyWquRwdF8Q755hihgLoFkzaszbmh5PTy1w/ScALON+o7uaxctDcjo+0QHdVtoz5Z6nJordk1Jfc1fs2pS/NfllNOJsu3QOhHk7SiAy/tVivxKGy+9wNm+R3f4eVzO1iORWxbQPVjSkf0TGn2k3Ohmo14+C83PPzXcno3Z0MT32LUNrjA0OOhNhkRC1ReaWgDVZDDUVZ0vN8Wtudr8YsTI2ipuHza/KCrdocWT9G4+aV6IDRJaS9ZTURmZXitmGj6XAW24YbNBwDjMybFpu91PmkUJ+ahUM6Ts2dj3NjBggbvKlsM3VPig38LaDcWpSUCqLubNbXKGBfRK0LmvT93CjZ1NPfO9ey/t9E5p+EAKio1YZf4oOIeIP9DNbX1G6ph2vgYA0drApgQQ70YPMmokldQFrVtc3KD65KLPf/6alDrJvFWbRwSYG0DA7+VQabzyHp8x1X8eZhO0qxIF1rIajASX/OmPwzGAwNC72y+6Yp7G3xTj2dCyiPB+tPXBh295uv9DjG68vSQ+V5XDZ8WWjtValsekVZQHCYrhjyNGA35+QqHYypahpqZX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6167.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199021)(26005)(36756003)(85182001)(5660300002)(7416002)(6916009)(66476007)(316002)(8936002)(8676002)(76116006)(41300700001)(38070700005)(64756008)(86362001)(4326008)(66556008)(66446008)(38100700002)(122000001)(91956017)(66946007)(107886003)(6486002)(966005)(6506007)(2906002)(6512007)(186003)(478600001)(71200400001)(54906003)(2616005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alp3UzhRdmpqQlNQRXF1d3F1THFlL3FFSDZmYUR6VU52bTRrYncxUUFUTTlp?=
 =?utf-8?B?SzlNRXoyUHZYSEpPRzJLem9jeldoY0VYdXFIeEhqUDBLWFpwQWRvUTFCbTRy?=
 =?utf-8?B?OEpJQXVqSGQzSGZYQkY5bW9ncTZyTFYwNmFqQVRDNWxiRWRkbG5OUU5zU3pJ?=
 =?utf-8?B?cHFlT1A3ZXIrcEZtRkN5clVGRi9JVktxcXNQODkvK1NFaGVQdmFrQmp6eEIy?=
 =?utf-8?B?cW9oSTYzTlU0b3NrVkdXYlFPVzNCbWQ4aGdzb3VaZzBmdmxzQktHM01SWHc0?=
 =?utf-8?B?dXpEemFDVTBBS0J2L3AvRGd3bUFaV3g0SkgrN0tuODcxU3JTbmgwcnhmMGky?=
 =?utf-8?B?YjdnaUdSWUdnb3hBcVpLOVgxYVpYTHloQ1pZek9DWHc3WklhZURpRUl1OUw1?=
 =?utf-8?B?ZUpLMjlRWGo2Y2E3M3gyekxyTHg5YTh0Tnc0Y0lTdGF3bVJXQm9SZ3h0RTJR?=
 =?utf-8?B?NTc4c2pXdDRjb0pVdCsyT3RNZHZjbkhVeUQwcjVpYzc2Y09YS01ORUFzSWJT?=
 =?utf-8?B?dXh6MS9qV0FrQTU2TVFtTzgzc2loNDdhUGxIUTZVZEdwLzNTalJ2TEJJVkY1?=
 =?utf-8?B?RlVpNTNEQzREN05kUmxQKzhHOXhycFlORXhMcXFIRlZxL2dSaGJXQjhBK2ly?=
 =?utf-8?B?M3BGYWxtSmhsV0paSktnUnVaL2QyQU1MMUoyUUhjNUFOTWREbmZyU28xVmdi?=
 =?utf-8?B?aDVRdU1rN2lTNDU0UjN1bkhpOXpKVTEwdW9zUkZiZFR6d2IzbXFvRDNkWVp1?=
 =?utf-8?B?bGNCUmtrdDlnYTNIT0ZuSWtJanRUdU5LdE5aUnVMWUNDcjJPU09qYjJvN1hn?=
 =?utf-8?B?WThxUTNOR3VWZytoTklpUFNHbnE2RXpiUWZaT0pJZmpTRnBMUUVram9GTHFh?=
 =?utf-8?B?Zzh4TE9PaGdlYy9vdVc3YzhOL2pDc1BOQ1JwTDl2RkErUVZJM1RoUk5IMmRI?=
 =?utf-8?B?U0g4ZW9DQWlhZVNLL3lFYjNEUlNoYzhhNG9qWUJoK0pacnA1Q1BTWm83UjFY?=
 =?utf-8?B?OGpYQ1FVQTNFUzk0dlEvYmp4R0R5NHNxTDNDM0xRVERNUmdqeXRVcFhQZnNj?=
 =?utf-8?B?ME1rd0VrOC9zNnFCdFE2R0lUd2xvcVU0SkJmbGt2QmZsMzFwcXl4aDJmdmtn?=
 =?utf-8?B?ZVBjL1hUc3FQZlVXaW9vNXBiREs4YllyQ1R2d28zNHM4K2FIMko4ZU16endn?=
 =?utf-8?B?UHA3Mmc5TmFRMFVmK3F0WmRVRUhra0Y4R0Myb0tkNFBETWNJdTZvRVgxaE5z?=
 =?utf-8?B?WUFKeXdRTEFMMVhnYXZBcGx1aThVQVlPTVVESmhnYzZwa2hTUjBCbFlhSzhs?=
 =?utf-8?B?U0xPMjh5c0pESExUcytuWnlDK3lSZXB5OEJSQWp3ZjkwemlBNTVFL3VxemFp?=
 =?utf-8?B?WXJyWVRKTUh1UFNnSUNDak9vNEtPVVlkbDJ6ckNBb1U2K2hVMDRia0lSZ2t5?=
 =?utf-8?B?Y21oTmFYazNKWkxmWUNMYVNqYmUzUlMxZFBrdkN0NUxnRnpQZHBHTnVHbXBl?=
 =?utf-8?B?QTFEUEJFU2s4NWZDU3FHRURkWmo2MmVFM0Fla0NPemdyYjh3ZlZSNGMvaVJR?=
 =?utf-8?B?b1UreFpwSWh5a1lsR2RKa1pvTCttUDVDQVZDa0dKYTk2ME45YndxeGUzaDZv?=
 =?utf-8?B?enpxWkFPOW5BOFBiSVAxUnlHRkVSZjZqMzEwVkNXOXc4V2tRNDV2ZklaZFNT?=
 =?utf-8?B?dzRvancxdHpnc05nc09jQkxiRmVTVlJwT09BeVVaZkZ5L08zTHhQZGlneitt?=
 =?utf-8?B?cW1VRFV3S2dZNWpBZDBlREVUSFVtSHhrQWlLdERSNjVPU0hOZzA0c3VsUEtI?=
 =?utf-8?B?WVBGL01aMHVnWlFPeGNjbFE2eDB2UzRVckQ5ZHFhUjVORGx2ZWFuQzBraDU1?=
 =?utf-8?B?WjRudTVOSDA5M0pYeldpZnJBeWFHOFVHOFRQR3JJei85bW94OUFBbmtPVlBG?=
 =?utf-8?B?WS9va2VnZ3VJT0hveUtub01RZnJBSXRoU1YvbTRrNlBGVFVOaWoxTHlLK2xt?=
 =?utf-8?B?b3NqYnFoVTNqbXhQcHZXTkNhcE9GcC9uWHFlTi9kTi94ZThabVNESnA4TXlS?=
 =?utf-8?B?bU83L3VDQkFOQ2JCRUgwRzdUSllnUmdmZE5sRWJBRnBRbUJWcFdMcnMwVklI?=
 =?utf-8?B?ZG9DYjJ1aGsxZGptQk5sNWM3bW5LVXhiUko3eVFwZkVBNzFUYmVkUTM5ZHFh?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A309B4673F256348A0007667DEEB7CC3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6167.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 166e73a6-93ae-40ca-546d-08db76247662
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 09:05:17.9845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8u40hYTmGgIqFHd2lGucpdZXHGcE6ivdjVxSR1ZBNua5qNz36RCOnuSwCX9V6KCqhwlxU0dAiiHft1sp22pt4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5636
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTA1LTEyIGF0IDE0OjQyICswODAwLCBZaS1EZSBXdSB3cm90ZToNCj4gT24g
RnJpLCAyMDIzLTA0LTI4IGF0IDE2OjI0IC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4gPiBF
eHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cw0KPiA+IHVudGlsDQo+ID4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gPiANCj4gPiANCj4gPiBPbiBGcmksIEFwciAyOCwgMjAyMyBhdCAwNjozNjox
N1BNICswODAwLCBZaS1EZSBXdSB3cm90ZToNCj4gPiA+IEZyb206ICJZaW5nc2hpdWFuIFBhbiIg
PHlpbmdzaGl1YW4ucGFuQG1lZGlhdGVrLmNvbT4NCj4gPiA+IA0KPiA+ID4gQWRkIGRvY3VtZW50
YXRpb24gZm9yIEdlbmllWm9uZShnenZtKSBub2RlLiBUaGlzIG5vZGUgaW5mb3Jtcw0KPiA+ID4g
Z3p2bQ0KPiA+ID4gZHJpdmVyIHRvIHN0YXJ0IHByb2JpbmcgaWYgZ2VuaWV6b25lIGh5cGVydmlz
b3IgaXMgYXZhaWxhYmxlIGFuZA0KPiA+ID4gYWJsZSB0byBkbyB2aXJ0dWFsIG1hY2hpbmUgb3Bl
cmF0aW9ucy4NCj4gPiANCj4gPiBXaHkgY2FuJ3QgdGhlIGRyaXZlciBqdXN0IHRyeSBhbmQgZG8g
dmlydHVhbCBtYWNoaW5lIG9wZXJhdGlvbnMgdG8NCj4gPiBzZWUNCj4gPiBpZiB0aGUgaHlwZXJ2
aXNvciBpcyB0aGVyZT8gSU9XLCBtYWtlIHlvdXIgc29mdHdhcmUgaW50ZXJmYWNlcw0KPiA+IGRp
c2NvdmVyYWJsZS4gRFQgaXMgZm9yIG5vbi1kaXNjb3ZlcmFibGUgaGFyZHdhcmUuDQo+ID4gDQo+
ID4gUm9iDQo+IA0KPiBDYW4gZG8sIG91ciBoeXBlcnZpc29yIGlzIGRpc2NvdmVyYWJsZSB0aHJv
dWdoIGludm9raW5nIHByb2JpbmcNCj4gaHlwZXJjYWxsLCBhbmQgd2UgdXNlIHRoZSBkZXZpY2Ug
dHJlZSB0byBwcmV2ZW50IHVubmVjZXNzYXJ5IG1vZHVsZQ0KPiBsb2FkaW5nIG9uIGFsbCBzeXN0
ZW1zLg0KDQpoaSBSb2IsDQoNCldlJ2QgbGlrZSB0byBjb250aW51ZSB3aXRoIHRoZSBhcmd1bWVu
dCB3aGV0aGVyIHRvIHVzZSBkdCBoZXJlLiBBcyBwZXINCm91ciBwcmV2aW91cyBkaXNjdXNzaW9u
LCB3ZSBrbmV3IHRoYXQgZHQgaXMgZm9yIG5vbi1kaXNjb3ZlcmFibGUNCmhhcmR3YXJlLiBIb3dl
dmVyLCBwcm9iaW5nIG9uIGFsbCBkZXZpY2VzIGNvdWxkIHBvc3NpYmx5IHJhaXNlIHRoZQ0Kd29y
cmllcyBhYm91dCBwb2xsdXRpbmcgb3RoZXIgdXNlcnMgd2l0aCByZWR1bmRhbnQgc3lzdGVtIG92
ZXJoZWFkIGluDQpvdXIgdjQgcGF0Y2hlc1sxXS4NCg0KQXJlIHRoZXJlIGFueSBjb25jZXJucyBm
cm9tIHlvdXIgc2lkZSBpZiB3ZSB3ZXJlIHRvIHRha2UgdGhlIGR0IGJhY2sgaW4NCnY1IHBhdGNo
ZXMgYW5kIGtlZXAgaXQgYXMgc2ltcGxlIGFzIHBvc3NpYmxlIGp1c3QgdG8gaW5pdGlhbGl6ZSBv
dXINCmh5cGVydmlzb3IgZXhjbHVzaXZlbHk/IFNvbWV0aGluZyBzaW1pbGFyIHRvIHdoYXQgd2Ug
cHJvcG9zZWQNCmJlZm9yZVsyXS4NCg0KUmVmZXJlbmNlOg0KWzFdIA0KaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGttbC8yZmUwYzdmOS01NWZjLWFlNjMtMzYzMS04NTI2YTAyMTJjY2RAbGluYXJv
Lm9yZy8NClsyXSANCmh0dHBzOi8vYW5kcm9pZC1yZXZpZXcuZ29vZ2xlc291cmNlLmNvbS9jL2tl
cm5lbC9jb21tb24vKy8yNDQ3NTQ3LzEuLjIvZHJpdmVycy92aXJ0L2dlbmllem9uZS9nenZtX21h
aW4uYyNiMTEyDQoNClJlZ2FyZHMsDQo=
