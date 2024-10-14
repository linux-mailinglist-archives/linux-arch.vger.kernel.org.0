Return-Path: <linux-arch+bounces-8078-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E9599CACC
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 14:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64FBA1F22AAA
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 12:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969911A76B9;
	Mon, 14 Oct 2024 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eNwsM+gj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA0D1A01B4
	for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910631; cv=none; b=jxumwwl1phUvaBfFq+pMiObRobRlAb84Yi1YuwoyYw9Lvji8C65/qOak5sk8kVtIyDCKEtIzdyf2RthguG5JeTjaaQ+QfwGPmXijwUrTUn3nsP/a2zt79kTWDCn3oCOBUSS1K5vF7KVAbUM865wVqaBiDcM4TSVOfMM9UuRVOwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910631; c=relaxed/simple;
	bh=95q1qEv3AreD4xQZZYXqmAGp2B69fftSxlZEkzq05Vg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hG6Hw5DIcOdN4vxZLoXz+HO6bD3l/8GAcpvhEkeXk7c7GTr/Cxi2ni98/gbC8EKxlcLOSgp1NUTEWpb4YiX0wvtH/xKV+wSmu+Sl6k5BoKyvpleJoPqJYitsIECliUxfPX+rbt9nvFS33rGnMsmHqvyMZfMJqeWvOSRqfIJT4zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eNwsM+gj; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3204db795so60975267b3.2
        for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 05:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728910629; x=1729515429; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t6li6wFeQ4E3rD2qiNU9/G5GhCLFz3hLIbapKHZloZU=;
        b=eNwsM+gjRUpqYj+RgRbpG8Fk54P2nGeDnaTest7cbyD2at/6Xg+rz+9+OS1827FL/b
         Bb18OsALStX8dzAAPUkA358aZE8ckR0vwZQsTrYK+matjs03OJw2RzibxNo/Kqe9HYQu
         SFZhBryByqQFnTQJKg7jr2vyr8V2P8ZLPCXat6atzX8FS9pnNQO7VS4DI9SMzXJ54/9e
         2puP9x2tf9fkqXL+gbK5k+3WDaygO+cwapCBiKRbP8j2o8ZpO1h9OdmqzzYxk4/ApDV8
         ifygR4ZcDgP4PQqQYjDLkq2iyP/qVY43NvS6+z52FEV4yjwKDW1Pfw196EkAjQSW/SLS
         pzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728910629; x=1729515429;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t6li6wFeQ4E3rD2qiNU9/G5GhCLFz3hLIbapKHZloZU=;
        b=AwQ5GBdWA4m90y8+z19R22F+z4xXdorBqIo7ev3Py801CbXynM4ybMVRXARF18PLJF
         5amm+YDhFlTqL0RMcIGzylW+XH/9FjBxLgk6CVnNo/Jb/NclM/XpdfXJz8PI+C2NFAo+
         bRhTH/i5DNW+AlISxRaUOkBdD+pDSDxFf9gb8+n7W6UpTggmFSqWbto8BCpQj5Cj/xZ7
         5mH8N9STHax7swQxUUjgTQkg8OsroLwOLTonn5ojUYKHF3hbsYF8kUp41jFd+DxtoZT6
         13xjrkF/0tLcOhU53U70N3w7iCr6VjC9u/StN5VDyr2MuXwHSguCpJKL3w9HGKjybdJE
         nOZA==
X-Forwarded-Encrypted: i=1; AJvYcCUlLvv8MU1U8dhgBd4XeuD2HGwm2fNNlRe5WzSQdqOba/0r+/xz6JNtm+GUwxPYFglplTuoarY7dC/E@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk77D+5FrV5QQRZlh5Wghi1qyVgdp30kJfG/F4g+kNTWplx2AY
	ejZM8wE38yi/Aqt1nM0QNjr7TxC4ELatKXGG+TmE56Luoal5iAD34wCdIccN226e6IxP7Q==
X-Google-Smtp-Source: AGHT+IGTU3Vxqy01+1H6TKajVNIl45h3QLSGp34rJErLGk2Yt75X/DddK3F0YmEjLLNQykAVyV0SclC8
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:2e12:b0:6e2:371f:4aef with SMTP id
 00721157ae682-6e347b2fe3bmr274597b3.3.1728910629046; Mon, 14 Oct 2024
 05:57:09 -0700 (PDT)
Date: Mon, 14 Oct 2024 14:57:04 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1194; i=ardb@kernel.org;
 h=from:subject; bh=91Wge0c+Id4XIKd5WqFFlARMHKg7IsAMaPdrRhgkLZg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ1XVCErR0q3bPvkx3mb+GYJN59u6CxbnyV960v5QsWAz
 mvN7xw7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwETi7zH84TcyXWAgIuH+S3fS
 S9+36odq19an2tZdvjxHnGHqtKMzFzH801ikayRtr2u99VqFsVtU9BvJn2LLGGYYVFyvmMx5744 MHwA=
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241014125703.2287936-4-ardb+git@google.com>
Subject: [PATCH 0/2] Use dot prefixes for section names
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Pre-existing code uses a dot prefix or double underscore to prefix ELF
section names. strip_relocs on x86 relies on this, and other out of tree
tools that mangle vmlinux (kexec or live patching) may rely on this as
well.

So let's not deviate from this and use a dot prefix for runtime-const
and alloc_tags sections.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kbuild@vger.kernel.org

Ard Biesheuvel (2):
  codetag: Use dot prefix for section name
  runtime-const: Use dot prefix for section names

 arch/arm64/include/asm/runtime-const.h | 4 ++--
 arch/s390/include/asm/runtime-const.h  | 4 ++--
 arch/x86/include/asm/runtime-const.h   | 4 ++--
 include/asm-generic/codetag.lds.h      | 2 +-
 include/asm-generic/vmlinux.lds.h      | 4 ++--
 include/linux/alloc_tag.h              | 4 ++--
 6 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.47.0.rc1.288.g06298d1525-goog


