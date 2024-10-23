Return-Path: <linux-arch+bounces-8494-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAEE9AD3F4
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 20:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9A981F2336B
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 18:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172BA1D0E18;
	Wed, 23 Oct 2024 18:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="l41O1iFV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724821D0B82
	for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708175; cv=none; b=bGBflxkRV7k8N6csHRNWHm5mEOLyvNKxrKEBqLl58Pro3NfkGt0Lx3sSWeRGUD9Xi6n6vMLhK11uY6KuKzXb79S0tI+fDHscVwraHSQLiKUvQ38kyo99f/LzukcQUjbbi3ElBwUG557OEZeO0Tz0vZNFQBJN5vNggdna1pD3x6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708175; c=relaxed/simple;
	bh=YhPnAykY09uvgHUZD+9d/UbZg3530EutzeGDcUlZqBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sG1AOrUnAfS5KA7OQAyS1EAbnQlSKKJFzEw7x7CW6snzJR/7DamW60NCZm+ZVchjrzIDUHFItPCnyvKloUl9b2zYaXAcj/ET6llDhvfqLfNk+Baao3+UD1PsVipsPjzTLLD/EjQVTui1tvfGUML54240SpX8FeG5cvOFo4SURxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=l41O1iFV; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b14077ec5aso110624885a.1
        for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 11:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1729708172; x=1730312972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhPnAykY09uvgHUZD+9d/UbZg3530EutzeGDcUlZqBw=;
        b=l41O1iFVAutM2hz7AGWo/j6xOhU2PFxEx3MEZgiIdS1XCq8chZmIyY+pa137USSA72
         wBm4IkA64jiTRSMqaXveII1QTDyGbG361pd8P8q+P3Q9/12va0P/2LxDr6rxDoy4EjJj
         S953rHYLlQp6cDidA7++Ho7HkFeyDwoeXh2UYzwhikaMMfJtK/tCSr1EqdenurZjynxy
         L9o/xzIc52UvRHV6MAtS88SejRaNR+dFjKRrDq+u1D94aNnkYb1FHngQrY8u+TzKbEw0
         5LgxCA2TWPGcqqvixL4/vSbYrMqlMoQoFj3roXHKF6uhjjh7xJZ6GUQY8VUSCYnqhcBR
         2tWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729708172; x=1730312972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhPnAykY09uvgHUZD+9d/UbZg3530EutzeGDcUlZqBw=;
        b=fCFP+vfT2S95mrDucsPEhFSm/CnGlnaIzS7eIUiF/hki2IwlL2gqb2o4tpmAh1QnGd
         vmrMxeVGioLLxI56UfNAp7IzJWtmHVZWIBa/WKdLkixUFfHzHMiAQOFLIVV03cfP6Kp2
         xO3bbYzYOlh/sAogkizG+Hl6x5Ah4hu3lRsZ7RPApAItQ0YTqmiF2Cm5kfGnlS7p1l+j
         lf/EjhX5cX381KHrGbeoTR9SrTNYtSAs++fBfrMEnaiXfmgSBgI6emjqsPp3r8xbIlxp
         R1pumtdZ8CtmrhlGwDyPrbFImfpwC4GnEGTRHLWWAc6tN07MyN3TjRFsxjJcPE4PoxCE
         O15A==
X-Forwarded-Encrypted: i=1; AJvYcCVQM2eV1RYTxAl61urP+Wz85HgOmsVisG1S4emqAD4Qk4qBM/ygryFJ2BfRxTQr/dxoaFRcCE+N/zHY@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8QXZEfnH3AzD8Hma2JZPPOxAR4HZlehJvlANe8B8dd0i1005W
	BDwxFQErgXaC8UiXbgbMu+dSXf+4eWgxFDXCAQgIlGyhHAa5Q9Id0cmykeAipGKwGrfvtBx69jv
	3iy6+Pp31sO2Qe0qkQQvHJBiVFr7odpJbtDBf+w==
X-Google-Smtp-Source: AGHT+IHN7Nn8TYgf6aogO4v+tavfp3Kp07Bk8F4db26KNztW0AXCpL0TnRtSVX9bTG1k+0/2LMpyl/hzTzQRoJaHQbk=
X-Received: by 2002:a05:620a:1994:b0:7ac:b95b:7107 with SMTP id
 af79cd13be357-7b175583433mr1343572285a.12.1729708172364; Wed, 23 Oct 2024
 11:29:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023170759.999909-1-surenb@google.com> <20241023170759.999909-5-surenb@google.com>
In-Reply-To: <20241023170759.999909-5-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 23 Oct 2024 14:28:54 -0400
Message-ID: <CA+CK2bD9UQsh8224QqTTAQ_Ybz23BE-DFeubLkf41psXBsMA=A@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] alloc_tag: populate memory for module tags as needed
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, corbet@lwn.net, 
	arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, 
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, 
	xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com, 
	vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, urezki@gmail.com, hch@infradead.org, petr.pavlu@suse.com, 
	samitolvanen@google.com, da.gomez@samsung.com, yuzhao@google.com, 
	vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	maple-tree@lists.infradead.org, linux-modules@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 1:08=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> The memory reserved for module tags does not need to be backed by
> physical pages until there are tags to store there. Change the way
> we reserve this memory to allocate only virtual area for the tags
> and populate it with physical pages as needed when we load a module.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

