Return-Path: <linux-arch+bounces-513-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09B17FBF30
	for <lists+linux-arch@lfdr.de>; Tue, 28 Nov 2023 17:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC2852828B9
	for <lists+linux-arch@lfdr.de>; Tue, 28 Nov 2023 16:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAD549F65;
	Tue, 28 Nov 2023 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L9B36PfU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2ADFD51;
	Tue, 28 Nov 2023 08:29:02 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASGRmKO022842;
	Tue, 28 Nov 2023 16:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=v5tUjc7w7x68+zEuTzqQmhFsKGO6AZKfikkoXHbnbHo=;
 b=L9B36PfUGkfRryzE1WIAX6LaAKndsaRdl67ogsFzbWhtc9ZsOZanaIdlUgwbTLZqETRd
 eHjByrr72BmSVvhW2xLS0Qt/JHk9T5XqmXUhRZ0vZlNmxCQqMLW7zEghjgQ6cLMNjNQd
 RqmViHyEmcGv+z7/XTStkBiCdes7wBfa9wT+Tgt6vqROzYohi0TnXX+p5m0gJY7kqtzu
 WdmzkT6luoF6iLRVm3ppbQSx9EjhbbTeRue3nWkvAulb2KIiPYT/Vd8FQ0eAkqUOO3Aj
 lYF7OufxrrTlBBiNDh/nei9CkO0cCq2m00DmsG5VxFZIaCWnHgAvRDrtu1owCKDtMzDr 5g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unknq871e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 16:28:41 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ASGSeHf028034;
	Tue, 28 Nov 2023 16:28:40 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unknq86yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 16:28:40 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASG8Ap9028313;
	Tue, 28 Nov 2023 16:28:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukv8ngw6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 16:28:38 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ASGSa0P18678504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 16:28:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 782B92004B;
	Tue, 28 Nov 2023 16:28:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36CCF20043;
	Tue, 28 Nov 2023 16:28:36 +0000 (GMT)
Received: from [9.152.212.236] (unknown [9.152.212.236])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Nov 2023 16:28:36 +0000 (GMT)
Message-ID: <002043477bba726f7dfb38573bf33990e38e3a51.camel@linux.ibm.com>
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
Date: Tue, 28 Nov 2023 17:28:36 +0100
In-Reply-To: <20231127175115.GC1165737@nvidia.com>
References: <cover.1700766072.git.leon@kernel.org>
	 <c3ae87aea7660c3d266905c19d10d8de0f9fb779.1700766072.git.leon@kernel.org>
	 <c102bdef10b280f47f5fe4538eb168ac730d7644.camel@linux.ibm.com>
	 <20231124142049.GF436702@nvidia.com>
	 <14103e31e0c47c0594e7479126ce7fe34f2de467.camel@linux.ibm.com>
	 <20231124145529.GG436702@nvidia.com>
	 <b3250b9a9af2f29ee3d06830746fb6e8ac49271d.camel@linux.ibm.com>
	 <20231124160627.GH436702@nvidia.com>
	 <637dcc4d69c380bd939dfdd1b14a5c82c2ddfaa4.camel@linux.ibm.com>
	 <20231127175115.GC1165737@nvidia.com>
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
X-Proofpoint-GUID: m3GuGqo-WfsgSfsHxk8AUvi0qc6ugx63
X-Proofpoint-ORIG-GUID: 9gK5zH9ByTU6i2fZHiPVrOhbnpNNm5mL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_18,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 mlxlogscore=598 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280131

On Mon, 2023-11-27 at 13:51 -0400, Jason Gunthorpe wrote:
> On Mon, Nov 27, 2023 at 06:43:11PM +0100, Niklas Schnelle wrote:
>=20
> > Also it turns out the writeq() loop we had so far does not produce the
> > needed 64 byte TLP on s390 either so this actually makes us newly pass
> > this test.
>=20
> Ooh, that is a significant problem - the userspace code won't be used
> unless this test passes. So we need this on S390 to fix a bug as well
> :\
>=20
> Thanks,
> Jason
>=20

Yes ;-(

In the meantime I also found out that zpci_write_block(dst, src, 64) is
not correct for all cases because the PCI store block requires the
(pseudo-)MMIO write not to cross a 4K boundary and we need src/dst to
be double word aligned. In rdma-core this is neatly handled by the
get_max_write_size() but the kernel variant of that
zpci_get_max_write_size() isn't just a lot harder to read and likely
less efficient but also too strict thus breaking the 64 byte write up
needlessly.

In total we have 5 conditions for the PCI block stores:

1. The dst+len must not cross a 4K boundary in the (pseudo-)MMIO space
2. The length must not exceed the maximum write size
3. The length must be a multiple of 8
4. The src needs to be double word aligned
5. The dst needs to be double word aligned

So I think a good solution would be to improve zpci_memcpy_toio() with
an enhanced zpci_get_max_write_size() based on the code in rdma-core
extended to also handle the alignment and length restrictions which in
rdma-core are already assumed (see comment there).=C2=A0Then we can use
zpci_memcpy_toio(dst, src, 64) for memcpy_toio_64() and rely on the
compiler to optimize out the unnecessary checks (2, 3 and possibly 4,
5).

So yeah this is getting a bit more  complicated than originally
thought. Let me cook up a patch.

Thanks,
Niklas

