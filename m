Return-Path: <linux-arch+bounces-9861-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B15A19B7F
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2025 00:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860DF3AC474
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2025 23:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90FA1CAA9E;
	Wed, 22 Jan 2025 23:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="VFnQzv5P";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="Euh2GBG3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67011185B62;
	Wed, 22 Jan 2025 23:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.189.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737588871; cv=none; b=HUherR4o2PZ8MnAqgjNildmhNu3w9HN/jKAJ1PL28FVzwTJ9aWs/cN31nen71s5iVu0IxL/ZW3lt0M2UD7vQ9MXCfi4iRFOprRNcihFMQ6xmKbbu6BTiUsoEYdukZ7AraonkgTVoJbJemFyJrSfP3Z9jgdeD8q5aEf67KNi/1vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737588871; c=relaxed/simple;
	bh=y9Q8HEE6q0vmvrQ9y+XwfgTOy+3p3frBcuPef11CoPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l9rXmgwajrbo+sB0K1Fx9YOWEzqMn+JRLZqPCcg2qY4P2/TqU95g9osIW4XnhPuZLL7u9dzgHiUSCK0KX9+JoCheZTtC4oxFvIwzHn79dIrA4rZz2TahhTa9LmSKjEq6p4VA0yvUDZgVVM+nyXmqBAOHEsXDE99ZD6k6aSmG9W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; spf=pass smtp.mailfrom=archlinux.org; dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=VFnQzv5P; dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=Euh2GBG3; arc=none smtp.client-ip=95.216.189.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinux.org
Message-ID: <8e5b171d-78fa-4cba-8217-1a661d23785b@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1737588523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nN8ZPByiAs2yKdwLh5W4fO3m7Re8B0wU6vIlJ5ZWJ6U=;
	b=VFnQzv5PEHo+boR7sYtwv3SvjQNrMce7nfWtbHdM4vxonnsLc+EQPaJObToIm2zIe0H5dc
	Dd3vYJdPEOtGoAYr/pKWs/Bxv7kkhyy/hSuMuUppZ2kkD5A7NAzO7HrFaSUozPhdnz3koF
	LS6rsq25cvrJHrm+rk8VJ3K1wCUqs8Y8WzHS3z/yQtavQGj3xROYyJLITrBOeGWY2LHr+6
	CrD4DtsD50Id6KahUobwnvGqKzIRAwHpMHYS4nQM71yHb0sryuyZwG1W7vweZEnRN8UFGc
	XBEPPo41c8T1lnnwVy6eNyZD7UWjTNdG5bE9FyWlazPr/e43Vvg/X4asGsoso/fIBRloM+
	aRYZquTWAvLlR4ACSkhH+N3GHc8k2AhwRdFBKL16gjI51oBjo+0NdVYhSelNaT6Z2romhT
	ZnJvbOGhpMWNoc36jwbZWGh8SZlM39gpdGrFsCJKhVbd+WDFwZXqSZIkB8+43ixtksv8Ix
	8oDaELwyHiUVnCFUqBqntV2UmcLUgxozoFPcTFJJ7UPo+0gRCwmgHSJkM5bSAj5UNXw+Ac
	KO5UW7A9oX/ktq9A5JrOmwHDwB8alHpAh3Y1OlBCmvjsrO7QKRRNEwQ9IjGzLSnlOWKgPY
	ZYjcY3fIOMQkbiFByM49TmxK6ltNK+EkNjJnMmyYMQ0BtLRzf71dQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1737588523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nN8ZPByiAs2yKdwLh5W4fO3m7Re8B0wU6vIlJ5ZWJ6U=;
	b=Euh2GBG39NEZKnmrDmzHEp7zEz7La8UboW2/Llrndh0TjmRCgzYt9pSb0oQW9Pb2RFA9cv
	AXC5ElgjGj/UKHAw==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=kpcyrd smtp.mailfrom=kpcyrd@archlinux.org
Date: Thu, 23 Jan 2025 00:28:40 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 6/6] module: Introduce hash-based integrity checking
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
 Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>,
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250120-module-hashes-v2-0-ba1184e27b7f@weissschuh.net>
 <20250120-module-hashes-v2-6-ba1184e27b7f@weissschuh.net>
Content-Language: en-US
From: kpcyrd <kpcyrd@archlinux.org>
In-Reply-To: <20250120-module-hashes-v2-6-ba1184e27b7f@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi!

Thanks for reaching out, also your work on this is much appreciated and 
followed with great interest. <3

On 1/20/25 6:44 PM, Thomas Weißschuh wrote:
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index effe1db02973d4f60ff6cbc0d3b5241a3576fa3e..094ace81d795711b56d12a2abc75ea35449c8300 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3218,6 +3218,12 @@ static int module_integrity_check(struct load_info *info, int flags)
>   {
>   	int err = 0;
>   
> +	if (IS_ENABLED(CONFIG_MODULE_HASHES)) {
> +		err = module_hash_check(info, flags);
> +		if (!err)
> +			return 0;
> +	}
> +
>   	if (IS_ENABLED(CONFIG_MODULE_SIG))
>   		err = module_sig_check(info, flags);
>   

 From how I'm reading this (please let me know if I'm wrong):

## !CONFIG_MODULE_HASHES && !CONFIG_MODULE_SIG

No special checks, CAP_SYS_MODULE only.

## !CONFIG_MODULE_HASHES && CONFIG_MODULE_SIG

No change from how things work today:

- if the module signature verifies the module is permitted
- else, if sig_enforce=1, the module is rejected
- else, if lockdown mode is enabled, the module is rejected
- else, the module is permitted

## CONFIG_MODULE_HASHES && CONFIG_MODULE_SIG

This configuration is the one relevant for Arch Linux:

- if the module is in the set of allowed module_hashes it is permitted
- else, if the module signature verifies, the module is permitted
- else, if sig_enforce=1, the module is rejected
- else, if lockdown mode is enabled, the module is rejected
- else, the module is permitted

## CONFIG_MODULE_HASHES && !CONFIG_MODULE_SIG

This one is new:

- if the module is in the set of allowed module_hashes it is permitted
- else, if lockdown mode is enabled, the module is rejected
- else, the module is permitted

---

This all seems reasonable to me, maybe the check for 
is_module_sig_enforced() could be moved from kernel/module/signing.c to 
kernel/module/main.c, otherwise `sig_enforce=1` would not have any 
effect for a `CONFIG_MODULE_HASHES && !CONFIG_MODULE_SIG` kernel.

cheers,
kpcyrd

