Return-Path: <linux-arch+bounces-13988-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C47BC9B92
	for <lists+linux-arch@lfdr.de>; Thu, 09 Oct 2025 17:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D7B6B346889
	for <lists+linux-arch@lfdr.de>; Thu,  9 Oct 2025 15:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125401DE4F6;
	Thu,  9 Oct 2025 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QchALc0U"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4820D1D6193
	for <linux-arch@vger.kernel.org>; Thu,  9 Oct 2025 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023091; cv=none; b=i0ZC6VEVtjebTtaKBUSe5Oz/ClSdxq4qm2h9Igzpze78FRDCvb5O1yIIJFlbV/8N/bTUGyzgwg4GVXwz76zpGc4iExKlJGtAo85M3MnWgImr/t5JLMreBOoIfRDlNrD6EHOzJegtf0yTBzkQu2PtuHUhzJ8vjceI6P9fxNUmamQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023091; c=relaxed/simple;
	bh=2OdZCuvMPhyb/oX+g/qQuxgXRvbsQA7OE8rAsab4a9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plpBLpf3qeEvpWEhdlNDED8/4zSLfd1LkRAEokLj/mKshP0jWqI35TQSoZDQBtbPYHwJO7d5djSJ0eA0oWWD3WOxZCiR8020Jc0nhOA/OsAdutpHlXTfpZdPGWQGkYDkyv5OaMv25ky0QDCqKByJgdqReMAmMaP5hlwUr4w/Ah4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QchALc0U; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ece1102998so668845f8f.2
        for <linux-arch@vger.kernel.org>; Thu, 09 Oct 2025 08:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760023087; x=1760627887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OdZCuvMPhyb/oX+g/qQuxgXRvbsQA7OE8rAsab4a9o=;
        b=QchALc0UupidtcvXks1cDQ0qMA/LiKjiUT1/XnC6sALCfjESIJNyJm+VYmDglFw1ML
         5ZG1GQZO6IdSlYLvHMaXhrgMnviyO9QtVI4mmaKx+JpqACwb55/EVudawSO20yIeiNan
         TUzv6lg70xxLGrVxI5EdmMGnzLdZfIMTn9N1KTRLF3lUamOJjrVPm143ob2Os/o8uyPe
         ty6V5HOlheh8P9S0BSvQqgHU3qDRJMxsj+OUhcXlAQYEJK2nh4q/0o30MUNoafmBpT9N
         2SxWCZYYffwv1kZ+QD/1znoghHUfr8ekUL1wJuMI4ptmkKiB7KwjYGGO+K2l96RDXN7L
         1aUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760023087; x=1760627887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2OdZCuvMPhyb/oX+g/qQuxgXRvbsQA7OE8rAsab4a9o=;
        b=KOCtL82gSbhNtu1OAHQ2zaLvKczAjh17gjeFd1I+hFKwkDgAI4mxHcTUKzi3D8yJHZ
         fdes1H6phicak+m+uGFIOPdTMdq9pF10nkWftiXkLq266LVK5x0BO/kReJ2oBBjZrGUr
         ZOrDGTp/xlm8GGsJc3WCKHfwzwvMN6bFuYjabkcgDaoBH3g/tIhXRHSxapnPsGfvm15c
         ySecvd/OEBt6EgfEI5LXMud8TC536+8Qbi8u2FlPBlvVMKbbGNUU95ryofKsO3+9Q/r3
         8+CttiRSzgnRfzDWtaYLM6OhKI50wR4kJoNxU2SFbyMx4KPlVdFal9JMzbvQsKSsoq2t
         N5mg==
X-Forwarded-Encrypted: i=1; AJvYcCX9LCnE6fzaNFJWJYoVvbRIaC0ascus9FwxWYSdYDrSLDQ3OgEwYJfyAICCKcT01PND3osJkWxxaUTc@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+hx1hQbHk1wZqh3hmQrufuHiDStGQMSCK45vr9FhdKKVBujKB
	9NaPwu2FERM7CEkI16uHlPJH+nrOJStuYDbpuPuphJUpJGOAxIRFSBnwPpbEFdMI/+SQULg5Iw9
	PcC+A+5Vvt14/EQfvwhwBgDCX3JZXl6c=
X-Gm-Gg: ASbGnctUojhqNUxxF8rmutG7YgnIPcJ6f/rMaoEP7AYCzztBMuGZHuZvFJS1l1y7zf+
	PifwUHY8mAiGHZQXIFMyI1D6pP2pCa+fD22mAhYwjzXNZLG5GQiYWH6Tp26PAvr6oDBmENy2Z8X
	qcWLjC+4D5IZbpS7BIWx5cWMruo/BEAP7Xn8dbmpBOz3JhtajuusF+u3yL9NQKeq8SHfm1O34mn
	uvg0sdwUJXsP3/v17OYfdgPVJ+h65XIECBgiBIJ7u4Porq1S1tyk36k6ycWHl/vI3jvynuX1LY=
X-Google-Smtp-Source: AGHT+IHFIW2ZRuVj6JW+2Xc5kVTwqVxqOqN9ru2LkZbWzNc2F/DIEJsdL0gLuDd10vTbWFu9LcmuEXrfEs4ejeimT+E=
X-Received: by 2002:a05:6000:2c0c:b0:3f0:2ab8:710f with SMTP id
 ffacd0b85a97d-42666ac39afmr4150639f8f.8.1760023087351; Thu, 09 Oct 2025
 08:18:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1759875560.git.fthain@linux-m68k.org> <807cfee43bbcb34cdc6452b083ccdc754344d624.1759875560.git.fthain@linux-m68k.org>
 <CAADnVQLOQq5m3yN4hqqrx4n1hagY73rV03d7g5Wm9OwVwR_0fA@mail.gmail.com> <20251009070206.GA4067720@noisy.programming.kicks-ass.net>
In-Reply-To: <20251009070206.GA4067720@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Oct 2025 08:17:55 -0700
X-Gm-Features: AS18NWCd-roHqFuBtFB_rLNuX70SLGKwer7HfRV2M50Son7-GOgDqpYYiOdZQVU
Message-ID: <CAADnVQK1GqQKxdoM9e1Z92QK68GEjqgMnC36ooVgS1uUNiP6eg@mail.gmail.com>
Subject: Re: [RFC v3 2/5] bpf: Explicitly align bpf_res_spin_lock
To: Peter Zijlstra <peterz@infradead.org>
Cc: Finn Thain <fthain@linux-m68k.org>, Will Deacon <will@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 12:02=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Oct 08, 2025 at 07:10:13PM -0700, Alexei Starovoitov wrote:
>
> > Are you saying 'int' on m68k is not 4 byte aligned by default,
> > so you have to force 4 byte align?
>
> This; m68k has u16 alignment, just to keep life interesting I suppose
> :-)

It's not "interesting". It adds burden to the rest of the kernel
for this architectural quirk.
Linus put the foot down for big-endian on arm64 and riscv.
We should do the same here.
x86 uses -mcmodel=3Dkernel for 64-bit and -mregparm=3D3 for 32-bit.
m68k can do the same.
They can adjust the compiler to make 'int' 4 byte aligned under some
compiler flag. The kernel is built standalone, so it doesn't have
to conform to native calling convention or anything else.

