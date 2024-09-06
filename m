Return-Path: <linux-arch+bounces-7092-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E6496E75C
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 03:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7E31F24569
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 01:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B90EEB3;
	Fri,  6 Sep 2024 01:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FcA+igIn";
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="tNzq3HG+"
X-Original-To: linux-arch@vger.kernel.org
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062AD1B969;
	Fri,  6 Sep 2024 01:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725587255; cv=none; b=rLFlHuFLCcM3/ScdeHC7HaaUvtXMaK9pr4GWJl4KeEFQsY6UXihr1hOQ27mEq+BFZwNgWcScjNptjwSSsizS2BXytYdlsrmMCsvTEI7E4I6l4FrnO4/ZaK0Fvlt27veTE8ozGmeRrHxgJPPUPD4fgiefKarjKBC/ifXc76fT0oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725587255; c=relaxed/simple;
	bh=waanMjzHKoTnpZo5MHgMAAvycu4b+6/KogsO8+Z3Dfw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=f12uKSnScecVUD/Czh0S7+tMPcYSP6sKGzPFr7bUpwcozETNXHQNdoLukETf/vtyrzylfTJcR/JK8CTPyza1f44muLELb5zyIyN/xmuyLQ+zzcIW9WJetlDgUZiLaxG8Xr1LKO7lKPB1VD0IaJ2TWx0u0lz73/S0A0ncTh8yptI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FcA+igIn; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=tNzq3HG+; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B524F32A18;
	Thu,  5 Sep 2024 21:47:31 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=sasl; bh=waanMjzHKoTnpZo5MHgMAAvycu4b+6/KogsO8+
	Z3Dfw=; b=FcA+igInD1hItBkIHMAZ6LQ0g2fy/5Q8FTm0mWnSWOeb7CWcSSXOpT
	LKfklPYCZnSoqxaW2vqtx7qUnX06kcs48ooASqQd2wjZbnO9qCw6q8Fmj9O40/dJ
	YTai6qSFOBJWFakETmz7Lh1JJufvsJIfyueOva/CPlszEMiYLVtnQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ADD1C32A16;
	Thu,  5 Sep 2024 21:47:31 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=waanMjzHKoTnpZo5MHgMAAvycu4b+6/KogsO8+Z3Dfw=; b=tNzq3HG+OL0j4T9k13CRAyVAZ83YzgOjRmRFi0dMetpOvkx9yn2MZZSzT/cBDDBIg4FUQQxmTWsCYnJNzOPS+d4EqCwMofBgVYSrONCfIKtFc48UJeZQIniamW9MPmszVYyjky8rHafqmcxMK9grqZjTlNrais+Lw8XmGfB+qfE=
Received: from yoda.fluxnic.net (unknown [184.162.17.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 12BE032A15;
	Thu,  5 Sep 2024 21:47:31 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id E2033DDA591;
	Thu,  5 Sep 2024 21:47:29 -0400 (EDT)
Date: Thu, 5 Sep 2024 21:47:29 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Arnd Bergmann <arnd@arndb.de>
cc: Russell King <linux@armlinux.org.uk>, linux-arch@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] do_div() with constant divisor simplification
In-Reply-To: <20240708012749.2098373-1-nico@fluxnic.net>
Message-ID: <r8r3nno4-45r3-09rr-797q-3o79s35n91ro@syhkavp.arg>
References: <20240708012749.2098373-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID:
 FACEFBC8-6BF1-11EF-8628-9B0F950A682E-78420484!pb-smtp2.pobox.com

Ping.


On Sun, 7 Jul 2024, Nicolas Pitre wrote:

> While working on mul_u64_u64_div_u64() improvements I realized that there
> is a better way to perform a 64x64->128 bits multiplication with overflow
> handling. This is not as lean as v1 of the series but still much better
> than the existing code IMHO.
> 
> Change from v2:
> 
> - Fix last minute edit screw-up (missing one function return type).
> 
> Link to v2: https://lore.kernel.org/lkml/20240707171919.1951895-1-nico@fluxnic.net/
> 
> Changes from v1:
> 
> - Formalize condition for when overflow handling can be skipped.
> - Make this condition apply only if it can be determined at compile time
>   (beware of the compiler not always inling code).
> - Keep the ARM assembly but apply the above changes to it as well.
> - Force __always_inline when optimizing for performance.
> - Augment test_div64.c with important edge cases.
> 
> Link to v1: https://lore.kernel.org/lkml/20240705022334.1378363-1-nico@fluxnic.net/
> 
> The diffstat is:
> 
>  arch/arm/include/asm/div64.h |  13 +++-
>  include/asm-generic/div64.h  | 121 ++++++++++++-----------------------
>  lib/math/test_div64.c        |  85 +++++++++++++++++++++++-
>  3 files changed, 134 insertions(+), 85 deletions(-)
> 
> 

