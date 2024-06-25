Return-Path: <linux-arch+bounces-5122-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FDF916FEE
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2024 20:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88D81C2254B
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2024 18:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721EC17A906;
	Tue, 25 Jun 2024 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J0hMxccY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF48143882
	for <linux-arch@vger.kernel.org>; Tue, 25 Jun 2024 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719339157; cv=none; b=cmgrWpx6ROSaJcHmNmvyM5OAf3ESx6VKfQtlGSi+N10sUsKYJx4GXB2+luWzqz56inLYZcDs0R9wfGcno845VpL3dIdDzqVWyUB19EK5S3vE4xvpD9hT1x9Odn96Z9iyA13A/h+qfZ/PYO6HnmckUNk0rl+uGgdvVfCsoP4mcdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719339157; c=relaxed/simple;
	bh=nGXNe+PE/VAVWq1alIdYYv4xLsJd7LfebmRVN6KSWFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/jIGwC6xfcBF3q0wOLL+C2ZTep9eA9dHGKDEO4HJqDyLs3iL/7GufgeMZhFsnmzEyL84SPPDfxzpKEplnQuf87gX4FS5erZnB1CYQ/eY15d1BiwAfnAz6GX8khfz/cMLdEI9GHwZYf8IwO2qjELn+YdV6IzMQZlqEs7yOezPyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=J0hMxccY; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ec6635aa43so19833191fa.1
        for <linux-arch@vger.kernel.org>; Tue, 25 Jun 2024 11:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719339153; x=1719943953; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p6VwDOaqwr4wbQW4OWCZIaWgizSIAoa+poBbII7mCEk=;
        b=J0hMxccYPGtfuMKqTv5dFbMf4qdl/21KEFg3OOlgjHOQkNhka47cbUuEPA2y7xa64G
         MEUkQf/2UjF8CnIkcowXYYyjVASaKDCGT7ySJAFXQmNIuIQP4ZbIxgEfOyA+RnAwzHv0
         WAQAOq1Ny82gHsJM+aQoFMo+Q1yKmsupIcouI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719339153; x=1719943953;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p6VwDOaqwr4wbQW4OWCZIaWgizSIAoa+poBbII7mCEk=;
        b=B4tAjtcLW45tpxy7cq+teWvqf75lY1cEwcE+RC527MsEAnfo7nM9RTiILv0aqHJAl2
         WTrz+lko71ynuY5ax/TD9Cll85u449ZstjrKFdHR+Gnn8/9UoK4Hq6FM15qfcWaxDUcO
         bgeQQeLeaTAoVfOg04YuiBdw61MR9s5e8CLRAqnBFl51hk8KiUI003Z3/3pEBO4oCk+Y
         4cwYHnPSBPuH0Bgn9tUqHikf/4/blFWVC7aD32eCmM/cExEbjZeXVtnf8hNx2ijtZTn/
         KgBRfSVk43JgLpLrAQsqdDJcCAwTGoIup9PdrI3RaqApEdRdlPWW7VoU5wAxCzWP+QrA
         e2Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVwi8l/EXjZMKuT51zawEjblfMD4uvU7w3tT8m023fnPYt96OURwgn6V07sEVPldn7iMd2+xjK9K3nYkgmBkEadpP3LRiBZ2IJyQw==
X-Gm-Message-State: AOJu0YzIydJkUnG2UldJ6R9Ox3Yf9SC+cGLgZ9ZruFTT4lY5bhcpI/KH
	ddxtK7AICEnepwrNFm01w/sZx0vHHmAAx2Sz43KKIiM1F/BkCGXAnXmwWQYgG8KC4TnlEf7r1GR
	30gf5Lg==
X-Google-Smtp-Source: AGHT+IGeuOsL/B8E6RL8iOMEcNYvz+M8N/DfEN1DSmjNMffe9rrGEXdyAE3JeZ6ax1Mvun1kS5xt1g==
X-Received: by 2002:a2e:3e0e:0:b0:2ec:54fb:c833 with SMTP id 38308e7fff4ca-2ec5797b042mr61693631fa.21.1719339153175;
        Tue, 25 Jun 2024 11:12:33 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d757f7asm12119061fa.86.2024.06.25.11.12.32
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 11:12:32 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52db11b1d31so12568e87.0
        for <linux-arch@vger.kernel.org>; Tue, 25 Jun 2024 11:12:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5rPkNzC8Q+o0TjdQoFAGF9clmFOUaCvxzaDxrCUIkCpmOXkQm4yyCh3Gnjq6Rc1vn9wUJ9/4GWy2ip3DHe7AXcGW2aGRC5LJMOA==
X-Received: by 2002:a05:6512:1594:b0:52c:cca8:a9fb with SMTP id
 2adb3069b0e04-52cdf820956mr7108544e87.42.1719339152174; Tue, 25 Jun 2024
 11:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625040500.1788-1-jszhang@kernel.org> <4d8e0883-6a8c-4eb5-bf61-604e2b98356a@app.fastmail.com>
In-Reply-To: <4d8e0883-6a8c-4eb5-bf61-604e2b98356a@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Jun 2024 11:12:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjDrx1XW1oEuUap=MN+Ku_FqFXQAwDJhyC5Q1CJkgBbFA@mail.gmail.com>
Message-ID: <CAHk-=wjDrx1XW1oEuUap=MN+Ku_FqFXQAwDJhyC5Q1CJkgBbFA@mail.gmail.com>
Subject: Re: [PATCH 0/4] riscv: uaccess: optimizations
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jisheng Zhang <jszhang@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jun 2024 at 00:22, Arnd Bergmann <arnd@arndb.de> wrote:
>
> I think the only bets we really need from an architecture
> here are:
>
> - __enable_user_access()/__disable_user_access() in
>    the label version

KCSAN wants user_access_save/restore() too, but yes.

> - __raw_get_mem_{1,2,4,8}() and __raw_put_mem_{1,2,4,8}()

You still need to split it into user/kernel.

Yes, *often* there is just one address space and they can be one "mem"
accessor thing, but we do have architectures with actually separate
user and kernel address spaces.

But yes, it would be lovely if we did things as "implement the
low-level accessor functions and we'll wrap them for the generic case"
rather than have every architecture have to do the wrapping..

The wrapping isn't just the label-based "unsafe" accesses and the
traditional error number return case, it's also the size-based case
statements ("poor man's generics").

The problem, of course, is that the majority of architectures are
based on the legacy interfaces, so it's a lot of annoying low-level
small details. I think there's a reason why nobody did the arm64
"unsafe" ones - the patch didn't end up being that bad, but it's just
fairly grotty code.

But apparently the arm64 patch was simple enough that at least RISC-V
people went "that doesn't look so bad".

Maybe other architectures will also be fairly straightforward when
there's a fairly clear example of how it should be done.

             Linus

