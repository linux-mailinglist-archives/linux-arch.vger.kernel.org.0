Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC68C6AD3B6
	for <lists+linux-arch@lfdr.de>; Tue,  7 Mar 2023 02:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCGBKn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 20:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCGBKm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 20:10:42 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E39034C29;
        Mon,  6 Mar 2023 17:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678151441; x=1709687441;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XRhsNDgQn0UH1j8Qqv3M+ur2aSLzQU8P2iLrmUtONt0=;
  b=HNo/CNNbEoQdHIsS3Uuq8BPvYOy5N9/BPE1d85aZFgLKvw89lVUW1vGq
   Qu2PHLWVqhcIDv0A5UTdGYg5q7XocDHAGCjqEGIpm2NBR5eVhPPkQjwTl
   sZt1kHfGjFqQxydc0KsK8gpgYJxZn9bP4fy077JrUImj8Bjrn8w/4pvKh
   hz5BDOugdX+i2O4cwHgejQjhbbrqXcJWDHIloSYA+ej8FjW9qx/XDPYuR
   eHkRgzFqf7q2mjydeTTojgb7exC1gvrkfI3Is26M+VS/tWq8PBCQkdsAN
   z2YOcqr/LRbIeZksTFd1vTItMJoPHqq4I/fdjL0Zmj2AH+FxAMaT9ryy0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="316129509"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="316129509"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 17:10:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="669674268"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="669674268"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 06 Mar 2023 17:10:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 17:10:37 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 6 Mar 2023 17:10:37 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 6 Mar 2023 17:10:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpG813yBVkxMibXV7h2B4PIcKbVUb7TG0N69PnlhOsdRffCc2Ka/4yqtNcQc17urPt5TaE/agPrFJ+YdKhCMPqwD/iqHd/VWTgOtQTrHNMsns+kjvEJ/N3Hd7nythYsm5YF/KYhPgsv47Mp+D1CYpP65h2TfU8eupHsUNIQIBqnjp6xX6giQGYxgodLXJl288WDUNO9ncpoEHJ0k8i7XhCCyNOi0M1tkU/oluwr1lGkqUNItbQSZqwJn2EZhg5CTJFZvt9BidzLoaBv3heewO58mykLWhxOlDH8li/DV3TNarjPd2XE8AOiyXf6CyBzqq84bKlxIz+yb5gcS4b823g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRhsNDgQn0UH1j8Qqv3M+ur2aSLzQU8P2iLrmUtONt0=;
 b=lDO04e2R3042zqa/3sd6g7QEx0Ns+LQF2vD8Lgoje6GXQYoqZoGeX8mshxuqFza6AY78z4BqBaJr7/6g/wcnGLV0QScUSpFNtjbnH6YxA0Fgm1yHWrILJpIMuqa3BdMLH1NLFjH5JkZFIM0XSRqglf5oahl6ZiLiRbj1RK6CM85Ok4IzWp/NZkpSuFsoCcg0oLLQtAdJmqjBDf5KDxI8AjsRo3ojyZNnW+18EFixzWiIMtrwsWLDRGNIdXUePJNlDE1WnTizaXplko2Mg1SZCQAwiyaDDtO8WqTtwcAdHLrS9WYp6hsDy/eQWVn56XcL1Dsp/cBQ0Rlzg0U+RbCT3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BL1PR11MB6004.namprd11.prod.outlook.com (2603:10b6:208:390::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 01:10:34 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 01:10:34 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
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
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v7 25/41] x86/mm: Introduce MAP_ABOVE4G
Thread-Topic: [PATCH v7 25/41] x86/mm: Introduce MAP_ABOVE4G
Thread-Index: AQHZSvtFYEOef2MxSkaO9K1nBc2rAq7uF5+AgAB1pAA=
Date:   Tue, 7 Mar 2023 01:10:33 +0000
Message-ID: <ca3e4a6abd0b3888110d65955c571d550138956d.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-26-rick.p.edgecombe@intel.com>
         <ZAYsWadAkdZBUGDb@zn.tnic>
In-Reply-To: <ZAYsWadAkdZBUGDb@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|BL1PR11MB6004:EE_
x-ms-office365-filtering-correlation-id: c952e880-52bb-4316-278b-08db1ea8c098
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ew8iG2kxLABBZgyvK2tcat7yNjH2DzIm/ZaoMNFG63Gszzc/fKTuW61cy0r12ztGPlWeSuA/TcNzvLpbSaK5TQghqudZsLKoY0kjqqWZliVCZwzl1uVncYLgLfrxr981ZdN1CgGIuVjWyRFRuQOTJsGpFTRiceVSnK7/6zehRpcA26Kj3UF1jNNcPlzkKDYwgpYQ2Vr4mkxvwKrlBcjH6qn3N+agSeT8gxlcwEy2peraZh1Hk6QtTysdn6p4qkiWPrgIUBPQqP0RnopS/nUxIJjNSV3Or3EVCYG6P2QS9/o6RReeGotO4NzaF4mXuV6ewxvUEP2LZCzVe2r0T2cI91BPd2Hq+dt8QmdGA+/wQ30/JVpdM9VBnc8tU8e5Oo8k5B3BxWnThK21tScHOQkbC8bZGO4KSf1zssvJFeXf2mL8WREr72J0S7kZocY8GlrcDgoIkR4bVijSoZzc+hgK4utcrukHYpdABvF6u2b9sF63pmh6Ayc5O960Hqod+VoBVSXOAjgTPJ3Vjb9xsDf7H7neLpEVP/RvyH/zPQqGkhtOLHxOy7x6sD9oOL8ETlP1MjwlQgVBYsYL2Tw/mCl3P+BwrgMG34UGYpuMizNla+tvCts+SEWsmxUq4ca6PME309BAbmjL7KCrF2zgvqSOFhYT50VGzcowG/oRARhC+zjqKAhZmDzixUcfE/13WSOCWhhD5+1t9MQnbc6+/nZp915xcAqoGwO7kLy9lc2o5n8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199018)(8936002)(5660300002)(7406005)(7416002)(41300700001)(76116006)(6916009)(66556008)(66446008)(64756008)(4326008)(8676002)(66946007)(4744005)(2906002)(66476007)(91956017)(316002)(83380400001)(54906003)(26005)(6506007)(478600001)(6512007)(186003)(6486002)(2616005)(122000001)(71200400001)(86362001)(36756003)(82960400001)(38070700005)(38100700002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXAvM1R4RWNkdkhFM1h0WG54R25kMEhKRmZBQ29UazFGZFNIeFVCeXl1MTRM?=
 =?utf-8?B?bS96V1FEd0dPbWR5YklCMmZBZ0QyQllhN0RtTkVncm5UYVh0cmR6dG5sc2M5?=
 =?utf-8?B?WGF2dnlLcVE1dnFDVnJvaC94VUhwYVI4eG9qSmFKemRKbVQ0cnFUSWNMWUlI?=
 =?utf-8?B?eTNId2M1U3hFSGEwaGlDY0paVXhCS3pHK205UnptdVl3NEE2Smo3aEo0Ukdr?=
 =?utf-8?B?aUN5YU1aQkNoeG5lME9SN2wyM0t3M2F3dFVUc0RQQStOWHEvL3Brd2pYQjM0?=
 =?utf-8?B?QUttYWZGSjBHT3U4dktGWFRzQXpmRW43Vkw1VVp1SW9NZ2lyb2RmeTk5UENn?=
 =?utf-8?B?NlVZdkY0VFdnN2YzUmp3TUw4Mi9ORUpmVTZpa1hHM2w0TlZhc20yenZkbnpL?=
 =?utf-8?B?N1psdkFRQWQrWmp2ZFJEaFBLR25JckszT0RnMmJJcVltNkVNOUtMN0lJL0NN?=
 =?utf-8?B?RkM0YUVzdlZxbjBkY1hFWnlOclRhNVNrandyZ0Q4bWQ5dHFiMHd3Um44K05s?=
 =?utf-8?B?TXFnayszSVdLQ0FCeHdJL1h5akQweHlMbEptdE54WGZiaGVqREpRTzVseW16?=
 =?utf-8?B?R28xK01mQlhBc2dFaTY1WWxoVFNkekdtZlVUQUU1ZHJwK253UjB5eGJVb3Y3?=
 =?utf-8?B?WFpHdUhTUjhrQUIvMUJSbjhhQklwanJNQmI0dm1jd2VkYTBsTGZxNncxVFdV?=
 =?utf-8?B?MVlOY0hSY0VwbSt4Y1BTTXlMWUpCbENoQzRDNTlzUUJnZUhKQVpwZ0tNTVEr?=
 =?utf-8?B?eGxMRXA4WjdwYmllcXBRcnV6R2hoZVJLQTNYWEIzQkpXdUNJdTgzVUp3WGlh?=
 =?utf-8?B?K25lWHN1WkV5ZUYrZk03M01DV1NtT3AzbjlQY1p2eHRLeVpLeC9qejg2c2FE?=
 =?utf-8?B?RkZFUDI2d0FVZmdpQmFWQ2JTa0l0LzZ2MUpWcmJKbE5WTUcvdUljeGR1NC94?=
 =?utf-8?B?dE52OUNsK2tEaFhLTDdySDZuZ2tSLy9YRTJVSmx5Wjk2UFdDOG0yYWpVdTc5?=
 =?utf-8?B?UUtNL0NydG82QXpYaFVkcUd0NWtFLzZETFZmNitncXh6SXg2dE1raXU4WFBp?=
 =?utf-8?B?YzF0Vnk4WVJZbU15OWM5NUVaM2tMSGFZcG1rQms5Tms1S0c5aFZhb3dxdFlN?=
 =?utf-8?B?QnVKc0hXZ29xbWN2SEZJK0NsVjZrMGlNOTJhazllNlllaEgrNVIrdnhHamxR?=
 =?utf-8?B?MnhIQW5rUGtOdEJHYUJySWhQemlDZGhmS3VHSDM1QXpGS0ZCV0p5UjZqS1VZ?=
 =?utf-8?B?dW1vT2djUUZFWjExVWpqeHhPbjNkRnFwd0FDWHlZMndwTWdOZG1rUXF0MktW?=
 =?utf-8?B?WkR1emdnODZhb21wMWNpSjl5UnlGekFsK3habWxBTk1yZWNSTWRteTJYSDNi?=
 =?utf-8?B?dGtpVTZIbGxRVUcwbHoxcDg0SFA0bVFYeDROTFhGbkJDOVBYNkRYS2dmTHhQ?=
 =?utf-8?B?cGhVd3BiaVRVVml1NGxKYXhZYXBwaTI4UjlseEFmTGNqWE1JNUpTVk85Tlds?=
 =?utf-8?B?OUJFVE1wQ1BGZWFuNEN6cmhxYWIvcmpudGFZRTFQMlgwWTF6ZGFBMHNleGZt?=
 =?utf-8?B?RmdtWGIrdDZjZjUzYy94UDVyUWxJWlZXZ25XM1VjbkZNeDQvV09kNkw5VGUx?=
 =?utf-8?B?MmYyTllrMVdqNlJHdGVlbzNQNEJCMWFJS216VHlpYjVPcmk0UlZ3K0I5NlFI?=
 =?utf-8?B?eFpQZkYyb1YrUW8xbGlIMm9jSElQMWZRYjUzMXNUV2JDa01Bb2dLUWM3Vjhm?=
 =?utf-8?B?bktWV0xMcEtka2txTVJtWWVhMXB2RU13SVhRUmRSWmRFd2lnQkI0RFNOeUpR?=
 =?utf-8?B?dFZ5eElUMUpTUWFBcER3VjZwTHFLbGpRejVwa3VYMFZiMHVKdnB6bjJOOGRz?=
 =?utf-8?B?bE55ZjFkR2F5WDB2QXh1L1dBSllxRk91UXBVMXdkOWFSVEQvdHFQdGEyQ3Rn?=
 =?utf-8?B?MDhVVm12Q0ZITjBJTTQ3dkpzOWRNbXNJN1ZXZTlENnhWSlIvQ0I4b3ZPbUpH?=
 =?utf-8?B?NzhqYTlFRDBDR1hvZDhDMjJJVVowaWU0dHpJUlZ6NEo0MVZEOGtpRjF2R1FK?=
 =?utf-8?B?T3RLNFdNMzJLWjRBcVUrRGJCU0ZuT294eThMM0lFL1V6TFNmRHJERGNtOFVQ?=
 =?utf-8?B?SnRGRVp2VjhiU2VjK1lqUzR5UHBjMlNteER3K250VStkSU1zdEUzMWJzM0Uv?=
 =?utf-8?Q?sCjnoATTOMyCwXqI4Js2YHA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADDA20352BCDBB4A8C431596C1C4F74E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c952e880-52bb-4316-278b-08db1ea8c098
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 01:10:33.5562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0NSM38MifoqK2l1RbYdjWarD8+s0+1yNIXkbpfcV1SNbHix/qn5Q6x6UpdC256Te93I8DMDzSpLSqFwNhB3xl4y5dAropGe+IbdvyIFrtiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6004
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIzLTAzLTA2IGF0IDE5OjA5ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9zeXNfeDg2XzY0LmMNCj4gPiBiL2Fy
Y2gveDg2L2tlcm5lbC9zeXNfeDg2XzY0LmMNCj4gPiBpbmRleCA4Y2M2NTNmZmRjY2QuLjA2Mzc4
YjU2ODJjMSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvc3lzX3g4Nl82NC5jDQo+
ID4gKysrIGIvYXJjaC94ODYva2VybmVsL3N5c194ODZfNjQuYw0KPiA+IEBAIC0xOTMsNyArMTkz
LDExIEBAIGFyY2hfZ2V0X3VubWFwcGVkX2FyZWFfdG9wZG93bihzdHJ1Y3QgZmlsZQ0KPiA+ICpm
aWxwLCBjb25zdCB1bnNpZ25lZCBsb25nIGFkZHIwLA0KPiA+ICAgDQo+ID4gICAgICAgIGluZm8u
ZmxhZ3MgPSBWTV9VTk1BUFBFRF9BUkVBX1RPUERPV047DQo+ID4gICAgICAgIGluZm8ubGVuZ3Ro
ID0gbGVuOw0KPiA+IC0gICAgIGluZm8ubG93X2xpbWl0ID0gUEFHRV9TSVpFOw0KPiA+ICsgICAg
IGlmICghaW5fMzJiaXRfc3lzY2FsbCgpICYmIChmbGFncyAmIE1BUF9BQk9WRTRHKSkNCj4gPiAr
ICAgICAgICAgICAgIGluZm8ubG93X2xpbWl0ID0gMHgxMDAwMDAwMDA7DQo+IA0KPiBXZSBoYXZl
IGEgaHVtYW4gcmVhZGFibGUgZGVmaW5lIGZvciB0aGF0OiBTWl80Rw0KDQpVaGgsIHllcyB0aGF0
J3MgbXVjaCBiZXR0ZXIuIEFuZCB0aGUgdHlwb3MuIFRoYW5rcy4NCg==
