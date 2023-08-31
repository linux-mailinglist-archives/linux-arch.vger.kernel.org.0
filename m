Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD72078E6D5
	for <lists+linux-arch@lfdr.de>; Thu, 31 Aug 2023 08:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbjHaGzD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 31 Aug 2023 02:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjHaGzC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 31 Aug 2023 02:55:02 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99996AB;
        Wed, 30 Aug 2023 23:54:58 -0700 (PDT)
X-UUID: 498520e047cb11eeb20a276fd37b9834-20230831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=5XBQBI3eBzI1KKsXVrNi7IljLC8Y1VxQuAQ5hPqWivc=;
        b=JQvTrk6wBTW7G7ecxo6Y/IQSCo13B61cuxikWiaxx+SPgZTNNTWldhSFtolv7hTwN+q4Me7mSjSa0OrzxQMnBeiPdrI8WdpWt0kbeUKr9i8xEs7HMlErNAYYEMaGqrYAWZquZlGRobx0dsCAqwh9OpJrSV2TDqIu/5RRh4e9Uc0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:007d4fc8-2eaa-44d3-a3c5-f495dcb83353,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:71976413-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 498520e047cb11eeb20a276fd37b9834-20230831
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1390982280; Thu, 31 Aug 2023 14:54:53 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 31 Aug 2023 14:54:52 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 31 Aug 2023 14:54:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyiV54v2mxOdrnGRQmzDxr2ZZf8gO4tSh+WU7lzD5TUs1KGxfrb/B9SkkkH9e6TCrsgsQP5Rp3t1QwDuZrGqW0Xa852jab9y0ksy5iQzvMqot+nNbYC+YVzhAkAK+Dlh9ixkMoQf3tm2iJjxDVD+j9geXlI7HliI2aEUM5dSRYv+Nb3VbEFPLNfNb96DE8vbIMP7+Fc3bDauqa7qP8hLOY0pnJTkFXzRO/QKzmmq+e0yPPyHs0zDC6RbOD5WmQmidyhkXEW+qS9SwNGtA+5o/HBSLNeylePgt00maW2MltPLTOX2s+itJZoz3GkBmbQPPZSPRnbXD4VVXFD1LYYUEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XBQBI3eBzI1KKsXVrNi7IljLC8Y1VxQuAQ5hPqWivc=;
 b=h9nDwpkqwCGlNm9l7BTiE6Hi96v7Ktf2SHPpPTBjMrx3Azxf02D9BF4vKC3RyxasoVFSbO71eF8Al+S7a9v1zywN0uRyfpNaaeiOBO23O/th0IIk3jycCVQ36cLy4+1BeZ/nTr4IP2Rc+Uqugys0NEFsmCc6hAL7BkkZArpOIkYfTRPqeMNfSS6Ywpsfkidttfd5pncWwFOgxLZhRZeSJcw8UFtl4a0v/sF95U/RCCtjx+d6zfIaGhTWi8BqX40oCQggoBGLI3TjZva2d28M189GxBEHd86bn51VrV7j/ug+K8AqZlWA4Do2sOg31e/oa/ECMi652w6PUm6E50croA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XBQBI3eBzI1KKsXVrNi7IljLC8Y1VxQuAQ5hPqWivc=;
 b=jpswVZJM76BtRkwn0BNJqGX9IWx9oQkbMNLKvfJuXUIlqOsBW4Cy7FsBHv/PB9a5qUftDHCrVID3trKa7zLIjzuoteAgaUGLNKoeDHF8Do9iqOJXFJBhFxhunLnG0U+d02jrU447LPR0sEIXmn2SJ0OmvuuBRVBS6/7eIYPHuC8=
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com (2603:1096:4:14f::8) by
 KL1PR03MB5490.apcprd03.prod.outlook.com (2603:1096:820:5f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20; Thu, 31 Aug 2023 06:54:49 +0000
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::a944:f5f3:d44f:8498]) by SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::a944:f5f3:d44f:8498%5]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 06:54:48 +0000
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
Subject: Re: [PATCH v5 04/12] virt: geniezone: Add vcpu support
Thread-Topic: [PATCH v5 04/12] virt: geniezone: Add vcpu support
Thread-Index: AQHZwGB0sRavPWtmsE20spZ1MP7yCq/lagYAgB7FSIA=
Date:   Thu, 31 Aug 2023 06:54:48 +0000
Message-ID: <f978d5599b5b4b9e75685421e180500ad138ca3c.camel@mediatek.com>
References: <20230727080005.14474-1-yi-de.wu@mediatek.com>
         <20230727080005.14474-5-yi-de.wu@mediatek.com>
         <20230811170054.GB3593414-robh@kernel.org>
In-Reply-To: <20230811170054.GB3593414-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6167:EE_|KL1PR03MB5490:EE_
x-ms-office365-filtering-correlation-id: 5b20b6a4-6ae6-4a3a-6c18-08dba9ef2ad3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sOiJlQKdw40ZhtIAtoPjUjHoad7b3eSUQX6jC0ygifpuwYmmzvigFDkOyOgkASnVKTDOZQHlcnQj63gYjeW3WjV2fBmfeUWqqOrmkD9WM129tst4AvZBxv92zIGNS6fGTQfzD6trF18CNdGuaqDSEVn52CGdzZyJFhQPmw/YJgk41WVwZifIPWzpY4ZD0x1VXtMxbvhUM1aapp8n28fbEX98r/CrQTU5zS5ySwO8n4Jb6ILYjcXuPX2w9/cofWh5OrhpjfHo2jzjli0gu1dNufi7+f421oOvDPgk+7q2oYdPXFUGiY8MiUloFuIG01v9b5ev6LRX32qVwugwK4H4Kj7BJToH9aA3p6bufEy9WIJL3UUyrtKeU8ye2x79a1b0d5k1JjFKIxICtt2pUvtzznvQCVcPBYHxx+8CpsiF6G0jiQmuHth8jNwKuvKFxRgkGtVwhZJyFKQo3q2fwwxziq47ohN5q48WIbf0H7gIPEAHFnv6Bj50ha5aJgWTjXPu1Kpt0Q5ow5ue7Jc2S3kilREBJb53BqXbSGqsHpmsbx+Cjhbh59Llz0Z8oOjxivwj25C+PDPu1BfQvn/6M1CWjPWZKXvwuRSHqG1GQuoNBl4lApaY9c/GI+kHG0BimubbntLSh3wXoMEYHV8YLYLkkxMJP3bMZOOSAQmRhPEBzsI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6167.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(1800799009)(451199024)(186009)(85182001)(36756003)(7416002)(83380400001)(41300700001)(86362001)(4326008)(5660300002)(107886003)(8936002)(8676002)(6506007)(26005)(71200400001)(6486002)(6512007)(2616005)(91956017)(76116006)(38100700002)(478600001)(2906002)(122000001)(38070700005)(66946007)(6916009)(64756008)(66446008)(66556008)(316002)(66476007)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVpkYnZDSXZiTmRGMndUcXVwODBNem8vZnJ6MG1iTzNxNlBNSmtqazlQWkJa?=
 =?utf-8?B?dDFaczM4eWU0UHdZQ2dXdXQ4Mk1ZWGRPRk96REMzdjhTbWJ6UnhIalBxRGor?=
 =?utf-8?B?S1l3M2V4NlQyRVlpcDNRMTcvZlhVaGVZQ2xNemFRcVViUEovbzM4a05mcXkw?=
 =?utf-8?B?RzhaTnB4VE1SbXd6YXc3M2R4NlE3ZWNKanhGeGhNbFlFSVZhamNBR0cxTjha?=
 =?utf-8?B?YTIwY2huN3lneENlN0x4QkdMQXFUNWdKZFRSZ20rN1gxS1JFaVhUenNBUHpj?=
 =?utf-8?B?STExOGIzS3NDUU5pdERBSG4zU3BHMmlsUkVXK3dHTDhSdGdNSURtaWt0TEY1?=
 =?utf-8?B?QlYxMFlibFdQejFHQisvV21keUlYbDFWUVl6R0xkK0psSE5RV1BYSGhVSHNx?=
 =?utf-8?B?SHhzQ0l1SnBmTGtHU1k1NVVaRE1CVGlPeWpaSUEwbDFMb3ErVDVZN25SWUph?=
 =?utf-8?B?bkg2RFR1YnFOVWg1N2V4U0I5RnI2TDB2Nnl2OUFpWktzTVlwenN4Ri9GblF4?=
 =?utf-8?B?bHJqRzMweTJHYTF4Y3NNWE01d0NoaDl5RloxVjg0Z3BTOFNkaWpUOGJqb3dr?=
 =?utf-8?B?bTRaRitIWHFqWFRvU3ZOK3UweGtJYzc5eEdGejNhdzhuS1hhSFlRNU5OY25Z?=
 =?utf-8?B?dnNFRDlwRmFuYmphMm5YV3JiVmFlaytjTjJGNnkyVkpic1MwZGgvVWV3UG1l?=
 =?utf-8?B?d0hXakVZTnE5K0xPQkJ0NjVKc0lsUkViMStVSjArVW8yeTY3RTdnQytlUDNS?=
 =?utf-8?B?WGhIU1VUaDZWa3N1VUprSEplNUxlWWJ1ekYrcFpwSU5WNkpVdCtFNERYNEFa?=
 =?utf-8?B?TE9MeWpHV0lrSGduVjc2Zm9ReXhMUTgzT04rbUZPU3hvOGZreDFVSG9SZlVF?=
 =?utf-8?B?NHl5d3ZQWWlDT0dpYXQ2dTM2R01sbkltQlF4NEgzL2FpUmZTb1JFM2ovRGRP?=
 =?utf-8?B?a0lZNmJnRUdjdVpiTEVYVEs2STFWaEwyaVRPY0V3cDdNUXJtNmloWkFTd0ZK?=
 =?utf-8?B?SFprWm5vQlVDYTAzcUFKcWVMWVJuRU9aZHdUc1ZGY0oxWm44M2lkanlNSjJh?=
 =?utf-8?B?UW5sLy9waFZWTUVtSFc4ZmorU25ZbUJYUW1xb0JJR0hkZGpPNTJDdVhsZzJN?=
 =?utf-8?B?T2xtVTlHTGVaazdCc2Y2WFdGQWNreHBuRDZzZkZYMnVkMnNMckVBRXpSY3B3?=
 =?utf-8?B?UEh4N1k2Umh1aG1XQ01jSXN6OVhacHh4NTE0WkdQYTBIaWlvNlF1Zjk1a2c4?=
 =?utf-8?B?QjRKZzkyM1lMdWJ0QmJ4WDltTTZmdDU0TGp0VG8xWHNLd2VBZG0rbTlQVVRs?=
 =?utf-8?B?SHhWRlBQUDB2RENpRjN4elNWOGFHQzhRSEY5K0ZJUVRNNUZqWEtZTUl2VTdW?=
 =?utf-8?B?M2NBejZMOVlrZE0xZk9IY3FxOHBXZDBvZTJ2YkRianVaQTFhOUJHSnJBeWRn?=
 =?utf-8?B?Nnp3dk9qVHd4cnlDT2pnZVVQd1JXOXlNa01JYlZSR0hRY3Eva0lmTnlxMDVy?=
 =?utf-8?B?Sjc4SWp6ak9VNVB4Q0QrSE9ZTlBBVTkyVmJlRnBwRkJ2Qk1mTjBZOGFHMlI5?=
 =?utf-8?B?S2NUMDcyclpuS0J5cXhtWkprRFppRzlYOHdtZHdPMTh2UVdjTWFLeHJ0anZZ?=
 =?utf-8?B?ZHlrOWJCTWU2QVo0a2dQSjYxdXJTTExzZ1U2dXdqV0hZaFlnbTk0T3Y5Syto?=
 =?utf-8?B?WEJwVWpmczVYOVl2VUdjaWJqNkRBUEhZQTZNQ1hQT2ErNGVwOEV0TVpCVkQr?=
 =?utf-8?B?ZHlrMGlHT3VyYXlETytzRDhpMnRxNU8wNlc2Z1RycmZic2FuVjNwTnNXc08r?=
 =?utf-8?B?SEJubiszeWNGYXNUN2doak5kZHhvWEN4bTRpNFBuV05naExjN2JxMUt0Yy9s?=
 =?utf-8?B?YXl4ZVM0NDBoOWMySWdwbVhra0hsR296Tkx2dG5rNi8yazBxdnpXTzV0cWJR?=
 =?utf-8?B?TDcvMEtYU0huNHEzU1VSNGFxbDBVUTNRN0xrN3hIY1hFTmxjVGl1dW5VMkhI?=
 =?utf-8?B?M2hudi9jZEM4RkJZRjcvRk5qTzZPUTZlaTYxM1ZaTTBZZ01IQXpxSzBrQjVj?=
 =?utf-8?B?aXB2MkZ3SVlyTXhDNzQyc3J3dlRIVklEaS8yK0JpOElzTDE2d2U1VEhvMGto?=
 =?utf-8?B?SkJqeEJPN1Q0dC84ZGVBUFNYT0JYVVYrQzhRa25jU2c0Z0tvRUdiMWpIazdy?=
 =?utf-8?B?SUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <340F7A083004B14CBB04796AE149AAC0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6167.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b20b6a4-6ae6-4a3a-6c18-08dba9ef2ad3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 06:54:48.3270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yFi5CBS0/9LBL7Bxoiy28BG3MSU9M70wdOqykZ3jLYNmts0Y51g/79Ef7IcgQSQ0r9Kai+couNqAgn2erS64yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5490
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTA4LTExIGF0IDExOjAwIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ICBPbiBUaHUsIEp1bCAyNywgMjAyMyBhdCAwMzo1OTo1N1BNICswODAwLCBZ
aS1EZSBXdSB3cm90ZToNCj4gPiBGcm9tOiAiWWluZ3NoaXVhbiBQYW4iIDx5aW5nc2hpdWFuLnBh
bkBtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4gVk1NIHVzZSB0aGlzIGludGVyZmFjZSB0byBjcmVh
dGUgdmNwdSBpbnN0YW5jZSB3aGljaCBpcyBhIGZkLCBhbmQNCj4gdGhpcw0KPiA+IGZkIHdpbGwg
YmUgZm9yIGFueSB2Y3B1IG9wZXJhdGlvbnMsIHN1Y2ggYXMgc2V0dGluZyB2Y3B1IHJlZ2lzdGVy
cw0KPiBhbmQNCj4gPiBhY2NlcHRzIHRoZSBtb3N0IGltcG9ydGFudCBpb2N0bCBHWlZNX1ZDUFVf
UlVOIHdoaWNoIHJlcXVlc3RzDQo+IEdlbmllWm9uZQ0KPiA+IGh5cGVydmlzb3IgdG8gZG8gY29u
dGV4dCBzd2l0Y2ggdG8gZXhlY3V0ZSBWTSdzIHZjcHUgY29udGV4dC4NCj4gPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBZaW5nc2hpdWFuIFBhbiA8eWluZ3NoaXVhbi5wYW5AbWVkaWF0ZWsuY29tPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEplcnJ5IFdhbmcgPHplLXl1LndhbmdAbWVkaWF0ZWsuY29tPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IExpanUgQ2hlbiA8bGlqdS1jbHIuY2hlbkBtZWRpYXRlay5jb20+
DQo+ID4gU2lnbmVkLW9mZi1ieTogWWktRGUgV3UgPHlpLWRlLnd1QG1lZGlhdGVrLmNvbT4NCj4g
PiAtLS0NCj4gPiAgYXJjaC9hcm02NC9nZW5pZXpvbmUvTWFrZWZpbGUgICAgICAgICAgIHwgICAy
ICstDQo+ID4gIGFyY2gvYXJtNjQvZ2VuaWV6b25lL2d6dm1fYXJjaF9jb21tb24uaCB8ICAyMCAr
Kw0KPiA+ICBhcmNoL2FybTY0L2dlbmllem9uZS92Y3B1LmMgICAgICAgICAgICAgfCAgODggKysr
KysrKysrDQo+ID4gIGFyY2gvYXJtNjQvZ2VuaWV6b25lL3ZtLmMgICAgICAgICAgICAgICB8ICAx
MSArKw0KPiA+ICBhcmNoL2FybTY0L2luY2x1ZGUvdWFwaS9hc20vZ3p2bV9hcmNoLmggfCAgMzAg
KysrDQo+IA0KPiBJJ20gYWxtb3N0IGNlcnRhaW4gdGhhdCB0aGUgYXJtNjQgbWFpbnRhaW5lcnMg
d2lsbCByZWplY3QgcHV0dGluZw0KPiB0aGlzIA0KPiBoZXJlLiBXaGF0IGlzIHRoZSBwdXJwb3Nl
IG9mIHRoZSBzcGxpdCB3aXRoIGRyaXZlcnMvdmlydC8/IERvIHlvdQ0KPiBwbGFuIA0KPiB0byBz
dXBwb3J0IGFub3RoZXIgYXJjaCBpbiB0aGUgbmVhciBmdXR1cmU/DQo+IA0KPiBZZXMsIHRoZXJl
J3MgS1ZNIHN0dWZmIGluIGFyY2gvYXJtNjQsIGJ1dCB0aGF0IGlzIG11bHRpLWFyY2guDQo+IA0K
DQpoaSBSb2IsDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldywgYW5kIHRoZSBjb25maXJtYXRp
b24gZnJvbSBXaWxsIHdhcyB3ZWxsDQpyZWNlaXZlZC4gDQoNClRvIGJlIG1vcmUgc3BlY2lmaWMs
IGFyZSB5b3Ugc3VnZ2VzdGluZyB0byANCi0gcmVtb3ZlIHRoZSBgZ3p2bV9hcmNoLmhgDQpmcm9t
IFVBUEkgb3IgDQotIHJlbW92ZSBhbGwgdGhlIGNvZGUgdW5kZXIgYGFyY2gvYXJtNjQvZ2VuaWV6
b25lYCB0bw0Kc29tZXdoZXJlIGxpa2UgYGRyaXZlcnMvdmlydC9nZW5pZXpvbmUvYXJjaGAsIG9y
DQotIGJvdGg/IA0KDQpSZWdhcmRzLA0KDQo+ID4gIGRyaXZlcnMvdmlydC9nZW5pZXpvbmUvTWFr
ZWZpbGUgICAgICAgICB8ICAgMyArLQ0KPiA+ICBkcml2ZXJzL3ZpcnQvZ2VuaWV6b25lL2d6dm1f
dmNwdS5jICAgICAgfCAyNTANCj4gKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIGRyaXZl
cnMvdmlydC9nZW5pZXpvbmUvZ3p2bV92bS5jICAgICAgICB8ICAgNSArDQo+ID4gIGluY2x1ZGUv
bGludXgvZ3p2bV9kcnYuaCAgICAgICAgICAgICAgICB8ICAyMSArKw0KPiA+ICBpbmNsdWRlL3Vh
cGkvbGludXgvZ3p2bS5oICAgICAgICAgICAgICAgfCAxMzYgKysrKysrKysrKysrKw0KPiA+ICAx
MCBmaWxlcyBjaGFuZ2VkLCA1NjQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvZ2VuaWV6b25lL3ZjcHUuYw0KPiA+ICBjcmVh
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy92aXJ0L2dlbmllem9uZS9nenZtX3ZjcHUuYw0K
