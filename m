Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD0370B416
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 06:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjEVE34 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 00:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjEVE3y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 00:29:54 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F41CCF;
        Sun, 21 May 2023 21:29:47 -0700 (PDT)
X-UUID: 4509965cf85911edb20a276fd37b9834-20230522
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=MjhyTWZQmyCfqqK1T1rbcXXhnzdxRlXWmMbTcV1IG84=;
        b=Wryt+3sSYepgcv5vuNzVLWsi+jSjLz3TqmSxpQLQjJK0bCgWhql+uH4SyUIL0ZJiEsUe5FIy1xKHy9rgM8BRKCAseVRS5gkELR4Oce4uIJrr184KVTi7BOgGsGOcW+8ZcRmBVyFZ9N989LE7WPUIg3grq+XTmfp7ss/9RlLFjSU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:3b574f98-84b6-450f-bb8e-4f8edaa27081,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.25,REQID:3b574f98-84b6-450f-bb8e-4f8edaa27081,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:d5b0ae3,CLOUDID:ba89ea3b-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:23052212294380Q68PAE,BulkQuantity:0,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
        SA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 4509965cf85911edb20a276fd37b9834-20230522
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 609340072; Mon, 22 May 2023 12:29:41 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 22 May 2023 12:29:40 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 22 May 2023 12:29:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0mTyLnsUYsLLDPrLlEMNbvyxCN+0lEXsm3s3jlXKqtZWjuKxBty4z3j2Oy2sl/7658KHM8nzEAnH1YFzpnOObpyPN9O//K+RTP9XpdYfylREDcc3y0XppV2URAWtTKEOE65W5R5E0BYRLzk+m9Tj3lgRIkAuQQe/DV3yP+sTcCFNtQwpV/IB6YpVh+ntAEtEwJhkGkEYPoX02Sr49N3K1ado1WUJ6xZdTQW0pe2NehqKfE0/QGoeTe+J7QvnK1D1Av/1y2jY++s9ATUwaBVuiH1NXMQeGYVJKZJOZnqh7MZaTzvNT+XkSLVqUKb+2eutrdFF4vCAr1fMs8I0vBUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjhyTWZQmyCfqqK1T1rbcXXhnzdxRlXWmMbTcV1IG84=;
 b=ChesoDbOfIkYnCekBB/kxDhDp6+l8uFybhaUNDAuHIwMLjGB98AUnKQ8/1KgHTwf5TDUdImG7OlPDUt+MjbO14HG6DYP9L4e9mlL+KCc+wtDeDal12R2i2+1ndz2TxkU/vLYScHO7lDnRDxfF7ukSbElQZWEGWEhl+5pt2dOkg5OmL9XRqTBzntoVLN/mUucurlbaFDYybomu5ifrLP0eBJT7XIyHpA38tPU/2ZETPDfRCfm0R/ThWQqI9Fe5tWhl1A/mJZFMTsacjn4/PK2pxJYoZuJae5HW3SjQygZa9RAAL1SgqrM00F7K/J0QTsxUHKjHDkjhA2wNmfpko3ctw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjhyTWZQmyCfqqK1T1rbcXXhnzdxRlXWmMbTcV1IG84=;
 b=pmecunzbYCxWurQ7a3YnUC5Ew8Z+uYyrAB/Z2HJ8VDe7HNyRgEn8iqZA2woOI46yyf9/V5ZMw7Y0x+IAW6mSkvPn936uk61coeyFpBll3MFb604bjRMe+jSNFiy9L4mplqGesaepfLcPm91qnO0XEizgi88xC/5QyeWWaNzPGXk=
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com (2603:1096:4:14f::8) by
 TYUPR03MB7161.apcprd03.prod.outlook.com (2603:1096:400:355::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.27; Mon, 22 May 2023 04:29:37 +0000
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b]) by SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b%9]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 04:29:36 +0000
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
        "yi-de.wu@mediatek.corp-partner.google.com" 
        <yi-de.wu@mediatek.corp-partner.google.com>,
        =?utf-8?B?SmFkZXMgU2hpaCAo5pa95ZCR546oKQ==?= 
        <jades.shih@mediatek.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "dbrazdil@google.com" <dbrazdil@google.com>,
        "yipei.chang@gmail.com" <yipei.chang@gmail.com>,
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
Subject: Re: [PATCH v2 3/7] virt: geniezone: Introduce GenieZone hypervisor
 support
Thread-Topic: [PATCH v2 3/7] virt: geniezone: Introduce GenieZone hypervisor
 support
Thread-Index: AQHZeb1aX90tY1i6HkGV8pI87sQlea9BSaOAgBUGooCAAC0vAIAPWxgA
Date:   Mon, 22 May 2023 04:29:36 +0000
Message-ID: <804b1b375dcb0dbc84360948db6a8ea089dc429b.camel@mediatek.com>
References: <20230428103622.18291-1-yi-de.wu@mediatek.com>
         <20230428103622.18291-4-yi-de.wu@mediatek.com>
         <904abf67ec4ba7d37fc1e500e8a2dbd1@kernel.org>
         <457219eb8c83b35fc8705d80abbf75fc2fd8741c.camel@mediatek.com>
         <86r0rlna43.wl-maz@kernel.org>
In-Reply-To: <86r0rlna43.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6167:EE_|TYUPR03MB7161:EE_
x-ms-office365-filtering-correlation-id: 3b4adbc5-1487-4bc0-47a6-08db5a7d269c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V/CUsiNb+pr0L1uEZ67ZKRKB14ybnaNT/gerLDtSHeydqD4sbVD64+yd2cj30viX6NudVVvtZJi2Oy2/hWVO6aalaqjBoCwBYK0kATVGGSmfyGQ2hiCPoRIVXgUmuV7jyrLo5UbrhYd7TR3i4KpbgEjvqJ9X5/MuiGf2FJfu3rdQYUJv7M6CxsfynzmfjfWd6AISittVMtptcywW5L8Jn4TXcmp2D/8agpLfjrK/grq2whjVILeXdmhJ6GdJNlxJWMu6ldYMLN9sDOO35NKIuQlz9+fsrd3GDo9vUxCVEH398ihO8TQzTOF5pxSlQaGhUaGiSxEKwlRlS5n+aqW0d0+7xJ7y0qbRWehIyVJZyyqidcdRLmUZJCmhqzsO2A/ECg+x+MQRtll4LSbVpyUcabuMqG4YTICNhJF9dT+EJSV8prQBAD4eh7/QZsb7lj6gOFe+5lZ39hRdjFWAhvCS+Mkc41UrJQuqsZfttx60fr/UIOjG2lBFQA+CWp689JL2rM4u7Vx2cgbX770XT4OaNmm85MyreFJvpHfq24KleONydTyfqYy16q1nXbHK94iUuIbcUj0adHXY2cTgBHWCufRtLzjbSVJ4TJom7n22/mkPJZfA/uNonTgUYNWdASad
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6167.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199021)(5660300002)(7416002)(8936002)(8676002)(83380400001)(85182001)(186003)(36756003)(2616005)(122000001)(38100700002)(38070700005)(2906002)(86362001)(6512007)(6506007)(26005)(53546011)(71200400001)(91956017)(316002)(6916009)(4326008)(66446008)(64756008)(76116006)(66946007)(66556008)(66476007)(478600001)(54906003)(41300700001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEFLbVRSQytUZFJSZHdOanp2VEl6a1oyd3NEMzEzMDJmcFFTa095WUdtWkps?=
 =?utf-8?B?QnQxcTFuZWxLcVJhQlBMOTA1ZmZDRnNOR1JHRW1xMmJIcEduNzd0c09kSDls?=
 =?utf-8?B?WGt1d0lrZzFYQVdmK0dOaitmbE1xU1RrVGg4aWxyaUk1ZkgzeEZyZjc4aEY5?=
 =?utf-8?B?TzFnRWwzcDRDWmFLSzVkZVlrNnVFSVMvYXNHTFQzSWd1RFJtd1ZGWUFsMFJh?=
 =?utf-8?B?aFpQcjRwblFuZk9kTnNhMGhxMzgzN3NtZHVTa3RSVVVBQ0s1UlNDOWRWUkts?=
 =?utf-8?B?SFJ4RFVIQkkyNGJoc21uZWFjczJhK0Q2dHpSNEFTSkRTRjRGeUdWdWZFQVYx?=
 =?utf-8?B?cnNRdWl6TFA2ZnVlVDI4ZER5aTZZWFF1UDNaZVNla1hYcmZUc0M5SjZWV2I2?=
 =?utf-8?B?STJuMHcxaVNKVHAxM2tEYVhSelhLa3ltNkg1Nm9qTVpldXZtcWMzMDRNMjVW?=
 =?utf-8?B?NzJLNElzcUhHOWVNSE5UY3J5SURoRWdyaTlvZjNmYlNpZ1ZHUGl4ejNtcTZK?=
 =?utf-8?B?dEVNTlVrWVB1MDRMN3pLNmp6WlFNbWoyQlRtelZMTFltUitlUEM2RGw5dGZ2?=
 =?utf-8?B?RVdQQ0ZXNG8rVmR6LzVqN1hRWC9pelQ2MTlabW9yQXA3ck13NkJhU1NWRnB6?=
 =?utf-8?B?b0llMmU1ZnR1QjlON01OcFpDTmpqVGIxNmFRTkFKaFZ6NFp6MDQ1ZXBoWGFK?=
 =?utf-8?B?a3VLLzI5OURsTmo1Qi9IRHU0S1BEUGIwMEd6bE5rcUhTdk1maHNOZ1lnUVpB?=
 =?utf-8?B?VFRZTmdwOHhwd0dTd1JqM0ExekR2cGNKRzAxOGRLVGRpYngvNWtuU0tKNkRB?=
 =?utf-8?B?WUtkMTJIeHliL1R1RHRlOUM5RzVlQWx3WVhoZHJLb0JqVHIvRlBFSlhBbEdM?=
 =?utf-8?B?VkVBUGJzNmlPWStySllhV1daUXNWRFZPSjk0WGg1enFOSEFiR1E2TUdFdXZP?=
 =?utf-8?B?bzdBb2R1dmZlbUVYRm5oV2JGYzBNYjFoZkF6U2xPR3VOdHhkbTRUR250QlJ2?=
 =?utf-8?B?UFFJUzkwN280eGVBdTNVMlZLNzRRWlFvM1FjeGxGTk8zOWw2SmlURVlQWXUw?=
 =?utf-8?B?RXR4bDFkdFV4ZHVGeU1nY2dBVGdCcmRwbHRHdnMwaXRLS3V1bEpuS1doQVlD?=
 =?utf-8?B?QW1vYmVHSnduRXViWWZ3QjZSR0VaU2NVUU01REg0eGRKaFpsQVVwVlA2R0RD?=
 =?utf-8?B?NWRmcEI2QmZyVkRiaEdxdTllbjZmaFg5U3oxSWRubTI2SmV0Y3M5UTZ4Z1dY?=
 =?utf-8?B?Wk0rc0p6WHFpbFh4US9sRXhGdFBWdjE1bU9RQjhJUlJIcXpFT08zOTdETW5O?=
 =?utf-8?B?Wk1mc2ZxSkVKZUo3d1JGMXd1RU5uU2xLZ0ZXaGJHRlJBWDg2V2trSldtMEkw?=
 =?utf-8?B?eFgvczFRY2NwbzRXamhycnVLV3VCWE9FbURMVG5MSkg1VEZpelZmZ1QrdHJy?=
 =?utf-8?B?QlAyYWQ1OTkrSlZ4NDEvMHNjcXRKazY2bWZxdThlOXR0VW1mUDljU3phZ3Rr?=
 =?utf-8?B?cExKTmZFaW5yYmNabkEzWUJFQUxYQXRrYi9qZ20zZGhTSFlZK1hqWFZBdURZ?=
 =?utf-8?B?d2hvMVQwQm4rbGJZV0s2Qjc3dHVlSnRFQmtFNlBQaUpMUERxWHJpUzJROEJM?=
 =?utf-8?B?aHFYc3diNWxPUjlXRHVpZ1NKTjlvdnhyY0c4L0FxVlZ4ZU9nbGlFYnFLWjZO?=
 =?utf-8?B?MmwzUUh5dG1qNXYrRU9yR2FWK3FhZjFQd1JZOUx3djNWVVFFM0pkYjFoa0o3?=
 =?utf-8?B?cnNMM2JXYlVUa0RhZ2FxUEhwMzA1TnF0N1hIeXpmSW9vNWtsTEhvT0RJRGJ4?=
 =?utf-8?B?QjdlWExlSHRwUEhYSHFQMi9qaUFFWXU5RDN5YnJuRFVOeHo1eHlRUzkwMVlQ?=
 =?utf-8?B?dmlMOVZPM2xzVXdFVzRYMXlqRzBxMHcxSkNORHBXV2ZYVFc2ZmxLdlVtY2ZE?=
 =?utf-8?B?elUrdUJDVVRIWEMyQjJUMmhoaEhqTldvcklUaGFST3NDdG96UWRUVVNwNVNS?=
 =?utf-8?B?QmNjOUJVRDBRWHNGeWhlR1JpaE5UaGZsTTV5Nll0VHdyRExyMk9tT2dwWXhZ?=
 =?utf-8?B?TnAyVFZtakJRQlJwajlOWFVVS2kzd0cxdXc0dGFtQ0FzaDNBZ2dJdGowb1B1?=
 =?utf-8?B?cDE5VGZBcFV4akdPODNpa2svcThZeTAyOUpKb0lXS0dPcWFNV1k2eVEzclNr?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD1D13C2B933FC489F6B967914E5C353@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6167.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4adbc5-1487-4bc0-47a6-08db5a7d269c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 04:29:36.7881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d9Xj+64NspvmkFtRsa7PNm6Gsl12Im6Cj5LlJHkru01WYJuEYhbnau/59bQN3xGekn0xx6e3YgisUMw2Fx+V7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7161
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTA1LTEyIGF0IDEwOjU5ICswMTAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuDQo+IA0KPiANCj4gT24gRnJpLCAxMiBNYXkgMjAyMyAwODoxNzo1OCArMDEwMCwNCj4gIllp
LURlIFd1ICjlkLPkuIDlvrcpIiA8WWktRGUuV3VAbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPiAN
Cj4gPiBPbiBGcmksIDIwMjMtMDQtMjggYXQgMjM6MTIgKzAxMDAsIE1hcmMgWnluZ2llciB3cm90
ZToNCj4gPiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzDQo+ID4gPiB1bnRpbA0KPiA+ID4geW91IGhhdmUgdmVyaWZpZWQgdGhl
IHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBPbiAyMDIzLTA0
LTI4IDExOjM2LCBZaS1EZSBXdSB3cm90ZToNCj4gPiA+ID4gRnJvbTogIllpbmdzaGl1YW4gUGFu
IiA8eWluZ3NoaXVhbi5wYW5AbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiANCj4gPiA+ID4gK2NvbmZp
ZyBNVEtfR1pWTQ0KPiA+ID4gPiArICAgICB0cmlzdGF0ZSAiR2VuaWVab25lIEh5cGVydmlzb3Ig
ZHJpdmVyIGZvciBndWVzdCBWTQ0KPiA+ID4gPiBvcGVyYXRpb24iDQo+ID4gPiA+ICsgICAgIGRl
cGVuZHMgb24gQVJNNjQNCj4gPiA+ID4gKyAgICAgZGVwZW5kcyBvbiBLVk0NCj4gPiA+IA0KPiA+
ID4gTkFLLg0KPiA+ID4gDQo+ID4gPiBFaXRoZXIgdGhpcyBpcyBLVk0sIGFuZCB0aGlzIGNvZGUg
c2VydmVzIG5vIHB1cnBvc2UsIG9yIGl0IGlzIGENCj4gPiA+IHN0YW5kYWxvbmUNCj4gPiA+IGh5
cGVydmlzb3IsIGFuZCBpdCAqY2Fubm90KiBoYXZlIGEgZGVwZW5kZW5jeSBvbiBLVk0uDQo+ID4g
PiANCj4gPiA+IFsuLi5dDQo+ID4gPiANCj4gPiANCj4gPiBJbiBvcmRlciB0byBiZSBzZWxmLWNv
bnRhaW5lZCBhbmQgYXZvaWQgZGVwZW5kZW5jeSBsaWtlIHdpdGggS1ZNLA0KPiA+IG1heQ0KPiA+
IHdlIGxldmVyYWdlIEtWTSdzIHN5bWJvbCwgbWFjcm8gZS5nLiBWR0lDX05SX1NHSVMsDQo+ID4g
VkdJQ19OUl9QUklWQVRFX0lSUVMuLi5ldGMsIGFuZCBjb3B5IG9yIHJlbmFtZSB0aGUgcmVsYXRl
ZCBwYXJ0IHRvDQo+ID4gKi9nZW5pZXpvbmUvPw0KPiANCj4gQWdhaW4sIHRoZXNlIGFyZSBhcmNo
aXRlY3RlZCBjb25zdGFudHMuIFlvdSBjYW4gaGF2ZSB5b3VyIG93bi4gWW91DQo+IGNhbg0KPiBh
bHJlYWR5IGNvbnNpZGVyIGFueSB1c2Ugb2YgYSBLVk0gc3RydWN0dXJlIG9yIHN5bWJvbCBhcyBh
IGJ1Zy4NCj4gDQo+ICAgICAgICAgTS4NCj4gDQo+IC0tDQo+IFdpdGhvdXQgZGV2aWF0aW9uIGZy
b20gdGhlIG5vcm0sIHByb2dyZXNzIGlzIG5vdCBwb3NzaWJsZS4NCg0KTm90ZWQsIHdlJ3ZlIHJl
Y2VpdmVkIGNsZWFyIG1lc3NhZ2VzIGFuZCBhZ3JlZWQgdGhlIGN1cnJlbnQgdXNhZ2Ugb24NCktW
TSdzIGRhdGEgc3RydWN0dXJlIGFuZCBmdW5jdGlvbiBwcm90b3R5cGUgc2hvdWxkIGJlIHRyZWF0
ZWQgYXMgYnVncy4NCldlIHdvdWxkIHByb3ZpZGUgb3VyIG93biBpbXBsZW1lbnRhdGlvbiBvbiB2
NCB0byBzb2x2ZSB0aGlzIGlzc3VlLg0K
