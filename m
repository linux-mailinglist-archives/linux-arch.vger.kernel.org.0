Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B004737836
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jun 2023 02:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjFUA2Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jun 2023 20:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFUA2X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jun 2023 20:28:23 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020016.outbound.protection.outlook.com [52.101.56.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08976173B;
        Tue, 20 Jun 2023 17:28:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKHpkEHep67GcCEJ9AMOK4gL9L5Ll7LadgbciW2Rxqm6sbZVCsiOXQlkk5/EP04Nre3HC/pRx0BMm+uD2SA0zylrM+RplpW1xQEoZFycbWI2uSJt5OhfQOCnadOGCPwnnIts6ImXTWetvYLkkvNea1AO4CQ3ujC2TUSuJRWIkGNAlEeqye7EMm7OqKaPjU0QDfy+Z3V3BhvSwEKmUaHdvu2x8Ljva6oKjIOnAyNdFFs3Fj7dSMNMgc35xTYhQX9yJ8yzVo38WPrThcUmmOzsC8UQGfV3+uH7TaHojDQNxsdgDSqIgxOzSnN1QblG7QN1xNjlzMlhcM4D+5X97yKFpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZUtZc/ujcFyypKrZ1MtydV+nVn4CYINQrcmQeUqfGU=;
 b=TqOKxDzAdnSx1mmwmHhL1E2HjkMWbwDwf69n5flJaGMob1r49fvmuoPfmQi4ZigATLY3PveyGbhQAeFaqxJhIOFw+nYwg8YZWNlUE9rhEjPMBf9okBu2ZbJdhfdFXUqir5ETxD+PcT5XugakEGmOBnABsouPMdBkRhvLKcqrinPZcNyUOUk1O5yMwZKMIH8uOxVf4PfhrrfrzBz/lN5OU7BeGCRfj2MPh6Sc+8yg5f5w2jFhGc5AEUi8kAJpdc0obA1CAdAbQKN0EIOFOvNeHd0lSEjzbPJoJnUF0EDfpbsXL4AGSKH80uIg7eqxr6SVZ5qjUTZvz3XFLaKOUAC6KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZUtZc/ujcFyypKrZ1MtydV+nVn4CYINQrcmQeUqfGU=;
 b=JpE88ivyfN26Aa7YmR7WCtutxocXlzdSKP/n9jsSd4Lxnsf9ZqryK4clgKEcp0EIXvVhwMC6fIaNazhVl16O1k2i7x7LkCEgMlAyH9E/Hcqh2Dpv84wLjwYHRdbtHujoMNO5f2znkHjRM0c50S8o7uzjnr03OW/+LQhzFAD7CAA=
Received: from CO1PR21MB1332.namprd21.prod.outlook.com (2603:10b6:303:153::24)
 by MN0PR21MB3607.namprd21.prod.outlook.com (2603:10b6:208:3d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.16; Wed, 21 Jun
 2023 00:28:17 +0000
Received: from CO1PR21MB1332.namprd21.prod.outlook.com
 ([fe80::fc5e:819c:e6b2:2a6b]) by CO1PR21MB1332.namprd21.prod.outlook.com
 ([fe80::fc5e:819c:e6b2:2a6b%6]) with mapi id 15.20.6544.008; Wed, 21 Jun 2023
 00:28:17 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>
Subject: RE: [PATCH v8 1/2] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Thread-Topic: [PATCH v8 1/2] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Thread-Index: AQHZo8+1zbqfjiZtTU+wNQsPRxDHk6+UY/3A
Date:   Wed, 21 Jun 2023 00:28:17 +0000
Message-ID: <CO1PR21MB133257BE30F61447E12F83ABBF5DA@CO1PR21MB1332.namprd21.prod.outlook.com>
References: <20230620154830.25442-1-decui@microsoft.com>
 <20230620154830.25442-2-decui@microsoft.com>
 <90ff7c36-9b2e-c791-dc26-3644b9ff20df@intel.com>
In-Reply-To: <90ff7c36-9b2e-c791-dc26-3644b9ff20df@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cf416bd2-0d17-47e6-b28c-a69ff52e9f19;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-21T00:17:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR21MB1332:EE_|MN0PR21MB3607:EE_
x-ms-office365-filtering-correlation-id: 47a6b103-de76-427d-8793-08db71ee687a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dulGN8xHLPMc4chBhIesvAYHOR21JhNQLKJZ2ZU6r525DVINILQdx40PzijFLBcsD7v6stCtTnCBCZ/CJk+njvYaAvytaJ2YEnCtjoAXfXuQ6fOXQ2AuVhjavCUeV+tqcqGhapILMff6kT1uCGRPd+SOEupvVnyRSV60xfXiD5lDnKgQfNMzKAYJlhYAMqjMGT0tGy3e7yARLkJIAFw2qtA/OKnHLg5DBvSvUhdEUFvVvN3pTofCsPaLrFAdbXjS+me1amRVebbZBkEo5GFBSiFt9F8Vu8lguuyYBBijwTsimFGUJnD93JJyie5V8d5rFwvmaNfWcPvxrCt9EeqQ6OfviTHcqSO2sSo7z4OdAEosQ5Hyi78C6Ul2BmTx3OJJVciRWTxYSMoMkMcVdZcE/3wxlC1fO3zj9IHrBGO1Cywhp8IvGwP/+nDYgb79ik1EVISikqdn+ZhlTOh+6trub4j4qpZo6Tx3h2egBP3zzxyz7gMjlxhibicGHZcnLbYAEi/uj3vmCa+Ee1z/qsxBIUJsolcRK0BMOkbNOd6Vykwv35g+PAid3rSJeKK+ls/tE9NRDXxFsK9rL1NLnSBh/t/trxgV8ZGJShrV55CsENnYwpQCZhj+JBp63edHytRTFFytAKSJKeu7s15KQWzof+AV+Giv3naz7fLkf5oHvg7JTrk6mbN1oduM6mHZi3AC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR21MB1332.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199021)(186003)(2906002)(10290500003)(54906003)(110136005)(478600001)(8990500004)(6506007)(9686003)(38100700002)(122000001)(316002)(921005)(86362001)(8936002)(8676002)(82950400001)(82960400001)(7416002)(55016003)(4326008)(5660300002)(52536014)(6636002)(71200400001)(38070700005)(33656002)(41300700001)(66476007)(66556008)(66446008)(64756008)(66946007)(76116006)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnUyTXFmRG80VWQwVFM4ZWwwSHY5aHUvV0xvbi8zVnVuWURWVjl1TTBLYmtP?=
 =?utf-8?B?WG9rRXRPN3RIczVVdzhlWHFlRk0zc3JqWHRzNE42c2xuY3lMWXMvdytpazZE?=
 =?utf-8?B?SkJQVnA1N1RPY1I0dlk3enJ1c09WWGYxcTZyaHJzZVZNWENGQTUwN1lJTzh0?=
 =?utf-8?B?c2V5cTdRWkdUeElLK3pZZVg1RGFDSnhoOWVHcU5GV1FCcW56SG5KbExKV0xZ?=
 =?utf-8?B?WFBTT29YVmhwYjlMeVdvMURXWUpYaEgwNUtuSGorMXRDSkRTWkZyKzlCYmVQ?=
 =?utf-8?B?VXZiaW50aUtUaU1NalQ2NjQ4dDBnZDgrR2lIbFU2NTVMc0JKNVVQV0RveXdE?=
 =?utf-8?B?ZGhxNU5PdkpyR0MxZHAvUkNNcFkzVXNSbU55STZLR2IrR29MWkc5UEZETm1I?=
 =?utf-8?B?RWFLOE1yQitqeEtiUEx5NTZJY20wMlZPZXc4UlQrNnVqQWpWT1hLeUVJMmhG?=
 =?utf-8?B?QlkzS1F1eVhEWTlFNityR09qSlJEcHJqNXpvOE91TnZEUEoyMEV1UmZ2R2ZW?=
 =?utf-8?B?TmhGdGFRSlZaR2ZIWXRBamN4L1VxdnZuMGF5bGM0Zm8xS3pxenlQSXpHNXNa?=
 =?utf-8?B?WHNRc2pQZFN0UlNDK2YyQy8wYnBCalJYYXJvMW5Nd3lKTU9qN1JKcGdIUFBi?=
 =?utf-8?B?eWUrV3VkTjVPRDNNNWc5UkVhcU5ZYlp4YlBxSzdxZUdkd1UxNzh5b3R4ano3?=
 =?utf-8?B?Ulpzcmhzb2NIVlYvZmpEMjArLzNqcDVrcWZMY3lZcWROZUVjZmVwdXlqakc3?=
 =?utf-8?B?aWN5QVhwZGdNcTF0V2VXSllBZXFieUc1MXVrWVQrc0ZGN0J6elFjRU5HZitD?=
 =?utf-8?B?RXBtVEgvVTJqTlVpekFJV1BINzRqVytzWmtDUXd0dlFsVXJ5YWN0NXhhY0lN?=
 =?utf-8?B?bGVxbFN5eENZSG1QcVNoT250Ri90QVZJbUxMZHBuQUhhcEhRaWRWUC85ZWlj?=
 =?utf-8?B?NENnZkFvbnJVNmUxUE5BK21rbU0xa2dSSjNOZ1BiNEJzcFpOSjR3N04rVWVQ?=
 =?utf-8?B?R3BaSFFNVklIc0QxOUNhLzlVSXpZV0krbXJVRFJKUWl3cW8xdXFCWUpMYjVu?=
 =?utf-8?B?c3RTdEJwaWFNSzJaNDJuTExvRENWV2IwM0I3RWdEMTVlV01HRzB0TlVyZWFj?=
 =?utf-8?B?anJyZ2ZhZ29HNG5JN0IybzlWdTdYbjZRcHU4NmNGLzZpcUdmVi9iWFdFSitl?=
 =?utf-8?B?bEppMmVtT0pKTUYzaUo5VUZIa3Vvc0Z5T0hkRFI5KzFpMTArNTRoT2laOVA3?=
 =?utf-8?B?bVc5d3lTZTBHaUZORGdqTEY5WXAyVUJxT1Zkd1BVQU0wWUNHdUoxcGl1Z1o0?=
 =?utf-8?B?clRtek5Cd3RrR3JqbG1PYzhHaEJMOEJzc0NIMjR2RzJHUUVqWElwVDZncnU5?=
 =?utf-8?B?aGJQVXBMWHZYYjJNYlRKZHhKNGNuaGhSQjNMOGx2bUVxd3NCRUJOdFpNVjBR?=
 =?utf-8?B?blNKakZLYXBuMHhEWUN6UWxKTVdYdHRMK3pGWEdzc21RWEV6aXEvRXRGbGpS?=
 =?utf-8?B?R0E5TmVmcjA5eWZOQ3VkRW93TnZLLzZuaFN6VmRiWGpqT3ZLQnA2ZCsrcHlC?=
 =?utf-8?B?elpjWVo0eVl6SVVnZGd5WXZvSzdSbytqQkhYVndZZDlTSFVmV2ptZFEvY2pP?=
 =?utf-8?B?RmdzNkVJdW13S0JkUC9tSE4xTG5pNG5JNHJpTEoxTjI4R2J0b05yaHdRRWll?=
 =?utf-8?B?bjlNdEtudVY1azg4blhPN3REWFhJN1FhVDZCZjlGcEV2b2FNVlZxWnUyQncr?=
 =?utf-8?B?d3l4aUZ4OENOS3RUK3A5N1Z3VnR6Q0YwZjNUZGY3VHI3cmxZMDI1YUh3Vjhw?=
 =?utf-8?B?Si9UcEJ0U0tWd3huOFVDQ3pIa3c0amxNTlR0ejJBTnQ2Q1ZjbXNaSndHQk5k?=
 =?utf-8?B?L1J3WVVERzlTelh2bSt0UCs2WXNiWjdvb053dWxURnIreXRydW8zR2pDRk0x?=
 =?utf-8?B?c2Ntd29RcFVzeGJOSm1UaFNYN2VDMFRpeXpxeCtmeGYzbEV0enFpL3VXOXpI?=
 =?utf-8?B?b0RFYkROOEVaTDhCNStJSkRmRHdwVmdKRS9qVTk0YXhxZkZCTkxraGpiV1I2?=
 =?utf-8?B?YjVTbUFNeHJyMHVETTdNWHl5a2dTZXhqaXBsSE8wWDcyVlI1c2NCTHEvRGlH?=
 =?utf-8?B?c3A5eGRNQnhMM2VZTkQ4THpvaURHaUpTN0xXSExnTXprVyszYjN3VlBMWUxm?=
 =?utf-8?Q?LIt99jgQ4okxrcd1LYHqITdVKMfzWSShRdyG2Jh6bZnT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR21MB1332.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a6b103-de76-427d-8793-08db71ee687a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 00:28:17.2042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fThC5o6P2Nff4nzglR/O8mcQ0FhWJk2UUtaBfVLtGLr4Hon0TfT7FD9+CNekfXwXnwsrSKY9n3BDT4w5KxSibQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3607
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PiBGcm9tOiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBKdW5lIDIwLCAyMDIzIDQ6MzQgUE0NCj4gPiAgLi4uDQo+ID4gLQlpZiAoX3RkeF9oeXBl
cmNhbGwoVERWTUNBTExfTUFQX0dQQSwgc3RhcnQsIGVuZCAtIHN0YXJ0LCAwLCAwKSkNCj4gPiAr
CXdoaWxlIChyZXRyeV9jb3VudCA8IG1heF9yZXRyaWVzX3Blcl9wYWdlKSB7DQo+ID4gKwkJbWVt
c2V0KCZhcmdzLCAwLCBzaXplb2YoYXJncykpOw0KPiA+ICsJCWFyZ3MucjEwID0gVERYX0hZUEVS
Q0FMTF9TVEFOREFSRDsNCj4gPiArCQlhcmdzLnIxMSA9IFREVk1DQUxMX01BUF9HUEE7DQo+ID4g
KwkJYXJncy5yMTIgPSBzdGFydDsNCj4gPiArCQlhcmdzLnIxMyA9IGVuZCAtIHN0YXJ0Ow0KPiA+
ICsNCj4gDQo+IFdoYXQncyB3cm9uZyB3aXRoOg0KPiANCj4gCXdoaWxlIChyZXRyeV9jb3VudCA8
IG1heF9yZXRyaWVzX3Blcl9wYWdlKSB7DQo+IAkJc3RydWN0IHRkeF9oeXBlcmNhbGxfYXJncyBh
cmdzID0gew0KPiAJCQkucjEwID0gVERYX0hZUEVSQ0FMTF9TVEFOREFSRCwNCj4gCQkJLnIxMSA9
IFREVk1DQUxMX01BUF9HUEEsDQo+IAkJCS5yMTIgPSBzdGFydCwNCj4gCQkJLnIxMyA9IGVuZCAt
IHN0YXJ0IH07DQo+IA0KPiA/DQo+IA0KPiBPciBtYXliZSB3aXRoIHRoZSBicmFja2V0cyBzbGln
aHRseSBkaWZmZXJlbnRseSBhcnJhbmdlZC4NCj4gDQo+IFdoeSdkIHlvdSBkZWNsYXJlIGFsbCB0
aGUgdmFyaWFibGVzIG91dHNpZGUgdGhlIHdoaWxlKCkgbG9vcCBhbnl3YXk/DQoNClRoYW5rcyBm
b3IgdGhlIHN1Z2dlc3Rpb24gb2YgbWFraW5nIHRoZSBjb2RlIGNvbXBhY3QhDQpJJ2xsIGFwcGx5
IHRoZSBiZWxvdyBkaWZmLCBhbmQgcG9zdCB2OSB0b21vcnJvdyAodHJ5aW5nIHRvDQpub3QgcG9z
dCB0b28gZnJlcXVlbnRseS4uLikNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2NvY28vdGR4L3Rk
eC5jIGIvYXJjaC94ODYvY29jby90ZHgvdGR4LmMNCmluZGV4IDA4ZWFjOGY0NmMxMS4uMWNiN2U5
ZWUzYTY4IDEwMDY0NA0KLS0tIGEvYXJjaC94ODYvY29jby90ZHgvdGR4LmMNCisrKyBiL2FyY2gv
eDg2L2NvY28vdGR4L3RkeC5jDQpAQCAtNzEwLDkgKzcxMCw4IEBAIHN0YXRpYyBib29sIHRkeF9j
YWNoZV9mbHVzaF9yZXF1aXJlZCh2b2lkKQ0KICAqLw0KIHN0YXRpYyBib29sIHRkeF9tYXBfZ3Bh
KHBoeXNfYWRkcl90IHN0YXJ0LCBwaHlzX2FkZHJfdCBlbmQsIGJvb2wgZW5jKQ0KIHsNCisJLyog
UmV0cnlpbmcgdGhlIGh5cGVyY2FsbCBhIHNlY29uZCB0aW1lIHNob3VsZCBzdWNjZWVkOyB1c2Ug
MyBqdXN0IGluIGNhc2UgKi8NCiAJY29uc3QgaW50IG1heF9yZXRyaWVzX3Blcl9wYWdlID0gMzsN
Ci0Jc3RydWN0IHRkeF9oeXBlcmNhbGxfYXJncyBhcmdzOw0KLQl1NjQgbWFwX2ZhaWxfcGFkZHIs
IHJldDsNCiAJaW50IHJldHJ5X2NvdW50ID0gMDsNCiANCiAJaWYgKCFlbmMpIHsNCkBAIC03MjIs
MTMgKzcyMSwxNCBAQCBzdGF0aWMgYm9vbCB0ZHhfbWFwX2dwYShwaHlzX2FkZHJfdCBzdGFydCwg
cGh5c19hZGRyX3QgZW5kLCBib29sIGVuYykNCiAJfQ0KIA0KIAl3aGlsZSAocmV0cnlfY291bnQg
PCBtYXhfcmV0cmllc19wZXJfcGFnZSkgew0KLQkJbWVtc2V0KCZhcmdzLCAwLCBzaXplb2YoYXJn
cykpOw0KLQkJYXJncy5yMTAgPSBURFhfSFlQRVJDQUxMX1NUQU5EQVJEOw0KLQkJYXJncy5yMTEg
PSBURFZNQ0FMTF9NQVBfR1BBOw0KLQkJYXJncy5yMTIgPSBzdGFydDsNCi0JCWFyZ3MucjEzID0g
ZW5kIC0gc3RhcnQ7DQotDQotCQlyZXQgPSBfX3RkeF9oeXBlcmNhbGxfcmV0KCZhcmdzKTsNCisJ
CXN0cnVjdCB0ZHhfaHlwZXJjYWxsX2FyZ3MgYXJncyA9IHsNCisJCQkucjEwID0gVERYX0hZUEVS
Q0FMTF9TVEFOREFSRCwNCisJCQkucjExID0gVERWTUNBTExfTUFQX0dQQSwNCisJCQkucjEyID0g
c3RhcnQsDQorCQkJLnIxMyA9IGVuZCAtIHN0YXJ0IH07DQorDQorCQl1NjQgbWFwX2ZhaWxfcGFk
ZHI7DQorCQl1NjQgcmV0ID0gX190ZHhfaHlwZXJjYWxsX3JldCgmYXJncyk7DQogCQlpZiAocmV0
ICE9IFREVk1DQUxMX1NUQVRVU19SRVRSWSkNCiAJCQlyZXR1cm4gIXJldDsNCiAJCS8qDQoNCg0K
VGhlIGZ1bmN0aW9uIG5vdyBsb29rcyBsaWtlIHRoaXM6DQoNCi8qDQogKiBOb3RpZnkgdGhlIFZN
TSBhYm91dCBwYWdlIG1hcHBpbmcgY29udmVyc2lvbi4gTW9yZSBpbmZvIGFib3V0IEFCSQ0KICog
Y2FuIGJlIGZvdW5kIGluIFREWCBHdWVzdC1Ib3N0LUNvbW11bmljYXRpb24gSW50ZXJmYWNlIChH
SENJKSwNCiAqIHNlY3Rpb24gIlRERy5WUC5WTUNBTEw8TWFwR1BBPiIuDQogKi8NCnN0YXRpYyBi
b29sIHRkeF9tYXBfZ3BhKHBoeXNfYWRkcl90IHN0YXJ0LCBwaHlzX2FkZHJfdCBlbmQsIGJvb2wg
ZW5jKQ0Kew0KCS8qIFJldHJ5aW5nIHRoZSBoeXBlcmNhbGwgYSBzZWNvbmQgdGltZSBzaG91bGQg
c3VjY2VlZDsgdXNlIDMganVzdCBpbiBjYXNlICovDQoJY29uc3QgaW50IG1heF9yZXRyaWVzX3Bl
cl9wYWdlID0gMzsNCglpbnQgcmV0cnlfY291bnQgPSAwOw0KDQoJaWYgKCFlbmMpIHsNCgkJLyog
U2V0IHRoZSBzaGFyZWQgKGRlY3J5cHRlZCkgYml0czogKi8NCgkJc3RhcnQgfD0gY2NfbWtkZWMo
MCk7DQoJCWVuZCAgIHw9IGNjX21rZGVjKDApOw0KCX0NCg0KCXdoaWxlIChyZXRyeV9jb3VudCA8
IG1heF9yZXRyaWVzX3Blcl9wYWdlKSB7DQoJCXN0cnVjdCB0ZHhfaHlwZXJjYWxsX2FyZ3MgYXJn
cyA9IHsNCgkJCS5yMTAgPSBURFhfSFlQRVJDQUxMX1NUQU5EQVJELA0KCQkJLnIxMSA9IFREVk1D
QUxMX01BUF9HUEEsDQoJCQkucjEyID0gc3RhcnQsDQoJCQkucjEzID0gZW5kIC0gc3RhcnQgfTsN
Cg0KCQl1NjQgbWFwX2ZhaWxfcGFkZHI7DQoJCXU2NCByZXQgPSBfX3RkeF9oeXBlcmNhbGxfcmV0
KCZhcmdzKTsNCgkJaWYgKHJldCAhPSBURFZNQ0FMTF9TVEFUVVNfUkVUUlkpDQoJCQlyZXR1cm4g
IXJldDsNCgkJLyoNCgkJICogVGhlIGd1ZXN0IG11c3QgcmV0cnkgdGhlIG9wZXJhdGlvbiBmb3Ig
dGhlIHBhZ2VzIGluIHRoZQ0KCQkgKiByZWdpb24gc3RhcnRpbmcgYXQgdGhlIEdQQSBzcGVjaWZp
ZWQgaW4gUjExLiBSMTEgY29tZXMNCgkJICogZnJvbSB0aGUgdW50cnVzdGVkIFZNTS4gU2FuaXR5
IGNoZWNrIGl0Lg0KCQkgKi8NCgkJbWFwX2ZhaWxfcGFkZHIgPSBhcmdzLnIxMTsNCgkJaWYgKG1h
cF9mYWlsX3BhZGRyIDwgc3RhcnQgfHwgbWFwX2ZhaWxfcGFkZHIgPj0gZW5kKQ0KCQkJcmV0dXJu
IGZhbHNlOw0KDQoJCS8qICJDb25zdW1lIiBhIHJldHJ5IHdpdGhvdXQgZm9yd2FyZCBwcm9ncmVz
cyAqLw0KCQlpZiAobWFwX2ZhaWxfcGFkZHIgPT0gc3RhcnQpIHsNCgkJCXJldHJ5X2NvdW50Kys7
DQoJCQljb250aW51ZTsNCgkJfQ0KDQoJCXN0YXJ0ID0gbWFwX2ZhaWxfcGFkZHI7DQoJCXJldHJ5
X2NvdW50ID0gMDsNCgl9DQoNCglyZXR1cm4gZmFsc2U7DQp9DQoNCg==
