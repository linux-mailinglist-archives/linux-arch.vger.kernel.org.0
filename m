Return-Path: <linux-arch+bounces-10350-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFF3A43414
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2025 05:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6824516658C
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2025 04:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B9D1684AE;
	Tue, 25 Feb 2025 04:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMeFjPHQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BF4EEA9;
	Tue, 25 Feb 2025 04:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740457473; cv=none; b=L+HaxXZLC4/WBU8V2eN2fNokoP3L4MDS9iizeDu1NTSEagunbqO9LKzCvYBXHD41rNGFMcB5acoxDYNWscbqQkV2T9IVn01XaROWQww1bzaWFuSFyuKFR7IIcqUFWONKzcsWd6gzk69alWJV2RJ7lrlw1+sH6oFZ0jfN1E80PSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740457473; c=relaxed/simple;
	bh=0xBlOnbwWPcpFpEFFwo3az9IHLdEaVF/e2PiZf+/3Tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHa+CIL6COxJl/jZFJxqkKrYBrEFi3CN4Ls4oFcckSIENVSLnI/BgOhsUg1TykjFpfjKNyJ2knQeIgEAXFCIQS+4OHnTIdAGyi/q19wr6IYxY2k3yrMVHLF5PhNMoEDB5Gzawu/pAst5Njnw36Lf8CR9lAXnyPQ7mAdjb+TrCXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMeFjPHQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220e6028214so111589345ad.0;
        Mon, 24 Feb 2025 20:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740457471; x=1741062271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0QXq0XS1DMAs9J2jLZ98jTCNHr/BGJPzzAtLUhi5pf0=;
        b=JMeFjPHQv1n6JVl6L3ZsUU2S9CDlUmv87pIYrvSKg5R/Q2JtQd47frw1gu3J+4wtAI
         4ZIGgdHU9J9xs6GHpuWJ6rhxzfhMiqavHcFBltkCFXVSh9/OFVQXvSg9aOWGyFdAR059
         Tf+MyO9i7UX/JN7vRGXgxp+pzOW/tNIg09p/v4sPVOUf1lCnvFigk0DrDi76KpsnW9Qf
         N4jEok7ZaaJ6BqhFemC91MEK7u3rxnqPPZh6npCglAgiHF58ypTnJPxKcuJZcfDU9KqE
         oU2xigke7PnsAs38f49SLzRLkQNcMWPTmZgHLombcvFEv/aK+c9Dw6dOQQdgm9vmpK4I
         LmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740457471; x=1741062271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0QXq0XS1DMAs9J2jLZ98jTCNHr/BGJPzzAtLUhi5pf0=;
        b=ToyfD1c8qAxIMv7S3FcYf1FM6rDmImIJadY/A+a0+3UHwRRSPdfawJlLvij4Oemwlz
         OGcjFOwsmTk897oifAewA27nfAntMPpJwjJcZy+tCl30D54KXJX6diINxNOdxPa7d6ID
         DFo1twQmcKAp6eQ74XFJnfQvnscVHTryGRqrX7ZG9FNpnvrOgjSHXQ+2AAMxyH2rP3Df
         khWobxJdH31MeKZxtlevDeMqgf6rduAur7r7Pyt07mBM4QO0y8ttrYsD29FF0IUomE6Q
         eFbWXNtox2+F5QP1MLGFFh86+rr4wIFIHIKu4iDE4P6Hk2HHkHKrddRHFZskaGSjfsxp
         rVXA==
X-Forwarded-Encrypted: i=1; AJvYcCVDpD+V88m6fh3ZOWTtcBWOfzH5uYtRo+6/M2lfMrkFI8sx4KxIYp6baUJVtMpdiTi7gHkAlRVsu24i@vger.kernel.org, AJvYcCW9T8mjd0jf1OKd4CyKfhpnxWGCUq1KYHV3grM4NkmpXltp34vK2U5tVEvd5varuzCFLrolECxLxldz4g+y@vger.kernel.org
X-Gm-Message-State: AOJu0YwZJIN6PWLL4xF1uzKwsExPqfx6Gh5KOR0tcdFuFOegP+LSZf8c
	wgYgAfFmO3aOOwsk3LmPqMUUatnv9cPTi2yBeBSh1QUsVRQfNr1U
X-Gm-Gg: ASbGncsOSs91i5cYXyaRscB05yExAPXZ7a6R5ydqfUiAVoEGKQ3e5nXToO6PymGwyn7
	Nj7tBXxr+XnGTf7I+cj4/cH31awQZUX2T4123idA8ZqFDcgK/PaGllMXoH6YOBWdXXxa1RD2pfW
	1bjA4btuWxZ7bGfRX6xIBHbZHHH4Frcnwv8jBveQOWYLm8bz3+VLoxJgPgA2utVq2sveAIXQoAr
	EPmHLGvk6DCJOWMeKm2nWmKBINTJrT9rPuU3QuZnN+fIHKKwgI5rXEgGbs1x7FwnKTw+Z+gamUJ
	MWjJJSlUf9glI63j94+x1t/9cnKazbJ7+aYREDeKauEghqXrye2ZSexTbS+hcDeU6DkUJV5O
X-Google-Smtp-Source: AGHT+IHFL6RvLCzMfkpdq/lhGiaA43IWa0AsYFBQKyWXztLMGiZRzji2e0BFIghxYbY4ZIqQsN1xWw==
X-Received: by 2002:a17:902:f60b:b0:216:725c:a137 with SMTP id d9443c01a7336-2219ffb8b58mr294789865ad.28.1740457471345;
        Mon, 24 Feb 2025 20:24:31 -0800 (PST)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0ae9basm4341005ad.226.2025.02.24.20.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 20:24:31 -0800 (PST)
Message-ID: <105532ce-a41d-4f14-8172-cd68bdffae1d@gmail.com>
Date: Tue, 25 Feb 2025 13:24:24 +0900
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH memory-model 6/7] tools/memory-model: Switch to softcoded
 herd7 tags
To: "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, lkmm@lists.linux.dev, kernel-team@meta.com,
 mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
 peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
 dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
 Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
 Akira Yokosawa <akiyks@gmail.com>
References: <8cfb51e3-9726-4285-b8ca-0d0abcacb07e@paulmck-laptop>
 <20250220161403.800831-6-paulmck@kernel.org>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250220161403.800831-6-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 08:14:02 -0800, Paul E. McKenney wrote:
> From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> 
> A new version of herd7 provides a -lkmmv2 switch which overrides the old herd7
> behavior of simply ignoring any softcoded tags in the .def and .bell files. We
> port LKMM to this version of herd7 by providing the switch in linux-kernel.cfg
> and reporting an error if the LKMM is used without this switch.
> 
> To preserve the semantics of LKMM, we also softcode the Noreturn tag on atomic
> RMW which do not return a value and define atomic_add_unless with an Mb tag in
> linux-kernel.def.
> 
> We update the herd-representation.txt accordingly and clarify some of the
> resulting combinations.
> 

Having failed to hear from Jonas or Hernan in response to my question at:

    https://lore.kernel.org/lkmm/ec97f28e-31ad-4a45-ac87-fab91e27d4ee@gmail.com/

, let me guess.  Past contributions strongly suggest that Hernan looks after
herd7 changes and Jonas takes care of LKMM side of changes.

So my suggestion is to add a Co-developed-by tag of Hernan here:

Co-developed-by: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
> Signed-off-by: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Tested-by: Boqun Feng <boqun.feng@gmail.com>

, and let me add a Tested-by:

Tested-by: Akira Yokosawa <akiyks@gmail.com> # herdtools7.7.58

        Thanks, Akira

> ---
>  .../Documentation/herd-representation.txt     | 27 ++++++++++---------
>  tools/memory-model/README                     |  2 +-
>  tools/memory-model/linux-kernel.bell          |  3 +++
>  tools/memory-model/linux-kernel.cfg           |  1 +
>  tools/memory-model/linux-kernel.def           | 18 +++++++------
>  5 files changed, 30 insertions(+), 21 deletions(-)


