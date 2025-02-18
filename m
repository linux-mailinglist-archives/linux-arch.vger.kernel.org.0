Return-Path: <linux-arch+bounces-10165-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D47A39520
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 09:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCFAA1888E4D
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 08:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A1822B5B1;
	Tue, 18 Feb 2025 08:15:50 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F8A22B8D2;
	Tue, 18 Feb 2025 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866550; cv=none; b=MqoWZSaBVU9CxpOjmxZEnkfqCghv3XJDBRBBIQ9WGWpxPrHyl+C6pU3Tl6KAUF172CIp55MZVDmUwKAP8RCqoUySlOOIuWSH73iKyyO0vzJlNE0dSlSn+l76yQitSFtdSNZBHA3xT3v50x50bS2LC6NARnRogJbZHeRgT3JZ9yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866550; c=relaxed/simple;
	bh=hUhVSMiNBon3K2vaCA6tQYsPBq1I+3qyjxMNBRB+kOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpB3Zc7JX1TxhvW7Lfq2GmyY1BGASdNdI7rboOS+iGTd80gdME+6xJbTj7RkKhj66VxU11dupMSD6AJPEIHHFFhBMrQ728OYpFFLJIOELVq87Ha9zBDbdeYyzs3NSlbrwkcOqqhR2IeVeQeLSdLGyskMZ360bGpVb9QMNieIBJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4be66604050so467845137.3;
        Tue, 18 Feb 2025 00:15:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739866547; x=1740471347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K6Hz8bZDs78uyXHgQQ8oUf4o6rHFlSQuKCrUj7YwByY=;
        b=h+wR2ycrOrqVnyKGdEcFAXkjs9P9ct4q172F1Sa+IrUwjGdc8j8lrDng2cp+ssXN0W
         hOgLB+K5BXHMClm5ikeCvGIcyQ4Xm11jqrvSy58jQwNeqDc4QXwmVHWHJxFpbN9qNsKT
         vocjFH4aJpf4Y1oVtZa9tl9TvWpEp3D8sAhD/TOB85EIPFi8YRXxINnsQLSEBN9fFXkr
         4jKvUWPrFClZNz21W2V7KFWgd9G+CbkmW3PKN8UrkEMgBij4Ih2m09ZdsCSCGlJOuP9G
         m4oH21wXAVfHUtsEAwoZQ+wa5+T/d64fB2Gg0QUjuU0vtXbIK5TsnjCqyZ9QjTtWWq7A
         5Wyw==
X-Forwarded-Encrypted: i=1; AJvYcCUfpaR0Rrpr/ydPSRbLZVRIZEwxZaUTw8KZh8vEgWe7vzACNZn9OiYHRnZgQxFTqXtWHtPsRl1KaIQZ@vger.kernel.org, AJvYcCWGpFpZMBFtLsHqfnnBh+sz1pU/v0LFg21A0zvbSt80033LOQkaxwXOFEZQTv3q0c9je8rAufsgztL5HA==@vger.kernel.org, AJvYcCWiTRg4Jg7LmOwIa2iZ6PRDf0Ie47s0TKG5zUgGaVxO/G6RfD0r+UyNY4L1/816Vr6o3iF54JW5H20sog==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5xb+N7c8hT+R5b+yr++SeXHa9G6Hlk2R8CTHTqzjJCSUpXcKq
	FSxLNxhlqt+SKhqH/n2NyURVWNu9hJV/LA2fdmt1o/lbSIgN/KgHpQemHkbRNXs=
X-Gm-Gg: ASbGnctGV4vFv1LdgzDmb40Y9ZKgC2gct81vZirQW315fZLGgFF4f//7zg2HvHkQX05
	JsXh+Tq7DGI+0ggFB+6CukU6lSY6icWhkbAZecZXQ4tpTufhYnHegegkFkRhojy6KtIBG/7hboS
	yTin603dJ+19W9pMkYhtudG4Acu4tJnYR/DJFXBsN397hJU4ZYndSpGkTJPJtUaiaFWVbkHBZcv
	vLfSnteTtnDoSEx5T+TIgAQobWu8SJekdk4DM/kawqjg9BN2OudqA2GVcFmnAxtrwJeuyFbDbMk
	CGztfm+mbOBQvksSsFFo72WOP0s6Y7i+Tzpg5jVKY6a1M+l5ILrV4w==
X-Google-Smtp-Source: AGHT+IEX76G7/YcPfmDhLpq/8v43imczmXmfnbQxrZ2R0fm1QusDqKNHAjlipVipWh7vDVZcUM0Z5g==
X-Received: by 2002:a05:6102:2c82:b0:4ba:9689:8725 with SMTP id ada2fe7eead31-4bd3fd51580mr6366553137.14.1739866546779;
        Tue, 18 Feb 2025 00:15:46 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4bd3c9acda5sm1790288137.9.2025.02.18.00.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 00:15:46 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-868ddc4c6b6so1879852241.2;
        Tue, 18 Feb 2025 00:15:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7GsFGAw8oXkKVf2vWeMOx5mwEwwa7pwWScQVuakA7vPmBgXsNhX7gUQsBFjS5i9Y1AKKWcmXZA6gK@vger.kernel.org, AJvYcCVkZmpJes0DhivFZdutVqM2Hulv15oU/D66zdzgekl6EOigeFBA7X7Z88r5N66zdUyavDpqVGNSeB3mUQ==@vger.kernel.org, AJvYcCXc/qROJlrRTWcpU5r4MPxSpmMSQJ1ZVs0HcTXUZowMjAehIpIOl9PPRLTeVTPv6J7rKHM9qQkRJgwO8A==@vger.kernel.org
X-Received: by 2002:a05:6102:d94:b0:4bb:b843:95e6 with SMTP id
 ada2fe7eead31-4bd3fc9869amr6525145137.7.1739866546228; Tue, 18 Feb 2025
 00:15:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217190836.435039-1-willy@infradead.org> <20250217190836.435039-3-willy@infradead.org>
In-Reply-To: <20250217190836.435039-3-willy@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Feb 2025 09:15:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVGGPVxz6spuFhqZV5YONji+hOi2ALjBkD2Yt-xrb8R9w@mail.gmail.com>
X-Gm-Features: AWEUYZlUk2UQkMyt8RR6rg-cBVbuU2v1FebOMuVIYEMfkPb3IlGZ86jcKmJ0Nps
Message-ID: <CAMuHMdVGGPVxz6spuFhqZV5YONji+hOi2ALjBkD2Yt-xrb8R9w@mail.gmail.com>
Subject: Re: [PATCH 2/7] mm: Introduce a common definition of mk_pte()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Feb 2025 at 20:09, Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> Most architectures simply call pfn_pte().  Centralise that as the normal
> definition and remove the definition of mk_pte() from the architectures
> which have either that exact definition or something similar.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

>  arch/m68k/include/asm/mcf_pgtable.h      | 6 ------
>  arch/m68k/include/asm/motorola_pgtable.h | 6 ------
>  arch/m68k/include/asm/sun3_pgtable.h     | 6 ------

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

