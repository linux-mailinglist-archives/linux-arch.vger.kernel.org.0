Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A580553ABC7
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 19:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356295AbiFARYf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jun 2022 13:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355645AbiFARYd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2022 13:24:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDBC37AB4;
        Wed,  1 Jun 2022 10:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654104271; x=1685640271;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KMt8WigI3sHnYMvZcY1bergcsC+XUQxG2xrnIrTayrc=;
  b=DLxanH/HWJTlXHJP1PPYTNsxUHq3H14NTSCJYB8EAjNe4+h6554P14+D
   DQx9yjldK5hBy/4A4teEFuStTqP7tQNOvixMZlHtGR7KiyXDtgwe89yUy
   hiALUkfs9N0U1xo3CuG04/oh3Q5awlurPyOyUDTK2nxsayfo9dzO87e9D
   koAevvdr9h30Mmd5n6jk+S4vNIl6GFY6omCp47PpjXa7Mno491stODvmz
   mfHFk0YHeOhoNKUuc4SBdhTMzPBlGA39OsaeFcJ6//CnHNsYJNQJzybJH
   FsRVNYLfV8HKGjmvFDtSxyT9TJLL9Y1ZTZGgVKE1zFb00ZL5rA9ArLavk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="274466555"
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="274466555"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 10:24:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="904552620"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga005.fm.intel.com with ESMTP; 01 Jun 2022 10:24:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 1 Jun 2022 10:24:30 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 1 Jun 2022 10:24:29 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 1 Jun 2022 10:24:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 1 Jun 2022 10:24:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONV1nixcpIC4S8vZE0/5L/nCTFLBYV8WqVN2oZI5QAWmsnZeVfwXK8glUcFCgYw8rmObftrKyiCloGNO3xUGPbcVOCqEBqAl3W0tfglsPoA1pbJWeZ8yxNoAb50XXg7s65WOYzrndWt3rO+7bc1K7zZl+z006RlnbzZg+bP0Z8mReIrGh93PYq++9C3tc1hdlAEKe9HZx40yR6edxExEsCQnENYw176T+t4JCCeEMYqryAbGhvDtZLKAEWOs5M317t/mifnvLcOLgJTtopNvqXZxJt9TB7UqTVOrvYByXeb9hcHOYdkOtu1xbDqU0Z4CwujI8or6RFApDhzTUpIjJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMt8WigI3sHnYMvZcY1bergcsC+XUQxG2xrnIrTayrc=;
 b=JrlaVlZvqe6jgloRJEgPulHeUXQEr3W1tyExYhreY8QUa+l0go7jx+vIv83kMtZnSAG/wKyUqtQkxHXpuM7Ucnu+jfSSqWDugnejnkD6pT6e8Jh/732Fr07hZalvb/jqmAlzneXqem89DAU2PnaRUf6oACGy5xTG+oI9T59c1w0hny4nt4dnQQrfra+YbUIjRk90ARfjLSNEX6gcxBwlXM/UCLyta6h0UTDdy0vVZVBPGIayMDfZCLGpzl4eCNyaQwM2qXV/sf/JSKDCIGJ9RUzc4pcUksBxi9jSpYVklP3RpDSvZitqHnKPdD52cyF9UqSQrP3HVaUo8lTO1+pYKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by IA1PR11MB6172.namprd11.prod.outlook.com (2603:10b6:208:3e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 1 Jun
 2022 17:24:26 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03%12]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 17:24:26 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rppt@kernel.org" <rppt@kernel.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "adrian@lisas.de" <adrian@lisas.de>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "avagin@gmail.com" <avagin@gmail.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "dave.martin@arm.com" <dave.martin@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
Thread-Topic: [PATCH 00/35] Shadow stacks for userspace
Thread-Index: AQHYFh9orVaVUe6rNECZu4edjJzhZqyG5jiAgADTxwCAAJnkAIABGRSAgAADewCAAHMeAIAAC4MAgACbY4CAAZeygIAddLsAgAAA+YCAABC1gIAAF8EAgASAo4CAADfAgIAAKfMAgAEo6oCABLJcAIAAAt+AgIUewYCAAEo0AIAAAygAgAAQTACAAPNwAIAAm/yA
Date:   Wed, 1 Jun 2022 17:24:26 +0000
Message-ID: <1d77dcab5d5ee7c565cfc62601d3a28ecf5a6bed.camel@intel.com>
References: <YiEZyTT/UBFZd6Am@kernel.org>
         <CALCETrWacW8SC2tpPxQSaLtxsOXfXHueyuwLcXpNF4aG-0ZvhA@mail.gmail.com>
         <fb7d6e4da58ae77be2c6321ee3f3487485b2886c.camel@intel.com>
         <40a3500c-835a-60b0-15bf-40c6622ad013@kernel.org>
         <YiZVbPwlgSFnhadv@kernel.org>
         <CAMe9rOrSLPKdL2gL=yx84zrs-u6ch1AVvjk3oqUe3thR5ZD=dQ@mail.gmail.com>
         <YpYDKVjMEYVlV6Ya@kernel.org>
         <d0c94eed6e3c7f35b78bab3f00aadebd960ee0d8.camel@intel.com>
         <YpZEDjxSPxUfMxDZ@kernel.org>
         <7c637f729e14f03d0df744568800fc986542e33d.camel@intel.com>
         <Ypcd8HQtrn7T41LF@kernel.org>
In-Reply-To: <Ypcd8HQtrn7T41LF@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 832308d6-1ec4-41d6-f346-08da43f39416
x-ms-traffictypediagnostic: IA1PR11MB6172:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <IA1PR11MB6172C9E151ACE4458972C09CC9DF9@IA1PR11MB6172.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iiHfcmLMWGmkK0Jp4RCMgFONWq17nXfeI+We2OKuiSVVagTkJn1re8gYO6jqwisAOO1aWi0Bwuhc5ma6HC96bxXSvEm/6MDWgmRFVz5cVGF33gEIA/Z6tfl5KJl2UKwAMUkr4NnLMyD0LA9eqZBCiiKozWe+fgc21AN5Glh1S3+QSKOn/HYvC+egLaW9JnR14+792oeOvpnPkd/wHlD+4pGhJzXulF5MwKfMQaCXtAi7357R44goW9ImnPWUEIIxlU9xqN3SGydVKe11FfKGYl6J3KW7lJen3p9UD3FhGadZaTzoUaoSbMyRlb29OWx/2zTRBhhKOdQkdrZaTvegUmqApuXB9FoDS8+nUCAVVkOiT4WOkLWqpq7IZCU+TC+VLuLHE2UhvJ+QXtSgxUylqeILdJqEiUu35Ud1yRwirX2B/0Pe29qniXKvKEXzUHLfrCU+atYgSXBreByyaAUHSs3XZXmUnZ70B2l0kpDPIoPRGQcAFnUtLt1N1ICLka3ClS6H5X3c3MJXdhcn083q8BgOm92jlv8+lRHkFKUgZeRgrjq2F7/hIZNAFGgZPULTvWEd6T+xWVhqIEquv24tEHgS5HP5SLboSdv3l4WenEgbIrCsb1aj9U74SzaLdVJeQA35ncoUr5kpHLXoaSy7dppEenpP4TsU/azjLJC7Wxhub2HBJlvtoDKQCltJDDclhRP2hov8V2I/CPYJzwyixTXTeJOWzX0iszari4R5gdo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(66476007)(4326008)(64756008)(66446008)(66946007)(66556008)(76116006)(8676002)(38070700005)(82960400001)(122000001)(316002)(6916009)(38100700002)(54906003)(508600001)(186003)(2616005)(6506007)(6512007)(26005)(2906002)(36756003)(8936002)(83380400001)(7406005)(7416002)(71200400001)(5660300002)(6486002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGtwZXI1amk1SWVPUTFsVzRDU1RLSC93c3ZjalFKN2xINmlma2VDdS9aMW5D?=
 =?utf-8?B?cmVrUlRDRkxEcDExbEhEVW9HRG44RGQ0cUhKSGE0OFc4V2Zjd3R1aFhaTldB?=
 =?utf-8?B?T1IySnNnT1NXWE8zY3FnQVBTMnlNUjlob1Y1ek5GVVcxZDJJamt1Mk9RUmVu?=
 =?utf-8?B?VlFBWndGbmlSalRaUHFCRTdVWkVHSEpzRGFtWXBBVDNha1VVbGo5aWdjMmRr?=
 =?utf-8?B?OWdsTGVTS1ZURDdPLzJkSEdRV0VzcG92ZFc2VXIwbUxvZ09Qd0FRY2RrVXVX?=
 =?utf-8?B?TDlMOE1pUGZTbjhVVFBsa3Era05rZXZCcHd4YTZ3SEJHNXVWZmh1c3RSRnZs?=
 =?utf-8?B?cFg0S3VUbWlURktGWHM1QlRIT2dtTEN4cEJseU1Jb3grRkRhbmVTZnIwTWZa?=
 =?utf-8?B?aitVL0VNU0w2ODR2bnNqemg4T1M5VTk5Rmt5NDlVY0NGMmJOWHpueFpQeUFy?=
 =?utf-8?B?dmtSVitGOVF2SVRGYzJuMWpsRTdFZ0dZK21vUnZtaWN0Y0MzWUxrWFFGekZS?=
 =?utf-8?B?TnhCKzVGdHBOSHdYMllUcDZqRlJ4ZFpaQjdyditIQWtKdStMMG0xTVRUcUk4?=
 =?utf-8?B?TWNIdVU4anUzb0xjMGZMMTNVb09uQ243RTNROTBZelpZV1FBU1BvbG5XVzU2?=
 =?utf-8?B?WDNhaWpqMlphWXVnU0IxN012K293V1BvU3NHaUF5cnd2TG1xZEwvQllNNFNk?=
 =?utf-8?B?MTZrUXhjcnNpT3o5QS9ZZW5vYzFIRXNXYlhLcXg1Z003ZThXNFRTTXlsWmIz?=
 =?utf-8?B?S2pEbjduZERzNDFmNSs3OStwS1d2YnltRlIra2luTkxxNE9ldjlKRUJ5WGFu?=
 =?utf-8?B?a1hYZXZJNmF5cWJFTXdldWNEazZaS3ZTdVl4T3BqVk8vNlNBaHpQYklIakFp?=
 =?utf-8?B?V1hTbEZ1NUs3NEc5aU1zR3hpTzR6NGs3TkFMZEtjcThiVHNSVmJIQWpaaDFW?=
 =?utf-8?B?a25VdGhFdzVoNTEwSkFhaWNGemxSaFdIN2lqalJXMEpaNFZEUWJZaExYWVJF?=
 =?utf-8?B?TnpVU3ZwN25UY0Q5RmVRWHVkQ3hrVDVUcG5VOVB0Q05SaThSVmE1U2V6aVJm?=
 =?utf-8?B?MWt2ODhvZXZUTzQyWDVMa3NTSFp1WjdQSHZtNTZCVVpvVW8zR0xXWnE1OGtl?=
 =?utf-8?B?UC8weTllOFpBZFVFMGZ2R0Z3NmlQT3BVSW1vT000eDRGK1pHREQwMkxqQ2lQ?=
 =?utf-8?B?eVo2b3RTLzlPUDNQeHlXcjFQdXBGWGVvUXFmSlEvRHcxNk1qK0g0d01jOGJq?=
 =?utf-8?B?Zyt6TCs1ZkpqaVpiVmVEd09NdTJkWE9jT040SGpwcE1pWHU4QTREVUZoSXl1?=
 =?utf-8?B?cGtpOVpqMlRGMWE5b0JPaGx0U3QvZXF4eG9uWHV4YndVcXBWSmxZQ1hDaXRL?=
 =?utf-8?B?czNDTTQvU2VqQTlvUUpKWEY3MThYNFkvY3BZcVBBaTc1bVZPODhPTmVVaDNt?=
 =?utf-8?B?dVNDL2ZtaGo5ZFJuTDF0R1lhbTFCbFVkOVBoTUlNVmY0QlQzQnVqNFVIa1Bk?=
 =?utf-8?B?K3UxU0xEQVF5cmxsa0hrbVRmd0IzeHdqZGdRdzM3ZUJMcnpJaWtGcThuc0d0?=
 =?utf-8?B?RmFqVnRyZmVoOWxsd2k2b3BSVUllem50SUw5cDhlY3hNbUVTSWtpcVZpTHhS?=
 =?utf-8?B?M2d2NHlmWEN5aFNiQ3dRYWdCVDhWTGdLTkpxdUJPdmxPejFoVlgzY2JNdWVB?=
 =?utf-8?B?YktTRkppOUg5MTRlWVlYbVBOZmtScFFRTW9vWXNJckFzWTlBZVQ4SFNNUysw?=
 =?utf-8?B?NitQZzhCR3QvajJBemw4NkdKaVo4YTJ6UzlFazNyM0JKRnFyUUprR05mSnJv?=
 =?utf-8?B?ajdUQ2JRZWJ6ZGFrSXVmTkxoRGpjeTlxTXR5eHZpclBMR3lqeFhpaXJ2L2Iv?=
 =?utf-8?B?ZlhqT0YrTWxMMklSRmo4cFBxN3pLbUV6MnpiZExSeW8xWHc1RDhYdVZTTUFv?=
 =?utf-8?B?anpHR0IrY0orTnM5MmpycTV2ZFEwV1NDbGN5b25tWC9JMGRra1hsOWdkUENR?=
 =?utf-8?B?SG1GUFRLSFpyUzN1Rk9TMC9MeWdNSit1aTlsY3VET2tWckprVGxQaHFPMUhB?=
 =?utf-8?B?aW9lTjBsN3pwem51bkJ1eitIdTZQemVnWjI1d2tqUEFhdEU5cVdOZ0FoRW1W?=
 =?utf-8?B?bk43dWVtSllhc2VFWXV4Rk55eUpEdDFlUThCQ0o0N2w0YkZ1RnRRSko2a2lF?=
 =?utf-8?B?aWFUK1lPQTlwWDJaSThVMGQ4RjB4NzltQUhFMWVnQkJzU29Lc3hDK2hvdlJD?=
 =?utf-8?B?R3E5YktLcEk5WTFzaWVOK3hRMGpJb1lTTUNXUlVuTWlPMjVKcXVWZ1NYTWZF?=
 =?utf-8?B?ZUlQaXIrMVhxOHdrSFlQOFhsUHNvRHc3STBxU2J6MFR1Y0dsSVNyNHE2OW1k?=
 =?utf-8?Q?cHoMvHpbIAlc1Lqyq9ZOjBTNOkExNmfEemt3W?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <256EEE238D4063468270598C57E7FFBD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 832308d6-1ec4-41d6-f346-08da43f39416
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 17:24:26.6679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uGhznNUof9TY9ABG6W51zDdNWythD403B6B3PNbRj/wuW1qMu2HdID1MHwvXRlSdQc4Os1ZqCx2GdY6FJ+hkAuVSK+A6P9edPi3zKa1Y4io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6172
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIyLTA2LTAxIGF0IDExOjA2ICswMzAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiA+IFllYSwgaGF2aW5nIHNvbWV0aGluZyB3b3JraW5nIGlzIHJlYWxseSBncmVhdC4gTXkgb25s
eSBoZXNpdGFuY3kgaXMNCj4gPiB0aGF0LCBwZXIgYSBkaXNjdXNzaW9uIG9uIHRoZSBMQU0gcGF0
Y2hzZXQsIHdlIGFyZSBnb2luZyB0byBtYWtlDQo+ID4gdGhpcw0KPiA+IGVuYWJsaW5nIEFQSSBD
RVQgb25seSAoc2FtZSBzZW1hbnRpY3MgZm9yIHRob3VnaCkuIEkgc3VwcG9zZSB0aGUNCj4gPiBs
b2NraW5nIEFQSSBhcmNoX3ByY3RsKCkgY291bGQgc3RpbGwgYmUgc3VwcG9ydCBvdGhlciBhcmNo
DQo+ID4gZmVhdHVyZXMsDQo+ID4gYnV0IGl0IG1pZ2h0IGJlIGEgc2Vjb25kIENFVCBvbmx5IHJl
Z3NldC4gSXQncyBub3QgdGhlIGVuZCBvZiB0aGUNCj4gPiB3b3JsZC4NCj4gDQo+IFRoZSBzdXBw
b3J0IGZvciBDRVQgaW4gY3JpdSBpcyBhbnl3YXkgZXhwZXJpbWVudGFsIGZvciBub3csIGlmIHRo
ZQ0KPiBrZXJuZWwNCj4gQVBJIHdpbGwgYmUgc2xpZ2h0bHkgZGlmZmVyZW50IGluIHRoZSBlbmQs
IHdlJ2xsIHVwZGF0ZSBjcml1Lg0KPiBUaGUgaW1wb3J0YW50IHRoaW5ncyBhcmUgdGhlIGFiaWxp
dHkgdG8gY29udHJvbCB0cmFjZWUgc2hhZG93IHN0YWNrDQo+IGZyb20gcHRyYWNlLCB0aGUgYWJp
bGl0eSB0byBtYXAgdGhlIHNoYWRvdyBzdGFjayBhdCBmaXhlZCBhZGRyZXNzIGFuZA0KPiB0aGUN
Cj4gYWJpbGl0eSB0byBjb250cm9sIHRoZSBmZWF0dXJlcyBhdCBsZWFzdCBmcm9tIHB0cmFjZS4N
Cj4gQXMgbG9uZyBhcyB3ZSBoYXZlIEFQSXMgdGhhdCBwcm92aWRlIHRob3NlLCBpdCBzaG91bGQg
YmUgT2suDQo+ICANCj4gPiBJIGd1ZXNzIHRoZSBvdGhlciBjb25zaWRlcmF0aW9uIGlzIHRpZWlu
ZyBDUklVIHRvIGdsaWJjDQo+ID4gcGVjdWxpYXJpdGllcy4NCj4gPiBMaWtlIGV2ZW4gaWYgd2Ug
Zml4IGdsaWJjLCB0aGVuIENSSVUgbWF5IG5vdCB3b3JrIHdpdGggc29tZSBvdGhlcg0KPiA+IGxp
YmMNCj4gPiBvciBhcHAgdGhhdCBmb3JjZSBkaXNhYmxlcyBmb3Igc29tZSB3ZWlyZCByZWFzb24u
IElzIGl0IHN1cHBvc2VkIHRvDQo+ID4gYmUNCj4gPiBsaWJjLWFnbm9zdGljPw0KPiANCj4gQWN0
dWFsbHkgdXNpbmcgdGhlIHB0cmFjZSB0byBjb250cm9sIHRoZSBDRVQgZmVhdHVyZXMgZG9lcyBu
b3QgdGllDQo+IGNyaXUgdG8NCj4gZ2xpYmMuIFRoZSBjdXJyZW50IHByb3Bvc2FsIGZvciB0aGUg
YXJjaF9wcmN0bCgpIGFsbG93cyBsaWJjIHRvIGxvY2sNCj4gQ0VUDQo+IGZlYXR1cmVzIGFuZCBo
YXZpbmcgYSBwdHJhY2UgY2FsbCB0byBjb250cm9sIHRoZSBsb2NrIG1ha2VzIGNyaXUNCj4gYWdu
b3N0aWMNCj4gdG8gbGliYyBiZWhhdmlvdXIuDQoNCkZyb20gc3RhcmluZyBhdCB0aGUgZ2xpYmMg
Y29kZSwgSSdtIHN1c3BpY2lvdXMgc29tZXRoaW5nIHdhcyB3ZWlyZCB3aXRoDQp5b3VyIHRlc3Qg
c2V0dXAsIGFzIEkgZG9uJ3QgdGhpbmsgaXQgc2hvdWxkIGJlIGxvY2tpbmcuIEJ1dCBJIGd1ZXNz
IHRvDQpiZSBjb21wbGV0ZWx5IHByb3BlciB5b3Ugd291bGQgbmVlZCB0byBzYXZlIGFuZCByZXN0
b3JlIHRoZSBsb2NrIHN0YXRlDQphbnl3YXkuIFNvLCBvayB5ZWEsIG9uIGJhbGFuY2UgcHJvYmFi
bHkgYmV0dGVyIHRvIGhhdmUgYW4gZXh0cmENCmludGVyZmFjZS4NCg0KU2hvdWxkIHdlIG1ha2Ug
aXQgYSBHRVQvU0VUIGludGVyZmFjZT8NCg==
