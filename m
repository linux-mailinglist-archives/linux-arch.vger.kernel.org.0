Return-Path: <linux-arch+bounces-7019-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DD696C3DD
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 18:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660611C21AB4
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 16:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4222C1DEFE2;
	Wed,  4 Sep 2024 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k3sOJvwS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25BA1DC184
	for <linux-arch@vger.kernel.org>; Wed,  4 Sep 2024 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466696; cv=none; b=BAwpEWJFsix7vXrdMo/wWSFBKU0GqbKETQNRelNV5Jy0Q6kiGQnL4NWZB42sCLXGoycxYXrTYVTc8529TR64LetDPuvfKtl5iYcKo6AbgGKlNHZQYZRw3fMC8HnVTbpo8wuBjqKIFkNWoIRSuukuOEsih15pS03ScYKggPuiWKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466696; c=relaxed/simple;
	bh=YjgeBQx1vUvZtzHDl8kC+TeEaUMQNUyI2Gymk2f+KpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDYKdd6Ig8mRIUX7R1HyEDaORhQmWwWdHVCBYDyav44cd95zxhfaY6+oRMJMkHeF5YRvZkKoPgsgDihoZXrdQkRqLRSd2RcehMtyLI653WmLQjmw+frNg5a7tJlybaecgf+u5kmnHPP8IQncRuf/cU+fDNA3aLGtaEhcijeu25o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k3sOJvwS; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-457c6389a3aso293381cf.1
        for <linux-arch@vger.kernel.org>; Wed, 04 Sep 2024 09:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725466693; x=1726071493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WeGJH80bEcJ0365jFT2qsdMy+ow6oBRUAZDQ7XPYag=;
        b=k3sOJvwSNyoqmFwZ6KJRNdTmx949ghUrk9dS1AG+zMsKpggyVE6HCiEGVnfcnuOaLf
         TkTEqf4cP91N2+cwvraWDxvFooC8ww4Xx19BGERVltESfC9wbbUwKX8hym1OaKgo3LV+
         qjRaQssYgpRRg6rX88KVhGwY7Mwb4lAOMEG7/yIwW4VvUXGyb6y46lpZF/0K/qHRYOwS
         U3tZ3+b0KEDaLloI5DJWffQU+qaZWCmswxEsJdzu8QS12nXeAjenk11GkqxadWoSH9cI
         RZvdq+IXL3PH2gI8sCfbRJZp6d1cFYOGF8Hq12m42N7d18N5oyr/Q0DqpdkCuDMOgzWK
         V9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725466693; x=1726071493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7WeGJH80bEcJ0365jFT2qsdMy+ow6oBRUAZDQ7XPYag=;
        b=XgSit01LI1blboGJXhpRae+W+KA27xoFs9DgoaLqUkddY1r7/lUsuBXHy9jl++cjA4
         e+6ifTYRKPgRmtErBNc53vreLpSB6Yqe+M2VcMhJ+U0fCCzfzewENpia8XRdJ+FZEyvF
         Yn89qrvVUhcnx0K+emYnTephZHUw2fq+G8geFOJhK5zKlpjbIPdvpyjpkuzRuT8EFjt0
         hnwtbmNDW5qYZldLgjFdMBytjkqKFAIL3wZxC0ux6vKCoorF78pqxgBb9OlVfuJX9wjp
         sNNWNmyfZLiaoG82vhWC7EKaQhckoxQJ9Kd0DU6aGyzEjQP4IAY2KDmcZqNbcaJg3tKR
         tT2g==
X-Forwarded-Encrypted: i=1; AJvYcCWLS3boyysswNdgJtapK6urTKkSBOTD22EV1gIJLMeEa09QW1q94ikYujBP0LOIxfgj+KI1/Z4cROgF@vger.kernel.org
X-Gm-Message-State: AOJu0YwMHrDrzLsb+lapkoIW8Z3hJjwp+w+cl+cdnIk9L/KtZnkKLNTA
	iHNTSg0o6+E+3e7PMllZjen0hvbCN/AVpyex6BwVNU4H8LMtYiUSSk3MWriPrkV0KV3omGZqDrg
	GfW1UDdWs+hshBME6iZ5c11dXcyDhB4A/JvCa
X-Google-Smtp-Source: AGHT+IEykJoO0CUB9s8s6fVSGbKiIoASEttssn/0WTzizKwfBV/HeZPmuqrT5IbD+slBtZTDHwI1j3Scv6KP974j2CE=
X-Received: by 2002:a05:622a:15c9:b0:456:9498:6b53 with SMTP id
 d75a77b69052e-457f623ac57mr4374521cf.16.1725466693017; Wed, 04 Sep 2024
 09:18:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902044128.664075-1-surenb@google.com> <20240902044128.664075-7-surenb@google.com>
 <20240901221636.5b0af3694510482e9d9e67df@linux-foundation.org>
 <CAJuCfpGNYgx0GW4suHRzmxVH28RGRnFBvFC6WO+F8BD4HDqxXA@mail.gmail.com>
 <47c4ef47-3948-4e46-8ea5-6af747293b18@nvidia.com> <ZtfDiH3lZ9ozxm0v@casper.infradead.org>
In-Reply-To: <ZtfDiH3lZ9ozxm0v@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 4 Sep 2024 09:18:01 -0700
Message-ID: <CAJuCfpHJ9PwNOqmFOH373gn6Uqa-orG6zP3rqk-_x=GkpUo2+Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] alloc_tag: config to store page allocation tag
 refs in page flags
To: Matthew Wilcox <willy@infradead.org>
Cc: John Hubbard <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de, mcgrof@kernel.org, 
	rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com, tglx@linutronix.de, 
	bp@alien8.de, xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com, 
	vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	dave@stgolabs.net, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	yuzhao@google.com, vvvvvv@google.com, rostedt@goodmis.org, 
	iamjoonsoo.kim@lge.com, rientjes@google.com, minchan@google.com, 
	kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 7:19=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Tue, Sep 03, 2024 at 06:25:52PM -0700, John Hubbard wrote:
> > The more I read this story, the clearer it becomes that this should be
> > entirely done by the build system: set it, or don't set it, automatical=
ly.
> >
> > And if you can make it not even a kconfig item at all, that's probably =
even
> > better.
> >
> > And if there is no way to set it automatically, then that probably mean=
s
> > that the feature is still too raw to unleash upon the world.
>
> I'd suggest that this implementation is just too whack.
>
> What if you use a maple tree for this?  For each allocation range, you
> can store a pointer to a tag instead of storing an index in each folio.

I'm not sure I understand your suggestion, Matthew. We allocate a
folio and need to store a reference to the tag associated with the
code that allocated that folio. We are not operating with ranges here.
Are you suggesting to use a maple tree instead of page_ext to store
this reference?

