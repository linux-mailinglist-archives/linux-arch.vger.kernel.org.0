Return-Path: <linux-arch+bounces-7363-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8679F97E30C
	for <lists+linux-arch@lfdr.de>; Sun, 22 Sep 2024 21:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247101F21178
	for <lists+linux-arch@lfdr.de>; Sun, 22 Sep 2024 19:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B47B64A;
	Sun, 22 Sep 2024 19:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZDOQFVcO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C26B2F2D
	for <linux-arch@vger.kernel.org>; Sun, 22 Sep 2024 19:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727034259; cv=none; b=I3bG+Q5ksNfhUo1JZMbiBjJwkxtTkYhQBPKqD6EMShDxZjs9ENXBBM9sv6Drgw/Tai1gc8iNWccalQhHVu7Xm84S/VOI1UzmbZXDCxW7SyMju2GyeC1CH/5/A42ypYH9DK+LoUwqVgUVn7IBGo3ZBGHB2KB7Opy/m6iZ/OG6lfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727034259; c=relaxed/simple;
	bh=+l4r0lSf8fP2xgI/sV8pT0OF6zq8vKiv/gJAe/9nKos=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rEjbzD/y0owkABNwiHpRZrIWGfpY+ZvCTYDA2JKG6C49hxdbC1hmfCjZVP9y4tD1L7JF10Jn0mx1mo6+LxD7cYAsbfL3rJvrf6kvPElSkEPPsX29t8aMBV3EPLwLL3ZNINTVYqisacvpF/YIPeqQgnvpHD1vRNZQs9lP1VOIrTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZDOQFVcO; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8b155b5e9eso535014566b.1
        for <linux-arch@vger.kernel.org>; Sun, 22 Sep 2024 12:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727034255; x=1727639055; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dYJ96bzwB7bpOSj60t3jZOszF/VQdizpR+a/PPLNZoY=;
        b=ZDOQFVcOYJTktGifKn/Zwp7uH/vP4T7gS3/hTcNDhcZN9ewvj+CuYP2OSkfK+tzGmc
         OWd0rBd7cJL+uqoon6ZTdXJQBYBdiTm3MOo3ninKNAoQN/OsMAA47WJRF1lmrxklRw4W
         SBvn/8MUfKZtiLsopzFi2JWKqUls8pkJOTd4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727034255; x=1727639055;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dYJ96bzwB7bpOSj60t3jZOszF/VQdizpR+a/PPLNZoY=;
        b=ZOdtJ14V4l7h576xOI4vCZBHNz8jCIyl7woXNS1s2YZVco3IZeEVUr5Bic7emxOa1/
         JlvUDblvucf6No9tc/QbDGQ89k/p9OM9Lh2Jz0e3Ekk2jHNk3AD/3vd6Zy3zx38AtJD2
         eA8YOLk3ZtIfhnqJmWakgMVsILBXPi/opxWZ3BjCH+yXAGZ++00Ou1NYeT2nqZcYrX7r
         MmTsQHm/IWKn51TyTOWj0TueplFbwsgBP8SY5NOTmg1sE5IWFqdAbARw5ALy6DpUR3oF
         dsTdegzK0g67H3wVElbij1RWFbBzuDErztkNlZpfYvvUfHDmOxFkMTeTb0oT8FQOpQJg
         KKzA==
X-Gm-Message-State: AOJu0YzQCXJ2g+Ij4ucgF5O7Qaqrg1V9mAN4yltrHuRCssFRyxN+ju1e
	B8+Q33wI2jAVGk8i4tHjQeN68NWoDdU/LJGkdI7+m2ksB1CLvZqjawyS+5TZeXMDQLXZkx8MPWA
	vmAw=
X-Google-Smtp-Source: AGHT+IEGDku2LVYTevv7Wsf27QH37DpRGTunzMGV1w513/h60i1dHYWZ0W5ayIWfzxaqu13g2twv7Q==
X-Received: by 2002:a17:907:f19c:b0:a86:789b:71fe with SMTP id a640c23a62f3a-a90d50eed3amr942184066b.48.1727034255037;
        Sun, 22 Sep 2024 12:44:15 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a906111a7a3sm1121995566b.96.2024.09.22.12.44.14
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 12:44:14 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c3d20eed0bso4251154a12.0
        for <linux-arch@vger.kernel.org>; Sun, 22 Sep 2024 12:44:14 -0700 (PDT)
X-Received: by 2002:a17:907:d2de:b0:a7a:97ca:3059 with SMTP id
 a640c23a62f3a-a90d5005f45mr858615366b.34.1727034253879; Sun, 22 Sep 2024
 12:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 22 Sep 2024 12:43:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg5eXX2+YeBP59so_i6O+-j-v325kV31kqu7dgqmA_ZbQ@mail.gmail.com>
Message-ID: <CAHk-=wg5eXX2+YeBP59so_i6O+-j-v325kV31kqu7dgqmA_ZbQ@mail.gmail.com>
Subject: arch maintainer heads-up: masked user access infrastructure
To: linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Ok, this should probably have been in linux-next, but it's fairly
simple, and it's entirely optional.

I just merged a branch that I've had around in my local test tree for
several months in one form or another: it allows architectures to
avoid the spectre conditional branch speculation barrier in the
"user_*_access_begin()" by using a data dependency on the address
instead of the conditional.

That speculation barrier doesn't really show up in any major way, but
this was the last piece of my "path lookup profile pain points",
because it does show up on x86-64 in "strncpy_from_user()", which is
obviously how the kernel copies the path from user space.

Not all architectures can do the data dependency model - for one
thing, it requires that there be a guard area between user space and
kernel space accesses, so that you can't overflow from one into the
other (because the address masking trick will also avoid even looking
at the size of the address).

For another, you need to have a convenient enough user/kernel split
and a known-trapping address that it's easy to have a simple
arithmetic "turn any kernel pointers into faulting pointers".

Anyway, this *only* makes sense if your architecture already handles
the (much more important) get_user() and put_user() calls with the
same trick. And I think x86-64 is the only architecture that does
that, but I thought I'd mention it to others just in case.

(arm64 already avoids the speculation barrier with a data dependency
on the address, but does so in _addition_ to the access_ok() check.
The new "masked_user_access" infrastructure allows for avoiding the
access_ok() check entirely when used).

                Linus

