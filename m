Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134B6648779
	for <lists+linux-arch@lfdr.de>; Fri,  9 Dec 2022 18:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiLIROF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Dec 2022 12:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiLIRNp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Dec 2022 12:13:45 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A91F4EC0B;
        Fri,  9 Dec 2022 09:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670606013; x=1702142013;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yoeWqQUC9hNaOqVWiGaAPxhG1gocXAJzCIpY4DOduvw=;
  b=X07LoaO2EZMc/AuBC+A0HEMiDjjZO2ILdLV2l12QHrxlDwRhrSwH4Ytv
   AyFPX1KHf+9TyZ9cgbIQrPeLcEfaSLYrf5n47G9QIGCmgBYntYyHf9Tpb
   GXoj8wpjDVJrtAlbNjTKT47vDNQ6CYpuim8Aj2KKO6Z219uUmGfDk+XVI
   ps0n1qFfrvelFfZkSkacFZFLBO63+lTUrfziuUoGPB9yuRqPptO+UE+2i
   O8BAkpanowG80mqQuYA1ktHJ4lB2pNAsWnIfbwCCni3ELXFbfiBGmbdzI
   FVekilbd9mbW2zo71E/bbjYSQaj/fCJ1qlc81XGkqiOtl52YYRZ2RIBl5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="344540609"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="344540609"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 09:08:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="789776100"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="789776100"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 09 Dec 2022 09:08:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 9 Dec 2022 09:08:23 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 9 Dec 2022 09:08:23 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 9 Dec 2022 09:08:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxbwbJ6heEoA5ZG0DZwfio7Le8o+t0OcqE4cPn2nxWD9oTHrsCsG/j/CKXDsukLyhLK46JXdGTrIjWDNOhv5KR/JAOYj5UIJu4Qxfm4Y2CJzwiig68rK1KB3AC7FBJSkKUcmkIWqaBzHNjhcq4IUUxaCfT8VI2IRYujQQuVZsguzIXk0zVbEjETMn18qy4NDLQbEj5PO4Jul9WnoSCc660i5asFN0BlUBuuUWELc++VCjJBg3cjVbua62UNdodgQbkkZF4lN9EKrsnxFDZIYBJ+sayGwyYR7yfQPG0XGlmaHlffIHC3nowgI+iBmSW0K5HByqp139CPDiioBe4456g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoeWqQUC9hNaOqVWiGaAPxhG1gocXAJzCIpY4DOduvw=;
 b=BSUS4zooREOPnk/UGuV/HzanSr/7qtoJeHmYe3jH9GrZ+JkHI28RRmxfAMSmV0vRk9rO0qCJTNs7gEAkokKZUimFd9GlmtImaIpHo3ffTsi1SMg8Ef8ujIp7FzYJxahaOsRB6l6yBVolxLVy8XyMO5ri7Rua4HDY3vt9F1AKvrcidbBJGokcSvSC6+fBf5R01q6M8iXkKkGVkRdF6uqG6CwB/S6dPeZf3R2zNj00if4dt/fkpKNb34QtrbLlFQJqiP2fKS5h0nbCGBBrfwdH2Z6CRPoyocIvVxgQOLINHB2xjXTEEXB+cVWWR4/KMhvD8ErDxEBjITLODVbl2FY8aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH0PR11MB4854.namprd11.prod.outlook.com (2603:10b6:510:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 17:08:21 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff%5]) with mapi id 15.20.5880.016; Fri, 9 Dec 2022
 17:08:20 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rppt@kernel.org" <rppt@kernel.org>
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
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v4 37/39] x86: Add PTRACE interface for shadow stack
Thread-Topic: [PATCH v4 37/39] x86: Add PTRACE interface for shadow stack
Thread-Index: AQHZBq9/FzxBTfcuS0GSoDQuHiOx0a5l0zQAgAABGIA=
Date:   Fri, 9 Dec 2022 17:08:20 +0000
Message-ID: <a34d766dc3bf09e445320e0f94fb8d8e6301c7b5.camel@intel.com>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
         <20221203003606.6838-38-rick.p.edgecombe@intel.com>
         <Y5NqmLqXfXpowoSM@kernel.org>
In-Reply-To: <Y5NqmLqXfXpowoSM@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH0PR11MB4854:EE_
x-ms-office365-filtering-correlation-id: 8a927fe2-91d7-4e4b-8eba-08dada07f931
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P5JwdStVSgyjSUrKZIiXXLN47TfX1xCIY7u5BYP4DYceLJxYRhvRUpPKKpLrDoduRLWUz0oh5aNIeIOE5KwHyq3wRNWkBYqDMEwRobLzWGglr+17F27BJszG9qFp6Um/4Kz4kDzNtZAwtFusRIeFupnwL/qPQH1qxkR+mv8pJDJ8pywsXKrUc3+bbbVsbSdgLn8uMITIiJyVIdS94Slk3VqICR7yTDofvZ5YdBlOGGDOqT84tebGBHBhsZja7fiGCbgZm5DdcjSs4VI9xKV3DRS3n3u0DQtfg+BgmqFh3AHNdRzv64VFw8ZiIV22MVAjgjMnvmjflrc4TDbzLQb/Oeuk8dgcCL5pKnp4/+OJ4R0+rn3Vtai5eBMMMVNySgMzEJM8KXT1IbQpHaSr9Ht+vR2fW2gb5HfBO9x3pGhAhI/b2kYDkYWCsMrMfaFXz0hmjinp3WfRPBafmxP+AEAAVdzpChyCqz00FHKf1v3SUgD2Yh6aT2oxqdNwYXtrH99lMgfyJ/nmFYhNOos3NB4LkcSRV35dckBPnXqOImgXBRm0kdBjyWsC5PdNFkwLrwjvkDdGZ1Q9mGrXYcS1aJoobSwv8Rn2WWJcAIZ0CBda5xU7eBAIevTteYx9G1xEsn4oSRW3KCHD2S6t0g3caSFeqEqKC/Zz6KsFUji+Bpxedslpeer5eSL/uERCAGR+Jr139vtmyfLpn00AbEpwCY+v2zVK9UZdGLz9EsMYKiwk/Ms=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199015)(82960400001)(38100700002)(122000001)(38070700005)(86362001)(2616005)(6916009)(8676002)(316002)(54906003)(186003)(478600001)(6512007)(6506007)(26005)(71200400001)(6486002)(7406005)(2906002)(7416002)(4744005)(5660300002)(76116006)(66476007)(4326008)(36756003)(91956017)(64756008)(66556008)(66446008)(66946007)(8936002)(41300700001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0lNejdtVVNlanMyWUc2dDJqdTc5WFhIajZDS2dHNmxQTVErU1d0am9Vdm0r?=
 =?utf-8?B?RWR1SkNEQ3ZZdkZaZTFLKzZyS2lNZGJvbHlqaHY5K2VkOEY1cmR2MjdQY3RM?=
 =?utf-8?B?RDVkNzFESURhVjBHYitzRGR4SzVNTmNFcUZNMlpiSEZacVF5YXdJR251TW1o?=
 =?utf-8?B?UGROU1RxdCtsUWs0K2JWbTYzYnNzc2VLdjhGWE5mOHV4L2QzbVhPeVhtM2lW?=
 =?utf-8?B?a2ZBdGNMNFF5WmtlejVzSVpxVUVpekJUYjBUUnVrM0Fsd0gzWi9oT1plbmpu?=
 =?utf-8?B?SmVheXlRdG9xZkdkaitLMDFBZFd1NDhCK2hHZkh1UzFjSGdIcXhDRVk5UURN?=
 =?utf-8?B?YWNhY0pQSmpRZGJPd2hsOVg1QWxhWFhyWTJpb0g4TWo2Vy9VYjc0d0FlMWlU?=
 =?utf-8?B?Qi9kc21KZEMyRWtwZ1JpQllERlpiRFc4SEp5dlZLQ04rb0poMEdtSDZsOEhm?=
 =?utf-8?B?b01KdlZvVjB5NGV3QzhVVWk2bnJLT1FOZk9PKzhONlF2NE5HaEZvOGpEUVk0?=
 =?utf-8?B?TGF2VGlKNlh6cEk5dXBRenhqeGtKNHJianduR0NjRjFqdmV3U1o2N2dCRWF0?=
 =?utf-8?B?by9IaDJyVjMxNlZPMkZva0hJc2FML2d2NitDMlFJT3lBMWRBVUZ3end1YThY?=
 =?utf-8?B?bEdVY1pMQTdieWJoSGdZa0hWWVR5Y0h2VlI5QldEWGJHYitoRmpIdFFQckR4?=
 =?utf-8?B?SmNTT0FxTEhBT3E3dG1oZHhCQlB0dGhNREF1T1AvZ2RDNTd6dm1RVEl5STdt?=
 =?utf-8?B?Vnh4MEhBOUk5MG9Qb1Y1aVFrcmxOZWlWWnZwM1JkWVM4bXNsaTR0RkdtMU9P?=
 =?utf-8?B?OVUrOXlaS3FCenVBQndkTjVJZEFNUjlzcFYrYkRYazg2bnJxVEYvcks2cEhY?=
 =?utf-8?B?bWhMN3c5QTcyOWI1UTl1VDhaN3BOUXV5ckwzaUN4MXZvSHUwK1Rkc1VJWDhM?=
 =?utf-8?B?TkNwNDRuREVMQlBaSHZaRWlueEI0SVFSbDB0UFcyOThTL0tRMDFvbm85elps?=
 =?utf-8?B?UHlKNnFOY2VhVXJGanIzaTNlVUd0VUJpRk0xdzJxSDlhb0hta1NBV0JlT1Jp?=
 =?utf-8?B?SFFKbEtWMyt2SEtSUHpDYUFOcjJ0eVY1M1B2aXZOSDk1Tk9wVFFmOStOYllR?=
 =?utf-8?B?dldpNEhaUUNGSGpKQ011UEc3VUdQWWNISm9DVjJmN2JaN0x1L2RsQWNRSVRv?=
 =?utf-8?B?Q3doSUFuRXZEVG5zWjRuMUd4Ym4xenRwYlY0di9OTWNlNmdjUkVEajd5eVRY?=
 =?utf-8?B?a3drc3diZXl2Nk5BKzhxaTJKWjVFWFdmcWtDc1Z6R1Z0ajNlR1o0cTY1RWM4?=
 =?utf-8?B?QzNMMEVHekx1d0prdTBwL09Sb25keTdtdHNMQUNIN3FvY0QxdEkydmpBMWdG?=
 =?utf-8?B?Ull3RmpRUU9EeHR1R01OR1VLSEZZdzdjMlVSY2tJelB5dS8rZTJUR2FleFQ2?=
 =?utf-8?B?UlFudzk5TVNFWXFib0VhUHhybTg3TDljb3N4UzJ1VTZBUGM3ODA5NjVrWDhk?=
 =?utf-8?B?ZWIwNVlxcnc1UDNCSm9ONUlqQzhZRDFSQWQ4dTFnczA3U01FY0lSOHB4UUp1?=
 =?utf-8?B?YjRhbzF0eXNKV2p0Vmc2cUcweW82eEgzd3I1WFlJZ3RFOUpPVEMybEFLb3Vm?=
 =?utf-8?B?dkVDdDFGaHJ4OTZ6ZVZqZWpPbW5Xdk1lc3ZlTTJOUTdndE5QMnRPVzVnQzRx?=
 =?utf-8?B?S29WWGkzNy8xZGZuOHZwOXdtalp2NUYvQktYUHhpRzEwL3c0OHYwci84S2VS?=
 =?utf-8?B?Y3N5eDZOYVRGOEg3MW1sRFZudnRZMXRUQU9nUndCdFYwV1JKMjc4VU1kbFg4?=
 =?utf-8?B?MU9UMHhRUGpiQkVwT3Y0b3lHaVk3bHRmMERjOWRRTkVnRWlBdXRCMGZOYlp1?=
 =?utf-8?B?T3ErZE8zSzlBSWxXZ2FkZTg5SC9oVS85WGdsbU9iNlhGNC9lc2hHbFVFVndU?=
 =?utf-8?B?T2FJNUxKcVF6bmJKbEFXSnh3NUhBcThGVGZicjlnMjZIZmZyTE51Yi9zSlEr?=
 =?utf-8?B?QkNhWlFoelNPUzBCMjRGSXdMU3NLa3JGeXBJTjE0UDBEeC80Z1ZwVnZCbENG?=
 =?utf-8?B?Z2dKcTlEK1ZmbEFPenJvMFozdGJXSkRGWjhFMjR6TTJlRnVla3ZNTGQxZmxH?=
 =?utf-8?B?SXNQdFAzRUV5OGdDbHBLbVpQRncyNDBRTnovNWk1OFJTYkNqYlNZMHF5NXpL?=
 =?utf-8?Q?oD6jWlL2BI4xqSq7bvCjA9Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <569840192EA7494C8D556A26ED0B8DFC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a927fe2-91d7-4e4b-8eba-08dada07f931
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2022 17:08:20.6591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cxdLyadHriMNKq2239kflfyTHxaxJxqH48g5PNTNPm1VzuiVti/BD4wzmB0LYAyH9uI63Ebc0UGGtKd2J4X5JcN5hWcdfYb4kA+FOEzMypA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4854
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIyLTEyLTA5IGF0IDE5OjA0ICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiA+ICAgLyoNCj4gPiAgICAqIHhzdGF0ZXJlZ3NfYWN0aXZlID09IHJlZ3NldF9mcHJlZ3NfYWN0
aXZlLiBQbGVhc2UgcmVmZXIgdG8gdGhlDQo+ID4gY29tbWVudA0KPiA+IGRpZmYgLS1naXQgYS9h
cmNoL3g4Ni9rZXJuZWwvZnB1L3JlZ3NldC5jDQo+ID4gYi9hcmNoL3g4Ni9rZXJuZWwvZnB1L3Jl
Z3NldC5jDQo+ID4gaW5kZXggNmQwNTZiNjhmNGVkLi4wMGYzZDVjOWI2ODIgMTAwNjQ0DQo+ID4g
LS0tIGEvYXJjaC94ODYva2VybmVsL2ZwdS9yZWdzZXQuYw0KPiA+ICsrKyBiL2FyY2gveDg2L2tl
cm5lbC9mcHUvcmVnc2V0LmMNCj4gPiBAQCAtOCw2ICs4LDcgQEANCj4gPiAgICNpbmNsdWRlIDxh
c20vZnB1L2FwaS5oPg0KPiA+ICAgI2luY2x1ZGUgPGFzbS9mcHUvc2lnbmFsLmg+DQo+ID4gICAj
aW5jbHVkZSA8YXNtL2ZwdS9yZWdzZXQuaD4NCj4gPiArI2luY2x1ZGUgPGFzbS9wcmN0bC5oPg0K
PiA+ICAgDQo+ID4gICAjaW5jbHVkZSAiY29udGV4dC5oIg0KPiA+ICAgI2luY2x1ZGUgImludGVy
bmFsLmgiDQo+ID4gQEAgLTE3NCw2ICsxNzUsOTIgQEAgaW50IHhzdGF0ZXJlZ3Nfc2V0KHN0cnVj
dCB0YXNrX3N0cnVjdCAqdGFyZ2V0LA0KPiA+IGNvbnN0IHN0cnVjdCB1c2VyX3JlZ3NldCAqcmVn
c2V0LA0KPiA+ICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICAgfQ0KPiA+ICAgDQo+ID4gKw0KPiA+
ICsjaWZkZWYgQ09ORklHX1g4Nl9VU0VSX1NIQURPV19TVEFDSw0KPiA+ICtpbnQgc3NwX2FjdGl2
ZShzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhcmdldCwgY29uc3Qgc3RydWN0DQo+ID4gdXNlcl9yZWdz
ZXQgKnJlZ3NldCkNCj4gPiArew0KPiA+ICsgICAgIGlmIChzaHN0a19lbmFibGVkKCkpDQo+IA0K
PiBUaGlzIGlzIG5vdCBnb2luZyB0byB3b3JrIHdpdGggcHRyYWNlIGFzIHNoc3RrX2VuYWJsZWQo
KSBjaGVja3MNCj4gY3VycmVudA0KPiByYXRoZXIgdGhhbiB0YXJnZXQuDQoNCk9oIHJpZ2h0LCB0
aGFua3MuIEkgY2FuIGNoYW5nZSBzaHN0a19lbmFibGVkKCkgdG8gdGFrZSBhIHRhc2tfc3RydWN0
Lg0K
