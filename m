Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92E07DC928
	for <lists+linux-arch@lfdr.de>; Tue, 31 Oct 2023 10:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjJaJL0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Oct 2023 05:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjJaJLZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Oct 2023 05:11:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC16BB3;
        Tue, 31 Oct 2023 02:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698743478; x=1730279478;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qH/VlD/DSdJS9HVNOVdVm3l3tve3grgqnWLF0d+FETc=;
  b=BPQ2AJf1CeZcKOvAtWJtUg199Xcx+UhJTbDmXoWzLszDx5rHTyK6DAwh
   WIi4pf7QQJNstniUTwyqQsR04KXbLXTdq/SZot/8zK5ct8FYF+HkM63mD
   3qV0EV5xrnbyLBgjIWruQmKCdkVfXw+ItV5wMkjh2LgSfN4IrZs8jGKJy
   2uu82s6y8d6SHqN4OgUb+rkEopps5Ct5d1+onM6+woRse72yBws91rLpU
   /UiICQZA7T/40cLyX8mjx/2e/8otoZaAJRpc878HhcdYxooGTYAhLPaYi
   lBS45b2n7idpJyw/icjL7WGUI1/OzkaH1SbPV4bNbjIxinC/kXI2l3Aog
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="385434410"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="385434410"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 02:11:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="1733261"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2023 02:11:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 02:11:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 02:11:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 02:11:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iT6CN/pjgfsoVUa24Q/DpKst1QWZj0tpWgU8oW1sbNNLQtmdJWCU9OfpE9+PWaFmWwMwTtGjqd7Y3LfRN1MeBev6+3H+2QWIH+tK1C3CfBQKtX57EWS6RwCjejNaxQkyZGO681GHsrq2QMBffTUSSkE16J5nHM7+jDYd3nuc3pqjEI3hc+I5Iz2nizaAnTjUyyEsddMP7LEuTYT/n/K9Hl6N70wou2kSy9fagsqjt5xjI3QJS1mc/UVaRZrjJrGxmSHPSKrxlTreLBsm0shZsPxTeRypOOouqG7fpMCaCxQYECR+SREf438KB+XZ91ZwbunX4fxufB1TVOs1WX1Y7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qH/VlD/DSdJS9HVNOVdVm3l3tve3grgqnWLF0d+FETc=;
 b=IR/Nti69IwiIrVq4bl9AY4Itza/i2QPK53vlwLrq+fknnhxpoZj9NdvbPe0wWNvw1xJ/RcBlkXaQUEt5DT9I7gsMfX5XPrzfFND075JByGyBCwvQEhTEDATPXJz4pPjlClX8f5gedc1kwV3shseqf8O7NAO5/9+aqp+5l3vsRi0Xjcav2DbG3OrLIHo9YiUFCkSbVSY4V/NZRJhSBzVGPYSO5QFgAxvQehPR5rjAZQddSFr1OGBP9v0B1+q1PW2Sybz6D/9BHIQIu8QbRheoPfugSN3INxnw3RfzIdMcO1phZcZvZTyRKL01irAO3EcEWS1Hytdjl9kQK3wu3ImpJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 IA1PR11MB6393.namprd11.prod.outlook.com (2603:10b6:208:3ae::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Tue, 31 Oct 2023 09:11:08 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::d070:1879:5b04:5f57]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::d070:1879:5b04:5f57%4]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 09:11:08 +0000
From:   "Wang, Xiao W" <xiao.w.wang@intel.com>
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        "Evan Green" <evan@rivosinc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: RE: [PATCH v8 3/5] riscv: Checksum header
Thread-Topic: [PATCH v8 3/5] riscv: Checksum header
Thread-Index: AQHaCScbyez8kuVx206/Fnj5ZW42L7BjnJTw
Date:   Tue, 31 Oct 2023 09:11:07 +0000
Message-ID: <DM8PR11MB5751FE93CB74EDE4A2F4876BB8A0A@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20231027-optimize_checksum-v8-0-feb7101d128d@rivosinc.com>
 <20231027-optimize_checksum-v8-3-feb7101d128d@rivosinc.com>
In-Reply-To: <20231027-optimize_checksum-v8-3-feb7101d128d@rivosinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|IA1PR11MB6393:EE_
x-ms-office365-filtering-correlation-id: c24274de-f7ea-4b1f-44e3-08dbd9f1517c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jHUj02YIDEyziarBNKjd3E2uXgievqVwhaiBKAhnihCE0nQy8EOTYFGFZ450v1RypYL/XaEmuOfQRhhbHX+nPmC+HZbgy4LZmMEYN9qqG5e3OQJuRXGSw3bOhJrgZJ33cXt6NGBoMVpvj/qeazMPbFvqoTT5zY9VJ8UCpbAPpAAj9Ueb01F2g9eZQ/e/xpuDycKpJPf0FhvRJ3Lkr9ggGALt/9ZWpkwgSOUf7ngWDZaPADVmmd5o87908uGiGZRYxmO+lxpdLT1REPn2yMg4c0vy9L6NCfD+eN2SIztfEiAzGvn+kACd2Q/MLnyOSTvopDUCUbt1g04xqP1WpWxoBv0bhiBJRDap9co1+6gOjQDRSoT3aLFpoY1PId9P0vSCVdhy1MBow3lYC+7WzwXYPOmpTh0coS3EysfFpMvQy34jjqkENTSrITSCblFPtR9Ab+NJLz4Odok8WIbS0dDfSfJsxFJDLEKKZw7pTQCJIlp1Bm6TrLhjnl5IhyfMVsKhsN8fA5f0xTDxAsIL+gW8Wj4+Sy2WC4hwhsYkMeM8t15/82ksJZxlgQqDZ541zWNZZ3qy4x7Ff3mGm1j09MY/3fHHHxEXuiX9WYNczE2uvqaH78KQpknQLpabVReHR49/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(26005)(38070700009)(38100700002)(55016003)(52536014)(2906002)(41300700001)(76116006)(64756008)(5660300002)(8676002)(86362001)(33656002)(8936002)(4326008)(7416002)(478600001)(66446008)(53546011)(110136005)(82960400001)(7696005)(71200400001)(122000001)(6506007)(316002)(66946007)(66556008)(54906003)(66476007)(83380400001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmsrMTFhQ3dGSGF3ZHVwOGlqOE41U2wvcVhYSlliRlRpNVNnN2wxR3czMzRF?=
 =?utf-8?B?TnZvd0tBSW1OTnRPQjRvZkJ2aWJudklqbXZoc215NXNNY2ZVSHFXd3U2RG5S?=
 =?utf-8?B?UU5TY3VzdGxDQ2VjQWFGUFJwL1Y0VGFaeTJPc0NWMWZUNURETG9TZVBJR2Jh?=
 =?utf-8?B?RkFIeHJCZTBFbWxDdzdLandIRUw0aURaekFOQzZKbmhYYU1vRUo4MGMrSXkv?=
 =?utf-8?B?T0VMNnJwRnc3Q3pOdW4xclE5Q2ovYnptdXpMRi9pY3FkcGcrQjg5Wm1RL1ll?=
 =?utf-8?B?T3pGeTgwTU9GZ3pyZHVUNVBKaGZNa1BQOEdEdkZZRnJZN3R6SnZLa1hXNEJD?=
 =?utf-8?B?K1pPSTZIb2pDcVV6d2hlKzJsQ0NLdGRsbWtrS0h6a1Y1bUYrdTBsRVhFUzNF?=
 =?utf-8?B?VUtiZVFWVHZQL01Pd3BrQmVxTmpvcm5COWw2ZWY4YTVKdGo2L0RDak01TFg1?=
 =?utf-8?B?TmVLRHZmU21MR0FsNW51azR5Sk52UnFOZGlYRlBhenl1MzVXQmNZT2RlVnA2?=
 =?utf-8?B?eG1vRzBnTkk4NTVYRzNrLzFkeWNtY2hBSURZNWd4RDRFMnBOZ2NRaXRvcmVI?=
 =?utf-8?B?Q0hZZHBUblI1R0Vucmt6ZHFxRW5QUHhONlBIYk1TbXQwY0FuaTdlZStoOVN5?=
 =?utf-8?B?b2RpUUIzd2crVUt0b2tYR1NZYUxOblA5R0lIcm9XdWw1T0Y4eWo3QytxM0Ny?=
 =?utf-8?B?SnVCMFFmeFp3NDBkdFRUOVRCcHYxMUN6emJTU3J5RCtYNDNhUGs5UmUyS0tK?=
 =?utf-8?B?dkNYSVliY0Y3NEV1VUMvVjdINWtyNWhjQWFpQkZSdFpIamd4K2E5VktEVzVz?=
 =?utf-8?B?SUJXU1BFT0NJejZzUk1nbWNIQ0ttRFcvUWJnWU5vNXFwbmIwYVhmQ01QR2Ur?=
 =?utf-8?B?RUp5eHRkTFp3Q0M2S3JwaGdSQ0RvL2xjbHhQVnBJNnpxNVFjaHkrQTdRVkJs?=
 =?utf-8?B?RGFLb1JlRlNIY0NJWUxkbmd2N3Axb2QvWGR0VHJKbURRaFpYYjlDcWp4Z3dP?=
 =?utf-8?B?UTlCcWZNclVqMS8zNXV3TTl2NTU5MzE5aWVwUUQ4T0lvckRYK3hHb0NoeFZo?=
 =?utf-8?B?NTdiWlVzVDJCcE9WY2tNaGJtcndMa0xBeHZJZUpYRno1Q3NWN01QTWlFZHR3?=
 =?utf-8?B?MHllTDRmQjEzZWtUNDk5VXovWm5hcFIvWnZDTTMyOXNYODNyd2JNeFEwNnp5?=
 =?utf-8?B?ZGc5ZjlWNTQwRzIxVzNPblBua0M1aEtWMXk3RkRUbW1ZUEwwTnN5RDA0bXJt?=
 =?utf-8?B?WThVdk01czlHZjJTU2V2T1djdXFycXRkUmMrMTUyM1NHSkw1ZW12M2U1eDB2?=
 =?utf-8?B?VnE2cUZUZFdvSkRJMUJoKzVyTXFGM2xvdnJTM3FRd3dNT2pkNkRSeC9KSXhZ?=
 =?utf-8?B?eGZ3UERzZlBQWlJCeUtXa2R3d3pmS25FQjU5bkR6NHJEeEo2M3YrNjVZMjFB?=
 =?utf-8?B?VUJXWXRoM3NBczZ0Q0lMMnU0QkdkZmdrdmlpUHlGak1wdEk3VmMwdEJiZ1Mv?=
 =?utf-8?B?Y1prOWwrRDU1bi9jazlJb0Y2b3VvWVYwZFlMckc3VTYwK1VqaGxkUmI2TE1o?=
 =?utf-8?B?a3grQk9Cd1lpb083ODhING5KZWdEMWFuaWZSTjZhYklZaHcyQ2JkNUwySWgy?=
 =?utf-8?B?clhwNUkrdGxzWTl2UmE4ZE1SU1lWUEJNYVpxeU15N2RjdFdCeHVWSHVnOHdI?=
 =?utf-8?B?OWU5N0NGdGNudTRxbXJ2Rnk1TnJUMzdmaGRkdURURmRoaVV4dDJkVmlxeXk1?=
 =?utf-8?B?a2REeEhTcXBYd0hIRWhsODFmaEtmdFJzcXhxUXJvUitkZ2hCd0hUNlB6ZVdm?=
 =?utf-8?B?OGphdW84N0FsaU80bHlQaTVvVUQ4SDloblFyallPU29kMjBFeDlpdlZlT3p5?=
 =?utf-8?B?b1hvdHpLSVRINENwdC9rSHZmWUZQTW1jbWFQR25WUzNyTVNEaXlvMHNzTVlL?=
 =?utf-8?B?UW1GVllSZzZLWUt4TG9QZUJpOThmd0p2QlZvKzFYU1BPTWxyR3IrQ05CU3BR?=
 =?utf-8?B?S2gvekUyMmhTK2dvZDJ4dU9wcHg0RzA1cHREK0c4R2l6dnVyVEV1QVRyVVd6?=
 =?utf-8?B?NjR1eWJkcEJUU1NzS2NGckdCY1lFYzFjRUZLMGJJWi93UDZXMTVIb2Vnb0gv?=
 =?utf-8?Q?mk3BGOdk2QezFI06QLPRuXMtv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24274de-f7ea-4b1f-44e3-08dbd9f1517c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 09:11:07.9927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q8e0s1zUxvtjSf6EHmV8VOpShzWrk2wp4SiJCtB2xCzQrLKV6RPSxuEZp2luCEYuftheywMVt7eD2tD/yE0myA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6393
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hhcmxpZSBKZW5raW5z
IDxjaGFybGllQHJpdm9zaW5jLmNvbT4NCj4gU2VudDogU2F0dXJkYXksIE9jdG9iZXIgMjgsIDIw
MjMgNjo0NCBBTQ0KPiBUbzogQ2hhcmxpZSBKZW5raW5zIDxjaGFybGllQHJpdm9zaW5jLmNvbT47
IFBhbG1lciBEYWJiZWx0DQo+IDxwYWxtZXJAZGFiYmVsdC5jb20+OyBDb25vciBEb29sZXkgPGNv
bm9yQGtlcm5lbC5vcmc+OyBTYW11ZWwgSG9sbGFuZA0KPiA8c2FtdWVsLmhvbGxhbmRAc2lmaXZl
LmNvbT47IERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0QGFjdWxhYi5jb20+Ow0KPiBXYW5nLCBY
aWFvIFcgPHhpYW8udy53YW5nQGludGVsLmNvbT47IEV2YW4gR3JlZW4gPGV2YW5Acml2b3NpbmMu
Y29tPjsNCj4gbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGFyY2hAdmdlci5rZXJuZWwub3JnDQo+IENjOiBQYXVs
IFdhbG1zbGV5IDxwYXVsLndhbG1zbGV5QHNpZml2ZS5jb20+OyBBbGJlcnQgT3UNCj4gPGFvdUBl
ZWNzLmJlcmtlbGV5LmVkdT47IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+OyBDb25vciBE
b29sZXkNCj4gPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0gg
djggMy81XSByaXNjdjogQ2hlY2tzdW0gaGVhZGVyDQo+IA0KPiBQcm92aWRlIGNoZWNrc3VtIGFs
Z29yaXRobXMgdGhhdCBoYXZlIGJlZW4gZGVzaWduZWQgdG8gbGV2ZXJhZ2UgcmlzY3YNCj4gaW5z
dHJ1Y3Rpb25zIHN1Y2ggYXMgcm90YXRlLiBJbiA2NC1iaXQsIGNhbiB0YWtlIGFkdmFudGFnZSBv
ZiB0aGUgbGFyZ2VyDQo+IHJlZ2lzdGVyIHRvIGF2b2lkIHNvbWUgb3ZlcmZsb3cgY2hlY2tpbmcu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaGFybGllIEplbmtpbnMgPGNoYXJsaWVAcml2b3NpbmMu
Y29tPg0KPiBBY2tlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNv
bT4NCj4gLS0tDQo+ICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2NoZWNrc3VtLmggfCA5Mg0KPiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA5MiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9pbmNsdWRl
L2FzbS9jaGVja3N1bS5oDQo+IGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9jaGVja3N1bS5oDQo+
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uOWZkNGIxYjgwNjQx
DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9jaGVja3N1
bS5oDQo+IEBAIC0wLDAgKzEsOTIgQEANCj4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wICovDQo+ICsvKg0KPiArICogSVAgY2hlY2tzdW0gcm91dGluZXMNCg0KVGhlIGNoZWNr
c3VtIGhlbHBlcnMnIHVzYWdlIG1heSBub3QgYmUgbGltaXRlZCB0byBJUCBwcm90b2NvbC4NCg0K
PiArICoNCj4gKyAqIENvcHlyaWdodCAoQykgMjAyMyBSaXZvcyBJbmMuDQo+ICsgKi8NCj4gKyNp
Zm5kZWYgX19BU01fUklTQ1ZfQ0hFQ0tTVU1fSA0KPiArI2RlZmluZSBfX0FTTV9SSVNDVl9DSEVD
S1NVTV9IDQo+ICsNCj4gKyNpbmNsdWRlIDxsaW51eC9pbjYuaD4NCj4gKyNpbmNsdWRlIDxsaW51
eC91YWNjZXNzLmg+DQo+ICsNCj4gKyNkZWZpbmUgaXBfZmFzdF9jc3VtIGlwX2Zhc3RfY3N1bQ0K
PiArDQo+ICtleHRlcm4gdW5zaWduZWQgaW50IGRvX2NzdW0oY29uc3QgdW5zaWduZWQgY2hhciAq
YnVmZiwgaW50IGxlbik7DQo+ICsjZGVmaW5lIGRvX2NzdW0gZG9fY3N1bQ0KPiArDQo+ICsvKiBE
ZWZhdWx0IHZlcnNpb24gaXMgc3VmZmljaWVudCBmb3IgMzIgYml0ICovDQo+ICsjaWZkZWYgQ09O
RklHXzY0QklUDQo+ICsjZGVmaW5lIF9IQVZFX0FSQ0hfSVBWNl9DU1VNDQo+ICtfX3N1bTE2IGNz
dW1faXB2Nl9tYWdpYyhjb25zdCBzdHJ1Y3QgaW42X2FkZHIgKnNhZGRyLA0KPiArCQkJY29uc3Qg
c3RydWN0IGluNl9hZGRyICpkYWRkciwNCj4gKwkJCV9fdTMyIGxlbiwgX191OCBwcm90bywgX193
c3VtIHN1bSk7DQo+ICsjZW5kaWYNCg0KVGhlIGRvX2NzdW0gYW5kIGNzdW1faXB2Nl9tYWdpYyBo
ZWxwZXJzIGFyZSBpbXBsZW1lbnRlZCBpbiBwYXRjaCA0LzUsIHNvIHRoZQ0KZGVjbGFyYXRpb25z
IHNob3VsZCBiZSBtb3ZlZCB0aGVyZS4gT3RoZXJ3aXNlLCBidWlsZCB3b3VsZCBmYWlsIGF0IHRo
aXMgcGF0Y2guDQoNCj4gKw0KPiArLyogRGVmaW5lIHJpc2N2IHZlcnNpb25zIG9mIGZ1bmN0aW9u
cyBiZWZvcmUgaW1wb3J0aW5nIGFzbS0NCj4gZ2VuZXJpYy9jaGVja3N1bS5oICovDQo+ICsjaW5j
bHVkZSA8YXNtLWdlbmVyaWMvY2hlY2tzdW0uaD4NCj4gKw0KPiArLyoNCj4gKyAqIFF1aWNrbHkg
Y29tcHV0ZSBhbiBJUCBjaGVja3N1bSB3aXRoIHRoZSBhc3N1bXB0aW9uIHRoYXQgSVB2NCBoZWFk
ZXJzDQo+IHdpbGwNCj4gKyAqIGFsd2F5cyBiZSBpbiBtdWx0aXBsZXMgb2YgMzItYml0cywgYW5k
IGhhdmUgYW4gaWhsIG9mIGF0IGxlYXN0IDUuDQo+ICsgKiBAaWhsIGlzIHRoZSBudW1iZXIgb2Yg
MzIgYml0IHNlZ21lbnRzIGFuZCBtdXN0IGJlIGdyZWF0ZXIgdGhhbiBvciBlcXVhbA0KPiB0byA1
Lg0KPiArICogQGlwaCBpcyBhc3N1bWVkIHRvIGJlIHdvcmQgYWxpZ25lZCBnaXZlbiB0aGF0IE5F
VF9JUF9BTElHTiBpcyBzZXQgdG8gMiBvbg0KPiArICoJcmlzY3YsIGRlZmluaW5nIElQIGhlYWRl
cnMgdG8gYmUgYWxpZ25lZC4NCj4gKyAqLw0KPiArc3RhdGljIGlubGluZSBfX3N1bTE2IGlwX2Zh
c3RfY3N1bShjb25zdCB2b2lkICppcGgsIHVuc2lnbmVkIGludCBpaGwpDQo+ICt7DQo+ICsJdW5z
aWduZWQgbG9uZyBjc3VtID0gMDsNCj4gKwlpbnQgcG9zID0gMDsNCj4gKw0KPiArCWRvIHsNCj4g
KwkJY3N1bSArPSAoKGNvbnN0IHVuc2lnbmVkIGludCAqKWlwaClbcG9zXTsNCj4gKwkJaWYgKElT
X0VOQUJMRUQoQ09ORklHXzMyQklUKSkNCj4gKwkJCWNzdW0gKz0gY3N1bSA8ICgoY29uc3QgdW5z
aWduZWQgaW50ICopaXBoKVtwb3NdOw0KPiArCX0gd2hpbGUgKCsrcG9zIDwgaWhsKTsNCj4gKw0K
PiArCS8qDQo+ICsJICogWkJCIG9ubHkgc2F2ZXMgdGhyZWUgaW5zdHJ1Y3Rpb25zIG9uIDMyLWJp
dCBhbmQgZml2ZSBvbiA2NC1iaXQgc28gbm90DQo+ICsJICogd29ydGggY2hlY2tpbmcgaWYgc3Vw
cG9ydGVkIHdpdGhvdXQgQWx0ZXJuYXRpdmVzLg0KPiArCSAqLw0KPiArCWlmIChJU19FTkFCTEVE
KENPTkZJR19SSVNDVl9JU0FfWkJCKSAmJg0KPiArCSAgICBJU19FTkFCTEVEKENPTkZJR19SSVND
Vl9BTFRFUk5BVElWRSkpIHsNCj4gKwkJdW5zaWduZWQgbG9uZyBmb2xkX3RlbXA7DQo+ICsNCj4g
KwkJYXNtX3ZvbGF0aWxlX2dvdG8oQUxURVJOQVRJVkUoImogJWxbbm9femJiXSIsICJub3AiLCAw
LA0KPiArCQkJCQkgICAgICBSSVNDVl9JU0FfRVhUX1pCQiwgMSkNCj4gKwkJICAgIDoNCj4gKwkJ
ICAgIDoNCj4gKwkJICAgIDoNCj4gKwkJICAgIDogbm9femJiKTsNCj4gKw0KPiArCQlpZiAoSVNf
RU5BQkxFRChDT05GSUdfMzJCSVQpKSB7DQo+ICsJCQlhc20oIi5vcHRpb24gcHVzaAkJCQlcblwN
Cj4gKwkJCS5vcHRpb24gYXJjaCwremJiCQkJCVxuXA0KPiArCQkJCW5vdAklW2ZvbGRfdGVtcF0s
ICVbY3N1bV0NCj4gCVxuXA0KPiArCQkJCXJvcmkJJVtjc3VtXSwgJVtjc3VtXSwgMTYJCVxuXA0K
PiArCQkJCXN1YgklW2NzdW1dLCAlW2ZvbGRfdGVtcF0sICVbY3N1bV0NCj4gCVxuXA0KPiArCQkJ
Lm9wdGlvbiBwb3AiDQo+ICsJCQk6IFtjc3VtXSAiK3IiIChjc3VtKSwgW2ZvbGRfdGVtcF0gIj0m
ciIgKGZvbGRfdGVtcCkpOw0KPiArCQl9IGVsc2Ugew0KPiArCQkJYXNtKCIub3B0aW9uIHB1c2gJ
CQkJXG5cDQo+ICsJCQkub3B0aW9uIGFyY2gsK3piYgkJCQlcblwNCj4gKwkJCQlyb3JpCSVbZm9s
ZF90ZW1wXSwgJVtjc3VtXSwgMzIJXG5cDQo+ICsJCQkJYWRkCSVbY3N1bV0sICVbZm9sZF90ZW1w
XSwgJVtjc3VtXQ0KPiAJXG5cDQo+ICsJCQkJc3JsaQklW2NzdW1dLCAlW2NzdW1dLCAzMgkJXG5c
DQo+ICsJCQkJbm90CSVbZm9sZF90ZW1wXSwgJVtjc3VtXQ0KPiAJXG5cDQo+ICsJCQkJcm9yaXcJ
JVtjc3VtXSwgJVtjc3VtXSwgMTYJCVxuXA0KPiArCQkJCXN1YncJJVtjc3VtXSwgJVtmb2xkX3Rl
bXBdLCAlW2NzdW1dDQo+IAlcblwNCj4gKwkJCS5vcHRpb24gcG9wIg0KPiArCQkJOiBbY3N1bV0g
IityIiAoY3N1bSksIFtmb2xkX3RlbXBdICI9JnIiIChmb2xkX3RlbXApKTsNCj4gKwkJfQ0KPiAr
CQlyZXR1cm4gY3N1bSA+PiAxNjsNCj4gKwl9DQo+ICtub196YmI6DQo+ICsjaWZuZGVmIENPTkZJ
R18zMkJJVA0KPiArCWNzdW0gKz0gKGNzdW0gPj4gMzIpIHwgKGNzdW0gPDwgMzIpOw0KDQpKdXN0
IGxpa2UgdGhlIG5leHQgcGF0Y2ggZG9lcywgd2UgY2FuIGNhbGwgcm9yNjQoY3N1bSwgMzIpLg0K
DQpCUnMsDQpYaWFvDQoNCj4gKwljc3VtID4+PSAzMjsNCj4gKyNlbmRpZg0KPiArCXJldHVybiBj
c3VtX2ZvbGQoKF9fZm9yY2UgX193c3VtKWNzdW0pOw0KPiArfQ0KPiArDQo+ICsjZW5kaWYgLyog
X19BU01fUklTQ1ZfQ0hFQ0tTVU1fSCAqLw0KPiANCj4gLS0NCj4gMi40Mi4wDQoNCg==
