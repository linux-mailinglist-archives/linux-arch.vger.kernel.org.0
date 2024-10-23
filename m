Return-Path: <linux-arch+bounces-8495-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECEB9AD3FA
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 20:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12403B21D45
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 18:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033301CEADD;
	Wed, 23 Oct 2024 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="eq/ELnXX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6C21CACD3
	for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708232; cv=none; b=q9m3v2z1yuxMT+exNmS1UF8zXj0V9nG9DFTyF+ScAMFcX+ymgFyckR459ZVQM1JWCN4DbTNfb/u0djbbUwXoKuIrg++utQQ6nH+WGTDVfhj3GCdM77ESr07LUY3URO6dhKrTB93H6u30ObdRxQcG6EiK5fWx3CPZDh+SnnZ5sZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708232; c=relaxed/simple;
	bh=ubUqy/1MJzXp3/UXBgXCxp9XPERhzWpzHXPp04ORje4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQnyRNDg+g3a4HXeyFbhCNKNEey9kp9Zo2aA0EaU5wS48LRgV04YMumW0Wby8Ka7aS8T3/XuLUD7xaE0cFIE8H4D79/29zwh2yahuuIL9k04zGsf9FYIBiFXoUaP3Ns+QNbFEMzAnTlI4eDZT6Og+MGmWl8wt9djP65m7ppB8ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=eq/ELnXX; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7181caa08a3so81739a34.0
        for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 11:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1729708229; x=1730313029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubUqy/1MJzXp3/UXBgXCxp9XPERhzWpzHXPp04ORje4=;
        b=eq/ELnXXiMmEb0+ITbFQVY6x+WyP9N5HJwQ+DbZaAbp4orjmr1MaNnlaIQo0CF64Mm
         suQYJiU3tugj0rwbPTSS+Lpnx5JIJ9bEIUQEZ2cstnHMHa39hmmr9w5PpYDfAZsr7Nhl
         /yvP8DQoTqRp+u1pMoAv7h18L57zC8idAlmXkrsHB7xx6XfuD/vyXvfrW+H1VUGCWeVx
         iiWK2ogNxcV84oB5dsbo8Y+YUktCxIerlie6bJ6T0dvH7xUcPiIKwGiWSngdpMr8OY+7
         GLtFnCiOEULuI4PcP71P2UD0SMF0xNykHuNiBtB8nsoM1tP49i8wzBlLKjBtsx3+WHad
         Sc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729708229; x=1730313029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubUqy/1MJzXp3/UXBgXCxp9XPERhzWpzHXPp04ORje4=;
        b=og3NusNMlqYwvYtdo/tzBGKNTf5IURR2tTiQ8niZZ08zR6wa7N5hzLTG8v4B4opQXp
         2FN7w62C9OXMxWcPenpri4ukqWZEDsxMUXC/xguIve92Db/qYfntdWgYMatdhho6K3iR
         PQNBgNQnXYx4gh5Fz1+lml7mlb6VxthVia8v5f1g5WT/oVW+nn2aQL49NJIs8O0dQwB4
         pOq6qmbTYcR4BNoOjDr8xmz4VoIGKHp5tfT5erLp+mkcJufkTmxdnGzqo8mxPjhdxv30
         LoZU1M+qLHeXBiHmW6QpzVe/o3WaF//rBSoFM/UBuKK0j8CcYI+PN/Xwpu+Pqr6kokia
         NTXg==
X-Forwarded-Encrypted: i=1; AJvYcCWqqHswT2aVDkeRz1cYQNVDPUaHuZkthV2zBj6opHbbwSpgCcfpb4An33K/Yx4BUyDkc44/U+SXTy+6@vger.kernel.org
X-Gm-Message-State: AOJu0YylCabHb3+mwzwR0/gcneE7u6fIQyMHrla6lx/nznxgN0N1jRyG
	nGlt2iw55yuTglrsnPlYdq6P/Om3v0QpTC81JTKkUacyliTzCux+g3QM10wPQ0bnPy3dxvKZuD+
	EjsC16TGAPV+Gnl78EQ0z4oNArDbFbLdwHypI1A==
X-Google-Smtp-Source: AGHT+IHZNmISvMTUF0Ry3WVIT6e83mSx+xUUgcWBYXzvmpfrEZ1SC65WVbmpMeEmSjAgZbhRAY6FHGSOWJPRJPg+7LE=
X-Received: by 2002:a05:6358:6f05:b0:1c3:7ff6:4a88 with SMTP id
 e5c5f4694b2df-1c3d81b1815mr252520455d.25.1729708229406; Wed, 23 Oct 2024
 11:30:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023170759.999909-1-surenb@google.com> <20241023170759.999909-7-surenb@google.com>
In-Reply-To: <20241023170759.999909-7-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 23 Oct 2024 14:29:51 -0400
Message-ID: <CA+CK2bBzZDdVN66qK4UQ4jpDuAABu89S3mVNbJipaJjL3bcg4w@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] alloc_tag: support for page allocation tag compression
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
> Implement support for storing page allocation tag references directly
> in the page flags instead of page extensions. sysctl.vm.mem_profiling
> boot parameter it extended to provide a way for a user to request this
> mode. Enabling compression eliminates memory overhead caused by page_ext
> and results in better performance for page allocations. However this
> mode will not work if the number of available page flag bits is
> insufficient to address all kernel allocations. Such condition can
> happen during boot or when loading a module. If this condition is
> detected, memory allocation profiling gets disabled with an appropriate
> warning. By default compression mode is disabled.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Thank you very much Suren for doing this work. This is a very
significant improvement for the fleet users.

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

