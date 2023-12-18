Return-Path: <linux-arch+bounces-1129-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 204F9817C08
	for <lists+linux-arch@lfdr.de>; Mon, 18 Dec 2023 21:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350091C21B63
	for <lists+linux-arch@lfdr.de>; Mon, 18 Dec 2023 20:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7778273462;
	Mon, 18 Dec 2023 20:35:29 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7691DA29;
	Mon, 18 Dec 2023 20:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-203223f3299so111013fac.0;
        Mon, 18 Dec 2023 12:35:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702931727; x=1703536527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5muLLdvnEWK5GQ123Z96eJyI+5glad1JcNNdF8H1Jg=;
        b=QFjCXzQjZLmVr4iO9XA2sgrkBVSpB8/GIMU085B3NW5V+8rluMFDr1vI1KCwliLpTM
         TBb2jTYT6bR9KtAYwVdPjxwxiPozX015k8UgcEgfVSTc0k/gHFgelSGI58eA7U8SDLw1
         pBZZt5qY2doVjOnI2y9QVrFSBUSCp9pXOGmTHCOVuQ15o9BxmvgxKUcIwjzfxwwL45ry
         LzQsblDBGcQgwQiZw+hUKJRiFDDMEQsoTfe94joVIGlM9TQAr6mMxDkz9HWYzVu5gtme
         MhMCQa/hevzK9U1lLvU8SNBtcdvikQZZfSyjMo3yuRr6fuWGRyLXMleY91eScM8ZixbA
         xMpg==
X-Gm-Message-State: AOJu0YyeIJgMFO0elQr12OxlmdapBT8d0yvrHi556SzcPZfQXFCDfnxS
	A1Op+EXK9gV1bhHf1Z9QUgE9bO3NxwhhOv1LM1s=
X-Google-Smtp-Source: AGHT+IF1MjB6QbmwWfc3T+5pLabp0AF+8g7RLCoeqeEABS9CAvETyoAN6o6rB15S5OlZOByT2E647igWVuJN9yCJ/4I=
X-Received: by 2002:a05:6870:71ca:b0:203:e75d:a2c2 with SMTP id
 p10-20020a05687071ca00b00203e75da2c2mr729668oag.1.1702931727130; Mon, 18 Dec
 2023 12:35:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk> <E1rDOgD-00Dvk2-3h@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1rDOgD-00Dvk2-3h@rmk-PC.armlinux.org.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Dec 2023 21:35:16 +0100
Message-ID: <CAJZ5v0g9nfLrEf9u4Ksw6BOWJQ9iv8Z-O8RsLU6jR5zk0ahxRw@mail.gmail.com>
Subject: Re: [PATCH RFC v3 05/21] ACPI: Rename ACPI_HOTPLUG_CPU to include 'present'
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, 
	acpica-devel@lists.linuxfoundation.org, linux-csky@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org, 
	linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com, justin.he@arm.com, 
	James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 1:49=E2=80=AFPM Russell King <rmk+kernel@armlinux.o=
rg.uk> wrote:
>
> From: James Morse <james.morse@arm.com>
>
> The code behind ACPI_HOTPLUG_CPU allows a not-present CPU to become
> present.

Right.

> This isn't the only use of HOTPLUG_CPU. On arm64 and riscv
> CPUs can be taken offline as a power saving measure.

But still there is the case in which a non-present CPU can become
present, isn't it there?

> On arm64 an offline CPU may be disabled by firmware, preventing it from
> being brought back online, but it remains present throughout.
>
> Adding code to prevent user-space trying to online these disabled CPUs
> needs some additional terminology.
>
> Rename the Kconfig symbol CONFIG_ACPI_HOTPLUG_PRESENT_CPU to reflect
> that it makes possible CPUs present.

Honestly, I don't think that this change is necessary or even useful.

