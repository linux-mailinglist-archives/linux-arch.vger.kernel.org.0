Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707DD5F3900
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 00:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiJCW3B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 18:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiJCW2m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 18:28:42 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DE526F;
        Mon,  3 Oct 2022 15:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664836098; x=1696372098;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CF+b8b8md2zIxcDhNGsxDFi5FqMHmriijCredxi+Q5E=;
  b=FML7G1+7vDFp3FyOAj8+KUGuJ2UBn5Eh9zfoMxGt2gnMjZnjG3DMUaiW
   Ci7xcIVoOk1VpI1+F1vq3F8IEEZX0ao9B5xg6Dgwm3IAZ1LBrThPrBdCG
   wqvvOH2Tl7Hr7XuXUCi3UiY7xWw8TT2zEEPz8grG+5Jq4VIAiyJrvEQR2
   afcLf2KQYT750yWX4YlOot0G+8x6WEhVgDDpWcbAW2ZpIUlfcaC7YIxop
   KzD/feluZG1zE9rb7x8qtGajgCxsT/wzZfVJOydxy7Pjpl0Up79PDtqP/
   Mqv1PhqMH/cXhhXsROSJZMTNa3xealHuksAm+9/9dJv20gH1DzUtpCliT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="364673452"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="364673452"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 15:28:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="625966067"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="625966067"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 03 Oct 2022 15:28:16 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 15:28:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 3 Oct 2022 15:28:16 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 3 Oct 2022 15:28:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcXRCjaPjhpyzPWRl4hxN6XR8Y08hWGSxXa62y6FRWskhiFxtavICQsNiR10h8+xjvZD8lHnTXHxBpPXs9+rAeXdAQWjScuW8DdycEgybhu1I00K8+PuyDnkOtrSqGUhUk8hyNW7/FcCxmo4FQlCRVN+VQVHr3Yr9SBbjxsBeYAniSOaITWeYo14QexCkEQKqULWnX47/cA6PACQik7Z2Jmux9wE5L3B4PeZi5wpwRJP9uFLK0LgZQr3SoAUpXC8PbHoadeiEAlHnFmXpW4oKgevM3NSW5QXUYWir8Xu3kz4o/mn442yISfskTO5JNQcclDwl6UhpoMfN23F6ngdgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CF+b8b8md2zIxcDhNGsxDFi5FqMHmriijCredxi+Q5E=;
 b=I2PbLrGw7wwni+XPlHs2YuLHxDFl98UTGyIK5hT3LZ5LxlA4N9RjoM2xpr4/5CaTIS+Vv2JCK0ApzpS2os+vfkqqP1K5u+rHZg862oYxXqqZE+LZD9GP54L85TlTDC6asZbJolDvYccBVZdO9htqfICTH3EgDJ7+nKdvUqUsSRF8XSwFqBtclLXvHouDrCLvf0lgx/93FqPojb7ESpJxgRsBJ/DY1/LaGzI6tqiH5OP2qMxSwQoKKdwnhaFR/FJbUAEyokSsbZjF1rhSm8FDt4vkt1L+/V5kx5E52XqhePc6fH05md5NIOGdzuq8RjZpyrXBT1NW6u0vUaNLUEzM5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CH0PR11MB5314.namprd11.prod.outlook.com (2603:10b6:610:bd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 3 Oct
 2022 22:28:08 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 22:28:08 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "nadav.amit@gmail.com" <nadav.amit@gmail.com>
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
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 12/39] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
Thread-Topic: [PATCH v2 12/39] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
Thread-Index: AQHY1FMUATa463BSCk+10IV661tk3K38/nyAgABHr4A=
Date:   Mon, 3 Oct 2022 22:28:07 +0000
Message-ID: <64313344833c3b1701002a347d539e69276b66fb.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-13-rick.p.edgecombe@intel.com>
         <E5D7151E-B5A6-4BEA-9642-ECCFC28F8C8E@gmail.com>
In-Reply-To: <E5D7151E-B5A6-4BEA-9642-ECCFC28F8C8E@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|CH0PR11MB5314:EE_
x-ms-office365-filtering-correlation-id: bd88ab8b-8b6d-4bab-a228-08daa58e8c12
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5vf3EbArkBzItIzMFeIRUPnPdTWPu4jO8+Mkb05K/B1j5HfYR1Wa1M4mP2BENKw0Ai9+DdT2TOxCgd8Sbim71pzKEWN0BQcBwHfNMVa9FgBLoTBhFzIK73mjlHM4hFpI9vvjqmHVu49ns9DrgFqEs/E7xVjj066Pmf1cVINJ4H4vf49qZulzXCECbVXyyU+ahqiB5TYtQWtMoV9KvoEMkYHtissZ3m5Mfp0pqFvg2yOqbfiR1vmu4XZq8j11Op+X9ydKTffHanRatWgRHuj9CHx34Hmi6Q58OVia7Ez6AGukuAQhIaV/vAZZW6Y0KM6ffk+TDOjcfPhYfCH15SX8CAQ7fMm0mjU3idaVGFHwkBYE4w64W1eIylezUNrRQA7Fkvz1ybVHKhkG/6zavFwfIxEvwDALExi6+FKBZ8VkUoB1pe3aCCq7O++jQ2eWpBCyUa8TzW9UnfQ0M+OODSNs9vlOEulwnwRjg4EzKb9pCISFtEctRLU7ga2EBiXsRpxW359cDzcMVMZmYBeJ5ZKXtUsgeCBRkvpFZm4zjqa07yIXnPFEUspLRYLTa58fOzv7FThWcVLBq2WJt/sw3+WpT89qZGaJ/gqENBzx5svIOrIgYa5kbgNcMTg3OMqsM3erscJMYlakpaC0ECGtm9kifwLYHlZV4eRbXOfne7S3TLG3qGaKvPpYz03OD1w+iozaLlAQhsSfiX9VEgttlO3t38Z06Bq3Caqv2s50QUJB1tjG/vKtOsi+1inNhA3TRV2YBIlrwi+OnU5ctWImggKW0z8Tr6V6iqzbdnYMBN0PtfFIXX5YKGnn0SrFNCZOHolQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199015)(86362001)(83380400001)(5660300002)(7416002)(7406005)(2616005)(6512007)(26005)(82960400001)(71200400001)(36756003)(6486002)(54906003)(6916009)(6506007)(8936002)(316002)(66946007)(66556008)(8676002)(4326008)(66476007)(4744005)(66446008)(186003)(91956017)(76116006)(41300700001)(38070700005)(122000001)(64756008)(38100700002)(2906002)(478600001)(99106002)(14143004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWZpTTd4SnRyR1ZuUUluODlvVi82elQxdG9kUHN4V3A1UHgxUTB3bmVrUmFF?=
 =?utf-8?B?empKb3FuS2hpZUJVb0F4eGR5VytTbGlMVmc4aTZTU0FPK3hESVJiU1drNHZD?=
 =?utf-8?B?S3E3TW1POGpCVGZCNlU5RmVOaGQzcEtHVVlWWlQrMHdoMEVjM1g2MTJnbHlO?=
 =?utf-8?B?NHV5RUpkVnZZUlkyMU9POC9PSVdjbm5ya1Y1T09YeG9FQ2x4WGxyWkZMNHE1?=
 =?utf-8?B?NVFaRnQ1eEN1cHVyU3JSbG05bVJUcVVXUlFveUdLcG0vUVdQNkUyT21ESjFu?=
 =?utf-8?B?ak1RYm43QXAwRWJOdk9zMVZOdFA0OU45a2t4dkFTSkdBd0E5UERQdEJHR05E?=
 =?utf-8?B?TFVuVVJMZ05VV3Z2SkVGSnZXSXo3RDBXOTd0T2IvY0FVM2dYRFNxOGpDaXNR?=
 =?utf-8?B?Q29rSkhabEppYTJRVXVwcEM3R3pIVUNUaCtieUYwNE9ZVUxPNjd2YS9zcjhq?=
 =?utf-8?B?TkdVOUp5OGh0b29VL2ZLbUEycW5OTUk0bDNUQ09QREZBVE1rcnNFUSt3c09y?=
 =?utf-8?B?RjRwcHhpbHVvckl0Q283TXRDN2hYekh0aWdTVXVGYjI3UTVVSFRMSVBBRGtn?=
 =?utf-8?B?d21idlBzVFE0R1cwYmtDNWZaR3N6bWJUcmhLQkd5Z2ZVdVYwVGl3alBlRVFs?=
 =?utf-8?B?V1VXVWh0UCszNCtyblFuakZRaVpSQWJKejBoaW5Qd0RuK2FIaWxPalNKT0xJ?=
 =?utf-8?B?M3p3YklESithVUtaZVlyaTI5KzlxTWRrWFVFc0NJdytrbCtpRmpNZGRFUTlt?=
 =?utf-8?B?OFp4V3hvSzVxU3d0TmN3UGFUVGw1bGQ0bUpKaU4xcXplSUViTk1iNmNpMzhi?=
 =?utf-8?B?M1ZtM28yVlhYZUt5K1p2c1BvMUxuVENqZU5pRXRKeW1GT2U5SUoxeUM1NVhU?=
 =?utf-8?B?RWdKazE3YkhSQzJYVnIvQm9DNzZFYWZ3MFk4MmE0YkFHOGtqUmJJYmVnbHJ5?=
 =?utf-8?B?dDRlTVhlS3RmYjhpTFVRMFBUMEFQUEo1b1cvaEpVZ1c2NS9XNjFZTHJOL24x?=
 =?utf-8?B?RWFwclJhL1Y1T1IxdlJQOHB4dHRWVnI2SlhrV2d4R1hUbVN4RUYycEVwYlRV?=
 =?utf-8?B?ckVBTFdUSU1YdkovT0NYaUMwelhTVGJ0N28xL09mZE9NUCtiTkFMWFQ3eDQy?=
 =?utf-8?B?ejFZd25WUHZkU3ZkV1BUUE9CYzQvOEp0Uk1BK21UL21CcVNlbE16L2poLzN4?=
 =?utf-8?B?bkFaV2p0UWI2aVNMV3NWQWJRSmNtb1F4Ylg4Nmk5MjJyMkd2QW44TGtCSW9J?=
 =?utf-8?B?cGtIWUt3SGl1TnVyVC9GcThuVDVNMm0yemhuOVU3ZWZCSDdZTVV1anZOLyti?=
 =?utf-8?B?VERjUExZQ2MwQzRtSmZkTWlZZGZydEUyc1ZQY1czaVRUNHJGY0I2cjl5anhU?=
 =?utf-8?B?cm5uK0p5eWRrbVBNSXdReDNRKzRhMmpMaGpKb2EvaEVScGlTVTRhelNObzNR?=
 =?utf-8?B?Q25Ga0RxTU5wTHBpVVdRV2FueVJwQlVKWHlYeWk1UlQ1WVg4emZJMDFGakY5?=
 =?utf-8?B?L1FtdXFLZVNhM2hhS0k5dmxCYllmbUx5R1BSOSthdGJMSGdkbUYyUVR6Qnlq?=
 =?utf-8?B?MDlJYTllay9zS0dpYTJMbld6Tm1JYWpXVGpyNUhXcXNHSWE3bkFZTmV6a1BH?=
 =?utf-8?B?UGxaK3laOWczczlHdjZLZnNDTzNPREU3QjJDamtOQ0RJMTdpenJqdndkSHJS?=
 =?utf-8?B?MnNqY1kyTklOUlVoWHZZVkcwZ3QySE1QK0R0Yzk2K2VEZDhNQVdvaHlwK041?=
 =?utf-8?B?aitxR3hLV09CN2ltUXg3cHh0NWxJbTkxY0Z2czc4YlR5ekptOVVCVElhWWJn?=
 =?utf-8?B?MnJnRTFOdjZaOVRTM25weHA0cGRQbTRUZVY5UUpaZGRIK2JSNnB1Zk5UejhW?=
 =?utf-8?B?MjM4ZGNVeXVIU05PeUsySzNmcllYVmxTRWFKNnFNRmtjR0xBWnlGZGNJdHdK?=
 =?utf-8?B?aEVwcENJQWp0cTd5enY1TWk2Vmlka0dpNjdwbnVZQzBuSFcwM2pvaW1SdXJL?=
 =?utf-8?B?TFRRUytNYWV5Sm9tWnZHMCtkMWQrbWlmVHdFUUlIMW90Q2pkYnphRDdRMzND?=
 =?utf-8?B?d2xaZzVOMDl4VUY0cGxGTzBBMUx0MmF1Q0RxMThkejhpdkk0ald1c2VyMCtW?=
 =?utf-8?B?alBIMDNka0VKY0lKZWZHalVvOGplcU1ranoyOE56MEwyMC80YnhzZTMzQTIr?=
 =?utf-8?Q?hs5lQQTztdaQbrpXXL09PaU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8809B3ADE276EB4CAB582FDBF6D51923@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd88ab8b-8b6d-4bab-a228-08daa58e8c12
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 22:28:07.9848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uj2Zpo7eGKD8yiKNFXQNP+EMmrxt86il3W2VF1GR301G4SaUXPgKJLiKoEAglWt+H6P4JJ+NPlHFvv+7uvKGilG9C5c+CSk0D8O82FCsNI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5314
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTAzIGF0IDExOjExIC0wNzAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPiBE
aWQgeW91IGhhdmUgYSBsb29rIGF0IHB0ZXBfc2V0X2FjY2Vzc19mbGFncygpIGFuZCBmcmllbmRz
IGFuZA0KPiBjaGVja2VkIHRoZXkNCj4gZG8gbm90IG5lZWQgdG8gYmUgY2hhbmdlZCB0b28/IA0K
DQpwdGVwX3NldF9hY2Nlc3NfZmxhZ3MoKSBkb2Vzbid0IGFjdHVhbGx5IHNldCBhbnkgYWRkaXRp
b25hbCBkaXJ0eSBiaXRzDQpvbiB4ODYsIHNvIEkgdGhpbmsgaXQncyBvay4NCg0KPiBQZXJoYXBz
IHlvdSBzaG91bGQgYXQgbGVhc3QgYWRkIHNvbWUNCj4gYXNzZXJ0aW9uIGp1c3QgdG8gZW5zdXJl
IG5vdGhpbmcgYnJlYWtzLg0KDQpZb3UgbWVhbiBpbiBwdGVwX3NldF9hY2Nlc3NfZmxhZ3MoKT8g
SSB0aGluayBzb21lIGFzc2VydGlvbnMgd291bGQgYmUNCnJlYWxseSBncmVhdCwgSSdtIGp1c3Qg
bm90IHN1cmUgd2hlcmUuDQo=
