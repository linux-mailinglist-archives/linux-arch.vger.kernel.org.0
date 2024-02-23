Return-Path: <linux-arch+bounces-2697-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EDB8610A0
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 12:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37DA6285A5C
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 11:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C166C7B3D1;
	Fri, 23 Feb 2024 11:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TIQRRS/d"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0138D664D7;
	Fri, 23 Feb 2024 11:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688386; cv=none; b=KEyuNeueulj0u0xdYVa817OhLgjrfjAaogolfr91+2vyK54/lE4MQszloFPspFOP1xvkxPD2Nl7pLkXWrHdtFT5rCNmVWS+CshHqsB/hzDTXhbbReLofiZLuAGkiyH1HtUq5dBGOBA9TaPkxPHZFz7RNlK8a1NfBQtoCFGiotPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688386; c=relaxed/simple;
	bh=SOBGkQ87OHbpYPbwJbV1z8UXUoNJ8LFvnhMAoufEYUY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YyHRd2zZgnv4ChKObIZLYLQ+U4QjcsM80swRICAmPJDOLlDOrQaMbjkPEfTIxVH6Z7WhCu1UQX+3VvKNb8fqRqEDhHdZsV/D3GFcAn2Q5F6kvsosqJIPyuvFQ2DdNn2lO8blnntN6jrHoJlm7BosGW3aqaD7Pg4HQ1A9oBISq7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TIQRRS/d; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NBRJq2026830;
	Fri, 23 Feb 2024 11:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Z3T8PgukbxivN47ypziSxUoMZgR1s8vOcvIkbeCW9rI=;
 b=TIQRRS/dQpVAe+BOBgEk+maQA38eY4ClsKF3pKb2Ou3+QKTMdTOGRX+RHQrWVAWgsi9X
 gLZ9k3+ztbQihEyXyLQEJGhFkJ0xYwhCb7U3p5ev4xjHQ5HulejDu/3FgeR3xn357sIw
 5qr5RxlZSGl6uBZk4r7fzeP76sr2oqVILes3cpzmFAdURfPtTOcv+HCZJRPT99ZRqBTb
 Qo+KKv09WhglHM50rN9DFmyosW+vAMYG7OcTSZHVGAg38WldJ/gkbHffGGzZoPQ2ejz5
 WPQc3TONHkB/EQgMoya0SCVMOaPZthGom1ufs5lGfQdaWUnEaUgoIf9Di0gTIHSnblGw zA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wetgc8fb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 11:38:28 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41NBRHWD026738;
	Fri, 23 Feb 2024 11:38:28 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wetgc8f9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 11:38:27 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NAQOH6003620;
	Fri, 23 Feb 2024 11:38:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74u5ac4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 11:38:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NBcKX014877224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 11:38:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57E5F2004B;
	Fri, 23 Feb 2024 11:38:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DB2520040;
	Fri, 23 Feb 2024 11:38:18 +0000 (GMT)
Received: from [9.179.5.151] (unknown [9.179.5.151])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 11:38:18 +0000 (GMT)
Message-ID: <e78f6e6294c31d889ace4de3a3c3cebad04f4213.camel@linux.ibm.com>
Subject: Re: [PATCH 4/6] arm64/io: Provide a WC friendly __iowriteXX_copy()
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: David Laight <David.Laight@ACULAB.COM>,
        "'Jason Gunthorpe'"
 <jgg@nvidia.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton
 <akpm@linux-foundation.org>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen
 <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Heiko
 Carstens <hca@linux.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Justin
 Stitt <justinstitt@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Leon
 Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>,
        "linux-s390@vger.kernel.org"
 <linux-s390@vger.kernel.org>,
        "llvm@lists.linux.dev"
 <llvm@lists.linux.dev>,
        Ingo Molnar <mingo@redhat.com>, Bill Wendling
 <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick
 Desaulniers <ndesaulniers@google.com>,
        "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Salil Mehta
 <salil.mehta@huawei.com>,
        Jijie Shao <shaojijie@huawei.com>,
        Sven Schnelle
 <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Yisen Zhuang <yisen.zhuang@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        "linux-arch@vger.kernel.org"
 <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland
 <mark.rutland@arm.com>,
        Michael Guralnik <michaelgur@mellanox.com>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        Will Deacon
 <will@kernel.org>
Date: Fri, 23 Feb 2024 12:38:18 +0100
In-Reply-To: <efc727fbb8de45c8b669b6ec174f95ce@AcuMS.aculab.com>
References: <0-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
	 <4-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
	 <6d335e8701334a15b220b75d49b98d77@AcuMS.aculab.com>
	 <20240222223617.GC13330@nvidia.com>
	 <efc727fbb8de45c8b669b6ec174f95ce@AcuMS.aculab.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MqwhGsgikHa9NyimJCr5jU4KExms2tOv
X-Proofpoint-ORIG-GUID: QhPPKuwwZngZhITqhGS4k2s-WuzqCqDx
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 mlxlogscore=622 priorityscore=1501 adultscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402230083

On Fri, 2024-02-23 at 09:07 +0000, David Laight wrote:
> From: Jason Gunthorpe
> > Sent: 22 February 2024 22:36
> > To: David Laight <David.Laight@ACULAB.COM>
> >=20
> > On Thu, Feb 22, 2024 at 10:05:04PM +0000, David Laight wrote:
> > > From: Jason Gunthorpe
> > > > Sent: 21 February 2024 01:17
> > > >=20
> > > > The kernel provides driver support for using write combining IO mem=
ory
> > > > through the __iowriteXX_copy() API which is commonly used as an opt=
ional
> > > > optimization to generate 16/32/64 byte MemWr TLPs in a PCIe environ=
ment.
> > > >=20
> > > ...
> > > > Implement __iowrite32/64_copy() specifically for ARM64 and use inli=
ne
> > > > assembly to build consecutive blocks of STR instructions. Provide d=
irect
> > > > support for 64/32/16 large TLP generation in this manner. Optimize =
for
> > > > common constant lengths so that the compiler can directly inline th=
e store
> > > > blocks.
> > > ...
> > > > +/*
> > > > + * This generates a memcpy that works on a from/to address which i=
s aligned to
> > > > + * bits. Count is in terms of the number of bits sized quantities =
to copy. It
> > > > + * optimizes to use the STR groupings when possible so that it is =
WC friendly.
> > > > + */
> > > > +#define memcpy_toio_aligned(to, from, count, bits)                =
        \
> > > > +	({                                                               =
 \
> > > > +		volatile u##bits __iomem *_to =3D to;                       \
> > > > +		const u##bits *_from =3D from;                              \
> > > > +		size_t _count =3D count;                                    \
> > > > +		const u##bits *_end_from =3D _from + ALIGN_DOWN(_count, 8); \
> > > > +                                                                  =
        \
> > > > +		for (; _from < _end_from; _from +=3D 8, _to +=3D 8)           \
> > > > +			__const_memcpy_toio_aligned##bits(_to, _from, 8); \
> > > > +		if ((_count % 8) >=3D 4) {
> > >=20
> > > If (_count & 4) {
> >=20
> > That would be obfuscating, IMHO. The compiler doesn't need such things
> > to generate optimal code.
>=20
> Try it: https://godbolt.org/z/EvvGrTxv3=20
> And it isn't that obfuscated - no more so than your version.
>=20
> > > > +			__const_memcpy_toio_aligned##bits(_to, _from, 1); \
> > > > +	})
> > >=20
> > > But that looks bit a bit large to be inlined.
> >=20
> > You trimmed alot, this #define is in a C file and it is a template to
> > generate the 32 and 64 bit out of line functions. Things are done like
> > this because the 32/64 version are exactly the same logic except just
> > with different types and sizes.
>=20
> I missed that in a quick read at 11pm :-(
>=20
> Although I doubt that generating long TLP from byte writes is
> really necessary.

I might have gotten confused but I think these are not byte writes.
Remember that the count is in terms of the number of bits sized
quantities to copy so "count =3D=3D 1" is 4/8 bytes here.

> IIRC you were merging at most 4 writes.
> So better to do a single 32bit write instead.
> (Unless you have misaligned source data - unlikely.)
>=20
> While write-combining to generate long TLP is probably mostly
> safe for PCIe targets, there are some that will only handle
> TLP for single 32bit data items.
> Which might be why the code is explicitly requesting 4 byte copies.
> So it may be entirely wrong to write-combine anything except
> the generic memcpy_toio().
>=20
> 	David

On anything other than s390x this should only do write-combine if the
memory mapping allows it, no? Meaning a driver that can't handle larger
TLPs really shouldn't use ioremap_wc() then.

On s390x one could argue that our version of __iowriteXX_copy() is
strictly speaking not correct in that zpci_memcpy_toio() doesn't really
use XX bit writes which is why for us memcpy_toio() was actually a
better fit indeed. On the other hand doing 32 bit PCI stores (an s390x
thing) can't combine multiple stores into a single TLP which these
functions are used for and which has much more use cases than forcing a
copy loop with 32/64 bit sized writes which would also be a lot slower
on s390x than an aligned zpci_memcpy_toio().

