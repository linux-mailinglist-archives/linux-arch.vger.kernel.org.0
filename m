Return-Path: <linux-arch+bounces-8440-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B87799ABE9A
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 08:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFDBF1C21034
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 06:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7264E1482E6;
	Wed, 23 Oct 2024 06:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PrwYraWd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53CE13C8F6
	for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 06:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729664665; cv=none; b=IqfV9EjM8aU+a9/4loUT+0l6vO6B+urYN5l+HglQLzq1Cc5uA3fQQ3wem+/CE0odDYytK6c6V9ZeNLwEgz0QjbRgXqdcn4xQ7BP7FkGptEO070ncP66/4HKDFtq6idFhpSPyWMF3luapmPRcmOq+Np8UNMuz6faIGJlbWvvewRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729664665; c=relaxed/simple;
	bh=Kmf/1xEzbwqpAKJt9go6uvl87csSe+TqzWzUtyTAm8I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ecHvWh8PiUuYwC/I58JXdK1dJHksfrdEeGLm6ij33tgbKnRvf7K/7yB7M2GzKwzA9xHGcf/tlRZ8ZFuc8IRU7sKu44D6P8IPh3wq6tGEkDx9ROhL1AuMdnh3+/4kSLZemsm/HbCXuoFYO0v8ZSW4v9MteSzW6JHerxWfxQCvhUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PrwYraWd; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5c9362c26a9so3849875a12.0
        for <linux-arch@vger.kernel.org>; Tue, 22 Oct 2024 23:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729664662; x=1730269462; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kmf/1xEzbwqpAKJt9go6uvl87csSe+TqzWzUtyTAm8I=;
        b=PrwYraWdobug2t+uC6Vp7EV4xdzZoVwTNHirr73b2IFqvth+F4o5VWgdzH0i/gmNvh
         ZHKJqzhqNtxP4SqT2eY+kDTQkKUIEiSTrPi2nYwkJPIR9tvneugekSRGtKKYanGleFub
         MiPMP10l4ktHx4DwnjU+siCw1amlk+KOzUAMa8+2a55LPcNcIS61hYzNq+ny/WCJkCw4
         BkyTRidsui8NTTW/yt3kJxhZHry4mZHojJevjbmbTv15Y1da8qnnzb/yZeO/MRvUl2mq
         AENdyKhdfRgcLxVfG99qakdKL1WOe/Ui47pY20zETidEzKKkp81ECCFRYvnJmA1SptM/
         Q2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729664662; x=1730269462;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kmf/1xEzbwqpAKJt9go6uvl87csSe+TqzWzUtyTAm8I=;
        b=Fcz9Tp6Muat52p3JdCwLFmCCHXFwkmJlhxyq3sBoj3KN6Cq4UNKSjhaNsjRM0Wpe3l
         0EC1evHYta40+s5oi8Q931zXtayVpVyl+9fTx1WjU87YVqaI1mSEJUvEWWI5a+pV6btP
         1dqE4LVPy27eC6gglNYrSzLapadJYToBU0LRoa1VLLHbHy0bmfjQzf3Y87iv3WaZe554
         0jN0yulBC6rGcGAMbStTSgprXhyhDJThz80LMcs9jB+A/MWHkF3ZRwFTrCIyiUOAHUCD
         jZ3D6iw0gLhHLALqD9DcirB5WlGz+8g1LWU0jvlTAS3fJ0WeRyRh2kcoOnzyOdF7X+qf
         a3QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXTQYw0Ofd74a8s5ZoUU47GH9XesqxxbeGRbCtAGi/uhKHdgnIFVc9OiSr6m0RLp3M8j/YyN8hTIT0@vger.kernel.org
X-Gm-Message-State: AOJu0YwaEpCONLMecdRg+W+FI/Bxio2w89Q3zz0H8TIP73yhpUzCgLSj
	HYLqmf1Wicc8MO79/lE4GRqMYzKLVqwc2Cc4FYMBB7w2kGawWqAsvHHSeuIuKuc8dOuIAifYGqA
	x/s2/qg==
X-Google-Smtp-Source: AGHT+IH2bi6zc9dFjuEaAFUh7qdl0Clkcf7sHX1Yomy2F23FgFUOKN443WAQT8QytBDy9+TF/aj9qhft85qo
X-Received: from dvyukov9.muc.corp.google.com ([2a00:79e0:9c:201:6e9d:53fb:bcc1:7c2d])
 (user=dvyukov job=sendgmr) by 2002:a05:6402:3482:b0:5c9:5cbf:e5b9 with SMTP
 id 4fb4d7f45d1cf-5cb8b20d251mr583a12.8.1729664661613; Tue, 22 Oct 2024
 23:24:21 -0700 (PDT)
Date: Wed, 23 Oct 2024 08:24:17 +0200
In-Reply-To: <87a5eysmj1.fsf@mid.deneb.enyo.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <87a5eysmj1.fsf@mid.deneb.enyo.de>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241023062417.3862170-1-dvyukov@google.com>
Subject: Re: [PATCH v2 0/5] implement lightweight guard pages
From: Dmitry Vyukov <dvyukov@google.com>
To: fw@deneb.enyo.de
Cc: James.Bottomley@HansenPartnership.com, Liam.Howlett@oracle.com, 
	akpm@linux-foundation.org, arnd@arndb.de, brauner@kernel.org, 
	chris@zankel.net, david@redhat.com, deller@gmx.de, hch@infradead.org, 
	ink@jurassic.park.msu.ru, jannh@google.com, jcmvbkbc@gmail.com, 
	jeffxu@chromium.org, jhubbard@nvidia.com, linux-alpha@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-parisc@vger.kernel.org, 
	lorenzo.stoakes@oracle.com, mattst88@gmail.com, muchun.song@linux.dev, 
	paulmck@kernel.org, richard.henderson@linaro.org, shuah@kernel.org, 
	sidhartha.kumar@oracle.com, surenb@google.com, tsbogend@alpha.franken.de, 
	vbabka@suse.cz, willy@infradead.org, elver@google.com
Content-Type: text/plain; charset="UTF-8"

Hi Florian, Lorenzo,

This looks great!

What I am VERY interested in is if poisoned pages cause SIGSEGV even when
the access happens in the kernel. Namely, the syscall still returns EFAULT,
but also SIGSEGV is queued on return to user-space.

Catching bad accesses in system calls is currently the weak spot for
all user-space bug detection tools (GWP-ASan, libefence, libefency, etc).
It's almost possible with userfaultfd, but catching faults in the kernel
requires admin capability, so not really an option for generic bug
detection tools (+inconvinience of userfaultfd setup/handler).
Intercepting all EFAULT from syscalls is not generally possible
(w/o ptrace, usually not an option as well), and EFAULT does not always
mean a bug.

Triggering SIGSEGV even in syscalls would be not just a performance
optimization, but a new useful capability that would allow it to catch
more bugs.

Thanks


