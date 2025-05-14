Return-Path: <linux-arch+bounces-11925-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F3CAB6F60
	for <lists+linux-arch@lfdr.de>; Wed, 14 May 2025 17:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1D03B5813
	for <lists+linux-arch@lfdr.de>; Wed, 14 May 2025 15:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66AC27A107;
	Wed, 14 May 2025 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EDeEF4IO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C01E278163;
	Wed, 14 May 2025 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235477; cv=none; b=iTfLaWXqNOvDtY17lT3hUHLSyNO4oMY7Pbq8qHN9pY5xkgQtei9Q457y1m7RE6rkiV7Hm54Ao+uqadNbxQp+NPouSciBsdus30bQCAOKCvdLrrB6+gNBK9XoSCiSc3/Inm+fyKMdfpGdc6mydpS0vlFaUeaoJ0n/pqSrTPN04Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235477; c=relaxed/simple;
	bh=ODl9UQqPd95AnZ5qIfWScfOTC8V1uuA2mDhjBIjFohc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e7FSjojR3VJwNHhm8hL6te1SKc2ETwRwySCgftDKCVTEJNYg2j/1io1mxY6tvBfqJdAxR4FI7DDGavXlxnqN7fZixddUzHayvFwDZb+aosRd/+DkdIuUIesePW/UDpMAXXIKo9RCszhGrIoUnZi/BOD+huJQ1ywDQyKX/mIdW9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EDeEF4IO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EEn9jI025341;
	Wed, 14 May 2025 15:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SGLS4m
	X8Cr6nBhXohVGb4hxEdStSi2AhSRa+lOkd6Rc=; b=EDeEF4IOYx2AE+f7lPQiyF
	IRyvtU0UyyfLRz/m/EGB2YPnrJj9LgYYnyKusAffnlttd89Nis4X+sz92EjzQjpd
	jwWTsThw+Y5GLOMoGOaVRMfV0OIZuKKtHGSOKF/3U3aCRx6MlSPpa8KnmJhef1VP
	aN0cNxncPfkE7KPekD8F3idZQdgoQUBsveGNHXvz7wwQbEnYCE8lqtt4iwtDXWi4
	CRAafK2tdRSH6gutURszp7nStU4k4ZayI86IjkNBuD7e4q5LDAL/8q+NRhvdodVD
	z0xzgPw0UIRz+jrbwxRGYTycmQN76r39KZq4wMWTuDGk5HgF+HaIttAexs8pYn9Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mbs6mygm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 15:09:21 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EF3ppg015552;
	Wed, 14 May 2025 15:09:20 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mbs6mygh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 15:09:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EDIrZ4026656;
	Wed, 14 May 2025 15:09:19 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpcun1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 15:09:19 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54EF9JUY61669786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 15:09:19 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3F885805D;
	Wed, 14 May 2025 15:09:18 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2A225805C;
	Wed, 14 May 2025 15:09:15 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.139.222])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 May 2025 15:09:15 +0000 (GMT)
Message-ID: <10ca077d6d51fac10e56c94db4205a482946d15f.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/9] ima: efi: Drop unnecessary check for
 CONFIG_MODULE_SIG/CONFIG_KEXEC_SIG
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
Date: Wed, 14 May 2025 11:09:15 -0400
In-Reply-To: <20250429-module-hashes-v3-2-00e9258def9e@weissschuh.net>
References: <20250429-module-hashes-v3-0-00e9258def9e@weissschuh.net>
	 <20250429-module-hashes-v3-2-00e9258def9e@weissschuh.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEzNSBTYWx0ZWRfXxHBh49BiMB+Z MOVdYBkj3WfGeCvyIQdcjIWtbvhdgBJDYmtH6aIKRjRnMJBKYgzpPmkHWOOqemh7EtoawfXuMN4 eKKgq7Ry6EeCtJw7jp7/S2fYItn19YaPW+hBVQRi+4t3a5UAZNQ5UPInke8w30g5b8se68ZT7Ax
 uyX1Mp5KfZEBF1+6kD3JyFEbD6Ba5ORKHBGX2UYN+mA+u9b5PNgiZ4CrEnefA6hvAWwSLzSGVz5 lfZsKkS3N4Z5aAyu4/uL9doUnd4OJRE2qSwiQt6qWZvzc77oDfFAmcU2G+ATyRKgE9IvpviTCgs UWQHCPNHhWFnBgTjcLgT6zGCCSV8LvhiQkuSOBWZC40lmYxl/++p50z0pqMJ3qtG/nPGT+SAqw5
 AgDBYLW1PLqYSYudLSRYQO3vcficUjVtjVwE+OfIpvmnKwF2qJ8sxjnazQ4TXbapLUyVp0K4
X-Proofpoint-ORIG-GUID: j22mpxTFY4WP2OwphhpcY-gxyz0D7Xyv
X-Authority-Analysis: v=2.4 cv=d5f1yQjE c=1 sm=1 tr=0 ts=6824b221 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VTue-mJiAAAA:8 a=GYJFTEJjVrNzjNUGXfAA:9 a=QEXdDO2ut3YA:10
 a=S9YjYK_EKPFYWS37g-LV:22
X-Proofpoint-GUID: DQ7JcpUJJQk_GINm-Q0_GETzDy7ehAm2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 clxscore=1011 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 impostorscore=0 adultscore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140135

On Tue, 2025-04-29 at 15:04 +0200, Thomas Wei=C3=9Fschuh wrote:
> When configuration settings are disabled the guarded functions are
> defined as empty stubs, so the check is unnecessary.
> The specific configuration option for set_module_sig_enforced() is
> about to change and removing the checks avoids some later churn.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>=20
> ---
> This patch is not strictly necessary right now, but makes looking for
> usages of CONFIG_MODULE_SIG easier.
> ---
> =C2=A0security/integrity/ima/ima_efi.c | 6 ++----
> =C2=A01 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/im=
a_efi.c
> index
> 138029bfcce1e40ef37700c15e30909f6e9b4f2d..a35dd166ad47beb4a7d46cc3e8fc604=
f57e03ecb
> 100644
> --- a/security/integrity/ima/ima_efi.c
> +++ b/security/integrity/ima/ima_efi.c
> @@ -68,10 +68,8 @@ static const char * const sb_arch_rules[] =3D {
> =C2=A0const char * const *arch_get_ima_policy(void)
> =C2=A0{
> =C2=A0	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot(=
)) {
> -		if (IS_ENABLED(CONFIG_MODULE_SIG))
> -			set_module_sig_enforced();
> -		if (IS_ENABLED(CONFIG_KEXEC_SIG))
> -			set_kexec_sig_enforced();
> +		set_module_sig_enforced();
> +		set_kexec_sig_enforced();
> =C2=A0		return sb_arch_rules;

Hi Thomas,

I'm just getting to looking at this patch set.  Sorry for the delay.

Testing whether CONFIG_MODULE_SIG and CONFIG_KEXEC_SIG are configured gives=
 priority
to them, rather than to the IMA support.  Without any other changes, both s=
ignature
verifications would be enforced.  Is that the intention?

Mimi

> =C2=A0	}
> =C2=A0	return NULL;
>=20


