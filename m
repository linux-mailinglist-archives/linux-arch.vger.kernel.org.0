Return-Path: <linux-arch+bounces-2158-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8827984FDD7
	for <lists+linux-arch@lfdr.de>; Fri,  9 Feb 2024 21:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE1B1C23C1B
	for <lists+linux-arch@lfdr.de>; Fri,  9 Feb 2024 20:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3392512E7A;
	Fri,  9 Feb 2024 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C0DBlokm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3516AA7;
	Fri,  9 Feb 2024 20:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511501; cv=fail; b=aUu/bY2QVz7yhmrGZylqSob8NmK+f8KhRLe58sghuNeRR1Kn8OqOPISBmsjsLZsynGrsp7pPHdAIbgfdvm8h+1m0y+v26jAsUuMuwLEaIejQq6/7I908T/ijUFVaYQe67AnnEXe0aAxGw9A2e67WRhv+6uSO/j9SnADJ+IERWLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511501; c=relaxed/simple;
	bh=Wk13llEoAEZK2reCAXEFv2pKxLe107CHI28Ei7HUlMM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZojQ5vxswodkQM4llHGWdn1aGKbLVVdY+GIRtTg9sEpYJx+k+9V5B2XIxa2Leahxy0RkDzpDaD11iE0s6Iq95w2OyL6gFbHYUzd7PDlUKYwQUETC1IOOF8xOEWWII9Z2kUJUPniJcUN0TZxPQvT85MttY1+UJDMo46asi/acmb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C0DBlokm; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707511500; x=1739047500;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Wk13llEoAEZK2reCAXEFv2pKxLe107CHI28Ei7HUlMM=;
  b=C0DBlokmZav0c0UzRLnlJJyNuy1R+RIuoSUzoDEPLqGw3TZi8F3jWERS
   jz6JoLdADNlU5I3qSNu61fNI3MokPwcVPiOM0yydC8Ht/BdRpOf8Gry/g
   VDUo3pfsDZDu4/5/d6rU9syRth0bEW7X/i+6RfysCIPWozXfsRdfrR84D
   9MlVtY9blaYTT1COyQEwUveVM+AZJYbf1udxDEYe5w84JMl6fh60Yp56C
   feQn+dik9PjHic6G5go3QrS5D27YIt3vk+EeuxAPib3YFVnq9RQnwi9qX
   Gapygke2IH15mx+xDL6Ix9D8uA5ddwHV0laxJF4CzL82ULAS0S8vzTbEn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1407317"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1407317"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 12:44:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="25260565"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 12:44:57 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 12:44:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 12:44:56 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 12:44:56 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 12:44:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/LswlPLfGdUTFRCT57kEuRb4I7YxkSYbaz2JQ4++wTl/59GWddzYEnDU/XZgeBfwbn+PU/cD7YacNB5ef5BAd/a2OXYFZQ2ZsX0+iHbakcYJIndiC/doR9gdJs6QiHaZVn6I8LNIoeloEwltGVB/v6roaS529lG8azRajcaM+kAc0P2NuwQZhkPISHUiqeVGE1W+bfQtrXzlV4ivuTXsDUrKrKSchcwEJPFs+Gfz/0ww7sPfZsWDYr/dmK1xi9RFVEASGTGRCgw7hgIGHiHPztUEx6vV2o1TkT6tMJQO0rUJM0qWxEpRyzddcy3Ahvowk7u9dqKAG/4NUT+kmf8xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wk13llEoAEZK2reCAXEFv2pKxLe107CHI28Ei7HUlMM=;
 b=VAKiqyaC3ysuIrKOy73pkezj1pZONq0qJMBn3vM6OCSGeYAYI37ajjXdWBdMNVxXa/z7Pf672S3Ecn3JPULPAy33dl8SPol7/he7r2c81iz9+hw7M1RzKXp6NbQy5tGk6nSozO5PVj0Ehf2PN5b+T4Q+HXHgRy+1ZxR6skRPUdldMN54Ootiv3Fic6T2ZPpq9NUzvOoExQyboUKBERPFiJtQVZxNFxe+6KGv9xt8ZJ5OOAVnXPEtYxO2uGOBVo2fxHGJ9jzxSLIJC7hwzZbr6CHkPuRfn/WrCo+LA6ftEWPZ/11Q8eQtFf4stsiUuj3hQaRxT79/WahF1Hn1iXdmwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS7PR11MB5991.namprd11.prod.outlook.com (2603:10b6:8:72::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Fri, 9 Feb
 2024 20:44:53 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409%7]) with mapi id 15.20.7249.035; Fri, 9 Feb 2024
 20:44:53 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "debug@rivosinc.com" <debug@rivosinc.com>, "ajones@ventanamicro.com"
	<ajones@ventanamicro.com>, "bjorn@rivosinc.com" <bjorn@rivosinc.com>,
	"conor.dooley@microchip.com" <conor.dooley@microchip.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "keescook@chromium.org"
	<keescook@chromium.org>, "kito.cheng@sifive.com" <kito.cheng@sifive.com>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "alex@ghiti.fr" <alex@ghiti.fr>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>, "alexghiti@rivosinc.com"
	<alexghiti@rivosinc.com>, "atishp@atishpatra.org" <atishp@atishpatra.org>,
	"cleger@rivosinc.com" <cleger@rivosinc.com>
CC: "josh@joshtriplett.org" <josh@joshtriplett.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gerg@kernel.org"
	<gerg@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "bhe@redhat.com" <bhe@redhat.com>,
	"charlie@rivosinc.com" <charlie@rivosinc.com>, "david@redhat.com"
	<david@redhat.com>, "samitolvanen@google.com" <samitolvanen@google.com>,
	"heiko@sntech.de" <heiko@sntech.de>, "panqinglin2020@iscas.ac.cn"
	<panqinglin2020@iscas.ac.cn>, "mchitale@ventanamicro.com"
	<mchitale@ventanamicro.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"revest@chromium.org" <revest@chromium.org>, "mason.huo@starfivetech.com"
	<mason.huo@starfivetech.com>, "ojeda@kernel.org" <ojeda@kernel.org>,
	"baruch@tkos.co.il" <baruch@tkos.co.il>, "waylingii@gmail.com"
	<waylingii@gmail.com>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "joey.gouly@arm.com" <joey.gouly@arm.com>,
	"ancientmodern4@gmail.com" <ancientmodern4@gmail.com>,
	"mathis.salmen@matsal.de" <mathis.salmen@matsal.de>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>, "shr@devkernel.io" <shr@devkernel.io>,
	"andy.chiu@sifive.com" <andy.chiu@sifive.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"vincent.chen@sifive.com" <vincent.chen@sifive.com>,
	"greentime.hu@sifive.com" <greentime.hu@sifive.com>, "oleg@redhat.com"
	<oleg@redhat.com>, "willy@infradead.org" <willy@infradead.org>,
	"zhangqing@loongson.cn" <zhangqing@loongson.cn>, "jhubbard@nvidia.com"
	<jhubbard@nvidia.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>,
	"Wang, Xiao W" <xiao.w.wang@intel.com>, "cuiyunhui@bytedance.com"
	<cuiyunhui@bytedance.com>, "brauner@kernel.org" <brauner@kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "ruscur@russell.cc"
	<ruscur@russell.cc>, "shikemeng@huaweicloud.com" <shikemeng@huaweicloud.com>,
	"jszhang@kernel.org" <jszhang@kernel.org>, "jeeheng.sia@starfivetech.com"
	<jeeheng.sia@starfivetech.com>, "alx@kernel.org" <alx@kernel.org>,
	"guoren@kernel.org" <guoren@kernel.org>, "chenjiahao16@huawei.com"
	<chenjiahao16@huawei.com>, "omosnace@redhat.com" <omosnace@redhat.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "evan@rivosinc.com"
	<evan@rivosinc.com>, "bgray@linux.ibm.com" <bgray@linux.ibm.com>,
	"apatel@ventanamicro.com" <apatel@ventanamicro.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [RFC PATCH v1 15/28] riscv/mm: Implement map_shadow_stack()
 syscall
Thread-Topic: [RFC PATCH v1 15/28] riscv/mm: Implement map_shadow_stack()
 syscall
Thread-Index: AQHaT1fwP0pRQmDoxEaF26DrihDWXrECkvkA
Date: Fri, 9 Feb 2024 20:44:53 +0000
Message-ID: <ba45e69f69851721419b84f1ff8b66a490f92c86.camel@intel.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
	 <20240125062739.1339782-16-debug@rivosinc.com>
In-Reply-To: <20240125062739.1339782-16-debug@rivosinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS7PR11MB5991:EE_
x-ms-office365-filtering-correlation-id: bcc5741f-e3da-4187-8ed6-08dc29aff807
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RfL494m/nmchgdt/zvRd/msCKQq2vajvyEr8dsmxO60NWIanA7oLV5tX56qyLOj+4Qy0jPi6fWOxh9WQ5FYhSwxG5STmjHiUkppI06QAlWzp2jx27qkRLtEDDdh/KjEvUBHLoYimL1ey/keSZVhFCaiAnhwBYVnMHrwmetwBeqrRPhNU5R3nz+ZHIMa1B0ceVzJWBgSvyKksfMMBZLWhBNZvSX7buX9oNB+GbMUoLjMf0hkoZUSgY9t8QH/yCSJz9FCIzvpEvEQ4hDW0CwPy4JICqCKqWaLm2SnOZD3zLFQYoyddlNzxKPnH8sRpS+OMsyIsi3a7RFHvX7c4f0Yia1Fi0QUn1WuJyyved1gUCs5X/UWcBimXmqp2zTipQQ2n9xTpe2sLDNKhyseA8Q7IIwvNkHxJOgIeY2VATwjyQMJ9f4LMrCjpznL11AUvjLRVoaxuwm07Vb14nCuaZXO5AhN/YvgGAH39xjut9JxxWTYhTMEXoQcjCsC4nx6n59fP+2Rzitpp1Ar4Tu5ZC9g1N33RXfWHosa89FW6fStRnI0DhwlzOCTjscyxN8m8F/RZqRc2LbkGWXvNOYUVwW6VLYj2LhH7XnUi2w7hAUmlITE2FzLjZb+aOlnDDhdjbWJd+vj1MVoe1LFpQrA3WGLdzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(136003)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(7366002)(2906002)(5660300002)(7416002)(7406005)(82960400001)(86362001)(6512007)(71200400001)(83380400001)(2616005)(6506007)(6486002)(478600001)(26005)(8676002)(8936002)(38100700002)(122000001)(64756008)(66556008)(66476007)(66446008)(110136005)(76116006)(4326008)(316002)(66946007)(54906003)(38070700009)(36756003)(921011)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmlVOW85RE5Id1lERWl5eWM0a25nOXlKTzdKdm8wMGRDUXgydXVyaUJ6SEZY?=
 =?utf-8?B?WHJwWXRLU08yZnZkRWYxVTBFRFJsZmtSbURza0hFSTc5QUlEV3paRGVrMGxR?=
 =?utf-8?B?QURPTVkybm5DK3FoTzVCa2ZWRERlOCtXVmx6akNoc20zcHRhaDNxNWpUdXZn?=
 =?utf-8?B?cTJ2WkN2TnZjRUZhbzU5WVAxekFyY0ZYU0wvemxXR2x0N25XUmtTWDJianBq?=
 =?utf-8?B?N3BoRGpwdURpZklSbGVBNEJpQjRCK3U3bnI4M0tYcEhBczRiZCtFSXhzSGVQ?=
 =?utf-8?B?aTBNTnBTQkUwUE83UXVORWhMaHpTeFRHbUNZbDhMSEpHTmdhSlZjZFUzME1y?=
 =?utf-8?B?Z1dmaXVuUk1KTHVTRmw5cHJXcXdVdVFJL0VJUkMxU0I0dnRUNllrT2hhRVVD?=
 =?utf-8?B?QWM5MkhQaXJXaUowMWdMOXlRaWVPd0Jqc1BKdnRlZDhyMElPQTFoNnBuQ25C?=
 =?utf-8?B?S1pvbUxFZTlRNUhzcllSVDJlYWZEb1NCLzBKY3g3Q3hVcHliSVptTC90Z01B?=
 =?utf-8?B?R042bUY1WEs5V3JTMjBrSXZ5NjhMZGRIb05CQ0daRXZlOXVsbkhqd2tuUmZa?=
 =?utf-8?B?T2dlMWEyd05pQmduNkZDcFF5MmZNYzFTeThBcGdubTRyVksxVGl0U3FrVkxX?=
 =?utf-8?B?YmxVTnA2NE52UVN4TTdBQXdPNkFCUjhLdWQzZGR2alN0RW02ZDIyVDNwcHJX?=
 =?utf-8?B?bm9TRGt4T0o0czdvUkJieU1KYWtBOG13QmNjSktoUGtrWGNtRjMwRVBlcjQ2?=
 =?utf-8?B?TDZzRWxtcGU0eXpLTDdnL1RWNm50dXQybEh6eXNTNHRCMGZRa3EvTEhSVDc3?=
 =?utf-8?B?dUoyYXdUQytFdE85SVhHb3lOUzNzZytXYVJucWsxT210TXZ6VTAyTE44RmJ4?=
 =?utf-8?B?OFdlVnRUU2dSdUpia1FaK04zY0Z5WVdpTEdzN1lCM2FwSFR3N3V0ODRBajRO?=
 =?utf-8?B?cml2QW5vdkdUWkp3VE9hcnlzYVFTNHlHczMvMUcvZ3k5ZkZUZE1NY2U2VjQ2?=
 =?utf-8?B?SmV6WXVHaGtrdXh6eWFBT2lHcU9lTFB4czBkMTlmTHlLT29FT0xzV0IvYTVG?=
 =?utf-8?B?TjNmZVdLRlNRaUo0UTVNZlVkSmJpLzd6WWlwZE9RbVgvTlRid3dZd05ZMWdy?=
 =?utf-8?B?bURKeHZzV3JxOHRPN09rYjQ3bER3N2RUajZVdVExaTdFZXZKc3pBUU4rTURC?=
 =?utf-8?B?Q3QrcFhIVzlYSENoajhtb096ZUYvUkV6UmNlWU5IUGZWcGFTZ2ZvdkhlK2pq?=
 =?utf-8?B?dHZjMGtoUHdLT1hGaWROTDFtRjJnd1FSVXpBSitZR3E3Tk1vNnFPNGNJZTdT?=
 =?utf-8?B?NEVPNXByWTRmb2V4WTZWVktBN2dLOHN0M2l6Ujh1VVBMb1ZhZ1dsN2tFQ0ww?=
 =?utf-8?B?WWRBRndFazFUUktUdjBiK3pWaURncjN5cnd4TlYwSHpLTUJIT1JjQnZPdm5r?=
 =?utf-8?B?YlpzajR0T3laaUNmbldGS1dlQmhHbDZJSFNnTXJ0cEVDUGRhbDFWWTBJUmhO?=
 =?utf-8?B?MXVHWFFJTTBaU0Z6UUM0L0V1T3pQK1RvVi84QldRTmoxMnQ1OVNXSnhGTXNo?=
 =?utf-8?B?WGNSVkVMOVFFUERBSzE3QUZtRUVGY2lMYVNQK1RBaUdJd0F2eENXTHJQSm4x?=
 =?utf-8?B?eUxTWXM3UWdITlU4d2xCQnBxQ3oxZThDdytKTTRqUUMxUkhXOTVBVUY1L2hN?=
 =?utf-8?B?QkloNGZOa055Y2l3RXZ2OE53SWU2ZHBNYmJLN3VHcFMvOVhhd1ZZamhXRFNx?=
 =?utf-8?B?bGw5dk91NWRCTjNZYVdRWU0wdTJldGhLeStrTU1rZ0g5Z1RXb2V0anUwRjRa?=
 =?utf-8?B?Sy9VMTdLd2U3Y1B0ZWkyTHhsOEFkd3pzTjBnaDE1U3VvMDlUKzZHTHA3VDZE?=
 =?utf-8?B?WTNrb0ZjYlVtdTF2R1dvRzZkWHZuaGsxdm9pQ1h1Y0ZmSlgwZnoyMDVKYjFz?=
 =?utf-8?B?N2NZdXJQZzVGRWMrdXE4RGMzcnAwTk5rNFFuYUplRDZuWFJvNE9xeDE2enV6?=
 =?utf-8?B?b0JuVGNjaTNUUXpPRThCdk9tak9FaHo3MG02SDZtUE1CMlNEVDUwUXJQZTdM?=
 =?utf-8?B?S0kvSlJLTi9GRlpSMmJWQjc5K3pxZHhvLzVNN3pNNnpKSkloeEFFY0FkMVUx?=
 =?utf-8?B?M21xY2F3dTQwb2FWQmtOYVgxL0FDRytZbTZVZG1kcXViUEFsYzJkOXBQZGRP?=
 =?utf-8?Q?ynQdPVM1W/lU0iW2sywhLUQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F51123F34DC04D4481220EDCC93D81BD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc5741f-e3da-4187-8ed6-08dc29aff807
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 20:44:53.6707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cv88Va8FxTdyJ2iNA+B3jgAifBZfwtk2/TsmixPIHspGZEZw+gRwFVFCLQ/Kjkhvqb6Cy4Bv+U2gAlySVujhuVqrsCDdYHGR7qs3eWtp+sM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5991
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAxLTI0IGF0IDIyOjIxIC0wODAwLCBkZWJ1Z0ByaXZvc2luYy5jb20gd3Jv
dGU6DQo+IEZyb206IERlZXBhayBHdXB0YSA8ZGVidWdAcml2b3NpbmMuY29tPg0KPiANCj4gQXMg
ZGlzY3Vzc2VkIGV4dGVuc2l2ZWx5IGluIHRoZSBjaGFuZ2Vsb2cgZm9yIHRoZSBhZGRpdGlvbiBv
ZiB0aGlzDQo+IHN5c2NhbGwgb24geDg2ICgieDg2L3Noc3RrOiBJbnRyb2R1Y2UgbWFwX3NoYWRv
d19zdGFjayBzeXNjYWxsIikgdGhlDQo+IGV4aXN0aW5nIG1tYXAoKSBhbmQgbWFkdmlzZSgpIHN5
c2NhbGxzIGRvIG5vdCBtYXAgZW50aXJlbHkgd2VsbCBvbnRvDQo+IHRoZQ0KPiBzZWN1cml0eSBy
ZXF1aXJlbWVudHMgZm9yIGd1YXJkZWQgY29udHJvbCBzdGFja3Mgc2luY2UgdGhleSBsZWFkIHRv
DQo+IHdpbmRvd3Mgd2hlcmUgbWVtb3J5IGlzIGFsbG9jYXRlZCBidXQgbm90IHlldCBwcm90ZWN0
ZWQgb3Igc3RhY2tzDQo+IHdoaWNoDQo+IGFyZSBub3QgcHJvcGVybHkgYW5kIHNhZmVseSBpbml0
aWFsaXNlZC4gSW5zdGVhZCBhIG5ldyBzeXNjYWxsDQo+IG1hcF9zaGFkb3dfc3RhY2soKSBoYXMg
YmVlbiBkZWZpbmVkIHdoaWNoIGFsbG9jYXRlcyBhbmQgaW5pdGlhbGlzZXMgYQ0KPiBzaGFkb3cg
c3RhY2sgcGFnZS4NCj4gDQo+IFRoaXMgcGF0Y2ggaW1wbGVtZW50cyB0aGlzIHN5c2NhbGwgZm9y
IHJpc2N2LiByaXNjdiBkb2Vzbid0IHJlcXVpcmUNCj4gdG9rZW4NCj4gdG8gYmUgc2V0dXAgYnkg
a2VybmVsIGJlY2F1c2UgdXNlciBtb2RlIGNhbiBkbyB0aGF0IGJ5IGl0c2VsZi4NCj4gSG93ZXZl
ciB0bw0KPiBwcm92aWRlIGNvbXBhdGlibGl0eSBhbmQgcG9ydGFiaWxpdHkgd2l0aCBvdGhlciBh
cmNoaXRlY3R1ZXMsIHVzZXINCj4gbW9kZSBjYW4NCj4gc3BlY2lmeSB0b2tlbiBzZXQgZmxhZy4N
Cg0KQSBsb3Qgb2YgdGhpcyBjb2RlIGxvb2sgdmVyeSBmYW1pbGlhci4gV2UnbGwgaGF2ZSB0byB0
aGluayBhYm91dCBhdA0Kd2hhdCBwb2ludCB3ZSBjb3VsZCBwdWxsIHNvbWUgb2YgaXQgaW50byB0
aGUgY29kZSBrZXJuZWwuDQoNCkkgdGhpbmsgaWYgd2UgaGFkIGFuIGFyY2ggd3JpdGVfdXNlcl9z
aHN0aygpLCBtb3N0IG9mIHRoZSBjb2RlIGNvdWxkIGJlDQpzaGFyZWQgaGVyZS4NCg==

