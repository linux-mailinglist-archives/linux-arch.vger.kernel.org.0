Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA7D63B262
	for <lists+linux-arch@lfdr.de>; Mon, 28 Nov 2022 20:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbiK1TiH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Nov 2022 14:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbiK1TiE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Nov 2022 14:38:04 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11021014.outbound.protection.outlook.com [40.93.199.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E0125296;
        Mon, 28 Nov 2022 11:38:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVfk7kNmf7cif7GLuzKl1uSdd60v8f6Q/xceR0ThSzgOsbW1UvenAbQ7iSXKfn75mkMGH/XRy1wdFYqbgN6AIEfYOyFIzCZpQYQBtYHLcU1UmwEkJNUw1M6cvKyyBYIeB641somFVWmrd7vZRTlDFBYO4PG246qmU0JPL3DQJtY4Ab/8Hf+ls/xcoe+lsldIu57vvyzFFJruZQPgUEns0UMWwiAMQqF6VxcqTh/V3sEUoWSDAxR1OAyZ2HPQJblPzHwMxLEkO3gKLBEEROgTdoeWui/p3ImcUWRexY9ThAuC1aLWnYJLNqpx3UElyHYBhmSg6foYPtFIHZEhLZYkjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CemQoZFA7kurVg99XGAdAytCYh/ldpPL89QkN/tYci0=;
 b=k8+Zb7AkvqP7D1s/Pd8h2nnH9v5cNyH07AyYDtLbGZJ6TrY+H9T4sffcDqc66xtLn81FLy+Wt8QW+yb/75T28ZqpMhPRWTnbYDGc6THE2z1eo5qBq9vvg61wfG7+e1tU4BiurKs8zCG0c3k4bhCPe8/6KmFjFu4ya+2uA4KPoWeU0gY3m1Urkdo5s9zFR9T+atqVcFA+9bRZsN7s6n7kTaeE9GTnxYlVS7ESRI4waNPE13FsYlsOxU1DF7DwiIYcV35TmYm7Mz4oVoGPNxQlYOd8rN+Ywpt181YwBOIGC+P10++wE2u9ZjkmYpa9FBZZLJLIO5HIdY2izZXppo1o9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CemQoZFA7kurVg99XGAdAytCYh/ldpPL89QkN/tYci0=;
 b=OYSfhM96cCQWJNkfZThUN9ZNi7POeHFvnk9I98rpkQEvKdX/FBHHeRvp0E0/drpsloAMQ2IOCD1urztF6BAJ5LHKeAxS8PJoCawQNbTCqYKMlHPpzeXvmYKOYky/HDIFifWZprl5foFxG6zWdDR/jQAoTCE1WM4+bBfEX5JLC1M=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by SJ0PR21MB1311.namprd21.prod.outlook.com (2603:10b6:a03:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Mon, 28 Nov
 2022 19:38:00 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%6]) with mapi id 15.20.5880.008; Mon, 28 Nov 2022
 19:38:00 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
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
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/6] x86/hyperv: Support hypercalls for TDX guests
Thread-Topic: [PATCH 5/6] x86/hyperv: Support hypercalls for TDX guests
Thread-Index: AQHY/0oyvJMCdibbbUqzNA0JVsxn0a5TiVBAgADyjYCAAC5pcIAAEXiAgAAD5oA=
Date:   Mon, 28 Nov 2022 19:37:59 +0000
Message-ID: <SA1PR21MB13357B3CC486514D2DF50A4DBF139@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-6-decui@microsoft.com>
 <BYAPR21MB16886270B7899F35E8A826A4D70C9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <SA1PR21MB133528B2B3637D61368FF5FFBF139@SA1PR21MB1335.namprd21.prod.outlook.com>
 <b692c4da-4365-196d-9d12-33e2679c01de@intel.com>
 <SA1PR21MB1335BA9D27891F6B1BA3A988BF139@SA1PR21MB1335.namprd21.prod.outlook.com>
 <54871aec-823b-1ff5-8362-688d10e97263@intel.com>
In-Reply-To: <54871aec-823b-1ff5-8362-688d10e97263@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=765966c6-e536-42a0-8533-8d1b6364a217;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-28T19:25:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|SJ0PR21MB1311:EE_
x-ms-office365-filtering-correlation-id: 7578881d-461b-4e21-62c0-08dad1780eb2
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ThUhXocQ15e8UbsADLvFaWXxvzR1EIHa9a4jR8izjSzkQkTJM+45Sa0GffMj1xaVJ7j5Oozf52WQBOrShAH+PcF7LeM6ED2Gx0a7zrSTneT1nSVFDNdxSOztKmpWlt22dlcVZx22hP94Fj6v0y8EgQgu/DEgufvsczJPZGyViDzYqwrHzx5etQVfuaCYAe/hiepAq+m/FveCGy8EYjsvs/aN1HY2+KOqxL9Fay5BTpaaacFDH6/XHy0dUMsBFHaOk9b0aEL/BtM+gdNuEzq2lr4yx7UeuJdSX0OIe1xxwN09irGoLiYRaRIQLm4pjgZNrqKv0ixJuc2xztprhfnPHbGsmj/UuHFN/G3ee9ZbACXaQzzwnNxxtvyQdVsU8dE5xi6dhjZTzWr2KoaJ1SePermBsI8CFqaYt6yF+3bQ8dnMqfBfTEanXTJel3uYeTiYJ5VuHjtLDthsxmmfxycc6LHqFKTjJYStHxCee46bT5hkYvq+U6RjQqYdI6FT4TM1nV6/tAcfEdG93Wh0GtwpKNvY9l3lc4ZUMtjSFUyf0v4JG0r2FkQEi0HSR0bO/YbCJeID8hw+kh4Nlvamss/ofbfPCHtbkM/5jStW7vQXWRQuj9XDQmjtgKGvOfQto7y8XMLEs4qm8d2lC5hgRpdRg/n7bKd0txHw+tilEo0Yw55HcZZ4gDSNWOLYL66mBfxjsjDK+ZmJSpL5k6VW7fB124lFi7Cbg1Mody/VaQ9bIZhDfaooCk4ofLwJpmJorIlF/2v/vRwRcRXnbBg2PizOmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199015)(52536014)(41300700001)(4326008)(5660300002)(7416002)(8936002)(8676002)(66476007)(64756008)(66446008)(71200400001)(2906002)(33656002)(10290500003)(8990500004)(316002)(478600001)(66946007)(66556008)(76116006)(110136005)(86362001)(9686003)(7696005)(26005)(53546011)(6506007)(186003)(38070700005)(921005)(83380400001)(38100700002)(82950400001)(82960400001)(55016003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0oxS2phYXo5bjlnMmEvVVdrRVBDd3YxMUcra1drUENLQy9PR3dZb24wS0Zo?=
 =?utf-8?B?TkJHU3BsNHRIYnp5UGVxa1FKRjhaMjd0bm9IODlnK2JoTHhtMVpNcGVwbkNR?=
 =?utf-8?B?WnNHTXBPTktKZW5ONG43RmEvUzUyRnY3YXlQNlpXNmhQWUtZaWdLUCtFU0JX?=
 =?utf-8?B?bWR5OUEzZEllOFdpWE96elR5SHhmOGtmNjlyTGE3dFNxOFFXL2Fqa1p0U3JJ?=
 =?utf-8?B?aUhQWklBMkQ1Z0xHNE0remFTdERXWnU0dEVSMVFrYUduR1VSYUZaMXJLSnVt?=
 =?utf-8?B?bVRxSDJYZzdCMFRVOWQvS0hXQU5OWU1Rc25sMVUvK0U0UUJHR2VzTmJqM041?=
 =?utf-8?B?UTRSY2NubkxyNEl1dzZ4ck9QNmNUL3VGNGFWS3pmWFpjYzUvR1BJeTRmcFZY?=
 =?utf-8?B?RVFwZXZ6K2Q3MEpvT2ZuYXdFd1hza0d0eXhlNC96dXpFdXBRS2tPeUtQSXVE?=
 =?utf-8?B?eTE1UmR1RVhvNFdQVGpqL1FLRXJidlpJemR2NVFlS2NZREF2MGRNTlR3L2t6?=
 =?utf-8?B?Q0hGT3MxNjNsalJqWWU2eVNJMTlTUU9GcDNlZDZGM2RPUTE4K2ZoRUpsNHdp?=
 =?utf-8?B?OSttSHdKaytOVUtadU81Y0xIWEpTQ3ZWaUc3ejRDbmpPN24rb1FvSy9GeUZE?=
 =?utf-8?B?TTgvM2RweTFrNWFCSW12TlhzcEpsQzVneGRPd29ud3k5K3hVQU1oUjBLdGI5?=
 =?utf-8?B?azgvS2VqNksyUjBxL0ZmK1dmWXdUNUF0UjlyOGlUaWFCelhWeTRyTTNJSExL?=
 =?utf-8?B?S3NxN200RmFkMkg3SERvendQeUVLTUhsT3dYMExIYXhZemx0QktZdVl4NmJJ?=
 =?utf-8?B?MzE0MzVUYm9jWlJBUUxXbTZaV0VhampOaHExRXJrdC9qWmsvaElQZjVsR3JX?=
 =?utf-8?B?RytsU0huYXFNNlI0ZXJqQmYySTlsMytMcC81SktLUzdPenpLcFRRcDNXVGlD?=
 =?utf-8?B?c2lqQkJibXloc0h3dVVQU1crQ05PVjRSVUtGTzlZZ2Noa1B0STd0ejlIWUVk?=
 =?utf-8?B?NjJzaGdiWTRlVzFGVDY3QWtqUDBEOWc0ZWd1ckJrMGs5VWpLTlE5VHkwR1BV?=
 =?utf-8?B?ZTloaHRBTXRBMnJoNitDaVlxOHdGOWJBaTgwYndLL3VCdjZ4RjVoNkcydWhL?=
 =?utf-8?B?UlhJTzVjazNNSEw0Y0xQRjVkdnZ6SDNDamNaSTJzOHQ0TU9iTVZiQ3VqbURm?=
 =?utf-8?B?OHRYc0FuL2dyOXNYNjhza3lvUGFMaEFnKytaTXJrQit3eTVTMTZ2SkdSOWpX?=
 =?utf-8?B?OVdsdUgzRG4wWkFyQzRoRXNSTDZSMm1aOUNZU3hQOVY2L09Yb1B4dWxHNW45?=
 =?utf-8?B?K2lxU2FReVdhSTRCTy93U0tsQ1JCOVhCV203UjlIVk9YNzlZRkZGS0wzRWpE?=
 =?utf-8?B?b1J4RE5DdXNXQVhQM0dzcmFzdnV5ejEvUnJLSlUxZ1dBSWFlWGdrVjZJeWU5?=
 =?utf-8?B?bHo5RE1IamRmODdaREFYUzkxRzBKTjBtRVRUUXBRQUt5RHlxQlFNZk9RVGY5?=
 =?utf-8?B?MmpwNW9CTCtPZnVOT05MQlhnRXdyU1cxUksvWFZ0SWV1WGkzZ0IrcDBhN2I2?=
 =?utf-8?B?anFFazNHa0dDeEczOSttR0lxc2FFNXFjcE9ISmVoT05VU0NoS1U2S0IzOUNG?=
 =?utf-8?B?QlcwRnliNlZYQm9hRzQrZlRCRGJBdnFrTW9nWjBtUlRhd3hkNFMvMjNONXVZ?=
 =?utf-8?B?VWFrSDgwZm1TYVUyVXZnT3ljS3ZzbnRQM3MwY3FrQUZSb0trYU15R0k1ZzlZ?=
 =?utf-8?B?aHJSTmVYUTh4VzVWQ0UxaVFQajBaS2x4S2ZyZ2w2MEQ5QktiZzVVY2xTMGZa?=
 =?utf-8?B?NU5EeGNXd1F3dk10R2VuaWRMYngvSWFjVmJ0NGFGdkFud3JTSHpDL3loZ3A5?=
 =?utf-8?B?OWdEQWZySnVod2xCM2VpTDRLdHlWelBRY3B0Njh5bUg5QTdQcXpUdi9pZTFk?=
 =?utf-8?B?T3lnSytxbjJnMGpLbkpxYTVEMG8zTEUxek5ONEp5VFliRDNsYmNoUTlKMStG?=
 =?utf-8?B?N1pTdEJUamRaT2JRUW5TVHYwbmEvdDdNaXBtQm9qbnY2em80UzBYKzVTcm1a?=
 =?utf-8?B?RVdlRHlCYUVtWUFIUFVyWUlhMmhQZWRjMDNuMjRrUEhyZFJuK1VlVW5ob0RY?=
 =?utf-8?Q?JI+nY7BVEXyJEUStz+abxZ76I?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7578881d-461b-4e21-62c0-08dad1780eb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 19:37:59.8730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q7amgGw45fSXGoAj9u5tfI85yAdZqiJyAu1e56jF24W6G+qmPgiArzRkl3c4xHjI/w2OlLHsDOOkpvOAyZZcWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1311
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PiBGcm9tOiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPg0KPiBTZW50OiBNb25k
YXksIE5vdmVtYmVyIDI4LCAyMDIyIDExOjExIEFNDQo+IE9uIDExLzI4LzIyIDExOjAzLCBEZXh1
YW4gQ3VpIHdyb3RlOg0KPiAuLi4NCj4gPiB1NjQgaHZfdGR4X2h5cGVyY2FsbCh1NjQgY29udHJv
bCwgdTY0IHBhcmFtMSwgdTY0IHBhcmFtMikNCj4gPiB7DQo+ID4gICAgICAgICBzdHJ1Y3QgdGR4
X2h5cGVyY2FsbF9hcmdzIGFyZ3MgPSB7IH07DQo+ID4NCj4gPiAgICAgICAgIGlmICghKGNvbnRy
b2wgJiBIVl9IWVBFUkNBTExfRkFTVF9CSVQpKSB7DQo+ID4gICAgICAgICAgICAgICAgIGlmIChw
YXJhbTEpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcGFyYW0xID0gY2NfbWtkZWMocGFy
YW0xKTsNCj4gPg0KPiA+ICAgICAgICAgICAgICAgICBpZiAocGFyYW0yKQ0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgIHBhcmFtMiA9IGNjX21rZGVjKHBhcmFtMik7DQo+ID4gICAgICAgICB9
DQo+ID4NCj4gPiAgICAgICAgIGFyZ3MucjEwID0gY29udHJvbDsNCj4gPiAgICAgICAgIGFyZ3Mu
cmR4ID0gcGFyYW0xOw0KPiA+ICAgICAgICAgYXJncy5yOCAgPSBwYXJhbTI7DQo+ID4NCj4gPiAg
ICAgICAgICh2b2lkKV9fdGR4X2h5cGVyY2FsbCgmYXJncywgVERYX0hDQUxMX0hBU19PVVRQVVQp
Ow0KPiA+DQo+ID4gICAgICAgICByZXR1cm4gYXJncy5yMTE7DQo+ID4gfQ0KPiANCj4gSSBzdGls
bCB0aGluayB0aGlzIGlzIHByb2JsZW1hdGljLg0KPiANCj4gVGhlIGNjX21rZGVjKCkgc2hvdWxk
IGJlIGRvbmUgb24gdGhlIHBhcmFtZXRlcnMgd2hlbiB0aGUgY29kZSBzdGlsbA0KPiAqa25vd3Mq
IHRoYXQgdGhleSBhcmUgYWRkcmVzc2VzLg0KDQpNYWtlcyBzZW5zZS4NCiANCj4gSG93IGRvIHdl
IGtub3csIGZvciBpbnN0YW5jZSwgdGhhdCBubyBoeXBlcmNhbGwgdXNpbmcgdGhpcyBpbnRlcmZh
Y2UNCj4gd2lsbCAqZXZlciogdGFrZSB0aGUgMHgwIHBoeXNpY2FsIGFkZHJlc3MgYXMgYW4gYXJn
dW1lbnQ/DQoNCkEgMHgwIHBoeXNpY2FsIGFkZHJlc3MgYXMgYW4gYXJndW1lbnQgc3RpbGwgd29y
a3M6IHRoZSAwIGlzIHBhc3NlZA0KdG8gdGhlIGh5cGVydmlzb3IgdXNpbmcgR0hDSS4gSSBiZWxp
ZXZlIEh5cGVyLVYgaW50ZXJwcmV0cyB0aGUgMCBhcw0KYW4gZXJyb3IgKGlmIHRoZSBwYXJhbSBp
cyBuZWVkZWQpLCBhbmQgcmV0dXJucyBhbiAiaW52YWxpZCBwYXJhbWV0ZXIiDQplcnJvciBjb2Rl
IHRvIHRoZSBndWVzdC4NCg0KSGVyZSBpcyB0aGUgdXBkYXRlZCB2ZXJzaW9uOg0KDQpkaWZmIC0t
Z2l0IGEvYXJjaC94ODYvaHlwZXJ2L2l2bS5jIGIvYXJjaC94ODYvaHlwZXJ2L2l2bS5jDQppbmRl
eCA3MDE3MDA0OWJlMmMuLjQxMzk1ODkxZDExMiAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2h5cGVy
di9pdm0uYw0KKysrIGIvYXJjaC94ODYvaHlwZXJ2L2l2bS5jDQpAQCAtMjQyLDYgKzI0MiwyMCBA
QCBib29sIGh2X2lzb2xhdGlvbl90eXBlX3RkeCh2b2lkKQ0KIHsNCiAgICAgICAgcmV0dXJuIHN0
YXRpY19icmFuY2hfdW5saWtlbHkoJmlzb2xhdGlvbl90eXBlX3RkeCk7DQogfQ0KKw0KK3U2NCBo
dl90ZHhfaHlwZXJjYWxsKHU2NCBjb250cm9sLCB1NjQgcGFyYW0xLCB1NjQgcGFyYW0yKQ0KK3sN
CisgICAgICAgc3RydWN0IHRkeF9oeXBlcmNhbGxfYXJncyBhcmdzID0geyB9Ow0KKw0KKyAgICAg
ICBhcmdzLnIxMCA9IGNvbnRyb2w7DQorICAgICAgIGFyZ3MucmR4ID0gcGFyYW0xOw0KKyAgICAg
ICBhcmdzLnI4ICA9IHBhcmFtMjsNCisNCisgICAgICAgKHZvaWQpX190ZHhfaHlwZXJjYWxsKCZh
cmdzLCBURFhfSENBTExfSEFTX09VVFBVVCk7DQorDQorICAgICAgIHJldHVybiBhcmdzLnIxMTsN
Cit9DQorRVhQT1JUX1NZTUJPTF9HUEwoaHZfdGR4X2h5cGVyY2FsbCk7DQogI2VuZGlmDQoNCiAv
Kg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL21zaHlwZXJ2LmggYi9hcmNoL3g4
Ni9pbmNsdWRlL2FzbS9tc2h5cGVydi5oDQppbmRleCA5Y2M2ZGI0NWMzYmMuLmVhMDUzYWYwNjdh
MiAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL21zaHlwZXJ2LmgNCisrKyBiL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL21zaHlwZXJ2LmgNCkBAIC0xMCw2ICsxMCw3IEBADQogI2luY2x1
ZGUgPGFzbS9ub3NwZWMtYnJhbmNoLmg+DQogI2luY2x1ZGUgPGFzbS9wYXJhdmlydC5oPg0KICNp
bmNsdWRlIDxhc20vbXNoeXBlcnYuaD4NCisjaW5jbHVkZSA8YXNtL2NvY28uaD4NCg0KIHVuaW9u
IGh2X2doY2I7DQoNCkBAIC0zOSw2ICs0MCw4IEBAIGludCBodl9jYWxsX2RlcG9zaXRfcGFnZXMo
aW50IG5vZGUsIHU2NCBwYXJ0aXRpb25faWQsIHUzMiBudW1fcGFnZXMpOw0KIGludCBodl9jYWxs
X2FkZF9sb2dpY2FsX3Byb2MoaW50IG5vZGUsIHUzMiBscF9pbmRleCwgdTMyIGFjcGlfaWQpOw0K
IGludCBodl9jYWxsX2NyZWF0ZV92cChpbnQgbm9kZSwgdTY0IHBhcnRpdGlvbl9pZCwgdTMyIHZw
X2luZGV4LCB1MzIgZmxhZ3MpOw0KDQordTY0IGh2X3RkeF9oeXBlcmNhbGwodTY0IGNvbnRyb2ws
IHU2NCBwYXJhbTEsIHU2NCBwYXJhbTIpOw0KKw0KIHN0YXRpYyBpbmxpbmUgdTY0IGh2X2RvX2h5
cGVyY2FsbCh1NjQgY29udHJvbCwgdm9pZCAqaW5wdXQsIHZvaWQgKm91dHB1dCkNCiB7DQogICAg
ICAgIHU2NCBpbnB1dF9hZGRyZXNzID0gaW5wdXQgPyB2aXJ0X3RvX3BoeXMoaW5wdXQpIDogMDsN
CkBAIC00Niw2ICs0OSwxMiBAQCBzdGF0aWMgaW5saW5lIHU2NCBodl9kb19oeXBlcmNhbGwodTY0
IGNvbnRyb2wsIHZvaWQgKmlucHV0LCB2b2lkICpvdXRwdXQpDQogICAgICAgIHU2NCBodl9zdGF0
dXM7DQoNCiAjaWZkZWYgQ09ORklHX1g4Nl82NA0KKyAgICAgICBpZiAoaHZfaXNvbGF0aW9uX3R5
cGVfdGR4KCkpIHsNCisgICAgICAgICAgICAgICB1NjQgcGFyYW0xID0gaW5wdXRfYWRkcmVzcyAg
PyBjY19ta2RlYyhpbnB1dF9hZGRyZXNzKSAgOiAwOw0KKyAgICAgICAgICAgICAgIHU2NCBwYXJh
bTIgPSBvdXRwdXRfYWRkcmVzcyA/IGNjX21rZGVjKG91dHB1dF9hZGRyZXNzKSA6IDA7DQorICAg
ICAgICAgICAgICAgcmV0dXJuIGh2X3RkeF9oeXBlcmNhbGwoY29udHJvbCwgcGFyYW0xLCBwYXJh
bTIpOw0KKyAgICAgICB9DQorDQogICAgICAgIGlmICghaHZfaHlwZXJjYWxsX3BnKQ0KICAgICAg
ICAgICAgICAgIHJldHVybiBVNjRfTUFYOw0KDQpAQCAtODMsNiArOTIsOSBAQCBzdGF0aWMgaW5s
aW5lIHU2NCBodl9kb19mYXN0X2h5cGVyY2FsbDgodTE2IGNvZGUsIHU2NCBpbnB1dDEpDQogICAg
ICAgIHU2NCBodl9zdGF0dXMsIGNvbnRyb2wgPSAodTY0KWNvZGUgfCBIVl9IWVBFUkNBTExfRkFT
VF9CSVQ7DQoNCiAjaWZkZWYgQ09ORklHX1g4Nl82NA0KKyAgICAgICBpZiAoaHZfaXNvbGF0aW9u
X3R5cGVfdGR4KCkpDQorICAgICAgICAgICAgICAgcmV0dXJuIGh2X3RkeF9oeXBlcmNhbGwoY29u
dHJvbCwgaW5wdXQxLCAwKTsNCisNCiAgICAgICAgew0KICAgICAgICAgICAgICAgIF9fYXNtX18g
X192b2xhdGlsZV9fKENBTExfTk9TUEVDDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgOiAiPWEiIChodl9zdGF0dXMpLCBBU01fQ0FMTF9DT05TVFJBSU5ULA0KQEAgLTExNCw2
ICsxMjYsOSBAQCBzdGF0aWMgaW5saW5lIHU2NCBodl9kb19mYXN0X2h5cGVyY2FsbDE2KHUxNiBj
b2RlLCB1NjQgaW5wdXQxLCB1NjQgaW5wdXQyKQ0KICAgICAgICB1NjQgaHZfc3RhdHVzLCBjb250
cm9sID0gKHU2NCljb2RlIHwgSFZfSFlQRVJDQUxMX0ZBU1RfQklUOw0KDQogI2lmZGVmIENPTkZJ
R19YODZfNjQNCisgICAgICAgaWYgKGh2X2lzb2xhdGlvbl90eXBlX3RkeCgpKQ0KKyAgICAgICAg
ICAgICAgIHJldHVybiBodl90ZHhfaHlwZXJjYWxsKGNvbnRyb2wsIGlucHV0MSwgaW5wdXQyKTsN
CisNCiAgICAgICAgew0KICAgICAgICAgICAgICAgIF9fYXNtX18gX192b2xhdGlsZV9fKCJtb3Yg
JTQsICUlcjhcbiINCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDQUxMX05P
U1BFQw0K
