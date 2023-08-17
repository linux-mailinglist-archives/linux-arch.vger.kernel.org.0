Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C2377F142
	for <lists+linux-arch@lfdr.de>; Thu, 17 Aug 2023 09:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348478AbjHQHck (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Aug 2023 03:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348491AbjHQHcP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Aug 2023 03:32:15 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500ED1FC8;
        Thu, 17 Aug 2023 00:32:08 -0700 (PDT)
X-UUID: 276b44b83cd011eeb20a276fd37b9834-20230817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=X2Nip8z5B7X8ss1jGlDour46zh2QDQ4aEVBPa/I1xU0=;
        b=O6hlXgNGIj/RZbiGkR8tjTH7ls9jq1579Vn4jZirlPGTolfsCKvU0AGFPCwZ42qfQqvEQWrDB9TNvWsOq9iyFLQr/sRXmTNk26zDtitkCsHkWkfPXxxcKh6rFApFBD6symE3gBlgEWAwHYoPcyDSiqjAIU7PhP++7yumWAzJpSo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:ed806892-3fb2-42c8-992e-82096c2f8f42,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.31,REQID:ed806892-3fb2-42c8-992e-82096c2f8f42,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:0ad78a4,CLOUDID:9d4ba1ee-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:230817153201Z32LXEPA,BulkQuantity:0,Recheck:0,SF:19|48|29|28|17|102,
        TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:
        0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
        TF_CID_SPAM_ULS
X-UUID: 276b44b83cd011eeb20a276fd37b9834-20230817
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 13328519; Thu, 17 Aug 2023 15:32:00 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 17 Aug 2023 15:31:59 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 17 Aug 2023 15:31:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M28s3OhQBIlVfwXziZS0KDKeANAi90FT5DissQMMZVlawICgtdv/4bByyFgpyaQAjXymsiNRnxYiCXgrBUlxSLx5DSsveg77C30a02uMN/NOOltH6a84EDhG5aveNO6qSpBXbuq66dVX8IW+/jsDUWFzWw+SFC6VxmI5Gm4CaWgZoNJX1Ojo+fdkQ52lgA42lJHVQbkcIOYMYXDlZfHESOM2uFfj9fLE56BzRXp4fphw/wSCATUC9+EQfkv+ok2auz5kD8Db88NrCJ+Az6PznDbTExerf88nDC/+lyhOlb5jrXpgK1e2YvNyebLSmUVX56Pz/KKHedkdXLYTh1B8Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2Nip8z5B7X8ss1jGlDour46zh2QDQ4aEVBPa/I1xU0=;
 b=CQjIYGOHW14Rjr+3tzqiv/0xOXMTigpIYGI/XLK3llMsD/D97KzMxPYjpezInLL6b2+StAw1KALQVaaSisxA7LsNSyCS9EK4cIKEHdmSCsDbm8/x6y9F4+mU3qihOXV/Xk+5kWHls9tQn66k9fVOEJzrQ2SlUDUYSdUKgGN24fx0a2PoBwjx1vlpSyKnNlGUuJaOjBb3lL/ev/6jFYq1eLNRL11n/TIdAV6uJYS1gtlfIQLI79aupWgPWYgJkuUV8g2Rdt84zXhu6+NY3uil9PzwbtxXviabkjmbBpOR1lhsn8NJlOrzRKfs2WPIgqMB9WsfDRnMq7TDM73wRaJoQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2Nip8z5B7X8ss1jGlDour46zh2QDQ4aEVBPa/I1xU0=;
 b=BrUhSe9VN9IqoyBlqJ383P7SB+47crcxiFdusYRDRcqHPMexA9wiK7TqSTlvXF8jnclcLNSDJS8d7O+VHcUbBWCFm72hFsOKSRUndrxBD8aJFpuvCuQ98APU7jjHT0DWkaAOQrGYiKvXHcLV+wWp8hNdDog7zuNh1YvMcI/IfXI=
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com (2603:1096:4:14f::8) by
 SG2PR03MB6681.apcprd03.prod.outlook.com (2603:1096:4:1d0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Thu, 17 Aug 2023 07:31:57 +0000
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::a944:f5f3:d44f:8498]) by SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::a944:f5f3:d44f:8498%5]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 07:31:57 +0000
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
Thread-Index: AQHZwGB03EK4wPTFHUyhJ3nzDQrEXq/lZ6CAgAjRaoA=
Date:   Thu, 17 Aug 2023 07:31:56 +0000
Message-ID: <4b81b7fbd50c04958c27fbb6e620a15ae4fe0d54.camel@mediatek.com>
References: <20230727080005.14474-1-yi-de.wu@mediatek.com>
         <20230811165219.GA3593414-robh@kernel.org>
In-Reply-To: <20230811165219.GA3593414-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6167:EE_|SG2PR03MB6681:EE_
x-ms-office365-filtering-correlation-id: fe84396b-ac59-478a-4e7d-08db9ef40955
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UieZWoUrEzv4JCdvZi8FFZN6De4fEOTL1mHYAOjLonYe8KFS1qe8DzzRl2n5ezwzrk37sKzgfa9z/EFZbrzaCIP02xO3I7nfSxQ63BpGzkpwqSPYZ6NO6fVEQIweYNaqmUeL3xq9hY5DzE1bqsbL3id8cNoD11QiRr2TWAZBWz0r/wlnwQ4WacpjT5ygpI6JUP8om3op3ue3jOf64E9/gjmeKF+e1puMlie8AVGUQjOkzajiadHqO2Gq0+F9LsPawDxLOIq9ofQ8pNfNA4dSCozbmNE+1TNEjVDbtR7pS5zhFFwqv+QsDWEM5N/M/otU7UrQ9O1VI+a4ersWRdlwS2mM5kJoWI3CzIMbLJIVapG63TWh5ykfYMhPYzsdYl0MAhLg8BRvvCPEVWycpAJABCxtyOHdDHxKQUaB8PHil6IGvmGkSae/odU1nPM+kdzvsu6eIO42DJJx7NKR5W+c2BgM7tj6pMuPwvGcP5LWBkNJoy0VKULLTPBNkTKjf9RMDiPXAwf2uzoEcUVgdiqTjSntbla/Kq5Iyy4t8sz82VDpSanfIWGizlyt3BYdHSHWqrtpFrIOX0qaOsZo/ewFg9Lnnv3xJ/HpA52SVjzcJ0PNRJMWbF0YrXn0eJL76iSLCMXemTBogpbIrPGU+p3lYPIvmel5nODNWUHF9fh5zR2/Xgv8s8QcGBWGDGV4FcSaPmfd4ENG5ZiMlzjy3ApUD26akuPKQEK2OCB/0Bdmouc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6167.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199024)(1800799009)(186009)(83380400001)(2906002)(7416002)(86362001)(478600001)(6506007)(6486002)(36756003)(2616005)(71200400001)(107886003)(85182001)(6512007)(26005)(966005)(5660300002)(41300700001)(122000001)(76116006)(6916009)(54906003)(316002)(66556008)(66946007)(91956017)(66476007)(66446008)(64756008)(12101799020)(8936002)(8676002)(4326008)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTByZmRReGZIUGlSU21Nb082d3huM0phYWNRTWZJQlp6YVNDZTBtWlNWUytu?=
 =?utf-8?B?M1BkSnZyakpWd29XRVJQbThDTVBGODg3YlNkV0ZGVTVqNWhRVE5xTHZKZ04r?=
 =?utf-8?B?anViZGRkamFBckdBZlkvVEVQdHF5VnpPMDdubDB0WDc3T1lYQ2ozU2R4LzhY?=
 =?utf-8?B?dTBuSEh6dVJEQ1AwUXFWNHFSVC95YWlBTndaR2wyajM5cHVtSGY2N0M4c21m?=
 =?utf-8?B?dWFCd2o3K2dhVm83ZVFiQVVoYkk4RnJNKzd2VjJrV1p4MmIvYVV0aVV5Tyts?=
 =?utf-8?B?dEFlWVZZdUtieVFoWGdzcUFUQzRUZmh0MDA3T0piY3dDZytiMlRMaDVvRmpl?=
 =?utf-8?B?Q0VMbGcwK1hzTktQcXQ2Z1pBUUVRNVJpZjBiWnR2cGJXc2lnMVdPZndSNVFp?=
 =?utf-8?B?R1Y5MVVjbUdxTXE0QWtlRFZ6UnduRE1mVW4zNE52Z045eXhyRmF2cWtIeWdC?=
 =?utf-8?B?bENvN3ZpME9senIyRzBUZ3NEN3FNZy95S25UR2F1bk1TbVN0TDFJVTZ0YTFp?=
 =?utf-8?B?SHkzbmRYcHI0R25KS3FOazRlWXNIMHVnMlp5aXphZy91eVE5N2hxbjM2Vi9h?=
 =?utf-8?B?MjcrcFNrOUx4NGVQck9lRmV5ZnpkNU1iMDZxOVJFNGExVnJmMXBySHZGK3FP?=
 =?utf-8?B?Q1Q2MWpEZnFyR0NzcUlZdGlsSmVCQnZmU3cyd3NhMWlKbysyM1lwNTlOVFJR?=
 =?utf-8?B?anJFRkRDRWJNUGp1Y25FZHdEWUV1eks2SS9IT05tK1d1VmwyQkZGREo4cnZ3?=
 =?utf-8?B?T0JwbXZkTWNsNDR4R2o0TjVDWFFxdk94cDlIK1lLRVNaeUtjcFVrWG16aUdh?=
 =?utf-8?B?VCtOd05iN250cWdGTWcyeHhxQ3M3d21ZaU5mTkh5enZFUlZ3OU9qaWRPSmZN?=
 =?utf-8?B?VExmdzd5R0dwUWJQNmlLaUU2S2Vwb0lmSWt1R2JLbmlJMDNmcmJGT1R6VEMw?=
 =?utf-8?B?QVFYbUk3VTZ4RFNvYjFZN25PTFhJY29PdkZ2dWtUdldqWEQvVzNzcko1Mnor?=
 =?utf-8?B?MWpSRmJTa3FrYU9ZRzJhL3JGdmNGNjFIZUJYU29nWDZiazJNaFdLMjFOdElj?=
 =?utf-8?B?ODloM25Fa1NnNFdZWm5PeE9rdFJRSmc2Y3REQ3FFMmJkeUZzRWRGVk8vMFd4?=
 =?utf-8?B?NWt1NUVSMm9UdTZlTm5XRlRIcDhHOEkrYWFmNmRKc2FpVVRqQnNMU1FNaXUv?=
 =?utf-8?B?TjRFdjYyN3pva3U4aVF4bzdNU3AwS2x4aFBXODlRYkFGQ1VKV25tRHRFUE9n?=
 =?utf-8?B?Wkl2UkNZNzE2M281dndmK3UvRkhxaFZud2VyTm5laHhFMVlvQU9kczdIQUtV?=
 =?utf-8?B?N2R0NG1wRC9kSzNtVUxISVFpUVVpMXMvVWkzcU5WalMzdFd0VEdkcVlhcSta?=
 =?utf-8?B?S3lDZms1QnYyZTRXMGZFd0lZYzVjN0YrS21GYS9CUjlQVkc0VXd3U3VKcXlJ?=
 =?utf-8?B?dkdFNnZibzVwcG8rWVRTSTQ2OHV5ZUZHUE9LODVoNlFSM215RXBBbHg0eHNQ?=
 =?utf-8?B?elBKaVRmcWNseEFVbmxIRjBaUkVObTRyZEZaUmpBOC9ybThaUDIxdC9IOVJB?=
 =?utf-8?B?MnNGTnBtZ2FieVF5T2o2bEU5WWx6V3BLcENaRmlJWE92QTJhbUQ5Tk8yWXps?=
 =?utf-8?B?SytEMEpPTndZaGRIdE5oYWhBNCszTVVEOUNMY2g0eWV5NjlTOVFPRWMyaHVX?=
 =?utf-8?B?WU1CcnlIdXE0N1NmYVEyZFVIUWVLQVFuR3g3OGVDVlE3am5tSEpLVEpwb1lM?=
 =?utf-8?B?YVJBazFmc0I3eS8xL1FYQzNERE5wTlNOUnFWd3lSYUVzSFA4dzdwV1VGR3hF?=
 =?utf-8?B?TXowbUV5ZFhicGNxNWNXSzR5bDh2c0ZxRXl3ZmptYllMa1BPeEFGeFBlbjY4?=
 =?utf-8?B?TXNiWldJYzExODhEREhBK2RQRllHaG16UFFKRi9SalhoVEdPUFE3MlJIMmdH?=
 =?utf-8?B?NzJ0cmZhbHoxVFBPZmpDdm1JMUFxZkJwNGNSUHJFR2J0SW04a21SZ0czdFJz?=
 =?utf-8?B?YVdyRjNpcFVwZGdldi9ienRwYTVySlhaWWd5N2FON3l1Ykk1cW1OQmFRSEIx?=
 =?utf-8?B?ZjhzNy8zM3RYcFNwUlQrS2pLanNNS3VSWmVZSTU2alhWaTR3TTdGdTQwU0RB?=
 =?utf-8?B?QVZqdVdCVUtzOTVrdGo0U0dGczNlWkNlUDVhOFFrNVB4UVBPalFBbVBMWmw2?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C57E6EA05CE7B4CB7CE6F0BE4BAEBA6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6167.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe84396b-ac59-478a-4e7d-08db9ef40955
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 07:31:56.8812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I7kmWIfHQNf/ENCM4tsVz1T5iJT785hYekmCIegIqst+epdP3xvLX/K+Dt+KtxUwXb556y9G3fvHjKrpMrzhgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6681
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTA4LTExIGF0IDEwOjUyIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ICBPbiBUaHUsIEp1bCAyNywgMjAyMyBhdCAwMzo1OTo1M1BNICswODAwLCBZ
aS1EZSBXdSB3cm90ZToNCj4gPiBUaGlzIHNlcmllcyBpcyBiYXNlZCBvbiBsaW51eC1uZXh0LCB0
YWc6IG5leHQtMjAyMzA3MjYuDQo+ID4gDQo+ID4gR2VuaWVab25lIGh5cGVydmlzb3IoZ3p2bSkg
aXMgYSB0eXBlLTEgaHlwZXJ2aXNvciB0aGF0IHN1cHBvcnRzDQo+IHZhcmlvdXMgdmlydHVhbA0K
PiA+IG1hY2hpbmUgdHlwZXMgYW5kIHByb3ZpZGVzIHNlY3VyaXR5IGZlYXR1cmVzIHN1Y2ggYXMg
VEVFLWxpa2UNCj4gc2NlbmFyaW9zIGFuZA0KPiA+IHNlY3VyZSBib290LiBJdCBjYW4gY3JlYXRl
IGd1ZXN0IFZNcyBmb3Igc2VjdXJpdHkgdXNlIGNhc2VzIGFuZCBoYXMNCj4gPiB2aXJ0dWFsaXph
dGlvbiBjYXBhYmlsaXRpZXMgZm9yIGJvdGggcGxhdGZvcm0gYW5kIGludGVycnVwdC4NCj4gQWx0
aG91Z2ggdGhlDQo+ID4gaHlwZXJ2aXNvciBjYW4gYmUgYm9vdGVkIGluZGVwZW5kZW50bHksIGl0
IHJlcXVpcmVzIHRoZSBhc3Npc3RhbmNlDQo+IG9mIEdlbmllWm9uZQ0KPiA+IGh5cGVydmlzb3Ig
a2VybmVsIGRyaXZlcihnenZtLWtvKSB0byBsZXZlcmFnZSB0aGUgYWJpbGl0eSBvZiBMaW51eA0K
PiBrZXJuZWwgZm9yDQo+ID4gdkNQVSBzY2hlZHVsaW5nLCBtZW1vcnkgbWFuYWdlbWVudCwgaW50
ZXItVk0gY29tbXVuaWNhdGlvbiBhbmQNCj4gdmlydGlvIGJhY2tlbmQNCj4gPiBzdXBwb3J0Lg0K
PiA+IA0KPiA+IENoYW5nZXMgaW4gdjU6DQo+ID4gLSBBZGQgZHQgc29sdXRpb24gYmFjayBmb3Ig
ZGV2aWNlIGluaXRpYWxpemF0aW9uDQo+IA0KPiBXaHk/IEl0J3MgYSBzb2Z0d2FyZSBpbnRlcmZh
Y2UgdGhhdCB5b3UgZGVmaW5lIGFuZCBjb250cm9sLiBNYWtlDQo+IHRoYXQgDQo+IGludGVyZmFj
ZSBkaXNjb3ZlcmFibGUuDQo+IA0KPiBSb2INCg0KaGkgUm9iLA0KDQpMZXQgbWUgcmVjYXAgYSBi
aXQgYWJvdXQgdGhpcyBhcyB5b3UgbWlnaHQgbm90IG5vdGljZSBvdXIgcHJldmlvdXMNCnJlc3Bv
bnNlWzFdLiBJbiBvcmRlciB0byBkaXNjb3ZlciBvdXIgR2VuaWVab25lIGh5cGVydmlzb3IsIHRo
ZXJlIHdlcmUNCjIgc29sdXRpb25zIGJlaW5nIHRhbGtlZCBhYm91dCwgbmFtZWx5IHdpdGggZHQg
b3Igd2l0aG91dCBkdC4NCg0KVGhlIHJlYXNvbnMgd2UgdXNlIGR0IG5vdyB3ZXJlIGxpc3RlZCBp
biBzb21lIHByZXZpb3VzIG1haWwgdGhyZWFkWzJdLg0KSSdsbCBqdXN0IGNvcHkgdGhlIHN0YXRl
bWVudHMgaGVyZSBmb3IgYmV0dGVyIHN5bmMtdXAuDQotIEFsdGhvdWdoIGR0IGlzIGZvciBoYXJk
d2FyZSwgaXQncyBkaWZmaWN1bHQgdG8gZGlzY292ZXIgYSBzcGVjaWZpYw0KaHlwZXJ2aXNvciB3
aXRob3V0IHByb2Jpbmcgb24gYWxsIHN1YnN5c3RlbSBhbmQgdGh1cyBwb2xsdXRlIGFsbCBvZg0K
b3RoZXIgdXNlcnMgYXMgYSBjb25zZXF1ZW5jZS4NCi0gVGhlIEdlbmllWm9uZSBoeXBlcnZpc29y
IGNvdWxkIGJlIGNvbnNpZGVyZWQgYXMgYSB2ZW5kb3IgbW9kZWwgdG8NCmFzc2lzdCBwbGF0Zm9y
bSB2aXJ0dWFsaXphdGlvbiB3aG9zZSBpbXBsZW1lbnRhdGlvbiBpcyBpbmRlcGVuZGVudCBmcm9t
DQpMaW51eGlzbS4NCg0KSW4gY29udHJhc3QgdG8gdGhlIHNvbHV0aW9uIHdpdGggZHQsIHdoYXQg
d2Ugd2VyZSBkb2luZyB3YXMgcHJvYmluZyB2aWENCmh5cGVyY2FsbCB0byBzZWUgd2hldGhlciBv
dXIgaHlwZXJ2aXNvciBleGlzdHMuDQpIb3dldmVyLCB0aGlzIGNvdWxkIHJhaXNlIHNvbWUgY29u
Y2VybnMgYWJvdXQgInBvbGx1dGluZyBhbGwgc3lzdGVtcyINCmV2ZW4gZm9yIHRob3NlIHN5c3Rl
bXMgd2l0aG91dCBHZW5pZVpvbmUgaHlwZXJ2aXNvciBlbWJlZGRlZFszXS4NCg0KV2UncmUgd29u
ZGVyaW5nIGlmIHRoZXJlJ3MgYW55IHNwZWNpZmljIGltcGxlbWVudGF0aW9uIGluIG1pbmQgZnJv
bQ0KeW91ciBzaWRlIHRoYXQgd2UgY291bGQgaW5pdGlhbGl6ZSBvdXIgZGV2aWNlIGluIGEgZGlz
Y292ZXJhYmxlIG1hbm5lcnMNCndoaWxlIG5vdCBhZmZlY3Rpbmcgb3RoZXIgc3lzdGVtcy4gV2Un
bGwgYXBwcmVjaWF0ZSBmb3IgdGhlIGhpbnQuDQoNClJlZ2FyZHMsDQoNClJlZmVyZW5jZQ0KMS4g
DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMTRjMDM4MWJlMzhlYTQwZmNkMDMxMDRiZmYz
MmJjYWEwOWI5MjBkMy5jYW1lbEBtZWRpYXRlay5jb20vDQoyLiANCmh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xrbWwvZWE1MzFiYTgwZGI2N2NjY2IwM2VhMTczZTcxNGZlODY4Zjg2OWU5MS5jYW1l
bEBtZWRpYXRlay5jb20vDQozLiANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yZmUwYzdm
OS01NWZjLWFlNjMtMzYzMS04NTI2YTAyMTJjY2RAbGluYXJvLm9yZy8NCg0KUmVnYXJkcywNCg==
