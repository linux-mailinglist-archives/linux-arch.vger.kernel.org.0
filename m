Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472ED5AC3EE
	for <lists+linux-arch@lfdr.de>; Sun,  4 Sep 2022 12:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbiIDKgr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 4 Sep 2022 06:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIDKgq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 4 Sep 2022 06:36:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320121A075;
        Sun,  4 Sep 2022 03:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662287805; x=1693823805;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SAqZuBOvnh018QGCNXfMUC8jNsoDdhGgn/DhLGHSyjc=;
  b=ig94YvNFNqNrZe5ePbFCANu2WvSkVu/qCVgtDahA6M39L8DzHcaiIdMq
   DeaTzhY6jWg9alIMMKQFbABEoI1VLeAZAYaHt47IlEqFhOxjUduxbQQ2E
   vW/aV2eJQ5iE3GB9+mWtnwd1is/I5lYjYPJvIQ2XskTMg8ZKYuIeolPEX
   Zk4eimCy31hfHdBj51MaA+dBTgRiCmSFS0OtQx+5WlGtWjRti6WtV9oiB
   WFdy/+0OA+Tt0hB0WxVNIKWRBecChLHnwHPRoJxa11vyZOD2UZxWmGYAe
   m4MgPZKxKulnGPGsSGPxkf4mXdmxyTb/2jexwzipzZUuLg6m8a3V26xg2
   w==;
X-IronPort-AV: E=Sophos;i="5.93,289,1654585200"; 
   d="scan'208";a="189344639"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Sep 2022 03:36:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sun, 4 Sep 2022 03:36:44 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Sun, 4 Sep 2022 03:36:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9Jbd1KxogQcF8rW0NnEHPigq7wNN3NWzZqXIb6BwuTxWGGDeWvq7Up5aQGz7CUKdO3HmgxCLuv6ujj9wG2YBi2fJw60Y7kyvpn6m2aZGx8N8YUBSNv1UlZugE67AFvcoSSrYPD0k92z/Kn0lQI0Hi+obXY3ODNA9Oi/xclC2apDGjn8Q/L5iUFw4QZUjswKoam9neHi6e0ZuUwJ6yA2hwjCjYzDFnUnl9rgA80rFP3tolLDkoWixbwJVOc8l8y+Q1ujTsaJ01h+7BiJZmBwtXZv7iUTY6Nrc34k8I147/+cK2pVtSlCekx7cp6DJ2Nt8JmB+wkyuGnaYGXL2RZNtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAqZuBOvnh018QGCNXfMUC8jNsoDdhGgn/DhLGHSyjc=;
 b=HWCLs0voFlngOxpJ5gGa5lKHtcynlKeUdxeYVu5bJ9aGMLnQrmr/68n11mgJgDzinfbk5qlt8WQgC+0+oQq6b/41fxowvO4vfETpQuxjiKJzC09YzuGSzqy/JvxDSnilAI/KInGVJxA25IEd7MK8dlTdop6/qGtDic4hjnfy1GeAJ36SU+mUgzC5h8u8G1phkWwu4Cacgun0hs7HMVvkY3GYLxizrstEKYrArY2clEJzi5DRexVlOFWLlPBikfkO6MFY0sJB3IISd0+YjkRbAoH3C11jLGzsw1z7dJsHsZFnRkfM2jYAFK4oNJs8pKM2BDU3IqypDiqEpfCBP2G4dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAqZuBOvnh018QGCNXfMUC8jNsoDdhGgn/DhLGHSyjc=;
 b=Hor3HlOPFgsjR9V2lg7tAyuST+XzPjopjXHpYZ82vidKBKw/wEOteApXBAWi6XceKmKLsBVeDFFOqecBnEq06PxlaHTagEEIbADvPmqR5KzteDyucXmE2NulZifAek4WZDK/4uzoVMSBnEQLSXwaXjmEyL+b0+ooJ/AFnpOCxaU=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BL0PR11MB3281.namprd11.prod.outlook.com (2603:10b6:208:66::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Sun, 4 Sep
 2022 10:36:39 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.018; Sun, 4 Sep 2022
 10:36:38 +0000
From:   <Conor.Dooley@microchip.com>
To:     <guoren@kernel.org>, <arnd@arndb.de>, <palmer@rivosinc.com>,
        <tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
        <heiko@sntech.de>, <jszhang@kernel.org>, <lazyparser@gmail.com>,
        <falcon@tinylab.org>, <chenhuacai@kernel.org>,
        <apatel@ventanamicro.com>, <atishp@atishpatra.org>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>
CC:     <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <guoren@linux.alibaba.com>,
        <lkp@intel.com>
Subject: Re: [PATCH V2 5/6] riscv: elf_kexec: Fixup compile warning
Thread-Topic: [PATCH V2 5/6] riscv: elf_kexec: Fixup compile warning
Thread-Index: AQHYwC/gSov6LLzR/EOOdHeAB9nrWa3PFAuA
Date:   Sun, 4 Sep 2022 10:36:37 +0000
Message-ID: <98efc4d8-f846-1ff1-2635-d18b7fca4ac8@microchip.com>
References: <20220904072637.8619-1-guoren@kernel.org>
 <20220904072637.8619-6-guoren@kernel.org>
In-Reply-To: <20220904072637.8619-6-guoren@kernel.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a37aeae-129c-4716-98dc-08da8e6158dd
x-ms-traffictypediagnostic: BL0PR11MB3281:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o0+R2Mqa8gS+9wj7L+INNDQnHRqhVKXs6gnssJHLYL/z6rAa/VKNNxGKl53OOb5ixT+sFdTF52311Dy+m784A4kSYwoDLQKYgjwZcuPmWL19IwzS8YReG9itxSU8ynfFUl15yRFi9v51Zt9AZruAGEIpOw6GiVhHnc1bkVKkdh9EThrPKiaLMA1KfEBhbSSgc0EvdYlaI37IkAWKZ1i1PfEfzUjByrzh49LlJr0zL9h180mx3ENCU6coOSdBwZMkxopr4kIeLf/0V91970UtpU9Nc8IkYOmjCP4FBhSBVxJ/vNG0smjPNPzD/LMkQZEWb6FKaKEF+O8PEwt1Gg1gLsVLP3YQVNHruNjxyQoNfcqCnhISnwfCqkApIVZSS05dELKbx7U9dIj6vRAVOYC3LR6E8w32ptYvP2PPJGctZj8HGtIzgcGEfAy19v+5N2h6pf2BHV7Tk6nbEq9Tw66HdMJ5OYd6ZOF8xukr4quX+H9sSgXQ6lK7QHy3nGGJ7XNG1z15F/lPrCBuJJb0fLU7Q3VjBUTEh18f1IG+n2BE52ZAEZAE3LLm4PiRdD//FRKCwC0b7Ncmc+VMVp1YtiFkH7+JnMJ3+tOb7m+bT7k+aTf/zYC1WaOZjOZwwVyjUOMZy97inlPZ5DHmfNgKo12xCduk3tn0jKWipRqEtI8Q3BgdhedgEv2JxjLxCNdufRuShWf9jFa/K9vLn+JDIZ8P+i0BQUcnwvUdhohAxR50MncM1VB6MLpM1Egil/jk660yJbypIkNjiSjAvc9umylMBjKNxgfGA0zPW7aA4g067Zo39RJLoXm6DWyIu7nN/OD4neF/pv4sQq6wdu6Plla7DLFr1nUyA8uyLsH/9kmcslo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(346002)(366004)(376002)(39850400004)(2616005)(186003)(5660300002)(53546011)(6512007)(6506007)(26005)(38070700005)(31686004)(6486002)(921005)(41300700001)(71200400001)(478600001)(36756003)(83380400001)(38100700002)(31696002)(316002)(86362001)(8936002)(7416002)(54906003)(122000001)(2906002)(64756008)(76116006)(110136005)(66446008)(91956017)(66476007)(8676002)(66556008)(4326008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3RDWTlzMExpckZVbHNLVlFoTDNwVGdOUWdiUzVKdkpaWVpzc25qOE9STldQ?=
 =?utf-8?B?NGhFQythY2FEaUR5cEFFeVlqZi9QdzBMWGlCSFIzckhWeGpVZlkyejlTOEdT?=
 =?utf-8?B?R0VwTTNFaExpdmRlcXluSEJaM1IvOENJWHpxZXp2UnhEMXJGdy9XU0NLV2d3?=
 =?utf-8?B?Ym5QdFVqUjBIcGpISmlCZ091ZGFiUHlmL05sMEQzb2d3MEJQTDh2TE9XTlB0?=
 =?utf-8?B?eHhaNkpUekJDaC9VRVAvbnFiQm0zQmsxWlNhZmpHUDZnVURuNkJDQktFK3ZE?=
 =?utf-8?B?cHdIbzBOcGJ1aU9CZThZQjBOT21vak11aG5BVFFYcWlJU1NvZXRNeXd3OU05?=
 =?utf-8?B?ZHpNNHM2SjNmT3laMW9nTmN1WHJrTjZhMVVCb2hZV0JpUXFDMENrWkQ0YmlR?=
 =?utf-8?B?cGRtYit2VFU0N3dmbFI0ZVV0cWtSQjY2a3J0L3Z0M1NxZlZnYlF0WGhDc1po?=
 =?utf-8?B?Mmg4bDJyeE5FUjJ3Zkw2azJzTXdIbEw1eGxjeHVabG5LcGFPVVF2SG9Qeko2?=
 =?utf-8?B?ZkJ6UkJkS2RJL0w3K2FGNWZtdVR1M0l4Mkw3Uk51bG9jVUlOYnJOUHJUMmVQ?=
 =?utf-8?B?Q3Y3TkdxejRQOFdTYjdYVXg1RFVoMHN5K1kwbFZnRkJJVDM1RWRzWDlVdDlz?=
 =?utf-8?B?a3djbUZqdEtDNkE2MTk0WWlHeVJmaVVHdlBwYlIzYjI0LzJjR3IrQ2RrYVBO?=
 =?utf-8?B?bXNvODlmQUhrd21UQXJEb0w1Q3lvdVpFYzAwZTdqU3ZESDJXcUhNK29qUkFX?=
 =?utf-8?B?TzA1ako5ODNKbXVoYkFVTEVqYnlXeFRycERjVkVpZkN1VVRqODdGMDh2Qkpk?=
 =?utf-8?B?c0Y2QmtCSWdmbUlWVzZucG9DdVJYbXpOeGJLV3JUemJRU20vNitPS1h3Zi8w?=
 =?utf-8?B?cS95eEVhT0JMVkhxZkpqSFVjM2JpTExYL25pWGJ5bU1xSVRuYVlLbUgvTjNa?=
 =?utf-8?B?Wm5DN1JHcjlqZTc3Wk1ZdHVTV3pjTmFVcTFwQ3ZCV21MUjBnb1lycmlMRXNB?=
 =?utf-8?B?S3lPR2E1dFYxZGFRR2FMNWQzNW8rREN2RVh2SUpMbDJXNVJNYXR4RE5CYit4?=
 =?utf-8?B?eFcvc2xhQldwektZcHlXVnlxcHdnOHl6eFIvbmhxUjE4M1h4Q1h2azBlTXlz?=
 =?utf-8?B?RE4zY1RhYzdUSW93WHNvNWFwcjVqcENudTQvQWV6MG94dnFCODd4b1hSTUpi?=
 =?utf-8?B?U2l0RXlNY09wWGVXVVQrMElFanNTUmpVZko1WXlpT3pxL2paSk5YVngvS05M?=
 =?utf-8?B?TFV0MVh5bngvU3ppUzhGN2ZIM3FveFlxK0VwRldEc1dIM1BjbUNKcXVRbnBX?=
 =?utf-8?B?R3FtTGNnNjVLalRMT1MxSUsvOW5zQSs5OUw0VDdxNHZqMWh6WEZJUHdtN2dS?=
 =?utf-8?B?dXpVZk1MU3JhaDhtRXhzUUFOVVhnY0VZcEdPc0hsRGJHV1NCTmY3cVRGeGly?=
 =?utf-8?B?Q2lpbnp3K294Sm5mV3pkK2k2YnliQXlwNmFZRFdsT1VFd0xha1dIdHF2VDl4?=
 =?utf-8?B?RGZMMlV2MGQ4dXJrYTluTklTRlFsRDNGaGxXT1ZsRXFHMHRMUkxxQmRabWFY?=
 =?utf-8?B?UUNHcERNQm1jZ2NrTDJwbXI5aTdwN3VzTkYyaXdEVWNBeEFxVkNOZFFZOFV0?=
 =?utf-8?B?YUoyamV6SS9vUzRIazdtUThVNnFybUZtZ05SbE9KT0RHNGtLREtGR01VcERJ?=
 =?utf-8?B?bTVZdFdWQ2hSZUY2YUpxcUxBM0JyU3VPRUppM1U3OWVLVUJOS3h6a09RWG9Q?=
 =?utf-8?B?cU1BQVlZRnF2Wms2SGRhR01NS2pHb09iNWxpc2NlMXkzMUViVmxNM0p6UmNK?=
 =?utf-8?B?TjZsVnBkbW1kQWFlTHlxZ1loazBDeUZ6NWxZZUtaZTJVTlVFbk4wN25OcmxH?=
 =?utf-8?B?TGl3S1hMR2ErMDFwOTRWaGJXMndDRVVoUDM3VkZsTzlyNlRwMlorYnYyMFEz?=
 =?utf-8?B?V0x0VHZkMU54MlVXcU9YRjdUQW9xT0ZwWTUrdWt3cDJjSWVieEJJMXhyNzFD?=
 =?utf-8?B?Y0xZaVV0aHFQS0NPMmk0R21QMytraTFGZnN5SUVXc0I3eFg4azVXcVlhbUJw?=
 =?utf-8?B?YVJKem4rMjl2eXkrUTM5THF3TmNrZTVLdWJ5d1YvZ1YrdGc3L1lpT2MrQmY1?=
 =?utf-8?Q?2JOAt71aQC3u+AjcOvjCJ/any?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C256C4ABA841CE44BC36A66C279D49D2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a37aeae-129c-4716-98dc-08da8e6158dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2022 10:36:37.9923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sf8nPlyESOZz+MvyxdRrSsOlWLOBG6ki0YDwkWOebwZgoCG+6+DKqSv8ahjhb5uKaSjD9XrhNWBBmOYVP1drfzGiTL/ne05VUY0hRSVasqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3281
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMDQvMDkvMjAyMiAwODoyNiwgZ3VvcmVuQGtlcm5lbC5vcmcgd3JvdGU6DQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gRnJvbTogR3VvIFJlbiA8Z3VvcmVuQGxp
bnV4LmFsaWJhYmEuY29tPg0KPiANCj4gQ09NUElMRVJfSU5TVEFMTF9QQVRIPSRIT01FLzBkYXkg
Q09NUElMRVI9Z2NjLTEyLjEuMCBtYWtlLmNyb3NzIFc9MQ0KPiBPPWJ1aWxkX2RpciBBUkNIPXJp
c2N2IFNIRUxMPS9iaW4vYmFzaCBhcmNoL3Jpc2N2Lw0KPiANCj4gLi4vYXJjaC9yaXNjdi9rZXJu
ZWwvZWxmX2tleGVjLmM6IEluIGZ1bmN0aW9uICdlbGZfa2V4ZWNfbG9hZCc6DQo+IC4uL2FyY2gv
cmlzY3Yva2VybmVsL2VsZl9rZXhlYy5jOjE4NToyMzogd2FybmluZzogdmFyaWFibGUNCj4gJ2tl
cm5lbF9zdGFydCcgc2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0N
Cj4gICAxODUgfCAgICAgICAgIHVuc2lnbmVkIGxvbmcga2VybmVsX3N0YXJ0Ow0KPiAgICAgICB8
ICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEd1byBSZW4gPGd1b3JlbkBsaW51eC5hbGliYWJhLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogR3Vv
IFJlbiA8Z3VvcmVuQGtlcm5lbC5vcmc+DQo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2Jv
dCA8bGtwQGludGVsLmNvbT4NCg0KSXMgdGhpcyB0aGVuIGENCkZpeGVzOiA4MzhiM2UyODQ4OGYg
KCJSSVNDLVY6IExvYWQgcHVyZ2F0b3J5IGluIGtleGVjX2ZpbGUiKQ0KPw0KDQpDb3VsZCB5b3Ug
YWxzbyBhZGQgc29tZXRoaW5nIGxpa2U6DQoiSWYgQ09ORklHX0NSWVRQTyBpcyBub3QgZW5hYmxl
ZCwgLi4uLiIgdG8gZXhwbGFpbiB3aHkgdGhpcw0KbWF5IGJlIHVudXNlZD8NCg0KPiAtLS0NCj4g
IGFyY2gvcmlzY3Yva2VybmVsL2VsZl9rZXhlYy5jIHwgNCArKysrDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9rZXJuZWwv
ZWxmX2tleGVjLmMgYi9hcmNoL3Jpc2N2L2tlcm5lbC9lbGZfa2V4ZWMuYw0KPiBpbmRleCAwY2I5
NDk5MmMxNWIuLmJiYTM3MjNhMDkxNCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9yaXNjdi9rZXJuZWwv
ZWxmX2tleGVjLmMNCj4gKysrIGIvYXJjaC9yaXNjdi9rZXJuZWwvZWxmX2tleGVjLmMNCj4gQEAg
LTE4Miw3ICsxODIsOSBAQCBzdGF0aWMgdm9pZCAqZWxmX2tleGVjX2xvYWQoc3RydWN0IGtpbWFn
ZSAqaW1hZ2UsIGNoYXIgKmtlcm5lbF9idWYsDQo+ICAgICAgICAgdW5zaWduZWQgbG9uZyBuZXdf
a2VybmVsX3BiYXNlID0gMFVMOw0KPiAgICAgICAgIHVuc2lnbmVkIGxvbmcgaW5pdHJkX3BiYXNl
ID0gMFVMOw0KPiAgICAgICAgIHVuc2lnbmVkIGxvbmcgaGVhZGVyc19zejsNCj4gKyNpZmRlZiBD
T05GSUdfQVJDSF9IQVNfS0VYRUNfUFVSR0FUT1JZDQo+ICAgICAgICAgdW5zaWduZWQgbG9uZyBr
ZXJuZWxfc3RhcnQ7DQo+ICsjZW5kaWYgLyogQ09ORklHX0FSQ0hfSEFTX0tFWEVDX1BVUkdBVE9S
WSAqLw0KPiAgICAgICAgIHZvaWQgKmZkdCwgKmhlYWRlcnM7DQo+ICAgICAgICAgc3RydWN0IGVs
ZmhkciBlaGRyOw0KPiAgICAgICAgIHN0cnVjdCBrZXhlY19idWYga2J1ZjsNCj4gQEAgLTE5Nyw3
ICsxOTksOSBAQCBzdGF0aWMgdm9pZCAqZWxmX2tleGVjX2xvYWQoc3RydWN0IGtpbWFnZSAqaW1h
Z2UsIGNoYXIgKmtlcm5lbF9idWYsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJm9s
ZF9rZXJuZWxfcGJhc2UsICZuZXdfa2VybmVsX3BiYXNlKTsNCj4gICAgICAgICBpZiAocmV0KQ0K
PiAgICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+ICsjaWZkZWYgQ09ORklHX0FSQ0hfSEFTX0tF
WEVDX1BVUkdBVE9SWQ0KPiAgICAgICAgIGtlcm5lbF9zdGFydCA9IGltYWdlLT5zdGFydDsNCj4g
KyNlbmRpZiAvKiBDT05GSUdfQVJDSF9IQVNfS0VYRUNfUFVSR0FUT1JZICovDQoNCkluc3RlYWQg
b2YgYWRkaW5nIG1vcmUgI2lmZGVmcyB0byB0aGUgZmlsZSwgY291bGQgd2UgaW5zdGVhZCBqdXN0
IGRyb3AgdGhlDQprZXJuZWxfc3RhcnQgdmFyaWFibGU/IEZvciB0aGUgc2FrZSBvZiBjb21waWxh
dGlvbiBjb3ZlcmFnZSwgd2UgY291bGQgdGhlbg0KYWxzbyBkbyB0aGUgZm9sbG93aW5nIChidWls
ZC10ZXN0ZWQgb25seSk6DQoNCi0tID44IC0tDQpGcm9tOiBDb25vciBEb29sZXkgPGNvbm9yLmRv
b2xleUBtaWNyb2NoaXAuY29tPg0KRGF0ZTogU3VuLCA0IFNlcCAyMDIyIDExOjI3OjA3ICswMTAw
DQpTdWJqZWN0OiBbUEFUQ0hdIHJpc2N2OiBlbGZfa2V4ZWM6IHJlcGxhY2UgaWZkZWYgd2l0aCBJ
U19FTkFCTEVEKCkNCg0KSVNfRU5BQkxFRCgpIGdpdmVzIGJldHRlciBjb21waWxlIHRpbWUgY292
ZXJhZ2UgdGhhbiAjaWZkZWYuDQpSZXBsYWNlIHRoZSBpZmRlZiBDT05GSUdfQVJDSF9IQVNfS0VY
RUNfUFVSR0FUT1JZIGluIGVsZl9rZXhlY19sb2FkKCkNCnNpbmNlIG5vbmUgb2YgdGhlIGNvZGUg
aXQgZ3VhcmRzIHVzZXMgYSBzeW1ib2wgdGhhdCdzIG1pc3NpbmcgaWYgaXQNCmlzIG5vdCBzZXQu
DQoNClNpZ25lZC1vZmYtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5j
b20+DQotLS0NCiBhcmNoL3Jpc2N2L2tlcm5lbC9lbGZfa2V4ZWMuYyB8IDI4ICsrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMTQg
ZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2tlcm5lbC9lbGZfa2V4ZWMu
YyBiL2FyY2gvcmlzY3Yva2VybmVsL2VsZl9rZXhlYy5jDQppbmRleCAwY2I5NDk5MmMxNWIuLjI5
Y2JmNjU1YzQ3NCAxMDA2NDQNCi0tLSBhL2FyY2gvcmlzY3Yva2VybmVsL2VsZl9rZXhlYy5jDQor
KysgYi9hcmNoL3Jpc2N2L2tlcm5lbC9lbGZfa2V4ZWMuYw0KQEAgLTI0OCwyMSArMjQ4LDIxIEBA
IHN0YXRpYyB2b2lkICplbGZfa2V4ZWNfbG9hZChzdHJ1Y3Qga2ltYWdlICppbWFnZSwgY2hhciAq
a2VybmVsX2J1ZiwNCiAJCWNtZGxpbmUgPSBtb2RpZmllZF9jbWRsaW5lOw0KIAl9DQogDQotI2lm
ZGVmIENPTkZJR19BUkNIX0hBU19LRVhFQ19QVVJHQVRPUlkNCi0JLyogQWRkIHB1cmdhdG9yeSB0
byB0aGUgaW1hZ2UgKi8NCi0Ja2J1Zi50b3BfZG93biA9IHRydWU7DQotCWtidWYubWVtID0gS0VY
RUNfQlVGX01FTV9VTktOT1dOOw0KLQlyZXQgPSBrZXhlY19sb2FkX3B1cmdhdG9yeShpbWFnZSwg
JmtidWYpOw0KLQlpZiAocmV0KSB7DQotCQlwcl9lcnIoIkVycm9yIGxvYWRpbmcgcHVyZ2F0b3J5
IHJldD0lZFxuIiwgcmV0KTsNCi0JCWdvdG8gb3V0Ow0KKwlpZiAoSVNfRU5BQkxFRChDT05GSUdf
QVJDSF9IQVNfS0VYRUNfUFVSR0FUT1JZKSkgew0KKwkJLyogQWRkIHB1cmdhdG9yeSB0byB0aGUg
aW1hZ2UgKi8NCisJCWtidWYudG9wX2Rvd24gPSB0cnVlOw0KKwkJa2J1Zi5tZW0gPSBLRVhFQ19C
VUZfTUVNX1VOS05PV047DQorCQlyZXQgPSBrZXhlY19sb2FkX3B1cmdhdG9yeShpbWFnZSwgJmti
dWYpOw0KKwkJaWYgKHJldCkgew0KKwkJCXByX2VycigiRXJyb3IgbG9hZGluZyBwdXJnYXRvcnkg
cmV0PSVkXG4iLCByZXQpOw0KKwkJCWdvdG8gb3V0Ow0KKwkJfQ0KKwkJcmV0ID0ga2V4ZWNfcHVy
Z2F0b3J5X2dldF9zZXRfc3ltYm9sKGltYWdlLCAicmlzY3Zfa2VybmVsX2VudHJ5IiwNCisJCQkJ
CQkgICAgICZrZXJuZWxfc3RhcnQsDQorCQkJCQkJICAgICBzaXplb2Yoa2VybmVsX3N0YXJ0KSwg
MCk7DQorCQlpZiAocmV0KQ0KKwkJCXByX2VycigiRXJyb3IgdXBkYXRlIHB1cmdhdG9yeSByZXQ9
JWRcbiIsIHJldCk7DQogCX0NCi0JcmV0ID0ga2V4ZWNfcHVyZ2F0b3J5X2dldF9zZXRfc3ltYm9s
KGltYWdlLCAicmlzY3Zfa2VybmVsX2VudHJ5IiwNCi0JCQkJCSAgICAgJmtlcm5lbF9zdGFydCwN
Ci0JCQkJCSAgICAgc2l6ZW9mKGtlcm5lbF9zdGFydCksIDApOw0KLQlpZiAocmV0KQ0KLQkJcHJf
ZXJyKCJFcnJvciB1cGRhdGUgcHVyZ2F0b3J5IHJldD0lZFxuIiwgcmV0KTsNCi0jZW5kaWYgLyog
Q09ORklHX0FSQ0hfSEFTX0tFWEVDX1BVUkdBVE9SWSAqLw0KIA0KIAkvKiBBZGQgdGhlIGluaXRy
ZCB0byB0aGUgaW1hZ2UgKi8NCiAJaWYgKGluaXRyZCAhPSBOVUxMKSB7DQotLSANCjIuMzcuMQ0K
DQo=
