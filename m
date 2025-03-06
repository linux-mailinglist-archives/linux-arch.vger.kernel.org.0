Return-Path: <linux-arch+bounces-10534-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DAAA54447
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 09:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66083A9A28
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 08:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD47B1F76B5;
	Thu,  6 Mar 2025 08:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="qRwsTV1J"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543911F3FF8;
	Thu,  6 Mar 2025 08:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741248648; cv=none; b=fb2U81d6jDMflJdN0gCPzRrBxJt+TsJR/zNyxZQSCr1/fpIFE6PyywMV5GBcL8Gw1TuPXlJ3TyxWXknNsr1JNR6f22XADWgwoBoS9Qt7SmbDhPftNTNZbbSDcsGnclWzNK5lbVw6g+/yIuIJFhK9+aoc4leTKuLxoDRtRCErTPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741248648; c=relaxed/simple;
	bh=y1jyoG2OYZHXc+mxM9f2meBVTyx6le840P9TMgyFh+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNtKVkwyC0W6JwfiYD5yhcQVOb6/9ju+4ZTzRA+rdfbvZKQS7j+ML97FTcxxo+55hKu2Qoej30Z+sh3wcsJAqO4kz0UjSUTPWYvFfk/BunmqZnVoXhpUYx+4HS217L/FLUKhmDSmXU82S0L/3EjxUrYSrWbL5gnzQMOg/9SFf6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=qRwsTV1J; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1741248635;
	bh=y1jyoG2OYZHXc+mxM9f2meBVTyx6le840P9TMgyFh+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qRwsTV1JFdbocyf1I4u0uZdJYpMNpU7YnRpWkjEymYyU/qjJaRTnyO247BZyPCYHx
	 9qGCfQl7ZMx7HfKGRxzkyuZOYpmKVvvtO9E02kRtH4CGtEulfvKF6QG95dwbDGGg2J
	 PiH8iQpi5J0HzxwVFa/ff1p3xgrxiRgkkRbMu+s8=
Date: Thu, 6 Mar 2025 09:10:34 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: kpcyrd <kpcyrd@archlinux.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Jonathan Corbet <corbet@lwn.net>, Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
	Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 6/6] module: Introduce hash-based integrity checking
Message-ID: <169f0e30-a8b2-494d-917e-eade8340cf67@t-8ch.de>
References: <20250120-module-hashes-v2-0-ba1184e27b7f@weissschuh.net>
 <20250120-module-hashes-v2-6-ba1184e27b7f@weissschuh.net>
 <8e5b171d-78fa-4cba-8217-1a661d23785b@archlinux.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e5b171d-78fa-4cba-8217-1a661d23785b@archlinux.org>

On 2025-01-23 00:28:40+0100, kpcyrd wrote:
> Thanks for reaching out, also your work on this is much appreciated and
> followed with great interest. <3
> 
> On 1/20/25 6:44 PM, Thomas Weißschuh wrote:
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index effe1db02973d4f60ff6cbc0d3b5241a3576fa3e..094ace81d795711b56d12a2abc75ea35449c8300 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -3218,6 +3218,12 @@ static int module_integrity_check(struct load_info *info, int flags)
> >   {
> >   	int err = 0;
> > +	if (IS_ENABLED(CONFIG_MODULE_HASHES)) {
> > +		err = module_hash_check(info, flags);
> > +		if (!err)
> > +			return 0;
> > +	}
> > +
> >   	if (IS_ENABLED(CONFIG_MODULE_SIG))
> >   		err = module_sig_check(info, flags);
> 
> From how I'm reading this (please let me know if I'm wrong):

<snip>

This is how it is intended, thanks for checking.

> This all seems reasonable to me, maybe the check for
> is_module_sig_enforced() could be moved from kernel/module/signing.c to
> kernel/module/main.c, otherwise `sig_enforce=1` would not have any effect
> for a `CONFIG_MODULE_HASHES && !CONFIG_MODULE_SIG` kernel.

Moving the check would complicate the logic and shouldn't make a
difference. In signing.c it ensures that a validation failure is
propagated. However that is the default behaviour in hashes.c.


Thomas

