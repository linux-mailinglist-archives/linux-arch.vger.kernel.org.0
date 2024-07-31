Return-Path: <linux-arch+bounces-5790-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B4B943687
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 21:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995BE1F219B0
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 19:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD354879B;
	Wed, 31 Jul 2024 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="edSl81qa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YLzgzcqS"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E7A1401B;
	Wed, 31 Jul 2024 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722454615; cv=none; b=O5iLGGvrvHGq0lxIRAYhV2GWWMYaHMysnjQOk4Cqk417Uvm+6HPiSl7s0tSb4//AgGFRfT7MNnDUx3lrDtxD+yJGkkn8p8D2ugAmEpcJCCpHFi8MaK81tGRLX126Y+ZGSwMtN2vYweMN8X7NUfI+MGWcY9AtQMT9bJGwlmuDN5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722454615; c=relaxed/simple;
	bh=A2ypCx6OZqmFdxZX0053g+WM3m1cHSSLnZjJyfcI9h8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gM4EyoC28ruP8sOhxui0ablPseTxTF48siRodu+pb8jeT5JKMte3nRsw1kCbjIuASY3gxreBfG87BAmMGQV0R2HIOd+zqJ+qWhuCjQmdSBSXDBrQ6bGPuMs4tDfXmY2E3BaBLnfUlSK1M1eBnBz2+tk1rLH0lxdWNt8fqgpX6XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=edSl81qa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YLzgzcqS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722454612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A2ypCx6OZqmFdxZX0053g+WM3m1cHSSLnZjJyfcI9h8=;
	b=edSl81qatmGTFb/6oc7NeZ6Mj7hxD+ajA1ALcOdBOM6mqSSvJZjraJNLqYEtSyfKu4BYy1
	ofyZmW1IjBqFa1yE1XRCi5caUOw6EP6uBXQ5DenQGcPApIyC/2Fhg3B/XGd2Rl7Z7Ia6gm
	xef6trlPr2eZGn7tYISjoKO9wHUBWtrSHNK49+tvCJ/0nZsxHXeGnnL3S+qLRH13zNvkuq
	Q3cQTU53RWQgGA52a3IXz1JsO7Bs5L9nOzIp2DX+XA7Z2zlt8zIKkNT8Jo9L8z3C//9yq4
	FMjhBvITcnu4DgMLqYwT8FbSxdQR9Xnzx0+5jujT8hab67sWOlebopQOriXsTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722454612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A2ypCx6OZqmFdxZX0053g+WM3m1cHSSLnZjJyfcI9h8=;
	b=YLzgzcqSpn7alTguPQ8xYRTxP5K4NFJPxGvcW+GABc7bFSzvA1rMpbF9Fjq0JDQ3DN2V4N
	8cMxX2J6Fp3hYDAQ==
To: Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>, Linus
 Torvalds <torvalds@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-arch@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] runtime constants: move list of constants to vmlinux.lds.h
In-Reply-To: <20240730-runtime-constants-refactor-v1-1-90c2c884c3f8@google.com>
References: <20240730-runtime-constants-refactor-v1-1-90c2c884c3f8@google.com>
Date: Wed, 31 Jul 2024 21:36:52 +0200
Message-ID: <8734np5p63.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 30 2024 at 22:15, Jann Horn wrote:
> Refactor the list of constant variables into a macro.
> This should make it easier to add more constants in the future.
>
> Signed-off-by: Jann Horn <jannh@google.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

