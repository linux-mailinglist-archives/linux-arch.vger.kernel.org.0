Return-Path: <linux-arch+bounces-1404-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DEF83293D
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jan 2024 12:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6FFC287229
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jan 2024 11:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7544EB4B;
	Fri, 19 Jan 2024 11:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sc1Vpb/R"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD544C600;
	Fri, 19 Jan 2024 11:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705665170; cv=none; b=q6dNHNw8qdtL2Td0Mdrnz/RSIRpwiIrNT5ja+ayRBjxZEbbzvms5PgJ2herwiSWS765Abi4enRD9xwqWQgZ1teUrdiaD+Aas8/MRFyEHBQkNxn5u9olz3uzAooLuQ03luNud+uIaA4ESv1pSv/r7jSh+wO1hvngS/P5HKXhv/vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705665170; c=relaxed/simple;
	bh=Rt/U4LeEYbelRH6EwCkWjSLyEfhtCIGZFLcpiMjeHEc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VzGxoaq50YOuY+AVu+5CdNwD8ZzbcQPjO0aTIhV7UT2j2pEG5lkmuFmwGbLtDLl4gm3xtsjqNSGIpXcMLF93dQjOenkMP27MePVPxzyzgXcrLXWUmF1DK4Bb8Hi78H5hoakGOVA8+O8zih9ftWBgpuL+Sk8sLF2gcF3+ho8Q+/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sc1Vpb/R; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40JBbCl4015198;
	Fri, 19 Jan 2024 11:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Rt/U4LeEYbelRH6EwCkWjSLyEfhtCIGZFLcpiMjeHEc=;
 b=Sc1Vpb/R7TGUYisMZc7RPKesd/UZGB96K+viRPxAD+Yojlo4HFu93njZ7CMDPcX1NU4D
 KVqkX/AvpWnxMrIE7Jr9cVXlLSnlpFIYRDECE8FZRiYou4Z8enH3wyDOOjoQsuzRj1Al
 6hZD8Ci4vOnTCAd1hZniItFg2sJAkrvYkLPODmxlTmXUuHnLlBBAfedP1sF9/EB/Nu2/
 +tVZU9d4sqlj/zf0DSn6HP40HDeuInmcdmm6PpOmJkBYL4q5qKQvbaF6Gz27hTLT+yGW
 U6K7MHGCCAgvTtyvNreNvX+ZQ8p3MgCJXlbV/5OYyGjr3SXBT2M8PHDdoEgck6697sro Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vqrc50avs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 11:52:27 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40JBqBAi029441;
	Fri, 19 Jan 2024 11:52:27 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vqrc50aus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 11:52:27 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40JAVFuV011222;
	Fri, 19 Jan 2024 11:52:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm5801hpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 11:52:24 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40JBqMXs17433312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jan 2024 11:52:22 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F3E62004D;
	Fri, 19 Jan 2024 11:52:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7677C20040;
	Fri, 19 Jan 2024 11:52:21 +0000 (GMT)
Received: from [9.171.27.207] (unknown [9.171.27.207])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jan 2024 11:52:21 +0000 (GMT)
Message-ID: <b16b959a206a0cebb9b733b7f325e4343d8060ae.camel@linux.ibm.com>
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
Date: Fri, 19 Jan 2024 12:52:21 +0100
In-Reply-To: <96451909f0a9ac1eec71b81ee2db49ac66d9ced5.camel@linux.ibm.com>
References: <637dcc4d69c380bd939dfdd1b14a5c82c2ddfaa4.camel@linux.ibm.com>
	 <20231127175115.GC1165737@nvidia.com>
	 <002043477bba726f7dfb38573bf33990e38e3a51.camel@linux.ibm.com>
	 <20240116173330.GA980613@nvidia.com>
	 <ddd56db15bd2c87073a2f839e06cdb80d693272c.camel@linux.ibm.com>
	 <20240117132613.GH734935@nvidia.com> <20240117175518.GJ734935@nvidia.com>
	 <8e043042f425b4c574d1d3c3ed686253c8cd3517.camel@linux.ibm.com>
	 <20240118140039.GL734935@nvidia.com>
	 <071e2d2e301769d523dd613e77c6541a61bd496b.camel@linux.ibm.com>
	 <20240118162129.GO734935@nvidia.com>
	 <96451909f0a9ac1eec71b81ee2db49ac66d9ced5.camel@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=mQINBGHm3M8BEAC+MIQkfoPIAKdjjk84OSQ8erd2OICj98+GdhMQpIjHXn/RJdCZLa58k/ay5x0xIHkWzx1JJOm4Lki7WEzRbYDexQEJP0xUia0U+4Yg7PJL4Dg/W4Ho28dRBROoJjgJSLSHwc3/1pjpNlSaX/qg3ZM8+/EiSGc7uEPklLYu3gRGxcWV/944HdUyLcnjrZwCn2+gg9ncVJjsimS0ro/2wU2RPE4ju6NMBn5Go26sAj1owdYQQv9t0d71CmZS9Bh+2+cLjC7HvyTHKFxVGOznUL+j1a45VrVSXQ+nhTVjvgvXR84z10bOvLiwxJZ/00pwNi7uCdSYnZFLQ4S/JGMs4lhOiCGJhJ/9FR7JVw/1t1G9aUlqVp23AXwzbcoV2fxyE/CsVpHcyOWGDahGLcH7QeitN6cjltf9ymw2spBzpRnfFn80nVxgSYVG1dw75ksBAuQ/3e+oTQk4GAa2ShoNVsvR9GYn7rnsDN5pVILDhdPO3J2PGIXa5ipQnvwb3EHvPXyzakYtK50fBUPKk3XnkRwRYEbbPEB7YT+ccF/HioCryqDPWUivXF8qf6Jw5T1mhwukUV1i+QyJzJxGPh19/N2/GK7/yS5wrt0Lwxzevc5g+jX8RyjzywOZGHTVu9KIQiG8Pqx33UxZvykjaqTMjo7kaAdGEkrHZdVHqoPZwhCsgQARAQABtChOaWtsYXMgU2NobmVsbGUgPHNjaG5lbGxlQGxpbnV4LmlibS5jb20+iQJXBBMBCABBAhsBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAhkBFiEEnbAAstJ1IDCl9y3cr+Q/FejCYJAFAmWVooIFCQWP+TMACgkQr+Q/FejCYJCmLg/+OgZD6wTjooE77/ZHmW6Egb5nUH6DU+2nMHMHUupkE3dKuLcuzI4aEf/6wGG2xF/LigMRrbb1iKRVk/VG/swyLh/OBOTh8cJnhdmURnj3jhaef
	zslA1wTHcxeH4wMGJWVRAhOfDUpMMYV2J5XoroiA1+acSuppelmKAK5voVn9/fNtrVr6mgBXT5RUnmW60UUq5z6a1zTMOe8lofwHLVvyG9zMgv6Z9IQJc/oVnjR9PWYDUX4jqFL3yO6DDt5iIQCN8WKaodlNP61lFKAYujV8JY4Ln+IbMIV2h34cGpIJ7f76OYt2XR4RANbOd41+qvlYgpYSvIBDml/fT2vWEjmncm7zzpVyPtCZlijV3npsTVerGbh0Ts/xC6ERQrB+rkUqN/fx+dGnTT9I7FLUQFBhK2pIuD+U1K+A+EgwUiTyiGtyRMqz12RdWzerRmWFo5Mmi8N1jhZRTs0yAUn3MSCdRHP1Nu3SMk/0oE+pVeni3ysdJ69SlkCAZoaf1TMRdSlF71oT/fNgSnd90wkCHUK9pUJGRTUxgV9NjafZy7sx1Gz11s4QzJE6JBelClBUiF6QD4a+MzFh9TkUcpG0cPNsFfEGyxtGzuoeE86sL1tk3yO6ThJSLZyqFFLrZBIJvYK2UiD+6E7VWRW9y1OmPyyFBPBosOvmrkLlDtAtyfYInO0KU5pa2xhcyBTY2huZWxsZSA8bmlrbGFzLnNjaG5lbGxlQGlibS5jb20+iQJUBBMBCAA+AhsBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEnbAAstJ1IDCl9y3cr+Q/FejCYJAFAmWVoosFCQWP+TMACgkQr+Q/FejCYJB7oxAAksHYU+myhSZD0YSuYZl3oLDUEFP3fm9m6N9zgtiOg/GGI0jHc+Tt8qiQaLEtVeP/waWKgQnje/emHJOEDZTb0AdeXZk+T5/ydrKRLmYC6rPge3ue1yQUCiA+T72O3WfjZILI2yOstNwd1f0epQ32YaAvM+QbKDloJSmKhGWZlvdVUDXWkS6/maUtUwZpddFY8InXBxsYCbJsqiKF3kPVD515/6keIZmZh1cTIFQ+Kc+UZaz0MxkhiCyWC4
	cH6HZGKRfiXLhPlmmAyW9FiZK9pwDocTLemfgMR6QXOiB0uisdoFnjhXNfp6OHSy7w7LTIHzCsJoHk+vsyvSp+fxkjCXgFzGRQaJkoX33QZwQj1mxeWl594QUfR4DIZ2KERRNI0OMYjJVEtB5jQjnD/04qcTrSCpJ5ZPtiQ6Umsb1c9tBRIJnL7gIslo/OXBe/4q5yBCtCZOoD6d683XaMPGhi/F6+fnGvzsi6a9qDBgVvtarI8ybayhXDuS6/StR8qZKCyzZ/1CUofxGVIdgkseDhts0dZ4AYwRVCUFQULeRtyoT4dKfEot7hPE/4wjm9qZf2mDPRvJOqss6jObTNuw1YzGlpe9OvDYtGeEfHgcZqEmHbiMirwfGLaTG2xKDx4g2jd2zOcf83TCERFKJEhvZxB3tRiUQTd3dZ1TIaisv/o+y0K05pa2xhcyBTY2huZWxsZSA8bmlrbGFzLnNjaG5lbGxlQGdtYWlsLmNvbT6JAlQEEwEIAD4CGwEFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQSdsACy0nUgMKX3Ldyv5D8V6MJgkAUCZZWiiwUJBY/5MwAKCRCv5D8V6MJgkNVuEACo12niyoKhnXLQFtNaqxNZ+8p/MGA7g2XcVJ1bYMPoZ2Wh8zwX0sKX/dLlXVHIAeqelL5hIv6GoTykNqQGUN2Kqf0h/z7b85o3tHiqMAQV0dAB0y6qdIwdiB69SjpPNK5KKS1+AodLzosdIVKb+LiOyqUFKhLnablni1hiKlqYyDeD4k5hePeQdpFixf1YZclGZLFbKlF/A/0Q13USOHuAMYoA/iSgJQDMSUWkuC0mNxdhfVt/gVJnuKq+uKUghcHflhK+yodqezlxmmRxg6HrPVqRG4pZ6YNYO7YXuEWy9JiEH7MmFYcjNdgjn+kxx4IoYUO0MJ+DjLpVCV1QP1ZvMy8qQxScyEn7pMpQ0aW6zfJBsvoV3EHCR1emwKYO6rJOfvt
	u1rElGCTe3snsScV9Z1oXlvo8pVNH5a2SlnsuEBQe0RXNXNJ4RAls8VraGdNSHi4MxcsYEgAVHVaAdTLfJcXZNCIUcZejkOE+U2talW2n5sMvx+yURAEVsT/50whYcvomt0y81ImvCgUz4xN1axZ3PCjkgyhNiqLe+vzgexq7B2Kx2++hxIBDCKLUTn8JUAtQ1iGBZL9RuDrBy2rR7xbHcU2424iSbP0zmnpav5KUg4F1JVYG12vDCi5tq5lORCL28rjOQqE0aLHU1M1D2v51kjkmNuc2pgLDFzpvgLQhTmlrbGFzIFNjaG5lbGxlIDxuaWtzQGtlcm5lbC5vcmc+iQJUBBMBCAA+AhsBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEnbAAstJ1IDCl9y3cr+Q/FejCYJAFAmWVoosFCQWP+TMACgkQr+Q/FejCYJAglRAAihbDxiGLOWhJed5cFkOwdTZz6MyYgazbr+2sFrfAhX3hxPFoG4ogY/BzsjkN0cevWpSigb2I8Y1sQD7BFWJ2OjpEpVQd0Dsk5VbJBXEWIVDBQ4VMoACLUKgfrb0xiwMRg9C2h6KlwrPBlfgctfvrWWLBq7+oqx73CgxqTcGpfFytD87R4ovR9W1doZbh7pjsH5Ae9xX5PnQFHruib3y35zC8+tvSgvYWv3Eg/8H4QWlrjLHHy2AfZDVl9F5t5RfGL8NRsiTdVg9VFYg/GDdck9WPEgdO3L/qoq3Iuk0SZccGl+Nj8vtWYPKNlu2UvgYEbB8clUoWhg+SjjYQka7/p6tc+CCPZ8JUpkgkAdt7yXt6370wP1gct2VztS6SEGcmAE1qxtGhi5Kuln4ZJ/UO2yxhPHgoW99OuZw3IRHe0+mNR67JbIpSuFWDFNjZ0nckQcU1taSEUi0euWs7i4MEkm0NsOsVhbs4D2vMiC6kO/FqWOPmWZeAjyJw/KRUG4PaJAr5zJUx57nhKWgeTniW712n4DwC
	Uh77D/PHY0nqBTG/B+QQCR/FYGpTFkO4DRVfapT8njDrsWyVpP9o64VNZP42S+DuRGWfUKCMAXsM/wPzRiDEVfnZMcUR9vwLSHeoV7MiIFC0xIrp5ES9R00t4UFgqtGc36DV71qjR+66Im24OARh5t9QEgorBgEEAZdVAQUBAQdAwhTH11wigg1BVNqmlPAcneh8CthXnZZf70RNLR9fWloDAQgHiQI2BBgBCAAgFiEEnbAAstJ1IDCl9y3cr+Q/FejCYJAFAmHm31ACGwwACgkQr+Q/FejCYJAztg//fshsI9L9eCmLKUdZIc0XuFJcek0B9ydLp9jPIGUjBDLmkqxZ6NT1GWx9Ab3xTVg2Zs6IuP70UhvRqRV8g2XQdkHia5NMnTqfJEZWncjBr9pjfbZJRjvm7T2IVYiVnAqPf/LEoVgztgG8RvtQ/lPRwnE+zPJ3bEBcnl+W5fguRxHo/Mom3XGlQCif3oF3uydWAKRef4b3h8nZmn2EBzj6J7juwek9x7SkxKe8+Vavr5HTwEHOBTMrsUH7DCp27zJ8MU1XRpBAjkn2YEujRx2z2cPeNloFX6z5F7T4f+Ao2xxcXUEXeEBz8XL94DstXGI1IULTC2ui99B4NL0JfiCAWOf3mrosppdjzgM0X6g4pO8gVR1C09+rr/fbp6L8FflQu01kV1TZkAgSAUe58HlbP10I9Ush6nE7Z9Q5DR/T56DXh1o8sW4dBMu6AWan7mFRPwVQqL9zN5m8n87uNb/jiedvhBeb22TihHvbheEWB3WtfaQjdykETR80bm5T+ACcrwBpPvXkOFKovWJVEvvsUXynfFQYoFj5chNtH60zhvg/eHI9ZCweQgwvCqAJxESTZSEMbtxkklSl9OfnoBzPFFia1JwqazmUl0N5WzaLPW1P9KjDSt5YxMu0jdh2MAPaHdxFO/G8d0VS13FjIy/2QAni8Zf2CRlj1q4q5MJ0vXq4MwRh5t9wFgkrBgEEA
	dpHDwEBB0CdY+CSLBT98n1BaxlG+VeVzL3fQUYZDqybI14E6IH+JokCrQQYAQgAIBYhBJ2wALLSdSAwpfct3K/kPxXowmCQBQJh5t9wAhsCAIEJEK/kPxXowmCQdiAEGRYIAB0WIQSiikNOrnCUNbxSj4j7H22hwInkVgUCYebfcAAKCRD7H22hwInkVtg4AP0cl7yQX1JjOa92zkytZc7rwsjmSzvYExyRV0ilozmUNwEAifrmLVNjn+fST7LqkjWpSdFN3waHM9rw1d88SE0z1QqgCQ//YJOcAVYrR5KruzYjfh/FHiimFfvoOcanPS22uRhteBEALvV7LeCPjU5zi8/TKd8KZ9FmvYCaUf4IWzKIe51szZgnWPXdxF7Eyz5gVdM7ZaS35Dk9CCH3gtVU7iUorN95+pJ5elwUn6DAMdgFWswCBWuOm9zwq6Dj4KHTE4b4iWDenTNECqT+qwiS1bAHNbljXtoM68Uo1s3WDZPYcjqPlsoSjkpa7kz1z0NygE0zT3vHq8r7aFs+kq2sPVveTGhKhqZ82l7rSZpxssutpEdhChKbshD/44VaRLyXGhtQaOpWpFPdELAsJIB9BG39GrgP9K8TXG/5dXDzmC2Ku0ftyLa4ronM1LXG515bxQUPKFxaBYQonpdDWQVBu9bzQDmT8itP44hJWGDurDaPrYh5GYuetzIj8zgDxnh/wfwCpIepUxdZCV2NGYQiMjxuXEf/u7a2164U45rSsOCeKAG97f1GeQME3RsHV+d8lDOdjU+AfiWXqIhP32DVa5xElE3xQAd7+mUoAjYhP9OdM9e8j/UO6e4TmBMLYIMJh+joXan5eePJDYdY/NuRTqPjlZnOlA6JzbWOstXk/3GwFVOAO6YxNJl0m+EzGSOAYmIA3HuohrwPcVGi4CSbZF829CAMQQl0cXGjfI65pZFM8xcaB+lMgykEHrZ2uf6Y+Kkgdo24MwRh5t+CFgkrBgEEAdpHDwEBB0
	AF23/zeAYKTtphGMg29j9mNBKDoRQS9I3Zih5SNpJ3YokCNgQYAQgAIBYhBJ2wALLSdSAwpfct3K/kPxXowmCQBQJh5t+CAhsgAAoJEK/kPxXowmCQV4UP/3KpWKD6EUIO8DGnohGUpZkD0qHSWVXMu6RuCukZeAMDaWdVkMW6SSFswUT1xGoGc10hxPFiR1Sv448S1DgIz1sRgZKDcvFFlPhJH8PAJArv2gaaBBhUj3IN8XH58BJ/q9we8n/lJLDCs++0QeQJEoOG0O5IiP8wGHLPSWa9jXiej5SBMbTx+wQmQZc6NQdv7O9gB3j86IRv3Ly2tHuOQ3WEAUQZvy1dzQj+5WHVOU9F99P6OfkzU8QW0izPyB3uVfxJkNB+K78+Klj1L1HONCfBVGz8vly3U4bXtWm0JuIBty7x9a0TPrSGpghs+rPRw8miHgkEB6pWiJzDek6jQLPMyEtUDs7/vgQEPBlDwVHxPvLtqzyjn0v+9T9DEFQo3i2zWfpE9AI7CTf3qJeqHFATtVzNQnA8j2X94R8R3r9oxzSW/z17zuDV2XjmZTUJlOuw8e99FOop2CFUn49OcfA7qm8o2vaatPy4aYahsaptmTuMZ6InwZp/LI1GX7egQyExtte7y/X0HAbME5Wa6UpYgxt689xWFlh+VAOadZ6c7UDDu8KZis+3z6PAXYOJK5naEHpYbLdyBZEvtXWVoYVCA69h1X6289XUAjbm1h7OS6qz9m7+8kjpoakIFUt75M2KKCJ9a6yaOGjiLj5r1vQzNgV16lOPsb1Ywf8p2/ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: p-KB6q3zymEWtsOOTmhQYjIDYJeCRen_
X-Proofpoint-GUID: as3VKn3SFOc7GT1cyGh7TKojN1A1HKqi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_06,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401190058

On Thu, 2024-01-18 at 17:25 +0100, Niklas Schnelle wrote:
> On Thu, 2024-01-18 at 12:21 -0400, Jason Gunthorpe wrote:
> > On Thu, Jan 18, 2024 at 04:59:47PM +0100, Niklas Schnelle wrote:
> > > On Thu, 2024-01-18 at 10:00 -0400, Jason Gunthorpe wrote:
> > > > On Thu, Jan 18, 2024 at 02:46:40PM +0100, Niklas Schnelle wrote:
> > >=20
---8<---
> >=20
> >=20
> > > I did test your patches too and by accident confirmed again that thes=
e
> > > do need commit 80df7d6af7f6 ("s390/pci: fix max size calculation in
> > > zpci_memcpy_toio()") from the s390 feature branch to get the mlx5
> > > driver to detect Write-Combining as supported. Note, as far as I know
> > > Alexander Gordeev is targeting that one for v6.8-rc2 since we had qui=
te
> > > a few changes for v6.8-rc1.
> >=20
> > OK, but we can still run these two things in parallel?
> >=20
> > Jason
>=20
> Sure, it's not worse without my patch than what we had before and
> clearly __iowrite64_copy() has been completely broken for ages without
> anyone noticing and is fixed by your patches even without my fix for
> the too strict issue in that at least it then copies what it is
> supposed to copy even if it does so with 8*8 byte stores.
>=20
> Thanks,
> Niklas
>=20

FYI Alexander ended up doing a second v6.8-rc1 pull request and my
change has now landed in Linus' tree as commit 80df7d6af7f6 ("s390/pci:
fix max size calculation in zpci_memcpy_toio()").

Thanks,
Niklas

