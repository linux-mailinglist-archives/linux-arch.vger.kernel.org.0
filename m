Return-Path: <linux-arch+bounces-446-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD327F786B
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 17:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9DF81C20946
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 16:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFDD31751;
	Fri, 24 Nov 2023 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FvHJjHxZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895BD12B;
	Fri, 24 Nov 2023 08:00:01 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOFv2lX015477;
	Fri, 24 Nov 2023 15:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=rnorhOgJqTAhJ2ff91jA+Eihqw7bxMBbiU6K3KlQoiY=;
 b=FvHJjHxZO1InjBWtTGTI30is4uOBHWOyOp6bV551FD0+YTRF+W+/tLYyvGuLpvqgB0xX
 7BYq345nQ/2pLZKLIvMr73mFM14zZQFXoblTfWVP/yCHnJhHZy3mKzrn9NSNnnkDeCh+
 DEzK63fhOQPAHJMAXrCGndH695gHWu0s5gAEPbagASHalAsBWIEqJmdnM7L8leeWaKdE
 wwXeKbCR7TTQ5LoAiihSw7Y8xGk3vkDBoMZvnV9Si6eo0tDKqJ3A0jVm0zC/k9uF7WwE
 JjCI/H7d1949eBtjGYVVi3fNrJ4qi/AHPt47APPNgfmAbLQLKR1830aMqgp56fpWk9kX yA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ujxx101t4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 15:59:42 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AOFxEqk021637;
	Fri, 24 Nov 2023 15:59:42 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ujxx101sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 15:59:42 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOF5xbU015327;
	Fri, 24 Nov 2023 15:59:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf8006tda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 15:59:40 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AOFxcnA18088654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Nov 2023 15:59:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E8BF20043;
	Fri, 24 Nov 2023 15:59:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EAB420040;
	Fri, 24 Nov 2023 15:59:38 +0000 (GMT)
Received: from [9.152.212.236] (unknown [9.152.212.236])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Nov 2023 15:59:38 +0000 (GMT)
Message-ID: <b3250b9a9af2f29ee3d06830746fb6e8ac49271d.camel@linux.ibm.com>
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
        Will Deacon <will@kernel.org>
Date: Fri, 24 Nov 2023 16:59:38 +0100
In-Reply-To: <20231124145529.GG436702@nvidia.com>
References: <cover.1700766072.git.leon@kernel.org>
	 <c3ae87aea7660c3d266905c19d10d8de0f9fb779.1700766072.git.leon@kernel.org>
	 <c102bdef10b280f47f5fe4538eb168ac730d7644.camel@linux.ibm.com>
	 <20231124142049.GF436702@nvidia.com>
	 <14103e31e0c47c0594e7479126ce7fe34f2de467.camel@linux.ibm.com>
	 <20231124145529.GG436702@nvidia.com>
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
X-Proofpoint-ORIG-GUID: 3KltwUJsWxyHpdOewx-yp-U8XnIdt2m9
X-Proofpoint-GUID: Bk8fkUCCN1I4BSgtnI337b9eqIR7URmK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-24_02,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311240125

On Fri, 2023-11-24 at 10:55 -0400, Jason Gunthorpe wrote:
> On Fri, Nov 24, 2023 at 03:48:22PM +0100, Niklas Schnelle wrote:
> > On Fri, 2023-11-24 at 10:20 -0400, Jason Gunthorpe wrote:
> > > On Fri, Nov 24, 2023 at 03:10:29PM +0100, Niklas Schnelle wrote:
> > > =20
> > > > What's the reasoning behind not using the existing memcpy_toio()
> > > > here?
> > >=20
> > > Going forward CPUs are implementing an instruction to do a 64 byte
> > > aligned store, this is a wrapper for exactly that operation.
> > >=20
> > > memcpy_toio() is much more general, it allows unaligned buffers and
> > > non-multiples of 64. Adapting the general version to generate the
> > > optimized version in the cases it can is complex and has a codegen
> > > penalty..
> >=20
> > I think you misunderstood me. I understand why you want a separate
> > memcpy_toio_64(). I just wonder if its generic implementation shouldn't
> > just be a define or inline wrapper for memcpy_toio(addr, buffer, 64).
>=20
> Oh, yes, I totally did.
>=20
> I'm worried that x86 will less reliably generate write combining with
> it's memcpy_toio implemention. It codegens byte copies for that
> function :(

Oh ok I see what you mean.

>=20
> > Also seeing the second patch of course that would no longer really test
> > for write combining for us which we can also do but I think that's okay
> > and you're probably going to use memcpy_toio_64() in more places and
> > there we really want the PCI store block.
>=20
> Right now we don't have in-kernel performance use cases for write
> combining for mlx5.

Is the code in patch 2 performance critical?

>=20
> Userspace uses the WC and we already have the special 390 instructions
> for batching in rdma-core already, IIRC.

Yes, I added that support to rdma-core :-)

>=20
> So it would be appropriate for s390 to use a consistent path.
>=20
> Jason

This should be as easy as adding

#define memcpy_toio_64(to, from) zpci_memcpy_toio(to, from, 64)

to arch/s390/include/asm/io.h. I'm wondering if we should do that as
part of this series. It's not as good as a special case but probably
better than the existing loop.

I don't think we have any existing in-kernel users of memcpy_toio() on
s390 so far though so I'd like to give this some extra testing. Could
you share instructions on how to exercise the code path of patch 2 on a
ConnectX-5 or 6? Is this exercised e.g. when using NVMe-oF RDMA?

Thanks,
Niklas

