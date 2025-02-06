Return-Path: <linux-arch+bounces-10041-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1D7A2A6A3
	for <lists+linux-arch@lfdr.de>; Thu,  6 Feb 2025 12:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8AF1889A50
	for <lists+linux-arch@lfdr.de>; Thu,  6 Feb 2025 11:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AC622CBFC;
	Thu,  6 Feb 2025 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YopcJIKb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D11F22CBF4;
	Thu,  6 Feb 2025 10:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839481; cv=none; b=M6NtpM1y6itMKuE3SELpZGcrrpwAqJJmC4edC1jzlcfOnitOSO9+TiqHRG7JS75ctnSlgyB7e14pwxouWeUXuE46pg1yg0km90Hah4JmAyHsEpq+/i2IDuwlfHOoNvNZHAZvHreFB13AVUgUiNKGbywbzBZmtMU0CjKeZWJLpJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839481; c=relaxed/simple;
	bh=RWheo7jB9CFPRMRRn73ubD2be1ma2wgGJgQQNlUo3GI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BmJ0jwi7BMDVC9kwAuASpTnnKSD/Wr9nJcA5DfDjkrak/RmLZpQAv3HkzptVGG8bKzkpwffBFGPTlh9wd5DQ3UvJWzXhTFgSggN7Ba5A3NNHbG4o29l7H3e5WCmAoEpnYxxGR3ORke7r4uAxOyu0keZ5XyWo2uspdPlFtVJL2PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YopcJIKb; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5dcdfa7df68so1372940a12.3;
        Thu, 06 Feb 2025 02:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738839478; x=1739444278; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UCwEnHmZYStesPLVZzhLCy/SlMOkoHP6UZc4smqj+Is=;
        b=YopcJIKbWyQURFRey38A2CrBw7jKRlPebgyy0nBN/QXMpypfKHR6VF9Ekblf/hxLkS
         CVggz8y/3CZc7SxLmaN6a4ZM7EQQSZM6EnipBKrwLYe8B5LgGcG4hnESHL1GS7ez9TWy
         4zEsyGRecYIzxWQVzNzQkgC4iGaknJP3kcu9HPb4mZEpheRHtdnaSWN+K4KORSD1nwXL
         GrKcLSc8vuYU3GXZMFGvRpKV76Jh49RYg948qHz+sKhe1bE73FbX+LPHQcPH0DF7rOnL
         R7OUwv/fy5lK9QmLlP5S1oDsCh+MPwqZE4crD7b94yS6kbBEpwar+6+ztio0Rt6nJcG5
         tcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839478; x=1739444278;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UCwEnHmZYStesPLVZzhLCy/SlMOkoHP6UZc4smqj+Is=;
        b=B47BqDMTwIvLRbOpLCNs0IU3QHKBn7qSRYN5a7SfvcyjHzN3PumN359fv6N7EapuPZ
         /O7/5DBmKiveToPbgraP4YnhYt3cQcGkOoUZQ5OgQA1i0vlXdOfe5/OQEpVYuYEI8BBd
         9DUOTVJpjhyL469yoZ73t7czSJjKdOcxK2PUj3WDDaMTf4GjQDRjLGKgzFc/h299F0SZ
         7GBgkxwMWMRsygLhMs+i8SgaLky9ST0dkXXoHSx8Y9uUo/ABAPILNPaGba3dc9Yo9Rw7
         SgyCUyUBVwGE9l5JonAJnodBnc0WNo+G4sVAbqdDxA1AJqA/qfi8H5YSei6Marp2ku+9
         iMnw==
X-Forwarded-Encrypted: i=1; AJvYcCUzMGW5XFAP+gZgVfSbKGTHh3l/uUd3Uq7G0Yfm03GOe0fxvbXU1kbsrytYxfcErjB5Ecuv8y96ianUixQM@vger.kernel.org, AJvYcCVyA5f2bmP8dz+XZAIL59bOotiFwYR0+JMqIJq1RdRsfdEMc9TvMWU2tNjma3KxXdynfGM22zlH8h7k@vger.kernel.org
X-Gm-Message-State: AOJu0YxoQnAc74ynIFUQOOoOuSHDy7VA7EqUsYVbn1QQz3ap8cMnfCzh
	GMizBslVOEB9M8uUhwDcwDTNwp74BjMPJm3Na815qPlRWD/PsEnqPkcW61+vqjlU4QFoDmBlc4K
	oR15Snbt7byJKABNEj4dGe9j4jyI=
X-Gm-Gg: ASbGncsyAg7LummNFHx3BtYU7kS7eXdxHzNsqTYqrcb8ClnyBQTnxlpFPTH5J9nHrRd
	8FhvXOULxqwVBtWG9d/BZxvacE+ncOJloPvDv2Do11JTkbCt/2Bnh8ec6LJfIOd+cegmmKhVvq4
	o=
X-Google-Smtp-Source: AGHT+IGP8tAW0CXvHNHg7p5sWcAX+S7UmNuU0OrOMLWbPyPHRVVI4cXsDxphL4+JA8N5RtUQ7mSHl6x3rrvdPIqiBpg=
X-Received: by 2002:a05:6402:27c6:b0:5da:a97:ad73 with SMTP id
 4fb4d7f45d1cf-5dcdb71bb7emr7512035a12.13.1738839477521; Thu, 06 Feb 2025
 02:57:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203214911.898276-1-ankur.a.arora@oracle.com>
In-Reply-To: <20250203214911.898276-1-ankur.a.arora@oracle.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 6 Feb 2025 11:57:21 +0100
X-Gm-Features: AWEUYZn3un_MskJWBGcJT6aFZUZFVS49qML1cEO5eTlJd56xDvMM1MKgwwStIVI
Message-ID: <CAP01T75B-UjoKugBsCHnfjwMmL5Bdfs+-YK3QH7mLUJs0+mmCA@mail.gmail.com>
Subject: Re: [PATCH 0/4] barrier: Introduce smp_cond_load_*_timeout()
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org, 
	mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org, 
	zhenglifeng1@huawei.com, joao.m.martins@oracle.com, 
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Feb 2025 at 22:49, Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
> Hi,
>
> This series adds waited variants of the smp_cond_load() primitives:
> smp_cond_load_relaxed_timewait(), and smp_cond_load_acquire_timewait().
>
> There are two known users for these interfaces:
>
>  - poll_idle() [1]
>  - resilient queued spinlocks [2]
>
> For both of these cases we want to wait on a condition but also want
> to terminate the wait at some point.
>
> Now, in theory, that can be worked around by making the time check a
> part of the conditional expression provided to smp_cond_load_*():
>
>    smp_cond_load_relaxed(&cvar, !VAL || time_check());
>
> That approach, however, runs into two problems:
>
>   - smp_cond_load_*() only allow waiting on a condition: this might
>     be okay when we are synchronously spin-waiting on the condition,
>     but not on architectures where are actually waiting for a store
>     to a cacheline.
>
>   - this semantic problem becomes a real problem on arm64 if the
>     event-stream is disabled. That means that there will be no
>     asynchronous event (the event-stream) that periodically wakes
>     the waiter, which might lead to an interminable wait if VAL is
>     never written to.
>
> This series extends the smp_cond_load_*() interfaces by adding two
> arguments: a time-check expression and its associated time limit.
> This is sufficient to allow for both a synchronously waited
> implementation (like the generic cpu_relax() based loop), or one
> where the CPU waits for a store to a cacheline with an out-of-band
> timer.
>
> Any comments appreciated!
>

Thanks for splitting this and sending it out.
+cc bpf@ for visibility (please keep it in cc for subsequent versions).

>
>  [...]

