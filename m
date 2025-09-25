Return-Path: <linux-arch+bounces-13764-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DCBB9D8D8
	for <lists+linux-arch@lfdr.de>; Thu, 25 Sep 2025 08:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ECFD3A4BFD
	for <lists+linux-arch@lfdr.de>; Thu, 25 Sep 2025 06:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3112E9EA0;
	Thu, 25 Sep 2025 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="q6nYUkKc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zyr+Mhub"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAD72E9759;
	Thu, 25 Sep 2025 06:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780903; cv=none; b=DRYN2JGh2R+v9P1ZV7pCIsE8hSllDX3KcbzNYnt++a99h22IYSdl+Zmrk9zaYrBohqFcoiIzzwVi7QtQScyr6gzC6y6tRpwluHcP7upcqoazUeVi0tB9TklsxXHQgGJogJI/2ovB7C0aKB55crlrQP9VDKm8NH0hqIArz0fYCw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780903; c=relaxed/simple;
	bh=IJ+re8/aN2ZpswtgEhY7S86+CaZnj3sd8sp3Ecm1uhc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oezKUkhvhfk30vshNo7L+bG2QHx33UgVcc1ixQ/nw0/R7QBC6prYFQny8vlzsR2RIHQIH0UxWnnDUY/kBOwoF5xDqRbxXBGVrjeC1PNH/LFvaYbYvu6k4WNoNrlXdregx9wZswiYY0+2a3J68xySIX0pSbdwFF47JXX89a/gsyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=q6nYUkKc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zyr+Mhub; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 73CDC1D000CF;
	Thu, 25 Sep 2025 02:14:56 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 25 Sep 2025 02:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758780896;
	 x=1758867296; bh=daMBAWHHIBRnjmTgLv5h4+WBfo0EIvTll1secxh8FC0=; b=
	q6nYUkKcdPWO9hpgxW/8lUBH3Hafmtdu0v/jTW8FergvcW3aL1TkCBlD9WjOYCgv
	wZ+thVZrEesOjUmAKy24oLZbkjEiOt+7ei+wQ2gmNXK1n/7h1FYSswj/9C/PBt/U
	rfRo8U8mv2O3oMviJtZ0y4iSnYSn7khO/2smEi4C+W+zz5ss2ehYfI6ECwUWk5+l
	xlBCqJmktEGwj/euxB6e/qldIl9UxEmvNGetaAMCyzUaukWye371H6sPl8Ha5dvY
	sISqajHAhrqrq46Szq+qL0Rq9QNTzTj7I/nYIdLhzgs0AThrWTadk6e3NNHw0a6t
	mekSCF9uN7QD96cWFWM4xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758780896; x=
	1758867296; bh=daMBAWHHIBRnjmTgLv5h4+WBfo0EIvTll1secxh8FC0=; b=Z
	yr+MhubZWoLYdgYRuNped4IodL/ItnQ5qvAMibk1i0m4PxpqimsMLm7P9KaGO1Hp
	mMwJeRbptS00eXEHriBlv9ogS78q1dVHI1xCT1C0V9CofVS2QbwXeEZPn1AlNfmj
	GnvhdOZcnmBkAzpQzVLttov6YR+KAGSIQk6jAZcby6e2svJjRxvNjvsgRRGB3eOt
	BEb0TcnGoz9Tae8aY+Br/dQ634XlLZ4g8YnfNlkxjdCKD7s7YSEJVztkWRn3qGrF
	A3tJOqWi2szyCte1fCsffZP4HKMBaTApBLI19rQYLFzsSuD1wKmNqlIFCR1HjZO+
	YtXYE3vsrwaPzGuefDEpw==
X-ME-Sender: <xms:393UaPfhxLBZWArsaRMFrCNOEDy4hM-EmYNyDMlwlifiInVBGfSv-g>
    <xme:393UaAD0GoTFj5RnjbQga6nhko8IxYWOaEld_OENIn6hME91hEF51Y-AgSx58qmQ2
    sJ16SxRbjPVAffGyZXni0W9ztavwP_Ez0Q-4WZ-TUWUVd73z2UgtvmY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepnhhitgholhgrshesfhhjrghslhgvrdgvuhdprhgtphhtthhopegvug
    humhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepsghosghordhshhgrohgs
    ohifrghngheshhhurgifvghirdgtohhmpdhrtghpthhtohepgihivgigihhuqhhisehhuh
    grfigvihdrtghomhdprhgtphhtthhopeigihhqihdvsehhuhgrfigvihdrtghomhdprhgt
    phhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrshgrhhhirh
    hohieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgrthhhrghnsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorh
    hg
X-ME-Proxy: <xmx:393UaPZNl1EggM-bmsGyfW0juLf_ed8i8y1Oe4CKrVJ2xhd10Mn7mQ>
    <xmx:393UaEy0qTIXAk1j5zbq-pUSyx06fiKGNBKpKmUwOs41HUhNtmrpGw>
    <xmx:393UaOMtPqWAWBpWyCU8T57a3ip-52dBMlA3PqS3OhzbOIWVjjrKug>
    <xmx:393UaDcbZcWx38pBijJfHI-fRmPepC-_iNPl2NeTltel2UpRrNyt9Q>
    <xmx:4N3UaAUeXWogU4XrThEBmbaFq7FPoDH3xgy2mF52clNwkVa0g6d0Gnyk>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 706BE700069; Thu, 25 Sep 2025 02:14:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AA0nVRjimp4N
Date: Thu, 25 Sep 2025 08:14:35 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Qi Xi" <xiqi2@huawei.com>, bobo.shaobowang@huawei.com,
 xiexiuqi@huawei.com
Cc: linux-kernel@vger.kernel.org, "Masahiro Yamada" <masahiroy@kernel.org>,
 "Jakub Kicinski" <kuba@kernel.org>, "Eric Dumazet" <edumazet@google.com>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kbuild@vger.kernel.org,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nicolas Schier" <nicolas@fjasle.eu>,
 "Andrew Morton" <akpm@linux-foundation.org>
Message-Id: <3de848cc-0f01-4999-a4fc-1ff3cc11daa4@app.fastmail.com>
In-Reply-To: <20250909112911.66023-1-xiqi2@huawei.com>
References: <20250909112911.66023-1-xiqi2@huawei.com>
Subject: Re: [PATCH v3] once: fix race by moving DO_ONCE to separate section
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 9, 2025, at 13:29, Qi Xi wrote:
> The commit c2c60ea37e5b ("once: use __section(".data.once")") moved
> DO_ONCE's ___done variable to .data.once section, which conflicts with
> DO_ONCE_LITE() that also uses the same section.
>
> This creates a race condition when clear_warn_once is used:
>
> Thread 1 (DO_ONCE)             Thread 2 (DO_ONCE)
> __do_once_start
>     read ___done (false)
>     acquire once_lock
> execute func
> __do_once_done
>     write ___done (true)      __do_once_start
>     release once_lock             // Thread 3 clear_warn_once reset ___done
>                                   read ___done (false)
>                                   acquire once_lock
>                               execute func
> schedule once_work            __do_once_done
> once_deferred: OK             write ___done (true)
> static_branch_disable         release once_lock
>                               schedule once_work
>                               once_deferred:
>                                   BUG_ON(!static_key_enabled)
>
> DO_ONCE_LITE() in once_lite.h is used by WARN_ON_ONCE() and other warning
> macros. Keep its ___done flag in the .data..once section and allow resetting
> by clear_warn_once, as originally intended.
>
> In contrast, DO_ONCE() is used for functions like get_random_once() and
> relies on its ___done flag for internal synchronization. We should not reset
> DO_ONCE() by clear_warn_once.
>
> Fix it by isolating DO_ONCE's ___done into a separate .data..do_once section,
> shielding it from clear_warn_once.
>
> Fixes: c2c60ea37e5b ("once: use __section(".data.once")")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qi Xi <xiqi2@huawei.com>
> ---
> v3 -> v2: apply the same section change to DO_ONCE_SLEEPABLE().
> v2 -> v1: add comments for DO_ONCE_LITE() and DO_ONCE().
> ---
>  include/asm-generic/vmlinux.lds.h | 1 +
>  include/linux/once.h              | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)

Hi,

I hadn't seen this until your ping and had a look since it
touches asm-generic. The patch looks correct to me, thanks for
addressing this and for the detailed patch description.

I think what happened is that nobody felt responsible for
applying it, between the networking (which originally
added the infrastructure) and kbuild maintainers (Masahiro
did the last changes to this bit, but recently handed
over maintenance to Nathan).

I've applied the fix to the asm-generic tree for 6.18 now
to be sure that it makes it in and gets linux-next testing,
but it's not my area either really.

It would be best to have another review though. If Nathan
or Andrew want to instead pick it up through one of their
trees, please add

Acked-by: Arnd Bergmann <arnd@arndb.de>

