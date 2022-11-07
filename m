Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A756200C1
	for <lists+linux-arch@lfdr.de>; Mon,  7 Nov 2022 22:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbiKGVOi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Nov 2022 16:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiKGVOM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Nov 2022 16:14:12 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CAA3E09E;
        Mon,  7 Nov 2022 13:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667855469; x=1699391469;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RrLKjFklh3bs2oJYf9s2kGox9Vi73MAjdCJB1I41lhI=;
  b=caHjroBxmo49gYUZO0qTe7NlATANZXVW7AQKg3+3MD+5MkDLpbBxW8xK
   D0Vr7uv6F6JbR24V9E618o7Au9YixlxNPSS4HY6w+NmtKf/2iisFrsrc+
   FUueFfGu/QzJ84Ll1LswZPSC6AQFMa6Jcg+8+GytaYv5OBlpbErVruOij
   nsOX0A8fmlnb6zeishWjNf5IO8WbhQc1uLzzu7+3u/rx9sExSWeMt8f2g
   EiLKxUhearH/7P26mLr2ir5LbixATYf6sTVZn7kIvVbltkdULOus1SFfm
   QRf/8Y3TQWvf7WvULA4vv4PSdjvxj1l1gRskoMhFaYM4Rf69+SX0oxuN4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="309234901"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="309234901"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 13:11:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="699642609"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="699642609"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 07 Nov 2022 13:11:06 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 13:11:06 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 13:11:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 7 Nov 2022 13:11:05 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 7 Nov 2022 13:11:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwXLasdj0+JqqyiOMLWX0WL5DfNM6Ey9bEF9U9gR4JdVvnOV6afD637jGeTyuBMQFwJBMgwOHZ37Pp8Xp/5Eq6VdYeUW3mv8gHrTogvKmZG+0BisaFlLaL9bn7A0G1d9Kyu+RxK3h3pBpWLqTI+pAhS3yyMGoH1afzLJTJkvZxa9BB29lmznLHkbOQC3oLGnPefo/BQJ95qdamB2aDryUO7j47MXgYILHdRmMgJ8xMsEZJIc4VltUoZUyJBg8D8ummSKzMCpGQjWu62RdVD0uKZz3aCYof7f383IHqUOgFt3H5163u1zHyB/WvNZtc2HnQZa9XPAt/AHWu2Ss+4AZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrLKjFklh3bs2oJYf9s2kGox9Vi73MAjdCJB1I41lhI=;
 b=Bp6ePuuem+RePu3WyRBy/iXlCN9kR1yZVSWENS6JS/iBpj6CsR1IEjwNjJJ5d70gMCnw+33YMfnBHoJcFvqpMZkFfjj/elDmnZ77ak/YDSCYu6KkE0X5ubFt+NAcWT7TZxBDZbnkW5eGk4/OrY7M257fIWjoTyTeeC0/UhJKwmtN/6LGkGeeJaXZTZymA3zx+/E6ljVdZEaMrIDOFVnUZqvVb7wEm4RvyX4M6Bny6RD+N42L0q/ubyIoy1NikQ2bm8CzcTRygMUlahABRn36be5vKzGuLQRhZfY3A4PCDpot3hWsX8VtTRlhFjpefDzrCXp6c4SNMfdGvCnT0PlI/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN0PR11MB6034.namprd11.prod.outlook.com (2603:10b6:208:375::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 21:10:53 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5791.027; Mon, 7 Nov 2022
 21:10:53 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hjl.tools@gmail.com" <hjl.tools@gmail.com>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
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
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [RFC 37/37] fs/binfmt_elf: Block old shstk elf bit
Thread-Topic: [RFC 37/37] fs/binfmt_elf: Block old shstk elf bit
Thread-Index: AQHY8J5g32apAoMYh0aArgmkU40OVa4vYA0AgAJEZxCAAgw+gIAAAcpVgAALa4CAABn9AIAAIbOA
Date:   Mon, 7 Nov 2022 21:10:52 +0000
Message-ID: <73b8f726c424db1af1c10a48e101bf74703a186a.camel@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-38-rick.p.edgecombe@intel.com>
         <CAMe9rOpfSccXVWmgK6E0Y0DXC=VX3PpdxXookN1Ty8soeAxrKw@mail.gmail.com>
         <87iljs4ecp.fsf@oldenburg.str.redhat.com>
         <ca106fe1b5005f54525e7a644684108f6a823e14.camel@intel.com>
         <87h6zaiu05.fsf@oldenburg.str.redhat.com>
         <f60f1138813f850d52dd92bc6b3df067c021a197.camel@intel.com>
         <CAMe9rOpVUwCccRb5DAyraEKO48rix+Xfiamfp_Vc_aHhjp7=LQ@mail.gmail.com>
In-Reply-To: <CAMe9rOpVUwCccRb5DAyraEKO48rix+Xfiamfp_Vc_aHhjp7=LQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MN0PR11MB6034:EE_
x-ms-office365-filtering-correlation-id: 8a4bd92c-9da2-4070-2879-08dac1048def
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: owRwn4juPU+tl7TE9mTa2dbtN75LC0Mcvuu0OnjFoghQ5Z5zRzM+jIt+PxoejOPLE5tnwow09QBS3Ji/w4quArNy0VTJ78+RT0eT12KJxU1ILPedTTx7BLB1YloppPL5b1HVfwgTgudiGZHd0vHlJDyr/Q0OGjhlE40CLVD9+h9WOV7nkAmGGu0vJ3Z7sn4FOq9tjhfVVUNIP7/hj6CsK2aLJHmBvK/n7arx84ubVD1FtiKH3RDWNskMUsI3UkgIcweJPC2QRyGSTHNOZYSdRyoCqSxbTLwgFznNxL8HYj+8bgaP6S7PeZtXb2TbFxY24auXdjwjydDqGED5TvKrl4/vbsaiouWbLczdUOwpEtoOaXDXiptV2E16li8cX0d9FE0WHYfJYWVyw6sTaM9UORnjOH93Wji4sDCK8xj/nQogrdFHSOwZ+wOIOTf98aJQuKBfhXs7TccUzNw4Vxy8hW6RSf8F9uS+Vy4IRS3QfoJy2D5J2i5NbQI63MucA1Z7w7Kr736+/uZFs0EOyKEMTH2Ic2rKyJoxik9J5g7fiBZRej5DYzv8ZZEAf22K4sLl5sJIN9EloqtQADl1cc1/8HRgpteuow4h97CFDdc1JmmlyilNl+1Aw1wfOH6KFrq0Z/3WQzpzsiKHGhDS1gwyQaXrAjNusro1a6ND801nt5qTZjq06w3OWNCLKLZPGiZsgHeG6ABtXIEjDBa/nUB4X06tyfVy1R/PDh/1ZiAdScX40WKsYK9PMLuPuVIUAHhfa+DTIrgavInBflwnGZoyfkSmii37RXFZTxM4Bq/5z5k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199015)(186003)(6512007)(38070700005)(53546011)(83380400001)(2616005)(71200400001)(6506007)(26005)(66899015)(82960400001)(38100700002)(122000001)(36756003)(2906002)(8676002)(7416002)(8936002)(41300700001)(5660300002)(54906003)(6486002)(316002)(6916009)(86362001)(66946007)(4326008)(76116006)(66446008)(7406005)(66476007)(64756008)(66556008)(478600001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THlvU0lDc0I2MDlxcVQ3WGQwSjJaUmZrZWxPY1ExcEN0a0NJOU81NncvTTVa?=
 =?utf-8?B?YkpHRFJNOEFhZjU0ZXVsRE9NamRPQ2FaaEJxdVdxdlYvVVhuQnVCYjM2NTJT?=
 =?utf-8?B?UmovSUFFYk96aUsraW1Id0NjeU5OT0RiWlhkN09kZjlHL0JYdld1Q25mdmdt?=
 =?utf-8?B?aFhpamdDUEU3OEcrRlp2cCtMZDU5OERYeVp5dmgzL1R1RVljd2lOaWdnK3Bs?=
 =?utf-8?B?Y3o0L0dINDU2a01waWZ0WkVyUlFlRG1jRnNWemtIc1V3cGJ1ZnJDYkNHQ2Ir?=
 =?utf-8?B?Y1QwNlpibXM4bnNTTWd6L3hRNWIxWDkvOGZIYTNnTE16Ry8rNTRVeVQ3Tjdm?=
 =?utf-8?B?dHdidDVjSmZ1QlBkT3hPR1V3ZTRyNUJnUHdhQ3pvTzg5Ui95TEw1dWRjZGdk?=
 =?utf-8?B?bGdEbDVSYStpVk11Q29qR3FtcE4wV2Y1d08za0I5UXFIUUVESUdpRnhwdDh2?=
 =?utf-8?B?dElERE1mVlhDZHd6c3N2cTdjT2N1R002cTRaTXZ0djArRmNZVXpRcUFHZXdk?=
 =?utf-8?B?WjhpRlppcmRycS9yL3k4ZG1xTUp3STFlYlNZY0xsWGtVdUVEVzBkc1Q0N3JN?=
 =?utf-8?B?K2tHVWdFd2JadXZzZ3EySHpQbFlHOVo3Tld6cHZyd3dtVDdEOW1sTTRPd0Y3?=
 =?utf-8?B?TUlVZXUrdzQ5OEZLQTF1VGczQUxFb0wwSEFMOXJ3SS9MdjExVnlJUzh1eStB?=
 =?utf-8?B?MTk3dW9zOUVtbmtwOWRBVldkRURNb0YxdUxtTHJtSmorR09KZGx2SlNvNmlO?=
 =?utf-8?B?M2NkR3UxZGVsanZyNm1PUDFrQjU0R1pQZzZrUDIreWlWUEs5S1NOUDhibzhM?=
 =?utf-8?B?RXdaN2lGWnU5bW5DUE9CKytEbzNZQXdmMWhjM1cxTDdRWnlTTEJVMnBUaStz?=
 =?utf-8?B?TU1MdTBObzlxOVFrbXZUN0IxWWlWU3hBUHhhbDZURFlTSER1STcrTVFlNFhj?=
 =?utf-8?B?RzIxTFEvcWpmQnZCWGJYbmJadGM0OW5GaFlaMW54cklmNGRhQnRhS1RnaUNZ?=
 =?utf-8?B?Q2hsNWg3OURTWFV2bjJNNlFxZ2p3VXR3WnZFSWJCUG9EaTdTMUU5STZlSzdt?=
 =?utf-8?B?bnZxL0lIS1NIdXJIMFFvVFhHRGZ5Rzl1aE45YW9YSkFnOVFLeWVibEU2TUky?=
 =?utf-8?B?SmhwMjdtMnFKbVoza0J0VGdNWC8yNHlrbTBRN3ROclRRTDJ0RFRZY25vYUFH?=
 =?utf-8?B?cVJ3VVBlU214WHFuZTR5dmRnNjZjcVFaWWZwMnRvVGYyTWc1QXhvaSs2Nmd3?=
 =?utf-8?B?Z1JkaHRlSHhDNFVmMkF4WkdaNFIwNlB0MEczNHpCSVJxd09yRlh2UEF0VXR1?=
 =?utf-8?B?SVBrWS9CTTFNRnNJL2p1UWcrQlJWaHo2d2Q1YzZaUG1QSmxFUUtKZjh4MlYx?=
 =?utf-8?B?elEweUJIdzBHdUVVNTlWR0d5Sml0Mjd1ZHpGc0RDS1czNC9QU1paUnpISzBi?=
 =?utf-8?B?NksxTGhubFlEWFdhQUZJTjVBOVI0YUpMUXJDdkxNNkt5ZjNRdkQzN3pPSjBV?=
 =?utf-8?B?cDdNK2N6YUpHRmg2V3FWRTlwOGFqQzV0QzlvQ0pNYXlVaTZ5T3dBNkFTVEpY?=
 =?utf-8?B?ZXlkNTBIWktLUDA2Q1Biditxdjd6YmtpU2hJNDhUTkpUZkZPU3RmYUF0OGJm?=
 =?utf-8?B?UWVBdFk4OEdPOXBTM3djL2VXRE5pb04reUIwcVRUNEx4OUhCazZ0T3hxMlNO?=
 =?utf-8?B?KzhmWDdkcHZUUzMxd0hkREUxdm84cVE1RmNKamNXdVBBa1BjMGp5bkhjV0w2?=
 =?utf-8?B?QkR5NGU2YnJIZ2tINnFwNHlQbnB3TmJuRElKeWozYjFEdldRZzVPcjAzNlBN?=
 =?utf-8?B?dmh5V2JmQTVrSERqNTZPb0pOdUtHMEJsN2VNN0wwektCenE2bU1GbXRqQU53?=
 =?utf-8?B?RmhPOTBXTlI3d2FqcW16L0R2a0pKR1dsSkJDSlh0ZDlXL2ZrMUFzcHVPNGZ4?=
 =?utf-8?B?eW9oVnJDT2JDV0hkNDVTWmZ3K0xsY0RITTh5TGQyNVpmRnR0YkJxcHcwOGR3?=
 =?utf-8?B?cEhhRkJCZWRaR3pBdjlTdGFFSUZrK1pzd3RrWjdMM2llaWdoczJnT2dwY3Z0?=
 =?utf-8?B?Skc1UVZ2TXZCc3FaNVl3M2xXY1FIellRVGpuRjZzbjdWbEdVd3FDT0xGekVG?=
 =?utf-8?B?UjZ1aDhyK2twd205YTB4aUxPbHl1OWNYU3hDQTM0eHdoLy9rMGFRQTNkY2Rj?=
 =?utf-8?Q?IxwAxDAk6FQXwzqE7622+l4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B711965D5DEA0543ABAF9A9826205C5E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4bd92c-9da2-4070-2879-08dac1048def
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 21:10:53.1168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: om43uZzDJuwftS90T6WWyPChBsO3+QeW0nVkmEfr2iJuZqrvt56b4S4fRL55smbRIFHU2mnSHOqrXpFswXyKdSGhxH6FOXvMdP6KpaRCin0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6034
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTExLTA3IGF0IDExOjEwIC0wODAwLCBILkouIEx1IHdyb3RlOg0KPiBPbiBN
b24sIE5vdiA3LCAyMDIyIGF0IDk6NDcgQU0gRWRnZWNvbWJlLCBSaWNrIFANCj4gPHJpY2sucC5l
ZGdlY29tYmVAaW50ZWwuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBNb24sIDIwMjItMTEtMDcg
YXQgMTc6NTUgKzAxMDAsIEZsb3JpYW4gV2VpbWVyIHdyb3RlOg0KPiA+ID4gKiBSaWNrIFAuIEVk
Z2Vjb21iZToNCj4gPiA+IA0KPiA+ID4gPiBPbiBTdW4sIDIwMjItMTEtMDYgYXQgMTA6MzMgKzAx
MDAsIEZsb3JpYW4gV2VpbWVyIHdyb3RlOg0KPiA+ID4gPiA+ICogSC4gSi4gTHU6DQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gPiBUaGlzIGNoYW5nZSBkb2Vzbid0IG1ha2UgYSBiaW5hcnkgQ0VUIGNv
bXBhdGlibGUuICBJdCBqdXN0DQo+ID4gPiA+ID4gPiByZXF1aXJlcw0KPiA+ID4gPiA+ID4gdGhh
dCB0aGUgdG9vbGNoYWluIG11c3QgYmUgdXBkYXRlZCBhbmQgYWxsIGJpbmFyaWVzIGhhdmUgdG8N
Cj4gPiA+ID4gPiA+IGJlDQo+ID4gPiA+ID4gPiByZWNvbXBpbGVkIHdpdGggdGhlIG5ldyB0b29s
Y2hhaW4gdG8gZW5hYmxlIENFVC4gIEl0DQo+ID4gPiA+ID4gPiBkb2Vzbid0DQo+ID4gPiA+ID4g
PiBzb2x2ZQ0KPiA+ID4gPiA+ID4gYW55DQo+ID4gPiA+ID4gPiBpc3N1ZSB3aGljaCBjYW4ndCBi
ZSBzb2x2ZWQgYnkgbm90IHVwZGF0aW5nIGdsaWJjLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFJp
Z2h0LCBhbmQgaXQgZG9lc24ndCBldmVuIGFkZHJlc3MgdGhlIGxpYnJhcnkgY2FzZSAodGhlDQo+
ID4gPiA+ID4ga2VybmVsDQo+ID4gPiA+ID4gd291bGQNCj4gPiA+ID4gPiBoYXZlIHRvIGhvb2sg
aW50byBtbWFwIGZvciB0aGF0KS4gIFRoZSBrZXJuZWwgc2hvdWxkbid0IGRvDQo+ID4gPiA+ID4g
dGhpcy4NCj4gPiA+ID4gDQo+ID4gPiA+IFNoYWRvdyBzdGFjayBzaG91bGRuJ3QgZW5hYmxlIGFz
IGEgcmVzdWx0IG9mIGxvYWRpbmcgYSBsaWJyYXJ5LA0KPiA+ID4gPiBpZg0KPiA+ID4gPiB0aGF0
J3Mgd2hhdCB5b3UgbWVhbi4NCj4gPiA+IA0KPiA+ID4gSXQncyB0aGUgb3Bwb3NpdGXigJRsb2Fk
aW5nIGluY29tcGF0aWJsZSBsaWJyYXJpZXMgbmVlZHMgdG8gZGlzYWJsZQ0KPiA+ID4gc2hhZG93
DQo+ID4gPiBzdGFjayAob3IgaWRlYWxseSwgbm90IGVuYWJsZSBpdCBpbiB0aGUgZmlyc3QgcGxh
Y2UpLg0KPiA+IA0KPiA+IFRoZSBnbGliYyBjaGFuZ2VzIEkgaGF2ZSBiZWVuIHVzaW5nIHdvdWxk
IG5vdCBoYXZlIGVuYWJsZWQgc2hhZG93DQo+ID4gc3RhY2sNCj4gPiBpbiB0aGUgZmlyc3QgcGxh
Y2UgdW5sZXNzIHRoZSBleGVjaW5nIGJpbmFyeSBoYXMgdGhlIGVsZiBiaXQuIFNvDQo+ID4gdGhl
DQo+ID4gYmluYXJ5IHdvdWxkIHJ1biBhcyBpZiBzaGFkb3cgc3RhY2sgd2FzIG5vdCBlbmFibGVk
IGluIHRoZSBrZXJuZWwNCj4gPiBhbmQNCj4gPiB0aGVyZSBzaG91bGQgYmUgbm90aGluZyB0byBk
aXNhYmxlIHdoZW4gYW4gaW5jb21wYXRpYmxlIGJpbmFyeSBpcw0KPiA+IGxvYWRlZC4gR2xpYmMg
d2lsbCBoYXZlIHRvIGRldGVjdCB0aGlzIGFuZCBhY3QgYWNjb3JkaW5nbHkgYmVjYXVzZQ0KPiA+
IG5vdA0KPiA+IGFsbCBrZXJuZWxzIHdpbGwgaGF2ZSBzaGFkb3cgc3RhY2sgY29uZmlndXJlZC4N
Cj4gPiANCj4gPiA+ICAgVGVjaG5pY2FsbHksIEkNCj4gPiA+IHRoaW5rIG1vc3QgaW5jb21wYXRp
YmxlIGNvZGUgcmVzaWRlcyBpbiBsaWJyYXJpZXMsIHNvIHRoaXMga2VybmVsDQo+ID4gPiBjaGFu
Z2UNCj4gPiA+IGFjaGlldmVzIG5vdGhpbmcgYmVzaWRlcyBwdW5pc2hpbmcgZWFybHkgaW1wbGVt
ZW50YXRpb25zIG9mIHRoZQ0KPiA+ID4gcHVibGlzaGVkLWFzLWZpbmFsaXplZCB4ODYtNjQgQUJJ
Lg0KPiA+IA0KPiA+IEl0J3MgdW5kZXIgdGhlIGFzc3VtcHRpb24gdGhhdCBub3QgYnJlYWtpbmcg
dGhpbmdzIGlzIG1vcmUNCj4gPiBpbXBvcnRhbnQNCj4gPiB0aGFuIGhhdmluZyBzaGFkb3cgc3Rh
Y2sgZW5hYmxlZC4gU28gaXQgaXMgbm90IGludGVuZGVkIGFzIGENCj4gPiBwdW5pc2htZW50DQo+
ID4gZm9yIHVzZXJzIGF0IGFsbCwgcmF0aGVyIHRoZSBvcHBvc2l0ZS4NCj4gPiANCj4gPiBJJ20g
bm90IHN1cmUgaG93IG11Y2ggdGhlIHNwZWMgbWFuZGF0ZXMgdGhpbmdzIGJ5IHRoZSBsZXR0ZXIg
b2YgaXQsDQo+ID4gYnV0DQo+ID4gaW4gYW55IGNhc2UgdGhpbmdzIGhhdmUgZ29uZSB3cm9uZyBp
biB0aGUgcmVhbCB3b3JsZC4gSSBhbSB2ZXJ5DQo+ID4gb3BlbiB0bw0KPiA+IGRpc2N1c3Npb24g
aGVyZS4gSSBvbmx5IHdlbnQgdGhpcyB3YXkgYXMgYSBsYXN0IHJlc29ydCBiZWNhdXNlIEkNCj4g
PiBkaWRuJ3QNCj4gPiBoZWFyIGJhY2sgb24gdGhlIGxhc3QgdGhyZWFkLg0KPiANCj4gU29tZSBh
cHBsaWNhdGlvbnMgYW5kIGxpYnJhcmllcyBhcmUgY29tcGlsZWQgd2l0aCAtZmNmLXByb3RlY3Rp
b24sDQo+IGJ1dA0KPiB0aGV5IG1hbmlwdWxhdGUgdGhlIHN0YWNrIGluIHN1Y2ggYSB3YXkgdGhh
dCB0aGV5IGFyZW4ndCBjb21wYXRpYmxlDQo+IHdpdGggdGhlIHNoYWRvdyBzdGFjay4gICBIb3dl
dmVyLCBpZiB0aGUgYnVpbGQvdGVzdCBzZXR1cCBkb2Vzbid0DQo+IHN1cHBvcnQNCj4gc2hhZG93
IHN0YWNrLCBpdCBpcyBpbXBvc3NpYmxlIHRvIHZhbGlkYXRlLg0KPiANCg0KV2hlbiB3ZSBoYXZl
IGV2ZXJ5dGhpbmcgaW4gcGxhY2UsIHRoZSBwcm9ibGVtcyB3b3VsZCBiZSBtdWNoIG1vcmUNCm9i
dmlvdXMgd2hlbiBkaXN0cm9zIHN0YXJ0ZWQgdHVybmluZyBpdCBvbi4gQnV0IHdlIGNhbid0IHR1
cm4gaXQgb24gYXMNCnBsYW5uZWQgd2l0aG91dCBicmVha2luZyB0aGluZ3MgZm9yIGV4aXN0aW5n
IGJpbmFyaWVzLiBXZSBjYW4gaGF2ZSBib3RoDQpieToNCjEuIENob29zaW5nIGEgbmV3IGJpdCwg
YWRkaW5nIGl0IHRvIHRoZSB0b29scywgYW5kIG5ldmVyIHN1cHBvcnRpbmcgdGhlDQpvbGQgYml0
IGluIGdsaWJjLg0KMi4gUHJvdmlkaW5nIHRoZSBvcHRpb24gdG8gaGF2ZSB0aGUga2VybmVsIGJs
b2NrIHRoZSBvbGQgYml0LCBzbw0KdXBncmFkZWQgdXNlcnMgY2FuIGRlY2lkZSB3aGF0IGV4cGVy
aWVuY2UgdGhleSB3b3VsZCBsaWtlLiBUaGVuIGRpc3Ryb3MNCmNhbiBmaW5kIHRoZSBwcm9ibGVt
cyBhbmQgYWRqdXN0IHRoZWlyIHBhY2thZ2VzLiBJJ20gc3RhcnRpbmcgdG8gdGhpbmsNCmEgZGVm
YXVsdCBvZmYgc3lzY3RsIHRvZ2dsZSBtaWdodCBiZSBiZXR0ZXIgdGhhbiBhIEtjb25maWcuDQoz
LiBBbnkgb3RoZXIgaWRlYXM/DQo=
