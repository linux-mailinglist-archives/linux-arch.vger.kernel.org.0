Return-Path: <linux-arch+bounces-11930-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7701AB7451
	for <lists+linux-arch@lfdr.de>; Wed, 14 May 2025 20:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637474E0441
	for <lists+linux-arch@lfdr.de>; Wed, 14 May 2025 18:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D01D281523;
	Wed, 14 May 2025 18:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="sr0OtqzI"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98DF28136B;
	Wed, 14 May 2025 18:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747247149; cv=none; b=stuAlaM4LMPj1ji1pH3hKpONmbODhQ2Rn4+NfSzANSIjvkt9qzDOaIrOk1dIaS68wzz5KX4QyKNFVoUvsC6rHIYkQdTezXWMcnUA+swNG6QlC50e8hhUXspHHlZj63MYo2Na/qC0R11ez0LNduXgL8w7CWFikyLNAj8MU/st4CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747247149; c=relaxed/simple;
	bh=Sk6K50SJwRVBX41TpMia1ozjSbtn+RFQ/xSJZ1d8+m0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=P2aDFl6UO8r1Os/8zQzWvLV1tYA2ZM5MoMX0pX4p3+JlvOWctF0YaVZiHDS5fXdgQ5VtdA+XSaYzF4VFXK82H0k8KzBi6wvowM26k8QHYcsMLTsaAVrVwkv2Y1465riSpZepVFckb7FTSMGrfVPNncbuTGHKnRF3QEjFrAy1mJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=sr0OtqzI; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1747247137;
	bh=Sk6K50SJwRVBX41TpMia1ozjSbtn+RFQ/xSJZ1d8+m0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=sr0OtqzImkjWIiWULL7qcXg/qcMho0hs2xaNucwcAreBWQ2E45Z4IIQOyS+7+B/9Z
	 wMiLLhMsWTW9FAwOJzQDW7ieAtsPf/Rs2zUIKJPVF3ajqcQxESgMoxyM8ON+2GcBW1
	 L8qZcUsSGEIr4hfmDvc1N8xI98e0pDP4tIuKtUls=
Date: Wed, 14 May 2025 20:25:34 +0200 (GMT+02:00)
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	=?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>,
	Arnout Engelen <arnout@bzzt.net>,
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
	Christian Heusel <christian@heusel.eu>,
	=?UTF-8?Q?C=C3=A2ju_Mihai-Drosi?= <mcaju95@gmail.com>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Message-ID: <17aaa56b-5ee7-4a7f-a3c1-206e2114645d@weissschuh.net>
In-Reply-To: <edeb23e7884e94006d560898b7f9d2dd257a275e.camel@linux.ibm.com>
References: <20250429-module-hashes-v3-0-00e9258def9e@weissschuh.net> <20250429-module-hashes-v3-2-00e9258def9e@weissschuh.net> <10ca077d6d51fac10e56c94db4205a482946d15f.camel@linux.ibm.com> <edeb23e7884e94006d560898b7f9d2dd257a275e.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/9] ima: efi: Drop unnecessary check for
 CONFIG_MODULE_SIG/CONFIG_KEXEC_SIG
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <17aaa56b-5ee7-4a7f-a3c1-206e2114645d@weissschuh.net>

May 14, 2025 19:39:37 Mimi Zohar <zohar@linux.ibm.com>:

> On Wed, 2025-05-14 at 11:09 -0400, Mimi Zohar wrote:
>> On Tue, 2025-04-29 at 15:04 +0200, Thomas Wei=C3=9Fschuh wrote:
>>> When configuration settings are disabled the guarded functions are
>>> defined as empty stubs, so the check is unnecessary.
>>> The specific configuration option for set_module_sig_enforced() is
>>> about to change and removing the checks avoids some later churn.
>>>
>>> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>>>
>>> ---
>>> This patch is not strictly necessary right now, but makes looking for
>>> usages of CONFIG_MODULE_SIG easier.
>>> ---
>>> =C2=A0security/integrity/ima/ima_efi.c | 6 ++----
>>> =C2=A01 file changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/=
ima_efi.c
>>> index
>>> 138029bfcce1e40ef37700c15e30909f6e9b4f2d..a35dd166ad47beb4a7d46cc3e8fc6=
04f57e03ecb
>>> 100644
>>> --- a/security/integrity/ima/ima_efi.c
>>> +++ b/security/integrity/ima/ima_efi.c
>>> @@ -68,10 +68,8 @@ static const char * const sb_arch_rules[] =3D {
>>> =C2=A0const char * const *arch_get_ima_policy(void)
>>> =C2=A0{
>>> =C2=A0=C2=A0=C2=A0 if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_g=
et_secureboot()) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ENABLED(CONFIG_MODULE_SIG)=
)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_modul=
e_sig_enforced();
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ENABLED(CONFIG_KEXEC_SIG))
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_kexec=
_sig_enforced();
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_module_sig_enforced();
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_kexec_sig_enforced();
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return sb_arch_rules;
>>
>> Hi Thomas,
>>
>> I'm just getting to looking at this patch set.=C2=A0 Sorry for the delay=
.
>>
>> Testing whether CONFIG_MODULE_SIG and CONFIG_KEXEC_SIG are configured gi=
ves priority
>> to them, rather than to the IMA support.=C2=A0 Without any other changes=
, both signature
>> verifications would be enforced.=C2=A0 Is that the intention?
>
> Never mind, got it.
>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Thanks for the review!

Given that this series has no chance
of getting into the next merge window,
would it be possible to take the two IMA preparation patches
through the IMA tree to have them out of the way?


Thomas

