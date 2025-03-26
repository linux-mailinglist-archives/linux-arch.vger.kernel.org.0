Return-Path: <linux-arch+bounces-11151-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCBDA726A4
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 23:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943093B1DB7
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 22:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA04025F780;
	Wed, 26 Mar 2025 22:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eKFe6WIU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CD91A3031
	for <linux-arch@vger.kernel.org>; Wed, 26 Mar 2025 22:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743029465; cv=none; b=WT1D8CG9vpS0edB0cVlOkvTs6kepX99qWD7VkG/WSc8R0lzAVJeEHT/WmAYQJraIQlJto+5rjPGkupBJXH1IuuSnSKRYjyIa/Pm5tvlmbYUMyrSzQMl700aSIphEe1lsQs1n22Eeo4754zwMwoq9WQzfAgRDxll7DwMNykfQCVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743029465; c=relaxed/simple;
	bh=BOrvvv43yXOr35sq4KdL4n+0WD7H6VNVRPs2SXLF+Kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sxn8wFivZPYnm+4EctNlUc4R03BZ2Up1WUv+ftFe+ppIbliFDavbA3yB8LY2vr9dTfoCnTaZDPpWK5/6VnGqNezA6OpNXa80FfqNK/1DGt0b2nXIoRc4ojzdRXCk3r7EJ8Vi7qdmnRR2PeSU9lfdyrlvYi1fYQYAQ8dmgpCZj0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eKFe6WIU; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5cbd8b19bso1926a12.1
        for <linux-arch@vger.kernel.org>; Wed, 26 Mar 2025 15:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743029462; x=1743634262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOrvvv43yXOr35sq4KdL4n+0WD7H6VNVRPs2SXLF+Kc=;
        b=eKFe6WIUhSy4OnFrSoaaoTMC7u2p/+Tuw1so3enyFelI6m1jftcfFvMDZA/OwcPFZL
         cTmQG6fC5rDiDLG8v6DjK7QHvALCmdJE+MuswG0TKabGUTyXZQdh9U9YI+/QQsOMiDYK
         sXix6/TvyFE4Wx3+Fzb/aEz/Q36W5FdaOI8xm1slZPokzmInaqpDhFUSPQuCrFaRFIF3
         4LOf++2hjrfFbq65POCBmdMD61vG0CWhuhrjDRUSSIL45fqKFDkPIpSaVgjvEbT69WK0
         qpA86kg+DLj+cyTvXckrEvYskpiJlFcx6IU+3wzZSavonItMKEGyLrmSUjcY7FG/vpff
         5YnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743029462; x=1743634262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOrvvv43yXOr35sq4KdL4n+0WD7H6VNVRPs2SXLF+Kc=;
        b=uZ7OeL9Bd78jmdu2yygHAzx12fk0rv2hucpNrfa76zP7slsZs/fu9UJaB3iP6BZXs/
         Oyb5Og0dWOx/mR/RZaZkolvqnnT5qknzXNwvHqWsYHsNeAOe5rI0v5Nr9pPlUibcF0FU
         VfFcAtQ/7lFQsGsTUexmZMRfPR/PEuaiUqYWT02VJFhbICGx+U5SAVL2FJdeze1FT3O6
         x1WOMPWoYT3ti6VqT7KxqIMdLBRzJCPVHdUMMIT/hcZ25HqohxF3A1BGmw8JhXmihsTp
         hDqk1eSxKwVZeO6kIczBCED6Ff9vLHwK2EKlmUi+DYsna1GS/hco9f/yOFSc4/JwKnIL
         QTaA==
X-Forwarded-Encrypted: i=1; AJvYcCVCMwHVA1eBRale+vWfpewHAnGcMI6fxJH0UNuVNapPiFpPnLjcvilh7b+Pmx5B75bv0Rm8dlhNba5a@vger.kernel.org
X-Gm-Message-State: AOJu0YzfMXuNKoY2nhaxqArbXmQdzjMnqjRpJHX89XqrVVxgfYccUbNx
	QxtHpm3ZUprcb7jv2vh0z3EmQmj/z8jmQpnaDcDCiZDI+Ou5A0esRYby4/dYQnhqcoa25eTolT4
	HX6db/gB2vUuhHLEmfbWn7qERNl4IolqtOSjK
X-Gm-Gg: ASbGnct1E5HRYPySwSGURuyAHsAYBPL9hFw/l/J1jMLpMwPqlXDMLl6oUcRFoFDnevA
	vrZyG7h15pW68mUUIVw7UsPLrYGptmgKCQh4ZNXKiVx+NoFN6JZeNN1zi3NcJmzhXkG03JHCdnb
	cCOJrJVMdPi+gvZDzGuTIb7sCxBgA1lwH/lX9ncosQ1m8/SAxUnvsRd/I=
X-Google-Smtp-Source: AGHT+IEgsOrfzjqoOVaCRUdXQZMnKM69qndvLDnySVU6Gn6KZ7HyRr93TDhl95KuAmAY4T7CRqnhsb8l97t1WcVAf/s=
X-Received: by 2002:aa7:c954:0:b0:5dc:ccb4:cb11 with SMTP id
 4fb4d7f45d1cf-5edaae205aamr19582a12.4.1743029461262; Wed, 26 Mar 2025
 15:51:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326-rwaat-fix-v1-1-600f411eaf23@google.com>
 <4b412238-b20a-4346-bf67-f31df0a9f259@app.fastmail.com> <CAHk-=wikuhxhdSEgqb-Lkb2ibQM_hAHR1Cu7yxg-gHZu1NF+ug@mail.gmail.com>
In-Reply-To: <CAHk-=wikuhxhdSEgqb-Lkb2ibQM_hAHR1Cu7yxg-gHZu1NF+ug@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 26 Mar 2025 23:50:23 +0100
X-Gm-Features: AQ5f1JoMlU5g6NSl6UncTD8u6mGw6GHy9x8K4Y9hj5_mHgN8qGD6_Tf3xX5Nx5A
Message-ID: <CAG48ez1qGW8MO9KbKnsjEZE=mP4o+K0yrK4YQuTa1cebYYNr8g@mail.gmail.com>
Subject: Re: [PATCH] rwonce: fix crash by removing READ_ONCE() for unaligned read
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 11:41=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, 26 Mar 2025 at 14:24, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > I've applied this on top of the asm-generic branch, but I just sent
> > the pull request with the regression to Linus an hour ago.
> >
> > I'll try to get a new pull request out tomorrow.
>
> I will ignore that pull request, and wait for your updated one.
>
> That said, this whole thing worries me. The fact that the compiler
> magically makes READ_ONCE() require alignment that it normally doesn't
> require seems like a bug waiting to happen somewhere else.

To be clear, this is not the compiler's doing. The arch-specific arm64
code defines a custom version of the __READ_ONCE() macro used by
READ_ONCE() in LTO builds:

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/arch/arm64/include/asm/rwonce.h

/*
 * When building with LTO, there is an increased risk of the compiler
 * converting an address dependency headed by a READ_ONCE() invocation
 * into a control dependency and consequently allowing for harmful
 * reordering by the CPU.
 *
 * Ensure that such transformations are harmless by overriding the generic
 * READ_ONCE() definition with one that provides RCpc acquire semantics
 * when building with LTO.
 */

