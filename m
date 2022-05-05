Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D0151C00C
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 15:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378547AbiEENEN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 May 2022 09:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378530AbiEEND5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2022 09:03:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388F6DBE;
        Thu,  5 May 2022 06:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651755615; x=1683291615;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cTeyf05McYWxzfsiFZIE7L+zG1+RvIX8z7YD2chl9us=;
  b=rOUcNClbBeX8Eb5ymermTGlbUFskRAhnvXLYT9omF8v4ReJrsazgdVMX
   m76DariE0lnPKngjWodh1J1thc6PAhe2D3rN+lTC5IP+97klTVgX4/Ypx
   sX+CQXJlMW7zXAmlkHlwn1iNo+fjGLKI4VYq+3wx2gyKRyhQkICD3SUqh
   w6/F+3vbhv9FoBqGVPDKyIHVczWjZFp68BbbsEjlXGzoWKoz93vMh3AjQ
   ftpAvNokndEHtS/FHQvC69UsytQ6hJVh1qR3rijNdbSgQpQxO/PXBzmhe
   unyIFVm+4Ud0QPs+KvgFi4IgRCFUHbewxD8DEIxKLK1WWwYC8aYSyPHBK
   A==;
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="162437038"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 May 2022 06:00:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 5 May 2022 06:00:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 5 May 2022 06:00:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWrzxgArt9PNHC0Ekn9Y9H/cuDUDMwsexwTDHWO4lbSxThNcvIm/qMgtxCWs3ryvmaubeyuMzB7zxeyPYXLS/8/Gbk6gzEAVzlZaqXnhcMhpADhDqLr+VNCA9GVyCLEN4MMfWfPd2OXtJYSr0XO5LBT1TNwQGEZRW6+ZFrEwBsSS7n/+pOwfPqfraE5qHBJRxxmiicOzXv4GjVzHxWjkITz4+ewO+fySMzzyGtlELRb8HC6QWeD3Q+CG84WsrAALir2QO3hJJsOEfbGFACAIohg0hIjyMKG4w4rQkMWkU9AUoYP8i+0/asDVoHunydDJyIycJQCJWcefsp7P5t8Xcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTeyf05McYWxzfsiFZIE7L+zG1+RvIX8z7YD2chl9us=;
 b=izH8U6swh3+XS8SVSVFPoHBwfY131k3rSfEYXhmq8Nb5ZRMbZHHKqYmYf4liYTdvzeXbeT/WzW2ytFmjofdPnihWbu/UmgaQ+IKsEXjwbizMURh77WhCj+yL219y+IUn4/2BvVqZETjkENHt8rKwk3plZq6JmVZk+3O10jNOjxYjguIEZge3qr49Xngr6zX06VuhIZuWAz6PxWMEoDHwuYSnjLqrSFXjk9x2Xp18AY6rJFkhIzMBdsZXq4UNheTXlGr+lJhqE4HmmROgLabfFlQRKkOcEUTfHxbNdbm6Tfj2k16SSFLTHSbioewclbTC2D61ssMxA10B39ofdSSMgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTeyf05McYWxzfsiFZIE7L+zG1+RvIX8z7YD2chl9us=;
 b=j0+ZPODradhj/6o9SHCY2uLY7Yav8bccRK2PxP5QkJbeTQt617610KPOEY9J6YxLrwOl1ZadaYu9/YwBw5e8zOV+fMq1+5zBuZggR+w5+ZifufaLDGOtIGwjzsil0dW+MQcUBILy0EIx9LVlZ/sHRtwIiXIqPggAYlI1YndJaU4=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by BN6PR11MB4116.namprd11.prod.outlook.com (2603:10b6:405:83::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Thu, 5 May
 2022 13:00:07 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18%9]) with mapi id 15.20.5206.025; Thu, 5 May 2022
 13:00:07 +0000
From:   <Conor.Dooley@microchip.com>
To:     <palmer@rivosinc.com>, <arnd@arndb.de>
CC:     <guoren@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <will@kernel.org>, <longman@redhat.com>, <boqun.feng@gmail.com>,
        <jonas@southpole.se>, <stefan.kristiansson@saunalahti.fi>,
        <shorne@gmail.com>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <gregkh@linuxfoundation.org>, <sudipm.mukherjee@gmail.com>,
        <macro@orcam.me.uk>, <jszhang@kernel.org>,
        <linux-csky@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <openrisc@lists.librecores.org>, <linux-riscv@lists.infradead.org>,
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v4 5/7] RISC-V: Move to generic spinlocks
Thread-Topic: [PATCH v4 5/7] RISC-V: Move to generic spinlocks
Thread-Index: AQHYXKhYtH/vI/1B5Ea5aV8nenoVOa0QRqwA
Date:   Thu, 5 May 2022 13:00:06 +0000
Message-ID: <49b08c9a-8898-98ed-9b2c-9cf21d24497a@microchip.com>
References: <20220430153626.30660-1-palmer@rivosinc.com>
 <20220430153626.30660-6-palmer@rivosinc.com>
In-Reply-To: <20220430153626.30660-6-palmer@rivosinc.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abcceb82-3bbb-4113-5ddf-08da2e972dd9
x-ms-traffictypediagnostic: BN6PR11MB4116:EE_
x-microsoft-antispam-prvs: <BN6PR11MB41167655BD1CA6B1C331DBE398C29@BN6PR11MB4116.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sIzXHpN3YzAOrlCjcd/LqHvxtTvGgLW/4s9gfchG8a7vza/Lbt7IA9ybYdxNuNyHZPKsEt5KgFN2HJcPRdaRvezqBGgBkBEM9frITYaFLk5b8etP9Rtp4VYkaF55Rnv4ZIIoXFvKQZSE1rdmrWNvf0flV/BGg5mVvWmRFPW5mUgNVVudmuRvT9XNHM6EGp4cJTAuOMvBBcT1ujDTeGW6PhZCJJJCeAGgi6s+IdRy7d+kuhu4j9O5+G6wqNQhhYLQMNZhyliLaIxSVZlVUUUd/WpEXMGBWEH92zExzrQhih53GjQUOD433+0shnSGw1z/1xt5qmGSAJ8o9b+INUO2Mp16Gb9tk9rgWrC0dXbsgapPdMLz74G4uIq/2uMSai5nKpYPo+RZflL61J5PloLqYH5RULqZ6Zsbc77yM7Mx/hN5Y4eo2f1LHiiIXQFdT1mPxpfa0G/obKWXU2oQ5jiwRLNbWTAWSttHMnSiil1vap1sRTMnWLUTwFEAjJglO4p0uKgV1yxFmTdgEBUZRt7yMOL1xbUM1PQ9RCeWYlwsRFRiJEF6KK52F10eL8jYn1R6u1tb4t7RF65gokUKGP9qE+eki034FpRWd37HlYOOrNIWKlS0qNU+6pDY/uOvFAFtRGcccdBTPDSmrjrSa9LxiNOaeqvKQnW4LMQyuOTBfYYW5FAAPLloMX7JQAPTrByBE2muotsg7I0oBsDz7Ik1yGKiaGthew9fEb9xxkch52Xd8/8G9j4z9zIYSyX9sjltiZcenYmIXbjOhEVXni0H4KTdVm4NONJae3TBirOmMGE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(31686004)(31696002)(122000001)(508600001)(38100700002)(38070700005)(8936002)(83380400001)(316002)(53546011)(36756003)(54906003)(6506007)(110136005)(64756008)(91956017)(66946007)(7416002)(76116006)(66446008)(66556008)(66476007)(86362001)(5660300002)(2906002)(71200400001)(8676002)(6512007)(4326008)(26005)(6486002)(2616005)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVhSSkZ6N0ZGajdzejhwSWVJRjBlVnJuZjM2clNYeG85WS91VkRNaS9XNzdj?=
 =?utf-8?B?T3ZlM2NCVlA0RTBOTTEvK2FqS0lVUzk4UVplWDFXV2F6bStwUnpWa0lqdVls?=
 =?utf-8?B?SHBqdTVoc2o1aEdrb3QwVm83NHpNVlZIWFl6QXZHTjZPTUVWVHNPbkhScFlF?=
 =?utf-8?B?MU9xZGdvcXpTaG5Uc0VUVTlpQ1c0eWkxRnRsSUNlQTE4dXVTSnd3YW5GNkZW?=
 =?utf-8?B?bEpvQWY3blpLSk50bmVpNVYzNE9kK3k2T3UyN1pJNEhoV1plNHpHajNWT1BJ?=
 =?utf-8?B?NURDWld1bnZJM0FBMTRhWHdMaXFQSm9Ld3YwYU54OHQ0ZlpuUXJMbDlGT0Zq?=
 =?utf-8?B?NXN2TXdkVTZnUy8rNksvQlVjSlJKWjgyVnJMQjVVaHU3OWwyK1dFUWFTMFJp?=
 =?utf-8?B?TDdGSE41T3cxbWYySW1sd3lUYmpMU1V2K1VrTjNvSmJTK0xsem9LRFhCbzlH?=
 =?utf-8?B?V05WUlNjc1BXV2o4ZHVKUGZ0UUc4NE1QY1luM3c4ZTBOdXpZMEJMRnhjOTF2?=
 =?utf-8?B?dXM3RkRrS0Q5ZFdHajlPcGZQU2x3ZWtFRFF2N2h1WklPWGlqdGhDNE5kclJT?=
 =?utf-8?B?NEZ1L0FYSy82eW5UQm1Ec2txT1p6OGJOT0lnRGJWdGFhM0FQLzJkZDMweVli?=
 =?utf-8?B?a0FXaDE5NHltZmJWVkErSjhEd0czb29XYTQ0b09DK09uT0xxd0hGd3k5cGdS?=
 =?utf-8?B?OVdrTG1XNC9mbXo4ZkR1OGlnZzJSWkd6a1JsU2VsQlZ4WXdTd2FOdUhWR0tS?=
 =?utf-8?B?SCttMkovR2dITzVmcExPMTN2WVhzY0JMd1BXaXZhMFh2cmFRaFRnQi9LS2Nx?=
 =?utf-8?B?U1UraEluNDNDUERjMkRTWnZma2hFM2FmaXpMWXZFUUloK2pLN3FRVzF0VlZh?=
 =?utf-8?B?MG5HbEkvTDJtZDJ2TEVrdEkxbEhzRjNvWXdDTHlVRk41QWEzTzVtaFE4c2x4?=
 =?utf-8?B?elpGejBEVm1XKzEzbkdpRmZRekZzS2wxZlZBUmVoWkVCNytaT2JkOUhXZklG?=
 =?utf-8?B?YWhkNVBQQjd3WnZuT3ZML1V1ekhneWFZcUxHNGpnb3QyM05sMTdqVTk1elIw?=
 =?utf-8?B?eUV3TXI3dVJCSlhWL0dzZ2NUajJ5anl5Zk5sUzdrajNISStna1luODBWL1hJ?=
 =?utf-8?B?eXFpMThzN1JpcEpaTXdWcjVIaVhUa3ZRQ0pPb2krWmlIdHBmK1JiVVdkVXE5?=
 =?utf-8?B?N1pTZmdNTWR3Q1lVcmRscDhaRnR6ekt6ZDh4K0V0eXJrZGdaekt3Z0FJZ3pC?=
 =?utf-8?B?c2oranFpSmM4U3RLYmdQTitUY09QdEJKbTlXWHhjVitTcGRlSzRXem9uZERZ?=
 =?utf-8?B?SFEwL1d0TW9ObHUxZ2V5TzZTR25xMkRtTEZMS08vNDN0WTE5MHJEbFlCbmsz?=
 =?utf-8?B?eEdBYVdFbktTVzJRa1FaSU90SUZKNkVrRmZCTGI4TEJ5NUJlSVB2enNmTFFI?=
 =?utf-8?B?Zk5yd1VhQStyZk4xdi9yUHdJSVpETWVBbzVjaFprajZVbmFKMWpXWXR2eEFj?=
 =?utf-8?B?L3pVMCtOTlRHcUZsYXkxUkdRMkNPbDFpaWpXdXQ0dVdyRXZxdUdQTjQycXBl?=
 =?utf-8?B?Ukcwd1owVVVhWWFNWE44a0paaWlCaXB6TTJid0RsOThKdXBMSk5laHRmL1d3?=
 =?utf-8?B?MFpoWGlIb3hyeHZzcTNpeTBIV1lheWhiY1NVV2hYQlo5bUdvRk9FcWhESUNG?=
 =?utf-8?B?Vmp6cDZIa2QwOEQ2RHJJL0s4bXhWOVNJdDc4c0M5a0ZRSWpNb1JhTStXYk9i?=
 =?utf-8?B?VGJ1NFZmTzV2YVpIUlkvM0VBS1dLOTV3K0JrL2liQjkxMldwcFo4MzVGSlYv?=
 =?utf-8?B?TmUycWo2M3puekpkU3JtdU1vdkN3K0dLdkVWbEd0RThKT0gvWFN1RE1RTE0v?=
 =?utf-8?B?ZlZYUDMzN1M3VW5TTDNhSHU3Q0lHdjdRREFvRFV4L0pmMC9EOWhQVktWNTBq?=
 =?utf-8?B?YjRmL0dtb0pZeXArTU5TZXI5QTdwdG0wQnVCb2xORlRtd0c3UmdXZ1V2NVVX?=
 =?utf-8?B?NWxkZlFRZm1Za1djcGJtRG13a0h5Y0lRb3BzRkZJbjdnT29LcFh6TFIrM21G?=
 =?utf-8?B?MUFSYldLdmxqejllcVlXT2pmSlhyeFM2dnhLSU14cGZRNnJnS3lLbS9idExR?=
 =?utf-8?B?QmowNmxscXkzUkFTcEZmU1JsVTlkK2RaY2tteGx6eU12blo5N0gwMDk5Q0hn?=
 =?utf-8?B?THEwRzVqSGFLdlFFMFpGN0JmTUVQb0ZOOGEwck4za3ZubVhVc1kyOURUZWhC?=
 =?utf-8?B?T0NXTlF4bCtlc1cwaGx3U2JOOVVBc3kzVWUzVWU4NCtvMVZvcUcxdVJvZWIy?=
 =?utf-8?B?LzRNcDNuMGZpOUdsY1BwZmdEam5Kem5PNmZjZ2NobnBMSnJjNmgyM2RvK1pV?=
 =?utf-8?Q?D6hGCf2ylTfXi90Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4E2EC605ABFE74D9A189F07357A74D4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abcceb82-3bbb-4113-5ddf-08da2e972dd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 13:00:07.0037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/ZGdasDFfIUv7/1khWTluuzr1jcv50uCy9I6z6Ox8pypuPRYjlzNgKDMZ0VbvaqBLB4gK6J1sWhSu9BYur+9g+t5RvQXPnxzHROrcUj6Ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4116
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQpPbiAzMC8wNC8yMDIyIDE2OjM2LCBQYWxtZXIgRGFiYmVsdCB3cm90ZToNCj4gRnJvbTogUGFs
bWVyIERhYmJlbHQgPHBhbG1lckByaXZvc2luYy5jb20+DQo+IA0KPiBPdXIgZXhpc3Rpbmcgc3Bp
bmxvY2tzIGFyZW4ndCBmYWlyIGFuZCByZXBsYWNpbmcgdGhlbSBoYXMgYmVlbiBvbiB0aGUNCj4g
VE9ETyBsaXN0IGZvciBhIGxvbmcgdGltZS4gIFRoaXMgbW92ZXMgdG8gdGhlIHJlY2VudGx5LWlu
dHJvZHVjZWQgdGlja2V0DQo+IHNwaW5sb2Nrcywgd2hpY2ggYXJlIHNpbXBsZSBlbm91Z2ggdGhh
dCB0aGV5IGFyZSBsaWtlbHkgdG8gYmUgY29ycmVjdA0KPiBhbmQgZmFzdCBvbiB0aGUgdmFzdCBt
YWpvcml0eSBvZiBleHRhbnQgaW1wbGVtZW50YXRpb25zLg0KPiANCj4gVGhpcyBpbnRyb2R1Y2Vz
IGEgaG9ycmlibGUgaGFjayB0aGF0IGFsbG93cyB1cyB0byBzcGxpdCBvdXQgdGhlIHNwaW5sb2Nr
DQo+IGNvbnZlcnNpb24gZnJvbSB0aGUgcndsb2NrIGNvbnZlcnNpb24uICBXZSBoYXZlIHRvIGRv
IHRoZSBzcGlubG9ja3MNCj4gZmlyc3QgYmVjYXVzZSBxcndsb2NrIG5lZWRzIGZhaXIgc3Bpbmxv
Y2tzLCBidXQgd2UgZG9uJ3Qgd2FudCB0byBwb2xsdXRlDQo+IHRoZSBhc20tZ2VuZXJpYyBjb2Rl
IHRvIHN1cHBvcnQgdGhlIGdlbmVyaWMgc3BpbmxvY2tzIHdpdGhvdXQgcXJ3bG9ja3MuDQo+IFRo
dXMgd2UgcG9sbHV0ZSB0aGUgUklTQy1WIGNvZGUsIGJ1dCBqdXN0IHVudGlsIHRoZSBuZXh0IGNv
bW1pdCBhcyBpdCdzDQo+IGFsbCBnb2luZyBhd2F5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGFs
bWVyIERhYmJlbHQgPHBhbG1lckByaXZvc2luYy5jb20+DQoNCkkgYW0gbG9hdGhlIHRvIGFkZCBh
IFRCIHRhZyBzaW5jZSBJIGhhdmUgbm90IGRvbmUgbXVjaCBieSB3YXkgb2YgdGVzdGluZw0KYW55
IHJlYWxpc3RpYyB1c2UgY2FzZXMgLSBidXQgSSBoYXZlIHB1dCBpdCBpbiBvdXIgQ0kgYW5kIGhh
dmUgaGFkIGEgcGxheQ0KYXJvdW5kIHdpdGggaXQgbG9jYWxseSAmIG5vdGhpbmcgb2J2aW91c2x5
IGJyb2tlIGZvciBtZS4NCg0KSWYgeW91IHRoaW5rIHRoYXQgaXMgc3VmZmljaWVudDoNClRlc3Rl
ZC1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCk90aGVyd2lz
ZSBmZWVsIGZyZWUgdG8gaWdub3JlIHRoZSB0YWcuDQoNClRoYW5rcywNCkNvbm9yLg0KDQo+IC0t
LQ0KPiAgIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vS2J1aWxkICAgICAgICAgICB8ICAyICsrDQo+
ICAgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9zcGlubG9jay5oICAgICAgIHwgNDQgKysrLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiAgIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vc3BpbmxvY2tfdHlw
ZXMuaCB8ICA5ICsrKy0tDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA0
NSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNt
L0tidWlsZCBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vS2J1aWxkDQo+IGluZGV4IDVlZGY1Yjg1
ODdlNy4uYzNmMjI5YWU4MDMzIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNt
L0tidWlsZA0KPiArKysgYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL0tidWlsZA0KPiBAQCAtMyw1
ICszLDcgQEAgZ2VuZXJpYy15ICs9IGVhcmx5X2lvcmVtYXAuaA0KPiAgIGdlbmVyaWMteSArPSBm
bGF0LmgNCj4gICBnZW5lcmljLXkgKz0ga3ZtX3BhcmEuaA0KPiAgIGdlbmVyaWMteSArPSBwYXJw
b3J0LmgNCj4gK2dlbmVyaWMteSArPSBxcndsb2NrLmgNCj4gK2dlbmVyaWMteSArPSBxcndsb2Nr
X3R5cGVzLmgNCj4gICBnZW5lcmljLXkgKz0gdXNlci5oDQo+ICAgZ2VuZXJpYy15ICs9IHZtbGlu
dXgubGRzLmgNCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vc3BpbmxvY2su
aCBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vc3BpbmxvY2suaA0KPiBpbmRleCBmNGY3ZmExYjdj
YTguLjg4YTRkNWQwZDk4YSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9z
cGlubG9jay5oDQo+ICsrKyBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vc3BpbmxvY2suaA0KPiBA
QCAtNyw0OSArNywxMyBAQA0KPiAgICNpZm5kZWYgX0FTTV9SSVNDVl9TUElOTE9DS19IDQo+ICAg
I2RlZmluZSBfQVNNX1JJU0NWX1NQSU5MT0NLX0gNCj4gICANCj4gKy8qIFRoaXMgaXMgaG9yaWJs
ZSwgYnV0IHRoZSB3aG9sZSBmaWxlIGlzIGdvaW5nIGF3YXkgaW4gdGhlIG5leHQgY29tbWl0LiAq
Lw0KPiArI2RlZmluZSBfX0FTTV9HRU5FUklDX1FSV0xPQ0tfSA0KPiArDQo+ICAgI2luY2x1ZGUg
PGxpbnV4L2tlcm5lbC5oPg0KPiAgICNpbmNsdWRlIDxhc20vY3VycmVudC5oPg0KPiAgICNpbmNs
dWRlIDxhc20vZmVuY2UuaD4NCj4gLQ0KPiAtLyoNCj4gLSAqIFNpbXBsZSBzcGluIGxvY2sgb3Bl
cmF0aW9ucy4gIFRoZXNlIHByb3ZpZGUgbm8gZmFpcm5lc3MgZ3VhcmFudGVlcy4NCj4gLSAqLw0K
PiAtDQo+IC0vKiBGSVhNRTogUmVwbGFjZSB0aGlzIHdpdGggYSB0aWNrZXQgbG9jaywgbGlrZSBN
SVBTLiAqLw0KPiAtDQo+IC0jZGVmaW5lIGFyY2hfc3Bpbl9pc19sb2NrZWQoeCkJKFJFQURfT05D
RSgoeCktPmxvY2spICE9IDApDQo+IC0NCj4gLXN0YXRpYyBpbmxpbmUgdm9pZCBhcmNoX3NwaW5f
dW5sb2NrKGFyY2hfc3BpbmxvY2tfdCAqbG9jaykNCj4gLXsNCj4gLQlzbXBfc3RvcmVfcmVsZWFz
ZSgmbG9jay0+bG9jaywgMCk7DQo+IC19DQo+IC0NCj4gLXN0YXRpYyBpbmxpbmUgaW50IGFyY2hf
c3Bpbl90cnlsb2NrKGFyY2hfc3BpbmxvY2tfdCAqbG9jaykNCj4gLXsNCj4gLQlpbnQgdG1wID0g
MSwgYnVzeTsNCj4gLQ0KPiAtCV9fYXNtX18gX192b2xhdGlsZV9fICgNCj4gLQkJIglhbW9zd2Fw
LncgJTAsICUyLCAlMVxuIg0KPiAtCQlSSVNDVl9BQ1FVSVJFX0JBUlJJRVINCj4gLQkJOiAiPXIi
IChidXN5KSwgIitBIiAobG9jay0+bG9jaykNCj4gLQkJOiAiciIgKHRtcCkNCj4gLQkJOiAibWVt
b3J5Iik7DQo+IC0NCj4gLQlyZXR1cm4gIWJ1c3k7DQo+IC19DQo+IC0NCj4gLXN0YXRpYyBpbmxp
bmUgdm9pZCBhcmNoX3NwaW5fbG9jayhhcmNoX3NwaW5sb2NrX3QgKmxvY2spDQo+IC17DQo+IC0J
d2hpbGUgKDEpIHsNCj4gLQkJaWYgKGFyY2hfc3Bpbl9pc19sb2NrZWQobG9jaykpDQo+IC0JCQlj
b250aW51ZTsNCj4gLQ0KPiAtCQlpZiAoYXJjaF9zcGluX3RyeWxvY2sobG9jaykpDQo+IC0JCQli
cmVhazsNCj4gLQl9DQo+IC19DQo+IC0NCj4gLS8qKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8NCj4gKyNpbmNsdWRlIDxhc20tZ2VuZXJp
Yy9zcGlubG9jay5oPg0KPiAgIA0KPiAgIHN0YXRpYyBpbmxpbmUgdm9pZCBhcmNoX3JlYWRfbG9j
ayhhcmNoX3J3bG9ja190ICpsb2NrKQ0KPiAgIHsNCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yv
aW5jbHVkZS9hc20vc3BpbmxvY2tfdHlwZXMuaCBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vc3Bp
bmxvY2tfdHlwZXMuaA0KPiBpbmRleCA1YTM1YTQ5NTA1ZGEuLmYyZjliNWQ3MTIwZCAxMDA2NDQN
Cj4gLS0tIGEvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9zcGlubG9ja190eXBlcy5oDQo+ICsrKyBi
L2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vc3BpbmxvY2tfdHlwZXMuaA0KPiBAQCAtNiwxNSArNiwx
NCBAQA0KPiAgICNpZm5kZWYgX0FTTV9SSVNDVl9TUElOTE9DS19UWVBFU19IDQo+ICAgI2RlZmlu
ZSBfQVNNX1JJU0NWX1NQSU5MT0NLX1RZUEVTX0gNCj4gICANCj4gKy8qIFRoaXMgaXMgaG9yaWJs
ZSwgYnV0IHRoZSB3aG9sZSBmaWxlIGlzIGdvaW5nIGF3YXkgaW4gdGhlIG5leHQgY29tbWl0LiAq
Lw0KPiArI2RlZmluZSBfX0FTTV9HRU5FUklDX1FSV0xPQ0tfVFlQRVNfSA0KPiArDQo+ICAgI2lm
bmRlZiBfX0xJTlVYX1NQSU5MT0NLX1RZUEVTX1JBV19IDQo+ICAgIyBlcnJvciAicGxlYXNlIGRv
bid0IGluY2x1ZGUgdGhpcyBmaWxlIGRpcmVjdGx5Ig0KPiAgICNlbmRpZg0KPiAgIA0KPiAtdHlw
ZWRlZiBzdHJ1Y3Qgew0KPiAtCXZvbGF0aWxlIHVuc2lnbmVkIGludCBsb2NrOw0KPiAtfSBhcmNo
X3NwaW5sb2NrX3Q7DQo+IC0NCj4gLSNkZWZpbmUgX19BUkNIX1NQSU5fTE9DS19VTkxPQ0tFRAl7
IDAgfQ0KPiArI2luY2x1ZGUgPGFzbS1nZW5lcmljL3NwaW5sb2NrX3R5cGVzLmg+DQo+ICAgDQo+
ICAgdHlwZWRlZiBzdHJ1Y3Qgew0KPiAgIAl2b2xhdGlsZSB1bnNpZ25lZCBpbnQgbG9jazsNCg==
