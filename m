Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 819741BE82
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2019 22:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbfEMUTw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 May 2019 16:19:52 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:54490 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbfEMUTv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 May 2019 16:19:51 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4DKADuB012076;
        Mon, 13 May 2019 13:16:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=8FSlz0GjC3PdOKK/ewJnq9q1qVk9z6fQdSQDgDPLZOs=;
 b=v8h8SgiZTm2Mrf3UKe715rKamNihd4Ywk9LCgclviNg51vqDvK8/3RvWaC5xJq+FRnyJ
 VlqRytZQWSER0seoEEL3JJD9lpESnkfSKDRe2nQuJIx0PM7wVgmeh9JiSRUcerIss9TM
 +wOxxxMGugafn9Am/EVOMhDTDnOQMTxgtVE2Oy8tIx3lyJTtuvEj8OPoxKJbgrPQU1uY
 l7xm5n/tUP6amIn1e+ILLBU96cT0FYJC9wJ2Jr8UCq1nYp9d4jZd3WdMakJmbzirH5/g
 8SoY4yb7Dg39sBTj6an/Of82bbjH88cGICYQHOl3ITxmVKklZL1xCsZ1CgHwpMcJ/vk3 7Q== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2sf9xchp6t-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 13 May 2019 13:16:52 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 13 May
 2019 13:16:22 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.53) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 13 May 2019 13:16:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FSlz0GjC3PdOKK/ewJnq9q1qVk9z6fQdSQDgDPLZOs=;
 b=dks3mxVUhOA91QILnn063NP916tvQ50FO0HuSlFouxKiM2NmHe7/J61cDuzv86U7wkwlelrnvjMwDWsUX1IDt6L0iNX5Na+Irjq3DZhlvQF+7dyI92gtqo9kCjQBhuOQidaPvHhQhrT4ciRIFbufee94Py6FAGmZEH68TyVdL5w=
Received: from MN2PR18MB3086.namprd18.prod.outlook.com (20.179.21.74) by
 MN2PR18MB3328.namprd18.prod.outlook.com (10.255.238.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.21; Mon, 13 May 2019 20:16:18 +0000
Received: from MN2PR18MB3086.namprd18.prod.outlook.com
 ([fe80::9407:14a6:29bf:d683]) by MN2PR18MB3086.namprd18.prod.outlook.com
 ([fe80::9407:14a6:29bf:d683%7]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 20:16:18 +0000
From:   Yuri Norov <ynorov@marvell.com>
To:     Andreas Schwab <schwab@suse.de>, Yury Norov <yury.norov@gmail.com>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>
CC:     Yury Norov <ynorov@caviumnetworks.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Adam Borowski <kilobyte@angband.pl>,
        "Alexander Graf" <agraf@suse.de>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andrew Pinski <pinskia@gmail.com>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Florian Weimer" <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        James Morse <james.morse@arm.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Lin Yongting <linyongting@huawei.com>,
        "Manuel Montezelo" <manuel.montezelo@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        "Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Steve Ellcey <sellcey@caviumnetworks.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: Re: [EXT] Re: [PATCH v9 00/24] ILP32 for ARM64
Thread-Topic: [EXT] Re: [PATCH v9 00/24] ILP32 for ARM64
Thread-Index: AQHUhpjH9to/8IYtJ0GO80mU13Jv5KZi1g0AgAbuLc2AAL0yKQ==
Date:   Mon, 13 May 2019 20:16:17 +0000
Message-ID: <MN2PR18MB30865B950D85C6463EB0E1D4CB0F0@MN2PR18MB3086.namprd18.prod.outlook.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
        <20190508225900.GA14091@yury-thinkpad>,<mvmtvdyoi33.fsf@suse.de>
In-Reply-To: <mvmtvdyoi33.fsf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:640:9:8937:19d3:11c4:475e:3daa]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d63a7e5a-30b5-4c72-6c2e-08d6d7dfdb8f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR18MB3328;
x-ms-traffictypediagnostic: MN2PR18MB3328:
x-microsoft-antispam-prvs: <MN2PR18MB332863E675D3AFB0F5BEF1F1CB0F0@MN2PR18MB3328.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:826;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(136003)(39860400002)(346002)(199004)(189003)(55016002)(25786009)(9686003)(6246003)(316002)(64756008)(66556008)(66476007)(6116002)(66946007)(66446008)(76176011)(2501003)(7736002)(86362001)(73956011)(186003)(2906002)(476003)(76116006)(486006)(11346002)(4326008)(52536014)(446003)(46003)(229853002)(305945005)(99286004)(5660300002)(8936002)(68736007)(33656002)(8676002)(74316002)(6506007)(53936002)(4744005)(81166006)(7406005)(7416002)(7696005)(81156014)(6436002)(71200400001)(478600001)(102836004)(71190400001)(14454004)(54906003)(110136005)(14444005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3328;H:MN2PR18MB3086.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0BNA/4lGkwI/JlW9pnyosBaPDm721604g/Nf3FAJ0B/ROE9Hupn8TalOe1n6tAYKBDim/zKvwaubRL4labxcw8SscgAKrkz3NAY9IT8pwPQqCdoIhfvxdC+p0d7UMmZonRhz5O8qSt1NR37x5d6Q8ksZX5WcNMnR+FBN4iTbjqkO6PhExPk0DpVNmBzaE5FftIenOPUYMIbxzHe+bvHEQgZxHBjiHME+aFmfMpdmjDJ7+3xkWh51b+veSpXfSdLSW14XLPVYo20s6/c9dCbye7Yi/6xmMC76lhS2Vcnth7hRgBiwxiFiiWt3eswxlQ7+vdjDsya1CQjzCICCMUDKcv5hH32IXVRrkcJSS5MlhwGHZQiizlXIjUtGK7HABrJhnjUva8d8aP1ahEBGQ5CFagk/HuznHKSSaQ/sGRRSgHg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d63a7e5a-30b5-4c72-6c2e-08d6d7dfdb8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 20:16:17.9821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3328
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-13_12:,,
 signatures=0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+ ltp@lists.linux.it

> There is a problem with the stack size accounting during execve when
> there is no stack limit:
>
> $ ulimit -s
> 8192
> $ ./hello.ilp32=20
> Hello World!
> $ ulimit -s unlimited
> $ ./hello.ilp32=20
> Segmentation fault
> $ strace ./hello.ilp32=20
> execve("./hello.ilp32", ["./hello.ilp32"], 0xfffff10548f0 /* 77 vars */) =
=3D -1 ENOMEM (Cannot allocate memory)
> +++ killed by SIGSEGV +++
> Segmentation fault (core dumped)
>
> Andreas.

Thanks Andreas, I will take a look. Do we have such test in LTP?
   =20
Yury=
