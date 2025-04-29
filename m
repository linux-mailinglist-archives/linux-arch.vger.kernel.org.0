Return-Path: <linux-arch+bounces-11721-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47656AA3C41
	for <lists+linux-arch@lfdr.de>; Wed, 30 Apr 2025 01:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA65B188BAD4
	for <lists+linux-arch@lfdr.de>; Tue, 29 Apr 2025 23:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3927F26D4DC;
	Tue, 29 Apr 2025 23:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EKXBOqmu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FFB21129A
	for <linux-arch@vger.kernel.org>; Tue, 29 Apr 2025 23:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745969463; cv=none; b=BQqHjXrzyQAXmUp0GOHI88qRFZcft+PcXD3fGTCsTeS1+jq1qfW39svm1TgEkW+v/uNtSSrYxrrodkbMu7oscr3cVAJg0xJIJI5hjbtI53z8Db/gwsOqZXGlBEVpM9glZ54Z7ojPueQn/VU9Q9gGc/IkyALerKYscNOLcS5CxrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745969463; c=relaxed/simple;
	bh=6+tn3bVnsdbyoFhXLXW3XNOXO8RdLpvvD8H+IgN8isw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kU9kWH3LdhdPOgkWiOGJvqmwnpmOZxOhfPrZD3dKwgIFufQIma3mNnNoUmrfuAC+OK0QzGv6+ntqfeeWIINMEP3hRBgR87YNGnf9qGrYP8kW4lI6NqVPCYCFVzvaxl2lTh9+U95mluTkqm4vjouQXCK2Et3aOxe4pP39QhSKwW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EKXBOqmu; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e6a8aa771e8so5828693276.3
        for <linux-arch@vger.kernel.org>; Tue, 29 Apr 2025 16:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745969460; x=1746574260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIuAebnQ3utGP4sRcNF3af9094rXpAxKt1SXsqCPHIU=;
        b=EKXBOqmuBPd3QD0u0uXcMb8RXce8GeOv2o58ReliDmsY6jwHqdPW/JGLY+OEiGpmbT
         lja2QVzmYiVG1FUiP9tnnqOQqueX/mWLevqAKG1cZIgtJibmyj/PZAwSkCrPGfE5S+Vx
         ICYJZd9sxzmS32qWTvu6WGZ0u6715wpCeNxiUM7RroHWdXn5KAPoik7dU67SobIF1Ak0
         W0KKY44pEeikYACgaLWIn6BpYQrRMReyGFibQT7N3PH9iI6TmA6utLBcD5SK0Zgg4D5y
         IW6iZtZ02YU7Yc7nKGNd5Ze+slDFZj9UkpZVrf8WRaYytC14nazrOwLnYtA5MImIgzns
         PeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745969460; x=1746574260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIuAebnQ3utGP4sRcNF3af9094rXpAxKt1SXsqCPHIU=;
        b=DoIsSUthVgaV4T/w+m26mhbgmzPwgX4QrThm+K4tWMHGfw1M2ZUVJLZVgtHB2n0mLY
         H2yolZ2lk69Bs8QQFpGepRivIuPFPrvI8vOolXINMe958bMhNdtHMv33RCEqmUiG8Aic
         6AD+lgQMJqB0gS+mvEROTZanvU0GaTr/xz4eDTDcfK0Fcu7JY+i2vJY41lVdtpoIOXiQ
         wBRRJr/A2dcPU3P6jDMQbbaRtkEitF6J1ATMGKfXXXTH9pZQ7qaTO2LeQf+qRYG3koly
         JAyXb3AomyO2WHJN0n3HWCqGBRDcqAxGLJJO5tNMZZ+vFMMhuWEItNFIUfFHUVzny8MW
         8C5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBCHUyDBUjTFJBlSoFp34JlNLc4CGbPCRDoN9/Bcmf34WNqCeygf3GeT6KCYIbRnXKDumCeJlq0sEU@vger.kernel.org
X-Gm-Message-State: AOJu0YwjQGgtp98/nlJ72yeqg2Ak38HNHlduioOqRzWC9xv0BBywkfIs
	aqAreNHPgJ87R05YPo7DE6zISsEIJBWTrdV6lritgN6dfWSXuL+6ixvMseHtQAseG7zMLKWFGGB
	xMg5wcKt++lJg+7XdbGg8Wo4lw8YHygAPn5yj
X-Gm-Gg: ASbGncs7FgJwtZl8W/uHIOAz4RiS5VRO1Qnk2U7P8rBl/xoWQTVPhy8AEHjrSr2YHEB
	0v/oHziobxFUlDippKtr9GpejaF8+qJ8jZFC4rfxMsdraTC9vc1dA/vQpnXP3ZNzTvv2hle00zF
	3Nkb9zAMls7zSPrAlq8pl6Ug==
X-Google-Smtp-Source: AGHT+IGwua5N9PuQI5YXnZ9QizB13TEvlVyb3ghRMEepupOY9IBACmHRKJ/ceFLULrT2r9vA2fNY/xi9tZpK618tJa8=
X-Received: by 2002:a05:6902:e09:b0:e73:17e3:ef4e with SMTP id
 3f1490d57ef6-e73ecf7cabdmr1474221276.48.1745969460035; Tue, 29 Apr 2025
 16:31:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429-module-hashes-v3-0-00e9258def9e@weissschuh.net> <20250429-module-hashes-v3-8-00e9258def9e@weissschuh.net>
In-Reply-To: <20250429-module-hashes-v3-8-00e9258def9e@weissschuh.net>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 29 Apr 2025 19:30:48 -0400
X-Gm-Features: ATxdqUHKCRv2dWw3Z8HwiaRKbffRbebAcIs6GQu6Ludlza-Iyae1SuGp-QceJWc
Message-ID: <CAHC9VhSAANnOYB11AerdtpEwWSu9OoRdxW34dap909D3z=t49A@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] lockdown: Make the relationship to MODULE_SIG a dependency
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	=?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
	Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>, 
	Christian Heusel <christian@heusel.eu>, =?UTF-8?Q?C=C3=A2ju_Mihai=2DDrosi?= <mcaju95@gmail.com>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 9:04=E2=80=AFAM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> The new hash-based module integrity checking will also be able to
> satisfy the requirements of lockdown.
> Such an alternative is not representable with "select", so use
> "depends on" instead.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>  security/lockdown/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I'm hopeful that we will see notice about dedicated Lockdown
maintainers soon, but in the meantime this looks okay to me.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/lockdown/Kconfig b/security/lockdown/Kconfig
> index e84ddf48401010bcc0829a32db58e6f12bfdedcb..155959205b8eac2c85897a8c4=
c8b7ec471156706 100644
> --- a/security/lockdown/Kconfig
> +++ b/security/lockdown/Kconfig
> @@ -1,7 +1,7 @@
>  config SECURITY_LOCKDOWN_LSM
>         bool "Basic module for enforcing kernel lockdown"
>         depends on SECURITY
> -       select MODULE_SIG if MODULES
> +       depends on !MODULES || MODULE_SIG
>         help
>           Build support for an LSM that enforces a coarse kernel lockdown
>           behaviour.
>
> --
> 2.49.0

--=20
paul-moore.com

