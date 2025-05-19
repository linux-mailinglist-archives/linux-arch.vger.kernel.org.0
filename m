Return-Path: <linux-arch+bounces-12001-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA26ABCA62
	for <lists+linux-arch@lfdr.de>; Mon, 19 May 2025 23:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ED2216CCCC
	for <lists+linux-arch@lfdr.de>; Mon, 19 May 2025 21:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCAF217733;
	Mon, 19 May 2025 21:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tm60BgJo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644D31EB1BC
	for <linux-arch@vger.kernel.org>; Mon, 19 May 2025 21:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747691662; cv=none; b=HPDKOTfyMAJNsJu1Fs8sXQZkKsJwn4QiwUaEQUaSinwLJolOqWyHKwv7jj2BzmMqXH2ejuIJiv8e+JJgpJcVOTH9Op8iOylmzyA0+QuBJ5lM2UtXEj5HCg9CTCgQoUudafcbSUeh970LeJxyJ7o6Uz0+NMahE0vYD9Y2tXMEtrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747691662; c=relaxed/simple;
	bh=1cMrRrD1wKYeXbyb4edK//2QLqfqx2FamRPjULNvPhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chTqUeYBmydrnCBCFN6eGsL7MoBBxfdHGUaPdHghkxAFMEtWoZwPaEaBfO01RmJXxB0KbqwunePS3cRR0pKFTd9uynJPtcBgoUxbRLsxhqRBD2Pv7ca/DDOYsFKJloq11sqtSrTDRhVTDYWfpclO0P+SQDNzCwfIciNBt/OgwKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tm60BgJo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-231f61dc510so563185ad.0
        for <linux-arch@vger.kernel.org>; Mon, 19 May 2025 14:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747691660; x=1748296460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cMrRrD1wKYeXbyb4edK//2QLqfqx2FamRPjULNvPhc=;
        b=Tm60BgJowglxwG0ADKJfC/kFivUSVg/1l+v7ESrne7cR7qxwtyERaO+D1IwRHA/baK
         V86dIQbyPdRPCrd5cetOgnoDwv4+ejDND+njA1mc4dPNcegcHB7hIzdp/NLCjH8aOA1P
         QY//U8wXxLQkGocSM8jrr3spx4eR8dMY0RQntPT1PsvX2kuNApk6wEwZxpryN95jddhz
         j/MfHHREeqhMlk5RO83cGHZlu1Z5xPxwvh/zEgW/im7aQg/Uu7PZ4ZgpvA90Mch64dhZ
         h98DP8iOY7vKrerjic+Ad+vu97Mwr00zQmzas5+W5gB4x6Lk4szjNkQH8T6WxzhBp37Q
         6A8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747691660; x=1748296460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cMrRrD1wKYeXbyb4edK//2QLqfqx2FamRPjULNvPhc=;
        b=LzV+RS35dZMk5nvmb8EROYT4rmrUYNZ38n+DzrVYtH/aozhFAfXpegkmERqFGtE+i3
         hijdMcdgPqqiOv8HPXvCti2E0Vu5KZkczSAGd5BjPiFTl/2eI0uhQZnuxDtvwU9zGUzj
         cxl4wSYns+M/08wOzd87O1+Ly2OyZhrlFNfJsoggFLFt3V8OzIj6UeclfJxdbkxH55ex
         9mIHVueSrTMF6Co09ILMyV/L25ARZ+V4qlpuuyxKd/q9vucXNjXu9uaRXmsq6lEQfdzY
         r1FYthejfKsqEPmsSKtSgzMbtHJGf6NbVMcu9+I44QA4NvAeK4X79uQD33eKVYLs6URk
         MF2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNRdPhAeyrR+BWpjXgBFC3lK/f0/zRaDekWvovMLuFE2tnctFhDB8Mm0nigDCm+h0Ic4H+qRI7SrN5@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5WPzTmtqDCy77U/Q6O7oGaOwXa1eP7dTPTNoVVe9bw9/Q3HBZ
	5Yuvao4KiOMi3cw5bxveBg7BUoijdw4qPk/Afv+nA6CtO+ncHYYWqwjbzAuwizAV6HPbS5Sgszu
	ONEujhQe59MdSLRnmhTrjvpL+0i3jhQjs6QVQrBTm
X-Gm-Gg: ASbGncsby/ddGtvrK+Bfqw3v9NUreGyoMsNlPH5xA/e0HLt3w8RV3bTVwubYhm3vCTu
	8drzz+VL3LgHJ0X40MZLb4dxvz1QCwRD5qxyAg5xYIn+y3HA8EQvEO+sjmUxt8JGSpI6SHoPijS
	EX9iabN/WHFL3chxxn1PL3dBgQB7nGaDmB6ddmXGykK2/F5CZ0vC5TP0zOgiGCYEZ0jpShyQ5v6
	cN2UZxI
X-Google-Smtp-Source: AGHT+IGxMFzfxoMshf8o4a14Ejv5ySZeVudjy8uWADR3jrlyocSlHqGDCSnPrW5fBZgeWyiqUxNYjC030ER26Bgve7s=
X-Received: by 2002:a17:902:d54f:b0:231:d0ef:e8fb with SMTP id
 d9443c01a7336-231ffd0e311mr5549935ad.10.1747691660258; Mon, 19 May 2025
 14:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 19 May 2025 23:53:43 +0200
X-Gm-Features: AX0GCFvlTHWGpQXPrZqZ0zsT-FBytrKftqSVY8o-HTsRuDoHswTfw7vQf9EDQFQ
Message-ID: <CAG48ez3-7EnBVEjpdoW7z5K0hX41nLQN5Wb65Vg-1p8DdXRnjg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>, 
	Usama Arif <usamaarif642@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 10:53=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> 3. PMADV_SET_FORK_EXEC_DEFAULT
>
> It may be desirable for a user to specify that all VMAs mapped in a proce=
ss
> address space default to having an madvise() behaviour established by
> default, in such a fashion as that this persists across fork/exec.

Settings that persist across exec are generally a bit dodgy and you
have to ask questions like "what happens on setuid execution, could
this somehow influence the behavior of a setuid binary in a
security-relevant way", and I'm not sure whether that is the case with
hugepage flags but I guess it could maybe influence the alignment with
which mappings are created or something like that? And if you add more
flags to this list later, you'll again have to think about annoying
setuid considerations each time.

For comparison, personality flags are explicitly supposed to persist
across execve, but they can be dangerous (stuff like READ_IMPLIES_EXEC
and ADDR_NO_RANDOMIZE), so we have PER_CLEAR_ON_SETID which gets
cleared only if the execution is privileged. (Annoyingly, the
PER_CLEAR_ON_SETID handling is currently implemented separately for
each type of privileged execution we can have
[setuid/setgid/fscaps/selinux transition/apparmor transition/smack
transition], but I guess you could probably gate it on
bprm->secureexec instead...).

It would be nice if you could either make this a property of the
mm_struct that does not persist across exec, or if that would break
your intended usecase, alternatively wipe it on privileged execution.

> Since this is a very powerful option that would make no sense for many
> advice modes, we explicitly only permit known-safe flags here (currently
> MADV_HUGEPAGE and MADV_NOHUGEPAGE only).

Ah, sort of like a more generic version of prctl(PR_SET_THP_DISABLE,
flag, 0, 0, 0) that also allows opt-in on top of opt-out.

