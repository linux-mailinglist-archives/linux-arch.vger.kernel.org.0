Return-Path: <linux-arch+bounces-14040-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5123DBD1964
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 08:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 428994EA9D0
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 06:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1478F2E0939;
	Mon, 13 Oct 2025 06:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E08XGpzm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715712DE703
	for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 06:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760335596; cv=none; b=gtrBnGo7LuO/+fYrP76gSH4VOvUvAJYFTJ948ubH39sdehovtmSyPHjUdxy+8cfNUs4gXE0CL1pJV/KQqWSem+H5s0oL2DhEemaU7XgalOPLAmGr4zr0BKVlDawlH8vGXJhY4tVkDk2ZfogU73++w2C1yiStEjDMhIrJenbmNLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760335596; c=relaxed/simple;
	bh=RSL7ODefchx0oaqAeJ6n26+cCreCbBCiVlRzlUCjIjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8fcsR3AyJiJZ7kmLmNft6nM0SOzqNz4lEZv13FL+XCwLYMJzR24SgPdLLQWZK0KlFQCKdiNWTLVwgLyF3SW4u4w1p6aJ8TwSsLvQulW+yMv10E/f1sdXcQafHmZCISR4bsYf0iStrPruAYksdsiYzx1eQALhGcmyk+2TTRX84o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E08XGpzm; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6348447d5easo3603463d50.0
        for <linux-arch@vger.kernel.org>; Sun, 12 Oct 2025 23:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760335592; x=1760940392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSL7ODefchx0oaqAeJ6n26+cCreCbBCiVlRzlUCjIjc=;
        b=E08XGpzmHVw0+qDzU5sCl5j2nWjFq/4gmZrI+HSMqUtrUQdW75O40jzorsqViIJ5Op
         YueCYgQvB7QPc4pUrMdPo6WnC+J7hR1UlRYyfnedh94HC57pUVWE3OllsoN75neJ05zd
         7IcSugJKTLhjY0wSwmbSfQ1BF+GIHKMdxFsZBTI139vylrWwsfot4THqwBnc5WWO1ADS
         owqxNkoEXxySlcupDmKJPMhXmeet3aWT00Ul8qKcfRlZ1+XFeBRnw6Pd6ASpf6fNaQKa
         kriZgtpxAU1TcDZRtFRbT0eY4rS6fV6XOKhazNP5uPTqs37bNueBArVUKMrsryxA49Ua
         /esQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760335592; x=1760940392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSL7ODefchx0oaqAeJ6n26+cCreCbBCiVlRzlUCjIjc=;
        b=DoKZ/2qS1OCDdcEdWjr6U27dE2VEnknxCQArV2PUCe3M2LOJ3GDN3dqLEZlfIMnXrf
         XAi3wtb8iPYeYcOIr2scEuoBE7P3Xd0RwS01mGkGV98pFchJ63dt85TdlmwP0HHKCueT
         22u8V0BPKQR70DFbnXLNHkFUBp/yXC4uJU+t6OVskU4RzQYrKfg1upbuGUuFQLfhVDIq
         hCLZjqQOfo7X7KQ1rhE96ZC5oHVBpkcGguQCbIOk+GWJ8uDCa2I+vdvAKPWPM4IphBmk
         3quX/IKkNrCsWfoNzkSa8M2iVmP82ogw/q8fGf9ZBk3hlN1cvXMrqts4naxBCXiG696H
         3a8g==
X-Forwarded-Encrypted: i=1; AJvYcCXQ5dUoOSX00jp2/ytvB1SpdYFmvvL0PHtlnCYBWeNeKlHNyiVcGNcoPAqlQJMXD/5M80oCyZ486Wz4@vger.kernel.org
X-Gm-Message-State: AOJu0YwhV0f5brhPqUgfSAA3Oysl+m5KEjYD/VYw3YObFwzW/x4YobBh
	z8+5Z3ZlSuSB+Y88Ewi2I8najVdbtda/xtxMO8878iP2o+1UyFaWBJ+yv1bHCH89L98iYH0pNW1
	xZseCWxoLNqA9MIDVQAifzfoBSqtx7YQ=
X-Gm-Gg: ASbGncsu1oiaogEGlLedmtKpLuAM8azZrapGeP2PAZh0iMXh2ApDP2/T59gtY1fdP5J
	8BL9F+AQ5WMHRmAsRDg3uHLa3IrWgYn5REt+Hmwd+FE0VurQhjsY2y+JMeAWPb70acVMcq4MTTd
	6fXT3ajk5mouMeWifrSRD0e9hA6ZYUnD61tDpr/U8oTQr9wl0iV2+3ykKu++DILA737Nhsu67cw
	opliEQK0LLItkrdpEgNBxYdbUuJYTyzTKFK
X-Google-Smtp-Source: AGHT+IGNAOIcFLi0/Sm93Y3jSHSuxr+30gS3y7Fr34MKhVqQQnt1MJ/lLmHR6+qpb+bVmq5VVWr9ycljJFZ2Qxe2L4U=
X-Received: by 2002:a05:690e:4142:b0:63c:f4eb:1b0d with SMTP id
 956f58d0204a3-63cf4eb1b25mr7582533d50.22.1760335592286; Sun, 12 Oct 2025
 23:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010094047.3111495-1-safinaskar@gmail.com>
 <20251010094047.3111495-2-safinaskar@gmail.com> <CAHp75VeJM_OoCWDX20FhphRi6e7rG9Z4X6zkjx9vFF12n7Ef7A@mail.gmail.com>
In-Reply-To: <CAHp75VeJM_OoCWDX20FhphRi6e7rG9Z4X6zkjx9vFF12n7Ef7A@mail.gmail.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Mon, 13 Oct 2025 09:05:56 +0300
X-Gm-Features: AS18NWAQKixJeSnu1jMDTs2ReasUmQ44oKevMSLcLyEUnjeI8Werl5Jwf9tycOM
Message-ID: <CAPnZJGDvHbDt_JvDNLN+LaU+5yFyB_qkdBtVhSEV60_yktAVzw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] init: remove deprecated "load_ramdisk" and
 "prompt_ramdisk" command line parameters
To: Andy Shevchenko <andy.shevchenko@gmail.com>
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

On Fri, Oct 10, 2025 at 6:02=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> 1) often the last period is missing in the commit messages;
I will fix in v3.

> 2) in this change it's unclear for how long (years) the feature was
> deprecated, i.e. the other patch states that 2020 for something else.
> I wonder if this one has the similar order of oldness.

These two commits were done in 2020, too. I will fix in v3.

--
Askar Safin

