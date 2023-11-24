Return-Path: <linux-arch+bounces-440-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831FF7F75FF
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 15:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DC8C281611
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 14:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B018528E25;
	Fri, 24 Nov 2023 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VROhY8l8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3996A1988;
	Fri, 24 Nov 2023 06:10:53 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOCju9F008828;
	Fri, 24 Nov 2023 14:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=1XDpK+nffdFUHDezokoXgxxXnBygg99Fmzos5zujGm4=;
 b=VROhY8l8EU/pUM6VT+/NXuq7bgb3DJYPQpOAqbZAvcs7b9sB6p0g4AVmhr8J09HKXvo7
 2ti3wzryF4Get8Zn7uCDDIPy3/coDxKsRGvUhJjkefWWZTIjvGCwQZ6N1ozIHCAvFrtP
 WsZCjtrNHh6iICpwZkeK8CcjsCQS+Bc8wNjKvo8SGeYetvHp3GbtKFu+HUgNVWfVbE+p
 Vj4Bgn0k4Io97rJQiCUWhr6w73VZcYUmVBLnJeyzC9KvtYBI9PichDeXcxBxpABA2D4H
 rs+28X+yj58PCvWvm3Zpf2fDn2iK8Dvt/D+plhIIEDG+fPKW0/meYntzgFmXSIrIpDJX EA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ujr1uqsyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 14:10:33 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AODjTG7005756;
	Fri, 24 Nov 2023 14:10:32 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ujr1uqsy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 14:10:32 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOCImGt010706;
	Fri, 24 Nov 2023 14:10:31 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ufaa2nha9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 14:10:31 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AOEAUVB25625310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Nov 2023 14:10:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 111882004B;
	Fri, 24 Nov 2023 14:10:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDD0C20043;
	Fri, 24 Nov 2023 14:10:29 +0000 (GMT)
Received: from [9.152.212.236] (unknown [9.152.212.236])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Nov 2023 14:10:29 +0000 (GMT)
Message-ID: <c102bdef10b280f47f5fe4538eb168ac730d7644.camel@linux.ibm.com>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas
 <catalin.marinas@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
        Michael Guralnik <michaelgur@mellanox.com>,
        Nathan
 Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>
Date: Fri, 24 Nov 2023 15:10:29 +0100
In-Reply-To: <c3ae87aea7660c3d266905c19d10d8de0f9fb779.1700766072.git.leon@kernel.org>
References: <cover.1700766072.git.leon@kernel.org>
	 <c3ae87aea7660c3d266905c19d10d8de0f9fb779.1700766072.git.leon@kernel.org>
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
X-Proofpoint-ORIG-GUID: DlX5JX8yDxirijJYFx7Tw99QLOVLHZNy
X-Proofpoint-GUID: Z5J6A1Un7mtX4x1KyJ1P2vtnA3j-CODM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311240110

On Thu, 2023-11-23 at 21:04 +0200, Leon Romanovsky wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
>=20
> The kernel supports write combining IO memory which is commonly used to
> generate 64 byte TLPs in a PCIe environment. On many CPUs this mechanism
> is pretty tolerant and a simple C loop will suffice to generate a 64 byte
> TLP.
>=20
> However modern ARM64 CPUs are quite sensitive and a compiler generated
> loop is not enough to reliably generate a 64 byte TLP. Especially given
> the ARM64 issue that writel() does not codegen anything other than "[xN]"
> as the address calculation.
>=20
> These newer CPUs require an orderly consecutive block of stores to work
> reliably. This is best done with four STP integer instructions (perhaps
> ST64B in future), or a single ST4 vector instruction.
>=20
> Provide a new generic function memcpy_toio_64() which should reliably
> generate the needed instructions for the architecture, assuming address
> alignment. As the usual need for this operation is performance sensitive =
a
> fast inline implementation is preferred.
>=20
> Implement an optimized version on ARM that is a block of 4 STP
> instructions.
>=20
> The generic implementation is just a simple loop. x86-64 (clang 16)
> compiles this into an unrolled loop of 16 movq pairs.
>=20
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
---8<---
> +#ifndef memcpy_toio_64
> +#define memcpy_toio_64 memcpy_toio_64
> +/**
> + * memcpy_toio_64	Copy 64 bytes of data into I/O memory
> + * @dst:		The (I/O memory) destination for the copy
> + * @src:		The (RAM) source for the data
> + * @count:		The number of bytes to copy
> + *
> + * dst and src must be aligned to 8 bytes. This operation copies exactly=
 64
> + * bytes. It is intended to be used for write combining IO memory. The
> + * architecture should provide an implementation that has a high chance =
of
> + * generating a single combined transaction.
> + */
> +static inline void memcpy_toio_64(volatile void __iomem *addr,
> +				  const void *buffer)
> +{
> +	unsigned int i =3D 0;
> +
> +#if BITS_PER_LONG =3D=3D 64
> +	for (; i !=3D 8; i++)
> +		__raw_writeq(((const u64 *)buffer)[i],
> +			     ((u64 __iomem *)addr) + i);
> +#else
> +	for (; i !=3D 16; i++)
> +		__raw_writel(((const u32 *)buffer)[i],
> +			     ((u32 __iomem *)addr) + i);
> +#endif

What's the reasoning behind not using the existing memcpy_toio() here?
For s390 the above generic variant would do 8 of our special PCI store
instructions while memcpy_toio() is defined to zpci_memcpy_toio() which
can do the same as a single PCI store block instruction. Now of course
we could provide our own memcpy_toio_64() but that would end up the
same as just doing memcpy_toio(addr, buffer, 64) here.

> +}
> +#endif
> +
>  extern int devmem_is_allowed(unsigned long pfn);
> =20
>  #endif /* __KERNEL__ */


