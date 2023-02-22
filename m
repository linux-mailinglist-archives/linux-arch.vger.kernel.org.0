Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994CB69EC2F
	for <lists+linux-arch@lfdr.de>; Wed, 22 Feb 2023 02:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjBVBD2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Feb 2023 20:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjBVBDY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Feb 2023 20:03:24 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6005A22DD9;
        Tue, 21 Feb 2023 17:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677027801; x=1708563801;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=69RjnqsYrIuPdp/YH0f5/wyFp7g+a5/kDBrAmf/TJIE=;
  b=ZDUpQj0W0tjv8wgs5nIcsbWOYN3kqUjbJYZEgL1sPtvHLljX7jQ6Ytei
   /7xSOL1ZDjh8epbPyQ1Nclu+wcGEGpvcv8E4YjmNM6t6xQu7x6h00Ez/+
   lD9zWxeF/td4T66FhfVhBA5Cs1xQkSPj04c9i9+qISHBrnnbk85qrMrGw
   dYzSxF8pFFH3uiakLbiNIwal5D+KOYhT9aANeL/WnAyLsOIJJaAz8bMf+
   HtwJhpS1qXdgv97e+wL8CVhfv67Y54sFO19bsYU5JfflqeDvhOfRu9XfN
   TamaraKQc1I84lzXAZuxHbETx6bgu6iaRuGq5u2/6W7A86gDG/fs0g7qY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="419026288"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="419026288"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 17:03:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="702224104"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="702224104"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 21 Feb 2023 17:03:09 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 17:03:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 17:03:08 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 21 Feb 2023 17:03:08 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 21 Feb 2023 17:03:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6qYOA87mEca9PuP1zm7AarZq+Eac5ISQQFiC1I8ynChm6u7exPGmMrO0WhJ+wsag02Df9e5s3Kn6F9OQkqecUzJFgfO6aUVvsIzbryFGL8ngICOxayNn1+2Fzqrta1V3lR3DT6qmPokgQZonef1NgC4FEZx+t+Q0HDDLeOuIeYgzRfSDCwuSwXPzdJtQd/snKDjWIkbLVhvxYZbJljkE9X/lC8jQjgnVEKdPl5bukIOuZnbG0cy1N2QQ8IimjvDoVIHRU2IgaN+MrzqlBA+ZiWBXkp6GQCeS+YxflsefCCRDBPBixyTxu/f4Q4hmCgirq9EPp35D0Q3WCPL4L2Bkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69RjnqsYrIuPdp/YH0f5/wyFp7g+a5/kDBrAmf/TJIE=;
 b=a4e1HyHr5qOaCkA+Qi0BKBYYhPziSC/AQhSZHqfrWsbFsH3Bp9A7BoqlumvMtVZTiHDYnnwCUWN3+wKy24ynlNiL7Fhu8TBB2MkQ3K0pAhfOaNnZ7TFCrOxThCX8YU74/VbSkUx+X3gA3rk7ioKQKnpckXBW74218VDHZKsA5PXQ/u4cnX1zw5dV1M29PcF0wKVuXChXfWSvqGMKVglJ1I/i/ZymWCZ5mxpJbXbpBO+JgGocAYHwFLY25ls8C1SCb8xkWKjbasbJTo3QCKVK44Co1rFTXfBjlYUQo5aWdsfh7YZl4aZJ8hRlZK8m8l4KPoSsKU2/L4ATjfxNH/AAbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CO1PR11MB4945.namprd11.prod.outlook.com (2603:10b6:303:9c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 01:02:57 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 01:02:57 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
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
        "bp@alien8.de" <bp@alien8.de>, "arnd@arndb.de" <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v6 14/41] x86/mm: Introduce _PAGE_SAVED_DIRTY
Thread-Topic: [PATCH v6 14/41] x86/mm: Introduce _PAGE_SAVED_DIRTY
Thread-Index: AQHZQ95AseCELEMbPEKUKa6WOvZcWa7XtimAgACpbgCAALhnAIAAwiAAgABQ8IA=
Date:   Wed, 22 Feb 2023 01:02:57 +0000
Message-ID: <6af692a98dd536507e685fb8a772ddf8c1f741b2.camel@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
         <20230218211433.26859-15-rick.p.edgecombe@intel.com>
         <70681787-0d33-a9ed-7f2a-747be1490932@redhat.com>
         <6f19d7c7ad9f61fa8f6c9bd09d24524dbe17463f.camel@intel.com>
         <6e1201f5-da25-6040-8230-c84856221838@redhat.com>
         <273414f5-2a7c-3cc0-dc27-d07baaa5787b@intel.com>
In-Reply-To: <273414f5-2a7c-3cc0-dc27-d07baaa5787b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|CO1PR11MB4945:EE_
x-ms-office365-filtering-correlation-id: 1ca73232-c558-44fb-c71c-08db14708932
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W1sE3lLFfVXVPD84ah5UfS/7dVprt3hxjkDKsCuKEpSi18ulFmNQJs2GRII/+BIaGA/6dYX6lco6Qls2o4y4TtxHrwBWLNWTHHtmTGXgXuUWYfviLE2BFMq8uCG9aU96e+JruRUv/dHnirIsJaMYnWZH5WTBmtQ2ZJmmG3+90pJ0LNDb0Guyz1UNF/xoR4ILISuYqhVqtnBBtAajLp8P0ERDvbeiyUpB9b0j/mxWAwsg8yY6KI4WSOdHxowmGsYvL/1D1+K5nMECFRSk5G2jAN5IEZ2r5HB1UV1OiklvEoSAGS3kvq9Xy942FaaFycLv5d763amX0Nx9MmiDDE+/5u3f8GmtxWyboLSIKmmMMHTV+liP/oOyz+Gu5BcvdkTBrW7C+snY+J5xtw9Q/7y/R2bHpoQJ3DbN7wg/lcZLi5UxYJRj6WLN3S7dXkM6EEX042IBJkI84DfEXuvWaRzkUxZYZjemxvutjX85zkq4SMN4YI//JORbWdetnQFubbLfX/2zzhWY4CK50zjX8aNE5ndQddrtKNUaZPZ4DNR6xfcdCafQ3JJtPyMlgH+gZIGuMwRXkffZJgopjFIjeu2R8t63Tl3w50aJSSMQee/G6GwahWnDZ7zqoTfnQqma3c3Xdhus8Fe1TOZZHWQWo2dIJQqXW+1Alf4NVeDdXiSq3cl6Py8f6j6Blxx1nqDe4k8GnY5DR0NL9vVHrmu3LIYMWzFMLQnz3+lspqTpY1gXRnNf+udfKiCW/zK+8SDytFRdUrEwrgm9L8mbxTNt1oZzbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199018)(86362001)(36756003)(64756008)(66446008)(186003)(66476007)(66556008)(6512007)(26005)(4326008)(8676002)(5660300002)(8936002)(2616005)(316002)(41300700001)(6486002)(110136005)(478600001)(71200400001)(91956017)(76116006)(66946007)(6506007)(122000001)(38100700002)(38070700005)(82960400001)(921005)(4744005)(7406005)(7416002)(2906002)(99106002)(14143004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3JVQndGRlpUVjdpdXA1Ty9tM0QvNUdyeXJ2K3ZGVFA0WUZ3MFZHa2pFako3?=
 =?utf-8?B?MWowVzJDTnU3NUZlUTBvUS9tN2FuRUo5MHd0SGFVMEJXdCt2V2RleG9BK2NF?=
 =?utf-8?B?MU9VdWFvZ2N1aDUzcEFFQUwwK2ZHT3VQTEZFWkVDbkN3SHdEU1ppUkFvMlRv?=
 =?utf-8?B?eFkrS0wybVZDYTFHS1FaL0lFK2h3OWxIUmFTeFVMb2tMa3l6SnY2V0g0Ry84?=
 =?utf-8?B?Y04zdEVaSDlRMGJlMCthWjZSemR1M2prdVRPM3FyYm1GY2ZEN0ZtYThLOS9x?=
 =?utf-8?B?V1pZd2M3U1VxOUdFM3Fkb05zSzdlVDNQcko5SFhGUlE1NUgzSEtOeUQ1c0FL?=
 =?utf-8?B?OCttQUJBQldaU0VkUHVneHNMS3ZNUWZXaFUrN3paYXB3RDlJc05qSThhYTJs?=
 =?utf-8?B?M2FENWhzWmFyTThZWW5DUmppK3VGTHc0NUIyNWk0YklmMG14V09jTjFnekQ1?=
 =?utf-8?B?cnp6TFYvdWN2a1R3eFhPMHFHN0JLNVZRajVsWjdJMzNnZ3oyNkYwdkxLQk9u?=
 =?utf-8?B?bEFGS0o1bnFvTDFzRm5xQk1jL3BNVG10aGRSOHl5czZOaG0vVWpsMXhmUnl3?=
 =?utf-8?B?ZmtXSDFTQkZucFF5MnBMOG5aRUtPeWhOME9zZHNRb2dZekNwWDRycnN3RFA0?=
 =?utf-8?B?Wm9ITkJrdnZ1dk4yOGU5VVpHWUw0Z2RnQm94dStsZFdhK21KdVlmbXp6SnFh?=
 =?utf-8?B?Slo1R3VCRzFDb1cwUERVdW4vOWtvb1lZV2xWdDhWYXpZMDZXSVl3QXdmN0dP?=
 =?utf-8?B?YzZwU0xUUkdEVzNuTWI1Vy90REhuYnN1blc2dkxiMHdxMDBpUTRyOU9XVlFx?=
 =?utf-8?B?d1hlK1Y0dWY2TkIrdGxqUlJtSndVMGc2SCtpb3diZEM1NVpadENpWm9DWWxB?=
 =?utf-8?B?TmJGNnFaalowM0hDci9PTDVJVENZWkJ2M2xwei94UGJYNWJneVhjYjhjcExu?=
 =?utf-8?B?THJoR2ZhcU9PRkgzcXp6OUF0TkVIQ09hTzNnTWMyYmlTT2F5eVVLZGpoRmFw?=
 =?utf-8?B?NTR3cGpqc1hUcjdCaFFqU3R2THlZeExJOWNPOEJOakFydnAxUG1mVFFUL3RV?=
 =?utf-8?B?NWVhd2pZQllzWkZCUHdtWVNqaWFPZHM0ZVZFVlZjdDF0NkwreGdQOVlPN2E5?=
 =?utf-8?B?N1VVZjlJWFNzU3dGUHhLMVl6RjdHT0paUlA5Y05pM3dYOUYxc3U2ZkN1bWcy?=
 =?utf-8?B?RkJlYXlqREJFVUczY1V4b2RQSktvd0FxRW52a0t5LzRYU29nOGdjVGMrWnhM?=
 =?utf-8?B?L3hienBoaFFHMGpSaER1U1hNUTRSNVo5QWZ0MEN4K20wUTJJaFFZZHBLcm9M?=
 =?utf-8?B?T3FFVmt4dTJOZkpGUDhPMEMzSWh0M0YwUzlwT0lkajJDKytYRFFpc2dsdjBO?=
 =?utf-8?B?cERmallSUHBxNEEvTjB3Q0w5RVpablRaZGtuM2VQOXMwUHZGck5XWUQ4eXJZ?=
 =?utf-8?B?QnZCRmZoeXRjV2tLVnVJeTljWjF5aStJU2FlTnVkdDJTbG9VN0xNdEsveFpr?=
 =?utf-8?B?WFF5cFB3WXVvalBXRHhVY29IVzZ5QnU1R2Q1RFYrMGQxZDhzOVRDOFpBYVhl?=
 =?utf-8?B?SzVhejVIK3ZmbTRIMmMzOG9GRTE4OW93cUZpdUNyNTFOVXlZVHBhQ0NiaUdY?=
 =?utf-8?B?N1l1M3M5U0xUYkhlT0laWXloQS9NcG90dFhoc2JoTUNucytoYmV5TnBrWkFM?=
 =?utf-8?B?NjA5ZEVIZXlhZHBWdkl5RldHeG9ZTnJOaEtHNWtSNC8wV2xjdjg3MFlHaHdC?=
 =?utf-8?B?ZnBEUTNSL3F5Z1NVS1Y0Y3BLWksxK1NTTkJpUXgzZGhTUEpDZE5DNFZyQS94?=
 =?utf-8?B?Wm1jUEsyNjU1b1lpaWtNNDFrdE44QWJleXhWTk5GaGtuMzFzck9Fd2hhWXF2?=
 =?utf-8?B?cENzOE9tNzE4bG1MT0p4bUZDQVRGWU9pSUswdXZqdXc0QWxGd0RiQWU0NUM2?=
 =?utf-8?B?bVFwMVZKa2pRWEZ1K0N4VWhuRUplOEJxZ3JYYTRGZDY4dHRQUlIwanRpY0tB?=
 =?utf-8?B?V0VNR0FvNWk4VXh2c04vK3c5OCtMbEhSczhlQVAvRTNqNjBHazVOaHpGeEps?=
 =?utf-8?B?Z3NHeC9XM3ZCSUlNd3BsSHhIUnFqOXJoRERqam1JL0xLMElCcURmTmpZSVpS?=
 =?utf-8?B?c0FOdHhqK1h6emhIRFYvOGplWnhiRS9nalpnMDhwTFFWWHY3VUQyOVNUcy8z?=
 =?utf-8?Q?V73b5js/+K0zGMllLWX7/GE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CC474D7462C374A9F7348666CB5F06F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca73232-c558-44fb-c71c-08db14708932
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 01:02:57.3443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LAVmjbPkWO2/Sg/oNsT9Z/KfOpZcQ1cs3jy6EgCiufYD61JCP6lUQec77j5OF1bZqfimNRqFM8sE/9rlB7I8uwy5ZInrZrXKFzISG1ooYio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4945
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIzLTAyLTIxIGF0IDEyOjEzIC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gMi8yMS8yMyAwMDozOCwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6PiBTdXJlLCBmb3IgbXkg
dGFzdGUgdGhpcw0KPiBpcw0KPiAoMSkgdG9vIHJlcGV0aXRpdmUgKDIpIHRvbyB2ZXJib3NlICgz
KSB0bw0KPiA+IHNwZWNpYWxpemVkLiBCdXQgd2hhdGV2ZXIgeDg2IG1haW50YWluZXJzIHByZWZl
ci4NCj4gDQo+IEF0IHRoaXMgcG9pbnQsIEknbSBub3QgZ29pbmcgdG8gYmUgdG9vIG5pdHBpY2t5
LiAgSSBwZXJzb25hbGx5IHRoaW5rDQo+IHdlDQo+IG5lZWQgdG8gZ2V0IF9zb21ldGhpbmdfIG1l
cmdlZC4gIFdlIGNhbiB0aGVuIG5pdHBpY2sgaXQgdG8gZGVhdGggb25jZQ0KPiBpdHMgaW4gdGhl
IHRyZWUuDQo+IA0KPiBTbyBJIHByZWZlciB3aGF0ZXZlciB3aWxsIG1vdmUgdGhlIHNldCBhbG9u
Zy4gOykNCg0KT2ssIERhdmlkJ3MgZ2VuZXJhbCBzdWdnZXN0aW9uIGFjcm9zcyB0aGVzZSB4ODYv
bW0gcGF0Y2hlcyBpcyB0byBtYWtlDQp0aGluZ3MgbGVzcyBDT1cgc3BlY2lmaWMuIFNvdW5kcyBs
aWtlIHlvdSBkb24ndCBoYXZlIGEgcHJvYmxlbSB3aXRoDQp0aGF0LiBJJ2xsIGp1c3QgZG8gdGhh
dCBhbmQgaG9wZSBJIGRvbid0IHN0aXIgdXAgYW55IGFkZGl0aW9uYWwNCmNvbmNlcm5zLiBUaGFu
a3MgYWxsLg0K
