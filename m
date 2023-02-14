Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EA16955BA
	for <lists+linux-arch@lfdr.de>; Tue, 14 Feb 2023 02:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBNBHe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Feb 2023 20:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBNBHc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Feb 2023 20:07:32 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B411632D;
        Mon, 13 Feb 2023 17:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676336851; x=1707872851;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=P2vFY3od03Pea6G0b208iZ1luo9/ZCOfNcf9VgTXvA4=;
  b=b89W7efkAsLRxef1AshFXUhBfSB08OPFpwF7YzrUkehs8y+7DnEOX7lr
   XEirVJsEKPV2rsA6WCxTLMmuGp9UdFSlRYIDjsCxl8+NE00J05tJvim5D
   nX3PDvnB4EGrY1VAPS/fLTLWb73biagerLkWIGbvQp5F5heesxBfRS81q
   cVjjFTFzdmHOSlt6PMmOI6QVDoqTIA3abiVRoWoDz5gVP1jmAN4yxy/5+
   7LjuDwTjY4chZwIch3QOmsITwdNMWkkTHXtEcGxKx7AwxveJ+RMf3Y2kD
   wEkexEAsgXzk3V6cF1pgY7P5YBrW9y7h6BK1FqYzxYyOGcfux1W5SqkX1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="310678938"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="310678938"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 17:07:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="732697305"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="732697305"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 13 Feb 2023 17:07:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 17:07:28 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 17:07:27 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 17:07:27 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 17:07:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fyy/I6OtSrr4d6rfWCFUAedVD8CVyBDITci+RsxFpByEzegNjkdQx+2bdrVWOz1p7TGCXlxLliwujp85Ih5dlsQJ75N1CGHY8SDf4VeY1+wugQIr8e3M6HSuiODWG0FISwjCx4NWmC1sVBcUUQjfXkg/7nkCmPHd0Av6k7vS2ES4uuGSaWessy66fH3PQTMGZ7PppDVczZEIM5etjvx3Zy3rLh+9KNtSawN2g34xEkduUkpHkx/1hIp0mQnddwN80xcBo/I/uK9muUAkIqsHRFLFYvwY9rEWSZGtn+RTxhU1tclVTYGyzBeF4xxl01UaFrxSDBwx3EJfzNG2RXEumg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2vFY3od03Pea6G0b208iZ1luo9/ZCOfNcf9VgTXvA4=;
 b=j9s3YXhDYniqpTdRFMljMier+mh8LCCUjfYtr+Gb4QSI2Np8+G8fk+4bxVR1UnRDZn5V1NzXzsslNyTZsK61GTrUBxyiIT0XCsurJtXk2cg2xzVqrK/5BIiMI1cbxXZ8i8zOMgW2l7/yZe0wXi9YdurT8xYBxNqzxeF1fDqKvJCDn/VFNqf8BREqItv1YP80VXZvTLRTIXFGaPYLQnM45GcqWoBgqAI216N/K2kwOxfzxoKeQNwQvOVLJD9RB3PjvfeziBiivD0/EitOfB1CyfvmyDwQY0mKvEsUDWZqrrzLBRRB50eNn9cwlaTsR+zoPe9HfK//H6UGEReySjz+/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CH3PR11MB7298.namprd11.prod.outlook.com (2603:10b6:610:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 01:07:25 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 01:07:25 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "debug@rivosinc.com" <debug@rivosinc.com>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 19/39] mm: Fixup places that call pte_mkwrite()
 directly
Thread-Topic: [PATCH v5 19/39] mm: Fixup places that call pte_mkwrite()
 directly
Thread-Index: AQHZLExhHYeOx8u1uE+GSfMVtoENIa7NuLKAgAAQGIA=
Date:   Tue, 14 Feb 2023 01:07:24 +0000
Message-ID: <1dd1c61c69739fde6db445df79ebbbbec0efe8cd.camel@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
         <20230119212317.8324-20-rick.p.edgecombe@intel.com>
         <20230214000947.GB4016181@debug.ba.rivosinc.com>
In-Reply-To: <20230214000947.GB4016181@debug.ba.rivosinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|CH3PR11MB7298:EE_
x-ms-office365-filtering-correlation-id: e235e52e-1f69-4933-361b-08db0e27d52b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HLA7XK7E+2Hb2MiJA543neGl07bQuqIUNwHYlLAQkkkikJBnAHWDHnJk6GyISaySmv045nQyDPVU1rgw8qExO7QvOrx99agipRrqyRifhMnaTz/2Smc0MA1z7BolpcCJFxo68sOAXHJqJZ+KUO23PVQUJvNp9LRLVBZ7R4g1Ci9Vo2J0n9DdhKCF5kyDmLI5d2gATtMr0zYHZDD5GWALGMoSpNiXeTJASNZBAfLtZka3OVeNUePA3apBhF310uLbMa4/5CaJnCxEQJU+BaAA6PM8JcydZ2/ebcJkgU5MuJe1s5drvHzYhJBNHK+XIxd3iYIxkMx1qKxB1CdJ2m2S/kF40Kjo6jPt4RRcHc5m5hkGm57uv64naXQgsofTcbynYtNknBFdruuSDybqw42L8P5CQMomwEyEgI0frDXvWkmlRFFZCCVRl6sOIz/AFNCTBjLjRWWrgP8k1M0YpZws0qCh7uq83nb0hn/QbRN81/lZ0ZxiI95lq5bx4a+vOCviYeOCfz3118X7b1Gj07YkNrFyrysV9JeBmbQUHwMdn+GCsQ0cv0tWeWr0W7i5GNqq7llLzhcBrauI+PqJQLOHMbQmm+v3B5uAf4o/zQNbnHVt7iVBGQJvpFnPdzlMnQy8h2/w8ZaDFsF+15s9wPxCll/Wqnxk/7Ww/+1yvMFiSp77r8vHuYOBAvTb4HrtANm6OYuyHDxlikgBEio+oxLo7QAizjMqnnT15CYz8XdyWG5v1onNM9KzPmQY5faLM5R1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(396003)(346002)(136003)(376002)(451199018)(2906002)(82960400001)(38070700005)(478600001)(83380400001)(71200400001)(26005)(186003)(6506007)(6512007)(36756003)(38100700002)(966005)(6486002)(5660300002)(30864003)(41300700001)(66476007)(122000001)(64756008)(66556008)(66446008)(66946007)(76116006)(8936002)(6916009)(8676002)(4326008)(91956017)(7406005)(7416002)(86362001)(54906003)(2616005)(316002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YytTQnFIa2owVkJnWVZZVk1VOVdaU2lGd3NGd3FBZmYyakZySHlYOFFJUDZl?=
 =?utf-8?B?NUtLcUYzejhKQWYydU5Ma2xCODloTFBBZWU1YUMrNDBjR2dYV1VycVVock5v?=
 =?utf-8?B?Z1ZTakdjdDhkKzl5MjhKb1o1WHRGekZhU25xZHRmS3UrRktBQWQ2NEljMUZ5?=
 =?utf-8?B?Z3EydVNCMjhzdWpDZXlWWlV5SXh0R2J2MW03YnZoejlJWGdJTzJVK000bjRH?=
 =?utf-8?B?MDBIL2xZTXRjOTRHb3JEUktoM1p5UVZMK1dxdWlwakxkN2JpSFRZMS9jOHp1?=
 =?utf-8?B?OGVvZ3NYNlVHUEZJYkhvaURjcEtlWEQ2THM3NU5JNGY4dFY4Zkl3bk5pRjRB?=
 =?utf-8?B?c05ON2d0Wnh1L095bGZDYlIwWWdFMVNYTlVDMlAzbTlTbEtRemgzU0VXMWJz?=
 =?utf-8?B?UmwzcVNSOFgzQTdzWnRaUFFvMFg4TE1wc0daQXpSRktBRU5NUlhGdGQrQm1s?=
 =?utf-8?B?djBhMGNJTE1KOWd6d1VHSDdac2FBeEdwd3JGek1oMHlQWlN0ZU9kWFRrUUw2?=
 =?utf-8?B?eC94anMvNDVGY0wvQzRTa2Q2bWlyL2xTNndDem5rZkc3WHVCNWQwaGcvQ2Vj?=
 =?utf-8?B?YlcrUWtJKzFsTVRFSnRXSUZNZ2FmdW11NENRVk81ZTBMNDFaSEtONm9SdG1u?=
 =?utf-8?B?dUYwUEtjdEpFbnQzSE83czZHN0d1MXMyYUJ0Rm1FZThDWWt3R29wSVA0K1N4?=
 =?utf-8?B?cUJUbnRQdGlYV2dWSjlrR3h4eThUZlhmcldBMzQxSG9qUzFkRUU3Mnd0dk0v?=
 =?utf-8?B?YjREU2FicmZUT055R0NmUkoyNEU2aGYyU0pnZjhTUmZyWmIrc1lRMTVLSkhj?=
 =?utf-8?B?clExeUJQYW91dUtDL0o3RXRVVGdoVFRtWVZSYVZaNHF0dGVxZXFqcGZDZUtv?=
 =?utf-8?B?K1NnTFpYTklNWkJGUnJTMGJNRzIrZkRTUjZBR1ZGN3JYamNBd09mbnZmaU5F?=
 =?utf-8?B?SVlCalZ3amVvSkhnN1RtSGpPVDdjUjI1d1hnUXAwSnd6cnptQWpPSUp0RFQy?=
 =?utf-8?B?alVwVjVPZTFyRkl0b2FhcVVhbDBzd0tVMTJRUVBxczBISFQ3THBGV3lGd3hI?=
 =?utf-8?B?ckhPQ01VNjM0a1czZlhiVmhqUllic09iSTE5N3lRcmFGV3o1Sy9QMUVnMG00?=
 =?utf-8?B?MkFRZW8zL0NweTk0U3lvMDhxYXBYcEROaXVkckRoeFplclZVbUNMeHVHS2cw?=
 =?utf-8?B?d1RXL2taMTdCTTliNXFJMHBZTERsUlBFS0szcEFrZ3kwcXkraFliRTRrbVJq?=
 =?utf-8?B?dDNoc2c3bStqUzNOQUwrOUJaYUh4S09JSzZIdE1lRXU2Zi9HTEdnb3dFTE5t?=
 =?utf-8?B?eWJla3haVWcxRjdWM0VIcHZxd1pwY0N4YzhsdjZ0cW8rUkJXZEdEMkxtNlBp?=
 =?utf-8?B?NUEyVXdOYW1qU3lOSzRXdnJtU01XRTBxd2VLd3hqSW1ETVExYmlYcVNBeEhF?=
 =?utf-8?B?dU5SMERzTW4vaHRMUXRhS050cG1VMndwT2FUQ2daWXFCZ254eWlKaGZkUkd4?=
 =?utf-8?B?NVJpTlZxOVk3QUZxd21BaHJ4am1Sc1Rzemw4UURHZWVONG1EckhXQjB4QndY?=
 =?utf-8?B?UG5iUXV0VEM4QzJ5ZS81TEN5ZVJiQ0tBeWJOSVpvTG5wWEw1R1QxNGF5ampx?=
 =?utf-8?B?cjNBbnAvOHZJdGZRUC9td0tZN2VKaUN1OUI1Smw1TXBWSzVwVkVvcEdIcGEx?=
 =?utf-8?B?OXVaU2hmbW5DNGw1bFpzUlh2OUV4SDhMMjlUYkIwS1FTekZhVlJVcWNQVXJE?=
 =?utf-8?B?Y1Bud2JDR0RGYTNOT0ZveW5YczVoVGtqR2lGSndKczFYdWdmL3FhZ0RPTzlD?=
 =?utf-8?B?Y2dXaXkwaS9oSXJEKzVYdVg4RGhWSmtPK0xTUXJDc1J0KzFsT2pGTWpETXM2?=
 =?utf-8?B?RkEyMWlQSEJ6SmlZUEVhYkVudjJPcXNWbUpEVE1KR1BDRWx5YlRDYnhpMkJN?=
 =?utf-8?B?eG5ya1hSRDk2K2h1bmROZDFYL0U5RGJOMmRDaEFDbFpVMWtLZEdGWWxwN3V5?=
 =?utf-8?B?NjlWdE1tNTYzc2FrL3hyeWwxOXJOeDJJYUZ3TWozRWlicitPdjdESjVqOWhq?=
 =?utf-8?B?VmlSeEpXN0I0cFErS08vTVg0Z2RjajRsV0t0eHgzTGE4dmRJUmtNYmRrQWNG?=
 =?utf-8?B?ZzhXRE9WTFoxOVJnUUd6OG9nOFlpY05LMjdyMUFXbVdsMkdqWUh0VVdoN296?=
 =?utf-8?Q?s6u4DQAF5AT6JcxHJ7jvdJs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E64AD030E31EB64994245037B30C6F7F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e235e52e-1f69-4933-361b-08db0e27d52b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 01:07:24.5636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1nSR6sa8NvOHurxTRw9Snx49Olp63ncJW4cDkYu1iqvK7g6REViUfHhBh0M3H1kpLTxXVB4JOmaCXsgW9O5bLCkY9FbSc6o3oAWV1v4Bxk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7298
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIzLTAyLTEzIGF0IDE2OjA5IC0wODAwLCBEZWVwYWsgR3VwdGEgd3JvdGU6DQo+
IFNpbmNlIEkndmUgYSBnZW5lcmFsIHF1ZXN0aW9uIG9uIG91dGNvbWUgb2YgZGlzY3Vzc2lvbiBv
ZiBob3cgdG8NCj4gaGFuZGxlDQo+IGBwdGVfbWt3cml0ZWAsIHNvIEkgYW0gdG9wIHBvc3Rpbmcu
DQo+IA0KPiBJIGhhdmUgcG9zdGVkIHBhdGNoZXMgeWVzdGVyZGF5IHRhcmdldGluZyByaXNjdiB6
aXNzbHBjZmkgZXh0ZW5zaW9uLg0KPiANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAy
MzAyMTMwNDUzNTEuMzk0NTgyNC0xLWRlYnVnQHJpdm9zaW5jLmNvbS8NCj4gDQo+IFNpbmNlIHRo
ZXJlJ3JlIHNpbWlsYXJpdGllcyBpbiBleHRlbnNpb24ocyksIHBhdGNoZXMgaGF2ZSBzaW1pbGFy
aXR5DQo+IHRvby4NCj4gT25lIG9mIHRoZSBzaW1pbGFyaXR5IHdhcyB1cGRhdGluZyBgbWF5YmVf
bWt3cml0ZWAuIEkgd2FzIGFza2VkIChieQ0KPiBkaGlsZGVuYg0KPiBvbiBteSBwYXRjaCAjMTEp
IHRvIGxvb2sgYXQgeDg2IGFwcHJvYWNoIG9uIGhvdyB0byBhcHByb2FjaCB0aGlzIHNvDQo+IHRo
YXQNCj4gY29yZS1tbSBhcHByb2FjaCBmaXRzIG11bHRpcGxlIGFyY2hpdGVjdHVyZXMgYWxvbmcg
d2l0aCB0aGUgbmVlZCB0bw0KPiB1cGRhdGUgYHB0ZV9ta3dyaXRlYCB0byBjb25zdW1lIHZtYSBm
bGFncy4NCj4gSW4geDg2IENFVCBwYXRjaCBzZXJpZXMsIEkgc2VlIHRoYXQgbG9jYXRpb25zIHdo
ZXJlIGBwdGVfbWt3cml0ZWAgaXMNCj4gaW52b2tlZCBhcmUgdXBkYXRlZCB0byBjaGVjayBmb3Ig
c2hhZG93IHN0YWNrIHZtYSBhbmQgbm90IG5lY2Vzc2FyaWx5DQo+IGBwdGVfbWt3cml0ZWAgaXRz
ZWxmIGlzIHVwZGF0ZWQgdG8gY29uc3VtZSB2bWEgZmxhZ3MuIExldCBtZSBrbm93IGlmDQo+IG15
DQo+IHVuZGVyc3RhbmRpbmcgaXMgY29ycmVjdCBhbmQgdGhhdCdzIHRoZSBjdXJyZW50IGRpcmVj
dGlvbiAodG8gdXBkYXRlDQo+IGNhbGwgc2l0ZXMgZm9yIHZtYSBjaGVjayB3aGVyZSBgcHRlX21r
d3JpdGVgIGlzIGludm9rZWQpDQo+IA0KPiBCZWluZyBzYWlkIHRoYXQgYXMgSSd2ZSBtZW50aW9u
ZWQgaW4gbXkgcGF0Y2ggc2VyaWVzIHRoYXQgdGhlcmUncmUNCj4gc2ltaWxhcml0aWVzIGJldHdl
ZW4geDg2LCBhcm0gYW5kIG5vdyByaXNjdiBmb3IgaW1wbGVtZW50aW5nIHNoYWRvdw0KPiBzdGFj
aw0KPiBhbmQgaW5kaXJlY3QgYnJhbmNoIHRyYWNraW5nLCBvdmVyYWxsIGl0J2xsIGJlIGEgZ29v
ZCB0aGluZyBpZiB3ZSBjYW4NCj4gY29sbGFib3JhdGUgYW5kIGNvbWUgdXAgd2l0aCBjb21tb24g
Yml0cy4NCg0KT2ggaW50ZXJlc3RpbmcuIEkndmUgbWFkZSB0aGUgY2hhbmdlcyB0byBoYXZlIHB0
ZV9ta3dyaXRlKCkgdGFrZSBhIFZNQS4NCkl0IHNlZW1zIHRvIHdvcmsgcHJldHR5IHdlbGwgd2l0
aCB0aGUgY29yZSBNTSBjb2RlLCBidXQgSSdtIGxldHRpbmcgMC0NCmRheSBjaGV3IG9uIGl0IGZv
ciBhIGJpdCBiZWNhdXNlIGl0IHRvdWNoZWQgc28gbWFueSBhcmNoJ3MuIEknbGwNCmluY2x1ZGUg
eW91IHdoZW4gSSBzZW5kIGl0IG91dCwgaG9wZWZ1bGx5IGxhdGVyIHRoaXMgd2Vlay4NCg0KRnJv
bSBqdXN0IGEgcXVpY2sgbG9vaywgSSBzZWUgc29tZSBkZXNpZ24gYXNwZWN0cyB0aGF0IGhhdmUg
YmVlbg0KcHJvYmxlbWF0aWMgb24gdGhlIHg4NiBpbXBsZW1lbnRhdGlvbi4NCg0KVGhlcmUgd2Fz
IHNvbWV0aGluZyBsaWtlIFBST1RfU0hBRE9XX1NUQUNLIGJlZm9yZSwgYnV0IHRoZXJlIHdlcmUg
dHdvDQpwcm9ibGVtczoNCjEuIFdyaXRhYmxlIHdpbmRvd3Mgd2hpbGUgcHJvdmlzaW9uaW5nIHJl
c3RvcmUgdG9rZW5zIChtYXliZSB0aGlzIGlzDQpqdXN0IGFuIHg4NiB0aGluZykNCjIuIEFkZGlu
ZyBndWFyZCBwYWdlcyB3aGVuIGEgc2hhZG93IHN0YWNrIHdhcyBtcHJvdGVjdCgpZWQgdG8gY2hh
bmdlIGl0DQpmcm9tIHdyaXRhYmxlIHRvIHNoYWRvdyBzdGFjay4gQWdhaW4gdGhpcyBtaWdodCBi
ZSBhbiB4ODYgbmVlZCwgc2luY2UNCml0IG5lZWRlZCB0byBoYXZlIGl0IHdyaXRhYmxlIHRvIGFk
ZCBhIHJlc3RvcmUgdG9rZW4sIGFuZCB0aGUgZ3VhcmQNCnBhZ2VzIGhlbHAgd2l0aCBzZWN1cml0
eS4NCg0KU28gaW5zdGVhZCB0aGlzIHNlcmllcyBjcmVhdGVzIGEgbWFwX3NoYWRvd19zdGFjayBz
eXNjYWxsIHRoYXQgbWFwcyBhDQpzaGFkb3cgc3RhY2sgYW5kIHdyaXRlcyB0aGUgdG9rZW4gZnJv
bSB0aGUga2VybmVsIHNpZGUuIFRoZW4gbXByb3RlY3QoKQ0KaXMgcHJldmVudGVkIGZyb20gbWFr
aW5nIHNoYWRvdyBzdGFjaydzIGNvbnZlbnRpb25hbGx5IHdyaXRhYmxlLg0KDQphbm90aGVyIGRp
ZmZlcmVuY2UgaXMgZW5hYmxpbmcgc2hhZG93IHN0YWNrIGJhc2VkIG9uIGVsZiBoZWFkZXIgYml0
cw0KaW5zdGVhZCBvZiB0aGUgYXJjaF9wcmN0bCgpcy4gU2VlIHRoZSBoaXN0b3J5IGFuZCByZWFz
b25pbmcgaGVyZQ0KKHNlY3Rpb24gIlN3aXRjaCBFbmFibGluZyBJbnRlcmZhY2UiKToNCg0KaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMDEzMDIxMTgzOC44MzgyLTEtcmljay5wLmVk
Z2Vjb21iZUBpbnRlbC5jb20vDQoNCk5vdCBzdXJlIGlmIHRob3NlIHR3byBpc3N1ZXMgd291bGQg
YmUgcHJvYmxlbXMgb24gcmlzY3Ygb3Igbm90Lg0KDQpGb3Igc2hhcmluZyB0aGUgcHJjdGwoKSBp
bnRlcmZhY2UuIFRoZSBvdGhlciB0aGluZyBpcyB0aGF0IHg4NiBhbHNvIGhhcw0KdGhpcyAid3Jz
cyIgaW5zdHJ1Y3Rpb24gdGhhdCBjYW4gYmUgZW5hYmxlZCB3aXRoIHNoYWRvdyBzdGFjay4gVGhl
DQpjdXJyZW50IGFyY2hfcHJjdGwoKSBpbnRlcmZhY2Ugc3VwcG9ydHMgYm90aC4gSSdtIHRoaW5r
aW5nIGl0J3MNCnByb2JhYmx5IGEgcHJldHR5IGFyY2gtc3BlY2lmaWMgdGhpbmcuDQoNCkFCSS13
aXNlLCBhcmUgeW91IHBsYW5uaW5nIHRvIGF1dG9tYXRpY2FsbHkgYWxsb2NhdGUgc2hhZG93IHN0
YWNrcyBmb3INCm5ldyB0YXNrcz8gSWYgdGhlIEFCSSBpcyBjb21wbGV0ZWx5IGRpZmZlcmVudCBp
dCBtaWdodCBiZSBiZXN0IHRvIG5vdA0Kc2hhcmUgdXNlciBpbnRlcmZhY2VzLiBCdXQgYWxzbywg
SSB3b25kZXIgd2h5IGlzIGl0IGRpZmZlcmVudC4NCg0KPiANCj4gDQo+IFJlc3QgaW5saW5lLg0K
PiANCj4gDQo+IE9uIFRodSwgSmFuIDE5LCAyMDIzIGF0IDAxOjIyOjU3UE0gLTA4MDAsIFJpY2sg
RWRnZWNvbWJlIHdyb3RlOg0KPiA+IEZyb206IFl1LWNoZW5nIFl1IDx5dS1jaGVuZy55dUBpbnRl
bC5jb20+DQo+ID4gDQo+ID4gVGhlIHg4NiBDb250cm9sLWZsb3cgRW5mb3JjZW1lbnQgVGVjaG5v
bG9neSAoQ0VUKSBmZWF0dXJlIGluY2x1ZGVzDQo+ID4gYSBuZXcNCj4gPiB0eXBlIG9mIG1lbW9y
eSBjYWxsZWQgc2hhZG93IHN0YWNrLiBUaGlzIHNoYWRvdyBzdGFjayBtZW1vcnkgaGFzDQo+ID4g
c29tZQ0KPiA+IHVudXN1YWwgcHJvcGVydGllcywgd2hpY2ggcmVxdWlyZXMgc29tZSBjb3JlIG1t
IGNoYW5nZXMgdG8gZnVuY3Rpb24NCj4gPiBwcm9wZXJseS4NCj4gPiANCj4gPiBXaXRoIHRoZSBp
bnRyb2R1Y3Rpb24gb2Ygc2hhZG93IHN0YWNrIG1lbW9yeSB0aGVyZSBhcmUgdHdvIHdheXMgYQ0K
PiA+IHB0ZSBjYW4NCj4gPiBiZSB3cml0YWJsZTogcmVndWxhciB3cml0YWJsZSBtZW1vcnkgYW5k
IHNoYWRvdyBzdGFjayBtZW1vcnkuDQo+ID4gDQo+ID4gSW4gcGFzdCBwYXRjaGVzLCBtYXliZV9t
a3dyaXRlKCkgaGFzIGJlZW4gdXBkYXRlZCB0byBhcHBseQ0KPiA+IHB0ZV9ta3dyaXRlKCkNCj4g
PiBvciBwdGVfbWt3cml0ZV9zaHN0aygpIGRlcGVuZGluZyBvbiB0aGUgVk1BIGZsYWcuIFRoaXMg
Y292ZXJzIG1vc3QNCj4gPiBjYXNlcw0KPiA+IHdoZXJlIGEgUFRFIGlzIG1hZGUgd3JpdGFibGUu
IEhvd2V2ZXIsIHRoZXJlIGFyZSBwbGFjZXMgd2hlcmUNCj4gPiBwdGVfbWt3cml0ZSgpDQo+ID4g
aXMgY2FsbGVkIGRpcmVjdGx5IGFuZCB0aGUgbG9naWMgc2hvdWxkIG5vdyBhbHNvIGNyZWF0ZSBh
IHNoYWRvdw0KPiA+IHN0YWNrIFBURQ0KPiA+IGluIHRoZSBjYXNlIG9mIGEgc2hhZG93IHN0YWNr
IFZNQS4NCj4gPiANCj4gPiAtIGRvX2Fub255bW91c19wYWdlKCkgYW5kIG1pZ3JhdGVfdm1hX2lu
c2VydF9wYWdlKCkgY2hlY2sgVk1fV1JJVEUNCj4gPiAgZGlyZWN0bHkgYW5kIGNhbGwgcHRlX21r
d3JpdGUoKS4gVGVhY2ggaXQgYWJvdXQNCj4gPiBwdGVfbWt3cml0ZV9zaHN0aygpDQo+ID4gDQo+
ID4gLSBXaGVuIHVzZXJmYXVsdGZkIGlzIGNyZWF0aW5nIGEgUFRFIGFmdGVyIHVzZXJzcGFjZSBo
YW5kbGVzIHRoZQ0KPiA+IGZhdWx0DQo+ID4gIGl0IGNhbGxzIHB0ZV9ta3dyaXRlKCkgZGlyZWN0
bHkuIFRlYWNoIGl0IGFib3V0DQo+ID4gcHRlX21rd3JpdGVfc2hzdGsoKQ0KPiA+IA0KPiA+IFRv
IG1ha2UgdGhlIGNvZGUgY2xlYW5lciwgaW50cm9kdWNlIGlzX3Noc3RrX3dyaXRlKCkgd2hpY2gN
Cj4gPiBzaW1wbGlmaWVzDQo+ID4gY2hlY2tpbmcgZm9yIFZNX1dSSVRFIHwgVk1fU0hBRE9XX1NU
QUNLIHRvZ2V0aGVyLg0KPiA+IA0KPiA+IEluIG90aGVyIGNhc2VzIHdoZXJlIHB0ZV9ta3dyaXRl
KCkgaXMgY2FsbGVkIGRpcmVjdGx5LCB0aGUgVk1BIHdpbGwNCj4gPiBub3QNCj4gPiBiZSBWTV9T
SEFET1dfU1RBQ0ssIGFuZCBzbyBzaGFkb3cgc3RhY2sgbWVtb3J5IHNob3VsZCBub3QgYmUNCj4g
PiBjcmVhdGVkLg0KPiA+IC0gSW4gdGhlIGNhc2Ugb2YgcHRlX3NhdmVkd3JpdGUoKSwgc2hhZG93
IHN0YWNrIFZNQSdzIGFyZSBleGNsdWRlZC4NCj4gPiAtIEluIHRoZSBjYXNlIG9mIHRoZSAiZGly
dHlfYWNjb3VudGFibGUiIG9wdGltaXphdGlvbiBpbg0KPiA+IG1wcm90ZWN0KCksDQo+ID4gICBz
aGFkb3cgc3RhY2sgVk1BJ3Mgd29uJ3QgYmUgVk1fU0hBUkVELCBzbyBpdCBpcyBub3QgbmVjZXNz
YXJ5Lg0KPiA+IA0KPiA+IFRlc3RlZC1ieTogUGVuZ2ZlaSBYdSA8cGVuZ2ZlaS54dUBpbnRlbC5j
b20+DQo+ID4gVGVzdGVkLWJ5OiBKb2huIEFsbGVuIDxqb2huLmFsbGVuQGFtZC5jb20+DQo+ID4g
U2lnbmVkLW9mZi1ieTogWXUtY2hlbmcgWXUgPHl1LWNoZW5nLnl1QGludGVsLmNvbT4NCj4gPiBD
by1kZXZlbG9wZWQtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBp
bnRlbC5jb20+DQo+ID4gQ2M6IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPg0KPiA+
IC0tLQ0KPiA+IA0KPiA+IHY1Og0KPiA+IC0gRml4IHR5cG8gaW4gY29tbWl0IGxvZw0KPiA+IA0K
PiA+IHYzOg0KPiA+IC0gUmVzdG9yZSBkb19hbm9ueW1vdXNfcGFnZSgpIHRoYXQgYWNjaWRldGFs
bHkgbW92ZWQgY29tbWl0cw0KPiA+IChLaXJpbGwpDQo+ID4gLSBPcGVuIGNvZGUgbWF5YmVfbWt3
cml0ZSgpIGNhc2VzIGZyb20gdjIsIHNvIHRoZSBiZWhhdmlvciBkb2Vzbid0DQo+ID4gY2hhbmdl
DQo+ID4gICB0byBtYXJrIHRoYXQgbm9uLXdyaXRhYmxlIFBURXMgZGlydHkuIChOYWRhdikNCj4g
PiANCj4gPiB2MjoNCj4gPiAtIFVwZGF0ZWQgY29tbWl0IGxvZyB3aXRoIGNvbW1lbnQncyBmcm9t
IERhdmUgSGFuc2VuDQo+ID4gLSBEYXZlIGFsc28gc3VnZ2VzdGVkIChJIHVuZGVyc3Rvb2QpIHRv
IG1heWJlIHR3ZWFrDQo+ID4gdm1fZ2V0X3BhZ2VfcHJvdCgpDQo+ID4gICB0byBhdm9pZCBoYXZp
bmcgdG8gY2FsbCBtYXliZV9ta3dyaXRlKCkuIEFmdGVyIHBsYXlpbmcgYXJvdW5kDQo+ID4gd2l0
aA0KPiA+ICAgdGhpcyBJIG9wdGVkIHRvICpub3QqIGRvIHRoaXMuIFNoYWRvdyBzdGFjayBtZW1v
cnkgbWVtb3J5IGlzDQo+ID4gICBlZmZlY3RpdmVseSB3cml0YWJsZSwgc28gaGF2aW5nIHRoZSBk
ZWZhdWx0IHBlcm1pc3Npb25zIGJlDQo+ID4gd3JpdGFibGUNCj4gPiAgIGVuZGVkIHVwIG1hcHBp
bmcgdGhlIHplcm8gcGFnZSBhcyB3cml0YWJsZSBhbmQgb3RoZXIgc3VycHJpc2VzLg0KPiA+IFNv
DQo+ID4gICBjcmVhdGluZyBzaGFkb3cgc3RhY2sgbWVtb3J5IG5lZWRzIHRvIGJlIGRvbmUgd2l0
aCBtYW51YWwgbG9naWMNCj4gPiAgIGxpa2UgcHRlX21rd3JpdGUoKS4NCj4gPiAtIERyb3AgY2hh
bmdlIGluIGNoYW5nZV9wdGVfcmFuZ2UoKSBiZWNhdXNlIGl0IGNvdWxkbid0IGFjdHVhbGx5DQo+
ID4gdHJpZ2dlcg0KPiA+ICAgZm9yIHNoYWRvdyBzdGFjayBWTUFzLg0KPiA+IC0gQ2xhcmlmeSBy
ZWFzb25pbmcgZm9yIHNraXBwZWQgY2FzZXMgb2YgcHRlX21rd3JpdGUoKS4NCj4gPiANCj4gPiBZ
dS1jaGVuZyB2MjU6DQo+ID4gLSBBcHBseSBzYW1lIGNoYW5nZXMgdG8gZG9faHVnZV9wbWRfbnVt
YV9wYWdlKCkgYXMgdG8NCj4gPiBkb19udW1hX3BhZ2UoKS4NCj4gPiANCj4gPiBhcmNoL3g4Ni9p
bmNsdWRlL2FzbS9wZ3RhYmxlLmggfCAgMyArKysNCj4gPiBhcmNoL3g4Ni9tbS9wZ3RhYmxlLmMg
ICAgICAgICAgfCAgNiArKysrKysNCj4gPiBpbmNsdWRlL2xpbnV4L3BndGFibGUuaCAgICAgICAg
fCAgNyArKysrKysrDQo+ID4gbW0vbWVtb3J5LmMgICAgICAgICAgICAgICAgICAgIHwgIDUgKysr
Ky0NCj4gPiBtbS9taWdyYXRlX2RldmljZS5jICAgICAgICAgICAgfCAgNCArKystDQo+ID4gbW0v
dXNlcmZhdWx0ZmQuYyAgICAgICAgICAgICAgIHwgMTAgKysrKysrKy0tLQ0KPiA+IDYgZmlsZXMg
Y2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZm
IC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vcGd0YWJsZS5oDQo+ID4gYi9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9wZ3RhYmxlLmgNCj4gPiBpbmRleCA0NWIxYThmMDU4ZmUuLjg3ZDMwNjg3MzRl
YyAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZ3RhYmxlLmgNCj4gPiAr
KysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZ3RhYmxlLmgNCj4gPiBAQCAtOTUxLDYgKzk1MSw5
IEBAIHN0YXRpYyBpbmxpbmUgcGdkX3QgcHRpX3NldF91c2VyX3BndGJsKHBnZF90DQo+ID4gKnBn
ZHAsIHBnZF90IHBnZCkNCj4gPiB9DQo+ID4gI2VuZGlmICAvKiBDT05GSUdfUEFHRV9UQUJMRV9J
U09MQVRJT04gKi8NCj4gPiANCj4gPiArI2RlZmluZSBpc19zaHN0a193cml0ZSBpc19zaHN0a193
cml0ZQ0KPiA+ICtleHRlcm4gYm9vbCBpc19zaHN0a193cml0ZSh1bnNpZ25lZCBsb25nIHZtX2Zs
YWdzKTsNCj4gPiArDQo+ID4gI2VuZGlmCS8qIF9fQVNTRU1CTFlfXyAqLw0KPiA+IA0KPiA+IA0K
PiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9tbS9wZ3RhYmxlLmMgYi9hcmNoL3g4Ni9tbS9wZ3Rh
YmxlLmMNCj4gPiBpbmRleCBlNGY0OTllYjBmMjkuLmQxMDM5NDViYTUwMiAxMDA2NDQNCj4gPiAt
LS0gYS9hcmNoL3g4Ni9tbS9wZ3RhYmxlLmMNCj4gPiArKysgYi9hcmNoL3g4Ni9tbS9wZ3RhYmxl
LmMNCj4gPiBAQCAtODgwLDMgKzg4MCw5IEBAIGludCBwbWRfZnJlZV9wdGVfcGFnZShwbWRfdCAq
cG1kLCB1bnNpZ25lZCBsb25nDQo+ID4gYWRkcikNCj4gPiANCj4gPiAjZW5kaWYgLyogQ09ORklH
X1g4Nl82NCAqLw0KPiA+ICNlbmRpZgkvKiBDT05GSUdfSEFWRV9BUkNIX0hVR0VfVk1BUCAqLw0K
PiA+ICsNCj4gPiArYm9vbCBpc19zaHN0a193cml0ZSh1bnNpZ25lZCBsb25nIHZtX2ZsYWdzKQ0K
PiA+ICt7DQo+ID4gKwlyZXR1cm4gKHZtX2ZsYWdzICYgKFZNX1NIQURPV19TVEFDSyB8IFZNX1dS
SVRFKSkgPT0NCj4gPiArCSAgICAgICAoVk1fU0hBRE9XX1NUQUNLIHwgVk1fV1JJVEUpOw0KPiA+
ICt9DQo+IA0KPiBDYW4gd2UgY2FsbCB0aGlzIGZ1bmN0aW9uIHNvbWV0aGluZyBhbG9uZyB0aGUg
bGluZXMNCj4gYGlzX3NoYWRvd19zdGFja192bWFgPw0KPiBSZWFzb24gYmVpbmcsIHdlJ3JlIGFj
dHVhbGx5IGNoZWNraW5nIGZvciB2bWEgcHJvcGVydHkgaGVyZS4NCj4gDQo+IEFsc28gY2FuIHdl
IG1vdmUgdGhpcyBpbnRvIGNvbW1vbiBjb2RlPyBDb21tb24gY29kZSBjYW4gdGhlbiBmdXJ0aGVy
DQo+IGNhbGwgIA0KPiBgYXJjaF9pc19zaGFkb3dfc3RhY2tfdm1hYC4gUmVzcGVjdGl2ZSBhcmNo
IGNhbiBpbXBsZW1lbnQgdGhlaXIgb3duDQo+IHNoYWRvdw0KPiBzdGFjayBlbmNvZGluZy4gSSBz
ZWUgdGhhdCB4ODYgaXMgdXNpbmcgb25lIG9mIHRoZSBhcmNoIGJpdC4gQ3VycmVudA0KPiByaXNj
dg0KPiBpbXBsZW1lbnRhdGlvbiB1c2VzIHByZXNlbmNlIG9mIG9ubHkgYFZNX1dSSVRFYCBhcyBz
aGFkb3cgc3RhY2sNCj4gZW5jb2RpbmcuDQoNCkluIHRoZSBuZXh0IHZlcnNpb24gSSd2ZSBzdWNj
ZXNzZnVsbHkgbW92ZWQgYWxsIG9mIHRoZSBzaGFkb3cgc3RhY2sNCmJpdHMgb3V0IG9mIGNvcmUg
TU0uIEl0IGRvZXNuJ3QgbmVlZCBpc19zaHN0a193cml0ZSgpIGFmdGVyIHRoZQ0KcHRlX21rd3Jp
dGUoKSBjaGFuZ2UsIGFuZCBjaGFuZ2luZyB0aGlzIG90aGVyIG9uZToNCg0KaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGttbC8yMDIzMDExOTIxMjMxNy44MzI0LTI2LXJpY2sucC5lZGdlY29tYmVA
aW50ZWwuY29tLw0KRm9yIHRoYXQgSSBhZGRlZCBhbiBhcmNoX2NoZWNrX3phcHBlZF9wdGUoKSB3
aGljaCBhbiBhcmNoIGNhbiB1c2UgdG8NCmFkZCB3YXJuaW5ncy4NCg0KU28gSSB3b25kZXIgaWYg
cmlzY3Ygd29uJ3QgbmVlZCBhbnl0aGluZyBlaXRoZXI/DQoNCj4gDQo+IFBsZWFzZSBzZWUgcGF0
Y2ggIzExIGFuZCAjMTIgaW4gdGhlIHNlcmllcyBJIHBvc3RlZCAoVVJMIGF0IHRoZSB0b3ANCj4g
b2YNCj4gdGhpcyBlLW1haWwpLg0KPiANCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvcGd0YWJsZS5oIGIvaW5jbHVkZS9saW51eC9wZ3RhYmxlLmgNCj4gPiBpbmRleCAxNGE4MjBh
NDVhMzcuLjQ5Y2UxZjA1NTI0MiAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3BndGFi
bGUuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvcGd0YWJsZS5oDQo+ID4gQEAgLTE1NzgsNiAr
MTU3OCwxMyBAQCBzdGF0aWMgaW5saW5lIGJvb2wNCj4gPiBhcmNoX2hhc19wZm5fbW9kaWZ5X2No
ZWNrKHZvaWQpDQo+ID4gfQ0KPiA+ICNlbmRpZiAvKiAhX0hBVkVfQVJDSF9QRk5fTU9ESUZZX0FM
TE9XRUQgKi8NCj4gPiANCj4gPiArI2lmbmRlZiBpc19zaHN0a193cml0ZQ0KPiA+ICtzdGF0aWMg
aW5saW5lIGJvb2wgaXNfc2hzdGtfd3JpdGUodW5zaWduZWQgbG9uZyB2bV9mbGFncykNCj4gPiAr
ew0KPiA+ICsJcmV0dXJuIGZhbHNlOw0KPiA+ICt9DQo+ID4gKyNlbmRpZg0KPiA+ICsNCj4gPiAv
Kg0KPiA+ICAqIEFyY2hpdGVjdHVyZSBQQUdFX0tFUk5FTF8qIGZhbGxiYWNrcw0KPiA+ICAqDQo+
ID4gZGlmZiAtLWdpdCBhL21tL21lbW9yeS5jIGIvbW0vbWVtb3J5LmMNCj4gPiBpbmRleCBhYWQy
MjZkYWY0MWIuLjVlNTEwNzIzMmEyNiAxMDA2NDQNCj4gPiAtLS0gYS9tbS9tZW1vcnkuYw0KPiA+
ICsrKyBiL21tL21lbW9yeS5jDQo+ID4gQEAgLTQwODgsNyArNDA4OCwxMCBAQCBzdGF0aWMgdm1f
ZmF1bHRfdCBkb19hbm9ueW1vdXNfcGFnZShzdHJ1Y3QNCj4gPiB2bV9mYXVsdCAqdm1mKQ0KPiA+
IA0KPiA+IAllbnRyeSA9IG1rX3B0ZShwYWdlLCB2bWEtPnZtX3BhZ2VfcHJvdCk7DQo+ID4gCWVu
dHJ5ID0gcHRlX3N3X21reW91bmcoZW50cnkpOw0KPiA+IC0JaWYgKHZtYS0+dm1fZmxhZ3MgJiBW
TV9XUklURSkNCj4gPiArDQo+ID4gKwlpZiAoaXNfc2hzdGtfd3JpdGUodm1hLT52bV9mbGFncykp
DQo+ID4gKwkJZW50cnkgPSBwdGVfbWt3cml0ZV9zaHN0ayhwdGVfbWtkaXJ0eShlbnRyeSkpOw0K
PiA+ICsJZWxzZSBpZiAodm1hLT52bV9mbGFncyAmIFZNX1dSSVRFKQ0KPiA+IAkJZW50cnkgPSBw
dGVfbWt3cml0ZShwdGVfbWtkaXJ0eShlbnRyeSkpOw0KPiA+IA0KPiA+IAl2bWYtPnB0ZSA9IHB0
ZV9vZmZzZXRfbWFwX2xvY2sodm1hLT52bV9tbSwgdm1mLT5wbWQsIHZtZi0NCj4gPiA+YWRkcmVz
cywNCj4gPiBkaWZmIC0tZ2l0IGEvbW0vbWlncmF0ZV9kZXZpY2UuYyBiL21tL21pZ3JhdGVfZGV2
aWNlLmMNCj4gPiBpbmRleCA3MjFiMjM2NWRiY2EuLjUzZDQxNzY4M2UwMSAxMDA2NDQNCj4gPiAt
LS0gYS9tbS9taWdyYXRlX2RldmljZS5jDQo+ID4gKysrIGIvbW0vbWlncmF0ZV9kZXZpY2UuYw0K
PiA+IEBAIC02NDUsNyArNjQ1LDkgQEAgc3RhdGljIHZvaWQgbWlncmF0ZV92bWFfaW5zZXJ0X3Bh
Z2Uoc3RydWN0DQo+ID4gbWlncmF0ZV92bWEgKm1pZ3JhdGUsDQo+ID4gCQkJZ290byBhYm9ydDsN
Cj4gPiAJCX0NCj4gPiAJCWVudHJ5ID0gbWtfcHRlKHBhZ2UsIHZtYS0+dm1fcGFnZV9wcm90KTsN
Cj4gPiAtCQlpZiAodm1hLT52bV9mbGFncyAmIFZNX1dSSVRFKQ0KPiA+ICsJCWlmIChpc19zaHN0
a193cml0ZSh2bWEtPnZtX2ZsYWdzKSkNCj4gPiArCQkJZW50cnkgPSBwdGVfbWt3cml0ZV9zaHN0
ayhwdGVfbWtkaXJ0eShlbnRyeSkpOw0KPiA+ICsJCWVsc2UgaWYgKHZtYS0+dm1fZmxhZ3MgJiBW
TV9XUklURSkNCj4gPiAJCQllbnRyeSA9IHB0ZV9ta3dyaXRlKHB0ZV9ta2RpcnR5KGVudHJ5KSk7
DQo+ID4gCX0NCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvbW0vdXNlcmZhdWx0ZmQuYyBiL21tL3Vz
ZXJmYXVsdGZkLmMNCj4gPiBpbmRleCAwNDk5OTA3YjZmMWEuLjgzMmYwMjUwY2E2MSAxMDA2NDQN
Cj4gPiAtLS0gYS9tbS91c2VyZmF1bHRmZC5jDQo+ID4gKysrIGIvbW0vdXNlcmZhdWx0ZmQuYw0K
PiA+IEBAIC02Myw2ICs2Myw3IEBAIGludCBtZmlsbF9hdG9taWNfaW5zdGFsbF9wdGUoc3RydWN0
IG1tX3N0cnVjdA0KPiA+ICpkc3RfbW0sIHBtZF90ICpkc3RfcG1kLA0KPiA+IAlpbnQgcmV0Ow0K
PiA+IAlwdGVfdCBfZHN0X3B0ZSwgKmRzdF9wdGU7DQo+ID4gCWJvb2wgd3JpdGFibGUgPSBkc3Rf
dm1hLT52bV9mbGFncyAmIFZNX1dSSVRFOw0KPiA+ICsJYm9vbCBzaHN0ayA9IGRzdF92bWEtPnZt
X2ZsYWdzICYgVk1fU0hBRE9XX1NUQUNLOw0KPiA+IAlib29sIHZtX3NoYXJlZCA9IGRzdF92bWEt
PnZtX2ZsYWdzICYgVk1fU0hBUkVEOw0KPiA+IAlib29sIHBhZ2VfaW5fY2FjaGUgPSBwYWdlX21h
cHBpbmcocGFnZSk7DQo+ID4gCXNwaW5sb2NrX3QgKnB0bDsNCj4gPiBAQCAtODQsOSArODUsMTIg
QEAgaW50IG1maWxsX2F0b21pY19pbnN0YWxsX3B0ZShzdHJ1Y3QgbW1fc3RydWN0DQo+ID4gKmRz
dF9tbSwgcG1kX3QgKmRzdF9wbWQsDQo+ID4gCQl3cml0YWJsZSA9IGZhbHNlOw0KPiA+IAl9DQo+
ID4gDQo+ID4gLQlpZiAod3JpdGFibGUpDQo+ID4gLQkJX2RzdF9wdGUgPSBwdGVfbWt3cml0ZShf
ZHN0X3B0ZSk7DQo+ID4gLQllbHNlDQo+ID4gKwlpZiAod3JpdGFibGUpIHsNCj4gPiArCQlpZiAo
c2hzdGspDQo+ID4gKwkJCV9kc3RfcHRlID0gcHRlX21rd3JpdGVfc2hzdGsoX2RzdF9wdGUpOw0K
PiA+ICsJCWVsc2UNCj4gPiArCQkJX2RzdF9wdGUgPSBwdGVfbWt3cml0ZShfZHN0X3B0ZSk7DQo+
ID4gKwl9IGVsc2UNCj4gPiAJCS8qDQo+ID4gCQkgKiBXZSBuZWVkIHRoaXMgdG8gbWFrZSBzdXJl
IHdyaXRlIGJpdCByZW1vdmVkOyBhcw0KPiA+IG1rX3B0ZSgpDQo+ID4gCQkgKiBjb3VsZCByZXR1
cm4gYSBwdGUgd2l0aCB3cml0ZSBiaXQgc2V0Lg0KPiA+IC0tIA0KPiA+IDIuMTcuMQ0KPiA+IA0K
