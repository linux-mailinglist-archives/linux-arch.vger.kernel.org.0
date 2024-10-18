Return-Path: <linux-arch+bounces-8269-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF1B9A4329
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 18:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84221F2426F
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 16:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797CD200CB8;
	Fri, 18 Oct 2024 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uheKiSvL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE2B1FF5F7
	for <linux-arch@vger.kernel.org>; Fri, 18 Oct 2024 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267479; cv=none; b=b6776zJDfrzLQsam+lzgcP8BuGemgOLzzLlk9LuyVDjxvkoQ7lo7xEn6p4Aup91ugmPQrEpX2kaBcDHuhtCNWtfCk2QzxwNnPli8X6Ng9oLhoFGR0172JjVgJNl2NCnFjBoKeJhM9GPrq8R6PVBJ6BV/GJ578WmwTfp36puf+mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267479; c=relaxed/simple;
	bh=inlYmE1jkrrFn4f3Uk0ZGHGC9Ou3kuwAezYOZ+WS5/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILvfXOdFzN4UQp0Pxoh2aIalP3MZVwpyYdd65LYIygOYYD6SoeiyCRcJ6Y6ajZ670G0cERy98nGmxTDl6iPrb2fziM+8xeOdXGDvvNVOAl1qokCGCXd7LT/JOdQVPSGooIwNfXLxU4wT8GF1rsPLIu9dm59nXFTRTc+jfafbjSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uheKiSvL; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-460969c49f2so318961cf.0
        for <linux-arch@vger.kernel.org>; Fri, 18 Oct 2024 09:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729267476; x=1729872276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txzJ41KP+IG2jzYwjNeONh64Ul17CPWMb2WeMlBT1K8=;
        b=uheKiSvLv3RBS2j+3aIR/SC5iCxT6blxyNxdn5bwGdU2+quEJRvz0bVf93OVWZkiZW
         4HAq3nNllK6blEc8bals7SLQPtiYSm9WRpGTynb1gecndYjikg0BmbCkZ2EWiJiEYvad
         UKX9CDTQSiXxEwU6Vc1mDKNMVJOozs/oVP2QvXXUHpuPTzNUj7mkXvpFYfPPII2z2EC2
         ot/RqW4exjaWw6cYj7cTxoS6xii/gPf8t9i904X3YfWnr27sJ4dTT4ZGRPsbT+sn6oYj
         KY1U/7Wwjh2sfTOh3Q6KsBuTKy+jjH8OLepnaraxZOhK/oM4TxRDbO6HYrxIR/zjSaFi
         oR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729267476; x=1729872276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txzJ41KP+IG2jzYwjNeONh64Ul17CPWMb2WeMlBT1K8=;
        b=FHhTAMc/aFMz5xKTEQoES1OSK4LViLLtXBAdDT6gBwfD/6YXRq45dxrJqMsHrN+NAr
         U81L+QU6CpPvcF+dNSviAtTgGNld2BPpO2x2jwFWlEnmxGQArPz85B1PWPE0c8n+y9Tu
         yVIb1W6n8eVSgU0z6Wkbz8qPMWM8rvMhVXUMBLpi8FiM2Liw1qR8cxSXOgTGbE+L+ZxM
         JCF3ZAv86NS4cph+uHMuy23r52SR/MjLbGC3hjxNyCCMfyxlPJvSCjGdxQbXdGC8sbE1
         3wvpvB2BclNjibHWmu0LRQchPxfeSSzfxwNF5yF995iXhczH90kMCkqwgg4fojt+SxMC
         1DRA==
X-Forwarded-Encrypted: i=1; AJvYcCWif5l8AnkIKS831Es7xw9F+JuYNN4+ESqAwOjSb0DH2ZcHjQ1sZOoXJezj7ibBtvVjxPh9wNuugapL@vger.kernel.org
X-Gm-Message-State: AOJu0YwiASggG6VXhppnIeU8b2gkE2wSp34yURRZfGaOp+bfcyzmqWLs
	KbwSnOxbgspZHqmMqJhTMpBorpawZj/9yR7xnnNv8cyzctTj5ffNgtBeJqlASFqgTVhwMUKeujU
	3EtA27+koqvCLI1FQqWVOG4X4uADTiJbVNMOd
X-Google-Smtp-Source: AGHT+IFQG+EGiekTkeB05IxiF0O0r7KvtKqW4HJXohUooeRpV2q0MrbuBuWAeTds5JJTI5Aqfm71otuz2Ld2rT6smr0=
X-Received: by 2002:a05:622a:7b0a:b0:460:46a8:9e67 with SMTP id
 d75a77b69052e-460ad735ad8mr3690811cf.10.1729267475834; Fri, 18 Oct 2024
 09:04:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014203646.1952505-1-surenb@google.com> <20241014203646.1952505-6-surenb@google.com>
 <CAJD7tkY0zzwX1BCbayKSXSxwKEGiEJzzKggP8dJccdajsr_bKw@mail.gmail.com>
 <cd848c5f-50cd-4834-a6dc-dff16c586e49@nvidia.com> <6a2a84f5-8474-432f-b97e-18552a9d993c@redhat.com>
 <CAJuCfpGkuaCh+PxKbzMbu-81oeEdzcfjFThoRk+-Cezf0oJWZg@mail.gmail.com>
 <9c81a8bb-18e5-4851-9925-769bf8535e46@redhat.com> <CAJuCfpH-YqwEi1aqUAF3rCZGByFpvKVSfDckATtCFm=J_4+QOw@mail.gmail.com>
 <ZxJcryjDUk_LzOuj@tiehlicka>
In-Reply-To: <ZxJcryjDUk_LzOuj@tiehlicka>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 18 Oct 2024 09:04:24 -0700
Message-ID: <CAJuCfpGV3hwCRJj6D-SnSOc+VEe5=_045R1aGJEuYCL7WESsrg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] alloc_tag: config to store page allocation tag
 refs in page flags
To: Michal Hocko <mhocko@suse.com>
Cc: David Hildenbrand <david@redhat.com>, John Hubbard <jhubbard@nvidia.com>, 
	Yosry Ahmed <yosryahmed@google.com>, akpm@linux-foundation.org, 
	kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de, mcgrof@kernel.org, 
	rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com, tglx@linutronix.de, 
	bp@alien8.de, xiongwei.song@windriver.com, ardb@kernel.org, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	yuzhao@google.com, vvvvvv@google.com, rostedt@goodmis.org, 
	iamjoonsoo.kim@lge.com, rientjes@google.com, minchan@google.com, 
	kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 6:03=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Tue 15-10-24 08:58:59, Suren Baghdasaryan wrote:
> > On Tue, Oct 15, 2024 at 8:42=E2=80=AFAM David Hildenbrand <david@redhat=
.com> wrote:
> [...]
> > > Right, I think what John is concerned about (and me as well) is that
> > > once a new feature really needs a page flag, there will be objection
> > > like "no you can't, we need them for allocation tags otherwise that
> > > feature will be degraded".
> >
> > I do understand your concern but IMHO the possibility of degrading a
> > feature should not be a reason to always operate at degraded capacity
> > (which is what we have today). If one is really concerned about
> > possible future regression they can set
> > CONFIG_PGALLOC_TAG_USE_PAGEFLAGS=3Dn and keep what we have today. That'=
s
> > why I'm strongly advocating that we do need
> > CONFIG_PGALLOC_TAG_USE_PAGEFLAGS so that the user has control over how
> > this scarce resource is used.
>
> I really do not think users will know how/why to setup this and I wouldn'=
t
> even bother them thinking about that at all TBH.
>
> This is an implementation detail. It is fine to reuse unused flags space
> as a storage as a performance optimization but why do you want users to
> bother with that? Why would they ever want to say N here?

In this patch you can find a couple of warnings that look like this:

pr_warn("With module %s there are too many tags to fit in %d page flag
bits. Memory profiling is disabled!\n", mod->name,
NR_UNUSED_PAGEFLAG_BITS);
emitted when we run out of page flag bits during a module loading,

pr_err("%s: alignment %lu is incompatible with allocation tag
indexing, disable CONFIG_PGALLOC_TAG_USE_PAGEFLAGS",  mod->name,
align);
emitted when the arch-specific section alignment is incompatible with
alloc_tag indexing.

I'll change the first one to also specifically guide the user to
disable CONFIG_PGALLOC_TAG_USE_PAGEFLAGS.
When these happen, memory profiling gets disabled automatically. These
two cases would be the main ones when the user would want to disable
CONFIG_PGALLOC_TAG_USE_PAGEFLAGS to keep memory profiling enabled.
I also think when we auto-disable memory profiling at runtime like
that, I should make /proc/allocinfo empty so that it's apparent it is
disabled and the user does not use stale data.


> --
> Michal Hocko
> SUSE Labs

