Return-Path: <linux-arch+bounces-12677-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18226B023CE
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 20:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8CB15C58DA
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 18:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F4A2F3651;
	Fri, 11 Jul 2025 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5ejUvB4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5E92F273E;
	Fri, 11 Jul 2025 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258933; cv=none; b=XS8JXxE7o3VHsilceL66NXvAa6nVztlLT/RbBXR0tl1aOitEpnGN9pkPi8Jv93U+SIfFuQqjU9kevoGJWymcX832hFvPhnYS2VP7+Q9j4Zc1lL9ap2ML4V0ElfqRqPwkhCRbrB8MR/YG43UYgsv96bG+HNz04HaJQBt8jn8zXG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258933; c=relaxed/simple;
	bh=Nnk/XGwHPiUD0lDNan2tVFDypdXvt3FmNJtRHDYftis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jjf5w56vsqw9wAm2rDmZLI4KSSb9X2aH8AleNvE3+GyWt8/9/TAdsrWQTCS6HrUavRJ3ucocggeamZ4VX0YdmaxtZoDQopbaS+8v8UyUnvTI4QB7VnUNyUtU79+7TouI5Zg3GgR7Yi/LlcnV+0EtGQot6RACfpxL0jMX2UfXeHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5ejUvB4; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-313fab41fd5so488364a91.1;
        Fri, 11 Jul 2025 11:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752258931; x=1752863731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nnk/XGwHPiUD0lDNan2tVFDypdXvt3FmNJtRHDYftis=;
        b=h5ejUvB4iWMJhLmJo1dEd3MI4d3Cbte6oF8HDcKMFzhSwT8NpRm2CKR/OdRB7/2T1T
         9noiwS1w53hWZrO5/u3x0lRQ1NqhB3gDfa0c/R/a95i4AhORMvmFuFosNa58qWaju7AD
         luBO1k491s2khzfPGWItq3i2S0JER8hd0KXIbLqawXDW6XfsxMEGx14abYyRQyS0+qEM
         kLNPacNR0hqfQUvcG/r3PINQt/PhmYK5RHT4aifwDKjr2tgCdhyQSA0g93IoQXzq5gnJ
         aU3x5oQkGuGGX/aMPKFz4ya8TO/Ccz5YaGuXMefgX4A3Mzn2eRK3Sg/vb97LognyWqNJ
         PsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752258931; x=1752863731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nnk/XGwHPiUD0lDNan2tVFDypdXvt3FmNJtRHDYftis=;
        b=ugG+50LoctsGmaorKjNmaXov3FCqTXVNiSlN4R5wzPeVG1wC2RQd/vkms7X88a9a3N
         O+LaRaidX2XW07K1YppbiwmANVz89BT4ew/Vl1pCFNVclQsGIxCYt56zev4qoRkr/fgB
         IdXLfEHCbTWnmVjA7TEfSpwrm5oO5jyBMh8eSiyjtN80zefGLNJdLyWofQzrlb7zTgep
         +3i3savKxYoqVruzF6dDwQwu9ym85bs2FJG41kJNDDecP9+k/5aw64HTn0XsmKB/+3wP
         pC7BLKZ8vyNv/ZfkhwWismZTBSaKKmWoH09BmKb+WEY/NgYgylkk9v8QMpfmNnGtq8Ex
         Lxyw==
X-Forwarded-Encrypted: i=1; AJvYcCWHKRS0MpfShE2GlItchdA0Fyz7Cn2OYCyIxFhXvDTBLKC+7QhvTvNl7xDb9VqqO6lXQ9bvW3ssS8TOfrlV1GQ=@vger.kernel.org, AJvYcCWRgjA7z5yP2hyVlWeLkWPlf6m02B5VKD4YkvswdlquQSxnHjpGSag1vjxmYBREC8aqDH8ykkackyHw@vger.kernel.org, AJvYcCXV217k/uSZSUQYZ3gfLt5RLX11rMduac7bMDxALly9IIcAC2ajFnhmMYFoAiK3GTg2nEarUyEMNC8r4q76@vger.kernel.org
X-Gm-Message-State: AOJu0YypbF6f3tkdcV6URDe8Pc9Pwql1U9eirc8KiTeY+XZS5rzheTd5
	rnFJmDTofPiRzC7eH5zYZRtqMO38IDF90XN4RkAr2zSZIQrUWg8d0YSk148WX0AQuPbdr1ssB77
	ifCq3qeSRf9Al6slclDezhBLSQVobCQM=
X-Gm-Gg: ASbGncsE9tNWEdpMQFPJJZuk3Ew20ViQVote7fOAsJFYkS3Qgf2MRH1rZYOOZRQA02g
	4rQ9UjvEXMrdggVOtfC7adezEcYUX77GhCagn64Z7kejir8GZ60wHB+ChQHvW7czueZmra1n+DK
	OmWASViGRVaFfyfOyJ/BpoqUzgQ9dBOohHIo2d61iiao6G9eSvCxVxvFJH7Mn4eUS46vAnTg66U
	uOrBcRA
X-Google-Smtp-Source: AGHT+IFdu4P3gbr8jvRULTRTMc+I1fag/ZOAwbK9fM7UQH+JY9maBUmCSu1LiearbfL5q3wUS3fTxkawFpOTfX0eTVs=
X-Received: by 2002:a17:90b:2e8b:b0:311:c5d9:2c8b with SMTP id
 98e67ed59e1d1-31c4f540066mr2104181a91.5.1752258931399; Fri, 11 Jul 2025
 11:35:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710060052.11955-1-boqun.feng@gmail.com> <20250710060052.11955-10-boqun.feng@gmail.com>
 <DB93Q0CXTA0G.37LQP5VCP9IGP@kernel.org> <CANiq72m9AeqFKHrRniQ5Nr9vPv2MmUMHFTuuj5ydmqo+OYn60A@mail.gmail.com>
 <aHEasoyGKJrjYFzw@Mac.home> <CANiq72kvZ7-fMoE9g7SBUrBZy4QMbSL1p8KgBqGhOkenrsr=3w@mail.gmail.com>
 <aHEx85VKv4F_9S61@Mac.home>
In-Reply-To: <aHEx85VKv4F_9S61@Mac.home>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 11 Jul 2025 20:35:18 +0200
X-Gm-Features: Ac12FXzmhAWZAkjX5xQzsRISqFx9ayq4uB2VwF5ENzbOuWKuP9kZr-GbD5DMCb0
Message-ID: <CANiq72=ow6R72EaEC2Q4J7EfvfG1qMv-u5NdDV7YMMuLLmZiVA@mail.gmail.com>
Subject: Re: [PATCH v6 9/9] rust: sync: atomic: Add Atomic<{usize,isize}>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, lkmm@lists.linux.dev, 
	linux-arch@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Lyude Paul <lyude@redhat.com>, Ingo Molnar <mingo@kernel.org>, 
	Mitchell Levy <levymitchell0@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Alan Stern <stern@rowland.harvard.edu>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 5:47=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Seems good?

Yeah, thanks!

I will send the other one about 128-bit independently.

Cheers,
Miguel

