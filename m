Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B3C700149
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 09:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240310AbjELHUt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 May 2023 03:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240357AbjELHUA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 03:20:00 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310FF1992;
        Fri, 12 May 2023 00:19:38 -0700 (PDT)
X-UUID: 58c725a4f09511ed9cb5633481061a41-20230512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=JwJ5vNJ0RM8WjJ+5DoLT41RRVNfQkruJnAJIjDbsDHg=;
        b=izmLmHnxY4Z1Hxdg2bXKKznynmTsS2fZ0MUVVL78KZy9nfvHPKevGTX9dLGJZGCEfmz3R4QWQcqHop5cUZM4nKZN5TA+X/OYHkETZ7msvTL/TBhHmDV9uv/ZvOPgMxe40bPMcHYCTHs64vXb71rUj4EiwUpSg0t1fvMHhgLTFTw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:aea3579f-dd47-4272-95b4-5ea4ae428137,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:1
X-CID-INFO: VERSION:1.1.24,REQID:aea3579f-dd47-4272-95b4-5ea4ae428137,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:re
        lease,TS:1
X-CID-META: VersionHash:178d4d4,CLOUDID:016c986b-2f20-4998-991c-3b78627e4938,B
        ulkID:230512151935JWTFIDEK,BulkQuantity:0,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
        SA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 58c725a4f09511ed9cb5633481061a41-20230512
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1154102497; Fri, 12 May 2023 15:19:34 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 May 2023 15:19:33 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 May 2023 15:19:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1xo5voOr+/7/pNKc+u/2dHBUUyNVVbo0z9R78NsgYC6bbSyVBedQVFHXqkNofiXOU6VRXipo4jWeKPY8EXuQ84ZqUzZYvMY5dYDJx1e/B8CNvyYZ70SxK3pUy6MZ6nVGudbkxWzaXP0eRS3+lrrIqwWy2fEhJZPV2fCEB7Da5CleUFPAi8wtIftupeilSqb/pB0G3VO6z1B1dZgicsM9UMknenQvRCQf7utcjOwrdY3wNTsHYZohhHNa2NpYQ0dkk3mt7h6cWVs5FkGO0lyUBoYjJ+oNLJ+FL6qyyjVXpZOi9zi1GLB5yCj/esI59L2fdA+h0aSzumlhjdQ6HzyKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwJ5vNJ0RM8WjJ+5DoLT41RRVNfQkruJnAJIjDbsDHg=;
 b=JoUkvcsMrjRjwvLOkjOVJ8168xmSUgw/x9H0R0j161BwBNvwmoHZ4MO0BDk4Qi6Od2SQSENFeAVnX6tcs7GGVam8Vq6kqGms1RprLRhbXUrL6pqIQNF8VDYqH42WxR7Uk7vrYyFF6+4CyfIJ4jk0MJbAhGRwgByK5h+2yIfXhtkzPIdIX5e+BNN47vZt2iBqtwzrMMwdF+KY2UpKFQZWcB75J1puaUcxc4osVn/LZrhXglK/q9/bw7H2EY2/iez0eSot66YT+1X4fuG4popuQNl4XVrxSPxvR5HpIOpSwTlYjtLYIf3aFn5kkDlMORijd4BF2Ok3zxiQ8y0/91s1fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwJ5vNJ0RM8WjJ+5DoLT41RRVNfQkruJnAJIjDbsDHg=;
 b=Vh2zEm24HuRhJlxutxIFizlHkU+Y6+Ujhst/6xjQc6wofVcHb1RNC+t8W6ihvxWj8omeBYUjwQJuNvZMDiVRx7cDjKG8XRVcJxOQ0Gcx4XMNwjX5Q3PLuxuK93QY0h/1mrIJlSIB31BQB9s3FWxTrGNg+byrVF29tpLSK7mHN2E=
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com (2603:1096:4:14f::8) by
 SEZPR03MB7592.apcprd03.prod.outlook.com (2603:1096:101:12b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.23; Fri, 12 May 2023 07:19:31 +0000
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b]) by SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b%9]) with mapi id 15.20.6387.023; Fri, 12 May 2023
 07:19:31 +0000
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
Subject: Re: [PATCH v2 5/7] virt: geniezone: Add irqchip support for virtual
 interrupt injection
Thread-Topic: [PATCH v2 5/7] virt: geniezone: Add irqchip support for virtual
 interrupt injection
Thread-Index: AQHZeb1n+Te8Qxm6rku5UO/fybejz69BE5YAgBU9HgA=
Date:   Fri, 12 May 2023 07:19:31 +0000
Message-ID: <762e3494ed468f0337b1c336615065b154396d23.camel@mediatek.com>
References: <20230428103622.18291-1-yi-de.wu@mediatek.com>
         <20230428103622.18291-6-yi-de.wu@mediatek.com>
         <f1c8c1c1c091be87dfbc27b9178fc3e6@kernel.org>
In-Reply-To: <f1c8c1c1c091be87dfbc27b9178fc3e6@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6167:EE_|SEZPR03MB7592:EE_
x-ms-office365-filtering-correlation-id: 857287d2-8780-4f01-2d90-08db52b93ae4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BWL0zc8qXSftgVHCNhN1k4x7IeG+ggrrPFgaIxvkuBQUrtPcFgHDdW7xQcS+Q0G0HOYByDfx9F+AvmmBpPqiRaAtUI+hNb8mjXhzQwvqnSNOxqdndvAgh8Wtc09QKPJM66CAwn925q2fXg0mQTJWfK92anxTuLjFkAWxl7G1v7aMTiymh8lM7bM413KMPKpeM6leS/ZlQpoMKkuIr8pInYNNywuNgbYOTv7mFUwghNi9zRRxTGL4pWg4Hfw9ybzqZkT+rT517Q0naT91pIaEF6sQl+k2iYCngkc63ld5X7foLEQv16WGwJAoWpv8FAgP1O+0KxIq5VDBK684X6IKWRu5cOZrMghNCSSSi63MHl6KKFYBw4tobvHfnv6jEJBR6VHc/vmnBjPpC+hB76SPD7Iv7xjdqeOVFVwnQgkWiv/ETiCr+Wv0c1j75jjjIlggRTw6TWvSfaTnVDwFt51PH1rIltXqOMj4gY0pyXiJb8+sNMsTpa1OuI6L2YV1MQWpX0Yh8SwElHAQ2hAMFWBN+88dtx1cerr4kXUuXVZNZWGbL/2vS4MkQowWAiyPEEYX1Ww8IfbDUkLsZGm6GLEVyoDORhMEzdcVdV0Hes5akB87JIsk2XYdBMam/AM7Pr+MbV3eEjv8RTxbrsT9uhUdkJb5/VQjYziouaIiLjBR1a0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6167.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(6916009)(76116006)(66446008)(4326008)(64756008)(66476007)(66556008)(54906003)(2906002)(66946007)(478600001)(7416002)(8676002)(8936002)(5660300002)(316002)(41300700001)(71200400001)(6486002)(53546011)(186003)(107886003)(6506007)(6512007)(26005)(2616005)(85182001)(83380400001)(36756003)(38070700005)(122000001)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RU9Wc3hMZURiQ1BEY3h1dlVoTGxrWDlIRU9xZ0p3WEdXTFJ4TUVDbTA0S3NJ?=
 =?utf-8?B?ZUJRQ2RRdGRHVEFPOTlJTEtueEw1NVhmQkdpL0k3QkwzcDYwY24zSmhWVk9u?=
 =?utf-8?B?KzIxV0RDWFl1akU5S1lPaUlNcW8xc05nNTVBSHh4anllbm1GWm5Pb0lUb1dn?=
 =?utf-8?B?Zllzb0dYN003ai8wSjQ2WENjOWczcnNOTnYwUzl6eVpxbTdWeE1lNko1bEhS?=
 =?utf-8?B?SnVIRWVDV00yWE1wNTdHQmVydVIxbTgwVk05bGd4NjRhY1hISXRvSUdJMWhq?=
 =?utf-8?B?V3gyb3NQeHhqdlM4SXRZcHhtZHRwUHVFUDNPRDQwSGpSdVdtaktDcmtPQUl5?=
 =?utf-8?B?UmlIOVBXckpubjZseGtUZ2lNR3NialhoNFdwS2tiZTNDTHZMeUVmZjlLVjgw?=
 =?utf-8?B?WEJpRzVXdUYxYTNzRmhreFhYQkFVbWdhVkJhdGpkNk92NHMrRnN6MHgxZGFs?=
 =?utf-8?B?TWs5L3pqVmRJOEJCa1Rva0JkWXFQYW9vMWR0U0tHbnkrR3VVZERBdEp0M2d6?=
 =?utf-8?B?dFRPTndqbEw1dEFiNWZBRGNkdXJCTjFLSU01MXlEUDNaMitVQWlXSlB3bEo0?=
 =?utf-8?B?TmxEekwvRXRwc0hHdXRteWNqdklmZEVsYUZnVS9kWVE3Wi9uTjNJK0NEQ0dt?=
 =?utf-8?B?OGdmSFhxbmJkVzMvSHNrV0ZQcXBUODdUa0lUcDFWR1htczB5N05KREtMVE1h?=
 =?utf-8?B?RDVYZS9QZ0s5ajIycjJLSHJVMkt0WW9hUGM5WU9PdUxuNFEwWGYwY0hST1c0?=
 =?utf-8?B?OGZSSlZaZzFiL09neDJxdTBacVg5UmhuLzZ5MkhPdXlJYTQxYVREYTJuQUc1?=
 =?utf-8?B?TXE4SS92TU9td1BSUHNESnZRVTlKNmVVN2QrV0I4OExZZkd2MENVa0xMZWpV?=
 =?utf-8?B?UTZGa1N6ZWp6dFJ4am5PYndlYnpuWXdicmd1dG9hVVlWRy81bm9waXBPd1U4?=
 =?utf-8?B?czN2SEp4N1VlOUpWamhWeWFjWkVUa2x1Z1hHT2xqdU5hTllUTEhtVDdrNlBB?=
 =?utf-8?B?WjhxQTl1SXRYSkdaQUdDQXRjSGVDSzRXTVBNbnkvcGlTWmp1d2lJOGRoVUxU?=
 =?utf-8?B?MXBIMEQwU25BSlorRlcraUhFQzdITUxraUhWa3lWVDY1ZHVRSFhKSFNObTQ3?=
 =?utf-8?B?eXQ3MExyWXhPQjREdGJpdXBmcjVpRElpZGpXR0JUNDE1MGRDOFRDdXpSRVg5?=
 =?utf-8?B?RTVMOUtiUFJ0ekZHRmhDZm9NRHhKUE9Ib1poVEhiMGhuWWhWa3drVmJlc0lN?=
 =?utf-8?B?cmkyUC9uMDJxVkJOVHgweGlqQW9wVktua0RSVGRQZWFrZUJaREdGR0FwYlk0?=
 =?utf-8?B?YmNYWTBoQk1MOXZPY2dSRDN3NGI1QU96YjBmZUVmZnZvNW44OVZXZUVIcHNR?=
 =?utf-8?B?MlFkWFgrNnpYYjF6YWZsWmhtWlJaaXpLZUp5aXZFcVJYTndsYVFpcU9FSkJ5?=
 =?utf-8?B?eGpHSkRjNjl0bW1uN1NkcStJY3F0M2IraVExZG4zb0ZtQzNxdFV6YS81UWZO?=
 =?utf-8?B?aTg0dHl3YitIOEoxbFRCbTN4VmsvTWN0Vk9SMzhqRG9DYjVZdW1IRTBEcmR1?=
 =?utf-8?B?Rlk1RmlFVk1wMit5clpyWm9tOVBhbDlMTkFsWXRjaE45VVNXa2MvaksySmhs?=
 =?utf-8?B?T3RKOC82bGs2US9kcEx6ZFdnWHU1ZVhieXBJWjBablFpNXh3SmIxZjNvT3Z3?=
 =?utf-8?B?dlA4ckhHUkFPWjEvTHJVYlpMcTU4SnBhSDdnenQySlRlRElRZGxXVDVOMy9G?=
 =?utf-8?B?bW5qaTZydUpXWlJSdFhHcEREWGxXUnJpMU1tZlAyb0JMc3p4R1NCbUNqRlgw?=
 =?utf-8?B?OHo3NkE1R21NMGt3MS9qQjloN1p2c2UxZnBWeTlhb1Bvc2lLTTZMOFpsL2h0?=
 =?utf-8?B?Wkl5UkNxKy9KTWQySlkwbFI4VXVsbjE4UHZZNHNDbTZhNm1WZkNYWFJGbmFD?=
 =?utf-8?B?RmtCYXk2azFQcTZqOHo4NFE3N2dMU3UwdjFYTXJWaGxOQ2trdXJUalB4M3R0?=
 =?utf-8?B?NklvNktwK1l0VVVwRTA1VnI5ZEVWUENZUDkwM2dMZVVNSzRFcWVMUm5YT2hM?=
 =?utf-8?B?SnhzaVUzZlF1KzVHMTVJN0lyd0JWOXgxejBKa1BmSmIvRG1RTWlVYngyc2tv?=
 =?utf-8?B?VGZmbnFzcG1ZNnRLQ3FBYjlsUnhBeGJUcDJzYXdRaDI5YWRkWWV6b2JNR1NL?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A0CDF02D8321340804161A4AB02DBD3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6167.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 857287d2-8780-4f01-2d90-08db52b93ae4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 07:19:31.3464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1P0wGhymp7frsmbXrXC4hY67LasSNxthW+22GC7QCUZ5J1r4Rq9p0usfWyKzfMpAajJ8uiv3mLbYoAU3kTIOXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7592
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTA0LTI4IGF0IDE5OjU5ICswMTAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuDQo+IA0KPiANCj4gT24gMjAyMy0wNC0yOCAxMTozNiwgWWktRGUgV3Ugd3JvdGU6DQo+ID4g
RnJvbTogIllpbmdzaGl1YW4gUGFuIiA8eWluZ3NoaXVhbi5wYW5AbWVkaWF0ZWsuY29tPg0KPiA+
IA0KPiA+IEVuYWJsZSBHZW5pZVpvbmUgdG8gaGFuZGxlIHZpcnR1YWwgaW50ZXJydXB0IGluamVj
dGlvbiByZXF1ZXN0Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFlpbmdzaGl1YW4gUGFuIDx5
aW5nc2hpdWFuLnBhbkBtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogWWktRGUgV3Ug
PHlpLWRlLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9nZW5pZXpv
bmUvTWFrZWZpbGUgICAgICAgfCAgMiArLQ0KPiA+ICBhcmNoL2FybTY0L2dlbmllem9uZS9nenZt
X2FyY2guYyAgICB8IDI0ICsrKysrKy0tDQo+ID4gIGFyY2gvYXJtNjQvZ2VuaWV6b25lL2d6dm1f
YXJjaC5oICAgIHwgMTEgKysrKw0KPiA+ICBhcmNoL2FybTY0L2dlbmllem9uZS9nenZtX2lycWNo
aXAuYyB8IDg4DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgZHJpdmVy
cy92aXJ0L2dlbmllem9uZS9nenZtX3ZtLmMgICAgfCA3NSArKysrKysrKysrKysrKysrKysrKysr
KysNCj4gPiAgaW5jbHVkZS9saW51eC9nenZtX2Rydi5oICAgICAgICAgICAgfCAgNCArKw0KPiA+
ICBpbmNsdWRlL3VhcGkvbGludXgvZ3p2bS5oICAgICAgICAgICB8IDM4ICsrKysrKysrKysrKy0N
Cj4gPiAgNyBmaWxlcyBjaGFuZ2VkLCAyMzUgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkN
Cj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvZ2VuaWV6b25lL2d6dm1faXJxY2hp
cC5jDQo+IA0KPiBbLi4uXQ0KPiANCj4gPiArKysgYi9hcmNoL2FybTY0L2dlbmllem9uZS9nenZt
X2lycWNoaXAuYw0KPiA+IEBAIC0wLDAgKzEsODggQEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjANCj4gPiArLyoNCj4gPiArICogQ29weXJpZ2h0IChjKSAyMDIzIE1l
ZGlhVGVrIEluYy4NCj4gPiArICovDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSA8bGludXgvaXJxY2hp
cC9hcm0tZ2ljLXYzLmg+DQo+ID4gKyNpbmNsdWRlIDxrdm0vYXJtX3ZnaWMuaD4NCj4gDQo+IE5B
Sy4NCj4gDQo+IFRoZXJlIGlzIG5vIHdheSB5b3UgY2FuIHJlbHkgb24gYW55dGhpbmcgZnJvbSBL
Vk0gaW4NCj4geW91ciBvd24gaHlwZXJ2aXNvciBjb2RlLg0KPiANCg0KU2FtZSB3aXRoIHByZXZp
b3VzIGRpc2N1c3Npb24sIHdlJ2QgbGlrZSB0byBjb3B5IG9yIHJlbmFtZSB0aGUgcmVsYXRlZCAN
CnBhcnQgZnJvbSBLVk0gYW5kIGtlZXAgdGhlIG1haW50YWluYW5jZSBhdCBvdXIgb3duIGlmIGl0
J3Mgb2suDQoNCj4gPiArDQo+ID4gKyNpbmNsdWRlIDxsaW51eC9nenZtLmg+DQo+ID4gKyNpbmNs
dWRlIDxsaW51eC9nenZtX2Rydi5oPg0KPiA+ICsjaW5jbHVkZSAiZ3p2bV9hcmNoLmgiDQo+ID4g
Kw0KPiA+ICsvKioNCj4gPiArICogZ3p2bV9zeW5jX3ZnaWNfc3RhdGUoKSAtIENoZWNrIGFsbCBM
UnMgc3luY2VkIGZyb20gZ3oNCj4gPiBoeXBlcnZpc29yDQo+ID4gKyAqDQo+ID4gKyAqIFRyYXZl
cnNlIGFsbCBMUnMsIHNlZSBpZiBhbnkgRU9JZWQgdmludCwgbm90aWZ5X2Fja2VkX2lycSBpZg0K
PiA+IGFueS4NCj4gPiArICogR1ogZG9lcyBub3QgZm9sZC91bmZvbGQgZXZlcnl0aW1lIEtWTV9S
VU4sIHNvIHdlIGhhdmUgdG8NCj4gPiB0cmF2ZXJzZQ0KPiA+IGFsbCBzYXZlZA0KPiA+ICsgKiBM
UnMuIEl0IHdpbGwgbm90IHRha2VzIG11Y2ggbW9yZSB0aW1lIGNvbXBhcmluZyB0byBmb2xkL3Vu
Zm9sZA0KPiA+IGV2ZXJ5dGltZQ0KPiA+ICsgKiBHWlZNX1JVTiwgYmVjYXVzZSB0aGVyZSBhcmUg
b25seSBmZXcgTFJzLg0KPiA+ICsgKi8NCj4gPiArdm9pZCBnenZtX3N5bmNfdmdpY19zdGF0ZShz
dHJ1Y3QgZ3p2bV92Y3B1ICp2Y3B1KQ0KPiA+ICt7DQo+ID4gK30NCj4gPiArDQo+ID4gKy8qIGlz
X2lycV92YWxpZCgpIC0gQ2hlY2sgdGhlIGlycSBudW1iZXIgYW5kIGlycV90eXBlIGFyZSBtYXRj
aGVkDQo+ID4gKi8NCj4gPiArc3RhdGljIGJvb2wgaXNfaXJxX3ZhbGlkKHUzMiBpcnEsIHUzMiBp
cnFfdHlwZSkNCj4gPiArew0KPiA+ICsgICAgIHN3aXRjaCAoaXJxX3R5cGUpIHsNCj4gPiArICAg
ICBjYXNlIEdaVk1fSVJRX1RZUEVfQ1BVOg0KPiA+ICsgICAgICAgICAgICAgLyogIDAgfiAxNTog
U0dJICovDQo+ID4gKyAgICAgICAgICAgICBpZiAobGlrZWx5KGlycSA8PSBHWlZNX0lSUV9DUFVf
RklRKSkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+ID4gKyAgICAg
ICAgICAgICBicmVhazsNCj4gPiArICAgICBjYXNlIEdaVk1fSVJRX1RZUEVfUFBJOg0KPiA+ICsg
ICAgICAgICAgICAgLyogMTYgfiAzMTogUFBJICovDQo+ID4gKyAgICAgICAgICAgICBpZiAobGlr
ZWx5KGlycSA+PSBWR0lDX05SX1NHSVMgJiYgaXJxIDwNCj4gPiBWR0lDX05SX1BSSVZBVEVfSVJR
UykpDQo+IA0KPiBXaGF0IGhhcHBlbnMgaWYgSSByZWRlZmluZSBhbGwgdGhlc2UgbWFjcm9zIHRv
bW9ycm93PyBOb25lIG9mDQo+IHRoaXMgY29kZSBzaG91bGQgcmVseSBvbiBhbnl0aGluZyB0aGF0
IGlzICpJTlRFUk5BTCogdG8gS1ZNLg0KPiANCj4gICAgICAgICAgTS4NCj4gLS0NCj4gSmF6eiBp
cyBub3QgZGVhZC4gSXQganVzdCBzbWVsbHMgZnVubnkuLi4NCg==
