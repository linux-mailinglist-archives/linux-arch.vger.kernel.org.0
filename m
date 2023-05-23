Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A9570E956
	for <lists+linux-arch@lfdr.de>; Wed, 24 May 2023 01:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbjEWXCf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 May 2023 19:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjEWXCe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 May 2023 19:02:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123A3C2;
        Tue, 23 May 2023 16:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684882953; x=1716418953;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UK8Afoly+UKoCh9ixq1COLmVtSKOMa1+KeWeh1rOzk0=;
  b=LQmbQMYMOva9MqQjeTE/cKFefkmc3P/+fUhknl3aSRvoHNR7Alq5TsRI
   RzAp+tm7fodzfNaT0Ftj0KgclFxn6GhWUWGrrpcDsd66K0lFHgdz+ZUaO
   XcjI0OM/0ZF06eeLI77+JfjzdKA3gtAYjmfHQAuJJH5ygku8bnynsTPoP
   b6adXzEA/bEgvyX4kp+LZ5ds4vZwAiQrlDSN1eGXlxkHlBFKrwENHD3bg
   FGi6d6IFGK6/oQvPxymp6bTebC6JOyhLVg6nwVzbY2ao27d9d35miQftb
   aloLYfePSASMEozuSeRyskJEhj/NZJy2mL8tR8fmy0fqRKRVuPZEeUNxT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="353412960"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="353412960"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 16:02:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="878377095"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="878377095"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 23 May 2023 16:02:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 16:02:31 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 16:02:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 16:02:31 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 16:02:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfqC7SdKzcFcEzIGacRJUtlC3EBj8z29ts94muGW9ERoGFCEQHRrTukcLDwaGosqdmwpCe/yiWssGbLfN49SNdub9ax1jFUAYxBiyYTNtC//+SPZeAER9wyfGw7RtXDcbTdiPcD3KbEYEUO6nk1mv4KP01D730nmLOshP2LR1urbyIbgHGEf7DhHcvCe6fhPGLJd+QfKSE6ikrRCBjogQKPJalKp/2drIv/YuCrc0n6wUEd3xkrocmbqgRUFVBzoCqQiORVsWt/b3TsFB7qqphXYeGgi/6AP2gPERdNQXyf6epr76SiPMpGSBfjnqNifPIZFoRtDa/cY3Xrryl+VXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UK8Afoly+UKoCh9ixq1COLmVtSKOMa1+KeWeh1rOzk0=;
 b=R1Qved+rE6ooN3fvpWmXgvq8XqD411KnZ8dDSZNKCne/EiTInv2aznsizCFetRdHxPUDdPmvsLuWNMAO6U88lLeCXYQPTkW6fkGAVZo0zvHfRJZDmfENFKTCyRgBaiffrjAz7TJm1gtD+xnSfWwon/nWHvf7+JdjHDWE95Rpt+w1IRHxfWxZH6DZQySue/wQ3UrHTcAvo0PDQ2kaFpvDmG+OocWs/eizI9VuhbhJWAoaiH+zfE5EfIFQy+KG54OWuTJmIQJgtvtdm3fFMEXk1aprWId/bNzbbwrPdW426QH9jXxKImXrtUrvCYphqLhnP+KUmm/d1QimdHtbRbbKFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA0PR11MB7909.namprd11.prod.outlook.com (2603:10b6:208:407::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 23:02:28 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::33bf:d30c:12fd:b7e3]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::33bf:d30c:12fd:b7e3%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 23:02:28 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>
CC:     "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "Cui, Dexuan" <decui@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "chu, jane" <jane.chu@oracle.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "Tianyu.Lan@microsoft.com" <Tianyu.Lan@microsoft.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 2/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Thread-Topic: [PATCH v6 2/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Thread-Index: AQHZjb4rlYIVly/3XkOwRx0l0mBKHq9oecsA
Date:   Tue, 23 May 2023 23:02:27 +0000
Message-ID: <a32aca6c7545d4537982a58b275c0dc78720835e.camel@intel.com>
References: <20230504225351.10765-1-decui@microsoft.com>
         <20230504225351.10765-3-decui@microsoft.com>
         <9e466079-ff27-f928-b470-eb5ef157f048@intel.com>
         <ZG0vXlQpXgll+YJ1@google.com>
         <9a772a17-6038-a73e-eb2c-c3a28fa3b85f@intel.com>
In-Reply-To: <9a772a17-6038-a73e-eb2c-c3a28fa3b85f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA0PR11MB7909:EE_
x-ms-office365-filtering-correlation-id: 7c83eefc-97c9-4430-79f3-08db5be1c796
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5kPxejT0MaQRgE4bcLRLIZ08VuqdtjoLMbR42Cql8Q29Q3j56JwW5WWwRzv3wzJajtNQzpJTwvYktiC4mSS+5KLwtnT89xUqMCYEjphSjY12Yx2TMJlhUWOxjz41c9IiBg2c5l5TkE6yi6d6J7pHDYdjYNnoqNSGhuO1HAHtPmnrUicXhTTQa3bL1sm4Sn733D5xGeF3qv3+0ca7Kf65YrawxwQ0K2RIMePAzMZUvjBTvQeOyvxz61CvVWS/wETXqKYzpRI5ov0Ai9M0tZMA93BHkEg5KjxoEdjQLCMd3phB8N4rcL7qJ3wI69Bj3/7MhMkf5kr1w7PD+8NXVGAuNGcgnhI+zykggP4FhVu2dkCoUSbnlkSkvaAVh2AJYwPrG4ckmLf2cUNAdG2sV5zVKSYCxounRG4OWYqYbcmWVsLTk+FleTgLHTjy4ua7XWjCNGm9A/ix1sCryyEP85JAE3+Qcd2oyPxNk8aH7zckbwa26gLECXVz78EakXnieCFVX5wnjp2hWyv9bQ6LJHBaEWkDwMMp2hruVk/cTQknhSmIfoG4858gqbZeJlYuqKN0pAtvEJ8NHlv+58Jz4CcXV3PysN4nMQGlSagKzPXATHo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199021)(38100700002)(76116006)(66946007)(66556008)(66446008)(66476007)(91956017)(64756008)(478600001)(41300700001)(6486002)(110136005)(966005)(54906003)(316002)(71200400001)(38070700005)(4326008)(86362001)(8676002)(5660300002)(8936002)(7416002)(26005)(6512007)(186003)(122000001)(53546011)(6506007)(82960400001)(2906002)(2616005)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmhRWURPMjM1dHlJcHZJNEllTkN0ejBERzhOa3VOMEVvTnhOVWFraVZ0U1VK?=
 =?utf-8?B?VWRFc1NMY1FaTW9XNXl3WldieDEwdEVqR3VzTkMweDh3WFVlSnVYT2lWU3h3?=
 =?utf-8?B?TEFvY2hOaWR4cGRCM1NPQUsrY291TDg1ZDNRYVJUY3dvYThZM2owWnZ3akFu?=
 =?utf-8?B?WWN2c2FiT3RRc0VJK0hOcm16OXFTaVkzMjVxUytsR3daNCtkMVltOTIzZXpi?=
 =?utf-8?B?amRjQnJwVUQ2VnJUdDUwSnlpUENoNGNhZ0l4Z2R5Vi8ybjRyZXJRcjROa3pE?=
 =?utf-8?B?akJaWERKTlM5MWczTTZ3ZE5zcDVIdWl1c0Z0ZVFXUG5tdk1XQkR2QlU4QWtj?=
 =?utf-8?B?dkpUVFFXeWNYUzFrenhrQWI4Y2lHcXE3VkRSTjhsRE8zMSsyZ1FzTDEvUWM3?=
 =?utf-8?B?RVF3dzRoTDdDemZ5a1Y3SGplN0ticjBVV3RkL0dIbnpHS0NOSU5PTjM4VU9F?=
 =?utf-8?B?VEJEVVhZV0kzL2RULytZSFhFZTd3NlYwWnhnWkI2bTZQSFVGTHA2K1RhcTVv?=
 =?utf-8?B?ek8xTkUyMlh6RXNvSXpUa0JZcUhXV3EreGprMmNER00xVmxkT05EUEN1Sk95?=
 =?utf-8?B?c0l0WWZpd3h1cHJPRlVoeXN0VDBMbXp5ZXVoSlhBYVY4NUpYdUVwVE04Wkd5?=
 =?utf-8?B?Sk96bThvdzlxWmg0a2ZEYjROaXJLRXcwUnlXb1ZmRlVKTTdWNGFzQjVDR1FC?=
 =?utf-8?B?bWNXQzRnN0NBMmlkZ1Z0elJmQTBWU1FTa2FWU3hlaEM5Qks2VXZPSjhxaFU1?=
 =?utf-8?B?dERwc2s3aEhVQ21aWmJmbEtYL3VuaCtDSnErc1dTZ2dmdWFFZTdYUlZ0aUNQ?=
 =?utf-8?B?S2pMaVR5aWZuSkNEWU5tV2NQbjFtR1ZRMWN2TjJ1WGU1VWZxWkxNSHNHNHRm?=
 =?utf-8?B?cjM0aGUxWjczQUdoZWtkRDlwaDA4Wlh2ZmJIMkw3NnRFdW9QZTdUdDREdkw4?=
 =?utf-8?B?RjVEMThvWngzVlRBOGszclZrT2p0ZXBjdHhDTVRDaElLd1o2eU9BNFYzemdj?=
 =?utf-8?B?NjN5NTNRbWtNNTVyUmp5SWR1UnVsaW1BUmJZTEFnVi9FbDNJUC9GOG52dWFx?=
 =?utf-8?B?QmpDVk94Z1E3dFRSUnFDNjJKUGpySkRzQUNzelZMTEhlbkhkU2grQnJBcVA4?=
 =?utf-8?B?RG81a3ovRzB4UDIvNzZnb2lFRFdmY25FaDl2VFNXZkhiYWd1cHhBOVN3U1dl?=
 =?utf-8?B?NE02bitvNjBVMTZWeUExbFI1OVlaVU5kdVB5Qm5rNitST1VLY2p6bkRkbDg2?=
 =?utf-8?B?NDVXc0tmMXh5Tjl6cTdBOU9yVlRxaDRrcFFqcDMvZTM5ckIwem5XdHhycjJt?=
 =?utf-8?B?RG9pRGtGTjBmTDVxN3ZyMWFHNjNnMDd4cDg3MGg2bmdIWUd2VndwUTQ3b3dK?=
 =?utf-8?B?UzlJNDBxNDFNekJwNnRQTHlnS0tLY2Z1K0tuK3VrRUJJcGJNT1hBdksvV29O?=
 =?utf-8?B?eXoraDFUUG5sZytQT1RuaHJrekU4Ymd2QWx5MVlCSUhmeHRpdlVkNGNtWkpR?=
 =?utf-8?B?Z05GV09pclNYNlpWQWxOaUNuWUNvY1VrTGNSaDRoQ1NwMUNGdWdadzdYdlZP?=
 =?utf-8?B?V2g4QUdiamE3TmF2TjhDUnpzNGViUGZUVGRncXl6OC8wdGRDVFZ6SHRvb3dJ?=
 =?utf-8?B?RFpTY1pIb3pYbk1lcGNHZFVPSE1ERVpjTE9FekhaOWpnSG9kNjdIQ0tZa2Nx?=
 =?utf-8?B?WHB0ODZJL3dXLytTZ1hmdlRDOGZ0ZVhLM0YxUmMxaHUwUmZmazNxR3IxUzl2?=
 =?utf-8?B?Q3Z4VlhBbEIyclM5UTMzK3c3cXp2SlF4TTRPV3lZWitNVStwQXFqZHpCWlln?=
 =?utf-8?B?OGhoSjJNejRvNTlzZk5tOXpEMlBXblk1ZmZQd3JnbkVSSHAwQmlnSW5qRkoy?=
 =?utf-8?B?ODFFUDVLeVlrM2ZOTFNqQjdUUzVUbno4dThsaUxrYVNNU1RiczBFcTZCSjhH?=
 =?utf-8?B?SEFIOE04dEdlODdndm9Ra3VoUmYrSDNKWjZPZmtmVlpFdmt5VzYwcGh4L1FG?=
 =?utf-8?B?YjJwWUFRQ2licWhBc3RpeGxVTVdiS3YwK0FGUHVTRTc2cFUvakhQblV2QkdN?=
 =?utf-8?B?MmdtRDFGWnlMSjQwUEozNkYvaUVBdnZQYndGRi9mUGdiZ1NUb3dyNTBKMGU4?=
 =?utf-8?B?TjJ3bkRaTW00aHd1bWdFQVJSNkdmek5zVlM0dXJSSTZWdU5GVWkzWE15V3Nm?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EE1214B93667C47B1BA21DA5266A762@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c83eefc-97c9-4430-79f3-08db5be1c796
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 23:02:27.7150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wMrdmrQCq/p5XgFkpMBYweip19/Aao74JIsuBlt3viP05fXl4sEEynb13bMErVfh/h3vndr6Bijn6aD/fYSralLJ9P1Kx3NpTKcEWQkJy5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7909
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIzLTA1LTIzIGF0IDE0OjMzIC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gNS8yMy8yMyAxNDoyNSwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90ZToNCj4gPiA+IFRoZXJl
IGFyZSBjb25zZXF1ZW5jZXMgZm9yIGNvbnZlcnRpbmcgcGFnZXMgYmV0d2VlbiBzaGFyZWQgYW5k
DQo+ID4gPiBwcml2YXRlLg0KPiA+ID4gRG9pbmcgaXQgb24gYSB2bWFsbG9jKCkgbWFwcGluZyBp
cyBndWFyYW50ZWVkIHRvIGZyYWN0dXJlIHRoZQ0KPiA+ID4gdW5kZXJseWluZw0KPiA+ID4gRVBU
L1NFUFQgbWFwcGluZ3MuDQo+ID4gPiANCj4gPiA+IEhvdyBkb2VzIHRoaXMgd29yayB3aXRoIGxv
YWRfdW5hbGlnbmVkX3plcm9wYWQoKT/CoCBDb3VsZG4ndCBpdCBiZQ0KPiA+ID4gcnVubmluZyBh
cm91bmQgcG9raW5nIGF0IG9uZSBvZiB0aGVzZSB2bWFsbG9jKCknZCBwYWdlcyB2aWEgdGhlDQo+
ID4gPiBkaXJlY3QNCj4gPiA+IG1hcCBkdXJpbmcgYSBzaGFyZWQtPnByaXZhdGUgY29udmVyc2lv
biBiZWZvcmUgdGhlIHBhZ2UgaGFzIGJlZW4NCj4gPiA+IGFjY2VwdGVkPw0KPiA+IFdvdWxkIGl0
IGJlIGZlYXNpYmxlIGFuZCBzZW5zaWJsZSB0byBhZGQgYSBHRlBfU0hBUkVEIG9yIHdoYXRldmVy
LA0KPiA+IHRvIGNvbW11bmljYXRlDQo+ID4gdG8gdGhlIGNvcmUgYWxsb2NhdG9ycyB0aGF0IHRo
ZSBwYWdlIGlzIGRlc3RpbmVkIHRvIGJlIGNvbnZlcnRlZCB0bw0KPiA+IGEgc2hhcmVkIHBhZ2U/
DQo+ID4gSSBhc3N1bWUgdGhhdCB3b3VsZCBwcm92aWRlIGEgY29tbW9uIHBsYWNlIChvciB0d28p
IGZvciBpbml0aWF0aW5nDQo+ID4gY29udmVyc2lvbnMsDQo+ID4gYW5kIHdvdWxkIGhvcGVmdWxs
eSBhbGxvdyBmb3IgZnV0dXJlIG9wdGltaXphdGlvbnMsIGUuZy4gdG8ga2VlcA0KPiA+IHNoYXJl
ZCBhbGxvY2F0aW9uDQo+ID4gaW4gdGhlIHNhbWUgcG9vbCBvciB3aGF0ZXZlci7CoCBTaGFyaW5n
IG1lbW9yeSB3aXRob3V0IGFueQ0KPiA+IGludGVsbGlnZW5jZSBhcyB0byB3aGF0DQo+ID4gbWVt
b3J5IGlzIGNvbnZlcnRlZCBpcyBnb2luZyB0byBtYWtlIGJvdGggdGhlIGd1ZXN0IGFuZCBob3N0
IHNhZC4NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgd2Ugd2FudCBhIEdGUCBmbGFnLsKgIFRoaXMgaXMg
c3RpbGwgd2F5IHRvbyBzcGVjaWFsaXplZA0KPiB0bw0KPiB3YXJyYW50IG9uZSBvZiB0aG9zZS4N
Cj4gDQo+IEl0IHNvdW5kcyBsaWtlIGEgc2ltaWxhciBwcm9ibGVtIHRvIHdoYXQgZm9sa3Mgd2Fu
dCBmb3IgbW9kdWxlcyBvcg0KPiBCUEYuDQo+IFRoZXJlIGFyZSBhIGJ1bmNoIG9mIGFsbG9jYXRp
b25zIHRoYXQgYXJlIHJlbGF0ZWQgYW5kIGNhbiBoYXZlIHNvbWUNCj4gb2YNCj4gdGhlaXIgc2V0
dXAvdGVhcmRvd24gY29zdHMgYW1vcnRpemVkIGlmIHRoZXkgY2FuIGJlIGNsdW1wZWQgdG9nZXRo
ZXIuDQo+IA0KPiBGb3IgQlBGLCB0aGUgY29zdHMgYXJlIGZyb20gZG9pbmcgUlc9PlJPIGluIHRo
ZSBrZXJuZWwgZGlyZWN0IG1hcCwNCj4gYW5kDQo+IGZyYWN0dXJpbmcgaXQgaW4gdGhlIHByb2Nl
c3MuDQo+IA0KPiBIZXJlLCB0aGUgY29zdHMgYXJlIGZyb20gdGhlIHByaXZhdGUtPnNoYXJlZCBj
b252ZXJzaW9ucyBhbmQNCj4gZnJhY3R1cmluZw0KPiBib3RoIHRoZSBkaXJlY3QgbWFwIGFuZCB0
aGUgRVBUL1NFUFQuDQo+IA0KPiBJIGp1c3QgZG9uJ3Qga25vdyBpZiB0aGVyZSdzIGFueXRoaW5n
IHRoYXQgd2UgY2FuIHJldXNlIGZyb20gdGhlIEJQRg0KPiBlZmZvcnQuDQoNCkxhc3QgSSBzYXcg
dGhlIEJQRiBhbGxvY2F0b3Igd2FzIGZvY3VzZWQgb24gbW9kdWxlIHNwYWNlIG1lbW9yeSBhbmQN
CnBhY2tpbmcgbXVsdGlwbGUgYWxsb2NhdGlvbnMgaW50byBwYWdlcy4gU28gdGhhdCB3b3VsZCBw
cm9iYWJseSBoYXZlIHRvDQpiZSBnZW5lcmFsaXplZCB0byBzdXBwb3J0IHRoaXMuDQoNCkJ1dCBh
bHNvLCBhIGxvdCBvZiB0aGUgZWZmb3J0cyBhcm91bmQgaW1wcm92aW5nIGRpcmVjdCBtYXAgbW9k
aWZpY2F0aW9uDQplZmZpY2llbmN5IGhhdmUgc29ydCBvZiBhc3N1bWVkIGFsbCBvZiB0aGUgdHlw
ZXMgb2Ygc3BlY2lhbCBwZXJtaXNzaW9ucw0KY291bGQgYmUgZ3JvdXBlZCB0b2dldGhlciBvbiB0
aGUgZGlyZWN0IG1hcCBhbmQganVzdCBtYXBwZWQgZWxzZXdoZXJlDQppbiB3aGF0ZXZlciBwZXJt
aXNzaW9uIHRoZXkgbmVlZGVkLiBUaGlzIGRvZXMgc2VlbSBsaWtlIGEgc3BlY2lhbCBjYXNlDQp3
aGVyZSBpdCByZWFsbHkgbmVlZHMgdG8gYmUgZ3JvdXBlZCB0b2dldGhlciBvbmx5IHdpdGggc2lt
aWxhcg0KcGVybWlzc2lvbnMuDQoNCklmIGEgR0ZQIGZsYWcgaXMgdG9vIHByZWNpb3VzLCB3aGF0
IGFib3V0IHNvbWV0aGluZyBsaWtlIFBLUyB0YWJsZXNbMF0NCnRyaWVkLiBJdCBraW5kIG9mIGhh
ZCBhIHNpbWlsYXIgcHJvYmxlbSB3aXRoIHJlc3BlY3QgdG8gcHJlZmVycmluZw0KcGh5c2ljYWxs
eSBjb250aWd1b3VzIHNwZWNpYWwgcGVybWlzc2lvbmVkIG1lbW9yeSBvbiB0aGUgZGlyZWN0IG1h
cC4gSXQNCmRpZCB0aGlzIHdpdGggYSBjYWNoZSBvZiBjb252ZXJ0ZWQgcGFnZXMgb3V0c2lkZSB0
aGUgcGFnZSBhbGxvY2F0b3IgYW5kDQphIHNlcGFyYXRlIGFsbG9jKCkgZnVuY3Rpb24gdG8gZ2V0
IGF0IGl0LiBUaGlzIG9uZSBjb3VsZCBiZQ0Kdm1hbGxvY19zaGFyZWQoKSBvciBzb21ldGhpbmcu
IERvbid0IGtub3csIGp1c3QgdG9zc2luZyBpdCBvdXQgdGhlcmUuDQoNClswXQ0KaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGttbC8yMDIxMDgzMDIzNTkyNy42NDQzLTctcmljay5wLmVkZ2Vjb21i
ZUBpbnRlbC5jb20vDQoNCg==
