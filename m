Return-Path: <linux-arch+bounces-9918-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8896A1DA2B
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 17:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F9807A4C9B
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 16:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349B0158218;
	Mon, 27 Jan 2025 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeaP5XGD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE18155747;
	Mon, 27 Jan 2025 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737994044; cv=none; b=MUYFabCUczi/2yYweWEofRW304V5zCSvTZko9TFxC2Cy7G0CK94BFDfQT0wBh/88IXP9VLrXgnSt9OaZc2osa0wCFYV+b5oUaFVlU1JC4XGbCN0oE7TBF0Ad9hqXl27cJ0lxYzCuBgRxtFNiTrEMp8ZVN50dGHnxOmnJP4iXnv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737994044; c=relaxed/simple;
	bh=+QwPUp3qsE13Mkc3DWfjMlz0Em0OicoIS5FT71+NDyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DkvT1tRJdZr3+erNjZ1Nq+3C6okhiHlZD8BbadyQDx4ccxqczoYNwsuvA3R/6Yuih+mUrA+TKDeZzwSCEywOkX00QCDSQc8wa/hJbU8+AhYEcx/r9gQSKR1PK9SRhbZ/huUBHWacLsBKyhIbTwTeJUrl6UfEMHLt6+jJRjc+kzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeaP5XGD; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aab925654d9so909936366b.2;
        Mon, 27 Jan 2025 08:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737994040; x=1738598840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WT5eWH6rZrIJLgUZzxnI1r9howrcT7ENhSKc9wgIf9U=;
        b=BeaP5XGDltUN8ywCC3iGfh5oy5oab5XGxEnEOseh/f0Y6H3vzd1LwRIHKGjj5pD2Le
         xe36+pTRGutyKoZkL6UYFmvOV/g/nWon4wJQ1crrGMrmB1BYYAXEYN6yE8PT7F9WvyIx
         0f7kXEHeNg8txQKDPCPAiYT3cXQ2ugBiOiQ/YeGSuBSmoEbjNfOVZ85TG6eXCqb7Gubq
         v/i29s0XHiHVSW7LyhfPSBKM3DSuucFyxCWs3hPLK70ajgXDiA7o9vzsF8fwo17T9RcS
         HDTOgeSsZUC2dCovEfJ/kk77mHSjh58S123VmQhMva5PGmBRA/HfJxAW113RrHyPUrg0
         1Jcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737994040; x=1738598840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WT5eWH6rZrIJLgUZzxnI1r9howrcT7ENhSKc9wgIf9U=;
        b=F9C/5qY5Gf2G8xSr4036OFdJEdVp4NRfUpxOY0/XmB1ecE9Oc8ixFH9nFIqI+TUWrn
         OQp/KX0rhjIJyh1NB3iIOXp9HWvGWtE9kkHB/p6wYPAefsMM8ACZnXMMfSeB96zLlbah
         tn5Fvzp6JzekbuWOgmIxtKbzHkYKAQXfRIu8Nt+lXd13mKLSH3CZXETpkSEYqa+ctpt0
         DLY2R8BTih3sPBHEwpQmZWpX38h8M7B9jGyas7rrW4uSqH9g7pDU4pwU5n33xs9iI2KS
         lCdlRhbMumm3dE/EDXsxSPzC8TZVMZL1h+aroyfM15oMSVfoUW7DTS5Hh8g8AclgLyfY
         VLwg==
X-Forwarded-Encrypted: i=1; AJvYcCU0fJQh3Xg4ZaR/UuJkNjV/Qb2Y1ONNN+KzRQpWoWWiLwEc2HWN32xj2vUsKysL/9me3zxNM3zCJx3h@vger.kernel.org, AJvYcCVQALGYN9tOYoqLugUs7e/taj6dUmIvho7/rWSg5dyEL3sdSKvyjcrafYBESvvdpZSIRVHccgE56ZaR+zH/@vger.kernel.org, AJvYcCVQPRlMSyj8u2huhe1h2txuAkF1+OuIv3W6kR896pB4JNAtpxpLvERpr7vUaQVhWb1uh9UQ2JBZVbrYlEcxMTE=@vger.kernel.org, AJvYcCWu07v1byz5T7l1gf/RWZpvKWXqszoYvimcHoK2XBUIfR4xIQoW4TafbsNjjRPoPWcSXckf1BHB@vger.kernel.org
X-Gm-Message-State: AOJu0YxNJxZw3kYb+2RC3PhomeADLRrXC7hgGiMo5pR4+42oqSZ/yOF1
	+BKJBbwa9V2DOAAwHvtH2cbX3+ulDabWXEo7LyboFEzGXvEqogNd
X-Gm-Gg: ASbGncu+UBS3ygA2dXPyDdq8UwwhbSXLvGWqcsyBFJbPc9a7O242LfbgWUx8er14PFz
	SObwcvVj8l5cRFnLPuT3nuyR41i9sOHx8HXGVcvH0Ahl9A++bj7Q76hvdaREXh/UyZ5aDKrUU3F
	ywIxVbcJ/cjJ2z5jyZhMkgxKIJA3WS5PXNIXHUmY+1sFyRkOaSQkDt+TS9nZ0e1YqL0hwnHVUn+
	+nvqhkiD+k8+N7tvXONpHQkcIUskNTfE2htlqi6MQDHtkhlfxBu+k9BptLE/0K57Z1j2O+a7R6f
	WO7Oi3in0HcyRA==
X-Google-Smtp-Source: AGHT+IFuULEp0GQymnkX/TKA35qIg1LycjVhC3Ts9VWHQc6Q18z1cFu8eW/Z/NP2jJeLUu8LFdZJ8A==
X-Received: by 2002:a17:907:940b:b0:aac:619:7ed8 with SMTP id a640c23a62f3a-ab38b1e651bmr3499843866b.7.1737994040271;
        Mon, 27 Jan 2025 08:07:20 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e8b01asm592643866b.84.2025.01.27.08.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 08:07:19 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
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
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Nadav Amit <nadav.amit@gmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 0/6] Enable strict percpu address space checks
Date: Mon, 27 Jan 2025 17:05:04 +0100
Message-ID: <20250127160709.80604-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enable strict percpu address space checks via x86 named address space
qualifiers. Percpu variables are declared in __seg_gs/__seg_fs named
AS and kept named AS qualified until they are dereferenced via percpu
accessor. This approach enables various compiler checks for
cross-namespace variable assignments.

Please note that current version of sparse doesn't know anything about
__typeof_unqual__() operator. Avoid the usage of __typeof_unqual__()
when sparse checking is active to prevent sparse errors with unknowing
keyword. The proposed patch by Dan Carpenter to implement
__typeof_unqual__() handling in sparse is located at:

https://lore.kernel.org/lkml/5b8d0dee-8fb6-45af-ba6c-7f74aff9a4b8@stanley.mountain/

v2: - Add comment to remove test for __CHECKER__ once sparse learns
      about __typeof_unqual__.
    - Add Acked-by: tags.
v3: - Rename __per_cpu_qual to __percpu_qual.
    - Add more Acked-by: tags.
v4: - Do not auto-detect compiler support for __typeof_unqual__()

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>

Uros Bizjak (6):
  x86/kgdb: Use IS_ERR_PCPU() macro
  compiler.h: Introduce TYPEOF_UNQUAL() macro
  percpu: Use TYPEOF_UNQUAL() in variable declarations
  percpu: Use TYPEOF_UNQUAL() in *_cpu_ptr() accessors
  percpu: Repurpose __percpu tag as a named address space qualifier
  percpu/x86: Enable strict percpu checks via named AS qualifiers

 arch/x86/include/asm/percpu.h  | 33 +++++++++++++++++++---------
 arch/x86/kernel/kgdb.c         |  2 +-
 fs/bcachefs/util.h             |  2 +-
 include/asm-generic/percpu.h   | 39 ++++++++++++++++++++++------------
 include/linux/compiler-clang.h |  8 +++++++
 include/linux/compiler-gcc.h   |  8 +++++++
 include/linux/compiler.h       | 20 +++++++++++++++++
 include/linux/compiler_types.h |  2 +-
 include/linux/part_stat.h      |  2 +-
 include/linux/percpu-defs.h    |  6 +++---
 include/net/snmp.h             |  5 ++---
 kernel/locking/percpu-rwsem.c  |  2 +-
 net/mpls/internal.h            |  4 ++--
 13 files changed, 97 insertions(+), 36 deletions(-)

-- 
2.42.0


