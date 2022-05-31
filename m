Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12641539580
	for <lists+linux-arch@lfdr.de>; Tue, 31 May 2022 19:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346586AbiEaRfY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 May 2022 13:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346590AbiEaRfT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 May 2022 13:35:19 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C8598080;
        Tue, 31 May 2022 10:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654018513; x=1685554513;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kKoq9nX8oBqi3LGYAnSl3mP1RYwXz5yonr5kOkcR4uo=;
  b=KNP/M2pzATYbQMRix02MBjU8FG9IzwQ7SVZIxTE6Ho/Re71TNqsdqtvM
   r9bTMuDM76VJL9V909X70nc5j+4qadEIFHSvfQenTeWgxpiEyFe3um4Yt
   R7bP4maOqNlvsiCBQ9AL80zmdVthl/irtczyWmXKpZ/EMLbB/z9aneNyQ
   dOV05aUG396ScJPFrFKI6jrfASLZMWva6HLGyQrkvLNZp0EfWt/Yjnc0M
   zFyVI4xDr2JmUrGkxNG2zeQxcCBlCtQ3iBI1Yb/iW4CYSTmVxhWUsomjr
   Wr8mezVsXFMx2FfyUQmrCdCS8iBSmROifUqMc8ncGaohA8GZXXtwNXUna
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="272901069"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="272901069"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 10:34:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="667023622"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 31 May 2022 10:34:53 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 31 May 2022 10:34:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 31 May 2022 10:34:53 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 31 May 2022 10:34:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQ4CKBM8qyUdHtMyBm1cO1gXtGfqleoNPesiI+au0cpdWB8yYkCJ3W26U+x7UPTUF6RfTCKibAzzExqD0h1tOKI5AZEW6zCpQ/ow+9wua8iw9jxlJg+jcqtdTpDF951FKllfW0nadYmPISxHQus0dLpGTk1NktgXYsNHuQU0E5gqxJnJEO5abtSHGVBVZkIDIYXg4bnlgGzCUYd0wLCqlYI/6aU5WlO/gUHY8mRaDnNrlSs6hZdwj967qwRs2Eh90Cx6YvMRr1HFDcqvG5//0Urs/A8fUxI4FaW5TTAkZpW1pr+hVoQmHqu81HrBMtWjIOM9ZVG87xa4syqggKkDEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKoq9nX8oBqi3LGYAnSl3mP1RYwXz5yonr5kOkcR4uo=;
 b=SsZU3A786uFS3H091KZCutJFGd3uTzYtmbJ6ttVeRCTnuzFCK1lT1Dzi+LHjh2NEsadCKLnVJ5zwKZ81G/GeC+1pOB11NZTCyuh8THDLPA9AzTzl5+51t88ROI0JFmb7rHubc/fwaUiAvC62LeCoIYt/VW4uVR/MXnOUH3Y7MYZb++HO0QW7kAiWrqykeatL/eVkl+wapl1A9mZutXnMo2HnlRp9f0i+YNsVaAH7LAUiksXxlM8GV4YxcrS0226cyMWElozw/LaQ1KAeDtkxIwCH7SEAf2/QNBM4rG8aJNNnbpT8WUUgVgTPNe+mTIFf5oi0v6eDCyV6LuVsmRAu8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM6PR11MB4562.namprd11.prod.outlook.com (2603:10b6:5:2a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 31 May
 2022 17:34:51 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03%12]) with mapi id 15.20.5293.019; Tue, 31 May
 2022 17:34:51 +0000
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
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
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
Thread-Index: AQHYFh9orVaVUe6rNECZu4edjJzhZqyG5jiAgADTxwCAAJnkAIABGRSAgAADewCAAHMeAIAAC4MAgACbY4CAAZeygIAddLsAgAAA+YCAABC1gIAAF8EAgASAo4CAADfAgIAAKfMAgAEo6oCABLJcAIAAAt+AgIUewYCAAEo0AIAAAygAgAAQTAA=
Date:   Tue, 31 May 2022 17:34:50 +0000
Message-ID: <7c637f729e14f03d0df744568800fc986542e33d.camel@intel.com>
References: <Yh0+9cFyAfnsXqxI@kernel.org>
         <05df964f-552e-402e-981c-a8bea11c555c@www.fastmail.com>
         <YiEZyTT/UBFZd6Am@kernel.org>
         <CALCETrWacW8SC2tpPxQSaLtxsOXfXHueyuwLcXpNF4aG-0ZvhA@mail.gmail.com>
         <fb7d6e4da58ae77be2c6321ee3f3487485b2886c.camel@intel.com>
         <40a3500c-835a-60b0-15bf-40c6622ad013@kernel.org>
         <YiZVbPwlgSFnhadv@kernel.org>
         <CAMe9rOrSLPKdL2gL=yx84zrs-u6ch1AVvjk3oqUe3thR5ZD=dQ@mail.gmail.com>
         <YpYDKVjMEYVlV6Ya@kernel.org>
         <d0c94eed6e3c7f35b78bab3f00aadebd960ee0d8.camel@intel.com>
         <YpZEDjxSPxUfMxDZ@kernel.org>
In-Reply-To: <YpZEDjxSPxUfMxDZ@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86b8ea55-a4e4-4bd8-e6fc-08da432bddd5
x-ms-traffictypediagnostic: DM6PR11MB4562:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB4562D39A246789A4D3E2264DC9DC9@DM6PR11MB4562.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OuJM7N5W+Y2vAmyBCh1ApIInUox7q2tzOKbRcI44yR59FlTt03R1LOOg6C3mAVU4rQBfjS845GJgKtQKwLHEf210v68m10q391CB9aXMZ1LXmYkhwZB3fbfG3nGCnAH3+15aZLyi5Fbgn6r+7fomnUcz5HPDNSYk2VJ+cOuS9wzPBLj+eg4O5u+C79Mm9YYP3itTM+bCsC1OOHzSYvb+hxqc/+WSiwHGJfKMs6fbZiGDc1fySzye44VnyFg9B3zTzgJrs0VAdm6B5FLiizcqzjMe3AhyGTK0tIuE1Sta14AxY0617lajUv6og3ZDea0Q94IEOdc30AxOjuuEQbE3WByvyWY6Ciygb1yRtA0XsCyeSc7nI92BoWJAb9WTP5/C3TpYsamK4yN+RT4o7hRuoFWTLTrM9p7RjlohCuWpOVFVtaolGNiXqsL0V7dp5DcDC8z9mnqj5DfJnsWWSjcIq1Yoyh5qU6AQn0y8bhyqk1U6ac0EBt5nt0SDrYCn9YffgEthBEn6OjUG+xhIX5xJKpsQU4jHuVdo+9fhGdx5omgXg/esthuYgUdJBHd0gXg3YCJ0yZWVNOATVJBqNOxw1FIzqXEWcCeh49zHaDKzWTLndTej2WirgklC874ZBX6pB36E9VVs0cg9esq3BbCIU3BlOYASa7OD1DX1KmPc956tZk8fZwtr1zrstf/b4hro/iXCGVG+zc4G6uNaC60/lHspAkvj+dzJzo5Z8ZIY7IA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(6512007)(26005)(36756003)(54906003)(2906002)(2616005)(38100700002)(122000001)(316002)(82960400001)(186003)(38070700005)(66946007)(76116006)(64756008)(8676002)(66446008)(66556008)(83380400001)(4326008)(6506007)(7416002)(7406005)(71200400001)(6486002)(66476007)(8936002)(86362001)(5660300002)(508600001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2FnVWlMMklwQ3EwZ3IrNlk2QUNnZFdwTTNOdEpKd0MzSHRFOVhDczQ0bmt3?=
 =?utf-8?B?aFVVNnBqcGhPZXRxVm9uYjM5THdMcHdDbWRFWHQzNTYxK1J1b0hCWDhGbEJJ?=
 =?utf-8?B?SnArWWRkWEMvUnJUVHV0OCtJZDVsejYwZ05LTEw4N2E5aUd1UzBIdFZ6RFl3?=
 =?utf-8?B?d3A3cThQOWFNQ1pzN2ZxMGorRWo2WTllbHE2Y00wNlhjQjhuZXNVRnRsMW81?=
 =?utf-8?B?S1VObGN1VWw5dHQ0aGd3b2dhYmlNL1lVamFwclVNTFNrR0F4RVFYb1hwWDk4?=
 =?utf-8?B?b05TUkFOdWcwNzR6THcwbWZiSkRpR2lnNHBOdnkrVGxvNEs1RDBCdHVLM0xj?=
 =?utf-8?B?MEJ6dnhkSlhHRFVGeW13K3VJRUdJWTJ5NU92SWU5ZDE4N3FyLzVQNklHMFdO?=
 =?utf-8?B?UktSU01DbHA3V0xIWFYyWHFBbkcrd2ZONHozRlFwUGROZkxlWnVNMGdrbk1h?=
 =?utf-8?B?dk8rWnRWRXUyMWpCNEdacENKcm4ydHVFdENySFUwdEdLbUtVcU1uMkJFckIx?=
 =?utf-8?B?d29BakVUMzVGRWNpQVFHZW80NzYzY0FJVjFoQ1Y4Z1lTWWxZK3pzWnR0emJX?=
 =?utf-8?B?eEtPb25vTnNwTDEwdTFYdFgxa1NkTG1OeFBRb05oSkJpNm03U0FmVmNSTWwr?=
 =?utf-8?B?YitNQ3NqTDZldGhXUnA4OUxva2lnS295aUpIeHMzSXI4Tm85cFdmM3BabmFi?=
 =?utf-8?B?dzN2THoyTDdyK2NOQjB1cGJrUEZadVdFdHFHUVEzU0x2MDVJREFLa1hFcThC?=
 =?utf-8?B?Rm13Q2hpNHQ3bStNaXhzd3gvZVNJemtxVUZ3VHo5SXRDQnlieFd2dGx6SmlU?=
 =?utf-8?B?eW11UmdCZU1VeXl0MXIzM0VsZXdLNzRHLzlCWkNoNjVWYlduU0tlZ0tFdHZH?=
 =?utf-8?B?Y1A1ZWZLRW12b21FRHpuUG9aTkNzRDIyaGtMemVKR3VlNjh0elJCajRBL01i?=
 =?utf-8?B?aXdSUEUyWGdmb2R5WmhRbzl2a0VFeUlKK1JBenZxejVoTGFEMEl0K0R4ckFh?=
 =?utf-8?B?S3A3QmNtbDEzUzQ4MnovZUxramZheXNveTNwZjZyeEkraDM5bmtxMVNBTTZ4?=
 =?utf-8?B?cVBSWGp0bGJMY1E3ZWNZRjVhVFZjak9BZi9IVWgzbU9KclA2RlkrVGs0Ukxa?=
 =?utf-8?B?T0Fub3MyT2JoRGJyRjdWVGFFdEsvaHRFK3BQOXBaTWw3VHR1ZVFPSmFYcnI0?=
 =?utf-8?B?aFRuYVZPRFpPajB5cDZkek44WHhHdjhCRVZicEx6WXJuWW4zMkl3RGUrRTZS?=
 =?utf-8?B?Smo3R2ZobnlRZlFqeG5YWVMxNEtobFZFNGlRc3BQV2tDQVNwZGZjZ1o2dGpx?=
 =?utf-8?B?dXhJbVpUdkhvWGpEZjBpZU9pbFhCQ0ZtYmJaUXlxb2FURkhEaDJoRzNvVHNj?=
 =?utf-8?B?T2VVZHVjY0NtY2dSZDhweXdQd0pGM0hTNUZXekZ3RnNJMTZUQ09FL1lONkxP?=
 =?utf-8?B?eU9vTTRCSFUxdmFpTE10L0tXRW1XeGNudUwrWS9FV2toVHZzcVZBbjJINjZn?=
 =?utf-8?B?cmRhUURIamw1YmZNRDVkMTBxN3Zxa2p6SzIxL0lVMlc1QWxNZjBDWWZGdTFy?=
 =?utf-8?B?eHdNRDhWazI2YXlWSldUSUVHcUFwSnBvZGVpT2FqeFNQMHZaL0QyQ29HSkFz?=
 =?utf-8?B?QXpoUzljeFFVOWlTcTVYcTR4bFJ6YXpZV3hnSkFvNjUrc3BsS1ZtVWltU1M5?=
 =?utf-8?B?YjRNQmNXdHFFeDJURk5tMUFkbzRQZ3ZrbnlMOWFGcU5kdU8rTEY3d2l3WFY3?=
 =?utf-8?B?SUY4NnNmQ1AvTGxDdDFDSTEyZ1ozcVBpd3ZBcFJnY0Z6VkRhTExMU2ViU3Rz?=
 =?utf-8?B?eWo5N280WjVrVWlkSE1zSUJwMDZzV1kxR0w2bEZPWU10Y01UeVpBTkZlcVVL?=
 =?utf-8?B?OVV6QTZQanVCSEMweURWQjJoYkNJdG5DM2ZicjdvTmFYbG9HTHRoK2pNK2Ur?=
 =?utf-8?B?elFYQWFtd01uL2hCQmNDUGN5TiswWnVKUHR6eVdsNE5CYjBNMHYydEFiTFZJ?=
 =?utf-8?B?QURVY2ZBUXh6aW5OOTMreU5ZaFlLVUtPQ2tlOFhSSGFhK2pWZng4d1U0MjZS?=
 =?utf-8?B?aHVMdUtjTVlRSHZwd1ovaHlMMjlERkwxeURlNW13VHJrMngzQXpEcTdXYUZG?=
 =?utf-8?B?eFV3akJQSmNTbGtPL0xDdllrYTZRMmlockJQb1hmYTYxVExBS0plU0gzL2Z5?=
 =?utf-8?B?WDdPVnY4UlE3WWU1UkwzcDN4ZjVDcmt2K1BPR05xVmVzNEtsVDlOL2FCazRE?=
 =?utf-8?B?RHVTQXdZRkUrTEdEOTJFZmhsQXRPaXhoUmk3VTFuZ0lXRFNvcjFscms4SW5I?=
 =?utf-8?B?UWI2NUVOMUVERjJmOXo2ZW1BdFNOTmdtdFJCOGN3TTI4L3BrYjFoRDJvZ2k0?=
 =?utf-8?Q?audYwjqZx8wGvpIUCNgbMZztsZl4kG8u0ESNU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F47A15591DC6254BB8161AEA06BFE5AA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b8ea55-a4e4-4bd8-e6fc-08da432bddd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2022 17:34:51.0471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wBhp9mV33qDfL/SJ9vc1MvwmZhyDr4yqdjtGuVoLc11TZgfSjrdhjzjIAyUktJUg09klXRm8QTR1KTKhqaddCPk8FSdnExp+4XnSooObBQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4562
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIyLTA1LTMxIGF0IDE5OjM2ICswMzAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiA+IFdSU1MgaXMgYSBmZWF0dXJlIHdoZXJlIHlvdSB3b3VsZCB1c3VhbGx5IHdhbnQgdG8gbG9j
ayBpdCBhcw0KPiA+IGRpc2FibGVkLA0KPiA+IGJ1dCBXUlNTIGNhbm5vdCBiZSBlbmFibGVkIGlm
IHNoYWRvdyBzdGFjayBpcyBub3QgZW5hYmxlZC4gTG9ja2luZw0KPiA+IHNoYWRvdyBzdGFjayBh
bmQgV1JTUyBvZmYgdG9nZXRoZXIgZG9lc24ndCBoYXZlIGFueSBzZWN1cml0eQ0KPiA+IGJlbmVm
aXRzDQo+ID4gaW4gdGhlb3J5LiBzbyBJJ20gdGhpbmtpbmcgZ2xpYmMgZG9lc24ndCBuZWVkIHRv
IGRvIHRoaXMuIFRoZQ0KPiA+IGtlcm5lbA0KPiA+IGNvdWxkIGV2ZW4gcmVmdXNlIHRvIGxvY2sg
V1JTUyB3aXRob3V0IHNoYWRvdyBzdGFjayBiZWluZyBlbmFibGVkLg0KPiA+IENvdWxkIHdlIGF2
b2lkIHRoZSBleHRyYSBwdHJhY2UgZnVuY3Rpb25hbGl0eSB0aGVuPw0KPiANCj4gV2hhdCBJIHNl
ZSBmb3IgaXMgdGhhdCBhIHByb2dyYW0gY2FuIHN1cHBvcnQgc2hhZG93IHN0YWNrLCBnbGliYw0K
PiBlbmFibGVzDQo+IHNoYWRvdyBzdGFjaywgZG9lcyBub3QgZW5hYmxlIFdSU1MgYW5kIHRoYW4g
Y2FsbHMNCj4gDQo+ICAgICAgICAgYXJjaF9wcmN0bChBUkNIX1g4Nl9GRUFUVVJFX0xPQ0ssDQo+
ICAgICAgICAgICAgICAgICAgICBMSU5VWF9YODZfRkVBVFVSRV9TSFNUSyB8IExJTlVYX1g4Nl9G
RUFUVVJFX1dSU1MpOw0KDQpJIHNlZSB0aGUgbG9naWMgaXMgZ2xpYmMgd2lsbCBsb2NrIFNIU1RL
fElCVCBpZiBlaXRoZXIgaXMgZW5hYmxlZCBpbg0KdGhlIGVsZiBoZWFkZXIuIEkgZ3Vlc3MgdGhh
dCBpcyB3aHkgSSBkaWRuJ3Qgc2VlIHRoZSBsb2NraW5nIGhhcHBlbmluZw0KZm9yIG1lLCBiZWNh
dXNlIG15IG1hbnVhbCBlbmFibGVtZW50IHRlc3QgZG9lc24ndCBoYXZlIGVpdGhlciBzZXQgaW4N
CnRoZSBoZWFkZXIuDQoNCkl0IGNhbid0IHNlZSB3aGVyZSB0aGF0IGdsaWJjIGtub3dzIGFib3V0
IFdSU1MgdGhvdWdoLi4uDQoNClRoZSBnbGliYyBsb2dpYyBzZWVtcyB3cm9uZyB0byBtZSBhbHNv
LCBiZWNhdXNlIHNoYWRvdyBzdGFjayBvciBJQlQNCmNvdWxkIGJlIGZvcmNlLWRpc2FibGVkIHZp
YSBnbGliYyB0dW5hYmxlcy4gSSBkb24ndCBzZWUgd2h5IHRoZSBlbGYNCmhlYWRlciBiaXQgc2hv
dWxkIGV4Y2x1c2l2ZWx5IGNvbnRyb2wgdGhlIGZlYXR1cmUgbG9ja2luZy4gT3Igd2h5IGJvdGgN
CnNob3VsZCBiZSBsb2NrZWQgaWYgb25seSBvbmUgaXMgaW4gdGhlIGhlYWRlci4NCg0KPiANCj4g
c28gdGhhdCBXUlNTIGNhbm5vdCBiZSByZS1lbmFibGVkLg0KPiANCj4gRm9yIHRoZSBwcm9ncmFt
cyB0aGF0IGRvIG5vdCBzdXBwb3J0IHNoYWRvdyBzdGFjaywgYm90aCBTSFNUSyBhbmQNCj4gV1JT
UyBhcmUNCj4gZGlzYWJsZWQsIGJ1dCBzdGlsbCB0aGVyZSBpcyB0aGUgc2FtZSBjYWxsIHRvDQo+
IGFyY2hfcHJjdGwoQVJDSF9YODZfRkVBVFVSRV9MT0NLLCAuLi4pIGFuZCB0aGVuIG5laXRoZXIg
c2hhZG93IHN0YWNrDQo+IG5vcg0KPiBXUlNTIGNhbiBiZSBlbmFibGVkLg0KPiANCj4gTXkgb3Jp
Z2luYWwgcGxhbiB3YXMgdG8gcnVuIENSSVUgd2l0aCBubyBzaGFkb3cgc3RhY2ssIGVuYWJsZSBz
aGFkb3cNCj4gc3RhY2sNCj4gYW5kIFdSU1MgaW4gdGhlIHJlc3RvcmVkIHRhc2tzIHVzaW5nIGFy
Y2hfcHJjdCgpIGFuZCBhZnRlciB0aGUgc2hhZG93DQo+IHN0YWNrDQo+IGNvbnRlbnRzIGlzIHJl
c3RvcmVkIGRpc2FibGUgV1JTUy4NCj4gDQo+IE9idmlvdXNseSwgdGhpcyBkaWRuJ3Qgd29yayB3
aXRoIGdsaWJjIEkgaGF2ZSA6KQ0KDQpXZXJlIHlvdSBkaXNhYmxpbmcgc2hhZG93IHN0YWNrIHZp
YSBnbGliYyB0dW5uYWJsZT8gT3Igd2FzIHRoZSBlbGYNCmhlYWRlciBtYXJrZWQgZm9yIElCVD8g
SWYgaXQgd2FzIGEgcGxhaW4gb2xkIGJpbmFyeSwgdGhlIGNvZGUgbG9va3MgdG8NCm1lIGxpa2Ug
aXQgc2hvdWxkIG5vdCBsb2NrIGFueSBmZWF0dXJlcy4NCg0KPiANCj4gT24gdGhlIGJyaWdodCBz
aWRlLCBoYXZpbmcgYSBwdHJhY2UgY2FsbCB0byB1bmxvY2sgc2hhZG93IHN0YWNrIGFuZA0KPiB3
cnNzDQo+IGFsbG93cyBydW5uaW5nIENSSVUgaXRzZWxmIHdpdGggc2hhZG93IHN0YWNrLg0KPiAg
DQoNClllYSwgaGF2aW5nIHNvbWV0aGluZyB3b3JraW5nIGlzIHJlYWxseSBncmVhdC4gTXkgb25s
eSBoZXNpdGFuY3kgaXMNCnRoYXQsIHBlciBhIGRpc2N1c3Npb24gb24gdGhlIExBTSBwYXRjaHNl
dCwgd2UgYXJlIGdvaW5nIHRvIG1ha2UgdGhpcw0KZW5hYmxpbmcgQVBJIENFVCBvbmx5IChzYW1l
IHNlbWFudGljcyBmb3IgdGhvdWdoKS4gSSBzdXBwb3NlIHRoZQ0KbG9ja2luZyBBUEkgYXJjaF9w
cmN0bCgpIGNvdWxkIHN0aWxsIGJlIHN1cHBvcnQgb3RoZXIgYXJjaCBmZWF0dXJlcywNCmJ1dCBp
dCBtaWdodCBiZSBhIHNlY29uZCBDRVQgb25seSByZWdzZXQuIEl0J3Mgbm90IHRoZSBlbmQgb2Yg
dGhlDQp3b3JsZC4NCg0KSSBndWVzcyB0aGUgb3RoZXIgY29uc2lkZXJhdGlvbiBpcyB0aWVpbmcg
Q1JJVSB0byBnbGliYyBwZWN1bGlhcml0aWVzLg0KTGlrZSBldmVuIGlmIHdlIGZpeCBnbGliYywg
dGhlbiBDUklVIG1heSBub3Qgd29yayB3aXRoIHNvbWUgb3RoZXIgbGliYw0Kb3IgYXBwIHRoYXQg
Zm9yY2UgZGlzYWJsZXMgZm9yIHNvbWUgd2VpcmQgcmVhc29uLiBJcyBpdCBzdXBwb3NlZCB0byBi
ZQ0KbGliYy1hZ25vc3RpYz8NCg0K
