Return-Path: <linux-arch+bounces-14002-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CD9BCDB4D
	for <lists+linux-arch@lfdr.de>; Fri, 10 Oct 2025 17:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 410AD3562B5
	for <lists+linux-arch@lfdr.de>; Fri, 10 Oct 2025 15:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB042F90E0;
	Fri, 10 Oct 2025 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cukOrGdK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C762F8BF7
	for <linux-arch@vger.kernel.org>; Fri, 10 Oct 2025 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108713; cv=none; b=S6TJEM8qlm6Ayvht7U4kVEcC2sJ9tu3q0f08GvGF2MYW8l+7+uce5NnsFDs35bSpo766dis6JAuAdfmhCohSJE7L1RXtEt3ecgUwALc9sloE8zxv5I7hyQNwUmQay9czq9Lb7co2WZ0UFO5TkjUbR7fDAAD7+XxEqdpqCZAwo3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108713; c=relaxed/simple;
	bh=auvR4vzTTatOuCuru52VOtm4KI7SmeTOVUgJyw2/46g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g6oNf6pmHUY/TjfnF340aA/pHjylEfgnc3IBpeVZeoBEnLqEC2oD/amNOMdf3jALKAPlq6b8YhlbC6PNer1w27va+gk/TPCTzB4AtT41Bz5o4IOD8WTh+9ztNEgC/yRfGMPxlMO0UhzvZFWBf3rBbUzOD+K2Y/d+UHZRKigEij4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cukOrGdK; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3da3b34950so358792566b.3
        for <linux-arch@vger.kernel.org>; Fri, 10 Oct 2025 08:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760108709; x=1760713509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIWxPopIPg40sXCXJnzxg4lhVvntApAACn3HESqIPcY=;
        b=cukOrGdK67ALc138mnVZJfA3nAbcSaf9ydeV1KhpWWi4VAc2Reodc632tdlco8WCam
         6lmTryDBz8Pwky0HIhVJGEdxdSIf+t7NjJZt66/OCUU01cmxp+7b2d9nrdbpTot4q3Xw
         PG8OPQYolf/jm7ASPNQQLQxnQpjWMLLE8DE0H7sAy535HzhvOfIi9iDMTUNjgURkfN38
         sPcLH8bje6HSkKtd2nm1jf0miU3Fm3O8g947/Ybrc/iWH3QK6BG/H1hhM4S750ZmcsYw
         dK2uOqJRJTQHyoL56Sg0wLuhcKFqk5jTN+4Tgym4kGXc1tRa0WHfSarSptSXNVsGG1tq
         IDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108709; x=1760713509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIWxPopIPg40sXCXJnzxg4lhVvntApAACn3HESqIPcY=;
        b=pWoaFiA4kPBhjsrkjIY/4usvFPylExIrgdHRMwLnrHUj0qHB/B8QjQ5powvlfu2/VX
         1TDBJUX0AruKJEcNoyg2HxIjfHVPp/FT5ZOlbM7a8nMT9Yu17YAGKpl+Ig5igc0L3mm6
         fsJukOaUgBLqDlQRtHze4p0+kq9HTBW4uPO7ObzL6mYTqbmldVhwz3f840KrAtvEr2dp
         +OeM6da5PaODnWjUwOyYUIqXvs21CxLdY3BM7ktpFqswYJbYF+oaOYZzCyUf3tC++14k
         q/s8ncxGgNkazMPvXB4IZRIfXiVI51H+XaT/wDikjSFWUbU5JmXwcsARfJayrvPAOCR+
         gejQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZDST9sH3tRnkXEROswaxwkcV2wqAdz6RV3fXNgczMj4IK1vUhG2GDmR5R14YB1vyDPGD/eu0vYavJ@vger.kernel.org
X-Gm-Message-State: AOJu0YySwzjGBxdZinpv1XA8+ObdAmqgHHxvT8eyDaAsJw7F24+RIxJ8
	+CoY5pwMn+9W7Dkl+bud2TNtNr9DlLOiaBMRBfDDe1Btpvu955DRcV7prZsSax2IHMKlvtE8mdf
	v+p/C4V/DUIlda4iW2Y6WI80vemiUMBU=
X-Gm-Gg: ASbGncs8lfRmKoJSirBdOJOiHaMYnu9rTjBHIWetBokcXxDc9f9kareCHTw6YIv4mm5
	s+MKlyqt0QEEdr70jhKKS5Z9G4PpFTpFo/dAvdsjBHwID3/NhfwRmd9V8WPC5+xeleiniuGOtn1
	BniNs1UEaLRGTGbZHXSabLgFv5K61KjjF1EReztWhyKrc9vDOX+FK2GrOtSwXUPanBa3PD9RtsX
	7ex8AQ9w7+/fPgRPBrpGt7FnEXl7PoISXVDGvKoVK5s9L0=
X-Google-Smtp-Source: AGHT+IF09dfhTcQpiRWLSf2A1k/s4FQSc760VKHf84ZQbfzXVjJJrp2yCq5wGIDsYhhFT8HuSa1w5HwjyUCOwQmF8So=
X-Received: by 2002:a17:907:2da3:b0:b3e:e244:1d8 with SMTP id
 a640c23a62f3a-b50abaa44c8mr1245748966b.34.1760108709145; Fri, 10 Oct 2025
 08:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010094047.3111495-1-safinaskar@gmail.com> <20251010094047.3111495-3-safinaskar@gmail.com>
In-Reply-To: <20251010094047.3111495-3-safinaskar@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 10 Oct 2025 18:04:33 +0300
X-Gm-Features: AS18NWCvLx5PLZaUkorsbem-B-yR3hlKjw6yF-hbdTFMFmR4Zuzb6EIcT1htWkA
Message-ID: <CAHp75VezkZ7A1VOP8cBH8h0DKVumP66jjUbepMCP87wGOrh+MQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] initrd: remove deprecated code path (linuxrc)
To: Askar Safin <safinaskar@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Aleksa Sarai <cyphar@cyphar.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Rob Landley <rob@landley.net>, Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
	linux-block@vger.kernel.org, initramfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	Michal Simek <monstr@monstr.eu>, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, 
	Arnd Bergmann <arnd@arndb.de>, Dave Young <dyoung@redhat.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Jessica Clarke <jrtc27@jrtc27.com>, 
	Nicolas Schichan <nschichan@freebox.fr>, David Disseldorp <ddiss@suse.de>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 12:42=E2=80=AFPM Askar Safin <safinaskar@gmail.com>=
 wrote:
>
> Remove linuxrc initrd code path, which was deprecated in 2020.
>
> Initramfs and (non-initial) RAM disks (i. e. brd) still work.
>
> Both built-in and bootloader-supplied initramfs still work.
>
> Non-linuxrc initrd code path (i. e. using /dev/ram as final root
> filesystem) still works, but I put deprecation message into it

...

> -       noinitrd        [RAM] Tells the kernel not to load any configured
> +       noinitrd        [Deprecated,RAM] Tells the kernel not to load any=
 configured
>                         initial RAM disk.

How one is supposed to run this when just having a kernel is enough?
At least (ex)colleague of mine was a heavy user of this option for
testing kernel builds on the real HW.

--=20
With Best Regards,
Andy Shevchenko

