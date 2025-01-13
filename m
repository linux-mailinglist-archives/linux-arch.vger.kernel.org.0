Return-Path: <linux-arch+bounces-9715-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF38A0B27E
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jan 2025 10:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F0D1886399
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jan 2025 09:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F93023499A;
	Mon, 13 Jan 2025 09:15:54 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABAD233D92;
	Mon, 13 Jan 2025 09:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736759753; cv=none; b=WJyp4RbCeL9uQ+8PMwI8SaflQfcs2L39hbvTz6YzSR8NMXJlx7y35KZ7DbmykyqUvM/3vcF12a8P4OVzSxQW0tumebevLvt3P3WzFcP5D1fC3SXmKft52lBZgc7wUche3WwAdecb4XxX7QPlzCAvKix56k83nNxXRVDlbCEIVPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736759753; c=relaxed/simple;
	bh=ykO6ROWoK/m4H4zwfcwB0m3Uc355ddIHyPlQ76bVw+8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:MIME-Version:
	 Message-Id:Content-Type; b=ilePaz5WXnj/QP6ztTwtWGOxxI7qlGxT4DcS62vMC4P/y19GAQCh9kgXclkcG9o/DipLxHEqe+oUKsFayjTRv1P1Qw4A1FBGo0CV3QKf3Dqvb0Wcee0JJ/jM6mlGxRviAxYRMPHcPaC2iagj2tEFP1gpNEfQtxgBFCnykke0VZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 2C8B44434F;
	Mon, 13 Jan 2025 10:15:43 +0100 (CET)
Date: Mon, 13 Jan 2025 10:15:39 +0100
From: Fabian =?iso-8859-1?q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>
Subject: Re: [PATCH RFC 2/2] module: Introduce hash-based integrity checking
To: Thomas =?iso-8859-1?q?Wei=DFschuh?= <linux@weissschuh.net>,
	Luis Chamberlain <mcgrof@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Daniel Gomez <da.gomez@samsung.com>,
	linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, Masahiro Yamada
	<masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier
	<nicolas@fjasle.eu>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
	<samitolvanen@google.com>
References: <20241225-module-hashes-v1-0-d710ce7a3fd1@weissschuh.net>
	<20241225-module-hashes-v1-2-d710ce7a3fd1@weissschuh.net>
	<Z3iQ8FI4J7rCzICF@bombadil.infradead.org>
In-Reply-To: <Z3iQ8FI4J7rCzICF@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: astroid/0.16.0 (https://github.com/astroidmail/astroid)
Message-Id: <1736759530.44f6v98g9c.astroid@yuna.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 4, 2025 2:37 am, Luis Chamberlain wrote:
> On Wed, Dec 25, 2024 at 11:52:00PM +0100, Thomas Wei=C3=9Fschuh wrote:
>> diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
>> index 7b329057997ad2ec310133ca84617d9bfcdb7e9f..57d317a6fa444195d0806e6b=
d7a2af6e338a7f01 100644
>> --- a/kernel/module/Kconfig
>> +++ b/kernel/module/Kconfig
>> @@ -344,6 +344,17 @@ config MODULE_DECOMPRESS
>> =20
>>  	  If unsure, say N.
>> =20
>> +config MODULE_HASHES
>> +	bool "Module hash validation"
>> +	depends on !MODULE_SIG
>=20
> Why are these mutually exclusive? Can't you want module signatures *and*
> this as well? What distro which is using module signatures would switch
> to this as an alternative instead? The help menu does not clarify any of
> this at all, and neither does the patch.

FWIW, I think we (Proxmox, a Debian derivative) would consider switching
to MODULE_HASHES for the modules shipped with our kernel packages, once
MODULE_HASHES does not conflict with user/MOK-signatures on DKMS- or
manually-built modules. we do prefer reproducible builds, but
extensibility via third-party modules is an important use case for us
(and I except many other more general purpose distros).


