Return-Path: <linux-arch+bounces-9166-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDFE9D9C6D
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2024 18:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA97285EC8
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2024 17:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B351DB951;
	Tue, 26 Nov 2024 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blsAnjk7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B5E1AC8A6;
	Tue, 26 Nov 2024 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732641836; cv=none; b=Zgs+mlhPWLKwm/9j0EyebIk7XYMkgKYxmUUVUc1e8G6/1FKII6BiNGQSkikf7RiKB83xrBzuapBuB26lsCO+EcZ31wwyJmv6xnv8A5lqkMMVc58ugOcuVyPR3PfA/ukiUkT1NZ6PyN1lAxkKrODtu9L+Ol/PCv+pDAHJCDfjndw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732641836; c=relaxed/simple;
	bh=U2qWLpvmvrNRc7fBpmJACAoXp45wDX7aSHeyAukM69w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RWS09tV1RY0cYsN24yqE3DeVT4hHUAX0kkM14KudCPSODWitV7HmSCAOWnMjlvrZ5f0drP5PdD85V/B2L+nzITHWcULDvIKlin+PkEBHJ+1H8EAVn+Xa6TkGt16fsfgEEFGW+u5AA7LqijaXPc3NXaGIKGRKKmN8XXajC0f2qx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blsAnjk7; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9e44654ae3so792399866b.1;
        Tue, 26 Nov 2024 09:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732641833; x=1733246633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Erh3kDkyyLqMgBRTpctsP9hRptfdoHadkYL68Kj+DE=;
        b=blsAnjk70GyW/Q4EyY5ilD/7rNsNXCfdWulDT/Da0yKClNXSO/0Xr5KwbqdbGMuvpJ
         begI2oRdbw0VBXHRDJ7XKA1A+1Y9WNUUjnTrdQ8sv0HA/TcYErgJJvgcKjKPl4YpiUje
         Vvk7ql+ZyWPk46Egq+fTOnyQzC6J0kC8RWvdKIzDS0vGK9c0QCXH44RVQ1XLyUFb08MI
         Ui7gAbI1++7yoYe60CAG4lC0hT7fBpeA0JT184EIJU4Bf5l72kLTfO7S3TmID9DYFLT/
         8qslenLo2lBEZzULqILX4DILIXxAMiTbQl9mOzCoCHSqWDH5MOkJaWbABzsb7gUzbCQO
         64Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732641833; x=1733246633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Erh3kDkyyLqMgBRTpctsP9hRptfdoHadkYL68Kj+DE=;
        b=wFm9T/F2+Mxn/xao/iO6xJ6VkgqrncgbiBvimaVZ8yEWpO9FrsLB/cCsFps4L3jYLy
         cYBGrkP0TR6p2yHBElfbk1Hpe3HMgDyNydg4PgcjUcc2yNgOwZioTMmhqhXK7+yi36jW
         WZH2IYW5/l7yDVsCt8QwpWDxCOI8y4dCboL6uEi6c3z0s2El3a8uURXslksCLKlxL+Tr
         6TuTPSuRb5pXDrBwfS1JxGBb9LbrwtILQQokgkeS/uZUcFXom6M1zyrHMOaMpE4sLuUq
         v9R4YSf3uqRVwn79hkZaQl+6HSxqpCjxbWWeWcXqzAe0vGAJ4JGa0nS4OWSLx2vukzjN
         l0wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtxn/JWZrteI4HT/fVuR/yeyrazO88SqmUQcaIAgpAvNf+k1kQwltwMFnQpyFCI8wQ5rU+OwefaBdu@vger.kernel.org, AJvYcCV0Vp9JTjZLO+Q2MJMt9s7DTKQOioA66k2lYpidZF9kOf/p+CkpKg06jJ56AJ5qZYExHt2aQ2uM@vger.kernel.org, AJvYcCVIXEALO9+yybyfWaAuiDcPx9BkjCQqgvHpQoUhZ5dQ8uQNRwAjZB5fapjATkr5UDHJMmk97PEl7VpIaOBx@vger.kernel.org, AJvYcCWmkxgaGV3O54K7zxZb5LEWDz/NSsprs1YgXKMb7UV3HO/+9zNrXAFloQoXpDi/prUauOcFhMObjV/XfU0Yi7Q=@vger.kernel.org, AJvYcCWq0J1UwnSYWGCjkjxIZwE4un5GIVFeLbVTVDV2iblAtdtD+oK3HQkwVGeJRCNYdXwGkvkGSTUvz+C+dtrE@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6kqSFeySwb2H2DX3O7DVfYS3azVF97fOWAfoI07BSXnbfZJCO
	XwwcTM36N+JPjzMcqeytyOr0yp31V4kyA2NHOhszaWPx1Ty7xkjE
X-Gm-Gg: ASbGncueS+j/UWtaDH+dETCBGfjWKgtkcpwozuBNKSV5NptpWmlFvxQHMGnzligK202
	W1lNE55IS8RUPhAbQIq90aGAlHyximpsGjBoUBcFx6mHqNsu3nKl4MOnk7cd6zxsli2dmqkKVj0
	IXi+dLFFu380ffZKjtguSVB/1m1qh15IHL0NZkWrtEvp5mC3UQXmJMPtfiylPK+HYlT+7YwAErw
	ZxOW/l+bCldx9RCkK8cZqm+Hej5SHtcH3D/YwJvkh2NUvsbUDsXEoKqUk4=
X-Google-Smtp-Source: AGHT+IECV1SfPk75kkOO3nyGfh6AJfPnfs9z/0KCVg6p2LbUtu1npUxOUG5Li3TZL6yCbXfXk+iKng==
X-Received: by 2002:a17:906:314f:b0:aa4:9ab1:196c with SMTP id a640c23a62f3a-aa50990b24emr1417865366b.9.1732641832663;
        Tue, 26 Nov 2024 09:23:52 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa534232086sm473832866b.42.2024.11.26.09.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 09:23:52 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-sparse@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Nadav Amit <nadav.amit@gmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/6] Enable strict percpu address space checks
Date: Tue, 26 Nov 2024 18:21:17 +0100
Message-ID: <20241126172332.112212-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset enables strict percpu address space checks via x86 named 
address space qualifiers. Percpu variables are declared in
__seg_gs/__seg_fs named AS and kept named AS qualified until they
are dereferenced via percpu accessor. This approach enables various
compiler checks for cross-namespace variable assignments.

Please note that current version of sparse doesn't know anything about
__typeof_unqual__() operator. Avoid the usage of __typeof_unqual__()
when sparse checking is active to prevent sparse errors with unknowing
keyword.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>

Uros Bizjak (6):
  x86/kgdb: Use IS_ERR_PCPU() macro
  compiler.h: Introduce TYPEOF_UNQUAL() macro
  percpu: Use TYPEOF_UNQUAL() in variable declarations
  percpu: Use TYPEOF_UNQUAL() in *_cpu_ptr() accessors
  percpu: Repurpose __percpu tag as a named address space qualifier
  percpu/x86: Enable strict percpu checks via named AS qualifiers

 arch/x86/include/asm/percpu.h  | 34 +++++++++++++++++++---------
 arch/x86/kernel/kgdb.c         |  2 +-
 fs/bcachefs/util.h             |  2 +-
 include/asm-generic/percpu.h   | 41 +++++++++++++++++++++++-----------
 include/linux/compiler.h       | 13 +++++++++++
 include/linux/compiler_types.h |  2 +-
 include/linux/part_stat.h      |  2 +-
 include/linux/percpu-defs.h    |  6 ++---
 include/net/snmp.h             |  5 ++---
 init/Kconfig                   |  3 +++
 kernel/locking/percpu-rwsem.c  |  2 +-
 net/mpls/internal.h            |  4 ++--
 12 files changed, 80 insertions(+), 36 deletions(-)

-- 
2.42.0


