Return-Path: <linux-arch+bounces-2652-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 395D085E9FC
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 22:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8DA1C245DD
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 21:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFF4127B66;
	Wed, 21 Feb 2024 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="JxUB1ljL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90E1127B71
	for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 21:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550475; cv=none; b=Km0z3z2UI+rBGtvzLc0QDCIehyUwf+HDg36+YIa6xGe5Ubw2pJyzMImS3d7yEHpZSdoVTjqHERbhVJ6x/dgO0dTesM98VrT58w44FejymdQKWwhOEXep6M0wY9Bh2MRbj8YwGbhMEgz6WmfAbDm+ftpkecnFpl9s9/dYjFMAT2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550475; c=relaxed/simple;
	bh=JFD4yQzqaLEAi4PA03QBYwNo3rIHnJT2RUQoKF+C/Mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SA41ZcPolrtxobDsfpvSUbyjF/qjGSa/iyqHWs2mm1iQMREQ/ZuVtOLL7d8w4sNuJBokAlBAjmyBPePeTpk0u3eNcYSvW0EUL+TFABZyZiIPvC64SbNvDuyJJEdf9CKg+fXhIBoYleOeCPNOcLDWYTp8+TjM5cdJcB4N5JHIBzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=JxUB1ljL; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42dc86cc271so37922331cf.2
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 13:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708550462; x=1709155262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFD4yQzqaLEAi4PA03QBYwNo3rIHnJT2RUQoKF+C/Mg=;
        b=JxUB1ljL7XvovtiVCEiIV+ZgtEh/WCr4kltgFFgJQOX/Nze6UEOtT6SfoHf94oS5jO
         F3PgJkRi/OzC+uTdyAXVDZmtuBXx1QevUcedfG5duFQQZh76wbB6L3+KWuUhGIpLKmeg
         lE+A8eFEnzaYCiggTXZqyAlSoc8Xi3sSVCBTwEevS3Nb7Wvz9IiH3Mvo9QqvuKM1Exzq
         rmwxKg2TCPQiLQ4fmnLgyPwn+aTdMq13ksJqrR7dXfzOnHvMAEgoLrl3ha+pGyxeENnF
         JY0D23vKekg6Y0NHqqHpT8rjyB+aP5mxYFacnV4aFLgKRoeUbHuCMt7fUBTn/1Ola9MY
         AQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550462; x=1709155262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFD4yQzqaLEAi4PA03QBYwNo3rIHnJT2RUQoKF+C/Mg=;
        b=F1jHbbQosNH0TH1fqEpSUBvhWyIzOktndxkoewQlIHTonOuHZWNviy42XumU/mSkIf
         sbZrG55OD135IQ0qQ72qqeVmdE7BfdhJqHUa89kpxPpN3RHQTvRHBHEq7ZMyvcQXlo9j
         VRAis2ZeYBXiR+K1RVqEkX02PeHtWkZFTunlSSCteIA/lLJ/jO0WuTQCpG3glN3XQx9H
         +UbVyEMbWd0D+WVnblxZ0+kKX6+uBOuO8DSqSaJSqdRQRn/bAsjgOteNTzVl5ESr2vni
         55iBGYdSb5yIejZm4yn6ZHUoFVxCmgeKAf+Tx+Dt9Bk0d7yYNlTIJG0mj2bbSzPbQSNp
         h+Bg==
X-Forwarded-Encrypted: i=1; AJvYcCXg/Q0lCtCivOj+GHTsPUA64gLZj3DxsQU6YTiUkyDo3h44XyilD1E9zRE8vW3aFTWGn/0XxI5OHJpQINVDCBFhRkXpu33/H915HQ==
X-Gm-Message-State: AOJu0YwUzB/3MPfMnVs2T1ITyqNuhkJMp3jdcIlZXwwmU4X8GOxmSA9V
	/J2t5Y4azbAcy3uMP3fsHP8W89wmT4fjor7iLl7xhNBWigyaAvOxxIgq4caglTRZowSblyaql/y
	kF2zHoviL41dlWHQMaCbhPaFbwSNH5A9WqmPplw==
X-Google-Smtp-Source: AGHT+IGJtekCGEzDieaihS15p2Hc5EreGxKXqPCCpXJixs6Ac2iIPaw+nCtg/oETMxVwF6eTa85a+lNh3bwEt5JkkGQ=
X-Received: by 2002:ac8:5981:0:b0:42e:17d9:f8bd with SMTP id
 e1-20020ac85981000000b0042e17d9f8bdmr9654015qte.24.1708550462298; Wed, 21 Feb
 2024 13:21:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-5-surenb@google.com>
In-Reply-To: <20240221194052.927623-5-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 16:20:26 -0500
Message-ID: <CA+CK2bBqUV-mTOYSuDCBaMjy+HyEs+=YnY9Ay9iQ45mStSn47w@mail.gmail.com>
Subject: Re: [PATCH v4 04/36] scripts/kallysms: Always include __start and
 __stop symbols
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:41=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> From: Kent Overstreet <kent.overstreet@linux.dev>
>
> These symbols are used to denote section boundaries: by always including
> them we can unify loading sections from modules with loading built-in
> sections, which leads to some significant cleanup.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

