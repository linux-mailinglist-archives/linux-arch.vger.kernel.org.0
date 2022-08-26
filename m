Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988915A2B64
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 17:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241295AbiHZPhx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 11:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243507AbiHZPhu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 11:37:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233DC7A779;
        Fri, 26 Aug 2022 08:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661528268; x=1693064268;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ehz4grZjhWyEhkN+3iMk1WOhZdy68iEH/WCm38ZP+5U=;
  b=O9I6ylK787QCnHeADdbUIu+0WVALloIWKp3x2V9QI3IMjdDqGtfO0uhd
   YE4kH6r0cSjyjDRmQ1s8YOo/MSpRJxe9SmjivXhNhlaQgAtEQysjH0uMB
   RC/oVbS04WD+NWQcpk7e0+SoxxpM8zpZTr7Wpq7eLhpqiqAG/G7hQV2eL
   A6gUEFVeHgh4sm3OMi+m/+Md4mDbFpqRak2yLzziRpwGR2mJJvmfLlJn2
   SZT6/3JT3kYS75uysMMtuyOS0DIyIasBDgj0VDwGj3OpmaDorPRvzUCl+
   QAJSg8v1nmevU7VK9WRITttduEA/6mUoIRb8aLKQjtqoS3JJ+Bsuhyq7x
   g==;
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="188219916"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2022 08:37:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 26 Aug 2022 08:37:47 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 26 Aug 2022 08:37:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zv952nfkCaLCVRdH52xmvF8PDJLI0XleLsXjSd6Y+wEK1Wi14KHNBBDR/ODy9b/Da4xsX1tYpRbW1y9XWJiiHZlopsofhRWkmhYo/oRVQCtc0Nno6Q/1AOvEY4X7QpRNxmqZSyPX1i57xMV4yj9gY5pDqHt8/0C1Q8XzIFQ0BGiPE1cuFurlYCVET3P1KUY39GiOjQDGNa2UEJbcSi98u0QiiVSXz2S10tBZgPd+n8fx87MQ5iJnYAiebVgrfRHlP77iewQjz3RXSeTQaUK+dI39uiaOB0Nh61p+drKyTOn+JsW4rxz/CYrUTqYaPMmjGTGUfKb1ewZ7xwlYqhwtig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ehz4grZjhWyEhkN+3iMk1WOhZdy68iEH/WCm38ZP+5U=;
 b=I/Gzwqok1VwvCouGMEU35Up1LC+f8bKQ9gPHn9pof0LWNKCzZmB9n+Wdw2NjdnS/SmEQI2AHQp5ZiGnXjiGFdW7wObEx3qDLlCsC2Z+6lbVnQSuBQjzctIVOZiHzXhUYeNG/9Jli0NAmjqgBVFjW8nVb4b3t4DwSW8/j8qf9V6sQWVXDL4KreTDdQvTwKu/cNhakuFnc4zTADbu8gmylrKJdcsos14nnGX/mgULu+kUCMRTAzjmkoQulmOF32EZWqiHBWczirGTX+6f1lsglC2f/+WIiOL97woy3RLCKfWg4SFlMIwO2U4F38KyPtt7S5JwNf3g/VsCgM/3Is1I8Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ehz4grZjhWyEhkN+3iMk1WOhZdy68iEH/WCm38ZP+5U=;
 b=YKnp18RQJFsC9vRgNfrYTvwLMG1goC25L/kxMtsrbqvpmzCTgQWyk9S8e1ct3yxT0JgFRNR7urCJ+7jcKOkzvBCanITXss3JFNCZcpMmoUl9tItd/etvtsUgyqjQKgx5A9Mw0A5PCkpXIStJKECNHAZQQpQiUl5nXB1ZXtrCgPk=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by PH7PR11MB6056.namprd11.prod.outlook.com (2603:10b6:510:1d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Fri, 26 Aug
 2022 15:37:41 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 15:37:41 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sam@ravnborg.org>, <mail@conchuod.ie>
CC:     <monstr@monstr.eu>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <hca@linux.ibm.com>,
        <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
        <ysato@users.sourceforge.jp>, <dalias@libc.org>,
        <davem@davemloft.net>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <arnd@arndb.de>, <geert@linux-m68k.org>,
        <keescook@chromium.org>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-s390@vger.kernel.org>, <linux-sh@vger.kernel.org>,
        <sparclinux@vger.kernel.org>, <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 5/6] sparc: use the asm-generic version of cpuinfo_op
Thread-Topic: [PATCH 5/6] sparc: use the asm-generic version of cpuinfo_op
Thread-Index: AQHYtVJUB5xz+q4nSkCZ18VS3U1tX63BSsiAgAAOIAA=
Date:   Fri, 26 Aug 2022 15:37:40 +0000
Message-ID: <87c83d38-18bc-7dfc-be6f-d906ed713450@microchip.com>
References: <20220821113512.2056409-1-mail@conchuod.ie>
 <20220821113512.2056409-6-mail@conchuod.ie> <Ywjc67hcBwOkMtI/@ravnborg.org>
In-Reply-To: <Ywjc67hcBwOkMtI/@ravnborg.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e12f5ed-6df5-4d74-906d-08da8778e96e
x-ms-traffictypediagnostic: PH7PR11MB6056:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VDGlC/wdnRe62VEhDGOBMwQxoUIR/jJzJswQZtCkHqQLMcKYuILy4RmZJjzre3fe45eXQFMUn7ECLr2/1g+JZJd74o3zUbPyJoTafbz+/ciuCYCh280YvZNkB1OjK61feFAx/pS1MvTy5vZHgLjA3XNdP0va266snbcLyhUI8cVLIaaGKxJDmk2rl1Lxv+wrej8DFNDlNA5VpA3nePJYPpRhO/HG7q35xUtoIIYx2i3+w1c4C1x2iNHi/P/RH/zYY6hixwskVStW+qUtZEW8e9bOU+Cdm4TT+ovfg2HRbAuUAYK9zcGU5Qs34nOPdT2oW1DB93ze+riCqTqJym5jBHxlb6rfiywxWAsn7GGdlVRlajhgBb3VYREVnlX9t+3qTgW4xF2+Rp3SE38vLJQA/NIIngQ7SiJbBvvKUpHIGh7IWgnbQTDWHiSnCGMOz0jCC3P0jaTOB7zIwwxDyADX4iRM4Qby6hXYdLM8LebpOhh8ELEQx/pjmC1JMn0v5umciAwvDV+PzUozSYi6SoC2iU0n7nvOdK3tW2jOECc0vhWKn0Mrh0bw1mgsVltVz/YaDYkvGFisqvlwGNlL9rCOMAr35tGvCEodkGI1ALQbBWfhFlAVFLxHHFpf/nn8YhZgO5oJBvXhsZEIkPZCJ65LNz/4vt76QbHuPf9xsAYyJW6iUWkUrWXhVeXMdR0a8Xu+TUSTA5MYlSm89PlaME4m7ldjbSiEC6GiqJur1rqId9fIzCj9P8cwq1kG8LfcnLYTehXnvEWE5ySzO/CTG1SeeQUyRYTDSSkAa13nMe3s2kB88Ty5PXzqkX1U3i7i2/P60uERK+xzHKN7u4sjWZheS6+3KJo/eX0dxBNzgwQ2+fNLWU0DdOh0xsSLWBv8ZkVh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(366004)(396003)(136003)(66446008)(54906003)(316002)(38100700002)(122000001)(7406005)(7416002)(5660300002)(8936002)(83380400001)(66556008)(91956017)(38070700005)(66476007)(478600001)(8676002)(64756008)(66946007)(76116006)(4326008)(186003)(110136005)(41300700001)(2616005)(53546011)(966005)(6512007)(26005)(86362001)(6486002)(71200400001)(36756003)(31686004)(6506007)(2906002)(31696002)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmtsYnlXZjFTRmgyRU9DaWdpcTZQMk9zU002Ym0wQTZkT1hRK0VYNkMvYWVP?=
 =?utf-8?B?b0JjbkRuUVptOW12SkNUY2FOQlBpNTJBWW95UTlibitjSG5yTzJnYlRINmlR?=
 =?utf-8?B?N1I2Y2dlUEFQbGJSZEUwcVMvUEQyZHVWOVJCNzdxQ1IrYjJ1aXA2YkRQaVI2?=
 =?utf-8?B?anhRL1hoU1VPSzJsT2lHbXA2dmpkcGNtdHJPbFJrcWM3K1RCK0tya3h2dWZZ?=
 =?utf-8?B?ZjZlbkZxMngrQ3JzTDYyK2wrK1hYS1VIb1A5NldKbm1SQ1lnRll1c1JVREND?=
 =?utf-8?B?dXNEVVpoUW9NcFhWKzJPWUZKM3czcW1YWnhrRVdkTHc3bkJaS2lrM09uUjFQ?=
 =?utf-8?B?WGpIVkJMcm44d2lCRis2bGpkRWxHQ0Q3V3hEdjFxZFgxR0x3eDg5R2IxSmVL?=
 =?utf-8?B?YVNMTGVidDRZU0VTOFRqRTAwNHJtak1JUktyNWtCaVdhMXo4THM5Mzgxb1Jp?=
 =?utf-8?B?OS9DbExROCtEZjI3c3ZYeWJsbVorcE1XeVYwSUVVTjZpdjBCSjQwamhFTzhy?=
 =?utf-8?B?Y0EyQTU4MHdudlE0b3RROEFSeWJZZDBGRCs1dnVocEtRSHhSSyt4RVlpZ2hE?=
 =?utf-8?B?ZENiWnl2MVk1L0xmN0lVS21Cem1ocHhYNERoU2loeVBBSVhkRkpuOWdPNGZY?=
 =?utf-8?B?OGx5UDlESnNUTGFhQW5pMDVRVUVQNjdqWW51TTZ3RnR1SnhDZmF1QU1zRUF4?=
 =?utf-8?B?V09UeURDZlE1MC9VeTczMlFoNUlFN29mb1ZNT1dHenZoSTVRL1lMYjBTQjRS?=
 =?utf-8?B?Rm45eTJpYWJLWVM4V3RJcFBhREVKTUs3cTY3M2VjaFVtVEJQcTkvc3FSWXhz?=
 =?utf-8?B?QmlpWXRabVBCYVpKTHAyelZ3My9haDhtNnZLUE56T2ZjQ0F5bERHS1pFVUh1?=
 =?utf-8?B?UzhxRWRqSGluUW8yRCt4TjFQV3kwMTQ0aGRsNkVqZTdueEVKdmNJYXR3bkNk?=
 =?utf-8?B?Q1huTUpVYjZLTkNNYVd3dlhwNllWZ3ZsamkxMFZ2TWhNMW5lUHVmSnFBYmla?=
 =?utf-8?B?elNBTklLMzc2aFNBU3huK2FFQWo5SFlDU0ovNEFMeFNrWDRMVC9yU0dDcE1P?=
 =?utf-8?B?SFFoaFJGR1Jobndoa3BmeWtBWGtOVk5IVUtndWtKU2xIYUVnOE41SUpHN2VK?=
 =?utf-8?B?dDFhcTVVSWJyME5sTytPUnFRZ1BJOHZFOURzbGpORlJjY2t4ODlNS0xsbjlC?=
 =?utf-8?B?dkJ0QjMwbzVlM2hxTnNCYjlwT0Z4bFJacFVROEY1OWI3S1RIazZnSUhyNEhM?=
 =?utf-8?B?YVVJSFo3VlM1eTNDaGFzRGdYRXIxK1N4OWVHcW1yUVljRWhOc3RmZjV5QzhL?=
 =?utf-8?B?dHNhb2NRYTA4eThNcC9FMUF1VlpURjBEdXoxQ2hkcFRZeXFLMmYydEtla1hP?=
 =?utf-8?B?K0pDNm5mRzNCRS9sOTB0N2dRYmhLUW5CVVowSHQ3WWdNeHBxd0pOaGdvam9k?=
 =?utf-8?B?bVAwTG00MHJGY3BpODE1M1pWczIzNEk0NXRnZTdrSHlESWpDT1lteHRjSGZ0?=
 =?utf-8?B?Mld0V1VQam1GUFZDSEV6QTN5RG50YjhnZ2hzQ3dHUGo5VTQ2R0ZKZEk4czVo?=
 =?utf-8?B?THgvY3ByNC94ZWVEdS8rb3FxMityZ0h6WHhEcjVjeU4wMGJlalIrQXdDQWVR?=
 =?utf-8?B?UXFnTkNuWWxlRTFhalZtUHFOQzc0T3dCblB2NHMzM3BDZldsZWpxMThhaG5Q?=
 =?utf-8?B?dUkrZkFPTEdEZlowQTBxOUY0RWpmdWFnalFFYXlVdmw1bmN2RER2YW9nNllK?=
 =?utf-8?B?QXRTSFJMSHNubXlpamdDU2hnWnNpZjQzOFJoU0srM0ZZRkdzNGE0RlhhTHZQ?=
 =?utf-8?B?L1RtdjAyanFVbnZxSUpMQzNENXNNY3UyVFBSRytYT0hLZ3NLWWFkQm1OaU4z?=
 =?utf-8?B?UWU4dmNYbk5mL1poRVhiT2hrSTNKNG1pcDBkQ0hnSjlhR0NLOXdYOTNoMXVu?=
 =?utf-8?B?RjFaWDNtTUM1TkRnZWVYdlE1OGFmcTF5aWdDYUp2RkdkNmFRbVRtMDYwN1Y1?=
 =?utf-8?B?bU9EN2FDckI1bUprZGU5Wk9Yb1JXR1krbjlrRy9TWkxsZ1RaQVllTHFMQVYw?=
 =?utf-8?B?RFFvZUZ1ZFJjaUNXYjRLTE00anFaQ0dBNHhJSEtFaUgycE8vdkJXMUx6NGxm?=
 =?utf-8?B?S3JlNUJnTmM5dmRDYTcvNDNFamR4UzVRSlBOMU9UaWVIV0pUdjZFK0RxeVpK?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEC04B5D6C6F81499C582F11ADF292AB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e12f5ed-6df5-4d74-906d-08da8778e96e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 15:37:40.8352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jh667STd1eCL5k1T84UPIGvmRg9+sF3OG3bstQ8zfKFwfoAdAQP//MoU/iJ9jQPffwoMbN0vzAWEvfVmpDypmNBOiRxoSkLMCCwC+dg4FB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6056
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMjYvMDgvMjAyMiAxNTo0NywgU2FtIFJhdm5ib3JnIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpIENvbm9yLg0KPiANCj4gVGhhbmtzIGZvciB0
aGlzIG5pY2Ugc2ltcGxpZmljYXRpb24sIGJ1dCBJIHRoaW5rIHlvdSBjYW4gbWFrZSBpdCBldmVu
DQo+IGJldHRlci4NCj4gDQo+IE9uIFN1biwgQXVnIDIxLCAyMDIyIGF0IDEyOjM1OjEyUE0gKzAx
MDAsIENvbm9yIERvb2xleSB3cm90ZToNCj4+IEZyb206IENvbm9yIERvb2xleSA8Y29ub3IuZG9v
bGV5QG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gVGhlcmUncyBsaXR0bGUgcG9pbnQgaW4gZHVwbGlj
YXRpbmcgdGhlIGRlY2xhcmF0aW9uIG9mIGNwdWluZm9fb3Agbm93DQo+PiB0aGF0IHRoZXJlJ3Mg
YSBzaGFyZWQgdmVyc2lvbiBvZiBpdCwgc28gZHJvcCBpdCAmIGluY2x1ZGUgdGhlIGdlbmVyaWMN
Cj4+IGhlYWRlci4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRv
b2xleUBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgYXJjaC9zcGFyYy9pbmNsdWRlL2FzbS9j
cHVkYXRhLmggfCAzICstLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBk
ZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9zcGFyYy9pbmNsdWRlL2FzbS9j
cHVkYXRhLmggYi9hcmNoL3NwYXJjL2luY2x1ZGUvYXNtL2NwdWRhdGEuaA0KPj4gaW5kZXggZDIx
MzE2NWVlNzEzLi5hZjZlZjNjMDI4YTkgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3NwYXJjL2luY2x1
ZGUvYXNtL2NwdWRhdGEuaA0KPj4gKysrIGIvYXJjaC9zcGFyYy9pbmNsdWRlL2FzbS9jcHVkYXRh
LmgNCj4+IEBAIC02LDggKzYsNyBAQA0KPj4NCj4+ICAjaW5jbHVkZSA8bGludXgvdGhyZWFkcy5o
Pg0KPj4gICNpbmNsdWRlIDxsaW51eC9wZXJjcHUuaD4NCj4+IC0NCj4+IC1leHRlcm4gY29uc3Qg
c3RydWN0IHNlcV9vcGVyYXRpb25zIGNwdWluZm9fb3A7DQo+PiArI2luY2x1ZGUgPGFzbS1nZW5l
cmljL3Byb2Nlc3Nvci5oPg0KPiANCj4gU2luY2UgdGhlIGhlYWRlciBmaWxlIGRpZCBub3QgbmVl
ZCA8YXNtLWdlbmVyaWMvcHJvY2Vzc29yLmg+IHRoZW4gaXQNCj4gc2hvdWxkIG5vdCBuZWVkIGl0
IG5vdyBhZnRlciBkZWxldGluZyBzdHVmZi4NCj4gVGhlIGJldHRlciBmaXggaXMgdG8gYWRkIHRo
ZSBtaXNzaW5nIGluY2x1ZGUgdG8gYXJjaC9zcGFyYy9rZXJuZWwvY3B1LmMsDQo+IHdoZXJlIHdl
IGhhdmUgdGhlIHVzZXIgb2YgaXQuDQo+IA0KPiBBIGhlYWRlciBmaWxlIHNob3VsZCBpbmNsdWRl
IHdoYXQgaXQgbmVlZHMsIGFuZCBubyBtb3JlLg0KPiANCj4gSSBsb29rZWQgb25seSBhdCB0aGlz
IHBhdGNoLCB0aGlzIGNvbW1lbnQgbWF5IGFsc28gYmUgcmVsZXZhbnQgZm9yIHRoZQ0KPiBvdGhl
ciBwYXRjaGVzLg0KDQpIZXkgU2FtLCB0aGFua3MgZm9yIHlvdXIgZmVlZGJhY2suDQpBcyBwZXIg
R2VlcnQncyBzdWdnZXN0aW9uLCBzdWJtaXR0ZWQgYSB2MjoNCmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LXJpc2N2LzIwMjIwODI1MjA1OTQyLjE3MTM5MTQtMS1tYWlsQGNvbmNodW9kLmll
L1QvI3UNCg0KSW4gdjIsIEkgaW5jbHVkZWQgbGludXgvcHJvY2Vzc29yLmggaW5zdGVhZCBvZiBh
biBhc20tZ2VuZXJpYyBoZWFkZXIuDQpUaGUgZGlmZiBmb3Igc3BhcmMgYmVjYW1lOg0KDQpkaWZm
IC0tZ2l0IGEvYXJjaC9zcGFyYy9pbmNsdWRlL2FzbS9jcHVkYXRhLmggYi9hcmNoL3NwYXJjL2lu
Y2x1ZGUvYXNtL2NwdWRhdGEuaA0KaW5kZXggZDIxMzE2NWVlNzEzLi5mN2U2OTBhNzg2MGIgMTAw
NjQ0DQotLS0gYS9hcmNoL3NwYXJjL2luY2x1ZGUvYXNtL2NwdWRhdGEuaA0KKysrIGIvYXJjaC9z
cGFyYy9pbmNsdWRlL2FzbS9jcHVkYXRhLmgNCkBAIC03LDggKzcsNiBAQA0KICNpbmNsdWRlIDxs
aW51eC90aHJlYWRzLmg+DQogI2luY2x1ZGUgPGxpbnV4L3BlcmNwdS5oPg0KIA0KLWV4dGVybiBj
b25zdCBzdHJ1Y3Qgc2VxX29wZXJhdGlvbnMgY3B1aW5mb19vcDsNCi0NCiAjZW5kaWYgLyogIShf
X0FTU0VNQkxZX18pICovDQogDQogI2lmIGRlZmluZWQoX19zcGFyY19fKSAmJiBkZWZpbmVkKF9f
YXJjaDY0X18pDQpkaWZmIC0tZ2l0IGEvYXJjaC9zcGFyYy9rZXJuZWwvY3B1LmMgYi9hcmNoL3Nw
YXJjL2tlcm5lbC9jcHUuYw0KaW5kZXggNzljZDZjY2ZlYWMwLi5mZmRjN2E4MjViODAgMTAwNjQ0
DQotLS0gYS9hcmNoL3NwYXJjL2tlcm5lbC9jcHUuYw0KKysrIGIvYXJjaC9zcGFyYy9rZXJuZWwv
Y3B1LmMNCkBAIC0xMiw2ICsxMiw3IEBADQogI2luY2x1ZGUgPGxpbnV4L3NtcC5oPg0KICNpbmNs
dWRlIDxsaW51eC90aHJlYWRzLmg+DQogI2luY2x1ZGUgPGxpbnV4L3BndGFibGUuaD4NCisjaW5j
bHVkZSA8bGludXgvcHJvY2Vzc29yLmg+DQogDQogI2luY2x1ZGUgPGFzbS9zcGl0ZmlyZS5oPg0K
ICNpbmNsdWRlIDxhc20vb3BsaWIuaD4NCg0KSG9wZWZ1bGx5IHRoYXQgaXMgbW9yZSBhcHBlYWxp
bmcgdG8geW91IQ0KVGhhbmtzLA0KQ29ub3IuDQo=
