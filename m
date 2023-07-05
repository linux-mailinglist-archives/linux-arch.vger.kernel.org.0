Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0DD747BAC
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jul 2023 05:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjGEDGE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jul 2023 23:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGEDGC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2023 23:06:02 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3306FE72;
        Tue,  4 Jul 2023 20:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688526362; x=1720062362;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3ez0J17sKKBoA73t3dppmh8Sp84SjFwzHT9kESkWpdE=;
  b=lX4+rdg/B5cA70VG97umx3GwFOKeHC2IJ8TVu8AQtATqtQfsHCSCKBIy
   Wm4cQU//Lp46VUsy9ZiO4s2z82lO5nhzi6XU6UO7v9YteGzto+XIl55FH
   dEdgKKKiSjjmrl9nHh2MP2Oykexd5wa7ssxqEprHhrz1MDEwKtmqD55Hq
   DQo49BPnAREI5kbjFg/UFcScUtBMQydbgrnTmUrzi55enqUVSl00M8sKR
   cpiTUXNBVYe63g8oUKwlGtH7+50zrmCzSNzi3iOyr1SOe1m3Lje5LxypG
   sCCzik0OP3ICVNfd6Rke/qkJ63Ay8AOIj2Uzdzdfjdqj2pNNWzIbyrvvL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="362097749"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="362097749"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 20:06:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="832351745"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="832351745"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jul 2023 20:05:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 20:05:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 4 Jul 2023 20:05:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 4 Jul 2023 20:05:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaBOnJDTkqOU7OJ8y9a85OkHFhaZx0rlw6Y0dK6DZGS/EjAIIH+m05PapVBn3tOklasCp+oZvK3GWOSZd+1ykDFuM+jVCdXiBwIsqeCNUUcl4jSu9KpzH0IPTwi8AkW10A8P5tov668tsVGYWCi6PjrBJJEZXBHqgNr9foYQUh+0YOhvtR4UMmRy87slKG/osb6nLmGU7C4EGu4smWsaMRSSCz7daIcihIVc3XrouqN5HeYBCBkyBVmP3LG6oRy0aufSDwr3e9dRG0eQr1NFqg7I6ckKJ/HpuDMAEM1LzcvBzsdW/FPCt2aRZeZO/Z8/XYcpadWJqXOsJzuYd2SJPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ez0J17sKKBoA73t3dppmh8Sp84SjFwzHT9kESkWpdE=;
 b=aU1QgE1snicbgvPEyceBB+P1bEqg1gPWyDMBYW04QKc2pmlcMbNk4WJx3rjhDyQ0EohpeskE6AHF34aqW97D+/IjjcWPCV8kAfpzVs7jTqurg1wzxB02uwDyceNkHAkabEyTMBHqy/A+PtCBQ86Q+rvU+0l72EflqrdzQu1Qzv/rUHLSMTR8KA6GBwE5QJS1E/oEWZ3PkBQBS66xT0Ucg5uB0ZqAHcBeV3w2ZXNJCeNBMXaPROwxaEv5O6NDOvDC8Z2zUK6ZL1qid+mbjr0e6a3RfYecV+WQ4IRWrvVGUCcIVAcjYIOdCltIvIbHPCZopqUQmxOgiOVswmycpat+rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by LV8PR11MB8679.namprd11.prod.outlook.com (2603:10b6:408:1f9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 03:05:54 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::23ed:f657:76a5:722d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::23ed:f657:76a5:722d%2]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 03:05:54 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "ldufour@linux.ibm.com" <ldufour@linux.ibm.com>
CC:     "npiggin@gmail.com" <npiggin@gmail.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3 3/9] cpu/SMT: Store the current/max number of threads
Thread-Topic: [PATCH v3 3/9] cpu/SMT: Store the current/max number of threads
Thread-Index: AQHZqpdKSJnBgUgGIkCZOHfP1AbxI6+qhf4A
Date:   Wed, 5 Jul 2023 03:05:54 +0000
Message-ID: <f7f8726fcab00fa7436867c58eba1032159c4af8.camel@intel.com>
References: <20230629143149.79073-1-ldufour@linux.ibm.com>
         <20230629143149.79073-4-ldufour@linux.ibm.com>
In-Reply-To: <20230629143149.79073-4-ldufour@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|LV8PR11MB8679:EE_
x-ms-office365-filtering-correlation-id: 3b592771-b88d-462e-bf4d-08db7d04bf48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 93yreEQ8roFGabLyMlYaADmJgP6Z+rHL4rp750+xoywSGnoxDcuUNjPVOxCh8Rfs6rWPtTee6RqpVv3fMoF1hzVkhe409ltcctr8R00219hqSWCnM8JZAJsRe2cmbmi8Yq9f2N9oY3lrtvmwp6k5ZMIYDX4NgcIuJQmtW4ZxKYt+v+lenuxMYAiS2lnm3hcIICrCX/9ZR6KL3lEoUMyVmDld/Nh8l70WBO5g0NpfDsL7RXjzjzQDsoyNOpqqyrDQQsRUL8Ir58KoBfUD2R3/RRBneLcvan/O1ibj3YAB1V1jAHlyUDB3Olz+ZgSrT6gFZBrPWRZV6qBgweKuaFA3t7G5anqySYWGBOllF1IOE9rpZtaLgpeSRaKDt0rP/4g7HJQoOcXe7X6rtnqs6BF6j1MuUr+px1lmNN1MIg6RQmjYyRguDeejZhAqjEkl6eafHivAtwwbLRr+W/gvWlhGLMp9jUjC6fiAYmuvQWloXCvA47iseT5t8vGLwO8B9jDYFKTyJ1DavyOyp99kYSI7XuAVLYqmOu/QcEwq05cfsThY+ehrry5dI54JHfw0zY9y8xa4uULlJwlZnARtHxnSmTvtUWIJVKIqL21OWcJ6uEYS8hcG+0xmqWoOBonk8pZ0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199021)(186003)(82960400001)(478600001)(6512007)(26005)(6506007)(86362001)(71200400001)(2616005)(316002)(110136005)(54906003)(38100700002)(6486002)(66556008)(76116006)(91956017)(122000001)(64756008)(66446008)(66946007)(4326008)(66476007)(7416002)(5660300002)(8676002)(8936002)(38070700005)(2906002)(41300700001)(558084003)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVVuS1QwdUkzaWp0bHJXMWZqUCtkOWYzOUpWTUxZMkJxcnpzTGlyWEZ0VlZu?=
 =?utf-8?B?RzU0dFRPY0FZRlVaSXJDdEpWWk13ZDZQNWNXSTFycm1ocG9aQlN5M0ZHNGEv?=
 =?utf-8?B?UlIwN2RPYmxNZzZNZ3hTVzRUUWhPdFhseWZ2WFBWKy94OTdJM1Z1Z29NMzVa?=
 =?utf-8?B?VWNJUzJnTGppRUtFb1BFZzZUVVFEM2tqK0ZWUG1nTjM3VitIaWdUTWhIbTFE?=
 =?utf-8?B?blVjSFRZUElQMVRmaU1meFQ1WTBYbmsrS0Q3dkZhaHIzK1hYaDNoS1BtUktq?=
 =?utf-8?B?dGxsQnBON21oWWp3ZDk5Y1h3NkZoRjJpNVgrL3doNFNEY1ZiWHZ0aWdJVFV6?=
 =?utf-8?B?NGdkY2gxajFUM0ZEZGlCME92YVV6bzlnN1NKeVUyUVk3OXdDNXJPeGFwVUhk?=
 =?utf-8?B?OFpyU1NaTEc3YW5DdVVja09zYnRQUlBwYzBpSEZWYzJSWGIzb2F3YVN6ZmJl?=
 =?utf-8?B?dXFSbU1sNGNIc3JxcjB0RnZTSDkxUkdUSFAxcXNNaXVyZlRlV2QwMS9pYThV?=
 =?utf-8?B?Z0RhaFIxbDNGeXN0WmU1NVhxT2ZUNVVacU9QVFozRjY4ai93OGVZclR3UzJI?=
 =?utf-8?B?aXJsZXRTbnBpZXB6dGtyeEZISzFxdzIvVlB5eXgrOCt6SzVPNTdUcytZREQ2?=
 =?utf-8?B?VjR4R0xZc0dncVJkVVV0VmdsczFTRWpEYkxTNWhORjBjSEFZd2NHaE1JS21D?=
 =?utf-8?B?TkxGNWhRRzdsc212aFdwWnpXazNicHdRTE45K1UwQ0liWGNSdFdFcDE1ajlx?=
 =?utf-8?B?YkRDVWZ3WTZLNHpOK2FBbEJsemZhb1l3YVY1ZjN3ZEd2b1JhbUNtTHBoTkor?=
 =?utf-8?B?U2ptU2ZHdVVaZ3dOb1JjY3VKRXNyTzFZNUpYWGJOdXlsQWVvYUxuSEZ1MXRR?=
 =?utf-8?B?bnQ5R05hT0lSUExrWWlwRWFXRGZieEhvWWZ4VUFydzFKempXREkzNEplQXpQ?=
 =?utf-8?B?TDQ0N3ZmblVCWlVyUkU4T1FiZ2YvY2dsMnM0d205dnVDS0tLYncxWEUxYkJr?=
 =?utf-8?B?aEMxenR2VkRhWkp6WU5MdWRxdXRqSDVOeVMzMlM3OTNCVnpGTUNEOWlJang2?=
 =?utf-8?B?VHcyNFNKSlhaSWlVRlZEMjA0V2Z0TG9kMnBpY29qVTBnSkRGOGNpOSsyelJL?=
 =?utf-8?B?QlJHT2VjUWEvWTZrWjAxdnlUMWlXeEFLVTZ1VWpza3BKTzJhbFh3VDMvNGg2?=
 =?utf-8?B?NmpMamxxUm1WOG5iUlJGT3VJZG9zRjBsbTBlVGJXRWpZS2VyUEExbjI3dEVB?=
 =?utf-8?B?ekx6RFhPRmd0REJQdWlDVGgyOUJzU1c3WlcyUFA2OGpwUmRoaTcyNHpBL29h?=
 =?utf-8?B?UW1LVGxKL3ptL0QxWkJMOThubk9OcXgzV24xdEtnTVhvSi9CN25mSWFXdkN5?=
 =?utf-8?B?UndTSmRsZElOS1R6OHBoTzhpUGJKMkhOL3RlMUZCWFVpR09NUGIxam9icmg1?=
 =?utf-8?B?RTU1UWJUSllCSU9Dd3I2ZVFmWVV6STdmMnBXOGtWUVM2Z0hIL2FORktJMDQz?=
 =?utf-8?B?M2tHb3pDczdRVHg2aWZyL2VtUFZMRXBrSG5xMzRLRnRtWHpmTEVBMzg0TG5p?=
 =?utf-8?B?K0hmUmxtVW1ESXA5MnFNUk4rbDJMQWZYazRDUUVNM0R5a2owNW5iNDMzZ29v?=
 =?utf-8?B?b0FBcmpDbWJxV2dON2N2RDVwelgwU3VVRWI1NFIydmN0STBGOGdrY090ejdQ?=
 =?utf-8?B?c00yUnJibDBNc0NkeFZYNnd6bXgvL1ZjWi90ZUUydE1FYkJIY0ZlazBXUmlS?=
 =?utf-8?B?aWFsSllRNEdLZHI0TnBweGh6OVc0U2tHRkVIbWJseXExWVZUTDBORnNXZE9j?=
 =?utf-8?B?Lzh1NEpGLytONnVEdWNVTGJwQ0daWElVTzl2djhhajI5YjBkbWtyV05kMHBw?=
 =?utf-8?B?bCtVZUlJQ09STWdLaTU3eFUvTXdXeTFZS1R0cG51aG0vSlplNitCNmhEclRG?=
 =?utf-8?B?VU5hWXg0Tk1xM2V3dDBLS0JQb0J0YnZRcnJreWd4a24yVGJVczhVcms0T29U?=
 =?utf-8?B?SVFjY29YT2Fla0hxQnBaTzJ0RE5icmpQTzMzbitmNHFGb1NEZjd2dkowWlpN?=
 =?utf-8?B?YXluUldPN243TFhlRG04YWl6aG5tZWJ0T0tzSy9iMThrYkJOZHlrbUtNcDhu?=
 =?utf-8?B?OUU1TzlzTXYvK2UwQjZTNEluMDhvaDQ4KzVaU0dCay9jMERrRGR4REQ3a1Vu?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CEB384F6D517734088B525F8811759EF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b592771-b88d-462e-bf4d-08db7d04bf48
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 03:05:54.5550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wn/1GgzDKIWvggms95WS/efVooNNmalbUx1INvqsUephY/Ib0oL2KwEYiNggB59aC1Ozr+KQJBex8jvvGF/p0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8679
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

T24gVGh1LCAyMDIzLTA2LTI5IGF0IDE2OjMxICswMjAwLCBMYXVyZW50IER1Zm91ciB3cm90ZToN
Cj4gRnJvbTogTWljaGFlbCBFbGxlcm1hbiA8bXBlQGVsbGVybWFuLmlkLmF1Pg0KPiANCj4gU29t
ZSBhcmNoaXRlY3R1cmVzIGFsbG93cyBwYXJ0aWFsIFNNVCBzdGF0ZXMgYXQgYm9vdCB0aW1lLA0K
DQpzL2FsbG93cy9hbGxvdy4NCg0KdGhhbmtzLA0KcnVpDQoNCg==
