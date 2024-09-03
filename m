Return-Path: <linux-arch+bounces-6961-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FAF96A207
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 17:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3FF28A085
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 15:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BD4191494;
	Tue,  3 Sep 2024 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pvyz9wGF"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F016618F2D4;
	Tue,  3 Sep 2024 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376629; cv=none; b=V1FWtOR8PhzYPFuq3xApLIzo7mk6rx6Jm4ZSvjI3SfSRSEOtcH1+NkEowoU1774mWewBm13aVAZXZP9U0QvB9SVzBdOc9D7r70nvxEABJt/CTjsKC9X8LnJ87/HP1NQreVCx6HKhQzbJi+zGjsp/5S1fqnJQHy3+J4yImd04wlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376629; c=relaxed/simple;
	bh=yzP8ylj32txOclG8CPUkimzLIphAVlXEwtZnuZ0KRLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bm9IgEqpIBBdm22KWpRlcFixQ535yGyCJme1HrIS6Mvz5bwPa6twTq1TQKelLNwTmlKrrDggbBQPFfreQGXxdVnpeGS+c59ohgFEJ66rEfOEUUBZlgMqwfz7FlWHjC84H8lUHu5eiSj4MA23/texDQuNogT7f12TAIn5Zc+aNws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=pvyz9wGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE9EC4CEC6;
	Tue,  3 Sep 2024 15:17:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pvyz9wGF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725376624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yzP8ylj32txOclG8CPUkimzLIphAVlXEwtZnuZ0KRLc=;
	b=pvyz9wGFU+S+i5B07Sgu0AZyeZ4ZWXMGxNfoNUXKjoRcWBJGinXU5i5bEb7GRjbnG2GSVt
	1X60hGbxXIGWGtkXFlbUGICiFDUFpD8mlfhmtHigoG4Wd6Vfbk36cCkAFNvt/btHUA9yIt
	8i3FXAyPV1WVwEKub2azFEQhJt5HWkA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0e2f6d1b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Sep 2024 15:17:04 +0000 (UTC)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5df9542f3d8so4581559eaf.0;
        Tue, 03 Sep 2024 08:17:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWmnGg4WJycLdoUWyXK9X2YE+jY5vl4aLosJcGo6YWyeVYBHmOuJSJWGrieWFh+h2M41fFgHVx8zXqL@vger.kernel.org
X-Gm-Message-State: AOJu0YwsINhF+n0q7w3k1OMHDoIppGw1jMuI80xmHnxt5yBs/pnxOa/S
	S8wiPteProxqjr4IPZ80hiFyIdPZp36iQ1J6I73EwAhzVvKAxp37On01zuZ9AOmMANnp/UpZGdD
	cGXlI/s7UQ8dird9T4PctdAHneIA=
X-Google-Smtp-Source: AGHT+IEd3qZMU72H68mDlASWWXA/KuAd+aTzSL3vfI4ouWwWx0VqtJNxLrT9XS+PGGV87nsfiomYJRY8ZT/w+XHbahE=
X-Received: by 2002:a05:6871:29e:b0:25e:24b:e65b with SMTP id
 586e51a60fabf-2781a9ae348mr3001621fac.42.1725376622017; Tue, 03 Sep 2024
 08:17:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903151437.1002990-1-vincenzo.frascino@arm.com> <20240903151437.1002990-2-vincenzo.frascino@arm.com>
In-Reply-To: <20240903151437.1002990-2-vincenzo.frascino@arm.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 3 Sep 2024 17:16:49 +0200
X-Gmail-Original-Message-ID: <CAHmME9qvj9r71G3QOvQm8dqAsFROWGT0BDU=89MWyEUdAQbBZQ@mail.gmail.com>
Message-ID: <CAHmME9qvj9r71G3QOvQm8dqAsFROWGT0BDU=89MWyEUdAQbBZQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] x86: vdso: Introduce asm/vdso/mman.h
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, "Theodore Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

Christophe explained the issue with this in
https://lore.kernel.org/all/85efc7c5-40c8-4c89-b65f-dd13536fb8c7@cs-soprasteria.com/

