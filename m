Return-Path: <linux-arch+bounces-12580-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 753D9AFA7A8
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jul 2025 22:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8282176795
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jul 2025 20:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1972882A5;
	Sun,  6 Jul 2025 20:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="coIZzHni";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nqs0sa/L"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860E02E36FE;
	Sun,  6 Jul 2025 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751833596; cv=none; b=ViPQahluYdoVnJT/E5m8s02+t36TjtHLOuWutqhjqB4fdIATSzME1M4oL5GCGO8RFBU2ayFqiRfTApe74FZM4qSN92U7WWQ0qqD85BKMN7XD9z73DsvsP2NRAx04yMLK4ApxH+CTABfOa154CYqBdtglizfhZ5xAO18NOz/41y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751833596; c=relaxed/simple;
	bh=usgtwnYV2zSW+LtzIHeU7+mGrxPq/yKmMHF6FWzP6z4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uEdXV1aBbOk6U5zS0FFY9gdMdMxi/UwiDRU7ask4JQAzOBgzByX4mJ0kQCnJwHQ/6vuyZFsQ499mMFTl4pQbv8DWoRn2SPMf+y+nEmlluDmT2fGDn+VJCCmMc866K6U4TuJzppy6jRxjU1fySh9V7DMAi+NK6mM0vui5UyIjnec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=coIZzHni; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nqs0sa/L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751833592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e1Im/IBNO0y7hI7V+On66xP1EYDvFOgnxomSyh9iREE=;
	b=coIZzHniJqa9x3uqEcYBcBh6IFco8ufa3Rl6nK5J9/1KHfeE7wh567Qg69/3tQHX56t8MT
	rpQlAQS1vES6w2KZEBsJF5cZ6RVFJ3WXR4Y00ANrrHS8vQ3aDNsb74eNTEaWUpqM1iHBLr
	f5NtH/m+mC8gc6TeplIESxle85pjHdN0RVin/bzNQJIyZ4e1zFh4YUSvxM6H7siJbcGCk8
	S8DGx3qKzLCdQUsKnDlX8VOqwSEMnTeVaEmRl2jngSPDbK+54tF6MLYI8SdbwzPIoI0Dro
	NDLTjxROwWEyKK0OSr0/HEjuIYjuLmFu0ioF9PpUB25x5dFbJFZDsjcr37Ev8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751833592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e1Im/IBNO0y7hI7V+On66xP1EYDvFOgnxomSyh9iREE=;
	b=nqs0sa/Ls300GE1wwnRZMFCNZwbj0GF4RFOMIXnc+Z+pDrx+DuU63uVOI7JLmO9jQsVnGS
	wXipWqz9uLDpyRCw==
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Andy Lutomirski
 <luto@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah
 Khan <shuah@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, John Stultz
 <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Richard
 Cochran <richardcochran@gmail.com>, Christopher Hall
 <christopher.s.hall@intel.com>, Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Miroslav Lichvar
 <mlichvar@redhat.com>, Werner Abt <werner.abt@meinberg-usa.com>, David
 Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>, Kurt
 Kanzenbach <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>, Antoine
 Tenart <atenart@kernel.org>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH 14/14] selftests/timers/auxclock: Test vDSO functionality
In-Reply-To: <20250701-vdso-auxclock-v1-14-df7d9f87b9b8@linutronix.de>
References: <20250701-vdso-auxclock-v1-0-df7d9f87b9b8@linutronix.de>
 <20250701-vdso-auxclock-v1-14-df7d9f87b9b8@linutronix.de>
Date: Sun, 06 Jul 2025 22:26:31 +0200
Message-ID: <87cyadrrpk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 01 2025 at 10:58, Thomas Wei=C3=9Fschuh wrote:

> Extend the auxclock test to also cover the vDSO.

I'm not really convinved, that this is the right thing to do. Why can't
this just extend selftests/vDSO instead of creating these

> +#include "../vDSO/parse_vdso.c"
> +#include "../vDSO/vdso_config.h"
> +#include "../vDSO/vdso_call.h"

cross directory oddities? Confused.

Thanks,

        tglx

