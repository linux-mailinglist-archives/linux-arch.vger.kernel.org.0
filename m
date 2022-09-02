Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C5C5AB66A
	for <lists+linux-arch@lfdr.de>; Fri,  2 Sep 2022 18:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiIBQWj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Sep 2022 12:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbiIBQWi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Sep 2022 12:22:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476EAC0BFD
        for <linux-arch@vger.kernel.org>; Fri,  2 Sep 2022 09:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662135754; x=1693671754;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=G+uI7ZhoVTv0G3UnwmRRej9I/GaxvpHqc37vQDAO1BA=;
  b=KSYnGAon05mC6+6uEubnOu7j3nA3tvqblFepC9OPc27KoDMb09C+j0QG
   vh2fBC/NGs+i0m3wH8ice6CxFZ3UlTW4wrz74PvhaKEzxMK0i6IJhmevo
   GyXQ6R+a9B+oiE/o963SGITuGyRpKeNVPBgRrGCBzBhAR6qBNtbFjND8g
   OW0aG1bsGxhkXfsIni80dKAihqHmqdOrFLK7gKnrh3oYJqC76xfwcf1i/
   vCr+Ntowq58sSVz7YtNbRp2kb8MlGuAa3rnPNa4paaNR6rGmVGCzqCLsP
   CPCZnzgvuV6kaKXEXaUxsrkeK3dDrRLfRI6/sRYQivN9VPt31RPu3HTlr
   g==;
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="175406902"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Sep 2022 09:22:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 2 Sep 2022 09:22:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 2 Sep 2022 09:22:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isQmnlwZ+6ymmCxz6vWgjH6C5sW+GCZFxfuNR7oWIe7s7NyB0f76jDI4KRqs8gS9o9/saEb9sbtQAvn7rtXg1UcWAxDzI86JCf3geo1F8WOWujXzzn20PFlUBrvINb1kGl/83uwiGm0z8bkgbDSdCDjexdbVDGnr0O4dA9T8CWND2ZTSpXO/HTfc1v+wLAfn+2w3dUB/l8v/nEk12EmfXUFIADerEuXPizzyYePGJYIptmVitGZmqMBy3P5KNDTo+9Ml2GWpJdZwtm0Twr+LYKNRS9dU9fXFI2Gsn1HWrvzEXLIb1qZJbAFH18tYrLCsHeH2+1A/tKWw68PPNUbviA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+uI7ZhoVTv0G3UnwmRRej9I/GaxvpHqc37vQDAO1BA=;
 b=ZS2M+OYirnDD7d/yxe5UuCAQZX27oN+Lm10zUCjZhV4RM4kNOO1QP/GvJDfYU6flpMznA8n36oFqaseLqOTcRmYFAKph28xKvwdzIa3DRN+fCtC4RZuDSRP0pgTfBbXGIF9Yd12rhvgZaOrvUwdox8sQZSqt3lGuNvahvhPLBbYAizIgfuIUfIw55WtkGrI47f+6gl6y6MZoG4ci/coXYun05alaQ/yARwQGD/fz/cRfbz4V/nCUVLPOVhzy2EhIHhbWLDK9vqYxWmiHmbxDI5wNMDOYp9rmxq5Yz5Yjq4Ymx3+bTEyP3JCLpKEF2Ausl9kcF2YYij7nBO7eT1XSug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+uI7ZhoVTv0G3UnwmRRej9I/GaxvpHqc37vQDAO1BA=;
 b=TXe9YPyWkwlZGP9XIqpQTboiP3GI/7miUTpbO3EQzu87a2yo8e0Gy5/zO3ajyNQnS+fPfz+7ux1yhYe6TbCs482aGaWiLhZ6l9viFKZES/Acy2DRg5x1lCb/h87sAjSG0AejyfDsL2BmWdTCD7wdD3aSz3R7YkeW2IqpN0NoSLo=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MN2PR11MB3646.namprd11.prod.outlook.com (2603:10b6:208:f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 16:22:22 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.016; Fri, 2 Sep 2022
 16:22:22 +0000
From:   <Conor.Dooley@microchip.com>
To:     <vladimir.isaev@syntacore.com>, <linux-arch@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <atishp@atishpatra.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <anup@brainfault.org>
CC:     <ajones@ventanamicro.com>
Subject: Re: [PATCH v3] riscv: Fix permissions for all mm's during mm init
Thread-Topic: [PATCH v3] riscv: Fix permissions for all mm's during mm init
Thread-Index: AQHYvrTMgmHvyyFJk0WgMDlPWFbNm63MUvIA
Date:   Fri, 2 Sep 2022 16:22:22 +0000
Message-ID: <49acc483-a356-5db1-c326-39c1eb2162a3@microchip.com>
References: <20220902101312.220350-1-vladimir.isaev@syntacore.com>
In-Reply-To: <20220902101312.220350-1-vladimir.isaev@syntacore.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44af124b-7d77-4560-f806-08da8cff50c0
x-ms-traffictypediagnostic: MN2PR11MB3646:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ifSi8+Vc1/djV8WAwf6NfHJHk3VMb3ZF69XcK3PoyT290WPV67nGU9e8wyLJZg/WD9vqJBu1mwlnjMYsC+id3dOpoFfPGbJOXISqwtFPSQ8a7ShBSaDYh4rOQ/xCE5b2YsNfAFDfXx1qpoIrqKpRwk4xI77TyAtH3syeSE0QLqE7OxmVzjA7id4rKFZHxxVgwtHfkIgPjDa/+acYjlNk1Ohovsdp2XEraf4TqwgJZXUF17+vyysIpjrEzaGufttk9yXMluTsVFt/VwI3uQJjGHjsFDZpO60BANAmvHAwyzWWLqqv2crAFZenxrfVZ1/owTSLshXn1OmUaGC7TIReqioW6ULsPuH7v75MmJeAerOD2A5ztfSqTastIh1PzGXHLmQSzYTpj9ouF7av1rG6FrD/1QvOrcN9s0aMe6IQTva9DlrOrJiCibeHu8yaHRfj5Ks7Gxpu0/RgRqVvXSu3phrkgcD3pjMXj4BMYZLSpfs8Hi1D9zCgD2G5Q8jTyDvCaHTdTyGZVmxCb2uz92pZvOQRhh0NqSWIHXgvlvc/ZOlYCxp2QzLKmFcQO0sSdFsy+9W4z91VKnG/9tENXYREXKMo0sfB814iUgN9BOr6fFj5UAoWqgCR7jx1FTepeMcZSn/z7F5YGOFBKgwbcMebEDazfXKZIelkY8bUaxdynEV+53/I5ymQkj7CQClLxJsmT2ClUMngX1qB4jfiMkY0PLsAY9IVRwIh/L4vqFwIaSjoUDIp34TO22gwcgkULpYgxsYi0L1DSCKZl3KgpJPIIVr9Zui12eC9AJ4YHJUKat2rWH1olZdWZZej/0e711Q0nMTcguOsgwkqxqMZKAUHI9lsR4DdFfTejlgPFxvgoNw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(366004)(396003)(376002)(136003)(2616005)(31686004)(2906002)(38070700005)(186003)(36756003)(26005)(6512007)(66556008)(91956017)(66446008)(64756008)(66476007)(8936002)(5660300002)(8676002)(76116006)(4326008)(66946007)(6486002)(966005)(316002)(110136005)(71200400001)(478600001)(41300700001)(6506007)(53546011)(122000001)(38100700002)(45080400002)(86362001)(31696002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXFTdE9GS1ZUUHNhSTNac3NFUlNEdFJJZDE5QlRJY1p1RWcyM3l1UVlNNFJy?=
 =?utf-8?B?TzRXanBWRnRYQ05WTWYzS01EUWoxQ1RYVitHSXprbW1jeXVzZkNyVFAwcUc5?=
 =?utf-8?B?OEFybXdsWXVCOFNwSTFCZys3eTkzbDd4cEJqL0VRQjlnaUZjb0tHZjJqZ0lX?=
 =?utf-8?B?dGRiZ2FLN2ZIVnFBaWd6UmxHTXFqMlBGSG5oY3pFZGtHTjBycTBtVDRmRmRB?=
 =?utf-8?B?cEJ3V2JtMWQ0TmJGSlhTYnpvV0lLcjRCL3ZoRC9PZ25FaTZha1dRK0JPSzMy?=
 =?utf-8?B?Y2NrakpINGtrUWJXQ3JqOWI4T1ZUUkhuYk5ibkw0L0dQQTBqbHhKQWtWTU5H?=
 =?utf-8?B?TkRFUVp6bEtnTWxiT0RRelpaeVc0SkRkcTZ2dXlSam5kVzgzQXdpV0pUT3Br?=
 =?utf-8?B?MWdpb2ttaGVUUWloRVoyTVdLNEU1MFd2dEpqbDFsWjBIZzhteDdPaHVObmJi?=
 =?utf-8?B?L01oYkFxQmJXdnNXNENsbDA1UWkxcm9Dd1FOQ0djbC9oSDA1Z2ZoUDB5bDVO?=
 =?utf-8?B?ZzJtOU5KNFltcXVMTE1lamJEWXY4VW5nbTlsV3UwRml0dXRTaU1YSlN1dGtD?=
 =?utf-8?B?NXFpR0V3OG5pVE5kbzREaFhKWnRyT3VvSTRqY0VqczBsQ2dEeXBmbXFyeFZa?=
 =?utf-8?B?UkZMK1gxNG1VUUo4Ym9EVEMxMG92ZFpyTDRCYlVCaGNhYmxDRkFOdW9UWFdX?=
 =?utf-8?B?QS9LQ0NxUXRRTUFuUjVaVWt5SEdkR0pGVTRsVGxQZm8vQzhDSUZHenhQQW00?=
 =?utf-8?B?eEtnVnlWckgvUUNrUnhkQlZxcVZPR2JpbENFb1FzWWE3Mjk4SVpDVVhETUVH?=
 =?utf-8?B?ZXBuWWdiOS9ZRlpUVXowM0cyM0toME1KZlIycjFYL3F0RzlzVHdWL2pFTElu?=
 =?utf-8?B?RllGSGt4YlIxS0pIcDlhS0FZRXdBNC9ncFNpVVFYWUpMNjJPTVN1OUhTQjJL?=
 =?utf-8?B?WlpYTmxTQlkvTzNDS3RRTTJyN1JsWWlOb3YvbCtacVdrYU1SaTBDR001eW1J?=
 =?utf-8?B?b0tPcTAzTEE0NTdDbTU0dFpkWWU1ZGtoSmRlWXBrcVowVlpmeHdGOUd4M3lS?=
 =?utf-8?B?N2pUNWhqeUkxNHRUbHViNURYMVZWQWdxYWE4TExQLzlWRGFkTXRtd2wwU3dC?=
 =?utf-8?B?ZTVrWm5UMXRzWGZCL2JIQmhsUUVhcmVzTEc0ZVN4alFtaFlhanlqVjk3ZGo1?=
 =?utf-8?B?dFVyWURHSTdRb2lERkI0ZXd4YnlHZ2dHMmJaZXZPZmMrVFpWTWNaZ0RRVVEv?=
 =?utf-8?B?SVJnYk4yd3UydjR5NlV5emQ5c2drbXJ5U1p4UWpTeEFSNFF0NFcweUlnZnpH?=
 =?utf-8?B?U2Z2RUtYUHVOZ2pvbGNRYXhmSUV5NWV4Y1hHVXJPNG9mL01KQllmaHd1UVJU?=
 =?utf-8?B?L1VhN05iQXlRUzAxcGtTdW16bE1JckNCQy9OUHhOdC83bW4xT21vclpzQWg5?=
 =?utf-8?B?a1pKNWJGZWdZY0pmMi8rRGxvYzZ3dzZlQ0thK0hwTjlUNWt1WEtpbWxQT2hl?=
 =?utf-8?B?WmJRWGpjeWxnSGtyNjBxb3BZeGRxMXNScEZRdExtcEptZ0tKdnVhcmFEdUMy?=
 =?utf-8?B?NDVPb1F4S3A2U2lEQ3pzVW15RkNNTG9qc1AvcXpsTFEvaDA2U3hzZEkxNW1u?=
 =?utf-8?B?Z3RhcEUzTDVxVVhDZ3RtVkJZSDBJN1VtRjMybTFCcDhKUGFTTzVYN1FwVjRV?=
 =?utf-8?B?WlRURDk0VlpJZFVzMGcwWVhNSkJ0QnJXY2EwcEJMR09rWUcvRDJJcU1DaG4z?=
 =?utf-8?B?TFFDa1Q0cWNZMkppSzI5c0NFbU5paVVVMFh3ZUpQOXZ1R0M4RDVLZmtpbGFJ?=
 =?utf-8?B?SUdQRXk5cXpIOVJSbHlxc1lrRGQ1Q0lwb1VKcy9oTUtjc0FwSmRPZmdINGYr?=
 =?utf-8?B?eDNsaFZ3WS9qWGI4Y09tMWtqVFJEUkdpUG5xT0dIblpWNVlzaHRqSDk0cTEz?=
 =?utf-8?B?VlZqSmk3bDJZazdMQjRQeG81cktqQ1RJRjBjUHltOHNPRlA0djFua1cvT3NB?=
 =?utf-8?B?QitWekFFVFZKTDZKS3BKRkMxYjRMOHFWY0tnRWlwU3hoWENHcFR4Z0kyWjZW?=
 =?utf-8?B?ZE56RjdLWSt3eWphSXRuWUI5VWFrcjlwMnBvVmt2QVR3bjJuTW9LSFZuVGVj?=
 =?utf-8?Q?tx0HNSrNpwRfPU7WqtbbVnTcS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02520A2116A7B64A968FA02F4E6FE9AE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44af124b-7d77-4560-f806-08da8cff50c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 16:22:22.5094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yG2yf5auG8CvjmXpHqeqnOZZFwiRTJSxObd+KlA6kLjKZ8CBtCIaOVDBglzeWLVeK3S3qtb7VidAqwj/s7746IgybU6zN8UzAXvTCwsORhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3646
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMDIvMDkvMjAyMiAxMToxMywgVmxhZGltaXIgSXNhZXYgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSXQgaXMgcG9zc2libGUgdG8gaGF2ZSBtb3Jl
IHRoYW4gb25lIG1tIChpbml0X21tKSBkdXJpbmcgbWVtb3J5DQo+IHBlcm1pc3Npb24gZml4ZXMu
IEluIG15IGNhc2UgaXQgd2FzIGNhdXNlZCBieSByZXF1ZXN0X21vZHVsZQ0KPiBmcm9tIGRyaXZl
cnMvbmV0L3BoeS9waHlfZGV2aWNlLmMgYW5kIGxlYWRzIHRvIGZvbGxvd2luZyBPb3BzDQo+IGR1
cmluZyBmcmVlX2luaXRtZW0oKSBvbiBSVjMyIHBsYXRmb3JtOg0KPiAgICAgIFVuYWJsZSB0byBo
YW5kbGUga2VybmVsIHBhZ2luZyByZXF1ZXN0IGF0IHZpcnR1YWwgYWRkcmVzcyBjMDgwMDAwMA0K
PiAgICAgIE9vcHMgWyMxXQ0KPiAgICAgIE1vZHVsZXMgbGlua2VkIGluOg0KPiAgICAgIENQVTog
MCBQSUQ6IDEgQ29tbTogc3dhcHBlciBOb3QgdGFpbnRlZCA1LjE1LjQ1DQo+ICAgICAgSGFyZHdh
cmUgbmFtZTogU3ludGFjb3JlIFNDUjUgU0RLIGJvYXJkIChEVCkNCj4gICAgICBlcGMgOiBfX21l
bXNldCsweDU4LzB4ZjQNCj4gICAgICAgcmEgOiBmcmVlX3Jlc2VydmVkX2FyZWErMHhmYS8weDE1
YQ0KPiAgICAgIGVwYyA6IGMwMmIyNmFjIHJhIDogYzAwZWI1ODggc3AgOiBjMWMxZmVkMA0KPiAg
ICAgICBncCA6IGMxODk4NjkwIHRwIDogYzFjOTgwMDAgdDAgOiBjMDgwMDAwMA0KPiAgICAgICB0
MSA6IGZmZmZmZmZmIHQyIDogMDAwMDAwMDAgczAgOiBjMWMxZmYyMA0KPiAgICAgICBzMSA6IGMx
ODlhMDAwIGEwIDogYzA4MDAwMDAgYTEgOiBjY2NjY2NjYw0KPiAgICAgICBhMiA6IDAwMDAxMDAw
IGEzIDogYzA4MDEwMDAgYTQgOiAwMDAwMDAwMA0KPiAgICAgICBhNSA6IDAwODAwMDAwIGE2IDog
ZmVmMDkwMDAgYTcgOiAwMDAwMDAwMA0KPiAgICAgICBzMiA6IGMwZTU3MDAwIHMzIDogYzEwZWRj
ZjggczQgOiAwMDAwMDBjYw0KPiAgICAgICBzNSA6IGZmZmZlZmZmIHM2IDogYzE4OGE5ZjQgczcg
OiAwMDAwMDAwMQ0KPiAgICAgICBzOCA6IGMwODAwMDAwIHM5IDogZmVmMWIwMDAgczEwOiBjMTBl
ZTAwMA0KPiAgICAgICBzMTE6IGMxODlhMDAwIHQzIDogMDAwMDAwMDAgdDQgOiAwMDAwMDAwMA0K
PiAgICAgICB0NSA6IDAwMDAwMDAwIHQ2IDogMDAwMDAwMDENCj4gICAgICBzdGF0dXM6IDAwMDAw
MTIwIGJhZGFkZHI6IGMwODAwMDAwIGNhdXNlOiAwMDAwMDAwZg0KPiAgICAgIFs8YzA0ODg2NTg+
XSBmcmVlX2luaXRtZW0rMHgyMDQvMHgyMjINCj4gICAgICBbPGMwNDhkMDVhPl0ga2VybmVsX2lu
aXQrMHgzMi8weGZjDQo+ICAgICAgWzxjMDAwMmY3Nj5dIHJldF9mcm9tX2V4Y2VwdGlvbisweDAv
MHhjDQo+ICAgICAgLS0tWyBlbmQgdHJhY2UgN2E1ZTJiMDAyMzUwYjUyOCBdLS0tDQo+IA0KPiBU
aGlzIGlzIGJlY2F1c2UgcmVxdWVzdF9tb2R1bGUgYXR0ZW1wdGVkIHRvIG1vZHByb2JlIG1vZHVs
ZSwgc28gaXQgY3JlYXRlZA0KPiBuZXcgbW0gd2l0aCB0aGUgY29weSBvZiBrZXJuZWwncyBwYWdl
IHRhYmxlLiBBbmQgdGhpcyBjb3B5IHdvbid0IGJlIHVwZGF0ZWQNCj4gaW4gY2FzZSBvZiA0TSBw
YWdlcyBhbmQgUlYzMiAocGdkIGlzIHRoZSBsZWFmKS4NCj4gDQo+IFRvIGZpeCB0aGlzIHdlIGNh
biB1cGRhdGUgcHJvdGVjdGlvbiBiaXRzIGZvciBhbGwgb2YgZXhpc3RpbmcgbW0tcywgdGhlDQo+
IHNhbWUgYXMgQVJNIGRvZXMsIHNlZSBjb21taXQgMDg5MjVjMmYxMjRmDQo+ICgiQVJNOiA4NDY0
LzE6IFVwZGF0ZSBhbGwgbW0gc3RydWN0dXJlcyB3aXRoIHNlY3Rpb24gYWRqdXN0bWVudHMiKS4N
Cj4gDQo+IEZpeGVzOiAxOWEwMDg2OTAyOGYgKCJSSVNDLVY6IFByb3RlY3QgYWxsIGtlcm5lbCBz
ZWN0aW9ucyBpbmNsdWRpbmcgaW5pdCBlYXJseSIpDQo+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWly
IElzYWV2IDx2bGFkaW1pci5pc2FldkBzeW50YWNvcmUuY29tPg0KPiBSZXZpZXdlZC1ieTogQW5k
cmV3IEpvbmVzIDxham9uZXNAdmVudGFuYW1pY3JvLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgZm9y
IHYzOg0KPiAgIC0gQWRkIFdBUk5fT04oc3RhdGUgIT0gU1lTVEVNX0ZSRUVJTkdfSU5JVE1FTSkg
dG8gZml4X2tlcm5lbF9tZW1fZWFybHkoKQ0KPiAgICAgdG8gbWFrZSBzdXJlIHRoYXQgdGhlIGZ1
bmN0aW9uIHVzZWQgb25seSBkdXJpbmcgcGVybWlzc2lvbiBmaXhlcy4NCj4gICAtIEFkZCBjb21t
ZW50IHRvIGZpeF9rZXJuZWxfbWVtX2Vhcmx5KCkuDQo+IA0KPiBDaGFuZ2VzIGZvciB2MjoNCj4g
ICAtIEZpeCBjb21taXQgbWVzc2FnZSBmb3JtYXQuDQo+ICAgLSBBZGQgJ0ZpeGVzJyB0YWcuDQoN
ClN3ZWV0LCB0aGFua3MuDQoNClJhbiBpdCB0aHJvdWdoIGEgMzJiaXQgYnVpbGQgJiBiZWVuIHJ1
bm5pbmcgd2l0aCB0aGlzIGFwcGxpZWQgb24gNjRiaXQgZm9yDQp0aGUgYWZ0ZXJub29uICYgZXZl
cnl0aGluZyBzdGlsbCBzZWVtcyB0byBiZSBpbnRhY3QuIFRoZXJlZm9yZToNClJldmlld2VkLWJ5
OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KDQpUaGFua3MgZm9y
IHlvdSBwYXRjaCwNCkNvbm9yLg0KDQo+IC0tLQ0KPiAgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9z
ZXRfbWVtb3J5LmggfCAyMCArKy0tLS0tLS0tDQo+ICBhcmNoL3Jpc2N2L2tlcm5lbC9zZXR1cC5j
ICAgICAgICAgICB8IDExIC0tLS0tDQo+ICBhcmNoL3Jpc2N2L21tL2luaXQuYyAgICAgICAgICAg
ICAgICB8IDI5ICsrKysrKysrKysrLS0tDQo+ICBhcmNoL3Jpc2N2L21tL3BhZ2VhdHRyLmMgICAg
ICAgICAgICB8IDYyICsrKysrKysrKysrKysrKysrKysrKysrKystLS0tDQo+ICA0IGZpbGVzIGNo
YW5nZWQsIDgyIGluc2VydGlvbnMoKyksIDQwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vc2V0X21lbW9yeS5oIGIvYXJjaC9yaXNjdi9pbmNs
dWRlL2FzbS9zZXRfbWVtb3J5LmgNCj4gaW5kZXggYTJjMTRkNGIzOTkzLi5iYjBmNmI0ZWQ4NmIg
MTAwNjQ0DQo+IC0tLSBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vc2V0X21lbW9yeS5oDQo+ICsr
KyBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vc2V0X21lbW9yeS5oDQo+IEBAIC0xNiwyOCArMTYs
MTYgQEAgaW50IHNldF9tZW1vcnlfcncodW5zaWduZWQgbG9uZyBhZGRyLCBpbnQgbnVtcGFnZXMp
Ow0KPiAgaW50IHNldF9tZW1vcnlfeCh1bnNpZ25lZCBsb25nIGFkZHIsIGludCBudW1wYWdlcyk7
DQo+ICBpbnQgc2V0X21lbW9yeV9ueCh1bnNpZ25lZCBsb25nIGFkZHIsIGludCBudW1wYWdlcyk7
DQo+ICBpbnQgc2V0X21lbW9yeV9yd19ueCh1bnNpZ25lZCBsb25nIGFkZHIsIGludCBudW1wYWdl
cyk7DQo+IC1zdGF0aWMgX19hbHdheXNfaW5saW5lIGludCBzZXRfa2VybmVsX21lbW9yeShjaGFy
ICpzdGFydHAsIGNoYXIgKmVuZHAsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGludCAoKnNldF9tZW1vcnkpKHVuc2lnbmVkIGxvbmcgc3RhcnQsDQo+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGludCBudW1fcGFnZXMpKQ0KPiAtew0KPiAtICAgICAgIHVuc2lnbmVkIGxvbmcgc3RhcnQg
PSAodW5zaWduZWQgbG9uZylzdGFydHA7DQo+IC0gICAgICAgdW5zaWduZWQgbG9uZyBlbmQgPSAo
dW5zaWduZWQgbG9uZyllbmRwOw0KPiAtICAgICAgIGludCBudW1fcGFnZXMgPSBQQUdFX0FMSUdO
KGVuZCAtIHN0YXJ0KSA+PiBQQUdFX1NISUZUOw0KPiAtDQo+IC0gICAgICAgcmV0dXJuIHNldF9t
ZW1vcnkoc3RhcnQsIG51bV9wYWdlcyk7DQo+IC19DQo+ICt2b2lkIGZpeF9rZXJuZWxfbWVtX2Vh
cmx5KGNoYXIgKnN0YXJ0cCwgY2hhciAqZW5kcCwgcGdwcm90X3Qgc2V0X21hc2ssDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgcGdwcm90X3QgY2xlYXJfbWFzayk7DQo+ICAjZWxzZQ0KPiAg
c3RhdGljIGlubGluZSBpbnQgc2V0X21lbW9yeV9ybyh1bnNpZ25lZCBsb25nIGFkZHIsIGludCBu
dW1wYWdlcykgeyByZXR1cm4gMDsgfQ0KPiAgc3RhdGljIGlubGluZSBpbnQgc2V0X21lbW9yeV9y
dyh1bnNpZ25lZCBsb25nIGFkZHIsIGludCBudW1wYWdlcykgeyByZXR1cm4gMDsgfQ0KPiAgc3Rh
dGljIGlubGluZSBpbnQgc2V0X21lbW9yeV94KHVuc2lnbmVkIGxvbmcgYWRkciwgaW50IG51bXBh
Z2VzKSB7IHJldHVybiAwOyB9DQo+ICBzdGF0aWMgaW5saW5lIGludCBzZXRfbWVtb3J5X254KHVu
c2lnbmVkIGxvbmcgYWRkciwgaW50IG51bXBhZ2VzKSB7IHJldHVybiAwOyB9DQo+ICBzdGF0aWMg
aW5saW5lIGludCBzZXRfbWVtb3J5X3J3X254KHVuc2lnbmVkIGxvbmcgYWRkciwgaW50IG51bXBh
Z2VzKSB7IHJldHVybiAwOyB9DQo+IC1zdGF0aWMgaW5saW5lIGludCBzZXRfa2VybmVsX21lbW9y
eShjaGFyICpzdGFydHAsIGNoYXIgKmVuZHAsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGludCAoKnNldF9tZW1vcnkpKHVuc2lnbmVkIGxvbmcgc3RhcnQsDQo+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBudW1f
cGFnZXMpKQ0KPiAtew0KPiAtICAgICAgIHJldHVybiAwOw0KPiAtfQ0KPiArc3RhdGljIGlubGlu
ZSB2b2lkIGZpeF9rZXJuZWxfbWVtX2Vhcmx5KGNoYXIgKnN0YXJ0cCwgY2hhciAqZW5kcCwNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBncHJvdF90IHNldF9tYXNr
LCBwZ3Byb3RfdCBjbGVhcl9tYXNrKSB7IH0NCj4gICNlbmRpZg0KPiANCj4gIGludCBzZXRfZGly
ZWN0X21hcF9pbnZhbGlkX25vZmx1c2goc3RydWN0IHBhZ2UgKnBhZ2UpOw0KPiBkaWZmIC0tZ2l0
IGEvYXJjaC9yaXNjdi9rZXJuZWwvc2V0dXAuYyBiL2FyY2gvcmlzY3Yva2VybmVsL3NldHVwLmMN
Cj4gaW5kZXggOTVlZjZlMmJmNDVjLi4xN2VhZTE0MDYwOTIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gv
cmlzY3Yva2VybmVsL3NldHVwLmMNCj4gKysrIGIvYXJjaC9yaXNjdi9rZXJuZWwvc2V0dXAuYw0K
PiBAQCAtMjcsNyArMjcsNiBAQA0KPiAgI2luY2x1ZGUgPGFzbS9lYXJseV9pb3JlbWFwLmg+DQo+
ICAjaW5jbHVkZSA8YXNtL3BndGFibGUuaD4NCj4gICNpbmNsdWRlIDxhc20vc2V0dXAuaD4NCj4g
LSNpbmNsdWRlIDxhc20vc2V0X21lbW9yeS5oPg0KPiAgI2luY2x1ZGUgPGFzbS9zZWN0aW9ucy5o
Pg0KPiAgI2luY2x1ZGUgPGFzbS9zYmkuaD4NCj4gICNpbmNsdWRlIDxhc20vdGxiZmx1c2guaD4N
Cj4gQEAgLTMxOCwxMyArMzE3LDMgQEAgc3RhdGljIGludCBfX2luaXQgdG9wb2xvZ3lfaW5pdCh2
b2lkKQ0KPiAgICAgICAgIHJldHVybiAwOw0KPiAgfQ0KPiAgc3Vic3lzX2luaXRjYWxsKHRvcG9s
b2d5X2luaXQpOw0KPiAtDQo+IC12b2lkIGZyZWVfaW5pdG1lbSh2b2lkKQ0KPiAtew0KPiAtICAg
ICAgIGlmIChJU19FTkFCTEVEKENPTkZJR19TVFJJQ1RfS0VSTkVMX1JXWCkpDQo+IC0gICAgICAg
ICAgICAgICBzZXRfa2VybmVsX21lbW9yeShsbV9hbGlhcyhfX2luaXRfYmVnaW4pLCBsbV9hbGlh
cyhfX2luaXRfZW5kKSwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIElTX0VO
QUJMRUQoQ09ORklHXzY0QklUKSA/DQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzZXRfbWVtb3J5X3J3IDogc2V0X21lbW9yeV9yd19ueCk7DQo+IC0NCj4gLSAgICAg
ICBmcmVlX2luaXRtZW1fZGVmYXVsdChQT0lTT05fRlJFRV9JTklUTUVNKTsNCj4gLX0NCj4gZGlm
ZiAtLWdpdCBhL2FyY2gvcmlzY3YvbW0vaW5pdC5jIGIvYXJjaC9yaXNjdi9tbS9pbml0LmMNCj4g
aW5kZXggYjU2YTBhNzU1MzNmLi45NzgyMDI3MTI1MzUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcmlz
Y3YvbW0vaW5pdC5jDQo+ICsrKyBiL2FyY2gvcmlzY3YvbW0vaW5pdC5jDQo+IEBAIC0xNiw3ICsx
Niw2IEBADQo+ICAjaW5jbHVkZSA8bGludXgvb2ZfZmR0Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgv
b2ZfcmVzZXJ2ZWRfbWVtLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvbGliZmR0Lmg+DQo+IC0jaW5j
bHVkZSA8bGludXgvc2V0X21lbW9yeS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2RtYS1tYXAtb3Bz
Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvY3Jhc2hfZHVtcC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4
L2h1Z2V0bGIuaD4NCj4gQEAgLTI4LDYgKzI3LDcgQEANCj4gICNpbmNsdWRlIDxhc20vaW8uaD4N
Cj4gICNpbmNsdWRlIDxhc20vcHRkdW1wLmg+DQo+ICAjaW5jbHVkZSA8YXNtL251bWEuaD4NCj4g
KyNpbmNsdWRlIDxhc20vc2V0X21lbW9yeS5oPg0KPiANCj4gICNpbmNsdWRlICIuLi9rZXJuZWwv
aGVhZC5oIg0KPiANCj4gQEAgLTcxNCwxMCArNzE0LDE0IEBAIHN0YXRpYyBfX2luaXQgcGdwcm90
X3QgcGdwcm90X2Zyb21fdmEodWludHB0cl90IHZhKQ0KPiANCj4gIHZvaWQgbWFya19yb2RhdGFf
cm8odm9pZCkNCj4gIHsNCj4gLSAgICAgICBzZXRfa2VybmVsX21lbW9yeShfX3N0YXJ0X3JvZGF0
YSwgX2RhdGEsIHNldF9tZW1vcnlfcm8pOw0KPiAtICAgICAgIGlmIChJU19FTkFCTEVEKENPTkZJ
R182NEJJVCkpDQo+IC0gICAgICAgICAgICAgICBzZXRfa2VybmVsX21lbW9yeShsbV9hbGlhcyhf
X3N0YXJ0X3JvZGF0YSksIGxtX2FsaWFzKF9kYXRhKSwNCj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHNldF9tZW1vcnlfcm8pOw0KPiArICAgICAgIHBncHJvdF90IHNldF9tYXNr
ID0gX19wZ3Byb3QoX1BBR0VfUkVBRCk7DQo+ICsgICAgICAgcGdwcm90X3QgY2xlYXJfbWFzayA9
IF9fcGdwcm90KF9QQUdFX1dSSVRFKTsNCj4gKw0KPiArICAgICAgIGZpeF9rZXJuZWxfbWVtX2Vh
cmx5KF9fc3RhcnRfcm9kYXRhLCBfZGF0YSwgc2V0X21hc2ssIGNsZWFyX21hc2spOw0KPiArICAg
ICAgIGlmIChJU19FTkFCTEVEKENPTkZJR182NEJJVCkpIHsNCj4gKyAgICAgICAgICAgICAgIGZp
eF9rZXJuZWxfbWVtX2Vhcmx5KGxtX2FsaWFzKF9fc3RhcnRfcm9kYXRhKSwgbG1fYWxpYXMoX2Rh
dGEpLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2V0X21hc2ssIGNs
ZWFyX21hc2spOw0KPiArICAgICAgIH0NCj4gDQo+ICAgICAgICAgZGVidWdfY2hlY2t3eCgpOw0K
PiAgfQ0KPiBAQCAtMTI0MywzICsxMjQ3LDE4IEBAIGludCBfX21lbWluaXQgdm1lbW1hcF9wb3B1
bGF0ZSh1bnNpZ25lZCBsb25nIHN0YXJ0LCB1bnNpZ25lZCBsb25nIGVuZCwgaW50IG5vZGUsDQo+
ICAgICAgICAgcmV0dXJuIHZtZW1tYXBfcG9wdWxhdGVfYmFzZXBhZ2VzKHN0YXJ0LCBlbmQsIG5v
ZGUsIE5VTEwpOw0KPiAgfQ0KPiAgI2VuZGlmDQo+ICsNCj4gK3ZvaWQgZnJlZV9pbml0bWVtKHZv
aWQpDQo+ICt7DQo+ICsgICAgICAgcGdwcm90X3Qgc2V0X21hc2sgPSBfX3BncHJvdChfUEFHRV9S
RUFEIHwgX1BBR0VfV1JJVEUpOw0KPiArICAgICAgIHBncHJvdF90IGNsZWFyX21hc2sgPSBJU19F
TkFCTEVEKENPTkZJR182NEJJVCkgPw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBf
X3BncHJvdCgwKSA6IF9fcGdwcm90KF9QQUdFX0VYRUMpOw0KPiArDQo+ICsgICAgICAgaWYgKElT
X0VOQUJMRUQoQ09ORklHX1NUUklDVF9LRVJORUxfUldYKSkgew0KPiArICAgICAgICAgICAgICAg
Zml4X2tlcm5lbF9tZW1fZWFybHkobG1fYWxpYXMoX19pbml0X2JlZ2luKSwNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxtX2FsaWFzKF9faW5pdF9lbmQpLA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2V0X21hc2ssIGNsZWFyX21hc2spOw0K
PiArICAgICAgIH0NCj4gKw0KPiArICAgICAgIGZyZWVfaW5pdG1lbV9kZWZhdWx0KFBPSVNPTl9G
UkVFX0lOSVRNRU0pOw0KPiArfQ0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9tbS9wYWdlYXR0
ci5jIGIvYXJjaC9yaXNjdi9tbS9wYWdlYXR0ci5jDQo+IGluZGV4IDVlNDllNGI0YTRjYy4uNzRi
ODEwN2FjNzQzIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Jpc2N2L21tL3BhZ2VhdHRyLmMNCj4gKysr
IGIvYXJjaC9yaXNjdi9tbS9wYWdlYXR0ci5jDQo+IEBAIC01LDYgKzUsNyBAQA0KPiANCj4gICNp
bmNsdWRlIDxsaW51eC9wYWdld2Fsay5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BndGFibGUuaD4N
Cj4gKyNpbmNsdWRlIDxsaW51eC9zY2hlZC5oPg0KPiAgI2luY2x1ZGUgPGFzbS90bGJmbHVzaC5o
Pg0KPiAgI2luY2x1ZGUgPGFzbS9iaXRvcHMuaD4NCj4gICNpbmNsdWRlIDxhc20vc2V0X21lbW9y
eS5oPg0KPiBAQCAtMTA0LDI0ICsxMDUsNjkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtbV93YWxr
X29wcyBwYWdlYXR0cl9vcHMgPSB7DQo+ICAgICAgICAgLnB0ZV9ob2xlID0gcGFnZWF0dHJfcHRl
X2hvbGUsDQo+ICB9Ow0KPiANCj4gLXN0YXRpYyBpbnQgX19zZXRfbWVtb3J5KHVuc2lnbmVkIGxv
bmcgYWRkciwgaW50IG51bXBhZ2VzLCBwZ3Byb3RfdCBzZXRfbWFzaywNCj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgcGdwcm90X3QgY2xlYXJfbWFzaykNCj4gK3N0YXRpYyBpbnQgX19zZXRfbWVt
b3J5X21tKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCB1bnNpZ25lZCBsb25nIHN0YXJ0LA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIGVuZCwgcGdwcm90X3Qgc2V0X21h
c2ssDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIHBncHJvdF90IGNsZWFyX21hc2spDQo+
ICB7DQo+ICAgICAgICAgaW50IHJldDsNCj4gLSAgICAgICB1bnNpZ25lZCBsb25nIHN0YXJ0ID0g
YWRkcjsNCj4gLSAgICAgICB1bnNpZ25lZCBsb25nIGVuZCA9IHN0YXJ0ICsgUEFHRV9TSVpFICog
bnVtcGFnZXM7DQo+ICAgICAgICAgc3RydWN0IHBhZ2VhdHRyX21hc2tzIG1hc2tzID0gew0KPiAg
ICAgICAgICAgICAgICAgLnNldF9tYXNrID0gc2V0X21hc2ssDQo+ICAgICAgICAgICAgICAgICAu
Y2xlYXJfbWFzayA9IGNsZWFyX21hc2sNCj4gICAgICAgICB9Ow0KPiANCj4gKyAgICAgICBtbWFw
X3JlYWRfbG9jayhtbSk7DQo+ICsgICAgICAgcmV0ID0gd2Fsa19wYWdlX3JhbmdlX25vdm1hKG1t
LCBzdGFydCwgZW5kLCAmcGFnZWF0dHJfb3BzLCBOVUxMLA0KPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAmbWFza3MpOw0KPiArICAgICAgIG1tYXBfcmVhZF91bmxvY2sobW0p
Ow0KPiArDQo+ICsgICAgICAgcmV0dXJuIHJldDsNCj4gK30NCj4gKw0KPiArdm9pZCBmaXhfa2Vy
bmVsX21lbV9lYXJseShjaGFyICpzdGFydHAsIGNoYXIgKmVuZHAsIHBncHJvdF90IHNldF9tYXNr
LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgIHBncHJvdF90IGNsZWFyX21hc2spDQo+ICt7
DQo+ICsgICAgICAgc3RydWN0IHRhc2tfc3RydWN0ICp0LCAqczsNCj4gKw0KPiArICAgICAgIHVu
c2lnbmVkIGxvbmcgc3RhcnQgPSAodW5zaWduZWQgbG9uZylzdGFydHA7DQo+ICsgICAgICAgdW5z
aWduZWQgbG9uZyBlbmQgPSBQQUdFX0FMSUdOKCh1bnNpZ25lZCBsb25nKWVuZHApOw0KPiArDQo+
ICsgICAgICAgLyoNCj4gKyAgICAgICAgKiBJbiB0aGUgU1lTVEVNX0ZSRUVJTkdfSU5JVE1FTSBz
dGF0ZSB3ZSBleHBlY3QgdGhhdCBhbGwgYXN5bmMgY29kZQ0KPiArICAgICAgICAqIGlzIGRvbmUg
YW5kIG5vIG5ldyB1c2Vyc3BhY2UgdGFzayBjYW4gYmUgY3JlYXRlZC4NCj4gKyAgICAgICAgKiBT
byByY3VfcmVhZF9sb2NrKCkgc2hvdWxkIGJlIGVub3VnaCBoZXJlLg0KPiArICAgICAgICAqLw0K
PiArICAgICAgIFdBUk5fT04oc3lzdGVtX3N0YXRlICE9IFNZU1RFTV9GUkVFSU5HX0lOSVRNRU0p
Ow0KPiArDQo+ICsgICAgICAgX19zZXRfbWVtb3J5X21tKGN1cnJlbnQtPmFjdGl2ZV9tbSwgc3Rh
cnQsIGVuZCwgc2V0X21hc2ssIGNsZWFyX21hc2spOw0KPiArICAgICAgIF9fc2V0X21lbW9yeV9t
bSgmaW5pdF9tbSwgc3RhcnQsIGVuZCwgc2V0X21hc2ssIGNsZWFyX21hc2spOw0KPiArDQo+ICsg
ICAgICAgcmN1X3JlYWRfbG9jaygpOw0KPiArICAgICAgIGZvcl9lYWNoX3Byb2Nlc3ModCkgew0K
PiArICAgICAgICAgICAgICAgaWYgKHQtPmZsYWdzICYgUEZfS1RIUkVBRCkNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgY29udGludWU7DQo+ICsgICAgICAgICAgICAgICBmb3JfZWFjaF90aHJl
YWQodCwgcykgew0KPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAocy0+bW0pIHsNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX3NldF9tZW1vcnlfbW0ocy0+bW0sIHN0YXJ0
LCBlbmQsIHNldF9tYXNrLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBjbGVhcl9tYXNrKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiAr
ICAgICAgICAgICAgICAgfQ0KPiArICAgICAgIH0NCj4gKyAgICAgICByY3VfcmVhZF91bmxvY2so
KTsNCj4gKw0KPiArICAgICAgIGZsdXNoX3RsYl9rZXJuZWxfcmFuZ2Uoc3RhcnQsIGVuZCk7DQo+
ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgX19zZXRfbWVtb3J5KHVuc2lnbmVkIGxvbmcgYWRkciwg
aW50IG51bXBhZ2VzLCBwZ3Byb3RfdCBzZXRfbWFzaywNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgcGdwcm90X3QgY2xlYXJfbWFzaykNCj4gK3sNCj4gKyAgICAgICBpbnQgcmV0Ow0KPiArICAg
ICAgIHVuc2lnbmVkIGxvbmcgc3RhcnQgPSBhZGRyOw0KPiArICAgICAgIHVuc2lnbmVkIGxvbmcg
ZW5kID0gc3RhcnQgKyBQQUdFX1NJWkUgKiBudW1wYWdlczsNCj4gKw0KPiAgICAgICAgIGlmICgh
bnVtcGFnZXMpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gDQo+IC0gICAgICAgbW1h
cF9yZWFkX2xvY2soJmluaXRfbW0pOw0KPiAtICAgICAgIHJldCA9ICB3YWxrX3BhZ2VfcmFuZ2Vf
bm92bWEoJmluaXRfbW0sIHN0YXJ0LCBlbmQsICZwYWdlYXR0cl9vcHMsIE5VTEwsDQo+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmbWFza3MpOw0KPiAtICAgICAgIG1tYXBf
cmVhZF91bmxvY2soJmluaXRfbW0pOw0KPiArICAgICAgIHJldCA9IF9fc2V0X21lbW9yeV9tbSgm
aW5pdF9tbSwgc3RhcnQsIGVuZCwgc2V0X21hc2ssIGNsZWFyX21hc2spOw0KPiANCj4gICAgICAg
ICBmbHVzaF90bGJfa2VybmVsX3JhbmdlKHN0YXJ0LCBlbmQpOw0KPiANCj4gLS0NCj4gMi4zNy4y
DQo+IA0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18NCj4gbGludXgtcmlzY3YgbWFpbGluZyBsaXN0DQo+IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJh
ZGVhZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1yaXNjdg0KDQo=
