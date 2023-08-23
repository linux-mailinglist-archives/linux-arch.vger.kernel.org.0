Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298B8784F1F
	for <lists+linux-arch@lfdr.de>; Wed, 23 Aug 2023 05:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjHWDJB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Aug 2023 23:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbjHWDI6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Aug 2023 23:08:58 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020019.outbound.protection.outlook.com [52.101.61.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71BECD5;
        Tue, 22 Aug 2023 20:08:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnoWbrmqQogp9JADCeTqQHxMNF7HM51iH/AVpLyhUCW7PoC3rNJUcaLuC2TboHJ4oU3oI1MvR4OAOeti+r7bQNvMVgnRWay+efXN++GAYSzVAkxc+BfcYqDDvp0xtXRrlUdylgKBLyXDc5ygcwLsBlyBuNv/dcD4AnnwTirDwoSo0CdkW/E643Yx7mBOojYhShrHSMDYb+qMEExKd1nFhoFVflQXE8GvrW8W5TchsZm/LbCw3NFBr4iU1KTarzllkKjMc6gpP4W8giSag7mKW0wYhfkVMue9sgIqUT7UqAeq2ynoigeCcNmKfR/LLQpg6RErH1ljIbea3YDZnRgiIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymHlzwYXS26dA1RMgi3xcBt3tiqWIpszyNL0qSWiViA=;
 b=RHde/JqZq08/liznv83EmSAypsravS/oMnbavPT57Ptn/HnY/P7qFyaaj53JMziVb92TpZDFFBGHRBJhB+WhDNPgx1k65UlWZulPCvBpEzbQvMHi1sp9ynPh2MtMVttvS5B0h0JKRW+4OIRMP+1KDNGQPYTRnz0qre1/VaLnh0qQ0rX08h4W34StVq3DgO0OLs67PnbqXn+qB6uMcr4HOwMqtWWQ7/Z8gturGymyKhY8nQFRUpKnx/5ouUPRBYJFtndcqjsPJrj1kLmGEDBYDUrAq2YqCr8KaIptzkjuJ04WajOABfWthAt9uJtv71UoiGxOD/00LxyF7NNixujcyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymHlzwYXS26dA1RMgi3xcBt3tiqWIpszyNL0qSWiViA=;
 b=GnbJ6ZqUnBBJ6WHRrStO3i1drWgMkJM/FazgYGoBKiY8mj6w7Qo86lrSH3JAk281+y6H3DRnP0JD7XyqIAfaww/Jb5S0Tb6jIFsov9QTS362UaYGOGwXQR4tW8EXtvas9TP4xHKRIddpFdK1ryVmn4h9gVc75obugBC9XdzAGRg=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by SN7PR21MB3827.namprd21.prod.outlook.com (2603:10b6:806:29a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.4; Wed, 23 Aug
 2023 03:08:54 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f%5]) with mapi id 15.20.6745.001; Wed, 23 Aug 2023
 03:08:53 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>, Tianyu Lan <ltykernel@gmail.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH v7 0/8] x86/hyperv: Add AMD sev-snp enlightened guest
 support on hyperv
Thread-Topic: [PATCH v7 0/8] x86/hyperv: Add AMD sev-snp enlightened guest
 support on hyperv
Thread-Index: AQHZ1TApIvlQ6j6w2EaWKJk4sPhtrK/3MTXA
Date:   Wed, 23 Aug 2023 03:08:53 +0000
Message-ID: <SA1PR21MB13353ED36ADAA84F13F40543BF1CA@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230818102919.1318039-1-ltykernel@gmail.com>
 <ZOQMiLEdPsD+pF8q@liuwe-devbox-debian-v2>
 <b4979997-23b9-0c43-574e-e4a3506500ff@amd.com>
In-Reply-To: <b4979997-23b9-0c43-574e-e4a3506500ff@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9b6db2b0-477d-4387-9c13-cb4630d51ac3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-23T02:59:11Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|SN7PR21MB3827:EE_
x-ms-office365-filtering-correlation-id: 651a06e4-5505-41e3-4761-08dba3864856
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BYAHeFcEzgM+o2gM/K0++lkG/KwCnim7YO/0zV4VEhb3ARQFb/NVVHXSNTFRTOU0Z/IIRE2vkPVDESxyjUIA8RwKewrDjc14CyZWNEwCTX2q6eD20SptJqaCaNLD9GznZ8ti6BiF02k+eIwBCHSJWr2NPEjvlHUHuZHZfoHvCbrEV/gWi8TB7gWfhzX6/Uan4/OLHGbqkKBEPLkrQek+g1jtkYT+QvoIi9aGIyUlbmjHRuDIglROZfDIfZE1oTcgO046JIo/9sbpV+aSEjL9F2loKLrVmi98YW+YHiWzgKeKmR4S08/bHGuNT65zGZibLi79nJ/MlRwhcYpDVEpMAjn8hAc32jSktZ/A4YYviKEpnDTaFkraQd/x8t3o/TcQniZMD3zKQHEx+7kni+VYRPv2hVS7/gUOftohsdVf2pECqdVB7C3h4e++lVR9VVIWNgQGBzHhdp8vW/c4IAaSEL0Hxzh8Z3OXKzyv6sgF+WsbuUQ7/aPnuFo1re0QZyUpDYvUIJVWmJF5S3vjRr+SAyY/jwIAJi0Y6wHi7YhU76wAiQj0RHKph9WsMHkhdCpV/Sft0qMVtUgOHpY24VsyLfXwDywevVO0LjrzR5o0vLE+903cXwpOqrGnDvgh4vuYURWXiVY8WXT3P6apycn1A9Hoi8MLlgKGYrdSK/CrMkGNrxBvBcS2rL1snOz+P02S
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(376002)(136003)(186009)(1800799009)(451199024)(12101799020)(55016003)(966005)(478600001)(71200400001)(10290500003)(110136005)(6506007)(83380400001)(122000001)(82950400001)(82960400001)(8990500004)(2906002)(7416002)(53546011)(7696005)(9686003)(26005)(76116006)(41300700001)(33656002)(86362001)(38070700005)(38100700002)(4326008)(66556008)(54906003)(64756008)(66446008)(66476007)(8676002)(52536014)(8936002)(66946007)(4744005)(5660300002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXVmYnBrR0lJUWVodDRYcHRWaFZMRG5kanFZbW5nM2xtdXR1VnMrMzgvVlFM?=
 =?utf-8?B?dDVjMVdMeVlNQUtFYm9FNmViMm0xMkVzRW5VZjY0TzNhVlJBaFdzbzJ2eWto?=
 =?utf-8?B?NTJLOXlXNFFDQU1OK2dVN2JUaVltb2RYaGQ2ZWtFNTI5WUwyRFpRZ09jbWNK?=
 =?utf-8?B?cmdsM3JGdm4wNVAvVTFESFdxRmo5UGM2TVJ2ZHJYOG5mMXE3U3JTb0k5NUN0?=
 =?utf-8?B?Y3lPQVNLS3J5TWdkLzVWVGY2OFlGMXRSRDBGYStUQ2dLc2doTUlKWHNWbzdU?=
 =?utf-8?B?UE43S29hWTRvVWxsQ25IT1FRMGNZNjlySFByY0JZbE9Ba1lIT3Fnbm5mYzNr?=
 =?utf-8?B?WEl4QmlwU292SGtiT2lURGFhQ080QlZEWk1ncitHM3l6cDRrYkpEZlY1V3FW?=
 =?utf-8?B?bExaeEhkR3JVTytJVHNhUVdRRW9qTkNxVmh0MTkya2JXbm45ODRkVUE1dkpR?=
 =?utf-8?B?YmRRZmtVaVJJUTZZM2lRM0ZZdi9MemJzMmxsWXBjaXA5amRQcm1JYm5QbDkv?=
 =?utf-8?B?UHkxdE9Lb1JBRWNpWVdGSzBQanB2a25qSkxYYUZWdkVrc0FNNWlCY0xhMUx4?=
 =?utf-8?B?YzNNTXFQaUkrTG9Uazd6ais2VFpyQ3JUaTlGdEFZRmNJaXVkcTVvUU0zT0I4?=
 =?utf-8?B?T2V2MDUwYmx3ZUZSY3RjVCtiaXZMRThGUHFBRC8zQUE0UzRIZXcvSGQvY3ZI?=
 =?utf-8?B?S21CU2FiUzdnOHJPZ29rbzdjWkw4eHVBVnlxUE1qYzg3eWJWOFE0YnJrelVM?=
 =?utf-8?B?SjlMTTRWQ0lzdXlOUFZJMEw3S0xxQUpSc2JZSjhTNS9zbHgwTk9oWmN6dkVh?=
 =?utf-8?B?cWw4SzN6YjBIRWwrOVFFZXF5dFVzbWNiMGtDRTI1RmVjMDVzdHQ1ejEvZTVj?=
 =?utf-8?B?aVpDODRDWVlzZGxLOGwwd1NkUUlNTTRPa2lMV1hnZDJlRFNZWDJPbFNpcFJy?=
 =?utf-8?B?dmVjVmk5UXFDM3F5RndINmVUcVNENWVRT2dVSVBxRXJPMjdxL0plcjFGMEdn?=
 =?utf-8?B?WGlHZXhkam9ORjJJY1RQcmJGdUtNWGxkWFloN0F2QW9IVUhIeEJka1pwSjBt?=
 =?utf-8?B?VzQ0Y3Z3T1dtaUUvdUVtNXBaY1NMbkxDcmt2ekQ1Yno4T3hPMEVOOFBmQS9r?=
 =?utf-8?B?UG1manBJMkF3dmdjN2g4L2hPcktpNWFRY0Z3V1VscTMyL2xwU2RNaE16cDhU?=
 =?utf-8?B?VVJBUGN4WHFSWkxGRGRmZG5oaHF1Sjc0K1hBMko5WnU1b29rY3NDMXNyODBK?=
 =?utf-8?B?bkEyUEJyaWlrbmlZKysvWE5qQTRFMWE0YmhIVjNQaDljVS9jVEp6UDA4SGlD?=
 =?utf-8?B?eGNTMFc5UjNBY1BXWTYrQ0thQTJjSHVpY2Q2UHNHWVdmK20vS01sN0RhU2dD?=
 =?utf-8?B?WWlvZWJPWmdRUm9zcVF1RnJ6VzVpSFFrQUhmRWJjdkxPN0JReGNsV25XTDVR?=
 =?utf-8?B?T2VVaVhoRE1vaGtsMXkwbVBvMnpKeng0bmVBRkY5Ykhla0ViNVhSUERTUXFG?=
 =?utf-8?B?ZHVZSXF1cmJBZ3Z2ZFZJeXpQR1UzaDBDUWl4MGJuMk9oU3p4bG15bXlreit0?=
 =?utf-8?B?eTRkVzJreU1VUFQ1dEhpM1NqazNIZUplQzVqM2V5Mm81Q1NRUTJZM2lmRlR6?=
 =?utf-8?B?aDlKYVYyWDNIcFd5VHZreWcrNzJjVlFpblBKMlpEQ1ZRNTd2QWZXTnNPVG53?=
 =?utf-8?B?dzk2akd3WUdUVVJHNVByK1FkaFZ0STNGOU5xdUxiM3lKUHZNeUU5c1BOeElQ?=
 =?utf-8?B?YjR3WUVsRXRhQWNSeTF5cHRtckVkbk1DeFFrY3NyRC9EMHhmRHN0NmdLc1Nm?=
 =?utf-8?B?NDI4RXh3eTMzbTl3MDJlNXMvZzVYTFRqNFR1WG5BQnNublpROFZQeC81WVZt?=
 =?utf-8?B?cDFCZHIxVVA5cjZSekR1VjJjZ2RxMGhSNlhLSGRIeDljRGtlM2o4VjJkRGV4?=
 =?utf-8?B?eVI0WnVFUmRsV1NkUmRXRmJrREdsUWQzU0VFU01FZmFNVS95THo2eVNTWjl6?=
 =?utf-8?B?aHVoc0gyYWt4NGFPZHZFVVZSTnNPeHR6eXFGYS9ZQzVWSGFoUEhzNk9ZSFM0?=
 =?utf-8?B?T3RnTE5NemhRWlFnSjN2c3lWek0rbXJRK0piZi9aQ1ZGYmN3cWtTOURvZG9j?=
 =?utf-8?Q?y42K2zTDVn+2fGfr1PmTNoihm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651a06e4-5505-41e3-4761-08dba3864856
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 03:08:53.7518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BPn0XSZpIGRAEqtiQnlBotJvgLoSo/aDpPVCNTGLQv6E0J4undS5oUguhc3/nvjEUZbkmHh5jUYQv1EAfLDSPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR21MB3827
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PiBGcm9tOiBUb20gTGVuZGFja3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29tPg0KPiBTZW50OiBU
dWVzZGF5LCBBdWd1c3QgMjIsIDIwMjMgMTI6MzggUE0NCj4gVG86IFdlaSBMaXUgPHdlaS5saXVA
a2VybmVsLm9yZz47IFRpYW55dSBMYW4gPGx0eWtlcm5lbEBnbWFpbC5jb20+DQo+ICBbLi4uXQ0K
PiBKdXN0IGZvdW5kIHRoYXQgdGhpcyBzZXJpZXMgZmFpbHMgdG8gYnVpbGQgaWYgQ09ORklHX0hZ
UEVSViBpcyBub3Qgc2V0Og0KPiANCj4gbGQ6IGFyY2gveDg2L2tlcm5lbC9jcHUvbXNoeXBlcnYu
bzogaW4gZnVuY3Rpb24gYG1zX2h5cGVydl9pbml0X3BsYXRmb3JtJzoNCj4gL3Jvb3Qva2VybmVs
cy9saW51eC1uZXh0LWJ1aWxkLXg4Nl82NC9hcmNoL3g4Ni9rZXJuZWwvY3B1L21zaHlwZXJ2LmM6
NDE3Og0KPiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBpc29sYXRpb25fdHlwZV9lbl9zbnAnDQoN
CkkgbWFkZSBhIGZpeDoNCmh0dHBzOi8vZ2l0aHViLmNvbS9kY3VpL2xpbnV4L2NvbW1pdC8yOWZh
ZGFiY2FhMmNiMzQ2NmFjZTFkZmYxM2I0ZDk0OGE3MWY4ODhkDQoNCkknbGwgcG9zdCB0aGUgZml4
IGltbWVkaWF0ZWx5Lg0K
