Return-Path: <linux-arch+bounces-11145-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C17A72075
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 22:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2411899345
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 21:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029AC25D539;
	Wed, 26 Mar 2025 21:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FbLHCo98"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390AC49659
	for <linux-arch@vger.kernel.org>; Wed, 26 Mar 2025 21:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743023375; cv=none; b=fohn17JJfckw4I4sDoOVoZGfNSpPBWBLDmWgdOCGv4oFhTUpb8XNs0vsQJd+862e5Y7rz0/PLQL2lnxQGwFpkq1kQfuzemnA/o5ZTyVuFcgDp+45ZTImGYjBXNq+nrFXHxIULxW0y05ICPdmvdUpCRuwrO7eK+4u6XGa/Kowu2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743023375; c=relaxed/simple;
	bh=N1Iw1CJ8p9YjJ/cpcO93upEpS735Wn8gFvx0ADY4HQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmlhQCld96jqr7z/Bo7oDf5X0CIsUcmtZiElqdklAtJV2meFtKnGES7dnb8zvba/o9NNVyKwUzCL5qTZZcTK8dD3OEjXmIzbQeC6+RNcuaVqrqT4bU7dVHxlm/4EhwCSfMFlptQ3QIJDHLRy4FauhCjHHQ0c2IWsiDEvubxx5eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FbLHCo98; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e50bae0f5bso3454a12.0
        for <linux-arch@vger.kernel.org>; Wed, 26 Mar 2025 14:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743023372; x=1743628172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mn6ZXtt6CVZ3GL75/BKIeHmkynUInUG3RiCFW/2GGVA=;
        b=FbLHCo98BNQbaIzelURIZhGhN3nxVLc2ZcD0Bt7Cc/zj1ciJjKSNQqi3lBAqGFRpSs
         GMMv+lmjV4f8AsP/07Qs4vBSVgOivZGjN/mWlubhwLIo8UnU5H6jVCa4BURkjWw6xKW9
         aAihdjzQh4Yo+bnfkqW2sroYSNFyRBAX01cnFrRiXWxdtfltu3j3V3f47tOBnq5k6z2t
         nOzspXmbr73gAoTm17MqPV7sFlja1ZhD3fE1W6CqmG9X4tOh28MWm+x/n0nmHTBLLDJq
         TotkMrb8mfH1evYKH+jFYr9kYM0DZsNy39rE4SCJqybHyDQN2pePA584HDk+nbU7IDNj
         N9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743023372; x=1743628172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mn6ZXtt6CVZ3GL75/BKIeHmkynUInUG3RiCFW/2GGVA=;
        b=o5AstQyGlBlZH5M4mZOge9hnoptfJ2B3gW5EdsiYoe8ickSA4WE6drJgvu/jmlmMNt
         KOC2BNVZzokgdS8fBfzA5rbEyCt4QNGwayTgorUFjaNWcZeYtzGgi1XlzhlRw99hLJXs
         rxo1uwoIQJkSAvqduWIudjJfI715Sf6C8GeSPtluJnrG0dmGNB8+hfKgOEPdxy44M6s3
         xRm2jEBRZK2lPYelLZIAN3CqtXg5yXoGWLeDy15UIa3WUlYd/PM62iciEjY4ZO1N/edN
         1rjAQ++re9fW+lEO1xRM5zL8zAFTzHYZRvIh7t0vblsq512dWCd+DKdVpX+h/1EJFgY0
         xdLQ==
X-Gm-Message-State: AOJu0YwjN5UVQVbD9ftqQ7OAJ7vK/tYn099KIcqH4wE9cPO09aVpLQ/7
	NWDDGGpuw2DWGIbSCzQnAIaCbx8DGSmX/yL2HHYarMrChrI/RHaSqmaAyAOkOd/STrUu5LuSUqN
	2i17XgzW0dQJpLyDN/Doi5QGl8UG7f1STX0E55ZNb7ujrXDQq/1dRUpY=
X-Gm-Gg: ASbGncuuzf3+77ByRE0Z5SwToWDcBi5ISO3k9+sgwm95LHt4bs0MM2YziemdAo3tMKY
	i5aMTQWddZTmDD1y6edB40faSsNTeHp+PkIujlAtCj8HW6NY7yutSooBjfLI+esOi0dueOVaQo3
	MnhoRVr3Fz26sATG5foKBtXS4sH/DslC6pgn8mrywUQoazFMInQ+SsviQ=
X-Google-Smtp-Source: AGHT+IF5XYVtxnEMnp8UVx9idrWRetkioyCanAIqpXdGdCYrAu98yJ9b779Z+2gRPmY2TAzVTNKL5she3ojuvy4WlUA=
X-Received: by 2002:aa7:c557:0:b0:5e5:c024:ec29 with SMTP id
 4fb4d7f45d1cf-5eda8160d64mr14905a12.0.1743023372195; Wed, 26 Mar 2025
 14:09:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <31097083-a444-4bd1-8722-d8b7c4b7a43a@app.fastmail.com>
In-Reply-To: <31097083-a444-4bd1-8722-d8b7c4b7a43a@app.fastmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 26 Mar 2025 22:08:55 +0100
X-Gm-Features: AQ5f1Jrc_WaIP2U4wJ_EdK04Nd4TpZufnq_KcUHEOJYF7zycnekmFp_S3xzW9WU
Message-ID: <CAG48ez0ZahF98zN+qKrizDC8MBM7CM=WMBOzk7ybr55Er37=pA@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic changes for 6.15
To: Arnd Bergmann <arnd@arndb.de>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 8:43=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
> The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f0=
5b:
>
>   Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git ta=
gs/asm-generic-6.15
>
> for you to fetch changes up to ece69af2ede103e190ffdfccd9f9ec850606ab5e:
>
>   rwonce: handle KCSAN like KASAN in read_word_at_a_time() (2025-03-25 17=
:50:38 +0100)
[...]
> Jann Horn (1):
>       rwonce: handle KCSAN like KASAN in read_word_at_a_time()

Uh, sorry about this...

Nathan Chancellor just pointed out that my commit "rwonce: handle
KCSAN like KASAN in read_word_at_a_time()" breaks the arm64 build when
LTO is enabled (<https://lore.kernel.org/all/20250326203926.GA10484@ax162/>=
).
I just posted a patch that undoes the buggy part of my patch at
<https://lore.kernel.org/r/20250326-rwaat-fix-v1-1-600f411eaf23@google.com>=
.

@Linus: Sorry for throwing a spanner in the works here... maybe you
should only pull up to the commit before mine (luckily mine's the last
in the stack, and it's not important), or wait for Arnd to give his
opinion.

