Return-Path: <linux-arch+bounces-443-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14E97F76FB
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 15:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E255E1C21145
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 14:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3775B2D624;
	Fri, 24 Nov 2023 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PNc26pYu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7910BD72;
	Fri, 24 Nov 2023 06:54:51 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOEfkPu032140;
	Fri, 24 Nov 2023 14:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=wrtplODzTkg0s37TrASK47GrOZoTUBB2kH1oQhdC6Xs=;
 b=PNc26pYua2XmImV+7dCHw3o2aha6eEjyUNmlOm0+fExSanewNBD8a/SYLQuwL3py8Krm
 K2ZBhIXtq3LUAW1rxY8TUeXCOoafQ/QfPKIqkIlvDSNpNlp+7tKMCaT436sOewYVHVhZ
 hwa+m/BiMLWDTNdCqTan2caAY1APTZocSo72UaPkV+t17UZXJHup9x8Ewe7abfF2kweJ
 pM1ShXOMjF3pGDNIzc54Mkdpc58uXoxmgXnzmOuPahyNSImKxGANXTE59l3T+dJMlNqG
 ZPLK77EJJSyZeVlnLp9JRF2TRkLwOgbp9UuYakwTac2h92uHEtr96NLc9x9cmWvKHMlD Ug== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ujwfkgt9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 14:54:34 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AOEgVTI003397;
	Fri, 24 Nov 2023 14:54:33 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ujwfkgsvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 14:54:33 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOCIjaH015308;
	Fri, 24 Nov 2023 14:53:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf8006f9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 14:53:42 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AOErepZ46989594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Nov 2023 14:53:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 836AE20049;
	Fri, 24 Nov 2023 14:53:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B37520040;
	Fri, 24 Nov 2023 14:53:40 +0000 (GMT)
Received: from [9.152.212.236] (unknown [9.152.212.236])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Nov 2023 14:53:40 +0000 (GMT)
Message-ID: <f6ee7bce3ee8f670468937c32143a45ec1adf776.camel@linux.ibm.com>
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
Date: Fri, 24 Nov 2023 15:53:40 +0100
In-Reply-To: <14103e31e0c47c0594e7479126ce7fe34f2de467.camel@linux.ibm.com>
References: <cover.1700766072.git.leon@kernel.org>
	 <c3ae87aea7660c3d266905c19d10d8de0f9fb779.1700766072.git.leon@kernel.org>
	 <c102bdef10b280f47f5fe4538eb168ac730d7644.camel@linux.ibm.com>
	 <20231124142049.GF436702@nvidia.com>
	 <14103e31e0c47c0594e7479126ce7fe34f2de467.camel@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: dyiVLWTqTfZvw8fzzqfdJbF63FRN4yFS
X-Proofpoint-GUID: 3NcOEXeKGZljidjsCBPE8_11alwYUyHU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-24_01,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 spamscore=0 mlxlogscore=819 phishscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311240116

On Fri, 2023-11-24 at 15:48 +0100, Niklas Schnelle wrote:
> On Fri, 2023-11-24 at 10:20 -0400, Jason Gunthorpe wrote:
> > On Fri, Nov 24, 2023 at 03:10:29PM +0100, Niklas Schnelle wrote:
> > =20
---8<---
>=20
> Also seeing the second patch of course that would no longer really test
> for write combining for us which we can also do but I think that's okay
> and you're probably going to use memcpy_toio_64() in more places and
> there we really want the PCI store block.

Disregard this part I didn't properly align commit message and code. I
thought you replaced the check with memcpy_toio_64().

Thanks,
Niklas


