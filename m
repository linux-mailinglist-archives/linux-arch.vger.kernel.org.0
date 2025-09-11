Return-Path: <linux-arch+bounces-13493-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3650B529EF
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 09:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C81CA030A8
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 07:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC34226B942;
	Thu, 11 Sep 2025 07:29:18 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EC62459FE
	for <linux-arch@vger.kernel.org>; Thu, 11 Sep 2025 07:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757575758; cv=none; b=RflrYydrWf4hmQuQpUsgQn71kDSV54uasoxvqNlzVYg6CSEApI3NQf/KEWSKa0gmh4e+GMOLy/rpVQ3hUlUAJVrYJktHeWZ4enGHbr1p8K9Z5i6bv6ESoNVBEYYPXZuwmbrDzAN9JVv6InMp2nhAw/R6xdY6roRk4XOjGbdGK5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757575758; c=relaxed/simple;
	bh=TEIRZT/f9ZFe+n3XMoz5gFPwp4mNtoqn58IEZ/HkxUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iMaaAdY/qUJtI8WLCHZK6w/3Azu2fLxREhwfz6UQeRwS4D3XJQmgu3gE6eWZ+bhbq1/isjcpQFaXJzr8pU3sIg+fUPy4e5nqp7qtHlDLA1ruLUjLTS6CaGjyLOYChnvscgl/em2oqoHHAIVgT3wBKP3m8dEKbCp/F5+AFjBRyQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5448514543eso278799e0c.3
        for <linux-arch@vger.kernel.org>; Thu, 11 Sep 2025 00:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757575756; x=1758180556;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XaFNAAT+NA6RCTfsICXLhuiGjMghVZ0R7BbTGO2fF0o=;
        b=tkI90YENBVSrrnZeQJwD18bhyiiTruhxZnsQ0yNigjQMOoUbwSkGKEOBKZLy6ccwUQ
         644j3HF84R3xjEkOtEILWuX/q1tWdhfNKMHySBQLAScpmiGV+4XlwvjGjQXE37i1jLlC
         d1MlFFfyh27MK73ztP0s5zmeBgYu1tFSB7it7LvAFq7P/PWwKuSkeiFczLm3vGO4EtLY
         6uZ2/j3A57zJjqZ5BapZU7jWFasd/GtaUv6fvDIGK0pYYEJHgAFZ/NZ2ChHrUhsf8xu1
         UeedLMmAx9ByGJ8gc2/2yi8XPPVHDOKpSfIiiFKh1z6A3gZcx0MyU54Rt2rjcKD8wJK7
         0vQQ==
X-Gm-Message-State: AOJu0YxsdkZqUpHxXybOwPga91I8NRcC9YBFhTfYXs6LTdue9kGEn5KK
	5ALQSQdyqR93sI9xf1Zw0ZuqQ5WsrAhQKBAhdoFC/lKGQTHmWAuUKCHPLBEOLVrs
X-Gm-Gg: ASbGncvd/moywA1E3FUeStAYBsi6wfI0Ytn1hhueBPXKwr3Ke3f3OOR8xSO/yTog+kn
	fmC5TrrVHhxo2O90i0NdU2e2kh6Ew8l4quPJ58WuuydYI2+he0p8Vj+WGvmKSSQcRRPCZiGAP7h
	fmB4ux/upGLoIYb8ZTdRuPWLD3LVLVFw4oZ9v/dGk5g+N+dNBwQ1TaFwYTqn2Mq5OylOWRlpyOX
	NKge/ROfuxl25yh6Fa1NrYRxm3ki5Li90R01jUtNgt0v31Yx6kWFYDODOxTZdemWJLg2gvi0rR9
	Qm7hGlWx0RaSkm8cqSOHR1/wsUor4XHg3LWr3JfuRGTGfXFpllCR/nd3LuUH6L82p1fUWPAIEh6
	QXA55oQhSijsga7KaU8NuxcTllJ7us8GDAQB6SoBEfBlvJVbzXGsToCpvrmUph5fqYpdPdWE=
X-Google-Smtp-Source: AGHT+IEDoV1EFkiY/u2dCtGNlwKnEZhQ7Is7LtaKPRZDU8Xr5VnRFEI74EqAmQ0R/JPEi+nmmSIEgw==
X-Received: by 2002:a05:6122:3d05:b0:541:bf69:17ac with SMTP id 71dfb90a1353d-5473d47c07dmr6324619e0c.16.1757575755660;
        Thu, 11 Sep 2025 00:29:15 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8ccd640bb5csm118244241.20.2025.09.11.00.29.14
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 00:29:14 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-529f4770585so316605137.1
        for <linux-arch@vger.kernel.org>; Thu, 11 Sep 2025 00:29:14 -0700 (PDT)
X-Received: by 2002:a05:6102:3e04:b0:538:dc93:e3c4 with SMTP id
 ada2fe7eead31-53d21db6e24mr6555906137.16.1757575754614; Thu, 11 Sep 2025
 00:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911015124.GV31600@ZenIV> <20250911015306.GB2604499@ZenIV>
In-Reply-To: <20250911015306.GB2604499@ZenIV>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Sep 2025 09:29:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU33x6yVYO143cGCnGAcccBSthjNg9G7uyp=0oOXJvi5w@mail.gmail.com>
X-Gm-Features: AS18NWABAcMzYPBfj9VhQL9kwryCB7SJ28D1zs--UCgO1nL2MCGED90_txRXdwg
Message-ID: <CAMuHMdU33x6yVYO143cGCnGAcccBSthjNg9G7uyp=0oOXJvi5w@mail.gmail.com>
Subject: Re: [PATCH 2/6][alpha,m68k,openrisc] PAGE_PTR() had been last used
 outside of arch/* in 1.1.94
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, 
	linux-alpha@vger.kernel.org, Michal Simek <monstr@monstr.eu>, 
	Max Filippov <jcmvbkbc@gmail.com>, Jonas Bonn <jonas@southpole.se>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Sept 2025 at 03:53, Al Viro <viro@zeniv.linux.org.uk> wrote:
> .. and in arch/* - circa 2.2.7.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  arch/alpha/include/asm/pgtable.h    | 13 -------------
>  arch/m68k/include/asm/pgtable_mm.h  | 10 ----------
>  arch/openrisc/include/asm/pgtable.h | 14 --------------

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

(I would have just taken it if it wasn't mixed with non-m68k stuff ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

