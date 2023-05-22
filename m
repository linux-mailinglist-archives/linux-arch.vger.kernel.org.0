Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BD670B3DD
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 05:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjEVDpe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 May 2023 23:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjEVDpd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 May 2023 23:45:33 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136EDC2;
        Sun, 21 May 2023 20:45:30 -0700 (PDT)
X-UUID: 16b985cef85311ed9cb5633481061a41-20230522
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=dRKQ7rgoI8W9UCSPJq6UKbSmLg/rrIiHPNb4qvCyMP0=;
        b=lquestw8t42KRYAeZw076412src+mDQnuCifd4su3jeLbGXlMiODmestCd1aXhuXywjEa+xk50OasElzNK2/w6s9IR/t+1Vqbqdcp6wlQTTObs/RfGMxAyvmnJ5Y1DIiHucKTmpnhORPFjAbNMRcRjIWxH0SVXOsX6wJJAo1nuI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:a3064ee1-95bc-454a-ab5d-21b956b3e76b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.25,REQID:a3064ee1-95bc-454a-ab5d-21b956b3e76b,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:d5b0ae3,CLOUDID:aa038e6c-2f20-4998-991c-3b78627e4938,B
        ulkID:230522112902IMI6PLM6,BulkQuantity:7,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0
        ,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 16b985cef85311ed9cb5633481061a41-20230522
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 359329987; Mon, 22 May 2023 11:45:26 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 22 May 2023 11:45:25 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 22 May 2023 11:45:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ap3+1w6UG2suSoW1MRbx64dDfKyk+ZWJgssyuUl+Dkghm84F947GSnEOt72GUoi/2toVAx9/mJBlYhGEnAVytPLpcg7yJWn4tqQ7Cl+obAsasAcLe/PfMvkMBYP3QCcIYxd4WLKBYHPY+jQHQaMpi6oPmv7Mh6+uFYCsJEGi68W/YTA5woW52WEYaK22IS1NWvmNlohaK3/eCs9ILgSwp4IhzDHuja9MRKnTn/E9C/LqFAx+XSYXW+cIweCY8NB7rt8pGlGf1sWrcH3gElsLcZb2++nMG9zDkLAS1kJhURtzLKkooFPPLUsZ93XHOr8iH8+4u4PIAlxZwiHwWcB4tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRKQ7rgoI8W9UCSPJq6UKbSmLg/rrIiHPNb4qvCyMP0=;
 b=V6N2QJMSYkRtdQrRzHZER3AdzrpqCxSsgd6yq8jfbR5laZpUHOxgBqdJr4VD88n0TNJu7ZimVSqNLo9a4/PNnWQtSiB5sI0VcXJR3NA5yhNol9yRL+39jf2nt2ZO1UALDsL6A3/bPfJn1u//ciKbzyOPaWwFiK5sXDE+eoAp1bz4hztgswrfov1E1vXji1LD17dMu65xvH9maJ9c2iDafSP1AaM+lHv8IWGqtPNo+sJGmAWfikyvDUqMhCWt2g5rs/yGWEE/QJyhTjRWt9YziGeaMjUICaqxItB6NZPy6e+j0t+0GuluJfFCHtPdvm/PDeAIduoc2seB1pZcZH9QDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRKQ7rgoI8W9UCSPJq6UKbSmLg/rrIiHPNb4qvCyMP0=;
 b=T5mPLxNmaTFdPeOQeWzBq1g1Tss7cWc1NWmMGXvQ/4/QjtQV4wyGqSEf6CwB8njP4qQPRzJSIj5Yf33Kl5qXUdvWVRh+I0kP4Wf5I1j6tWs1CSjTdIV+680+5EjuJQAzoU7+cXq45x/YHw9DTtm5sASNm8lGjU9T1ZaH4b1Joyg=
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com (2603:1096:4:14f::8) by
 SI2PR03MB5499.apcprd03.prod.outlook.com (2603:1096:4:12a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28; Mon, 22 May 2023 03:45:23 +0000
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b]) by SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b%9]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 03:45:23 +0000
From:   =?utf-8?B?WWktRGUgV3UgKOWQs+S4gOW+tyk=?= <Yi-De.Wu@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?TVkgQ2h1YW5nICjojormmI7ouo0p?= <MY.Chuang@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        =?utf-8?B?WmUteXUgV2FuZyAo546L5r6k5a6HKQ==?= 
        <Ze-yu.Wang@mediatek.com>,
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
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?U2hhd24gSHNpYW8gKOiVreW/l+elpSk=?= 
        <shawn.hsiao@mediatek.com>,
        =?utf-8?B?WWluZ3NoaXVhbiBQYW4gKOa9mOepjui7kik=?= 
        <Yingshiuan.Pan@mediatek.com>,
        =?utf-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <Miles.Chen@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        =?utf-8?B?SXZhbiBUc2VuZyAo5pu+5b+X6LuSKQ==?= 
        <ivan.tseng@mediatek.com>
Subject: Re: [PATCH v2 2/7] dt-bindings: hypervisor: Add MediaTek GenieZone
 hypervisor
Thread-Topic: [PATCH v2 2/7] dt-bindings: hypervisor: Add MediaTek GenieZone
 hypervisor
Thread-Index: AQHZeb1mU9LdvrjJWkKKQBIpP+78BK9AzqOAgBV3voCAAKVugIAO4GEA
Date:   Mon, 22 May 2023 03:45:23 +0000
Message-ID: <7f5bfc415b20907a0a9553a3e15bb1053386a90a.camel@mediatek.com>
References: <20230428103622.18291-1-yi-de.wu@mediatek.com>
         <20230428103622.18291-3-yi-de.wu@mediatek.com>
         <168269352006.3076.11433928748883862569.robh@kernel.org>
         <c0b590711516f5bb0e9db688685e09a8e73abd5e.camel@mediatek.com>
         <169ecb01-0ab6-93d7-7350-0c551b69e7ae@quicinc.com>
In-Reply-To: <169ecb01-0ab6-93d7-7350-0c551b69e7ae@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6167:EE_|SI2PR03MB5499:EE_
x-ms-office365-filtering-correlation-id: 5d586256-1d87-4e40-6ee8-08db5a76f8e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /7aXSnqd5lKLkIiGmt8Gv+i8//kRSnsdFqHBCeSfu0fVkBRKBaw0442cfUMd/UJqc1hvyRCIEOkjuZZIz5nGb6j/Q32iu/g5oSpb5sgGOx35P6HNEwhrtYMFopcsngl8pz+tNo28/aQOfPty4vsSrCApLzi27izrMzeC+IPR6+dl5URpD4FKg6C3xwyVhSxaPomcMfgVwgHncaE/wHhauNIBXhR/FQERNvWi0j3q7DjYYidw2Cf1wqLLxSyvCzrpB6HVrL06LJedxSK3vh5KGgCuifgBBlZjIBloRN1wfwgll5bBhuTAFiEKZODoJnPJ44RkSq+XeoaneQL4m0ideIzgqgNuE0Y2wod6GO7WoEXXviwk0LXO42gzX5ZFKlmjiAGvJwGY+vStYmlLerouZomjzxw4wm5zlpRAb1Nfb+HtajHgX7PymIoD1jhK+UP10znzwFcnGYGtf3zJFnD5CALqz4EBeXao2dlKL1AeBpSLUVdcoR9kkhGQ48FSwCzEC+PMvS+kI6h9U6qDOH4WqskgjCkZ8H/Iflxqng819NsHWQQJbKN5Q22sF4ERDO7m7RSJqE0b2DINx9BU2NBAMsExPZxHLXgR6cFYq3KiZxTWiFyV04Yh35+riGb3GIRJ8ywkye0dV7weruPIezR93g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6167.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199021)(8676002)(8936002)(7416002)(5660300002)(83380400001)(53546011)(186003)(6512007)(6506007)(107886003)(26005)(2616005)(86362001)(122000001)(38100700002)(38070700005)(41300700001)(71200400001)(6486002)(478600001)(966005)(4326008)(64756008)(66446008)(76116006)(36756003)(66946007)(66556008)(66476007)(316002)(85182001)(54906003)(110136005)(91956017)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ky9KTm9rbWkvdU1TOUxyeVdGeWovOXlON2N3bWNiV2hjcHc0SGRrQmgybFFi?=
 =?utf-8?B?S0NKKzFYK1FJNGJqbmhwalBsUllxcHFFNkpGaXAzM0FxZDUvSHlrcVhVNkFW?=
 =?utf-8?B?SlU2VmxvL0lySm5HUGdINlIrMHJ3Tks1OGJRK1hKWjl2TkJ5TUFoMVBHSXhB?=
 =?utf-8?B?SU02V24yVXhlUXJqRjd1bmlkVzd6UUZnTS96TFJYWWtJSXdEdmRuU1dNRUQr?=
 =?utf-8?B?RU56QU1nc1RJdm5rV01VcitzSkxhNzJmYTNtV2NydFQwK2xpNmJ5MDZvNkV3?=
 =?utf-8?B?MEEvSGJNK3ZZRlp4ZzJBSkxuM0hDRnpQUThYL2V0WG5hdHFjWkszOHowQmlF?=
 =?utf-8?B?S2wyTDlHa1NCaVJvRnBEaE1UeFVUdG1Kc3RtSWZxSTFyTE1LdzFzbEhoNnRv?=
 =?utf-8?B?anFHamdmOHZWVGsweDF6a2F4VmNOQzdwczgwR0JnYjc0b0xpN2UxWmdmeElO?=
 =?utf-8?B?UFNYOGExdDdGN3FtY2ZJUjRVSU53QklGTC9FQ1IzQmlDamtTdW5rdVpGak16?=
 =?utf-8?B?NHVjV3BLYlFEOFF1VnRvVnI3eVliaXZyTmw4SVl0L1Bab2p2Wml3T29LWExl?=
 =?utf-8?B?a3dKU2JRQmUwd0dPRDZSQU5wZVVNd0lBYVV5WG5zMFBUUTdGZnFxR2FBYTNw?=
 =?utf-8?B?TE5jdGc4TU5tVWNSNG9sQTZuRnZ5bGxKYzdqZUIzcFhuNmJNWTZWNFpQQXZD?=
 =?utf-8?B?Ry9FWEt1TGdyNGloNWJjK0w1ajJWdFFHdVBBd0ttSUx4bCt4UGk1b1I0RVhW?=
 =?utf-8?B?VW9jNEhxVWxPa2ZxbFNzY3hSeUI4NGZRdHc5TkJUUWExRmlxcURGNHNIaWZJ?=
 =?utf-8?B?OFF6UnNYcXZwREY1d1A4OFl6TEpPMFdXcEs3c3N3Z3pTYlhVdHozdzhlSEFQ?=
 =?utf-8?B?ak1XbjlCNUxhK3BNdDFuMndFN0VRaE5XcDRqYTJUYW9wKzdaUWJCUXJJRC9V?=
 =?utf-8?B?bitMZDBkTEc4UWNNV0hMOGhkZUM3S1h0a1pjVjRvdTdDd0tlVjZVRG1EUlBB?=
 =?utf-8?B?aldSdFEzR2xoRnVjMHpEYlRsejFaYkZMdjgvMGt3QUJRS0xvKzQ5Nzhoa2F6?=
 =?utf-8?B?RkVaZVBKTTNibnF2aVN0elhHSVJQL3ZrVURyYWY1MDBVdlF0cytRelBBTktH?=
 =?utf-8?B?ZTN2OTBSbE5nSUJ1ektXT1N2amhaanhyV3hLNHoyU2hYem9IdjNJQzYyYnJj?=
 =?utf-8?B?cVBwVGhGeG9SdlhqMVBxeVErTmxJR21ncnkyN0F0T3ppc2h4ZUFXTzVDOW1N?=
 =?utf-8?B?Z3AxaytWVDVEZFRHZ294M1pxUk5sM1UzcnE3RStWaExpaXhvSXBoM25nZlND?=
 =?utf-8?B?UnROdkhHZVNsK29nd0dIN0xkUFNpM3NxS2NtYzVLbzk3SFU4Wm1VYm5xNDYw?=
 =?utf-8?B?WDY1cUlySHM1VUtZSS9sV0tEN0pDQVhPeXhVMGN3VlpDeWNzUVpsRC9Ca3Qr?=
 =?utf-8?B?VUxxWEVxVGpuUUxGTzFhdEdBU0ZyTXdYV3BaTTZwSUpzYVdSREZpdHhiN0Ex?=
 =?utf-8?B?UFVNZU51c0NKMndrRGJDWXdKYWFmY2NQM2RtTEc2NC9STXorajBZR29FSTVp?=
 =?utf-8?B?UGFkdWZMajlGc21VRTJUYUxTMDg3anVoRHZ4L0Q1WHJkeVEzTDFvOFdRMHhR?=
 =?utf-8?B?TExYQmQ1T3RCWVZFWHNwVTFaczQ2QUVVemMxNmFRZWtjQTY3ajNpdDV6RnJk?=
 =?utf-8?B?aUhkNkVTcWJpc3Qrck15K0lPMlpscmdhRkNkVWt2NnlyRTR4dWovNnNsNHpL?=
 =?utf-8?B?TVZGK3YvK0RpMklYS2pLUFJVTGhxNFhkd3IyMHNrMnZwUnFpRjJWWlhrZnla?=
 =?utf-8?B?ZktyNXhFamVZRHhJSC9RNlVCdzNua0VkWUZFZm9ibU5pVjM0WmUxaEI1dkRY?=
 =?utf-8?B?aTl5V3RjK0hEYVZxSm14M3EvMjBOdC81QkhDaDZheVFYaGhTY3E0eEpjbnFr?=
 =?utf-8?B?OUg2ZjUyaHdsVFNJRVpoWTBLcXMzcFphOHVvckJhc0w3R3ZHQWpBQXB6aW9B?=
 =?utf-8?B?dnNGTjh1RFhPSTBYVlM3TktoOExDNmFEV3gwQkwxUE0yQkdNRnVxNVdqeVhU?=
 =?utf-8?B?OWp0Z3B5MnFFeVJqSmJyVUx1MElMVnFkVStIc2NNaE9hWTJrVU9XM2FOUkxU?=
 =?utf-8?B?T2RJY05QTVdsZDBKQnNuSlpKd1hRalg0V1llUndmK0NRTzRSRWNhR25nbGc3?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D4782006756FB4F9BC65FB65CDACC20@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6167.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d586256-1d87-4e40-6ee8-08db5a76f8e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 03:45:23.1215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lWGsNccSiL0b0/ksR8Kyu/3r3cg6VAYg3eP+ZYBfGht3x+Dw9bvqx/3688Ws8quxhFoXqkBC0z3fQx0JAX1yNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5499
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTA1LTEyIGF0IDA5OjM0IC0wNzAwLCBUcmlsb2sgU29uaSB3cm90ZToNCj4g
RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVu
dC4NCj4gDQo+IA0KPiBPbiA1LzExLzIwMjMgMTE6NDIgUE0sIFlpLURlIFd1ICjlkLPkuIDlvrcp
IHdyb3RlOg0KPiA+IE9uIEZyaSwgMjAyMy0wNC0yOCBhdCAwOTo1MiAtMDUwMCwgUm9iIEhlcnJp
bmcgd3JvdGU6DQo+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiA+ID4gdW50aWwNCj4gPiA+IHlvdSBoYXZlIHZlcmlm
aWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gT24g
RnJpLCAyOCBBcHIgMjAyMyAxODozNjoxNyArMDgwMCwgWWktRGUgV3Ugd3JvdGU6DQo+ID4gPiA+
IEZyb206ICJZaW5nc2hpdWFuIFBhbiIgPHlpbmdzaGl1YW4ucGFuQG1lZGlhdGVrLmNvbT4NCj4g
PiA+ID4gDQo+ID4gPiA+IEFkZCBkb2N1bWVudGF0aW9uIGZvciBHZW5pZVpvbmUoZ3p2bSkgbm9k
ZS4gVGhpcyBub2RlIGluZm9ybXMNCj4gPiA+ID4gZ3p2bQ0KPiA+ID4gPiBkcml2ZXIgdG8gc3Rh
cnQgcHJvYmluZyBpZiBnZW5pZXpvbmUgaHlwZXJ2aXNvciBpcyBhdmFpbGFibGUNCj4gPiA+ID4g
YW5kDQo+ID4gPiA+IGFibGUgdG8gZG8gdmlydHVhbCBtYWNoaW5lIG9wZXJhdGlvbnMuDQo+ID4g
PiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZaW5nc2hpdWFuIFBhbiA8eWluZ3NoaXVhbi5w
YW5AbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZaS1EZSBXdSA8eWktZGUu
d3VAbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIC4uLi9oeXBlcnZpc29yL21l
ZGlhdGVrLGdlbmllem9uZS1oeXAueWFtbCAgICB8IDMxDQo+ID4gPiA+ICsrKysrKysrKysrKysr
KysrKysNCj4gPiA+ID4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAxICsNCj4gPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKQ0K
PiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gPiA+IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9oeXBlcnZpc29yL21lZGlhdGVrLGdlbmllem9uZQ0KPiA+ID4gPiAtDQo+
ID4gPiA+IGh5cC55YW1sDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBNeSBib3QgZm91bmQgZXJy
b3JzIHJ1bm5pbmcgJ21ha2UgRFRfQ0hFQ0tFUl9GTEFHUz0tbQ0KPiA+ID4gZHRfYmluZGluZ19j
aGVjaycNCj4gPiA+IG9uIHlvdXIgcGF0Y2ggKERUX0NIRUNLRVJfRkxBR1MgaXMgbmV3IGluIHY1
LjEzKToNCj4gPiA+IA0KPiA+ID4geWFtbGxpbnQgd2FybmluZ3MvZXJyb3JzOg0KPiA+ID4gDQo+
ID4gPiBkdHNjaGVtYS9kdGMgd2FybmluZ3MvZXJyb3JzOg0KPiA+ID4gLi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvaHlwZXJ2aXNvci9tZWRpYXRlayxnZW5pZXpvbmUNCj4gPiA+
IC0NCj4gPiA+IGh5cC55YW1sOiAkaWQ6IHJlbGF0aXZlIHBhdGgvZmlsZW5hbWUgZG9lc24ndCBt
YXRjaCBhY3R1YWwgcGF0aA0KPiA+ID4gb3INCj4gPiA+IGZpbGVuYW1lDQo+ID4gPiAgICAgICAg
IGV4cGVjdGVkOg0KPiA+ID4gDQpodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDovL2Rl
dmljZXRyZWUub3JnL3NjaGVtYXMvaHlwZXJ2aXNvci9tZWRpYXRlayxnZW5pZXpvbmUtaHlwLnlh
bWwqX187SXchIUNUUk5LQTl3TWcwQVJidyFqb0lPWGJJQ003VUd2eTNYQkVKdmZ6U0tPN3M2MWVm
Qjg3X05YNWNxcFVxcHU1b3Q1Y3V6dzUwQTgtOGxlZFpUOV83aWZzQjJzS3p4U0QwJA0KPiA+ID4g
DQo+ID4gPiBkb2MgcmVmZXJlbmNlIGVycm9ycyAobWFrZSByZWZjaGVja2RvY3MpOg0KPiA+ID4g
DQo+ID4gPiBTZWUNCj4gPiA+IA0KaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0
L2RldmljZXRyZWUtYmluZGluZ3MvcGF0Y2gvMjAyMzA0MjgxMDM2MjIuMTgyOTEtMy15aS1kZS53
dUBtZWRpYXRlay5jb20NCj4gPiA+IA0KPiA+ID4gVGhlIGJhc2UgZm9yIHRoZSBzZXJpZXMgaXMg
Z2VuZXJhbGx5IHRoZSBsYXRlc3QgcmMxLiBBIGRpZmZlcmVudA0KPiA+ID4gZGVwZW5kZW5jeQ0K
PiA+ID4gc2hvdWxkIGJlIG5vdGVkIGluICp0aGlzKiBwYXRjaC4NCj4gPiA+IA0KPiA+ID4gSWYg
eW91IGFscmVhZHkgcmFuICdtYWtlIGR0X2JpbmRpbmdfY2hlY2snIGFuZCBkaWRuJ3Qgc2VlIHRo
ZQ0KPiA+ID4gYWJvdmUNCj4gPiA+IGVycm9yKHMpLCB0aGVuIG1ha2Ugc3VyZSAneWFtbGxpbnQn
IGlzIGluc3RhbGxlZCBhbmQgZHQtc2NoZW1hIGlzDQo+ID4gPiB1cA0KPiA+ID4gdG8NCj4gPiA+
IGRhdGU6DQo+ID4gPiANCj4gPiA+IHBpcDMgaW5zdGFsbCBkdHNjaGVtYSAtLXVwZ3JhZGUNCj4g
PiA+IA0KPiA+ID4gUGxlYXNlIGNoZWNrIGFuZCByZS1zdWJtaXQgYWZ0ZXIgcnVubmluZyB0aGUg
YWJvdmUgY29tbWFuZA0KPiA+ID4geW91cnNlbGYuDQo+ID4gPiBOb3RlDQo+ID4gPiB0aGF0IERU
X1NDSEVNQV9GSUxFUyBjYW4gYmUgc2V0IHRvIHlvdXIgc2NoZW1hIGZpbGUgdG8gc3BlZWQgdXAN
Cj4gPiA+IGNoZWNraW5nDQo+ID4gPiB5b3VyIHNjaGVtYS4gSG93ZXZlciwgaXQgbXVzdCBiZSB1
bnNldCB0byB0ZXN0IGFsbCBleGFtcGxlcyB3aXRoDQo+ID4gPiB5b3VyDQo+ID4gPiBzY2hlbWEu
DQo+ID4gPiANCj4gPiANCj4gPiBOb3RlZCwgd2UndmUgcnVuIHRoZSB5YW1sIGNoZWNrIGFuZCB3
ZSBhcmUgZ29pbmcgdG8gcmUtc3VibWl0IHRoZQ0KPiA+IGxhdGVzdCB2ZXJzaW9uIGluIHYzLg0K
PiA+IA0KPiA+ICoqKioqKioqKioqKiogTUVESUFURUsgQ29uZmlkZW50aWFsaXR5IE5vdGljZSAq
KioqKioqKioqKioqKioqKioqKg0KPiA+IFRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaW4gdGhp
cyBlLW1haWwgbWVzc2FnZSAoaW5jbHVkaW5nIGFueQ0KPiA+IGF0dGFjaG1lbnRzKSBtYXkgYmUg
Y29uZmlkZW50aWFsLCBwcm9wcmlldGFyeSwgcHJpdmlsZWdlZCwgb3INCj4gPiBvdGhlcndpc2UN
Cj4gPiBleGVtcHQgZnJvbSBkaXNjbG9zdXJlIHVuZGVyIGFwcGxpY2FibGUgbGF3cy4gSXQgaXMg
aW50ZW5kZWQgdG8gYmUNCj4gPiBjb252ZXllZCBvbmx5IHRvIHRoZSBkZXNpZ25hdGVkIHJlY2lw
aWVudChzKS4gQW55IHVzZSwNCj4gPiBkaXNzZW1pbmF0aW9uLA0KPiA+IGRpc3RyaWJ1dGlvbiwg
cHJpbnRpbmcsIHJldGFpbmluZyBvciBjb3B5aW5nIG9mIHRoaXMgZS1tYWlsDQo+ID4gKGluY2x1
ZGluZyBpdHMNCj4gPiBhdHRhY2htZW50cykgYnkgdW5pbnRlbmRlZCByZWNpcGllbnQocykgaXMg
c3RyaWN0bHkgcHJvaGliaXRlZCBhbmQNCj4gPiBtYXkNCj4gPiBiZSB1bmxhd2Z1bC4gSWYgeW91
IGFyZSBub3QgYW4gaW50ZW5kZWQgcmVjaXBpZW50IG9mIHRoaXMgZS1tYWlsLA0KPiA+IG9yIGJl
bGlldmUNCj4gPiB0aGF0IHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZS1tYWlsIGluIGVycm9yLCBw
bGVhc2Ugbm90aWZ5IHRoZQ0KPiA+IHNlbmRlcg0KPiA+IGltbWVkaWF0ZWx5IChieSByZXBseWlu
ZyB0byB0aGlzIGUtbWFpbCksIGRlbGV0ZSBhbnkgYW5kIGFsbCBjb3BpZXMNCj4gPiBvZg0KPiA+
IHRoaXMgZS1tYWlsIChpbmNsdWRpbmcgYW55IGF0dGFjaG1lbnRzKSBmcm9tIHlvdXIgc3lzdGVt
LCBhbmQgZG8NCj4gPiBub3QNCj4gPiBkaXNjbG9zZSB0aGUgY29udGVudCBvZiB0aGlzIGUtbWFp
bCB0byBhbnkgb3RoZXIgcGVyc29uLiBUaGFuayB5b3UhDQo+IA0KPiBEbyB5b3Ugd2FudCB1cyB0
byByZXBseSB3LyBzdWNoIGEgYmlnIGNvbmZpZGVudGlhbGl0eSBub3RpY2U/DQo+IA0KDQpNeSBh
cG9sb2d5IHRvIHRoaXMgbWlzdGFrZSwgb3VyIG1haWwgc2VydmVyIHdhc24ndCBjb25maWd1cmVk
IHByb3Blcmx5Lg0KV2UndmUgYWRkZWQgYWxsIHJlbGF0ZWQgbWFpbGluZyBsaXN0IHRvIG91ciBk
aXNjbGFpbWVyLWZyZWUgYnlwYXNzaW5nDQpsaXN0IHRvIHByZXZlbnQgc3VjaCBpc3N1ZXMgZnJv
bSBoYXBwZW5pbmcgYWdhaW4uDQo=
