Return-Path: <linux-arch+bounces-7375-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7648097EF41
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2024 18:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185391F2268D
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2024 16:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE1F19F11E;
	Mon, 23 Sep 2024 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O7L0fRk3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E24197A97
	for <linux-arch@vger.kernel.org>; Mon, 23 Sep 2024 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108935; cv=none; b=rFCzHQ9KC741aK5hWeL2rg5/s3RqjGbhSFgvucHIpNVjaw4hJOifQlUboxU3xL3T5L1UqFKN0vb6hyv0KBZp5/ViPYOfTaXRGXGGh+QfJu3My8n4Jsv9PlcsYajqVvlUjnU7d3IruNzIvPTEOZ8b3GUJSOhUa3DjbwpTyKpLt8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108935; c=relaxed/simple;
	bh=+T8OHCsnl0xm/aiwQxXYggnb8lS4bf/DjsuSlEb3Jmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGkewSjvs21MqvK/G1ZL74JO2ez7d0ON2TzQ5q9XAy5GR4SLm02LX+cQmw/NhtfWUVt8A1pViQl7cI5yc3DPNrqpvbZZHHaU2VsHZpT43e3HebYixlRR5NWsqthCkVEzQyMTaIh1wFR8WUu6BB+iqTNGr+c1UB+23DojYw5CR9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O7L0fRk3; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d13b83511so557598966b.2
        for <linux-arch@vger.kernel.org>; Mon, 23 Sep 2024 09:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727108931; x=1727713731; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D6O4DcTTpjoMkUJHje/dzaoACgQ68Lelk+k9yz/L1L4=;
        b=O7L0fRk35WtgfzY4E8un2pXGKIrA2nSJNuJSboGeYbXHHPiQ0PAjOPv1RPoAT69wrI
         quMQzQRUi/N6loOoQiezesCjddWo0HZ3od/0PTRqufqUD97qnf9zIARZeYRLiB5VSw8Z
         KvDVuyw9qfIxqMEatfdNAERv+f0jUgrzYedSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727108931; x=1727713731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6O4DcTTpjoMkUJHje/dzaoACgQ68Lelk+k9yz/L1L4=;
        b=JGDOD+syE0eWekZOKfvLY1CnoC3y4YwIz5KeloLorjkEv/ZsahPvC+9gU9MZz5r2ID
         xyKiaDex0NWIhOek/P8GzVal0SnRFO6USGQugMpwp06M4UkMKkFSSsA6s3AwJyovanFA
         tz8x7Hei9/MA+VK3iJJuJzx/NPAV5wgy9YZkEZseZ1dsrWyO+m0iicit6YwMPBdjgBGe
         VmLmgKUiyMus+uAkgMu7sZszLTxkQCRPUOqFUt4xg2xaUtmIhX8A/Q6aN2T5lijLGu91
         AZ2mOOyZ0ypVhnykUY3xB7+oJSo1loowrSY8JfPoPtuWP9JbhfWc3hRWmpojhdy0xxnZ
         FgZw==
X-Forwarded-Encrypted: i=1; AJvYcCU3Tql2iKLN/BzF0U7/MKBNwTcKwDNzOBxs6YhqSXxg9A8WcH6b+PAnS3PXUV+OcAGayio4gyynEY93@vger.kernel.org
X-Gm-Message-State: AOJu0YyIPFC+utWU5YNsGMsgpBCxBOcjstUWnRJaeE5VNHU1EbWmCpJk
	VGrxwTlqtizi7XCWBA3RX1t4qr/n4KoYrha+tP9VzQ2ic53ZZP7fT3lAYxqx411BvpTbBXHNFn5
	69fE=
X-Google-Smtp-Source: AGHT+IGdu455ncxiTHwiOyAmObJgMPdYM+cpEz8dvFhldIDbSspkGJZMLsrRQwJezndT/taWurC16A==
X-Received: by 2002:a17:907:368d:b0:a8d:5133:c426 with SMTP id a640c23a62f3a-a90d5925759mr1097184666b.45.1727108931482;
        Mon, 23 Sep 2024 09:28:51 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612e4b87sm1270987966b.179.2024.09.23.09.28.48
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 09:28:48 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9018103214so663119866b.3
        for <linux-arch@vger.kernel.org>; Mon, 23 Sep 2024 09:28:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVS9sgtjpxleZ0XhL3xSjNv3s/RIHefxjHhIoMwdHAxJuV2ftWPQ2h8dd9mjZlbuynwrLh0oaWsCst6@vger.kernel.org
X-Received: by 2002:a17:907:25c2:b0:a8a:780f:4faf with SMTP id
 a640c23a62f3a-a90d5925392mr1037193466b.47.1727108928289; Mon, 23 Sep 2024
 09:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912-seq_optimize-v3-1-8ee25e04dffa@gentwo.org>
 <20240917071246.GA27290@willie-the-truck> <4b546151-d5e1-22a3-a6d5-167a82c5724d@gentwo.org>
 <CAHk-=wgw3UErQuBuUOOfjzejGek6Cao1sSW4AosR9WPZ1dfyZg@mail.gmail.com>
In-Reply-To: <CAHk-=wgw3UErQuBuUOOfjzejGek6Cao1sSW4AosR9WPZ1dfyZg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Sep 2024 09:28:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjdOX0t45a7aHerVPv_WBM3AmMi3sEp8xb19jpLFnk0dA@mail.gmail.com>
Message-ID: <CAHk-=wjdOX0t45a7aHerVPv_WBM3AmMi3sEp8xb19jpLFnk0dA@mail.gmail.com>
Subject: Re: [PATCH v3] Avoid memory barrier in read_seqcount() through load acquire
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Sept 2024 at 08:22, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 18 Sept 2024 at 13:15, Christoph Lameter (Ampere) <cl@gentwo.org> wrote:
> >
> > Other arches do not have acquire / release and will create additional
> > barriers in the fallback implementation of smp_load_acquire. So it needs
> > to be an arch config option.
>
> Actually, I looked at a few cases, and it doesn't really seem to be true.

Bah. I ended up just committing the minimal version of this all. I
gave Christoph credit for the commit, because I stole his commit
message, and he did most of the work, I just ended up going "simplify,
simplify, simplify".

I doubt anybody will notice, and smp_load_acquire() is the future. Any
architecture that does badly on it just doesn't matter (and, as
mentioned, I don't think they even exist - "smp_rmb()" is generally at
least as expensive).

                 Linus

