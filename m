Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A46CA6C099
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2019 19:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfGQRqI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Jul 2019 13:46:08 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:35920 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727255AbfGQRqH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Jul 2019 13:46:07 -0400
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com [10.12.135.161])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 99531C0C2A;
        Wed, 17 Jul 2019 17:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563385565; bh=EflrrD8SgF4nT5b+YTInbdVxmM8gut1TYJuxUxonJXo=;
        h=From:To:CC:Subject:Date:References:From;
        b=IY/NZlS6VQlzzX7uy4IqaryT+tcsHhKDBIfh3iLglH0OrXiHo2SXjmGu4TwIdj6g3
         O43rH3fQ4ss5pFd787r7UsJHAVnek3k+xr3c1xS4/39s/ewWWT7p/arKBWLj5QzFlc
         t8VTkfiIZudjDi8WNy/gHJo/PoS3kXfQjOIF7GQgFuUZmDDFn50PEDkzXZfMHPor2/
         olxFboTT8FQndq0V2q1eIwpnkctvJ9CqT91Qd1GiVg1HGgmnyyORbaF9nLauA+4+iO
         evXxoxdVTLc6sKBJV4aNPfZwj581+OCLG8YuJ4D93/hmQC6AZ040WAmzgsoPtLgNJT
         jZlhjOCz7Rmlg==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id BD976A009C;
        Wed, 17 Jul 2019 17:46:03 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 17 Jul 2019 10:45:54 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 17 Jul 2019 10:45:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPa1HetfUjUyV9FIBnjG13+4wi6mYVj0eLKbAZfeRPjBKgdqbIUuo8bxS4OPdS7aHj0W8VRT5Fpct87quVfsfVmMx9Lalz2eH2NN1hyRfxorFcodnovNLjvVUdz4FVaB9Kbtr+008cVRZJe7AWiBklLr4pyFNeSsI5EL/uErzG+eIWajCWTHxOQS9lXrNJOH74mdWTOoj4h1HWFCuX46STV7IicvmB5rnlsizXw1lubJ+6QMiLaq77PHtoYQ2s9w4hYPckVR6/zycpygeK82up000rwhqvP7Qy0BDjHWWE+OKXdAru1y/lTBQiCBIs0jhrvzz2WkV4TVOjll13gt/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTzV79R87hkd/yqVEBTt3QrPhlp9U0m5BQT03O6G7z0=;
 b=M8AeQ68HY1vGw66yVKl12BU7mdtyamn4Y8S5adoHxrWd5977zn5Q3z05kxSL4cBV1zIPNtgUmsEt9eUBN1rBHoTRxTna7KfpwZSyJ0C3nmF+RoxgQnVVOr9JjvFhtS/BQgJi4+lrOzGKj4+vDp/WMjnmFB1w1pBSaIXpeUpeWKT/GFnMa3x6ff3c0KCZeN2iJgXO1Uv/FRy4nqWJ0ILTvcdSnllYpEOnCPvBmtxr1okAqy17egDhgy2FHQ3H99brXkEvrfCtLEHTpG/N03S8x3UOh2ZD0m5ZgJTmGS+7n8DEUtuPOlhtHX8m4h/+DwRg31cZuBUKOHxL8ndr1pVSDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=synopsys.com;dmarc=pass action=none
 header.from=synopsys.com;dkim=pass header.d=synopsys.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTzV79R87hkd/yqVEBTt3QrPhlp9U0m5BQT03O6G7z0=;
 b=k1CIgFTljosYIZTZ25uULu5+YNXw8gfAJ9kK1shBeaBnYxoMhIkes/fI3cTbjfwh/2TihVbPZAzIHf4Mp/X9DRoWkum1yFSATsomI66kFbMwVbntg46bxoDs/ZzZYc5Ri6gG2noSH7S6o5/bAFKCY2k0UZaEZh4L28Z6bmkmoNc=
Received: from BN6PR1201MB0035.namprd12.prod.outlook.com (10.174.238.140) by
 BN6PR1201MB2531.namprd12.prod.outlook.com (10.172.111.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Wed, 17 Jul 2019 17:45:52 +0000
Received: from BN6PR1201MB0035.namprd12.prod.outlook.com
 ([fe80::24a0:9726:b1f7:fb3c]) by BN6PR1201MB0035.namprd12.prod.outlook.com
 ([fe80::24a0:9726:b1f7:fb3c%11]) with mapi id 15.20.2073.012; Wed, 17 Jul
 2019 17:45:52 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "jbaron@redhat.com" <jbaron@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Thread-Topic: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Thread-Index: AQHVPLGkQUnMGryojE2rPVU+oeatwQ==
Date:   Wed, 17 Jul 2019 17:45:52 +0000
Message-ID: <BN6PR1201MB0035E304FF25609CBCACBD09B6C90@BN6PR1201MB0035.namprd12.prod.outlook.com>
References: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
 <57076361ad37f4fe7a5584643ae47adf30a99d35.camel@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-originating-ip: [198.182.56.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac315126-1681-432d-ed11-08d70ade9d06
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN6PR1201MB2531;
x-ms-traffictypediagnostic: BN6PR1201MB2531:
x-microsoft-antispam-prvs: <BN6PR1201MB2531D684490F8EF3BFAB7D42B6C90@BN6PR1201MB2531.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01018CB5B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(81166006)(256004)(316002)(5660300002)(52536014)(86362001)(14444005)(6116002)(3846002)(2501003)(8676002)(66476007)(54906003)(81156014)(476003)(486006)(9686003)(446003)(74316002)(64756008)(66556008)(66946007)(76116006)(66446008)(91956017)(2906002)(66066001)(6436002)(99286004)(26005)(186003)(7696005)(53546011)(76176011)(6506007)(229853002)(71190400001)(8936002)(71200400001)(102836004)(6246003)(478600001)(7736002)(68736007)(25786009)(14454004)(110136005)(53936002)(33656002)(305945005)(4326008)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR1201MB2531;H:BN6PR1201MB0035.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Pjd1Jdag6lHtz/BSi87t9zUmJhZOEMmbGhK3DCkcQdPHsqiU2Qpdo7gWjouzc7DFu885jA487XGj07a5/1zUOfCR0sCjxZai4QfkCsMF6oplp/YqV3YGWiM3kiP7Ymo7D1T7J49wKhTFn62oGvIZjZ3tbZluVj9Te8ILzq2OTxSpde8IFPF+e1Fq9V5Uv4+BXSpHFoLLgnropZijPZk1FwPCddmPa44gjnID1kH1gt/cJgOa3fHHvJ8ISoHI1hOpk7aVk+9ZHTNYnyBSzuylevl+0U/1DUSTGajlQ59P9S2PxBYX1s1pO92cXySzNVsb4r1+eXzPLbDhPdWTYbFIOavZA9othLi7QZJzeDz6UyOLidG5vTK2efSkOosJ843i1oxmmSEbYWN0SS8OTIo9jHC67Nq8KUNgebOovgi4wmc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ac315126-1681-432d-ed11-08d70ade9d06
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2019 17:45:52.8939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vgupta@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2531
X-OriginatorOrg: synopsys.com
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/17/19 8:09 AM, Eugeniy Paltsev wrote:=0A=
>>> +/* Halt system on fatal error to make debug easier */=0A=
>>> +#define arc_jl_fatal(format...)						\=0A=
>>> +({									\=0A=
>>> +	pr_err(JUMPLABEL_ERR format);					\=0A=
>>> +	BUG();								\=0A=
>> Does it make sense to bring down the whole system vs. failing and return=
ing.=0A=
>> I see there is no error propagation to core code, but still.=0A=
> I totally agree with Peter, and I prefer to stop the system on this error=
s. Here is few arguments:=0A=
> All this checks can't be toggle in system operating normally and only may=
 be caused by bad code generation (or some code/data corruption):=0A=
> 1) We got our instruction to patch unaligned by 4 bytes (despite the fact=
 that we used '.balign 4' to align it)=0A=
> 2) We got branch offset unaligned (which means that we calculate it wrong=
 at build time or corrupt it in run time)=0A=
> 3) We got branch offset which not fits into s25. As this is offset inside=
 one function (inside one 'if' statement actually) we newer get such huge=
=0A=
> offset in real life if code generation is ok.=0A=
=0A=
I understand that. But AFAIKR in implementation arc_jl_fatal() gets called =
before=0A=
we have done the actual code patching and/or flushing the caches to that ef=
fect.=0A=
So harm has been done just yet. We just need to make sure that any book-kee=
ping of=0A=
true/false is not yet done or unrolled.=0A=
=0A=
> If we only warn to log and return we will face with compromised kernel fl=
ow later.=0A=
> I.E. it could be 'if' statement in kernel text which is switched to wrong=
 state: the condition is true but we take the false branch.=0A=
> And It will be the issue which is much more difficult to debug.=0A=
>=0A=
> Does it sound reasonably?=0A=
=0A=
I'm still not convinced that by hitting the _fatal() we are in some inconsi=
stent=0A=
state already. But if u feel strongly lets keep it.=0A=
=0A=
>=0A=
> If you really don't want to have BUG here, I can make it conditionally en=
abled=0A=
=0A=
Not a good idea. It is unconditionally present or not. Not something in bet=
ween.=0A=
=0A=
> in depend on CONFIG_ARC_STATIC_KEYS_DEBUG as I want to have it enabled at=
 least on ARC development platforms.=0A=
=0A=
=0A=
