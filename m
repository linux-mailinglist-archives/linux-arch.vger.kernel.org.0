Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1A76A21A2
	for <lists+linux-arch@lfdr.de>; Fri, 24 Feb 2023 19:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjBXSiY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Feb 2023 13:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjBXSiW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Feb 2023 13:38:22 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDDF2129C;
        Fri, 24 Feb 2023 10:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677263896; x=1708799896;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Irrz6zQ9+rslBHKRFRAr6Gv6CxxS3HSe7DQSux3A0WQ=;
  b=fcfWOjKE09lHB85eTNace1pXfbHzTCTOBh9iqeU+CYjaDFdZMXovl/MH
   /rEcCRJL6Ie6pDVI8LUrsMLbw2yxVKn9hVBHD+Hi6jzpCgShdtpG/OzO0
   ydmXPfHbZcGXHkllAL170/dhcZy6+BP1ssbZQCNGUJQ/vbG1s2oNsTCdy
   pFIJf1mx87z/ClH85ZXvW42NN57yz8Xk84S6Jn0ip0PG1kshpfulP6oI+
   lFygQpqeUry4aEgmE/mJ4LDIB3Q7dsUSOQen0w0hryrpQQ3CrPyDdS7x3
   ACMiIMdOpEH87cYUZ3eeeiwQRJfxla24SUjz1SZDoA38e+DwkPcpMWLhI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="333557875"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="333557875"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 10:38:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="672992074"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="672992074"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 24 Feb 2023 10:38:01 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 24 Feb 2023 10:38:00 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 24 Feb 2023 10:38:00 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 24 Feb 2023 10:38:00 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 24 Feb 2023 10:37:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRIIrUFKau5Cw6sSKsT1pVqPrHflw344SBYOUZFxxLi6stRp4H/2fTBNBjX1M7Ik6aoErmPm0fzwvB37au7FtVxIHVKlH+ESQNTHx290f19m0YV5d3A/eQbrLSxafEXcxO74QqVx8a8MZ7HNMoNCKhYUp68DG5e8S44CAyDZsRdjV09CbL1FXoa0sVs8zlwyaGV5odGpF4T/42TM1+YsI+bwH4NtQoyJK2HqGSXUwYd+oQOk3Z7Wd+65Lc5h14Yrfv3mGPjgc2dq0tUyIFJtvq7Bx7XLQ6duxVXAX8z90y6/aJx96QThsyz+RNhisB2XnF3CduF67CA1eD3KwhgRjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Irrz6zQ9+rslBHKRFRAr6Gv6CxxS3HSe7DQSux3A0WQ=;
 b=C6g9e6AzQP/Cjv8xQBJUqsEwm5vpy6VOWYo0ey+E5QrNZ9zZxjCv934/z3IuiHp9WnP5KFKPivIfZfl7tEdnBCdjJ8Aox5Rpyh5QwUkxnANnve5bi0rX+Bik5MGuQ4R1YoqIl04CDykjzHOKbKjwhH+gzqTpTlpfWaWMdjHUQYkKTGC6pBnNpodIEjUE+x6dX6ou4mvkHMdJJ/DdfgEA5ivF+1DXjfHyvHszvXUICgSIe+kqLzRQ1POtGnIn2gcZRuLDzLgi0jXLQwfL64V+/mt0sWxoK78X1Rcn7KjhUQZ9ikehsURWBNgiooeKzJKdMMKpXpyOeAkAt5i5btEDYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH0PR11MB7562.namprd11.prod.outlook.com (2603:10b6:510:287::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 18:37:57 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 18:37:57 +0000
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
Subject: Re: [PATCH v6 28/41] x86: Introduce userspace API for shadow stack
Thread-Topic: [PATCH v6 28/41] x86: Introduce userspace API for shadow stack
Thread-Index: AQHZQ95DLT0p3p6er0+nOfRd208Kja7eDPuAgABpgQA=
Date:   Fri, 24 Feb 2023 18:37:57 +0000
Message-ID: <9c67abd16cce9251bfdb87bcc7e47bbf32e4a9f2.camel@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
         <20230218211433.26859-29-rick.p.edgecombe@intel.com>
         <Y/irg8d6OZ+OCFml@zn.tnic>
In-Reply-To: <Y/irg8d6OZ+OCFml@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH0PR11MB7562:EE_
x-ms-office365-filtering-correlation-id: 16d3d64d-8bd4-4e7b-03f3-08db16963fd1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zz9P5XVCGFa/k4smgIjJ8UnX13GBCGvFiCfpZh6sqTgvuOaPW4+I92CYDchZa2xJxULKQvtuLSaUebgntDHwpAYIRHIexvJBjEYsOOCVWnROV8U8W9IxRFAN+5/6r84GJIAsHMKROmmyFWR0ibY9uAig+md3Czo5N+fu4GnY/dnrTQtBGFiyjxEReFZ8mBcRhcCCzjVmYdvo0Fq3bKuVOMErINJh1h+CXZr7/8bREnKCdBZdsV641Ucl2xkvG521HNCFsqJRlxRHeQC4nhKmjuaARtZMAHAI0PL6xPOE5HeoaqqE/wNtXe7xNINawL5h+Wb6zrT8dOGQLNdVjm2E8MzDjnFQFtq64ARI00GCYMFF5FjYgOmm+4B41XHfzauGOPeUBixr3ue3o4wKQYY+omdB7DCqD7GdqEWOximkIzoQFAJ+nbF9bpl0cbakd8vnqcirL1eTPjt+bE/gt9l7znHpj1rHxXkRYDNs7k53ZESSFqvYx2ji1e7IKJyYzM0H9Noj8rOi2OBOzoyKSAsMra6OBndCQ0nWF3vTFflxMFDoXuFomIRPNasaH3Ua9qGfdII342m+SnPSR/LdIVzeIOw15WpL7W2Y6tQHFj+ei/X1akU+oytEPPb5i38s1zK5ga4xx8xT/qVzOxKxLmnaAOBjWSrKDzxJDi9GVmiGV9uLBPB6JY+nTKmh90xBs6WurLEqWPHildX3xGjkLLD2oA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199018)(8676002)(316002)(54906003)(91956017)(66946007)(66476007)(66556008)(76116006)(83380400001)(6916009)(66446008)(4326008)(64756008)(38070700005)(41300700001)(5660300002)(7416002)(8936002)(7406005)(6506007)(186003)(6512007)(26005)(2616005)(71200400001)(966005)(478600001)(6486002)(86362001)(122000001)(36756003)(2906002)(82960400001)(38100700002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFZ5U1dTSnAramRObDlSQ0cxc0ZSTkloa1FiNzR5Y2tqUUp5dm5Ub1VJUTlZ?=
 =?utf-8?B?LzNpUVg5THloTGNQL291YVhDSzFpSzRWc1F4clBjVHhzWDdiT1gwSVc2Q3ND?=
 =?utf-8?B?UC9TUlhOcGNiZC81NGNUYUFleEpGa3BIUXpkeWhPVTNGVk1LanArUENoMmk4?=
 =?utf-8?B?Z1diL2ZuTXdidTZUTHlUQUhSWU9RV2NxYlRmZ2pVOXVJZ0g0bU1IY3pxVjlh?=
 =?utf-8?B?QWNwZVNuYnByeTlQN0VNKzM5bWlnVVJOaEhqUEdxOHl5RWMrRXlOejA0dldX?=
 =?utf-8?B?V1RrdnZ4c2xRYm1uaGJXVnJKM29hYjJwYXF6UW9ETVJuT0xMY2lmWWprYW1Z?=
 =?utf-8?B?Y2xXcWQxcWpydEFXRjVnVGhzTW52VzNXQjJyeXlsMkhjZ1lyZ0s4TUFBN3Jq?=
 =?utf-8?B?bDZjVXVpbUY2N0RsOXUxWWp3Nkg0d0NJb1BjV3JUQlZHUTNsM29NbVRrQWNo?=
 =?utf-8?B?UGFMNVN0UEZNVWl1eGxZTTN3VmJIbEJLN0FRYmxPUDNsMGtLYktVOE9pK21R?=
 =?utf-8?B?QnhpelFRWXZSeFRBVkZKOW5VMW5oRCt5amFId1krbW1DeWRCSFZmSlgxdEh3?=
 =?utf-8?B?bFJDM280Z05xK0hGOVoxSVIxS1J2UUhBbjFkUHpzeUNwS2FsWUgraTViMmpy?=
 =?utf-8?B?NWlmM3J6QWRmS3NJdFMwUHlXSTdMU1hFN1orL3RMY2dic3hNa3JnSmFvR0sr?=
 =?utf-8?B?KytuV0Q0bjN5aGYyMHpTSDErcFE5b1pmUVZwR25MMUM4aGdCS2s2UHBSU3Rz?=
 =?utf-8?B?UmVFMmFGeCtPQ25MeUxJc2hjaE1XOFQ4T2JLV2ZMekVJZHpMNkI1MVNNbFhu?=
 =?utf-8?B?a0x0VEdXVG1oYmwxOVMzUk93d0VZMXlTME1DdWFrYWc4WmJGa082S2oxakFE?=
 =?utf-8?B?WEhIRTgvVk5TOC8wckNxZnNQSGJNUFhLS0VLRGM1Vk9BZmRKVnJoU1lrQWRB?=
 =?utf-8?B?YWl6eDYyQ1lFWXJ4MS9DbUhwWWJTWDg1OTNzOFNZTXBWVC9ObXlvaXNtZjNT?=
 =?utf-8?B?TUM3SUR3T2FPMjFIZ2NZRmxiUjZ3a05HQ2d3NEVwYVgzUU91RlRDaDRXQnRx?=
 =?utf-8?B?VFJUKzJsb3Q0c0hFcDA3L1MvcDAzWkdBZUV5dEgzY2ZXcEFkRUpLaTlCTllD?=
 =?utf-8?B?dENjVHhPRXN3cUlvS25iMUxLUWl4ZjhsR05FVUtiVTZzSllmTlZNUFJ0ZEVu?=
 =?utf-8?B?WDZQekpPeUFTYjkvMDBmU1dZREEvQ00wOGVHS0JDbm9nbnlHWVJhMDJzV2VE?=
 =?utf-8?B?OW9DSDFxc1cwQmhyRmtjUytLSWg0T2Fsd3Jzd0NoU1pGTXMxZk83b3Vla1pK?=
 =?utf-8?B?UlcwVDU3b3R1d1VLQmI2dWtGWmhrY2tlbE04NjN4b0czeXBiV2dJbmtaMFJM?=
 =?utf-8?B?b3cyL3ZjZEhmSmE1eTZIaXRpNzNxOVkwQk9kQWpLRTgxb3ozd3VDWHRQTGtL?=
 =?utf-8?B?bTlZM2pMT0FGN2dSN0RCZ3N4RE43RjBEMGMzVU5yTnNIOGJNclhxK29mbWRD?=
 =?utf-8?B?MEZJYVhOcU1TSnBiZWFyQ00wQ2g3TVFpVzVNQ2FSdGpuVmltTlNkeXpnVHdm?=
 =?utf-8?B?ditHaURGRFpFaklhd294aUtXeHdiQ3pYNUt0S3ExbHpDOElnNXczYTFHelZU?=
 =?utf-8?B?Uk9WMFQyM3Q0Tk5QdDhwUC9XVkl2TnpxU2QzVGxQbC82aUhmaFd0L2JOZWdJ?=
 =?utf-8?B?L3kxZTh2T0gyUndXYjhHVkVzOWZReXh2b3ZQSDRvdXYydzNPbUVoQXFwWGFi?=
 =?utf-8?B?bThZQ3V1LzNkbXpudS92OUxVUUg3VXoraU1ZSUR0ZlA4ejkrSmxFNTdESjU5?=
 =?utf-8?B?NENZTllQSmh4bDZoSk4wTWp1dDNoNUlOWklsSUd2aVBSbkhKYkF5MTY1Y0x0?=
 =?utf-8?B?SThqeGJsa25VSXdad3cyUDFsQVhQT0NIdzZJYUNSRXJTT3hPc2x5YXlRdjFT?=
 =?utf-8?B?MmNTWnd0N2FNeGFFZVo0VCtPM3cxdTBRUklpOHVmKzZSd3RaL21JaTZORE9w?=
 =?utf-8?B?NUdOUjJGbURoaHQ3NnNCb2k2dXVGV3VDd0Eya2FtbTU3dEw3TkhzUmp3dlhC?=
 =?utf-8?B?aE4vUzNMZTRYYlprbUJySlNSWWlpZ0wvZjJURlNQNGE5VHpWaStJNXlpaGgy?=
 =?utf-8?B?WVA5Y3B4REppK1JwcUR3T2J2UmlyT1pHSHFxamF5cnluYVRYTXB0SUdTTmta?=
 =?utf-8?Q?nGoKKV3LxcPkAslR3NZMgNs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B3322D8BC3A4A46B44D5C905B520093@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d3d64d-8bd4-4e7b-03f3-08db16963fd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 18:37:57.4156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KhJ06rQj6/vh08Q5IfS1UaE5HhyKh54l66HzFo1iGhMVNPkGpuhpclrhY8E5v41uxrmtKadlFZO6G3GD6OMrWMy+1bfZ/zq7y7BZ6Pvuia0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7562
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTAyLTI0IGF0IDEzOjIwICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFNhdCwgRmViIDE4LCAyMDIzIGF0IDAxOjE0OjIwUE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL3VhcGkvYXNtL3By
Y3RsLmgNCj4gPiBiL2FyY2gveDg2L2luY2x1ZGUvdWFwaS9hc20vcHJjdGwuaA0KPiA+IGluZGV4
IDUwMGI5NmU3MWYxOC4uYjJiM2I3MjAwYjJkIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2lu
Y2x1ZGUvdWFwaS9hc20vcHJjdGwuaA0KPiA+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvdWFwaS9h
c20vcHJjdGwuaA0KPiA+IEBAIC0yMCw0ICsyMCwxMCBAQA0KPiA+ICAgI2RlZmluZSBBUkNIX01B
UF9WRFNPXzMyICAgICAgICAgICAgIDB4MjAwMg0KPiA+ICAgI2RlZmluZSBBUkNIX01BUF9WRFNP
XzY0ICAgICAgICAgICAgIDB4MjAwMw0KPiA+ICAgDQo+ID4gKy8qIERvbid0IHVzZSAweDMwMDEt
MHgzMDA0IGJlY2F1c2Ugb2Ygb2xkIGdsaWJjcyAqLw0KPiANCj4gU28gd2hlcmUgaXMgdGhpcyBh
bGwgbmV3IGludGVyZmFjZSB0byB1c2Vyc3BhY2UgcHJvZ3JhbXMgZG9jdW1lbnRlZD8gDQoNCklu
IHRoZSBmaXJzdCBwYXRjaDoNCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMDIx
ODIxMTQzMy4yNjg1OS0yLXJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tLw0KDQpUaGVuIHNvbWUg
bW9yZSBkb2N1bWVudGF0aW9uIGlzIGFkZGVkIGFib3V0IEFSQ0hfU0hTVEtfVU5MT0NLIGFuZA0K
QVJDSF9TSFNUS19TVEFUVVMgKHdoaWNoIGFyZSBmb3IgQ1JJVSkgaW4gdGhvc2UgcGF0Y2hlcy4N
Cg0KPiBEbw0KPiB3ZSBoYXZlIGFuIGFncmVlbWVudCB3aXRoIGFsbCB0aGUgaW52b2x2ZWQgcGFy
dGllcyB0aGF0IHRoaXMgaXMgaG93DQo+IHdlJ3JlIGdvaW5nIHRvIHN1cHBvcnQgc2hhZG93IHN0
YWNrcyBhbmQgdGhhdCB0aGlzIGlzIHdoYXQgdXNlcnNwYWNlDQo+IHNob3VsZCBkbz8NCj4gDQo+
IEknZCBsaWtlIHRvIGF2b2lkIG9uZSBtb3JlIGZpYXNjbyB3aXRoIGdsaWJjIGV0YyBoZXJlLi4u
DQoNClRoZXJlIGFyZSBnbGliYyBwYXRjaGVzIHByZXBhcmVkIGJ5IEhKIHRvIHVzZSB0aGUgbmV3
IGludGVyZmFjZSBhbmQNCml0J3MgbXkgdW5kZXJzdGFuZGluZyB0aGF0IGhlIGhhcyBkaXNjdXNz
ZWQgdGhlIGNoYW5nZXMgd2l0aCB0aGUgb3RoZXINCmdsaWJjIGZvbGtzLiBUaG9zZSBnbGliYyBw
YXRjaGVzIGFyZSB1c2VkIGZvciB0ZXN0aW5nIHRoZXNlIGtlcm5lbA0KcGF0Y2hlcywgYnV0IHdp
bGwgbm90IGdldCB1cHN0cmVhbSB1bnRpbCB0aGUga2VybmVsIHBhdGNoZXMgdG8gYXZvaWQNCnJl
cGVhdGluZyB0aGUgcGFzdCBwcm9ibGVtcy4gU28gSSB0aGluayBpdCdzIGFzIHByZXBhcmVkIGFz
IGl0IGNhbiBiZS4NCg0KT25lIGZ1dHVyZSB0aGluZyB0aGF0IG1pZ2h0IGNvbWUgdXAuLi4gR2xp
YmMgaGFzIHRoaXMgbW9kZSBjYWxsZWQNCiJwZXJtaXNzaXZlIG1vZGUiLiBXaGVuIGdsaWJjIGlz
IGNvbmZpZ3VyZWQgdGhpcyB3YXkgKGNvbXBpbGUgdGltZSBvcg0KZW52IHZhciksIGl0IGlzIHN1
cHBvc2VkIHRvIGRpc2FibGUgc2hhZG93IHN0YWNrIHdoZW4gZGxvcGVuKClpbmcgYW55DQpEU08g
dGhhdCBkb2Vzbid0IGhhdmUgdGhlIHNoYWRvdyBzdGFjayBlbGYgaGVhZGVyIGJpdC4gVGhlIHBy
b2JsZW0gaXMsDQppdCBkb2Vzbid0IHJlYWxseSB3b3JrIGFzIGludGVuZGVkLiBJdCBvbmx5IHR1
cm5zIG9mZiBzaGFkb3cgc3RhY2sgZm9yDQp0aGUgY2FsbGluZyB0aHJlYWQsIGxlYXZpbmcgdGhl
IG90aGVyIHRocmVhZHMgZnJlZSB0byBjYWxsIGludG8gdGhlIERTTw0Kd2l0aCBzaGFkb3cgc3Rh
Y2sgZW5hYmxlZC4gSXQncyBub3QgY2xlYXIgeWV0IGlmIHRoZXkgYXJlIGdvaW5nIHRvIGJlDQph
YmxlIHRvIGZpeCBpdCBpbiB1c2Vyc3BhY2UuIFNvIHRoaXMgcHJvbXB0ZWQgc29tZSB0aGlua2lu
ZyBvZiBpZiB0aGVyZQ0KY291bGQgYmUgYW4gYWRkaXRpb25hbCBrZXJuZWwgbW9kZSB0byBoZWxw
IGdsaWJjIGluIHRoaXMgc2NlbmFyaW8uIEJ1dA0KZm9yIG5vbi1wZXJtaXNzaXZlIG1vZGUsIGds
aWJjIGlzIHF1ZXVlZCB1cCB0byB1c2UgdGhlIGludGVyZmFjZSBhcyBpcy4NCg0K
