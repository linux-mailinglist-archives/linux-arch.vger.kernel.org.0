Return-Path: <linux-arch+bounces-476-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A8E7FA843
	for <lists+linux-arch@lfdr.de>; Mon, 27 Nov 2023 18:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3881F20EF8
	for <lists+linux-arch@lfdr.de>; Mon, 27 Nov 2023 17:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFF63A8DE;
	Mon, 27 Nov 2023 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="feIF0PY5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE02111;
	Mon, 27 Nov 2023 09:46:06 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARHed0U001128;
	Mon, 27 Nov 2023 17:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=lzqj58I3IPFrtKe4S8rNaZ4kZ62EXnfUaMFKX5my+LU=;
 b=feIF0PY5+um4MebiA8jlFX3aHG2Ss612jVt0ln8mqQnDDxOl8SfctHc0x954bYkr+kv0
 CrFXhe3FWqtpNe/Gy0yWJ/T5Vr9UNpqTn3VoQBZxkEG6IKGNaBOJSWDi53B5DeBYK65W
 crDbe+xSTUpKM88r4rZELhkYKIx1hlQDP2S53I4mOekJ9U8e3Wq5UNKKdBUG35hMx8TB
 TjqNC7hTIxf7pUbdNVmQvdZahzrevJogueSGunAssN9gkNsCNtVq96pkRYuZaTxlqGiU
 IgNJ4J8+vCgyex8P8naDKu6A0VPoZ3i/83jcYeVoXLjMK6qHhtS5GjAAMZn3enq0mWYe 9g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umxd52vr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 17:45:48 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ARGqxI1010012;
	Mon, 27 Nov 2023 17:45:47 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umxd52vhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 17:45:47 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARGtRpk009198;
	Mon, 27 Nov 2023 17:43:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukumyaftk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 17:43:14 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ARHhCIC20185812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Nov 2023 17:43:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61DD42004B;
	Mon, 27 Nov 2023 17:43:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E09820040;
	Mon, 27 Nov 2023 17:43:11 +0000 (GMT)
Received: from [9.179.10.95] (unknown [9.179.10.95])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Nov 2023 17:43:11 +0000 (GMT)
Message-ID: <637dcc4d69c380bd939dfdd1b14a5c82c2ddfaa4.camel@linux.ibm.com>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
        llvm@lists.linux.dev, Michael Guralnik <michaelgur@mellanox.com>,
        Nathan
 Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>
Date: Mon, 27 Nov 2023 18:43:11 +0100
In-Reply-To: <20231124160627.GH436702@nvidia.com>
References: <cover.1700766072.git.leon@kernel.org>
	 <c3ae87aea7660c3d266905c19d10d8de0f9fb779.1700766072.git.leon@kernel.org>
	 <c102bdef10b280f47f5fe4538eb168ac730d7644.camel@linux.ibm.com>
	 <20231124142049.GF436702@nvidia.com>
	 <14103e31e0c47c0594e7479126ce7fe34f2de467.camel@linux.ibm.com>
	 <20231124145529.GG436702@nvidia.com>
	 <b3250b9a9af2f29ee3d06830746fb6e8ac49271d.camel@linux.ibm.com>
	 <20231124160627.GH436702@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _M3XpV3w84E_3d-YkVQ8I7sJh5H0Q7He
X-Proofpoint-GUID: lQohcn7e8AuOM97Z7HR6-FkciDH-UZJt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_16,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=566 impostorscore=0 spamscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311270122

On Fri, 2023-11-24 at 12:06 -0400, Jason Gunthorpe wrote:
> On Fri, Nov 24, 2023 at 04:59:38PM +0100, Niklas Schnelle wrote:
> =20
> > This should be as easy as adding
> >=20
> > #define memcpy_toio_64(to, from) zpci_memcpy_toio(to, from, 64)
> >=20
> > to arch/s390/include/asm/io.h. I'm wondering if we should do that as
> > part of this series. It's not as good as a special case but probably
> > better than the existing loop.
>=20
> Makes sense

Ok, I overlooked the obvious. Let's make that:

#define memcpy_toio_64(dst, src)       zpci_write_block(dst, src, 64)

>=20
> > I don't think we have any existing in-kernel users of memcpy_toio() on
> > s390 so far though so I'd like to give this some extra testing. Could
> > you share instructions on how to exercise the code path of patch 2 on a
> > ConnectX-5 or 6? Is this exercised e.g. when using NVMe-oF RDMA?
>=20
> Simply boot and look at pr_debug from mlx5 to see if writecombining is
> on or off - you want to see on.
>=20
> Thanks,
> Jason

With the above zpci_write_block(dst, src, 64) we get a PCI store block
without any extra alignment treatment i.e. exactly what we want for
memcpy_toio_64(). If the alignment is wrong the PCI store block
instruction will fail the PCI function will be isolated and we log an
error so I don't see a need for checks there either. On an aside it
looks like our zpci_memcpy_toio() is wrongly looking for tighter than 8
byte alignment on the source address and would issue a series of 8
stores. Still looking into that. I also tested this with our only
privileged (kernel only) PCI stores and that works too.

Also it turns out the writeq() loop we had so far does not produce the
needed 64 byte TLP on s390 either so this actually makes us newly pass
this test.

Thanks,
Niklas


