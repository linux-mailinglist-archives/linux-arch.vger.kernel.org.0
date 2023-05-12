Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF6D7000BA
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 08:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239825AbjELGm7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 May 2023 02:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240072AbjELGmy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 02:42:54 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121261FF7;
        Thu, 11 May 2023 23:42:45 -0700 (PDT)
X-UUID: 2fab9b00f09011edb20a276fd37b9834-20230512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Za1bXg8cUjqrMAMqNX6zNTjInVooMFokKx1m0/6aPmU=;
        b=rE1dz719IVWRO/SBvqPqUiN1ZSumdy6ZXt7KOXAtE76fijgH1NWXn5P/MhL2hMopMCQaCzsqkij+PPbtOeAbv2XiMcxxb2TBmph8nlMzxXPH6244AOmqa3xI0gl834x6zbtMsnzN1d/qxFd9v37d139q4OqLI4zya7I7pL+kHcY=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:af7e61bb-98a9-4046-86f6-0e89646157d6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:4,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:4
X-CID-INFO: VERSION:1.1.24,REQID:af7e61bb-98a9-4046-86f6-0e89646157d6,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:4,FILE:0,BULK:0,RULE:Release_HamU,ACTION:r
        elease,TS:4
X-CID-META: VersionHash:178d4d4,CLOUDID:c22b976b-2f20-4998-991c-3b78627e4938,B
        ulkID:230512144241UWLV7EGJ,BulkQuantity:0,Recheck:0,SF:16|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
        SA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 2fab9b00f09011edb20a276fd37b9834-20230512
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 658678967; Fri, 12 May 2023 14:42:38 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 May 2023 14:42:38 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 May 2023 14:42:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxCgTbw+wBidghbypV5ESCLEbnrHY7Fk6C5vZbjFApIVbiN3U1rV34Q/ak0vD8GlWLX4CqlJdzKrwGhsS458sJIWAWbIoeRlZPV7hGeSbgEa/Lg7h+aw+Z8PHWsz5EaZTNNUlGap93CCyd5VLVsyibsr7fQoKeVyZLUvepgmKMRmAANYsK9sCoojzWb62w/IIWKsrT8zH58f4/LoMfn1obaicIkxa4C2CH+aUx3udATCPdeJcvePFqlIitUDUNGS7UNs1W4TdgDsZ3az/80hOG2nbn86SIvbYxfkinfvtu5CJ/AJiDzV8j+eVZmb1wEy0O8v/OxDbDypEpLgSMK9TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Za1bXg8cUjqrMAMqNX6zNTjInVooMFokKx1m0/6aPmU=;
 b=l/pwDcxe5hoMvxg4gcORR7XyDp0hCNuhYnlJN0vmXVG6wh+0Bu9INIsaxYJLAivckydscF16OLnnCjnUL+XbIDG9sj1aigLbrOgUSg5JRMdawe1mNHcqmGop8hxHZz5D1Ju/DFnjTYulPmEWBlzuoIufOMSY0jjP3Q1J+UyssxogKy5ADtaXXSCcyAUaq0n8ZvYI/W+jaDTe0AxjtOlkYZl8E7B+s8TL9myRW4Hm31rKck8at0yLMoFwKvxHz66XL2w0BM9ByFLMf6cWl+zsewq9QVOF/A2AiIwEYFoxMQId5rla6b5jIZbJduXaDbRcbjrDyfaUDi23YITm3NRlTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Za1bXg8cUjqrMAMqNX6zNTjInVooMFokKx1m0/6aPmU=;
 b=IJuhNGmAAiO7BTeBbNrEeF/u9aw6iTdQgmvOCFS9qYlwTjNEv2eAC+Egz+mydTY1I5gHK6pszikMK8HqJ6aFR7VlN2xAlPE+oro82Jzjb1q/RJlO9fcURi83yZMqVnlX9/5G0/Zt1NJa8UMEIjx9mv08fj9I0HEVXlnLfszmEPU=
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com (2603:1096:4:14f::8) by
 SEZPR03MB6810.apcprd03.prod.outlook.com (2603:1096:101:65::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.21; Fri, 12 May 2023 06:42:35 +0000
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b]) by SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b%9]) with mapi id 15.20.6387.023; Fri, 12 May 2023
 06:42:35 +0000
From:   =?utf-8?B?WWktRGUgV3UgKOWQs+S4gOW+tyk=?= <Yi-De.Wu@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>,
        =?utf-8?B?TVkgQ2h1YW5nICjojormmI7ouo0p?= <MY.Chuang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
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
        =?utf-8?B?WWluZ3NoaXVhbiBQYW4gKOa9mOepjui7kik=?= 
        <Yingshiuan.Pan@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <Miles.Chen@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        =?utf-8?B?SXZhbiBUc2VuZyAo5pu+5b+X6LuSKQ==?= 
        <ivan.tseng@mediatek.com>,
        =?utf-8?B?WmUteXUgV2FuZyAo546L5r6k5a6HKQ==?= 
        <Ze-yu.Wang@mediatek.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v2 2/7] dt-bindings: hypervisor: Add MediaTek GenieZone
 hypervisor
Thread-Topic: [PATCH v2 2/7] dt-bindings: hypervisor: Add MediaTek GenieZone
 hypervisor
Thread-Index: AQHZeb1mU9LdvrjJWkKKQBIpP+78BK9AzqOAgBV3voA=
Date:   Fri, 12 May 2023 06:42:35 +0000
Message-ID: <c0b590711516f5bb0e9db688685e09a8e73abd5e.camel@mediatek.com>
References: <20230428103622.18291-1-yi-de.wu@mediatek.com>
         <20230428103622.18291-3-yi-de.wu@mediatek.com>
         <168269352006.3076.11433928748883862569.robh@kernel.org>
In-Reply-To: <168269352006.3076.11433928748883862569.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6167:EE_|SEZPR03MB6810:EE_
x-ms-office365-filtering-correlation-id: b8c45b13-5fa8-4c7b-db7a-08db52b411e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0EqORKlHCtAL1x0ZB/mhByN/gyakddznfzrHMsdch5LEcV4dR6XvKdkBAgtxx5Yh7g0FZOIrMDqIF9xar5wrkc1oDH5a03AVkBlsZQaPCdVl8n4M+QKuzOIRm3jCxR6C1/39Nzm1LOBKBv14i1g4pXEHrCPC6D54aZjEAW5g6YTjveK2Y82EWcid9mqo/TW/rQyMBf3G5mTQVsGr+hlGiuDUzrJkEFSSp2XTUz3UGa492pX1MEOAlAtHTWyf0kiv8ZWzPCzOwcrXnXbzBpCEBq0QWFoxoyUGlaKNan+TH+dCezsax7NH3hrK/uX4f9vMaqqj0jxf77AsQbW7SvtO1esOvizdZx6t+pRwOvqwd234tCIY21mxhkc2JHaJXcVeTVkofJNCxiwwWRFU2pT9Ssxw9LIZhE+TgRMQc6J51l4CHl4I42SGXYr+hUGvoKlr8FK4KLsALHo7vkvcwgY/9kWXbT68azq1RfX2kSZ1yKf3pcSwlj23Bw2Ep0nM8HU2S9+E/dSei2ZjQGwN7OqZwXcNY98SpWeU1sXBVbkUGPoZHQoi2uBRKyenbPg1+uUzRU9fphAKd/POIrLD5KA7QkgQ3OLeTOfKW8UU4ITo6OxNs4p/YVKSieboyQqataqoRbpyp4X0E6Ri2iabzgUx3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6167.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(122000001)(71200400001)(41300700001)(6506007)(26005)(6512007)(966005)(8676002)(8936002)(7416002)(5660300002)(6486002)(83380400001)(2616005)(186003)(2906002)(38100700002)(91956017)(64756008)(76116006)(86362001)(38070700005)(4326008)(66446008)(66556008)(66476007)(316002)(478600001)(54906003)(36756003)(85182001)(6916009)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0NmaUpDWVo0ZDNOM1FkTjRVSVB6NjdNaXVtMVQ4UXRVR2RwcnpkZE1ISFBh?=
 =?utf-8?B?YnJ5VUFOaDVhOGhubjNNQnFPMnVhZ2VkSnBTNWNmNTEwYkkwVFhSdTFjNElw?=
 =?utf-8?B?d1BjZ3VtbXErc2xESytYdENmMVZMajB4ekcyejh5UzFFWGQ3MVZLOHQxd0Vl?=
 =?utf-8?B?cEJkb2dwWWt2dVBrWWNuR3JZcTkxYzhFWkxxZ2Fkc2hWL3hHUjVQTmc0eHlW?=
 =?utf-8?B?LzgvWTV2czIwcVIyWHBVcWJuaUJYRG5NbTErNjF5aFdPQlRzMGFXWWc4S09X?=
 =?utf-8?B?cUdyaTRCOXBQSWtoa1FkUWhLMTc0U0VwRUZpbjYvSWgrTldYc2lDVGdkdjVk?=
 =?utf-8?B?VlZWWFFkV2ZSZEZwUzQ3MjZoa3F4VmtwRkQ1OUw3VVdiYnI1RTU2L3lGWVQ5?=
 =?utf-8?B?SHNOQnRvcUpkbzFoSUwvM0R4am1EU3NVeHdENDdsclY4REtnYXViWkQrK0pS?=
 =?utf-8?B?aTN3WjdsOUl0V012ZTBtNngyNGh1WjBDZmkycWE5N3hVWHNHYXNwQnJKSkFT?=
 =?utf-8?B?NkFtOXhzdXJuT0FPZUtmV2JRZklYUEwrU1dGRlBLN3JWWis1Q01tSndYWFlz?=
 =?utf-8?B?OGo1cnk3SWRhaXhlKzYyaTVMd284VGtPbXVOZlFZVXgwSDhCZEN0ekx6Ky9B?=
 =?utf-8?B?NFJoV0dwcDFJNnNjQmZQRzZMZ3BCQmF2TEI2a2VOV0tHTWJyOExXYnkzU2Ny?=
 =?utf-8?B?Q0QxdFZ4VFpRbE9lKzJZMmJyd3hJTkJwaEV0cWJXMitDemxZbEI5RHVVbkxC?=
 =?utf-8?B?M2hHVGk4TVZqQkpXWFhSQTd3K28wVE9HeUJTL0dMQjV3NHM2Sm9QS2NYUkJl?=
 =?utf-8?B?SUY5dmIwYXpyWVU1Ry9XU01tUzVWbkF3UlpOVlBrODVra3EwSWUzSVlLVDlj?=
 =?utf-8?B?UlF6Vi8xS0dtbzhlQUZ2aDhMcE13UTl3TjdFR2paYno3ZE9IZFQ4eEtEVW0r?=
 =?utf-8?B?ZGVuMjBDMldyYUNtYVlodTVyaWJYeXQvcGY5eTNGTUhURzdSb1AwMzM4SHNm?=
 =?utf-8?B?TnFGWG11WFE1blpWVmF4NTVxRXdkVmFGZjVJMDMvaGxwME1MWHZNcVZFZnlR?=
 =?utf-8?B?ZEdzQitaTC8wQXI3Z2tVSHRxSnM4RWtGOW05KzBIK1dWVU9TRWVkSU5oblph?=
 =?utf-8?B?L0x6N0tPcy9MOEJkMzJQYytQdytFQ1dWa08vRDRkbHNocnpwUnRFakdVUGM4?=
 =?utf-8?B?TnFaU1VGV3dzS2tVV0FJWnZqd2xjMUk3OVdaMkdLQ29KV05meGZhczIxYVZM?=
 =?utf-8?B?NERPODc3ZFo5dDZkWXZWVjIxV0xPNHozRkxrbmxJTHg1SDBFMFMwRFpjUm1Y?=
 =?utf-8?B?RHpyZVJYUFVNQVA0a0p1SzdzbkpIU1hZdy9mTW9HL29VbUs3Z293VTk3T2Vm?=
 =?utf-8?B?ZFJDMXk5SU9iM1phRGJEQWJkUVc5czl0akFWL25peGlydmtGeE9tS1VnaG4x?=
 =?utf-8?B?SGJOTjJRcEhqY1RvTk9zMndMYVhBa0xFSjN4dWwrT1JnclM1UVJYQlRvbzRH?=
 =?utf-8?B?Y3BWNmhKOWxPd2JSRDl6N1IwODRDampGcXF4SGFQYkFSbUl4dFhhVDFmTUdh?=
 =?utf-8?B?THE1QVZZQTJqQmgvMTZrNmI2SFVsMWNhWThuL0U3OUY0ZEpQV3NuUzlaVHFZ?=
 =?utf-8?B?L3dyQkI5T3ZGc1orSXJtVG81QzcraFlZWjI3L05naDR5Lzl0ajBKSlRRTklx?=
 =?utf-8?B?MmdVZWtJQ25qU01pOHdzbExtOHdzazlyc3V0NWg4aGVQTnBiN1NRbGpkSE1G?=
 =?utf-8?B?dlp3QlE4MFBaMDZwK1EybForSXlRdnFUdGdIcjFibTN4WE5tWEtZeDNaZFc3?=
 =?utf-8?B?Q0tidll5MWRzUmhBRWNPL2JQTnFzRHlKV08rdGREb2lRWk9MQ0p3NWEva25W?=
 =?utf-8?B?ME9RREJGa0poVXl0UUtmdENacytMb1h6NTljQ05QbzVEOENrbVNoSWxib2Zt?=
 =?utf-8?B?elNSWEtVVm5UYTd6dHFTMk4yelBxZG5jOEp4czBkUXhubHV4cDA2QkhxT21w?=
 =?utf-8?B?VDcvK3ZrYWNPRzRoanlFcE1rZElFTVpMV0FxQ2RFMVBZVVd2M1BQaDZKUlNR?=
 =?utf-8?B?SldVYlhPSnlvZUVhclRlL3lPbFBJeU8wUFdxOHpUdlBjancvTnV4UER1VHlx?=
 =?utf-8?B?UUFtdmhsMkN3bWxoYlJjLzN3ZUh4c2tBOTlCQVVucmoxUC9QSGNYU29HK0Ji?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E753E02F780F434DAFF9279E5226EA0E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6167.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c45b13-5fa8-4c7b-db7a-08db52b411e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 06:42:35.1125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dRa3HQi0z4L3yon6kQsESbZozYN4B5Zn/Dto9DCkGRbxNwS/pijDVMMSjRyHVCXNKt1zL6ylZLN1F/G7CpLStg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6810
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTA0LTI4IGF0IDA5OjUyIC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVu
dC4NCj4gDQo+IA0KPiBPbiBGcmksIDI4IEFwciAyMDIzIDE4OjM2OjE3ICswODAwLCBZaS1EZSBX
dSB3cm90ZToNCj4gPiBGcm9tOiAiWWluZ3NoaXVhbiBQYW4iIDx5aW5nc2hpdWFuLnBhbkBtZWRp
YXRlay5jb20+DQo+ID4gDQo+ID4gQWRkIGRvY3VtZW50YXRpb24gZm9yIEdlbmllWm9uZShnenZt
KSBub2RlLiBUaGlzIG5vZGUgaW5mb3JtcyBnenZtDQo+ID4gZHJpdmVyIHRvIHN0YXJ0IHByb2Jp
bmcgaWYgZ2VuaWV6b25lIGh5cGVydmlzb3IgaXMgYXZhaWxhYmxlIGFuZA0KPiA+IGFibGUgdG8g
ZG8gdmlydHVhbCBtYWNoaW5lIG9wZXJhdGlvbnMuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTog
WWluZ3NoaXVhbiBQYW4gPHlpbmdzaGl1YW4ucGFuQG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBZaS1EZSBXdSA8eWktZGUud3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAu
Li4vaHlwZXJ2aXNvci9tZWRpYXRlayxnZW5pZXpvbmUtaHlwLnlhbWwgICAgfCAzMQ0KPiA+ICsr
KysrKysrKysrKysrKysrKysNCj4gPiAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDEgKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDMyIGluc2VydGlvbnMo
KykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2h5cGVydmlzb3IvbWVkaWF0ZWssZ2VuaWV6b25lLQ0KPiA+IGh5cC55YW1sDQo+
ID4gDQo+IA0KPiBNeSBib3QgZm91bmQgZXJyb3JzIHJ1bm5pbmcgJ21ha2UgRFRfQ0hFQ0tFUl9G
TEFHUz0tbQ0KPiBkdF9iaW5kaW5nX2NoZWNrJw0KPiBvbiB5b3VyIHBhdGNoIChEVF9DSEVDS0VS
X0ZMQUdTIGlzIG5ldyBpbiB2NS4xMyk6DQo+IA0KPiB5YW1sbGludCB3YXJuaW5ncy9lcnJvcnM6
DQo+IA0KPiBkdHNjaGVtYS9kdGMgd2FybmluZ3MvZXJyb3JzOg0KPiAuL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9oeXBlcnZpc29yL21lZGlhdGVrLGdlbmllem9uZS0NCj4gaHlw
LnlhbWw6ICRpZDogcmVsYXRpdmUgcGF0aC9maWxlbmFtZSBkb2Vzbid0IG1hdGNoIGFjdHVhbCBw
YXRoIG9yDQo+IGZpbGVuYW1lDQo+ICAgICAgICAgZXhwZWN0ZWQ6IA0KPiBodHRwczovL3VybGRl
ZmVuc2UuY29tL3YzL19faHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvaHlwZXJ2aXNvci9t
ZWRpYXRlayxnZW5pZXpvbmUtaHlwLnlhbWwqX187SXchIUNUUk5LQTl3TWcwQVJidyFqb0lPWGJJ
Q003VUd2eTNYQkVKdmZ6U0tPN3M2MWVmQjg3X05YNWNxcFVxcHU1b3Q1Y3V6dzUwQTgtOGxlZFpU
OV83aWZzQjJzS3p4U0QwJA0KPiANCj4gZG9jIHJlZmVyZW5jZSBlcnJvcnMgKG1ha2UgcmVmY2hl
Y2tkb2NzKToNCj4gDQo+IFNlZSANCj4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9q
ZWN0L2RldmljZXRyZWUtYmluZGluZ3MvcGF0Y2gvMjAyMzA0MjgxMDM2MjIuMTgyOTEtMy15aS1k
ZS53dUBtZWRpYXRlay5jb20NCj4gDQo+IFRoZSBiYXNlIGZvciB0aGUgc2VyaWVzIGlzIGdlbmVy
YWxseSB0aGUgbGF0ZXN0IHJjMS4gQSBkaWZmZXJlbnQNCj4gZGVwZW5kZW5jeQ0KPiBzaG91bGQg
YmUgbm90ZWQgaW4gKnRoaXMqIHBhdGNoLg0KPiANCj4gSWYgeW91IGFscmVhZHkgcmFuICdtYWtl
IGR0X2JpbmRpbmdfY2hlY2snIGFuZCBkaWRuJ3Qgc2VlIHRoZSBhYm92ZQ0KPiBlcnJvcihzKSwg
dGhlbiBtYWtlIHN1cmUgJ3lhbWxsaW50JyBpcyBpbnN0YWxsZWQgYW5kIGR0LXNjaGVtYSBpcyB1
cA0KPiB0bw0KPiBkYXRlOg0KPiANCj4gcGlwMyBpbnN0YWxsIGR0c2NoZW1hIC0tdXBncmFkZQ0K
PiANCj4gUGxlYXNlIGNoZWNrIGFuZCByZS1zdWJtaXQgYWZ0ZXIgcnVubmluZyB0aGUgYWJvdmUg
Y29tbWFuZCB5b3Vyc2VsZi4NCj4gTm90ZQ0KPiB0aGF0IERUX1NDSEVNQV9GSUxFUyBjYW4gYmUg
c2V0IHRvIHlvdXIgc2NoZW1hIGZpbGUgdG8gc3BlZWQgdXANCj4gY2hlY2tpbmcNCj4geW91ciBz
Y2hlbWEuIEhvd2V2ZXIsIGl0IG11c3QgYmUgdW5zZXQgdG8gdGVzdCBhbGwgZXhhbXBsZXMgd2l0
aCB5b3VyDQo+IHNjaGVtYS4NCj4gDQoNCk5vdGVkLCB3ZSd2ZSBydW4gdGhlIHlhbWwgY2hlY2sg
YW5kIHdlIGFyZSBnb2luZyB0byByZS1zdWJtaXQgdGhlDQpsYXRlc3QgdmVyc2lvbiBpbiB2My4N
Cg==
