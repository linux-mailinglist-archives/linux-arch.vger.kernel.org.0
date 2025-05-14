Return-Path: <linux-arch+bounces-11932-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C42AB780D
	for <lists+linux-arch@lfdr.de>; Wed, 14 May 2025 23:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C33C3B9D9D
	for <lists+linux-arch@lfdr.de>; Wed, 14 May 2025 21:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D1F215075;
	Wed, 14 May 2025 21:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qnFQzg7H"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9149761FF2;
	Wed, 14 May 2025 21:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747258641; cv=none; b=QLseGd0vF+anYwHtCMSStRy+4lTGE2lMWZ0HcK8cCFlrixP3auShjh2lqy6pII28fAH1/BgjlwSyWdo+hk/HHhfsu7k3pqYS/89/9H24rkbAPoZHARftqHUkyXRcEQDwj32kQBeCnKKC4lpvh1L4YiI/eEjcYcrXZBj7qwlLR0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747258641; c=relaxed/simple;
	bh=xRFOVzuv9WFmt0OA/lEjVrkz1nJAEAvQhv3PjcQUuUc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d49vKWuOw+R2sGHETNeaenFjPz2iy7fuEjEVmbT9MwY4Csvfo2uKNSQVP+iCC3MeHCmRBcXiDrhQ1sWdZ3yheGDrGaFh9aHE8JVTGfpIr/681wbAyct4kjfRk3o6gbevnh7jshZelE+ABBhvhbgk/w23GjKVFBeUf8YMMohKhgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qnFQzg7H; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EIsOfN012674;
	Wed, 14 May 2025 21:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xRFOVz
	uv9WFmt0OA/lEjVrkz1nJAEAvQhv3PjcQUuUc=; b=qnFQzg7HUiK+nls3CnYth2
	E65MbfXC4F7eIKUnxhjoxc2QNG9QskMUZofNp9wV+dyFBlM1N43/gSxtAzLB0Umu
	NwiYVLio++qMzar+i3Ay/xz8ctDRy8AIHNwwVJG28mSDJbDOUVdCQ27ye5kXkNi4
	thdVHNtQk5c18yvGFni8gUH09/BXB0OtwYP5SsqO3ta8KmaHcinJZVpQByhuKy/P
	3lZnAHqiX6jyl2QKQASRr/PPH2oh8KQkkUtIvOvzRZkuGMr98zXAbQZzK2tloR+f
	1YE7YOrtytMi9/L37H35fcyImDjfqX4bZo45VQ8BTE/WrHe2G7dy8WDnQa0art+g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6gsv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 21:36:25 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54ELaOks014072;
	Wed, 14 May 2025 21:36:25 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6gsv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 21:36:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EJbtR5024288;
	Wed, 14 May 2025 21:36:23 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfs6ppb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 21:36:23 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54ELaM1A28508780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 21:36:23 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A87175805A;
	Wed, 14 May 2025 21:36:22 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00EAC5805C;
	Wed, 14 May 2025 21:36:20 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 May 2025 21:36:19 +0000 (GMT)
Message-ID: <3bc7c90c620d46378978f30e03cf8375dc0cbc42.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/9] ima: efi: Drop unnecessary check for
 CONFIG_MODULE_SIG/CONFIG_KEXEC_SIG
From: Mimi Zohar <zohar@linux.ibm.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor
 <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Luis Chamberlain
 <mcgrof@kernel.org>,
        Petr Pavlu <petr.pavlu@suse.com>,
        Sami Tolvanen
 <samitolvanen@google.com>,
        Daniel Gomez <da.gomez@samsung.com>, Paul Moore
 <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"
 <serge@hallyn.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Madhavan Srinivasan
 <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas
 Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg
 <eric.snowberg@oracle.com>,
        Nicolas Schier <nicolas.schier@linux.dev>,
        Fabian =?ISO-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>,
        Arnout
 Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>,
        kpcyrd
 <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>,
        =?ISO-8859-1?Q?C=E2ju?= Mihai-Drosi <mcaju95@gmail.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Date: Wed, 14 May 2025 17:36:19 -0400
In-Reply-To: <17aaa56b-5ee7-4a7f-a3c1-206e2114645d@weissschuh.net>
References: <20250429-module-hashes-v3-0-00e9258def9e@weissschuh.net>
	 <20250429-module-hashes-v3-2-00e9258def9e@weissschuh.net>
	 <10ca077d6d51fac10e56c94db4205a482946d15f.camel@linux.ibm.com>
	 <edeb23e7884e94006d560898b7f9d2dd257a275e.camel@linux.ibm.com>
	 <17aaa56b-5ee7-4a7f-a3c1-206e2114645d@weissschuh.net>
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
X-Authority-Analysis: v=2.4 cv=IqAecK/g c=1 sm=1 tr=0 ts=68250cd9 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=VTue-mJiAAAA:8 a=KLImt8Xm0npdB1J_YwkA:9 a=QEXdDO2ut3YA:10
 a=S9YjYK_EKPFYWS37g-LV:22
X-Proofpoint-ORIG-GUID: f5XBtQh4mBIUFD0svQ8WZ4natbLj1BXZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDIwMSBTYWx0ZWRfX0J/q+sNmdfdm i1ZHU47UsEXxhb9YRuiVfLyTUlkU8TH00xq7HIG19po+fL1JGIpvZjM/uX6q5+4t0NPh5dp4k4A uN7188bKesc49xrTc6GBTy7lOMs+ZNjaWji652m5L6f1AxxoZd/vEoWK+Kuo+ncsW4y8DHTRM7p
 R6fGlTFx5BEJHKJnQaF5K8E1e00WUGwmeibIplYY4v8jFk1SvdHod2h8Nvl+2aCydTecEoo+n2L vSxA3VNRMDV35wrChVwg5zFikRo5P7f2GYU6VboeHo7mguezLscbb4UFmlb2+dU11GdR62pNfTH EqfQwq6lweOyKgkbd7Vp1A4adwXhKyw8C6BaU4Dd+SyySDBKc9yjiTWTRQqlZ+cUd2MW2Iv5eSZ
 CLMdhE4i1h3uz8OTg/w+xX0bvEzrampxKZGJR0T8KnUmpNAA9Aq1CKvRJUMlTq/5jsMGFxqX
X-Proofpoint-GUID: mwVJ5c7YLe1v2I9fxeVNmrltNyZdPkRw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140201

On Wed, 2025-05-14 at 20:25 +0200, Thomas Wei=C3=9Fschuh wrote:
> May 14, 2025 19:39:37 Mimi Zohar <zohar@linux.ibm.com>:
>=20
> > On Wed, 2025-05-14 at 11:09 -0400, Mimi Zohar wrote:
> > > On Tue, 2025-04-29 at 15:04 +0200, Thomas Wei=C3=9Fschuh wrote:
> > > > When configuration settings are disabled the guarded functions are
> > > > defined as empty stubs, so the check is unnecessary.
> > > > The specific configuration option for set_module_sig_enforced() is
> > > > about to change and removing the checks avoids some later churn.
> > > >=20
> > > > Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> > > >=20
> > > > ---
> > > > This patch is not strictly necessary right now, but makes looking f=
or
> > > > usages of CONFIG_MODULE_SIG easier.
> > > > ---
> > > > =C2=A0security/integrity/ima/ima_efi.c | 6 ++----
> > > > =C2=A01 file changed, 2 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/=
ima/ima_efi.c
> > > > index
> > > > 138029bfcce1e40ef37700c15e30909f6e9b4f2d..a35dd166ad47beb4a7d46cc3e=
8fc604f57e03ecb
> > > > 100644
> > > > --- a/security/integrity/ima/ima_efi.c
> > > > +++ b/security/integrity/ima/ima_efi.c
> > > > @@ -68,10 +68,8 @@ static const char * const sb_arch_rules[] =3D {
> > > > =C2=A0const char * const *arch_get_ima_policy(void)
> > > > =C2=A0{
> > > > =C2=A0=C2=A0=C2=A0 if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_i=
ma_get_secureboot()) {
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ENABLED(CONFIG_MODULE_=
SIG))
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_m=
odule_sig_enforced();
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ENABLED(CONFIG_KEXEC_S=
IG))
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_k=
exec_sig_enforced();
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_module_sig_enforced();
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_kexec_sig_enforced();
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return sb_arch_rules;
> > >=20
> > > Hi Thomas,
> > >=20
> > > I'm just getting to looking at this patch set.=C2=A0 Sorry for the de=
lay.
> > >=20
> > > Testing whether CONFIG_MODULE_SIG and CONFIG_KEXEC_SIG are configured=
 gives priority
> > > to them, rather than to the IMA support.=C2=A0 Without any other chan=
ges, both signature
> > > verifications would be enforced.=C2=A0 Is that the intention?
> >=20
> > Never mind, got it.
> >=20
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>=20
> Thanks for the review!
>=20
> Given that this series has no chance
> of getting into the next merge window,
> would it be possible to take the two IMA preparation patches
> through the IMA tree to have them out of the way?

I'm fine with picking up the two patches simply as code cleanup, meaning dr=
opping the last
sentence of the patch description, after some testing.

Mimi



