Return-Path: <linux-arch+bounces-14881-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40322C6B339
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 19:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E6354E1547
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 18:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184E035E527;
	Tue, 18 Nov 2025 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jS8TyPx0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B55328632
	for <linux-arch@vger.kernel.org>; Tue, 18 Nov 2025 18:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763490363; cv=none; b=ClyksKOac7/AlfEL1fl7akrFpou+Em0e4xqA7H7qDdSy5G2DWIf7UBE2EZmntXZfsAoyz1tul0HtMJBJx3LFyFHm3DUL4BqPI4Z8Rz3Y0OvQNxkZe1OqnIKzZWxxu/If1mRCH51dR9S83FEe1y/Y7GpOwgtiGnwTqv2/LZLNJiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763490363; c=relaxed/simple;
	bh=q1VzzOGvp4fwVAg7h8kZp1x/zCovYNVzplz0g7BwT5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdXXE6SIV4306TwiZHf/4eRIEJns9m6DgRjUPIPphEWAh7bPpNaPJqcz+3JViNRPh0o0BRLpUe0lYp7EEA/4lBfMGe5VfimLGTQfYaXTMonCtU15qc62xhojjFqkgfZeMF0AUlgKqAuPfBGD75n4djeQKErtaEjswtw4o+u7+Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jS8TyPx0; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ed67a143c5so27561cf.0
        for <linux-arch@vger.kernel.org>; Tue, 18 Nov 2025 10:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763490360; x=1764095160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1VzzOGvp4fwVAg7h8kZp1x/zCovYNVzplz0g7BwT5o=;
        b=jS8TyPx0wv2Y3zIxxKjKxPT/U705BFDi5tIMDh9VknaXO114zQDik72c9xLesS+fn8
         9PG3V1s2gD9fZ+HZBZAboqFKdZUTiHMSmeUn6NLcMBoCCqHPhDqMMnYEXIUdOSFdsNFy
         giFC6NqUtqAhZPYGTRV736K2lGblyQirnyLd6UmcsYW6uVOF0qUxS67+YGHHmFd7wuI0
         mzw4bDoXXZye7AgCCWkm5TFIbisbUUY7sSRIFq9waDYg5MMSArmTt/tPdD7SsBH8ncsb
         Ef+ioaaO9le4YwaKXI3/+Uh1HC/Ns5ZkYxdd9NdqzPm6Hndqcymb7IFAqhR5dgUew95a
         O9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763490360; x=1764095160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q1VzzOGvp4fwVAg7h8kZp1x/zCovYNVzplz0g7BwT5o=;
        b=tqYSprB2eze1Cbywbbrj/iVH5PCYR3Ne+okyWMCdsTzumHwYhOxuK6ESmet+8m2YNb
         SSMZwfX6y1oMO8aNjqhAQtafsQ5sfD4jPQhZARZqXjmc2R73gRefUCXl6Wu/E1mTHzz3
         f8r/zKN0IVKNqUqKxNXP7B3pnNpBxqWVtI+DIi1MxoUSyyNqQy9Zp/c+FmGytULGfpPr
         m+2gkEXZ9CIiGbah61fynD8BIRRAMKSDbEHtw6BWmfy26/7JVhRjUqEPZB3VMrqn5SW0
         s6bloUYTBGYQ4/X8bYYhS+NjP51kUbJzj7iX6NjKKRYwtve359vrJvqlZUb9yLamTgs5
         VTPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpq93i7wwatNuEuY0p1VkIDsbD8++l4i1Mhvg93bms/9oX+lEgtIa8gALyUESCyJsQ/Sc1e9DH2nhq@vger.kernel.org
X-Gm-Message-State: AOJu0YyszBcoz6ne2jlmtISjXcPppvkovz9JPP0OsBsU6EQfAngvFOU3
	Q716dC0cfdYx8VfBgrPGxU5Hj5q5XKwIqvU2bFtgCoVn+rXOLM5qH/PE0bIWd3RbAF8hPd2oi6n
	wxaSVuFtvPcSsTRVtaqehYYaTSmDyfWepaeT+ENbL
X-Gm-Gg: ASbGncssEY6QJ2gVL4hqd4Ig6+isGW/RKADv6VoUIaEqX2rn0R6uLGKbgM8yNVUDUjJ
	13zySsV0WT64fETIvK+282SkjzZKBzlxdTqwVYtyBKkveoZmEEf6OeUfa/iL4CFV7ZAmJibcdgo
	6gQfOxuGCv71BGCgeZLflR5Pgo5PsTVkFp3r+HN8fvQleWgwrvmPCfQGu2DsT3H2I4LgcrlCDP6
	mc3fF0JxN1J7VipmOJm8MiSPjJslknQ8R5oK8M+oIWXaEV+W/Lnzyg7fDbp4evhWvrWvyH3
X-Google-Smtp-Source: AGHT+IGVElTtL4/i+smzItaWJDiu3+prrt7JQFQrGjQ0qMoHFXH2Gt0z2VJENRbxmg0Ns+4cd7el6ofKhTIM/Db3w9w=
X-Received: by 2002:a05:622a:4d2:b0:4ed:7c45:9908 with SMTP id
 d75a77b69052e-4ee3eb9b15cmr232771cf.10.1763490360082; Tue, 18 Nov 2025
 10:26:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116182839.939139-1-lrizzo@google.com> <20251116182839.939139-4-lrizzo@google.com>
 <87seec78yf.ffs@tglx> <87bjl06yij.ffs@tglx> <CAMOZA0+rA-ys1JSb=GxpPEFS7W8TJGz23gSuUWi0Kv7TX2FfSg@mail.gmail.com>
 <878qg37n8p.ffs@tglx> <CAMOZA0+K73YbPqq_vTS2sMkbV-0Fh5GSCt3ABfReV3DYk1CO2g@mail.gmail.com>
 <87pl9fmhe5.ffs@tglx>
In-Reply-To: <87pl9fmhe5.ffs@tglx>
From: Luigi Rizzo <lrizzo@google.com>
Date: Tue, 18 Nov 2025 19:25:23 +0100
X-Gm-Features: AWmQ_blDMC2aOKuZe0GArzWOO3JPuGXljGtUzykIOs_lb9uMHkQlqochCEo9GZA
Message-ID: <CAMOZA0JXv1ERyGOJ8fmwefnc6XKbGGy-E4p_d+BFr6KPzoOUZw@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] genirq: soft_moderation: implement fixed moderation
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 5:31=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Tue, Nov 18 2025 at 11:09, Luigi Rizzo wrote:
> > ...
> > (I appreciate the time you are dedicating to this thread)
>
> It's hopefully saving me time and nerves later :)
>
> > ...
> That's kinda true for the per interrupt accounting, but if you look at
> it from a per CPU accounting perspective then you still can handle them
> individually and mask them when they arrive within or trigger a delay
> window. That means:

ok, so to sum up, what are the correct methods to do the masking
you suggest, should i use mask_irq()/unmask_irq() ?

thanks
luigi

