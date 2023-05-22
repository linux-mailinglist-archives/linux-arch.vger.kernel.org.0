Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A86A70B41B
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 06:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjEVEcx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 00:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjEVEcw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 00:32:52 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5CE99;
        Sun, 21 May 2023 21:32:49 -0700 (PDT)
X-UUID: afd39aa0f85911edb20a276fd37b9834-20230522
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=afzNTNf9oU177E0A05IiLXRHFOonUReV5R21OIuFpJY=;
        b=nO75/tPAY4nwDwiSf9/ctHo8YwyY0EddgvZVVVBBVelUXL/9dJZvzzP4VMz7cI4dhH0eZIK4CdNF+w1APOXOdIlxsyaizhhSMRlmGHtAkuyw+HUp3+36RraN5C9Mc2FMIsVsQkBlljimh6WrD+R0rVAyT0ofNpucqc02wYeGD2Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:f7d393c2-22f1-4f96-9d9b-e68fdca8bcd0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.25,REQID:f7d393c2-22f1-4f96-9d9b-e68fdca8bcd0,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:d5b0ae3,CLOUDID:d4a38f6c-2f20-4998-991c-3b78627e4938,B
        ulkID:230522123243KXPAI7EJ,BulkQuantity:0,Recheck:0,SF:19|17|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
        SA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: afd39aa0f85911edb20a276fd37b9834-20230522
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 953454305; Mon, 22 May 2023 12:32:40 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 22 May 2023 12:32:39 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 22 May 2023 12:32:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwlAfIuNCxPuJ9nycXC46jsDYtLKw7MJfDn6e5pQwQ6N3lxJpBoxT2jqy9a1efFMMFT4S+LrvO3UoItVOUn4GH2cdDG5NUkbAw/+xc2+d3gS2bYWtAOnYHmjN8/h8p6ISwkTTGjBTeTvtDY04Kx39SI0fWrUFBoTPnlj6r1KI8g9C98UnD3VDMglrv3P1AK0Y5dDHQNfNVyD+L8MQQAj5wcEE+ZYMl06zkpmWdSod/JvlLXAiy1v6ID061pYNdocQ6rWj+x79/pV3oKUh6BNgVvHJZJjC6OEAhy4L1/Srqip+NeBLiUJxrV3U5kX9/g8ST16h7IzNzhccWmHi69nyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afzNTNf9oU177E0A05IiLXRHFOonUReV5R21OIuFpJY=;
 b=BRMEh8Ui6YL9/Q3d8/PW4c2B6dD2+K14Cj3Vbrcmj0btfWWGYAlzt+2cbEccxrxTGHrtFeaG6kRUsQXNm7Flwdps1UTU+EdvPei3BP4TBkBphMfj3jWNHV7KPR2uswusujpr1pjU5zCHbWTACa1UL7TKl+GgSsEv+diPRQbeVbZDvKRbFV4Qw/xlOg0DDzLAztl9EVFbLmRQ+YkGPWwAcu2vYz38QppqeKVl4cA+njSOhNa+hnjNfJyOOseyQXcUq05KsJMSEsNyXEai9rirG2FBGEMFV32PZ+jmxYd/wbaoRfBAXuRkq/XrN1ioEUPkyfMIZD4ofJID1MDYlozfCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afzNTNf9oU177E0A05IiLXRHFOonUReV5R21OIuFpJY=;
 b=WEUXrE/U3tDZTAcc56lsg2SJk3GtwhTXj6E3YnbbtKA2oPNNcN2XzaTClCUrwR/7SCkpQG7tWpbZMpy0o88o6vtoAvnr9vRnpuldIK/Dn9OdT5Oj7tzFJYSeJCHXVMlhPHV2npirPXjzO2GQHxpDmTeTEWq7kLFq2Qtum334XyQ=
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com (2603:1096:4:14f::8) by
 KL1PR03MB7501.apcprd03.prod.outlook.com (2603:1096:820:99::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.20; Mon, 22 May 2023 04:32:36 +0000
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b]) by SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b%9]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 04:32:36 +0000
From:   =?utf-8?B?WWktRGUgV3UgKOWQs+S4gOW+tyk=?= <Yi-De.Wu@mediatek.com>
To:     "maz@kernel.org" <maz@kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>,
        =?utf-8?B?TVkgQ2h1YW5nICjojormmI7ouo0p?= <MY.Chuang@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?WWluZ3NoaXVhbiBQYW4gKOa9mOepjui7kik=?= 
        <Yingshiuan.Pan@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
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
        "yipei.chang@gmail.com" <yipei.chang@gmail.com>,
        =?utf-8?B?U2hhd24gSHNpYW8gKOiVreW/l+elpSk=?= 
        <shawn.hsiao@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <Miles.Chen@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        =?utf-8?B?SXZhbiBUc2VuZyAo5pu+5b+X6LuSKQ==?= 
        <ivan.tseng@mediatek.com>,
        =?utf-8?B?WmUteXUgV2FuZyAo546L5r6k5a6HKQ==?= 
        <Ze-yu.Wang@mediatek.com>, "arnd@arndb.de" <arnd@arndb.de>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v2 5/7] virt: geniezone: Add irqchip support for virtual
 interrupt injection
Thread-Topic: [PATCH v2 5/7] virt: geniezone: Add irqchip support for virtual
 interrupt injection
Thread-Index: AQHZeb1n+Te8Qxm6rku5UO/fybejz69BE5YAgBU9HgCAAAjUAIAABzgAgAAcB4CAD1yagA==
Date:   Mon, 22 May 2023 04:32:36 +0000
Message-ID: <0df5f0f601e0177e64b65e643affd46939e231f6.camel@mediatek.com>
References: <20230428103622.18291-1-yi-de.wu@mediatek.com>
         <20230428103622.18291-6-yi-de.wu@mediatek.com>
         <f1c8c1c1c091be87dfbc27b9178fc3e6@kernel.org>
         <762e3494ed468f0337b1c336615065b154396d23.camel@mediatek.com>
         <86wn1em1hx.wl-maz@kernel.org>
         <fa864743c550ecd0a0c8052bfe7fddcc3f9be15c.camel@mediatek.com>
         <86sfc1na84.wl-maz@kernel.org>
In-Reply-To: <86sfc1na84.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6167:EE_|KL1PR03MB7501:EE_
x-ms-office365-filtering-correlation-id: 0b2ce5e7-4168-44dd-d6d6-08db5a7d919e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gnpMEa5ocNF2g3w9zIfYeI3v4+i2X5LG4ERwkgDSjiLBEVMkl3MtEZRRGqIMc2oONf/8HrfvEk9BppxyfjRATtmb9iTXFgePxyNDfRmuuJ+Qaq9DKHb4bDtRfm5G9/UwWNfjiHMWpqW4x4xrO9sgxXj+vL4L3ECjHKVyj7ISoBhcvh0XQtu1Tmpv8jfuxFWnRRYhoc4w/VYboih3u0Yyld2wGp7o48w4HsZzNcnFDxkqldxGhYBK17DM0hKFTUMGrkAUj7rJo7QzDZnwCG/d38UygcVzq9EfnrdX2k1SzfwugJs5Wy7zIfMYEqS+hHvNXZwF9xlp9aysKCdDYJkMq/dNtXS7aNDhaCMRdXi4lEjnI8JPFlce3EayIAAANMZnyc2Gsb0t4wD10aancDQb4V5Z5vYyKTqEPw1WEN1ZD6XXjgOWr9dd8hvlxtGtiwCJNKgEe6kglpQvu2lM6Odq56P3mMiEheBxpG5k6v1oy7rJ3dFrN19G1qg2+BLYR9HZxtKrhJ136ZGwM/OF4GSSGsgXQUrXR0IBLdnMdI8lE/fiHfSgIYoHPcRoCj75GfuwwYYfDawmc67uSp/ll1/GscWfs9UY7Eik8XRpty8VweCOV95ypXR5zzHAMpRF2ZPw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6167.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199021)(122000001)(38100700002)(36756003)(85182001)(38070700005)(86362001)(53546011)(2906002)(6512007)(6506007)(8936002)(26005)(7416002)(186003)(8676002)(41300700001)(2616005)(66946007)(54906003)(478600001)(66556008)(316002)(66476007)(64756008)(5660300002)(66446008)(71200400001)(6916009)(4326008)(6486002)(76116006)(91956017)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2JDeDN2NHpLNEJlbzMrM1JlV013Q2VSeTcySnU0N2UvZGV1NGpZRmU4TXYv?=
 =?utf-8?B?akZzS2dnN2JxSEhucVhhMXdiVDlsS0I5ckhnTGsyZms1Q3VVaE5xUWRTWStJ?=
 =?utf-8?B?cHJCSTVHeVQ1ZXJqUmV4cmpjczNEQWdBdWg3dkFkUUtLS2hrM1dqdk51Zk9B?=
 =?utf-8?B?M0hWUlprQWUvd2V0cWhzZjVDN3U1TFdlRUp4eFVmSExnTU91ano0THpvUjho?=
 =?utf-8?B?YXUzWDRNZkRRT1ltYUkvajJJaW9hbG56S0tUeSs4SWg5OCtaVHFHem44SU1z?=
 =?utf-8?B?Unk1T2hETEFqbHc0RnhRTU9hRnpreWlodkpzQ0lYMGJkeXlsOGwvQkpUc1Rj?=
 =?utf-8?B?V1FPZ1Faa2VBRFN3V2tmTGN2VHI5OXNhWUdEZ21WaHl4Y0gwR2ZNa1ZDLzRK?=
 =?utf-8?B?ZlVHUXNKR0RSNFpDZXovQ0trcUZaVVJNRlFiYjRYcmlLMTRPOFl3eFpTRTRF?=
 =?utf-8?B?WW5jWHdYYUowb2JIV3V5ckt4TEZGSHdsRlF1WkZ6R2huV0YrMzcrYWVNUVQv?=
 =?utf-8?B?eDE5WWhkRGZFTWlRTWlBelgxTS8rdVIvTHNpRzBsenF3RG9URGhEeXppZDJk?=
 =?utf-8?B?WDI4RHJQNStXVnlveXNucHlrMGtZODByR3k0OGdRd1pHaGswaWtSMW8xMGRv?=
 =?utf-8?B?aUtWZWNrdHZUcUFWUVZMZzFLeFNqVmVtb25SQlFMdnlhU0k5Z3Q0NFF2SkxJ?=
 =?utf-8?B?cmJKNkRTejFBSWdKeWpYdXhwSDlRUDk5YTJLbmZPMURqZlB3L0xDRE1kZHJL?=
 =?utf-8?B?a0xYclJWbjJpb1FHMEMyYXA2NTJMTSsyYmc0MWtvK1dadjBVNTk1czllS0Zu?=
 =?utf-8?B?SkxjYXBoT3A3bzgrSkllb1lEK2V0RHE3cDFabkc2RlJDcUtld2VBaUhsZW5T?=
 =?utf-8?B?a1VQczh1WEZJYUorczBKejhMd1lyeDNEL25lUWwzWWRHdi9TNXJucUMwWDlM?=
 =?utf-8?B?VThYVTNNeGhUNHkrQW82dU4vUExpaUNpQUx6ZlcyRVNGejgzTTlxNnpaU2lR?=
 =?utf-8?B?d08ydWgwaXBMc050ckxvWEVyNWREeDRocnJHR3dsTmZQOCtDTXZIRFhoZjdn?=
 =?utf-8?B?dUJUTGlLUWJmeVIwSUh0NUxFd3NHMGovRENXZGJraUxwclFsWXQ4U3BYdnRl?=
 =?utf-8?B?SDZFeVl4OTdQbFFzMEUwSUhVN0p5UlhtTDd4aWtUR2J4TFJnblRWc1BLMVky?=
 =?utf-8?B?Wk5JZ3VnYWwzVzVqWkxOT1lYTkZoUjE5Z0UvR0RDamEyNFhJN2hOOHlzdEVK?=
 =?utf-8?B?cVVuQlMzOHc5Mkc0U3ZyamlzOVNGaHZiVlRIU0RHVzZDYnhDR010V1BXUDZM?=
 =?utf-8?B?c0RsY0NUc3RJSGxweVlPTERqWjdxdElGMWlubmxkNVBBaGhBY3ozT1pEVVZo?=
 =?utf-8?B?U2l6UjNuR3AvMFZpNDFNd1pzZkVrbVdsYTNwMEhmOEpzTDdCc2IvZWc4R3hC?=
 =?utf-8?B?ZmN1VDN1WkNzemN2M29CM01EZnNwYWx2c0Zpc2JjdlZXell0NzIvQ2wzd3Fr?=
 =?utf-8?B?UFZoK3pRa1JpVmFaTFFVc1hyVzRDVGc5aDNibmVhSXFYZ28vbWlLZGI1Zy9F?=
 =?utf-8?B?ZS93Y3AwSTU4M3J0S3dIOHVqeGhnaitIUzlxSkhPblhQUnZWbWgxMHN1VmQ4?=
 =?utf-8?B?aWUxSUQ2Z20zMjVJRkVzckwwM00zOTQzV3BaNTdUZHNYajM5YWxMcGFJK2Yr?=
 =?utf-8?B?dzRMWjgyVFRjS2FobDh2bkhSbEtLbUJjUDF4Y1J5KzNjTE9WWXpyeDV2L2xU?=
 =?utf-8?B?c05rOFR3WnkwVm9vYnQvRWJDZit2ajFrR1pFTUhORCtaN0N5RlArWFVqc0Jx?=
 =?utf-8?B?d2U5ZXpHZFk0LzAzY3ZVWEx4VXBya2FBdE52TExBTE9QTE1qU1FvNkJuS1Bv?=
 =?utf-8?B?WTUyUlkzWnlwb2t2QlUvczFJcm1KMW1rYkJTL2VMb1JmYnlBL3FUQk5QTE04?=
 =?utf-8?B?eTdtS2hlZGZJMGdsK1NaVm9XQ0xOMWYrUjV3bnluVFFHUVhlQklRQ1M4VndW?=
 =?utf-8?B?bHE3L2tKTWc1TTZDL2ZEd1pVaVAxS2MrZDYxZHBtOFp5RjFsUEZwcHJ3Rmds?=
 =?utf-8?B?MkVVOThPd2RNeU1rWXJicXI1dVZ5dSt6R09udWpBMXFVSy9mREpBS1I0a1Nh?=
 =?utf-8?B?T0ZwN05lREY1eFNGUXNaZmd1b1NJMS9zMWExOFc2bTVjaXlkSFZ2VXFxVHVC?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F07D5C19E92E114FB5D2166F40CAB6B6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6167.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2ce5e7-4168-44dd-d6d6-08db5a7d919e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 04:32:36.3128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: giZozP9KN4Q2cHVBeepKDxc4MWT1d03H/gbp19vJRLc7jfAD0hcFfuNeiAxDxMExlICtzzh2xI+5US1NK5jBMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7501
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTA1LTEyIGF0IDEwOjU3ICswMTAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuDQo+IA0KPiANCj4gT24gRnJpLCAxMiBNYXkgMjAyMyAwOToxNjo1OCArMDEwMCwNCj4gIllp
LURlIFd1ICjlkLPkuIDlvrcpIiA8WWktRGUuV3VAbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPiAN
Cj4gPiBPbiBGcmksIDIwMjMtMDUtMTIgYXQgMDg6NTEgKzAxMDAsIE1hcmMgWnluZ2llciB3cm90
ZToNCj4gPiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzDQo+ID4gPiB1bnRpbA0KPiA+ID4geW91IGhhdmUgdmVyaWZpZWQgdGhl
IHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBPbiBGcmksIDEy
IE1heSAyMDIzIDA4OjE5OjMxICswMTAwLA0KPiA+ID4gIllpLURlIFd1ICjlkLPkuIDlvrcpIiA8
WWktRGUuV3VAbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IE9uIEZyaSwg
MjAyMy0wNC0yOCBhdCAxOTo1OSArMDEwMCwgTWFyYyBaeW5naWVyIHdyb3RlOg0KPiA+ID4gPiA+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuDQo+ID4g
PiA+ID4gYXR0YWNobWVudHMNCj4gPiA+ID4gPiB1bnRpbA0KPiA+ID4gPiA+IHlvdSBoYXZlIHZl
cmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gT24gMjAyMy0wNC0yOCAxMTozNiwgWWktRGUgV3Ugd3JvdGU6DQo+ID4gPiA+
ID4gPiBGcm9tOiAiWWluZ3NoaXVhbiBQYW4iIDx5aW5nc2hpdWFuLnBhbkBtZWRpYXRlay5jb20+
DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEVuYWJsZSBHZW5pZVpvbmUgdG8gaGFuZGxlIHZp
cnR1YWwgaW50ZXJydXB0IGluamVjdGlvbg0KPiA+ID4gPiA+ID4gcmVxdWVzdC4NCj4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWWluZ3NoaXVhbiBQYW4gPHlpbmdzaGl1
YW4ucGFuQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFlpLURlIFd1
IDx5aS1kZS53dUBtZWRpYXRlay5jb20+DQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ICBh
cmNoL2FybTY0L2dlbmllem9uZS9NYWtlZmlsZSAgICAgICB8ICAyICstDQo+ID4gPiA+ID4gPiAg
YXJjaC9hcm02NC9nZW5pZXpvbmUvZ3p2bV9hcmNoLmMgICAgfCAyNCArKysrKystLQ0KPiA+ID4g
PiA+ID4gIGFyY2gvYXJtNjQvZ2VuaWV6b25lL2d6dm1fYXJjaC5oICAgIHwgMTEgKysrKw0KPiA+
ID4gPiA+ID4gIGFyY2gvYXJtNjQvZ2VuaWV6b25lL2d6dm1faXJxY2hpcC5jIHwgODgNCj4gPiA+
ID4gPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ID4gPiAgZHJpdmVy
cy92aXJ0L2dlbmllem9uZS9nenZtX3ZtLmMgICAgfCA3NQ0KPiA+ID4gPiA+ID4gKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ID4gPiA+ID4gPiAgaW5jbHVkZS9saW51eC9nenZtX2Rydi5oICAg
ICAgICAgICAgfCAgNCArKw0KPiA+ID4gPiA+ID4gIGluY2x1ZGUvdWFwaS9saW51eC9nenZtLmgg
ICAgICAgICAgIHwgMzggKysrKysrKysrKysrLQ0KPiA+ID4gPiA+ID4gIDcgZmlsZXMgY2hhbmdl
ZCwgMjM1IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+ID4gPiA+ID4gPiAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvZ2VuaWV6b25lL2d6dm1faXJxY2hpcC5jDQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gWy4uLl0NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ICsrKyBiL2FyY2gv
YXJtNjQvZ2VuaWV6b25lL2d6dm1faXJxY2hpcC5jDQo+ID4gPiA+ID4gPiBAQCAtMCwwICsxLDg4
IEBADQo+ID4gPiA+ID4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4g
PiA+ID4gPiA+ICsvKg0KPiA+ID4gPiA+ID4gKyAqIENvcHlyaWdodCAoYykgMjAyMyBNZWRpYVRl
ayBJbmMuDQo+ID4gPiA+ID4gPiArICovDQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArI2lu
Y2x1ZGUgPGxpbnV4L2lycWNoaXAvYXJtLWdpYy12My5oPg0KPiA+ID4gPiA+ID4gKyNpbmNsdWRl
IDxrdm0vYXJtX3ZnaWMuaD4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBOQUsuDQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gVGhlcmUgaXMgbm8gd2F5IHlvdSBjYW4gcmVseSBvbiBhbnl0aGluZyBmcm9t
IEtWTSBpbg0KPiA+ID4gPiA+IHlvdXIgb3duIGh5cGVydmlzb3IgY29kZS4NCj4gPiA+ID4gPiAN
Cj4gPiA+ID4gDQo+ID4gPiA+IFNhbWUgd2l0aCBwcmV2aW91cyBkaXNjdXNzaW9uLCB3ZSdkIGxp
a2UgdG8gY29weSBvciByZW5hbWUgdGhlDQo+ID4gPiA+IHJlbGF0ZWQNCj4gPiA+ID4gcGFydCBm
cm9tIEtWTSBhbmQga2VlcCB0aGUgbWFpbnRhaW5hbmNlIGF0IG91ciBvd24gaWYgaXQncyBvay4N
Cj4gPiA+IA0KPiA+ID4gV2h5IGRvIHlvdSBuZWVkICpBTlkqIG9mIHRoZSBLVk0gc3R1ZmY/IFBs
ZWFzZSBmdWxseSBlbnVtZXJhdGUNCj4gPiA+IHRoZXNlDQo+ID4gPiBkZXBlbmRlbmNpZXMgYW5k
IHdoeSB5b3UgaGF2ZSB0aGVtLg0KPiA+ID4gDQo+ID4gPiBEaXJlY3RseSB1c2luZyBLVk0gc3R1
ZmYgZm9yIHNvbWV0aGluZyBjb21wbGV0ZWx5IHVucmVsYXRlZCBpcw0KPiA+ID4gbm90DQo+ID4g
PiBPSywNCj4gPiA+IGFuZCB3aWxsIG5ldmVyIGJlLg0KPiA+ID4gDQo+ID4gPiAgICAgICAgIE0u
DQo+ID4gPiANCj4gPiA+IC0tDQo+ID4gPiBXaXRob3V0IGRldmlhdGlvbiBmcm9tIHRoZSBub3Jt
LCBwcm9ncmVzcyBpcyBub3QgcG9zc2libGUuDQo+ID4gDQo+ID4gVGhlIHBhcnRpY3VsYXIgcGFy
dCB3ZSdkIGxpa2UgdG8gbGV2ZXJhZ2UgZnJvbSBLVk0gYXJlIGFzIGZvbGxvd2VkDQo+ID4gMS4g
YGdmbl90b19wZm5fbWVtc2xvdGAgdG8gY29udmVydCBndWVzdCBwaHlzaWNhbCBhZGRyZXNzKG9y
DQo+ID4gaW50ZXJtZWRpYXRlIHBoeXNpY2FsIGFkZHJlc3MpIHRvIHBoeXNpY2FsIGFkZHJlc3MN
Cj4gDQo+IFdoYXQgaXMgYSBtZW1zbG90IGluIHlvdXIgaHlwZXJ2aXNvcj8gSG93IGRvZXMgaXQg
cmVsYXRlIHRvIEtWTSdzPw0KPiBXaGF0IGFib3V0IHRoZSB1c2Ugb2Ygc3RydWN0IGt2bT8NCj4g
DQo+IEknbSBzb3JyeSwgYnV0IHlvdXIgdXNlIG9mICppbnRlcm5hbCogc3RydWN0dXJlcyBhbmQg
QVBJIHdvdWxkIG1ha2UNCj4gaXQNCj4gaW1wb3NzaWJsZSBmb3IgdXMgdG8gbWFrZSBhbnkgZnVy
dGhlciBjaGFuZ2Ugd2l0aG91dCBwb3RlbnRpYWxseQ0KPiBhZmZlY3RpbmcgeW91ciBoeXBlcnZp
c29yLiBXaGljaCBpcyBjbG9zZWQgc291cmNlIGFuZCB1bnRlc3RhYmxlLg0KPiANCj4gVG8gc3Vt
IGl0IHVwLCBJJ20gc3Ryb25nbHkgb3Bwb3NlZCB0byBhbnkgdXNlIG9mIHRoZXNlIGRhdGENCj4g
c3RydWN0dXJlcy4gIElmIHlvdSBjYW4gc3BvdCBzb21lIGNvbW1vbmFsaXRpZXMsIGV4cG9zZSB0
aGVtIGFzIGENCj4gMC1jb3N0IGFic3RyYWN0aW9uLiBCdXQgZG9uJ3QgdXNlIHRoZW0gYXMgaXMg
eW91ciBjb2RlLg0KPiANCj4gPiAyLiBnZXQgQVJNJ3MgbnVtYmVyIG9mIGludGVycnVwdCBvZiBk
aWZmZXJlbnQgdHlwZXMgZS5nLiBudW1iZXIgb2YNCj4gPiBTR0ksDQo+ID4gbnVtYmVyIG9mIFBQ
SS4uLmV0Yw0KPiANCj4gVGhlc2UgYXJlIGFyY2hpdGVjdHVyYWwgY29uc3RhbnRzLCBhbmQgeW91
IGNhbiBkZWZpbmUgeW91ciBvd24uIFRoYXQNCj4gd2lsbCBjb3N0IHlvdSBub3RoaW5nIGJ1dCBh
IGhhbmRmdWwgb2YgI2RlZmluZSwgYW5kIGtlZXAgdGhlIHR3bw0KPiBzdWJzeXN0ZW0gaW5kZXBl
bmRlbnQuDQo+IA0KPiAgICAgICAgIE0uDQo+IA0KPiAtLQ0KPiBXaXRob3V0IGRldmlhdGlvbiBm
cm9tIHRoZSBub3JtLCBwcm9ncmVzcyBpcyBub3QgcG9zc2libGUuDQoNCkFzIHBlciBkaXNjdXNz
aW9uLCB3ZSB3b3VsZCBkZWZpbmUgb3VyIG93biBjb25zdGFudHMgaGVyZSBhbmQga2VlcCB0aGUN
CnN1YnN5c3RlbSBpbmRlcGVkZW50Lg0K
