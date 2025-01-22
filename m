Return-Path: <linux-arch+bounces-9862-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CF4A19BA2
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2025 00:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD8A188D0DC
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2025 23:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055931CBE96;
	Wed, 22 Jan 2025 23:59:13 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768821CAA98;
	Wed, 22 Jan 2025 23:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737590352; cv=none; b=ry1IYyRryanHucrcroz9ZRCU0aK2FxYzEgySH6s/b42I0Ei+ACQei0X9C3axwAIBJApr4A2vmj1NrJM/KKbcO0hJZ0VrBjIE1ci3ZPwlyI628F+BrDQKpBGx4fGwxCuCDJ4z+tI+sABOYkaV/7UuJ8UFAqwKq3p/NuHA/kl8Tqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737590352; c=relaxed/simple;
	bh=c4NBJpmSmeXWwTS/4eM2Sqi9KPCjxEtJE64CtY9LkmE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=OQsiZWCr+zKh39ZDtplrPV5mjxGjLmVE9cBkzObyTS0uZtOAd8lQMRubA6YC69K9duO3VjpifioalHVao5oBTjSSJV8WVHqyV+qielamxDBL9Pc+7d3fytkPQGK6pUsFI3j/qj+dTuHRO6Fe1r1DBQGLyTTmN1audlnFqzAdmUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (unknown [82.8.138.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 47AB0340BEF;
	Wed, 22 Jan 2025 23:59:08 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: xur@google.com, Michael Matz <matz@suse.de>
Cc: ardb@kernel.org,arnd@arndb.de,arnd@kernel.org,jannh@google.com,kees@kernel.org,linux-arch@vger.kernel.org,linux-kbuild@vger.kernel.org,linux-kernel@vger.kernel.org,masahiroy@kernel.org,nathan@kernel.org,regressions@lists.linux.dev,shenhan@google.com
Subject: Re: [PATCH] [RFC, DO NOT APPLY] vmlinux.lds: revert link speed
 regression
In-Reply-To: <CAF1bQ
Organization: Gentoo
User-Agent: mu4e 1.12.7; emacs 31.0.50
Date: Wed, 22 Jan 2025 23:59:03 +0000
Message-ID: <87frlaxuwo.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Can you file a binutils bug please with that reproducer and the bisect
result? Something smaller would be nice but isn't required (at least for
an initial report).

(CC'd matz, full thread at https://lore.kernel.org/linux-kbuild/20250120212839.1675696-1-arnd@kernel.org/).

