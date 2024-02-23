Return-Path: <linux-arch+bounces-2709-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FFA861C71
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 20:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1081C22F44
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 19:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DA3143C54;
	Fri, 23 Feb 2024 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OpCi4S7E"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E03143C6A
	for <linux-arch@vger.kernel.org>; Fri, 23 Feb 2024 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708716416; cv=none; b=uMrRS+FGwjc1Cyi09k5CbymsRV546m70fwQO2AA1Blk1cANOU+fDjAt7g+8DfIBwPTj9ZNYPiShVhp9fAVIxHDA2kUcTv2VOieBDKeQD0znyLWFfCBt+BStqaMq41hTt62hU9Zw9bt4gV/Ru5OYECei0HkNj+4FSnYqDk76uMao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708716416; c=relaxed/simple;
	bh=R6zUV9LQ644WPBwU2nAdaKkCRupl6ITF2pP4ziWZMV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtY02LU+vD8dP7Z8+24aw0qFDDqSlXPSuqNgo+PmaU+RhFI/dpjgUdNPxjhgQnRry4AzWVuautkhNOHkJcItLvRgQV5EkO73faMVFOEKhvLeG9VtPsS6qHVKa+baJoMD5nBafFXglugdKPHyoyM2QNdV2U6Z1MCsMo9YYT+G8pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OpCi4S7E; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc6d24737d7so1066840276.0
        for <linux-arch@vger.kernel.org>; Fri, 23 Feb 2024 11:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708716412; x=1709321212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6zUV9LQ644WPBwU2nAdaKkCRupl6ITF2pP4ziWZMV0=;
        b=OpCi4S7EIle74AF4FZHaIEyLZXNxInq/DezUptdf3Dtyp+NkJo+dehUdZWG2qusLIi
         bt8qF0ES+0LRUSPqWcX3BhMdXjaIdmafbMwRL9IPIvSNXVQcek1Jj0OLzR/dzhi+w7to
         dAXnDGoFer1u6qbebk7TeotLVef6+Rz6kG/IIQYYpJYnHAms2nBdwshn2RMbFLixh9yV
         eZZ0uK4Fjh1XP2wbWR9k7FrQhpvdHVp19ivE5SZkX2rlJbmBquB+IxJZ7azGQfDfOpLl
         DtRq+AvFDvwCsisaBmPWMyn88TDIfYFY/bu64HZB+J1w9y9ZRnJSSKlJoV24LCl5T0vH
         ZewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708716412; x=1709321212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6zUV9LQ644WPBwU2nAdaKkCRupl6ITF2pP4ziWZMV0=;
        b=TMbz806gzpeks1DRwCz/IpwYeRZOnfrRvwQtwbwEnAmBQh2D7is/9Rz1+cp0p30eWd
         KX4KVCnQ2aX4dVkr9O9jA/hapGkB2bK00a34p5LE1/7SgFp+enRmxNwuWlgDj5AJyOiw
         4VVDa6RWpl2sGOiMEGkXMkLoCFKJVU9TfKXN1Cr2HFRLiwKhUqzajnfWTvkhDsYRmxN6
         4RNV3QBOKTc0itF83QG6VwpXyVspJod665z+JH/E+5vEEO/HFJzif4KbnZzDOb3PGVav
         aXX+MR6+AmI4hPDI/4AxDZdrCBtci8t80mdCONc/GZt1CAQ4DriuCPsi/bPpzA7KS2YU
         nnHw==
X-Forwarded-Encrypted: i=1; AJvYcCXkZGsq6KkCfx51LzQz92QWZ4nVxK7JgydWOD93nZKlDx9NxTzyhiV2tqi9UTsoUps1sPnCPaRNPtp+pioiph/1/ncpfVYs/Q4CYQ==
X-Gm-Message-State: AOJu0YxHQdJr1bTGOvkWGsaC9WtjIaHaC/yIAIXVbmQIhgxB51CFWQ+S
	aYmtnvsHQPj16sVDpgg6aj4Q4vlOO3HACCFBuKvntnE5X6je/lDYZWyl6R0yBVPk27ulRewclc8
	UpjNTMSal3/85u66xDUr1JsqJwzIDBpazet52
X-Google-Smtp-Source: AGHT+IE/Pl6hrmaYgXKRMYbWWj3alWqUpkDIYPYsJjZVZ7mPx6TO4HEVqSuGco97bbBAS2NUd8BFNQPQR2paQWXSoCg=
X-Received: by 2002:a25:2653:0:b0:dc6:b088:e742 with SMTP id
 m80-20020a252653000000b00dc6b088e742mr843579ybm.8.1708716411749; Fri, 23 Feb
 2024 11:26:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-7-surenb@google.com>
 <Zdc6LUWnPOBRmtZH@tiehlicka> <20240222132410.6e1a2599@meshulam.tesarici.cz>
In-Reply-To: <20240222132410.6e1a2599@meshulam.tesarici.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 23 Feb 2024 11:26:40 -0800
Message-ID: <CAJuCfpGNoMa4G3o_us+Pn2wvAKxA2L=7WEif2xHT7tR76Mbw5g@mail.gmail.com>
Subject: Re: [PATCH v4 06/36] mm: enumerate all gfp flags
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc: Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 4:24=E2=80=AFAM 'Petr Tesa=C5=99=C3=ADk' via kernel=
-team
<kernel-team@android.com> wrote:
>
> On Thu, 22 Feb 2024 13:12:29 +0100
> Michal Hocko <mhocko@suse.com> wrote:
>
> > On Wed 21-02-24 11:40:19, Suren Baghdasaryan wrote:
> > > Introduce GFP bits enumeration to let compiler track the number of us=
ed
> > > bits (which depends on the config options) instead of hardcoding them=
.
> > > That simplifies __GFP_BITS_SHIFT calculation.
> > >
> > > Suggested-by: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> >
> > I thought I have responded to this patch but obviously not the case.
> > I like this change. Makes sense even without the rest of the series.
> > Acked-by: Michal Hocko <mhocko@suse.com>
>
> Thank you, Michal. I also hope it can be merged without waiting for the
> rest of the series.

Thanks Michal! I can post it separately. With the Ack I don't think it
will delay the rest of the series.
Thanks,
Suren.

>
> Petr T
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

