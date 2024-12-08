Return-Path: <linux-arch+bounces-9305-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 030ED9E87D4
	for <lists+linux-arch@lfdr.de>; Sun,  8 Dec 2024 21:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D86280FFD
	for <lists+linux-arch@lfdr.de>; Sun,  8 Dec 2024 20:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2068C1586FE;
	Sun,  8 Dec 2024 20:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G16evrTg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C54837160;
	Sun,  8 Dec 2024 20:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733690846; cv=none; b=AsxZVqz//0cD2Y/MHBLBzzUSWGLTy/SzuZA4+Pe0zLEbLVuZXDMRN9PztSpgeMjYg6m0+EjVW+vw0A3B7bBR4fRGeKkZ+xN6BWqQmH9QJRxoe9AYaY643VwyQUAoxECM5xLWletYn2i7EiVwYkXLuEeLI+UWFJvtFOBe6wlZ4KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733690846; c=relaxed/simple;
	bh=wvTHlBoz9C30davazZ3R7eA+Vj3AKi08qx/aTOFW1pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FWZLfOWX/PnPezyEQThuRXUE4/yVEcMjc9S0F798rXZ2c7X8aieESoNDxR+odFlXxx4s8NK0bciigEwoMCpre45qB2qa0plMmcIb0UF9xm05dwVcvM3omEMdSM59rej/BCpcjfJC2iQjF4yxy1nHdYuXfINyzHqYqps4ET6Ex5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G16evrTg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a2f3bae4so40524545e9.3;
        Sun, 08 Dec 2024 12:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733690842; x=1734295642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uydVfRix40VtM5XGFg4FP+2BbqHhhGYzjwg/+qRitoA=;
        b=G16evrTgMZYHQgJq2t4ucbMLgPw7IjpTn/Owk6E/fsU/aDeOWQcvu4M8VEBWUYs2Yr
         4GbhKU2gzFgHjEdsyPatPUQ4RoCujcO+oZ4fRpWBh7zMI9OXF9WJIS3yrwmDZOtVKRJU
         NpjLu5kr0spJYAw37zYytOd9wK/qrNgNV8pHxyhL5ehdAyV5dyax7kGeicloFaxGo2kN
         jH5ZSBzx1ImJKSsZMkSIZK9w7jplJ7avVGkoJrt/mBlThv0Ey4qHq/tflWw6WgPIcn2B
         CvGyPhi2aiG9+ZDYr/PyLNWbM8e8huuTr9acfwaKsCPIzjdKJEcLO+h//tu/bo7l5SIC
         VgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733690842; x=1734295642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uydVfRix40VtM5XGFg4FP+2BbqHhhGYzjwg/+qRitoA=;
        b=RbDLK20QizKayeodtxJpIeSWS560s8/0vOtwb8YJZ1JmiXExQeASRXRXz6P5aS2EET
         VAeuSGUCtt9fE/zSx7V4866zUEmjxdyI/YH1vki2++dmydnEtE1FMe70vaUspzHTuve8
         ZC27uMnUAgYL2S6atVDkRHar/NFrVO3iaKIofc+GUznh4OpRMSBI0BaJhotOg9sX8Rle
         tzHvUkQbp4uiAlVIZJOScJAc0hvd+XaM/WXGwj5eNdsEjIKmRIqsGZrq5DFbO2jmf0Dm
         rjSuReUqhkzhmPRjeP2bXNeIypQgcEwHmHYrXw5NpYikEuKrugjfsb5JVzyM16fkCjU9
         YTNg==
X-Forwarded-Encrypted: i=1; AJvYcCUWAHQXjrTuwMyxBLx6n4KqByMfJowH4d0krB3/gWJi86WRQzfRJZoOAwhcPpxB1CJmc4F8wlL1Z+P1VbF4@vger.kernel.org, AJvYcCVTBnyRN11hzX1ustFB75e8M5bqK9zebYL/j2UIJDtcfVQbBjsEP5Kf2cpUq3i3wocJ1JsPrNtL@vger.kernel.org, AJvYcCWg2Aqxod2JvF9jV7tgHDg2llutBXGBLa06Ny+GLKcAEV7NSD+efsfrdBgqlZtyubTgf6kzG+XyNgyu@vger.kernel.org, AJvYcCXeDA6gDiLdN+Sfk67wwlz84kpv2zHJRZCZNBUr2gRiTtdVCO1oGQ96o6qBbnF0FUoSs+IxLk0Hw4coWZ/nfiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc3iO2Jvr97RtqwH4SNXgTz7w33uaxxE+3MEDKwI4ZbEG1v9ps
	OwBbLqUk6O3MOOJLhedji66OfR59GgggdV7MUAPq+eAe7LDFF2dv
X-Gm-Gg: ASbGnctv37QQk0Fukx0T42wZbmdDO5v5C+c25NioBUej+g9SJPjUSnemphmz6GFN3Iz
	qDEaDIbZ3GXm0xhbrTyNMoiI4yU5jxWS5SXMFiUVWNTvTRq65garKQWKDCWkoS7MtnujyC4BxNv
	RYki37d0xlgVE0OYIs9DOoXm8k4MwyjSRXYY72JbwVXGY91XHxR39Q4Quq3vyV2tIn9lTqLUZnE
	rj2ijv2D9D4q+kEWgxUyulFoJsktw0WjcjJ0PUVrOK6/6D0uK+kdrZtccw=
X-Google-Smtp-Source: AGHT+IHFzU3im506LwOrHouMZuWAgeUYsws5o5LtVKTrGik4PmUi+r8oEAGSFnNWQi82Ax6AF2zxOw==
X-Received: by 2002:a05:600c:1909:b0:434:f586:753c with SMTP id 5b1f17b1804b1-434f5867ecemr15873445e9.7.1733690842202;
        Sun, 08 Dec 2024 12:47:22 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f59cc6fsm10874975f8f.34.2024.12.08.12.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 12:47:21 -0800 (PST)
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
	Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Nadav Amit <nadav.amit@gmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 0/6] Enable strict percpu address space checks
Date: Sun,  8 Dec 2024 21:45:15 +0100
Message-ID: <20241208204708.3742696-1-ubizjak@gmail.com>
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

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
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

 arch/x86/include/asm/percpu.h  | 38 ++++++++++++++++++++++++---------
 arch/x86/kernel/kgdb.c         |  2 +-
 fs/bcachefs/util.h             |  2 +-
 include/asm-generic/percpu.h   | 39 ++++++++++++++++++++++------------
 include/linux/compiler.h       | 13 ++++++++++++
 include/linux/compiler_types.h |  2 +-
 include/linux/part_stat.h      |  2 +-
 include/linux/percpu-defs.h    |  6 +++---
 include/net/snmp.h             |  5 ++---
 init/Kconfig                   |  3 +++
 kernel/locking/percpu-rwsem.c  |  2 +-
 net/mpls/internal.h            |  4 ++--
 12 files changed, 82 insertions(+), 36 deletions(-)

-- 
2.42.0


