Return-Path: <linux-arch+bounces-4991-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD5691135C
	for <lists+linux-arch@lfdr.de>; Thu, 20 Jun 2024 22:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0B52845FF
	for <lists+linux-arch@lfdr.de>; Thu, 20 Jun 2024 20:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7BC57C9C;
	Thu, 20 Jun 2024 20:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="gfNgQQkE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5A455882;
	Thu, 20 Jun 2024 20:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718915812; cv=none; b=IpJ6nyKNilkUNiWr8C3nNOb5Q/MNBVaxVtSE0MLNLpkWPcb2VIdGywZ+/4usNliCay8AFe2tX4Yw6B7uQQE5A+6v2SXO2mKytvpV1ucud8K6ExSKHW8PRyhrSX+wuSpL+IZXEKnSM3B5gUWSm9ijIYnikBgIty//ZZrTz+7auBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718915812; c=relaxed/simple;
	bh=ZCX2mbIB71xdIzJY2fRAFR66NO/Z3FXrbqoEYilYEUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CLHfCFQwCyQ2yR/l0D6BFz3Azswg0xnaK2lB7C94USyawjNc8L2N02zy3upX/VzbKmg79hp7nO6SriSCB61xF49cfsrksRauI2GR6PJq+pzzScwuaMv2WRj1b0iCn3ew8ZFUvSaMGLYWSnTLOw/Nk+z+1SZ3o2sTIe8YuLvxD8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=gfNgQQkE; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1718915800; x=1719520600; i=deller@gmx.de;
	bh=+3/2uR/NPfJJSa+zW4iJ2yK8CBAEPxF6iAuEf1hYCPM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gfNgQQkEvsFW6GV5/9p3j+5eCmk+LXCBO3hU/s9srN6YctV3Vu7gPPa7lnYly/Nf
	 AU8UBhrMPH3QleYe0QAgk0KKQ63L0riIO/5S3110Wz8Ls6aGKEuboXJ2pFCHQEB9C
	 7nY4q60T1sHK6FJLz0fiVAodLPc4VdAPcGnAhiok69jgdGx4UlZd3O0QSuK2kZOOL
	 lUl7scyuxRDfNoxXnc9q5lo+umOBOvtHhPdWvvD9TR0UJYWPx/L71H4NEFZHEdxSv
	 Ut9cGCzWWJEO1KO2JY6uyHh4aqLswjKBCJkM87wcOF3hfblai1JWHEmAiK2FHZtxM
	 kSKQBtzs5NhNs2bZSg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.133]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvbBk-1sbNNO0rnK-00qpKT; Thu, 20
 Jun 2024 22:36:40 +0200
Message-ID: <a53789ee-9de1-49f9-93c2-58ba3fd47cae@gmx.de>
Date: Thu, 20 Jun 2024 22:36:39 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/15] parisc: use correct compat recv/recvfrom syscalls
To: Arnd Bergmann <arnd@kernel.org>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
References: <20240620162316.3674955-1-arnd@kernel.org>
 <20240620162316.3674955-7-arnd@kernel.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240620162316.3674955-7-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6AIiO4kRM6M//N3+rso49VJZ41HsQNJrFkilT5ktQcd+UnnTBre
 LW9BEE5j7hL0D3Ira70Y81QTI27j+qi7JGIuDQNSlAg+dhMDoBT9bSuABxWjLJrXO5zAtUL
 OzEyCBXP6mNxJVckt/14seluFr2TEw67DOgQ4CfU+p9eZzVe/4hHQDmqZkG3KBgqFYYcZmv
 bJ5qYEuS2FlaWuCcSumTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:e0CNm+9+x/A=;UQLvHQ7ZPLua1Gb8YR2cW/KtgvU
 Piy+L7N6r4Mdhy7RIzXSuLsI7e4el3pSnWAyqdlQOrnfkIZd8fsfHBHTU7lHNzrS163vsVLM+
 BGJofPvo1EYlr9g2ItxBLLcMznTmk+eOYe+K5Kz2ASvlOA1faEoxgzTB9uYjsNKmxntGVSuLo
 Wrd26UdEKJWjJobtwbVBcKZ6OUnftQTG1rsmcIa7kfinq7GDGrtW70PUwt21YOiH0wAjJ9PqI
 eOix1fc1dv6yH0DUZqWa/Jjx5ANJTS/ORXxbbU5ZuaYrukrJyZTCX8ysIMwK0i6CSxaiIAI+H
 lZSwxr6svA7ys1j2XN7SkI4KIDjTuK25/tIESYcBTw9oo+rqH+wAFrRGcRn/zscq3AY4wNLQo
 9WEon4u7zXQnjkQcq0bH+0cO6Lw6BdZ85xp75bfN/P0IX3FmVNBgVEvn0/OIEy4aytN5041kY
 GR1l8MaTGehbEmsKLv/+3Z7sxDk3MvMbQlw+s+sGbGsrdS34aHvnwWRFgt+e3D11ZPxbdlnUG
 Ff1aL//lPAgTp/+UtavUvP+SFbiH55exrORy+0CAlTvikrkNtErA1RSRfptVuYJtFWxuE9UXI
 gCk7jTKpPCG4KMQe8Ivp3zHrFLjxwRbGeFzAsIGVO/CFl/pu4Gj3T5aozgHE2s1usEl/7e/68
 fEHCmyZlBDuxm2zvZqxWj59VWjUEEQELBFm+QxbAIxwVwV0j3aQ0wrhHEadZpSCc7+ufHfG/S
 8JYiKP/hdLu5qv6bNo8o2bTpLe38HYHID3tQqXKVCkdvz1tyXg+ygQk3neSwSDmx1ocQ87dPf
 NMtaTrZ/wVfE85G5z1HNeLysq0UzVB4BZy3ke31i3rkow=

On 6/20/24 18:23, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Johannes missed parisc back when he introduced the compat version
> of these syscalls, so receiving cmsg messages that require a compat
> conversion is still broken.
>
> Use the correct calls like the other architectures do.
>
> Fixes: 1dacc76d0014 ("net/compat/wext: send different messages to compat=
 tasks")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Helge Deller <deller@gmx.de>

Nice catch, Arnd!
I'll add a backport tag and take this patch through the parisc git tree.

Thank you!
Helge

> ---
>   arch/parisc/kernel/syscalls/syscall.tbl | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kerne=
l/syscalls/syscall.tbl
> index b13c21373974..39e67fab7515 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -108,7 +108,7 @@
>   95	common	fchown			sys_fchown
>   96	common	getpriority		sys_getpriority
>   97	common	setpriority		sys_setpriority
> -98	common	recv			sys_recv
> +98	common	recv			sys_recv			compat_sys_recv
>   99	common	statfs			sys_statfs			compat_sys_statfs
>   100	common	fstatfs			sys_fstatfs			compat_sys_fstatfs
>   101	common	stat64			sys_stat64
> @@ -135,7 +135,7 @@
>   120	common	clone			sys_clone_wrapper
>   121	common	setdomainname		sys_setdomainname
>   122	common	sendfile		sys_sendfile			compat_sys_sendfile
> -123	common	recvfrom		sys_recvfrom
> +123	common	recvfrom		sys_recvfrom			compat_sys_recvfrom
>   124	32	adjtimex		sys_adjtimex_time32
>   124	64	adjtimex		sys_adjtimex
>   125	common	mprotect		sys_mprotect


