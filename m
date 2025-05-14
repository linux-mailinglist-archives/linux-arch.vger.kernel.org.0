Return-Path: <linux-arch+bounces-11928-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E830CAB72FF
	for <lists+linux-arch@lfdr.de>; Wed, 14 May 2025 19:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559E7173EB1
	for <lists+linux-arch@lfdr.de>; Wed, 14 May 2025 17:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B302820D1;
	Wed, 14 May 2025 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a3sLf5q9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4FE28151A;
	Wed, 14 May 2025 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747244375; cv=none; b=fjQOSag6l1GKXsJdM2GfHQ3++soUCY2XnyKq4ldVBrcyhX4M0wrBxkywBxFDgO9o5ZYYbijEGsk3MVvLN1ung8cben/S/8VkW0dkDBX53a9e52T/qx5zPoYYc9aSPB5+VZfuVZW5/cfO16GhfVfhtv4p6lzKcqc//CKO2SE9NR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747244375; c=relaxed/simple;
	bh=cSLxshIeNr+V/+u5rK75CUAgh5kaX3jKR2fw3mz1P70=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cE+ypBouNpEhThlsb/SrVCASfAxbLcZXDDDaNO95a1iXFSHmYfQqyQU1dkvayBZoKqISAPNcDoqgRnh8Hcdh0M6xIXDGBkPHtdf+xp6a1928ZiFWe9WAeqkmdUAE82xgxIIcQj6CdiT14LcWEwMglxQ1Gaa+t4cmqH35NcCS8jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a3sLf5q9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGNoGp017016;
	Wed, 14 May 2025 17:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OhYFTK
	3Y8z/4xazu3XKdTqh8g1BwjMNXvG+8F5JF5lY=; b=a3sLf5q95rLq+ogvCQJGZX
	V2yY+OSkcxJPwWlGLm5m+YbRqDyBCHDuKaJVszSbyc6wBgriio9qhcS8jZL2kmpm
	Wt4GZx+6jyOB5ckxK023vjDNAOCrH9Qi1jhunvuv1GZoIrmF8NkPqaIvsKPNtKt6
	4hgT1Iv7BiUX4NQbm2Gd9ZUtJ6/alASi/l3hSrJm8hGMWRzCT58Ss5nfVjHM8Kb8
	Aq+p5zH55xzrkCg7OLiv6NLv6BxdnZLp6mjSsBqNtkqxVdTmfyAGiN3UmAdMbp6K
	DM/3Caw67cLgGwwlDPxkdaL+pvtp/ntrzw506jlQg3dF0R5Xe+sq5+5xXnYcX5Lg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mbq8nxys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 17:37:55 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EHbtLg031046;
	Wed, 14 May 2025 17:37:55 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mbq8nxyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 17:37:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGaGqc019883;
	Wed, 14 May 2025 17:37:53 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfrnhv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 17:37:53 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54EHbrIw26608194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 17:37:53 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 716EB58055;
	Wed, 14 May 2025 17:37:53 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C906C58043;
	Wed, 14 May 2025 17:37:51 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 May 2025 17:37:51 +0000 (GMT)
Message-ID: <edeb23e7884e94006d560898b7f9d2dd257a275e.camel@linux.ibm.com>
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
Date: Wed, 14 May 2025 13:37:51 -0400
In-Reply-To: <10ca077d6d51fac10e56c94db4205a482946d15f.camel@linux.ibm.com>
References: <20250429-module-hashes-v3-0-00e9258def9e@weissschuh.net>
	 <20250429-module-hashes-v3-2-00e9258def9e@weissschuh.net>
	 <10ca077d6d51fac10e56c94db4205a482946d15f.camel@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: RPOjhr87gRyfajPTapmF9ThaYjREaKWR
X-Authority-Analysis: v=2.4 cv=GrRC+l1C c=1 sm=1 tr=0 ts=6824d4f4 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VTue-mJiAAAA:8 a=VnNF1IyMAAAA:8 a=cvE8ob5KMqMXAi4NVQcA:9 a=QEXdDO2ut3YA:10
 a=S9YjYK_EKPFYWS37g-LV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE1OSBTYWx0ZWRfXw38stgEBAl0t 92v/U+3cUWiDo2+zByc4gM0wk3jePfyswMAaKF8sD4OxddTZs4UE+NB2VcDeYErV+mi7iXDLJvh jytWmpJowyB3HAFvoC/P87zqtuhU4ohvwApvR4JcscvN5E9rFDkFyfB3MP21mi3Zb3l+g+pWZQ5
 /zisZSh5IrT0P2FTctMhkdbGJ+vk/ngQWR21ZkgpICCF4flVjz33Zf7h1seH2KutvMUEHN3jFoN qHhzfy21Le9jr+tImfrJxzgiHGbORUqwHkT3WM+yq8fA3vvdM8IpHWRhsKpfgfdpjELXgFLQIs6 IT8J9qyUx1t9E14ZCdCK7Cxb9XNiDRPETyybcLAf7J3irr/+jfvhA770zoy0OcXw3arFlBdT6iP
 uQgkQZKJLprO24T3AJbCT8A8FRFqOLmv6LIX4yNw5rmj3w8Rk4AvjRlvWa145C4lQPlIu3+5
X-Proofpoint-GUID: DzVVxD_mhRAfjC9jgp_93CXh0t-Hz9hv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140159

On Wed, 2025-05-14 at 11:09 -0400, Mimi Zohar wrote:
> On Tue, 2025-04-29 at 15:04 +0200, Thomas Wei=C3=9Fschuh wrote:
> > When configuration settings are disabled the guarded functions are
> > defined as empty stubs, so the check is unnecessary.
> > The specific configuration option for set_module_sig_enforced() is
> > about to change and removing the checks avoids some later churn.
> >=20
> > Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> >=20
> > ---
> > This patch is not strictly necessary right now, but makes looking for
> > usages of CONFIG_MODULE_SIG easier.
> > ---
> > =C2=A0security/integrity/ima/ima_efi.c | 6 ++----
> > =C2=A01 file changed, 2 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/=
ima_efi.c
> > index
> > 138029bfcce1e40ef37700c15e30909f6e9b4f2d..a35dd166ad47beb4a7d46cc3e8fc6=
04f57e03ecb
> > 100644
> > --- a/security/integrity/ima/ima_efi.c
> > +++ b/security/integrity/ima/ima_efi.c
> > @@ -68,10 +68,8 @@ static const char * const sb_arch_rules[] =3D {
> > =C2=A0const char * const *arch_get_ima_policy(void)
> > =C2=A0{
> > =C2=A0	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboo=
t()) {
> > -		if (IS_ENABLED(CONFIG_MODULE_SIG))
> > -			set_module_sig_enforced();
> > -		if (IS_ENABLED(CONFIG_KEXEC_SIG))
> > -			set_kexec_sig_enforced();
> > +		set_module_sig_enforced();
> > +		set_kexec_sig_enforced();
> > =C2=A0		return sb_arch_rules;
>=20
> Hi Thomas,
>=20
> I'm just getting to looking at this patch set.=C2=A0 Sorry for the delay.
>=20
> Testing whether CONFIG_MODULE_SIG and CONFIG_KEXEC_SIG are configured giv=
es priority
> to them, rather than to the IMA support.=C2=A0 Without any other changes,=
 both signature
> verifications would be enforced.=C2=A0 Is that the intention?

Never mind, got it.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

