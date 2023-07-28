Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824B6766F5D
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jul 2023 16:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbjG1OYI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Jul 2023 10:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236953AbjG1OYB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Jul 2023 10:24:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1283C04;
        Fri, 28 Jul 2023 07:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690554239; x=1722090239;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QMYFgQafyYRWZzRHR7Qk3UfKsSOcKGDRsY94y39LZvs=;
  b=UOc1MlrpHJinevfV7Ak4dzd2fPx45gehkEGrwi9nNoR454jyt3rF37vv
   wPhIM4NwTH/MteP7UYzwdS8f+W8ftTd0yJtZl5q9+hcWtABRd0FCJYiV8
   kR9K3GwAZzQn0SwfIPX7CqBxk7fr1nZVNK5qQp2iZn6Qris0wEEjhUERU
   GnyY+YKPPsyJxCNQRRXCzeQ9Ahwvud+6DfQM19us0R0xmE2QpFLLQgbY7
   L+FO5F0RGvdyGLElujh8p0xqr5/fiiBzIWHJF+3z5iyqLj9T0dqR5YlN8
   rXqjYhc+iwYUz7+SgyiaAIL6AoST+MbgdhoE1A9B0yUYAgE5abt61Sh4I
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="434888114"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="434888114"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 07:23:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="817533790"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="817533790"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jul 2023 07:23:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 07:23:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 07:23:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 07:23:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRHWhiqRJLnxpv0Xxv20O7S2NX/wlnW3B4QcrQtI2HFm3RNX1jHZfwBENKKy2hXuhPPBeWUbb9OluLDPcjhnPfiEiEVKZ/MKqNfinuMof0FKguVc+WlHcnsTLLfkU7IiYGSF4qm+APPMw3TC2hSA3k556gkx6Vlgua8+G2lRnDAetEYNSfFgtkvVlmy/zVkcbzKH6ymqqeymYcvabORvKTcQJiYb6/eFPhmKQdmGn0vQYWSJQrExxINdG1ihTU7Bf9x5XOrNdk+C1HlZVfBF184dZUGCygksYTLDA1fUyIrV5uSspVYRxoe+JWMHK+rQjlrsDEkYbaUHqo6NyJi2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMYFgQafyYRWZzRHR7Qk3UfKsSOcKGDRsY94y39LZvs=;
 b=lgtWn6o4ajWESBh7+ZOalZAJ2bX+Wk7TA4fErFAKmzGaydLVlVSFGJjz+wcuKmM55en66vO/+EZ8K/zQftSaz81Tu90LYgyYMRBK8Teiie4pKVDU/uYaw3EaeZWBkiSFb5ZpIqTAbtLYZt9xKtb2svQzgBcyOyWZFGWoUJMqCbxd5sfSStBN9rKy4ogi3fF/9ubf2ynkx3YxqztQfI6j1Ie8pk7pXAa0ckfUYbsDoPRuGh1/Z2hzDDH1mtojYhqvf9klIAFe31kBfYHiuUm7vuozU0/TT1lzYaHOps64fSHGg925DK27VCWjT9zs74ZRjArmKtwWfGNc08I8XkAOFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SN7PR11MB7019.namprd11.prod.outlook.com (2603:10b6:806:2ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 14:23:56 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::75c5:4a90:a6c3:9d8d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::75c5:4a90:a6c3:9d8d%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 14:23:55 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "ldufour@linux.ibm.com" <ldufour@linux.ibm.com>
CC:     "npiggin@gmail.com" <npiggin@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/10] Introduce SMT level and add PowerPC support
Thread-Topic: [PATCH v4 00/10] Introduce SMT level and add PowerPC support
Thread-Index: AQHZr1BM9gzmeFoLCkCaGIrrlOZu8K+xlKUAgB1aO4CAAHDEgA==
Date:   Fri, 28 Jul 2023 14:23:55 +0000
Message-ID: <beaab9ae25de92bace2f2e30dff5e0d2e7774e56.camel@intel.com>
References: <20230705145143.40545-1-ldufour@linux.ibm.com>
         <c66e3e800a7d257ef7a90749fe567f056f4c3ace.camel@intel.com>
         <87wmykqyam.ffs@tglx>
In-Reply-To: <87wmykqyam.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SN7PR11MB7019:EE_
x-ms-office365-filtering-correlation-id: 2f231e59-c5f6-4afa-2b56-08db8f764698
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nMy3j/MiuURR8UjOga8nn9Fwlxw5UKNhB1dRAWe9dFQi6VEo50d7nAOElYriODKlwHdU3H6TjkEwbDkgDtQOq+aBltvdDSJ4kqlAEJU6XIIRLGpAkbB4a88zW3EvPkFclgovpqgnECcgPkrAjYcpdiZkvjF163RFak5eNUcwarpeG7hGsnVN5l9pkJnf5jNIqA7uK0ws7qOgilset0j/DUjShxfhBvUxCzzzfq5fxOaI9hVSMO9JKm1mtlhxagSMzwxHp1akiyVbe6zH4PIYNNVA4Uxor6sxRgeYPUf0YQX2szxY/3Gcv2kIlPGYxP5t2Pc1EWklxhPtVZa038bvqJEdKZitaPjafFrFQnq5K2FJXWoLyfSdoadGC9KjHdqsDx8oUzJ9uTeDXoYufnZJphc0E44KQvm1PVM/r3/My2pZboSTUj6u03RZ+0AuPM0jxdNMRtb4HwIUW9zWbliBTnIK+/Oo0IpIFKiqYZgmDz07AWEyn757dquW/xWCIh384ew0+upYyRzDyfnVEXTCDuDjlyniLA/XkGcOwE2rZPtw8YSYp6A+9HjEZK+GTPIA915LGZUNq/EZKczZDGkUF38Hd6EoLCrY44WvN7HnGtqIMKgDMR2Z4r48s2poN64TCrvc3LiRcw00L127uFNtjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(2906002)(38070700005)(82960400001)(71200400001)(6506007)(26005)(186003)(86362001)(83380400001)(38100700002)(2616005)(66574015)(6486002)(966005)(122000001)(478600001)(36756003)(6512007)(66946007)(54906003)(66476007)(66556008)(8936002)(66446008)(64756008)(76116006)(41300700001)(8676002)(7416002)(316002)(4326008)(110136005)(66899021)(91956017)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzY0OHpoMHMvYTYrWXprejNMa0VWV3V0WGNwODBvZUk1emdCV3hBYUlmV1pp?=
 =?utf-8?B?eWFuZTBDVXVXeW1Odm55bGR0dkZCbVFJcWx3bVVzckNaRlRJUlNVSFdqYzRN?=
 =?utf-8?B?cEdtem9lemhTQjE3Tmcrb1UzWHhGb0VreUJVZG0rblBYZmZrWS92a1NqWUFq?=
 =?utf-8?B?Ull1eU9aS2hRejlUbE05Y1k1c2RzWVlZY1VzaU5DV3BnL3ZBUzBXdWRZWXh4?=
 =?utf-8?B?TmJUakJNQkRrYzBNYW1Ia1puVExLTW5BbzlVWWdiSEgwZWN2Z1lJMDNRdkxm?=
 =?utf-8?B?dTZKUEtFM0FIWC9zdHBYMGw2RktuR0xjTTlVVjIwdXpuMVBFVjZGWTlkQVF6?=
 =?utf-8?B?cDF4UVhaTVNZd0xQWFFtNUQ0Nnh2MGxuTEtXTktGQW05U090c2k1YkhhUjNN?=
 =?utf-8?B?enNWcUl3OE1yWng2dC9sdnRUVmVicDVMYnhEMVREQ3FHc0NsbUtFb3NpSE8v?=
 =?utf-8?B?dmhELyszb2hWcUszbEphYWdoYy8vWjhia29kdllkZFV6bjNDQUpmWCtlSDZ2?=
 =?utf-8?B?Q3gzbzFnbnU3VzFlQnJIcFJuRGQ2eUdSWEIrVkxXYmR1ZjlLU2wzTm85aVIw?=
 =?utf-8?B?aU1TbEZyNDNSMzZHT1F3NUFlUGtXd3JhSGJvK1dhL0t0Zk9uVkFtN2NIcXdF?=
 =?utf-8?B?Zk0zdmxvam9BTmxUZGoxbDRBbm5IK040aUZSOW42a2gvbG81KzJuZi9PK0hn?=
 =?utf-8?B?dlFpWjRveWxOR3VnTVVPb2RNbWFxK3JOd0V3ZThMUnpnTWI4WndEUTJ1Ykw5?=
 =?utf-8?B?aFFZSm83cU1UblpqaHFuRUIxWUtEanhUd3ZVNmRPQ2lHOS9RY0srT1Jmd1pz?=
 =?utf-8?B?ZVBHYzZ2b0FNY1E5S1l1dlI3SDJSempOQ2ZnOElzd2FQSmVVK2NTWjQwSlpZ?=
 =?utf-8?B?SlJkVG9DSzlkUkdjR0ZZOGh2VS9DcUREYTIrd3FiNXpLSlZZTmQ2bm9tcGpY?=
 =?utf-8?B?alBTU0JrWDBydENGRGR5WjFPUlFnbUxYcCtPcWhXRHBXOGhBam16ZFVORldI?=
 =?utf-8?B?dUFvYmVLdXE5bFBlSXZUUzZVenI0NHlBM25sUUVEcStIVVRzcjVqQWZRb2Rz?=
 =?utf-8?B?N2JZcVg3NjlOL1k2WVV3VmxscjgyZHRtTnhDSVMvYlFiYjl3UkVBaFlpbS9K?=
 =?utf-8?B?YkpwZzFaQ3o3bE9sb3FjRGVrNnpzM0dvakduempFSUczcUZLNVcwdlNDZDZU?=
 =?utf-8?B?TlpjY3JnRFhyNlFQVVZuN010a0lMNHNMcXVZdkEvdXdpWFFTbjBaV20yQWhp?=
 =?utf-8?B?anVURWFQWWI1Y3BIQVo4bzF1NTFVejZiV1R6aG1jYnQ4blFUOFNZRytBY2JO?=
 =?utf-8?B?KzAwdVhLZHgyR0c5L0ZvR0xoclkzSWJpeWJCK2ZVc010UkdaNG9nbVZaY2Y1?=
 =?utf-8?B?ZGIwcVBSNW82eG9TR0hrc1hMTVhjK0owcUlydkJYelJxUVc1TGt4M3F3SlFF?=
 =?utf-8?B?bkZpdjNSRXFsWkc0ZmpkZDkxRHVPOVpJWEJDS3JmaHRmREVoN0dMeFNkTlE0?=
 =?utf-8?B?cm9lRnlDSy9mcEdqenRYKytIT2hDd0MybTVUWUhZTHFaaE4wUTNHYUpvekZY?=
 =?utf-8?B?UFJBa255UkF5Y1NKdlFsR1ZxNTBmUUFxejRCejdIaVFNRXdneWRuV2NjNkRS?=
 =?utf-8?B?NEJBaVBhQnczQ1laRWJPVlozWFFJaTk3SC9nWXZLSjNNRzJWOWF1Q2R3TjNk?=
 =?utf-8?B?b29jUjV0d3Z4QmRKaG9Wd2ljbWIrQUdkKzViWnVoa3VSeXlxMEhxWVpzZ1k1?=
 =?utf-8?B?aDBycXc2ZmJ4czJDUmhqaDUwbUFsNURIT1puNmFaRHhRaW9ZVjNyYytjZDVL?=
 =?utf-8?B?aWwrNHI2Vlo4aTUwY3F4SkdWakNUcjZ3RGlUMmlyUlE3R1ZNVG0vUjJjdmh1?=
 =?utf-8?B?MXo1M2hucE9HK29hSnFLYWI3K0V5cHE3RktPdUp1R3UvYzNXWGc4RWRwV3pj?=
 =?utf-8?B?TTdxMWZXa2h4VkxhNzVlK3BPbGttKzNnclYxemZkMXhkMG4zaDdNUUk1N29X?=
 =?utf-8?B?TXhpbXlFRWM3QUl0ZTR6WTZMbk00SG5Bam5sSHNFZHRmblNVSURHeWJyMVJJ?=
 =?utf-8?B?dUFwN0hxWkFyempmTXJrV0lBTUFMMWxEc0F1OG4rMy90NG5BYjkyVktqNHE2?=
 =?utf-8?Q?VWg19m8bsHLJw/CXYbLO/bbLn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BA8E55B94CC6D4ABF9F81A83BAD78E7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f231e59-c5f6-4afa-2b56-08db8f764698
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 14:23:55.6169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cAbPvyWt+QmNHvW3g43wRTyw0y4gAv9iGEIeMuW10alxbVUZGT3YvpnfREkTRBgiMaZmjireiFhewpbS0IxUmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7019
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

SGksIFRob21hcywNCg0KT24gRnJpLCAyMDIzLTA3LTI4IGF0IDA5OjQwICswMjAwLCBUaG9tYXMg
R2xlaXhuZXIgd3JvdGU6DQo+IFJ1aSENCj4gDQo+IE9uIFN1biwgSnVsIDA5IDIwMjMgYXQgMTU6
MjUsIFJ1aSBaaGFuZyB3cm90ZToNCj4gPiBJIHJhbiBpbnRvIGEgYm9vdCBoYW5nIHJlZ3Jlc3Np
b24gd2l0aCBsYXRlc3QgdXBzdHJlYW0gY29kZSwgYW5kIGl0DQo+ID4gdG9vayBtZSBhIHdoaWxl
IHRvIGJpc2VjdCB0aGUgb2ZmZW5kaW5nIGNvbW1pdCBhbmQgd29ya2Fyb3VuZCBpdC4NCj4gDQo+
IFdoZXJlIGlzIHRoZSBidWcgcmVwb3J0IGFuZCB0aGUgYW5hbHlzaXM/IEFuZCB3aGF0J3MgdGhl
IHdvcmthcm91bmQ/DQoNCkFzIGl0IGlzIGFuIGl3bHdpZmkgcmVncmVzc2lvbiwgSSBkaWRuJ3Qg
cGFzdGUgdGhlIGxpbmsgaGVyZS4NCg0KVGhlIHJlZ3Jlc3Npb24gd2FzIHJlcG9ydGVkIGF0DQpo
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvYjUzMzA3MWYzODgwNDI0N2YwNmRhOWU1MmEwNGYx
NWNjZTdhMzgzNi5jYW1lbEBpbnRlbC5jb20vDQoNCkFuZCBpdCB3YXMgZml4ZWQgbGF0ZXIgYnkg
YmVsb3cgY29tbWl0IGluIDYuNS1yYzIuDQoNCnRoYW5rcywNCnJ1aQ0KDQpjb21taXQgMTJhODlm
MDE3NzA5MmRiYzJhMWNiMWQwNWE5NzkwYWRiY2VhMjMwOQ0KQXV0aG9yOiAgICAgSm9oYW5uZXMg
QmVyZyA8am9oYW5uZXMuYmVyZ0BpbnRlbC5jb20+DQpBdXRob3JEYXRlOiBNb24gSnVsIDEwIDE2
OjUwOjM5IDIwMjMgKzAyMDANCkNvbW1pdDogICAgIEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5l
bC5vcmc+DQpDb21taXREYXRlOiBUdWUgSnVsIDExIDIwOjI2OjA2IDIwMjMgLTA3MDANCg0KICAg
IHdpZmk6IGl3bHdpZmk6IHJlbW92ZSAndXNlX3RmaCcgY29uZmlnIHRvIGZpeCBjcmFzaA0KICAg
IA0KICAgIFRoaXMgaXMgZXF1aXZhbGVudCB0byAnZ2VuMicsIGFuZCBpdCB3YXMgYWx3YXlzIGNv
bmZ1c2luZyB0byBoYXZlDQogICAgdHdvIGlkZW50aWNhbCBjb25maWcgZW50cmllcy4gVGhlIHNw
bGl0IGNvbmZpZyBwYXRjaCBhY3R1YWxseSBoYWQNCiAgICBiZWVuIG9yaWdpbmFsbHkgZGV2ZWxv
cGVkIGFmdGVyIHJlbW92aW5nICd1c2VfdGZoIiBhbmQgZGlkbid0IGFkZA0KICAgIHRoZSB1c2Vf
dGZoIGluIHRoZSBuZXcgY29uZmlncyBhcyB0aGV5J2QgbGF0ZXIgYmVlbiBjb3BpZWQgdG8gdGhl
DQogICAgbmV3IGZpbGVzLiBUaHVzIHRoZSBlYXNpZXN0IHdheSB0byBmaXggdGhlIGluaXQgY3Jh
c2ggaGVyZSBub3cgaXMNCiAgICB0byBqdXN0IHJlbW92ZSB1c2VfdGZoICh3aGljaCBpcyBlcnJv
bmVvdXNseSB1bnNldCBpbiBtb3N0IG9mIHRoZQ0KICAgIGNvbmZpZ3Mgbm93KSBhbmQgdXNlICdn
ZW4yJyBpbiB0aGUgY29kZSBpbnN0ZWFkLg0KICAgIA0KICAgIFRoZXJlJ3MgcG9zc2libHkgc3Rp
bGwgYW4gdW53aW5kIGVycm9yIGluIGl3bF90eHFfZ2VuMl9pbml0KCkgYXMNCiAgICBpdCBjcmFz
aGVzIGlmIFRYUSAwIGZhaWxzIHRvIGluaXRpYWxpemUsIGJ1dCB3ZSBjYW4gZGVhbCB3aXRoIGl0
DQogICAgbGF0ZXIgc2luY2UgdGhlIG9yaWdpbmFsIGZhaWx1cmUgaXMgZHVlIHRvIHRoZSB1c2Vf
dGZoIGNvbmZ1c2lvbi4NCiAgICANCiAgICBUZXN0ZWQtYnk6IFhpIFJ1b3lhbyA8eHJ5MTExQHhy
eTExMS5zaXRlPg0KICAgIFJlcG9ydGVkLWFuZC10ZXN0ZWQtYnk6IE5pa2zEgXZzIEtvxLxlc8WG
aWtvdnMNCjxwaW5rZmxhbWVzLmxpbnV4QGdtYWlsLmNvbT4NCiAgICBSZXBvcnRlZC1hbmQtdGVz
dGVkLWJ5OiBKZWZmIENodWEgPGplZmYuY2h1YS5saW51eEBnbWFpbC5jb20+DQogICAgUmVwb3J0
ZWQtYW5kLXRlc3RlZC1ieTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KICAgIExp
bms6IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE3NjIyDQog
ICAgTGluazoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC85Mjc0ZDliZDNkMDgwYTQ1NzY0
OWZmNWFkZGNjMTcyNmYwOGVmNWIyLmNhbWVsQHhyeTExMS5zaXRlLw0KICAgIExpbms6DQpodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FBSndfWnVnNlZDUzVacVRXYUZTcjlzZDg1ayUzRHR5
UG05REVFJTJCbVYlM0RBS29FQ1pNJTJCc1FAbWFpbC5nbWFpbC5jb20vDQogICAgRml4ZXM6IDE5
ODk4Y2U5Y2Y4YSAoIndpZmk6IGl3bHdpZmk6IHNwbGl0IDIyMDAwLmMgaW50byBtdWx0aXBsZQ0K
ZmlsZXMiKQ0KICAgIFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIEJlcmcgPGpvaGFubmVzLmJlcmdA
aW50ZWwuY29tPg0KICAgIExpbms6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjMwNzEw
MTQ1MDM4Ljg0MTg2LTItam9oYW5uZXNAc2lwc29sdXRpb25zLm5ldA0KICAgIFNpZ25lZC1vZmYt
Ynk6IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+DQoNCj4gDQo+IFRoYW5rcywNCj4g
DQo+IMKgwqDCoMKgwqDCoMKgIHRnbHgNCg0K
