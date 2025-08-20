Return-Path: <linux-arch+bounces-13225-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24849B2D59B
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 10:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A4F27A1DAB
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 08:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED432D6E6D;
	Wed, 20 Aug 2025 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w00Abl7L"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896DA283FC3
	for <linux-arch@vger.kernel.org>; Wed, 20 Aug 2025 08:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677053; cv=none; b=hxO5RWD3jyNAHzvEort0DYa1C7ybSlqrkvyc4P/qlyik3WolFgLdHjPfiiDHyltspH5j9DJyZxd89som44ozq5UqfAJtKKuqv3sGxrXplpDsJ14K5sTPz55N9OTZnWmn2Bs9ZOCUftsd0nCvVEK/rDUvSwpMGjBzwkBvmjWzw6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677053; c=relaxed/simple;
	bh=rbFXFjw4n1QivhuWIRmAWtZ9fMtej7RhLcACXFP/i3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nno0qkxSgyxQ3QgQUfbbJGQbzh/LhY4qDSIax+DWL6o5YSRV+nGSUcbpqj2XAfTLtcGXw0wzPDNERKkm77R0/kQlyih2IM6/TXJbHRrgdw690Z0N+qmKIberEbvQfWLXDsqdHF0DqEIT5DsYKXf+robG4FqSpyw+PQEtP+Q9RjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w00Abl7L; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55ce510f4f6so6590254e87.1
        for <linux-arch@vger.kernel.org>; Wed, 20 Aug 2025 01:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755677050; x=1756281850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbFXFjw4n1QivhuWIRmAWtZ9fMtej7RhLcACXFP/i3Y=;
        b=w00Abl7LIysvda5RITxZ3gyLq4xfappFa16LgbiYLPykC4dnMwAOUnsC/xSBnq7nW/
         qUU3yqZBVi7rfxH90gQ5a7pra1XDv1lIB9MS8r8MxKzWYF5GS7awXgROujXmCF47gCrQ
         oksu2jb1sZCFRD9qKTPEqZ5HuMy4Kbw2u/mkPXuU2jenNXN9aPtMsHjkibtHPMvB/CsQ
         7yhAuqMmnf7vf+MIYqZQKHI1F02/kuJAZ7nKGF56KGmtIDTHeliKk7HlaFFSEcLm+k5x
         W/XI1SLMshLnGDimdkgy23AeeBscKCQ22lJlFHJWoRCpgqH4jlGnbjcoE2HdMJpHbwdE
         zu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755677050; x=1756281850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbFXFjw4n1QivhuWIRmAWtZ9fMtej7RhLcACXFP/i3Y=;
        b=gf3iu1wNNg9l5zWEU/JgguRiO3ryKx7NfPohJvnB5GDFdc5dL1+CO/MXKlXWbGvrET
         0rr/ELn4MVBUnjupsa+fu9Rm7q3IhWPhlcqVd+L2If9kl01o2UFsRavOuLBYQLuyZgn6
         zTiJlTcz1ZdRP6obUXIOCtnq9XBAPk6Kj9Q9S7V0h3o4zdgluBdl9ZE2/85EuGVnxA+n
         /PRZZLbbU1R//xQFwrGthap3qQvlZkqOqkwwaoL7pPvuHAWnyIQdcLXa3PljtllQzg6z
         HSo71RKETJCxcALDpApRhZzpjGaVJkEwIZaaUgKkcazFnwo4KBdav/wPp4keGgzJ7fb2
         9uxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfEslf8RDalmI2U/1iqpAFFlfuMLxsUeJUXGSgH37ktGVHub1O6NBCuGdQqLaQYhCsDEdNbATGDL6b@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm0QX4R10tQx5ypRUaLDP2fas6trCcppOHpWLt3jtOG3ZlUrhS
	6dWO1XijY/Pmg7cRzCwM8Qt6H2NiEGD9EAZs+grdZBLBaggxg5reDBhHmDUp6aTe7ktrrHoT6js
	caBIuaw9ioNBg1mE0rHWVnbT7ubNve/ibwn5lh7M=
X-Gm-Gg: ASbGncvc8td/4mxtV13Wswu9A5G/x1onCq3Y+G9vmmA9jDDAuvnmHRKrUE67KXTcTwa
	1IIHvpgbLHowNrQhPrti9Hs8IlI6y6PinmE3ESVPUnSbVxEu+YdNVXHKOex+vqp9yTSuaCaHjyU
	pM5yWNnKKd82Cg/zK0K5HMBKi1QdKD1dxhuhlofhaCXisDaHc30sLmkAACl5UVV+DW4u9UTiFtR
	RJfkdVaQ5LFoHairacHQQLJoXo3owrgsLpmCPF9HVWc8dead+2XIg==
X-Google-Smtp-Source: AGHT+IGVK1oPtxH4WR1xR8qF9qbjjy/dcR0lYEGwtgT9scAs4HhXg+zq6box8q/WjPnqcqOrs9UAS7T3jjVlqulmz2U=
X-Received: by 2002:ac2:4ca9:0:b0:55b:732d:931 with SMTP id
 2adb3069b0e04-55e06b2dd6fmr405525e87.12.1755677049307; Wed, 20 Aug 2025
 01:04:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-vdso-auxclock-v1-0-df7d9f87b9b8@linutronix.de> <20250701-vdso-auxclock-v1-12-df7d9f87b9b8@linutronix.de>
In-Reply-To: <20250701-vdso-auxclock-v1-12-df7d9f87b9b8@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 20 Aug 2025 01:03:56 -0700
X-Gm-Features: Ac12FXwkxxvaSnLooTWKfhclqEnR_RwAuKEDNHPFBz1DnCC5Fudpwl3wjm0bVsk
Message-ID: <CANDhNCqvKOc9JgphQwr0eDyJiyG4oLFS9R8rSFvU0fpurrJFDg@mail.gmail.com>
Subject: Re: [PATCH 12/14] vdso/gettimeofday: Add support for auxiliary clocks
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>, 
	Christopher Hall <christopher.s.hall@intel.com>, Miroslav Lichvar <mlichvar@redhat.com>, 
	Werner Abt <werner.abt@meinberg-usa.com>, David Woodhouse <dwmw2@infradead.org>, 
	Kurt Kanzenbach <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>, 
	Antoine Tenart <atenart@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 1:58=E2=80=AFAM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Expose the auxiliary clocks through the vDSO.
>
> Architectures not using the generic vDSO time framework,
> namely SPARC64, are not supported.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Just as a heads up, I've just been bisecting and this commit seems to
be causing problems on arm64 devices, running 32bit versions of
kselftest nanosleep or inconsistency-check tests. Running the 64bit
versions of the tests are not showing issues.

From my initial digging, it looks like clockids that aren't vdso
enabled (CLOCK_PROCESS_CPUTIME_ID, CLOCK_THREAD_CPUTIME_ID,
CLOCK_REALTIME_ALARM, CLOCK_BOOTTIME_ALARM) are somehow getting caught
in the vdso logic and are *not* falling back to the syscall (stracing
the test I don't see syscalls happen before the failure), and the
values returned don't look to be correct.

The inconsistency-check output looks like:
# 5983032:0
# 5983317:0
# 5983561:0
# 5983846:0
# 5984130:0
# 5984415:0
# --------------------
# 5984659:0
# 2009440:0
# --------------------
# 2009724:0
# 2009969:0
# 2010253:0
# 2010538:0
# 2010782:0
# 2011067:0

Which hints we're returning nanosecond values in the tv_sec field somehow.

Reverting just this change gets things back to working.

It's pretty late here, so I'm going to try to dig a bit further to
understand what's going on tomorrow, but wanted to raise this in case
it's more obvious to less tired eyes. :)

thanks
-john

