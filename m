Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A01259DD7
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 20:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgIASFy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 14:05:54 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:36466 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726377AbgIASFw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 14:05:52 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 081I5chn004983;
        Tue, 1 Sep 2020 11:05:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0220; bh=S0RGQHBf4JE3KRy7FfsZIHeQHiJC9E8CDFbIsjrItQk=;
 b=JnTOo1gIrnWvrdLLfimktEpoJ0X6aQ8IpnK2RjTbCg/R73TSIzKq3Ds5gKTF0eu6VKu9
 hO7MOLnZXZtfFu1EuODdPc4P9TAECTZ0E9XrFoPxw9t3UI7BxxNMfPJwmDz2L7MoVUQe
 SzFy3xLKHCHF97CNsym3OT6ujJN7ryyJ+ckI1EX/80UABLVza55RZ7EEvVNSgEiImFZO
 Ph5OHGz2e2N8gGxSYdDpTZYo61ekvKliunnxaXGhcw86Zq0inRds5geQ5HqUSxVbp6IT
 75NqmIDwdHFiok2S6wJeyBTJZC7dHNco27fXRpBX4pDGbgomgfl4+hugqa4aG0wwnSdp aA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 337phq1tqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 11:05:38 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 1 Sep
 2020 11:05:37 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 1 Sep
 2020 11:05:36 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.50) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 1 Sep 2020 11:05:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Puksweb41G7n648/eGOhytFj/GVP6MeStqvZRWfxNCZwZ4n4GV0hBq4ZcQQxz7C05Pct6tgihRCqBuPIKzNtWfIl+7NHLXcBihNRMfwsXnVNzXETxF6PbJsR+w/XYI8NSCz6TPZga42fIqCxK4DK9rYABhi89Nibq9fcwh6j3ea01Dl8Sxq/WBhEsZh8oK8ak5ubErivsJdlNMV7wAaYp8If1Lr664HUW5tVtxxIVwMl4EsjJsu9KDptmL0EaeQsWMWcnW1xqCF/Nn+LiFEGq3n5j2saePakEn03VJ01pC78YQev2dWbJNBJM2bGdK1tuwHQdElO7DszruTFBali0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0RGQHBf4JE3KRy7FfsZIHeQHiJC9E8CDFbIsjrItQk=;
 b=USXdfdabg7R+fMF/Vu98ihgIczJDdXCmKSWDSw4PWgMXicRTTAbXFNXzZJfO7Nv/qXVr/venbl6F65odBjYbPO78mHhue7ClRfkc1AvPsGWXw0BZeq0f7eX+5LvzsZQVltIBhofZQoob7/x43w7yr+m3+IRdfV+yV2tqeH5L8NcCUWiU1yQhek2udstDEggddP2XCJzX9CVbJThKp1qsvLgj+q3M5dy/PsrllcqEPOKWK1zHIGGq9Bb86jw+Z9tlXdho+PaP1QRwF7RaDJ5YS/Gn2lF92K8ssYA4HQUknq2Hxhda/n96PQwhVxDhn6wuDJU+/E1ret3SQG4vWA59eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0RGQHBf4JE3KRy7FfsZIHeQHiJC9E8CDFbIsjrItQk=;
 b=eEZgt12J8oVek65NQ8VSE7JM5HJBkVVFtjtz2Ybu1lJbofLWI1d/+/f8BS027tI7ORces5O/JNQWv7Rl98lYXy+QpOAvum4TTis4qa9xN3/UyWZzRqBMSV3ZRxeTzXah0Tawg6ziZm9zoZ9O4fvo7V+OMhRrh3kexKikEuvNE7k=
Received: from BYAPR18MB2679.namprd18.prod.outlook.com (2603:10b6:a03:13c::10)
 by BYAPR18MB2454.namprd18.prod.outlook.com (2603:10b6:a03:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 1 Sep
 2020 18:05:34 +0000
Received: from BYAPR18MB2679.namprd18.prod.outlook.com
 ([fe80::2ded:ad90:8fc1:5c9e]) by BYAPR18MB2679.namprd18.prod.outlook.com
 ([fe80::2ded:ad90:8fc1:5c9e%4]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 18:05:34 +0000
From:   George Cherian <gcherian@marvell.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "mst@redhat.com" <mst@redhat.com>
Subject: Re: Re: [PATCH v3] PCI: Add pci_iounmap
Thread-Topic: Re: [PATCH v3] PCI: Add pci_iounmap
Thread-Index: AdaAiO3VCaJd0VKpQqmpZfC3xBhX9w==
Date:   Tue, 1 Sep 2020 18:05:34 +0000
Message-ID: <BYAPR18MB2679AAA983C2AF3CD399ABD8C52E0@BYAPR18MB2679.namprd18.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [49.207.219.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 280e0dd3-0935-482a-488b-08d84ea19f79
x-ms-traffictypediagnostic: BYAPR18MB2454:
x-microsoft-antispam-prvs: <BYAPR18MB2454558431E34397441BC2B0C52E0@BYAPR18MB2454.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mWTM3zJrlJtvdaPM0z3L8fzkeT6kSbKJvOnICO6LuuaU4y4XT4j9d9ocAf55H44HZsvWn4uLuN7m2zs53a8dK72lH+OZcMm95vE++YPs/sf3PkyCAvs+qjx0POFKef9FPW2jXrwA3j/Ine5KkCu2+yfmqSjXtBgNjJ99hf1IufK9NLDHQRU8YaY7ZB/VZtlEZUMlRdiv07c2/bHKGv2RI3mhGLfhjJFIZn0to0KYOL2lV5Bi8MmQOnzuD5uIOsw9PUVfvSfS65bZBD7guFFmzoS98gHh+6sMmaVLYSwuWy4WHSGGeih5daR1iXcnkeWR94Parst7lmZR7t8cwUzKhA9Vcrud1MHYz1awDO+NzT3aQ7mgpIphGFhK2YoTq9nntbR6gvM9k/uks6qvu+i5iw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2679.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(9686003)(7696005)(53546011)(966005)(6506007)(8936002)(33656002)(55016002)(316002)(55236004)(54906003)(110136005)(478600001)(86362001)(2906002)(5660300002)(52536014)(186003)(66556008)(66946007)(64756008)(66446008)(66476007)(26005)(83380400001)(76116006)(19627235002)(4326008)(8676002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: rauwkxRcw/nHZ49jT3rab6GYbTiSX75JXHIDTatvJO6HeJJkKG1nf5oLLyFT023fON8KLKMmuQtJo9iRQGY/BxBSXuQJGteD6hlv8x7dBO5spj9Go9SFyy2tmTOwrAZDTnscpq0cm+jGH7JpiAT9HBouTopKolLcQG4mbLXAO/Xe9YRRRuirtcUKlNZ/YwexrIXkyUvYifc/aQ9c2ry0Uye9huo3LNuw0T/6Kaf8IyXJGNk8zLxadHX/fW1aRHNR8+g1sYkVRcr9S9MtQ6XOcfS9x1ZzZEe6TLaY40HXyvtgKL5DPp2aAj7qOza+9gPUGxZJb5wi+ti+wEqfA37GZHTyYOXBPAIF67ddqno09yYaxP2YWZpJKilsrNCU1SUCEYqfuvPXVSIuvKwM3l7jAGbpQKStY66rfQFDZ6C1cJOLMJ/NGzFglJ4z5b+B34xKFOK2ZWW9X42AEX3MXhjL2ta/LDK6UzJq9UbAh8KfND0A6pF8Tm6zraCkm1YWHgWfGCUfwKsQvny85OGnQmHGXj1M0YmfFB64QmA+tqKiCwjHH0syl2vOrNp62uPF1DE045N6QJRqs86SuZplENpO9iKnu0OcV39SUm/LNLmgdTH4O7t9bwVbouZ5reuEk4lc+W0wf2zCnQJZIFY4F1CC9Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR18MB2679.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280e0dd3-0935-482a-488b-08d84ea19f79
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 18:05:34.3403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jsongXW69TcfopnoWm/srVaS1GnS1FLUo862e2uPcYzVqo1EDK0lnleYTjyptgyqOrzcGcpkFAoNiEO8ihUAsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2454
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-01_10:2020-09-01,2020-09-01 signatures=0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Yang,

> -----Original Message-----
> From: Yang Yingliang <yangyingliang@huawei.com>
> Sent: Tuesday, September 1, 2020 6:59 PM
> To: George Cherian <gcherian@marvell.com>; linux-kernel@vger.kernel.org;
> linux-arch@vger.kernel.org; linux-pci@vger.kernel.org
> Cc: kbuild-all@lists.01.org; bhelgaas@google.com; arnd@arndb.de;
> mst@redhat.com
> Subject: Re: [PATCH v3] PCI: Add pci_iounmap
>=20
>=20
>
>=20
> On 2020/8/25 9:25, kernel test robot wrote:
> > Hi George,
> >
> > I love your patch! Yet something to improve:
> >
> > [auto build test ERROR on pci/next]
> > [also build test ERROR on linux/master linus/master asm-generic/master
> > v5.9-rc2 next-20200824] [If your patch is applied to the wrong git tree=
,
> kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git-
> 2Dscm.com_doc
> > s_git-2Dformat-2Dpatch&d=3DDwIC-
> g&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DTjMsEFPc7di
> >
> rkF6u2D3eSIS0cA8FeYpzRkkMzr4aCbk&m=3DdvtRkwC273FmalEZE_KonLRWrIV
> WLSWfG61
> > NWTWG5LI&s=3DycW6SZOVRuKAm3YwdhyAuSh22oPuengSMVuv-
> EwaUew&e=3D ]
> >
> > url:    https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__github.com_0day-2Dci_linux_commits_George-2DCherian_PCI-2DAdd-
> 2Dpci-5Fiounmap_20200824-2D212149&d=3DDwIC-
> g&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DTjMsEFPc7dirkF6u2D3eSIS0cA8FeYpzRkk
> Mzr4aCbk&m=3DdvtRkwC273FmalEZE_KonLRWrIVWLSWfG61NWTWG5LI&s=3D6c
> UOYHeDOBZ0HaFc2z-vaDgDmbIK4LCBRt9kNkn1sto&e=3D
> > base:   https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__git.kernel.org_pub_scm_linux_kernel_git_helgaas_pci.git&d=3DDwIC-
> g&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DTjMsEFPc7dirkF6u2D3eSIS0cA8FeYpzRkk
> Mzr4aCbk&m=3DdvtRkwC273FmalEZE_KonLRWrIVWLSWfG61NWTWG5LI&s=3Dh-
> TMyLlEdAwew-u52q4dgWBUMgm0ys-xKzvOO86e1Lw&e=3D  next
> > config: powerpc-allyesconfig (attached as .config)
> > compiler: powerpc64-linux-gcc (GCC) 9.3.0 reproduce (this is a W=3D1
> > build):
> >          wget https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__raw.githubusercontent.com_intel_lkp-
> 2Dtests_master_sbin_make.cross&d=3DDwIC-
> g&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DTjMsEFPc7dirkF6u2D3eSIS0cA8FeYpzRkk
> Mzr4aCbk&m=3DdvtRkwC273FmalEZE_KonLRWrIVWLSWfG61NWTWG5LI&s=3Daz
> QcL0MQmPpr9UfvyBSSdQiu1UbjJgFrzNJOtcZ_--E&e=3D  -O ~/bin/make.cross
> >          chmod +x ~/bin/make.cross
> >          # save the attached .config to linux build tree
> >          COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0
> > make.cross ARCH=3Dpowerpc
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >     powerpc64-linux-ld: lib/pci_iomap.o: in function `__crc_pci_iounmap=
':
> >>> (.rodata+0x10): multiple definition of `__crc_pci_iounmap';
> >>> lib/iomap.o:(.rodata+0x68): first defined here
> EXPORT_SYMBOL(pci_iounmap) in lib/iomap.c need be removed.
I really don't think that is the way to fix this. I have also seen your oth=
er patch=20
in which iomap being moved out of lib/iomap.c to header file.

There was a reason for moving iomap and its variants to a lib since most of
the arch's implementation of map was similar. Whereas the unmap had multipl=
e=20
implementation per arch's. So, the lib/iomap never implemented the generic =
unmap.

I see either of the following solution.
a. Have an arm64 specific implementation for the unmap function.
Or
b. something on the lines of v2[1], which accommodates all the arch's but h=
as the #ifdef
for which Bjorn raised his concerns.

Bjorn, any comments?

Regards
-George

[1] - https://lkml.org/lkml/2020/8/20/28
