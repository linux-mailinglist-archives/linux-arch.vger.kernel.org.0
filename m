Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1583456A1D8
	for <lists+linux-arch@lfdr.de>; Thu,  7 Jul 2022 14:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbiGGMUa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Jul 2022 08:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbiGGMU3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jul 2022 08:20:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7CC24971;
        Thu,  7 Jul 2022 05:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657196427; x=1688732427;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=b4GYydNLs+Mg9XDEbKi5rJ26TOgrGzwLptK7mchHnf4=;
  b=Otce1ncKRHD9B9f8wBeaTytKrRt2moQn3WIXLaDCxGcldXBFKkGt5Xgg
   cuVtRva1qOVWDR81SGlRgdX8Wrwny4nLMzcZJU82PWVDQC0nF92FQHgR3
   ul6DLHJIGGhHdAe+fz6EKjyNiL2tEuM6Lxm9eAdJ+GDHnMZH1DYmdm5ph
   QLw9eOQgWdMu8Kwwy+h4uMXytIM95XvIY9fO2t37j7Hkaj2C9RBHm43IJ
   UQ6K11wLW9EolNlbFBRkA5eJc/56VcQkDgBsG613s7p0wchaEQb9OkLb7
   wW4oQtfR4J3cWT0JaUejCajCsp2t89PbwLiJL1ENCzwHrhby9Uz6VK54i
   A==;
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="163742682"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jul 2022 05:20:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Jul 2022 05:20:25 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 7 Jul 2022 05:20:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3M/ZeLOjT4YuLIGxxq2rV5bYtMaoPCZVpcOkP/t1ggkcJSEA5RWrbGKtqNFezMss6BCKEqWcb+NBmVCaZcN7Axrwipd5PDJwG3PVPg5vvwnQx6+67ZJS6WHEU3VsA1DiX2ohVoOH0uczGWQvPmnYDn8AMiYoA5ymgW8K488r4NDB0uHEQH08xYLFFse15VDeqRPc2nmki3lil7arFMTBaH3NPgqJZeoiW4XhtbLubm8XRly9cjA6qLk+XdJ324JJy8jiQunWE/5vwDzxOVHdWlt2s0iHuzKHTtOPSKsUoSX/HNpX2EkWr8l2nvixpR0TI3u7pzALS+EZNQ16f7C0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4GYydNLs+Mg9XDEbKi5rJ26TOgrGzwLptK7mchHnf4=;
 b=f9xzSs+McvjvD4yjtUUeokpcOyjYSFOTMji3ruHGdvm/KpKes+4fBB6+vjedOqGrR8DR8WRgVT0i3UEEEYbJN5Tt4Ide2JOjPoXTYGFFTtrmXOCCQc3NkrHzVepyg434KFejYx8TvI7hOc3JYtJppTA2HdvBpXh8KozpvrFy3mOnH+NpJNNv1AUka2XzkNoO89Twq6xa07L2YOKKdT53QXC41PENGt9JQVhDXl0bOETwXY/nv3x8YLNZZQafyvyTHYlOq1M5xFgEWvzceVD98g1HC/UxWilYn4qQtEH7iMngE8jxmEJb+GaGTpaYZw1FDeO1GaFygf+6lFyVUg9zpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4GYydNLs+Mg9XDEbKi5rJ26TOgrGzwLptK7mchHnf4=;
 b=qf8W9fyVdP2WuPoHGb54TWS0XIDzsFGWGpVullfjxc51GrtRr5estLa2a7pi/SBU2+Gd6nE4CaIQA2gMWSWZiLHoh0ERpe6Nbw1fT8VMQo79T+KnDRXlcuRp3Xlb7cQ2VU/NDo9jC/7ZJumZtDoSlkCpNZ4/+KDyWTJjW9erjh8=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN6PR11MB1892.namprd11.prod.outlook.com (2603:10b6:404:105::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 12:20:22 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 12:20:22 +0000
From:   <Conor.Dooley@microchip.com>
To:     <arnd@arndb.de>, <lukas.bulwahn@gmail.com>, <palmer@dabbelt.com>
CC:     <palmerdabbelt@google.com>, <mcgrof@kernel.org>,
        <linux-arch@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] asm-generic: correct reference to
 GENERIC_LIB_DEVMEM_IS_ALLOWED
Thread-Topic: [PATCH] asm-generic: correct reference to
 GENERIC_LIB_DEVMEM_IS_ALLOWED
Thread-Index: AQHYkfvtVm3tGdMjSE2ximSi209imA==
Date:   Thu, 7 Jul 2022 12:20:22 +0000
Message-ID: <4ff47e50-8702-1177-612b-73d9700e47c5@microchip.com>
References: <CAK8P3a12-atmqjtjqi-RhFXH2Kwa-hxYcxy3Ftz2YjY5yyPHqg@mail.gmail.com>
 <mhng-f5938c9b-7fc1-4b0c-9449-7dd1431f5446@palmerdabbelt-glaptop>
 <CAKXUXMzpWsdKYbcu5MxvrAEMLHv4_2OGv2bRYEsQaze5trUSiQ@mail.gmail.com>
 <CAK8P3a32m42gT9qz+Ldvr8okYGOc=kKeoJTGNWyYT71N8tJfEA@mail.gmail.com>
In-Reply-To: <CAK8P3a32m42gT9qz+Ldvr8okYGOc=kKeoJTGNWyYT71N8tJfEA@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7a9fc98-37c4-4697-df09-08da60131057
x-ms-traffictypediagnostic: BN6PR11MB1892:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jmXWlltxaqJsymslg9AsvqOXYilQr/HD5FyEtvIv6KgZTY6eB5ACqHrxOnxOnmNkxq+g73w1e9jfiPH0vuWW4uAlqVuA/53d3UoXhzqZvtkIzAhRtrAuhrhzUvYKIDIlADSvkVpbavrvmImUp5RRZ+T+LcWDRUpn98EX5n9CuYGlEbqKQuicWUolA80UPJtb42SRHar1/dsA7UWOCrsxCjbQ9b9CQKZdoHG1xnH3ZEZ2tqBH7aFDcaydH+V2CqHuN5QAV4GyKLU1NKMLrm2qJBo+oYFUfikmcFt+XDtFmK+UgsFJwd5vkT+VyWcp1lHr+udoAUiYv21bdvZdZJgoJqdegjTYjpWmZcEaSQ/Loi8mhSfDki8TLlFqJhqq2Z1wK0fytc5wezXpbJjdbVaoB1g2NiTp36oCNKSgobEixn7XicTkSmdwDAti2FLR222bhkn91v46RVBp/+Tdny0UCL/ZV4LmH9y69Mt6OVRBiPZVvr5C7cjGjRqh+2coXV/EOLVQZnxl5ND3+SpIFcmNHYO/Aw55HBn81gVHLsX8UOJFwoHbruBswCHCUzYK6ftLp2u6sg0munyuEPzDoOCskpkNkHf2+eul63CedxzWo//LE2hCFq4niE2g9XWwqZatydCI2HG4NDBgvA3kGW2qe0YeBU7WD76QHbWz09BnbJtRmBjoB+wXmB4JWs3KDC/AGjybRBgqHmSIyX2PJGn6WMBZEjwN/S1u9hwzRMShmskJFlcahmAykcuUw+FbjAsQazUXrc2s0GpkoxdVUkRU2bxh2yJfAab5t+Z4GWN6Wku48bdggoJlKMVsh0bxJdWjXUuQhYoWLER/nPsVjM+xgvuM5lJWVEJejROC/PVzX63wDvuF+YQqpKwqB5AnRu/eDilwk6o5XdCdz2IBkCAr8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39860400002)(136003)(396003)(366004)(2906002)(8936002)(6486002)(5660300002)(38100700002)(31686004)(36756003)(66946007)(76116006)(91956017)(31696002)(86362001)(66446008)(8676002)(66556008)(66476007)(64756008)(4326008)(122000001)(478600001)(186003)(71200400001)(316002)(38070700005)(41300700001)(2616005)(6506007)(83380400001)(53546011)(54906003)(26005)(6512007)(110136005)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTY2ZEJENGI3Y0ZBTGxyQmhBVFFkNmhweVVsY1VWbllhWG9iMFZISzB6VnZE?=
 =?utf-8?B?TFdSWXlxZDYzakFWVXFKQXFGTCtoUmwzU3h5ZWMySU9oQmhlYS81d1ZKdGJG?=
 =?utf-8?B?SzN6czQ4aW9tSC9nWlpJR0F2NzNmV1lJbkZMYWQwdU05aVdrUzBYcHFPNzdV?=
 =?utf-8?B?R0JmdTI0K3hYVGEzTXJLc3piRHNhcGY4aXlDZzRZSDgxMUlSKzRSRk9NV0Fz?=
 =?utf-8?B?M0xVL1NKRkhGN1NLRVI2OEhwcG0rcmJpTGd3WDZFRlVSKzh3L3JFdEJONURW?=
 =?utf-8?B?Ly96RmVpbytjR2xldlNmcUVzUU55Q1hvQ0hBSCtXSEh0RDlDTWZtOUZ3N0FG?=
 =?utf-8?B?cEliREJwc3dwQVB3R0paNUdkS0tQdElxZmpGc0VadW1US2FJMzAvaXhpU3hs?=
 =?utf-8?B?UzlNdm5OM2N2TzRJRURiQVYyems1K3o0QUg1dllnVmdETmhHYkx3cGpNMlFk?=
 =?utf-8?B?NldVaFRyTDFGakUxYVZ2d0hwbXdvQmVGc2ZIMjRRYmJFTzZnRS9HR3c1Unk5?=
 =?utf-8?B?dmlkTVdSaEUxcEhCR2VQcGF5dGFNN25ER3ZNMDdUNEpReHRheUhZNE5jMlFD?=
 =?utf-8?B?MjNtcFVMNlpmODRzRkIrWUtINVBUNStiTlk2Q3FSSzJxalBlOENySlg1SlN6?=
 =?utf-8?B?K2Yvb1lvSWFPZzQ2V1RqbmRzemVBK1NBUHpqNmtJc3g2ZStFS004SGRCSXpU?=
 =?utf-8?B?Ly9nRlZMc2lUeGFqeFFpY0ZVd1YrT08xWWRsTjY4eEdvUE1acnd6eFNKcmpa?=
 =?utf-8?B?Mk9hdEdDaGhZdEpYRk1jVmRxN0RSRTdrMnQ0TU11Q1RUeEE4d2x1NTlwbnl6?=
 =?utf-8?B?VHJHV215QmNvSDRLUVlEK1JXS3ZsL0pMeStlODFmcGNVeVlobTFwYkJMZ0Nv?=
 =?utf-8?B?WFhQQVJBUmFWR2VBNWt6dytnV2tEdEx4NlVJZjZkeW8vbFVaOXRZY2NkS05Y?=
 =?utf-8?B?QitqRk1sYVVJY3p0Y0Iyd1hjRktrZVVTRTdMQVYvTXJXTTZhZ0lxS1JKV1g3?=
 =?utf-8?B?Q0xqTm1Wenp5Ujk0RzFMQTlWMld3aGxUcGJsOWNYQmFRd2tkK2ZIY1hmazVl?=
 =?utf-8?B?SG5meDRNcWx1d2JmQmxxeVFPMEJENStoQ0w2OW5pdHlZOForU0x3b3NWN1ZV?=
 =?utf-8?B?cHE2M1VPVWNSNy9pZVVmbklSa2hkVlZDSnZYeFRYb0JETnRjY09mSkRKaHQv?=
 =?utf-8?B?UnJJdzhVRk1XRzdGM0xScktYUG9kVTFic0tRL0pYSEhMcFIxK1hidVZ5NEhu?=
 =?utf-8?B?T3p2M2MxU2V0NFZSd1RzV3ZFdkEvK1JCbVR5QUtzclErb01TUU9Lb1Z1L2Ro?=
 =?utf-8?B?U0NsRVluYlBvNW9CeFllNU9YVzdna01pZWt3WmxvRFlZNGZ5SW1DYUVxSUp5?=
 =?utf-8?B?L082dk90UzJ3d09nQWJZeGNRR0MyY3pZbFNnc0FzWExaVXpIaHcxZEgzYWdL?=
 =?utf-8?B?bHpKdFRVZ1BaTjNhTnJJRVRBRjdlSmxhVS92cWFtWkpXaUVnM3lQNEYwRjlV?=
 =?utf-8?B?dEcxMjYyempNZmwvQWt3YkxqbUhwTCtPdFN1ekpJSlBtQnpEZVNOem5TZXBv?=
 =?utf-8?B?TVYybTRucjJCbkVOc3JtYk8zZStBNnlsVmM1elY2MkppOHVFWE1JUTJrTUpJ?=
 =?utf-8?B?QmVYWDQrMnB6RjJ6U3VwcU1zK2U2a0IxVEt2Zy9sRkxUOFlkM0t1T3d4cjJC?=
 =?utf-8?B?NDU5MEpseUJ2elRlZWcwZEZwUFhBa2hPSGFDM2dsbGpwL1pmTFl4UVB6Y1pi?=
 =?utf-8?B?VWE4dzA4a2VueC9xU1o0eWgxTE5PRzFBeUUwN1d1TmVqQXRYMU5KakpOdUdi?=
 =?utf-8?B?SG1TdGUreUZnRXZBem1mSHJjdDQrVHYzR2NMbGpSTTZKV0x2bmNaRmxqVFQ1?=
 =?utf-8?B?ZzNuN2pBbjdVamRtZnZUTUpFS0dEa250c2tOQzNId2VDVzFFVHBhcG51cmQ5?=
 =?utf-8?B?ODlDbUR2RFVhYTd0MWVPRTJjU1FrTGxPREpGd05BWkJnRXBZR01DRU4vYnl3?=
 =?utf-8?B?M1dXUkhlWWJHR2YxRkxtdjMwK055eVMxYzczOTdLMm9DVXhKMU44eG5hL29L?=
 =?utf-8?B?V2k2Zmg3MVp6RXd5cjF3c1RsUlFCako3YTdsd2o1Q0YxZjhwWGNXZDBIY3F5?=
 =?utf-8?Q?Uv7RP7IzuKM+G0B+j3Cyoq1Bn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F85562C8036F440B51A6C6C88A23852@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a9fc98-37c4-4697-df09-08da60131057
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 12:20:22.0873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z+rr4CYxuuccVtrpGnWHVcKsbR/8/Ru+9xRHM9nC2uKV3bFrZKeR3lAX3/7EabKBtF8x34eZlpz3+LrdYuxqFwSRm3eQ8pMjSStOWUHVUGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1892
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

K0NDIFBhbG1lcidzIGN1cnJlbnQgZW1haWwNCihpZGsgaWYgaGlzIGdvb2dsZSBvbmUgZGlyZWN0
cywgYnV0IEpJQykNCg0KT24gMDcvMDcvMjAyMiAxMzoxMywgQXJuZCBCZXJnbWFubiB3cm90ZToN
Cj4gT24gVGh1LCBKdWwgNywgMjAyMiBhdCAxOjQwIFBNIEx1a2FzIEJ1bHdhaG4gPGx1a2FzLmJ1
bHdhaG5AZ21haWwuY29tPiB3cm90ZToNCj4+DQo+PiBPbiBXZWQsIE9jdCA2LCAyMDIxIGF0IDY6
NTIgUE0gUGFsbWVyIERhYmJlbHQgPHBhbG1lcmRhYmJlbHRAZ29vZ2xlLmNvbT4gd3JvdGU6DQo+
Pj4NCj4+PiBPbiBXZWQsIDA2IE9jdCAyMDIxIDA4OjE3OjM4IFBEVCAoLTA3MDApLCBBcm5kIEJl
cmdtYW5uIHdyb3RlOg0KPj4+PiBPbiBXZWQsIE9jdCA2LCAyMDIxIGF0IDU6MDAgUE0gTHVrYXMg
QnVsd2FobiA8bHVrYXMuYnVsd2FobkBnbWFpbC5jb20+IHdyb3RlOg0KPj4+Pj4NCj4+Pj4+IENv
bW1pdCA1Mjc3MDFlZGE1ZjEgKCJsaWI6IEFkZCBhIGdlbmVyaWMgdmVyc2lvbiBvZiBkZXZtZW1f
aXNfYWxsb3dlZCgpIikNCj4+Pj4+IGludHJvZHVjZXMgdGhlIGNvbmZpZyBzeW1ib2wgR0VORVJJ
Q19MSUJfREVWTUVNX0lTX0FMTE9XRUQsIGJ1dCB0aGVuDQo+Pj4+PiBmYWxzZWx5IHJlZmVycyB0
byBDT05GSUdfR0VORVJJQ19ERVZNRU1fSVNfQUxMT1dFRCAobm90ZSB0aGUgbWlzc2luZyBMSUIN
Cj4+Pj4+IGluIHRoZSByZWZlcmVuY2UpIGluIC4vaW5jbHVkZS9hc20tZ2VuZXJpYy9pby5oLg0K
Pj4+Pj4NCj4+Pj4+IEx1Y2tpbHksIC4vc2NyaXB0cy9jaGVja2tjb25maWdzeW1ib2xzLnB5IHdh
cm5zIG9uIG5vbi1leGlzdGluZyBjb25maWdzOg0KPj4+Pj4NCj4+Pj4+IEdFTkVSSUNfREVWTUVN
X0lTX0FMTE9XRUQNCj4+Pj4+IFJlZmVyZW5jaW5nIGZpbGVzOiBpbmNsdWRlL2FzbS1nZW5lcmlj
L2lvLmgNCj4+Pj4+DQo+Pj4+PiBDb3JyZWN0IHRoZSBuYW1lIG9mIHRoZSBjb25maWcgdG8gdGhl
IGludGVuZGVkIG9uZS4NCj4+Pj4+DQo+Pj4+PiBGaXhlczogNTI3NzAxZWRhNWYxICgibGliOiBB
ZGQgYSBnZW5lcmljIHZlcnNpb24gb2YgZGV2bWVtX2lzX2FsbG93ZWQoKSIpDQo+Pj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBMdWthcyBCdWx3YWhuIDxsdWthcy5idWx3YWhuQGdtYWlsLmNvbT4NCj4+Pj4N
Cj4+Pj4gQWNrZWQtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+Pj4NCj4+PiBS
ZXZpZXdlZC1ieTogUGFsbWVyIERhYmJlbHQgPHBhbG1lcmRhYmJlbHRAZ29vZ2xlLmNvbT4NCj4+
PiBBY2tlZC1ieTogUGFsbWVyIERhYmJlbHQgPHBhbG1lcmRhYmJlbHRAZ29vZ2xlLmNvbT4NCj4+
Pg0KPj4+IFRoYW5rcy4gIEknbSBnb2luZyB0byBhc3N1bWUgdGhpcyBpcyBnb2luZyBpbiB0aHJv
dWdoIHNvbWUgb3RoZXIgdHJlZSwNCj4+PiBidXQgSUlVQyBJIHNlbnQgdGhlIGJ1Z2d5IHBhdGNo
IHVwIHNvIExNSyBpZiB5b3UncmUgZXhwZWN0aW5nIGl0IHRvIGdvDQo+Pj4gdGhyb3VnaCBtaW5l
Lg0KPj4NCj4+IFBhbG1lciwgQXJuZCwNCj4+DQo+PiB0aGUgcGF0Y2ggaW4gdGhpcyBtYWlsIHRo
cmVhZCBnb3QgbG9zdCBhbmQgd2FzIG5vdCBwaWNrZWQgdXAgeWV0Lg0KPj4NCj4+IE1BSU5UQUlO
RVJTIHN1Z2dlc3RzIHRoYXQgQXJuZCB0YWtlcyBwYXRjaGVzIHRvIGluY2x1ZGUvYXNtLWdlbmVy
aWMvLA0KPj4gc2luY2UgY29tbWl0IDE1MjdhYWI2MTdhZiAoImFzbS1nZW5lcmljOiBsaXN0IEFy
bmQgYXMgYXNtLWdlbmVyaWMNCj4+IG1haW50YWluZXIiKSBpbiAyMDA5LCBidXQgbWF5YmUgdGhl
IHJlc3BvbnNpYmlsaXR5IGZvciB0aG9zZSBmaWxlcyBoYXMNCj4+IGFjdHVhbGx5IG1vdmVkIG9u
IHRvIHNvbWVib2R5IChvciBub2JvZHkpIGVsc2UgYW5kIHdlIGp1c3QgZGlkIG5vdA0KPj4gcmVj
b3JkIHRoYXQgeWV0IGluIE1BSU5UQUlORVJTLg0KPj4NCj4+IEFybmQsIHdpbGwgeW91IHBpY2sg
dGhpcyBwYXRjaCBhbmQgcHJvdmlkZSBpdCBmdXJ0aGVyIHRvIExpbnVzIFRvcnZhbGRzPw0KPj4N
Cj4+IE90aGVyd2lzZSwgUGFsbWVyIGFscmVhZHkgc3VnZ2VzdGVkIHBpY2tpbmcgaXQgdXAgaGlt
c2VsZi4NCj4+DQo+IA0KPiBJJ3ZlIGFwcGxpZWQgaXQgdG8gdGhlIGFzbS1nZW5lcmljIHRyZWUg
YW5kIGNhbiBzZW5kIGl0IGFzIGEgYnVnZml4DQo+IHB1bGwgcmVxdWVzdC4gSSBkb24ndCBoYXZl
IGFueSBvdGhlciBmaXhlciBmb3IgdGhhdCBicmFuY2ggYXQgdGhlIG1vbWVudCwNCj4gc28gaWYg
UGFsbWVyIGhhcyBvdGhlciBmaXhlcyBmb3IgdGhlIHJpc2N2IHRyZWUgYWxyZWFkeSwgaXQgd291
bGQNCj4gc2F2ZSBtZSBtYWtpbmcgYSBwdWxsIHJlcXVlc3QgaWYgaGUgcGlja3MgaXQgdXAgdGhl
cmUuDQo+IA0KPiAgICAgICAgIEFybmQNCg==
