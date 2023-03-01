Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7396A6A737A
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 19:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjCAScj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Mar 2023 13:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCASci (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2023 13:32:38 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09C242BFC;
        Wed,  1 Mar 2023 10:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677695557; x=1709231557;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ebx43VnEeZ0f7p6qDJMq5VRGjLe/L7PLQnIcWxFdnNY=;
  b=g0lwnEwvpz8L99/OJcZBsC2q+Zk4eCUcEfwdT6zGgGoFaIMPsoYnOIE1
   dTosGXN0F61H10QICWFSRqx8YPanbrzc6HdZGXNi87CLQSI1Fa6flwsY+
   jL4yAxItpiKE7UgHIyGTJS2C752tUKQzip/JlU0KingOA0ySOuFpPEA29
   hw7OPEFvPNKkqB7NjwmaSiDB/y+4kYU+MtKGpTjYQaTasVIZo7iWRwQEC
   CW0RbTMaBFjILORa4gurlnzWvPrtKbcz0SOwFx2SpZTjiCAb5on7w7z4E
   jujCxmX3eAJPEfwfuFSFGQIX2BLTVuaVeJgmhhMWPH87KMM3ly9kXoWhb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="336779145"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="336779145"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 10:32:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="676864405"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="676864405"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 01 Mar 2023 10:32:36 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 10:32:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 10:32:35 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 1 Mar 2023 10:32:35 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Mar 2023 10:32:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmzGQqU02WOPUz0FkWF474b4a77JBSLhfZ7TDGNu7jIlTQLfkSpQGno67HHpzK0m0vRIEmFdLMksj3Zcp3p9cIRPHRNILS+d/jRosszLBZM/vkUj6cFSw6h7kL6uL8wn6jkYEYEmRO0YHyc+fN8lk2a7duhhdHB0IHQlA7K3WSm0sivIQ0RhIxE6KwcRGkD2jH8i7ptTaXFlX3ZB9Q/r7zW5ktm28Gt8uvQgYG7hQ9i3a/JUKx8Y73NeNyGjbWS/BMLLkxnPyVNyAjm1M/AYwvhA5pJP0OCZ/xgmJMl4PPjF8aUw6zLVnTV98YROMMQHvwiTgTnjJq7FlQIg23hQ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebx43VnEeZ0f7p6qDJMq5VRGjLe/L7PLQnIcWxFdnNY=;
 b=ODg48lH9P5y+bvhSA8RgD+1/NbnnBMgUzfoWeemkRrCr171Hn6YAHBtoGW2BdkQxOolbKY6ysSOSwiUjCm8HA+n/K2KNcPPxnEanV+VY3EAhRa4O+8Ox5Un4JoukqnLA2Fhc2xBPzs7FiNxYm0KB1ldBZY/TAjAQh3gYzPJfCYP1e+h1N+fGpVTcLMnxNplwUhAnANvMfnFHy0rqrkh362LbEe7atbRkYBB8yfmrt7AHXIch3pjCwRJfGgRjBeokVlsQ/DkzbrAI8grLPHCLnbauh5F5mdatvsoBorWAdLEWnNpFAUgiwErhvGZLs7zWUPWldcP3rpfAGumvrYTyHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SN7PR11MB6678.namprd11.prod.outlook.com (2603:10b6:806:26a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 18:32:32 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 18:32:32 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
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
        "debug@rivosinc.com" <debug@rivosinc.com>,
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
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v7 01/41] Documentation/x86: Add CET shadow stack
 description
Thread-Topic: [PATCH v7 01/41] Documentation/x86: Add CET shadow stack
 description
Thread-Index: AQHZSvs0qmse+4pcp0Wr5jGCLtkFY67l/FKAgAA/GgCAAAb6AA==
Date:   Wed, 1 Mar 2023 18:32:32 +0000
Message-ID: <df8ef3a9e5139655a223589c16a68393ab3f6d1d.camel@intel.com>
References: <Y/9fdYQ8Cd0GI+8C@arm.com>
         <636de4a28a42a082f182e940fbd8e63ea23895cc.camel@intel.com>
In-Reply-To: <636de4a28a42a082f182e940fbd8e63ea23895cc.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SN7PR11MB6678:EE_
x-ms-office365-filtering-correlation-id: 68993361-a3a9-4296-e542-08db1a835208
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UjaLFFQS1/eOc8fJr1kZC3JDkdx94oI+ethq1d/sucz6e1Y8fc3eF2GCaU/cGmNG/iDHKMdUFrYBpzSHAWcFhzCciSffP7cx94zySfW58WDeoglTcQY7n3UCRVYdMSa8/K+btP0B6sIPbSrc0yVmKXXQDN7jdYZTf5Emi7ukeAXgSI6Ic+Yw7B9wHDkvPCfiPkXxZaikbsi+UEKfiL/sLTA0qmAySwGEV02rZaQPsH0aprA3UvTsZ+G/EveeVBIg2JFRjq26M8OL6FsqF21gX8Vin1RWSsbSIeuNowUvUFsVcGKCXjc5x4kUqUEKOSm+oVzOVFHbXXyd9zkPEialCMYAFbUqsjM9qdJbymdCiN3EjNBaEzcOxGNfOey0cwA6z2NxS+HfVP87EMI7qanqHByva8j2/hPw18P5SsUKTzfKVMtjElOCTO8eXY1XijqRzU1QflHpvhBeB8VVu21Sz+kVpXeIM1wYrP0W3qQmhbbJKeyp4HnGMmQURK/kC/DOXnZzDhcFW/tKrHI70Ha+88/CVzRnPgKR2xfIa8u/pUjWeoY+eKi5aH5D9EFy7QBtoCzQYgK++/bO5Y8Iiid2ilR/6DZQhanl0I/fToSuYxgYmhh52TIQXCvBOyaVQAQ8cXWy+AuMfrQ0VZMguOcVn/22ybmL4cnwVKYc2lwNfXT8cFpAwPLe/d5joKEcFKUjor2B/CP5XcQ9mrvWHmzClIEYxOGGs7V+ufdWh3Xx4zWDr1ub98aarhaGNdqtWqLa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199018)(2616005)(38070700005)(41300700001)(86362001)(316002)(36756003)(478600001)(71200400001)(83380400001)(110136005)(6486002)(64756008)(66446008)(66556008)(4326008)(66946007)(8676002)(76116006)(91956017)(66476007)(7416002)(7406005)(122000001)(5660300002)(82960400001)(8936002)(186003)(38100700002)(26005)(2906002)(6506007)(6512007)(921005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azNlVXpTc3lSbmVVZFFJN1pUcmhSNWgzNlp1VTdZa3UxSzl1VWtkdTV2bjc3?=
 =?utf-8?B?ZXdWbG9DVXJld254R21DcGZqZTMrd3lJYkg3U3Z5TTNVNU93VWREQUlvZkZ4?=
 =?utf-8?B?anJnRFRRSnJiVEc1cVNsVm5pUnhDeS9kMFM2L2x2MTZHOW02Mm9GcndhL1Ns?=
 =?utf-8?B?a3lHcmNvSE9qZXhsenFOSi9Fa29xWXU0VlhvQnpXU1ZkNUZINlAxZUhUSnBs?=
 =?utf-8?B?TURxZTF3Q2F3RGRJclJvdGRudlNnenQyd0RUR3RlT2M0SEJSamlxUTA3bmhJ?=
 =?utf-8?B?TnRMQ1pxWnRPVUFQSmVwNVdpOThMZGRxS2NSVXpMR3lVY2FPT0trZnBxSGh3?=
 =?utf-8?B?S2dndjIramNrV3FPVEdxY1kvaDNZdmFxdXZOQkNnM25vUnlGYnVuK2l0eHZC?=
 =?utf-8?B?a3VMNFhZenhCa2JHRFhsMUNQSHpOeW1TYnM5THFoSzQrQXhrMkpDc25qWmI5?=
 =?utf-8?B?ZXRjaDBZaS9NOU8zc1R4UTRKSlh4ditrQjFTbmlkQ2tMc1FZT1JrR1pCVFJC?=
 =?utf-8?B?bzcwUHdxNWd6Y1ZVUDhRNVRoOXFHUmVMU2wwZXpURUllaEROS2FLak1RWWUr?=
 =?utf-8?B?dWxDWGg5bS9jRm5PSm5qNDFla2NsQndDZWhEZHdESHhUUi9mZDdIUXZ5NnpL?=
 =?utf-8?B?YlozYUdzOHM4NWRxYWY1dG16YlFjSzc0ODN0OEFYTHNwUnFWVWZUai9GM2li?=
 =?utf-8?B?OEJ1VnZvaVBvcnpNdXhWY1NLdm96OFVDc3NzdndFV3Zyc3U0allpV2JGUEY3?=
 =?utf-8?B?VHRDa01iYTkzRWN5Q29MS3Z3YW5oKzJtZHc3SlVPN2ptSkozUkVyVFNBUzEw?=
 =?utf-8?B?U2cwQ2pjK0QvODUvcXR6ZWg4MXdhbjVUSzFTTWNMQUQ5VW14U1FwTGZzai9r?=
 =?utf-8?B?QytncnJXYUc1V1hEeW1NWmptQnlDdjBheGZrWUZhTWh0aEdqWGNjVXBieFox?=
 =?utf-8?B?dnY1QlVzeHpjSVljdEJjd0VieW9WRm4vM3RUQkgrL3ZTTExhVTViZGZBLzhy?=
 =?utf-8?B?TlkvaUlobmJPS0pWNlZNY0QrMVdPTHFWS1QrZjd1Y1g1c1F3bWREWm5MM0dJ?=
 =?utf-8?B?eFJmd2xPZllZVjVGdmJrSDc5dDlnMUdoMkdiMi9LRmdFazArdlJNUnVYbjBQ?=
 =?utf-8?B?LzBxTHNSbURoS0Y2bklwRU9vTWpWQU9ZUnlZRzQxZ0pTSk4wdkhRS3NOamF5?=
 =?utf-8?B?bVVWbUdVMXdVMjFaUFlta24ycmNJdTN0Q0RSdDgwVm84SEkrNFg2OUxVYVdt?=
 =?utf-8?B?QWdxYy80dHNRS0NtVGg1SStnS3JJUmttaEdIWFVGb0J4WEpMMXhZWUhvNXA0?=
 =?utf-8?B?b2ZJYTFhWGFVZDUySUxjbXRBbFlkTWFLTm9HU2RTUHZkd1RQS2ZFY0xYNXdW?=
 =?utf-8?B?M3JQNHB2UFNnUVAvUlhCNmxNMDBGN1NOS3c3LzR1YWRibEdTUWJIbWNTZFZj?=
 =?utf-8?B?WmZOcE83dThKd09OcjBNeCtqaThicWlwUGdOZENJNUkwbXBWdjkwbHZQYXdG?=
 =?utf-8?B?bHRYZ3k4c1lJYVRZUmdvSS9QMUlWSldqc3RiTkp0aFFKM3ZmbTZLTVZiRkM5?=
 =?utf-8?B?RGZzUldleEhPcjRERmlsVHVlWkZkNXJ5aXdUQjZpRkxaUDFkSFJWTFdMdXZM?=
 =?utf-8?B?MW1nN0l2YjMySWpZVk92OVhtNWJJUjN3NDdGbzFkT0ZNRXBsbTdMNnlpTkdH?=
 =?utf-8?B?d1dMOElBUUFjb0ZpeVgybmdKZW1FOVVTb1BLSklLSTNhOUcvRmt1TzZHTlJt?=
 =?utf-8?B?OEFYWDQ1RnZGWTRLcm5yYkZCT3NhazZVVzRrUzhBUVJzcGprMVkwZW1lZ2RI?=
 =?utf-8?B?Q053S2psb1JnN0ZRbDB0UkNJc01neUI4UWhyeWZtQlhrSmVhTWJVZDdWTTEz?=
 =?utf-8?B?Y3pLdStCOU9XVFFQUnNuaEMyTUpIOVpMcExZeWNaTStGYVU4ekJiRlVjSWNs?=
 =?utf-8?B?enJJdkdVV1VFSVZCbkJmZ045bjBKKy81N0tUajVpN0ZzL2UvMjUrUkI4WHdt?=
 =?utf-8?B?VVU4SnVMUFNmWkM4SFhZMkpic2JPWlEyNFFWdVZlVmM5K0ViU2UwRjJlNmxm?=
 =?utf-8?B?OHVkeUN4K2tIaFN1My8rTzVqMDBrb2xwNjBOdVNHSEZXbHlBa1JXdGUrbU94?=
 =?utf-8?B?YkJLSkF3ZVl5ODY1WGhESkZ6YTM5YW83MXRxb1VXTDgvYmNuVmVIT3pLVHhr?=
 =?utf-8?Q?nXChDyrYAQzJaiJL6bG9MCk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB8A955093565F408BCF3C8F12ECBB43@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68993361-a3a9-4296-e542-08db1a835208
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 18:32:32.1784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u7u2MhA2uCzXU6+Zog41IYPa7VTilKxNHgg+U8aDpZYbP37ItuqaP2kDHO8jtxrCGMHbi4rt4jsXK9VkulBz+dbI1Svysi59/yNtjGYcjEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6678
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIzLTAzLTAxIGF0IDEwOjA3IC0wODAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gPiBJZiBvbmUgd2FudHMgdG8gc2NhbiB0aGUgc2hhZG93IHN0YWNrIGhvdyB0byBkZXRlY3Qg
dGhlIGVuZCAoZS5nLg0KPiA+IGZhc3QNCj4gPiBiYWNrdHJhY2UpPyBJcyBpdCB1c2VmdWwgdG8g
cHV0IGFuIGludmFsaWQgdmFsdWUgKC0xKSB0aGVyZT8NCj4gPiAoYWZmZWN0cyBtYXBfc2hhZG93
X3N0YWNrIHN5c2NhbGwgdG9vKS4NCj4gDQo+IEludGVyZXN0aW5nIGlkZWEuIEkgdGhpbmsgaXQn
cyBwcm9iYWJseSBub3QgYSBicmVha2luZyBBQkkgY2hhbmdlIGlmDQo+IHdlDQo+IHdhbnRlZCB0
byBhZGQgaXQgbGF0ZXIuDQoNCk9uZSBjb21wbGljYXRpb24gY291bGQgYmUgaG93IHRvIGhhbmRs
ZSBzaGFkb3cgc3RhY2tzIGNyZWF0ZWQgb3V0c2lkZQ0Kb2YgdGhyZWFkIGNyZWF0aW9uLiBtYXBf
c2hhZG93X3N0YWNrIHdvdWxkIHR5cGljYWxseSBhZGQgYSB0b2tlbiBhdCB0aGUNCmVuZCBzbyBp
dCBjb3VsZCBiZSBwaXZvdGVkIHRvLiBTbyB0aGVuIHRoZSBiYWNrdHJhY2luZyBhbGdvcml0aG0g
d291bGQNCmhhdmUgdG8ga25vdyB0byBza2lwIGl0IG9yIHNvbWV0aGluZyB0byBmaW5kIGEgc3Bl
Y2lhbCBzdGFydCBvZiBzdGFjaw0KbWFya2VyLg0KDQpBbHRlcm5hdGl2ZWx5LCB0aGUgdGhyZWFk
IHNoYWRvdyBzdGFja3MgY291bGQgZ2V0IGFuIGFscmVhZHkgdXNlZCB0b2tlbg0KcHVzaGVkIGF0
IHRoZSBlbmQsIHRvIHRyeSB0byBtYXRjaCB3aGF0IGFuIGluLXVzZSBtYXBfc2hhZG93X3N0YWNr
DQpzaGFkb3cgc3RhY2sgd291bGQgbG9vayBsaWtlLiBUaGVuIHRoZSBiYWNrdHJhY2luZyBhbGdv
cml0aG0gY291bGQganVzdA0KbG9vayBmb3IgdGhlIHNhbWUgdG9rZW4gaW4gYm90aCBjYXNlcy4g
SXQgbWlnaHQgZ2V0IGNvbmZ1c2VkIGluIGV4b3RpYw0KY2FzZXMgYW5kIG1pc3Rha2UgYSB0b2tl
biBpbiB0aGUgbWlkZGxlIG9mIHRoZSBzdGFjayBmb3IgdGhlIGVuZCBvZiB0aGUNCmFsbG9jYXRp
b24gdGhvdWdoLiBIbW0uLi4NCg==
