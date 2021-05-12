Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0626F37EA60
	for <lists+linux-arch@lfdr.de>; Thu, 13 May 2021 00:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbhELS6u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 May 2021 14:58:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:32924 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356419AbhELSuD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 May 2021 14:50:03 -0400
IronPort-SDR: 0eTLMKsPUT/OW96HjI8zCOEgTG9MQthHQNYL79bbFO8OwPhU8clyIi4n/L4OYX+n5KYr9cGpWK
 tPpPNLTGRKbA==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="263708627"
X-IronPort-AV: E=Sophos;i="5.82,295,1613462400"; 
   d="scan'208";a="263708627"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 11:48:13 -0700
IronPort-SDR: R632Y29pvIve/bgg5r9kXdDvHgYui44Kn4hqtmtnCRkz/4Fg4CCag40JefoC0bySGsp6av0qw5
 DaG6AGX/ToYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,295,1613462400"; 
   d="scan'208";a="469577150"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga002.fm.intel.com with ESMTP; 12 May 2021 11:48:13 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 12 May 2021 11:48:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 12 May 2021 11:48:13 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 12 May 2021 11:48:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTTg/wXWusu64iMT0B8IHxccSo9wXLNWeXNiNt+4sdDOwSYDOlEc4ZR5e+jdHJQUW+UWa2DxBshmSAkPseFHrgzzzsDRaRfOOJxrpwIqV6iqAJGEJz/5iITt5u33TzI8gGBqczrURNXkWOhVilEs+OeLjVzsSnNVkvGKTXObP4m57sAbYwvLcAuxhxmvzwVfBge1EbwBb/Zm/3HdihsV7xj788854djBMWtN+gEifK/HS7fKJ2BV6mHJ7/KXMuvDHlPpMCt91KryOEt8LZoHUoFIWfGvbdkREtUs0AOjx6XDrQBySmakj5HIUgKYvrfVJ/bTv2FMRTs00uNAPUhLkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLMFmenhJmpc+15eidzMLyw0cGTYKlPfCQlzOVHOYM8=;
 b=bgh2K/yctT2Rk/0f7Bp8t19ZTEHmqVDXzRf+ppUTSkXnzpSZEyZ8FgRqhZjgLCLqkb3Z/OnCkUnX9+mxOBx11jqiCroTtslylmA0PNVcLOqOHiTLpXUmvkjgYRd75D7PrpN6qGhQmyb9PAUY0yYu1Ct+mmwz9viVj/pbtio7NvyPeXySRUb5wD1QccByjsU+ThQqW1Vk6pTrxvDY7lg8UnJyptd2gDa7NsI5QqwdK3xgUYD50WSLBsh5CjYOYNx50Aj+zm+XkNi5Sslp4p0oVAA9jpi1OebFiSoODbn/9xpQWPjst1nMulJC3mIa6/crHZYrWWu/BJ//urul8ti3OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLMFmenhJmpc+15eidzMLyw0cGTYKlPfCQlzOVHOYM8=;
 b=tV6WYvXOSta/sXwseYcOKyYOIVNhtWksAoqXSuPPVYnF28/OS+E1FDU7wFJKo+a+a2pKsIW5RElxs3ipKAc9RJquhoRW0uJBZaQGa3cOstzzAagXq+1lFpA9Xe2nNOjudp2L/0NFNofpuGEASdz8dsFr0UerVXb8yNhgQHwFOIw=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4821.namprd11.prod.outlook.com (2603:10b6:510:34::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Wed, 12 May
 2021 18:48:11 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::8878:2a72:7987:673]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::8878:2a72:7987:673%5]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 18:48:11 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Andy Lutomirski <luto@kernel.org>, "bp@suse.de" <bp@suse.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "jannh@google.com" <jannh@google.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "carlos@redhat.com" <carlos@redhat.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 5/6] x86/signal: Detect and prevent an alternate signal
 stack overflow
Thread-Topic: [PATCH v8 5/6] x86/signal: Detect and prevent an alternate
 signal stack overflow
Thread-Index: AQHXNzOQXxUM6Mub30elxTKCBjQG3areurqAgAGVlAA=
Date:   Wed, 12 May 2021 18:48:11 +0000
Message-ID: <B8EF2379-0AF6-4D00-B6B8-214CA9073BFC@intel.com>
References: <20210422044856.27250-1-chang.seok.bae@intel.com>
 <20210422044856.27250-6-chang.seok.bae@intel.com> <YJrOsbyYhMndI5jd@zn.tnic>
In-Reply-To: <YJrOsbyYhMndI5jd@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3579f252-742c-4aed-692b-08d915767dee
x-ms-traffictypediagnostic: PH0PR11MB4821:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB48212531494185D31DC3530CD8529@PH0PR11MB4821.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GSjCXVFffEnqaWn0UH2gIKHUVz6/3VBfIhdcpEsW61ol0GtBepJd8JtwcSjDAOvM1ByCgmhhU7+cfs9U6yRrccbfiirjSNJdLveUYZk4JYS8qYga2cs2/TyRI4T9JVE+8k5dsfLt6H/vuUswfeLS9Je+8iFgb/Cd9Dc10w5e4QqIgxE++WqHkm9y8mrdO4nESx12CYI1BymyXkiGvccH72Occ1cLpNi2Mqn6+JHr1SELpp2/tRv3UfO8PNW8F6z5yYml4QHKtu+socm9Fc42IObg626XBzyNSencs186KYv2sYSxnXJ7n1snxO9WxiFXjrAtwsWUxselP6nAHLTxG44r/8zNj2ff5xdIH6pvXdXlWoHdUa5m/DtygAhWl38yAhPtnm9q/6E4aKgT1ijDxGCngxOqwKmCT75yOS3aOkEL0f3YGwRaXfv/l6V3XSJxCWhESqk6fZ8lWf3uiQRS45PbSPTRTfxGrnLbDKqfKWNx3SX5iz5hPBaZgfvpTtpO2IQ7E33g93K22+o9zrZ7bfBfJPeGEid+ZCQzA1RTtT6O9fdSRdAaSLRfKgfJh+2lmrTcmFA1wJb+Zqj44Lqa56rCEF6ZqXcq5U6zIxoU/WS97RPBYuUtyZCMp6bLhF1Q4/6uG05e4bjUirVaCCxGR7Y2/sGrAjlVBN24YGkvABA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(39860400002)(376002)(2616005)(36756003)(6486002)(6506007)(478600001)(2906002)(7416002)(86362001)(53546011)(5660300002)(54906003)(316002)(4326008)(76116006)(6916009)(38100700002)(66946007)(186003)(33656002)(122000001)(4744005)(71200400001)(8676002)(66476007)(26005)(64756008)(8936002)(66446008)(66556008)(6512007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?dbtlK5wibfb49uyo2dcfnZt54lfKkWZ9VJlqNAnxLHoEOQmfBJKrso1wZ+hm?=
 =?us-ascii?Q?3il3uw+EdfyUN4dGDlJxn3UYKQmSq7wuyQD/C0Srgm5rzGKlBDJNeoQcLYTj?=
 =?us-ascii?Q?aTXrl0iF+Y8zzyMFP/8d40m2buKya8gOXcz4FtodE5oPoMmVf08czj69dGS2?=
 =?us-ascii?Q?s0/CnZaoIIhgv06Jf1QJUYfxLHakdjbjGCJpskw7uTIyblYozLeIMv0SogoQ?=
 =?us-ascii?Q?iLGn63t/SsfJnVyih0Fe0Z8pWVgang1AXWnyY3v/UOsnS1bG490jb2fk0Yte?=
 =?us-ascii?Q?PSrNvKVMiixZ1o2myqjJ6YXf2OwFZYhYxYkLJRNnDCpoSxyopy/K+LHkd3b0?=
 =?us-ascii?Q?8xyLGQ62JX786H84zu2GSNq2C2XNqANECzTJHY3FwTPELiEF2BzV+zhX6uPs?=
 =?us-ascii?Q?HFRz6xBVA5oyKuTukA0msSByZTtOQ+syiwcrSCjv2iFg6uqiLxkie+r7PxQz?=
 =?us-ascii?Q?mEJaNhpAW2g7rXlgFuDX2NkGGyEppW+JRJPW2YhbursIRsSOVp0qX+XDoEx9?=
 =?us-ascii?Q?5JoUKXZubyYLOSW2mWC2+HIu40SuRKUtNb7clepUGQHQO9G5MbZCdNTWRg2Y?=
 =?us-ascii?Q?8Hiy2uB0scJyLZHAlnNMQByU+p0BiH/zO33z53Sr9AuKtxRnG6z5mx7YLUbz?=
 =?us-ascii?Q?aamfEGF24vOS213QfG0UYhK5zoXoCS9mfFIGWEcIAfsiMVUh+KTbkxPcD4wU?=
 =?us-ascii?Q?ZkcncBPo+h4mbo3RxuM6V70dyplC0P6Di3TOXZIv6eyZhGiWiocALLmltaX8?=
 =?us-ascii?Q?8UrfrZlTFwO2skgtZBQrOCqRoITAK06wBka/6+fw8LpUHE4gD6cpE5pctLsv?=
 =?us-ascii?Q?txla+5RdSaK33HhC3aWJ1y9+q4hmYovPlSkgBdYHYAMmHgHq9K0ftg1FoP7J?=
 =?us-ascii?Q?TkQDhqUJ2r+sVOsy67tJiAYY6ssLsOu++7r361UsoxDGJ2U1pi7csdDMSqyb?=
 =?us-ascii?Q?jtHwKcqg7CJKXCX8oFlsxMBG52UIWM5chyHUp32FASNTzFfmnZ8sDMNgbx6L?=
 =?us-ascii?Q?G5h8FTJQbr3LcMU9PhjZkj98QBURENmLpeXwq994ZcyggKsEoz50KPHTonC0?=
 =?us-ascii?Q?fW4thGQA3vDRa/YgQCoX8E8VdZm+9REdu8Ko8xjjbSsi6fQx9OzoEceeMEpl?=
 =?us-ascii?Q?O9BQkAdB7IUrMsbavXAApwPrzl9dA1/2oE6MtWZCFsA/DnolwZ7OIjAOao84?=
 =?us-ascii?Q?Oi+kVG28OJLeEUvZN/Hv9+cKKOKPu6uEpqYai6dtNK5FGEX+vjW5mZedyXCm?=
 =?us-ascii?Q?uQrzYtKXQiObuiZvfTz888ioOJfYXWxJb6/mfoYkxp84D7LNVDr5e3yZrLyz?=
 =?us-ascii?Q?4aIOduIO1R5zJ5aL5RvkNxD+?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <672E4078839CC64EAB2AA2A497300EC0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3579f252-742c-4aed-692b-08d915767dee
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 18:48:11.1422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQ+fF4DLGNg+NEA42yedtwQjJ/6ieLYemjQzrr22t1/WjO6tz2vkJuS6/3j2t19a1D9wPICDuhXJMOOCISlqajw5PVCRq/c9THHXMXcRCHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4821
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On May 11, 2021, at 11:36, Borislav Petkov <bp@alien8.de> wrote:
>=20
> I clumsily tried to register a SIGSEGV handler with
>=20
>        act.sa_sigaction =3D my_sigsegv;
>        sigaction(SIGSEGV, &act, NULL);
>=20
> but that doesn't fire - task gets killed. Maybe I'm doing it wrong.

Since the altstack is already overflowed, perhaps set the flag like this --=
 not
using it to get the handler:

	act.sa_sigaction =3D my_sigsegv;
+	act.sa_flags =3D SA_SIGINFO;
	sigaction(SIGSEGV, &act, NULL);

FWIW, I think this is just a workaround for this case; in practice, altstac=
k is
rather a backup for normal stack corruption.

Thanks,
Chang

