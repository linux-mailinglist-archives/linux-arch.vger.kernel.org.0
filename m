Return-Path: <linux-arch+bounces-11839-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10859AA7D82
	for <lists+linux-arch@lfdr.de>; Sat,  3 May 2025 01:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C8E77AD869
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 23:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9316B270548;
	Fri,  2 May 2025 23:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="Qhic4OLm";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="pWUXN2ba"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7665226520;
	Fri,  2 May 2025 23:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.189.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746229901; cv=none; b=tayGBmVgxmEcvQBYSEgddNvxkgOhz7zQX6mPf5OthjK3lJCTXivAAlUQZXUILJGcaG338/VuWIzxUSr9bjxuzZPFeqrcTeLxUGhgINGp8oZB25zgZiyYayZ8J7jlOPv9iyk97SngqDClFnTksZ1Lclr6QQcc2AFCOiOv0hIImhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746229901; c=relaxed/simple;
	bh=njf1WV3cKpBGYTHc6siAE3sCl8ClWU7pG5cQt3nhjw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5yfz+dguWXDVL5vPL3ljwiaLweUBX/3vwIR5R58fXpsRoD96NG2RdcuL2GudNzOga7AdqtNTBky5/vEx+ifCz24hl1sGuBYdq4sLrDMpeLb++LN4YUkW7Cbq7TAeE0kRQNIP+txtSYERa8xnlApB/pqKxzlTweKYvSnYRwTPGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; spf=pass smtp.mailfrom=archlinux.org; dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=Qhic4OLm; dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=pWUXN2ba; arc=none smtp.client-ip=95.216.189.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinux.org
Message-ID: <bf3f2f1c-1852-449f-993f-71848d190db6@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1746229390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VputJNPvBl9XACh4x8s207ghVEizyjJrRTUadxhl7W0=;
	b=Qhic4OLmfnzDZAcpigNu7UrqLK5mWgcMPgKRWpfhdAXeZIqHXIBZVqEkrh8YlxeTSpOAbU
	tEuR8Hl86L0vi7auXrHzDR7/KmPsUpinbZ6VHAEwk64QsAe3+IL9ANV64KxMfw8/rHMGgA
	k1oSNM/QKKyilECNEb2JnruO5orD5/JCByNXVkBX1nuiBoTkhgZwex6wBzMz5CRSETtJvX
	/umQNjYFjOrleljhVtUZ9guk5XJ1MM7kE4yK9nqbZV6g1W4jd+u7mfzQmEYib+v/q0/liU
	WrAmO2uRMsrM+RRe9W4EYzVK5ED0kYo+jbIvZ4+vcjsRe38jBnBekYZNWY00XPOeplaiIK
	BvfFWmFZ9L9f7xIdxoz2sbnQEkhHVAFJ2xtZtsi6uLCneWRxBGBxT/ADPT0BOgRfPYAjwB
	atSK/tKeP4kcfOVS+t9AnSyV7obHcia28DSrHnsRMH7Lv/QJJshLghDJskgLHh3whAbBDd
	DQCPx6yylwF6AkLygj4FnEbHcMJj5bxz+NgHNKJP+wecgVU15BfLDeH/obVkNIOP3tW5zZ
	0FVGN0Ypnkope2InCXnrS0Ur0MWb8/RXNPdJHlLzgmkElM21+hmtrbSvl8ve0yGWoyf2sH
	ah7STOBC/NiCplBj5M1Z4RrvTRTHDEkZh7gcxt9ZubblsWPjOvH+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1746229390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VputJNPvBl9XACh4x8s207ghVEizyjJrRTUadxhl7W0=;
	b=pWUXN2baJ+rjBIqdcBKhyMfxHT1Z/KrJMyTIFAemXV1CBDzl8/qFRMzDBOovLcR/C95F5U
	Iyd1qkopp9pOBkCg==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=kpcyrd smtp.mailfrom=kpcyrd@archlinux.org
Date: Sat, 3 May 2025 01:43:06 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/9] module: Introduce hash-based integrity checking
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>,
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>,
 Christian Heusel <christian@heusel.eu>, =?UTF-8?Q?C=C3=A2ju_Mihai-Drosi?=
 <mcaju95@gmail.com>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-integrity@vger.kernel.org
References: <20250429-module-hashes-v3-0-00e9258def9e@weissschuh.net>
 <f1dca9daa01d0d2432c12ecabede3fa1389b1d29.camel@HansenPartnership.com>
 <840b0334-71e4-45b1-80b0-e883586ba05c@t-8ch.de>
 <b586e946c8514cecde65f98de8e19eb276c09703.camel@HansenPartnership.com>
Content-Language: de-DE, en-US
From: kpcyrd <kpcyrd@archlinux.org>
In-Reply-To: <b586e946c8514cecde65f98de8e19eb276c09703.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/25 3:30 PM, James Bottomley wrote:
> Under a your interpretation of the above, any signed binary isn't
> "reproducible" even if the underlying build was, which means any secure
> boot kernel would never be reproducible because it also has to be a
> signed binary.  The solution is simple: can you strip the signature and
> reproduce the build?  If yes, then the build is reproducible and even
> fits with the "any party can recreate ..." above.   This is the
> interpretation pretty much everyone else has been using.  It's why
> people like Intel with source only availability and Intel build only
> signing tout reproduceability: they only issue signed confidential VM
> firmware, but you can technically reproduce the build of the firmware
> minus the signature but you can never sign it.

The secure-boot signature is easier to deal with, I also think there'd 
be one package that contains just the unsigned kernel+modules (with the 
modules being pinned by a cryptographic hashset), and a second one that 
takes the kernel secure-boot signature as a source-code input, that is 
calculated after the first package was successfully built.

Arch Linux has also considered patching the module-signing-script into 
some kind of oracle that doesn't use any private key and instead selects 
the right pre-computed signature for the given content, but:

- that would be terribly annoying to maintain/operate
- any reproducible builds regression would make the build fail, because 
the kernel wouldn't be bootable

> You just strip the signatures before verifying reproducibility.
> 
[...]
> 
> If you take off the appended signature off the module, you can verify
> reproduceability.
> 
[...]
> 
> So you think stripping signatures is failure prone?  If that were the
> case then so would be verifying signatures upon which our whole secure
> boot and signed module loading is based.
> 
[...]
> 
> Or you simply ship tools to remove the signature;
> 
> sbattach --remove <signed efi variable>
> 
> already does this for you ...

It reads like you assume somebody sits down and explicitly looks at the 
linux package manually, but the reproducible builds tooling considers 
the package content to be fully opaque and doesn't have any 
special-casing of any package:

https://github.com/archlinux/archlinux-repro
https://salsa.debian.org/debian/devscripts/-/blob/main/scripts/debrebuild.pl?ref_type=heads

I'd rather not deal with the consequences of weakening the comparison 
and possibly introducing exploitable loop-holes in any of the layers we 
wouldn't be able to bit-for-bit compare anymore (like e.g. tar).

It would also break the concept of `f(source) -> binary`, "you can 
deterministically derive the binary packages from the documented build 
inputs", and instead you'd always need to fuzzy-match against what 
somebody else built.

cheers,
kpcyrd

