Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F1D5AFC4B
	for <lists+linux-arch@lfdr.de>; Wed,  7 Sep 2022 08:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiIGGXr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Sep 2022 02:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiIGGXq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Sep 2022 02:23:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE689E10D;
        Tue,  6 Sep 2022 23:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662531825; x=1694067825;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dBiX8MhMStHthauI6xpSUo2HBlgRJ7I1oCJYxCDLikI=;
  b=0uaTTZgdceY6eUKMA0iu6vciy6GUcj/bMdGpULKoeKwCX/kdl6l9fIno
   Zku8l4RJRLLpr5FtciWKEqu8Y6pYReihxvLWoYz+PC7ihWXpPADSJ78L1
   nIbaV/hsklM7rKdKlZ98999TXTl40Ie90FBdlPTMb3gPTVNimnMYgHcRP
   xDINHg4YURD/tFJC8FkBUYCIjQI4ChpnjNQE+dLa4SX9m0JUA/eIu9H89
   tupzC5MhA18r6eVrDcfhS2/Ctth0jhXXUxKshDzcsiAv6yL5p2wEBrszF
   EVWTqUSW/2Mk9EfPawkeupkQ4h3CTlytLYZaYMFQjEuYw5mTZRU0nndWi
   g==;
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="189742995"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Sep 2022 23:23:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 6 Sep 2022 23:23:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 6 Sep 2022 23:23:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUrKvaOMieFZBdQI7NyeZ4Wuqh5OzCDPa9c2R5ia2zxz7D+3Srlk4IB7otfoyh+rWbxw8AsS5RX0+t0QUqI0w7XOW28G5PKZpcdpEF35ACHfmHBD58YP3KWhr3ne5GhCAscuSxP6Cun2BNVcI0hU3NQQSYsU+EkMATyNumjV/6zyQx0zj0d2+C/Qp7xl4AoA0U2ue1s4Dk7U6Qs1p6B/DDiAVBJZFg8yH6zbVCWbH5VNiFPa+INv4/h0fclpuxP0/ZLozCJTwtfPrUzubemAbOrIfKYrDX25W8GvL6jaOts9oXei3C5+AnDwf9CDaEJS5uL0Jzby0zv/KJrvuKl1rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBiX8MhMStHthauI6xpSUo2HBlgRJ7I1oCJYxCDLikI=;
 b=XWAGLYmlcbGp9dBmtFXO1qceJZMPbvQFWHTxEGp/GZDKE2J4zrZaxbKklSidLgx/tn8BszqfCA1ii04tpxhDBdMXillyvZY11I5z5ITlU/qZGKb2kTtfRYBFhsCnPa0wdPF348xXTGht4zkT48cJ454E6SGMjSdCOQze6UgpckTxdNmxEGU1/hPNnfrVM8Pi+au7E9u7+Ic1PblMUOWQ+XJXZhFltmdhozJZAJcrBDFrrKDnvagGipTEl4lsi1F3T6wL5dMpyyYv3nxqgF9OozNVH57bpA8TSKglCb7a9otfzR0VwHbXacVBvk+i8WkVOWL9OtLAbGrzMZ26Y2aSpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBiX8MhMStHthauI6xpSUo2HBlgRJ7I1oCJYxCDLikI=;
 b=XscCET4gdrKHmpO6gaLQwWZGk+1Rre4fn6iC2MNXJDSX+2qFy3kGtY3BKTHrim8MA4H93pB/pjlv8CnKSm41hnr2yBiN4IRurUncbKGepaI7xYDp6Zfb4EKyS+RD1jZqezgDR2I09uztyZCi0x95IdOuJNgp2TZtyDzZKtHCTVU=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BL3PR11MB6338.namprd11.prod.outlook.com (2603:10b6:208:3b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Wed, 7 Sep
 2022 06:23:41 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 06:23:41 +0000
From:   <Conor.Dooley@microchip.com>
To:     <guoren@kernel.org>
CC:     <arnd@arndb.de>, <palmer@rivosinc.com>, <tglx@linutronix.de>,
        <peterz@infradead.org>, <luto@kernel.org>, <heiko@sntech.de>,
        <jszhang@kernel.org>, <lazyparser@gmail.com>, <falcon@tinylab.org>,
        <chenhuacai@kernel.org>, <apatel@ventanamicro.com>,
        <atishp@atishpatra.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <bigeasy@linutronix.de>,
        <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <guoren@linux.alibaba.com>
Subject: Re: [PATCH V3 0/7] riscv: Add GENERIC_ENTRY, irq stack support
Thread-Topic: [PATCH V3 0/7] riscv: Add GENERIC_ENTRY, irq stack support
Thread-Index: AQHYwaR9Zg4qVJdaxUOmW+ltdyCEZa3SrMIAgAB4ugCAACDqAIAAOvqA
Date:   Wed, 7 Sep 2022 06:23:41 +0000
Message-ID: <fb17255a-62ea-54c0-96a0-c19072c25ad5@microchip.com>
References: <20220906035423.634617-1-guoren@kernel.org>
 <8db7caea-a1a0-25a3-ade0-2f1714d709c8@microchip.com>
 <CAJF2gTQ29bn=hgubC+YU1qSw_L3W2kAt3Yi4_EknrNCkR-dRFg@mail.gmail.com>
 <CAJF2gTRU6xWv5z7FvYkupCfmc0_EEceeowpjemoUWSAz8OgfWg@mail.gmail.com>
In-Reply-To: <CAJF2gTRU6xWv5z7FvYkupCfmc0_EEceeowpjemoUWSAz8OgfWg@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5bfd8a2-b85a-4d2d-6920-08da90998235
x-ms-traffictypediagnostic: BL3PR11MB6338:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N3eCJJqWxU02zNYWYiQbGGIks3NzN2dKoSlU/nVAW6El0VprhRC6xdXraDCD6P4JT62A9EUp02Lwb5laGoa8JJnIvkOuRGyFRoV+4mulzPsBdblQWYWr3Bo6EZED6PwcTX712sNXAzxSzFgXdMb4Vinbzs/wOpNKcY1sxYM2yuvy8OOi/mQqqW9vc4R3HRdS+b86oDQwFqj74NPCC1edOyS7ybI6oGwsqxQzqpEKI+Uo8aq3e/e/QDRhFm5c1FiQZHS/cHt/jpwNyBIFW9sWMeYwgHi2sV7P6rJwvbTOPfOpHCTl6cNyJMDCagozxHPthB8yaLb3ULD36KUrz6Ce8e2kS5fUSaTtGayur8prwx0qs+iTmQBibidOM5ePtYoPqkF2SAckg9xEgbmktLJKAyW5mh1nsKdhhawi1FdjepphNVnAI7fHpvwNuk/MfMntzZjiiRpb5KR1VjCU8EM2vs4AOr8ZMGsJjwkwieyxTrXPcK+3H48ismgpREfL8FIFnYLFqT3BGbOYiv9+CBNU+OZfYJwuvEGeIkYVZD6Mo/Ut43IOEr+vjw7xwpYZnQnP7KGzvq6F65OJlViurkNlssBcus9lWo4ZVNRKnDO05MhkCLDoVxy3ojJJ4mtEebgXnY1PiJpezeyxb7Bdx+hPHDdKDELEfM0E6xgJ09xUGkeWVeeFuOSQoGaX5MwekYChmBEjYvDQXtY9fG34jJS3vkNhdmmsyTlaZpOHpoxMuWNeGx9ZRLBy3/muesQC/NoSaEcV5krwKPBxtJ7KItpbas28jo63ic6EIh3FP/JPV41Q1oLliM1Z158QfqWPr5yr1oY12BBw1ZYSXnRH12MgfksvO9Wwdso6KaWNsntyMGAOdemA9KIcSI1vgEJXxgxRLt/S+EKo+y5czmEJY2SJJzcRKKVJI/wSjzh5CsGVryk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(346002)(39860400002)(376002)(38070700005)(66946007)(66476007)(6916009)(122000001)(38100700002)(66556008)(4326008)(8676002)(64756008)(91956017)(316002)(54906003)(66446008)(76116006)(5660300002)(2906002)(7416002)(8936002)(2616005)(26005)(6512007)(83380400001)(6486002)(966005)(71200400001)(41300700001)(86362001)(478600001)(186003)(36756003)(53546011)(6506007)(31696002)(31686004)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1AxZjBlQ0s2UzZtSlNsM01teTdLT1dUOWplWks2UkJGc01lVHRtMXI4ckh1?=
 =?utf-8?B?TW1COWs3eVdhckxBQVRLT2Rpb2xQQkFGU3pwZndlUGtxTVBXTTlsWmkxQkZo?=
 =?utf-8?B?WmNpcUFLMGtubGtMcEkwUmpCSStNdjN4MkZIc1RmTXRKNXJnVmhyQzUzSE1F?=
 =?utf-8?B?M1EwZXJYRElYcGFQU1RkUmVxQVBHWEVSSE1NMzJSb0VEOU5ZWDFSSGxtU1hi?=
 =?utf-8?B?R3ZMbVRCZzhRRUdOMFEyUm81MjZ3b0tTWGVTYSttekpJZysxYXQ3VE13U29H?=
 =?utf-8?B?dzR6SWhhNXprbnRKODZROE9mSERBYlRPUzk4c3NFNTIwZDJid29UbldWUEVj?=
 =?utf-8?B?RFV4eVV0V3FlblNuVlFFV2FOZzhua0NDNlZVeWVMdlE0TFFLS1VhYjFBUUN0?=
 =?utf-8?B?dkw5K0h6SnBObnNVK3lCZXpXTzN3Y2tLQkovV01RcmFFcUtyOFhrNi9LRjgw?=
 =?utf-8?B?UjVmcVVwN3p5cGk2amdieFBiYUwrYlBBVnBid05GcStTbSthSDBmNk1vK3Ju?=
 =?utf-8?B?cVVHaU9OV3B2RTZMSm9PQUtDZGh1eGVXVGU1bmtkcWI2RUJTc2g0Qm1jdFZ2?=
 =?utf-8?B?RmJPK05wNkt0d1d0OWo5aDRKQjJIRzVzVFRQWExLNUhhd011Zys0ajFPY3VN?=
 =?utf-8?B?U3Jwb0tpOGFSaGMyZ1hYTWVwYVk2YTVNa25tZk5QUWNZTHhlbWdiL29pcWpP?=
 =?utf-8?B?VkJOdlR6aTFuUGZuaEZtelJCK0JwekFxK2dmdUIvcG0xVGd6dElmbDNFdmJY?=
 =?utf-8?B?MmpnSjN1MVU1SDZvSzB2S29NRDB4c2RBdnNOR1Jyb0RiYi9JNTlyclJzdDEw?=
 =?utf-8?B?QmVQMXBROHBnSlA0OW85TjZSWnlHVjAzblQyWlpUdGFqT3hYRmR6TGJ4VGFm?=
 =?utf-8?B?ZnVTUWRuVkhTYldNMnRkNlBoNzRyYUJjNlIwSlVXMDkrVmlwbnhvVjhScjJw?=
 =?utf-8?B?RXQ1Z0VNdTdZaTV1QU5ROU1uVUdrbG15K2VFUDhKbERtdE9CUDB4aGJpRW5k?=
 =?utf-8?B?ZG1KK2FOa0l0bkdSMWx4d0dZcCtZMHhjMHovYXpRL3FZTVNGRjZIVURmV05u?=
 =?utf-8?B?VXV2bmhlZ2FWc1E1VzNNV3h3c3d5V2lhdmIvT0w3aTgwWWxSdU9Sb2dLNzZH?=
 =?utf-8?B?aU5jRmw0TmxoMFhVYkh2ZGNyWis5TDZKOGwwWmNuSWZCOGN0bkZqOFJWdExt?=
 =?utf-8?B?UGZCTGlVNFJ5U3I5aUZNamVGWXcyL0Y4U3puc2lva1ZxK1g0bFBNSDZoS2t2?=
 =?utf-8?B?VzRLWmozblpNaW9vR1JHTlhQTG9wRjdsZUhRT1VuWkp2bFVIdk1ZQWhudUVj?=
 =?utf-8?B?cnc3UlVnRjFNZlBqQVAyUHIyQ3o0N3RPRSt2OEhXakZJU0QzUGozdk1FMGt4?=
 =?utf-8?B?K05xdHJmZyttUVBwQVFWNmRNTnJqNFBZQ3o3bmhnUnBFMm1WdG55MGpsWm80?=
 =?utf-8?B?MXZ1SGx6WUhjRkFCK1VuUVUydzYwWHJIRWhWaUF0U29rREtsNTlJRW9JQURv?=
 =?utf-8?B?dDVLaTVXUXN2ay85NFN6MDZhd015SEdLUXRyczVXYi9BYlhHVGRNbjZBRDdw?=
 =?utf-8?B?SzFNeU1PYkl4QzRzbmEzd0lEMGFsaFlKamR1WXQ2Z0c4R29taU9nNHdSdEZJ?=
 =?utf-8?B?bzdQQ1BHdkE4aTlQS2wxK0NZRVVYRVE3WDF0UVJ4b1BOVW1ZNVUrLytwZVBQ?=
 =?utf-8?B?VVJrQlF0Wk9CUDhTTm1OSE9hSjZ3Q01IUmxwWVdPNmlYZEdYT1F2NjRuUlJO?=
 =?utf-8?B?TC9Tbm5tMGNEdEJMc2prOUNCK0Q5b3JaTGNSdWNOZFdZdnc1cW5TYVlYVnpo?=
 =?utf-8?B?UUZ1Zm5jN0FNT2VhckpCbmVySnN1VXduOWdWZXNDSXMwZDhlRDl2dk83WnYw?=
 =?utf-8?B?bGVGWms0ems0eG9SWGxna3JMTkREeEtKU2w0Z3hsZ2FPSlJxZXR0eWJoczNT?=
 =?utf-8?B?SHAwRC9KaGEySEtxamVET3JmenBnR3BOU1pCKy8rcEdmK1c1STAwNG45L1B4?=
 =?utf-8?B?SFg2dmlaTXg0WVRJcGZsbG9DUVl3VFBSd1phUEdxSnRRR1dKS0RGd3FhQ3Jx?=
 =?utf-8?B?M2c1QWw0MWJ3SE40WlJ5dE8rSTY2cWhwY2JURnRnZkp3REtmaVJiOThhV0gz?=
 =?utf-8?Q?ZIUJOpJ5lhkTtIcJG/m+w455f?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0414E527688944439806CC73C328EE50@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5bfd8a2-b85a-4d2d-6920-08da90998235
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 06:23:41.4656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +HOpPHrJGB0lyx08OR4LPgQ04ZhxqBs6eskb24krAGNcpH7OqxDttfQsRH2a950pFX4rh+5pzLYYEKdrzS2nC6CnKdjHztW/SVYG+kBiuIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6338
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMDcvMDkvMjAyMiAwMzo1MiwgR3VvIFJlbiB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+IA0KPiBIaSBDb25vciwNCj4gDQo+IEkndmUgZm91bmQgdGhlIHJv
b3QgY2F1c2UsIHlvdSBhcmUgdXNpbmcgbGx2bToNCg0KWXVwLCBwcm9iYWJseSBzaG91bGQgaGF2
ZSBzcGVjaWZpZWQgLSBzb3JyeS4gSSBkaWRuJ3QgcmVhbGlzZSB0aGF0DQp0aGF0IHdhcyBzb21l
dGhpbmcgR0NDIHdvdWxkbid0IGNvbXBsYWluIGFib3V0LiBJdCB3YXMgYW4gTExWTT0xDQpidWls
ZCB3aXRoIGNsYW5nLTE1Lg0KDQpJIHVzdWFsbHkgZG8gYnVpbGRzIHdpdGggY2xhbmcgd2hpbGUg
dGVzdGluZyBwYXRjaGVzIGFzIGl0IHNlZW1zDQp0byBiZSBsZXNzZXIgdXNlZC4NCg0KVGhhbmtz
LA0KQ29ub3IuDQoNCj4gDQo+ICQgZ3JlcCAiYmFyZSBzeW0iIGxsdm0gLXJuIHxncmVwIFJJU0NW
DQo+IGxsdm0vbGliL1RhcmdldC9SSVNDVi9Bc21QYXJzZXIvUklTQ1ZBc21QYXJzZXIuY3BwOjEy
OTY6IHJldHVybg0KPiBFcnJvcihFcnJvckxvYywgIm9wZXJhbmQgbXVzdCBiZSBhIGJhcmUgc3lt
Ym9sIG5hbWUiKTsNCj4gbGx2bS9saWIvVGFyZ2V0L1JJU0NWL0FzbVBhcnNlci9SSVNDVkFzbVBh
cnNlci5jcHA6MTMwNDogcmV0dXJuDQo+IEVycm9yKEVycm9yTG9jLCAib3BlcmFuZCBtdXN0IGJl
IGEgYmFyZSBzeW1ib2wgbmFtZSIpOw0KPiANCj4gVGhhdCBtZWFucyB3ZSBjb3VsZCBmaXggdXAg
QmludXRpbHMgd2l0aCBhIHdhcm5pbmcgYXQgbGVhc3QuDQo+IA0KPiBUaHggZm9yIHBvaW50aW5n
IGl0IG91dC4NCj4gDQo+IE9uIFdlZCwgU2VwIDcsIDIwMjIgYXQgODo1NCBBTSBHdW8gUmVuIDxn
dW9yZW5Aa2VybmVsLm9yZz4gd3JvdGU6DQo+Pg0KPj4gT24gV2VkLCBTZXAgNywgMjAyMiBhdCAx
OjQyIEFNIDxDb25vci5Eb29sZXlAbWljcm9jaGlwLmNvbT4gd3JvdGU6DQo+Pj4NCj4+PiBPbiAw
Ni8wOS8yMDIyIDA0OjU0LCBndW9yZW5Aa2VybmVsLm9yZyB3cm90ZToNCj4+Pj4gRnJvbTogR3Vv
IFJlbiA8Z3VvcmVuQGxpbnV4LmFsaWJhYmEuY29tPg0KPj4+Pg0KPj4+PiBUaGUgcGF0Y2hlcyBj
b252ZXJ0IHJpc2N2IHRvIHVzZSB0aGUgZ2VuZXJpYyBlbnRyeSBpbmZyYXN0cnVjdHVyZSBmcm9t
DQo+Pj4+IGtlcm5lbC9lbnRyeS8qLiBBZGQgaW5kZXBlbmRlbnQgaXJxIHN0YWNrcyAoSVJRX1NU
QUNLUykgZm9yIHBlcmNwdSB0bw0KPj4+PiBwcmV2ZW50IGtlcm5lbCBzdGFjayBvdmVyZmxvd3Mu
IEFkZCB0aGUgSEFWRV9TT0ZUSVJRX09OX09XTl9TVEFDSw0KPj4+PiBmZWF0dXJlIGZvciB0aGUg
SVJRX1NUQUNLUyBjb25maWcuIFlvdSBjYW4gdHJ5IGl0IGRpcmVjdGx5IHdpdGggWzFdLg0KPj4+
DQo+Pj4gSGV5IEd1byBSZW4sDQo+Pj4gSSBhcHBsaWVkIHRoaXMgcGF0Y2hzZXQgdG8gdjYuMC1y
YzQgJiByYW4gaW50byBhIGJ1aWxkIGVycm9yOg0KPj4+IC9zdHVmZi9saW51eC9hcmNoL3Jpc2N2
L2tlcm5lbC9lbnRyeS5TOjM0Nzo5OiBlcnJvcjogb3BlcmFuZCBtdXN0IGJlIGEgYmFyZSBzeW1i
b2wgbmFtZQ0KPj4+ICAgbGEgYTMsICgoMSA8PCAoMTIpKSA8PCAoMiArIDApKQ0KPj4gWWVzLCBw
bGVhc2UgdHJ5Og0KPj4gLSAgICAgICBsYSAgICAgIGEzLCBJUlFfU1RBQ0tfU0laRQ0KPj4gKyAg
ICAgICBsaSAgICAgIGEzLCBJUlFfU1RBQ0tfU0laRQ0KPj4NCj4+IGxhIGlzIGZvciB0aGUgc3lt
Ym9sLCBub3QgaW1tZWRpYXRlLiBCdXQgd2h5IGRvZXMgbXkgdG9vbGNoYWluIG5vdA0KPj4gcmVw
b3J0IHRoZSBlcnJvcj8NCj4+DQo+PiDinpwgIGxpbnV4IGdpdDooZ2VuZXJpY19lbnRyeV92Mykg
bWFrZSBBUkNIPXJpc2N2DQo+PiBDUk9TU19DT01QSUxFPXJpc2N2NjQtdW5rbm93bi1saW51eC1n
bnUtIEVYVFJBX0NGTEFHUys9LWcNCj4+IE89Li4vYnVpbGQtcmlzY3YvIC1rajYyIGFsbCAta2oN
Cj4+IOKenCAgbGludXggZ2l0OihnZW5lcmljX2VudHJ5X3YzKSByaXNjdjY0LXVua25vd24tbGlu
dXgtZ251LWdjYyAtdg0KPj4gVXNpbmcgYnVpbHQtaW4gc3BlY3MuDQo+PiBDT0xMRUNUX0dDQz1y
aXNjdjY0LXVua25vd24tbGludXgtZ251LWdjYw0KPj4gQ09MTEVDVF9MVE9fV1JBUFBFUj0vb3B0
L3Jpc2N2L2xpYmV4ZWMvZ2NjL3Jpc2N2NjQtdW5rbm93bi1saW51eC1nbnUvMTEuMS4wL2x0by13
cmFwcGVyDQo+PiBUYXJnZXQ6IHJpc2N2NjQtdW5rbm93bi1saW51eC1nbnUNCj4+IENvbmZpZ3Vy
ZWQgd2l0aDoNCj4+IC9ob21lL2d1b3Jlbi9zb3VyY2UvcmlzY3YtZ251LXRvb2xjaGFpbi9yaXNj
di1nY2MvY29uZmlndXJlDQo+PiAtLXRhcmdldD1yaXNjdjY0LXVua25vd24tbGludXgtZ251IC0t
cHJlZml4PS9vcHQvcmlzY3YNCj4+IC0td2l0aC1zeXNyb290PS9vcHQvcmlzY3Yvc3lzcm9vdCAt
LXdpdGgtcGtndmVyc2lvbj1nNTk2NGI1Y2Q3MjcyDQo+PiAtLXdpdGgtc3lzdGVtLXpsaWIgLS1l
bmFibGUtc2hhcmVkIC0tZW5hYmxlLXRscw0KPj4gLS1lbmFibGUtbGFuZ3VhZ2VzPWMsYysrLGZv
cnRyYW4gLS1kaXNhYmxlLWxpYm11ZGZsYXAgLS1kaXNhYmxlLWxpYnNzcA0KPj4gLS1kaXNhYmxl
LWxpYnF1YWRtYXRoIC0tZGlzYWJsZS1saWJzYW5pdGl6ZXIgLS1kaXNhYmxlLW5scw0KPj4gLS1k
aXNhYmxlLWJvb3RzdHJhcCAtLXNyYz0uLi8uL3Jpc2N2LWdjYyAtLWVuYWJsZS1tdWx0aWxpYg0K
Pj4gLS13aXRoLWFiaT1scDY0ZCAtLXdpdGgtYXJjaD1ydjY0aW1hZmRjIC0td2l0aC10dW5lPXJv
Y2tldA0KPj4gLS13aXRoLWlzYS1zcGVjPTIuMiAnQ0ZMQUdTX0ZPUl9UQVJHRVQ9LU8yICAgLW1j
bW9kZWw9bWVkbG93Jw0KPj4gJ0NYWEZMQUdTX0ZPUl9UQVJHRVQ9LU8yICAgLW1jbW9kZWw9bWVk
bG93Jw0KPj4gVGhyZWFkIG1vZGVsOiBwb3NpeA0KPj4gU3VwcG9ydGVkIExUTyBjb21wcmVzc2lv
biBhbGdvcml0aG1zOiB6bGliDQo+PiBnY2MgdmVyc2lvbiAxMS4xLjAgKGc1OTY0YjVjZDcyNzIp
DQo+Pg0KPj4NCj4+DQo+Pj4gICAgICAgICAgXg0KPj4+ICAgIENDICAgICAgYXJjaC9yaXNjdi9r
ZXJuZWwvcHJvY2Vzcy5vDQo+Pj4gbWFrZVs1XTogKioqIFsvc3R1ZmYvbGludXgvc2NyaXB0cy9N
YWtlZmlsZS5idWlsZDozMjI6IGFyY2gvcmlzY3Yva2VybmVsL2VudHJ5Lm9dIEVycm9yIDENCj4+
PiBtYWtlWzVdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLg0KPj4+DQo+Pj4g
VGhhbmtzLA0KPj4+IENvbm9yLg0KPj4+Pg0KPj4+PiBbMV0gaHR0cHM6Ly9naXRodWIuY29tL2d1
b3JlbjgzL2xpbnV4L3RyZWUvZ2VuZXJpY19lbnRyeV92Mw0KPj4+Pg0KPj4+PiBWMzoNCj4+Pj4g
ICAtIEZpeHVwIENPTkZJR19DT01QQVQ9biBjb21waWxlIGVycm9yDQo+Pj4+ICAgLSBBZGQgVEhS
RUFEX1NJWkVfT1JERVIgY29uZmlnDQo+Pj4+ICAgLSBPcHRpbWl6ZSBlbGZfa2V4ZWMuYyB3YXJu
aW5nIGZpeHVwDQo+Pj4+ICAgLSBBZGQgc3RhdGljIHRvIGlycV9zdGFja19wdHIgZGVmaW5pdGlv
bg0KPj4+Pg0KPj4+PiBWMjoNCj4+Pj4gICBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1yaXNjdi8yMDIyMDkwNDA3MjYzNy44NjE5LTEtZ3VvcmVuQGtlcm5lbC5vcmcvDQo+Pj4+
ICAgLSBGaXh1cCBjb21waWxlIGVycm9yIGJ5IGluY2x1ZGUgInJpc2N2OiBwdHJhY2U6IFJlbW92
ZSBkdXBsaWNhdGUNCj4+Pj4gICAgIG9wZXJhdGlvbiINCj4+Pj4gICAtIEZpeHVwIGNvbXBpbGUg
d2FybmluZw0KPj4+PiAgICAgUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50
ZWwuY29tPg0KPj4+PiAgIC0gQWRkIHRlc3QgcmVwbyBsaW5rIGluIGNvdmVyIGxldHRlcg0KPj4+
Pg0KPj4+PiBWMToNCj4+Pj4gICBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1y
aXNjdi8yMDIyMDkwMzE2MzgwOC4xOTU0MTMxLTEtZ3VvcmVuQGtlcm5lbC5vcmcvDQo+Pj4+DQo+
Pj4+IEd1byBSZW4gKDcpOg0KPj4+PiAgICByaXNjdjogZWxmX2tleGVjOiBGaXh1cCBjb21waWxl
IHdhcm5pbmcNCj4+Pj4gICAgcmlzY3Y6IGNvbXBhdF9zeXNjYWxsX3RhYmxlOiBGaXh1cCBjb21w
aWxlIHdhcm5pbmcNCj4+Pj4gICAgcmlzY3Y6IHB0cmFjZTogUmVtb3ZlIGR1cGxpY2F0ZSBvcGVy
YXRpb24NCj4+Pj4gICAgcmlzY3Y6IGNvbnZlcnQgdG8gZ2VuZXJpYyBlbnRyeQ0KPj4+PiAgICBy
aXNjdjogU3VwcG9ydCBIQVZFX0lSUV9FWElUX09OX0lSUV9TVEFDSw0KPj4+PiAgICByaXNjdjog
U3VwcG9ydCBIQVZFX1NPRlRJUlFfT05fT1dOX1NUQUNLDQo+Pj4+ICAgIHJpc2N2OiBBZGQgY29u
ZmlnIG9mIHRocmVhZCBzdGFjayBzaXplDQo+Pj4+DQo+Pj4+ICAgYXJjaC9yaXNjdi9LY29uZmln
ICAgICAgICAgICAgICAgICAgICB8ICAxOSArKw0KPj4+PiAgIGFyY2gvcmlzY3YvaW5jbHVkZS9h
c20vY3NyLmggICAgICAgICAgfCAgIDEgLQ0KPj4+PiAgIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20v
ZW50cnktY29tbW9uLmggfCAgIDggKw0KPj4+PiAgIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vaXJx
LmggICAgICAgICAgfCAgIDMgKw0KPj4+PiAgIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vcHRyYWNl
LmggICAgICAgfCAgMTAgKy0NCj4+Pj4gICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3N0YWNrdHJh
Y2UuaCAgIHwgICA1ICsNCj4+Pj4gICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3N5c2NhbGwuaCAg
ICAgIHwgICA2ICsNCj4+Pj4gICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3RocmVhZF9pbmZvLmgg
IHwgIDE5ICstDQo+Pj4+ICAgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS92bWFwX3N0YWNrLmggICB8
ICAyOCArKysNCj4+Pj4gICBhcmNoL3Jpc2N2L2tlcm5lbC9NYWtlZmlsZSAgICAgICAgICAgIHwg
ICAxICsNCj4+Pj4gICBhcmNoL3Jpc2N2L2tlcm5lbC9lbGZfa2V4ZWMuYyAgICAgICAgIHwgICAy
ICstDQo+Pj4+ICAgYXJjaC9yaXNjdi9rZXJuZWwvZW50cnkuUyAgICAgICAgICAgICB8IDI1NSAr
KysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4+PiAgIGFyY2gvcmlzY3Yva2VybmVsL2lycS5j
ICAgICAgICAgICAgICAgfCAgNzUgKysrKysrKysNCj4+Pj4gICBhcmNoL3Jpc2N2L2tlcm5lbC9w
dHJhY2UuYyAgICAgICAgICAgIHwgIDQxIC0tLS0tDQo+Pj4+ICAgYXJjaC9yaXNjdi9rZXJuZWwv
c2lnbmFsLmMgICAgICAgICAgICB8ICAyMSArLS0NCj4+Pj4gICBhcmNoL3Jpc2N2L2tlcm5lbC9z
eXNfcmlzY3YuYyAgICAgICAgIHwgIDI3ICsrKw0KPj4+PiAgIGFyY2gvcmlzY3Yva2VybmVsL3Ry
YXBzLmMgICAgICAgICAgICAgfCAgMTEgKysNCj4+Pj4gICBhcmNoL3Jpc2N2L21tL2ZhdWx0LmMg
ICAgICAgICAgICAgICAgIHwgIDEyICstDQo+Pj4+ICAgMTggZmlsZXMgY2hhbmdlZCwgMjU5IGlu
c2VydGlvbnMoKyksIDI4NSBkZWxldGlvbnMoLSkNCj4+Pj4gICBjcmVhdGUgbW9kZSAxMDA2NDQg
YXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9lbnRyeS1jb21tb24uaA0KPj4+PiAgIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3ZtYXBfc3RhY2suaA0KPj4+Pg0KPj4NCj4+
DQo+Pg0KPj4gLS0NCj4+IEJlc3QgUmVnYXJkcw0KPj4gICBHdW8gUmVuDQo+IA0KPiANCj4gDQo+
IC0tDQo+IEJlc3QgUmVnYXJkcw0KPiAgIEd1byBSZW4NCg0K
