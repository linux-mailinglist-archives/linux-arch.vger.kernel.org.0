Return-Path: <linux-arch+bounces-3507-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8D689CCD6
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 22:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823921C21D33
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 20:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF4F146A62;
	Mon,  8 Apr 2024 20:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aPs+q7yA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6E01465BC
	for <linux-arch@vger.kernel.org>; Mon,  8 Apr 2024 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712607062; cv=none; b=PnlazZ3oZOGg9g2S25KOfHKTZdJgZSAqiBgqRhhIui+qLQuielkHUSIVMnXxZRoRM1YuBcH7ePIa7GWka0ZeW7hogvhle++QNYlDjEOC+x8x6xU2D9S3gzIxoH7MAMp0WgV4gOOUEwjNYIzxFjnZ/fxIDz8yzIIwpSL6qISUtEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712607062; c=relaxed/simple;
	bh=T9Axq0K/iXwEnSWdW8NNAFCF+A5jnAQA1gx3vfuBArU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oe/Q74VPJmLI92s3ZVvVBI65TCxJigxZXuG6V06KDqygJwMl2lgX8mm6wkHMzY/MBUN2++OS+n7NQLKDL9Jkw5XrRWf7R/GYS3Hrtz4ALOWoJr1mvDnaPnQUpaffOY5JOP8yT53gKtLrFpvQw68XBY1Q3LVqT/zzyOq5iZCXqtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aPs+q7yA; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d6e23253so3440646e87.1
        for <linux-arch@vger.kernel.org>; Mon, 08 Apr 2024 13:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712607059; x=1713211859; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ciB+yk+sxj3WjvAOZ3AtBhLNrg4E8Qyg/edsGuYwbwE=;
        b=aPs+q7yAgBVasoggG4grCJ3UPNqX/QnLIDqUzlKgr8AEcslwhpXb1i0hq/k/hwXr8r
         70PPe0HnvTM9sYksj5qT7iElMJ1a8W1UxYWTj9rsGnaD0LxhNgC8LRtNFzgCO8FHWnkV
         g6bDcPTL/ebjPSwi9IgZX1DeTZw+fQBgK5NjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712607059; x=1713211859;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ciB+yk+sxj3WjvAOZ3AtBhLNrg4E8Qyg/edsGuYwbwE=;
        b=eoc6pqyYRjvcopMVtnR3CtAlXXAh75b9FIxB+PRuIlM7iq7idCI7lSG+xQ+UACfaVm
         3Y8hiVzMGxEAxiXpsBL5AxfOXZ4U/8FAMgnTXj3QE9ynhmdG2nPR1UoCKt77dheQWDoc
         vYmSbppFYgQBIAC4R/2MKNjqMqmqfUtJq/Fkfvyy6NkX70IZoh1OwRGSpPM23C0jYiOa
         x4bWMpbwVF3Fplq2LN+U+vaJjSmYfEEdtbi0Lm9VI6uyYFwGekjVvnMrEiF+2yQPt6v9
         gf2dVxxNPFK2hstnx3TgEEUNn7cmAi4cE0rHYvJjzRB7QbboUSnVWYedBM7xBSz2cC9T
         HfuA==
X-Gm-Message-State: AOJu0YwCmGUEISZGyO9IrkenD/tRUZSDPmq9KsdtI334kXCN0SUYJxO1
	fQ6/O1VyhLWr0UKvKzFEuHMfxmDJRi8/2QBNrlipB1W6HQrCSrCltFl654elW4Y6H30KyS7lSn0
	gX9nwZQ==
X-Google-Smtp-Source: AGHT+IENfIWrl0cRUwgbvhNC80NKGXQFbm41uoZDZBNgFytEpOSM9pc4lBTHG/GAPKa5RX7ofYc7oQ==
X-Received: by 2002:a05:6512:3c8e:b0:514:88df:88b9 with SMTP id h14-20020a0565123c8e00b0051488df88b9mr9609262lfv.45.1712607058775;
        Mon, 08 Apr 2024 13:10:58 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id t27-20020a19911b000000b00516a096a35asm1312844lfd.123.2024.04.08.13.10.57
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 13:10:57 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516d0c004b1so5504081e87.2
        for <linux-arch@vger.kernel.org>; Mon, 08 Apr 2024 13:10:57 -0700 (PDT)
X-Received: by 2002:ac2:54bc:0:b0:516:afb5:6a71 with SMTP id
 w28-20020ac254bc000000b00516afb56a71mr6509617lfk.67.1712607057038; Mon, 08
 Apr 2024 13:10:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7b3646e0-667c-48e2-8f09-e493c43c30cb@paulmck-laptop> <20240408174944.907695-8-paulmck@kernel.org>
In-Reply-To: <20240408174944.907695-8-paulmck@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 Apr 2024 13:10:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwbdbNXeJ0m+YZqZcxKPD3v4dbcPVCd6gP7YkwCM=X7w@mail.gmail.com>
Message-ID: <CAHk-=whwbdbNXeJ0m+YZqZcxKPD3v4dbcPVCd6gP7YkwCM=X7w@mail.gmail.com>
Subject: Re: [PATCH cmpxchg 08/14] parisc: add u16 support to cmpxchg()
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, elver@google.com, 
	akpm@linux-foundation.org, tglx@linutronix.de, peterz@infradead.org, 
	dianders@chromium.org, pmladek@suse.com, Arnd Bergmann <arnd@arndb.de>, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Apr 2024 at 10:50, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> And get rid of manual truncation down to u8, etc. in there - the
> only reason for those is to avoid bogus warnings about constant
> truncation from sparse, and those are easy to avoid by turning
> that switch into conditional expression.

I support the use of the conditional, but why add the 16-bit case when
it turns out we don't want it after all?

                 Linus

