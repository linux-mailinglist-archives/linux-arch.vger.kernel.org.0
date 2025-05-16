Return-Path: <linux-arch+bounces-11981-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63453ABA291
	for <lists+linux-arch@lfdr.de>; Fri, 16 May 2025 20:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CBD07B9673
	for <lists+linux-arch@lfdr.de>; Fri, 16 May 2025 18:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F62247282;
	Fri, 16 May 2025 18:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fQcP9IM8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF7F2AEED;
	Fri, 16 May 2025 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747419067; cv=none; b=HnaAabWNjGfoiXPKDXVbVg+A+r89t4MXFdxV+WUADbQmnQHfNOwk8tOuLpcgJT915FfwRqqvAMDbfZAqkILg0Nb2gkBKfiNbbliQumXNwIMy7j1T/JvYn2AUj7kfoTaJG2GATbXrRHQ2zhlAgeWbrSlNbPO83dTEXCSo2CsVwxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747419067; c=relaxed/simple;
	bh=7WDsffkadeUUuhy0vWzf6lW/gdjRy6oTywyH2r1JMJ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tRl37bfNDskjbV/R02sw+njSdG1QU5veSsLPoY6DEY0kRjojXVFJkiuwB+DSrZpJ4d0yZoBLpBzqB8InsBOdqlMzVksEL5xUxaES9PMKgzt17gmEiL/dLQyltVpK/JpAxLcPlVb4ASIxdn5xZ5knk4m8/o3jQWx5RwSugqyA7Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fQcP9IM8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GE5HR2023915;
	Fri, 16 May 2025 18:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7WDsff
	kadeUUuhy0vWzf6lW/gdjRy6oTywyH2r1JMJ8=; b=fQcP9IM8VQbz46N5AoR5H0
	5VAuTb2xBCDJxR8gV7pP6tUihHDFVWUxr1e4MWZPG9Y+XeMmQ24snRSQVAMxsqtj
	n9Nw9AFtn1pHz6eSOBe35iW9ao4Gy5TIVYnfjcqsyY/Zyo3GrAepkovfBiDHasJu
	LhYiDPampN0+TVvfRsZBUzaA/0b18vwgmH0OCKNEsz7Use/QuKME6uJ2Z775AFf8
	V8u5AVf0kvqyADIXVq0i8timxb/4/6TTXCNSLpPzx+JM90z4+ct8Fy5yVcVL2doW
	pUHDd/36FpsGMFqtmXPJbQqcPNX4tY1TXOSWQY89dOWH8DQ6cOnJGe+VNnQYYJOQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nyytkekb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 18:09:34 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54GHu3TI018890;
	Fri, 16 May 2025 18:09:33 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nyytkek7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 18:09:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54GHPPwY021786;
	Fri, 16 May 2025 18:09:31 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfq0vdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 18:09:31 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54GI9VIY19989182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 18:09:31 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D00958051;
	Fri, 16 May 2025 18:09:31 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDCDE58060;
	Fri, 16 May 2025 18:09:28 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.87.94])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 May 2025 18:09:28 +0000 (GMT)
Message-ID: <ddaa84b8baf0e1ed8a3037abb0449f96a99450ec.camel@linux.ibm.com>
Subject: Re: [PATCH v3 0/9] module: Introduce hash-based integrity checking
From: Mimi Zohar <zohar@linux.ibm.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Masahiro
 Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Petr Pavlu
 <petr.pavlu@suse.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Daniel
 Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>,
        James
 Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jonathan
 Corbet <corbet@lwn.net>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael
 Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao
 <naveen@kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry
 Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg
 <eric.snowberg@oracle.com>,
        Nicolas Schier <nicolas.schier@linux.dev>
Cc: Fabian =?ISO-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>,
        Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>,
        kpcyrd <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>,
        =?ISO-8859-1?Q?C=E2ju?= Mihai-Drosi <mcaju95@gmail.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Date: Fri, 16 May 2025 14:09:28 -0400
In-Reply-To: <20250429-module-hashes-v3-0-00e9258def9e@weissschuh.net>
References: <20250429-module-hashes-v3-0-00e9258def9e@weissschuh.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JP_opKLtVXFXrDepXMXFr82Z71tDwcKZ
X-Proofpoint-ORIG-GUID: LSIXmeF4PPMgXkI58zDkLV8P9sqeLEXK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE3NyBTYWx0ZWRfXwS/eEj55lmwX CEZdkSomJY+LwB0UTMSc9BpM85C/G0NhM1CYfJKHPjyPA4+pvLoD4PfE2WG+Sx28YqmXfd2NdYf jpKMpIOrCFRNUCKM4iaCBIfeIOdoLrbOYs4iiAgTnQZa0Jw6hp0pRIG8ZFOSlYOV1Pw1GiJn7vH
 INcvZw8cCM/FYuDKgZhAYGHfzAVJBX80ue9UfPwtV0YbQhagKfnBGbuBSPkK/1m5M5Q8ChLxetE aZg2I0tyeH7lgL+mB9XZ5lR7HCpqdZz99uKc4pj8wL3ZS58OJR0UYg324ykc7sF5Z8SkX+QVeF4 ahhhVVTJHCgLgGbidgBDYdIDeH91LsCRIOAtOrlH38o/2VEqzNQmIPXOUXkn8/Uymye5lD1MsoX
 B/SPGzQXIydqPoriq4Vw9Sy+bx9kv34ZM7ewuT/1eg2zndCkVCEIY/hgewG2ywUHd7h3Khno
X-Authority-Analysis: v=2.4 cv=ZcMdNtVA c=1 sm=1 tr=0 ts=68277f5e cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=VTue-mJiAAAA:8 a=RvlH7QWmzk5iKMaHqTQA:9 a=QEXdDO2ut3YA:10
 a=S9YjYK_EKPFYWS37g-LV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 mlxscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160177

SGkgVGhvbWFzLAoKT24gVHVlLCAyMDI1LTA0LTI5IGF0IDE1OjA0ICswMjAwLCBUaG9tYXMgV2Vp
w59zY2h1aCB3cm90ZToKPiBUaGUgY3VycmVudCBzaWduYXR1cmUtYmFzZWQgbW9kdWxlIGludGVn
cml0eSBjaGVja2luZyBoYXMgc29tZSBkcmF3YmFja3MKPiBpbiBjb21iaW5hdGlvbiB3aXRoIHJl
cHJvZHVjaWJsZSBidWlsZHM6Cj4gRWl0aGVyIHRoZSBtb2R1bGUgc2lnbmluZyBrZXkgaXMgZ2Vu
ZXJhdGVkIGF0IGJ1aWxkIHRpbWUsIHdoaWNoIG1ha2VzCj4gdGhlIGJ1aWxkIHVucmVwcm9kdWNp
YmxlLCBvciBhIHN0YXRpYyBrZXkgaXMgdXNlZCwgd2hpY2ggcHJlY2x1ZGVzCj4gcmVidWlsZHMg
YnkgdGhpcmQgcGFydGllcyBhbmQgbWFrZXMgdGhlIHdob2xlIGJ1aWxkIGFuZCBwYWNrYWdpbmcK
PiBwcm9jZXNzIG11Y2ggbW9yZSBjb21wbGljYXRlZC4KPiBJbnRyb2R1Y2UgYSBuZXcgbWVjaGFu
aXNtIHRvIGVuc3VyZSBvbmx5IHdlbGwta25vd24gbW9kdWxlcyBhcmUgbG9hZGVkCj4gYnkgZW1i
ZWRkaW5nIGEgbGlzdCBvZiBoYXNoZXMgb2YgYWxsIG1vZHVsZXMgYnVpbHQgYXMgcGFydCBvZiB0
aGUgZnVsbAo+IGtlcm5lbCBidWlsZCBpbnRvIHZtbGludXguCgpGcm9tIGEgdmVyeSBoaWdoIGxl
dmVsLCBJIGxpa2UgdGhlIGlkZWEgb2YgaW5jbHVkaW5nIHRoZSBrZXJuZWwgbW9kdWxlIGhhc2hl
cwppbiB0aGUga2VybmVsIGltYWdlLCB3aGljaCBpcyBzaWduZWQsIGFuZCBmYWxsaW5nIGJhY2sg
dG8gdmVyaWZ5aW5nIG90aGVyCmtlcm5lbCBtb2R1bGVzIGJhc2VkIG9uIHNpZ25hdHVyZXMuCgpS
ZW1vdmluZyB0aGUgQ09ORklHX01PRFVMRV9TSUcgYW5kIENPTkZJR19LRVhFQ19TSUcgY2hlY2tz
IGluIHRoZSBmaXJzdCB0d28KcGF0Y2hlcyBpcyBjb3JyZWN0LMKgYXMgcHJldmlvdXNseSBtZW50
aW9uZWQuICBIb3dldmVyIHdpdGhvdXQgdGhlc2UgS2NvbmZpZ3MKYmVpbmcgZW5hYmxlZCwgdGhl
IElNQSBhcmNoIHNwZWNpZmljIHBvbGljeSBkZWZpbmVzIGFuZCBlbmZvcmNlcyBzaWduYXR1cmUK
dmVyaWZpY2F0aW9uIGJhc2VkIG9uIHRoZSBzaWduYXR1cmVzIHN0b3JlZCBpbiBzZWN1cml0eS5p
bWEuICBJIGRvdWJ0IHRoaXMgaXMKd2hhdCB3YXMgaW50ZW5kZWQuCgpDaGFuZ2VzIHdvdWxkIGJl
IG5lZWRlZCBpbiBpbWFfYXBwcmFpc2VfbWVhc3VyZW1lbnQoKS4gIEl0J3Mgbm90IGVub3VnaCB0
bwp0ZXN0IHdoZXRoZXIgdGhlIHBvbGljeSBwZXJtaXRzIGFwcGVuZGVkIHNpZ25hdHVyZXMgKG1v
ZHNpZyksIGJ1dCB0byBkZXRlY3QKd2hldGhlciBDT05GSUdfTU9EVUxFX1NJRyBpcyBlbmFibGVk
LiAgSW4gYWRkaXRpb24sIHNpbWlsYXIgc3VwcG9ydCB0bwp0cnlfbW9kc2lnLCBuZWVkcyB0byBi
ZSBhZGRlZCBmb3IgQ09ORklHX01PRFVMRV9IQVNIRVMuCgp0aGFua3MsCgpNaW1pCgo+IAo+IElu
dGVyZXN0IGhhcyBiZWVuIHByb2NsYWltZWQgYnkgTml4T1MsIEFyY2ggTGludXgsIFByb3htb3gs
IFNVU0UgYW5kIHRoZQo+IGdlbmVyYWwgcmVwcm9kdWNpYmxlIGJ1aWxkcyBjb21tdW5pdHkuCj4g
Cj4gVG8gcHJvcGVybHkgdGVzdCB0aGUgcmVwcm9kdWNpYmlsaXR5IGluIGNvbWJpbmF0aW9uIHdp
dGggQ09ORklHX0lORk9fQlRGCj4gYW5vdGhlciBwYXRjaCBvciBwYWhvbGUgdjEuMjkgaXMgbmVl
ZGVkOgo+ICJbUEFUQ0ggYnBmLW5leHRdIGtidWlsZCwgYnBmOiBFbmFibGUgcmVwcm9kdWNpYmxl
IEJURiBnZW5lcmF0aW9uIiBbMF0KPiAKPiBRdWVzdGlvbnMgZm9yIGN1cnJlbnQgcGF0Y2g6Cj4g
KiBOYW1pbmcKPiAqIENhbiB0aGUgbnVtYmVyIG9mIGJ1aWx0LWluIG1vZHVsZXMgYmUgcmV0cmll
dmVkIHdoaWxlIGJ1aWxkaW5nCj4gwqAga2VybmVsL21vZHVsZS9oYXNoZXMubz8gVGhpcyB3b3Vs
ZCByZW1vdmUgdGhlIG5lZWQgZm9yIHRoZQo+IMKgIHByZWFsbG9jYXRpb24gc3RlcCBpbiBsaW5r
LXZtbGludXguc2guCj4gKiBIb3cgc2hvdWxkIHRoaXMgaW50ZXJhY3Rpb24gd2l0aCBJTUE/Cj4g
Cj4gRnVydGhlciBpbXByb3ZlbWVudHM6Cj4gKiBVc2UgYSBMU00vSU1BIEtleXJpbmcgdG8gc3Rv
cmUgYW5kIHZhbGlkYXRlIGhhc2hlcwo+ICogVXNlIE1PRFVMRV9TSUdfSEFTSCBmb3IgY29uZmln
dXJhdGlvbgo+ICogVUFQSSBmb3IgZGlzY292ZXJ5Pwo+ICogQ3VycmVudGx5IGhhcyBhIHBlcm1h
bmVudCBtZW1vcnkgb3ZlcmhlYWQKPiAKPiBbMF0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
a21sLzIwMjQxMjExLXBhaG9sZS1yZXByb2R1Y2libGUtdjEtMS0yMmZlYWUxOWJhZDlAd2Vpc3Nz
Y2h1aC5uZXQvCj4gCj4gU2lnbmVkLW9mZi1ieTogVGhvbWFzIFdlacOfc2NodWggPGxpbnV4QHdl
aXNzc2NodWgubmV0Pgo+IC0tLQo+IENoYW5nZXMgaW4gdjM6Cj4gLSBSZWJhc2Ugb24gdjYuMTUt
cmMxCj4gLSBVc2Ugb3BlbnNzbCB0byBjYWxjdWxhdGUgaGFzaAo+IC0gQXZvaWQgd2FybmluZyBp
ZiBubyBtb2R1bGVzIGFyZSBidWlsdAo+IC0gU2ltcGxpZnkgbW9kdWxlX2ludGVncml0eV9jaGVj
aygpIGEgYml0Cj4gLSBNYWtlIGluY29tcGF0aWJpbGl0eSB3aXRoIElOU1RBTExfTU9EX1NUUklQ
IGV4cGxpY2l0Cj4gLSBVcGRhdGUgZG9jcwo+IC0gQWRkIElNQSBjbGVhbnVwcwo+IC0gTGluayB0
byB2MjoKPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwMTIwLW1vZHVsZS1oYXNoZXMt
djItMC1iYTExODRlMjdiN2ZAd2Vpc3NzY2h1aC5uZXQKPiAKPiBDaGFuZ2VzIGluIHYyOgo+IC0g
RHJvcCBSRkMgc3RhdGUKPiAtIE1lbnRpb24gaW50ZXJlc3RlZCBwYXJ0aWVzIGluIGNvdmVyIGxl
dHRlcgo+IC0gRXhwYW5kIEtjb25maWcgZGVzY3JpcHRpb24KPiAtIEFkZCBjb21wYXRpYmlsaXR5
IHdpdGggQ09ORklHX01PRFVMRV9TSUcKPiAtIFBhcmFsbGVsaXplIG1vZHVsZS1oYXNoZXMuc2gK
PiAtIFVwZGF0ZSBEb2N1bWVudGF0aW9uL2tidWlsZC9yZXByb2R1Y2libGUtYnVpbGRzLnJzdAo+
IC0gTGluayB0byB2MToKPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjQxMjI1LW1vZHVs
ZS1oYXNoZXMtdjEtMC1kNzEwY2U3YTNmZDFAd2Vpc3NzY2h1aC5uZXQKPiAKPiAtLS0KPiBUaG9t
YXMgV2Vpw59zY2h1aCAoOSk6Cj4gwqDCoMKgwqDCoCBwb3dlcnBjL2ltYTogRHJvcCB1bm5lY2Vz
c2FyeSBjaGVjayBmb3IgQ09ORklHX01PRFVMRV9TSUcKPiDCoMKgwqDCoMKgIGltYTogZWZpOiBE
cm9wIHVubmVjZXNzYXJ5IGNoZWNrIGZvcgo+IENPTkZJR19NT0RVTEVfU0lHL0NPTkZJR19LRVhF
Q19TSUcKPiDCoMKgwqDCoMKgIGtidWlsZDogYWRkIHN0YW1wIGZpbGUgZm9yIHZtbGludXggQlRG
IGRhdGEKPiDCoMKgwqDCoMKgIGtidWlsZDogZ2VuZXJhdGUgbW9kdWxlIEJURiBiYXNlZCBvbiB2
bWxpbnV4LnVuc3RyaXBwZWQKPiDCoMKgwqDCoMKgIG1vZHVsZTogTWFrZSBtb2R1bGUgbG9hZGlu
ZyBwb2xpY3kgdXNhYmxlIHdpdGhvdXQgTU9EVUxFX1NJRwo+IMKgwqDCoMKgwqAgbW9kdWxlOiBN
b3ZlIGludGVncml0eSBjaGVja3MgaW50byBkZWRpY2F0ZWQgZnVuY3Rpb24KPiDCoMKgwqDCoMKg
IG1vZHVsZTogTW92ZSBsb2NrZG93biBjaGVjayBpbnRvIGdlbmVyaWMgbW9kdWxlIGxvYWRlcgo+
IMKgwqDCoMKgwqAgbG9ja2Rvd246IE1ha2UgdGhlIHJlbGF0aW9uc2hpcCB0byBNT0RVTEVfU0lH
IGEgZGVwZW5kZW5jeQo+IMKgwqDCoMKgwqAgbW9kdWxlOiBJbnRyb2R1Y2UgaGFzaC1iYXNlZCBp
bnRlZ3JpdHkgY2hlY2tpbmcKPiAKPiDCoC5naXRpZ25vcmXCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMSArCj4g
wqBEb2N1bWVudGF0aW9uL2tidWlsZC9yZXByb2R1Y2libGUtYnVpbGRzLnJzdCB8wqAgNSArKy0K
PiDCoE1ha2VmaWxlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA4ICsrKy0KPiDCoGFyY2gvcG93ZXJwYy9r
ZXJuZWwvaW1hX2FyY2guY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDMgKy0KPiDC
oGluY2x1ZGUvYXNtLWdlbmVyaWMvdm1saW51eC5sZHMuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fCAxMSArKysrKysKPiDCoGluY2x1ZGUvbGludXgvbW9kdWxlLmjCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgOCArKy0tCj4gwqBpbmNsdWRlL2xpbnV4L21v
ZHVsZV9oYXNoZXMuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE3ICsrKysrKysr
Kwo+IMKga2VybmVsL21vZHVsZS9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8IDIxICsrKysrKysrKystCj4gwqBrZXJuZWwvbW9kdWxlL01ha2Vm
aWxlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKwo+
IMKga2VybmVsL21vZHVsZS9oYXNoZXMuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHwgNTYKPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gwqBrZXJu
ZWwvbW9kdWxlL2ludGVybmFsLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoCA4ICstLS0KPiDCoGtlcm5lbC9tb2R1bGUvbWFpbi5jwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNTEgKysrKysrKysrKysrKysrKysrKysr
Ky0tLQo+IMKga2VybmVsL21vZHVsZS9zaWduaW5nLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfCAyNCArLS0tLS0tLS0tLS0KPiDCoHNjcmlwdHMvTWFrZWZpbGUu
bW9kZmluYWzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE4ICsrKysr
Ky0tLQo+IMKgc2NyaXB0cy9NYWtlZmlsZS5tb2RpbnN0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqAgNCArKwo+IMKgc2NyaXB0cy9NYWtlZmlsZS52bWxpbnV4wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNSArKysKPiDCoHNjcmlw
dHMvbGluay12bWxpbnV4LnNowqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHwgMzEgKysrKysrKysrKysrKystCj4gwqBzY3JpcHRzL21vZHVsZS1oYXNoZXMuc2jCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjYgKysrKysrKysrKysrKwo+
IMKgc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfZWZpLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgIDYgKy0tCj4gwqBzZWN1cml0eS9sb2NrZG93bi9LY29uZmlnwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIgKy0KPiDCoDIwIGZpbGVzIGNoYW5nZWQsIDI1
MCBpbnNlcnRpb25zKCspLCA1NiBkZWxldGlvbnMoLSkKPiAtLS0KPiBiYXNlLWNvbW1pdDogMGFm
MmY2YmUxYjQyODEzODViNjE4Y2I4NmFkOTQ2ZWRlZDA4OWFjOAo+IGNoYW5nZS1pZDogMjAyNDEy
MjUtbW9kdWxlLWhhc2hlcy03YTUwYTdjYzJhMzAKPiAKPiBCZXN0IHJlZ2FyZHMsCgo=


