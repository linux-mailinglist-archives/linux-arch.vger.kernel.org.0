Return-Path: <linux-arch+bounces-442-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1F17F76D7
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 15:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9511C211A4
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 14:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B557B2AF14;
	Fri, 24 Nov 2023 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AQyPYsMd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE5CD60;
	Fri, 24 Nov 2023 06:48:41 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOEROsH030664;
	Fri, 24 Nov 2023 14:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=WqQVGO5bjgS3k2Tjkuek+o1+AkyMRpQvZNxP1S5gEt8=;
 b=AQyPYsMdSBOlm0kTekR7Nuj5+AuQ5mDFFuP5SGhb6LXRv/61T7uG3BmwyBTF6tKKLE22
 VMIavvKoLNCdtYiW21YlmQAmRCuHRYiD5oX2KQlD+wfx9Ht8nKO3LX6SEtB3caMSCYbn
 TzrgdXzSplpQ/Jy+daCJ+zDy3Lp+OmQUtwhj1F7XX8/gSxJMaZw/o+8/q8gYjXJ1UwrS
 0pB+XNffWklFXiBRCoxFX9UEUjkuaX0h5qjx9CXI66Bla8LMi2xs1VBu1sqGC73WolRJ
 veuF1XtXJ7R3UxADzwYItOfzi26luBcgDPsv78El9WBvTzaJ+BIa+C+yInHAJHI36EQF FA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ujwkw0mtm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 14:48:26 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AOET0La002906;
	Fri, 24 Nov 2023 14:48:25 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ujwkw0mtc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 14:48:25 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOCIsGC027825;
	Fri, 24 Nov 2023 14:48:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf7ktph5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 14:48:24 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AOEmNds6947516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Nov 2023 14:48:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1107B20067;
	Fri, 24 Nov 2023 14:48:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C48A02005A;
	Fri, 24 Nov 2023 14:48:22 +0000 (GMT)
Received: from [9.152.212.236] (unknown [9.152.212.236])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Nov 2023 14:48:22 +0000 (GMT)
Message-ID: <14103e31e0c47c0594e7479126ce7fe34f2de467.camel@linux.ibm.com>
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
Date: Fri, 24 Nov 2023 15:48:22 +0100
In-Reply-To: <20231124142049.GF436702@nvidia.com>
References: <cover.1700766072.git.leon@kernel.org>
	 <c3ae87aea7660c3d266905c19d10d8de0f9fb779.1700766072.git.leon@kernel.org>
	 <c102bdef10b280f47f5fe4538eb168ac730d7644.camel@linux.ibm.com>
	 <20231124142049.GF436702@nvidia.com>
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
X-Proofpoint-GUID: yVvdn8pt5Jds8ImHQT3KGWGHYXQL3zCC
X-Proofpoint-ORIG-GUID: JQX0uRX_3M1hZ1FoS7wh4fKnkficpaOO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-24_01,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=879 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311240115

On Fri, 2023-11-24 at 10:20 -0400, Jason Gunthorpe wrote:
> On Fri, Nov 24, 2023 at 03:10:29PM +0100, Niklas Schnelle wrote:
> =20
> > What's the reasoning behind not using the existing memcpy_toio()
> > here?
>=20
> Going forward CPUs are implementing an instruction to do a 64 byte
> aligned store, this is a wrapper for exactly that operation.
>=20
> memcpy_toio() is much more general, it allows unaligned buffers and
> non-multiples of 64. Adapting the general version to generate the
> optimized version in the cases it can is complex and has a codegen
> penalty..

I think you misunderstood me. I understand why you want a separate
memcpy_toio_64(). I just wonder if its generic implementation shouldn't
just be a define or inline wrapper for memcpy_toio(addr, buffer, 64).

For s390 that would already result in a single PCI store block which
for us is much much better than 8 consecutive __raw_writeq(). Our
zpci_memcpy_toio() still has some extra code to ensure alignment and
break it up in supported sizes that we could get rid of with our own
memcpy_toio_64() of course. I suspect though that since it's all inline
functions the compiler seeing the constant 64 might already eliminate
some of the extra code.

Also seeing the second patch of course that would no longer really test
for write combining for us which we can also do but I think that's okay
and you're probably going to use memcpy_toio_64() in more places and
there we really want the PCI store block.

Thanks,
Niklas


