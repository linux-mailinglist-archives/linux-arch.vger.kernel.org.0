Return-Path: <linux-arch+bounces-9074-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD1A9C7995
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 18:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749E01F21DDB
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 17:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A60D1FF7C4;
	Wed, 13 Nov 2024 17:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aVXR1PMv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56CA13D2B2
	for <linux-arch@vger.kernel.org>; Wed, 13 Nov 2024 17:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731517579; cv=none; b=bi+dIkpvnYTmZHWcDGSlEQnSZfh2HjbLfzrW9/Nsg23QWZsgggPSCp6oHNtQ0TPg7dkGMo3pUYJefMK/bWIa9g7od+4+aEqgBINR9IM/jryDIlC37uuai3SqAnUxtsuFLS9/1yTu6L1fhKxJNOEM1cA58cJ/edvd3w0PlI/7sdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731517579; c=relaxed/simple;
	bh=U9mSmdvebpc7SIfdO7D2vMyeVPrF3HfFMdaTvCTXFnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btaE740edLZUlKwuhK+PeYU/xGmZMFgex2lkjoSlFE9CU7o9AEoHWy9wMPtvqLcgvQPI5msuSBUnH+DvH+kK42NoW9+JfUH93c74d/WrrBtyWQCM6Io3cK+TGK4cA9swK/KFXb383AAyx8hjw9WTGhMCCIpl4wxIkD1z6jbDZhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aVXR1PMv; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e5cec98cceso56840447b3.2
        for <linux-arch@vger.kernel.org>; Wed, 13 Nov 2024 09:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731517577; x=1732122377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7HNwvxjs7/kFqm+0Upt4VZLTejUABVboco4/4FyZBQ=;
        b=aVXR1PMvD8u0N/v5WwmtBrctnrDp5NkJvJ8B/kv7Lh+adIUE/fZ6FfGUjyqbgNw9KO
         36zZzwzrVG+hzunJiycvbqw0/F7YH0ivss9xJ21PUq8Hxk19ZNDYSZNNSb03nBOYzLNJ
         wP6xuGv1YlIPmkGqCTU/2Lk6oAt2g8kY4HsCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731517577; x=1732122377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7HNwvxjs7/kFqm+0Upt4VZLTejUABVboco4/4FyZBQ=;
        b=Wfj+JMc5hbZFmNaAIR+spJFCPj2VGDzwg/QEbIEZYGSwknK7PpNIQRxcDv0cQpNWHm
         72cbR9AiGxJXKmMtXu++slfiO/sTbGQc4gvgk+Q6EL90GvTbnR4oEY6ANll6PW40h2zi
         JeA80gHzUYPngxAGgzfFCAOiv4Ry/ZfAhCFNQoSONDfluMJJI7EHzq6w91abBB7TPiUa
         GrENeYFuXTE4heGHQmMv+DNkQTWNGIkX6bwUgSt4ehvUOqLv9ScX6ULtmmuEac25Hlz9
         knst2slE9zhQv6SZllvpYW58sFeRjUL77R95+QLI4Z0F4gvsWLIC3ktLfA7FnrH6LLtF
         Co0g==
X-Forwarded-Encrypted: i=1; AJvYcCVAg0UDLmJ1GTX1PqiJGWuIbZ/J1by+k3AROq6fDFBkkSGgJzbswruXORgWmq2ywXW4MQvZZRgQUR8/@vger.kernel.org
X-Gm-Message-State: AOJu0YykqUC9IOTban85HLlcjkPz1WJ2RqmJZHHIV8LrI79FWv4iKxJc
	/WFDRWEuJZAqMuN+E/8x7uL28kfsZi9RtrIvuAPW819F2n8p1BTNNb+BlnzJpJYNBnuzLuLInej
	pn4VXBFqZZlCaajYGyOFHeCM3oa+ETtm4KVewWT38lo1eeRUPrI8GNw==
X-Google-Smtp-Source: AGHT+IG3duG8a1UDQht/mWeuhARKmr++5c3TJaN8LKjjGCuT1HlbkFbDsA3tyK+oqirwuGtWZGK1XLeNQvJ3rvg3ziw=
X-Received: by 2002:a05:690c:6d0a:b0:6ea:8bd9:6b2f with SMTP id
 00721157ae682-6ecb32af35fmr39075867b3.4.1731517576775; Wed, 13 Nov 2024
 09:06:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113124857.1959435-1-chenhuacai@loongson.cn>
In-Reply-To: <20241113124857.1959435-1-chenhuacai@loongson.cn>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Nov 2024 09:06:06 -0800
Message-ID: <CAADWXX9-LY7aaMax6KdtDV+vOkm_WKE76Qmy4n3UHN61O=-2Lg@mail.gmail.com>
Subject: Re: [GIT PULL] LoongArch fixes for v6.12-final
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 4:49=E2=80=AFAM Huacai Chen <chenhuacai@loongson.cn=
> wrote:
>
> LoongArch fixes for v6.12-final

Hmm. This email was in my spam folder. I'm not seeing anything
horribly wrong with it, but I do note that loongson.cn does not seem
to enable DKIM, and that does tend to make gmail (understandably) more
nervous. Yes, you do have proper SPF, but in this day and age SPF+DKIM
(and a proper DMARC policy to enable strict enforcement) really is a
good idea.

Maybe you can talk to your MIS people about setting up DKIM and DMARC too?

Yes, it's a bother. But spam is a scourge.

                      Linus

