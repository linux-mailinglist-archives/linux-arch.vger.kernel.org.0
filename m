Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0883F5F4BA2
	for <lists+linux-arch@lfdr.de>; Wed,  5 Oct 2022 00:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiJDWKc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 18:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiJDWKC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 18:10:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68DC2E9D1;
        Tue,  4 Oct 2022 15:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664921399; x=1696457399;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kBv9qV4gPgO1nEn8xDzq6FmiCKTwy3PRHpOzZ0tMNWU=;
  b=WChV1NGCFP2o9N/KkvVY/fjWnxPT1p4oXqOWXS4vVTy13QQijr9wjB5h
   tJBMP4gxEsLwiqCGw5esICDiwerwWqcalbbmtkwz0grEJlHqNy9nRcKAH
   k3NgjdaP0pRXz9f6UA7lHEeTgSWFMM+4msuAOUKGnSuH0h2il5VPX4Nd8
   5TabLvgBSWY6ZIrnW9E/0DBb6jFW8PAwls2++YUyQ8Zd9ovt5XfLofzFQ
   29TEsVj0pk6PVTpXpE2E2tIFDk3XTohAaoJAeUXeW0MaOR/0Rg8beflWd
   125lpit9rbbEzbV0BS2WfHFqv0pm4j7LbwzBNtzGsjKtzVjQYLfLOtvwo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="304021851"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="304021851"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 15:09:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="575211714"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="575211714"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 04 Oct 2022 15:09:58 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 15:09:57 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 15:09:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 4 Oct 2022 15:09:57 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 4 Oct 2022 15:09:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhZ+4vAticKdQfX3nMvg9RKbSVv+EOAz4C0MjdetxcaQHzXfLBw+n7CG008N29qbUPfFfEtRP6SbIGHqk32GKv2reXur4T/aZ30y5zzy5GhQNjls4gstbRMGzEvT9EXJhps6t56GC0v8klt2VmxDW0ySeREgEtIidaSkLkyj7psdoOK8930TsIHOjKHGJmiouacdbUKBJHX/1zF66vNcUnoe+ETeYdomqHqps81jvVvSIQmYTmYtuC4CvZOyI398l7k6K69CsE1CMZ/p5w8W16D7UGC6Oxs0ynk+ifIphns/8s7pln63WNnc4k6bAt+sI1XrUDA7IS4SzHGGcrVZOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBv9qV4gPgO1nEn8xDzq6FmiCKTwy3PRHpOzZ0tMNWU=;
 b=hujYKvMdL0fvsNAc61Gyqe5e/3PFgFYEWHeylTpYuXjbCdCHC/S65QnlkxWiwb77Lq6taYoVTnwjtORK3kBgqacq3jri9V3fvE42CqkP54spVUnSoIS6ou4o+R+6S+7iwPzK0gSRTiuU87gW/5FRqYsTD6xPbTByQOBOt4pP1RbxMuIaONEaxzu4e+d050SRV/CIjHmKqK1dOi2IEOT2269jli8gWa7vrZpCi+6PffZk4B2BxSRZ1t1XMMLIGZ+lXTIAea7z5L+HYrsQgtQGfqxZ2YF7f4RbLgWO4EEdzLuD1/D9ybNZfLQAUZtm9zWOW0EzVBVjOIhzqP2XH9loLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN2PR11MB4759.namprd11.prod.outlook.com (2603:10b6:208:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 4 Oct
 2022 22:09:53 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Tue, 4 Oct 2022
 22:09:52 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
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
Subject: Re: [PATCH v2 25/39] x86/cet/shstk: Handle thread shadow stack
Thread-Topic: [PATCH v2 25/39] x86/cet/shstk: Handle thread shadow stack
Thread-Index: AQHY1FMioR2zkUKPr0OYxM5M3mC81a39JOeAgAGuf4A=
Date:   Tue, 4 Oct 2022 22:09:52 +0000
Message-ID: <98aac9a451c622385189486cce856a4307d19f59.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-26-rick.p.edgecombe@intel.com>
         <202210031317.4611D6A1E7@keescook>
In-Reply-To: <202210031317.4611D6A1E7@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MN2PR11MB4759:EE_
x-ms-office365-filtering-correlation-id: e219ce6a-e140-4c3a-ebbe-08daa655298a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IJgMuERbxs4yHLkx8T5lvDPL6FMFriO4AgxaXwivV/ehFB1Gwlnwq3/6Wngyd8fUhLc/wBWC9YpBxkjN1+GF1RTQCTIS0DP6HAiiwohuvpxARC1dG7wl+JKBEKCom6O7IlnIvfs2Aib+iTXxhKZEiQ9EfaqJRbkElIZjRpqFUYcx2y1ES/Dn8XEymdipkOZNRJl+lzAN5fd0pw2OEtuRhzns1niBjmA+94WqiVuOQPiU6Y40XPK6h9Mwv33hbCpXi7LEkvNijszpeq9akjlde15sutA7ezmy11LQhkCS4RaundRG13xWS6NxAVhq1vE2SVa0m2SRVSqh4sol6mtWlbg5GLXXtBo8UVK+LErRbUbqcG4Jbi0WsqbNRuEh85wFb4A6Z2tH9JAHyQNYfQI1Uxf/nKZIRMrOGNkUZOog4MGNWF/MCmzeYCOkxBq2Eahgr6WqVUIEWOhdWHx9TQ854u+3LBswqfE8Hq9TaY4YR+/00hP4cwJKqJA+857xQth9RBnmH6wDlzN4/9KfbJHwAADraMOIBQ7fCKZrOcqQd+q2GNP4Qr18ye1jUxXo1U65P3eN5OD+/oaj/3zTIxqJao8Y0qw6wUZ40185K07/tQvUaoKFf4nofd+fcWUyKjkcKsxUSinx88j957ZkYKA1O9j5c76KuvuqvJ8kHNIwZRc2epX4YOpZsXcE0wJW5dy1zYtL1SOcRqLwGMv/H5CJlBErcv8XS52KZ6t7uLd4ZlPgF9+4DZb1mkLTtemVkQLRdhaFsXUzSXF0PuSSYE97F/1toL01k4KWRTFJqXjtsvc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(86362001)(7406005)(7416002)(8936002)(2906002)(5660300002)(41300700001)(82960400001)(186003)(38100700002)(66946007)(316002)(76116006)(122000001)(54906003)(66476007)(38070700005)(91956017)(66556008)(4326008)(8676002)(64756008)(66446008)(6916009)(6486002)(478600001)(6506007)(83380400001)(71200400001)(6512007)(26005)(2616005)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cktXRDZpSGg2ejJwT21hMW9jWG9LRTJtdHFPMVExOFVhWWQ1S1dUd1FEbGUv?=
 =?utf-8?B?ME5odHZ3R0dQMGsxMmdNWm9wSjZzUkEvNWJIa0k5bm9aQ1BmUlRaL3lUNDF1?=
 =?utf-8?B?N3pzcHZrUHBEb1hBN3V5MTJPZnZHTmNLNkFGdlE4N1ltMnk0SUt4T2pScjR6?=
 =?utf-8?B?R2JrWE4rcHJRM2RpOVVvQm9wZWcyNjRjY3RZcHVNSFFOVm5TUnBvVWkyTE0v?=
 =?utf-8?B?a0dDeUdDSm1waktmcDZFZEN1dHp0NnhFbXNNdlZCWGg2R3ZFMlZvVDQwK2k2?=
 =?utf-8?B?Yk5MTzF0dTZjU0xSM2VBU1B1M09rYXdud2U0SWEyK0xJdG9MTHZ6U2J5N3Bp?=
 =?utf-8?B?cWtWci9GbUpEdHZHQ3VnYmN1TUxJTjE4TlZXdTVHRXM1TTd2UHRkeFRRdXpN?=
 =?utf-8?B?YWZXeG1GOHhZSlQ1eDljcXg2WVpDa0J3cm9vaE95OGY3SjdnS1NZNWxKUE9H?=
 =?utf-8?B?cGRlMHV1bk80OEZIcFZrUWxNc05iN2lueHVLcHZrQ3V4RjIwVHpNVEwxV2dI?=
 =?utf-8?B?VEdQenphcjZnSWttMWxTVDNiNTBSL1RDcDU1ZVYreHVucUZpd1J3clo0K3lz?=
 =?utf-8?B?RjM4Sno3ZU5ESG84WGZ3dWhCWFJSNnRrMGdXaERyOEZpNXdkYU1vWG01S2VV?=
 =?utf-8?B?cXZmY2pKOTFXU3BPdFVTTTUxWUhkTkFNMmpscjlwam5ieVg5cVBKWlNlTmVj?=
 =?utf-8?B?dmVQSkNZNy9iZU0yaFYxcnNmL2w4WVpNVGFNcm9kc1daSXg5ZTFiWFl2aXlM?=
 =?utf-8?B?YnVXMExOWDZOVWJWVlQzWS9ieVlVRmlIMHBhWTVrVXp6U2tqUmdmY0hhbnRE?=
 =?utf-8?B?aVRpWDZWWmR3QUg3Mk10cm1lWVFmOHRybDZZVFMzZ2RuYld4V1Fubmd0K09E?=
 =?utf-8?B?bXJPV0JmZXRJRUxYSG1xWVNDL20veWY3ZksvY1hyQ3ZPRCs4c29JcWFuRnNP?=
 =?utf-8?B?N3BWMEpGU1FNQWZVdWFQdXVPTElHd3cxVkp1eUY1cE16ZjBXdEl6czUwMlpu?=
 =?utf-8?B?eERyZzNpaE9rTEhCY0J5eERaRnR6NzAyWGFvU2htYmllNlBYY3RId0lwZ3Fp?=
 =?utf-8?B?SEsyajMzaDJObWgxbnh5Z0tvUk5ScDJqVEtTT0k1RThRMXp1QmdJbTcvWWJO?=
 =?utf-8?B?S3ZjNUN0OER2cDdlSC9lOTVHSC9PVzlINTNKUE9IWXNHUG4wNGZkR3YvYzBZ?=
 =?utf-8?B?ajdPNlNMVnFDWlBSdWRNdjlkNm42aFZpUzRncVN3cTRWMHNBV0dvUEsyRDZv?=
 =?utf-8?B?VHVYR0NIWUZPTHlmT0RKSDJiWkN4VVExZHVLdDN4NXNLNVJTQzdLSU5jWjNv?=
 =?utf-8?B?Q0wxOXVxQjNxZk4rSlR0a0NxWkVMQ0VGNW4wSGRTR0pVdG52WDFnNHVhWFBh?=
 =?utf-8?B?cXVGeWNSNFNOdHlYb2wxc1N5aFp0NjJITnhPaklwOStCTU85VCszUCtRd01v?=
 =?utf-8?B?Njc2eFRvcFZqWitDTzUrQzduMlZLN1ErcUtTTG0wcEpFYjhjajVSaWhSQTBL?=
 =?utf-8?B?OG1kdlFPbEUyYjRBT2ROSEovajg1Zmh6aFlsT2Z2bGh2Ukh2SnF1MmJVTW4z?=
 =?utf-8?B?UjhheFhISlRBcjVseUwxYWdRSVY5ck91Z2xaTTVZdmxJakU2dENMbkNwL1Nu?=
 =?utf-8?B?VER6NkVFUzVZY0pZNU5vUFdySzhiRDVUV2F3WG1oWWN2K0N4QlU4V2NXWWpN?=
 =?utf-8?B?VU5VU0pVYnlxaUpLaUtXQk5RaWhBWm1QV3BvOUtTTE1CR25Td1ExdWdHTkdX?=
 =?utf-8?B?dGtQeWFIWEZCdFdkZTRiYW9yeHpHMG91SzlNOU01WVJOZWcxaTRnV1ZRNEsz?=
 =?utf-8?B?aWJidGdra2xFU0xDYmJrWXJlRWdsOUNWRVg5YU93L2NydDRyMGRrajl4bzcz?=
 =?utf-8?B?QU1rM3dPMkUwQWQ5bzN6Q0crNXQxUUY5OGNHUDVHdnp4Y1JFVDhlMFpmcXZq?=
 =?utf-8?B?b2U5WVFxMDFyUVR3OTFTeVozdjZybmVJYkhMaXlBY1NDUGZQdjdyakJjTjJN?=
 =?utf-8?B?ZlRRTzh5K3lEYmZiOVpYcE96QVRYN0VVdzZlZmloQStXY0tMT0M3eTVtUzlV?=
 =?utf-8?B?V1dSZGxKdHM2Q3NIcUtxSkVQS1ZROXdkUjdYRG1KTXR0TFpWK3IwaGVlWVgz?=
 =?utf-8?B?dVJaSlVURERMbUc5aFk1SmlaQUpFZTRWYzR4Z1l0QnVmTkJvbCtuZkoxbTl5?=
 =?utf-8?Q?GMLad+CApAxBwFN8a+Q/kuk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04AB59AA01BF54488212127F95588724@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e219ce6a-e140-4c3a-ebbe-08daa655298a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 22:09:52.5591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8RuyFGuMH2w81z3XuxtKAl3sCofEyibd8o8R7+60gkCz8o5wzJIMLx/mcpt5ntoQzZLONBT3fzxtFA8jUyksw0HMnIBUhr7yJ9an44v04Tk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4759
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTAzIGF0IDEzOjI5IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IE9u
IFRodSwgU2VwIDI5LCAyMDIyIGF0IDAzOjI5OjIyUE0gLTA3MDAsIFJpY2sgRWRnZWNvbWJlIHdy
b3RlOg0KPiA+IFsuLi5dDQo+ID4gKyNpZmRlZiBDT05GSUdfWDg2X1NIQURPV19TVEFDSw0KPiA+
ICtzdGF0aWMgaW50IHVwZGF0ZV9mcHVfc2hzdGsoc3RydWN0IHRhc2tfc3RydWN0ICpkc3QsIHVu
c2lnbmVkIGxvbmcNCj4gPiBzc3ApDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBjZXRfdXNlcl9zdGF0
ZSAqeHN0YXRlOw0KPiA+ICsNCj4gPiArCS8qIElmIHNzcCB1cGRhdGUgaXMgbm90IG5lZWRlZC4g
Ki8NCj4gPiArCWlmICghc3NwKQ0KPiA+ICsJCXJldHVybiAwOw0KPiANCj4gTXkgYnJhaW4gd2ls
bCB3b3JrIHRvIHVuZG8gdGhlIGNvbGxpc2lvbiBvZiBTaGFkb3cgU3RhY2sgUG9pbnRlciB3aXRo
DQo+IFN0YWNrIFNtYXNoaW5nIFByb3RlY3Rpb24uIDspDQo+IA0KPiA+IFsuLi5dDQo+ID4gZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9zaHN0ay5jIGIvYXJjaC94ODYva2VybmVsL3Noc3Rr
LmMNCj4gPiBpbmRleCBhMGI4ZDRhZGIyYmYuLmRiNGU1M2Y5ZmRhZiAxMDA2NDQNCj4gPiAtLS0g
YS9hcmNoL3g4Ni9rZXJuZWwvc2hzdGsuYw0KPiA+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9zaHN0
ay5jDQo+ID4gQEAgLTExOCw2ICsxMTgsNDYgQEAgdm9pZCByZXNldF90aHJlYWRfc2hzdGsodm9p
ZCkNCj4gPiAgCWN1cnJlbnQtPnRocmVhZC5mZWF0dXJlc19sb2NrZWQgPSAwOw0KPiA+ICB9DQo+
ID4gIA0KPiA+ICtpbnQgc2hzdGtfYWxsb2NfdGhyZWFkX3N0YWNrKHN0cnVjdCB0YXNrX3N0cnVj
dCAqdHNrLCB1bnNpZ25lZA0KPiA+IGxvbmcgY2xvbmVfZmxhZ3MsDQo+ID4gKwkJCSAgICAgdW5z
aWduZWQgbG9uZyBzdGFja19zaXplLCB1bnNpZ25lZCBsb25nDQo+ID4gKnNoc3RrX2FkZHIpDQo+
IA0KPiBFciwgYXJnIDMgaXMgInN0YWNrX3NpemUiLiBGcm9tIGxhdGVyOg0KPiANCj4gPiArICAg
ICByZXQgPSBzaHN0a19hbGxvY190aHJlYWRfc3RhY2socCwgY2xvbmVfZmxhZ3MsIGFyZ3MtPmZs
YWdzLA0KPiA+ICZzaHN0a19hZGRyKTsNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeXl5eXl5eXl5eXg0KPiANCj4gY2xvbmVfZmxh
Z3MgYW5kIGFyZ3MtPmZsYWdzIGFyZSBpZGVudGljYWwgLi4uIHRoaXMgbXVzdCBiZQ0KPiBhY2Np
ZGVudGFsbHkNCj4gd29ya2luZy4gSSB3YXMgZXhwZWN0aW5nIDAgdGhlcmUuDQoNCk9oIHdvdy4g
QSBzdGFja19zaXplIHVzZWQgdG8gYmUgcGFzc2VkIGludG8gY29weV90aHJlYWQoKSwgYnV0IEkg
bWVzc2VkDQp1cCB0aGUgcmViYXNlIGJhZGx5LiBUaGFua3MgZm9yIGNhdGNoaW5nIGl0Lg0KDQo+
IA0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgdGhyZWFkX3Noc3RrICpzaHN0ayA9ICZ0c2stPnRocmVh
ZC5zaHN0azsNCj4gPiArCXVuc2lnbmVkIGxvbmcgYWRkcjsNCj4gPiArDQo+ID4gKwkvKg0KPiA+
ICsJICogSWYgc2hhZG93IHN0YWNrIGlzIG5vdCBlbmFibGVkIG9uIHRoZSBuZXcgdGhyZWFkLCBz
a2lwIGFueQ0KPiA+ICsJICogc3dpdGNoIHRvIGEgbmV3IHNoYWRvdyBzdGFjay4NCj4gPiArCSAq
Lw0KPiA+ICsJaWYgKCFmZWF0dXJlX2VuYWJsZWQoQ0VUX1NIU1RLKSkNCj4gPiArCQlyZXR1cm4g
MDsNCj4gPiArDQo+ID4gKwkvKg0KPiA+ICsJICogY2xvbmUoKSBkb2VzIG5vdCBwYXNzIHN0YWNr
X3NpemUsIHdoaWNoIHdhcyBhZGRlZCB0bw0KPiA+IGNsb25lMygpLg0KPiA+ICsJICogVXNlIFJM
SU1JVF9TVEFDSyBhbmQgY2FwIHRvIDQgR0IuDQo+ID4gKwkgKi8NCj4gPiArCWlmICghc3RhY2tf
c2l6ZSkNCj4gPiArCQlzdGFja19zaXplID0gbWluX3QodW5zaWduZWQgbG9uZyBsb25nLA0KPiA+
IHJsaW1pdChSTElNSVRfU1RBQ0spLCBTWl80Ryk7DQo+IA0KPiBBZ2FpbiwgcGVyaGFwcyB0aGUg
Y2xhbXAgc2hvdWxkIGhhcHBlbiBpbiBhbGxvY19zaHN0aygpPw0KDQpUaGUgbWFwX3NoYWRvd19z
dGFjaygpIGlzIGtpbmQgb2YgbGlrZSBtbWFwKCkuIEkgdGhpbmsgaXQgc2hvdWxkbid0IGdldA0K
dGhlIHJsaW1pdCByZXN0cmljdGlvbi4gQnV0IEkgY2FuIHB1bGwgdGhlIHNoYXJlZCBsb2dpYyBp
bnRvIGEgaGVscGVyDQpmb3IgdGhlIG90aGVyIHR3byBjYXNlcy4NCg0KPiANCj4gPiArDQo+ID4g
KwkvKg0KPiA+ICsJICogRm9yIENMT05FX1ZNLCBleGNlcHQgdmZvcmssIHRoZSBjaGlsZCBuZWVk
cyBhIHNlcGFyYXRlDQo+ID4gc2hhZG93DQo+ID4gKwkgKiBzdGFjay4NCj4gPiArCSAqLw0KPiA+
ICsJaWYgKChjbG9uZV9mbGFncyAmIChDTE9ORV9WRk9SSyB8IENMT05FX1ZNKSkgIT0gQ0xPTkVf
Vk0pDQo+ID4gKwkJcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICsNCj4gPiArCXN0YWNrX3NpemUgPSBQ
QUdFX0FMSUdOKHN0YWNrX3NpemUpOw0KPiANCj4gVWhtLCBJIHRoaW5rIGEgbGluZSB3ZW50IG1p
c3NpbmcgaGVyZS4gOlANCj4gDQo+ICJ4ODYvY2V0L3Noc3RrOiBJbnRyb2R1Y2UgbWFwX3NoYWRv
d19zdGFjayBzeXNjYWxsIiBhZGRzIHRoZSBtaXNzaW5nOg0KPiANCj4gKwlhZGRyID0gYWxsb2Nf
c2hzdGsoMCwgc3RhY2tfc2l6ZSwgMCwgZmFsc2UpOw0KPiANCj4gUGxlYXNlIGFkZCBiYWNrIHRo
ZSBvcmlnaW5hbC4gOikNCg0KWWVzLCBtb3JlIHJlYmFzZSBtYW5nbGluZy4gVGhhbmtzLg0KDQo+
IA0KPiA+ICsJaWYgKElTX0VSUl9WQUxVRShhZGRyKSkNCj4gPiArCQlyZXR1cm4gUFRSX0VSUigo
dm9pZCAqKWFkZHIpOw0KPiA+ICsNCj4gPiArCXNoc3RrLT5iYXNlID0gYWRkcjsNCj4gPiArCXNo
c3RrLT5zaXplID0gc3RhY2tfc2l6ZTsNCj4gPiArDQo+ID4gKwkqc2hzdGtfYWRkciA9IGFkZHIg
KyBzdGFja19zaXplOw0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+
ICB2b2lkIHNoc3RrX2ZyZWUoc3RydWN0IHRhc2tfc3RydWN0ICp0c2spDQo+ID4gIHsNCj4gPiAg
CXN0cnVjdCB0aHJlYWRfc2hzdGsgKnNoc3RrID0gJnRzay0+dGhyZWFkLnNoc3RrOw0KPiA+IEBA
IC0xMjYsNyArMTY2LDEzIEBAIHZvaWQgc2hzdGtfZnJlZShzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRz
aykNCj4gPiAgCSAgICAhZmVhdHVyZV9lbmFibGVkKENFVF9TSFNUSykpDQo+ID4gIAkJcmV0dXJu
Ow0KPiA+ICANCj4gPiAtCWlmICghdHNrLT5tbSkNCj4gPiArCS8qDQo+ID4gKwkgKiBXaGVuIGZv
cmsoKSB3aXRoIENMT05FX1ZNIGZhaWxzLCB0aGUgY2hpbGQgKHRzaykgYWxyZWFkeSBoYXMNCj4g
PiBhDQo+ID4gKwkgKiBzaGFkb3cgc3RhY2sgYWxsb2NhdGVkLCBhbmQgZXhpdF90aHJlYWQoKSBj
YWxscyB0aGlzDQo+ID4gZnVuY3Rpb24gdG8NCj4gPiArCSAqIGZyZWUgaXQuICBJbiB0aGlzIGNh
c2UgdGhlIHBhcmVudCAoY3VycmVudCkgYW5kIHRoZSBjaGlsZA0KPiA+IHNoYXJlDQo+ID4gKwkg
KiB0aGUgc2FtZSBtbSBzdHJ1Y3QuDQo+ID4gKwkgKi8NCj4gPiArCWlmICghdHNrLT5tbSB8fCB0
c2stPm1tICE9IGN1cnJlbnQtPm1tKQ0KPiA+ICAJCXJldHVybjsNCj4gPiAgDQo+ID4gIAl1bm1h
cF9zaGFkb3dfc3RhY2soc2hzdGstPmJhc2UsIHNoc3RrLT5zaXplKTsNCj4gPiAtLSANCj4gPiAy
LjE3LjENCj4gPiANCj4gDQo+IA0K
