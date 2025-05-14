Return-Path: <linux-arch+bounces-11927-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9525AAB72F1
	for <lists+linux-arch@lfdr.de>; Wed, 14 May 2025 19:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2CB166DA1
	for <lists+linux-arch@lfdr.de>; Wed, 14 May 2025 17:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCA027FB04;
	Wed, 14 May 2025 17:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lz/8+h5Z"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A034A18DB37;
	Wed, 14 May 2025 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747244336; cv=none; b=nVzZyCmRpe83/Jce8ASmeq/OjgPKPRv/7ls6Z+Pljb1lSaYhv0+AEISChlJorAXDGKtJ5pdXtH2nSIT2USvDbYX+CIU2RNMEnDObot/ObA7eq1GFoVsq5/vPw5sH77Pdp634YNRrtnoO8f52ZrKtQ7Z3qNdNro9SwmoyXaby+Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747244336; c=relaxed/simple;
	bh=v9K/F5U26+lIsCu6HLA7A0rXsq0nCQ04K4GLMq/Lcek=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pRo3757WDgXu1lZ0KlVlZPJOSguI2tc1jTWuRr62rd3bpmzrAh2yqggMih8QPW/EDmg/NCLRa+mH4eSLsPGlJTiBOYdd426DwtGofi7PSTRduxgpjxQa43d+mJL8UXbAyF5xlzCm9kEDbTJvG0yb7X6xpUZLsXl9vNRDNd3PF+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lz/8+h5Z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EDn70a003599;
	Wed, 14 May 2025 17:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YLp6nw
	iSYTaLn4gwyUaR76LVzvg2bQ+LKZ+ZUZSAhbw=; b=lz/8+h5ZS/4qnk4Sa6Z+b8
	5OwsvoRHY0Y4QSiiG4Xq2WKOQmbywFlBScJ4Fwwz19ZAFl/7Z6LNrxmiV95TIuI7
	8jPQ3r2kJUyD58SJh+6paS1kULt2v8dGQaZcHrttL/J0d9gyK5xIhpqHbjAmBo6y
	YCKe/jMgoNa5uVZbihSpA9PZ2sUYo9Hs47WRZ69tXp+J48Bl0ZC0F6ttamy/uALf
	hUMhXvlRosCE10yDZ8H0EYh0sTVsmlzPMV1AMxAwdFY54jK03ivAFph7BwYpo3GE
	oHGQYoxOAVq+XSwQz+lG2yixUNrAxM0kESy82w6enNLCE7RHiI+uGMNRxVjutF7w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mvd39933-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 17:38:03 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EHXqgI011794;
	Wed, 14 May 2025 17:38:02 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mvd3992y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 17:38:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGShFt019386;
	Wed, 14 May 2025 17:38:01 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfrnhvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 17:38:01 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54EHc19A18088606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 17:38:01 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B03758054;
	Wed, 14 May 2025 17:38:01 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35EA858045;
	Wed, 14 May 2025 17:37:58 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 May 2025 17:37:58 +0000 (GMT)
Message-ID: <7d139d9cff2bd754ba6309b4e57d54a250d472f9.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/9] powerpc/ima: Drop unnecessary check for
 CONFIG_MODULE_SIG
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
Date: Wed, 14 May 2025 13:37:57 -0400
In-Reply-To: <20250429-module-hashes-v3-1-00e9258def9e@weissschuh.net>
References: <20250429-module-hashes-v3-0-00e9258def9e@weissschuh.net>
	 <20250429-module-hashes-v3-1-00e9258def9e@weissschuh.net>
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
X-Proofpoint-GUID: L7rNBy0TmhzC5nBoTVmlcmr1Q26qCuoG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE1OSBTYWx0ZWRfX6BAa4u6zF8K2 CbYh56fWxSGnHzpsMohJh5FctlOxLTyBue2f6YaMAsm3MzbGP2DQvR1uonB6ztmb0ESc/CxOB68 /9Ak+GiWpBYYsW5fG97kytt0EIYkQ0mwH6DDdrvZlKGOf4mop/CEYJUUMefLK/njeewzc7GO0mD
 9Lax94g3MZMmN9ZgWc9iHrUnr7ccwDcppEcu0h21uyqjbFDR7D1sTPNwd2ol5eBjo7lTg+V/mCY YNaYnJ92OtEW+0n4NjT6+neT0myTdLplBG1UOvr/Z4y1m5xBIr9PGoNA3gou7Kb972jb2COAH3E DBNGxPxwJSr2O4GuSsvuEvBt5VK9XfKOhRgscpBxh0CmLRJSG2cCGeV2miBWP4Z55bj9UqFGep4
 zPtEfWs4JVeIUk5wn0LcGMFK9biirA8Xucwacq/xff//YyuBo/KZGDPdtSjVu2zMWsVEJIb5
X-Proofpoint-ORIG-GUID: oU69WTXTNdjq_Hm2Csmrq282v-IE3FTv
X-Authority-Analysis: v=2.4 cv=GbEXnRXL c=1 sm=1 tr=0 ts=6824d4fb cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VTue-mJiAAAA:8 a=VnNF1IyMAAAA:8 a=uS6L9oXRRqgcvYQvzncA:9 a=QEXdDO2ut3YA:10
 a=S9YjYK_EKPFYWS37g-LV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140159

On Tue, 2025-04-29 at 15:04 +0200, Thomas Wei=C3=9Fschuh wrote:
> When CONFIG_MODULE_SIG is disabled set_module_sig_enforced() is defined
> as an empty stub, so the check is unnecessary.
> The specific configuration option for set_module_sig_enforced() is
> about to change and removing the check avoids some later churn.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>=20
> ---
> This patch is not strictly necessary right now, but makes looking for
> usages of CONFIG_MODULE_SIG easier.
> ---
> =C2=A0arch/powerpc/kernel/ima_arch.c | 3 +--
> =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/ima_arch.c b/arch/powerpc/kernel/ima_arc=
h.c
> index b7029beed847dc0acf15b3edbdd7fe9e60626f24..690263bf4265c78331b5f3060=
97543ce12ac7dbd
> 100644
> --- a/arch/powerpc/kernel/ima_arch.c
> +++ b/arch/powerpc/kernel/ima_arch.c
> @@ -63,8 +63,7 @@ static const char *const secure_and_trusted_rules[] =3D=
 {
> =C2=A0const char *const *arch_get_ima_policy(void)
> =C2=A0{
> =C2=A0	if (is_ppc_secureboot_enabled()) {
> -		if (IS_ENABLED(CONFIG_MODULE_SIG))
> -			set_module_sig_enforced();
> +		set_module_sig_enforced();
> =C2=A0
> =C2=A0		if (is_ppc_trustedboot_enabled())
> =C2=A0			return secure_and_trusted_rules;
>=20


